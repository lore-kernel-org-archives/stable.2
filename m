Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794319724;
	b=sTpJPw3XxWf3jdgFySYzJ2gUomdCB1Arzzd5z/YXuQDrhg20WzFAxsnGuJfA+wXhsBPF
	 FzU6Ol1P8yUgLYd6D6H/YahDxK2D5J7EEKgn92uUgaTXM62DKDZEJKVYIYLdiwCmzQjP6
	 IJVRiWbm647rHiaPr6+1YnPmrMCg5VRz9IN9Ge8S2PEY17M58gZ4VAmhpTzYOC67Osz1G
	 ualJds2sj22S52bcl0phyw/jY7KEKxtBBAs3C6hGLKKne+Y/btEblnSZqAuwTg/kKkfMx
	 Rw4sSc0Zi90gL2sXNKKi/W+aP9XfTJyO+0pMzM/N8h2N2tKxMR8E9sBIDj4Z4lgsMvA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794319724;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=LwC3ii33dsVPV4F1dBtmmbNDts8lCKrhAODAdleeMXI=;
	b=tRzyvbhw+zsv6QpJqfXSnkcVgo9iFxI6cixL4oAjgk1xP7G8u8MUJX94PR9DmEukVhxp
	 NpnB2Uu8dLtNCHYGHQ3eKwMadk6r/ylAyW6yYWIQefGk3sz7ib7TDa0JZzQ3s3HGv8WdK
	 VreO/uq617Zjv0tlH2xzzNb4lQ/hjY1IEUa80v3t05sahhj9E4PEHeofBtKjtQ8kByXNN
	 uFZflXpvyxNZ/zEI2vRhC62iAIUMoOZNnN2xJ8Yg23Zgy0yocrgxR73KQgHyFGZqgl1pi
	 e/8dfzmUlSJohCrJynNI0rTpNCkgbbG0sHqLRQ2M8CiCyXZLg8vNwm862gUygwc6PHw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=hzoxUH6P;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1ACBB606A338
	for <stable@vger.kernel.org>; Tue, 10 Nov 2026 14:08:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=hzoxUH6P
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 10D521F008A1;
	Tue, 10 Nov 2026 14:08:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794319723;
	bh=LwC3ii33dsVPV4F1dBtmmbNDts8lCKrhAODAdleeMXI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=hzoxUH6PEGAX3gDtblYHxgn+lnXOZu7pVyGBp0fTp4goIJAauNQBCyBacPIpOzvXG
	 gBNpwdY/v0Rj4pbsFF1UFwnN4RludvIGzsQGOrdV8J35daEQjewLRDzR2r4MeF3zAL
	 xwtUuAAzBARPF+8pV3L0yM4PWeFBwVIawONQBdBtaKSAy0TFR50whuASm2kOFmbmw4
	 FtQREg2cJkRoe5kQR5AaV7FeMFM2emHfZXoPxEfQT90KPoLP4ge5PSCl2wsnVwOpSJ
	 AQazoilQuiSFuofJnBIh4icd66vid0jdouIhOf3T70PDavnk1ZRWUFFJql/iEtJl6W
	 U4/OcnEZ6qWgA==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Yunpeng Tian <shionthanatos@gmail.com>,
	Gongming Wang <gmwgg05@gmail.com>,
	Mingda Zhang <npczmd@qq.com>,
	Qinrun Dai <jupmouse@gmail.com>,
	Jan Kara <jack@suse.cz>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.10.y] udf: validate the device specification EA before using it
Date: Tue, 10 Nov 2026 09:08:41 -0500
Message-ID: <20261110140749.1672140-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261107061430-failed-5.10-9a2390959685@kernel.org>
References: <20261107061430-failed-5.10-9a2390959685@kernel.org>
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
[ sashal: adapted write-side changes to udf_update_inode() instead of udf_write_inode() ]
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 fs/udf/inode.c | 42 +++++++++++++++++++++++++++++++++++++-----
 1 file changed, 37 insertions(+), 5 deletions(-)

diff --git a/fs/udf/inode.c b/fs/udf/inode.c
index 849fb64fdb8e5..f7ecee0a333fc 100644
--- a/fs/udf/inode.c
+++ b/fs/udf/inode.c
@@ -1284,6 +1284,26 @@ int udf_setsize(struct inode *inode, loff_t newsize)
 	return 0;
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
@@ -1598,13 +1618,12 @@ static int udf_read_inode(struct inode *inode, bool hidden_inode)
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
@@ -1752,6 +1771,10 @@ static int udf_update_inode(struct inode *inode, int do_sync)
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
@@ -1759,6 +1782,10 @@ static int udf_update_inode(struct inode *inode, int do_sync)
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
@@ -1898,6 +1925,11 @@ static int udf_update_inode(struct inode *inode, int do_sync)
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

