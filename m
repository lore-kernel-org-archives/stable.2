Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=185.203.200.13
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1794689421;
	b=nLS0mqJ365y25CPByDlzUq6bf9kHbWo162ZaeaYgRaQW9k7hqj1EpGqp64+5sva4UX2B
	 GHoeSeV6unFugZAdpqccbwcFO2ydy/ieWwBjDhuhYnxgst63JRR1tO4bK6P3Pdn72SMI7
	 +iVaZGjk6hBH6OaemBU++ZAKnrZBDT79dgNlvLPNm7pnxsxvjNpssL2JqX0pG7UJiqn7t
	 bIbIechtoQyvk3p40mmoDPYdWCZGHmZ79PRBmcRm+1lCIiRl7ZTWEQLyTc3eN6qHO7p9P
	 pDmSScw66knLaxZrtVI0qmSejJNoRrpH6hNRvFSAB0Pza4/fne52icDapWpdYXT/7bw==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794689421;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Received:From:Date:
	 Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:
	 Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key;
	bh=QaMupe0EerkwHQZi6TM4Ix6MSYbYjEL2qHaJJvKXP/U=;
	b=pnGFyjjLA6SYcw1S8ZQLJD8o9F0Mt9TjmHGeTQkyt3gmMOK0lB4kugdNoX3Hwj4qF+MN
	 mVm1cinLt7Ug0PYsBo67LfDJNcJUMbybeLeh8k0BojLcNAl176MDySC3OWTJLnWxtf+0z
	 +MGEMP2I2+ojfF1JtYRilHaNVq1GB3oQdZftp7V5lxSh+uxmRUj1wIYZHdRPqB70Cx6cv
	 U+QxRR0CVxnyU/SWtad2dKKIKpuGjYVZKXnm4D06UL2vhS9d2cpA2r/DfHN90jiADBVST
	 KopLdnd9pPCoyEvyWHBVW5Kp7Yb1Q8jubiyXSSDQZd4B5pZap7I15IceuQ0dkHZitrw==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=none header.from=pengutronix.de;
	spf=pass smtp.mailfrom=pengutronix.de;
	dkim=pass header.d=pengutronix.de header.i=@pengutronix.de header.a=rsa-sha256 header.s=20260414 header.b=Uqr6Ldot;
	arc=pass header.oldest-pass=0 smtp.remote-ip=185.203.200.13
Received: from mx1.white.stw.pengutronix.de (mx1.white.stw.pengutronix.de [185.203.200.13])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 05BF7606A331;
	Sat, 14 Nov 2026 20:50:20 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 05BF7606A331
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pengutronix.de header.i=@pengutronix.de header.a=rsa-sha256 header.s=20260414 header.b=Uqr6Ldot
Received: from drehscheibe.grey.stw.pengutronix.de (drehscheibe.grey.stw.pengutronix.de [IPv6:2a0a:edc0:0:c01:1d::a2])
	(Authenticated sender: relay-from-drehscheibe.grey.stw.pengutronix.de)
	by mx1.white.stw.pengutronix.de (Postfix) with ESMTPSA id 95BB320245F;
	Sat, 14 Nov 2026 21:50:15 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pengutronix.de;
	s=20260414; t=1794689415;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=QaMupe0EerkwHQZi6TM4Ix6MSYbYjEL2qHaJJvKXP/U=;
	b=Uqr6Ldot3P+XqwfkuUFhgKRF7D5epeMqFBjidA5kzt3Or9XzjFFTb0JAcrHc9d7rfGipQ6
	fJXNf76aNYuefz0qimH5dvOq/Up1es8x2mnfLIm7eoNdS8A9xubp7z5L3zC4KSwR+3yLgL
	qTxeOfW4/ow/Xko7J5fu4bwRsT+e7nfZzZO3ee9n5qLNtZWCjUMXeU+itc+uWpPMGj7YoN
	pbYD7cfVChSD20BkpeqEVS3nxnWayX16UafYKYU/L1LBvsIH4sjofx9IV9ism8jsKElGWP
	dTdw4VFo0+WYUeiRVknXdE0YDe0oiSMPRg6OdjKRlP3p7w5sm1zGqe54CGcJsA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=pengutronix.de;
	s=20260414; t=1794689415;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=QaMupe0EerkwHQZi6TM4Ix6MSYbYjEL2qHaJJvKXP/U=;
	b=E+tcsR0BpOD2/ufBcwoZ+RxITMUvGz0MjqygAjQ/+4PjZ83hI6F6m+2jTHgGdjp8WpVawV
	tjMBJrGnI5Z7E/oa0P8YDqqWSCQ8h2v0odSOjFtJ1aoDCYrKWm25Xluk/yxI5SESpslcMc
	s8hQFapKjS4hKA5M8gbrWANW35FcsCjGASIe85e5XQRh+z0OM+6TiypCzTyrZSVKWn7uKa
	M2yeiRejFSsJ/O/90xBKOD5xdBoMh4J5YT6itYbliMh3ibo1Ns7opjm+N+lw52SdfCFx1L
	aZ4nc4OQDyxTey1vv4Wr6MsuaskAaNWHp5P6W45e41f/pDSvucKsL1+43hU/TA==
ARC-Seal: i=1; s=20260414; d=pengutronix.de; t=1794689415; a=rsa-sha256;
	cv=none;
	b=cG07Ac0VC80XTQl16ZdECsT9LeVx+RxZlVC5BHgcHiLDC4REXCi1QvRTHz3wr1hEGj0wQ8
	IM6z3wKZeQtj5cPNXOZDbbnXXubeLxItO++AuIxdPCWIuYAcKaINNNqf4WZlQf2g3Zvumn
	Sg+LlONJQt6RyfFnrA4D59wyZT8PCdL67zOPhNsiFeMpjatLmLT3dvC/p2/opAwYDiGvL8
	erI/k3xvtesCKv4m1QKy7sYWge8C2S67IG9EyNM7gDoZPgVujDtXqo3/oNgOOO9xoV5qjj
	V/BY8LDqRdV370pyHayGIQaoQ0diM82Hp0I3qhk/+x3I6EKCOdIJxsMLVPYbFg==
ARC-Authentication-Results: i=1;
	ORIGINATING;
	auth=pass smtp.auth=relay-from-drehscheibe.grey.stw.pengutronix.de smtp.mailfrom=mkl@pengutronix.de
Received: from moin.white.stw.pengutronix.de ([2a0a:edc0:0:b01:1d::7b] helo=bjornoya.blackshift.org)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <mkl@pengutronix.de>)
	id 1xSKhT-004BfQ-1a;
	Sat, 14 Nov 2026 21:50:15 +0100
Received: from hardanger.blackshift.org (p4ffb23c7.dip0.t-ipconnect.de [79.251.35.199])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519MLKEM768 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(Client did not present a certificate)
	(Authenticated sender: mkl-all@blackshift.org)
	by smtp.blackshift.org (Postfix) with ESMTPSA id 30A795EBD73;
	Sat, 14 Nov 2026 20:50:15 +0000 (UTC)
From: Marc Kleine-Budde <mkl@pengutronix.de>
Date: Sat, 14 Nov 2026 21:49:59 +0100
Subject: [PATCH can-next v8 5/7] can: gs_usb: fix hardware timestamp state
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
Message-Id: <20261114-gs_usb-fixes-v8-5-f615502b005b@pengutronix.de>
References: <20261114-gs_usb-fixes-v8-0-f615502b005b@pengutronix.de>
In-Reply-To: <20261114-gs_usb-fixes-v8-0-f615502b005b@pengutronix.de>
To: Vincent Mailhol <mailhol@kernel.org>, Peter Fink <pfink@christ-es.de>, 
 Eric Evenchick <eric@evenchick.com>, 
 Maximilian Schneider <max@schneidersoft.net>, 
 Wolfgang Grandegger <wg@grandegger.com>
Cc: kernel@pengutronix.de, linux-can@vger.kernel.org, 
 Marc Kleine-Budde <mkl@pengutronix.de>, 
 Shuangpeng Bai <shuangpeng.kernel@gmail.com>, stable@vger.kernel.org, 
 Vadim Fedorenko <vadim.fedorenko@linux.dev>
X-Mailer: b4 0.17-dev-d7211
X-Developer-Signature: v=1; a=openpgp-sha256; l=7706; i=mkl@pengutronix.de;
 h=from:subject:message-id; bh=64DSKvzEMNmBrtBAnhstdvXNF8q6ewU0JvfWmFcWHAg=;
 b=owGbwMvMwCV2xirl17qZay8xnlZLYsj6cbLptF7v9TWHBf5dEjk7T07hp7F74vOV6SnRz84ee
 ac36Y7xxo5SFgYxLgZZMUWWpT9OKAoEOpT2vkyYBDOHlQlkCAMXpwBMpJSN4X+C1yKbrU8WnrOf
 uyw8YbXylH4Vx6iN9vd38uyfL7VohZA3I8Opx3vcrTn5L1s+ZF/9sMHyo/5yu+7Dsf/aj8vbr/t
 5SJEJAA==
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
channel has.

Keep the initialization of the HW timestamping infrastructure in
gs_usb_timestamp_init(), and move initial time init and the initial
scheduling of the delayed worker into gs_usb_timestamp_start().

Initialize the HW timestamping infrastructure in gs_usb_probe() using
gs_usb_timestamp_init() if at least one channel has the
GS_CAN_FEATURE_HW_TIMESTAMP flag set.

Start and sync the timestamping infrastructure when opening the first
channel of a device that supports HW timestamps and stop it if the last
channel closes. Avoid the race window during timecounter_init()
(gs_usb_timestamp_read() drops the struct gs_usb::tc_lock) by reading the
initial time stamp prior taking the lock.

To simplify backporting, the next patch will switch to the new
{enable,disable}_delayed_work() API to avoid self-rescheduling of the
timestamp worker. That API has been added with v6.10, commit 86898fa6b8cd
("workqueue: Implement disable/enable for (delayed) work items").

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
 drivers/net/can/usb/gs_usb.c | 74 ++++++++++++++++++++++++++++++++++++++------
 1 file changed, 64 insertions(+), 10 deletions(-)

diff --git a/drivers/net/can/usb/gs_usb.c b/drivers/net/can/usb/gs_usb.c
index 980c4a748c94..6b65f4d9e8f9 100644
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
@@ -332,11 +336,13 @@ struct gs_usb {
 	/* time counter for hardware timestamps */
 	struct cyclecounter cc;
 	struct timecounter tc;
-	spinlock_t tc_lock; /* spinlock to guard access tc->cycle_last */
+	u32 timestamp_initial;
+	spinlock_t tc_lock; /* spinlock to guard access cc, tc, timestamp_initial */
 	struct delayed_work timestamp;
 
 	unsigned int hf_size_rx;
 	u8 active_channels;
+	u8 flags;
 	u8 channel_cnt;
 
 	unsigned int pipe_in;
@@ -423,6 +429,13 @@ static inline int gs_usb_get_timestamp(const struct gs_usb *parent,
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
@@ -475,19 +488,44 @@ static void gs_usb_timestamp_init(struct gs_usb *parent)
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
@@ -988,9 +1026,15 @@ static int gs_can_open(struct net_device *netdev)
 
 	can_rx_offload_enable(&dev->offload);
 
+	/* rely on RTNL to serialize concurrent ifup/ifdown */
+	ASSERT_RTNL();
+
 	if (!parent->active_channels) {
-		if (dev->feature & GS_CAN_FEATURE_HW_TIMESTAMP)
-			gs_usb_timestamp_init(parent);
+		if (parent->flags & GS_USB_PARENT_FLAGS_HW_TIMESTAMP) {
+			rc = gs_usb_timestamp_start(parent);
+			if (rc)
+				goto out_can_rx_offload_disable;
+		}
 
 		for (i = 0; i < GS_MAX_RX_URBS; i++) {
 			u8 *buf;
@@ -1105,10 +1149,10 @@ static int gs_can_open(struct net_device *netdev)
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
 
@@ -1158,12 +1202,15 @@ static int gs_can_close(struct net_device *netdev)
 
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
 
@@ -1525,6 +1572,7 @@ static int gs_usb_probe(struct usb_interface *intf,
 		.byte_order = cpu_to_le32(0x0000beef),
 	};
 	struct gs_device_config dconf;
+	bool hw_ts_supported = false;
 	unsigned int icount, i;
 	int rc;
 
@@ -1599,6 +1647,9 @@ static int gs_usb_probe(struct usb_interface *intf,
 		parent->canch[i] = dev;
 		parent->canch[i]->parent = parent;
 
+		if (parent->canch[i]->feature & GS_CAN_FEATURE_HW_TIMESTAMP)
+			hw_ts_supported = true;
+
 		/* set RX packet size based on FD and if hardware
 		 * timestamps are supported.
 		 */
@@ -1616,6 +1667,9 @@ static int gs_usb_probe(struct usb_interface *intf,
 		parent->hf_size_rx = max(parent->hf_size_rx, hf_size_rx);
 	}
 
+	if (hw_ts_supported)
+		gs_usb_timestamp_init(parent);
+
 	for (i = 0; i < icount; i++) {
 		struct gs_can *dev = parent->canch[i];
 

-- 
2.53.0

