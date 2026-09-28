Received: from mail-dl2-f43.google.com (mail-dl2-f43.google.com [74.125.229.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 48E2B4E2F01
	for <stable@vger.kernel.org>; Mon, 28 Sep 2026 14:44:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.229.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790606677; cv=none; b=oNQQUhd1q9Wp/1U7Lir93wgn527a1E3LCabTxozSZRhZ4J3+9kEBaTAIc71MJuWzyU0qM1PM22tRe56l/c3e8WInsR1cE647x5kwDrskwfiblYUecYZ+0HVsJVEbxqJG3uhooL+g4eoxm0XMk+174E3uhkdIJYocagT762NBmEk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790606677; c=relaxed/simple;
	bh=hUzXU5E/KqvNPYAX3zmqdtrnJ5rtVP8vUr6s1W4TQew=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=LckunsFAQCWtt48WVdCvl82UuUT79MY/1L2WMj7LijpLnvBAhm5U/t5ZoleeTNXDQWynPNu7VaALYjvM/EvWLnN2UWMBVC/whHs1rlf25xMafi/pJ0Q8YXmb6kSn0o9cxplApORk5UKwDsvOFyJ3h0gbu1TSfMgr7PsYktjnx6I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Pe9JYZAF; arc=none smtp.client-ip=74.125.229.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Pe9JYZAF"
Received: by mail-dl2-f43.google.com with SMTP id a92af1059eb24-14373bcc010so2615824c88.1
        for <stable@vger.kernel.org>; Mon, 28 Sep 2026 07:44:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790606665; x=1791211465; darn=vger.kernel.org;
        h=cc:to:message-id:content-transfer-encoding:content-type
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=WZm/t45iPD8koRJxLUoUECjl6exhQnkIf+5xM7HxYQo=;
        b=Pe9JYZAF3+q66Gz58bYwq6pdI0UcmhoViq6j/K+BLNLdsq3rmvZxQNsW7oFf4qPEXL
         4pqpoewMLOfPfJRYUFPuhEqZPwiS8qcT+3+jIbxx9Qrz8uey8c8jJcSNqbeBLkYmPSsO
         LhyPeR86RzAXsH/+qd1dxowMUmmrjyBrkC0KtgZwk6OR+dXp61XnMh8ruhJT1pLGxqAT
         bC+a0ZbB8Y6WqSDABkWpK4zVeMjaSi8rWV3dyExfj7quY1ZPnP4WJJV7CUCkbE7M2UMP
         K8OSIhvgzDHWn04j5ziFw9t9z/N+jVYywrTja51T7i+Zz/o9XS/xMwuL26hk9Nbg4X4b
         ga7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790606665; x=1791211465;
        h=cc:to:message-id:content-transfer-encoding:content-type
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=WZm/t45iPD8koRJxLUoUECjl6exhQnkIf+5xM7HxYQo=;
        b=s4Bi9kLzWgVg5wduXJx4XwLHzMJJIOkg88B8nM/UaQBPSu/QX9POarY/lBVdFZzV/5
         YbhWPjZvTpMkJ2C+7pxGKcMjJPqyq0OCDA6S+cSUFwdLcHfrUIAylpjBEnhcRNazRlfw
         IzBoQFjZfKoPI7J9E6ngF93eDE0Ax5guMHl4tChi6n6Elt6aPRfg3eL9/DewbPDvs0XT
         KaxXEi3YmqFy+KvpzylVyMPO9iiWWeQ3WRNDn1D9/oQTRVNGKl300dalPbyv1PQsOBdi
         4XLtvmEcz46W91Ydt57/X+FoJEWH8ZPiP1e/ctbTXWcOPibGiaTyzyuacMT9XncQ1wYE
         xW7A==
X-Forwarded-Encrypted: i=1; AKwUvBzGIePZf/ujedUK+y2S/jvz8/HsCyLTNbj8nX8Ajn33x+OC0eHFfYTC8bQkLKVmV+KpLDM1vyw=@vger.kernel.org
X-Gm-Message-State: AFuF++mRHjHEX/IMrLFmzqTHxyhQggj3Jq0V4rrpM9EWBN4JJ0ahAJq9
	hKskPoJujUTfsbcanGCy1/wBMZTkP2bV6zRznIzhgkFVvvd0aYeAY+0L
X-Gm-Gg: AYBFou3CR503Lhf3TjCK0bBLgs3mbo48W8WlCOO2TOJkoPeJi3bhHT7j8KNz/aEuST5
	b2w0fChNDZXTGy97AuLbP8o2SIB7aQ6IiLsDF55y0q4Maq77UgAEsAf5mUmDu/acwC7XH6MmKgw
	RjRE5Y1nZp3pXbSoV2koXK7wdK6bdy5aAq5aEAMLjloYz4U1lV7ahMlZnlxjnS78iOalT2XmuUf
	7QI0F/g3BhpuvYRxhKlarF8xNKJWVz8stUHbzdCbtlWWtXAyjhaDTRqNP07jr1WOchNtATjciwo
	QRwsP892V8deIZOWluikHg+zRdHMRX9rc8YLSuwD5TuIORaQ/w9Vgk49IIOlCvJBtO0bJqdrneR
	I1He3P07pu8MB1OtoBuylCAul6M0xJBtMNSFc69+9JbYlVaaeDiPjxhkq4r6DU3V1idVwN4DoTf
	sDvbjkryUtAtfGsNRZ5y/6KBiGOiSY4QUlIJysPyzcTgqkCjf5tQq2UzJFlBnKtaEMg5k=
X-Received: by 2002:a05:7022:2525:b0:144:f096:4dda with SMTP id a92af1059eb24-146d096d302mr14884062c88.43.1790606665309;
        Mon, 28 Sep 2026 07:44:25 -0700 (PDT)
Received: from [127.0.1.1] ([23.254.208.9])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-145acc47ab8sm29671621c88.6.2026.09.28.07.44.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 28 Sep 2026 07:44:24 -0700 (PDT)
From: Qiliang Yuan <odys.yuan@gmail.com>
Date: Mon, 28 Sep 2026 22:44:21 +0800
Subject: [PATCH v3] jbd2: fix shrinker scan budget accounting in
 jbd2_journal_shrink_scan()
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260928-fix-jbd2-shrink-scan-nr-scanned-v3-1-916caaa53420@gmail.com>
X-B4-Tracking: v=1; b=H4sIAER9umoC/5XNQQ7CIBAF0Ks0rB0D1GBx5T2MC4ShHbVgwBBN0
 7tLu3Kpq8mf5L8/sYyJMLNDM7GEhTLFUEO7aZgdTOgRyNXMJJeKa9mBpxdcL05CHhKFG2RrAoS
 03oAObMt1Z53mAiWryiNhrawLp3PNA+VnTO91sIjl+7tdBAhA5XdcKLRK62M/GrpvbRzZYhf5p
 yert0eBHm1rvPPf3jzPH34cO2UeAQAA
To: Theodore Ts'o <tytso@mit.edu>, Jan Kara <jack@suse.com>
Cc: linux-ext4@vger.kernel.org, linux-kernel@vger.kernel.org, 
 stable@vger.kernel.org, Qiliang Yuan <odys.yuan@gmail.com>
X-Mailer: b4 0.13.0

jbd2_journal_shrink_checkpoint_list() already tracks its examined
checkpoint buffers accurately: it decrements its nr_to_scan in/out
parameter for every journal_head walked, whether or not it gets freed.
jbd2_journal_shrink_scan(), the shrinker's scan_objects() callback,
never surfaces that into sc->nr_scanned.

Because sc->nr_scanned defaults to sc->nr_to_scan before every call,
do_shrink_slab() always assumes a full batch was examined and keeps
calling scan_objects() until the one-shot budget derived from the
(possibly stale) percpu checkpoint count is drained, even when every
buffer in the checkpoint list is busy and nothing gets freed.

Derive sc->nr_scanned from the difference between the nr_to_scan value
passed in and the value left behind by
jbd2_journal_shrink_checkpoint_list(). Trigger SHRINK_STOP on
nr_shrunk == 0 (nothing freed) instead of leaving do_shrink_slab() to
keep calling us: a checkpoint list full of buffers that are still busy
being written back can honestly report a full batch scanned while
freeing nothing, and retrying immediately within the same synchronous
reclaim pass will not make any of that in-flight writeback complete
sooner.

Tested by creating 20000 small files without an explicit sync (to let
jbd2's normal 5-second commit timer move them onto the checkpoint list
while their buffers are still busy being written back) and then
triggering "echo 2 > /proc/sys/vm/drop_caches", tracing jbd2_shrink_*:

              scan_objects() calls   calls with nr_shrunk == 0
  before             176                    176 (100%)
  after                8                      8 (100%)

Fixes: 4ba3fcdde7e3 ("jbd2,ext4: add a shrinker to release checkpointed buffers")
Cc: stable@vger.kernel.org
Signed-off-by: Qiliang Yuan <odys.yuan@gmail.com>
---
V2 -> V3:
- Rebase onto v7.3-rc5. It already includes Max Kellermann's
  "jbd2: bound shrinker scans by examined checkpoint buffers"
  (15cb16496446), which independently fixes the busy-buffer
  accounting in journal_shrink_one_cp_list()/
  jbd2_journal_shrink_checkpoint_list() that v2 also touched. Drop
  the now-redundant checkpoint.c changes; this revision only touches
  journal.c, reusing the accurate nr_to_scan tracking Kellermann's
  fix already provides.
- Add a Fixes: tag for the commit that introduced
  jbd2_journal_shrink_scan() without ever setting sc->nr_scanned.
- Re-measure test data against the new baseline (176 -> 8 calls,
  vs the old baseline's 168 -> 7).

V1 -> V2:
- Count examined buffers, not just freed ones, in
  journal_shrink_one_cp_list() (Sashiko AI review finding).
- Trigger SHRINK_STOP on nr_shrunk == 0 instead of
  sc->nr_scanned == 0.

v2: https://lore.kernel.org/r/20260928-fix-jbd2-shrink-scan-nr-scanned-v2-1-7e1efec3afdf@gmail.com
v1: https://lore.kernel.org/r/20260928-fix-jbd2-shrink-scan-nr-scanned-v1-1-e6f4016ec699@gmail.com
---
 fs/jbd2/journal.c | 17 +++++++++++++++++
 1 file changed, 17 insertions(+)

diff --git a/fs/jbd2/journal.c b/fs/jbd2/journal.c
index 00f5a98f3d4fe..a61b7a59c0a0e 100644
--- a/fs/jbd2/journal.c
+++ b/fs/jbd2/journal.c
@@ -1263,10 +1263,27 @@ static unsigned long jbd2_journal_shrink_scan(struct shrinker *shrink,
 	trace_jbd2_shrink_scan_enter(journal, sc->nr_to_scan, count);
 
 	nr_shrunk = jbd2_journal_shrink_checkpoint_list(journal, &nr_to_scan);
+	sc->nr_scanned = sc->nr_to_scan - nr_to_scan;
 
 	count = percpu_counter_read_positive(&journal->j_checkpoint_jh_count);
 	trace_jbd2_shrink_scan_exit(journal, nr_to_scan, nr_shrunk, count);
 
+	/*
+	 * Give up on this reclaim pass if this call didn't manage to free
+	 * anything. This is deliberately based on nr_shrunk, not on
+	 * sc->nr_scanned: a checkpoint list can be full of buffers that are
+	 * still busy being written back, in which case a call can
+	 * legitimately scan (and correctly report through sc->nr_scanned)
+	 * a full batch of them without freeing a single one. Retrying
+	 * immediately within the same synchronous reclaim pass is not going
+	 * to let any of that in-flight writeback complete any sooner, so
+	 * there is nothing to gain from letting do_shrink_slab() keep
+	 * calling us against the same stale freeable count until its
+	 * one-shot scan budget for this priority level is exhausted.
+	 */
+	if (nr_shrunk == 0)
+		return SHRINK_STOP;
+
 	return nr_shrunk;
 }
 

---
base-commit: 72d3fcf802c45d00b300f25b848a93c3a2bd7c7e
change-id: 20260928-fix-jbd2-shrink-scan-nr-scanned-c3098cd901e2

Best regards,
-- 
Qiliang Yuan <odys.yuan@gmail.com>

