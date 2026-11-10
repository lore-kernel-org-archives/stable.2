Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794316047;
	b=E4u9BXIQ0HxSLcdiLGCBlhDCFRHoHMqB7rI4///sp4BfVWgHHVowgRm0xAIFj0rLXKS9
	 l8Sdm9L6ZyzcR3qs8b1EOBAMZfCkoERiFpDUqzVJ3roPbTBJqEGi0390qjh6qxgllo7DU
	 UifW2gF/Fw44fEavSG9jvOWWfby/IWmYmrkSBpP/kNK+ihRKqxA9dDox31IebSTSqtwzK
	 97pNtHKLaGmbnwAZYp+oebqlfJX8qwEIV0A2CaYkP3q2wxGmb39B3igCcVyG5t2tddbS1
	 kdDSlHl2MIJfGZqydiLC/LnAIpETxoREjGDzC/4VFbx/6WnsgcRdY4lfJ5z849s8clQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794316047;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=JPUJFyDCbPMbrOpLBOL1M7W5xvxAnTCmtQW67pbq1ZM=;
	b=dfNrOnBFr4ywVouvkkwAniXw63z1sOrlR6xZ9bbccyNp5DSafYJ66iCZrFWqOfzaP9hA
	 cEjVOYmkGt/uYU/TbXe6jEPXVFEUN4/QySnJFReq6MteU49yWNN6tqkr5kQ+IMNTcSd9O
	 AXmvm4wE9JDhbnhGL/Pq3bQc9zHX8m/Is/ynpNcquD5MzIUkJuOKzHEvkCAT1vqy82AIf
	 hgS3WWj/50bYRdgDY+KBnxj2eUy0v7mNgA0o9RLLKvpPVc5bjE/rT3DTtrT83EymCjML3
	 WCIkg9S7lm0DViX7GALvhmLmpfM92D8NOmiBcxNydscLvihbmz5Tk5eCyDDvMujVoRw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=bqPtlvdp;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E32E9606A74F
	for <stable@vger.kernel.org>; Tue, 10 Nov 2026 13:07:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=bqPtlvdp
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F2B321F008A1;
	Tue, 10 Nov 2026 13:07:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794316046;
	bh=JPUJFyDCbPMbrOpLBOL1M7W5xvxAnTCmtQW67pbq1ZM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=bqPtlvdpLnlZ3FbR8zPyZrpa24mwECqUCJqgWdb0jmF1KcZgea05ENADcONAwsflc
	 +NKIx2m7qGYx7yWYXKTQIj/z8+qAVLrNDug/3Q9jsUrR3bYyfTiwMHxC23HkB7tX+p
	 a8XmG05AMVnRLRiRggeYzsb5MxDSF4A4XxldjEl3329NNq0a2JojqYd1sjyptCdOfT
	 tLzaqG4YtYmLTdcle30COJHLr7iD9UGObNEWlZCJDFqM2UaAb3qWWMIiyXIzKHMMa8
	 tF0Cc90mCUukm4AjssVTlIdX8A+Ex3T2djWOJmEXEvKv1PIOajZon80s8vUEW5ENw1
	 m3LI4iMAH/F4w==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Yunpeng Tian <shionthanatos@gmail.com>,
	Gongming Wang <gmwgg05@gmail.com>,
	Mingda Zhang <npczmd@qq.com>,
	Qinrun Dai <jupmouse@gmail.com>,
	Jan Kara <jack@suse.cz>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.15.y] udf: validate the device specification EA before using it
Date: Tue, 10 Nov 2026 08:07:24 -0500
Message-ID: <20261110130706.966645-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261107055731-failed-5.15-9a2390959685@kernel.org>
References: <20261107055731-failed-5.15-9a2390959685@kernel.org>
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
[ sashal: adapted udf_write_inode() changes to the existing udf_update_inode() implementation ]
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 fs/udf/inode.c | 42 +++++++++++++++++++++++++++++++++++++-----
 1 file changed, 37 insertions(+), 5 deletions(-)

diff --git a/fs/udf/inode.c b/fs/udf/inode.c
index 4419070d5008a..e3a201df9b76c 100644
--- a/fs/udf/inode.c
+++ b/fs/udf/inode.c
@@ -1194,6 +1194,26 @@ int udf_setsize(struct inode *inode, loff_t newsize)
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
@@ -1508,13 +1528,12 @@ static int udf_read_inode(struct inode *inode, bool hidden_inode)
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
@@ -1662,6 +1681,10 @@ static int udf_update_inode(struct inode *inode, int do_sync)
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
@@ -1669,6 +1692,10 @@ static int udf_update_inode(struct inode *inode, int do_sync)
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
@@ -1808,6 +1835,11 @@ static int udf_update_inode(struct inode *inode, int do_sync)
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

