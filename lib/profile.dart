import 'package:flutter/material.dart';
import '../DummyMahasiswa.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  final List<Member> _members = GenerateMember.getDataMembers();
  String _selectType = 'All';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Profile'),
      ),
      body: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              ElevatedButton(
                onPressed: () {
                  setState(() {
                    _selectType = 'All';
                  });
                },
                child: const Text('All'),
              ),
              ElevatedButton(
                onPressed: () {
                  setState(() {
                    _selectType = 'Member';
                  });
                },
                child: const Text('Member'),
              ),
              ElevatedButton(
                onPressed: () {
                  setState(() {
                    _selectType = 'Trainee';
                  });
                },
                child: const Text('Trainee'),
              ),
            ],
          ),
          Expanded(
            child: ListView.builder(
              itemCount: _selectType == 'All'
                  ? _members.length
                  : _members
                      .where((member) => member.type == _selectType)
                      .length,
              itemBuilder: (context, index) {
                Member member = _selectType == 'All'
                    ? _members[index]
                    : _members
                        .where((member) => member.type == _selectType)
                        .elementAt(index);

                return Card(
                  child: ListTile(
                    leading: CircleAvatar(
                      backgroundImage: NetworkImage(member.photoUrl),
                    ),
                    title: Text(member.name),
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (_) => DetailProfilePage(
                            member: member,
                          ),
                        ),
                      );
                    },
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}

class DetailProfilePage extends StatefulWidget {
  final Member member;

  const DetailProfilePage({
    super.key,
    required this.member,
  });

  @override
  State<DetailProfilePage> createState() => _DetailProfilePageState();
}

class _DetailProfilePageState extends State<DetailProfilePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Detail Member'),
      ),
      body: ListView(
        children: [
          Center(
            child: ClipRRect(
              borderRadius: BorderRadius.circular(20),
              child: SizedBox(
                height: 200,
                child: Image.network(
                  widget.member.photoUrl,
                  fit: BoxFit.fitHeight,
                ),
              ),
            ),
          ),
          Center(
            child: ListTile(
              title: Text(
                widget.member.name,
                style: const TextStyle(fontSize: 32),
              ),
            ),
          ),
          ListTile(
            leading: const Icon(Icons.cake),
            title: Text(widget.member.dateOfBirth),
          ),
          ListTile(
            leading: const Icon(Icons.favorite),
            title: Text(widget.member.bloodType),
          ),
          ListTile(
            leading: const Icon(Icons.star),
            title: Text(widget.member.horoscope),
          ),
          ListTile(
            leading: const Icon(Icons.height),
            title: Text('${widget.member.bodyHeight.toStringAsFixed(2)} cm'),
          ),
          ListTile(
            leading: const Icon(Icons.tag_outlined),
            title: Text(widget.member.nickname),
          ),
          ListTile(
            leading: const Icon(Icons.person_pin),
            title: Text(widget.member.type),
          ),
        ],
      ),
    );
  }
}
