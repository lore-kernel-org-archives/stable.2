Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795630027;
	b=UeiYP1zBP4BiK/jZgwKiBcfnz1gf5bK73dgXgJTUV4wmywoM+kVE8pwlAZE1i7Gbd76K
	 B7M8md/PnGEL+RKgAws9L6snlRJNX6dWzYA+5iNbFcAEE7bnHAEnu7Hlqym4I6NaBc2wt
	 YevDfs4Thk9IbHTLARxP2qlCuHnZ2WzyZexf8j8fdzeoUjH77TagGNHKV8p8b+AlKgDOH
	 aCk1YC4NAozpAn2Qx2cZXuiynQlnbBaqnb3eWJlNlslg3K1Gnb7kCDRCzmWPfh8JXX1my
	 I90lVeNAkW87nk1Gz3cBMjwvvy4fOZnv1/peyHcRAR/RmfU7uJ6dj4sdURUXAya5eyw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795630027;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Type:
	 Content-Transfer-Encoding;
	bh=xR7iYWRHvc+xeM+fmDuSK+AE/UzLaxfEB64DZrcEgEM=;
	b=bcaXVmKezoe7HfwgH0h2lZOoWXccNw37zT/nEKiQ2vbZOFnk8ItNVF+n/gWTBMitlmfC
	 JN8NdOMGpXGzeWvbCLh/YxlvvX7q75dF/f1IOGVImfhXZdxlu2Dfuap6b8hShz+9h7gRU
	 79+2zkQ6JExh7Kduz9j+xe3WY6epWTlbBB1I5YHOaYNgwqbMgghSYYuarrfSOmSUc77kT
	 VOi7lnOrmH5J52oXBOq30ilNozTl1NbedSPpzsFhEn6o2sFnwaPrt3YDRyQaXcpAD8yt8
	 jZhybcG2Vj2b0raTitwRpibCNI2sMsNeXTZuyiFlqZMxZZAaAORnA9P8OnQ3wchCPNQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=RaaHAp9x;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 768C5606A326
	for <stable@vger.kernel.org>; Wed, 25 Nov 2026 18:07:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=RaaHAp9x
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1C01D1F000D3;
	Wed, 25 Nov 2026 18:07:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795630026;
	bh=xR7iYWRHvc+xeM+fmDuSK+AE/UzLaxfEB64DZrcEgEM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=RaaHAp9xWlUyUY6L8o9AcBLXpqJx2H2EioPK0LRzk5geFeZ6InEvqTrDLB0XMIgHk
	 5kUReyseNsIU94xqz64GVl1KSNcJ7A8bp/VISKEB/YniNtnoCiAZC2hDLwyLNNiyV6
	 xniQa2NupWnN2K2fiyCyzct8yz2G7J52oNBA8gKszr8wsdhEwgQnxq/MWRY4Wsdkqq
	 tvk5aPApSTE7/HGaGrUmyKQs2SVg/XX409gODguElp1CgLmjnoobI426Wf7iXsSLHQ
	 VIvdk4JlfdCYrm+tlc/XkJJXSSU1MvFEXFy2siellrvCh9fZgXVa2P44ax8+LIm/L3
	 DUzJWd0AvAoRA==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Stefan Haberland <sth@linux.ibm.com>,
	Heiko Carstens <hca@linux.ibm.com>,
	=?UTF-8?q?Jan=20H=C3=B6ppner?= <hoeppner@linux.ibm.com>,
	Jens Axboe <axboe@kernel.dk>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.1.y 5/6] s390/dasd: Fix typo 'immediatly' -> 'immediately'
Date: Wed, 25 Nov 2026 13:06:57 -0500
Message-ID: <20261125180617.1129141-5-sashal@kernel.org>
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
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

From: Stefan Haberland <sth@linux.ibm.com>

[ Upstream commit ae6f19236b5ae4eef4df2780d51bee19add0eba8 ]

Fix typo in function name dasd_sleep_on_immediatly().

Suggested-by: Heiko Carstens <hca@linux.ibm.com>
Reviewed-by: Jan Höppner <hoeppner@linux.ibm.com>
Signed-off-by: Stefan Haberland <sth@linux.ibm.com>
Link: https://patch.msgid.link/20261112102608.1057852-2-sth@linux.ibm.com
Signed-off-by: Jens Axboe <axboe@kernel.dk>
Stable-dep-of: 25cdc1f63227 ("s390/dasd: Re-initialize RCD buffer with "V1.0" before every start")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/s390/block/dasd.c       |  4 ++--
 drivers/s390/block/dasd_alias.c |  2 +-
 drivers/s390/block/dasd_eckd.c  | 14 +++++++-------
 drivers/s390/block/dasd_int.h   |  2 +-
 4 files changed, 11 insertions(+), 11 deletions(-)

diff --git a/drivers/s390/block/dasd.c b/drivers/s390/block/dasd.c
index aa7d370b14549..4b52833c00ecc 100644
--- a/drivers/s390/block/dasd.c
+++ b/drivers/s390/block/dasd.c
@@ -2559,7 +2559,7 @@ static inline int _dasd_term_running_cqr(struct dasd_device *device)
 	return rc;
 }
 
-int dasd_sleep_on_immediatly(struct dasd_ccw_req *cqr)
+int dasd_sleep_on_immediately(struct dasd_ccw_req *cqr)
 {
 	struct dasd_device *device;
 	int rc;
@@ -2607,7 +2607,7 @@ int dasd_sleep_on_immediatly(struct dasd_ccw_req *cqr)
 
 	return rc;
 }
-EXPORT_SYMBOL(dasd_sleep_on_immediatly);
+EXPORT_SYMBOL(dasd_sleep_on_immediately);
 
 /*
  * Cancels a request that was started with dasd_sleep_on_req.
diff --git a/drivers/s390/block/dasd_alias.c b/drivers/s390/block/dasd_alias.c
index e77393e6f63ab..57c591028d4eb 100644
--- a/drivers/s390/block/dasd_alias.c
+++ b/drivers/s390/block/dasd_alias.c
@@ -759,7 +759,7 @@ static int reset_summary_unit_check(struct alias_lcu *lcu,
 	cqr->buildclk = get_tod_clock();
 	cqr->status = DASD_CQR_FILLED;
 
-	rc = dasd_sleep_on_immediatly(cqr);
+	rc = dasd_sleep_on_immediately(cqr);
 	return rc;
 }
 
diff --git a/drivers/s390/block/dasd_eckd.c b/drivers/s390/block/dasd_eckd.c
index c103a006b22f5..3650908c61a17 100644
--- a/drivers/s390/block/dasd_eckd.c
+++ b/drivers/s390/block/dasd_eckd.c
@@ -887,7 +887,7 @@ static int dasd_eckd_read_conf_immediately(struct dasd_device *device,
 	set_bit(DASD_CQR_ALLOW_SLOCK, &cqr->flags);
 	cqr->retries = 5;
 	cqr->callback = read_conf_cb;
-	rc = dasd_sleep_on_immediatly(cqr);
+	rc = dasd_sleep_on_immediately(cqr);
 	return rc;
 }
 
@@ -5110,7 +5110,7 @@ dasd_eckd_release(struct dasd_device *device)
 	cqr->buildclk = get_tod_clock();
 	cqr->status = DASD_CQR_FILLED;
 
-	rc = dasd_sleep_on_immediatly(cqr);
+	rc = dasd_sleep_on_immediately(cqr);
 	if (!rc)
 		clear_bit(DASD_FLAG_IS_RESERVED, &device->flags);
 
@@ -5165,7 +5165,7 @@ dasd_eckd_reserve(struct dasd_device *device)
 	cqr->buildclk = get_tod_clock();
 	cqr->status = DASD_CQR_FILLED;
 
-	rc = dasd_sleep_on_immediatly(cqr);
+	rc = dasd_sleep_on_immediately(cqr);
 	if (!rc)
 		set_bit(DASD_FLAG_IS_RESERVED, &device->flags);
 
@@ -5219,7 +5219,7 @@ dasd_eckd_steal_lock(struct dasd_device *device)
 	cqr->buildclk = get_tod_clock();
 	cqr->status = DASD_CQR_FILLED;
 
-	rc = dasd_sleep_on_immediatly(cqr);
+	rc = dasd_sleep_on_immediately(cqr);
 	if (!rc)
 		set_bit(DASD_FLAG_IS_RESERVED, &device->flags);
 
@@ -5282,7 +5282,7 @@ static int dasd_eckd_snid(struct dasd_device *device,
 	cqr->status = DASD_CQR_FILLED;
 	cqr->lpm = usrparm.path_mask;
 
-	rc = dasd_sleep_on_immediatly(cqr);
+	rc = dasd_sleep_on_immediately(cqr);
 	/* verify that I/O processing didn't modify the path mask */
 	if (!rc && usrparm.path_mask && (cqr->lpm != usrparm.path_mask))
 		rc = -EIO;
@@ -5924,7 +5924,7 @@ static int dasd_eckd_read_message_buffer(struct dasd_device *device,
 	cqr->block = NULL;
 	cqr->expires = 10 * HZ;
 	set_bit(DASD_CQR_VERIFY_PATH, &cqr->flags);
-	/* dasd_sleep_on_immediatly does not do complex error
+	/* dasd_sleep_on_immediately does not do complex error
 	 * recovery so clear erp flag and set retry counter to
 	 * do basic erp */
 	clear_bit(DASD_CQR_FLAGS_USE_ERP, &cqr->flags);
@@ -5956,7 +5956,7 @@ static int dasd_eckd_read_message_buffer(struct dasd_device *device,
 
 	cqr->buildclk = get_tod_clock();
 	cqr->status = DASD_CQR_FILLED;
-	rc = dasd_sleep_on_immediatly(cqr);
+	rc = dasd_sleep_on_immediately(cqr);
 	if (rc == 0) {
 		prssdp = (struct dasd_psf_prssd_data *) cqr->data;
 		message_buf = (struct dasd_rssd_messages *)
diff --git a/drivers/s390/block/dasd_int.h b/drivers/s390/block/dasd_int.h
index 7823e6c06e29c..364f0ad623933 100644
--- a/drivers/s390/block/dasd_int.h
+++ b/drivers/s390/block/dasd_int.h
@@ -888,7 +888,7 @@ void dasd_schedule_device_bh(struct dasd_device *);
 void dasd_schedule_block_bh(struct dasd_block *);
 int  dasd_sleep_on(struct dasd_ccw_req *);
 int  dasd_sleep_on_queue(struct list_head *);
-int  dasd_sleep_on_immediatly(struct dasd_ccw_req *);
+int  dasd_sleep_on_immediately(struct dasd_ccw_req *);
 int  dasd_sleep_on_queue_interruptible(struct list_head *);
 int  dasd_sleep_on_interruptible(struct dasd_ccw_req *);
 void dasd_device_set_timer(struct dasd_device *, int);
-- 
2.53.0

