Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 581432561A2;
	Thu, 15 Oct 2026 05:39:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792042754; cv=none; b=Hk/qu2HRXxubPrvuya3oDeELZW4UFxMezSis9C9OKFqmKf0JjLLxhlud21WP++LvvYcjlW5kAkjuDzHGSxlWguGx56G7A2EL/JajNZJDZjTb2Mk/GLBH1YqSzeYetxsFM9AB5YXbMgS887/mhQ/JIX9nKt+1huGEBT26ScTk2NI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792042754; c=relaxed/simple;
	bh=AgR2linT6h6dXKgUQ5agGAs0DYjDGca+poQtrxWEcX8=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=Ph7VGAazrgSqhY84yPc5JEgMh3gIYqnBlrORBdCuaDa8LPZ6HDLhlfGWch8vjpK5BNOzsfl0jP8v043VNpGAKw2oRt5EOvubYolEKbM8PYxmKPvmmjd1FbXhRDnQGLuoTknUDNdc9PI+MUo3tPgiXonzkduVcrAodxD8EGEfk+c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=YRn/XSMq; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="YRn/XSMq"
Received: by smtp.kernel.org (Postfix) with ESMTPS id 1BD22C2BD01;
	Thu, 15 Oct 2026 05:39:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1792042754;
	bh=AgR2linT6h6dXKgUQ5agGAs0DYjDGca+poQtrxWEcX8=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=YRn/XSMq7k9sQpJ0dfyUAnrKr+EHvPaxXfGXiXja48Cru14ndH27zT7OQ9dqQN7pG
	 ffG2r8d6iRbolMraLXdkMzU4Ou9ur/PF7gzpWJwsXvWF48rENsAiQ+8vMSK060NanZ
	 x5W+Ibu8ewApuvT3gSgQgnxuglt3kYhd86vndqQ8moVO9C2PqQZ1tRbc6uKw1X6he2
	 AWeUsfCwjhQ2jLHDCLqfUx4FdyEcSJwLcjgNLL7EnMCBNjLMjikgq+GKYXTkWmQZ49
	 F+d4XZRLsUWz2zsE41khdDMwJpLj5FtCKpxs+cME9rvl3m/kwtBUz+0m+cXYXcHwPM
	 wh2gMTLgY2Bhw==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0ABE0CC6B34;
	Thu, 15 Oct 2026 05:39:14 +0000 (UTC)
From: Cunhao Lu via B4 Relay <devnull+1579567540.qq.com@kernel.org>
Date: Thu, 15 Oct 2026 13:38:58 +0800
Subject: [PATCH net v4 4/6] can: rockchip_canfd: prevent timestamp work
 from rearming after bus-off
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261015-rockchip-canfd-restart-close-v4-4-ad149ff79450@qq.com>
References: <20261015-rockchip-canfd-restart-close-v4-0-ad149ff79450@qq.com>
In-Reply-To: <20261015-rockchip-canfd-restart-close-v4-0-ad149ff79450@qq.com>
To: Marc Kleine-Budde <mkl@pengutronix.de>, 
 Vincent Mailhol <mailhol@kernel.org>, Heiko Stuebner <heiko@sntech.de>, 
 "David S. Miller" <davem@davemloft.net>, 
 Wolfgang Grandegger <wg@grandegger.com>, 
 Oliver Hartkopp <socketcan@hartkopp.net>, kernel@pengutronix.de
Cc: linux-can@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-arm-kernel@lists.infradead.org, linux-rockchip@lists.infradead.org, 
 stable@vger.kernel.org, Cunhao Lu <1579567540@qq.com>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1792042751; l=4366;
 i=1579567540@qq.com; s=20261015; h=from:subject:message-id;
 bh=L729iyLZPqYSYXdNKiWcUHyKMxTpCJWqzC68GEcr5dM=;
 b=eFw8VPP13CEgx0npGx94Af2ONNMcfYkUjWInOJEd4I/ePdGgTWGKVbA18RIo9Hm2X6ioHsZYe
 I6rfu/zT03PAEzPcrVM0zlbrMqA71t9A4IN4dDBrK9vBZoor33RptmC
X-Developer-Key: i=1579567540@qq.com; a=ed25519;
 pk=sUTWrzlIwT4C7ctjNfVZAzzg0G7QUn2XxRGpYsw4RtM=
X-Endpoint-Received: by B4 Relay for 1579567540@qq.com/20261015 with
 auth_id=1177
X-Original-From: Cunhao Lu <1579567540@qq.com>
Reply-To: 1579567540@qq.com

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
 drivers/net/can/rockchip/rockchip_canfd.h          |  4 +++
 2 files changed, 34 insertions(+), 4 deletions(-)

diff --git a/drivers/net/can/rockchip/rockchip_canfd-timestamp.c b/drivers/net/can/rockchip/rockchip_canfd-timestamp.c
index ad582afbbd68..0fa791849c95 100644
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
+		/* Serialize requeueing with timestamp_stop(). */
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
index e1debab54534..2743c96ed42f 100644
--- a/drivers/net/can/rockchip/rockchip_canfd.h
+++ b/drivers/net/can/rockchip/rockchip_canfd.h
@@ -15,6 +15,7 @@
 #include <linux/netdevice.h>
 #include <linux/reset.h>
 #include <linux/skbuff.h>
+#include <linux/spinlock.h>
 #include <linux/timecounter.h>
 #include <linux/types.h>
 #include <linux/u64_stats_sync.h>
@@ -485,8 +486,11 @@ struct rkcanfd_priv {
 
 	struct cyclecounter cc;
 	struct timecounter tc;
+	/* Protects timestamp_active and worker reads/requeueing. */
+	spinlock_t timestamp_lock;
 	struct delayed_work timestamp;
 	unsigned long work_delay_jiffies;
+	bool timestamp_active;
 
 	struct can_berr_counter bec;
 

-- 
2.34.1


