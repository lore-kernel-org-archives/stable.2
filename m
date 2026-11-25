Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795630390;
	b=p7EDPjYA+ObR56ZH5XZlwpNGniucizmbPvINhksSDY2lNHNxyM1m5fndQttr0PxarTTk
	 yeDscpsgJWsndNO5FF/T02t784iOWD8I14QDSnlIFBPsG/FTOyzPkX6Z4jSqNGANsMW0P
	 vMSpV0HWOzffWofW9XGG74guAB+aFoEiz0/wlUpCahFHUjHGvGA8XCCCGVmZK4OF0xpou
	 Pwr5jiUoSQ8KriYjqR87uK+MEIzHWVZp4hXPrHzcC4RDMXR+FLAYumD0AVQJUJex6B8WZ
	 KLBmNjcqFFfw7kJUBs7n4/EDxuc6/Tj1hGPG55G8kTuIOxICyIMEC0ftM5F3IcbfDCQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795630390;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=RTHsqjL1eHZ0/U3iiEl3DylzC4Vh+i1bHMjAZ/i+c74=;
	b=1hmXD7vtF69juJBvZSfMMr6f1ADWfshib8rv36V/LsXqn4Q7bIpVn61qln+FNVkcvr6Z
	 0YrrjlN/79X/b1yFa/bDigj3IMlPVoTC1vqV6Nc3I42DbEna+KEarubwlSndVTzQ9miks
	 4XQxR9Z5tzzNuZM8daIfUzqoijwOk2qbY15cotp+ERQIQRlw21tYvVCI7mTsFlFlC3CwC
	 SfgTVI3Gxi+lohYRnBqdhRF8CQC2hSp3008v1Y38MXKfleLCuiHYtI5D+kmY4Xhbp2IKu
	 pxszR5s80VT6ZtonfuytIqouXGo5mPR2/RgQKMVoNxJsXXt/46p5htc3YiyjeGw4R2w==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=KLcK4czL;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D20CA60A2625
	for <stable@vger.kernel.org>; Wed, 25 Nov 2026 18:13:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=KLcK4czL
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F11FC1F01577;
	Wed, 25 Nov 2026 18:13:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795630390;
	bh=RTHsqjL1eHZ0/U3iiEl3DylzC4Vh+i1bHMjAZ/i+c74=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=KLcK4czL9DXEBs8xfPKSSXtTNjnMCs/1FMT+Qs2bQWalJ4B/3hS9nFIatb/ArS+W8
	 8DOvSxvgf0BGL789ir+b6pK0tFzW8xXxxIv68hrZzppmcYzsig4GrtgvWW4yVdtfO1
	 J0ZcWRAhN8Fqpw8ExfH7Ns7q2UvaN00myZp0/mRJIqxtMTJgX6Pc6D3SUVgKtHg9ew
	 sNq7whWy/42hua3UA6jNFtxNsXF0auSCbWtIQ8qBNvI6HLdCZZb4xpfRcTDTb6Puba
	 deJekzvSdzgr2miTIPW2pfdfp+kATwn8jJzrWRCX68m9iwRJ0e4RGes95zO9HUDwd6
	 /07PsiaIX99UQ==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Heiko Carstens <hca@linux.ibm.com>,
	Stefan Haberland <sth@linux.ibm.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.15.y 4/7] s390/dasd_eckd: fix virtual vs physical address confusion
Date: Wed, 25 Nov 2026 13:13:00 -0500
Message-ID: <20261125181227.1137399-4-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261125181227.1137399-1-sashal@kernel.org>
References: <2026112516-snowbound-attentive-b141@gregkh>
 <20261125181227.1137399-1-sashal@kernel.org>
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Heiko Carstens <hca@linux.ibm.com>

[ Upstream commit 99aea41a4d11506c634000e234e0e1a707bd402d ]

Fix virtual vs physical address confusion. This does not fix a bug
since virtual and physical address spaces are currently the same.

Reviewed-by: Stefan Haberland <sth@linux.ibm.com>
Signed-off-by: Heiko Carstens <hca@linux.ibm.com>
Stable-dep-of: 25cdc1f63227 ("s390/dasd: Re-initialize RCD buffer with "V1.0" before every start")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/s390/block/dasd_eckd.c |  4 ++--
 drivers/s390/block/dasd_fba.c  | 12 ++++++------
 2 files changed, 8 insertions(+), 8 deletions(-)

diff --git a/drivers/s390/block/dasd_eckd.c b/drivers/s390/block/dasd_eckd.c
index e062d779be2b2..3eb2f460fc37b 100644
--- a/drivers/s390/block/dasd_eckd.c
+++ b/drivers/s390/block/dasd_eckd.c
@@ -6174,14 +6174,14 @@ static int dasd_eckd_query_pprc_status(struct dasd_device *device,
 	ccw->count = sizeof(struct dasd_psf_prssd_data);
 	ccw->flags |= CCW_FLAG_CC;
 	ccw->flags |= CCW_FLAG_SLI;
-	ccw->cda = (__u32)(addr_t)prssdp;
+	ccw->cda = (__u32)virt_to_phys(prssdp);
 
 	/* Read Subsystem Data - query host access */
 	ccw++;
 	ccw->cmd_code = DASD_ECKD_CCW_RSSD;
 	ccw->count = sizeof(*pprc_data);
 	ccw->flags |= CCW_FLAG_SLI;
-	ccw->cda = (__u32)(addr_t)pprc_data;
+	ccw->cda = (__u32)virt_to_phys(pprc_data);
 
 	cqr->buildclk = get_tod_clock();
 	cqr->status = DASD_CQR_FILLED;
diff --git a/drivers/s390/block/dasd_fba.c b/drivers/s390/block/dasd_fba.c
index e60c895f3293a..ee6d064b213d5 100644
--- a/drivers/s390/block/dasd_fba.c
+++ b/drivers/s390/block/dasd_fba.c
@@ -701,7 +701,7 @@ dasd_fba_dump_sense(struct dasd_device *device, struct dasd_ccw_req * req,
 		for (count = 0; count < 32 && count < act->count;
 		     count += sizeof(int))
 			len += sprintf(page + len, " %08X",
-				       ((int *) (addr_t) act->cda)
+				       ((int *)phys_to_virt(act->cda))
 				       [(count>>2)]);
 		len += sprintf(page + len, "\n");
 		act++;
@@ -710,18 +710,18 @@ dasd_fba_dump_sense(struct dasd_device *device, struct dasd_ccw_req * req,
 
 	/* print failing CCW area */
 	len = 0;
-	if (act <  ((struct ccw1 *)(addr_t) irb->scsw.cmd.cpa) - 2) {
-		act = ((struct ccw1 *)(addr_t) irb->scsw.cmd.cpa) - 2;
+	if (act < ((struct ccw1 *)phys_to_virt(irb->scsw.cmd.cpa)) - 2) {
+		act = ((struct ccw1 *)phys_to_virt(irb->scsw.cmd.cpa)) - 2;
 		len += sprintf(page + len, "......\n");
 	}
-	end = min((struct ccw1 *)(addr_t) irb->scsw.cmd.cpa + 2, last);
+	end = min((struct ccw1 *)phys_to_virt(irb->scsw.cmd.cpa) + 2, last);
 	while (act <= end) {
 		len += sprintf(page + len, "CCW %px: %08X %08X DAT:",
 			       act, ((int *) act)[0], ((int *) act)[1]);
 		for (count = 0; count < 32 && count < act->count;
 		     count += sizeof(int))
 			len += sprintf(page + len, " %08X",
-				       ((int *) (addr_t) act->cda)
+				       ((int *)phys_to_virt(act->cda))
 				       [(count>>2)]);
 		len += sprintf(page + len, "\n");
 		act++;
@@ -738,7 +738,7 @@ dasd_fba_dump_sense(struct dasd_device *device, struct dasd_ccw_req * req,
 		for (count = 0; count < 32 && count < act->count;
 		     count += sizeof(int))
 			len += sprintf(page + len, " %08X",
-				       ((int *) (addr_t) act->cda)
+				       ((int *)phys_to_virt(act->cda))
 				       [(count>>2)]);
 		len += sprintf(page + len, "\n");
 		act++;
-- 
2.53.0

