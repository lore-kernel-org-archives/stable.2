Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795630021;
	b=wufcUfVv3Pf0QYDv4vKMfzCevvKZFNmObS/ZKzdQE8L0VpUeqS41k7YC513gw9DDc2LO
	 d7RC+qm8HzwoG/BNtEtKKdwGAVd3RH+YsVjY5mwZAD7XWYR4EvDX9hMHvFN+1t7RwLqD7
	 w78A7jNyzAk/DDbePlsXG6xYxz4oZskhbzjcL/lLW3/Grt9MlZ+2w0+jx/6TbQ5zGRqot
	 WHpwZL+QS9PkJ8xAden9lEAgI1KAd8rMhaLN9e/hDFuoii3O7ZtlkySCfbUSkEDwOGoAX
	 ViobVaJbzDUh6lAzE9Y7ZNLy/UOvQ9/QMjhc7xAgmhT+lKfFd+VDC8HgU/BteUii1vA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795630021;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=QhIp3m3sXs4vUhBZ4SVAcLm1bKP6n0sKpjGZ9v07FfA=;
	b=Y2eAMxb1mZjTs5oGK1UVuFKj3pKyDnRBigj90bYLO/SFA2Mne2hpRE9pqMe3yWJiWirs
	 tk42Pv1nOJMH98pjhaSjimuSkZ5KP8imVuxRv8JCr9EJrS+r16znBUhO6WtWEAcTkudE7
	 mAEv+knd6P8plFoNxWw5y/+HvMg4wjFwG+pP4Ke393SOZquoK95Ew3HaVvWWICdbV+dTY
	 ONRC4NvLmV4shTP5mS79Cu3bSr/PT2K0TB9ue3vzUyiE+RJkOChy6wlLWiDVnhKUZzfBR
	 4MWeFt4a3y/OKQnlDbXzyUxONALYkExVJiq5Z1BANbSQH8qzNnI5E6oa74TZUWhfeOw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=F5Wo5ENp;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 328CE606A69C
	for <stable@vger.kernel.org>; Wed, 25 Nov 2026 18:07:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=F5Wo5ENp
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 222C21F000C4;
	Wed, 25 Nov 2026 18:07:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795630020;
	bh=QhIp3m3sXs4vUhBZ4SVAcLm1bKP6n0sKpjGZ9v07FfA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=F5Wo5ENpLvaqaKtWW1MnCmjLTYwx0BSjuuGAO0Y6rou0HVYw8MgSRsm7uil/0dMA8
	 WooCFxjPCgmxVkiCb2MmK3k7arGOZ84NfHuU6x8OHnwTDhvvbxS/8D+LN9zfLL5aQ/
	 0ImZ5nbUn9R6l6unmRppvpvA78YBpG63SvZ5lUBw9LEYYjYFpPRXVfmTxgmcHZFPTS
	 wL1tBfOZAwKc8Thr8zLD5gctD5iWDZJNQO+olQNQOcUoh4g8yL8aDHPNXBqJqz/N8L
	 OHIeO8a0ZXDTMaQ8Zc1ZMnmt9UU3nYY+E8ShSzNywrzVXtepGt0ZoxdTgDd0vZBZby
	 DlWc4biTqdGEA==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Alexander Gordeev <agordeev@linux.ibm.com>,
	Stefan Haberland <sth@linux.ibm.com>,
	Jens Axboe <axboe@kernel.dk>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.1.y 1/6] s390/dasd: sort out physical vs virtual pointers usage
Date: Wed, 25 Nov 2026 13:06:53 -0500
Message-ID: <20261125180617.1129141-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026112516-sculpture-facial-ba8e@gregkh>
References: <2026112516-sculpture-facial-ba8e@gregkh>
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
index 24a3169514a75..8d04e5bb3a586 100644
--- a/drivers/s390/block/dasd.c
+++ b/drivers/s390/block/dasd.c
@@ -3990,7 +3990,7 @@ static struct dasd_ccw_req *dasd_generic_build_rdc(struct dasd_device *device,
 
 	ccw = cqr->cpaddr;
 	ccw->cmd_code = CCW_CMD_RDC;
-	ccw->cda = (__u32)(addr_t) cqr->data;
+	ccw->cda = (__u32)virt_to_phys(cqr->data);
 	ccw->flags = 0;
 	ccw->count = rdc_buffer_size;
 	cqr->startdev = device;
@@ -4034,8 +4034,7 @@ char *dasd_get_sense(struct irb *irb)
 
 	if (scsw_is_tm(&irb->scsw) && (irb->scsw.tm.fcxs == 0x01)) {
 		if (irb->scsw.tm.tcw)
-			tsb = tcw_get_tsb((struct tcw *)(unsigned long)
-					  irb->scsw.tm.tcw);
+			tsb = tcw_get_tsb(phys_to_virt(irb->scsw.tm.tcw));
 		if (tsb && tsb->length == 64 && tsb->flags)
 			switch (tsb->flags & 0x07) {
 			case 1:	/* tsa_iostat */
diff --git a/drivers/s390/block/dasd_3990_erp.c b/drivers/s390/block/dasd_3990_erp.c
index b96044fb1a3af..07f886029a358 100644
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
@@ -1708,7 +1708,7 @@ dasd_3990_erp_action_1B_32(struct dasd_ccw_req * default_erp, char *sense)
 	ccw->cmd_code = DASD_ECKD_CCW_DEFINE_EXTENT;
 	ccw->flags = CCW_FLAG_CC;
 	ccw->count = 16;
-	ccw->cda = (__u32)(addr_t) DE_data;
+	ccw->cda = (__u32)virt_to_phys(DE_data);
 
 	/* create LO ccw */
 	ccw++;
@@ -1716,7 +1716,7 @@ dasd_3990_erp_action_1B_32(struct dasd_ccw_req * default_erp, char *sense)
 	ccw->cmd_code = DASD_ECKD_CCW_LOCATE_RECORD;
 	ccw->flags = CCW_FLAG_CC;
 	ccw->count = 16;
-	ccw->cda = (__u32)(addr_t) LO_data;
+	ccw->cda = (__u32)virt_to_phys(LO_data);
 
 	/* TIC to the failed ccw */
 	ccw++;
@@ -2413,7 +2413,7 @@ static struct dasd_ccw_req *dasd_3990_erp_add_erp(struct dasd_ccw_req *cqr)
 		tcw = erp->cpaddr;
 		tsb = (struct tsb *) &tcw[1];
 		*tcw = *((struct tcw *)cqr->cpaddr);
-		tcw->tsb = (long)tsb;
+		tcw->tsb = virt_to_phys(tsb);
 	} else if (ccw->cmd_code == DASD_ECKD_CCW_PSF) {
 		/* PSF cannot be chained from NOOP/TIC */
 		erp->cpaddr = cqr->cpaddr;
@@ -2424,7 +2424,7 @@ static struct dasd_ccw_req *dasd_3990_erp_add_erp(struct dasd_ccw_req *cqr)
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
index 2179ff50fb1a2..986e1da023075 100644
--- a/drivers/s390/block/dasd_eckd.c
+++ b/drivers/s390/block/dasd_eckd.c
@@ -291,7 +291,7 @@ define_extent(struct ccw1 *ccw, struct DE_eckd_data *data, unsigned int trk,
 		ccw->cmd_code = DASD_ECKD_CCW_DEFINE_EXTENT;
 		ccw->flags = 0;
 		ccw->count = 16;
-		ccw->cda = (__u32)__pa(data);
+		ccw->cda = (__u32)virt_to_phys(data);
 	}
 
 	memset(data, 0, sizeof(struct DE_eckd_data));
@@ -401,7 +401,7 @@ static void locate_record_ext(struct ccw1 *ccw, struct LRE_eckd_data *data,
 			ccw->count = 22;
 		else
 			ccw->count = 20;
-		ccw->cda = (__u32)__pa(data);
+		ccw->cda = (__u32)virt_to_phys(data);
 	}
 
 	memset(data, 0, sizeof(*data));
@@ -547,11 +547,11 @@ static int prefix_LRE(struct ccw1 *ccw, struct PFX_eckd_data *pfxdata,
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
 
@@ -618,7 +618,7 @@ locate_record(struct ccw1 *ccw, struct LO_eckd_data *data, unsigned int trk,
 	ccw->cmd_code = DASD_ECKD_CCW_LOCATE_RECORD;
 	ccw->flags = 0;
 	ccw->count = 16;
-	ccw->cda = (__u32) __pa(data);
+	ccw->cda = (__u32)virt_to_phys(data);
 
 	memset(data, 0, sizeof(struct LO_eckd_data));
 	sector = 0;
@@ -833,7 +833,7 @@ static void dasd_eckd_fill_rcd_cqr(struct dasd_device *device,
 	ccw = cqr->cpaddr;
 	ccw->cmd_code = DASD_ECKD_CCW_RCD;
 	ccw->flags = 0;
-	ccw->cda = (__u32)(addr_t)rcd_buffer;
+	ccw->cda = (__u32)virt_to_phys(rcd_buffer);
 	ccw->count = DASD_ECKD_RCD_DATA_SIZE;
 	cqr->magic = DASD_ECKD_MAGIC;
 
@@ -861,7 +861,7 @@ static void read_conf_cb(struct dasd_ccw_req *cqr, void *data)
 
 	if (cqr->status !=  DASD_CQR_DONE) {
 		ccw = cqr->cpaddr;
-		rcd_buffer = (__u8 *)((addr_t) ccw->cda);
+		rcd_buffer = phys_to_virt(ccw->cda);
 		memset(rcd_buffer, 0, sizeof(*rcd_buffer));
 
 		rcd_buffer[0] = 0xE5;
@@ -1552,7 +1552,7 @@ static int dasd_eckd_read_features(struct dasd_device *device)
 	ccw->cmd_code = DASD_ECKD_CCW_PSF;
 	ccw->count = sizeof(struct dasd_psf_prssd_data);
 	ccw->flags |= CCW_FLAG_CC;
-	ccw->cda = (__u32)(addr_t) prssdp;
+	ccw->cda = (__u32)virt_to_phys(prssdp);
 
 	/* Read Subsystem Data - feature codes */
 	features = (struct dasd_rssd_features *) (prssdp + 1);
@@ -1561,7 +1561,7 @@ static int dasd_eckd_read_features(struct dasd_device *device)
 	ccw++;
 	ccw->cmd_code = DASD_ECKD_CCW_RSSD;
 	ccw->count = sizeof(struct dasd_rssd_features);
-	ccw->cda = (__u32)(addr_t) features;
+	ccw->cda = (__u32)virt_to_phys(features);
 
 	cqr->buildclk = get_tod_clock();
 	cqr->status = DASD_CQR_FILLED;
@@ -1621,7 +1621,7 @@ static int dasd_eckd_read_vol_info(struct dasd_device *device)
 	ccw->cmd_code = DASD_ECKD_CCW_PSF;
 	ccw->count = sizeof(*prssdp);
 	ccw->flags |= CCW_FLAG_CC;
-	ccw->cda = (__u32)(addr_t)prssdp;
+	ccw->cda = (__u32)virt_to_phys(prssdp);
 
 	/* Read Subsystem Data - Volume Storage Query */
 	vsq = (struct dasd_rssd_vsq *)(prssdp + 1);
@@ -1631,7 +1631,7 @@ static int dasd_eckd_read_vol_info(struct dasd_device *device)
 	ccw->cmd_code = DASD_ECKD_CCW_RSSD;
 	ccw->count = sizeof(*vsq);
 	ccw->flags |= CCW_FLAG_SLI;
-	ccw->cda = (__u32)(addr_t)vsq;
+	ccw->cda = (__u32)virt_to_phys(vsq);
 
 	cqr->buildclk = get_tod_clock();
 	cqr->status = DASD_CQR_FILLED;
@@ -1821,7 +1821,7 @@ static int dasd_eckd_read_ext_pool_info(struct dasd_device *device)
 	ccw->cmd_code = DASD_ECKD_CCW_PSF;
 	ccw->count = sizeof(*prssdp);
 	ccw->flags |= CCW_FLAG_CC;
-	ccw->cda = (__u32)(addr_t)prssdp;
+	ccw->cda = (__u32)virt_to_phys(prssdp);
 
 	lcq = (struct dasd_rssd_lcq *)(prssdp + 1);
 	memset(lcq, 0, sizeof(*lcq));
@@ -1830,7 +1830,7 @@ static int dasd_eckd_read_ext_pool_info(struct dasd_device *device)
 	ccw->cmd_code = DASD_ECKD_CCW_RSSD;
 	ccw->count = sizeof(*lcq);
 	ccw->flags |= CCW_FLAG_SLI;
-	ccw->cda = (__u32)(addr_t)lcq;
+	ccw->cda = (__u32)virt_to_phys(lcq);
 
 	cqr->buildclk = get_tod_clock();
 	cqr->status = DASD_CQR_FILLED;
@@ -1940,7 +1940,7 @@ static struct dasd_ccw_req *dasd_eckd_build_psf_ssc(struct dasd_device *device,
 	}
 	ccw = cqr->cpaddr;
 	ccw->cmd_code = DASD_ECKD_CCW_PSF;
-	ccw->cda = (__u32)(addr_t)psf_ssc_data;
+	ccw->cda = (__u32)virt_to_phys(psf_ssc_data);
 	ccw->count = 66;
 
 	cqr->startdev = device;
@@ -2295,7 +2295,7 @@ dasd_eckd_analysis_ccw(struct dasd_device *device)
 		ccw->cmd_code = DASD_ECKD_CCW_READ_COUNT;
 		ccw->flags = 0;
 		ccw->count = 8;
-		ccw->cda = (__u32)(addr_t) count_data;
+		ccw->cda = (__u32)virt_to_phys(count_data);
 		ccw++;
 		count_data++;
 	}
@@ -2309,7 +2309,7 @@ dasd_eckd_analysis_ccw(struct dasd_device *device)
 	ccw->cmd_code = DASD_ECKD_CCW_READ_COUNT;
 	ccw->flags = 0;
 	ccw->count = 8;
-	ccw->cda = (__u32)(addr_t) count_data;
+	ccw->cda = (__u32)virt_to_phys(count_data);
 
 	cqr->block = NULL;
 	cqr->startdev = device;
@@ -2681,7 +2681,7 @@ dasd_eckd_build_check(struct dasd_device *base, struct format_data_t *fdata,
 		ccw->cmd_code = DASD_ECKD_CCW_READ_COUNT;
 		ccw->flags = CCW_FLAG_SLI;
 		ccw->count = 8;
-		ccw->cda = (__u32)(addr_t) fmt_buffer;
+		ccw->cda = (__u32)virt_to_phys(fmt_buffer);
 		ccw++;
 		fmt_buffer++;
 	}
@@ -2891,7 +2891,7 @@ dasd_eckd_build_format(struct dasd_device *base, struct dasd_device *startdev,
 			ccw->cmd_code = DASD_ECKD_CCW_WRITE_RECORD_ZERO;
 			ccw->flags = CCW_FLAG_SLI;
 			ccw->count = 8;
-			ccw->cda = (__u32)(addr_t) ect;
+			ccw->cda = (__u32)virt_to_phys(ect);
 			ccw++;
 		}
 		if ((intensity & ~0x08) & 0x04) {	/* erase track */
@@ -2906,7 +2906,7 @@ dasd_eckd_build_format(struct dasd_device *base, struct dasd_device *startdev,
 			ccw->cmd_code = DASD_ECKD_CCW_WRITE_CKD;
 			ccw->flags = CCW_FLAG_SLI;
 			ccw->count = 8;
-			ccw->cda = (__u32)(addr_t) ect;
+			ccw->cda = (__u32)virt_to_phys(ect);
 		} else {		/* write remaining records */
 			for (i = 0; i < rpt; i++) {
 				ect = (struct eckd_count *) data;
@@ -2941,7 +2941,7 @@ dasd_eckd_build_format(struct dasd_device *base, struct dasd_device *startdev,
 						DASD_ECKD_CCW_WRITE_CKD_MT;
 				ccw->flags = CCW_FLAG_SLI;
 				ccw->count = 8;
-				ccw->cda = (__u32)(addr_t) ect;
+				ccw->cda = (__u32)virt_to_phys(ect);
 				ccw++;
 			}
 		}
@@ -3884,7 +3884,7 @@ dasd_eckd_dso_ras(struct dasd_device *device, struct dasd_block *block,
 	}
 
 	ccw = cqr->cpaddr;
-	ccw->cda = (__u32)(addr_t)cqr->data;
+	ccw->cda = (__u32)virt_to_phys(cqr->data);
 	ccw->cmd_code = DASD_ECKD_CCW_DSO;
 	ccw->count = size;
 
@@ -4153,11 +4153,11 @@ static struct dasd_ccw_req *dasd_eckd_build_cp_cmd_single(
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
@@ -4289,7 +4289,7 @@ static struct dasd_ccw_req *dasd_eckd_build_cp_cmd_track(
 				ccw[-1].flags |= CCW_FLAG_CC;
 				ccw->cmd_code = cmd;
 				ccw->count = len_to_track_end;
-				ccw->cda = (__u32)(addr_t)idaws;
+				ccw->cda = (__u32)virt_to_phys(idaws);
 				ccw->flags = CCW_FLAG_IDA;
 				ccw++;
 				recid += count;
@@ -4305,7 +4305,7 @@ static struct dasd_ccw_req *dasd_eckd_build_cp_cmd_track(
 			 * idaw ends
 			 */
 			if (!idaw_dst) {
-				if (__pa(dst) & (IDA_BLOCK_SIZE-1)) {
+				if ((__u32)virt_to_phys(dst) & (IDA_BLOCK_SIZE - 1)) {
 					dasd_sfree_request(cqr, startdev);
 					return ERR_PTR(-ERANGE);
 				} else
@@ -4325,7 +4325,7 @@ static struct dasd_ccw_req *dasd_eckd_build_cp_cmd_track(
 			 * idal_create_words will handle cases where idaw_len
 			 * is larger then IDA_BLOCK_SIZE
 			 */
-			if (!(__pa(idaw_dst + idaw_len) & (IDA_BLOCK_SIZE-1)))
+			if (!((__u32)virt_to_phys(idaw_dst + idaw_len) & (IDA_BLOCK_SIZE - 1)))
 				end_idaw = 1;
 			/* We also need to end the idaw at track end */
 			if (!len_to_track_end) {
@@ -4877,7 +4877,7 @@ static struct dasd_ccw_req *dasd_eckd_build_cp_raw(struct dasd_device *startdev,
 		ccw->count = 57326;
 		/* 64k map to one track */
 		len_to_track_end = 65536 - start_padding_sectors * 512;
-		ccw->cda = (__u32)(addr_t)idaws;
+		ccw->cda = (__u32)virt_to_phys(idaws);
 		ccw->flags |= CCW_FLAG_IDA;
 		ccw->flags |= CCW_FLAG_SLI;
 		ccw++;
@@ -4896,7 +4896,7 @@ static struct dasd_ccw_req *dasd_eckd_build_cp_raw(struct dasd_device *startdev,
 			ccw->count = 57326;
 			/* 64k map to one track */
 			len_to_track_end = 65536;
-			ccw->cda = (__u32)(addr_t)idaws;
+			ccw->cda = (__u32)virt_to_phys(idaws);
 			ccw->flags |= CCW_FLAG_IDA;
 			ccw->flags |= CCW_FLAG_SLI;
 			ccw++;
@@ -4953,9 +4953,9 @@ dasd_eckd_free_cp(struct dasd_ccw_req *cqr, struct request *req)
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
@@ -5105,7 +5105,7 @@ dasd_eckd_release(struct dasd_device *device)
 	ccw->cmd_code = DASD_ECKD_CCW_RELEASE;
 	ccw->flags |= CCW_FLAG_SLI;
 	ccw->count = 32;
-	ccw->cda = (__u32)(addr_t) cqr->data;
+	ccw->cda = (__u32)virt_to_phys(cqr->data);
 	cqr->startdev = device;
 	cqr->memdev = device;
 	clear_bit(DASD_CQR_FLAGS_USE_ERP, &cqr->flags);
@@ -5160,7 +5160,7 @@ dasd_eckd_reserve(struct dasd_device *device)
 	ccw->cmd_code = DASD_ECKD_CCW_RESERVE;
 	ccw->flags |= CCW_FLAG_SLI;
 	ccw->count = 32;
-	ccw->cda = (__u32)(addr_t) cqr->data;
+	ccw->cda = (__u32)virt_to_phys(cqr->data);
 	cqr->startdev = device;
 	cqr->memdev = device;
 	clear_bit(DASD_CQR_FLAGS_USE_ERP, &cqr->flags);
@@ -5214,7 +5214,7 @@ dasd_eckd_steal_lock(struct dasd_device *device)
 	ccw->cmd_code = DASD_ECKD_CCW_SLCK;
 	ccw->flags |= CCW_FLAG_SLI;
 	ccw->count = 32;
-	ccw->cda = (__u32)(addr_t) cqr->data;
+	ccw->cda = (__u32)virt_to_phys(cqr->data);
 	cqr->startdev = device;
 	cqr->memdev = device;
 	clear_bit(DASD_CQR_FLAGS_USE_ERP, &cqr->flags);
@@ -5275,7 +5275,7 @@ static int dasd_eckd_snid(struct dasd_device *device,
 	ccw->cmd_code = DASD_ECKD_CCW_SNID;
 	ccw->flags |= CCW_FLAG_SLI;
 	ccw->count = 12;
-	ccw->cda = (__u32)(addr_t) cqr->data;
+	ccw->cda = (__u32)virt_to_phys(cqr->data);
 	cqr->startdev = device;
 	cqr->memdev = device;
 	clear_bit(DASD_CQR_FLAGS_USE_ERP, &cqr->flags);
@@ -5342,7 +5342,7 @@ dasd_eckd_performance(struct dasd_device *device, void __user *argp)
 	ccw->cmd_code = DASD_ECKD_CCW_PSF;
 	ccw->count = sizeof(struct dasd_psf_prssd_data);
 	ccw->flags |= CCW_FLAG_CC;
-	ccw->cda = (__u32)(addr_t) prssdp;
+	ccw->cda = (__u32)virt_to_phys(prssdp);
 
 	/* Read Subsystem Data - Performance Statistics */
 	stats = (struct dasd_rssd_perf_stats_t *) (prssdp + 1);
@@ -5351,7 +5351,7 @@ dasd_eckd_performance(struct dasd_device *device, void __user *argp)
 	ccw++;
 	ccw->cmd_code = DASD_ECKD_CCW_RSSD;
 	ccw->count = sizeof(struct dasd_rssd_perf_stats_t);
-	ccw->cda = (__u32)(addr_t) stats;
+	ccw->cda = (__u32)virt_to_phys(stats);
 
 	cqr->buildclk = get_tod_clock();
 	cqr->status = DASD_CQR_FILLED;
@@ -5495,7 +5495,7 @@ static int dasd_symm_io(struct dasd_device *device, void __user *argp)
 	ccw->cmd_code = DASD_ECKD_CCW_PSF;
 	ccw->count = usrparm.psf_data_len;
 	ccw->flags |= CCW_FLAG_CC;
-	ccw->cda = (__u32)(addr_t) psf_data;
+	ccw->cda = (__u32)virt_to_phys(psf_data);
 
 	ccw++;
 
@@ -5503,7 +5503,7 @@ static int dasd_symm_io(struct dasd_device *device, void __user *argp)
 	ccw->cmd_code = DASD_ECKD_CCW_RSSD;
 	ccw->count = usrparm.rssd_result_len;
 	ccw->flags = CCW_FLAG_SLI ;
-	ccw->cda = (__u32)(addr_t) rssd_result;
+	ccw->cda = (__u32)virt_to_phys(rssd_result);
 
 	rc = dasd_sleep_on(cqr);
 	if (rc)
@@ -5572,9 +5572,9 @@ dasd_eckd_dump_ccw_range(struct ccw1 *from, struct ccw1 *to, char *page)
 
 		/* get pointer to data (consider IDALs) */
 		if (from->flags & CCW_FLAG_IDA)
-			datap = (char *) *((addr_t *) (addr_t) from->cda);
+			datap = (char *)*((addr_t *)phys_to_virt(from->cda));
 		else
-			datap = (char *) ((addr_t) from->cda);
+			datap = phys_to_virt(from->cda);
 
 		/* dump data (max 128 bytes) */
 		for (count = 0; count < from->count && count < 128; count++) {
@@ -5645,7 +5645,7 @@ static void dasd_eckd_dump_sense_ccw(struct dasd_device *device,
 	len += sprintf(page + len, PRINTK_HEADER
 		       " device %s: Failing CCW: %p\n",
 		       dev_name(&device->cdev->dev),
-		       (void *) (addr_t) irb->scsw.cmd.cpa);
+		       phys_to_virt(irb->scsw.cmd.cpa));
 	if (irb->esw.esw0.erw.cons) {
 		for (sl = 0; sl < 4; sl++) {
 			len += sprintf(page + len, PRINTK_HEADER
@@ -5692,8 +5692,7 @@ static void dasd_eckd_dump_sense_ccw(struct dasd_device *device,
 		/* print failing CCW area (maximum 4) */
 		/* scsw->cda is either valid or zero  */
 		from = ++to;
-		fail = (struct ccw1 *)(addr_t)
-				irb->scsw.cmd.cpa; /* failing CCW */
+		fail = phys_to_virt(irb->scsw.cmd.cpa); /* failing CCW */
 		if (from <  fail - 2) {
 			from = fail - 2;     /* there is a gap - print header */
 			printk(KERN_ERR PRINTK_HEADER "......\n");
@@ -5747,13 +5746,12 @@ static void dasd_eckd_dump_sense_tcw(struct dasd_device *device,
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
@@ -5973,7 +5971,7 @@ static int dasd_eckd_read_message_buffer(struct dasd_device *device,
 	ccw->count = sizeof(struct dasd_psf_prssd_data);
 	ccw->flags |= CCW_FLAG_CC;
 	ccw->flags |= CCW_FLAG_SLI;
-	ccw->cda = (__u32)(addr_t) prssdp;
+	ccw->cda = (__u32)virt_to_phys(prssdp);
 
 	/* Read Subsystem Data - message buffer */
 	message_buf = (struct dasd_rssd_messages *) (prssdp + 1);
@@ -5983,7 +5981,7 @@ static int dasd_eckd_read_message_buffer(struct dasd_device *device,
 	ccw->cmd_code = DASD_ECKD_CCW_RSSD;
 	ccw->count = sizeof(struct dasd_rssd_messages);
 	ccw->flags |= CCW_FLAG_SLI;
-	ccw->cda = (__u32)(addr_t) message_buf;
+	ccw->cda = (__u32)virt_to_phys(message_buf);
 
 	cqr->buildclk = get_tod_clock();
 	cqr->status = DASD_CQR_FILLED;
@@ -6067,14 +6065,14 @@ static int dasd_eckd_query_host_access(struct dasd_device *device,
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
@@ -6434,7 +6432,7 @@ dasd_eckd_psf_cuir_response(struct dasd_device *device, int response,
 	psf_cuir->ssid = device->path[pos].ssid;
 	ccw = cqr->cpaddr;
 	ccw->cmd_code = DASD_ECKD_CCW_PSF;
-	ccw->cda = (__u32)(addr_t)psf_cuir;
+	ccw->cda = (__u32)virt_to_phys(psf_cuir);
 	ccw->flags = CCW_FLAG_SLI;
 	ccw->count = sizeof(struct dasd_psf_cuir_response);
 
diff --git a/drivers/s390/block/dasd_eer.c b/drivers/s390/block/dasd_eer.c
index d16c699b9ac6d..c956de711cf78 100644
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
index 0a8241b3bfdf5..c06fa2b271205 100644
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

