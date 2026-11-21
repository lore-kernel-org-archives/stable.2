Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=185.203.200.13
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1795300585;
	b=ORWwOvE53yKV+JONgewU8kf5mb4FLPn+hyr0fUW5oG5VSaGHVKvdGaw14xYLwGYkvSs3
	 32gZxEO8cYT97LdbJBHz7dsPZuqW0TpeM/48xP/M4WKxtPzzpKBQqFvlv31TJ/Dq/9n4G
	 xy4Q65mrJOofHj1QiHzOgVSV5AZ64xIe56QGL7cnQq/okYFb35JbgitRaAKUuthe3QoNe
	 +00w99eHjqxUec6slbx0DxW3sDqwGLPZS1OZua1ZBgsv/mFfFLedJql90z28Cc7vxQmAL
	 4G41i1py/feqmfphPhppV5jaxytpQ/5uPCEQGBDgzZEHuFUqF7OLpDq72CHpkEILsSg==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795300585;
	h=DMARC-Filter:Received:DKIM-Signature:From:Date:Subject:MIME-Version:
	 Content-Type:Content-Transfer-Encoding:Message-Id:References:
	 In-Reply-To:To:Cc:X-Mailer:X-Developer-Signature:X-Developer-Key;
	bh=/1DFVkDWzwfkxTtWSakwS1M1IpQEp0yJGUOpbD4dG8k=;
	b=AgUwN2p57xvBvABqMtRO9ALUMm12neMh2N0rJ8NcoB/blTYVukXqb6PkDXS/AorkFfsd
	 e1U/Uihsyb3D3daTClbj6AX2TF3iCtlM5Wx4Yd8dL5KoTdBfPHL2RMPjtOAG1+YnKuAoN
	 HRuPAIXVbyBxo2r53UYpd5xXMfnPO5KsUTQ3aHh9kvGeFHqpjW2biIsLqSS+VZz7Wrz5h
	 mWt29yhzd5dbjyqtOkrAXQXm+aqTwCHiBkooYwausZkGc2eL0ac+1ug52Iev6e97IvKwL
	 ca19cEdkiMu4AzobULYNtvnw1RRWLG2eeQoR4yGp3azS1VqkDB53Gyxm24rfEEVsH1A==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=none header.from=pengutronix.de;
	spf=pass smtp.mailfrom=pengutronix.de;
	dkim=pass header.d=pengutronix.de header.i=@pengutronix.de header.a=rsa-sha256 header.s=20260414 header.b=UGEU0AD9;
	arc=pass header.oldest-pass=0 smtp.remote-ip=185.203.200.13
Received: from mx1.white.stw.pengutronix.de (mx1.white.stw.pengutronix.de [185.203.200.13])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6BA95606A332;
	Sat, 21 Nov 2026 22:36:24 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 6BA95606A332
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pengutronix.de header.i=@pengutronix.de header.a=rsa-sha256 header.s=20260414 header.b=UGEU0AD9
Received: from hardanger.blackshift.org (p20030102af17cb00849b19770537dbc5.dip0.t-ipconnect.de [IPv6:2003:102:af17:cb00:849b:1977:537:dbc5])
	(Authenticated sender: mkl@pengutronix.de)
	by mx1.white.stw.pengutronix.de (Postfix) with ESMTPSA id 9B0EE205A1B;
	Sat, 21 Nov 2026 23:36:20 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pengutronix.de;
	s=20260414; t=1795300580;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=/1DFVkDWzwfkxTtWSakwS1M1IpQEp0yJGUOpbD4dG8k=;
	b=UGEU0AD9VOePdhdxw2LRp4e/bvSpsG9T3HSCYeZ9slG69CgKtQerSbMdxbITzLpB1ZC4NY
	ogSH6YKmWy1PcMKnbZdox1+e7d6YEg64EXkqdIdtnfID1RHMvRFNiaKkZAU4Ab153xsJ22
	gZ75Jeud6N7TWWM9aMjZryQURMCH/2BpQGymnMI0ijj/MjxFkcVcvYdyzvpSIya+QNSrgK
	NMc8Jb7RAJUhmuhP3rwztqeyFh2XO8PB3M9e22o4/IUNP9/FZeqSObZHshpLnJZ/i5jwZF
	QP54d3WLpqXOFtSnocDCbD9YnbNkNdQuSF3/Xj8Ux3fHfHnGCSjXelr3ZA+GJQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=pengutronix.de;
	s=20260414; t=1795300580;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=/1DFVkDWzwfkxTtWSakwS1M1IpQEp0yJGUOpbD4dG8k=;
	b=LzqEKUhwbQw/twvPe74T8bsGWX1jhWbyr0GVLv9q2VwqUfgC61PdmhFZYvEwQot5sBvtD3
	tyL3w0sl6fAiyixbjS+VIpbvY4L/+VQhDP1FwIoTsFVy2qLt4cclCilrczWka9wR301USJ
	JPktXcvL+AN65KRixSJZrdyA7iE6n2tG8mhviGoqSCsz1IDfLohmiYgR969YhKRs2B9J2F
	QrEga3tFymF2iQCB8g2KX8FETE7fyOn69tjoGF5h7FNrCLvmD7yNZrMy2SKJ6cm2KlDAUl
	blPvAgFLGB8bK8g6zIXg6SOSObipDGH2Oz4FjOtlxKbB/btxGPMuwMuQZGWf7Q==
ARC-Seal: i=1; s=20260414; d=pengutronix.de; t=1795300580; a=rsa-sha256;
	cv=none;
	b=XQVk6eveAicx/y8u2vWzjVpUldlS2mNw09ACQ8R/cGmmB3cW7LKRz1hWYxa1jZUnRnYE4o
	hA7RGPxDDH3+UszNUqVZCzU0Ofo8DBoDQm1nfEwYdwd8a3oQ9NI3FBFjvjwkaT6lgZMbdW
	w6vkxhF/YhGchzd1+qKDcqV+Tn0CRwXPuDD3SwFyFV/Yrfplld4uX7XDcCAGMe0JgFkQkO
	EptCyXguhoJyurp8crpu5jNikhhTL6MQwBVm8YNMXhALn7oYeOBU/39ZIGTpaUopTR2Rgh
	oHVL1f3PwDXFYOtwzTOIAPTULjM++DbxZNCjnlGmHVsSABjgTfL7MO/X9aKgsA==
ARC-Authentication-Results: i=1;
	ORIGINATING;
	auth=pass smtp.auth=mkl@pengutronix.de smtp.mailfrom=mkl@pengutronix.de
From: Marc Kleine-Budde <mkl@pengutronix.de>
Date: Sat, 21 Nov 2026 23:36:03 +0100
Subject: [PATCH can-next v9 05/13] can: gs_usb: fix hardware timestamp
 state for mixed channels
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
Message-Id: <20261121-gs_usb-fixes-v9-5-db121d488945@pengutronix.de>
References: <20261121-gs_usb-fixes-v9-0-db121d488945@pengutronix.de>
In-Reply-To: <20261121-gs_usb-fixes-v9-0-db121d488945@pengutronix.de>
To: Vincent Mailhol <mailhol@kernel.org>, Peter Fink <pfink@christ-es.de>, 
 Eric Evenchick <eric@evenchick.com>, 
 Maximilian Schneider <max@schneidersoft.net>, 
 Wolfgang Grandegger <wg@grandegger.com>
Cc: kernel@pengutronix.de, linux-can@vger.kernel.org, 
 Marc Kleine-Budde <mkl@pengutronix.de>, 
 Shuangpeng Bai <shuangpeng.kernel@gmail.com>, stable@vger.kernel.org, 
 Vadim Fedorenko <vadim.fedorenko@linux.dev>
X-Mailer: b4 0.17-dev-1b309
X-Developer-Signature: v=1; a=openpgp-sha256; l=8054; i=mkl@pengutronix.de;
 h=from:subject:message-id; bh=up8zxQrrA9JcpBVmEZgrLYbfRKp3bIp75b9e5d8Itfc=;
 b=owGbwMvMwCV2xirl17qZay8xnlZLYshmkrnhHT3p9Lv1v5+umGP+JW7NpAN7F3TFH61Y4ltve
 aUpdin3kY5SFgYxLgZZMUWWpT9OKAoEOpT2vkyYBDOHlQlkCAMXpwBM5KM7wz8T+5LFvWel1DXm
 G7g/yluXuW76jOuXTh8Tua96QS51hqMuw3+/Yv4Jk95dffj+asLlT4sddy/4tZLVvKY3t7e4q1P
 1fzQbAA==
X-Developer-Key: i=mkl@pengutronix.de; a=openpgp;
 fpr=C1400BA0B3989E6FBC7D5B5C2B5EE211C58AEA54

From: Shuangpeng Bai <shuangpeng.kernel@gmail.com>

For hardware timestamping, the driver manages the infrastructure
(cyclecounter/timecounter) for the entire USB interface, for now assuming
that all channels share a common time base, even though each channel
individually indicates support for hardware timestamping via the
GS_CAN_FEATURE_HW_TIMESTAMP flag.

Currently both the initialization and shutdown of the HW timestamping
infrastructure is tied to the flags of the first channel opened
respectively last channel closed. This leads to problems if the first
channel opened doesn't have the timestamping feature, but the second
channel has. In this case the timestamping is never properly initialized.

Keep the initialization of the HW timestamping infrastructure in
gs_usb_timestamp_init(), and move initial time init and the initial
scheduling of the delayed worker into gs_usb_timestamp_start().

It's worth noting that if reading of the initial time stamp fails the
interface cannot be opened.

Initialize the HW timestamping infrastructure in gs_usb_probe() using
gs_usb_timestamp_init() if at least one channel has the
GS_CAN_FEATURE_HW_TIMESTAMP flag set. Initialize struct gs_usb::cc while
holding the tc_lock.

Start and sync the timestamping infrastructure when opening the first
channel of a device that supports HW timestamps and stop it if the last
channel closes. Avoid the race window during timecounter_init()
(gs_usb_timestamp_read() drops the struct gs_usb::tc_lock) by reading the
initial time stamp prior taking the lock.

To simplify backporting, support for context analysis is added in a later
patch.

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
 drivers/net/can/usb/gs_usb.c | 88 +++++++++++++++++++++++++++++++++++++-------
 1 file changed, 74 insertions(+), 14 deletions(-)

diff --git a/drivers/net/can/usb/gs_usb.c b/drivers/net/can/usb/gs_usb.c
index 470dd52d97df..30bcb734c5df 100644
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
@@ -332,12 +336,14 @@ struct gs_usb {
 	/* time counter for hardware timestamps */
 	struct cyclecounter cc;
 	struct timecounter tc;
-	spinlock_t tc_lock; /* spinlock to guard access tc->cycle_last */
+	u32 timestamp_initial;
+	spinlock_t tc_lock; /* spinlock to guard access cc, tc, timestamp_initial */
 	unsigned long tc_lock_flags;
 	struct delayed_work timestamp;
 
 	unsigned int hf_size_rx;
 	u8 active_channels;
+	u8 flags;
 	u8 channel_cnt;
 
 	unsigned int pipe_in;
@@ -424,6 +430,13 @@ static inline int gs_usb_get_timestamp(const struct gs_usb *parent,
 	return 0;
 }
 
+static u64 gs_usb_timestamp_read_initial(struct cyclecounter *cc)
+{
+	const struct gs_usb *parent = container_of(cc, struct gs_usb, cc);
+
+	return parent->timestamp_initial;
+}
+
 static u64 gs_usb_timestamp_read(struct cyclecounter *cc) __must_hold(&dev->tc_lock)
 {
 	struct gs_usb *parent = container_of(cc, struct gs_usb, cc);
@@ -477,19 +490,46 @@ static void gs_usb_timestamp_init(struct gs_usb *parent)
 {
 	struct cyclecounter *cc = &parent->cc;
 
-	cc->read = gs_usb_timestamp_read;
-	cc->mask = CYCLECOUNTER_MASK(32);
-	cc->shift = 32 - bits_per(NSEC_PER_SEC / GS_USB_TIMESTAMP_TIMER_HZ);
-	cc->mult = clocksource_hz2mult(GS_USB_TIMESTAMP_TIMER_HZ, cc->shift);
-
 	spin_lock_init(&parent->tc_lock);
-	spin_lock_irqsave(&parent->tc_lock, parent->tc_lock_flags);
-	timecounter_init(&parent->tc, &parent->cc, ktime_get_real_ns());
-	spin_unlock_irqrestore(&parent->tc_lock, parent->tc_lock_flags);
+
+	scoped_guard(spinlock_irqsave, &parent->tc_lock) {
+		cc->mask = CYCLECOUNTER_MASK(32);
+		cc->shift = 32 - bits_per(NSEC_PER_SEC / GS_USB_TIMESTAMP_TIMER_HZ);
+		cc->mult = clocksource_hz2mult(GS_USB_TIMESTAMP_TIMER_HZ, cc->shift);
+	}
 
 	INIT_DELAYED_WORK(&parent->timestamp, gs_usb_timestamp_work);
+
+	parent->flags |= GS_USB_PARENT_FLAGS_HW_TIMESTAMP;
+}
+
+static int gs_usb_timestamp_start(struct gs_usb *parent)
+{
+	u32 timestamp = 0;
+	int rc;
+
+	/* read current timestamp, will be used for initial time stamp */
+	rc = gs_usb_get_timestamp(parent, &timestamp);
+	if (rc)
+		return rc;
+
+	scoped_guard(spinlock_irqsave, &parent->tc_lock) {
+		struct cyclecounter *cc = &parent->cc;
+
+		/* gs_usb_timestamp_read() will drop the struct gs_usb::tc_lock. Avoid the race
+		 * window by using gs_usb_timestamp_read_initial() to read the initial timestamp in
+		 * timecounter_init(), switch to gs_usb_timestamp_read() afterwards.
+		 */
+		parent->timestamp_initial = timestamp;
+		cc->read = gs_usb_timestamp_read_initial;
+		timecounter_init(&parent->tc, &parent->cc, ktime_get_real_ns());
+		cc->read = gs_usb_timestamp_read;
+	}
+
 	schedule_delayed_work(&parent->timestamp,
 			      GS_USB_TIMESTAMP_WORK_DELAY_SEC * HZ);
+
+	return 0;
 }
 
 static void gs_usb_timestamp_stop(struct gs_usb *parent)
@@ -990,9 +1030,19 @@ static int gs_can_open(struct net_device *netdev)
 
 	can_rx_offload_enable(&dev->offload);
 
+	/* rely on RTNL to serialize concurrent ifup/ifdown */
+	ASSERT_RTNL();
+
 	if (!parent->active_channels) {
-		if (dev->feature & GS_CAN_FEATURE_HW_TIMESTAMP)
-			gs_usb_timestamp_init(parent);
+		if (parent->flags & GS_USB_PARENT_FLAGS_HW_TIMESTAMP) {
+			rc = gs_usb_timestamp_start(parent);
+			if (rc) {
+				if (rc == -ENODEV) {
+					netif_device_detach(netdev);
+
+				goto out_can_rx_offload_disable;
+			}
+		}
 
 		for (i = 0; i < GS_MAX_RX_URBS; i++) {
 			u8 *buf;
@@ -1107,10 +1157,10 @@ static int gs_can_open(struct net_device *netdev)
 	if (!parent->active_channels) {
 		usb_kill_anchored_urbs(&parent->rx_submitted);
 
-		if (dev->feature & GS_CAN_FEATURE_HW_TIMESTAMP)
+		if (parent->flags & GS_USB_PARENT_FLAGS_HW_TIMESTAMP)
 			gs_usb_timestamp_stop(parent);
 	}
-
+out_can_rx_offload_disable:
 	can_rx_offload_disable(&dev->offload);
 	close_candev(netdev);
 
@@ -1160,12 +1210,15 @@ static int gs_can_close(struct net_device *netdev)
 
 	netif_stop_queue(netdev);
 
+	/* rely on RTNL to serialize concurrent ifup/ifdown */
+	ASSERT_RTNL();
+
 	/* Stop polling */
 	parent->active_channels--;
 	if (!parent->active_channels) {
 		usb_kill_anchored_urbs(&parent->rx_submitted);
 
-		if (dev->feature & GS_CAN_FEATURE_HW_TIMESTAMP)
+		if (parent->flags & GS_USB_PARENT_FLAGS_HW_TIMESTAMP)
 			gs_usb_timestamp_stop(parent);
 	}
 
@@ -1524,6 +1577,7 @@ static int gs_usb_probe(struct usb_interface *intf,
 		.byte_order = cpu_to_le32(0x0000beef),
 	};
 	struct gs_device_config dconf;
+	bool hw_ts_supported = false;
 	unsigned int icount, i;
 	int rc;
 
@@ -1598,6 +1652,9 @@ static int gs_usb_probe(struct usb_interface *intf,
 		parent->canch[i] = dev;
 		parent->canch[i]->parent = parent;
 
+		if (parent->canch[i]->feature & GS_CAN_FEATURE_HW_TIMESTAMP)
+			hw_ts_supported = true;
+
 		/* set RX packet size based on FD and if hardware
 		 * timestamps are supported.
 		 */
@@ -1615,6 +1672,9 @@ static int gs_usb_probe(struct usb_interface *intf,
 		parent->hf_size_rx = max(parent->hf_size_rx, hf_size_rx);
 	}
 
+	if (hw_ts_supported)
+		gs_usb_timestamp_init(parent);
+
 	for (i = 0; i < icount; i++) {
 		struct gs_can *dev = parent->canch[i];
 

-- 
2.53.0

