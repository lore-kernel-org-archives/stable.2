Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.215.181
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792979778;
	b=S2+6C218KwEPAAgix8DLi2eC8zZ8u5yoO1n+ZIa9ILnmigXnITkr/TlBSBUzSYg0qgXE
	 udr2UK2WLjubDVHdxePR+soFtZmsQldeGOvMig/XuGZ0WfGdMss7XaJfaWjTwTzUdwLZk
	 JeHNy9cVzGp5qzSGX0eFHq2CktMbShHA4sEljszg6keRmL5Pf8tfmHjr0Hm5pSZqo02/R
	 X69CuNDVfvd0nBeV9YGx9i5+qgKhf5AzuTWyE6s8JFLUomAs91RMRwgDUGPHtfUpEmhFS
	 RDPEzHvh3Rz4VJCFMW8lzd3CcxxIqcqHLakc6mt583iI0DZ54USYra8aSk/qEJMJHcg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792979778;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=2zkx3GxJ07XxsBtFlQsE6mExven9HQFX53pHIZRuedQ=;
	b=idWKdKQZjezXtdV0Jwi6sUe8nTDx0TfZ2fwsz2Sky7CUBngBcDEAqDc6p+qxOkDYcxCE
	 2xiMJUwG0zrYE2U87H4fn+HLkLmJOxJPemGsMqPrgNic+tcCQ3Nk2QfRGhYkTj/KnTkcC
	 Q0BXLzdZ5NZFq8oRSMnxZHY3YH9W4JU+GYiPYY7EoQnGmBuyHL8nhfD3o7LRYS2o4xjpX
	 tRKBnE6OPKvsvzzN4VCMYz3tuePMFXVkwBErBMTpF6rWsTWYV/tPmCP9Vi3Yy8SE4BV/2
	 fMYCit7MHrVbnUUM4QDLx0aKKbdsD1pqrSptgYzoWNBPFX14gezVYgGC1ONG0cXUKLg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=n02fUw+r;
	arc=none smtp.remote-ip=209.85.215.181
Received: from mail-pg1-f181.google.com (mail-pg1-f181.google.com [209.85.215.181])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 432B2606A31A
	for <stable@vger.kernel.org>; Mon, 26 Oct 2026 01:56:18 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 432B2606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=n02fUw+r
Received: by mail-pg1-f181.google.com with SMTP id 41be03b00d2f7-ccce6d9abfeso1576116a12.1
        for <stable@vger.kernel.org>; Sun, 25 Oct 2026 18:56:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792979778; x=1793584578; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=2zkx3GxJ07XxsBtFlQsE6mExven9HQFX53pHIZRuedQ=;
        b=n02fUw+rKW+iPKFVoi0rsVspUtENJ8TauLVFM0xx/FV1FPjGA/70QdT0M9+zxswJ0O
         AKthvmXDwj91DYDP3Gk2k0saqbbs6VWqG4jGxzQWOpj70a15Kqrh+q1CVZ3dydg/iedz
         8iDodIKim3hj1BOrjZW9CDaC3WPcEqmpOlU/X0Y+xVybikvDlKyuhmWZMSjLALVQCaeb
         IAD3O+SKMDMEcejHjFJnu0GQFW5gI8AlrkekOsTeWsHOLx9DEKPogfLQcghYJG1Q4IFP
         KWozzjAJHeq2S3M5K09ulJ3GymZOraxn1PighALcFIz/r4IGS2QU3kFdNZoCsl5+IYmK
         p1ew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792979778; x=1793584578;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=2zkx3GxJ07XxsBtFlQsE6mExven9HQFX53pHIZRuedQ=;
        b=S5Ps/ezxZfxspzmlLdTuHbZVEmVYjBE/ff6pbexJ/ocm97FHHi8rf7wwTmMmd2ROkr
         Yq9fM4FFf7wWwZ7j9s8pR4BNpTkg0p4xG1gmjfROY1+ItbsUTR4C4pvUuHBqs8Ni1AzX
         8iODh7CW7bv2exruyxzuokcWjQjsH5L8uJfrrkZzqFI42Wd7R077kyLiMx1Lva6dc04l
         i8Y/N8k7k5IYplCyOL0rPbwzUw+lKggDr+t2inIR3PGgKb4NZiU5p1CpUSnMZLo0eHL0
         1TrxoF+BReKJ0Dn0J7j1d1mG/jEhkcOrAtwt8iJmhhos7VXceUeow4q3wctGhdWm9Tx6
         Mslg==
X-Gm-Message-State: AFq9FYI0ynAa0PuQ9XlCSZ/docHdwKkH9b5gwSF8pCPf6Nxx6dd4pCtj
	4Ww8PjUGegmCwp4ACU5Ku8q1LZFdpl8qmpFtTfWvTa8ZVlYzCL2X7IZW5cpDyQ==
X-Gm-Gg: AYBFou2TIFgeLHg3XvtVFHjpNidob1diEORr0aqiNpMKjjkTNC+lpOU8A/Ueh+v4OyL
	JtPuMJKZg/dMQ3Kq1KqcE/OGGTN4UZBmr73OcNsJuxQxAoJydmXPf+vHZ2IeLkI1ZYNjy8VmUnh
	B5YQLK99G+EeEF+GROD10ki7ABi2PastCrK99HwnMY5fTKzhrU5A1Zn9rn1PjUb7gwgN6nQHHPM
	p4jmim/nGhFFbXQaSfwgvScS6UNt18AUSio0qRnX9DQjE9/amiJFC2FtcOACV3pRTXGahOCqZ0G
	QbT2TQoZe25/qTMReyXy/j0sN2L5/ZbwbLQBRe2Jb0lOXsr1+/qGrV/vPQ5RIgQbgsvXILA/1q4
	z9EdVBTznsK00RpIt8xStS3bp7SGyamzknPHVoj7KmwEbTgk4JG2JvbLMYMvE8FkXim7u1y2toi
	vmzHR6oDzneCECFg+5+1HRprbBiSAVZ5Cafwwi2r1dJYy9TrawPJ/ZMV8a50aWHVKvdT/ASGP3c
	8PP3nhyZJzaKwFYTiBAZ6VlxTrb7G/uDXByumZVtxxv/zM6kI5ezmZ1Uyv3MA==
X-Received: by 2002:a17:90b:58e8:b0:3ac:3e42:60a2 with SMTP id 98e67ed59e1d1-3adead5ca8emr4626405a91.33.1792979777581;
        Sun, 25 Oct 2026 18:56:17 -0700 (PDT)
Received: from hyunchul-PC02.lge.net ([27.122.242.71])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3adeb8240b5sm5115612a91.0.2026.10.25.18.56.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 25 Oct 2026 18:56:16 -0700 (PDT)
From: Hyunchul Lee <hyc.lee@gmail.com>
To: stable@vger.kernel.org
Cc: gregkh@linuxfoundation.org,
	hyc.lee@gmail.com,
	linkinjeon@kernel.org,
	liubaolin@kylinos.cn,
	zenghongling@kylinos.cn,
	ntfs@lists.linux.dev
Subject: [PATCH 7.2.y 1/2] ntfs: fix race between fallocate and mmap reads
Date: Mon, 26 Oct 2026 10:55:32 +0900
Message-ID: <20261026015533.1124816-1-hyc.lee@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <2026102240-impending-elusive-74a7@gregkh>
References: <2026102240-impending-elusive-74a7@gregkh>
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

[ Upstream commit 67aded1da114dc44808315f249bd9e7e440f799d ]

The fallocate implementation only takes invalidate_lock for punch hole,
collapse range, and insert range operations. For standard allocation modes
(mode == 0, FALLOC_FL_KEEP_SIZE), the lock is not held.

During ntfs_attr_fallocate(), new clusters are mapped to the runlist via
ntfs_attr_map_cluster() before being zeroed by ntfs_dio_zero_range(). This
creates a window where concurrent mmap page faults can read uninitialized
disk data.

Since mmap uses filemap_fault() which takes invalidate_lock in shared mode,
it can fault in pages during this window and expose old disk contents to
userspace. This is an information leak and data integrity issue.

Fix by taking invalidate_lock for all fallocate operations, not just for
punch/collapse/insert modes. This prevents concurrent page faults from
accessing unzeroed clusters during the allocation window.

Fixes: 495e90fa3348 ("ntfs: update attrib operations")
Cc: stable@vger.kernel.org
Reviewed-by: Baolin Liu <liubaolin@kylinos.cn>
Reviewed-by: Hyunchul Lee <hyc.lee@gmail.com>
Signed-off-by: Hongling Zeng <zenghongling@kylinos.cn>
Signed-off-by: Namjae Jeon <linkinjeon@kernel.org>
Stable-dep-of: 0fecc393f206 ("ntfs: take invalidate_lock in ntfs_filemap_page_mkwrite")
Signed-off-by: Hyunchul Lee <hyc.lee@gmail.com>
---
 fs/ntfs/file.c | 14 ++++----------
 1 file changed, 4 insertions(+), 10 deletions(-)

diff --git a/fs/ntfs/file.c b/fs/ntfs/file.c
index fb8e52574397..317bb249150f 100644
--- a/fs/ntfs/file.c
+++ b/fs/ntfs/file.c
@@ -1061,7 +1061,6 @@ static long ntfs_fallocate(struct file *file, int mode, loff_t offset, loff_t le
 	struct ntfs_volume *vol = ni->vol;
 	int err = 0;
 	loff_t old_size;
-	bool map_locked = false;
 
 	if (mode & ~(NTFS_FALLOC_FL_SUPPORTED))
 		return -EOPNOTSUPP;
@@ -1090,16 +1089,12 @@ static long ntfs_fallocate(struct file *file, int mode, loff_t offset, loff_t le
 
 	inode_lock(vi);
 	if (NInoCompressed(ni) || NInoEncrypted(ni)) {
-		err = -EOPNOTSUPP;
-		goto out;
+		inode_unlock(vi);
+		return -EOPNOTSUPP;
 	}
 
 	inode_dio_wait(vi);
-	if (mode & (FALLOC_FL_PUNCH_HOLE | FALLOC_FL_COLLAPSE_RANGE |
-		    FALLOC_FL_INSERT_RANGE)) {
-		filemap_invalidate_lock(vi->i_mapping);
-		map_locked = true;
-	}
+	filemap_invalidate_lock(vi->i_mapping);
 
 	switch (mode & FALLOC_FL_MODE_MASK) {
 	case FALLOC_FL_ALLOCATE_RANGE:
@@ -1124,8 +1119,7 @@ static long ntfs_fallocate(struct file *file, int mode, loff_t offset, loff_t le
 
 	err = file_modified(file);
 out:
-	if (map_locked)
-		filemap_invalidate_unlock(vi->i_mapping);
+	filemap_invalidate_unlock(vi->i_mapping);
 	if (!err) {
 		if (mode == 0 && NInoNonResident(ni) &&
 		    offset > old_size) {
-- 
2.43.0

