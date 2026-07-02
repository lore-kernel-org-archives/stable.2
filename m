Received: from mailgw.kylinos.cn (mailgw.kylinos.cn [124.126.103.232])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8EE9C2D0602;
	Thu,  2 Jul 2026 03:37:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=124.126.103.232
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782963431; cv=none; b=bh5LPAz7VTARDX78SewaH0ImOZHUCVAbMiSLzH20ztHGqU/yRdzum+AeJG5pYkkNSd+cgJQLpaDjz4k6co+gk8usMzsGaBZKvg5ZrA594wtujDgSPQMNTX0IRTbWVq9ePOXeqzPosqmPTFzgiWrE0fOqp2izewXr1IyhQojmM0E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782963431; c=relaxed/simple;
	bh=usuKir4LrXS8zKa8d1qjs74NKCCAe9vYkvZCvZk1TPM=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=S4B4K/N98/MEw5Z0vLJiuyJhw44mNqSRdbQBPJElEvwxg8XxPFBujIE9RtHk17Ts2epteifltg/nndR10shHk2hSaLwP1JSy6reuyZz4WYqHJC3wGqEN+Yq5iAKmpw7R+QZLRUa/aoa6lL00q8yd6QX8oZGXzg34NoSRJr7Pu8Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn; spf=pass smtp.mailfrom=kylinos.cn; arc=none smtp.client-ip=124.126.103.232
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kylinos.cn
X-UUID: 48cdeeb675c711f1aa26b74ffac11d73-20260702
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.3.12,REQID:6010c4bf-d519-40d2-8300-64e5702de31d,IP:0,U
	RL:0,TC:0,Content:-5,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION
	:release,TS:-5
X-CID-META: VersionHash:e7bac3a,CLOUDID:d4c84d72fc2ae16fb3e4124b21550943,BulkI
	D:nil,BulkQuantity:0,Recheck:0,SF:102|136|850|865|898,TC:nil,Content:0|15|
	50,EDM:-3,IP:nil,URL:0,File:nil,RT:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0
	,OSA:0,AV:0,LES:1,SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0,ARC:0
X-CID-BVR: 2,SSN|SDN
X-CID-BAS: 2,SSN|SDN,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR
X-CID-RHF: D41D8CD98F00B204E9800998ECF8427E
X-UUID: 48cdeeb675c711f1aa26b74ffac11d73-20260702
X-User: zenghongling@kylinos.cn
Received: from localhost.localdomain [(10.44.16.150)] by mailgw.kylinos.cn
	(envelope-from <zenghongling@kylinos.cn>)
	(Generic MTA with TLSv1.3 TLS_AES_256_GCM_SHA384 256/256)
	with ESMTP id 1027932102; Thu, 02 Jul 2026 11:37:00 +0800
From: Hongling Zeng <zenghongling@kylinos.cn>
To: linkinjeon@kernel.org,
	hyc.lee@gmail.com,
	charsyam@gmail.com
Cc: linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	zhongling0719@126.com,
	Hongling Zeng <zenghongling@kylinos.cn>,
	stable@vger.kernel.org
Subject: [PATCH] ntfs: validate error codes in check_windows_hibernation_status()
Date: Thu,  2 Jul 2026 11:36:56 +0800
Message-Id: <20260702033656.23048-1-zenghongling@kylinos.cn>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

check_windows_hibernation_status() calls ntfs_lookup_inode_by_name()
which returns MFT references read directly from disk (untrusted data).
The current code extracts error codes via MREF_ERR() without proper
validation, allowing maliciously crafted NTFS images to trigger
incorrect error handling.

The MFT reference encoding uses bit 47 as an error indicator, but the
lower 32 bits can contain arbitrary values. If a malicious image sets
the error bit with a positive integer (e.g., 1), MREF_ERR() returns
that positive value. This can cause the function to incorrectly
interpret the error as "Windows is hibernated" status, potentially
leading to the filesystem being mounted read-only (denial of service).

Fix by strictly validating error codes: only accept negative values
in the valid errno range [-MAX_ERRNO, -1]. Convert all other values
(positive, zero, or out-of-range) to -EIO to indicate disk corruption.

This prevents potential security issues and ensures proper error handling
for corrupted or malicious NTFS filesystems.

Fixes: 1e9ea7e04472d ("Revert \"fs: Remove NTFS classic\"")
Cc: stable@vger.kernel.org
Signed-off-by: Hongling Zeng <zenghongling@kylinos.cn>
---
 fs/ntfs/super.c | 13 ++++++++++---
 1 file changed, 10 insertions(+), 3 deletions(-)

diff --git a/fs/ntfs/super.c b/fs/ntfs/super.c
index 8abe7bee4c0d..78f7e9fa76a0 100644
--- a/fs/ntfs/super.c
+++ b/fs/ntfs/super.c
@@ -1168,9 +1168,16 @@ static int check_windows_hibernation_status(struct ntfs_volume *vol)
 			ntfs_debug("hiberfil.sys not present.  Windows is not hibernated on the volume.");
 			return 0;
 		}
-		/* A real error occurred. */
-		ntfs_error(vol->sb, "Failed to find inode number for hiberfil.sys.");
-		return ret;
+		/* Validate error code from untrusted disk data. */
+		if (ret < 0 && ret >= -MAX_ERRNO) {
+			ntfs_error(vol->sb, "Failed to find inode number for hiberfil.sys.");
+			return ret;
+		}
+		/* Invalid error code indicates disk corruption. */
+		ntfs_error(vol->sb,
+			"hiberfil.sys lookup returned invalid error code %i, treating as disk corruption.",
+				ret);
+		return -EIO;
 	}
 	/* Get the inode. */
 	vi = ntfs_iget(vol->sb, MREF(mref));
-- 
2.25.1

