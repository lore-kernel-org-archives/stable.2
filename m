Received: from mailgw.kylinos.cn (mailgw.kylinos.cn [124.126.103.232])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 53CEC3A3E8C;
	Thu,  6 Aug 2026 01:39:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=124.126.103.232
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785980364; cv=none; b=UxA44NdmZs4eXJ//RFJ6wiXZZqFiuFYUZzu2EDV9m+CzUS67Q81yQFd0zXOtMTpcUr1Vsq2h2u++dK+K6LveTwbDTPuA+tMSd+dO90zRNGP79wU4Rrs7rFDEHskTEdqVRgcErnyTbpsqqkdfsqRs0qby0mVBABJeS14AF8I6JMM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785980364; c=relaxed/simple;
	bh=TjqPnAU/Pt5O1nUz79TpUwdCD+jdKwW4O13a7b32MjY=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=ktXjRxLhg7fca4wUbray6y0/pK12A0IpCD0KU01gBNiX2DeKtwa7vzNukBUtRiFAxt09LHNvPfVV8fqGduROdnmC/xvZQJHW7xFvZ/vVKnHE3DYEPHv7H8SmXvuPr80zFJ+LS8o+c+ROL5SnprZFoXXe2C2erAbpLoC/Sy6z7lY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn; spf=pass smtp.mailfrom=kylinos.cn; arc=none smtp.client-ip=124.126.103.232
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kylinos.cn
X-UUID: 9d995f9e913711f1aa26b74ffac11d73-20260806
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.3.12,REQID:ab964d6b-8eb4-48a2-a5d2-ee410b13b3e3,IP:0,U
	RL:0,TC:0,Content:0,EDM:25,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION
	:release,TS:25
X-CID-META: VersionHash:e7bac3a,CLOUDID:51e2d7b99f8e0ebe579273d1060236cc,BulkI
	D:nil,BulkQuantity:0,Recheck:0,SF:102|850|865|898,TC:nil,Content:0|15|50,E
	DM:5,IP:nil,URL:0,File:nil,RT:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0,OSA:
	0,AV:0,LES:1,SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0,ARC:0
X-CID-BVR: 2,SSN|SDN
X-CID-BAS: 2,SSN|SDN,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR
X-CID-RHF: D41D8CD98F00B204E9800998ECF8427E
X-UUID: 9d995f9e913711f1aa26b74ffac11d73-20260806
X-User: zenghongling@kylinos.cn
Received: from localhost.localdomain [(10.44.16.150)] by mailgw.kylinos.cn
	(envelope-from <zenghongling@kylinos.cn>)
	(Generic MTA with TLSv1.3 TLS_AES_256_GCM_SHA384 256/256)
	with ESMTP id 1767105865; Thu, 06 Aug 2026 09:39:07 +0800
From: Hongling Zeng <zenghongling@kylinos.cn>
To: linkinjeon@kernel.org,
	hyc.lee@gmail.com,
	alexandro.calo@nozominetworks.com
Cc: ntfs@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	zhongling0719@126.com,
	Hongling Zeng <zenghongling@kylinos.cn>,
	stable@vger.kernel.org
Subject: [PATCH v2] ntfs: fix name offset validation in ntfs_non_resident_attr_value_is_valid
Date: Thu,  6 Aug 2026 09:39:03 +0800
Message-Id: <20260806013903.8526-1-zenghongling@kylinos.cn>
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
Changes in v2:
- Read name_length directly as an 8-bit field instead of using
  le16_to_cpu().
- Restrict the name forward-shift bounds check to the same attribute
  types that can actually be converted by ntfs_attr_update_meta().
---
 fs/ntfs/attrib.c | 33 ++++++++++++++++++++++++++++++++-
 1 file changed, 32 insertions(+), 1 deletion(-)

diff --git a/fs/ntfs/attrib.c b/fs/ntfs/attrib.c
index d354c3b0fae1..ffd08633970a 100644
--- a/fs/ntfs/attrib.c
+++ b/fs/ntfs/attrib.c
@@ -693,6 +693,9 @@ static bool ntfs_non_resident_attr_value_is_valid(const struct attr_record *a)
 	u32 attr_len;
 	u32 min_len;
 	u16 mp_offset;
+	u16 name_offset;
+	u8 name_len;
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
+	 * may be zero for unnamed attributes.
+	 */
+	name_len = a->name_length;
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
+		 * A normal non-resident attribute moves its name forward when
+		 * it is converted to a sparse attribute.
+		 */
+		if (!(a->flags & (ATTR_IS_SPARSE | ATTR_COMPRESSION_MASK)) &&
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

