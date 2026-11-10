Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794311356;
	b=WpbuG9Wni4VRmGWY+gq06L4WTB6UlkxJZI2HfbBpBkeB44KOy6mDIj5DSOB64BrE9ycw
	 YQQVEQy9GRqXF3yngq4YVPplJWpyUd1hN2lc2h/k+UyGyPPELkyJMTu5nXZUuWf22ZOm6
	 j3+sOYjjbe9w7y/Vv/SdPA8WomuIRbMk5s1YlCAx4TxRqWrNNapJkOM+LX0OKBgCMWgRH
	 FKh6dba56VkJCTiTl744zVKlcK5IVvaz36Ze2Yr5l+elsenL2AkE61q+BifTZ30ygCYXF
	 MdlZL5szt/9/DK4KgPG2BV4njWadeI3JRefbDGttfrYbBoxSGjsfVyWvHzDI/4LObDQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794311356;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=r8N0OWiyKAatgIhZ4pD7zbJ+IVTIbjv3CTH0tirxUno=;
	b=4eHV9rCJtMQJzJAwcqI9ukqYwFbtZelA799NiGJT5mx6TGxGIR/LZzPD/UJWa710nF0E
	 hicNXEpXUFEgq7Rrm2KKOtCmIpr4HYP7dNX+jO+iUG5rNY/cxjERP6BLyc+xST9WmLvvW
	 XqOlPHMB1IfjIJ8nkh221ySg2LgVri+PTZhZlTZSo7RtabHZMSxJFgy91mK89ZvjaAwLN
	 SeSlEMEZEFVwH04AReF/znqpCPNUE9RGxBLmj6NVe7P49+4hFzR0e0OI5+BhZRtpSX1xc
	 mT9Zva7W5hC6yyE0cvGV2SbsPjQEYMpoRtRIqIl8P36b8mf1lp85cqu32MCd8Pqs3oQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=LDLsqDkc;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BBE74606A321
	for <stable@vger.kernel.org>; Tue, 10 Nov 2026 11:49:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=LDLsqDkc
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7235A1F0089F;
	Tue, 10 Nov 2026 11:49:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794311355;
	bh=r8N0OWiyKAatgIhZ4pD7zbJ+IVTIbjv3CTH0tirxUno=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=LDLsqDkcpCXCg+bL+A+iyvv1jdnDqdpcENVfgIZllIRdjoFp5irQdzRYG6B57JprW
	 nALfLbC27au8lk6gXUw7mBcweMPlOxU6DE1FuxmdhEpREJ4oztaa9+J0uJp4kTaZhu
	 SMbV872/800VGhpV1xiiVet8Kjt7Md0ZATWjSA7mLDMA5el8V5syAgNpET/ezY9wdv
	 IEpT+ogFfJC3hDcs9Lianrl60snqzYF+Z3pnszfKRat3mTztSNihmqc1L1Uj4GS86/
	 rHDpVG8VE04qF/+NHLLcHgPrlrE8HuTdBmevjM5RxMEWXji1SeyqR0u4S/BgyCdAWd
	 EUy52yv7zZ+MA==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Yunpeng Tian <shionthanatos@gmail.com>,
	Gongming Wang <gmwgg05@gmail.com>,
	Mingda Zhang <npczmd@qq.com>,
	Qinrun Dai <jupmouse@gmail.com>,
	Jan Kara <jack@suse.cz>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.18.y] udf: validate the device specification EA before using it
Date: Tue, 10 Nov 2026 06:49:13 -0500
Message-ID: <20261110114858.624535-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261107050612-failed-6.18-9a2390959685@kernel.org>
References: <20261107050612-failed-6.18-9a2390959685@kernel.org>
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

From: Yunpeng Tian <shionthanatos@gmail.com>

[ Upstream commit 9a2390959685ac35a58c80c8016120849a2babf6 ]

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
[ sashal: adapted udf_write_inode() changes to udf_update_inode() while preserving its existing err variable and synchronous writeback error handling ]
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 fs/udf/inode.c | 42 +++++++++++++++++++++++++++++++++++++-----
 1 file changed, 37 insertions(+), 5 deletions(-)

diff --git a/fs/udf/inode.c b/fs/udf/inode.c
index d00b78523a967..a9538a0f9734b 100644
--- a/fs/udf/inode.c
+++ b/fs/udf/inode.c
@@ -1346,6 +1346,26 @@ int udf_setsize(struct inode *inode, loff_t newsize)
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
@@ -1664,13 +1684,12 @@ static int udf_read_inode(struct inode *inode, bool hidden_inode)
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
@@ -1818,6 +1837,10 @@ static int udf_update_inode(struct inode *inode, int do_sync)
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
@@ -1825,6 +1848,10 @@ static int udf_update_inode(struct inode *inode, int do_sync)
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
@@ -1966,6 +1993,11 @@ static int udf_update_inode(struct inode *inode, int do_sync)
 	brelse(bh);
 
 	return err;
+
+out_unlock:
+	unlock_buffer(bh);
+	brelse(bh);
+	return err;
 }
 
 struct inode *__udf_iget(struct super_block *sb, struct kernel_lb_addr *ino,
-- 
2.53.0

