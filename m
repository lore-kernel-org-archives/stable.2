Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794049054;
	b=vvRRMChiTdFAtiZf25vYCaLMrQbYM3qlLCvVwVctxo8KBmSJ0ClNLJOZdYkZHNb1tv7C
	 s6BKP3t1LLD/aFRkjS+I0CFoav4EPHMMAtddnluS7webWpgcjWAAIYdDYaL5/332/HlSj
	 ETTPRh9kvTBegcSAp13WOw/DIvp5AnUkt07OLIMzoLxm3cbSDotviJVskLaLNpjL6/Jba
	 7CmyrRWU2d02++9fFxLr+1/A7ha1nuk4godJ+TWnNejCgNj6GCcklIW1Wk7Yso3VN7iNd
	 MKcPuYeukeMHUE5bCVUTij/xlWK6yOEgLR6d/BxCFuDXD/Hft/XMrhz6Cne+I8q2Nhw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794049054;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 MIME-Version:Content-Type:Content-Transfer-Encoding;
	bh=pTTMSe12Zo4w1SEk6CbjchZPAzgzoKsEVZsqjH1qneA=;
	b=1xrNP7qHALbqkHimpyzMf3Ewt4uttN72qgtMVMQChOL6pWVb5Y1PI8qvQQcPUvOX5TVY
	 04Or6D5s2ydhTvaPK/oOypbrahDljUOQiog73MXMY1cb6/HYnQ8ao06rIBN079v8umsdZ
	 /W2AY66v55jTjtIeXQwXEAhX0BwPuOglZ72awY5o80Zezi0/fyOwLCSH/2mq6eR9GPChB
	 KCCm5CrEQtnyH91wf+Gg9rGpkfCadJ7KYw9bZgzppe4touQQUthhL0huHJ2mOf6qdFy3k
	 shqmHlV41SFCYN9URZp5WNv8H5fUu9h90J/DVqr1QgGZ4MDPPJK4GgIc3tK+b+8WKKA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=LYsnX21X;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B6B33606A326
	for <stable@vger.kernel.org>; Sat,  7 Nov 2026 10:57:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=LYsnX21X
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E9ABC1F0089F;
	Sat,  7 Nov 2026 10:57:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794049053;
	bh=pTTMSe12Zo4w1SEk6CbjchZPAzgzoKsEVZsqjH1qneA=;
	h=From:To:Cc:Subject:Date;
	b=LYsnX21Xf5Ny33uaUiSwr9TQa5AutGAF3mP3amECAOs1tbH+uZol4kYp6BPo8/rMc
	 s3D0OqeSF93LlbS2/EBUNkEK3imfWSDeB68NUcyCfWaeg7NdI/xV8xByvqq+b83QED
	 8TboA21EBkq7qg0kJVR4AwwTEfV4chMiAeSxV/4X3qHcKoiCI7vfy4OYYuFZEBWjXl
	 +f4TRcyjT605M2QXSrUbjwVUX84yAXjN3aGDIfMivc8Imf7RUVii97w2JOjpxGktl/
	 qpCEM7s/hInxqGFdYkoh52kWoIlYLVlj+pWBawovjzcAqnNPonfCOBEO3q5ZQ4bLJy
	 RVO5nau44n54w==
From: Sasha Levin <sashal@kernel.org>
To: shionthanatos@gmail.com,
	gmwgg05@gmail.com,
	npczmd@qq.com,
	jupmouse@gmail.com,
	jack@suse.cz
Cc: stable@vger.kernel.org
Subject: FAILED: patch "[PATCH] udf: validate the device specification EA before using it" failed to apply to 5.15-stable tree
Date: Sat,  7 Nov 2026 05:57:31 -0500
Message-ID: <20261107055731-failed-5.15-9a2390959685@kernel.org>
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
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

The patch below does not apply to the 5.15-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-5.15.y
git checkout FETCH_HEAD
git cherry-pick -x 9a2390959685ac35a58c80c8016120849a2babf6
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '20261107055731-failed-5.15-9a2390959685@kernel.org' --subject-prefix 'PATCH 5.15.y' 'HEAD^..'

Thanks,
Sasha

------------------ original commit in Linus's tree ------------------

From 9a2390959685ac35a58c80c8016120849a2babf6 Mon Sep 17 00:00:00 2001
From: Yunpeng Tian <shionthanatos@gmail.com>
Date: Mon, 31 Aug 2026 17:31:16 +0200
Subject: [PATCH] udf: validate the device specification EA before using it

udf_get_extendedattr() bounds an extended attribute only against
struct genericFormat, which is 12 bytes.  A type-12 device
specification is struct deviceSpec, which is 24 bytes plus a flexible
impUse array. Thus a corrupted filesystem can contain extended attribute
that is accepted by udf_get_extendedattr() but udf_write_inode() or
udf_read_inode() may access beyond the end of provided buffer.

Provide a udf_device_spec_valid() check to validate correctness of
extended attribute that is a deviceSpec. While here, check the result of
udf_add_extendedattr() before dereferencing it as it can return NULL in
case of error.

[JK: Removed duplicated validity checks]

Reported-by: Yunpeng Tian <shionthanatos@gmail.com>
Reported-by: Gongming Wang <gmwgg05@gmail.com>
Reported-by: Mingda Zhang <npczmd@qq.com>
Reported-by: Qinrun Dai <jupmouse@gmail.com>
Cc: stable@vger.kernel.org
Signed-off-by: Yunpeng Tian <shionthanatos@gmail.com>
Signed-off-by: Jan Kara <jack@suse.cz>
---
 fs/udf/inode.c | 43 ++++++++++++++++++++++++++++++++++++++-----
 1 file changed, 38 insertions(+), 5 deletions(-)

diff --git a/fs/udf/inode.c b/fs/udf/inode.c
index e45e546a739a9..baf9845ac06b0 100644
--- a/fs/udf/inode.c
+++ b/fs/udf/inode.c
@@ -1336,6 +1336,26 @@ int udf_setsize(struct inode *inode, loff_t newsize)
 	return err;
 }
 
+/*
+ * Verify validity of struct deviceSpec on disk. udf_get_extendedattr() has
+ * already verified the generic header and made sure attribute fits in the
+ * inode so we just have to make sure attribute space is large enough for
+ * deviceSpec struct and required impUse information.
+ */
+static bool udf_device_spec_valid(struct deviceSpec *dsea)
+{
+	u32 attr_length, imp_use_length;
+
+	attr_length = le32_to_cpu(dsea->attrLength);
+	imp_use_length = le32_to_cpu(dsea->impUseLength);
+	if (attr_length < sizeof(struct deviceSpec) ||
+	    imp_use_length < sizeof(struct regid) ||
+	    imp_use_length > attr_length - sizeof(struct deviceSpec))
+		return false;
+
+	return true;
+}
+
 /*
  * Maximum length of linked list formed by ICB hierarchy. The chosen number is
  * arbitrary - just that we hopefully don't limit any real use of rewritten
@@ -1654,13 +1674,12 @@ static int udf_read_inode(struct inode *inode, bool hidden_inode)
 	if (S_ISCHR(inode->i_mode) || S_ISBLK(inode->i_mode)) {
 		struct deviceSpec *dsea =
 			(struct deviceSpec *)udf_get_extendedattr(inode, 12, 1);
-		if (dsea) {
-			init_special_inode(inode, inode->i_mode,
+
+		if (!dsea || !udf_device_spec_valid(dsea))
+			goto out;
+		init_special_inode(inode, inode->i_mode,
 				MKDEV(le32_to_cpu(dsea->majorDeviceIdent),
 				      le32_to_cpu(dsea->minorDeviceIdent)));
-			/* Developer ID ??? */
-		} else
-			goto out;
 	}
 	ret = 0;
 out:
@@ -1757,6 +1776,7 @@ int udf_write_inode(struct inode *inode, struct writeback_control *wbc)
 	struct udf_sb_info *sbi = UDF_SB(inode->i_sb);
 	unsigned char blocksize_bits = inode->i_sb->s_blocksize_bits;
 	struct udf_inode_info *iinfo = UDF_I(inode);
+	int err;
 
 	bh = sb_getblk(inode->i_sb,
 			udf_get_lb_pblock(inode->i_sb, &iinfo->i_location, 0));
@@ -1821,6 +1841,10 @@ int udf_write_inode(struct inode *inode, struct writeback_control *wbc)
 				udf_add_extendedattr(inode,
 						     sizeof(struct deviceSpec) +
 						     sizeof(struct regid), 12, 0x3);
+			if (!dsea) {
+				err = -ENOSPC;
+				goto out_unlock;
+			}
 			dsea->attrType = cpu_to_le32(12);
 			dsea->attrSubtype = 1;
 			dsea->attrLength = cpu_to_le32(
@@ -1828,6 +1852,10 @@ int udf_write_inode(struct inode *inode, struct writeback_control *wbc)
 						sizeof(struct regid));
 			dsea->impUseLength = cpu_to_le32(sizeof(struct regid));
 		}
+		if (!udf_device_spec_valid(dsea)) {
+			err = -EFSCORRUPTED;
+			goto out_unlock;
+		}
 		eid = (struct regid *)dsea->impUse;
 		memset(eid, 0, sizeof(*eid));
 		strcpy(eid->ident, UDF_ID_DEVELOPER);
@@ -1962,6 +1990,11 @@ int udf_write_inode(struct inode *inode, struct writeback_control *wbc)
 	set_inode_metadata_writeback(inode);
 
 	return 0;
+
+out_unlock:
+	unlock_buffer(bh);
+	brelse(bh);
+	return err;
 }
 
 struct inode *__udf_iget(struct super_block *sb, struct kernel_lb_addr *ino,
-- 
2.53.0




