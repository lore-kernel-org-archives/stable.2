Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=185.203.200.13
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1794171228;
	b=frL4TnCmA/IyKMvK+UMK9wa8L0kOjDKf1RCJxV9nFLKsOyiTAgAdPGDJontkI0Eduge6
	 3DvOPXfubOUNXG/l5yzS+qip73A3HhbTqPRSVeulAR+qGsEIBJzlV8g9mLKMqOptbewTQ
	 0etxrqx5M1MqBAb/wIcO76bmr0ICHyh3dTKTLElXfYCSq0op5RBzCnZPXdQe2bEUGqvUf
	 0iEux2F732iJ6EsBqFk79mb46sWv5dVJtuzq3Fd61nuQWHoLLD/r1t7ltT94WOcjyKdeq
	 VFQ9FIMlyzetYFvwbWQVm8+8Rf4UGne/m4flNWMaKdOKfPzOiQBWGvMcLZKTlgY1kpA==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794171228;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Received:From:Date:
	 Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:
	 Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key;
	bh=D7SUOf0lCuEppgUMFHGopDauRrEQjd8i2oER4uSs8iE=;
	b=N1mFukgmjGE2+GGGMq2Hx2tfRrqM14IWkXyeLkloL50dfTt3ePa5oqdfVs2fRl6iplRJ
	 PoyUfu/1+ZNo8PnHlF+V82ExnGg8sQfEvBdiGv6He20Jeno/0ot6h/cRYqn5t+8R8zs9i
	 PO6rYFMsemoH+W5XAubBdKn2hBZPlT1eiRsebYHIXarGjtqCj03cQR13RViYMc9Knc2tE
	 ZMC5kNjCOUJFZ82ZMuujA5BtTWnyf7Z5kF+O2SSSa+1t2FRbtkFJRiqmiXyE1jmeNiL14
	 4CQV+Kt58MUFyBnuBN8EWwvJRN9M3kbVIP6zD1eH6U+ztvW44GGb+4BiH+LglLrKTKQ==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=none header.from=pengutronix.de;
	spf=pass smtp.mailfrom=pengutronix.de;
	dkim=pass header.d=pengutronix.de header.i=@pengutronix.de header.a=rsa-sha256 header.s=20260414 header.b="HpozFzf/";
	arc=pass header.oldest-pass=0 smtp.remote-ip=185.203.200.13
Received: from mx1.white.stw.pengutronix.de (mx1.white.stw.pengutronix.de [185.203.200.13])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B3B1A606A334;
	Sun,  8 Nov 2026 20:53:47 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org B3B1A606A334
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pengutronix.de header.i=@pengutronix.de header.a=rsa-sha256 header.s=20260414 header.b=HpozFzf/
Received: from drehscheibe.grey.stw.pengutronix.de (drehscheibe.grey.stw.pengutronix.de [IPv6:2a0a:edc0:0:c01:1d::a2])
	(Authenticated sender: relay-from-drehscheibe.grey.stw.pengutronix.de)
	by mx1.white.stw.pengutronix.de (Postfix) with ESMTPSA id 1D6CF200A41;
	Sun, 08 Nov 2026 21:53:40 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pengutronix.de;
	s=20260414; t=1794171220;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=D7SUOf0lCuEppgUMFHGopDauRrEQjd8i2oER4uSs8iE=;
	b=HpozFzf/dXRJCPK3Bxnpi/G8FZXWy37HBC/wuQHzPW2EVkiEdggl92tXO6ZOqBJ4Ob15Kq
	SgtFPr1AhWr03DvryK7bXuLXqJPvXugkSUCkRqLEeMwItVWszYLuKVDvxwwulGiKzLnom1
	l/4xTUZN30g+byDrwn/cTYY2B+XQUA3ugrDneSKHWc+sfObm3xWqtP59FouE1rYzP/U9rw
	/VuJ873HeD3k2wPZBAGQdGgd+Km10pc+70QZwTxz1S0UlGG1W4lmsTJbDLnjNK7eIRG56s
	yRogGFNOCfKuwQ1CFDur/KKmQRtNvU9+CFs6c1VP0TkoQCs3ugXp5cBfc0RgyA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=pengutronix.de;
	s=20260414; t=1794171220;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=D7SUOf0lCuEppgUMFHGopDauRrEQjd8i2oER4uSs8iE=;
	b=S/V/q5VOTiBC+k+OpGYjaEZ+X063CkOHxPVy3JS9hgsdtlOBxpEcuj/0UEtwET+G+9+vZT
	2ySz7sqlRDgK0cbCNkR+8bd7fHUVk2uOh+YrUv8bfT2yqzWSzpz19wdLuEXMb9PO1LMf6l
	VTs7hqnzOzhoBF82QgQeA0FkwP8d4ovuDMmp3w/3wA6M19zVXPG95A3zjAzGhuUelXnCH4
	7ORxRhEQvJZDYjmH3H93XCnNyDenfIbNB3sDZtQoqBzGR0xu80RghZCQX9JyOniqhUkn9N
	haqQsu1HHVpnkS0vU1Vi/Ih0PDGl5K0OocP6TkKKwKrCy+UcM2saZtt5oWtwMw==
ARC-Authentication-Results: i=1;
	ORIGINATING;
	auth=pass smtp.auth=relay-from-drehscheibe.grey.stw.pengutronix.de smtp.mailfrom=mkl@pengutronix.de
ARC-Seal: i=1; s=20260414; d=pengutronix.de; t=1794171220; a=rsa-sha256;
	cv=none;
	b=C1KI6mb6Zqznqx9Sn+hjOvvlqk54PYzIaq2ekDIz803RynBK6zLxPuYSgSXSu8Bv8xB7rF
	bo3Rj0DJZLpmQVGg2MyhSDcpGK0BYQrG1rlgnsVMZXf4c5htBEWPlcaS/8gAS7Vcv70eMP
	oS8KXtebJtUvB0pkRTZlK85QZmUqjRp++RBIkdyNdj/qbQVUhUUVRPcHLGD+3Tv5tBTHkp
	0Bn2Qei9KL4R5+JrRMsbpCMXrrEkxkYgLXMj+jWDDx2oZHdOPapU4fLKvWnThNgiJJLzRU
	7vllsAhPPxwaAhUrcE8hCeCdrIC2Y9DXSu6iAZHOBNlS35LWcIupNe9Of2T1Bg==
Received: from moin.white.stw.pengutronix.de ([2a0a:edc0:0:b01:1d::7b] helo=bjornoya.blackshift.org)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <mkl@pengutronix.de>)
	id 1xQ9tT-003EmR-32;
	Sun, 08 Nov 2026 21:53:39 +0100
Received: from hardanger.blackshift.org (p4ffb23c7.dip0.t-ipconnect.de [79.251.35.199])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519MLKEM768 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(Client did not present a certificate)
	(Authenticated sender: mkl-all@blackshift.org)
	by smtp.blackshift.org (Postfix) with ESMTPSA id 94F2D5E3E7A;
	Sun, 08 Nov 2026 20:47:37 +0000 (UTC)
From: Marc Kleine-Budde <mkl@pengutronix.de>
Date: Sun, 08 Nov 2026 21:47:27 +0100
Subject: [PATCH can-next v5 6/6] can: gs_usb: fix hardware timestamp state
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
Message-Id: <20261108-gs_usb-fixes-v5-6-d52dd4940d46@pengutronix.de>
References: <20261108-gs_usb-fixes-v5-0-d52dd4940d46@pengutronix.de>
In-Reply-To: <20261108-gs_usb-fixes-v5-0-d52dd4940d46@pengutronix.de>
To: Vincent Mailhol <mailhol@kernel.org>, Peter Fink <pfink@christ-es.de>, 
 Eric Evenchick <eric@evenchick.com>, 
 Maximilian Schneider <max@schneidersoft.net>, 
 Wolfgang Grandegger <wg@grandegger.com>
Cc: kernel@pengutronix.de, linux-can@vger.kernel.org, 
 linux-kernel@vger.kernel.org, Marc Kleine-Budde <mkl@pengutronix.de>, 
 Shuangpeng Bai <shuangpeng.kernel@gmail.com>, stable@vger.kernel.org, 
 Vadim Fedorenko <vadim.fedorenko@linux.dev>
X-Mailer: b4 0.17-dev-d7211
X-Developer-Signature: v=1; a=openpgp-sha256; l=7266; i=mkl@pengutronix.de;
 h=from:subject:message-id; bh=15D6A+wYsMELrLcjeR/HVfqy5tJq25C6wtGSMVX2xF0=;
 b=owGbwMvMwCV2xirl17qZay8xnlZLYsj6cP95s0ZBpJ7tQuX3UdPZdbo2nV+60jiDU4q9avpfg
 6w2mWvHO0pZGMS4GGTFFFmW/jihKBDoUNr7MmESzBxWJpAhDFycAjCRf1wM/2saPyf6BoVYdzsq
 1v9Tr2vUfrW7YM8y/VPvy3ucTMPM5Bn+l5rb8Ttv48qwnTr9Wu1ku5vhDgzBEmonln3Rl7+8dtd
 VfgA=
X-Developer-Key: i=mkl@pengutronix.de; a=openpgp;
 fpr=C1400BA0B3989E6FBC7D5B5C2B5EE211C58AEA54

From: Shuangpeng Bai <shuangpeng.kernel@gmail.com>

For hardware timestamping, the driver manages the
infrastructure (cyclecounter/timecounter) for the entire USB interface,
assuming that all channels share a common time base, even though each
channel individually indicates support for hardware timestamping via the
GS_CAN_FEATURE_HW_TIMESTAMP flag.

Currently both initialization and shutdown of the HW timestamping
infrastructure is tied to the flags of the first channel opened
respectively closed. This leads to problems if the first channel opened
doesn't have the timestamping feature, but the second channel has.

Keep the initialization of the HW timestamping infrastructure in
gs_usb_timestamp_init(), and move initial time init and the initial
scheduling of the delayed worker into gs_usb_timestamp_start().

Initialize the HW timestamping infrastructure in gs_usb_probe() using
gs_usb_timestamp_init() if at least one channel has the
GS_CAN_FEATURE_HW_TIMESTAMP flag set.

Extend the functions gs_usb_timestamp_start()/gs_usb_timestamp_stop()
to track the number of active timestamp channels. Enabling or disabling the
delayed worker prevents concurrent rescheduling while
gs_usb_timestamp_stop() is running.

Call gs_usb_timestamp_start()/gs_usb_timestamp_stop() based on the
channel's GS_CAN_FEATURE_HW_TIMESTAMP flag, rather than relying on the
number of active channels.

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
Changes in v4:
- switch to enable_delayed_work()/disable_delayed_work_sync()
- move starting from gs_usb_timestamp_init() into gs_usb_timestamp_start()
- polish ref-counting/locking
- Link to v3: https://patch.msgid.link/20260720184042.1712217-1-shuangpeng.kernel@gmail.com/

Changes in v3:
- Drop Suggested-by tag.
- Move active_timestamp_channels management into the timestamp init/stop
  helpers.
- Protect active_timestamp_channels with tc_lock, and keep it zero until
  timecounter_init() has completed.
- Make RX timestamp conversion and the delayed work skip the timecounter
  while no timestamp-capable channel is active.
- Initialize the shared timestamp lock and delayed work once during probe.

Changes in v2:
- Count active timestamp-capable channels instead of tracking only whether
  the shared timestamp worker has been started.
- Stop the shared timestamp worker when the last timestamp-capable channel
  closes, even if non-timestamp channels remain open.
- Unwind the timestamp-capable channel count on gs_can_open() failures.

---

Picking up Shuangpeng Bai's work, I've ported it on top of other fixes for
problems identified by sashiko.

Marc
---
 drivers/net/can/usb/gs_usb.c | 54 +++++++++++++++++++++++++++++++-------------
 1 file changed, 38 insertions(+), 16 deletions(-)

diff --git a/drivers/net/can/usb/gs_usb.c b/drivers/net/can/usb/gs_usb.c
index 6327069f63c9..0a1cd14c940c 100644
--- a/drivers/net/can/usb/gs_usb.c
+++ b/drivers/net/can/usb/gs_usb.c
@@ -337,6 +337,7 @@ struct gs_usb {
 
 	unsigned int hf_size_rx;
 	u8 active_channels;
+	u8 active_timestamp_channels;
 	u8 channel_cnt;
 
 	unsigned int pipe_in;
@@ -481,18 +482,35 @@ static void gs_usb_timestamp_init(struct gs_usb *parent)
 	cc->mult = clocksource_hz2mult(GS_USB_TIMESTAMP_TIMER_HZ, cc->shift);
 
 	spin_lock_init(&parent->tc_lock);
-	spin_lock_bh(&parent->tc_lock);
-	timecounter_init(&parent->tc, &parent->cc, ktime_get_real_ns());
-	spin_unlock_bh(&parent->tc_lock);
 
 	INIT_DELAYED_WORK(&parent->timestamp, gs_usb_timestamp_work);
+	disable_delayed_work(&parent->timestamp);
+}
+
+static void gs_usb_timestamp_start(struct gs_usb *parent)
+{
+	scoped_guard(spinlock_bh, &parent->tc_lock) {
+		parent->active_timestamp_channels++;
+		if (parent->active_timestamp_channels > 1)
+			return;
+
+		timecounter_init(&parent->tc, &parent->cc, ktime_get_real_ns());
+	}
+
+	enable_delayed_work(&parent->timestamp);
 	schedule_delayed_work(&parent->timestamp,
 			      GS_USB_TIMESTAMP_WORK_DELAY_SEC * HZ);
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
@@ -988,10 +1006,10 @@ static int gs_can_open(struct net_device *netdev)
 
 	can_rx_offload_enable(&dev->offload);
 
-	if (!parent->active_channels) {
-		if (dev->feature & GS_CAN_FEATURE_HW_TIMESTAMP)
-			gs_usb_timestamp_init(parent);
+	if (dev->feature & GS_CAN_FEATURE_HW_TIMESTAMP)
+		gs_usb_timestamp_start(parent);
 
+	if (!parent->active_channels) {
 		for (i = 0; i < GS_MAX_RX_URBS; i++) {
 			u8 *buf;
 
@@ -1102,12 +1120,10 @@ static int gs_can_open(struct net_device *netdev)
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
+	if (dev->feature & GS_CAN_FEATURE_HW_TIMESTAMP)
+		gs_usb_timestamp_stop(parent);
 
 	can_rx_offload_disable(&dev->offload);
 	close_candev(netdev);
@@ -1160,12 +1176,11 @@ static int gs_can_close(struct net_device *netdev)
 
 	/* Stop polling */
 	parent->active_channels--;
-	if (!parent->active_channels) {
+	if (!parent->active_channels)
 		usb_kill_anchored_urbs(&parent->rx_submitted);
 
-		if (dev->feature & GS_CAN_FEATURE_HW_TIMESTAMP)
-			gs_usb_timestamp_stop(parent);
-	}
+	if (dev->feature & GS_CAN_FEATURE_HW_TIMESTAMP)
+		gs_usb_timestamp_stop(parent);
 
 	/* Stop sending URBs */
 	usb_kill_anchored_urbs(&dev->tx_submitted);
@@ -1526,6 +1541,7 @@ static int gs_usb_probe(struct usb_interface *intf,
 	};
 	struct gs_device_config dconf;
 	unsigned int icount, i;
+	bool ts_supported;
 	int rc;
 
 	rc = usb_find_common_endpoints(intf->cur_altsetting,
@@ -1599,6 +1615,9 @@ static int gs_usb_probe(struct usb_interface *intf,
 		parent->canch[i] = dev;
 		parent->canch[i]->parent = parent;
 
+		if (parent->canch[i]->feature & GS_CAN_FEATURE_HW_TIMESTAMP)
+			ts_supported = true;
+
 		/* set RX packet size based on FD and if hardware
 		 * timestamps are supported.
 		 */
@@ -1616,6 +1635,9 @@ static int gs_usb_probe(struct usb_interface *intf,
 		parent->hf_size_rx = max(parent->hf_size_rx, hf_size_rx);
 	}
 
+	if (ts_supported)
+		gs_usb_timestamp_init(parent);
+
 	for (i = 0; i < icount; i++) {
 		struct gs_can *dev = parent->canch[i];
 

-- 
2.53.0

