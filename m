Received: from mail-pl1-f173.google.com (mail-pl1-f173.google.com [209.85.214.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2136D2C15BB
	for <stable@vger.kernel.org>; Sun,  6 Sep 2026 13:31:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788701483; cv=none; b=cuWncvDsj7oKfbfUkWNkgqwOw5ungHvuhF1BjH5VOquZqL1vGyeD4I+pK1S1KA1devCBAVwphljKm/h6JW2tZ3bVWWQuBj22qow6HHF6Ow/b7YcuOtiLVNr26R6lTH42mc/c5BMEicp1huHqOl5JnKocSSyk0xq8Hnfxv3kh7cU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788701483; c=relaxed/simple;
	bh=w9uXm4NeZlNVLPlUVdwRM9srfwyMgHqMULfg8Dra+mw=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=jeSDORXpJ1y+bSYORMp46K3F33+7jxF5v89mcFM0nMv4o7JykRT+Hmb5MKaJXhYyPiqaZl28BJsN4m31Ac41AdRrFPM9tQF51gHxH6bs0jqcvZ5d4FF6/ElwvFn8Mdi1FfhfBGSdDmlRDJF+zyKN9okc32xFeWX3IIK9AoIYkh8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=oiQiz3Ph; arc=none smtp.client-ip=209.85.214.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="oiQiz3Ph"
Received: by mail-pl1-f173.google.com with SMTP id d9443c01a7336-2cfbbdfa60bso23154785ad.3
        for <stable@vger.kernel.org>; Sun, 06 Sep 2026 06:31:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1788701481; x=1789306281; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=Tj4ItgvvBxbS1G7naSWp8Nbn7WWa6B30ZGxjseZ9BkI=;
        b=oiQiz3PhPwldC4bnwr4BRrOIcxwAPQl0IbKZWW2PA9mbdoh1kCGAObMVlqA1hk/5qx
         +ofkgCBxiZsiAwohvSzO8AoQsL0eLeNiIy2w9gmps3ZKW99o3BGw6kXAQX/KsRsiU5hj
         CFUkSJ7+unTOaqqeTGYWXf2zwjNDdKG/6+tMAyBCTEy8FPAD/NzhzyH7PLaoYpOsFc2p
         Hf4yQnBxf0O0N2s9SEhB3o/k5NNgpj5kOLCNqT1lRCom6BxP2eWXrXqySJfaR6XFOcfA
         rtToG6/9YApMg3D3llzuoG36c6kUxRsFTQXWWeAP3KGJ3MPmuL7kfRDQBoIxsizvg6cy
         wJZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788701481; x=1789306281;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=Tj4ItgvvBxbS1G7naSWp8Nbn7WWa6B30ZGxjseZ9BkI=;
        b=GWTP47pTlMCPd5jFwrWCzzixq7VDmlHCGqZCYmhVissKV4CJT/5fxH2t9HQadKK14w
         MiqxuQ/tONQVEwQnnwQ1xmQXihZoTAIW+REtoIDii4G7tFsoxKVGsGfByZwUTEYegsIv
         9P6WTyklsZXuPCy85j+NS2jDWmgidGWqxmoUFPyBAs4juMEj3uyz9LuJvtbOhXAdjCWo
         LFZ5L04FLgzXzuesdX9zXqGwd0BfBLtogBmzSGe+G2DXV5COflxQ+jffuBfjXRGCVuYV
         wCmazuTXPSVXJ9QicA85rdCa/G9KYm0TOkRDB0uR3fWnu6Een+02XIIWf3ePRw56oarZ
         MRRA==
X-Forwarded-Encrypted: i=1; AKwUvBxD1MMRc2JcdnYyXW1h9lOrPTBC7Hi5cehOh/0OpRUpFxA8HmBDuT+l4UolNokMV02XeKsl8IA=@vger.kernel.org
X-Gm-Message-State: AFuF++m/xdJbbnBTKI4C12bYDeRrHqA5h/T4Crf7bm6099pquYCGMcGx
	g9bUwswyVSI0NUjFiASSaChDvLKfcL6zx/Vnpb9Cr04/TAzEb1mSWlNF
X-Gm-Gg: AYBFou0n0xQmOA6wtq2CAwfXoo4dE/dUmLAvlwPswSNDfBDJ60d5s5Q8geyki1bZGlH
	QJAStOzkYmrGaPMvdyA1yvagKfa2QvZXDityc99rDFX1Z0F+QSnhtJJ3gqJ9IY4rqOnw+JpUuca
	8uE8n3PE215bosLwGo36LlDhIvX6xL3+fdofw1IC+fMUSfYuz+V+T3anAbtakGZ9UApcbGczznv
	eVgtlzR5mc4xpLDWjOQZJwEoAlCjp9zz0V4Fe7hm/fUTaK0CRiicRX33s1af08yIBMsKLUR8umC
	o4SO48hF5FaTmbj2LJ6eHc4zSxeviVVyGFXsBuaqtgzBWj9ielkxmLgoMRBmZ+ok8YJdU0n0Hcu
	rYzhoYaOnPdKJsEtKjvXoqYGteyP6emx73Rl0gGTIZPeUocd/BfV+Noc9f/vPd1OPBC20lCfnaA
	gfIM+ewl3ka/53fTdIgI8ZspubZiTY0U/CdCs0Olbif/YsOcYOD5YBfiP0H+PWKQCeQd28xQnfU
	xzsxo5u
X-Received: by 2002:a17:903:3848:b0:2d9:56dd:f804 with SMTP id d9443c01a7336-2db125f00c7mr262152175ad.13.1788701481084;
        Sun, 06 Sep 2026 06:31:21 -0700 (PDT)
Received: from thangnn-ASUS.. ([2405:4802:1d38:5c70:7bb9:b8bf:8aa8:fb0d])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2db1499d92dsm32422945ad.52.2026.09.06.06.31.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 06 Sep 2026 06:31:19 -0700 (PDT)
From: ThangNN99 <ngocthang2710.1999@gmail.com>
To: Mark Fasheh <mark@fasheh.com>,
	Joel Becker <jlbec@evilplan.org>,
	Joseph Qi <joseph.qi@linux.alibaba.com>,
	Heming Zhao <heming.zhao@suse.com>
Cc: Andrew Morton <akpm@linux-foundation.org>,
	Su Yue <glass.su@suse.com>,
	ocfs2-devel@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	ThangNN99 <ngocthang2710.1999@gmail.com>,
	syzbot+73d1166b94ed9875af54@syzkaller.appspotmail.com,
	stable@vger.kernel.org
Subject: [PATCH] ocfs2: fix ABBA deadlock in suballocator reclaim
Date: Sun,  6 Sep 2026 20:31:12 +0700
Message-ID: <20260906133112.73343-1-ngocthang2710.1999@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

_ocfs2_reclaim_suballoc_to_main() runs inside an already-started
transaction (j_trans_barrier held) and locks the global bitmap inode
to return clusters to it. Every other allocation path takes that
inode lock *before* starting a transaction, so this reverses the
order and can deadlock:

  CPU0                          CPU1
  rlock(j_trans_barrier)
                                lock(sb_internal)
                                lock(j_trans_barrier)
  lock(GLOBAL_BITMAP inode)

Since reclaim is best-effort (its caller already ignores the return
value), fix it by acquiring the global bitmap inode with trylock,
before mutating anything, and bailing out to skip reclaim on a busy
lock instead of blocking in the wrong order.

Reproduced with the syzbot C repro under QEMU: the unpatched kernel
hits the lockdep splat on the very first mount+mkdir+rmdir cycle
(~10s in); the patched kernel ran the same cycle 169 times with zero
splats, and instrumentation confirmed reclaim keeps running (trylock
succeeds) rather than being silently skipped.

Reported-by: syzbot+73d1166b94ed9875af54@syzkaller.appspotmail.com
Closes: https://syzkaller.appspot.com/bug?extid=73d1166b94ed9875af54
Fixes: 4a54331616b3 ("ocfs2: give ocfs2 the ability to reclaim suballocator free bg")
Cc: stable@vger.kernel.org
Signed-off-by: ThangNN99 <ngocthang2710.1999@gmail.com>
---
 fs/ocfs2/suballoc.c | 37 +++++++++++++++++++++++--------------
 1 file changed, 23 insertions(+), 14 deletions(-)

diff --git a/fs/ocfs2/suballoc.c b/fs/ocfs2/suballoc.c
index 20c3aec6b987..085af9ba38ab 100644
--- a/fs/ocfs2/suballoc.c
+++ b/fs/ocfs2/suballoc.c
@@ -2716,18 +2716,39 @@ static int _ocfs2_reclaim_suballoc_to_main(handle_t *handle,
 	idx = le16_to_cpu(group->bg_chain);
 	rec = &(cl->cl_recs[idx]);
 
+	/*
+	 * We already hold j_trans_barrier, while everywhere else locks the
+	 * allocator inode before starting a transaction. Trylock here, before
+	 * mutating anything, so a busy lock skips this best-effort reclaim
+	 * instead of inverting that order into an ABBA deadlock.
+	 */
+	main_bm_inode = ocfs2_get_system_file_inode(osb,
+						    GLOBAL_BITMAP_SYSTEM_INODE,
+						    OCFS2_INVALID_SLOT);
+	if (!main_bm_inode)
+		goto bail; /* ignore the error in reclaim path */
+
+	if (!inode_trylock(main_bm_inode)) {
+		iput(main_bm_inode);
+		goto bail; /* ignore the error in reclaim path */
+	}
+
+	status = ocfs2_try_inode_lock(main_bm_inode, &main_bm_bh, 1);
+	if (status < 0)
+		goto free_bm_inode; /* ignore the error in reclaim path */
+
 	status = ocfs2_extend_trans(handle,
 				ocfs2_calc_group_alloc_credits(osb->sb,
 						 le16_to_cpu(cl->cl_cpg)));
 	if (status) {
 		mlog_errno(status);
-		goto bail;
+		goto free_bm_bh;
 	}
 	status = ocfs2_journal_access_di(handle, INODE_CACHE(alloc_inode),
 					 alloc_bh, OCFS2_JOURNAL_ACCESS_WRITE);
 	if (status < 0) {
 		mlog_errno(status);
-		goto bail;
+		goto free_bm_bh;
 	}
 
 	/*
@@ -2795,18 +2816,6 @@ static int _ocfs2_reclaim_suballoc_to_main(handle_t *handle,
 	memset(group, 0, sizeof(struct ocfs2_group_desc));
 
 	/* prepare job for reclaim clusters */
-	main_bm_inode = ocfs2_get_system_file_inode(osb,
-						    GLOBAL_BITMAP_SYSTEM_INODE,
-						    OCFS2_INVALID_SLOT);
-	if (!main_bm_inode)
-		goto bail; /* ignore the error in reclaim path */
-
-	inode_lock(main_bm_inode);
-
-	status = ocfs2_inode_lock(main_bm_inode, &main_bm_bh, 1);
-	if (status < 0)
-		goto free_bm_inode; /* ignore the error in reclaim path */
-
 	ocfs2_block_to_cluster_group(main_bm_inode, start_blk, &bg_blkno,
 				     &start_bit);
 	fe = (struct ocfs2_dinode *) main_bm_bh->b_data;
-- 
2.43.0

