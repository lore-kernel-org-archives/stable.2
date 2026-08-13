Received: from mailgw.kylinos.cn (mailgw.kylinos.cn [124.126.103.232])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3767E451998;
	Thu, 13 Aug 2026 09:41:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=124.126.103.232
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786614107; cv=none; b=kOQ0Qmx0h/0+O4GNqfxfZcZVh7Umbf7ijCYp2Fe/BoWX0h0OA6tGy4FU/0PDckRgwNl6r/7MfBqnrF+rXWp+DVvRupuvFEVkRSqEAHTWImtYUP7yLfABHvXPq0IGPNrc5vDuAnrseimGG7J2CCbOQRMes6xvFfgB1R3xOodd0ZA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786614107; c=relaxed/simple;
	bh=lYbxm2sxqB5dmU88548SlO7/BNEpx7RGWcVvtAaPdQM=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=HZcdFuFZ3LIlf+wdV6Ffg7USCAf24fXYoL82PfTC6xJzb7InS8GqL/376Em/X/2DhrHO5uJK0Yj1KF36Re8/h5LcVSsgcbVoRiMK8pcuEphHZoqvE4XAtS4NqaKKbiKijMCAMGHlOEW+6jnXAAO8+pbVA3QNExFnZdQdQPhM1Rs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn; spf=pass smtp.mailfrom=kylinos.cn; arc=none smtp.client-ip=124.126.103.232
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kylinos.cn
X-UUID: 2be2944696fb11f1aa26b74ffac11d73-20260813
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.3.12,REQID:511f3c6c-18c2-4676-8f59-1c2e8c8e9c5a,IP:0,U
	RL:0,TC:0,Content:-5,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION
	:release,TS:-5
X-CID-META: VersionHash:e7bac3a,CLOUDID:f30c9d9a1f25e945f2811947f4e1d45a,BulkI
	D:nil,BulkQuantity:0,Recheck:0,SF:102|850|865|898,TC:nil,Content:0|15|50,E
	DM:-3,IP:nil,URL:0,File:nil,RT:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0,OSA
	:0,AV:0,LES:1,SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0,ARC:0
X-CID-BVR: 2,SSN|SDN
X-CID-BAS: 2,SSN|SDN,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR
X-CID-RHF: D41D8CD98F00B204E9800998ECF8427E
X-UUID: 2be2944696fb11f1aa26b74ffac11d73-20260813
X-User: zenghongling@kylinos.cn
Received: from localhost.localdomain [(10.44.16.150)] by mailgw.kylinos.cn
	(envelope-from <zenghongling@kylinos.cn>)
	(Generic MTA with TLSv1.3 TLS_AES_256_GCM_SHA384 256/256)
	with ESMTP id 85195721; Thu, 13 Aug 2026 17:41:34 +0800
From: Hongling Zeng <zenghongling@kylinos.cn>
To: almaz.alexandrovich@paragon-software.com
Cc: ntfs3@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	zhongling0719@126.com,
	Hongling Zeng <zenghongling@kylinos.cn>,
	stable@vger.kernel.org
Subject: [PATCH v2] ntfs3: fix buffer overflow in CreateAttribute validation
Date: Thu, 13 Aug 2026 17:41:29 +0800
Message-Id: <20260813094129.1366996-1-zenghongling@kylinos.cn>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

In the CreateAttribute action, the validation checks whether dlen
fits within the available MFT record space, but the actual memcpy
uses asize (the attribute size from the log record) as the copy length.

A malicious NTFS journal record can set a small dlen to pass the
validation while setting a large asize that exceeds the MFT record
buffer size, causing a buffer overflow when memcpy copies asize bytes
into the destination buffer.

The validation must use the same size that is later passed to memcpy().

Fix this by using asize in the bounds check instead of dlen, since
asize is the actual length used by memcpy. The source buffer boundary
is already validated by the existing check:
      Add2Ptr(attr2, asize) > Add2Ptr(lrh, rec_len)

Fixes: b46acd6a6a62 ("fs/ntfs3: Add NTFS journal")
Cc: stable@vger.kernel.org
Signed-off-by: Hongling Zeng <zenghongling@kylinos.cn>
---
Change in v2:
 Also fix the lower bound check to use asize instead of dlen. A malicious
 log record with dlen >= 24 (passing dlen < SIZE_OF_RESIDENT check) but
 asize < 24 could allocate insufficient memory and trigger OOB accesses
 in subsequent operations.
---
 fs/ntfs3/fslog.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/fs/ntfs3/fslog.c b/fs/ntfs3/fslog.c
index 3440212ecb12..e15f7621863e 100644
--- a/fs/ntfs3/fslog.c
+++ b/fs/ntfs3/fslog.c
@@ -3285,10 +3285,10 @@ static int do_action(struct ntfs_log *log, struct OPEN_ATTR_ENRTY *oe,
 		asize = le32_to_cpu(attr2->size);
 		used = le32_to_cpu(rec->used);
 
-		if (!check_if_attr(rec, lrh) || dlen < SIZEOF_RESIDENT ||
+		if (!check_if_attr(rec, lrh) || asize < SIZEOF_RESIDENT ||
 		    !IS_ALIGNED(asize, 8) ||
 		    Add2Ptr(attr2, asize) > Add2Ptr(lrh, rec_len) ||
-		    dlen > record_size - used) {
+		    asize > record_size - used) {
 			goto dirty_vol;
 		}
 
-- 
2.25.1

