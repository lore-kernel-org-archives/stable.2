Received: from mailgw.kylinos.cn (mailgw.kylinos.cn [124.126.103.232])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 21869363095;
	Mon, 14 Sep 2026 03:42:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=124.126.103.232
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789357334; cv=none; b=nUizIFqri/oq98vDCeE4LEv96TbpMpNRsGvqIw3dIejcoUhUvO8EWkRvc1pGkdbrzO9JiG3uudVTdOWNxgyh8Hpk5Lgtban1RWPQz3tFBHAoIzj+31TpkjzH/REqbEdodxUSPT1FQj5x6qIQVI4G5JYB/b8MgP5WTweZkYppBxo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789357334; c=relaxed/simple;
	bh=kkTR6F/wUkW+il1lGGH5wEVFKnviI8/3ctXCE0TZhJ8=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=eaTrwiUtlZ1kQAYRZ5SCCUFEIpgHf2cOdfr2UTEXaHU3ObdNWOIFsspdHr2+eByfBuXL9URF3LoD7j2pCY2NODyPP3/bCJIVThVZejPv2Ndhe5gWqj4U6o/NTNWGgNX/olEWmshvLk7VZTpKmJ0gDop6I2fTUeyL4eJowVoFyow=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn; spf=pass smtp.mailfrom=kylinos.cn; arc=none smtp.client-ip=124.126.103.232
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kylinos.cn
X-UUID: 4199fe26afee11f19a56ed5b684f684d-20260914
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.3.19,REQID:90b5acb6-eabd-44c5-a39b-8a8ec5087a4a,IP:0,U
	RL:0,TC:0,Content:-25,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTIO
	N:release,TS:-25
X-CID-META: VersionHash:7db8b62,CLOUDID:94ca796e3ccf2675eb6f445c78681014,BulkI
	D:nil,BulkQuantity:0,SF:102|136|850|865|898,TC:nil,Content:0|15|50|99,EDM:
	-3|-100,IP:nil,URL:0,File:nil,RT:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0,O
	SA:0,AV:0,LES:1,SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0,ARC:0
X-CID-BVR: 2,SSN|SDN
X-CID-BAS: 2,SSN|SDN,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR
X-CID-RHF: D41D8CD98F00B204E9800998ECF8427E
X-UUID: 4199fe26afee11f19a56ed5b684f684d-20260914
X-User: zenghongling@kylinos.cn
Received: from localhost.localdomain [(10.44.16.150)] by mailgw.kylinos.cn
	(envelope-from <zenghongling@kylinos.cn>)
	(Generic MTA with TLSv1.3 TLS_AES_256_GCM_SHA384 256/256)
	with ESMTP id 149147248; Mon, 14 Sep 2026 11:42:06 +0800
From: Hongling Zeng <zenghongling@kylinos.cn>
To: linkinjeon@kernel.org,
	hyc.lee@gmail.com
Cc: ntfs@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	zhongling0719@126.com,
	Hongling Zeng <zenghongling@kylinos.cn>,
	stable@vger.kernel.org
Subject: [PATCH] ntfs: mount hibernated volumes read-only regardless of  errors=
Date: Mon, 14 Sep 2026 11:42:02 +0800
Message-Id: <20260914034202.52011-1-zenghongling@kylinos.cn>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The hibernation check in load_system_files() only converts the
superblock to read-only under errors=remount-ro.  With the default
errors=continue (and with errors=panic), a hibernated volume is
mounted read-write and the mount-time $LogFile emptying writes to it,
although a hibernated volume must not be written to at all.

Drop the on_errors term so that a hibernated volume, or a volume whose
hibernation state cannot be determined, always mounts read-only.
NVolErrors() is still recorded, so ntfs_reconfigure() keeps refusing
remounts to read-write, and the $LogFile emptying is skipped by its
!sb_rdonly() check.

Cc: stable@vger.kernel.org
Signed-off-by: Hongling Zeng <zenghongling@kylinos.cn>
---
 fs/ntfs/super.c | 9 +++++++--
 1 file changed, 7 insertions(+), 2 deletions(-)

diff --git a/fs/ntfs/super.c b/fs/ntfs/super.c
index 2d4132aa39d3..fd7e5dbd1115 100644
--- a/fs/ntfs/super.c
+++ b/fs/ntfs/super.c
@@ -1660,8 +1660,13 @@ static bool load_system_files(struct ntfs_volume *vol)
 		const char *es1;
 
 		es1 = err < 0 ? es1a : es1b;
-		/* If a read-write mount, convert it to a read-only mount. */
-		if (!sb_rdonly(sb) && vol->on_errors == ON_ERRORS_REMOUNT_RO) {
+		/*
+		 * A Windows hibernation image is not a filesystem error, so
+		 * this is a safety interlock rather than something the
+		 * errors= policy may downgrade: always convert a read-write
+		 * mount to read-only.
+		 */
+		if (!sb_rdonly(sb)) {
 			sb->s_flags |= SB_RDONLY;
 			ntfs_error(sb, "%s.  Mounting read-only%s", es1, es2);
 		}
-- 
2.25.1

