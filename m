Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795629279;
	b=EEYeTfwiL3LdS5PAA49vfIiim9Dz7TGCSVVK2lZSJ5LiwZxaXPbIy6qaJsMjQQBMsak2
	 HeXPIklaVdBqZrQ+v2D9UCMIj9u1XdW3mzlhqnmwYVvQKyhoB8OF4tk1z2AvcrutvvqZR
	 nH00JkLlEad5AXXm5iY6ki1vBiLFf90I8+4BRp7FFlU1MR/Qaxgln4VHBovRzAo+pflpE
	 B7lJV2e9j8o1OuqFOogN+bBfhk8q/EatkM4DGai6IVd2EU9ycneeKG1RitjOD5s/D2OVL
	 5KMw49rlFGFh61TbBj8U7sU1APuORuMrSRPt+2ibz/EDK/dRxBG5Mjj+vhB7AcxXo+g==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795629279;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Type:
	 Content-Transfer-Encoding;
	bh=sDZ52foNT0rGU3OGiaqtgFGIChANWqwWiHIkkhsiVPs=;
	b=W+U0mcIgS1eLuAjEKPSZ/wzA+jWQd+D3eHQOH+JM3kReuIbx7VISuFTeK3wnQ73/PbH3
	 3+z4nBZbkD57BqkpkN/XsZ6Srb95iTzQt4sBeTZnTKYIe0+bJ/7Tj4x7jgZ2OyiYH+ujo
	 +TuknEstq2gLp9gm7fzFkbi+sA3uRR5bu0VQxq/Wv7HbyOrOQ/z2xKb3M6lx3Vdve/rAW
	 0ptrMPo7tnHZMz5HkF8uNsR8KVB/0mSAluSP9uyOMOPamq8F/kEeybL/rJczd4GjTW2mp
	 9q4PzHUznfDLsivlfBrYshTY69fWus5Qbfjhrjzznb88AN1e6s4OxXW60NOhu4UMq9g==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=TslhKZrW;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 06B34606A31E
	for <stable@vger.kernel.org>; Wed, 25 Nov 2026 17:54:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=TslhKZrW
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C6D621F00A00;
	Wed, 25 Nov 2026 17:54:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795629278;
	bh=sDZ52foNT0rGU3OGiaqtgFGIChANWqwWiHIkkhsiVPs=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=TslhKZrWldV2H/sNEzTBiXp1lz0ledWr73oY/XJNKmnKhjonkq1ZcZxSKShMh+kTA
	 red2B0siK4NSubW6cOR6C0Tug2JGE1PAE2MVEbXNNc199a1cEfiYecy5IoXrMJshBl
	 ez2HsScKyHeEbFtLBWC7FFfR1SWWlTVU2fm9xfq16OT2gUf/5N4rW02BRmvNX+2OXd
	 8ydFr/U/DnYA+1IUxLWOfdvR7F3yPll/wDYWERtWXtpkRrTUFHzSKObiNk5S/BdkBX
	 Sg07oud6M8CmxxqtYmUeuI8Wt+PbSUUh1UUmzrkkl4sVT3FREtBnMAVSwWV9LP310r
	 4uG3hzHX6vTMw==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Stefan Haberland <sth@linux.ibm.com>,
	Heiko Carstens <hca@linux.ibm.com>,
	=?UTF-8?q?Jan=20H=C3=B6ppner?= <hoeppner@linux.ibm.com>,
	Jens Axboe <axboe@kernel.dk>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.12.y 1/2] s390/dasd: Fix typo 'immediatly' -> 'immediately'
Date: Wed, 25 Nov 2026 12:54:35 -0500
Message-ID: <20261125175421.1074029-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026112514-monthly-stinging-2bde@gregkh>
References: <2026112514-monthly-stinging-2bde@gregkh>
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
index 12b219b72bd4a..9f5998d5da305 100644
--- a/drivers/s390/block/dasd.c
+++ b/drivers/s390/block/dasd.c
@@ -2571,7 +2571,7 @@ static inline int _dasd_term_running_cqr(struct dasd_device *device)
 	return rc;
 }
 
-int dasd_sleep_on_immediatly(struct dasd_ccw_req *cqr)
+int dasd_sleep_on_immediately(struct dasd_ccw_req *cqr)
 {
 	struct dasd_device *device;
 	int rc;
@@ -2619,7 +2619,7 @@ int dasd_sleep_on_immediatly(struct dasd_ccw_req *cqr)
 
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
index cad655b28c0c1..27f5df6973cdc 100644
--- a/drivers/s390/block/dasd_eckd.c
+++ b/drivers/s390/block/dasd_eckd.c
@@ -886,7 +886,7 @@ static int dasd_eckd_read_conf_immediately(struct dasd_device *device,
 	set_bit(DASD_CQR_ALLOW_SLOCK, &cqr->flags);
 	cqr->retries = 5;
 	cqr->callback = read_conf_cb;
-	rc = dasd_sleep_on_immediatly(cqr);
+	rc = dasd_sleep_on_immediately(cqr);
 	return rc;
 }
 
@@ -5100,7 +5100,7 @@ dasd_eckd_release(struct dasd_device *device)
 	cqr->buildclk = get_tod_clock();
 	cqr->status = DASD_CQR_FILLED;
 
-	rc = dasd_sleep_on_immediatly(cqr);
+	rc = dasd_sleep_on_immediately(cqr);
 	if (!rc)
 		clear_bit(DASD_FLAG_IS_RESERVED, &device->flags);
 
@@ -5155,7 +5155,7 @@ dasd_eckd_reserve(struct dasd_device *device)
 	cqr->buildclk = get_tod_clock();
 	cqr->status = DASD_CQR_FILLED;
 
-	rc = dasd_sleep_on_immediatly(cqr);
+	rc = dasd_sleep_on_immediately(cqr);
 	if (!rc)
 		set_bit(DASD_FLAG_IS_RESERVED, &device->flags);
 
@@ -5209,7 +5209,7 @@ dasd_eckd_steal_lock(struct dasd_device *device)
 	cqr->buildclk = get_tod_clock();
 	cqr->status = DASD_CQR_FILLED;
 
-	rc = dasd_sleep_on_immediatly(cqr);
+	rc = dasd_sleep_on_immediately(cqr);
 	if (!rc)
 		set_bit(DASD_FLAG_IS_RESERVED, &device->flags);
 
@@ -5272,7 +5272,7 @@ static int dasd_eckd_snid(struct dasd_device *device,
 	cqr->status = DASD_CQR_FILLED;
 	cqr->lpm = usrparm.path_mask;
 
-	rc = dasd_sleep_on_immediatly(cqr);
+	rc = dasd_sleep_on_immediately(cqr);
 	/* verify that I/O processing didn't modify the path mask */
 	if (!rc && usrparm.path_mask && (cqr->lpm != usrparm.path_mask))
 		rc = -EIO;
@@ -5914,7 +5914,7 @@ static int dasd_eckd_read_message_buffer(struct dasd_device *device,
 	cqr->block = NULL;
 	cqr->expires = 10 * HZ;
 	set_bit(DASD_CQR_VERIFY_PATH, &cqr->flags);
-	/* dasd_sleep_on_immediatly does not do complex error
+	/* dasd_sleep_on_immediately does not do complex error
 	 * recovery so clear erp flag and set retry counter to
 	 * do basic erp */
 	clear_bit(DASD_CQR_FLAGS_USE_ERP, &cqr->flags);
@@ -5946,7 +5946,7 @@ static int dasd_eckd_read_message_buffer(struct dasd_device *device,
 
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

