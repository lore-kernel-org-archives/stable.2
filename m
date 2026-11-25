Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795630395;
	b=yzs5IdI3wXztLHCp8n0iquc/r9m8JDJu92iFY6hkgPTjw4x5f7UJk5HsF4vMNSCFrMF5
	 pfWhXBfRy7hws1qCe0CchGOIeqFZf3XBsXTN2Fd9oW0nyUGBgcftsLvnCeMreTVcSdeFb
	 6i+pg9hXNb3YJlHcB7rIshnTwUHxp43hIAj1JTcjs6azlskzt+kTEv6JBY1CEMH+a8yW3
	 TgCcKcd2z1tXfdm7v41ZrewB4QwplaXR0S+Jj/cgzUlMTEkhr44CiayBpvv7zptptiTQH
	 5noDcGv1PjfZV34svTw0iUHAXQcldnH80WOMc7dnDj7W08f7OshrC7ceSlF4PRLlr7w==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795630395;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Type:
	 Content-Transfer-Encoding;
	bh=yeqKLWN/BIA3gDuw/xB0G/ocvhr7rPiQbKgeJpECJzQ=;
	b=Wf9GGPJPpRIDAwPmHaQVk3o6mOkOvbk3fBHXlziuisB29mn7h6x3nTKtjSIRVA6Xz9uG
	 5hSr+hsnMSArHgpISbGU6P/aip6JCRGq8iYdZ3riTLhC2lg54l1Q/7N2bJzcLkS7rIjcp
	 UgRBvHGbRCa3J9maI5xiZ2gICJKkeFqxGggk5tEkaMouUyqfYuLvE3naUO0K28fhzOnU6
	 bDY0PxFJV0HDrwF7TMEB4AOpaEQXFH4trFOQHFxyyfkHkreeIw+ANpDychMbCut+mIiOv
	 +aRB9MqqIG9sMwy7piS0VOtX/dzO/qORy9QQMUiiAPfSrEXBaswiwKQlrmZnNEDKWIg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=mZ2nfKA+;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DE2A6606A32E
	for <stable@vger.kernel.org>; Wed, 25 Nov 2026 18:13:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=mZ2nfKA+
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B89161F0089F;
	Wed, 25 Nov 2026 18:13:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795630395;
	bh=yeqKLWN/BIA3gDuw/xB0G/ocvhr7rPiQbKgeJpECJzQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=mZ2nfKA+h8WKV1puX+5Tl4A05ggzwvLGjLAc2Xd/BGtIZps7MRKU7sU2PJ1Za8HgO
	 NfP4Ednimtp+icckSTMzQApe4xoRE2kJwB9PVCho+En+USn7VR2CLtPYcow710ACdM
	 Ng8DNXzobW+GToeAEF6MEXzjyd44C07WVb+wuSAQgN6apjtmBCvF+TVA8mH+SyDWgO
	 KtY1P13uX5T3pM2M1Ff/5dlznVL5VK7r7+ROVLIEzTAaVmfIyOsxV9/o3Rx2BZ1zkq
	 34juyhOMlEyEiQ8ieIrd0oImaAWwHiiBJqhkVAljZrFxi6BptLFM8FNtuDZvrWmQwc
	 G7kd2dRSa7vKw==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Stefan Haberland <sth@linux.ibm.com>,
	=?UTF-8?q?Jan=20H=C3=B6ppner?= <hoeppner@linux.ibm.com>,
	Jens Axboe <axboe@kernel.dk>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.15.y 7/7] s390/dasd: Re-initialize RCD buffer with "V1.0" before every start
Date: Wed, 25 Nov 2026 13:13:03 -0500
Message-ID: <20261125181227.1137399-7-sashal@kernel.org>
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
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

From: Stefan Haberland <sth@linux.ibm.com>

[ Upstream commit 25cdc1f63227a1ea69a1ec823a8a860e33299169 ]

Under z/VM the Read Configuration Data (RCD) buffer has to start with
EBCDIC "V1.0" to request the virtual device SNEQ that carries the
minidisk UIT. The request and the response share the same buffer:
CP evaluates the magic on the way out and the RCD data is written into
the same buffer on the way back.

The magic is only written when the request is built and again in
read_conf_cb() when the original request fails.

Several restart paths do not run that callback:
 - ERP use the same buffer and if the same error occurs again,
   the ERP restarts the existing ERP request;
   if a different error occurs, it adds another ERP request.
   Neither re-initializes the magic.
 - Terminated (timed out) ERP requests, killed requests and requests
   requeued after the last path was gone are restarted without it.
 - dasd_sleep_on_immediately() overwrites cqr->callback, so read_conf_cb()
   never ran for dasd_eckd_read_conf_immediately(), and its fastpath
   retries in dasd_int_handler() do not call a callback either.

If such a restart succeeds, z/VM omits the virtual device SNEQ, the UID
of that path is built without the UIT and the paths are reported as
"Not all channel paths lead to the same device" although they lead to
the same minidisk.

Every start of a request, whatever path led to it, goes through
dasd_start_IO(). Add an optional prepare_io function to the request
that dasd_start_IO() calls before every start of the request and of
its ERP requests, and use it to write the magic for RCD requests.

The ERP handling stays unchanged. read_conf_cb() is no longer needed
and is removed, which also gets rid of its memset() that only cleared
a single byte.

Fixes: 5915a873fcb1 ("[S390] dasd: re-initialize read_conf buffer for retries")
Cc: stable@vger.kernel.org
Reviewed-by: Jan Höppner <hoeppner@linux.ibm.com>
Signed-off-by: Stefan Haberland <sth@linux.ibm.com>
Link: https://patch.msgid.link/20261112102608.1057852-3-sth@linux.ibm.com
Signed-off-by: Jens Axboe <axboe@kernel.dk>
[ sashal: adjusted context in dasd_eckd.c (memcmp against private->uid) and placed the dasd_int.h helper after a different neighboring declaration, since surrounding code differs in this tree. ]
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/s390/block/dasd.c      |  1 +
 drivers/s390/block/dasd_eckd.c | 52 ++++++++++++----------------------
 drivers/s390/block/dasd_int.h  | 15 ++++++++++
 3 files changed, 34 insertions(+), 34 deletions(-)

diff --git a/drivers/s390/block/dasd.c b/drivers/s390/block/dasd.c
index 69df3813cfcfd..56cbf5bf97779 100644
--- a/drivers/s390/block/dasd.c
+++ b/drivers/s390/block/dasd.c
@@ -1414,6 +1414,7 @@ int dasd_start_IO(struct dasd_ccw_req *cqr)
 		cqr->status = DASD_CQR_ERROR;
 		return -EIO;
 	}
+	dasd_start_IO_prepare(cqr);
 	cqr->startclk = get_tod_clock();
 	cqr->starttime = jiffies;
 	cqr->retries--;
diff --git a/drivers/s390/block/dasd_eckd.c b/drivers/s390/block/dasd_eckd.c
index 0791cfa6b8d96..ae5cd62847284 100644
--- a/drivers/s390/block/dasd_eckd.c
+++ b/drivers/s390/block/dasd_eckd.c
@@ -808,20 +808,29 @@ static int dasd_eckd_compare_path_uid(struct dasd_device *device,
 	return memcmp(&device_uid, &private->uid, sizeof(struct dasd_uid));
 }
 
+/*
+ * The RCD buffer has to start with EBCDIC "V1.0" to show support for
+ * virtual device SNEQ. The RCD data is written into the same buffer, so
+ * a failed attempt may already have overwritten the magic. Re-initialize
+ * it before every start, including restarts by ERP requests.
+ */
+static void dasd_eckd_rcd_prepare_io(struct dasd_ccw_req *cqr)
+{
+	struct ccw1 *ccw = cqr->cpaddr;
+	__u8 *rcd_buffer = dma32_to_virt(ccw->cda);
+
+	rcd_buffer[0] = 0xE5;
+	rcd_buffer[1] = 0xF1;
+	rcd_buffer[2] = 0x4B;
+	rcd_buffer[3] = 0xF0;
+}
+
 static void dasd_eckd_fill_rcd_cqr(struct dasd_device *device,
 				   struct dasd_ccw_req *cqr,
 				   __u8 *rcd_buffer,
 				   __u8 lpm)
 {
 	struct ccw1 *ccw;
-	/*
-	 * buffer has to start with EBCDIC "V1.0" to show
-	 * support for virtual device SNEQ
-	 */
-	rcd_buffer[0] = 0xE5;
-	rcd_buffer[1] = 0xF1;
-	rcd_buffer[2] = 0x4B;
-	rcd_buffer[3] = 0xF0;
 
 	ccw = cqr->cpaddr;
 	ccw->cmd_code = DASD_ECKD_CCW_RCD;
@@ -838,33 +847,10 @@ static void dasd_eckd_fill_rcd_cqr(struct dasd_device *device,
 	cqr->retries = 256;
 	cqr->buildclk = get_tod_clock();
 	cqr->status = DASD_CQR_FILLED;
+	cqr->prepare_io = dasd_eckd_rcd_prepare_io;
 	set_bit(DASD_CQR_VERIFY_PATH, &cqr->flags);
 }
 
-/*
- * Wakeup helper for read_conf
- * if the cqr is not done and needs some error recovery
- * the buffer has to be re-initialized with the EBCDIC "V1.0"
- * to show support for virtual device SNEQ
- */
-static void read_conf_cb(struct dasd_ccw_req *cqr, void *data)
-{
-	struct ccw1 *ccw;
-	__u8 *rcd_buffer;
-
-	if (cqr->status !=  DASD_CQR_DONE) {
-		ccw = cqr->cpaddr;
-		rcd_buffer = dma32_to_virt(ccw->cda);
-		memset(rcd_buffer, 0, sizeof(*rcd_buffer));
-
-		rcd_buffer[0] = 0xE5;
-		rcd_buffer[1] = 0xF1;
-		rcd_buffer[2] = 0x4B;
-		rcd_buffer[3] = 0xF0;
-	}
-	dasd_wakeup_cb(cqr, data);
-}
-
 static int dasd_eckd_read_conf_immediately(struct dasd_device *device,
 					   struct dasd_ccw_req *cqr,
 					   __u8 *rcd_buffer,
@@ -884,7 +870,6 @@ static int dasd_eckd_read_conf_immediately(struct dasd_device *device,
 	clear_bit(DASD_CQR_FLAGS_USE_ERP, &cqr->flags);
 	set_bit(DASD_CQR_ALLOW_SLOCK, &cqr->flags);
 	cqr->retries = 5;
-	cqr->callback = read_conf_cb;
 	rc = dasd_sleep_on_immediately(cqr);
 	return rc;
 }
@@ -922,7 +907,6 @@ static int dasd_eckd_read_conf_lpm(struct dasd_device *device,
 		goto out_error;
 	}
 	dasd_eckd_fill_rcd_cqr(device, cqr, rcd_buf, lpm);
-	cqr->callback = read_conf_cb;
 	ret = dasd_sleep_on(cqr);
 	/*
 	 * on success we update the user input parms
diff --git a/drivers/s390/block/dasd_int.h b/drivers/s390/block/dasd_int.h
index 81d3ff83ab58f..7482ba96a490a 100644
--- a/drivers/s390/block/dasd_int.h
+++ b/drivers/s390/block/dasd_int.h
@@ -177,6 +177,8 @@ struct dasd_ccw_req {
 	void *data;			/* pointer to data area */
 	struct irb irb;			/* device status in case of an error */
 	struct dasd_ccw_req *refers;	/* ERP-chain queueing. */
+	/* optional prepare function called before every start_io, must not sleep */
+	void (*prepare_io)(struct dasd_ccw_req *cqr);
 	void *function; 		/* originating ERP action */
 	void *mem_chunk;
 
@@ -825,6 +827,19 @@ static inline void *dasd_get_callback_data(struct dasd_ccw_req *cqr)
 	return cqr->callback_data;
 }
 
+/*
+ * Walk down the ERP chain to the original CQR and call its
+ * prepare_io function if set.
+ */
+static inline void dasd_start_IO_prepare(struct dasd_ccw_req *cqr)
+{
+	/* ERP requests use the prepare function of the original request */
+	while (cqr->refers)
+		cqr = cqr->refers;
+	if (cqr->prepare_io)
+		cqr->prepare_io(cqr);
+}
+
 /* externals in dasd.c */
 #define DASD_PROFILE_OFF	 0
 #define DASD_PROFILE_ON 	 1
-- 
2.53.0

