Received: from mailgw.kylinos.cn (mailgw.kylinos.cn [124.126.103.232])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E3ACA3148D0;
	Wed,  9 Sep 2026 02:48:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=124.126.103.232
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788922102; cv=none; b=m1oiRr3CctGNB9sA0gTB3RXrWtJ6kvqSpJDgw3B9qKJ1hxpjo1pbcfig4uUlZO4qu9YlZmPOEMg32hZ5TX32fXMvbzUt+WYu9hzfd6rrL9Wa++QqEtA4NgNIvzUJLRGtaRQOHRzyj1P/tvt9AoUYiUSNpCZK87nxGbLoHZqA7pU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788922102; c=relaxed/simple;
	bh=/i5rUaorm6lqTQKKWudnun2l8nXGGNqf71612WHwEOM=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=ZqPgItBEc95nQCu988s2TunxLbfENvbXy6dlABmPS7iZidLwBEHPbUVve5bJtIbCJEPBtyee1xfidrEi+wEK5P1Q9BfeJQirjiVpu+aG7jMRHKJdaEmmkRLH4wA5qw9VpBhCmprmZrpqC81oJmSQZnbeB8ULnBC2rHSgBvJQVys=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn; spf=pass smtp.mailfrom=kylinos.cn; arc=none smtp.client-ip=124.126.103.232
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kylinos.cn
X-UUID: e6a72d16abf811f19a56ed5b684f684d-20260909
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.3.19,REQID:4b132411-25d4-4bbf-9216-6a504bbada1f,IP:0,U
	RL:0,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION:
	release,TS:0
X-CID-META: VersionHash:7db8b62,CLOUDID:6c296e1216047ecfc7e122e09940215f,BulkI
	D:nil,BulkQuantity:0,SF:81|82|102|136|850|865|898,TC:nil,Content:0|15|50|9
	9,EDM:-3|-100,IP:nil,URL:0,File:nil,RT:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,O
	SI:0,OSA:0,AV:0,LES:1,SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0,ARC:0
X-CID-BVR: 2,SSN|SDN
X-CID-BAS: 2,SSN|SDN,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR
X-CID-RHF: D41D8CD98F00B204E9800998ECF8427E
X-UUID: e6a72d16abf811f19a56ed5b684f684d-20260909
X-User: zenghongling@kylinos.cn
Received: from localhost.localdomain [(10.44.16.150)] by mailgw.kylinos.cn
	(envelope-from <zenghongling@kylinos.cn>)
	(Generic MTA with TLSv1.3 TLS_AES_256_GCM_SHA384 256/256)
	with ESMTP id 1468862111; Wed, 09 Sep 2026 10:48:13 +0800
From: Hongling Zeng <zenghongling@kylinos.cn>
To: linkinjeon@kernel.org,
	hyc.lee@gmail.com
Cc: ntfs@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	zhongling0719@126.com,
	Hongling Zeng <zenghongling@kylinos.cn>,
	stable@vger.kernel.org
Subject: [PATCH v3 3/3] ntfs: NULL vol->vol_ino in the load_system_files() error teardown
Date: Wed,  9 Sep 2026 10:48:03 +0800
Message-Id: <20260909024803.810556-4-zenghongling@kylinos.cn>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20260909024803.810556-1-zenghongling@kylinos.cn>
References: <20260909024803.810556-1-zenghongling@kylinos.cn>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The error unwind of load_system_files() drops vol->vol_ino on two
paths but leaves the stale pointer in place while it keeps iput()ing
the remaining system inodes ($Bitmap, $MFT bitmap, $MFTMirr; $MFT
itself is dropped by the caller, ntfs_fill_super()).  A third path
carried an iput() that can never execute: it sits inside the
IS_ERR(vol->vol_ino) branch guarded by !IS_ERR(vol->vol_ino), and is
removed along with the stale pointers.  Nothing in the teardown
dereferences vol_ino today, so this is pure hygiene, but a stale
pointer to a freed inode surviving the unwind is a trap for any
future code walking the volume during teardown.

ntfs_put_super() and the ntfs_fill_super() error path already NULL it
after their iput(); do the same here.

Cc: stable@vger.kernel.org
Signed-off-by: Hongling Zeng <zenghongling@kylinos.cn>
---
 fs/ntfs/super.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/fs/ntfs/super.c b/fs/ntfs/super.c
index 4b4af1ea8b09..2d4132aa39d3 100644
--- a/fs/ntfs/super.c
+++ b/fs/ntfs/super.c
@@ -1541,8 +1541,7 @@ static bool load_system_files(struct ntfs_volume *vol)
 	 */
 	vol->vol_ino = ntfs_iget(sb, FILE_Volume);
 	if (IS_ERR(vol->vol_ino)) {
-		if (!IS_ERR(vol->vol_ino))
-			iput(vol->vol_ino);
+		vol->vol_ino = NULL;
 volume_failed:
 		ntfs_error(sb, "Failed to load $Volume.");
 		goto iput_lcnbmp_err_out;
@@ -1551,6 +1550,7 @@ static bool load_system_files(struct ntfs_volume *vol)
 	if (IS_ERR(m)) {
 iput_volume_failed:
 		iput(vol->vol_ino);
+		vol->vol_ino = NULL;
 		goto volume_failed;
 	}
 
@@ -1716,6 +1716,8 @@ static bool load_system_files(struct ntfs_volume *vol)
 	if (vol->logfile_ino)
 		iput(vol->logfile_ino);
 	iput(vol->vol_ino);
+	/* Do not leave a stale pointer behind for the rest of the teardown. */
+	vol->vol_ino = NULL;
 iput_lcnbmp_err_out:
 	iput(vol->lcnbmp_ino);
 iput_attrdef_err_out:
-- 
2.25.1

