Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.224.47
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794544766;
	b=S6SG0rk3nI7UkA3ZGHMPn52wdUqjMKd1P0zTXUbU6C9egmBVQZNZwA+JmFM2cw1RNXB7
	 7GwE7Jq7Y+5qH6ijmxyCYCFmFHr6gwWONWtZQJaN6ihRKM+3DJ+TOWWWoGHZr1pebylut
	 oWr4DSNEKNxiYcefV0Eny/jJegFjpJ1vzHdn2816dawySOvCwfLpEQOPwOjeD6MPxaXdC
	 fb6y8OaaWwQUV/N1UABHiWMZCbqds1Y0yh/pvGSk1bWe5sYBsDcbLzeLB0EzC/2ugay/y
	 3Ub+A/B3r/gKKYJOjYlxLx5FM/Ppzs4znyeX/LMECmf2EQ8GwIV5KmDviyOV+w6z0mQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794544766;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:MIME-Version:
	 Content-Transfer-Encoding;
	bh=tFaT0DZ6F3QRjTbdaYV7CT46FZwUMHFmzpgE4p3kzPo=;
	b=phtjiLCrvf5vtFeZ7Wfl/otJ0lWCW+N5jvJM26FIj7keB4AZR9hxMW/Rt1LIX8GTU64s
	 YqT287LqkeYu6bVs+TpbD2zOAIYvnYc/YwWE2mPWYMlbmD+Gg68tcDTRMsPYHQHXv/5NC
	 rh0xoWF2PByJ6Ht8brDRbLkighgp4cQDtVmbWp7yry7ASjhFz51pPXBa1i9ev3RGHxzGu
	 w8LI0yHaL9hEX9BuQsQ/WD/8jOe0yMahRemP9D2gtzX3l3n204L5IVMFefF62fG2Uji8r
	 xCQIPWPOeqRsuJAYTiziRVTHhCrd74gYJ3il+Zj2i0VkChjHw/glGaLF9mCBL+mvWJA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=cs.unc.edu;
	spf=pass smtp.mailfrom=cs.unc.edu;
	dkim=pass header.d=cs.unc.edu header.i=@cs.unc.edu header.a=rsa-sha256 header.s=google header.b=KBDxmF3I;
	arc=none smtp.remote-ip=74.125.224.47
Received: from mail-yx1-f47.google.com (mail-yx1-f47.google.com [74.125.224.47])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2B18D606A321
	for <stable@vger.kernel.org>; Fri, 13 Nov 2026 04:39:25 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 2B18D606A321
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=cs.unc.edu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cs.unc.edu
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cs.unc.edu header.i=@cs.unc.edu header.a=rsa-sha256 header.s=google header.b=KBDxmF3I
Received: by mail-yx1-f47.google.com with SMTP id 956f58d0204a3-67c6f1019a3so648557d50.0
        for <stable@vger.kernel.org>; Thu, 12 Nov 2026 20:39:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cs.unc.edu; s=google; t=1794544765; x=1795149565; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=tFaT0DZ6F3QRjTbdaYV7CT46FZwUMHFmzpgE4p3kzPo=;
        b=KBDxmF3Ij+U4FfCQaLZjUdUB1gdLJ8WW7JSEB1K9WgBXkrcD+fjhYsRfR7O2ntRU40
         4Sibb6XwHj7eji9fKO6U34e0ySQ78CBBZ95skC6WYKplQlA6NGMIMg4/2+Iqd5cmrOgf
         fIyLWWidqZz8ZQ/NH6dwFveIb71lB7Z35q3suSPUSrrXy2QNqN8Nek30GPVsJWIz2mog
         E0o9/W6EVQdStIMoXqVC8qTuUUXUwcY05BtZ3/5pn5iziA/T1hZktg6POXiRa1VeaMKr
         3H1ypnIvXjCIG/v31j1a5a4ShozkqRvGzd05bQZSPqO9/3hgK+ZcLxv7WAG9nJB/mRJt
         GppA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794544765; x=1795149565;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=tFaT0DZ6F3QRjTbdaYV7CT46FZwUMHFmzpgE4p3kzPo=;
        b=TQwnxP7sfS69cddDgNeb7aTQ6lFfKk/K5xo8DLc45fDy0Aljt1eBtyunJs4XMq7cLn
         eqGZ1MgIbA2uklV/40SpQ5XdEpT86VbQlZbWzReb68r826MG5Bg5YkEU0ERyrB29vfIV
         0jlvpuhdeK9dpNslwloCqunZWyJxNHjQJRAXVfZrLnxOD38brpOcZAz4C3w/A/kaRZyk
         4cZb7yc4zPBmB2TUNc4bJxtmnqXuHejaUbZ8wnWwjqb/loQrmU03bP4TlQKbo3zA9GOR
         kLT7Z4BLBnkVTVJcgr8lb0VmMQ8wWFmjyHpfUXmEucASYwKzt67EpXmE53MQtvj0Ra1q
         YOVQ==
X-Forwarded-Encrypted: i=1; AL+hErENj9ND3/mi/bDEF94SC4NPpFQpT0pMfNbu2ykGaQZbNZw1EUiuQ6glZtjiCiBGosHuVRM4L4M=@vger.kernel.org
X-Gm-Message-State: APuU4Z9TlDW93kx9aGbEmq+9AoT09gDrWUla2SXWkDYRpq6Rc6PNB87E
	0ryLkWKyA9iTHACOfSuT8ZG5GlvR3I1iuSe5YzLIt181zqFzOTtwd+KxUXtryEzTFjB38oyRpAf
	oSi/NlPlR
X-Gm-Gg: AYBFou2iQiENm4qx+Y2yBamdfWDwWd+COW73+8lsjDTnbt4P1bYrehH0VABdraUbIYZ
	5kuh3bWpglzJ3Sk59l3DbDOYNfNGBMMUSGb4gmqFEgtJ0I3cCa0LacyGmqqLpbWd0mUi4SxkPRg
	13ikAy3W0Eq00/lwTaYfFZPVLc3uCxI3uF4EkE6pPcl3Gbo9cixCwhgPGwqJAN/axeouNZKLlWV
	D9YA8wTSj51UYHDi6G1IKD0RGbTANI9qXbQjzrNQ2j8UxRsVOnqGMkrIqoJkNpsiU5+iGYbs/O+
	Ioex6QJTIH/wkvv1uMI5ndkZVaagWZOxYSmPQoyUY83SG5jHZ5BOd0emjtHySi3Q5juMryuRgHn
	EZYx05h7bHDo4ItW67Es420ALSbCvH86EjcjjCpbENLOI6VrGu2Qjry2a+G+6Qp7uh/xCVC73Fh
	SWNZX0Qs6Z+7MEV5a6Si3xmDw3/1wPZH3YFUizToA56m66ej1bVJLQeBeR7WiDpCTFlXkZlxyyk
	Yq+/Z/hGKkdARAlfsPx/1bAPvbby01/fesjDyoI+4juT9H8im9stOaLIuBQmG2SXAxtj76C9Wt4
	bkwSYqGxVn7woJX23Tw0orWB8+FWUFoFt9a9yvupIa28Dpzg6UfhaBacL3W3JsmZkwwMsLy+
X-Received: by 2002:a05:690e:1917:b0:679:ba40:efaf with SMTP id 956f58d0204a3-67d895e5adamr679117d50.46.1794544765076;
        Thu, 12 Nov 2026 20:39:25 -0800 (PST)
Received: from cobra01.cs.unc.edu (cobra01.cs.unc.edu. [152.2.130.143])
        by smtp.gmail.com with ESMTPSA id 956f58d0204a3-67d8a64b04bsm1078108d50.23.2026.11.12.20.39.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 12 Nov 2026 20:39:24 -0800 (PST)
From: Hengyu Liang <hengyul@cs.unc.edu>
To: Konstantin Komarov <almaz.alexandrovich@paragon-software.com>
Cc: ntfs3@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: [PATCH] fs/ntfs3: do not restart readdir() when entries are added
Date: Thu, 12 Nov 2026 23:39:20 -0500
Message-ID: <20261113043920.2583254-1-hengyul@cs.unc.edu>
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

Commit dffc7f2f177b ("fs/ntfs3: allow readdir() to finish after
directory mutations without rewinddir()") made ntfs_readdir() start
again from the first entry when it reaches the end of a directory whose
version has changed. This helps programs that remove the entries while
they read them.

However, indx_insert_entry() increments the version as well. As of now,
a program that reads a directory while another program adds files to it
gets the same names again and again, and reaches the end only after a
pass during which no file was added.

The issue can be reproduced on an NTFS volume mounted on /mnt:

    mkdir /mnt/d
    for i in $(seq 3000); do echo > /mnt/d/a$i; done
    for i in $(seq 10000); do echo > /mnt/d/b$i; done &
    sleep 1
    ls /mnt/d | wc -l

Before commit dffc7f2f177b ("fs/ntfs3: allow readdir() to finish after
directory mutations without rewinddir()"), the result is:

    5489

After that commit, the result is:

    1837538

This patch will increment the version only in indx_delete_entry(), so
that added entries do not restart readdir().

Fixes: dffc7f2f177b ("fs/ntfs3: allow readdir() to finish after directory mutations without rewinddir()")
Cc: stable@vger.kernel.org # v7.0
Signed-off-by: Hengyu Liang <hengyul@cs.unc.edu>
---
The readdir() + unlink() loop of that commit keeps working: it still
empties a directory of 20000 files in one pass (298 files are left on
v6.19).

Application impact (Ubuntu 26.04 user space): "tar -cf" (GNU tar 1.35)
of a folder with 3000 files while "cp -r" adds 2000 files to it. On
v6.19, tar ends after 1.2 s and the archive has each file once. On
v7.0, tar runs for 29 s and the archive has 200434 members, each file
up to 48 times.

Tested on ntfs3 master: without this patch the archive has 261512
members; with it each file is there once.

 fs/ntfs3/dir.c     | 6 +++---
 fs/ntfs3/index.c   | 1 -
 fs/ntfs3/ntfs_fs.h | 2 +-
 3 files changed, 4 insertions(+), 5 deletions(-)

diff --git a/fs/ntfs3/dir.c b/fs/ntfs3/dir.c
index 7ee1a5d4189e..defc84693e39 100644
--- a/fs/ntfs3/dir.c
+++ b/fs/ntfs3/dir.c
@@ -476,15 +476,15 @@ static int ntfs_readdir(struct file *file, struct dir_context *ctx)
 
 	if (!pos) {
 		/*
-		 * ni->dir.version increments each directory change.
-		 * Save the initial value of ni->dir.version.
+		 * ni->dir.version increments when a delete reshapes the
+		 * name tree. Save the initial value of ni->dir.version.
 		 */
 		file->private_data = (void *)ni->dir.version;
 	}
 
 	if (pos >= eod) {
 		if (file->private_data == (void *)ni->dir.version) {
-			/* No changes since first readdir. */
+			/* No such delete since first readdir. */
 			return 0;
 		}
 
diff --git a/fs/ntfs3/index.c b/fs/ntfs3/index.c
index c06b36760448..29884bf3d35e 100644
--- a/fs/ntfs3/index.c
+++ b/fs/ntfs3/index.c
@@ -2100,7 +2100,6 @@ int indx_insert_entry(struct ntfs_index *indx, struct ntfs_inode *ni,
 					      fnd->level - 1, fnd, cmp);
 	}
 
-	indx->version += 1;
 out:
 	fnd_put(fnd_a);
 out1:
diff --git a/fs/ntfs3/ntfs_fs.h b/fs/ntfs3/ntfs_fs.h
index f400cf94d05b..12212fb7a2be 100644
--- a/fs/ntfs3/ntfs_fs.h
+++ b/fs/ntfs3/ntfs_fs.h
@@ -198,7 +198,7 @@ struct ntfs_index {
 	struct runs_tree alloc_run;
 	/* read/write access to 'bitmap_run'/'alloc_run' while ntfs_readdir */
 	struct rw_semaphore run_lock;
-	size_t version; /* increment each change */
+	size_t version; /* incremented when a delete reshapes the tree */
 
 	u8 index_bits; // log2(root->index_block_size)
 	u8 idx2vbn_bits; // log2(root->index_block_clst)

base-commit: 0c895b1f6ab37a7c72a437818f307ef6e629051c
-- 
2.53.0

