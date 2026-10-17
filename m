Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 73EAB394797;
	Sat, 17 Oct 2026 14:50:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792248656; cv=none; b=HjeTVtgDKe35Zl3668ZbrNp4hC0aYEMwqjQIjBrlUDRuUl/B2oPH18Wr42CD7LeuGyJNsfPMWq/PmZtK7dLa+N/qESAjoFa9mtxwBmW6XJ24adLEC1vWDccg0C4JcwdFzja6q2cxkqsZEeluHBCg0lamRzScBZAihrrIWFSNOuY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792248656; c=relaxed/simple;
	bh=AgR2linT6h6dXKgUQ5agGAs0DYjDGca+poQtrxWEcX8=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=ncXjsw/zaw2f8qNsD4N8cYYNJJJrEPxmPMueax5nfA2vBQsZNut+NTQbG3GW6dGHjlxAKFh7Ak6VFlCKOey0mQCLxLx8/gva8tmHxX/DhgIfCB7PWhBII5+hiH9AKezmaUnpHXSqMnB6mkSTCNhwVODMkg9xWGmgIC7DaVtE8nI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=autH7ykW; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="autH7ykW"
Received: by smtp.kernel.org (Postfix) with ESMTPS id 411EEC32782;
	Sat, 17 Oct 2026 14:50:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1792248656;
	bh=AgR2linT6h6dXKgUQ5agGAs0DYjDGca+poQtrxWEcX8=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=autH7ykWjxRtT6SLnU0NLMkGoX/kK9+71AIC225bVXh51Y6/BJzzDj3FotFxXxXVX
	 JFJztIUIuycU9EY+nYCJPb/mfi860zEHJsQgtGaiu9IbycDdMYft//DXqGd7WrEVBH
	 teOp9KI38rQrmUyf00Bllt0J/nAWPZ8eU+n2L2mfEPpR9ff649x0a3fxvVRZ4FAObg
	 HwQilluPn0QowvzcvyLfh17i1wTsF16xjz16vgYePVnjCkClStoMiaFf8dqBNiuGR6
	 qpyV8JUf0dcFYr9ztIQ8d8r0OrJeONxvJQ34KRxIsWpdS7i1jLGEHM/Y+qsGjwaQyT
	 w3CBKiPf+UPwg==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 27F98CCF2C4;
	Sat, 17 Oct 2026 14:50:56 +0000 (UTC)
From: Cunhao Lu via B4 Relay <devnull+1579567540.qq.com@kernel.org>
Date: Sat, 17 Oct 2026 22:50:54 +0800
Subject: [PATCH net v6 4/6] can: rockchip_canfd: prevent timestamp work
 from rearming after bus-off
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261017-rockchip-canfd-restart-close-v6-4-ed605feb4b6e@qq.com>
References: <20261017-rockchip-canfd-restart-close-v6-0-ed605feb4b6e@qq.com>
In-Reply-To: <20261017-rockchip-canfd-restart-close-v6-0-ed605feb4b6e@qq.com>
To: Marc Kleine-Budde <mkl@pengutronix.de>, 
 Vincent Mailhol <mailhol@kernel.org>, Heiko Stuebner <heiko@sntech.de>, 
 "David S. Miller" <davem@davemloft.net>, 
 Wolfgang Grandegger <wg@grandegger.com>, 
 Oliver Hartkopp <socketcan@hartkopp.net>, kernel@pengutronix.de, 
 Eric Dumazet <edumazet@kernel.org>, Jakub Kicinski <kuba@kernel.org>, 
 Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, 
 Jonathan Corbet <corbet@lwn.net>, Shuah Khan <skhan@linuxfoundation.org>, 
 Randy Dunlap <rdunlap@infradead.org>
Cc: linux-can@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-arm-kernel@lists.infradead.org, linux-rockchip@lists.infradead.org, 
 netdev@vger.kernel.org, linux-doc@vger.kernel.org, stable@vger.kernel.org, 
 Cunhao Lu <1579567540@qq.com>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1792248654; l=4366;
 i=1579567540@qq.com; s=20261015; h=from:subject:message-id;
 bh=L729iyLZPqYSYXdNKiWcUHyKMxTpCJWqzC68GEcr5dM=;
 b=Yc81tvY6uDwUlOz5ahvRrINdDKUci5oaevm+DQj42SL8lMcNY9QovMFVZNgFIHKAwlZsYsF9l
 WfqfV5G57sYAuFO8f4LTyCy/h8g2BuN3Usb7lkD4xGQf7J9nduy+wwS
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


