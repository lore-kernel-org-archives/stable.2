Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=185.203.200.13
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1794564540;
	b=ncvK26YbRQfJ8WJzEQtTb47cEpFCu/QZTLR3R6QdAt4IFF3VOVA/pcblsDEfjFr5NhKV
	 /6IStoF6AmjQ+RPZJI9pjLJHb95hU+NM7kSzz3noHRd6FWvyZTjKUUKk6bKFqyIyvB7JS
	 9iYBL+6jAIMFP2JGCv69c1iNrmLuofL7Bv1gLywBc4Pn6yFQkLa2uWCRaJ7s9zBKk1sZj
	 lK9HCJMUMpaL/95CFrmE8cSRKWE4lhW8LSB/B1kkBMSGfaZwjdH4rXR/xlZlLGHKL/5fb
	 umLQLfmZoY+67DAZYrQq+otkk+uUdNvKPNPaDvHlG4ZmfhnFWtsYDCedjxfpZsuP5qg==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794564540;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Received:From:Date:
	 Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:
	 Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key;
	bh=4PxOYctp2Kp4PnC92fmWsW7tLVU3DDd2nyAlmNySccs=;
	b=X5eLEoledX6LZiL1oyhK0ypDU5Q8Q46YtIT71ydcwrBHAmBJfPtG1TpNk2yfL335Zu+D
	 eDl2NhBa7l7sTH+NUS+fSXxtmkiOoyYOZVI6z91fyKTlOILCceqTcuBGaFIiuL4nZWVWE
	 CW6M0asSezTgkSrsLtXlwIDAXfclN8s3FtUq+dgWXGhh8qbq44vyRX6nxr7ySdUNt3qC6
	 8XYLlWOYdArpjzdcNvv29NeYTnD/u7S7uNlHoRmQiUQqVe3+d11WKa8lQLer2rJeUjFiQ
	 7W6UAnfApAjPqkmcNooYHsJgUhi+YDRG1Gg3yHcCU0VmZJVDH/WfvegKgOmJgUG6Y6w==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=none header.from=pengutronix.de;
	spf=pass smtp.mailfrom=pengutronix.de;
	dkim=pass header.d=pengutronix.de header.i=@pengutronix.de header.a=rsa-sha256 header.s=20260414 header.b=QYA0dXuW;
	arc=pass header.oldest-pass=0 smtp.remote-ip=185.203.200.13
Received: from mx1.white.stw.pengutronix.de (mx1.white.stw.pengutronix.de [185.203.200.13])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A62EA606A887;
	Fri, 13 Nov 2026 10:08:59 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org A62EA606A887
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pengutronix.de header.i=@pengutronix.de header.a=rsa-sha256 header.s=20260414 header.b=QYA0dXuW
Received: from drehscheibe.grey.stw.pengutronix.de (drehscheibe.grey.stw.pengutronix.de [IPv6:2a0a:edc0:0:c01:1d::a2])
	(Authenticated sender: relay-from-drehscheibe.grey.stw.pengutronix.de)
	by mx1.white.stw.pengutronix.de (Postfix) with ESMTPSA id B7954202266;
	Fri, 13 Nov 2026 11:08:54 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pengutronix.de;
	s=20260414; t=1794564534;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=4PxOYctp2Kp4PnC92fmWsW7tLVU3DDd2nyAlmNySccs=;
	b=QYA0dXuWRVtbjbu/Vum9uo+BshfpvNrBlaMNuv6fxAnh6k8SKZ5s4B1t4RLwi8The0Xgao
	ecWdOVZ/4ysu1MAA4M55l6auw3NTCkCi45JQmAd5SyUiP2Tnki1zAGsOTwlsjSQ5AhuDlB
	beDNiLC3IfqRkaCKTHGC6E1w+t/18kqMBOoQlPYJTUGakvUzPtY4ilrfCpe/kJhUOMP5Ds
	jJP87o8rZpu7RxqCw52UFrFybC7+NkV4iFGRypkqnKYydUcZSZTCP9b5gQdBorFodsqrg7
	pFGGfKOxYYFGc2nL8+4kGUw2SIa0lUlxEl30ezbkml/GyBHRf3ht4im95ECCsQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=pengutronix.de;
	s=20260414; t=1794564534;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=4PxOYctp2Kp4PnC92fmWsW7tLVU3DDd2nyAlmNySccs=;
	b=SoIrkqMK96SuAqiZXT6mTAuZmGkr2a9F7Qy2j42gGtwR9qIhIrBrXIlmUglVFDH6/bifUf
	ncjtjz/8gfUMs+UXs8x/Lh4nERY7iuXfii2EnrWvzbk2ISQJ9eLCRMyts/bc3moXSTlRKb
	3PGrQ0JDHAzgSH2FkgG7GqLyLPsoC6byRdtyMiknjDps9JVR9I72jR8BTPvvoqfx/4ygsn
	UFnBuYRGLSdsu2xj8NuplFubl097qGCHs5Pb4GbGSZmmS5a4NP4XGO/g9SGh1IcsKSu+k7
	5Jm0W0mpaFAxkK82/w+q3MqgOJluM4tKME870taRWoo9/MlGQylqAmOi4HANMw==
ARC-Seal: i=1; s=20260414; d=pengutronix.de; t=1794564534; a=rsa-sha256;
	cv=none;
	b=NqJI6HWO2nZQzJmZZsG9fRpD5gvrpblnqyXN3NZZ2dFTLF78LQYdyW6o/Dnl/WOfrFJ9Y6
	3QWqhgDzS0js7XwxwETFE3KgNurXqkRzajqASdzYQVvFDrg/47KYzGWbVUyaekA9DSIkiF
	ytnkhrmh/Y+ERupYwJsc+L++OGtVXgTbtX+Ioq7MSguYHcMjkEahKC828rZwZ5BHeywc7c
	XyJFdT71ISM0+8cIzBr/F/YsADTU16KjyKLW04EBvlUOtG36nDDj559tUXaxYe0IVTqfr6
	IrxodlFMHmRKo3EGJXGA6libCWBZFXktuEsl6yt6IrwFxZVoiU0Ba8QOB7L6Sg==
ARC-Authentication-Results: i=1;
	ORIGINATING;
	auth=pass smtp.auth=relay-from-drehscheibe.grey.stw.pengutronix.de smtp.mailfrom=mkl@pengutronix.de
Received: from moin.white.stw.pengutronix.de ([2a0a:edc0:0:b01:1d::7b] helo=bjornoya.blackshift.org)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <mkl@pengutronix.de>)
	id 1xRoDG-003ySO-22;
	Fri, 13 Nov 2026 11:08:54 +0100
Received: from hardanger.blackshift.org (p4ffb23c7.dip0.t-ipconnect.de [79.251.35.199])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519MLKEM768 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(Client did not present a certificate)
	(Authenticated sender: mkl-all@blackshift.org)
	by smtp.blackshift.org (Postfix) with ESMTPSA id 5FEFE5EA852;
	Fri, 13 Nov 2026 10:08:54 +0000 (UTC)
From: Marc Kleine-Budde <mkl@pengutronix.de>
Date: Fri, 13 Nov 2026 11:08:43 +0100
Subject: [PATCH can-next v6 6/6] can: gs_usb: fix hardware timestamp state
 for mixed channels
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261113-gs_usb-fixes-v6-6-0c039e1bfd74@pengutronix.de>
References: <20261113-gs_usb-fixes-v6-0-0c039e1bfd74@pengutronix.de>
In-Reply-To: <20261113-gs_usb-fixes-v6-0-0c039e1bfd74@pengutronix.de>
To: Vincent Mailhol <mailhol@kernel.org>, Peter Fink <pfink@christ-es.de>, 
 Eric Evenchick <eric@evenchick.com>, 
 Maximilian Schneider <max@schneidersoft.net>, 
 Wolfgang Grandegger <wg@grandegger.com>
Cc: kernel@pengutronix.de, linux-can@vger.kernel.org, 
 linux-kernel@vger.kernel.org, Marc Kleine-Budde <mkl@pengutronix.de>, 
 Shuangpeng Bai <shuangpeng.kernel@gmail.com>, stable@vger.kernel.org, 
 Vadim Fedorenko <vadim.fedorenko@linux.dev>
X-Mailer: b4 0.17-dev-d7211
X-Developer-Signature: v=1; a=openpgp-sha256; l=8675; i=mkl@pengutronix.de;
 h=from:subject:message-id; bh=dbivKz0ij0Pbl5mjkEY5VLDPDjcNDK4kjOBA5RcZH40=;
 b=owGbwMvMwCV2xirl17qZay8xnlZLYsj69nCLFce2j08EP9+w9y8M4t8d3drZsN3jgWXovFvvH
 HPtEjaf7ShlYRDjYpAVU2RZ+uOEokCgQ2nvy4RJMHNYmUCGMHBxCsBE2sMY/in+ZlPxOHLr0YG/
 /bGtvFd6d1jLvT5f9GXvq49HKlqN7z9i+O/DmSK9JsX16kK/1kRNn3UyyxaLbBY+mvJan3u3QGT
 faxYA
X-Developer-Key: i=mkl@pengutronix.de; a=openpgp;
 fpr=C1400BA0B3989E6FBC7D5B5C2B5EE211C58AEA54

From: Shuangpeng Bai <shuangpeng.kernel@gmail.com>

For hardware timestamping, the driver manages the
infrastructure (cyclecounter/timecounter) for the entire USB interface,
assuming that all channels share a common time base, even though each
channel individually indicates support for hardware timestamping via the
GS_CAN_FEATURE_HW_TIMESTAMP flag.

Currently both the initialization and shutdown of the HW timestamping
infrastructure is tied to the flags of the first channel opened
respectively closed. This leads to problems if the first channel opened
doesn't have the timestamping feature, but the second channel has.

Keep the initialization of the HW timestamping infrastructure in
gs_usb_timestamp_init(), and move initial time init and the initial
scheduling of the delayed worker into gs_usb_timestamp_start().

Initialize the HW timestamping infrastructure in gs_usb_probe() using
gs_usb_timestamp_init() if at least one channel has the
GS_CAN_FEATURE_HW_TIMESTAMP flag set.

Extend the functions gs_usb_timestamp_start()/gs_usb_timestamp_stop() to
track the number of active timestamp channels. Initialize the timestamping
infrastructure when opening the first channel. Avoid the race window during
timecounter_init() (because gs_usb_timestamp_read() drops the struct
gs_usb::tc_lock) by reading the initial time stamp prior taking the lock.
Enabling and disabling the delayed worker prevents concurrent rescheduling
while gs_usb_timestamp_stop() is running.

Call gs_usb_timestamp_start()/gs_usb_timestamp_stop() if at least one of
the channels support HW timestamping, rather than relying on the number of
active channels.

Reported-by: Shuangpeng Bai <shuangpeng.kernel@gmail.com>
Closes: https://sashiko.dev/#/bug/linux-b39360f9-6cd8-4f47-83bb-f0f78331f308
Closes: https://sashiko.dev/#/bug/linux-5f8ecd4e-344e-4ceb-9b46-886f4942a5f6
Fixes: 5886e4d5ecec ("can: gs_usb: fix time stamp counter initialization")
Cc: stable@vger.kernel.org
Cc: Shuangpeng Bai <shuangpeng.kernel@gmail.com>
Cc: Vadim Fedorenko <vadim.fedorenko@linux.dev>
Signed-off-by: Shuangpeng Bai <shuangpeng.kernel@gmail.com>
Co-developed-by: Marc Kleine-Budde <mkl@pengutronix.de>
Signed-off-by: Marc Kleine-Budde <mkl@pengutronix.de>
---
 drivers/net/can/usb/gs_usb.c | 98 +++++++++++++++++++++++++++++++++++---------
 1 file changed, 78 insertions(+), 20 deletions(-)

diff --git a/drivers/net/can/usb/gs_usb.c b/drivers/net/can/usb/gs_usb.c
index 6327069f63c9..9eafdf63a4ef 100644
--- a/drivers/net/can/usb/gs_usb.c
+++ b/drivers/net/can/usb/gs_usb.c
@@ -324,6 +324,10 @@ struct gs_can {
 	atomic_t active_tx_urbs;
 };
 
+enum gs_usb_parent_flags {
+	GS_USB_PARENT_FLAGS_HW_TIMESTAMP = BIT(0),
+};
+
 /* usb interface struct */
 struct gs_usb {
 	struct usb_anchor rx_submitted;
@@ -332,11 +336,14 @@ struct gs_usb {
 	/* time counter for hardware timestamps */
 	struct cyclecounter cc;
 	struct timecounter tc;
-	spinlock_t tc_lock; /* spinlock to guard access tc->cycle_last */
+	spinlock_t tc_lock; /* spinlock to guard access tc and active_timestamp_channels */
 	struct delayed_work timestamp;
+	u32 initial_timestamp;
 
 	unsigned int hf_size_rx;
 	u8 active_channels;
+	u8 active_timestamp_channels;
+	u8 flags;
 	u8 channel_cnt;
 
 	unsigned int pipe_in;
@@ -423,6 +430,13 @@ static inline int gs_usb_get_timestamp(const struct gs_usb *parent,
 	return 0;
 }
 
+static u64 gs_usb_timestamp_read_initial(struct cyclecounter *cc)
+{
+	const struct gs_usb *parent = container_of(cc, struct gs_usb, cc);
+
+	return parent->initial_timestamp;
+}
+
 static u64 gs_usb_timestamp_read(struct cyclecounter *cc) __must_hold(&dev->tc_lock)
 {
 	struct gs_usb *parent = container_of(cc, struct gs_usb, cc);
@@ -475,24 +489,61 @@ static void gs_usb_timestamp_init(struct gs_usb *parent)
 {
 	struct cyclecounter *cc = &parent->cc;
 
-	cc->read = gs_usb_timestamp_read;
 	cc->mask = CYCLECOUNTER_MASK(32);
 	cc->shift = 32 - bits_per(NSEC_PER_SEC / GS_USB_TIMESTAMP_TIMER_HZ);
 	cc->mult = clocksource_hz2mult(GS_USB_TIMESTAMP_TIMER_HZ, cc->shift);
 
 	spin_lock_init(&parent->tc_lock);
-	spin_lock_bh(&parent->tc_lock);
-	timecounter_init(&parent->tc, &parent->cc, ktime_get_real_ns());
-	spin_unlock_bh(&parent->tc_lock);
 
 	INIT_DELAYED_WORK(&parent->timestamp, gs_usb_timestamp_work);
+	disable_delayed_work(&parent->timestamp);
+
+	parent->flags |= GS_USB_PARENT_FLAGS_HW_TIMESTAMP;
+}
+
+static int gs_usb_timestamp_start(struct gs_usb *parent)
+{
+	u32 timestamp = 0;
+	int err;
+
+	/* read current timestamp, might be used later for initial time stamp */
+	err = gs_usb_get_timestamp(parent, &timestamp);
+	if (err)
+		return err;
+
+	scoped_guard(spinlock_bh, &parent->tc_lock) {
+		struct cyclecounter *cc = &parent->cc;
+
+		parent->active_timestamp_channels++;
+		if (parent->active_timestamp_channels > 1)
+			return 0;
+
+		/* gs_usb_timestamp_read() will drop the struct gs_usb::tc_lock. Avoid the race
+		 * window by using gs_usb_timestamp_read_initial() to read the initial timestamp in
+		 * timecounter_init(), switch to gs_usb_timestamp_read() afterwards.
+		 */
+		parent->initial_timestamp = timestamp;
+		cc->read = gs_usb_timestamp_read_initial;
+		timecounter_init(&parent->tc, &parent->cc, ktime_get_real_ns());
+		cc->read = gs_usb_timestamp_read;
+	}
+
+	enable_delayed_work(&parent->timestamp);
 	schedule_delayed_work(&parent->timestamp,
 			      GS_USB_TIMESTAMP_WORK_DELAY_SEC * HZ);
+
+	return 0;
 }
 
 static void gs_usb_timestamp_stop(struct gs_usb *parent)
 {
-	cancel_delayed_work_sync(&parent->timestamp);
+	scoped_guard(spinlock_bh, &parent->tc_lock) {
+		parent->active_timestamp_channels--;
+		if (parent->active_timestamp_channels > 0)
+			return;
+	}
+
+	disable_delayed_work_sync(&parent->timestamp);
 }
 
 static void gs_update_state(struct gs_can *dev, struct can_frame *cf)
@@ -654,7 +705,7 @@ static void gs_usb_receive_bulk_callback(struct urb *urb)
 	if (!netif_device_present(netdev))
 		return;
 
-	if (!netif_running(netdev))
+	if (!netif_running(netdev) || !(netdev->flags & IFF_UP))
 		goto resubmit_urb;
 
 	minimum_length = gs_usb_get_minimum_rx_length(dev, hf, &data_length);
@@ -988,10 +1039,13 @@ static int gs_can_open(struct net_device *netdev)
 
 	can_rx_offload_enable(&dev->offload);
 
-	if (!parent->active_channels) {
-		if (dev->feature & GS_CAN_FEATURE_HW_TIMESTAMP)
-			gs_usb_timestamp_init(parent);
+	if (parent->flags & GS_USB_PARENT_FLAGS_HW_TIMESTAMP) {
+		rc = gs_usb_timestamp_start(parent);
+		if (rc)
+			goto out_can_rx_offload_disable;
+	}
 
+	if (!parent->active_channels) {
 		for (i = 0; i < GS_MAX_RX_URBS; i++) {
 			u8 *buf;
 
@@ -1102,13 +1156,11 @@ static int gs_can_open(struct net_device *netdev)
 out_usb_free_urb:
 	usb_free_urb(urb);
 out_usb_kill_anchored_urbs:
-	if (!parent->active_channels) {
+	if (!parent->active_channels)
 		usb_kill_anchored_urbs(&parent->rx_submitted);
-
-		if (dev->feature & GS_CAN_FEATURE_HW_TIMESTAMP)
-			gs_usb_timestamp_stop(parent);
-	}
-
+	if (parent->flags & GS_USB_PARENT_FLAGS_HW_TIMESTAMP)
+		gs_usb_timestamp_stop(parent);
+out_can_rx_offload_disable:
 	can_rx_offload_disable(&dev->offload);
 	close_candev(netdev);
 
@@ -1160,12 +1212,11 @@ static int gs_can_close(struct net_device *netdev)
 
 	/* Stop polling */
 	parent->active_channels--;
-	if (!parent->active_channels) {
+	if (!parent->active_channels)
 		usb_kill_anchored_urbs(&parent->rx_submitted);
 
-		if (dev->feature & GS_CAN_FEATURE_HW_TIMESTAMP)
-			gs_usb_timestamp_stop(parent);
-	}
+	if (parent->flags & GS_USB_PARENT_FLAGS_HW_TIMESTAMP)
+		gs_usb_timestamp_stop(parent);
 
 	/* Stop sending URBs */
 	usb_kill_anchored_urbs(&dev->tx_submitted);
@@ -1525,6 +1576,7 @@ static int gs_usb_probe(struct usb_interface *intf,
 		.byte_order = cpu_to_le32(0x0000beef),
 	};
 	struct gs_device_config dconf;
+	bool hw_ts_supported = false;
 	unsigned int icount, i;
 	int rc;
 
@@ -1599,6 +1651,9 @@ static int gs_usb_probe(struct usb_interface *intf,
 		parent->canch[i] = dev;
 		parent->canch[i]->parent = parent;
 
+		if (parent->canch[i]->feature & GS_CAN_FEATURE_HW_TIMESTAMP)
+			hw_ts_supported = true;
+
 		/* set RX packet size based on FD and if hardware
 		 * timestamps are supported.
 		 */
@@ -1616,6 +1671,9 @@ static int gs_usb_probe(struct usb_interface *intf,
 		parent->hf_size_rx = max(parent->hf_size_rx, hf_size_rx);
 	}
 
+	if (hw_ts_supported)
+		gs_usb_timestamp_init(parent);
+
 	for (i = 0; i < icount; i++) {
 		struct gs_can *dev = parent->canch[i];
 

-- 
2.53.0

