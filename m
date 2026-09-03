Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1FFF529B781
	for <stable@vger.kernel.org>; Thu,  3 Sep 2026 22:31:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788474693; cv=none; b=QZ7PJoOxE/KikRBvrJ77OSEVZ24boI1vA1EntpmXzcaLjdXsjXttlGicZBuVFVxO6PIapmDB4jow74Irit25mayy1ya4hDujDfi0+hhTOrMZzxhvv9I36KQNZEke+uQY2QrCRd/EZD8U/LfrP71l2jvlTyiz3ll0aKxbgNUi5jk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788474693; c=relaxed/simple;
	bh=M9sZvZiwGlvGC460n8Jj2mL19cwUTLmL3RtZj7Yvjj0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=niNum7+/IIl+S3xRSG479a+aoE2lgyQyrc6+iBTu1VeSqm2NwRysT5bQuAn+nXoLnXZPdTFEm0h2oEL3wJ4K0KGg9qR8VpWaBEbt+8qHKPoyyk+sdL0cVczW8T6TaDyr/omQHExpLm5ru61cww/BngVr9F6rwYOXUdD3W6JFejA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=BT7b7Za3; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="BT7b7Za3"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1A0E01F000E9;
	Thu,  3 Sep 2026 22:31:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788474691;
	bh=wZRafv82sQFne/iyvg+3lsCtUL77Ie7WzaM1bF6aLww=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=BT7b7Za3LJZe5Xzd83/xZOJmBFesiHiE2Ogq6lQ/ELBHPJa1Bhp51cUgUr5nhW+U4
	 7OY+RxOctKi5wWamkFuQ+KKbSP//JeoiOPtsaOxMTp+lgMCSkBSB6eLGb2INgO0fIX
	 4OHANOi5qrxIm/UGPzp/ZaMZLETZ62AiN+pOy8WTHo5eGw1FBdPTtf/6FrEspJDfK6
	 gg4qSXU2ObqamzizEtRktjrvQ5wtwv+WDYhlf9fjeWP4KMT8F/uR+pGMGH2WZduB78
	 q8xynFg85Lupi2RsGB0Aoc6qrB6kwQuKKmS4Ghk9ekZDaYhQkrbsd9NIqeHujQ1hAY
	 ZSl7aVFl6jxSQ==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Jim Cromie <jim.cromie@gmail.com>,
	Catalin Marinas <catalin.marinas@arm.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.6.y 1/4] kmemleak: drop (age <increasing>) from leak record
Date: Thu,  3 Sep 2026 18:31:26 -0400
Message-ID: <20260903223129.1741728-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026090345-kabob-hardcopy-cdf7@gregkh>
References: <2026090345-kabob-hardcopy-cdf7@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Jim Cromie <jim.cromie@gmail.com>

[ Upstream commit 88f9ee2b3040991ff40628fa9e3516ebe36dd6fa ]

Patch series "tweak kmemleak report format".

These 2 patches make minor changes to the report:

1st strips "age <increasing>" from output.  This makes the output
idempotent; unchanging until a new leak is reported.

2nd adds the backtrace.checksum to the "backtrace:" line.  This lets a
user see repeats without actually reading the whole backtrace.  So now
the backtrace line looks like this:

  backtrace (crc 603070071):

I surveyed for un-wanted effects upon users:

Syzkaller parses kmemleak in executor/common_linux.h:
static void check_leaks(char** frames, int nframes)

It just counts occurrences of "unreferenced object", specifically it
does not look for "age", nor would it choke on "crc" being added.

github has 3 repos with "kmemleak" mentioned, all are moribund.
gitlab has 0 hits on "kmemleak".

This patch (of 2):

Displaying age is pretty, but counter-productive; it changes with
current-time, so it surrenders idempotency of the output, which breaks
simple hash-based cataloging of the records by the user.

The trouble: sequential reads, wo new leaks, get new results:

  :#> sum /sys/kernel/debug/kmemleak
  53439    74 /sys/kernel/debug/kmemleak
  :#> sum /sys/kernel/debug/kmemleak
  59066    74 /sys/kernel/debug/kmemleak

and age is why (nothing else changes):

  :#> grep -v age /sys/kernel/debug/kmemleak | sum
  58894    67
  :#> grep -v age /sys/kernel/debug/kmemleak | sum
  58894    67

Since jiffies is already printed in the "comm" line, age adds nothing.

Notably, syzkaller reads kmemleak only for "unreferenced object", and
won't care about this reform of age-ism.  A few moribund github repos
mention it, but don't compile.

Link: https://lkml.kernel.org/r/20231116224318.124209-1-jim.cromie@gmail.com
Link: https://lkml.kernel.org/r/20231116224318.124209-2-jim.cromie@gmail.com
Signed-off-by: Jim Cromie <jim.cromie@gmail.com>
Reviewed-by: Catalin Marinas <catalin.marinas@arm.com>
Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
Stable-dep-of: 3541a2b06ecd ("mm/kmemleak: report RCU-tasks quiescent states during the scan")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 mm/kmemleak.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/mm/kmemleak.c b/mm/kmemleak.c
index e2e41de55c02b..b6e57e344bd6e 100644
--- a/mm/kmemleak.c
+++ b/mm/kmemleak.c
@@ -355,14 +355,12 @@ static void print_unreferenced(struct seq_file *seq,
 	int i;
 	unsigned long *entries;
 	unsigned int nr_entries;
-	unsigned int msecs_age = jiffies_to_msecs(jiffies - object->jiffies);
 
 	nr_entries = stack_depot_fetch(object->trace_handle, &entries);
 	warn_or_seq_printf(seq, "unreferenced object 0x%08lx (size %zu):\n",
 			  object->pointer, object->size);
-	warn_or_seq_printf(seq, "  comm \"%s\", pid %d, jiffies %lu (age %d.%03ds)\n",
-			   object->comm, object->pid, object->jiffies,
-			   msecs_age / 1000, msecs_age % 1000);
+	warn_or_seq_printf(seq, "  comm \"%s\", pid %d, jiffies %lu\n",
+			   object->comm, object->pid, object->jiffies);
 	hex_dump_object(seq, object);
 	warn_or_seq_printf(seq, "  backtrace:\n");
 
-- 
2.53.0

