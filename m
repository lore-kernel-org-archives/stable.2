Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795630026;
	b=fdsav2RrQjd13P7OvaEDE82s0ISUr4Dyg0PeSCHmz5bSkFf/rFG1K2YrwWlTup7ChKi4
	 t5oL6Vf2T/AU4p3TDb9NcqixR/SDz7AWVPDT31PiwpvidUVrZtbhxa6SCdhwGiCKshze+
	 225WoJhwmPTXTP/6WatoAZLm0l1trRNeGWmTQCRUjTduJyoCbe2HYL61+SVS462H7z7k3
	 8v9Wi+LXQX/8pnd7qG3i+EMh5KiVapKv2f2+RoxfKTlu1dhsXJdSq+MCvYkpCZLT96vnD
	 hRpSShbXa9dCAiLqUoZOI7pHfOztSbyioPrHUzbtTPyIwVxNyfy1/FXE5k45GTOMJoA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795630026;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=0VJUjR9SbFg46TsNXR+T8RiJhSr3TYoFSLOPgXRGNHM=;
	b=3d6sBiW01Ie+pY9HjhNOoq01/uSIkevGBf+rOW/f+7pMnyp1FTfKPwKFjSLw7+DkadkX
	 Gc285vbWLnk+XaRDMv8Mtbof/v3iLRV8W7dwaeWNepVCKB4rYH8H0fEYgCD1jPaudg+5g
	 553/Ix1dt5bA6qVZ2igv6B3L64idoHvDf5/Gi6pL27cGWaXSlJWTYSc1x3qpcvolZb19Y
	 rIS7TamXsxVzVHE+ElHfClF5Xn8FR8ygz2Nk9jOl9itD+9LpxWTQYfVkUnABqRi7z/+FP
	 6ZpSowQnso8E0y+Dcf+R214fNk7/mYNhatp+wrDrYE+/RWdWmolEB76yUIvNUYjKuVQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=kMAut4fP;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 373A7606A326
	for <stable@vger.kernel.org>; Wed, 25 Nov 2026 18:07:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=kMAut4fP
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C1ADA1F000C6;
	Wed, 25 Nov 2026 18:07:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795630025;
	bh=0VJUjR9SbFg46TsNXR+T8RiJhSr3TYoFSLOPgXRGNHM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=kMAut4fPw9Hib7QM550ScRQZ3eZuredBeYQMHxAD9N1rju6q2bDt8uZu0f4KmXzKx
	 rJ1bCnhn7l0fULBwL4qtBM7fmJLpqh6tNXhyhPPzvhGbPhZ0aahv6Fl5bWUG3KaYPE
	 Qvh+GoXhs61jTPRJMaWzd4b0u8v1+TqRbP7P6uZYedNyclPOMcwpgOr/AnYYF/TqjG
	 Nr7JONqj3ZOKdzpIFw07S3eMdz/cZOoY4dWN2C2xFO8Z7/sT96lWx48KNBLdkKR0i3
	 SSesd8gw80Wm51J+MXBLUWbEfVtpGyAJOLj/qH0YAQuGc+631huWx0cBZIGbYGUihO
	 9JbbcP6Fmboxw==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Heiko Carstens <hca@linux.ibm.com>,
	Stefan Haberland <sth@linux.ibm.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.1.y 4/6] s390/dasd: use new address translation helpers
Date: Wed, 25 Nov 2026 13:06:56 -0500
Message-ID: <20261125180617.1129141-4-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261125180617.1129141-1-sashal@kernel.org>
References: <2026112516-sculpture-facial-ba8e@gregkh>
 <20261125180617.1129141-1-sashal@kernel.org>
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

[ Upstream commit c0bd39601c13ab08e961d77a90dfeeff56056353 ]

Use virt_to_dma32() and friends to properly convert virtual to physical and
physical to virtual addresses so that "make C=1" does not generate any
warnings anymore.

Reviewed-by: Stefan Haberland <sth@linux.ibm.com>
Signed-off-by: Heiko Carstens <hca@linux.ibm.com>
Stable-dep-of: 25cdc1f63227 ("s390/dasd: Re-initialize RCD buffer with "V1.0" before every start")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/s390/block/dasd.c          |  4 +-
 drivers/s390/block/dasd_3990_erp.c | 14 ++---
 drivers/s390/block/dasd_alias.c    |  6 +-
 drivers/s390/block/dasd_eckd.c     | 98 +++++++++++++++---------------
 drivers/s390/block/dasd_eer.c      |  2 +-
 drivers/s390/block/dasd_fba.c      | 28 ++++-----
 6 files changed, 76 insertions(+), 76 deletions(-)

diff --git a/drivers/s390/block/dasd.c b/drivers/s390/block/dasd.c
index 8d04e5bb3a586..aa7d370b14549 100644
--- a/drivers/s390/block/dasd.c
+++ b/drivers/s390/block/dasd.c
@@ -3990,7 +3990,7 @@ static struct dasd_ccw_req *dasd_generic_build_rdc(struct dasd_device *device,
 
 	ccw = cqr->cpaddr;
 	ccw->cmd_code = CCW_CMD_RDC;
-	ccw->cda = (__u32)virt_to_phys(cqr->data);
+	ccw->cda = virt_to_dma32(cqr->data);
 	ccw->flags = 0;
 	ccw->count = rdc_buffer_size;
 	cqr->startdev = device;
@@ -4034,7 +4034,7 @@ char *dasd_get_sense(struct irb *irb)
 
 	if (scsw_is_tm(&irb->scsw) && (irb->scsw.tm.fcxs == 0x01)) {
 		if (irb->scsw.tm.tcw)
-			tsb = tcw_get_tsb(phys_to_virt(irb->scsw.tm.tcw));
+			tsb = tcw_get_tsb(dma32_to_virt(irb->scsw.tm.tcw));
 		if (tsb && tsb->length == 64 && tsb->flags)
 			switch (tsb->flags & 0x07) {
 			case 1:	/* tsa_iostat */
diff --git a/drivers/s390/block/dasd_3990_erp.c b/drivers/s390/block/dasd_3990_erp.c
index 07f886029a358..3e920acfa2d42 100644
--- a/drivers/s390/block/dasd_3990_erp.c
+++ b/drivers/s390/block/dasd_3990_erp.c
@@ -220,7 +220,7 @@ dasd_3990_erp_DCTL(struct dasd_ccw_req * erp, char modifier)
 	memset(ccw, 0, sizeof(struct ccw1));
 	ccw->cmd_code = CCW_CMD_DCTL;
 	ccw->count = 4;
-	ccw->cda = (__u32)virt_to_phys(DCTL_data);
+	ccw->cda = virt_to_dma32(DCTL_data);
 	dctl_cqr->flags = erp->flags;
 	dctl_cqr->function = dasd_3990_erp_DCTL;
 	dctl_cqr->refers = erp;
@@ -1603,7 +1603,7 @@ dasd_3990_erp_action_1B_32(struct dasd_ccw_req * default_erp, char *sense)
 {
 
 	struct dasd_device *device = default_erp->startdev;
-	__u32 cpa = 0;
+	dma32_t cpa = 0;
 	struct dasd_ccw_req *cqr;
 	struct dasd_ccw_req *erp;
 	struct DE_eckd_data *DE_data;
@@ -1708,7 +1708,7 @@ dasd_3990_erp_action_1B_32(struct dasd_ccw_req * default_erp, char *sense)
 	ccw->cmd_code = DASD_ECKD_CCW_DEFINE_EXTENT;
 	ccw->flags = CCW_FLAG_CC;
 	ccw->count = 16;
-	ccw->cda = (__u32)virt_to_phys(DE_data);
+	ccw->cda = virt_to_dma32(DE_data);
 
 	/* create LO ccw */
 	ccw++;
@@ -1716,7 +1716,7 @@ dasd_3990_erp_action_1B_32(struct dasd_ccw_req * default_erp, char *sense)
 	ccw->cmd_code = DASD_ECKD_CCW_LOCATE_RECORD;
 	ccw->flags = CCW_FLAG_CC;
 	ccw->count = 16;
-	ccw->cda = (__u32)virt_to_phys(LO_data);
+	ccw->cda = virt_to_dma32(LO_data);
 
 	/* TIC to the failed ccw */
 	ccw++;
@@ -1762,7 +1762,7 @@ dasd_3990_update_1B(struct dasd_ccw_req * previous_erp, char *sense)
 {
 
 	struct dasd_device *device = previous_erp->startdev;
-	__u32 cpa = 0;
+	dma32_t cpa = 0;
 	struct dasd_ccw_req *cqr;
 	struct dasd_ccw_req *erp;
 	char *LO_data;		/* struct LO_eckd_data */
@@ -2413,7 +2413,7 @@ static struct dasd_ccw_req *dasd_3990_erp_add_erp(struct dasd_ccw_req *cqr)
 		tcw = erp->cpaddr;
 		tsb = (struct tsb *) &tcw[1];
 		*tcw = *((struct tcw *)cqr->cpaddr);
-		tcw->tsb = virt_to_phys(tsb);
+		tcw->tsb = virt_to_dma64(tsb);
 	} else if (ccw->cmd_code == DASD_ECKD_CCW_PSF) {
 		/* PSF cannot be chained from NOOP/TIC */
 		erp->cpaddr = cqr->cpaddr;
@@ -2424,7 +2424,7 @@ static struct dasd_ccw_req *dasd_3990_erp_add_erp(struct dasd_ccw_req *cqr)
 		ccw->flags = CCW_FLAG_CC;
 		ccw++;
 		ccw->cmd_code = CCW_CMD_TIC;
-		ccw->cda      = (__u32)virt_to_phys(cqr->cpaddr);
+		ccw->cda      = virt_to_dma32(cqr->cpaddr);
 	}
 
 	erp->flags = cqr->flags;
diff --git a/drivers/s390/block/dasd_alias.c b/drivers/s390/block/dasd_alias.c
index c9740ae88d1a6..e77393e6f63ab 100644
--- a/drivers/s390/block/dasd_alias.c
+++ b/drivers/s390/block/dasd_alias.c
@@ -443,7 +443,7 @@ static int read_unit_address_configuration(struct dasd_device *device,
 	ccw->cmd_code = DASD_ECKD_CCW_PSF;
 	ccw->count = sizeof(struct dasd_psf_prssd_data);
 	ccw->flags |= CCW_FLAG_CC;
-	ccw->cda = (__u32)virt_to_phys(prssdp);
+	ccw->cda = virt_to_dma32(prssdp);
 
 	/* Read Subsystem Data - feature codes */
 	memset(lcu->uac, 0, sizeof(*(lcu->uac)));
@@ -451,7 +451,7 @@ static int read_unit_address_configuration(struct dasd_device *device,
 	ccw++;
 	ccw->cmd_code = DASD_ECKD_CCW_RSSD;
 	ccw->count = sizeof(*(lcu->uac));
-	ccw->cda = (__u32)virt_to_phys(lcu->uac);
+	ccw->cda = virt_to_dma32(lcu->uac);
 
 	cqr->buildclk = get_tod_clock();
 	cqr->status = DASD_CQR_FILLED;
@@ -747,7 +747,7 @@ static int reset_summary_unit_check(struct alias_lcu *lcu,
 	ccw->cmd_code = DASD_ECKD_CCW_RSCK;
 	ccw->flags = CCW_FLAG_SLI;
 	ccw->count = 16;
-	ccw->cda = (__u32)virt_to_phys(cqr->data);
+	ccw->cda = virt_to_dma32(cqr->data);
 	((char *)cqr->data)[0] = reason;
 
 	clear_bit(DASD_CQR_FLAGS_USE_ERP, &cqr->flags);
diff --git a/drivers/s390/block/dasd_eckd.c b/drivers/s390/block/dasd_eckd.c
index 1aefcca10769e..c103a006b22f5 100644
--- a/drivers/s390/block/dasd_eckd.c
+++ b/drivers/s390/block/dasd_eckd.c
@@ -286,7 +286,7 @@ define_extent(struct ccw1 *ccw, struct DE_eckd_data *data, unsigned int trk,
 		ccw->cmd_code = DASD_ECKD_CCW_DEFINE_EXTENT;
 		ccw->flags = 0;
 		ccw->count = 16;
-		ccw->cda = (__u32)virt_to_phys(data);
+		ccw->cda = virt_to_dma32(data);
 	}
 
 	memset(data, 0, sizeof(struct DE_eckd_data));
@@ -396,7 +396,7 @@ static void locate_record_ext(struct ccw1 *ccw, struct LRE_eckd_data *data,
 			ccw->count = 22;
 		else
 			ccw->count = 20;
-		ccw->cda = (__u32)virt_to_phys(data);
+		ccw->cda = virt_to_dma32(data);
 	}
 
 	memset(data, 0, sizeof(*data));
@@ -542,11 +542,11 @@ static int prefix_LRE(struct ccw1 *ccw, struct PFX_eckd_data *pfxdata,
 	ccw->flags = 0;
 	if (cmd == DASD_ECKD_CCW_WRITE_FULL_TRACK) {
 		ccw->count = sizeof(*pfxdata) + 2;
-		ccw->cda = (__u32)virt_to_phys(pfxdata);
+		ccw->cda = virt_to_dma32(pfxdata);
 		memset(pfxdata, 0, sizeof(*pfxdata) + 2);
 	} else {
 		ccw->count = sizeof(*pfxdata);
-		ccw->cda = (__u32)virt_to_phys(pfxdata);
+		ccw->cda = virt_to_dma32(pfxdata);
 		memset(pfxdata, 0, sizeof(*pfxdata));
 	}
 
@@ -613,7 +613,7 @@ locate_record(struct ccw1 *ccw, struct LO_eckd_data *data, unsigned int trk,
 	ccw->cmd_code = DASD_ECKD_CCW_LOCATE_RECORD;
 	ccw->flags = 0;
 	ccw->count = 16;
-	ccw->cda = (__u32)virt_to_phys(data);
+	ccw->cda = virt_to_dma32(data);
 
 	memset(data, 0, sizeof(struct LO_eckd_data));
 	sector = 0;
@@ -828,7 +828,7 @@ static void dasd_eckd_fill_rcd_cqr(struct dasd_device *device,
 	ccw = cqr->cpaddr;
 	ccw->cmd_code = DASD_ECKD_CCW_RCD;
 	ccw->flags = 0;
-	ccw->cda = (__u32)virt_to_phys(rcd_buffer);
+	ccw->cda = virt_to_dma32(rcd_buffer);
 	ccw->count = DASD_ECKD_RCD_DATA_SIZE;
 	cqr->magic = DASD_ECKD_MAGIC;
 
@@ -856,7 +856,7 @@ static void read_conf_cb(struct dasd_ccw_req *cqr, void *data)
 
 	if (cqr->status !=  DASD_CQR_DONE) {
 		ccw = cqr->cpaddr;
-		rcd_buffer = phys_to_virt(ccw->cda);
+		rcd_buffer = dma32_to_virt(ccw->cda);
 		memset(rcd_buffer, 0, sizeof(*rcd_buffer));
 
 		rcd_buffer[0] = 0xE5;
@@ -1547,7 +1547,7 @@ static int dasd_eckd_read_features(struct dasd_device *device)
 	ccw->cmd_code = DASD_ECKD_CCW_PSF;
 	ccw->count = sizeof(struct dasd_psf_prssd_data);
 	ccw->flags |= CCW_FLAG_CC;
-	ccw->cda = (__u32)virt_to_phys(prssdp);
+	ccw->cda = virt_to_dma32(prssdp);
 
 	/* Read Subsystem Data - feature codes */
 	features = (struct dasd_rssd_features *) (prssdp + 1);
@@ -1556,7 +1556,7 @@ static int dasd_eckd_read_features(struct dasd_device *device)
 	ccw++;
 	ccw->cmd_code = DASD_ECKD_CCW_RSSD;
 	ccw->count = sizeof(struct dasd_rssd_features);
-	ccw->cda = (__u32)virt_to_phys(features);
+	ccw->cda = virt_to_dma32(features);
 
 	cqr->buildclk = get_tod_clock();
 	cqr->status = DASD_CQR_FILLED;
@@ -1616,7 +1616,7 @@ static int dasd_eckd_read_vol_info(struct dasd_device *device)
 	ccw->cmd_code = DASD_ECKD_CCW_PSF;
 	ccw->count = sizeof(*prssdp);
 	ccw->flags |= CCW_FLAG_CC;
-	ccw->cda = (__u32)virt_to_phys(prssdp);
+	ccw->cda = virt_to_dma32(prssdp);
 
 	/* Read Subsystem Data - Volume Storage Query */
 	vsq = (struct dasd_rssd_vsq *)(prssdp + 1);
@@ -1626,7 +1626,7 @@ static int dasd_eckd_read_vol_info(struct dasd_device *device)
 	ccw->cmd_code = DASD_ECKD_CCW_RSSD;
 	ccw->count = sizeof(*vsq);
 	ccw->flags |= CCW_FLAG_SLI;
-	ccw->cda = (__u32)virt_to_phys(vsq);
+	ccw->cda = virt_to_dma32(vsq);
 
 	cqr->buildclk = get_tod_clock();
 	cqr->status = DASD_CQR_FILLED;
@@ -1816,7 +1816,7 @@ static int dasd_eckd_read_ext_pool_info(struct dasd_device *device)
 	ccw->cmd_code = DASD_ECKD_CCW_PSF;
 	ccw->count = sizeof(*prssdp);
 	ccw->flags |= CCW_FLAG_CC;
-	ccw->cda = (__u32)virt_to_phys(prssdp);
+	ccw->cda = virt_to_dma32(prssdp);
 
 	lcq = (struct dasd_rssd_lcq *)(prssdp + 1);
 	memset(lcq, 0, sizeof(*lcq));
@@ -1825,7 +1825,7 @@ static int dasd_eckd_read_ext_pool_info(struct dasd_device *device)
 	ccw->cmd_code = DASD_ECKD_CCW_RSSD;
 	ccw->count = sizeof(*lcq);
 	ccw->flags |= CCW_FLAG_SLI;
-	ccw->cda = (__u32)virt_to_phys(lcq);
+	ccw->cda = virt_to_dma32(lcq);
 
 	cqr->buildclk = get_tod_clock();
 	cqr->status = DASD_CQR_FILLED;
@@ -1935,7 +1935,7 @@ static struct dasd_ccw_req *dasd_eckd_build_psf_ssc(struct dasd_device *device,
 	}
 	ccw = cqr->cpaddr;
 	ccw->cmd_code = DASD_ECKD_CCW_PSF;
-	ccw->cda = (__u32)virt_to_phys(psf_ssc_data);
+	ccw->cda = virt_to_dma32(psf_ssc_data);
 	ccw->count = 66;
 
 	cqr->startdev = device;
@@ -2290,7 +2290,7 @@ dasd_eckd_analysis_ccw(struct dasd_device *device)
 		ccw->cmd_code = DASD_ECKD_CCW_READ_COUNT;
 		ccw->flags = 0;
 		ccw->count = 8;
-		ccw->cda = (__u32)virt_to_phys(count_data);
+		ccw->cda = virt_to_dma32(count_data);
 		ccw++;
 		count_data++;
 	}
@@ -2304,7 +2304,7 @@ dasd_eckd_analysis_ccw(struct dasd_device *device)
 	ccw->cmd_code = DASD_ECKD_CCW_READ_COUNT;
 	ccw->flags = 0;
 	ccw->count = 8;
-	ccw->cda = (__u32)virt_to_phys(count_data);
+	ccw->cda = virt_to_dma32(count_data);
 
 	cqr->block = NULL;
 	cqr->startdev = device;
@@ -2676,7 +2676,7 @@ dasd_eckd_build_check(struct dasd_device *base, struct format_data_t *fdata,
 		ccw->cmd_code = DASD_ECKD_CCW_READ_COUNT;
 		ccw->flags = CCW_FLAG_SLI;
 		ccw->count = 8;
-		ccw->cda = (__u32)virt_to_phys(fmt_buffer);
+		ccw->cda = virt_to_dma32(fmt_buffer);
 		ccw++;
 		fmt_buffer++;
 	}
@@ -2886,7 +2886,7 @@ dasd_eckd_build_format(struct dasd_device *base, struct dasd_device *startdev,
 			ccw->cmd_code = DASD_ECKD_CCW_WRITE_RECORD_ZERO;
 			ccw->flags = CCW_FLAG_SLI;
 			ccw->count = 8;
-			ccw->cda = (__u32)virt_to_phys(ect);
+			ccw->cda = virt_to_dma32(ect);
 			ccw++;
 		}
 		if ((intensity & ~0x08) & 0x04) {	/* erase track */
@@ -2901,7 +2901,7 @@ dasd_eckd_build_format(struct dasd_device *base, struct dasd_device *startdev,
 			ccw->cmd_code = DASD_ECKD_CCW_WRITE_CKD;
 			ccw->flags = CCW_FLAG_SLI;
 			ccw->count = 8;
-			ccw->cda = (__u32)virt_to_phys(ect);
+			ccw->cda = virt_to_dma32(ect);
 		} else {		/* write remaining records */
 			for (i = 0; i < rpt; i++) {
 				ect = (struct eckd_count *) data;
@@ -2936,7 +2936,7 @@ dasd_eckd_build_format(struct dasd_device *base, struct dasd_device *startdev,
 						DASD_ECKD_CCW_WRITE_CKD_MT;
 				ccw->flags = CCW_FLAG_SLI;
 				ccw->count = 8;
-				ccw->cda = (__u32)virt_to_phys(ect);
+				ccw->cda = virt_to_dma32(ect);
 				ccw++;
 			}
 		}
@@ -3879,7 +3879,7 @@ dasd_eckd_dso_ras(struct dasd_device *device, struct dasd_block *block,
 	}
 
 	ccw = cqr->cpaddr;
-	ccw->cda = (__u32)virt_to_phys(cqr->data);
+	ccw->cda = virt_to_dma32(cqr->data);
 	ccw->cmd_code = DASD_ECKD_CCW_DSO;
 	ccw->count = size;
 
@@ -4148,11 +4148,11 @@ static struct dasd_ccw_req *dasd_eckd_build_cp_cmd_single(
 			ccw->cmd_code = rcmd;
 			ccw->count = count;
 			if (idal_is_needed(dst, blksize)) {
-				ccw->cda = (__u32)virt_to_phys(idaws);
+				ccw->cda = virt_to_dma32(idaws);
 				ccw->flags = CCW_FLAG_IDA;
 				idaws = idal_create_words(idaws, dst, blksize);
 			} else {
-				ccw->cda = (__u32)virt_to_phys(dst);
+				ccw->cda = virt_to_dma32(dst);
 				ccw->flags = 0;
 			}
 			ccw++;
@@ -4284,7 +4284,7 @@ static struct dasd_ccw_req *dasd_eckd_build_cp_cmd_track(
 				ccw[-1].flags |= CCW_FLAG_CC;
 				ccw->cmd_code = cmd;
 				ccw->count = len_to_track_end;
-				ccw->cda = (__u32)virt_to_phys(idaws);
+				ccw->cda = virt_to_dma32(idaws);
 				ccw->flags = CCW_FLAG_IDA;
 				ccw++;
 				recid += count;
@@ -4872,7 +4872,7 @@ static struct dasd_ccw_req *dasd_eckd_build_cp_raw(struct dasd_device *startdev,
 		ccw->count = 57326;
 		/* 64k map to one track */
 		len_to_track_end = 65536 - start_padding_sectors * 512;
-		ccw->cda = (__u32)virt_to_phys(idaws);
+		ccw->cda = virt_to_dma32(idaws);
 		ccw->flags |= CCW_FLAG_IDA;
 		ccw->flags |= CCW_FLAG_SLI;
 		ccw++;
@@ -4891,7 +4891,7 @@ static struct dasd_ccw_req *dasd_eckd_build_cp_raw(struct dasd_device *startdev,
 			ccw->count = 57326;
 			/* 64k map to one track */
 			len_to_track_end = 65536;
-			ccw->cda = (__u32)virt_to_phys(idaws);
+			ccw->cda = virt_to_dma32(idaws);
 			ccw->flags |= CCW_FLAG_IDA;
 			ccw->flags |= CCW_FLAG_SLI;
 			ccw++;
@@ -4948,9 +4948,9 @@ dasd_eckd_free_cp(struct dasd_ccw_req *cqr, struct request *req)
 				ccw++;
 			if (dst) {
 				if (ccw->flags & CCW_FLAG_IDA)
-					cda = *((char **)phys_to_virt(ccw->cda));
+					cda = *((char **)dma32_to_virt(ccw->cda));
 				else
-					cda = phys_to_virt(ccw->cda);
+					cda = dma32_to_virt(ccw->cda);
 				if (dst != cda) {
 					if (rq_data_dir(req) == READ)
 						memcpy(dst, cda, bv.bv_len);
@@ -5100,7 +5100,7 @@ dasd_eckd_release(struct dasd_device *device)
 	ccw->cmd_code = DASD_ECKD_CCW_RELEASE;
 	ccw->flags |= CCW_FLAG_SLI;
 	ccw->count = 32;
-	ccw->cda = (__u32)virt_to_phys(cqr->data);
+	ccw->cda = virt_to_dma32(cqr->data);
 	cqr->startdev = device;
 	cqr->memdev = device;
 	clear_bit(DASD_CQR_FLAGS_USE_ERP, &cqr->flags);
@@ -5155,7 +5155,7 @@ dasd_eckd_reserve(struct dasd_device *device)
 	ccw->cmd_code = DASD_ECKD_CCW_RESERVE;
 	ccw->flags |= CCW_FLAG_SLI;
 	ccw->count = 32;
-	ccw->cda = (__u32)virt_to_phys(cqr->data);
+	ccw->cda = virt_to_dma32(cqr->data);
 	cqr->startdev = device;
 	cqr->memdev = device;
 	clear_bit(DASD_CQR_FLAGS_USE_ERP, &cqr->flags);
@@ -5209,7 +5209,7 @@ dasd_eckd_steal_lock(struct dasd_device *device)
 	ccw->cmd_code = DASD_ECKD_CCW_SLCK;
 	ccw->flags |= CCW_FLAG_SLI;
 	ccw->count = 32;
-	ccw->cda = (__u32)virt_to_phys(cqr->data);
+	ccw->cda = virt_to_dma32(cqr->data);
 	cqr->startdev = device;
 	cqr->memdev = device;
 	clear_bit(DASD_CQR_FLAGS_USE_ERP, &cqr->flags);
@@ -5270,7 +5270,7 @@ static int dasd_eckd_snid(struct dasd_device *device,
 	ccw->cmd_code = DASD_ECKD_CCW_SNID;
 	ccw->flags |= CCW_FLAG_SLI;
 	ccw->count = 12;
-	ccw->cda = (__u32)virt_to_phys(cqr->data);
+	ccw->cda = virt_to_dma32(cqr->data);
 	cqr->startdev = device;
 	cqr->memdev = device;
 	clear_bit(DASD_CQR_FLAGS_USE_ERP, &cqr->flags);
@@ -5337,7 +5337,7 @@ dasd_eckd_performance(struct dasd_device *device, void __user *argp)
 	ccw->cmd_code = DASD_ECKD_CCW_PSF;
 	ccw->count = sizeof(struct dasd_psf_prssd_data);
 	ccw->flags |= CCW_FLAG_CC;
-	ccw->cda = (__u32)virt_to_phys(prssdp);
+	ccw->cda = virt_to_dma32(prssdp);
 
 	/* Read Subsystem Data - Performance Statistics */
 	stats = (struct dasd_rssd_perf_stats_t *) (prssdp + 1);
@@ -5346,7 +5346,7 @@ dasd_eckd_performance(struct dasd_device *device, void __user *argp)
 	ccw++;
 	ccw->cmd_code = DASD_ECKD_CCW_RSSD;
 	ccw->count = sizeof(struct dasd_rssd_perf_stats_t);
-	ccw->cda = (__u32)virt_to_phys(stats);
+	ccw->cda = virt_to_dma32(stats);
 
 	cqr->buildclk = get_tod_clock();
 	cqr->status = DASD_CQR_FILLED;
@@ -5490,7 +5490,7 @@ static int dasd_symm_io(struct dasd_device *device, void __user *argp)
 	ccw->cmd_code = DASD_ECKD_CCW_PSF;
 	ccw->count = usrparm.psf_data_len;
 	ccw->flags |= CCW_FLAG_CC;
-	ccw->cda = (__u32)virt_to_phys(psf_data);
+	ccw->cda = virt_to_dma32(psf_data);
 
 	ccw++;
 
@@ -5498,7 +5498,7 @@ static int dasd_symm_io(struct dasd_device *device, void __user *argp)
 	ccw->cmd_code = DASD_ECKD_CCW_RSSD;
 	ccw->count = usrparm.rssd_result_len;
 	ccw->flags = CCW_FLAG_SLI ;
-	ccw->cda = (__u32)virt_to_phys(rssd_result);
+	ccw->cda = virt_to_dma32(rssd_result);
 
 	rc = dasd_sleep_on(cqr);
 	if (rc)
@@ -5567,9 +5567,9 @@ dasd_eckd_dump_ccw_range(struct dasd_device *device, struct ccw1 *from,
 
 		/* get pointer to data (consider IDALs) */
 		if (from->flags & CCW_FLAG_IDA)
-			datap = (char *)*((addr_t *)phys_to_virt(from->cda));
+			datap = (char *)*((addr_t *)dma32_to_virt(from->cda));
 		else
-			datap = phys_to_virt(from->cda);
+			datap = dma32_to_virt(from->cda);
 
 		/* dump data (max 128 bytes) */
 		for (count = 0; count < from->count && count < 128; count++) {
@@ -5638,7 +5638,7 @@ static void dasd_eckd_dump_sense_ccw(struct dasd_device *device,
 		       scsw_dstat(&irb->scsw), scsw_cstat(&irb->scsw),
 		       req ? req->intrc : 0);
 	len += sprintf(page + len, "Failing CCW: %px\n",
-		       phys_to_virt(irb->scsw.cmd.cpa));
+		       dma32_to_virt(irb->scsw.cmd.cpa));
 	if (irb->esw.esw0.erw.cons) {
 		for (sl = 0; sl < 4; sl++) {
 			len += sprintf(page + len, "Sense(hex) %2d-%2d:",
@@ -5681,7 +5681,7 @@ static void dasd_eckd_dump_sense_ccw(struct dasd_device *device,
 		/* print failing CCW area (maximum 4) */
 		/* scsw->cda is either valid or zero  */
 		from = ++to;
-		fail = phys_to_virt(irb->scsw.cmd.cpa); /* failing CCW */
+		fail = dma32_to_virt(irb->scsw.cmd.cpa); /* failing CCW */
 		if (from <  fail - 2) {
 			from = fail - 2;     /* there is a gap - print header */
 			dev_err(dev, "......\n");
@@ -5731,12 +5731,12 @@ static void dasd_eckd_dump_sense_tcw(struct dasd_device *device,
 		       (irb->scsw.tm.ifob << 7) | irb->scsw.tm.sesq,
 		       req ? req->intrc : 0);
 	len += sprintf(page + len, "Failing TCW: %px\n",
-		       phys_to_virt(irb->scsw.tm.tcw));
+		       dma32_to_virt(irb->scsw.tm.tcw));
 
 	tsb = NULL;
 	sense = NULL;
 	if (irb->scsw.tm.tcw && (irb->scsw.tm.fcxs & 0x01))
-		tsb = tcw_get_tsb(phys_to_virt(irb->scsw.tm.tcw));
+		tsb = tcw_get_tsb(dma32_to_virt(irb->scsw.tm.tcw));
 
 	if (tsb) {
 		len += sprintf(page + len, "tsb->length %d\n", tsb->length);
@@ -5942,7 +5942,7 @@ static int dasd_eckd_read_message_buffer(struct dasd_device *device,
 	ccw->count = sizeof(struct dasd_psf_prssd_data);
 	ccw->flags |= CCW_FLAG_CC;
 	ccw->flags |= CCW_FLAG_SLI;
-	ccw->cda = (__u32)virt_to_phys(prssdp);
+	ccw->cda = virt_to_dma32(prssdp);
 
 	/* Read Subsystem Data - message buffer */
 	message_buf = (struct dasd_rssd_messages *) (prssdp + 1);
@@ -5952,7 +5952,7 @@ static int dasd_eckd_read_message_buffer(struct dasd_device *device,
 	ccw->cmd_code = DASD_ECKD_CCW_RSSD;
 	ccw->count = sizeof(struct dasd_rssd_messages);
 	ccw->flags |= CCW_FLAG_SLI;
-	ccw->cda = (__u32)virt_to_phys(message_buf);
+	ccw->cda = virt_to_dma32(message_buf);
 
 	cqr->buildclk = get_tod_clock();
 	cqr->status = DASD_CQR_FILLED;
@@ -6036,14 +6036,14 @@ static int dasd_eckd_query_host_access(struct dasd_device *device,
 	ccw->count = sizeof(struct dasd_psf_prssd_data);
 	ccw->flags |= CCW_FLAG_CC;
 	ccw->flags |= CCW_FLAG_SLI;
-	ccw->cda = (__u32)virt_to_phys(prssdp);
+	ccw->cda = virt_to_dma32(prssdp);
 
 	/* Read Subsystem Data - query host access */
 	ccw++;
 	ccw->cmd_code = DASD_ECKD_CCW_RSSD;
 	ccw->count = sizeof(struct dasd_psf_query_host_access);
 	ccw->flags |= CCW_FLAG_SLI;
-	ccw->cda = (__u32)virt_to_phys(host_access);
+	ccw->cda = virt_to_dma32(host_access);
 
 	cqr->buildclk = get_tod_clock();
 	cqr->status = DASD_CQR_FILLED;
@@ -6302,14 +6302,14 @@ static int dasd_eckd_query_pprc_status(struct dasd_device *device,
 	ccw->count = sizeof(struct dasd_psf_prssd_data);
 	ccw->flags |= CCW_FLAG_CC;
 	ccw->flags |= CCW_FLAG_SLI;
-	ccw->cda = (__u32)virt_to_phys(prssdp);
+	ccw->cda = virt_to_dma32(prssdp);
 
 	/* Read Subsystem Data - query host access */
 	ccw++;
 	ccw->cmd_code = DASD_ECKD_CCW_RSSD;
 	ccw->count = sizeof(*pprc_data);
 	ccw->flags |= CCW_FLAG_SLI;
-	ccw->cda = (__u32)virt_to_phys(pprc_data);
+	ccw->cda = virt_to_dma32(pprc_data);
 
 	cqr->buildclk = get_tod_clock();
 	cqr->status = DASD_CQR_FILLED;
@@ -6403,7 +6403,7 @@ dasd_eckd_psf_cuir_response(struct dasd_device *device, int response,
 	psf_cuir->ssid = device->path[pos].ssid;
 	ccw = cqr->cpaddr;
 	ccw->cmd_code = DASD_ECKD_CCW_PSF;
-	ccw->cda = (__u32)virt_to_phys(psf_cuir);
+	ccw->cda = virt_to_dma32(psf_cuir);
 	ccw->flags = CCW_FLAG_SLI;
 	ccw->count = sizeof(struct dasd_psf_cuir_response);
 
diff --git a/drivers/s390/block/dasd_eer.c b/drivers/s390/block/dasd_eer.c
index c956de711cf78..0f53bf0d50ff0 100644
--- a/drivers/s390/block/dasd_eer.c
+++ b/drivers/s390/block/dasd_eer.c
@@ -492,7 +492,7 @@ int dasd_eer_enable(struct dasd_device *device)
 	ccw->cmd_code = DASD_ECKD_CCW_SNSS;
 	ccw->count = SNSS_DATA_SIZE;
 	ccw->flags = 0;
-	ccw->cda = (__u32)virt_to_phys(cqr->data);
+	ccw->cda = virt_to_dma32(cqr->data);
 
 	cqr->buildclk = get_tod_clock();
 	cqr->status = DASD_CQR_FILLED;
diff --git a/drivers/s390/block/dasd_fba.c b/drivers/s390/block/dasd_fba.c
index 3be974d65f50e..1ff7c1f816883 100644
--- a/drivers/s390/block/dasd_fba.c
+++ b/drivers/s390/block/dasd_fba.c
@@ -78,7 +78,7 @@ define_extent(struct ccw1 * ccw, struct DE_fba_data *data, int rw,
 	ccw->cmd_code = DASD_FBA_CCW_DEFINE_EXTENT;
 	ccw->flags = 0;
 	ccw->count = 16;
-	ccw->cda = (__u32)virt_to_phys(data);
+	ccw->cda = virt_to_dma32(data);
 	memset(data, 0, sizeof (struct DE_fba_data));
 	if (rw == WRITE)
 		(data->mask).perm = 0x0;
@@ -98,7 +98,7 @@ locate_record(struct ccw1 * ccw, struct LO_fba_data *data, int rw,
 	ccw->cmd_code = DASD_FBA_CCW_LOCATE;
 	ccw->flags = 0;
 	ccw->count = 8;
-	ccw->cda = (__u32)virt_to_phys(data);
+	ccw->cda = virt_to_dma32(data);
 	memset(data, 0, sizeof (struct LO_fba_data));
 	if (rw == WRITE)
 		data->operation.cmd = 0x5;
@@ -257,7 +257,7 @@ static void ccw_write_zero(struct ccw1 *ccw, int count)
 	ccw->cmd_code = DASD_FBA_CCW_WRITE;
 	ccw->flags |= CCW_FLAG_SLI;
 	ccw->count = count;
-	ccw->cda = (__u32)virt_to_phys(dasd_fba_zero_page);
+	ccw->cda = virt_to_dma32(dasd_fba_zero_page);
 }
 
 /*
@@ -523,11 +523,11 @@ static struct dasd_ccw_req *dasd_fba_build_cp_regular(
 			ccw->cmd_code = cmd;
 			ccw->count = block->bp_block;
 			if (idal_is_needed(dst, blksize)) {
-				ccw->cda = (__u32)virt_to_phys(idaws);
+				ccw->cda = virt_to_dma32(idaws);
 				ccw->flags = CCW_FLAG_IDA;
 				idaws = idal_create_words(idaws, dst, blksize);
 			} else {
-				ccw->cda = (__u32)virt_to_phys(dst);
+				ccw->cda = virt_to_dma32(dst);
 				ccw->flags = 0;
 			}
 			ccw++;
@@ -585,9 +585,9 @@ dasd_fba_free_cp(struct dasd_ccw_req *cqr, struct request *req)
 				ccw++;
 			if (dst) {
 				if (ccw->flags & CCW_FLAG_IDA)
-					cda = *((char **)phys_to_virt(ccw->cda));
+					cda = *((char **)dma32_to_virt(ccw->cda));
 				else
-					cda = phys_to_virt(ccw->cda);
+					cda = dma32_to_virt(ccw->cda);
 				if (dst != cda) {
 					if (rq_data_dir(req) == READ)
 						memcpy(dst, cda, bv.bv_len);
@@ -672,7 +672,7 @@ dasd_fba_dump_sense(struct dasd_device *device, struct dasd_ccw_req * req,
 	len += sprintf(page + len, "in req: %px CS: 0x%02X DS: 0x%02X\n",
 		       req, irb->scsw.cmd.cstat, irb->scsw.cmd.dstat);
 	len += sprintf(page + len, "Failing CCW: %px\n",
-		       (void *) (addr_t) irb->scsw.cmd.cpa);
+		       (void *)(u64)dma32_to_u32(irb->scsw.cmd.cpa));
 	if (irb->esw.esw0.erw.cons) {
 		for (sl = 0; sl < 4; sl++) {
 			len += sprintf(page + len, "Sense(hex) %2d-%2d:",
@@ -701,7 +701,7 @@ dasd_fba_dump_sense(struct dasd_device *device, struct dasd_ccw_req * req,
 		for (count = 0; count < 32 && count < act->count;
 		     count += sizeof(int))
 			len += sprintf(page + len, " %08X",
-				       ((int *)phys_to_virt(act->cda))
+				       ((int *)dma32_to_virt(act->cda))
 				       [(count>>2)]);
 		len += sprintf(page + len, "\n");
 		act++;
@@ -710,18 +710,18 @@ dasd_fba_dump_sense(struct dasd_device *device, struct dasd_ccw_req * req,
 
 	/* print failing CCW area */
 	len = 0;
-	if (act < ((struct ccw1 *)phys_to_virt(irb->scsw.cmd.cpa)) - 2) {
-		act = ((struct ccw1 *)phys_to_virt(irb->scsw.cmd.cpa)) - 2;
+	if (act < ((struct ccw1 *)dma32_to_virt(irb->scsw.cmd.cpa)) - 2) {
+		act = ((struct ccw1 *)dma32_to_virt(irb->scsw.cmd.cpa)) - 2;
 		len += sprintf(page + len, "......\n");
 	}
-	end = min((struct ccw1 *)phys_to_virt(irb->scsw.cmd.cpa) + 2, last);
+	end = min((struct ccw1 *)dma32_to_virt(irb->scsw.cmd.cpa) + 2, last);
 	while (act <= end) {
 		len += sprintf(page + len, "CCW %px: %08X %08X DAT:",
 			       act, ((int *) act)[0], ((int *) act)[1]);
 		for (count = 0; count < 32 && count < act->count;
 		     count += sizeof(int))
 			len += sprintf(page + len, " %08X",
-				       ((int *)phys_to_virt(act->cda))
+				       ((int *)dma32_to_virt(act->cda))
 				       [(count>>2)]);
 		len += sprintf(page + len, "\n");
 		act++;
@@ -738,7 +738,7 @@ dasd_fba_dump_sense(struct dasd_device *device, struct dasd_ccw_req * req,
 		for (count = 0; count < 32 && count < act->count;
 		     count += sizeof(int))
 			len += sprintf(page + len, " %08X",
-				       ((int *)phys_to_virt(act->cda))
+				       ((int *)dma32_to_virt(act->cda))
 				       [(count>>2)]);
 		len += sprintf(page + len, "\n");
 		act++;
-- 
2.53.0

