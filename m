Received: from mailgw.kylinos.cn (mailgw.kylinos.cn [124.126.103.232])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 63973345CC0;
	Mon, 24 Aug 2026 09:30:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=124.126.103.232
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787563844; cv=none; b=kUyo3o5Cq56YDH1y+JBBZs2+Tfv6KxZsZZT0nECC/VSDYaF03kqq3x03CK3yTvUWHHlyLIKBM0uTZm9HvSkkEqyKTA7JyNsVNPLJEkZiTqYoQlTq3Zo47rsTkVUBsjpnWZP46ZgQt227PTcYX0ds0vLoz0+odJbsHG1n6pAlPmw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787563844; c=relaxed/simple;
	bh=78yE10/xbclHlKoveZ5nGN9VaIjo8xxd8ysJQbi7NrI=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=T/GwHI1OCPWvlsYkPx/egewjU45y1+hpYlWQjhmrtu4yss9RPe7d91TRnQ2p3UzfPMNM3qlrzCX7SFELCwzY5Fy9po/vQkCgi7FHPRNxkCu6fufzAnzadG6mqG0/Nsxqx/CCRlVykTI3Mwe8Ca+UGT91SXx19BNHREHVL0OclYM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn; spf=pass smtp.mailfrom=kylinos.cn; arc=none smtp.client-ip=124.126.103.232
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kylinos.cn
X-UUID: 767799109f9e11f19a56ed5b684f684d-20260824
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.3.19,REQID:cdebc39d-9a5b-4d31-9ed8-46b7d58ac7db,IP:0,U
	RL:0,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION:
	release,TS:0
X-CID-META: VersionHash:7db8b62,CLOUDID:8b81f1eb8d97af383d75b9b32e2ef6bb,BulkI
	D:nil,BulkQuantity:0,SF:102|850|865|898,TC:nil,Content:0|15|50,EDM:-3,IP:n
	il,URL:0,File:nil,RT:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0,OSA:0,AV:0,LE
	S:1,SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0,ARC:0
X-CID-BVR: 2,SSN|SDN
X-CID-BAS: 2,SSN|SDN,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR
X-CID-RHF: D41D8CD98F00B204E9800998ECF8427E
X-UUID: 767799109f9e11f19a56ed5b684f684d-20260824
X-User: zenghongling@kylinos.cn
Received: from localhost.localdomain [(10.44.16.150)] by mailgw.kylinos.cn
	(envelope-from <zenghongling@kylinos.cn>)
	(Generic MTA with TLSv1.3 TLS_AES_256_GCM_SHA384 256/256)
	with ESMTP id 308014753; Mon, 24 Aug 2026 17:30:36 +0800
From: Hongling Zeng <zenghongling@kylinos.cn>
To: linkinjeon@kernel.org,
	hyc.lee@gmail.com
Cc: ntfs@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	zhongling0719@126.com,
	Hongling Zeng <zenghongling@kylinos.cn>,
	stable@vger.kernel.org
Subject: [PATCH] ntfs: fix memmove overlap in ntfs_new_attr_flags
Date: Mon, 24 Aug 2026 17:30:30 +0800
Message-Id: <20260824093030.213157-1-zenghongling@kylinos.cn>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

When the record shrinks while the payload offsets increase (e.g., enabling
compression reduces padding, making arec_size < old_arec_size, but the header
grows by 8 bytes), moving the name first can overwrite the old mapping_pairs
before they are copied. Move mapping_pairs first in this case.

Since mp_ofs is derived from name_ofs, they always change in the same
direction. Checking name_ofs alone is sufficient.

Fixes: fc053f05ca28 ("ntfs: add reparse and ea operations")
Cc: stable@vger.kernel.org
Signed-off-by: Hongling Zeng <zenghongling@kylinos.cn>
---
 fs/ntfs/ea.c | 33 +++++++++++++++++++++++++++------
 1 file changed, 27 insertions(+), 6 deletions(-)

diff --git a/fs/ntfs/ea.c b/fs/ntfs/ea.c
index cdd306933d73..61ca945ce5bf 100644
--- a/fs/ntfs/ea.c
+++ b/fs/ntfs/ea.c
@@ -753,15 +753,36 @@ static int ntfs_new_attr_flags(struct ntfs_inode *ni, __le32 fattr)
 	old_arec_size = le32_to_cpu(a->length);
 
 	/*
-	 * Move payloads before shrinking the record.  Otherwise resizing moves
+	 * Move payloads before shrinking the record. Otherwise resizing moves
 	 * the following attribute over the old payload before it can be copied.
+	 *
+	 * When offsets increase, move mapping_pairs first to avoid name
+	 * overwriting the start of mapping_pairs.
 	 */
 	if (arec_size < old_arec_size) {
-		if (a->name_length && name_ofs != old_name_ofs)
-			memmove((u8 *)a + name_ofs, (u8 *)a + old_name_ofs,
-				a->name_length * sizeof(__le16));
-		if (mp_ofs != old_mp_ofs)
-			memmove((u8 *)a + mp_ofs, (u8 *)a + old_mp_ofs, mp_size);
+		if (name_ofs > old_name_ofs) {
+			/* Payload offsets increased: move mapping pairs first. */
+			if (mp_ofs != old_mp_ofs)
+				memmove((u8 *)a + mp_ofs,
+						(u8 *)a + old_mp_ofs,
+						mp_size);
+			if (a->name_length && name_ofs != old_name_ofs)
+				memmove((u8 *)a + name_ofs,
+						(u8 *)a + old_name_ofs,
+						a->name_length *
+							sizeof(__le16));
+		} else {
+			/* Payload offsets decreased or unchanged: move name first. */
+			if (a->name_length && name_ofs != old_name_ofs)
+				memmove((u8 *)a + name_ofs,
+						(u8 *)a + old_name_ofs,
+						a->name_length *
+							sizeof(__le16));
+			if (mp_ofs != old_mp_ofs)
+				memmove((u8 *)a + mp_ofs,
+						(u8 *)a + old_mp_ofs,
+						mp_size);
+		}
 	}
 
 	err = ntfs_attr_record_resize(m, a, arec_size);
-- 
2.25.1

