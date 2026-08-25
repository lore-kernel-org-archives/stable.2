Received: from mailgw.kylinos.cn (mailgw.kylinos.cn [124.126.103.232])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 855C23F5BDB;
	Tue, 25 Aug 2026 09:54:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=124.126.103.232
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787651657; cv=none; b=X2WHupOSn5dNvMWxEOPhY4lPF7luKC5ZBQB3fo4dXPV+kI9MISiOTa79bzzti46h1H91Wz7OVDHkYtObFOmdWMmXRapDkdyeaV6lgCDM3X+/nEGbbwmaXcKsa9u/roJzbxQ7rw8xcBmTQTeIGs/2OTTYtrn1fb/ivp6BsVM2Lsk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787651657; c=relaxed/simple;
	bh=9VzUH3yQXpFtXHm7ZxHmWMtcLFl1q+qw7kcAIRn37H4=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=CYjsQX27/y8VlPO77LbajtQAeLs78t4BZdnLZuRpB1g9pc3pU4b6iOiGDRCLu/WfB8jK2jJxMGTr2wYFqPavzYagWLrJUvyWIStf4jvHoyWPlLdZUORF//XPUnlnDo1WFdOj8sDFD/mYic3Da6fC3kLZrcSLlNFdBQNw3JhAxiI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn; spf=pass smtp.mailfrom=kylinos.cn; arc=none smtp.client-ip=124.126.103.232
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kylinos.cn
X-UUID: eab5e56ca06a11f19a56ed5b684f684d-20260825
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.3.19,REQID:3d8f985e-fdd4-45c7-8c88-0b9d3a8b262d,IP:0,U
	RL:0,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION:
	release,TS:0
X-CID-META: VersionHash:7db8b62,CLOUDID:840bb7b4110cd749ec60fbbc926f4b1a,BulkI
	D:nil,BulkQuantity:0,SF:102|850|865|898,TC:nil,Content:0|15|50,EDM:-3,IP:n
	il,URL:0,File:nil,RT:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0,OSA:0,AV:0,LE
	S:1,SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0,ARC:0
X-CID-BVR: 2,SSN|SDN
X-CID-BAS: 2,SSN|SDN,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR
X-CID-RHF: D41D8CD98F00B204E9800998ECF8427E
X-UUID: eab5e56ca06a11f19a56ed5b684f684d-20260825
X-User: zenghongling@kylinos.cn
Received: from localhost.localdomain [(10.44.16.150)] by mailgw.kylinos.cn
	(envelope-from <zenghongling@kylinos.cn>)
	(Generic MTA with TLSv1.3 TLS_AES_256_GCM_SHA384 256/256)
	with ESMTP id 1235446033; Tue, 25 Aug 2026 17:54:08 +0800
From: Hongling Zeng <zenghongling@kylinos.cn>
To: linkinjeon@kernel.org,
	hyc.lee@gmail.com
Cc: ntfs@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	zhongling0719@126.com,
	Hongling Zeng <zenghongling@kylinos.cn>,
	stable@vger.kernel.org
Subject: [PATCH] ntfs: fix undefined behavior in mft/index record size calculation
Date: Tue, 25 Aug 2026 17:54:05 +0800
Message-Id: <20260825095405.858623-1-zenghongling@kylinos.cn>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The boot sector validation allows clusters_per_mft_record and
clusters_per_index_record to range from 0xE1 (-31) to 0xF7 (-9) when
interpreted as signed values. When these are used as negative shift
counts in expressions like `1 << -clusters_per_mft_record`, values
like 0xE1 cause `1 << 31`, which shifts into the sign bit of a 32-bit
signed integer, resulting in undefined behavior.

Fix by using unsigned shift (1U << ...) instead of signed shift.
This prevents undefined behavior while preserving the full valid
range of negative values (-31 to -9) that may appear in NTFS boot
sectors.

The encoding scheme uses negative values to represent record sizes
smaller than cluster_size: -log2(record_size). Common values include
-10 (1024 bytes) for mft_record_size and -12 (4096 bytes) for
index_record_size.

Fixes: 1da177e4c3f4 ("Linux-2.6.12-rc2")
Cc: stable@vger.kernel.org
Signed-off-by: Hongling Zeng <zenghongling@kylinos.cn>
---
 fs/ntfs/super.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/fs/ntfs/super.c b/fs/ntfs/super.c
index 30481e5d5dd4..a1813093222b 100644
--- a/fs/ntfs/super.c
+++ b/fs/ntfs/super.c
@@ -695,7 +695,7 @@ static bool parse_ntfs_boot_sector(struct ntfs_volume *vol,
 		 * = -log2(mft_record_size) bytes. mft_record_size normaly is
 		 * 1024 bytes, which is encoded as 0xF6 (-10 in decimal).
 		 */
-		vol->mft_record_size = 1 << -clusters_per_mft_record;
+		vol->mft_record_size = 1U << -clusters_per_mft_record;
 	vol->mft_record_size_mask = vol->mft_record_size - 1;
 	vol->mft_record_size_bits = ffs(vol->mft_record_size) - 1;
 	ntfs_debug("vol->mft_record_size = %i (0x%x)", vol->mft_record_size,
@@ -732,7 +732,7 @@ static bool parse_ntfs_boot_sector(struct ntfs_volume *vol,
 		 * index_record_size normaly equals 4096 bytes, which is
 		 * encoded as 0xF4 (-12 in decimal).
 		 */
-		vol->index_record_size = 1 << -clusters_per_index_record;
+		vol->index_record_size = 1U << -clusters_per_index_record;
 	vol->index_record_size_mask = vol->index_record_size - 1;
 	vol->index_record_size_bits = ffs(vol->index_record_size) - 1;
 	ntfs_debug("vol->index_record_size = %i (0x%x)",
-- 
2.25.1

