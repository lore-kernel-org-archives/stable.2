Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.216.46
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794787225;
	b=BOBkxxhC92803LtKo5S4TYD8bDzvWRcCG7ZcBugQZvrUHnangP2y5mIIb7sZ5erc/WpQ
	 WCTZmfumtlU3vIIVzy56dYsr0/WObrJvWOOdhD03sayKSlIgvlqolHAqpiD+NX3ocpLIX
	 Hc8/MPRk3phgXr0FTBMGZY1FhHCrRAOHsdoEOa9+dm+ezeuqDPpHWdzQWD34a7x1xoQxh
	 j2bNyJDJTCWJcuZxoUa7OpfmLKn7V3Qow3DZOWfWuET3mOtW+JTDLVfZ4ikOKucuHGudx
	 BSkqwAeMZm+RwpfSQ3cStU7wxO1fps4ujIi3Qs/kAy9ph9nyHO9jUuiTnUJLbn9bCmQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794787225;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:MIME-Version:
	 Content-Transfer-Encoding;
	bh=7mrq+jL5aACHNl3ltXcO3fURb6JLvjPGhfwWz9B6vIw=;
	b=qrkM1cLU4SYAAr+qO0143FU0Xui7lbjwrIAX0Kdgnw2kO4/0KcawZyO1yTQnST9KB83/
	 a/67rzef14jQtzxG5GryaTW5BZBOJZZKXHe+5EhGEiEoFkc9uCq2PWIlBAxi3Og8o3UsG
	 k+u4j7mTNYxh3c5PX2f9uNEMBkdLc0/s/DWJFuy2nRi0ySyO/Ls7HlwTyY+0GxS0p4LeP
	 CIDyn8hw28eCq0/n8pkPgJUgdocv40iwucM+/j9U80GMucQZRLeHOl/PcpeB8ys5ga8fh
	 sTTEM/2aMFnQbebtduEgIPtkqcvfIsmWkHBY9S5VR5+raVJTYEFDGTBoPsa3ASyiHHA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=JOxpDL5y;
	arc=none smtp.remote-ip=209.85.216.46
Received: from mail-pj1-f46.google.com (mail-pj1-f46.google.com [209.85.216.46])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4FC30606A329
	for <stable@vger.kernel.org>; Mon, 16 Nov 2026 00:00:25 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 4FC30606A329
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=JOxpDL5y
Received: by mail-pj1-f46.google.com with SMTP id 98e67ed59e1d1-3ae7626d14aso1439191a91.2
        for <stable@vger.kernel.org>; Sun, 15 Nov 2026 16:00:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794787224; x=1795392024; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=7mrq+jL5aACHNl3ltXcO3fURb6JLvjPGhfwWz9B6vIw=;
        b=JOxpDL5yC+IX5MOwPs/wTSOTxN89zjXJhuVNEmkPS30q+66oFAjGHytW+TWBKytTIB
         ZsE073w4Cc4vDEvRCkcxQYXvO8tu157YnjM3orpHlXPtqqMy2C26JlpDxkH9TwJGHFxO
         IzkU3woKqocMsKNBcHSugkPuYAqnx50Gf+aY+Is+6wGPHNTYI5Ca822Wy7loVl4rK3d2
         /4tLwypm4GS6t8iJNNAHQrEMWwBb2DZbcqfN81r1neJC9iThz91LnnK+64WnJQSSo0QA
         H0PSd3v9ZwLkY5doEslPgLdYS5jvdUxlrgPiVJz95n+p3JNp+SEsbCv/BZWloCMxEtSP
         LHcA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794787224; x=1795392024;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=7mrq+jL5aACHNl3ltXcO3fURb6JLvjPGhfwWz9B6vIw=;
        b=WoV+FvPAeGEvq7phBJyhKeqeNSsKWtj4VaqcuqrF2OMhwi4g1TztS3bHxK83PCBeM0
         aTwnKqkzEX4rYiaPKA7MCM02gnq4pToO31ImmFVVya52U0PyVRd+uQo1G4/PdrzqQPZ6
         0kfIntDx/usZ9NDcdSZFYtrQ5EJ2kMaIQS4ji7RLYG6hvN4jxFApixKnFuLQ7h7MRpB/
         +Nk7fIZt8cMbKPDpjhpJwYsKAcleDP4ltLnphOcEh7vfvJ9no7CCVLOldF6t8M45lBu5
         hz0pt+ti2SBea7O0rqNu+DKBnIZDf/tcpcdmXSpvqJIQvuEg8ea6K4Ev/Uh83YoDxuDa
         S1wg==
X-Forwarded-Encrypted: i=1; AL+hErHmNClTOW/nV+wrwV4/3w3Wjg3+C4UDC1k0S4mMtK4lkqCbjs8A+J9u9sUMQXoj6x/a17p5ea8=@vger.kernel.org
X-Gm-Message-State: APuU4Z/bnWx0+gUCfH+5g7xfWeO3cwKTEpVzVN+NxEyOaOXyiXdLQk7x
	zQagME5Kfrkg9tNG53QmtUNAFGTNJaWPclPDVALRDNBuSH0H/WpUckJj
X-Gm-Gg: AYBFou07dQ24UTRqK/DiqQ0BTG3iO23WM59F7Mz2I004d0DflPsEr73psQkE1oxrGxW
	YQ6sBp88tVlkDmClr0+EecYa6U8fQ8UkPt0cVsEtfF84ibaQOc8AMyObCAEUHO6kKBCoXRDOXO6
	0394C77dWgZABlRkGaAUMHsxngIKakiQL7HrmNxpOK6iUwDZipPwNsxPOp6HPpsG46uRw7CgOeR
	rB0o0AsLSSDNp3X4wX4gfBRzy76zoJxEdqBMfpiSMg1bC9Bw37L76+SVb82a5s0MXV3js/CuKHz
	xYvnTWEXmPTj4RJ9VXP2Q8YMiPjN5DaOpVLROdsi1lDDfItvy9bT29qnilVKTfQGIHDjx1Bpxms
	arpL+UHV+BqBh22RpiTW1fAVv09FfI3uJ+XVO0EMSIRo4A7TRhT8WEq9D3DZl5UeuabxpmomiU/
	4hBq3qzTCGXSoIvmh/RetzgZT/vK6nqsvs2w3kUM1XDWjUuhWb3xVRuns7lGBCRuGudYXA4hSum
	beDFDXliXBNeZFvcRAhdWuc3AO5klvk4F1ZXw2Ix/mitLr7z6i7ngQaiHwtSFXa+8ZRhpKVAXTW
	Yp2Ost+S+SUSbzBQuJF3Ag7a8zp241sbsGDMSGk9m+bQs7fNM33hZlJuU0JyFlkZYX6rl+Ro6qW
	CAhGTd6WWMF8ngpN9TTrLKXwwwrAkXtKVYhELLdYMlWgcVA==
X-Received: by 2002:a17:90b:5608:b0:3ac:adce:60a9 with SMTP id 98e67ed59e1d1-3b1b07ef0camr8541905a91.9.1794787224413;
        Sun, 15 Nov 2026 16:00:24 -0800 (PST)
Received: from f2fs-test.c.googlers.com.com (193.67.125.34.bc.googleusercontent.com. [34.125.67.193])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3b197ce556dsm19125756a91.6.2026.11.15.16.00.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 15 Nov 2026 16:00:23 -0800 (PST)
From: Daeho Jeong <daeho43@gmail.com>
To: linux-kernel@vger.kernel.org,
	linux-f2fs-devel@lists.sourceforge.net,
	kernel-team@android.com
Cc: Daeho Jeong <daehojeong@google.com>,
	stable@vger.kernel.org
Subject: [PATCH] f2fs: block checkpoint before moving cursegs for device aliasing
Date: Sun, 15 Nov 2026 16:00:19 -0800
Message-ID: <20261116000019.2299222-1-daeho43@gmail.com>
X-Mailer: git-send-email 2.56.0.611.g1030f0b940-goog
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

From: Daeho Jeong <daehojeong@google.com>

f2fs_ioc_reserve_dev_alias() moves the cursegs out of the range of the
alias device with gc_lock only, before it takes f2fs_lock_op(). gc_lock
does not keep every checkpoint away: f2fs_ioc_reserve_dev_alias() and
f2fs_ioc_release_dev_alias() write the checkpoint at their end after they
released gc_lock. So the cursegs can be moved while a checkpoint of
another alias ioctl is in progress.

do_checkpoint() copies the positions of the cursegs into the checkpoint
first and writes their summaries later. If a curseg is moved in between,
the checkpoint does not match it. Commit b4b10061ef98 ("f2fs: refactor
resize_fs to avoid meta updates in progress") fixed the same problem in
f2fs_resize_fs() by taking f2fs_lock_op() before the cursegs are moved.

Do the same here. Take f2fs_lock_op() first, and then move the cursegs.

Test: two alias files, with a debug patch which makes do_checkpoint()
of the release ioctl sleep after it copied the curseg positions. A
reserve ioctl on the other alias file moved the warm data curseg during
that sleep, and the checkpoint recorded the segment the curseg had left.
With this patch, the curseg is moved after the checkpoint is done.

Fixes: eae3faf210bd ("f2fs: support dynamic reserve/release for device aliasing")
Cc: stable@vger.kernel.org
Signed-off-by: Daeho Jeong <daehojeong@google.com>
---
 fs/f2fs/file.c | 17 ++++++++++-------
 1 file changed, 10 insertions(+), 7 deletions(-)

diff --git a/fs/f2fs/file.c b/fs/f2fs/file.c
index 05061254c3b2..75c51b3a4118 100644
--- a/fs/f2fs/file.c
+++ b/fs/f2fs/file.c
@@ -3905,13 +3905,7 @@ static int f2fs_ioc_reserve_dev_alias(struct file *filp)
 	/* Reset the victim information to prevent GC from targeting the range */
 	f2fs_reset_gc_victim_resource(sbi, start, end);
 
-	/* Move out cursegs from the target range */
-	for (type = CURSEG_HOT_DATA; type < NR_CURSEG_PERSIST_TYPE; type++) {
-		err = f2fs_allocate_segment_for_resize(sbi, type, start, end);
-		if (err)
-			goto out_gc_unlock;
-	}
-
+	/* stop CP before moving cursegs, as f2fs_resize_fs() does */
 	f2fs_lock_op(sbi, &lc);
 
 	if (unlikely(is_sbi_flag_set(sbi, SBI_CP_DISABLED))) {
@@ -3920,6 +3914,15 @@ static int f2fs_ioc_reserve_dev_alias(struct file *filp)
 		goto out_gc_unlock;
 	}
 
+	/* Move out cursegs from the target range */
+	for (type = CURSEG_HOT_DATA; type < NR_CURSEG_PERSIST_TYPE; type++) {
+		err = f2fs_allocate_segment_for_resize(sbi, type, start, end);
+		if (err) {
+			f2fs_unlock_op(sbi, &lc);
+			goto out_gc_unlock;
+		}
+	}
+
 	/* do GC to move out valid blocks in the range all at once! */
 	err = f2fs_gc_range(sbi, start, end, false, 0, false);
 	if (err) {
-- 
2.56.0.611.g1030f0b940-goog

