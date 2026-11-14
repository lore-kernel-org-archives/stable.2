Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=185.203.200.13
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1794669480;
	b=Le0IlRN6qWMQZxzlUNsakWI62yWFWX9bcVixuLXoszq5TdEduhIps0uu64GUGan7n8dS
	 8+iqEe2/98kWlATbff3dvWVN3IkAOVkY/mAeH6rjUpwWe3AuawlDiARkIb2Axg+lHDFXf
	 45r+Bhtea57L2gNWtJebb31JnJ/oFShRnNURQ8j8fXASBdiRgmkzseZb484Vb5ObNgQr9
	 RT3TPhZ9pznZZlKT88Wj2edT1QGCSaeqATA5TGKDuj2nv5VHAuo96OWjJhrqK9UF3cHrm
	 DKcAeJZ2E+Vmmnpf/ppusa2nTuYNgODRdOYDMrZHF/4L0AF+dh7iCBz+JGXTx7pCVKw==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794669480;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Received:From:Date:
	 Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:
	 Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key;
	bh=6gn9iLC6He441DbMRUw4suSWUmSlQYDunemppUn0K8w=;
	b=brdKiPBS9C1pbPwW3EAZu3E12BHzaRteQCps1KLL8pO0k4PTWchZ8qZ4XH/We8oH9n5G
	 peJ0mPeziLvnevrS10F5KmgppITcyclptqIg4mADTWthRRA0e9k79ehSdbma/wx1HGRiK
	 EBm1R/8JBax35hUsd5nNNZXvjFsR3b7CQczMCO/RX48gj5Fqx6B+ogPN3Irbnu+UFCcrW
	 4EV8ftGnAzH9m10EPEgrhdxieQZYTqL8T9HCS9A+DnzA2bL6hFhNCGkxYMlaFe5tClxdf
	 Z/8hhePDvtnTYQEsYEfFpfMK+7Vy7bh/KjvWbHiwQFFnyBpFJS8We5YufKyLoRlukgw==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=none header.from=pengutronix.de;
	spf=pass smtp.mailfrom=pengutronix.de;
	dkim=pass header.d=pengutronix.de header.i=@pengutronix.de header.a=rsa-sha256 header.s=20260414 header.b=BJ8T9K7X;
	arc=pass header.oldest-pass=0 smtp.remote-ip=185.203.200.13
Received: from mx1.white.stw.pengutronix.de (mx1.white.stw.pengutronix.de [185.203.200.13])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7A290606A8BB;
	Sat, 14 Nov 2026 15:17:59 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 7A290606A8BB
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pengutronix.de header.i=@pengutronix.de header.a=rsa-sha256 header.s=20260414 header.b=BJ8T9K7X
Received: from drehscheibe.grey.stw.pengutronix.de (drehscheibe.grey.stw.pengutronix.de [IPv6:2a0a:edc0:0:c01:1d::a2])
	(Authenticated sender: relay-from-drehscheibe.grey.stw.pengutronix.de)
	by mx1.white.stw.pengutronix.de (Postfix) with ESMTPSA id 80AB4202341;
	Sat, 14 Nov 2026 16:17:54 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pengutronix.de;
	s=20260414; t=1794669474;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=6gn9iLC6He441DbMRUw4suSWUmSlQYDunemppUn0K8w=;
	b=BJ8T9K7XJwphsGxnNZPd3Okr/6G+IUC1bytxGcoFH1YF9Z2aaJx0VO84CEJL3YN/UGPIhn
	7wWhLAiH2monHN5O/sQ4rRNRi3DYNA8qETrVgi/vTopxqxaPZpR9rtc/L2Eme5YToptc+T
	M2dUnu8EkxWExk9e8PfZZXbfIPaKCfL+QhDIuhd5YZvmfPEXAMYqvKkMPGVTQiFG9uKEGh
	oyk8v2fzO47dz3goKs0CU5I6SvVQLF6hn/DEuaOpE85zS7S5o23xm5U0bjbtDutp9s1xXR
	bNqTQdHKJXfvYpRKaMUItT+YpZA3w0sv5LMsiHhnE0B1ZF9cjKThFBXBs7SuoQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=pengutronix.de;
	s=20260414; t=1794669474;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=6gn9iLC6He441DbMRUw4suSWUmSlQYDunemppUn0K8w=;
	b=Y+TC1Oo9iL/Oa9OSsUHJOakWqSNsoG9gn+1E2yjf2ZMxtm8MFj8FpbYWKhcMcsnzB8/VNX
	bzmzqUcF0FSaC5/v95HNSUVWV2r/79h8aH1xanAceB88WQOJbA0jbp4vTwBMEhf0NG2fLC
	dFbQQVJ24qluzefO7eow7FOk4GYUdhK80ma83gNbLO+14DPlq3A2Ia/3A860GL6GG8N5xz
	wbquzCqV/bkZxXHr5pnglkvQmyj0RSfOQmdhqiBbXN83T2XD/hGHleIcgu1SE2gAy9hRiY
	+snLvd6EeK5/5NCqGDsKPlzLQgvtima9WqbyFwJV43z6dOsQmV7d6feK9HkdyQ==
ARC-Seal: i=1; s=20260414; d=pengutronix.de; t=1794669474; a=rsa-sha256;
	cv=none;
	b=G4W14rTqdDOIwwigwj6FDp+gbI/WXSWQtila6LA13V/Bkx4Xa8yiuQx6bVvZQan5pkHeuP
	Kd7kikL8KDcxccNDrrTGJjLelS/Bc0dL3NlKpfd/2TBa55l1V99pG1qD1GzQDnFC71vUPY
	m5qCJeyBrcmMf4NO31zZW2dlo0o8BV8o3OxsmEpH4DbcJgA0JZt/AlwpNRK5BimL8iC+9O
	cwTO3gufeMN7J6VzBaF9AY6Jg+6gndv9GbK/lqr9JDCg18TzFGevrCAqQam95qePCz8DB5
	IHPgjN/KaeqqFA62tfNKlCF14IGBd1ZpCWQwwA0SoRUgs0S7clnmIef868Z4YQ==
ARC-Authentication-Results: i=1;
	ORIGINATING;
	auth=pass smtp.auth=relay-from-drehscheibe.grey.stw.pengutronix.de smtp.mailfrom=mkl@pengutronix.de
Received: from moin.white.stw.pengutronix.de ([2a0a:edc0:0:b01:1d::7b] helo=bjornoya.blackshift.org)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <mkl@pengutronix.de>)
	id 1xSFVq-0049oI-1J;
	Sat, 14 Nov 2026 16:17:54 +0100
Received: from hardanger.blackshift.org (p4ffb23c7.dip0.t-ipconnect.de [79.251.35.199])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519MLKEM768 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(Client did not present a certificate)
	(Authenticated sender: mkl-all@blackshift.org)
	by smtp.blackshift.org (Postfix) with ESMTPSA id 20DE85EBB33;
	Sat, 14 Nov 2026 15:17:54 +0000 (UTC)
From: Marc Kleine-Budde <mkl@pengutronix.de>
Date: Sat, 14 Nov 2026 16:17:44 +0100
Subject: [PATCH can-next v7 5/6] can: gs_usb: fix hardware timestamp state
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
Message-Id: <20261114-gs_usb-fixes-v7-5-58b6341b1c08@pengutronix.de>
References: <20261114-gs_usb-fixes-v7-0-58b6341b1c08@pengutronix.de>
In-Reply-To: <20261114-gs_usb-fixes-v7-0-58b6341b1c08@pengutronix.de>
To: Vincent Mailhol <mailhol@kernel.org>, Peter Fink <pfink@christ-es.de>, 
 Eric Evenchick <eric@evenchick.com>, 
 Maximilian Schneider <max@schneidersoft.net>, 
 Wolfgang Grandegger <wg@grandegger.com>
Cc: kernel@pengutronix.de, linux-can@vger.kernel.org, 
 linux-kernel@vger.kernel.org, Marc Kleine-Budde <mkl@pengutronix.de>, 
 Shuangpeng Bai <shuangpeng.kernel@gmail.com>, stable@vger.kernel.org, 
 Vadim Fedorenko <vadim.fedorenko@linux.dev>
X-Mailer: b4 0.17-dev-d7211
X-Developer-Signature: v=1; a=openpgp-sha256; l=8122; i=mkl@pengutronix.de;
 h=from:subject:message-id; bh=FbFNNyOAyHTYopNO5bT2mkd26uVibD81e24FsKcrRUc=;
 b=owGbwMvMwCV2xirl17qZay8xnlZLYsj6UT0vSzSQVXFJ2fk/E9+VXaxubV0lxpB9W7bwvfvT+
 OAbK1uvdJSyMIhxMciKKbIs/XFCUSDQobT3ZcIkmDmsTCBDGLg4BWAibTMZGaa41l/VYsxhyLW4
 sL68ymWuvMdB/S15Z88t5mv13jNxRgvD/6S2YwH6k+JPPm04xvthZhT34xec/Tts5z1evv2xz94
 ENx4A
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

To simplify backporting, this change is not yet implemented in this patch,
but the next patch will switch to the new {enable,disable}_delayed_work()
API to avoid self-rescheduling the timestamp worker.

That API has been added with v6.10, commit 86898fa6b8cd ("workqueue:
Implement disable/enable for (delayed) work items").

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
 drivers/net/can/usb/gs_usb.c | 79 ++++++++++++++++++++++++++++++++++++++------
 1 file changed, 68 insertions(+), 11 deletions(-)

diff --git a/drivers/net/can/usb/gs_usb.c b/drivers/net/can/usb/gs_usb.c
index 980c4a748c94..b7780a23eff3 100644
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
@@ -405,6 +411,7 @@ static int gs_cmd_reset(struct gs_can *dev)
 
 static inline int gs_usb_get_timestamp(const struct gs_usb *parent,
 				       u32 *timestamp_p)
+	__must_not_hold(parent->tc_lock)
 {
 	__le32 timestamp;
 	int rc;
@@ -423,7 +430,16 @@ static inline int gs_usb_get_timestamp(const struct gs_usb *parent,
 	return 0;
 }
 
-static u64 gs_usb_timestamp_read(struct cyclecounter *cc) __must_hold(&dev->tc_lock)
+static u64 gs_usb_timestamp_read_initial(struct cyclecounter *cc)
+	__must_hold(&container_of(cc, struct gs_usb, cc)->tc_lock)
+{
+	const struct gs_usb *parent = container_of(cc, struct gs_usb, cc);
+
+	return parent->timestamp_initial;
+}
+
+static u64 gs_usb_timestamp_read(struct cyclecounter *cc)
+	__must_hold(&container_of(cc, struct gs_usb, cc)->tc_lock)
 {
 	struct gs_usb *parent = container_of(cc, struct gs_usb, cc);
 	u32 timestamp = 0;
@@ -475,19 +491,44 @@ static void gs_usb_timestamp_init(struct gs_usb *parent)
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
@@ -988,9 +1029,15 @@ static int gs_can_open(struct net_device *netdev)
 
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
@@ -1105,10 +1152,10 @@ static int gs_can_open(struct net_device *netdev)
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
 
@@ -1158,12 +1205,15 @@ static int gs_can_close(struct net_device *netdev)
 
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
 
@@ -1525,6 +1575,7 @@ static int gs_usb_probe(struct usb_interface *intf,
 		.byte_order = cpu_to_le32(0x0000beef),
 	};
 	struct gs_device_config dconf;
+	bool hw_ts_supported = false;
 	unsigned int icount, i;
 	int rc;
 
@@ -1599,6 +1650,9 @@ static int gs_usb_probe(struct usb_interface *intf,
 		parent->canch[i] = dev;
 		parent->canch[i]->parent = parent;
 
+		if (parent->canch[i]->feature & GS_CAN_FEATURE_HW_TIMESTAMP)
+			hw_ts_supported = true;
+
 		/* set RX packet size based on FD and if hardware
 		 * timestamps are supported.
 		 */
@@ -1616,6 +1670,9 @@ static int gs_usb_probe(struct usb_interface *intf,
 		parent->hf_size_rx = max(parent->hf_size_rx, hf_size_rx);
 	}
 
+	if (hw_ts_supported)
+		gs_usb_timestamp_init(parent);
+
 	for (i = 0; i < icount; i++) {
 		struct gs_can *dev = parent->canch[i];
 

-- 
2.53.0

