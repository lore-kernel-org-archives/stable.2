Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7A2F130216D;
	Fri, 16 Oct 2026 15:28:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792164512; cv=none; b=qZBmHoJd0Oba4tPPixkbUImvZKIDmaMG6yvREQITfLueFnsFa/nRN92RCvtO+CvFKQdkXq0oY/kNZVwmO06fbku/wefHt2SheBRwwr4Tpwq0rZ1oI/nTyZwUAEQBysojAzJpL6gcuY1cDYsT/uVlLELKfxqPjeD53onUUIgwpV4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792164512; c=relaxed/simple;
	bh=45h0gyJgvcDIpb6kvog5cj+2/XcuNSq1NQrNDLHgX1k=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=T/L8bb9yHtytrk8P9y/uOuO8LwCDU8XyVjyf3rb/oBSHWvZXTzJ8zygo1hR/EAAu2G2oL36iqLqbB4AJgvWJ1XusT+I3BZHGJ9/RsOWz2RU8i2XBn93FeM0XbOGDhZeOrcHiyhP5fk+PtzqDXYzannggtCdvDe2hCicVp7YYc/M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=VvqdLJRV; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="VvqdLJRV"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1CBFA1F000C4;
	Fri, 16 Oct 2026 15:28:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792164511;
	bh=62b7anYUbwO3ZcefTmO2NBk6/EKmfxok260BD4lTHvU=;
	h=From:To:Cc:Subject:Date;
	b=VvqdLJRVokhXmeQrjoQqSVXeVRVjI0Ifbp87jLMSZDwSnHF6tdhkP3Cd1kKhA+wpc
	 PIZIhRxznyohybDhCfAlQd90aaRU2fzcY7CptWv63t2XPkg58swD/rRnnsMftPu5wN
	 2s14hii5CylS+G9c3v2X05oabBJ2wn+x0Be6aD1rTfVy4DFc2jYMDAxmSFVfxF34ox
	 JCAiwVt34xukNgg0rm80uhi7E9j8P2bj+WU2/XxbNY8cddCf9Ic/zM+cVzm0LrGw1N
	 UD+5zHDXLwBNryi4dC3UxZ7pSnwlLkRmZ/5nUw1Ss9Hj2AOmk0bAZmy06bq3OGkVdo
	 DbhqOJJqSKMkw==
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
	Sasha Levin <sashal@kernel.org>,
	stable@vger.kernel.org
Subject: [PATCH v3 0/7] agents: add skills for Fixes tags, stable tags, similar bugs, and commit messages
Date: Fri, 16 Oct 2026 11:28:20 -0400
Message-ID: <20261016152828.3765695-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
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
   Coccinelle semantic patch when Coccinelle is available, and verifies
   each candidate.

 - commit-message writes, rewrites, or reviews a commit message or cover
   letter, and writes the text of a pull request. It follows the P:
   profiles for the changed files and keeps the text short and in the
   imperative voice, as Linus asked [2].

Rules that people need as much as agents go into the existing documents
instead: submitting-patches.rst now says which commit a Fixes tag names.
stable-kernel-rules.rst drops the 100 line limit, the rule against
theoretical issues, and the requirement that a fix be obviously correct,
none of which the stable trees apply.

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

v2: https://lore.kernel.org/r/20261012213452.1863248-1-sashal@kernel.org
v1: https://lore.kernel.org/r/cover.1791499378.git.sashal@kernel.org
[1] https://lore.kernel.org/r/askTmFZC6RJKAE_p@mit.edu
[2] https://lore.kernel.org/r/CAHk-=wgXU50=KgZNZc1JDxsSxg9Z+DjG1_2yU-fNXpZtUe4XDw@mail.gmail.com
[3] https://lore.kernel.org/r/87y0bzq8oe.fsf@trenco.lwn.net
[4] https://lore.kernel.org/r/202610150832.58E80C02A@keescook

Sasha Levin (7):
  agents: add infrastructure for agent resources
  docs: submitting-patches: say which commit a Fixes tag names
  docs: stable-kernel-rules: drop rules the stable trees do not apply
  agents: add a skill to determine Fixes tags
  agents: add a skill to determine stable tags
  agents: add a skill to find other instances of a fixed bug
  agents: add a skill to write commit messages

 Documentation/process/coding-assistants.rst   | 35 +++++++--
 Documentation/process/stable-kernel-rules.rst |  6 +-
 Documentation/process/submitting-patches.rst  |  9 +++
 MAINTAINERS                                   |  6 ++
 agents/skills/commit-message/SKILL.md         | 42 +++++++++++
 agents/skills/find-fixes/SKILL.md             | 39 ++++++++++
 agents/skills/find-siblings/SKILL.md          | 31 ++++++++
 .../find-siblings/references/coccinelle.md    | 66 +++++++++++++++++
 agents/skills/stable-tag/SKILL.md             | 72 +++++++++++++++++++
 9 files changed, 297 insertions(+), 9 deletions(-)
 create mode 100644 agents/skills/commit-message/SKILL.md
 create mode 100644 agents/skills/find-fixes/SKILL.md
 create mode 100644 agents/skills/find-siblings/SKILL.md
 create mode 100644 agents/skills/find-siblings/references/coccinelle.md
 create mode 100644 agents/skills/stable-tag/SKILL.md


base-commit: 3857c2fe5449541e24afc5efdb0f81a8a8f9a3a0
-- 
2.53.0

