Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794312148;
	b=YIgbsabXkCSv0MXGpA1X84hWXguVSf1tZ9xMOe3CXNL/z2j/01GNaBbviR5XRHTYwLRG
	 nxJ82tgHVY7WlOdgXwrrgKkYUJ3DmbEtuwkyW/TQVGbCN3pwc/DXMMU8rsBycu9CDT0Zn
	 zVHGDArnsztI4QzniZeVY/J+CyFeQVqX9lDDx2/lXu6ldLwhAaJTTMTknIVvg18oHqfwT
	 ecZ5JiI3TqKMjhCHCIQDkJE1TuxzWQOH4CSpiMZMLHKGHkjF9qhV2FXANc6sk06aXdHK0
	 hDZ9sPM15KYYmuLNksY7CkWtivFY5oQE4hAgZg9xOg0DFYdUScLbeQl8b7UfCxERJxw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794312148;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=PwwEusEYDQTzA94qqfzivqh2RRlFVy2vS6hXneQLYM0=;
	b=1mh+0AH7PXkUXdeEvBZoixad+vV7FOpSFCNYMf8HhfaDZpwAASp4nF2z7Q2/87k1pVsk
	 tczUwHC2Nqh+/PQpfSYE2iUEXnNFBpd9jWIx1czf9OAHNnpgttCjhC8djQ4dta5Cz8nl6
	 SVgeqdn3mMtcM7ql0gDCCqH0kFweD9klAV7/m7T7I9rb90ZGc4BTnEvksj0HdO4GYLVqw
	 kQ444n4XESWprRC7ojk8iTsuyOs7f9k3Lt8AdgTzhw+diEhSIdJvfidkHAdIjX5lgDVOT
	 5s+9ytzHoS+a0fMWNgp+InH8HbZbaSxU8lprrZyCsekC5LdgLXMdQbncksNdZgOadTA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=gNKL6PII;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BE10F606A321
	for <stable@vger.kernel.org>; Tue, 10 Nov 2026 12:02:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=gNKL6PII
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 36BDE1F0089F;
	Tue, 10 Nov 2026 12:02:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794312147;
	bh=PwwEusEYDQTzA94qqfzivqh2RRlFVy2vS6hXneQLYM0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=gNKL6PII8ABTZHPw/d/zE02MVKQlSDEqPn92O6/2UJJ0QB62eLJWJRpuNGBaXbG/z
	 f/2m2AHD9e5HRcT0cVq1v0S7L22iC5sEBudAB7Qv+RYUL9rflDkvs6k/osKcoejVmI
	 z0jSE3O/pW5G7AdmLWWsxpFhqEHRlbqD3QunTkg8o94Xx7STCkuz6B6WSTiO+7GkaF
	 3aWrR6BEm9YVdMru/cUuFQ0BIVKUhCx+mAgB3Q5pEpZBmNwFeyGeUlK04WhYk77rHt
	 G2cKGEWO6niGXVvrnusozOkopz28hU0Epz2a9IhEnnpQF1Sy0TgVyXlLE/gh/3H8qR
	 2kwSLbWnJ+lKg==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Yunpeng Tian <shionthanatos@gmail.com>,
	Gongming Wang <gmwgg05@gmail.com>,
	Mingda Zhang <npczmd@qq.com>,
	Qinrun Dai <jupmouse@gmail.com>,
	Jan Kara <jack@suse.cz>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.1.y] udf: validate the device specification EA before using it
Date: Tue, 10 Nov 2026 07:02:24 -0500
Message-ID: <20261110120155.946293-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261107054058-failed-6.1-9a2390959685@kernel.org>
References: <20261107054058-failed-6.1-9a2390959685@kernel.org>
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
[ sashal: adapted changes in udf_write_inode() to udf_update_inode() ]
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 fs/udf/inode.c | 42 +++++++++++++++++++++++++++++++++++++-----
 1 file changed, 37 insertions(+), 5 deletions(-)

diff --git a/fs/udf/inode.c b/fs/udf/inode.c
index fd4b8cc20f5f1..6b78df1f1625b 100644
--- a/fs/udf/inode.c
+++ b/fs/udf/inode.c
@@ -1185,6 +1185,26 @@ int udf_setsize(struct inode *inode, loff_t newsize)
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
@@ -1499,13 +1519,12 @@ static int udf_read_inode(struct inode *inode, bool hidden_inode)
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
@@ -1653,6 +1672,10 @@ static int udf_update_inode(struct inode *inode, int do_sync)
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
@@ -1660,6 +1683,10 @@ static int udf_update_inode(struct inode *inode, int do_sync)
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
@@ -1799,6 +1826,11 @@ static int udf_update_inode(struct inode *inode, int do_sync)
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

