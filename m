Received: from mailgw.kylinos.cn (mailgw.kylinos.cn [124.126.103.232])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EF0313DAAA9;
	Wed,  5 Aug 2026 06:46:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=124.126.103.232
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785912375; cv=none; b=bvUgudiChsiq+gDLY0QqxQsUsVfk1ULGw37fh2XNQCZQjyT7RQJIS+q9Apenu4oXu7lDNSJUfa+3f8NhPofDxiiEh1XvKBi/pVInYzPWFqWfB5Ce90Z1w5riHDIqNswTPFuF8KTEFk6Vk6uflTP2KrNIsYIXPX0MWCaJbGk+NCU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785912375; c=relaxed/simple;
	bh=EZzVDRZlm0r9mXg1kJE5fBb4EwmvJ4LhXh5cy9MTw+Y=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=FNXgdSH7JEzBa+it7pc5dgilrmIAJA/GnXRcL4LXt6Hvybt4MakjC9SwRZDnDJvCtWUyZdXdGJNWkySYCj+0/CG/MtROKrFv70Jl4C5oyBNEtFt/QZSDm6m5foXcKA28NW9R7jjHgGvEjE03Q/e99SosuNguHo1eLbxPrh3MUio=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn; spf=pass smtp.mailfrom=kylinos.cn; arc=none smtp.client-ip=124.126.103.232
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kylinos.cn
X-UUID: 540fb074909911f1aa26b74ffac11d73-20260805
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.3.12,REQID:0735a918-af37-4926-9645-e4db56151539,IP:0,U
	RL:0,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION:
	release,TS:0
X-CID-META: VersionHash:e7bac3a,CLOUDID:5a1aa0cdd6cbcd26617290f0d5efd721,BulkI
	D:nil,BulkQuantity:0,Recheck:0,SF:102|850|865|898,TC:nil,Content:0|15|50,E
	DM:-3,IP:nil,URL:0,File:nil,RT:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0,OSA
	:0,AV:0,LES:1,SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0,ARC:0
X-CID-BVR: 2,SSN|SDN
X-CID-BAS: 2,SSN|SDN,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR
X-CID-RHF: D41D8CD98F00B204E9800998ECF8427E
X-UUID: 540fb074909911f1aa26b74ffac11d73-20260805
X-User: zenghongling@kylinos.cn
Received: from localhost.localdomain [(10.44.16.150)] by mailgw.kylinos.cn
	(envelope-from <zenghongling@kylinos.cn>)
	(Generic MTA with TLSv1.3 TLS_AES_256_GCM_SHA384 256/256)
	with ESMTP id 196308775; Wed, 05 Aug 2026 14:46:03 +0800
From: Hongling Zeng <zenghongling@kylinos.cn>
To: almaz.alexandrovich@paragon-software.com
Cc: ntfs3@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	zhongling0719@126.com,
	Hongling Zeng <zenghongling@kylinos.cn>,
	stable@vger.kernel.org
Subject: [PATCH] ntfs3: fix mapping pairs bounds check for alignment
Date: Wed,  5 Aug 2026 14:45:59 +0800
Message-Id: <20260805064559.53060-1-zenghongling@kylinos.cn>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

In the UpdateMappingPairs action, the expansion check compares the
unaligned new attribute size with the available record space. The new
size is aligned to an 8-byte boundary before the mapping pairs are
updated, so the check can underestimate the required space by up to
seven bytes.

Use the aligned size in the expansion check to ensure that the
subsequent update cannot exceed the available record space.

Fixes: b46acd6a6a62 ("fs/ntfs3: Add NTFS journal")
Cc: stable@vger.kernel.org
Signed-off-by: Hongling Zeng <zenghongling@kylinos.cn>
---
 fs/ntfs3/fslog.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/fs/ntfs3/fslog.c b/fs/ntfs3/fslog.c
index cc24c23e4db9..3440212ecb12 100644
--- a/fs/ntfs3/fslog.c
+++ b/fs/ntfs3/fslog.c
@@ -3388,7 +3388,8 @@ static int do_action(struct ntfs_log *log, struct OPEN_ATTR_ENRTY *oe,
 
 		if (!check_if_attr(rec, lrh) || !attr->non_res ||
 		    aoff < le16_to_cpu(attr->nres.run_off) || aoff > asize ||
-		    (nsize > asize && nsize - asize > record_size - used)) {
+		    (nsize > asize &&
+		     ALIGN(nsize, 8) - asize > record_size - used)) {
 			goto dirty_vol;
 		}
 
-- 
2.25.1

