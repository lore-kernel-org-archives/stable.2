Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795629695;
	b=CZAkXAADj92Q0PTA/O0EDqZKp2Ht2XrM2f9NkjThHEakbuaatHbkj7uNYhtbahVX4p2N
	 Ag3LrMn2yitTg/sHNfHIS3jcNgh/kPeH3WDReMqFUtKpK68ZvvqpgCOPoI5wbUSlRMeXW
	 BuVs7O3rp2RsTkNLds4Hm2SYpHTdpEOZb/+og/Srl0fdPOK+GiXoVw2JQMRw7nmdP3P6L
	 nuXpym+6YXyBvUVon3rbM6zYcw5fBRM2DWF5iOuFsvmba+e5y9Tl/o1Ra97rpMp+czV7t
	 rx4NUsdVNv2UxTgM5dL7dbozKUyWJKTdLjD85GjzED1GQCTIs7YZCpNHd1dzkUYoSfw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795629695;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Type:
	 Content-Transfer-Encoding;
	bh=wKMfKv0JFAudZla4qlMuc49XCQTs+deFAPw9abCanPs=;
	b=Y226n5uIHMYlLwQ7EQ/S8PWoB1NeSoka4l8I4RvI/cHMKbFpJS5yIaonVBz59RUVcl8G
	 KqasXappHkPTLI40xjimhWQ+j3H0sKJMUYjSLKradFyj2+Cfnh+itrRWx+y0Q8mgY1k1J
	 E9TudLxatesuTu3Ps6gaXMk+YqZyiDL3aw9Kscpths95hCWYT+1RFKK56flUr2IrBN7CI
	 caIBeuMKDCbN2mXotK5ed4Jcrecv2u61TLaetptvuN9LQ5LIWeQeZOvb/2+rjuDA2pAQv
	 15uEwg8H2nHu8ei2aovr3JOAUrK8Z7nm3jrqDREH9mMy/A/q7I8xMdJfz88fjdtuXww==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=ebl3FGsy;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8A5EA606A326
	for <stable@vger.kernel.org>; Wed, 25 Nov 2026 18:01:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=ebl3FGsy
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 27A0C1F000D3;
	Wed, 25 Nov 2026 18:01:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795629694;
	bh=wKMfKv0JFAudZla4qlMuc49XCQTs+deFAPw9abCanPs=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=ebl3FGsyonJZsUuR5J2KybkhLytX0KbPZbvfgsI174FkKpK7pMmzLSOb5r0RQiRyK
	 rfLvwnUt5bupP1oNfG++tvIiBFq5HMTiLLRJJ3UNamSnp2hGh8iZA4kWDvoPHmiJFe
	 KC16hcNKiHOiNvhNdPWJ0ivDxk8L5qSfe1eZ7uPeDnYzI4taXB2AcXEixxxd8WngSF
	 aU5Gj91s+91svywhEDuvMXVdqGlA0bsekkE254OoCCMFAUC/CkTdLiMDvxRT5Jb6B9
	 adJS12RgF0MCzfqJpjETr1X6PA4sEt9023V/IbfqeMxOs1LIuACF7RSWTUfqzmuz6u
	 FrXmJy7dC9p+w==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Stefan Haberland <sth@linux.ibm.com>,
	Heiko Carstens <hca@linux.ibm.com>,
	=?UTF-8?q?Jan=20H=C3=B6ppner?= <hoeppner@linux.ibm.com>,
	Jens Axboe <axboe@kernel.dk>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.6.y 4/5] s390/dasd: Fix typo 'immediatly' -> 'immediately'
Date: Wed, 25 Nov 2026 13:01:28 -0500
Message-ID: <20261125180055.1102849-4-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261125180055.1102849-1-sashal@kernel.org>
References: <2026112515-random-remodeler-3b18@gregkh>
 <20261125180055.1102849-1-sashal@kernel.org>
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
index 0a98812f87ff2..de5f0a8b85c08 100644
--- a/drivers/s390/block/dasd.c
+++ b/drivers/s390/block/dasd.c
@@ -2572,7 +2572,7 @@ static inline int _dasd_term_running_cqr(struct dasd_device *device)
 	return rc;
 }
 
-int dasd_sleep_on_immediatly(struct dasd_ccw_req *cqr)
+int dasd_sleep_on_immediately(struct dasd_ccw_req *cqr)
 {
 	struct dasd_device *device;
 	int rc;
@@ -2620,7 +2620,7 @@ int dasd_sleep_on_immediatly(struct dasd_ccw_req *cqr)
 
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
index fcf1c4b65b638..fa3363394ea15 100644
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
 
@@ -5111,7 +5111,7 @@ dasd_eckd_release(struct dasd_device *device)
 	cqr->buildclk = get_tod_clock();
 	cqr->status = DASD_CQR_FILLED;
 
-	rc = dasd_sleep_on_immediatly(cqr);
+	rc = dasd_sleep_on_immediately(cqr);
 	if (!rc)
 		clear_bit(DASD_FLAG_IS_RESERVED, &device->flags);
 
@@ -5166,7 +5166,7 @@ dasd_eckd_reserve(struct dasd_device *device)
 	cqr->buildclk = get_tod_clock();
 	cqr->status = DASD_CQR_FILLED;
 
-	rc = dasd_sleep_on_immediatly(cqr);
+	rc = dasd_sleep_on_immediately(cqr);
 	if (!rc)
 		set_bit(DASD_FLAG_IS_RESERVED, &device->flags);
 
@@ -5220,7 +5220,7 @@ dasd_eckd_steal_lock(struct dasd_device *device)
 	cqr->buildclk = get_tod_clock();
 	cqr->status = DASD_CQR_FILLED;
 
-	rc = dasd_sleep_on_immediatly(cqr);
+	rc = dasd_sleep_on_immediately(cqr);
 	if (!rc)
 		set_bit(DASD_FLAG_IS_RESERVED, &device->flags);
 
@@ -5283,7 +5283,7 @@ static int dasd_eckd_snid(struct dasd_device *device,
 	cqr->status = DASD_CQR_FILLED;
 	cqr->lpm = usrparm.path_mask;
 
-	rc = dasd_sleep_on_immediatly(cqr);
+	rc = dasd_sleep_on_immediately(cqr);
 	/* verify that I/O processing didn't modify the path mask */
 	if (!rc && usrparm.path_mask && (cqr->lpm != usrparm.path_mask))
 		rc = -EIO;
@@ -5925,7 +5925,7 @@ static int dasd_eckd_read_message_buffer(struct dasd_device *device,
 	cqr->block = NULL;
 	cqr->expires = 10 * HZ;
 	set_bit(DASD_CQR_VERIFY_PATH, &cqr->flags);
-	/* dasd_sleep_on_immediatly does not do complex error
+	/* dasd_sleep_on_immediately does not do complex error
 	 * recovery so clear erp flag and set retry counter to
 	 * do basic erp */
 	clear_bit(DASD_CQR_FLAGS_USE_ERP, &cqr->flags);
@@ -5957,7 +5957,7 @@ static int dasd_eckd_read_message_buffer(struct dasd_device *device,
 
 	cqr->buildclk = get_tod_clock();
 	cqr->status = DASD_CQR_FILLED;
-	rc = dasd_sleep_on_immediatly(cqr);
+	rc = dasd_sleep_on_immediately(cqr);
 	if (rc == 0) {
 		prssdp = (struct dasd_psf_prssd_data *) cqr->data;
 		message_buf = (struct dasd_rssd_messages *)
diff --git a/drivers/s390/block/dasd_int.h b/drivers/s390/block/dasd_int.h
index fa5e070fd0c1c..923468a28b03c 100644
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

