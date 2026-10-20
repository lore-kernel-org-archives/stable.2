Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792513014;
	b=F5BVe/pr14v7tro68U4ChqyIIEdQ4S4/y4Eq7y9PfBFgg1WHmWC6zUw4BLoLwnEOQxCS
	 dpvnTkAvkAqCqvKB9qLidjXB61dyKqaCSykmUnZXP8qle/JHcPdeca2QeoqJXeuz/kqGQ
	 c/GRkjpGldXRBiUXtj18tr8Trfkp4ePluJAS5S+pKxd3X3zR90M9FBQtbq8SaH7wGvsHU
	 M/CSBEJvLlQkMLV4LyZD3hvTObRZwPlBUKNOBcFurX92AHFwS/jiwi6D/dGkAsyXGwrGs
	 O8O0gFMn+chCsILFAWMTuKeQjMdhr0eB7DX/Vumhh8XbF5XgE5t09w7hK8Yl4eUyusg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792513014;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 MIME-Version:Content-Transfer-Encoding;
	bh=/2mtLY4vFEovE8W1FOC1bSzXPmT7/yfQXWZD/ct0dlg=;
	b=fNVufZkdFUrTe+pSCc2mzjwKafQ28z6CGi8GwAzxTcX5TSo/Gcc6bdL/ZFawUfizv+45
	 zO/cVuSj6sWI2dxkYzf4Y6xF9de02plWWBqLUio9Zbupm5BSjB74fCAWOE424ypyLv2QA
	 VTHjfmsBlUmqNjM3bco93lQV4tcazMCg9WiYWdkcFb36Ab2tP7WcQF6Oy8wH7ZWvmD1eO
	 2r1t1tEX9XycD/T38hk0zLSl+tkKMAsG5VCM9AQd9oZbdlG5jnz87bK/cXT9W1Q1dmtWV
	 eaJDFbO1iZ0OBZq7xHKVNbgl/lcNdFNW8xxDzoTO5e5KBwZoioe+ed/Yj2OSDkfLIgg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=numaRKUw;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 29B84606A31A;
	Tue, 20 Oct 2026 16:16:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=numaRKUw
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3D68E1F000C4;
	Tue, 20 Oct 2026 16:16:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792513013;
	bh=/2mtLY4vFEovE8W1FOC1bSzXPmT7/yfQXWZD/ct0dlg=;
	h=From:To:Cc:Subject:Date;
	b=numaRKUwY2PB+YhjMuQ5QphhJtTKDBtfRsN1paHGiXjTrOIXdl2oQLcpqT1EoapMk
	 tZcoqK7tF+j3wK2H4jl20jCEDb978VcY0uriuxv2//S3M0RgYi9zVHwioaqvp7T7uN
	 CHdGpY27oIBRXUcarE0gQ3w5dzv0KbJ6iWv7gJjWPTICxY2XyxUQobaOnWHP2dwBo+
	 vuAGXUjAv+6Gc9+sApyn/wf2qjRsV7AYmiQhz9c55KPqrsLmX9K1uSLH+umFaPKn3t
	 AhP1ZkrQ3/ZxPA+c0xNL6zwo7qqAB7RXcHHL4LmxIkMax79bd7Xw4px/kjcdFntXCf
	 giWSxz+qBm8tw==
From: Sasha Levin <sashal@kernel.org>
To: workflows@vger.kernel.org,
	ksummit@lists.linux.dev
Cc: linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Jonathan Corbet <corbet@lwn.net>,
	Shuah Khan <skhan@linuxfoundation.org>,
	Randy Dunlap <rdunlap@infradead.org>,
	Mark Brown <broonie@kernel.org>,
	Theodore Ts'o <tytso@mit.edu>,
	Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Leon Romanovsky <leon@kernel.org>,
	Konstantin Ryabitsev <konstantin@linuxfoundation.org>,
	Thorsten Leemhuis <linux@leemhuis.info>,
	"Michael S. Tsirkin" <mst@redhat.com>,
	Kees Cook <kees@kernel.org>,
	Geert Uytterhoeven <geert@linux-m68k.org>,
	Dan Carpenter <error27@gmail.com>,
	Miguel Ojeda <ojeda@kernel.org>,
	Alexei Starovoitov <alexei.starovoitov@gmail.com>,
	Julia Lawall <julia.lawall@inria.fr>,
	SJ Park <sj@kernel.org>,
	Bradley Morgan <brads@mainlining.org>,
	Sasha Levin <sashal@kernel.org>,
	stable@vger.kernel.org
Subject: [PATCH v4 0/5] agents: add skills for Fixes tags, stable tags, similar bugs, and commit messages
Date: Tue, 20 Oct 2026 12:16:37 -0400
Message-ID: <20261020161642.3713052-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

At the Maintainers Summit, Ted asked whether the stable trees have a way
to deal with incorrect Fixes tags. Hannes estimated that 15-20% of them
are wrong, often because the author ran git blame and took the first
commit that touched the line [1]. We use LLM workflows to find the
commit that actually introduced a bug, and others asked us to share
them.

This series adds them as agent skills under agents/skills/, together
with a skill for writing commit messages. Each skill is a short SKILL.md
that points the agent at the process documents for its task and adds
only the checks agents tend to get wrong:

 - find-fixes determines the commit for a Fixes tag, following the
   history past code moves and refactors.

 - stable-tag decides whether a fix should go to stable and generates the
   tag. It finds the first release with the bug and checks that the fix
   applies there.

 - find-siblings looks for the same bug elsewhere in the tree, with a
   Coccinelle semantic patch when Coccinelle is available, verifies each
   candidate, and reports whether the interface itself invites the bug.

 - commit-message writes, rewrites, or reviews a commit message or cover
   letter, and writes the text of a pull request. It follows the P:
   profiles for the changed files and keeps the text short and in the
   imperative voice, as Linus asked [2].

Rules that people need as much as agents go into the existing documents
instead, in two patches sent separately: one says in
submitting-patches.rst which commit a Fixes tag names [5], and the other
drops the 100 line limit, the rule against theoretical issues, and the
requirement that a fix be obviously correct from stable-kernel-rules.rst,
none of which the stable trees apply [6].

Most of the skills only point at Documentation/. The exception is
stable-tag, which also lists the kinds of changes the stable trees take
and leave out. The lists describe how the stable rules are applied, not
new rules, and they save smaller models from working that out on every
fix. To keep agents/ consistent with Documentation/, I'll check one
against the other every release and trim anything in agents/ that
duplicates or contradicts it, as Kees suggested [4].

The skills only inspect and report. The calling workflow writes the
commit, creates the tag, and sends the mail. coding-assistants.rst tells
agents when to use each skill. Tools do not load agents/skills/ on their
own; to have a tool load them automatically, link the skill directories
into its skills directory.

Changes since v3:
 - find-siblings: when the same defect turns up in several places, also
   report whether the interface invites it, and leave the choice between
   fixing the interface and fixing each site to the developer (Alexei).
 - find-siblings returns the semantic patch it used, and commit-message
   includes it in the commit message, or names it if it is under
   scripts/coccinelle/ (Julia).
 - find-fixes also returns a Fixes tag for a later commit that exposed
   the bug, to match Thorsten's rewording of the Fixes paragraph
   (Thorsten).
 - Send the submitting-patches.rst and stable-kernel-rules.rst patches
   separately [5][6].
 - Add the Reviewed-by tags given on v3.

Changes since v2:
 - Keep the skills in agents/. They are now short pointers into
   Documentation/ rather than documentation of their own; see the
   discussion on v1 [3].
 - Cut each skill to a single short SKILL.md that points at the existing
   documentation, and drop the git how-to (Kees). The skill text went
   from about 960 lines to 250.
 - find-siblings: describe how to search with Coccinelle in a separate
   file that agents read only when Coccinelle is available.
 - Say in submitting-patches.rst which commit to name when a later commit
   exposed the bug or more than one commit introduced it, and which trees
   need the fix (Michael, Thorsten, Dan).
 - Drop the 100 line limit and the exclusion of theoretical issues from
   stable-kernel-rules.rst, and require a fix to be correct rather than
   obviously correct.
 - State once, in coding-assistants.rst, that skills only inspect and
   report.

v3: https://lore.kernel.org/r/20261016152828.3765695-1-sashal@kernel.org
v2: https://lore.kernel.org/r/20261012213452.1863248-1-sashal@kernel.org
v1: https://lore.kernel.org/r/cover.1791499378.git.sashal@kernel.org
[1] https://lore.kernel.org/r/askTmFZC6RJKAE_p@mit.edu
[2] https://lore.kernel.org/r/CAHk-=wgXU50=KgZNZc1JDxsSxg9Z+DjG1_2yU-fNXpZtUe4XDw@mail.gmail.com
[3] https://lore.kernel.org/r/87y0bzq8oe.fsf@trenco.lwn.net
[4] https://lore.kernel.org/r/202610150832.58E80C02A@keescook
[5] https://lore.kernel.org/r/20261020142534.3533478-1-sashal@kernel.org
[6] https://lore.kernel.org/r/20261020142537.3533510-1-sashal@kernel.org

Sasha Levin (5):
  agents: add infrastructure for agent resources
  agents: add a skill to determine Fixes tags
  agents: add a skill to determine stable tags
  agents: add a skill to find other instances of a fixed bug
  agents: add a skill to write commit messages

 Documentation/process/coding-assistants.rst   | 35 +++++++--
 MAINTAINERS                                   |  6 ++
 agents/skills/commit-message/SKILL.md         | 45 ++++++++++++
 agents/skills/find-fixes/SKILL.md             | 39 ++++++++++
 agents/skills/find-siblings/SKILL.md          | 36 ++++++++++
 .../find-siblings/references/coccinelle.md    | 66 +++++++++++++++++
 agents/skills/stable-tag/SKILL.md             | 72 +++++++++++++++++++
 7 files changed, 295 insertions(+), 4 deletions(-)
 create mode 100644 agents/skills/commit-message/SKILL.md
 create mode 100644 agents/skills/find-fixes/SKILL.md
 create mode 100644 agents/skills/find-siblings/SKILL.md
 create mode 100644 agents/skills/find-siblings/references/coccinelle.md
 create mode 100644 agents/skills/stable-tag/SKILL.md


base-commit: 3857c2fe5449541e24afc5efdb0f81a8a8f9a3a0
-- 
2.53.0

