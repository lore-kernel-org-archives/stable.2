Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.182
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793585040;
	b=WrxQS+rnB0SpJlDTNStMGhEshuAKpxwxuqn8Fm1C3sT6BbiByCAQj9gIAN8PF3KXn7Zk
	 hySWApTPPYTml3bFXyiVv5HYS61G0kdHYIv4I+CoEVR3z6PP+ElS4/w4iWhhFj62I46LG
	 Ii3B2M5ezMPkX8yGhqkLkDOmLqqxn0B/azN2mxju2JNZMWJD9DrdubnMHUgEF9b9OIber
	 ZOp6BJfoaf+5zyjbOEven3dkVb1NVGkh83gMME4XNq/pwgbaYLJp807TPZCNmwuMCmOBy
	 DNOPqoSGgj/NF3XICAg5u3AzgMWfle1sKZHwgs4j2K8MRK0/YJosqemJ4PmHK6vd+lA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793585040;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:Date:Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:
	 Message-Id:To:Cc:X-Mailer;
	bh=ILJGyWA9cCx1Ar1Qgl+/EPmfWI2kJKAy/oM+W8KfewE=;
	b=sHhM+yXvF220EkzxUFOlkFHRXYgeooY6+vNPlZ+Xvpy8wB7AF2+wBc8N4uOTcSkql5Nv
	 rIkpWHaaPSUz9uDLQ8O0VLg9bg+PrmqBdFE+tx1ggO0vK+BDH5mIEhbg7qmrh922pAkbO
	 XlJ5LlX4pFyZ+gBka8RLCl2EzaXOwm+oFVZRXkRbohlv2yR3K2CtZKq29SwOvw9L5O0ML
	 b4QI5NlpRgBHdZBurZWGxUP6UqlPJZLeKVxqFSMxV37NxrMfqv+Z8duCvZsaQ2lyvLhQc
	 mE5UqAlgo7B44sN+2ZZ91p8+npt6O2jh1wLg2sd9bpaYjf8Dc6xw+cDU5XNsVjGfHFQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=cvjdCDQ9;
	arc=none smtp.remote-ip=74.125.82.182
Received: from mail-dy1-f182.google.com (mail-dy1-f182.google.com [74.125.82.182])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3118C606A327
	for <stable@vger.kernel.org>; Mon,  2 Nov 2026 02:04:00 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 3118C606A327
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=cvjdCDQ9
Received: by mail-dy1-f182.google.com with SMTP id 5a478bee46e88-369f33df08eso5076931eec.0
        for <stable@vger.kernel.org>; Sun, 01 Nov 2026 18:04:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793585039; x=1794189839; darn=vger.kernel.org;
        h=cc:to:message-id:content-transfer-encoding:content-type
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=ILJGyWA9cCx1Ar1Qgl+/EPmfWI2kJKAy/oM+W8KfewE=;
        b=cvjdCDQ9msfC6Yh07CuhfdQcuH8sUS+uYR03A0FZTaDE+sR7OCvWhyVE2R9Nal3pHt
         JlRYJp/wzGNlWrcoJQg5SVYjKJS/1Ul1HVZF20kZC7ZR3wbbbTt2EMwn7XS8PLDTYgSo
         uyIgkqheMottE3QbQdRlb6zMoec+o71yp6uhady/doxEsHmBWnTkjjpZS8xR+u7Bml6x
         K18rg9rjnHrnWYb3N2RkweJRVZWzVTQC8t6IiY3S/dRBNkyyu+Vt6yjpqDVUxr079LIq
         xX9cdOhZ2s1kF01noEsyBA5cB6nWsmEElGaf4N8usurwz4jxdzRh4Wm5Ai7p0e5Nl/2X
         dKrw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793585039; x=1794189839;
        h=cc:to:message-id:content-transfer-encoding:content-type
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=ILJGyWA9cCx1Ar1Qgl+/EPmfWI2kJKAy/oM+W8KfewE=;
        b=lS/ctCk4YywdclvkBK9Kn3YXayI/qEN9YAl8acKqOXiGwdXXgFeFv7+5sVyi8RQR32
         He5DahNB/kiZVj+lF1sxDYqD5HohVE+0JV4lzVXzg2IvZMJPJ5busInGMCfA8A5ucn/r
         eT4iWy4mnYoaLwZ7EXdbr/XSOQk6M+KOXicomIusjJB6mfkZZYtzZCL6KmDsYLhhKFOO
         pefrDy9VpIy+8zbMIruUVPeAfIGUdfcoX6zW4J1Y0KjqEPcuNdnS0iSTq5zTgXqpN9Z3
         Y7e6VvGwrynRR3nFsOR2GaK+nhdzLh1jsPajhyJsPNKES/LlWskSzGTlUWxsm67YXVMw
         nPNA==
X-Forwarded-Encrypted: i=1; AKwUvByuZ+UL8I4GvvblGxhGLmwqJXgE2pEoEU1AleYv1fBa2TNuV974crEdQtK5P2xGWcpmyS4yAvY=@vger.kernel.org
X-Gm-Message-State: AFq9FYI5Ti9WoD01MGmApDQ6moKLGA7QX1BcbabImquFGoKvdoncNFVl
	9v1RJxgOKH9YJKtAV6QcVWugVQ0IyLjhO38lK8q5zQr/FfdXowbTSTY7/bs9IOYp
X-Gm-Gg: AYBFou3TYRAlEOGMNQeLT1eay0GRZi+y/1Il4jbC26qKSpGe6pUS18IOexsYVUPQuS+
	N7bOpJB2JQRtj68d2MvrNgBBKs4LF1MjWLN8CuVZqBDTq2hWwlzBo7Uf+lGOxejBvOa3zNXY9W6
	DLunEjXfYlY8fO8jSCaeU68OTQKmwqs37KHdn79OKeg9ZbtTz3eEbq+IXwoBuMWzz7+iXxg5Aky
	EstlZLUOqb8mOQiq47dKn0JnXq0ow5+JgcdroFb0ckUJuMrr8o0NXqLUx7cE1z6mst02ubQKEld
	SakRy6d69MJeZHD5mbbqd/Nio1JlSh3tnk0Z1txXcxqX51il/MxfpGNE6ibleHv5TKyKaMPGybI
	4B3zDazvtlFphLZWiOBfdIEvspQ2pj5Ans7quGcxqPuNzvzYq4159CiP0RDZvLX3CMYt7djx/t6
	WTzWSknGPaZritqZ58oIYEQx9+X+sck1Z2IrMIkyle8G8Oqog9LSv1g8Sd1WfJBFOJSiTiTWrXK
	/NvBEmx9FRp8aru37It47ZE8BgeALjl58u+HT5fF5qKUccs8M9kGp2JvyO/uR2g/7+o8a7yhdqg
	5M9KRVndw+P4RxhM4bvokQ9A
X-Received: by 2002:a05:7022:2097:b0:14b:cf58:ce15 with SMTP id a92af1059eb24-1ac600d9f9bmr13306709c88.43.1793585039251;
        Sun, 01 Nov 2026 18:03:59 -0800 (PST)
Received: from [127.0.1.1] ([23.254.208.9])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-1ac1854d925sm49907568c88.7.2026.11.01.18.03.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 01 Nov 2026 18:03:58 -0800 (PST)
From: Qiliang Yuan <odys.yuan@gmail.com>
Date: Sun, 01 Nov 2026 21:03:56 -0500
Subject: [PATCH RESEND v5] jbd2: fix shrinker scan budget accounting in
 jbd2_journal_shrink_scan()
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261101-fix-jbd2-shrink-scan-nr-scanned-v5-1-ebd1ecc59a96@gmail.com>
To: Theodore Ts'o <tytso@mit.edu>, Jan Kara <jack@suse.com>
Cc: linux-ext4@vger.kernel.org, linux-kernel@vger.kernel.org, 
 stable@vger.kernel.org, Qiliang Yuan <odys.yuan@gmail.com>, 
 Jan Kara <jack@suse.cz>
X-Mailer: b4 0.13.0

do_shrink_slab() reads count_objects() once per invocation to derive
a one-shot scan budget, then calls scan_objects() repeatedly until
that budget is exhausted or scan_objects() returns SHRINK_STOP.
include/linux/shrinker.h documents that scan_objects() "should track
its actual progress" in sc->nr_scanned, so do_shrink_slab() can tell
when there is nothing left to examine and stop early.

jbd2_journal_shrink_scan() never updates sc->nr_scanned, so it
defaults to the full sc->nr_to_scan on every call. do_shrink_slab()
therefore always believes a full batch was examined, regardless of
what jbd2_journal_shrink_checkpoint_list() actually did, and keeps
calling scan_objects() until the budget derived from the (possibly
stale) percpu checkpoint count is drained, even after the checkpoint
list has already been fully drained.

jbd2_journal_shrink_checkpoint_list() already tracks examined
buffers accurately: it decrements its nr_to_scan in/out parameter
for every journal_head walked, whether or not it gets freed. Derive
sc->nr_scanned from the difference, and return SHRINK_STOP once it
comes back zero, since that only happens when the checkpoint list
had nothing left to walk. Key this off sc->nr_scanned rather than
nr_shrunk: a batch can find every buffer in its transactions busy
and free none, while later transactions may still hold buffers
whose writeback has completed; sc->nr_scanned reflects that real
work either way.

Tested by creating 20000 small files, running sync, and letting
checkpointing settle for a few seconds (with systemd-journald and
cron stopped, since their own writes to the same filesystem keep
re-populating the checkpoint list and mask the effect being
measured), then triggering "echo 2 > /proc/sys/vm/drop_caches" while
tracing jbd2_shrink_scan_enter/exit:

                      total scan_objects()   calls with
                      calls                  nr_scanned == 0
  before this patch   22                     10 (45%)
  after this patch     8                      1 (12%)

Fixes: 4ba3fcdde7e3 ("jbd2,ext4: add a shrinker to release checkpointed buffers")
Cc: stable@vger.kernel.org
Signed-off-by: Qiliang Yuan <odys.yuan@gmail.com>
Reviewed-by: Jan Kara <jack@suse.cz>
---
V4 -> V5:
- Revert to keying SHRINK_STOP off sc->nr_scanned (buffers actually
  examined) rather than nr_shrunk (buffers actually freed), as v1
  originally did. Jan Kara rejected the nr_shrunk-based v4, pointing
  out that failing to reclaim the buffers in one batch doesn't mean
  later transactions won't have freeable ones; Sashiko AI review
  independently flagged the same issue. Restore Jan Kara's v1
  Reviewed-by: the diff in jbd2_journal_shrink_scan() is unchanged
  from what he reviewed there (only the explanatory comment reads
  differently).
- Redesign the test: the old methodology (no sync, buffers kept busy
  by design) exercises exactly the busy-but-productive case Jan Kara
  describes, so it isn't a useful before/after comparison for this
  change. Replace it with one that lets the checkpoint list actually
  drain via sync, then measures scan_objects() calls wasted after
  draining due to percpu-counter staleness.

V3 -> V4:
- Shorten the SHRINK_STOP comment; no functional change (the trigger
  has been nr_shrunk == 0 since v2, not sc->nr_scanned).
- Carry forward Jan Kara's v3 Reviewed-by.

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

v4: https://lore.kernel.org/r/20260930-fix-jbd2-shrink-scan-nr-scanned-v4-1-eb9a3ccc2524@gmail.com
v3: https://lore.kernel.org/r/20260928-fix-jbd2-shrink-scan-nr-scanned-v3-1-916caaa53420@gmail.com
v2: https://lore.kernel.org/r/20260928-fix-jbd2-shrink-scan-nr-scanned-v2-1-7e1efec3afdf@gmail.com
v1: https://lore.kernel.org/r/20260928-fix-jbd2-shrink-scan-nr-scanned-v1-1-e6f4016ec699@gmail.com
---
 fs/jbd2/journal.c | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/fs/jbd2/journal.c b/fs/jbd2/journal.c
index 00f5a98f3d4fe..eac5f84a1afc5 100644
--- a/fs/jbd2/journal.c
+++ b/fs/jbd2/journal.c
@@ -1263,10 +1263,22 @@ static unsigned long jbd2_journal_shrink_scan(struct shrinker *shrink,
 	trace_jbd2_shrink_scan_enter(journal, sc->nr_to_scan, count);
 
 	nr_shrunk = jbd2_journal_shrink_checkpoint_list(journal, &nr_to_scan);
+	sc->nr_scanned = sc->nr_to_scan - nr_to_scan;
 
 	count = percpu_counter_read_positive(&journal->j_checkpoint_jh_count);
 	trace_jbd2_shrink_scan_exit(journal, nr_to_scan, nr_shrunk, count);
 
+	/*
+	 * Key SHRINK_STOP off sc->nr_scanned (buffers actually examined),
+	 * not nr_shrunk (buffers actually freed): a batch can find every
+	 * buffer in its transactions busy and free none, while later
+	 * transactions may still hold buffers whose writeback has
+	 * completed. sc->nr_scanned only comes back 0 when the checkpoint
+	 * list had nothing left to walk.
+	 */
+	if (sc->nr_scanned == 0)
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

