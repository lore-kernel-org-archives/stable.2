Received: from mailgw.kylinos.cn (mailgw.kylinos.cn [124.126.103.232])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 308863F4DCA;
	Wed,  5 Aug 2026 09:29:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=124.126.103.232
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785922161; cv=none; b=UGV5FPffA87u9fJi4HFKT9deeMprlwjviik4DbWjEic5usOUIidy2ogNJPTlgGe7mvfH+zvsnvq/HcAGSnJ8c3cJHm6M2/H4annl8+SvP2MkMIOs0VOV1hVUuGcqSfCL5lXRwX+1SXBLO55PXUGN2bU9kIYNfA7j/+/O4EEsMHs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785922161; c=relaxed/simple;
	bh=Ky0V2UofAujX66s+HUXLD01q1ni68J3p0RJ1NV/yM/A=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=rXvk5O/lp5GkagB5gviVgwTHBUWgmRPMp9vgTrZdAtzbGjyiLASExgqOR2w3X12v6BAYdti3J4JrRdw7vLoxuL98GLJ34PYNRFMM7ZoNSEuzaRaj+cNhsff4VJ7yqjDL275b3VEqIgoLVFCzcyV26m6HgDOp2jlq5kUf1jkBJOw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn; spf=pass smtp.mailfrom=kylinos.cn; arc=none smtp.client-ip=124.126.103.232
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kylinos.cn
X-UUID: 1eb0878e90b011f1aa26b74ffac11d73-20260805
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.3.12,REQID:3a183ffd-c44f-4b1d-a550-e5b0ef6beab0,IP:0,U
	RL:0,TC:0,Content:0,EDM:25,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION
	:release,TS:25
X-CID-META: VersionHash:e7bac3a,CLOUDID:2d74e6fef57bd11b15d13d202d0218e5,BulkI
	D:nil,BulkQuantity:0,Recheck:0,SF:102|850|865|898,TC:nil,Content:0|15|50,E
	DM:5,IP:nil,URL:0,File:nil,RT:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0,OSA:
	0,AV:0,LES:1,SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0,ARC:0
X-CID-BVR: 2,SSN|SDN
X-CID-BAS: 2,SSN|SDN,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR
X-CID-RHF: D41D8CD98F00B204E9800998ECF8427E
X-UUID: 1eb0878e90b011f1aa26b74ffac11d73-20260805
X-User: zenghongling@kylinos.cn
Received: from localhost.localdomain [(10.44.16.150)] by mailgw.kylinos.cn
	(envelope-from <zenghongling@kylinos.cn>)
	(Generic MTA with TLSv1.3 TLS_AES_256_GCM_SHA384 256/256)
	with ESMTP id 1187836271; Wed, 05 Aug 2026 17:29:12 +0800
From: Hongling Zeng <zenghongling@kylinos.cn>
To: linkinjeon@kernel.org,
	hyc.lee@gmail.com,
	alexandro.calo@nozominetworks.com
Cc: ntfs@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	Hongling Zeng <zenghongling@kylinos.cn>,
	stable@vger.kernel.org
Subject: [PATCH] ntfs: fix name offset validation in ntfs_non_resident_attr_value_is_valid
Date: Wed,  5 Aug 2026 17:29:08 +0800
Message-Id: <20260805092908.77549-1-zenghongling@kylinos.cn>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

ntfs_attr_update_meta() performs memmove operations on attribute names
when converting between sparse and non-sparse attributes:

- Converting to sparse shifts the name forward by 8 bytes
  (name_offset + 8)
- Converting from sparse shifts the name backward by 8 bytes
  (name_offset - 8)

However, the validator does not check that name_offset is within safe
boundaries for these operations. A malicious MFT record could set
name_offset such that:

1. The name is positioned at the very end of a non-sparse attribute.
   Converting to sparse would shift the name forward by 8 bytes,
   writing beyond the attribute boundary.

2. The name overlaps with the mapping pairs, causing corruption during
   conversion.

Add validation to ensure:
- For named attributes, name_offset is within valid bounds
- Name does not extend beyond the attribute or overlap with mapping pairs
- For non-sparse attributes, name_end + 8 fits within attr_len to allow
  room for the forward shift when becoming sparse

Note: name_offset validation only applies when name_length != 0, as
unnamed attributes use name_offset = 0 which is valid.

Fixes: 7e2a1c554bc4 ("ntfs: Fix min_len for compressed/sparse attributes in ntfs_non_resident_attr_value_is_valid()")
Cc: stable@vger.kernel.org
Signed-off-by: Hongling Zeng <zenghongling@kylinos.cn>
---
 fs/ntfs/attrib.c | 33 ++++++++++++++++++++++++++++++++-
 1 file changed, 32 insertions(+), 1 deletion(-)

diff --git a/fs/ntfs/attrib.c b/fs/ntfs/attrib.c
index d354c3b0fae1..778b13cf9762 100644
--- a/fs/ntfs/attrib.c
+++ b/fs/ntfs/attrib.c
@@ -693,6 +693,9 @@ static bool ntfs_non_resident_attr_value_is_valid(const struct attr_record *a)
 	u32 attr_len;
 	u32 min_len;
 	u16 mp_offset;
+	u16 name_offset;
+	u16 name_len;
+	u32 name_end;
 
 	attr_len = le32_to_cpu(a->length);
 	min_len = offsetof(struct attr_record, data.non_resident.initialized_size) +
@@ -706,7 +709,35 @@ static bool ntfs_non_resident_attr_value_is_valid(const struct attr_record *a)
 		return false;
 
 	mp_offset = le16_to_cpu(a->data.non_resident.mapping_pairs_offset);
-	return mp_offset >= min_len && mp_offset <= attr_len;
+	if (mp_offset < min_len || mp_offset > attr_len)
+		return false;
+
+	/*
+	 * Validate name_offset for named attributes.
+	 * Unnamed attributes have name_length = 0 and name_offset may be 0.
+	 */
+	name_len = le16_to_cpu(a->name_length);
+	if (name_len) {
+		name_offset = le16_to_cpu(a->name_offset);
+
+		if (name_offset < min_len || name_offset >= attr_len)
+			return false;
+
+		name_end = name_offset + name_len * sizeof(__le16);
+		if (name_end > attr_len || name_end > mp_offset)
+			return false;
+
+		/*
+		 * For non-sparse -> sparse conversion, name shifts forward
+		 * by 8 bytes. Ensure there's room for the shift.
+		 */
+		if (!(a->flags & ATTR_IS_SPARSE) &&
+		     name_end + 8 > attr_len)
+			return false;
+	}
+
+	return true;
+
 }
 
 static bool ntfs_attr_value_is_valid(struct ntfs_volume *vol,
-- 
2.25.1

