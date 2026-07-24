Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ABC1F3859E0
	for <stable@vger.kernel.org>; Fri, 24 Jul 2026 10:49:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784890144; cv=none; b=CR03xE/1FJdmGJ+dk5jS+POG56Oto0Ac98MtypKFJBw8NVAK89u9QBoWt1wi8OG/4lyyCCUnvuBEBq35IggMPh6m1N8gOp6JGXA4qQlHrYzU3L9yaE3PsrPAKz4yJEGGbOVxJBNB06sPhg33lFQ7t8SVXuQwDWTbVFzgoksOAhk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784890144; c=relaxed/simple;
	bh=ZcTmnWZkjzouPPUmxIzVqA6DvR0+PhOIIi+dulFgcos=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ulJ1+Dn1Nk8t6YYANptvDlx9iCq6zS2XhYF3b5clLytV6JsTQzYRVLOYraJ8Et+UQBeIg1HO9rMiCz3zE74lHf4jPKxAlugZHdaB2qr6DP3yrU92PlDa6DEazp5Rfcq2cu0LelT1gZCfkc8K9wuXqJust98fFxXPPeBHdAEoPDM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Xco/fiGH; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Xco/fiGH"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CFE011F000E9;
	Fri, 24 Jul 2026 10:49:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784890143;
	bh=RGFXvO7PQw4N19YRWZNKw3+uuVueOBO+R3IiFQTBb+U=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=Xco/fiGHH0Qs/5b6Rv5I9qRmniX7NhwQu59AZ0dR13o/Sppm021yORe/CUq2mAffV
	 rpeWGnd27GWuuFkf/w39DsXNbAEHDC2tdNTAX+IAiR4hrNP3q38h7wCnKRgw81DsSx
	 ZRI0USUFX9w4rwbZYy6l81Cd7/33+sA0oriQ6cPfljYum0eNJzDkHZ/IfHBzRz4bn9
	 /fpnOmuL+/bs7SV4RS4NgRybE70QnYzodfdvnZ+39fzHvGZ8WzValrv70gb1F3Xf5r
	 8qB5AZrxQmOK3fvkY5UGBbJMfiLB0ACNfoiAHNo2AgdJ5VdVS7jl6OGdnzVXAcURiI
	 E+KoNKMFp0/KQ==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Pavel Skripkin <paskripkin@gmail.com>,
	Konstantin Komarov <almaz.alexandrovich@paragon-software.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.15.y 1/4] fs/ntfs3: Make ntfs_update_mftmirr return void
Date: Fri, 24 Jul 2026 06:48:57 -0400
Message-ID: <20260724104900.3973962-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026072042-litter-retold-6915@gregkh>
References: <2026072042-litter-retold-6915@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Pavel Skripkin <paskripkin@gmail.com>

[ Upstream commit e66af07ca2b57e01dbf6001ae565ab40037b2df3 ]

None of callers check the return value of ntfs_update_mftmirr(), so make
it return void to make code simpler.

Signed-off-by: Pavel Skripkin <paskripkin@gmail.com>
Signed-off-by: Konstantin Komarov <almaz.alexandrovich@paragon-software.com>
Stable-dep-of: 5e7b598660cf ("fs/ntfs3: bound copy_lcns dp->page_lcns[] index in analysis pass")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 fs/ntfs3/fsntfs.c  | 20 +++++++-------------
 fs/ntfs3/ntfs_fs.h |  2 +-
 2 files changed, 8 insertions(+), 14 deletions(-)

diff --git a/fs/ntfs3/fsntfs.c b/fs/ntfs3/fsntfs.c
index 566dd9083b8ff4..ab9c75e092c299 100644
--- a/fs/ntfs3/fsntfs.c
+++ b/fs/ntfs3/fsntfs.c
@@ -830,7 +830,7 @@ int ntfs_refresh_zone(struct ntfs_sb_info *sbi)
 /*
  * ntfs_update_mftmirr - Update $MFTMirr data.
  */
-int ntfs_update_mftmirr(struct ntfs_sb_info *sbi, int wait)
+void ntfs_update_mftmirr(struct ntfs_sb_info *sbi, int wait)
 {
 	int err;
 	struct super_block *sb = sbi->sb;
@@ -839,12 +839,12 @@ int ntfs_update_mftmirr(struct ntfs_sb_info *sbi, int wait)
 	u32 bytes;
 
 	if (!sb)
-		return -EINVAL;
+		return;
 
 	blocksize = sb->s_blocksize;
 
 	if (!(sbi->flags & NTFS_FLAGS_MFTMIRR))
-		return 0;
+		return;
 
 	err = 0;
 	bytes = sbi->mft.recs_mirr << sbi->record_bits;
@@ -855,16 +855,13 @@ int ntfs_update_mftmirr(struct ntfs_sb_info *sbi, int wait)
 		struct buffer_head *bh1, *bh2;
 
 		bh1 = sb_bread(sb, block1++);
-		if (!bh1) {
-			err = -EIO;
-			goto out;
-		}
+		if (!bh1)
+			return;
 
 		bh2 = sb_getblk(sb, block2++);
 		if (!bh2) {
 			put_bh(bh1);
-			err = -EIO;
-			goto out;
+			return;
 		}
 
 		if (buffer_locked(bh2))
@@ -884,13 +881,10 @@ int ntfs_update_mftmirr(struct ntfs_sb_info *sbi, int wait)
 
 		put_bh(bh2);
 		if (err)
-			goto out;
+			return;
 	}
 
 	sbi->flags &= ~NTFS_FLAGS_MFTMIRR;
-
-out:
-	return err;
 }
 
 /*
diff --git a/fs/ntfs3/ntfs_fs.h b/fs/ntfs3/ntfs_fs.h
index d93cba03a65aae..a03dce278221e8 100644
--- a/fs/ntfs3/ntfs_fs.h
+++ b/fs/ntfs3/ntfs_fs.h
@@ -599,7 +599,7 @@ int ntfs_look_free_mft(struct ntfs_sb_info *sbi, CLST *rno, bool mft,
 void ntfs_mark_rec_free(struct ntfs_sb_info *sbi, CLST rno, bool is_mft);
 int ntfs_clear_mft_tail(struct ntfs_sb_info *sbi, size_t from, size_t to);
 int ntfs_refresh_zone(struct ntfs_sb_info *sbi);
-int ntfs_update_mftmirr(struct ntfs_sb_info *sbi, int wait);
+void ntfs_update_mftmirr(struct ntfs_sb_info *sbi, int wait);
 enum NTFS_DIRTY_FLAGS {
 	NTFS_DIRTY_CLEAR = 0,
 	NTFS_DIRTY_DIRTY = 1,
-- 
2.53.0

