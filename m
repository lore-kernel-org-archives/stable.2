Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=18.9.28.11
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794438066;
	b=caXxNTDX3PAC3d2PYeLqeNa7glikqCk2tq5YqwgccRqjOnMcKanLYPmpo4sSNehbQJ0i
	 70mhLjaP2N5BamOFk9/1yBxhI0K66p9ITfdrrNZtKj+sjXq2al7Pd38dNnJBYI9omHv9k
	 +H2gDt5UCNRTRu6vACKi14egEUFHLXzOTgN+spBYMw9+H/M8mVp4CJ6HbvayuTvZwMlTf
	 YhSV3/x4OkE0ZEIs9q1FPIJa9iz6ca3XhcPIDdE0Ni1ejchv2cd/SDfBYxe5THVg/Rve4
	 aTEAGi8fI6YRAuC7LhUen5vldxT14i5lixAIDxudPl/1/crYnc8Rcs+l9dqYHAQPGVA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794438066;
	h=DMARC-Filter:Received:DKIM-Signature:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=kBr4lxIN7nKuJvI5i+sXZXAxd95v5Q1dSvAGHHbt4fk=;
	b=yRi2UNoYQQo/5uA3e9xOp31p6J11EuWtNvXnM31qpTFUVn7wyeoKbwdSh8oRk5sDntQN
	 UlCvdgr1jVhWBeI+c4Ig1RkvBMyJmpWyBEiSVN9gDTqScAtuqnf1O53efyEyTmH+6sBCc
	 FylQHwXrKir/lhEU4N91yM60S2L68Lv+LswMAlWrN1ObJY7/dw3iTqt390+Y24zGu9EuJ
	 s/0krPUMY2wfLU4IA0y7ICPUI7myiS2k6ESTe3UfAN6XVqrMeiZc1bQ8KS5DtFM6KzPLw
	 B5Bm+efCRcjAYO1ZlQIly22oupbP3dwKC2gHuWKDg9WV3nxqHrfYSEg4I7kJmzegjew==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=mit.edu;
	spf=pass smtp.mailfrom=mit.edu;
	dkim=pass header.d=mit.edu header.i=@mit.edu header.a=rsa-sha256 header.s=outgoing header.b=PeH6OJiY;
	arc=none smtp.remote-ip=18.9.28.11
Received: from outgoing.mit.edu (outgoing-auth-1.mit.edu [18.9.28.11])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3A36760A263C
	for <stable@vger.kernel.org>; Wed, 11 Nov 2026 23:01:06 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 3A36760A263C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=mit.edu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mit.edu
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mit.edu header.i=@mit.edu header.a=rsa-sha256 header.s=outgoing header.b=PeH6OJiY
Received: from trampoline.thunk.org (pool-173-48-111-191.bstnma.fios.verizon.net [173.48.111.191])
	(authenticated bits=0)
        (User authenticated as tytso@ATHENA.MIT.EDU)
	by outgoing.mit.edu (8.14.7/8.12.4) with ESMTP id 6ABMxi5t026990
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 11 Nov 2026 17:59:45 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mit.edu; s=outgoing;
	t=1794437992; bh=kBr4lxIN7nKuJvI5i+sXZXAxd95v5Q1dSvAGHHbt4fk=;
	h=From:Subject:Date:Message-ID:MIME-Version;
	b=PeH6OJiYNdZvMX8GDqCq6kZ/6LgxSu66UDtJ4vVAPF9DqbnlOMoUTKliNUeH0/Vrn
	 uugqb99R6yoZ3v/utrXA7zmd947N9PhP6yr39nPMpNEciSoC502NUl+wVruQYMZsVu
	 dBsqWmSc7TqKSwoVCH0lE9JIJjhndNXBKxIfi/vv8SLdPjt+fCECMrVUVPri/pTSad
	 1HKvdKruvP6B+A2GV1dV1tSSlc4CzIuIYgG6K9EmTpA2r89iXxKdDmjUA+XOGU4CLJ
	 ixzGB04AyAE6cWB53o8Vzl9zIlFdxNVyXoGKE9F6QPgQ9DUAqtoGZPu0cFqGad0i7E
	 WeTcyAyHrHfUQ==
Received: by trampoline.thunk.org (Postfix, from userid 15806)
	id CCD682E0146; Wed, 11 Nov 2026 17:59:44 -0500 (EST)
From: "Theodore Ts'o" <tytso@mit.edu>
To: workflows@vger.kernel.org, ksummit@lists.linux.dev
Cc: Sasha Levin <sashal@kernel.org>, "Theodore Ts'o" <tytso@mit.edu>,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        Jonathan Corbet <corbet@lwn.net>,
        Shuah Khan <skhan@linuxfoundation.org>,
        Randy Dunlap <rdunlap@infradead.org>, Mark Brown <broonie@kernel.org>,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Leon Romanovsky <leon@kernel.org>,
        Konstantin Ryabitsev <konstantin@linuxfoundation.org>,
        Thorsten Leemhuis <linux@leemhuis.info>,
        "Michael S. Tsirkin" <mst@redhat.com>, Kees Cook <kees@kernel.org>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        Dan Carpenter <error27@gmail.com>, Miguel Ojeda <ojeda@kernel.org>,
        Alexei Starovoitov <alexei.starovoitov@gmail.com>,
        Julia Lawall <julia.lawall@inria.fr>, SJ Park <sj@kernel.org>,
        Bradley Morgan <brads@mainlining.org>, stable@vger.kernel.org
Subject: [PATCH v5 4/6] agents: add a skill to find other instances of a fixed bug
Date: Wed, 11 Nov 2026 17:59:36 -0500
Message-ID: <20261111225940.1573565-5-tytso@mit.edu>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261111225940.1573565-1-tytso@mit.edu>
References: <20261111225940.1573565-1-tytso@mit.edu>
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

From: Sasha Levin <sashal@kernel.org>

A bug fixed in one place often exists elsewhere, in copied code, sibling
drivers, or other users of the same interface, and reviewers routinely
ask whether that was checked. Left alone, agents tend to audit the whole
tree by reading it. Add a skill that states the defect as a rule,
searches for it through shared interfaces, copied code, the introducing
series and earlier fixes, and verifies each candidate before reporting
it.

When Coccinelle is available, the skill searches with a semantic patch:
it looks for an existing one under scripts/coccinelle/, checks that the
rule marks the fixed site in the code before the fix, runs it over the
whole tree with coccicheck, and checks which code spatch could not
parse. These steps live in references/coccinelle.md, which the agent
reads only when it uses Coccinelle. The semantic patch is returned with
the results, so that the commit message of a fix can include it.

Tested on the parent of commit 989fe6771266 ("drm/nouveau/gsp: fix
mismatched alloc/free for kvmalloc()"): both the existing
api/kfree_mismatch.cocci and the example rule mark the two kfree() calls
that commit fixed, and a whole-tree run found the same bug in four other
drivers that were later fixed separately.

The sites found are reported, not fixed. When the same defect turns up
in several places, the skill also reports whether the interface invites
it. The missing of_node_put() calls that iterators/for_each_child.cocci
finds were fixed one driver at a time for years, until
commit 34af4554fb0c ("of: Introduce for_each_*_child_of_node_scoped() to
automate of_node_put() handling") made the put automatic. Whether to fix
the interface or each site is left to the developer.

Point the bug-fix procedure in coding-assistants.rst at the skill.

Link: https://lore.kernel.org/r/DM6DXZJSMPO3.J5PONDJ3HWNP@gmail.com
Signed-off-by: Sasha Levin <sashal@kernel.org>
Link: https://patch.msgid.link/20261020161642.3713052-5-sashal@kernel.org
Signed-off-by: Theodore Ts'o <tytso@mit.edu>
---
 Documentation/process/coding-assistants.rst   |  5 +-
 agents/skills/find-siblings/SKILL.md          | 36 ++++++++++
 .../find-siblings/references/coccinelle.md    | 66 +++++++++++++++++++
 3 files changed, 106 insertions(+), 1 deletion(-)
 create mode 100644 agents/skills/find-siblings/SKILL.md
 create mode 100644 agents/skills/find-siblings/references/coccinelle.md

diff --git a/Documentation/process/coding-assistants.rst b/Documentation/process/coding-assistants.rst
index 81ee530a8a7f..c2f9b71650c1 100644
--- a/Documentation/process/coding-assistants.rst
+++ b/Documentation/process/coding-assistants.rst
@@ -39,6 +39,8 @@ The following skills are available:
   checks an existing one.
 * agents/skills/stable-tag/SKILL.md decides whether a fix goes to stable and
   returns its stable tag, or checks an existing one.
+* agents/skills/find-siblings/SKILL.md looks for the same bug elsewhere in the
+  tree.
 
 Licensing and Legal Requirements
 ================================
@@ -83,7 +85,8 @@ these steps:
 5. Build and verify that the fix works either using the reproducer or by
    re-running a complete analysis; drop any fix that doesn't work and try
    another one. The fix must not add build warnings and must pass the
-   checkpatch.pl checks (see submitting-patches.rst).
+   checkpatch.pl checks (see submitting-patches.rst). Then look for the same
+   bug elsewhere with the find-siblings skill.
 6. Commit the working fix with a detailed message describing the problem, the
    solution, a Fixes tag determined with the find-fixes skill, and a stable
    tag if the stable-tag skill calls for one.  Do not add a Signed-off-by tag.
diff --git a/agents/skills/find-siblings/SKILL.md b/agents/skills/find-siblings/SKILL.md
new file mode 100644
index 000000000000..8d007472675d
--- /dev/null
+++ b/agents/skills/find-siblings/SKILL.md
@@ -0,0 +1,36 @@
+---
+# SPDX-License-Identifier: GPL-2.0-only
+name: find-siblings
+description: >-
+  Find other places in the Linux kernel tree that have the same defect as a
+  bug being fixed, and verify each candidate. Use after fixing or reviewing
+  a bug fix, or when asked whether the same bug exists elsewhere.
+---
+
+# Find other instances of a bug
+
+Follow the rules for skills in Documentation/process/coding-assistants.rst.
+
+- State the defect as a rule that does not depend on local names, such as
+  "memory from kvmalloc() is released with kfree()".
+- Search the tree as it was before the fix, not the working tree. Look at
+  other users of the same interface, field or lock, code copied from the same
+  origin, the rest of the series that introduced the bug, and earlier fixes
+  for the same defect. Limit history searches to the relevant directories.
+- If Coccinelle is available (`spatch --version` works), search for the
+  defect with a semantic patch as
+  [references/coccinelle.md](references/coccinelle.md) describes. Otherwise
+  use text searches and report that limit.
+- A match is a lead. Read each candidate with its callers, locking and object
+  lifetimes, and classify it as confirmed, safe or undetermined, with the
+  reason. Check whether a confirmed site is already fixed in the current tree
+  or in a pending tree such as linux-next.
+- If several sites have the same defect, check whether the interface they use
+  invites it, for example by making every caller drop a reference by hand when
+  it leaves a loop early. If it does, report that the defect is better fixed
+  in the interface, along with the sites. The developer decides which way to
+  fix it.
+
+Return the searches you ran and their scope, with any semantic patch you
+used, and the classified sites with their maintainers. Do not fix the sites or
+the interface.
diff --git a/agents/skills/find-siblings/references/coccinelle.md b/agents/skills/find-siblings/references/coccinelle.md
new file mode 100644
index 000000000000..6b09ce9d04c8
--- /dev/null
+++ b/agents/skills/find-siblings/references/coccinelle.md
@@ -0,0 +1,66 @@
+<!-- SPDX-License-Identifier: GPL-2.0-only -->
+
+# Searching for a bug pattern with Coccinelle
+
+Documentation/dev-tools/coccinelle.rst describes `make coccicheck` and its
+options. The semantic patch language is documented at
+https://coccinelle.gitlabpages.inria.fr/website/docs/.
+
+1. Look under `scripts/coccinelle/` for a semantic patch that already covers
+   the defect. Read its rules rather than its name: `kfree()` of memory from
+   `kvmalloc()` is covered by `api/kfree_mismatch.cocci`, while
+   `api/kvmalloc.cocci` only flags an open-coded `is_vmalloc_addr()` test.
+
+2. Otherwise, write a semantic patch outside the repository. Match only what
+   the defect needs, not names or statements specific to the fixed site. Mark
+   the lines of interest with `*`, and declare `virtual context`: coccicheck
+   passes `-D context`, and spatch rejects a mode the file does not declare.
+   A minimal rule for memory from `kvmalloc()` released with `kfree()`, a
+   case that `api/kfree_mismatch.cocci` covers more completely:
+
+       virtual context
+
+       @@
+       expression E;
+       @@
+       E = \(kvmalloc\|kvzalloc\|kvcalloc\|kvmalloc_array\)(...);
+       ...
+       * kfree(E);
+
+3. Check that it finds the site you fixed. Coccinelle reads the files on
+   disk, where the fix is usually already applied, so copy the file as it was
+   before the fix to a directory outside the repository and run
+   `spatch -D <mode> --very-quiet --sp-file <rule> <copy>`, with a mode the
+   rule declares on a `virtual` line, such as `context` or `report`. Without
+   `-D`, rules that depend on a mode do not run and nothing is reported. The
+   rule must mark the fixed site in that copy, and nothing in the fixed
+   version. If it misses the site, correct the rule before searching further.
+
+4. Search the whole tree:
+
+       make coccicheck MODE=context COCCI=<rule> DEBUG_FILE=<new log file>
+
+   - Use a `MODE` the rule declares on a `virtual` line, as in step 3.
+   - In context mode the output is a diff, and each line starting with `-`
+     is a line the rule marked; report mode prints one warning per site.
+     coccicheck searches the files on disk, so a site you already fixed
+     there is not marked; step 3 covers it.
+   - The kernel's `.cocciconfig` makes spatch skip files that do not contain
+     the rule's identifiers, so a whole-tree search is usually quick when the
+     rule names distinctive functions. Add `M=<dir>/` only if it is not.
+   - Give `COCCI` and `DEBUG_FILE` as absolute paths. With `M=`, coccicheck
+     runs from that directory.
+   - Read the log. Without `DEBUG_FILE`, spatch errors are discarded and a
+     broken rule shows only as "coccicheck failed". coccicheck refuses to
+     reuse an existing log file.
+   - Header files are searched only with `SPFLAGS=--include-headers`, or with
+     a `// Options: --include-headers` line at the top of the rule.
+
+5. Check what was not searched. Coccinelle skips code it cannot parse without
+   saying so. Run `spatch --parse-c` on the searched files or directories: a
+   nonzero `nb bad` count means part of them was skipped. Search those files
+   another way and report the gap.
+
+If the rule marks many sites that turn out to be safe, tighten it, for example
+with `when !=` constraints, and run it again rather than discarding candidates
+by hand.
-- 
2.53.0

