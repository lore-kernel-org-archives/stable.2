Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794311539;
	b=e04BJpW8MpNcikOkLSTOEMvfWRRk3mHoZocKt+qqahJo4SLSjmuTvA7BHjyg7g4hj4Qv
	 6DhFkNbWsnWdoCdmDjCqqQLf+6ED+KKj9QO+TU60iYHNPF/B31Q1+gTyvCxtoYT5Rr3xq
	 tmRD1H3VMZO2x1qFzhEqwmqhsO9im1XHfjk8SlP1BmkgH2/0dGn4D+7gxHXLsPURiL2Nd
	 +89snwOBFO1mbP5dGl1WEcxoU/FAt/KxUIKVvZzGYLQt6kLWkRPdlkfEgk2ZibvOf7qnG
	 +dkNi/4+2YGGZbAcGS0ZhRsLtEOa3gcxsDpDnbXDohIilTp6HL/tDFNL9h+bmjnvflw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794311539;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=9zPU+Bp9Q5JJEdzH/d+JZDt5nKjKV9Hhpbv/CxXuyB0=;
	b=MHFnsHPCq62M0JG7IEg0Vxw/0JhTvXB+okG/c0nHflyPq9aQw2iI/FRm/drcuxc8Y38y
	 hCgYKlEIry5Va/p6fpFvcVOtI9vjHf+GXHlhj0ZWYz8jFE0RMYl4nnxFCt29uf8TAFT/s
	 6648+OWQ9MzivhR5ixMNtHYiP2uiPAYMArsXdTqKnoXQOyZ+9lOudJFBgnYAOIMczxFtg
	 wgRvasQqXDBiSaEQXc4FY0SNZQtn1QybGxbKFDK42VKII/DIhEQkDnqi/ZecDt6nbsOQu
	 88D4atLpw8zZa+kTL/XCmRK6NLIwPdbgTf3pqJsoLoDNak8TBKrGeV5kjc7cXkofmgA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=fz7EwKzY;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 72375606A985
	for <stable@vger.kernel.org>; Tue, 10 Nov 2026 11:52:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=fz7EwKzY
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 609FD1F0089F;
	Tue, 10 Nov 2026 11:52:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794311539;
	bh=9zPU+Bp9Q5JJEdzH/d+JZDt5nKjKV9Hhpbv/CxXuyB0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=fz7EwKzYHuYTXV9+OZflBaowG77rAljSlAYpxxZd/137+3MRvCpC54aEcmmRrIUlS
	 FgBSv0DOdfJYl9yof1JH9Lz9G/1n3eiJ6WYv5dd9C+uGeBFPQbS/OE273Bp0R3dA5c
	 VXci4KG4aGaHNTVgdFOVDWVJNWoAyWQREAv3RMxyVJaWdLym+W8KufIltBZWb9foMx
	 zYJcje7N1M6gyj/jJC50QgN64ywqRBHefrnfGrBxvdq4f0gjk263KIjvngqCr4wnjy
	 47Ncl3LfuzuwxLmdp6mgiPmzUyx0mdKdkrwnHbyY/lOVlWIUPqUQD6LIK0qeWrZFuI
	 yX4mVS+DgndVg==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Yunpeng Tian <shionthanatos@gmail.com>,
	Gongming Wang <gmwgg05@gmail.com>,
	Mingda Zhang <npczmd@qq.com>,
	Qinrun Dai <jupmouse@gmail.com>,
	Jan Kara <jack@suse.cz>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.12.y] udf: validate the device specification EA before using it
Date: Tue, 10 Nov 2026 06:52:16 -0500
Message-ID: <20261110115156.881155-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261107051625-failed-6.12-9a2390959685@kernel.org>
References: <20261107051625-failed-6.12-9a2390959685@kernel.org>
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
[ sashal: adapted udf_write_inode() changes to udf_update_inode() using its existing error handling ]
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 fs/udf/inode.c | 42 +++++++++++++++++++++++++++++++++++++-----
 1 file changed, 37 insertions(+), 5 deletions(-)

diff --git a/fs/udf/inode.c b/fs/udf/inode.c
index 96934d42d9499..49d8a2b196414 100644
--- a/fs/udf/inode.c
+++ b/fs/udf/inode.c
@@ -1339,6 +1339,26 @@ int udf_setsize(struct inode *inode, loff_t newsize)
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
@@ -1657,13 +1677,12 @@ static int udf_read_inode(struct inode *inode, bool hidden_inode)
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
@@ -1811,6 +1830,10 @@ static int udf_update_inode(struct inode *inode, int do_sync)
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
@@ -1818,6 +1841,10 @@ static int udf_update_inode(struct inode *inode, int do_sync)
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
@@ -1959,6 +1986,11 @@ static int udf_update_inode(struct inode *inode, int do_sync)
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

