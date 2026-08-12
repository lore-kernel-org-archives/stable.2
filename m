Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DCDAD403AE0
	for <stable@vger.kernel.org>; Wed, 12 Aug 2026 09:11:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786525921; cv=none; b=ZXWCdKePN+Ep/vN76+kUGYUke1P1XR1YnFAsTQbDutzl3Xd3uf54HSDSTJyTxzTChlsXapi8hPaeMQf30ChZp4aruSiIjAHBDHwS4yMzpALVDH0NzYqRu239iAuwzzoD/m+GnpNVkUJFG4eDa9j5tgMI5UYOG5PIFHG5mfF/VIo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786525921; c=relaxed/simple;
	bh=hTuSLtDnil1/lr415irPw/HS4+0ctZWr4X8lSd3IB4E=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=gKNjfY5iTKW7Y01Os/tl3uQsjYci4e59geqevxllrbHQ//MWTFmEbWmpdmSWHJGFSUbuSedQp/N3xZRV5Jgw2SSQI7mtGiyAHYDkyfhyHR+vLaFabbfxQsuBEvwt64pYKETtTYwE/jTXzOvgTPoS3bdjg+EclOResGkc82BhDXc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=IHe2tndW; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="IHe2tndW"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 87C9B1F00A3F;
	Wed, 12 Aug 2026 09:11:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786525918;
	bh=kkzj+AnaPX0tr4c/wKXMAAEFqe9lyQSdpY2VrOX2EdQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=IHe2tndWl9B0JK0db1aAA29LIC7KBtyHVUQSXTJpCuitzJDqPAmVa/w1mCfxOo+oi
	 /86gVwZQeJHT4RAJ6LoG3RAQn5wthZS28fhbJo2Un3IjBf2pKHvzXNxlVB+w7vZiSm
	 Z+Mn1QdSelmSyys1khKm/kxtQCRyZwHZWW9hd89kxoK5D2MJraaLwBN4HB5vF7v73w
	 2aw1n4I6ggzSQYb2BJx+sQGcj9OQnx8fCav1Rf906herLJxrHmrV3Ksli6DkX60Aae
	 OSC3nIERioNuHyGLnM/OTY7MbyLg9iypXogcbFUaXIe3woUMBSDDGmSkhZymjdWevq
	 Y90lVzt5iFKBA==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Damien Le Moal <damien.lemoal@opensource.wdc.com>,
	Himanshu Madhani <himanshu.madhani@oracle.com>,
	Douglas Gilbert <dgilbert@interlog.com>,
	Bart Van Assche <bvanassche@acm.org>,
	"Martin K. Petersen" <martin.petersen@oracle.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.10.y 3/5] scsi: sd: sd_zbc: Return early in sd_zbc_check_zoned_characteristics()
Date: Wed, 12 Aug 2026 05:11:51 -0400
Message-ID: <20260812091153.1357339-3-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260812091153.1357339-1-sashal@kernel.org>
References: <2026080556-overlap-everybody-5524@gregkh>
 <20260812091153.1357339-1-sashal@kernel.org>
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
index 5f905d13b911d..d5991d905d5f7 100644
--- a/drivers/scsi/sd_zbc.c
+++ b/drivers/scsi/sd_zbc.c
@@ -591,14 +591,15 @@ static int sd_zbc_check_zoned_characteristics(struct scsi_disk *sdkp,
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

