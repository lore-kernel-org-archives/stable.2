Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794046588;
	b=GK/DJoo6WCypcMunf17LbuKsKfe4++gmTESBwgEO+XKNXFAw0LU1lGugIfp3dDBiW428
	 mlosoPRWyX7wAowfnao1qR5KNCSFTbbJl4+96no1zlcnZQxmQr0RIImFMjlqIh0jJws56
	 ARhoh2FlktXDM4SAOFvuGkI26RulNBllKiYuQDhHWHeGBq/d/IzIBn1blLZ6G3I1f9h6o
	 u6L8IpWh33nExbtUTqMJCsGcVRytJW28cVElVeksf9T/uKUjI5B26lFDPTIID8mGIzD1M
	 iF2TUdezsb//voiHuXAsFUY4S3zNasYq1S89/1Rft54DfGYXvIVTs4hFqjdjtAdwDvQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794046588;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 MIME-Version:Content-Type:Content-Transfer-Encoding;
	bh=G0Qs+5R8mnhgdBoai98XbYbVX/EkPyfskbsdqedeKio=;
	b=CBRajXok3T4xBKfoT1T6XfI1te9ZHpXsV41AdM4G7X0H4N3PA53LjXoM56z8OJGjU0xZ
	 hUJlq0OXEZRNVATmr6SLLbvfHqygKbXgduYfmULLISlES2BkH7Q1GJMTt/ksXGstvyGmQ
	 dEvXWgk4ZmVfghjzeeAbXLnFh23Ta01xQMlNaAiHOe9wT+APMOuYaF2/GVNZcD3dbc1bL
	 SIuaCy4YpxgfLME6aBLLcs/kiscLKdPHhaT4YkgcCbKVBIe7Yez9kDGLgHAdpDN/KRHWj
	 tSSWD+vm/U5mai2WI76cKo5rq3dG0l8dY9oPnGh71NQGkV9fuTzFjsHdCVO6f0UtDOg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=HQw4fv7z;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C5AFD606D80F
	for <stable@vger.kernel.org>; Sat,  7 Nov 2026 10:16:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=HQw4fv7z
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 01D371F0089F;
	Sat,  7 Nov 2026 10:16:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794046587;
	bh=G0Qs+5R8mnhgdBoai98XbYbVX/EkPyfskbsdqedeKio=;
	h=From:To:Cc:Subject:Date;
	b=HQw4fv7z2oi2tese1/QFwpE25wC9zTvNm4VkGStl1974DLepJtDy1ll7cAJAj+jow
	 NITAZJpU40FAo6L2YbsQmrLwHmQsqFvVokqeQEZ63QETiO1IkIS24JGRRsHppfkNAo
	 QSDLLXpOfx28FqD+a5/OSdHwI4X7jgbkHvd8fH3HGplxR5OBj51pAJwZOoWEuEzW+A
	 4lDLp+z1fPlxs/do+7/hvqw+3dIGqqDO+fdZFjwesQF7MdcWczzO5WZQHVUuTHtMax
	 moqVEsqM3kec96nb3Wx8PsdY/cDHe8S6iMbbRuFmvhMdhkuC6evTZfBLIawxdWk8i6
	 GPdrvl36hX5gQ==
From: Sasha Levin <sashal@kernel.org>
To: shionthanatos@gmail.com,
	gmwgg05@gmail.com,
	npczmd@qq.com,
	jupmouse@gmail.com,
	jack@suse.cz
Cc: stable@vger.kernel.org
Subject: FAILED: patch "[PATCH] udf: validate the device specification EA before using it" failed to apply to 6.12-stable tree
Date: Sat,  7 Nov 2026 05:16:25 -0500
Message-ID: <20261107051625-failed-6.12-9a2390959685@kernel.org>
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

The patch below does not apply to the 6.12-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-6.12.y
git checkout FETCH_HEAD
git cherry-pick -x 9a2390959685ac35a58c80c8016120849a2babf6
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '20261107051625-failed-6.12-9a2390959685@kernel.org' --subject-prefix 'PATCH 6.12.y' 'HEAD^..'

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




