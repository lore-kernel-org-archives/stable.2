Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795630387;
	b=KMCLfYrKV5X+AcZNwg3ljNnfCTK3rWsIgx53uZRsJ/GSN62volzVGQqTY9zJ4Y3+w0qX
	 FAOWbSAPOAzWHJg4sS/SpmirXj7Qtoq41diKeMYXbQs6c0RceoLlJwsdClR98IdoMe7jN
	 dEFGr4+E0R8vTRJyaVYbqsOPB7ZGaOLgv+Lvseo1ydudJn0twTC+/TjMwu7mpQpzkWjJ5
	 XKO0ik8SnSrgGcHfExiLfDxWV8QJ5BZxuWY6udOs9o0Z1a8SqxfHIxF7c9n7FyPXmu7eC
	 LOtj2bozpWlMQRVXMlaJztfStUDevO8vJjqgpFRavhBicKuygk9AYRdGQwTyriXhJGw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795630387;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=6IzXWLpqFvDmPc1iXJjLvXnjulqczo5Bqkkb9UoUf+8=;
	b=wGYCCFYI6jedTbWU/z/3LxJ5pVwVMSGG8Jv5U9WnwhbQJv1X3UHBSDVfacVQ59thaCto
	 g7svdeu9mmcb079UJJqHsgTT7edrYo6zx1GZKSXOHM30cU1VDrQnao0dCv92HjngKUpY5
	 FbMtyUwgR8AcU8fysyap52VEpKyoAHwwDrq8AclxP0cGmx8Er8i1fFYKLKuggEOKzbvnn
	 2n5jH5gP7iNteHyM7x6c2z069MIcNu7WWLwZfkXv5W4sMc4/QKFbiLYb7dHim/SrecxPy
	 EZqcajvdUCaEwfSd31HpMCE4RscNVbCYpIQd+Eujrv4lah4IsaAjbm1myIYFdZMXwfA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=YnHx6lFc;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AA7E5606A685
	for <stable@vger.kernel.org>; Wed, 25 Nov 2026 18:13:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=YnHx6lFc
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A89F41F000F0;
	Wed, 25 Nov 2026 18:13:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795630387;
	bh=6IzXWLpqFvDmPc1iXJjLvXnjulqczo5Bqkkb9UoUf+8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=YnHx6lFcB5osMQj8Tae9bElFu8pJZAcDV0B/rqCpO1ClBfJ7mzoLR8Vy5FkY8hLuV
	 NCH41tdefHWl863Z+Bc5SRTfxf59QctqOVX2KLL/DMm9lapXu0LeQmd7ikG94cKTmE
	 cPqipzfHIha4w2bo0j3kefkMygAhpnUqlCPn2JdmufKvRg6GLp+YaKXHXyxgtRcB56
	 DXGn3TtxpJMjTnl+hDj4Vh8pLCy4R10qj5lIlfs2n2xR4Ac9h6WzmrS+h2nSEsMDct
	 6OVK3WS6NHHvZxLKG3yB5hN4xyUsmY9GJ5HeTbjPVPaHHbJhsAFbAj3yB9qrPYm5I8
	 3isu7XWygLtEQ==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Alexander Gordeev <agordeev@linux.ibm.com>,
	Stefan Haberland <sth@linux.ibm.com>,
	Jens Axboe <axboe@kernel.dk>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.15.y 2/7] s390/dasd: sort out physical vs virtual pointers usage
Date: Wed, 25 Nov 2026 13:12:58 -0500
Message-ID: <20261125181227.1137399-2-sashal@kernel.org>
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

From: Alexander Gordeev <agordeev@linux.ibm.com>

[ Upstream commit b87c52e431adfe2dfe8634216b317b4a952aa9fc ]

This does not fix a real bug, since virtual addresses
are currently indentical to physical ones.

Signed-off-by: Alexander Gordeev <agordeev@linux.ibm.com>
Signed-off-by: Stefan Haberland <sth@linux.ibm.com>
Link: https://lore.kernel.org/r/20230210000253.1644903-2-sth@linux.ibm.com
Signed-off-by: Jens Axboe <axboe@kernel.dk>
Stable-dep-of: 25cdc1f63227 ("s390/dasd: Re-initialize RCD buffer with "V1.0" before every start")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/s390/block/dasd.c          |   5 +-
 drivers/s390/block/dasd_3990_erp.c |  10 +--
 drivers/s390/block/dasd_alias.c    |   6 +-
 drivers/s390/block/dasd_eckd.c     | 100 ++++++++++++++---------------
 drivers/s390/block/dasd_eer.c      |   2 +-
 drivers/s390/block/dasd_fba.c      |  14 ++--
 6 files changed, 67 insertions(+), 70 deletions(-)

diff --git a/drivers/s390/block/dasd.c b/drivers/s390/block/dasd.c
index 845f82215dfb3..6c0d748691d0b 100644
--- a/drivers/s390/block/dasd.c
+++ b/drivers/s390/block/dasd.c
@@ -4051,7 +4051,7 @@ static struct dasd_ccw_req *dasd_generic_build_rdc(struct dasd_device *device,
 
 	ccw = cqr->cpaddr;
 	ccw->cmd_code = CCW_CMD_RDC;
-	ccw->cda = (__u32)(addr_t) cqr->data;
+	ccw->cda = (__u32)virt_to_phys(cqr->data);
 	ccw->flags = 0;
 	ccw->count = rdc_buffer_size;
 	cqr->startdev = device;
@@ -4095,8 +4095,7 @@ char *dasd_get_sense(struct irb *irb)
 
 	if (scsw_is_tm(&irb->scsw) && (irb->scsw.tm.fcxs == 0x01)) {
 		if (irb->scsw.tm.tcw)
-			tsb = tcw_get_tsb((struct tcw *)(unsigned long)
-					  irb->scsw.tm.tcw);
+			tsb = tcw_get_tsb(phys_to_virt(irb->scsw.tm.tcw));
 		if (tsb && tsb->length == 64 && tsb->flags)
 			switch (tsb->flags & 0x07) {
 			case 1:	/* tsa_iostat */
diff --git a/drivers/s390/block/dasd_3990_erp.c b/drivers/s390/block/dasd_3990_erp.c
index 845f088ce97b1..188948f1f8606 100644
--- a/drivers/s390/block/dasd_3990_erp.c
+++ b/drivers/s390/block/dasd_3990_erp.c
@@ -220,7 +220,7 @@ dasd_3990_erp_DCTL(struct dasd_ccw_req * erp, char modifier)
 	memset(ccw, 0, sizeof(struct ccw1));
 	ccw->cmd_code = CCW_CMD_DCTL;
 	ccw->count = 4;
-	ccw->cda = (__u32)(addr_t) DCTL_data;
+	ccw->cda = (__u32)virt_to_phys(DCTL_data);
 	dctl_cqr->flags = erp->flags;
 	dctl_cqr->function = dasd_3990_erp_DCTL;
 	dctl_cqr->refers = erp;
@@ -1703,7 +1703,7 @@ dasd_3990_erp_action_1B_32(struct dasd_ccw_req * default_erp, char *sense)
 	ccw->cmd_code = DASD_ECKD_CCW_DEFINE_EXTENT;
 	ccw->flags = CCW_FLAG_CC;
 	ccw->count = 16;
-	ccw->cda = (__u32)(addr_t) DE_data;
+	ccw->cda = (__u32)virt_to_phys(DE_data);
 
 	/* create LO ccw */
 	ccw++;
@@ -1711,7 +1711,7 @@ dasd_3990_erp_action_1B_32(struct dasd_ccw_req * default_erp, char *sense)
 	ccw->cmd_code = DASD_ECKD_CCW_LOCATE_RECORD;
 	ccw->flags = CCW_FLAG_CC;
 	ccw->count = 16;
-	ccw->cda = (__u32)(addr_t) LO_data;
+	ccw->cda = (__u32)virt_to_phys(LO_data);
 
 	/* TIC to the failed ccw */
 	ccw++;
@@ -2408,7 +2408,7 @@ static struct dasd_ccw_req *dasd_3990_erp_add_erp(struct dasd_ccw_req *cqr)
 		tcw = erp->cpaddr;
 		tsb = (struct tsb *) &tcw[1];
 		*tcw = *((struct tcw *)cqr->cpaddr);
-		tcw->tsb = (long)tsb;
+		tcw->tsb = virt_to_phys(tsb);
 	} else if (ccw->cmd_code == DASD_ECKD_CCW_PSF) {
 		/* PSF cannot be chained from NOOP/TIC */
 		erp->cpaddr = cqr->cpaddr;
@@ -2419,7 +2419,7 @@ static struct dasd_ccw_req *dasd_3990_erp_add_erp(struct dasd_ccw_req *cqr)
 		ccw->flags = CCW_FLAG_CC;
 		ccw++;
 		ccw->cmd_code = CCW_CMD_TIC;
-		ccw->cda      = (long)(cqr->cpaddr);
+		ccw->cda      = (__u32)virt_to_phys(cqr->cpaddr);
 	}
 
 	erp->flags = cqr->flags;
diff --git a/drivers/s390/block/dasd_alias.c b/drivers/s390/block/dasd_alias.c
index b6b938aa66158..c9740ae88d1a6 100644
--- a/drivers/s390/block/dasd_alias.c
+++ b/drivers/s390/block/dasd_alias.c
@@ -443,7 +443,7 @@ static int read_unit_address_configuration(struct dasd_device *device,
 	ccw->cmd_code = DASD_ECKD_CCW_PSF;
 	ccw->count = sizeof(struct dasd_psf_prssd_data);
 	ccw->flags |= CCW_FLAG_CC;
-	ccw->cda = (__u32)(addr_t) prssdp;
+	ccw->cda = (__u32)virt_to_phys(prssdp);
 
 	/* Read Subsystem Data - feature codes */
 	memset(lcu->uac, 0, sizeof(*(lcu->uac)));
@@ -451,7 +451,7 @@ static int read_unit_address_configuration(struct dasd_device *device,
 	ccw++;
 	ccw->cmd_code = DASD_ECKD_CCW_RSSD;
 	ccw->count = sizeof(*(lcu->uac));
-	ccw->cda = (__u32)(addr_t) lcu->uac;
+	ccw->cda = (__u32)virt_to_phys(lcu->uac);
 
 	cqr->buildclk = get_tod_clock();
 	cqr->status = DASD_CQR_FILLED;
@@ -747,7 +747,7 @@ static int reset_summary_unit_check(struct alias_lcu *lcu,
 	ccw->cmd_code = DASD_ECKD_CCW_RSCK;
 	ccw->flags = CCW_FLAG_SLI;
 	ccw->count = 16;
-	ccw->cda = (__u32)(addr_t) cqr->data;
+	ccw->cda = (__u32)virt_to_phys(cqr->data);
 	((char *)cqr->data)[0] = reason;
 
 	clear_bit(DASD_CQR_FLAGS_USE_ERP, &cqr->flags);
diff --git a/drivers/s390/block/dasd_eckd.c b/drivers/s390/block/dasd_eckd.c
index 62f06ade2de1b..7e694ecca767a 100644
--- a/drivers/s390/block/dasd_eckd.c
+++ b/drivers/s390/block/dasd_eckd.c
@@ -288,7 +288,7 @@ define_extent(struct ccw1 *ccw, struct DE_eckd_data *data, unsigned int trk,
 		ccw->cmd_code = DASD_ECKD_CCW_DEFINE_EXTENT;
 		ccw->flags = 0;
 		ccw->count = 16;
-		ccw->cda = (__u32)__pa(data);
+		ccw->cda = (__u32)virt_to_phys(data);
 	}
 
 	memset(data, 0, sizeof(struct DE_eckd_data));
@@ -398,7 +398,7 @@ static void locate_record_ext(struct ccw1 *ccw, struct LRE_eckd_data *data,
 			ccw->count = 22;
 		else
 			ccw->count = 20;
-		ccw->cda = (__u32)__pa(data);
+		ccw->cda = (__u32)virt_to_phys(data);
 	}
 
 	memset(data, 0, sizeof(*data));
@@ -544,11 +544,11 @@ static int prefix_LRE(struct ccw1 *ccw, struct PFX_eckd_data *pfxdata,
 	ccw->flags = 0;
 	if (cmd == DASD_ECKD_CCW_WRITE_FULL_TRACK) {
 		ccw->count = sizeof(*pfxdata) + 2;
-		ccw->cda = (__u32) __pa(pfxdata);
+		ccw->cda = (__u32)virt_to_phys(pfxdata);
 		memset(pfxdata, 0, sizeof(*pfxdata) + 2);
 	} else {
 		ccw->count = sizeof(*pfxdata);
-		ccw->cda = (__u32) __pa(pfxdata);
+		ccw->cda = (__u32)virt_to_phys(pfxdata);
 		memset(pfxdata, 0, sizeof(*pfxdata));
 	}
 
@@ -615,7 +615,7 @@ locate_record(struct ccw1 *ccw, struct LO_eckd_data *data, unsigned int trk,
 	ccw->cmd_code = DASD_ECKD_CCW_LOCATE_RECORD;
 	ccw->flags = 0;
 	ccw->count = 16;
-	ccw->cda = (__u32) __pa(data);
+	ccw->cda = (__u32)virt_to_phys(data);
 
 	memset(data, 0, sizeof(struct LO_eckd_data));
 	sector = 0;
@@ -831,7 +831,7 @@ static void dasd_eckd_fill_rcd_cqr(struct dasd_device *device,
 	ccw = cqr->cpaddr;
 	ccw->cmd_code = DASD_ECKD_CCW_RCD;
 	ccw->flags = 0;
-	ccw->cda = (__u32)(addr_t)rcd_buffer;
+	ccw->cda = (__u32)virt_to_phys(rcd_buffer);
 	ccw->count = DASD_ECKD_RCD_DATA_SIZE;
 	cqr->magic = DASD_ECKD_MAGIC;
 
@@ -859,7 +859,7 @@ static void read_conf_cb(struct dasd_ccw_req *cqr, void *data)
 
 	if (cqr->status !=  DASD_CQR_DONE) {
 		ccw = cqr->cpaddr;
-		rcd_buffer = (__u8 *)((addr_t) ccw->cda);
+		rcd_buffer = phys_to_virt(ccw->cda);
 		memset(rcd_buffer, 0, sizeof(*rcd_buffer));
 
 		rcd_buffer[0] = 0xE5;
@@ -1565,7 +1565,7 @@ static int dasd_eckd_read_features(struct dasd_device *device)
 	ccw->cmd_code = DASD_ECKD_CCW_PSF;
 	ccw->count = sizeof(struct dasd_psf_prssd_data);
 	ccw->flags |= CCW_FLAG_CC;
-	ccw->cda = (__u32)(addr_t) prssdp;
+	ccw->cda = (__u32)virt_to_phys(prssdp);
 
 	/* Read Subsystem Data - feature codes */
 	features = (struct dasd_rssd_features *) (prssdp + 1);
@@ -1574,7 +1574,7 @@ static int dasd_eckd_read_features(struct dasd_device *device)
 	ccw++;
 	ccw->cmd_code = DASD_ECKD_CCW_RSSD;
 	ccw->count = sizeof(struct dasd_rssd_features);
-	ccw->cda = (__u32)(addr_t) features;
+	ccw->cda = (__u32)virt_to_phys(features);
 
 	cqr->buildclk = get_tod_clock();
 	cqr->status = DASD_CQR_FILLED;
@@ -1634,7 +1634,7 @@ static int dasd_eckd_read_vol_info(struct dasd_device *device)
 	ccw->cmd_code = DASD_ECKD_CCW_PSF;
 	ccw->count = sizeof(*prssdp);
 	ccw->flags |= CCW_FLAG_CC;
-	ccw->cda = (__u32)(addr_t)prssdp;
+	ccw->cda = (__u32)virt_to_phys(prssdp);
 
 	/* Read Subsystem Data - Volume Storage Query */
 	vsq = (struct dasd_rssd_vsq *)(prssdp + 1);
@@ -1644,7 +1644,7 @@ static int dasd_eckd_read_vol_info(struct dasd_device *device)
 	ccw->cmd_code = DASD_ECKD_CCW_RSSD;
 	ccw->count = sizeof(*vsq);
 	ccw->flags |= CCW_FLAG_SLI;
-	ccw->cda = (__u32)(addr_t)vsq;
+	ccw->cda = (__u32)virt_to_phys(vsq);
 
 	cqr->buildclk = get_tod_clock();
 	cqr->status = DASD_CQR_FILLED;
@@ -1834,7 +1834,7 @@ static int dasd_eckd_read_ext_pool_info(struct dasd_device *device)
 	ccw->cmd_code = DASD_ECKD_CCW_PSF;
 	ccw->count = sizeof(*prssdp);
 	ccw->flags |= CCW_FLAG_CC;
-	ccw->cda = (__u32)(addr_t)prssdp;
+	ccw->cda = (__u32)virt_to_phys(prssdp);
 
 	lcq = (struct dasd_rssd_lcq *)(prssdp + 1);
 	memset(lcq, 0, sizeof(*lcq));
@@ -1843,7 +1843,7 @@ static int dasd_eckd_read_ext_pool_info(struct dasd_device *device)
 	ccw->cmd_code = DASD_ECKD_CCW_RSSD;
 	ccw->count = sizeof(*lcq);
 	ccw->flags |= CCW_FLAG_SLI;
-	ccw->cda = (__u32)(addr_t)lcq;
+	ccw->cda = (__u32)virt_to_phys(lcq);
 
 	cqr->buildclk = get_tod_clock();
 	cqr->status = DASD_CQR_FILLED;
@@ -1953,7 +1953,7 @@ static struct dasd_ccw_req *dasd_eckd_build_psf_ssc(struct dasd_device *device,
 	}
 	ccw = cqr->cpaddr;
 	ccw->cmd_code = DASD_ECKD_CCW_PSF;
-	ccw->cda = (__u32)(addr_t)psf_ssc_data;
+	ccw->cda = (__u32)virt_to_phys(psf_ssc_data);
 	ccw->count = 66;
 
 	cqr->startdev = device;
@@ -2307,7 +2307,7 @@ dasd_eckd_analysis_ccw(struct dasd_device *device)
 		ccw->cmd_code = DASD_ECKD_CCW_READ_COUNT;
 		ccw->flags = 0;
 		ccw->count = 8;
-		ccw->cda = (__u32)(addr_t) count_data;
+		ccw->cda = (__u32)virt_to_phys(count_data);
 		ccw++;
 		count_data++;
 	}
@@ -2321,7 +2321,7 @@ dasd_eckd_analysis_ccw(struct dasd_device *device)
 	ccw->cmd_code = DASD_ECKD_CCW_READ_COUNT;
 	ccw->flags = 0;
 	ccw->count = 8;
-	ccw->cda = (__u32)(addr_t) count_data;
+	ccw->cda = (__u32)virt_to_phys(count_data);
 
 	cqr->block = NULL;
 	cqr->startdev = device;
@@ -2693,7 +2693,7 @@ dasd_eckd_build_check(struct dasd_device *base, struct format_data_t *fdata,
 		ccw->cmd_code = DASD_ECKD_CCW_READ_COUNT;
 		ccw->flags = CCW_FLAG_SLI;
 		ccw->count = 8;
-		ccw->cda = (__u32)(addr_t) fmt_buffer;
+		ccw->cda = (__u32)virt_to_phys(fmt_buffer);
 		ccw++;
 		fmt_buffer++;
 	}
@@ -2903,7 +2903,7 @@ dasd_eckd_build_format(struct dasd_device *base, struct dasd_device *startdev,
 			ccw->cmd_code = DASD_ECKD_CCW_WRITE_RECORD_ZERO;
 			ccw->flags = CCW_FLAG_SLI;
 			ccw->count = 8;
-			ccw->cda = (__u32)(addr_t) ect;
+			ccw->cda = (__u32)virt_to_phys(ect);
 			ccw++;
 		}
 		if ((intensity & ~0x08) & 0x04) {	/* erase track */
@@ -2918,7 +2918,7 @@ dasd_eckd_build_format(struct dasd_device *base, struct dasd_device *startdev,
 			ccw->cmd_code = DASD_ECKD_CCW_WRITE_CKD;
 			ccw->flags = CCW_FLAG_SLI;
 			ccw->count = 8;
-			ccw->cda = (__u32)(addr_t) ect;
+			ccw->cda = (__u32)virt_to_phys(ect);
 		} else {		/* write remaining records */
 			for (i = 0; i < rpt; i++) {
 				ect = (struct eckd_count *) data;
@@ -2953,7 +2953,7 @@ dasd_eckd_build_format(struct dasd_device *base, struct dasd_device *startdev,
 						DASD_ECKD_CCW_WRITE_CKD_MT;
 				ccw->flags = CCW_FLAG_SLI;
 				ccw->count = 8;
-				ccw->cda = (__u32)(addr_t) ect;
+				ccw->cda = (__u32)virt_to_phys(ect);
 				ccw++;
 			}
 		}
@@ -3867,7 +3867,7 @@ dasd_eckd_dso_ras(struct dasd_device *device, struct dasd_block *block,
 	}
 
 	ccw = cqr->cpaddr;
-	ccw->cda = (__u32)(addr_t)cqr->data;
+	ccw->cda = (__u32)virt_to_phys(cqr->data);
 	ccw->cmd_code = DASD_ECKD_CCW_DSO;
 	ccw->count = size;
 
@@ -4136,11 +4136,11 @@ static struct dasd_ccw_req *dasd_eckd_build_cp_cmd_single(
 			ccw->cmd_code = rcmd;
 			ccw->count = count;
 			if (idal_is_needed(dst, blksize)) {
-				ccw->cda = (__u32)(addr_t) idaws;
+				ccw->cda = (__u32)virt_to_phys(idaws);
 				ccw->flags = CCW_FLAG_IDA;
 				idaws = idal_create_words(idaws, dst, blksize);
 			} else {
-				ccw->cda = (__u32)(addr_t) dst;
+				ccw->cda = (__u32)virt_to_phys(dst);
 				ccw->flags = 0;
 			}
 			ccw++;
@@ -4272,7 +4272,7 @@ static struct dasd_ccw_req *dasd_eckd_build_cp_cmd_track(
 				ccw[-1].flags |= CCW_FLAG_CC;
 				ccw->cmd_code = cmd;
 				ccw->count = len_to_track_end;
-				ccw->cda = (__u32)(addr_t)idaws;
+				ccw->cda = (__u32)virt_to_phys(idaws);
 				ccw->flags = CCW_FLAG_IDA;
 				ccw++;
 				recid += count;
@@ -4288,7 +4288,7 @@ static struct dasd_ccw_req *dasd_eckd_build_cp_cmd_track(
 			 * idaw ends
 			 */
 			if (!idaw_dst) {
-				if (__pa(dst) & (IDA_BLOCK_SIZE-1)) {
+				if ((__u32)virt_to_phys(dst) & (IDA_BLOCK_SIZE - 1)) {
 					dasd_sfree_request(cqr, startdev);
 					return ERR_PTR(-ERANGE);
 				} else
@@ -4308,7 +4308,7 @@ static struct dasd_ccw_req *dasd_eckd_build_cp_cmd_track(
 			 * idal_create_words will handle cases where idaw_len
 			 * is larger then IDA_BLOCK_SIZE
 			 */
-			if (!(__pa(idaw_dst + idaw_len) & (IDA_BLOCK_SIZE-1)))
+			if (!((__u32)virt_to_phys(idaw_dst + idaw_len) & (IDA_BLOCK_SIZE - 1)))
 				end_idaw = 1;
 			/* We also need to end the idaw at track end */
 			if (!len_to_track_end) {
@@ -4860,7 +4860,7 @@ static struct dasd_ccw_req *dasd_eckd_build_cp_raw(struct dasd_device *startdev,
 		ccw->count = 57326;
 		/* 64k map to one track */
 		len_to_track_end = 65536 - start_padding_sectors * 512;
-		ccw->cda = (__u32)(addr_t)idaws;
+		ccw->cda = (__u32)virt_to_phys(idaws);
 		ccw->flags |= CCW_FLAG_IDA;
 		ccw->flags |= CCW_FLAG_SLI;
 		ccw++;
@@ -4879,7 +4879,7 @@ static struct dasd_ccw_req *dasd_eckd_build_cp_raw(struct dasd_device *startdev,
 			ccw->count = 57326;
 			/* 64k map to one track */
 			len_to_track_end = 65536;
-			ccw->cda = (__u32)(addr_t)idaws;
+			ccw->cda = (__u32)virt_to_phys(idaws);
 			ccw->flags |= CCW_FLAG_IDA;
 			ccw->flags |= CCW_FLAG_SLI;
 			ccw++;
@@ -4936,9 +4936,9 @@ dasd_eckd_free_cp(struct dasd_ccw_req *cqr, struct request *req)
 				ccw++;
 			if (dst) {
 				if (ccw->flags & CCW_FLAG_IDA)
-					cda = *((char **)((addr_t) ccw->cda));
+					cda = *((char **)phys_to_virt(ccw->cda));
 				else
-					cda = (char *)((addr_t) ccw->cda);
+					cda = phys_to_virt(ccw->cda);
 				if (dst != cda) {
 					if (rq_data_dir(req) == READ)
 						memcpy(dst, cda, bv.bv_len);
@@ -5088,7 +5088,7 @@ dasd_eckd_release(struct dasd_device *device)
 	ccw->cmd_code = DASD_ECKD_CCW_RELEASE;
 	ccw->flags |= CCW_FLAG_SLI;
 	ccw->count = 32;
-	ccw->cda = (__u32)(addr_t) cqr->data;
+	ccw->cda = (__u32)virt_to_phys(cqr->data);
 	cqr->startdev = device;
 	cqr->memdev = device;
 	clear_bit(DASD_CQR_FLAGS_USE_ERP, &cqr->flags);
@@ -5143,7 +5143,7 @@ dasd_eckd_reserve(struct dasd_device *device)
 	ccw->cmd_code = DASD_ECKD_CCW_RESERVE;
 	ccw->flags |= CCW_FLAG_SLI;
 	ccw->count = 32;
-	ccw->cda = (__u32)(addr_t) cqr->data;
+	ccw->cda = (__u32)virt_to_phys(cqr->data);
 	cqr->startdev = device;
 	cqr->memdev = device;
 	clear_bit(DASD_CQR_FLAGS_USE_ERP, &cqr->flags);
@@ -5197,7 +5197,7 @@ dasd_eckd_steal_lock(struct dasd_device *device)
 	ccw->cmd_code = DASD_ECKD_CCW_SLCK;
 	ccw->flags |= CCW_FLAG_SLI;
 	ccw->count = 32;
-	ccw->cda = (__u32)(addr_t) cqr->data;
+	ccw->cda = (__u32)virt_to_phys(cqr->data);
 	cqr->startdev = device;
 	cqr->memdev = device;
 	clear_bit(DASD_CQR_FLAGS_USE_ERP, &cqr->flags);
@@ -5258,7 +5258,7 @@ static int dasd_eckd_snid(struct dasd_device *device,
 	ccw->cmd_code = DASD_ECKD_CCW_SNID;
 	ccw->flags |= CCW_FLAG_SLI;
 	ccw->count = 12;
-	ccw->cda = (__u32)(addr_t) cqr->data;
+	ccw->cda = (__u32)virt_to_phys(cqr->data);
 	cqr->startdev = device;
 	cqr->memdev = device;
 	clear_bit(DASD_CQR_FLAGS_USE_ERP, &cqr->flags);
@@ -5325,7 +5325,7 @@ dasd_eckd_performance(struct dasd_device *device, void __user *argp)
 	ccw->cmd_code = DASD_ECKD_CCW_PSF;
 	ccw->count = sizeof(struct dasd_psf_prssd_data);
 	ccw->flags |= CCW_FLAG_CC;
-	ccw->cda = (__u32)(addr_t) prssdp;
+	ccw->cda = (__u32)virt_to_phys(prssdp);
 
 	/* Read Subsystem Data - Performance Statistics */
 	stats = (struct dasd_rssd_perf_stats_t *) (prssdp + 1);
@@ -5334,7 +5334,7 @@ dasd_eckd_performance(struct dasd_device *device, void __user *argp)
 	ccw++;
 	ccw->cmd_code = DASD_ECKD_CCW_RSSD;
 	ccw->count = sizeof(struct dasd_rssd_perf_stats_t);
-	ccw->cda = (__u32)(addr_t) stats;
+	ccw->cda = (__u32)virt_to_phys(stats);
 
 	cqr->buildclk = get_tod_clock();
 	cqr->status = DASD_CQR_FILLED;
@@ -5478,7 +5478,7 @@ static int dasd_symm_io(struct dasd_device *device, void __user *argp)
 	ccw->cmd_code = DASD_ECKD_CCW_PSF;
 	ccw->count = usrparm.psf_data_len;
 	ccw->flags |= CCW_FLAG_CC;
-	ccw->cda = (__u32)(addr_t) psf_data;
+	ccw->cda = (__u32)virt_to_phys(psf_data);
 
 	ccw++;
 
@@ -5486,7 +5486,7 @@ static int dasd_symm_io(struct dasd_device *device, void __user *argp)
 	ccw->cmd_code = DASD_ECKD_CCW_RSSD;
 	ccw->count = usrparm.rssd_result_len;
 	ccw->flags = CCW_FLAG_SLI ;
-	ccw->cda = (__u32)(addr_t) rssd_result;
+	ccw->cda = (__u32)virt_to_phys(rssd_result);
 
 	rc = dasd_sleep_on(cqr);
 	if (rc)
@@ -5555,9 +5555,9 @@ dasd_eckd_dump_ccw_range(struct ccw1 *from, struct ccw1 *to, char *page)
 
 		/* get pointer to data (consider IDALs) */
 		if (from->flags & CCW_FLAG_IDA)
-			datap = (char *) *((addr_t *) (addr_t) from->cda);
+			datap = (char *)*((addr_t *)phys_to_virt(from->cda));
 		else
-			datap = (char *) ((addr_t) from->cda);
+			datap = phys_to_virt(from->cda);
 
 		/* dump data (max 128 bytes) */
 		for (count = 0; count < from->count && count < 128; count++) {
@@ -5628,7 +5628,7 @@ static void dasd_eckd_dump_sense_ccw(struct dasd_device *device,
 	len += sprintf(page + len, PRINTK_HEADER
 		       " device %s: Failing CCW: %p\n",
 		       dev_name(&device->cdev->dev),
-		       (void *) (addr_t) irb->scsw.cmd.cpa);
+		       phys_to_virt(irb->scsw.cmd.cpa));
 	if (irb->esw.esw0.erw.cons) {
 		for (sl = 0; sl < 4; sl++) {
 			len += sprintf(page + len, PRINTK_HEADER
@@ -5675,8 +5675,7 @@ static void dasd_eckd_dump_sense_ccw(struct dasd_device *device,
 		/* print failing CCW area (maximum 4) */
 		/* scsw->cda is either valid or zero  */
 		from = ++to;
-		fail = (struct ccw1 *)(addr_t)
-				irb->scsw.cmd.cpa; /* failing CCW */
+		fail = phys_to_virt(irb->scsw.cmd.cpa); /* failing CCW */
 		if (from <  fail - 2) {
 			from = fail - 2;     /* there is a gap - print header */
 			printk(KERN_ERR PRINTK_HEADER "......\n");
@@ -5730,13 +5729,12 @@ static void dasd_eckd_dump_sense_tcw(struct dasd_device *device,
 	len += sprintf(page + len, PRINTK_HEADER
 		       " device %s: Failing TCW: %p\n",
 		       dev_name(&device->cdev->dev),
-		       (void *) (addr_t) irb->scsw.tm.tcw);
+		       phys_to_virt(irb->scsw.tm.tcw));
 
 	tsb = NULL;
 	sense = NULL;
 	if (irb->scsw.tm.tcw && (irb->scsw.tm.fcxs & 0x01))
-		tsb = tcw_get_tsb(
-			(struct tcw *)(unsigned long)irb->scsw.tm.tcw);
+		tsb = tcw_get_tsb(phys_to_virt(irb->scsw.tm.tcw));
 
 	if (tsb) {
 		len += sprintf(page + len, PRINTK_HEADER
@@ -5962,7 +5960,7 @@ static int dasd_eckd_read_message_buffer(struct dasd_device *device,
 	ccw->count = sizeof(struct dasd_psf_prssd_data);
 	ccw->flags |= CCW_FLAG_CC;
 	ccw->flags |= CCW_FLAG_SLI;
-	ccw->cda = (__u32)(addr_t) prssdp;
+	ccw->cda = (__u32)virt_to_phys(prssdp);
 
 	/* Read Subsystem Data - message buffer */
 	message_buf = (struct dasd_rssd_messages *) (prssdp + 1);
@@ -5972,7 +5970,7 @@ static int dasd_eckd_read_message_buffer(struct dasd_device *device,
 	ccw->cmd_code = DASD_ECKD_CCW_RSSD;
 	ccw->count = sizeof(struct dasd_rssd_messages);
 	ccw->flags |= CCW_FLAG_SLI;
-	ccw->cda = (__u32)(addr_t) message_buf;
+	ccw->cda = (__u32)virt_to_phys(message_buf);
 
 	cqr->buildclk = get_tod_clock();
 	cqr->status = DASD_CQR_FILLED;
@@ -6056,14 +6054,14 @@ static int dasd_eckd_query_host_access(struct dasd_device *device,
 	ccw->count = sizeof(struct dasd_psf_prssd_data);
 	ccw->flags |= CCW_FLAG_CC;
 	ccw->flags |= CCW_FLAG_SLI;
-	ccw->cda = (__u32)(addr_t) prssdp;
+	ccw->cda = (__u32)virt_to_phys(prssdp);
 
 	/* Read Subsystem Data - query host access */
 	ccw++;
 	ccw->cmd_code = DASD_ECKD_CCW_RSSD;
 	ccw->count = sizeof(struct dasd_psf_query_host_access);
 	ccw->flags |= CCW_FLAG_SLI;
-	ccw->cda = (__u32)(addr_t) host_access;
+	ccw->cda = (__u32)virt_to_phys(host_access);
 
 	cqr->buildclk = get_tod_clock();
 	cqr->status = DASD_CQR_FILLED;
@@ -6263,7 +6261,7 @@ dasd_eckd_psf_cuir_response(struct dasd_device *device, int response,
 	psf_cuir->ssid = device->path[pos].ssid;
 	ccw = cqr->cpaddr;
 	ccw->cmd_code = DASD_ECKD_CCW_PSF;
-	ccw->cda = (__u32)(addr_t)psf_cuir;
+	ccw->cda = (__u32)virt_to_phys(psf_cuir);
 	ccw->flags = CCW_FLAG_SLI;
 	ccw->count = sizeof(struct dasd_psf_cuir_response);
 
diff --git a/drivers/s390/block/dasd_eer.c b/drivers/s390/block/dasd_eer.c
index 22338033e6bfb..aa3d746eb56db 100644
--- a/drivers/s390/block/dasd_eer.c
+++ b/drivers/s390/block/dasd_eer.c
@@ -492,7 +492,7 @@ int dasd_eer_enable(struct dasd_device *device)
 	ccw->cmd_code = DASD_ECKD_CCW_SNSS;
 	ccw->count = SNSS_DATA_SIZE;
 	ccw->flags = 0;
-	ccw->cda = (__u32)(addr_t) cqr->data;
+	ccw->cda = (__u32)virt_to_phys(cqr->data);
 
 	cqr->buildclk = get_tod_clock();
 	cqr->status = DASD_CQR_FILLED;
diff --git a/drivers/s390/block/dasd_fba.c b/drivers/s390/block/dasd_fba.c
index e084f4deddddd..7b53244c56b32 100644
--- a/drivers/s390/block/dasd_fba.c
+++ b/drivers/s390/block/dasd_fba.c
@@ -83,7 +83,7 @@ define_extent(struct ccw1 * ccw, struct DE_fba_data *data, int rw,
 	ccw->cmd_code = DASD_FBA_CCW_DEFINE_EXTENT;
 	ccw->flags = 0;
 	ccw->count = 16;
-	ccw->cda = (__u32) __pa(data);
+	ccw->cda = (__u32)virt_to_phys(data);
 	memset(data, 0, sizeof (struct DE_fba_data));
 	if (rw == WRITE)
 		(data->mask).perm = 0x0;
@@ -103,7 +103,7 @@ locate_record(struct ccw1 * ccw, struct LO_fba_data *data, int rw,
 	ccw->cmd_code = DASD_FBA_CCW_LOCATE;
 	ccw->flags = 0;
 	ccw->count = 8;
-	ccw->cda = (__u32) __pa(data);
+	ccw->cda = (__u32)virt_to_phys(data);
 	memset(data, 0, sizeof (struct LO_fba_data));
 	if (rw == WRITE)
 		data->operation.cmd = 0x5;
@@ -262,7 +262,7 @@ static void ccw_write_zero(struct ccw1 *ccw, int count)
 	ccw->cmd_code = DASD_FBA_CCW_WRITE;
 	ccw->flags |= CCW_FLAG_SLI;
 	ccw->count = count;
-	ccw->cda = (__u32) (addr_t) dasd_fba_zero_page;
+	ccw->cda = (__u32)virt_to_phys(dasd_fba_zero_page);
 }
 
 /*
@@ -528,11 +528,11 @@ static struct dasd_ccw_req *dasd_fba_build_cp_regular(
 			ccw->cmd_code = cmd;
 			ccw->count = block->bp_block;
 			if (idal_is_needed(dst, blksize)) {
-				ccw->cda = (__u32)(addr_t) idaws;
+				ccw->cda = (__u32)virt_to_phys(idaws);
 				ccw->flags = CCW_FLAG_IDA;
 				idaws = idal_create_words(idaws, dst, blksize);
 			} else {
-				ccw->cda = (__u32)(addr_t) dst;
+				ccw->cda = (__u32)virt_to_phys(dst);
 				ccw->flags = 0;
 			}
 			ccw++;
@@ -590,9 +590,9 @@ dasd_fba_free_cp(struct dasd_ccw_req *cqr, struct request *req)
 				ccw++;
 			if (dst) {
 				if (ccw->flags & CCW_FLAG_IDA)
-					cda = *((char **)((addr_t) ccw->cda));
+					cda = *((char **)phys_to_virt(ccw->cda));
 				else
-					cda = (char *)((addr_t) ccw->cda);
+					cda = phys_to_virt(ccw->cda);
 				if (dst != cda) {
 					if (rq_data_dir(req) == READ)
 						memcpy(dst, cda, bv.bv_len);
-- 
2.53.0

