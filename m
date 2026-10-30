Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1793318963;
	b=y+CHt2mlNE7O4SImRURLOi8TRzOPuP24X4De7RjZA0uFFm7gaWqYK/mHMwEOw5PmxCRv
	 rpYpw++DcmqlpRuV/FhcH3JM/bXt9KVeA5NqGxPWv0ZP2r6gxHONTywHN/x64/ueHcrZA
	 wpBrkcMU6AOc8AXTxhNbyCkTijEAyefBfGCuqBfeZKNLyyUr4BEDzcLuk9YNp+FEc5oAo
	 PfR175G2cHW3PfZ19Lw1kc39vrn7Q8P60d8Fdh7ArsF/BLpWx/hjnUDNHjy1X7MQgFoSz
	 5NAappeSOtsA946HGk6gJddDLzo8fcuUVsHoaTyVelK+8+mmx3QsRpjfhP7onAtcZlg==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793318963;
	h=Received:DKIM-Signature:Received:From:Date:Subject:MIME-Version:
	 Content-Type:Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
	 X-Original-From:Reply-To:Content-Transfer-Encoding;
	bh=Vz3cXPU2dcLyyq19V6hD7X3ilxJKofbkfkp/hjH6SGs=;
	b=jBrEtA494E3KKm8PQCNOzwVnhcwFQK9CdK6Bq2aIulv6/6P0eqqzOaePeMdJ86NH4FZD
	 WbGhcwm9XiPpmg1WSStBfj60BJEd0OSx6WolqaGJ8a9A1rbyIBmUQI07xQHvu3f16SdZv
	 dlVnBdbeaOKiYj1+s25eTL+rQq95pKVpjDQP3HUzMZOAb4MA24pO5F92+I4EyCjWSQluR
	 HxSLBRYsXRlXR3RnIFPBjUvtZGDr2fxinxTm5LvtUP32uo6fOhszcpimz2GihdGiPaJre
	 407U/bsEaskdnIDgo5Y8fDBIZoNcKEDI7BiDO+MGiu/b1RxMbEhwZUmZBZ8plo5dbxQ==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=A8CO12o3;
	arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C95C3606A325;
	Fri, 30 Oct 2026 00:09:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=A8CO12o3
Authentication-Results: smtp.kernel.org; arc=none smtp.remote-ip=100.80.115.77
ARC-Seal: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256; cv=none;
	t=1793318962;
	b=Kgb0a6GSWzlO6xHK7YedjW7AAT7YttcmcF1Cj8dmi9Lh2dSMvqT4xhm9JuRusWm2zc4Z
	 yxIhP9hjopaBx7cHyMWW1QAEye0EYi7QqJ+C+BPh8P13ANW2eybQJ5omkwNelbtYNLW//
	 aQvoMav2CXwKuSZk3O/1NzyPnOCQ0uGYtrzlgTwYu7cf3zB1fkiu8VsBNYCo5F68u44Bu
	 DiiufwUpNSkzpnbBJhblHiYTppQIy+xWO+HiuX9NnRLQdedZ6N1YGu+l+p4pxBYzRasoe
	 HJXJQmJ5p1lROH1GXOqtnEB3F8Q305aBUtSUA0vTY1Rco/zOX2PRQJir7oUkJP51MQQ==
ARC-Message-Signature: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256;
	c=relaxed/relaxed; t=1793318962;
	h=DKIM-Signature:Received:From:Date:Subject:MIME-Version:Content-Type:
	 Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
	 X-Original-From:Reply-To:Content-Transfer-Encoding;
	bh=Vz3cXPU2dcLyyq19V6hD7X3ilxJKofbkfkp/hjH6SGs=;
	b=qHZvL9BYG5ny3doLZoG3n9xAw0PVQfg4edRVYoVSjj40I6QtcuJ1lmfMjekLUqL+vlgN
	 TmsU5Qqb8nOm3n1K6PTGdO/7vz2AJmGzQwLUjnVYZD0UQ1ciujN4ek6zfKTKdxK2PSrai
	 zWd6Mhrcgk5sC1L6E0EPR6umr5QTVxKPod+cHlEqy995aPkfsKJTQPOKjRCvsHqLbQcEL
	 0VmHYJEuopvQVW98fjs2HJ+qWtYYJx8CxEXRq6ZyDcX1LsFRNHJ3LbKo4X9LUvEA7dgjU
	 9gYvzqt/SvUzOmSRZieeOOz8TQzR6vSCaF7KTdhCJ6qzA/rilaz250GCWur6EIeDWVw==
ARC-Authentication-Results: i=1; smtp.kernel.org; 
	arc=none smtp.remote-ip=100.80.115.77
Received: from lkml.kernel.org (nexus.subspace.kernel.org [100.80.115.77])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.kernel.org (Postfix) with ESMTPS id 040B91F00A16;
	Fri, 30 Oct 2026 00:09:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793318962;
	bh=Vz3cXPU2dcLyyq19V6hD7X3ilxJKofbkfkp/hjH6SGs=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To;
	b=A8CO12o3UHuFzta1BpyKcYcvf+H9RqGP6qNIvF9Xf6r2eWkPtDdCcgP3Cid23X59E
	 NDjH3u5pXzhB8chBz5jZ8HZhoesjwEXH2ku00n9EMQcIahAj1qDAchB2F714DD8u1y
	 f42AvuFIZVAF1VZFycjOHBwhlUWQ7WWkrwwOZDP1ZNJE24fvEci4w8q5MrwM0Y5OO0
	 lmAIx6pgcT9//snt2KworRxH2iaIPqINTeRi26MXDJnX6UhQ4skx0YEmJdBMq9SJwR
	 4n6H60/eXluflvRjKd+YlrcfNkyTafmvG9SI3FT9g8lKWtXddWFbDxVVKYVcST3y6T
	 YA2ODTzLdaHVA==
Received: from nexus.subspace.kernel.org (localhost [IPv6:::1])
	by lkml.kernel.org (Postfix) with ESMTP id A0FEA409F0;
	Fri, 30 Oct 2026 00:09:20 +0000 (UTC)
From: Kamil Chojnowski via B4 Relay <devnull+contact.diath.net@kernel.org>
Date: Fri, 30 Oct 2026 01:08:14 +0100
Subject: [PATCH 5/6] fs/ntfs3: walk $FILE_NAME under ni_lock in
 ni_write_parents()
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
Message-Id: <20261030-ntfs3-resident-fixes-v1-5-7b6c857d4330@diath.net>
References: <20261030-ntfs3-resident-fixes-v1-0-7b6c857d4330@diath.net>
In-Reply-To: <20261030-ntfs3-resident-fixes-v1-0-7b6c857d4330@diath.net>
To: Konstantin Komarov <almaz.alexandrovich@paragon-software.com>
Cc: Christoph Hellwig <hch@lst.de>, ntfs3@lists.linux.dev, 
 linux-kernel@vger.kernel.org, stable@vger.kernel.org, 
 Kamil Chojnowski <contact@diath.net>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1793318890; l=3518;
 i=contact@diath.net; s=20261029; h=from:subject:message-id;
 bh=lildrmFmBPH9lTof/r12lMuwCz1/p9WenioNxFMoXLI=;
 b=ISLiw7n9wBInWM79VBnl/LyNwJ7gzQ/do53aWq2C06u3osegHCvFkK1t08cPnVK/q31FUIWfT
 1QiExGkdfS4DoBKgASgOIdFl4OA7G8DE98r8mBOGejyZWMVfj7LiczK
X-Developer-Key: i=contact@diath.net; a=ed25519;
 pk=G15RQXroUn6f8ud+bOEqlqpPdpLoCB3L3G9XVUf+YaA=
X-Endpoint-Received: by B4 Relay for contact@diath.net/20261029 with
 auth_id=1360
X-Original-From: Kamil Chojnowski <contact@diath.net>
Reply-To: contact@diath.net
Content-Transfer-Encoding: 7bit

From: Kamil Chojnowski <contact@diath.net>

ni_write_parents() (fsync) walks the inode's attributes without ni_lock.
When the record is rearranged at the same time - a name removed by
unlink, $DATA moved out of the record by a write through another file
descriptor - it can read a half-moved attribute.  It then either follows
a garbage parent reference:

  ntfs3(vda): MFT: r=0, expect seq=0 instead of 1!
  ntfs3(vda): ino=1e6, failed to open parent directory r=0 to write

or mi_enum_attr() sees an inconsistent record and marks a healthy inode
bad and the volume dirty, after which every operation on the file fails
with -EINVAL:

  ntfs3(vda): ino=100, "res2" mi_enum_attr

Collect the parent references under ni_lock and open and write the
parents after dropping it.

Reproducer: overwrite a small file through a shared mmap, grow it past
the MFT record with pwrite(2) and fsync(2) it, while another thread
calls fdatasync(2) on it in a loop.

Fixes: dcd9d6a47199 ("fs/ntfs3: fsync files by syncing parent inodes")
Cc: stable@vger.kernel.org
Assisted-by: Claude:claude-opus-5-5
Signed-off-by: Kamil Chojnowski <contact@diath.net>
---
 fs/ntfs3/frecord.c | 42 +++++++++++++++++++++++++++++++++++-------
 1 file changed, 35 insertions(+), 7 deletions(-)

diff --git a/fs/ntfs3/frecord.c b/fs/ntfs3/frecord.c
index 3d10b1519c86..a121ca4db0c0 100644
--- a/fs/ntfs3/frecord.c
+++ b/fs/ntfs3/frecord.c
@@ -2997,13 +2997,33 @@ int ni_write_parents(struct ntfs_inode *ni, int sync)
 	struct ATTR_LIST_ENTRY *le = NULL;
 	struct ntfs_sb_info *sbi = ni->mi.sbi;
 	struct super_block *sb = sbi->sb;
+	struct MFT_REF *homes;
+	u32 i, n = 0, cnt = 0;
 
 	if (!is_ni_base(ni))
 		return 0;
 
+	/*
+	 * Collect the parent references under ni_lock: the record may be
+	 * rearranged at the same time (a name removed, $DATA moved out of the
+	 * record), and mi_enum_attr() marks the inode bad if it walks a
+	 * half-moved attribute.  Open and write the parents without ni_lock.
+	 */
+	ni_lock(ni);
 	while ((attr = ni_find_attr(ni, attr, &le, ATTR_NAME, NULL, 0, NULL,
-				    NULL))) {
-		struct inode *dir;
+				    NULL)))
+		cnt++;
+
+	homes = kmalloc_objs(*homes, cnt, GFP_NOFS);
+	if (cnt && !homes) {
+		ni_unlock(ni);
+		return -ENOMEM;
+	}
+
+	attr = NULL;
+	le = NULL;
+	while (n < cnt && (attr = ni_find_attr(ni, attr, &le, ATTR_NAME, NULL,
+					       0, NULL, NULL))) {
 		struct ATTR_FILE_NAME *fname;
 
 		fname = resident_data_ex(attr, SIZEOF_ATTRIBUTE_FILENAME);
@@ -3012,19 +3032,26 @@ int ni_write_parents(struct ntfs_inode *ni, int sync)
 
 		/* Check simple case when parent inode equals current inode. */
 		if (ino_get(&fname->home) == ni->vfs_inode.i_ino) {
-			if (MFT_REC_ROOT != ni->vfs_inode.i_ino) {
-				ntfs_set_state(sbi, NTFS_DIRTY_ERROR);
+			if (ni->vfs_inode.i_ino != MFT_REC_ROOT)
 				err = -EINVAL;
-			}
 			continue;
 		}
 
-		dir = ntfs_iget5(sb, &fname->home, NULL);
+		homes[n++] = fname->home;
+	}
+	ni_unlock(ni);
+
+	if (err)
+		ntfs_set_state(sbi, NTFS_DIRTY_ERROR);
+
+	for (i = 0; i < n; i++) {
+		struct inode *dir = ntfs_iget5(sb, &homes[i], NULL);
+
 		if (IS_ERR(dir)) {
 			ntfs_inode_warn(
 				&ni->vfs_inode,
 				"failed to open parent directory r=%llx to write",
-				(u64)ino_get(&fname->home));
+				(u64)ino_get(&homes[i]));
 			continue;
 		}
 
@@ -3035,6 +3062,7 @@ int ni_write_parents(struct ntfs_inode *ni, int sync)
 		}
 		iput(dir);
 	}
+	kfree(homes);
 
 	return err;
 }

-- 
2.56.0


