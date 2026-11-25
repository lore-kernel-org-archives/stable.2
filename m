Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795628514;
	b=l/Omm4FqlSEIbl7fLX9niMs9dZfjvNW2CisYlBpnltxzAsQ9/vKvnO5ErsNEyo/DILb2
	 kmW4jtH4YtFt0hoi105JnK+ShYZhAQCxQxXGqttuMIA7Pi/D6wX3Ezua9/1XKro/iGKYR
	 OqCQyi0JDkC2X0zxQjak7zh5I2Znt6D0VykzSPwKPVLZ1RLRRartil8EkDoa8V6s9x2XM
	 KSVACd8LM21Ikg2TaYj9iz9F10QlLSHxCaL6Z0oEwmarzDqmJkIDmS/xUGldm+FIvvPWx
	 LSEpOHSNTD7o9DXs2GHcYI1qa0l+g8z4xsk1nq0OxRoB8zXdaHYRWW6joElZviMw/YQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795628514;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Type:
	 Content-Transfer-Encoding;
	bh=jv3hKonhHlz2cW6Z2jcJ0vvEI8DkelwwWiU+kHvRwNM=;
	b=TNP+1NXanygxCdCqREQvxqebfxZlqJm2U+S5j6ZjLugUDoaoqOhB6MOrNtAv8gwr7HTz
	 Mg3sUBu3e8fcsrvAbJrOeHGPwk+TOCQXNmfpKU9Sjc573qmk9fTUxm8nfFZSq490vpzl6
	 /5EXdAlRgQliJE9mvaIqJW4SC9aIELWfSEpog5vFxDEi+Xp3X2Uzim86DgsGwBUtQlI2G
	 YRZi6yVVCyPCpo/9TTjRQJUBtrDG2P9zbo6P9rYGc2r5CAM/jA7vCJ7dfhfCMaXWWVMyS
	 kXkkntc73Rb537vEkWtfJWO6ATdTvMoyMXOqyyBu6l++pPcyoyVPbY9CMrfKHWajRlw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=k5YBJYJT;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 28469606A31E
	for <stable@vger.kernel.org>; Wed, 25 Nov 2026 17:41:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=k5YBJYJT
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B59681F000C6;
	Wed, 25 Nov 2026 17:41:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795628513;
	bh=jv3hKonhHlz2cW6Z2jcJ0vvEI8DkelwwWiU+kHvRwNM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=k5YBJYJTRTltL1ysWc5eOPb1Zrnn4nLIPS1vKp/LXm+0yQpUNYE9FJwwNBbGfH/aQ
	 vfxZt/bn7ulfZ2pD+nSrPM0clAeRBeJnPkfd42bHN/wNi2joEHfmUoLF5nAgOVn7Zb
	 Na1Lj6w8h2UTvnjgtqDTlExEnfGY5vCbpM8a8Y2Vb+AyDHkloWxhDxFsD1EPinUX5l
	 2Hvnv/bGaX6mVNDou+CqmaXV8QIV+DRsoJNmKQeXgwbeI0QWOCgGXdsp5Rd33tK1OY
	 +XpP6kIoEdc8vCR5S+Ht74FmNrch0aEyV185tcJaH4VJxLsQGfI0Q9wqog7e3KuM20
	 2tTewwKiEtp7w==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Stefan Haberland <sth@linux.ibm.com>,
	Heiko Carstens <hca@linux.ibm.com>,
	=?UTF-8?q?Jan=20H=C3=B6ppner?= <hoeppner@linux.ibm.com>,
	Jens Axboe <axboe@kernel.dk>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 7.3.y 1/2] s390/dasd: Fix typo 'immediatly' -> 'immediately'
Date: Wed, 25 Nov 2026 12:41:50 -0500
Message-ID: <20261125174145.999872-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026112513-parasite-blouse-1597@gregkh>
References: <2026112513-parasite-blouse-1597@gregkh>
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
index 2ffe404b890fd..d74ef737ae26a 100644
--- a/drivers/s390/block/dasd.c
+++ b/drivers/s390/block/dasd.c
@@ -2576,7 +2576,7 @@ static inline int _dasd_term_running_cqr(struct dasd_device *device)
 	return rc;
 }
 
-int dasd_sleep_on_immediatly(struct dasd_ccw_req *cqr)
+int dasd_sleep_on_immediately(struct dasd_ccw_req *cqr)
 {
 	struct dasd_device *device;
 	int rc;
@@ -2628,7 +2628,7 @@ int dasd_sleep_on_immediatly(struct dasd_ccw_req *cqr)
 
 	return rc;
 }
-EXPORT_SYMBOL(dasd_sleep_on_immediatly);
+EXPORT_SYMBOL(dasd_sleep_on_immediately);
 
 /*
  * Cancels a request that was started with dasd_sleep_on_req.
diff --git a/drivers/s390/block/dasd_alias.c b/drivers/s390/block/dasd_alias.c
index 8d6c16d35c22a..1ffcfcfe4565f 100644
--- a/drivers/s390/block/dasd_alias.c
+++ b/drivers/s390/block/dasd_alias.c
@@ -750,7 +750,7 @@ static int reset_summary_unit_check(struct alias_lcu *lcu,
 	cqr->buildclk = get_tod_clock();
 	cqr->status = DASD_CQR_FILLED;
 
-	rc = dasd_sleep_on_immediatly(cqr);
+	rc = dasd_sleep_on_immediately(cqr);
 	return rc;
 }
 
diff --git a/drivers/s390/block/dasd_eckd.c b/drivers/s390/block/dasd_eckd.c
index d3de0d97cca21..73741873d42a4 100644
--- a/drivers/s390/block/dasd_eckd.c
+++ b/drivers/s390/block/dasd_eckd.c
@@ -922,7 +922,7 @@ static int dasd_eckd_read_conf_immediately(struct dasd_device *device,
 	set_bit(DASD_CQR_ALLOW_SLOCK, &cqr->flags);
 	cqr->retries = 5;
 	cqr->callback = read_conf_cb;
-	rc = dasd_sleep_on_immediatly(cqr);
+	rc = dasd_sleep_on_immediately(cqr);
 	return rc;
 }
 
@@ -6009,7 +6009,7 @@ __context_unsafe(/* Conditional locking */)
 	cqr->buildclk = get_tod_clock();
 	cqr->status = DASD_CQR_FILLED;
 
-	rc = dasd_sleep_on_immediatly(cqr);
+	rc = dasd_sleep_on_immediately(cqr);
 	if (!rc)
 		clear_bit(DASD_FLAG_IS_RESERVED, &device->flags);
 
@@ -6065,7 +6065,7 @@ __context_unsafe(/* Conditional locking */)
 	cqr->buildclk = get_tod_clock();
 	cqr->status = DASD_CQR_FILLED;
 
-	rc = dasd_sleep_on_immediatly(cqr);
+	rc = dasd_sleep_on_immediately(cqr);
 	if (!rc)
 		set_bit(DASD_FLAG_IS_RESERVED, &device->flags);
 
@@ -6120,7 +6120,7 @@ __context_unsafe(/* Conditional locking */)
 	cqr->buildclk = get_tod_clock();
 	cqr->status = DASD_CQR_FILLED;
 
-	rc = dasd_sleep_on_immediatly(cqr);
+	rc = dasd_sleep_on_immediately(cqr);
 	if (!rc)
 		set_bit(DASD_FLAG_IS_RESERVED, &device->flags);
 
@@ -6184,7 +6184,7 @@ __context_unsafe(/* Conditional locking */)
 	cqr->status = DASD_CQR_FILLED;
 	cqr->lpm = usrparm.path_mask;
 
-	rc = dasd_sleep_on_immediatly(cqr);
+	rc = dasd_sleep_on_immediately(cqr);
 	/* verify that I/O processing didn't modify the path mask */
 	if (!rc && usrparm.path_mask && (cqr->lpm != usrparm.path_mask))
 		rc = -EIO;
@@ -6816,7 +6816,7 @@ static int dasd_eckd_read_message_buffer(struct dasd_device *device,
 	cqr->block = NULL;
 	cqr->expires = 10 * HZ;
 	set_bit(DASD_CQR_VERIFY_PATH, &cqr->flags);
-	/* dasd_sleep_on_immediatly does not do complex error
+	/* dasd_sleep_on_immediately does not do complex error
 	 * recovery so clear erp flag and set retry counter to
 	 * do basic erp */
 	clear_bit(DASD_CQR_FLAGS_USE_ERP, &cqr->flags);
@@ -6848,7 +6848,7 @@ static int dasd_eckd_read_message_buffer(struct dasd_device *device,
 
 	cqr->buildclk = get_tod_clock();
 	cqr->status = DASD_CQR_FILLED;
-	rc = dasd_sleep_on_immediatly(cqr);
+	rc = dasd_sleep_on_immediately(cqr);
 	if (rc == 0) {
 		prssdp = (struct dasd_psf_prssd_data *) cqr->data;
 		message_buf = (struct dasd_rssd_messages *)
diff --git a/drivers/s390/block/dasd_int.h b/drivers/s390/block/dasd_int.h
index ef4930432c098..26ecf9f47d2eb 100644
--- a/drivers/s390/block/dasd_int.h
+++ b/drivers/s390/block/dasd_int.h
@@ -998,7 +998,7 @@ void dasd_schedule_device_bh(struct dasd_device *);
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

