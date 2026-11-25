Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795628971;
	b=XKh9gQO5xdLSbkV1NOGz/Dmx+pTKn26rUsdpptSvqRkLW8OlnLWUZVlRyFyphZ2091XW
	 Uin+lPNa/bGwkMH5Sgfmi88xmsSfHd/uhQxP6Al6jRx9wH1GGIgDhs4qFV5ruaSIBm5wO
	 4aYgcZJTEbbgq7RcWzBQQeilJFO0Hqo1o9QudCtCPwy419H71LTXb7NyfAfQlCN3iHluw
	 IwIjIL7W12P4bI6NjFXgmrIQHcCIKdKxHd0YUKJCUslfMDt38bjbSAU0ES59QBN3jP4fo
	 iu8Pib9cJ+tXP9xjxyzn4Ueh1z8mdSPcKUuKuVjFe7zKrKpSjXPYae+fl8BkkoSw8lQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795628971;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Type:
	 Content-Transfer-Encoding;
	bh=EVnXIVVTRbpBkBPehLLZhBR0TzdU4ArI0CAdfONTkqY=;
	b=yNCNMtqXke/hI5Vx8vrMV2lG7UktUaNLp2nMpvk0nlLCTV7PsreXI7le7KC/Xq0Ch92Y
	 +SkB+RzAFq3aaC/cD/uuCecjEbFLW1df8QqJFxoeAxQkMltb+SZq5zbHVhJcBfK6LRGc7
	 UxZEq7u+vju+ERztj79gIum/0mNcxc3ALBOlYfplzcOdTbjGhdQZnBfk5ATY35CN3ogfu
	 4otAreQXFB6lfNekxova6GNgVWMn17lrh96wX59EqI9EVw6ViiiJwcvEJT+AFPHg07+Xr
	 nScacV+SLgKj5/2h16wIeT1rzsjsflzypNpDmpB/Thy4QQ3Ua8G5eFr9h5hQihCM5Eg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=iGRk2Z+N;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7AD5D606A33A
	for <stable@vger.kernel.org>; Wed, 25 Nov 2026 17:49:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=iGRk2Z+N
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 537871F000CF;
	Wed, 25 Nov 2026 17:49:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795628971;
	bh=EVnXIVVTRbpBkBPehLLZhBR0TzdU4ArI0CAdfONTkqY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=iGRk2Z+NZU/xw+cvzt3XS7OsNKtop89vRfVRSyMgFo2IWc1VCNffG8qlAfmWpI04c
	 /XdMtqTi463e3shcOqvUgA7kdnQyZ5M46RoEIt4vgg8oS/NyLYh9uhjBx6Glm4J2K8
	 Szb5iPGZisyFVPFZFLhhW1cyyoayCNaxUaIedhJ8/VU+KoC7g+ox3RZne/KjyhvLq/
	 i3KYBbEA94FsDT9eVOe0WqcF7+LMiJ0mSQmNSn7SweHQpuqkXqU963JbSJRb1Se+3E
	 y9UU8d1tFomJj5eCKKC+40P4IHR7P36BUgDBduCN53QeNVNEnqsLPyNoHt60BHd/EM
	 NvLqnQOooKPSQ==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Stefan Haberland <sth@linux.ibm.com>,
	Heiko Carstens <hca@linux.ibm.com>,
	=?UTF-8?q?Jan=20H=C3=B6ppner?= <hoeppner@linux.ibm.com>,
	Jens Axboe <axboe@kernel.dk>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.18.y 1/2] s390/dasd: Fix typo 'immediatly' -> 'immediately'
Date: Wed, 25 Nov 2026 12:49:27 -0500
Message-ID: <20261125174916.1030533-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026112514-study-reseller-e32c@gregkh>
References: <2026112514-study-reseller-e32c@gregkh>
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
index f6e86692a21d7..f887b3657edd2 100644
--- a/drivers/s390/block/dasd.c
+++ b/drivers/s390/block/dasd.c
@@ -2573,7 +2573,7 @@ static inline int _dasd_term_running_cqr(struct dasd_device *device)
 	return rc;
 }
 
-int dasd_sleep_on_immediatly(struct dasd_ccw_req *cqr)
+int dasd_sleep_on_immediately(struct dasd_ccw_req *cqr)
 {
 	struct dasd_device *device;
 	int rc;
@@ -2621,7 +2621,7 @@ int dasd_sleep_on_immediatly(struct dasd_ccw_req *cqr)
 
 	return rc;
 }
-EXPORT_SYMBOL(dasd_sleep_on_immediatly);
+EXPORT_SYMBOL(dasd_sleep_on_immediately);
 
 /*
  * Cancels a request that was started with dasd_sleep_on_req.
diff --git a/drivers/s390/block/dasd_alias.c b/drivers/s390/block/dasd_alias.c
index f7e768d8ca766..2afac13cb79c2 100644
--- a/drivers/s390/block/dasd_alias.c
+++ b/drivers/s390/block/dasd_alias.c
@@ -751,7 +751,7 @@ static int reset_summary_unit_check(struct alias_lcu *lcu,
 	cqr->buildclk = get_tod_clock();
 	cqr->status = DASD_CQR_FILLED;
 
-	rc = dasd_sleep_on_immediatly(cqr);
+	rc = dasd_sleep_on_immediately(cqr);
 	return rc;
 }
 
diff --git a/drivers/s390/block/dasd_eckd.c b/drivers/s390/block/dasd_eckd.c
index 545446b3818f6..499b09162a0ae 100644
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
 
@@ -5101,7 +5101,7 @@ dasd_eckd_release(struct dasd_device *device)
 	cqr->buildclk = get_tod_clock();
 	cqr->status = DASD_CQR_FILLED;
 
-	rc = dasd_sleep_on_immediatly(cqr);
+	rc = dasd_sleep_on_immediately(cqr);
 	if (!rc)
 		clear_bit(DASD_FLAG_IS_RESERVED, &device->flags);
 
@@ -5156,7 +5156,7 @@ dasd_eckd_reserve(struct dasd_device *device)
 	cqr->buildclk = get_tod_clock();
 	cqr->status = DASD_CQR_FILLED;
 
-	rc = dasd_sleep_on_immediatly(cqr);
+	rc = dasd_sleep_on_immediately(cqr);
 	if (!rc)
 		set_bit(DASD_FLAG_IS_RESERVED, &device->flags);
 
@@ -5210,7 +5210,7 @@ dasd_eckd_steal_lock(struct dasd_device *device)
 	cqr->buildclk = get_tod_clock();
 	cqr->status = DASD_CQR_FILLED;
 
-	rc = dasd_sleep_on_immediatly(cqr);
+	rc = dasd_sleep_on_immediately(cqr);
 	if (!rc)
 		set_bit(DASD_FLAG_IS_RESERVED, &device->flags);
 
@@ -5273,7 +5273,7 @@ static int dasd_eckd_snid(struct dasd_device *device,
 	cqr->status = DASD_CQR_FILLED;
 	cqr->lpm = usrparm.path_mask;
 
-	rc = dasd_sleep_on_immediatly(cqr);
+	rc = dasd_sleep_on_immediately(cqr);
 	/* verify that I/O processing didn't modify the path mask */
 	if (!rc && usrparm.path_mask && (cqr->lpm != usrparm.path_mask))
 		rc = -EIO;
@@ -5915,7 +5915,7 @@ static int dasd_eckd_read_message_buffer(struct dasd_device *device,
 	cqr->block = NULL;
 	cqr->expires = 10 * HZ;
 	set_bit(DASD_CQR_VERIFY_PATH, &cqr->flags);
-	/* dasd_sleep_on_immediatly does not do complex error
+	/* dasd_sleep_on_immediately does not do complex error
 	 * recovery so clear erp flag and set retry counter to
 	 * do basic erp */
 	clear_bit(DASD_CQR_FLAGS_USE_ERP, &cqr->flags);
@@ -5947,7 +5947,7 @@ static int dasd_eckd_read_message_buffer(struct dasd_device *device,
 
 	cqr->buildclk = get_tod_clock();
 	cqr->status = DASD_CQR_FILLED;
-	rc = dasd_sleep_on_immediatly(cqr);
+	rc = dasd_sleep_on_immediately(cqr);
 	if (rc == 0) {
 		prssdp = (struct dasd_psf_prssd_data *) cqr->data;
 		message_buf = (struct dasd_rssd_messages *)
diff --git a/drivers/s390/block/dasd_int.h b/drivers/s390/block/dasd_int.h
index 81cfb5c89681b..99c2534216537 100644
--- a/drivers/s390/block/dasd_int.h
+++ b/drivers/s390/block/dasd_int.h
@@ -857,7 +857,7 @@ void dasd_schedule_device_bh(struct dasd_device *);
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

