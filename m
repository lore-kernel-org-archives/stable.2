Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794311791;
	b=Fmin6VyKCJRiw4TCah4/Bh4WWy183qzPVmVpcfYOUY66bh5RN4V4Hzc9lrDau7JO5rvb
	 xORNYjAFUW1BaELWId14qViZfbbZy58CsgswI27ucc67YYZWhKfdNH3mJy2TGQXuG0xQm
	 s+OFA5zil+NvejLi/P38541mPcln01UmUDtFPiOrVIPzhe5CVYlmgySOsS5XBNivod4Gw
	 uzXDbbi1rSJt9n7C06H4Cw9vki/PqiGAX9/G8/BgqEO+OewLHEiI1fKyODNV/kX5K1s3A
	 qIY/+TWANjQh/YJ0IuPR4VXpmG7pWpVOIiUqrVC/gNHBGH3NQu5klEX3WzwM8mE5n6Q==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794311791;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=rQDSqOXrTiEBQ9J3CLpVoHD52shbQjrDpCyXHrbp2M8=;
	b=ho+WrdASzFSSN4l4P6rLwjupuR7xZVIvPlttkS0Zj2dtH4Qj0ezvz1APqxh9d9bqDT2r
	 /xzWRYw8bDpC2LudACH0MmnWGE2IV/uclgL7AFOlIZhL7o6a+OYiAJ8JD3vB4fsX68+t/
	 xk+uslx8VtXQKQKvJu9+N2GuSls+vg3z5Ibh86RhCP/MapFIdzeHI+v62mZzJftUTC/kD
	 t7CwRZtZFhFJ/BZU8vgcHnvK/GQFeqPNVuX6veh4HS75SYeO2lKWDIk75pEJ0GyF5l1uF
	 pSjzG+OwUO8T0oJFeuJSvyVoJqKCEFE/En7biL21NwrMlO4tyf/Wq7palhjefE0CX4w==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=lz+S+Zki;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 625EA606A32A
	for <stable@vger.kernel.org>; Tue, 10 Nov 2026 11:56:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=lz+S+Zki
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 717431F008A1;
	Tue, 10 Nov 2026 11:56:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794311791;
	bh=rQDSqOXrTiEBQ9J3CLpVoHD52shbQjrDpCyXHrbp2M8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=lz+S+Zki3pK40KiSybqAwUGdKkr+dMb3ygQ5+NjfPbppo58feCxK3EJnCnDprd5Wo
	 0naLa2xIaWJqSc0aR68dW+RlwILMtP0rz/aZSk4BsFL/NDkByyO4aBG5he0wPmRbud
	 9a/dKHfQlintc6eMdOK6LOU9mbhoYyZZ2wWSnrzOBO6hHJLkG+1oLw5eJep1B77XDN
	 2j/XwTNer5219cgk2GVtdBLmB6ESvJUels+jCrj+3T4mD0kyBjNvY5VMrJX8j25vzJ
	 4+oX/jmgc1w4V9b7i9FOuQENohiQvALZ4lxm5ngjbcs8fazsRIwMyAgsdbn18jdGKa
	 PH4/QN5xLjSkw==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Yunpeng Tian <shionthanatos@gmail.com>,
	Gongming Wang <gmwgg05@gmail.com>,
	Mingda Zhang <npczmd@qq.com>,
	Qinrun Dai <jupmouse@gmail.com>,
	Jan Kara <jack@suse.cz>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.6.y] udf: validate the device specification EA before using it
Date: Tue, 10 Nov 2026 06:56:29 -0500
Message-ID: <20261110115605.931548-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261107052825-failed-6.6-9a2390959685@kernel.org>
References: <20261107052825-failed-6.6-9a2390959685@kernel.org>
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
index be59d205e3061..bf607df9ef02c 100644
--- a/fs/udf/inode.c
+++ b/fs/udf/inode.c
@@ -1344,6 +1344,26 @@ int udf_setsize(struct inode *inode, loff_t newsize)
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
@@ -1658,13 +1678,12 @@ static int udf_read_inode(struct inode *inode, bool hidden_inode)
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
@@ -1812,6 +1831,10 @@ static int udf_update_inode(struct inode *inode, int do_sync)
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
@@ -1819,6 +1842,10 @@ static int udf_update_inode(struct inode *inode, int do_sync)
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
@@ -1958,6 +1985,11 @@ static int udf_update_inode(struct inode *inode, int do_sync)
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

