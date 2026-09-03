Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EE4B14FDE47
	for <stable@vger.kernel.org>; Thu,  3 Sep 2026 17:48:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788457718; cv=none; b=awzxnVa+F+sEwHYGinKZGQO4YNRwkUoCZ660RsojUT3s3JaGxXUKo3EnHQMyaHnjL7TDaUTMsZYbKNYSmrIJ5QLtGWWA6m+2GXWvsPw2lHi6raDd46fSgQ6EX/m+rfL0tjzVxnVmcmOerlhKyYzC51/7J00VQIw+12GBf3zOpNk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788457718; c=relaxed/simple;
	bh=9ZLgUjIPIm2uXChxHO2wqVlT/kv/0uDjJXBQx8MbJfQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=t9iz/+UK4cEVzwM9a929z0VD8/3YDHRdRvPnW12ye0E4LdFfMXcff+DL/A/5kVQM+ES+hKoRHSern+xIJawSjmpnH66wmSE2Rp5hEKfuR/3X4rHd7eFbh93WLOIQ4VoYLWa0cFch1AkdOAcC3mFgvVdtE8k9VMjYKo3k0ik2kXc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=bSErrWTv; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="bSErrWTv"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1369A1F00A3E;
	Thu,  3 Sep 2026 17:48:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788457716;
	bh=Ngxi2YVMoIcWeiLhV82AJ1V7eJPOWXFRJjHLtADfCq8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=bSErrWTvSMR+8MqvKXNpM6VCrwr59/c7RADVB9AvXBoclewR2tt39pwGuuXIbWR6f
	 ibl+0fltJAaL6fAlXI52ErenTyiqTtFqlRZj4F5E9MksKjaUBEB1r/4BR00yyobimJ
	 d0himPAQWTnSUjJ4VlmRVRSGAcAj/LbdWEPzzD4bdbNV00k4DqUfuixVyaLbKihfWl
	 vbFeNhVMdDPldO81NkFHvnprx7ZwN3By5NF1qoxv1KT69tBfj395Te7XTxPZU6zeSG
	 1CLfbNIGXSGwYbG7sJMvKNAXdujDKLCctQ7C8kgCJq3IEgVtdy7UXmVIUQjaZvbgLc
	 k+gTKtdTE6COA==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Jim Cromie <jim.cromie@gmail.com>,
	Catalin Marinas <catalin.marinas@arm.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.1.y 3/4] kmemleak: drop (age <increasing>) from leak record
Date: Thu,  3 Sep 2026 13:48:31 -0400
Message-ID: <20260903174832.1263842-3-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260903174832.1263842-1-sashal@kernel.org>
References: <2026090332-elliptic-contort-6cb3@gregkh>
 <20260903174832.1263842-1-sashal@kernel.org>
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
Stable-dep-of: 5d10d4e19e6d ("mm/kmemleak: avoid soft lockup when scanning task stacks")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 mm/kmemleak.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/mm/kmemleak.c b/mm/kmemleak.c
index 83f885a55bff7..904b5d396e124 100644
--- a/mm/kmemleak.c
+++ b/mm/kmemleak.c
@@ -348,14 +348,12 @@ static void print_unreferenced(struct seq_file *seq,
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

