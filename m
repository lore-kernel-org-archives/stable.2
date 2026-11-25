Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795602961;
	b=F8FVKv0SzdCIK5+E9FsBnAEaqPcMsRd4kw5bVRrKdqmFEwrkwyKYRPoUt56VbsVxl7K3
	 4knHgZwf0OHwF870JO2oRQ2S77Zv3xB4Pdiz7F1XK8eGxqn96krHExtlzZPjJpFZcVUsH
	 QtZGa2AKQLzfnGDcdgTCQvjZmKSK9VO+oGUL6jbxVOxYLPIzE4w0lhS17YLIDpTylNlef
	 bItPAZRvbw5xDgD1FnbohJMkmjZi/WWdbkj3hFWj4PM6uWZJxuwnoNJiVKwMqF6u1dPr6
	 Ayu1z/ZSDlXlZ6rDVtWj1OCb/HDR/cq0KDAKFm8kiJQ3OwvZ+SVVG7QyXI3yGTsPgyg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795602961;
	h=Received:DKIM-Signature:Subject:To:Cc:From:Date:Message-ID:
	 MIME-Version:Content-Type:Content-Transfer-Encoding;
	bh=Tx3hRqS8kBoQCGILwjYew1EqwsPsRRYPkkxAJoycEqU=;
	b=cb25085U0sq6ajutEk4f+oQ0Le8niUahb1T3bx6wPMkuxjgcqiOP+xRg2b27pbqokPWZ
	 LqInM0zvhCoaUunfwDX8zKdGWEwJUxwWE2hBa9Y5kQ827TVRpRBWdXKA6q/HRCt4f2+r8
	 8SZ+/JgOBYRFTdTfId61nTpMEAQn0s08tB7Fzzrq2tRmrNEAWuRjcT3fG7FHnij5M/z/j
	 U0sGo696JfF3Z1AjRkD54CTPaoaa+c1o/Vb3lgIQQg0l1QjXd+SEP4nf2d2H68CVAIh/V
	 8GpAeU4i7Ro5az0anRFWawCu3R1tSg+75872HeEpjcwzJvK9v7EVCHzp23xcNgUWMVQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=linuxfoundation.org header.i=@linuxfoundation.org header.a=rsa-sha256 header.s=korg header.b=iUUEFdcZ;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 24958606A321
	for <stable@vger.kernel.org>; Wed, 25 Nov 2026 10:36:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.a=rsa-sha256 header.s=korg header.b=iUUEFdcZ
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 993F31F000D8;
	Wed, 25 Nov 2026 10:36:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1795602960;
	bh=Tx3hRqS8kBoQCGILwjYew1EqwsPsRRYPkkxAJoycEqU=;
	h=Subject:To:Cc:From:Date;
	b=iUUEFdcZ09gH9KSsNySfMt4MG14ayvAg0h+XKYlbBbltg51iJP8oInlBK0cga0+s0
	 Ug3aTm0T7jUFgU56w1Ptx+HRzzPMH4qqDZlTyz99Ov3btnCL/6265U0WXsZsE4VHWH
	 SI79+h5uEuK5yPiN90KpmRPrQTu6eKWi9C7S8R+c=
Subject: FAILED: patch "[PATCH] s390/dasd: Re-initialize RCD buffer with "V1.0" before every" failed to apply to 6.1-stable tree
To: sth@linux.ibm.com,axboe@kernel.dk,hoeppner@linux.ibm.com
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Wed, 25 Nov 2026 11:20:16 +0100
Message-ID: <2026112516-sculpture-facial-ba8e@gregkh>
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


The patch below does not apply to the 6.1-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-6.1.y
git checkout FETCH_HEAD
git cherry-pick -x 25cdc1f63227a1ea69a1ec823a8a860e33299169
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2026112516-sculpture-facial-ba8e@gregkh' --subject-prefix 'PATCH 6.1.y' 'HEAD^..'

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From 25cdc1f63227a1ea69a1ec823a8a860e33299169 Mon Sep 17 00:00:00 2001
From: Stefan Haberland <sth@linux.ibm.com>
Date: Thu, 12 Nov 2026 11:26:06 +0100
Subject: [PATCH] s390/dasd: Re-initialize RCD buffer with "V1.0" before every
 start
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

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

diff --git a/drivers/s390/block/dasd.c b/drivers/s390/block/dasd.c
index d74ef737ae26..3a55c937d0d6 100644
--- a/drivers/s390/block/dasd.c
+++ b/drivers/s390/block/dasd.c
@@ -1396,6 +1396,7 @@ int dasd_start_IO(struct dasd_ccw_req *cqr)
 		cqr->status = DASD_CQR_ERROR;
 		return -EIO;
 	}
+	dasd_start_IO_prepare(cqr);
 	cqr->startclk = get_tod_clock();
 	cqr->starttime = jiffies;
 	cqr->retries--;
diff --git a/drivers/s390/block/dasd_eckd.c b/drivers/s390/block/dasd_eckd.c
index 53f823a9310e..efaf117e39f4 100644
--- a/drivers/s390/block/dasd_eckd.c
+++ b/drivers/s390/block/dasd_eckd.c
@@ -845,20 +845,29 @@ static int dasd_eckd_compare_path_uid(struct dasd_device *device,
 	return memcmp(&device_uid, &path_uid, sizeof(struct dasd_uid));
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
@@ -875,33 +884,10 @@ static void dasd_eckd_fill_rcd_cqr(struct dasd_device *device,
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
@@ -921,7 +907,6 @@ static int dasd_eckd_read_conf_immediately(struct dasd_device *device,
 	clear_bit(DASD_CQR_FLAGS_USE_ERP, &cqr->flags);
 	set_bit(DASD_CQR_ALLOW_SLOCK, &cqr->flags);
 	cqr->retries = 5;
-	cqr->callback = read_conf_cb;
 	rc = dasd_sleep_on_immediately(cqr);
 	return rc;
 }
@@ -959,7 +944,6 @@ static int dasd_eckd_read_conf_lpm(struct dasd_device *device,
 		goto out_error;
 	}
 	dasd_eckd_fill_rcd_cqr(device, cqr, rcd_buf, lpm);
-	cqr->callback = read_conf_cb;
 	ret = dasd_sleep_on(cqr);
 	/*
 	 * on success we update the user input parms
diff --git a/drivers/s390/block/dasd_int.h b/drivers/s390/block/dasd_int.h
index 26ecf9f47d2e..53c450036fe1 100644
--- a/drivers/s390/block/dasd_int.h
+++ b/drivers/s390/block/dasd_int.h
@@ -147,6 +147,8 @@ struct dasd_ccw_req {
 	void *data;			/* pointer to data area */
 	struct irb irb;			/* device status in case of an error */
 	struct dasd_ccw_req *refers;	/* ERP-chain queueing. */
+	/* optional prepare function called before every start_io, must not sleep */
+	void (*prepare_io)(struct dasd_ccw_req *cqr);
 	void *function; 		/* originating ERP action */
 	void *mem_chunk;
 
@@ -892,6 +894,19 @@ static inline void *dasd_get_callback_data(struct dasd_ccw_req *cqr)
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
 static inline bool dasd_req_conflict(struct dasd_ccw_req *cqr1,
 				     struct dasd_ccw_req *cqr2)
 {

