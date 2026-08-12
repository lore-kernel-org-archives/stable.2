Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 71C7822ACFA
	for <stable@vger.kernel.org>; Wed, 12 Aug 2026 00:09:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786493389; cv=none; b=TNEEMc1hpac4Pz+NRIIrB2EIyWQ9Z9jACgtrhBsnMOvae9HORc8jmX9UWTUrLCfTcA2nE3pxEsItzpjjOM7umgrhsmMrG18vKGZMIYTo4S4pRxy2BkHOXm50xLVGlhrjbtFWuxdNgZDdQ6xGKfruS5/ApFM9dk3zgf+T+LWdNJ8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786493389; c=relaxed/simple;
	bh=qJp8xietwuSbA+lutpJFetGdJqn5BGNGgif8qgJC22s=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=t7uAh8jQ6MEW13U6HhnWEujF898/r4jJwg0ltGgRqec562HZmft+crhmZft7c1TrDTMioAMNMNqgkG/I8w/d77Azz2LgbKyZ8sc/ivCRx8x57NeAhCrPtjQaL9SB4KXe0MSo51XUVVV7HyUXsyTzRC4RUF8YHWCyEPwX5NpUEnw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=le2cXLdj; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="le2cXLdj"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 977421F00A3A;
	Wed, 12 Aug 2026 00:09:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786493388;
	bh=zZX0PqLYpYzQlErEoUdnTL3u7i2pJ9hMXkjQgtL3+ZM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=le2cXLdj2pySShaRrw41LaGddbnruTbBkHvxOr4di+i62e+8yGZ89+YDuT8NvdYXo
	 YQA6uQPSvtXL1PhTE19mLq9CtcmcaixrwWeAEM9tuRzLCyo1B7qi0TY8GNhs1sczFr
	 xtNy4IjDd+DM5w6VhT7zZY1ySjk4N3Opu2Flw3fJBEoZzHINyzEnen9dGea7jgvmJ0
	 l1VzMCFS/+gGW2yv3WKglE1o5jloZSJsLhqu71JWq3hGsr/y+zQSOjfZ1uhjupCghf
	 nHNlTbXCeB+Sf7zS9smuUDz003dB0qEZPZOGP48QF97xIGJEpmMGt6kHiXi0QOvWNf
	 tAcZDQTiC8uDA==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Damien Le Moal <damien.lemoal@opensource.wdc.com>,
	Himanshu Madhani <himanshu.madhani@oracle.com>,
	Douglas Gilbert <dgilbert@interlog.com>,
	Bart Van Assche <bvanassche@acm.org>,
	"Martin K. Petersen" <martin.petersen@oracle.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.15.y 4/6] scsi: sd: sd_zbc: Return early in sd_zbc_check_zoned_characteristics()
Date: Tue, 11 Aug 2026 20:09:39 -0400
Message-ID: <20260812000941.4158732-4-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260812000941.4158732-1-sashal@kernel.org>
References: <2026080556-pancake-criteria-119e@gregkh>
 <20260812000941.4158732-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Damien Le Moal <damien.lemoal@opensource.wdc.com>

[ Upstream commit 60caf3758103b8edc90724ba781ff119f739162a ]

Return early in sd_zbc_check_zoned_characteristics() for host-aware
disks. This patch does not change any functionality but makes a later patch
easier to read.

Link: https://lore.kernel.org/r/20220421183023.3462291-6-bvanassche@acm.org
Reviewed-by: Himanshu Madhani <himanshu.madhani@oracle.com>
Acked-by: Douglas Gilbert <dgilbert@interlog.com>
Signed-off-by: Damien Le Moal <damien.lemoal@opensource.wdc.com>
[ bvanassche: extracted this change from a larger patch ]
Signed-off-by: Bart Van Assche <bvanassche@acm.org>
Signed-off-by: Martin K. Petersen <martin.petersen@oracle.com>
Stable-dep-of: 93dde0bf2f39 ("scsi: scsi_debug: Fix REPORT ZONES alloc_len underflow OOB write")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/scsi/sd_zbc.c | 13 +++++++------
 1 file changed, 7 insertions(+), 6 deletions(-)

diff --git a/drivers/scsi/sd_zbc.c b/drivers/scsi/sd_zbc.c
index c41cfbaf8c63e..90d0f8ddd179c 100644
--- a/drivers/scsi/sd_zbc.c
+++ b/drivers/scsi/sd_zbc.c
@@ -593,14 +593,15 @@ static int sd_zbc_check_zoned_characteristics(struct scsi_disk *sdkp,
 		sdkp->zones_optimal_open = get_unaligned_be32(&buf[8]);
 		sdkp->zones_optimal_nonseq = get_unaligned_be32(&buf[12]);
 		sdkp->zones_max_open = 0;
-	} else {
-		/* Host-managed */
-		sdkp->urswrz = buf[4] & 1;
-		sdkp->zones_optimal_open = 0;
-		sdkp->zones_optimal_nonseq = 0;
-		sdkp->zones_max_open = get_unaligned_be32(&buf[16]);
+		return 0;
 	}
 
+	/* Host-managed */
+	sdkp->urswrz = buf[4] & 1;
+	sdkp->zones_optimal_open = 0;
+	sdkp->zones_optimal_nonseq = 0;
+	sdkp->zones_max_open = get_unaligned_be32(&buf[16]);
+
 	/*
 	 * Check for unconstrained reads: host-managed devices with
 	 * constrained reads (drives failing read after write pointer)
-- 
2.53.0

