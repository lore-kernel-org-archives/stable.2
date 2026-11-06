Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1793957856;
	b=BbMUeH1kqV2OXKpogWTu1UMToQNUiA24X5q/oKoOtEWnu4oRipr5FMKflBbAv10/9ErM
	 6bjC+CgejtFJ4xyBHhPUupCN0akAQUUtEdUPBF/bxovEEiwNQ6OexGk2YmSRHAA0YI1g0
	 GAWxpScVTo3QjHW5oPAg+a+B7lPvs15bC9T7stbO+y3J+J4RM+/Trp0Ugg/qog/Rpi9pv
	 rsARg6T7PVdSDXFMmZyQPUPHWsd5MHMIGUQre2YQXD6lhiePKlf1xUFeiRKWeyvUoTYjz
	 kt737Veqzp08GPXrH6CpmPP6Pgwcg6Nu+lJ+hBGnDARPi3OnujPuJhgfCTo/6xwmc+A==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793957856;
	h=Received:DKIM-Signature:Received:From:Date:Subject:MIME-Version:
	 Content-Type:Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
	 X-Original-From:Reply-To:Content-Transfer-Encoding;
	bh=eq9e5/JVOIYpfaf2X6q2/pV4dCFq8e5rt1cZux4duCo=;
	b=XUb12yGC6K2iNP33B5n7vJ6jn9IPgZB3gCW/5zV0UWFZ2xg7kna5csbQpXMlkMXz+r6L
	 F1yW6PJ6mE8r7EdUWnXc+0WQfa8lqDvcv8dqh2nSlFhadc46PQHJVlmmkjRNMQ0f/UKc4
	 O2dUKVGsavdvE01d4QHjLHdf34iDgUFExwzkl44yYuN7W6we0DlCkRuyFZIiS0qjRwJbF
	 T5nk64ou7SDm18+ET8PvjSBQeSgW/LkfhUXyov+4g1nV8wy7wXarekqroVwZenLUFrIxE
	 Pbrhm2A6au0GM8ZWMzsPNCAH5J6vamjTDJr763dWvyStFRbOc61PAMoMUA1vJtPni2g==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=cr6ejxUv;
	arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1C0706077CDC;
	Fri,  6 Nov 2026 09:37:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=cr6ejxUv
Authentication-Results: smtp.kernel.org; arc=none smtp.remote-ip=100.80.115.77
ARC-Seal: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256; cv=none;
	t=1793957856;
	b=VPjVMP6hDoEa9F+Qm6en2ASZnE3B+fD9nF/d180BFyoGrss1jWaF7d0lyJK0M7l+IAZU
	 Y9AExoTKtPUQkepYxF6zxR+gJE4lTCSqvJoDj+LDGDlnvUu2yQoJQHPhCUOmjSW1VI6eL
	 Fxf5BoDBVbrmpFCRMnTdH7wgWTLZzyZBlkzgy6cD6GJVBPWa0S66ge7Y3Zqk8ABwhwz60
	 KZF54Ah3wj3ESGGwHeok1gu/TyHbms0hkCVcorQbuC6M+kYviRzJCEap6VKVJrzYr6wzo
	 eiALr3qrb2z5YX5x0exO5VaxPCpTGABIIllCPOa/umPolUs6xEW9SrpJXYrm0wrhTJg==
ARC-Message-Signature: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256;
	c=relaxed/relaxed; t=1793957856;
	h=DKIM-Signature:Received:From:Date:Subject:MIME-Version:Content-Type:
	 Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
	 X-Original-From:Reply-To:Content-Transfer-Encoding;
	bh=eq9e5/JVOIYpfaf2X6q2/pV4dCFq8e5rt1cZux4duCo=;
	b=lYj3h8TqukePkczZBaxr0o3i/j7ofECs37NFnTf0LpgX1xm4XsB7OTnSWTH9P08f85jK
	 B8l7JuW7OO/27ZhD10IaFGnmPL+qqfg3BvW032i3842STC75uig084Es605eYsRblLsWM
	 za/Sepm2FnLaksDHoc1WNtPpNef/Ywjh2Po46DvhQR4b1GAMMbwwdkkfsVgyggkrGzo+7
	 FuVKnVidxGsrJ5aKQ0XKZups+lVN0BzRri3BPipL50CTuO6yOX41qbEFEAqifc7wtI2xq
	 ON+2gtCpMEGOZKv4fDZLtoHEe1PBveftsR5AFYf9S0u3d+Zx5PlqYyHyQp4a5icMMTw==
ARC-Authentication-Results: i=1; smtp.kernel.org; 
	arc=none smtp.remote-ip=100.80.115.77
Received: from lkml.kernel.org (nexus.subspace.kernel.org [100.80.115.77])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.kernel.org (Postfix) with ESMTPS id 34F701F0092F;
	Fri,  6 Nov 2026 09:37:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793957856;
	bh=eq9e5/JVOIYpfaf2X6q2/pV4dCFq8e5rt1cZux4duCo=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To;
	b=cr6ejxUvFAj+PEJpiaBAQRaCzZgbRWmYiZpg11CgLT/aK+ja2grnP/L/3r2e3JLdd
	 b+WV3vTwITstZ2qZaXSS8XwNvaE2x8DQuK6xh9hrO5puR+qvVGmDp/9cXOAGHxvaxj
	 Z83TFzmH0iNbYh4lKr0qvQs5aMnUGGjq1G1UteFZETwBjRD6z5JfCU2YtzaQjMsP9R
	 krwUSlkLJfdzZdkW/2VnQnhcf/BP2/3KSJwvUOYAnCCUDVh1mhJtK+jijMX3C2vaOC
	 rnxYEKENhX/6Q/PXghzsLPBkEvqcDToZ5Dg+cQ4L+SkCsaEXwCqN/ugeO0bqvertG1
	 sWuTijU9IFp9g==
Received: from nexus.subspace.kernel.org (localhost [IPv6:::1])
	by lkml.kernel.org (Postfix) with ESMTP id AACD645CBC;
	Fri,  6 Nov 2026 09:37:33 +0000 (UTC)
From: Cunhao Lu via B4 Relay <devnull+1579567540.qq.com@kernel.org>
Date: Fri, 06 Nov 2026 17:37:25 +0800
Subject: [PATCH net v7 6/7] can: rockchip_canfd: prevent timestamp work
 from rearming after bus-off
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
Message-Id: <20261106-rockchip-canfd-restart-close-v7-6-accdb11bc845@qq.com>
References: <20261106-rockchip-canfd-restart-close-v7-0-accdb11bc845@qq.com>
In-Reply-To: <20261106-rockchip-canfd-restart-close-v7-0-accdb11bc845@qq.com>
To: Marc Kleine-Budde <mkl@pengutronix.de>, 
 Vincent Mailhol <mailhol@kernel.org>, Heiko Stuebner <heiko@sntech.de>, 
 "David S. Miller" <davem@davemloft.net>, 
 Wolfgang Grandegger <wg@grandegger.com>, 
 Oliver Hartkopp <socketcan@hartkopp.net>, kernel@pengutronix.de, 
 Eric Dumazet <edumazet@kernel.org>, Jakub Kicinski <kuba@kernel.org>, 
 Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, 
 Jonathan Corbet <corbet@lwn.net>, Shuah Khan <skhan@linuxfoundation.org>, 
 Randy Dunlap <rdunlap@infradead.org>
Cc: Cunhao Lu <1579567540@qq.com>, linux-can@vger.kernel.org, 
 linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
 linux-rockchip@lists.infradead.org, netdev@vger.kernel.org, 
 linux-doc@vger.kernel.org, stable@vger.kernel.org
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1793957851; l=4333;
 i=1579567540@qq.com; s=20261015; h=from:subject:message-id;
 bh=SOO163gzYNYZNP6n4OTUiW0fL5Doo8hMgGkDjKR3yOc=;
 b=v3Eb7AUU44S2vzABSrZSahv4Srx7OImuvmgWdoBAG80QO1eryPiddCh3E8WUHp6CW8STytDri
 DG2BDSs0K0+DlfqXpyKl3XgALPg6Z1ljFV8hLT2xEoeeiPjGKAfLZ1h
X-Developer-Key: i=1579567540@qq.com; a=ed25519;
 pk=sUTWrzlIwT4C7ctjNfVZAzzg0G7QUn2XxRGpYsw4RtM=
X-Endpoint-Received: by B4 Relay for 1579567540@qq.com/20261015 with
 auth_id=1177
X-Original-From: Cunhao Lu <1579567540@qq.com>
Reply-To: 1579567540@qq.com
Content-Transfer-Encoding: 7bit

From: Cunhao Lu <1579567540@qq.com>

The bus-off IRQ cancels timestamp work asynchronously. If the worker
is already running, it can requeue itself after cancellation and keep
polling while the controller remains bus-off.

Add a dedicated lock and an active flag, initialized once at probe.
Serialize the worker's active check, counter read and self-requeue with
start and stop. Clear the flag under the lock before cancelling work
so no worker can read the counter or rearm after deactivation. Enable
the flag and schedule the initial work under the same lock at start.

Keep both cancellation calls outside the lock so synchronous stop can
wait for the worker to finish.

Fixes: 4e1a18bab124 ("can: rockchip_canfd: add hardware timestamping support")
Cc: stable@vger.kernel.org
Signed-off-by: Cunhao Lu <1579567540@qq.com>
---
 .../net/can/rockchip/rockchip_canfd-timestamp.c    | 34 +++++++++++++++++++---
 drivers/net/can/rockchip/rockchip_canfd.h          |  3 ++
 2 files changed, 33 insertions(+), 4 deletions(-)

diff --git a/drivers/net/can/rockchip/rockchip_canfd-timestamp.c b/drivers/net/can/rockchip/rockchip_canfd-timestamp.c
index ad582afbbd68..1d2a122770dc 100644
--- a/drivers/net/can/rockchip/rockchip_canfd-timestamp.c
+++ b/drivers/net/can/rockchip/rockchip_canfd-timestamp.c
@@ -30,18 +30,27 @@ static void rkcanfd_timestamp_work(struct work_struct *work)
 {
 	const struct delayed_work *delayed_work = to_delayed_work(work);
 	struct rkcanfd_priv *priv;
+	unsigned long flags;
 
 	priv = container_of(delayed_work, struct rkcanfd_priv, timestamp);
-	timecounter_read(&priv->tc);
-
-	schedule_delayed_work(&priv->timestamp, priv->work_delay_jiffies);
+	spin_lock_irqsave(&priv->timestamp_lock, flags);
+	if (priv->timestamp_active) {
+		timecounter_read(&priv->tc);
+
+		/* Serialize requeueing with timestamp deactivation. */
+		schedule_delayed_work(&priv->timestamp, priv->work_delay_jiffies);
+	}
+	spin_unlock_irqrestore(&priv->timestamp_lock, flags);
 }
 
 void rkcanfd_timestamp_work_init(struct rkcanfd_priv *priv)
 {
+	spin_lock_init(&priv->timestamp_lock);
+	priv->timestamp_active = false;
 	INIT_DELAYED_WORK(&priv->timestamp, rkcanfd_timestamp_work);
 }
 
+/* The caller must quiesce IRQs and timestamp work before reconfiguration. */
 void rkcanfd_timestamp_init(struct rkcanfd_priv *priv)
 {
 	const struct can_bittiming *dbt = &priv->can.fd.data_bittiming;
@@ -93,17 +102,34 @@ void rkcanfd_timestamp_init(struct rkcanfd_priv *priv)
 
 void rkcanfd_timestamp_start(struct rkcanfd_priv *priv)
 {
-	timecounter_init(&priv->tc, &priv->cc, ktime_get_real_ns());
+	unsigned long flags;
 
+	spin_lock_irqsave(&priv->timestamp_lock, flags);
+	timecounter_init(&priv->tc, &priv->cc, ktime_get_real_ns());
+	priv->timestamp_active = true;
 	schedule_delayed_work(&priv->timestamp, priv->work_delay_jiffies);
+	spin_unlock_irqrestore(&priv->timestamp_lock, flags);
 }
 
 void rkcanfd_timestamp_stop(struct rkcanfd_priv *priv)
 {
+	unsigned long flags;
+
+	spin_lock_irqsave(&priv->timestamp_lock, flags);
+	priv->timestamp_active = false;
+	spin_unlock_irqrestore(&priv->timestamp_lock, flags);
+
 	cancel_delayed_work(&priv->timestamp);
 }
 
 void rkcanfd_timestamp_stop_sync(struct rkcanfd_priv *priv)
 {
+	unsigned long flags;
+
+	spin_lock_irqsave(&priv->timestamp_lock, flags);
+	priv->timestamp_active = false;
+	spin_unlock_irqrestore(&priv->timestamp_lock, flags);
+
+	/* The worker needs timestamp_lock to finish. */
 	cancel_delayed_work_sync(&priv->timestamp);
 }
diff --git a/drivers/net/can/rockchip/rockchip_canfd.h b/drivers/net/can/rockchip/rockchip_canfd.h
index 3664124a8da2..078876769a05 100644
--- a/drivers/net/can/rockchip/rockchip_canfd.h
+++ b/drivers/net/can/rockchip/rockchip_canfd.h
@@ -477,6 +477,8 @@ struct rkcanfd_priv {
 
 	/* Serialize TX submission/completion with bus-off and restart. */
 	spinlock_t tx_lock;
+	/* Protects timestamp_active and worker reads/requeueing. */
+	spinlock_t timestamp_lock;
 	void __iomem *regs;
 	unsigned int tx_head;
 	unsigned int tx_tail;
@@ -485,6 +487,7 @@ struct rkcanfd_priv {
 	u32 reg_int_mask_default;
 	bool tx_enabled;
 	bool irq_suspended;
+	bool timestamp_active;
 	struct rkcanfd_devtype_data devtype_data;
 
 	struct cyclecounter cc;

-- 
2.34.1


