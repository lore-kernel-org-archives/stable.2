Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=45.254.49.198
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794750170;
	b=Q76KOmih2WE0yvMlgOL7+MfP/Hub1/oLSa/t10WBfExGgNgbdba5PF0qtSdRWZ9mgWWW
	 3PXY2oD6h04fhA/ScLAf+iyBXx8OlEtZDqHvumF/xYfwztUQIhzr1wuxZzKm+8mHNrEtt
	 6zojUsyAzJRfXFcCQtCeNnzje9JOlS6JQpL0utYuPJ8DR/XGijYmoUyeCGteh6JUX7HB0
	 +eVypeHh0lgKpByvhecr/2ydZIzulb5bXG/CTj08+dLKkPZCS/Bf+IMPw7Hui2LeXzrbu
	 lGy3a0rnwSt4j1s9OC6LFYmGuAJlbhF2s0qwKN9mEVtiidSex1WXeJVDHDdYXo31tPA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794750170;
	h=DMARC-Filter:Received:From:To:Cc:Subject:Date:Message-ID:In-Reply-To:
	 References:Content-Type:Content-Transfer-Encoding:MIME-Version:
	 X-HM-Tid:X-HM-MType:X-HM-Spam-Status:DKIM-Signature;
	bh=8CRk20VHscikiP6yQCkc1wYtx8UzpFFGh/MjagOJ6yE=;
	b=4EeDNCJ3TU0ie4MyAbt5xonODklqcGS+HZPBI4PoTLc5R4Bxfkx/DR8h3VNJuiihRdWN
	 UZCY3h9M4nICalktXJS92mODMn0DKjzWLz6BV8dV5rs+4OfZgsc/+cFDSvdcacRDOiaK9
	 vApFTZIhDp3eQGPKlWY/dFrSVz3Upqovo5ld3IhKCMtIcTtljmnDBU7rbSUPy/ol326d1
	 wdC0CtXG8fDyPKTv7P5ZJ3Sqpg9XK/26fujgGMXnThhRblR7FYIIrNES1y0NYbJt2hWDv
	 3glGs12CavDWorF9OxSIKV478D40uFFqFllBBeTL6KX2vvA99wA4iSPC4nGW+r7eOJA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=seu.edu.cn;
	spf=pass smtp.mailfrom=seu.edu.cn;
	dkim=pass header.d=seu.edu.cn header.i=@seu.edu.cn header.a=rsa-sha256 header.s=default header.b="hbk2Y/fo";
	arc=none smtp.remote-ip=45.254.49.198
Received: from mail-m49198.qiye.163.com (mail-m49198.qiye.163.com [45.254.49.198])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6D343606A338;
	Sun, 15 Nov 2026 13:42:47 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 6D343606A338
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=seu.edu.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=seu.edu.cn
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=seu.edu.cn header.i=@seu.edu.cn header.a=rsa-sha256 header.s=default header.b=hbk2Y/fo
Received: from [192.168.17.1] (unknown [124.79.98.159])
	by smtp.qiye.163.com (Hmail) with ESMTP id 54b8d4a14;
	Sun, 15 Nov 2026 21:42:44 +0800 (GMT+08:00)
From: Hongyan Xu <getshell@seu.edu.cn>
To: Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 David S. Miller <davem@davemloft.net>, Eric Dumazet <edumazet@kernel.org>,
 Andrew Lunn <andrew+netdev@lunn.ch>
Cc: linux-kernel@vger.kernel.org, stable@vger.kernel.org
Subject: [PATCH net v2 2/2] net: plip: balance the controller IRQ when closing
 a transfer
Date: Sun, 15 Nov 2026 21:42:42 +0800
Message-ID: <179475016227.114908.4057243616262048108@seu.edu.cn>
In-Reply-To: <179475015898.114908.1534399014158681174@seu.edu.cn>
References: <179475015898.114908.1534399014158681174@seu.edu.cn>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
X-HM-Tid: 0aa1df722eab03a1kunm6a37fc6bc5354
X-HM-MType: 10
X-HM-Spam-Status: e1kfGhgUHx5ZQUpXWQgPGg8OCBgUHx5ZQUlOS1dZFg8aDwILHllBWSg2Ly
	tZV1koWUFITzdXWRgWCB1ZQUpXWS1ZQUlXWQ8JGhUIEh9ZQVlDQ0lIVkxJTxgdTkhCSh9DTFYeHw
	5VEwETFhoSFyQUDg9ZV1kYEgtZQVlKSU9VTEJVQkNVSk5CWVdZFhoPEhUdFFlBWU9LSFVKS0lCQ0
	JKVUpLS1VLWQY+
DKIM-Signature: a=rsa-sha256;
	b=hbk2Y/foqg2KY4w6z+67GGpTX55XPsyEjis26BKHdhEagI0PRzZAv7UhcGROuCfJslOl85CGkP9bLhiBRqnnF5wA/HW6Di+KS8yt17I59O4VLdLJTFYWOgexmgXYNZgwBClm/x4ejhauj1EELnQRS/GKDejDoKzyB5slgzvZokk=; c=relaxed/relaxed; s=default; d=seu.edu.cn; v=1;
	bh=8CRk20VHscikiP6yQCkc1wYtx8UzpFFGh/MjagOJ6yE=;
	h=date:mime-version:subject:message-id:from;

Closing adds a counted disable_irq reference but never releases it. A
transfer can also hold its own reference across deferred work. Draining
that work can abandon the transfer's reference, so merely adding one
enable_irq to close is insufficient.

Track one driver-owned disable reference and prevent transfer completion
from enabling it while close drains the work. Reject IRQ publication
once close begins, restore the port's interrupt and data state while
ownership is still held, release the port, then drop the driver's IRQ
reference. The polling mode skips the invalid IRQ sentinel in the shared
helper.

Found by the author's in-house static analysis tool.

Fixes: 1da177e4c3f4 ("Linux-2.6.12-rc2")
Cc: stable@vger.kernel.org
Link: https://lore.kernel.org/all/179086213620.434549.7621820175200159527@kernel.org/
Signed-off-by: Hongyan Xu <getshell@seu.edu.cn>
Signed-off-by: Zehao Gao <gaozehao@iie.ac.cn>
---

Discovery: found by the author's in-house static analysis tool.

 drivers/net/plip/plip.c | 165 +++++++++++++++++++++++++++++++---------
 1 file changed, 131 insertions(+), 34 deletions(-)

diff --git a/drivers/net/plip/plip.c b/drivers/net/plip/plip.c
index dc3d258..f27c6a0 100644
--- a/drivers/net/plip/plip.c
+++ b/drivers/net/plip/plip.c
@@ -122,8 +122,6 @@ static const char version[] = "NET3 PLIP version 2.4-parport gniibe@mri.co.jp\n"
 #endif
 static const unsigned int net_debug = NET_DEBUG;
 
-#define ENABLE(irq)  if (irq != -1) enable_irq(irq)
-#define DISABLE(irq) if (irq != -1) disable_irq(irq)
 
 /* In micro second */
 #define PLIP_DELAY_UNIT		   1
@@ -217,11 +215,58 @@ struct net_local {
 	int is_deferred;
 	int port_owner;
 	int should_relinquish;
+	bool closing;
+	bool irq_disabled;
 	spinlock_t lock;
 	atomic_t kill_timer;
 	struct completion killed_timer_cmp;
 };
 
+/*
+ * Take one IRQ-disable reference and wait for handlers to finish.  Must be
+ * called from process context with nl->lock not held: synchronize_irq() may
+ * sleep.
+ */
+static void plip_disable_irq(struct net_device *dev)
+{
+	struct net_local *nl = netdev_priv(dev);
+	unsigned long flags;
+
+	if (dev->irq == -1)
+		return;
+
+	spin_lock_irqsave(&nl->lock, flags);
+	if (!nl->irq_disabled) {
+		nl->irq_disabled = true;
+		disable_irq_nosync(dev->irq);
+	}
+	spin_unlock_irqrestore(&nl->lock, flags);
+	synchronize_irq(dev->irq);
+}
+
+/*
+ * Drop the driver's IRQ reference unless close is in progress.  Takes
+ * nl->lock internally and must not be called with it held.
+ */
+static void plip_enable_irq(struct net_device *dev)
+{
+	struct net_local *nl = netdev_priv(dev);
+	unsigned long flags;
+	bool enable = false;
+
+	if (dev->irq == -1)
+		return;
+
+	spin_lock_irqsave(&nl->lock, flags);
+	if (nl->irq_disabled && !nl->closing) {
+		nl->irq_disabled = false;
+		enable = true;
+	}
+	spin_unlock_irqrestore(&nl->lock, flags);
+	if (enable)
+		enable_irq(dev->irq);
+}
+
 static inline void enable_parport_interrupts (struct net_device *dev)
 {
 	if (dev->irq != -1)
@@ -300,6 +345,7 @@ plip_init_netdev(struct net_device *dev)
 
 
 	nl->port_owner = 0;
+	nl->closing = true;
 
 	/* Initialize constants */
 	nl->trigger	= PLIP_TRIGGER_WAIT;
@@ -405,13 +451,10 @@ plip_bh_timeout_error(struct net_device *dev, struct net_local *nl,
 {
 	unsigned char c0;
 	/*
-	 * This is tricky. If we got here from the beginning of send (either
-	 * with ERROR or HS_TIMEOUT) we have IRQ enabled. Otherwise it's
-	 * already disabled. With the old variant of {enable,disable}_irq()
-	 * extra disable_irq() was a no-op. Now it became mortal - it's
-	 * unbalanced and thus we'll never re-enable IRQ (until rmmod plip,
-	 * that is). So we have to treat HS_TIMEOUT and ERROR from send
-	 * in a special way.
+	 * plip_disable_irq() takes the send path's single IRQ-disable
+	 * reference and skips the operation when that reference is already
+	 * held, so a retried timeout needs no separate "was it enabled"
+	 * test.
 	 */
 
 	spin_lock_irq(&nl->lock);
@@ -462,8 +505,7 @@ plip_bh_timeout_error(struct net_device *dev, struct net_local *nl,
 	}
 	spin_unlock_irq(&nl->lock);
 	if (error == HS_TIMEOUT) {
-		DISABLE(dev->irq);
-		synchronize_irq(dev->irq);
+		plip_disable_irq(dev);
 	}
 	disable_parport_interrupts (dev);
 	netif_stop_queue (dev);
@@ -595,8 +637,7 @@ plip_receive_packet(struct net_device *dev, struct net_local *nl,
 
 	switch (rcv->state) {
 	case PLIP_PK_TRIGGER:
-		DISABLE(dev->irq);
-		/* Don't need to synchronize irq, as we can safely ignore it */
+		plip_disable_irq(dev);
 		disable_parport_interrupts (dev);
 		write_data (dev, 0x01); /* send ACK */
 		if (net_debug > 2)
@@ -615,7 +656,7 @@ plip_receive_packet(struct net_device *dev, struct net_local *nl,
 				nl->connection = PLIP_CN_SEND;
 				schedule_delayed_work(&nl->deferred, 1);
 				enable_parport_interrupts (dev);
-				ENABLE(dev->irq);
+				plip_enable_irq(dev);
 				return OK;
 			}
 		} else {
@@ -693,13 +734,13 @@ plip_receive_packet(struct net_device *dev, struct net_local *nl,
 			spin_unlock_irq(&nl->lock);
 			schedule_work(&nl->immediate);
 			enable_parport_interrupts (dev);
-			ENABLE(dev->irq);
+			plip_enable_irq(dev);
 			return OK;
 		} else {
 			nl->connection = PLIP_CN_NONE;
 			spin_unlock_irq(&nl->lock);
 			enable_parport_interrupts (dev);
-			ENABLE(dev->irq);
+			plip_enable_irq(dev);
 			return OK;
 		}
 	}
@@ -790,8 +831,7 @@ plip_send_packet(struct net_device *dev, struct net_local *nl,
 			c0 = read_status(dev);
 			if (c0 & 0x08) {
 				spin_unlock_irq(&nl->lock);
-				DISABLE(dev->irq);
-				synchronize_irq(dev->irq);
+				plip_disable_irq(dev);
 				if (nl->connection == PLIP_CN_RECEIVE) {
 					/* Interrupted.
 					   We don't need to enable irq,
@@ -799,7 +839,7 @@ plip_send_packet(struct net_device *dev, struct net_local *nl,
 					/* Yes, we do. New variant of
 					   {enable,disable}_irq *counts*
 					   them.  -- AV  */
-					ENABLE(dev->irq);
+					plip_enable_irq(dev);
 					dev->stats.collisions++;
 					return OK;
 				}
@@ -868,7 +908,7 @@ plip_send_packet(struct net_device *dev, struct net_local *nl,
 		nl->is_deferred = 1;
 		schedule_delayed_work(&nl->deferred, 1);
 		enable_parport_interrupts (dev);
-		ENABLE(dev->irq);
+		plip_enable_irq(dev);
 		return OK;
 	}
 	return OK;
@@ -906,7 +946,7 @@ plip_error(struct net_device *dev, struct net_local *nl,
 		nl->should_relinquish = 0;
 		netif_start_queue (dev);
 		enable_parport_interrupts (dev);
-		ENABLE(dev->irq);
+		plip_enable_irq(dev);
 		netif_wake_queue (dev);
 	} else {
 		nl->is_deferred = 1;
@@ -930,6 +970,8 @@ plip_interrupt(void *dev_id)
 	rcv = &nl->rcv_data;
 
 	spin_lock_irqsave (&nl->lock, flags);
+	if (nl->closing)
+		goto out_unlock;
 
 	c0 = read_status(dev);
 	if ((c0 & 0xf8) != 0xc0) {
@@ -965,6 +1007,7 @@ plip_interrupt(void *dev_id)
 		break;
 	}
 
+out_unlock:
 	spin_unlock_irqrestore(&nl->lock, flags);
 }
 
@@ -1072,6 +1115,7 @@ plip_open(struct net_device *dev)
 	struct in_device *in_dev;
 
 	/* parport_claim() can make the interrupt handler reachable. */
+	spin_lock_irq(&nl->lock);
 	nl->rcv_data.state = PLIP_PK_DONE;
 	nl->snd_data.state = PLIP_PK_DONE;
 	nl->rcv_data.skb = NULL;
@@ -1080,11 +1124,14 @@ plip_open(struct net_device *dev)
 	nl->is_deferred = 0;
 	nl->should_relinquish = 0;
 	enable_work(&nl->immediate);
-	enable_work(&nl->deferred.work);
+	enable_delayed_work(&nl->deferred);
+	nl->closing = false;
+	spin_unlock_irq(&nl->lock);
 
 	/* Grab the port */
 	if (!nl->port_owner) {
 		if (parport_claim(nl->pardev)) {
+			nl->closing = true;
 			disable_work_sync(&nl->immediate);
 			disable_delayed_work_sync(&nl->deferred);
 			return -EAGAIN;
@@ -1138,10 +1185,13 @@ plip_close(struct net_device *dev)
 	struct net_local *nl = netdev_priv(dev);
 	struct plip_local *snd = &nl->snd_data;
 	struct plip_local *rcv = &nl->rcv_data;
+	bool owned;
 
-	netif_stop_queue (dev);
-	DISABLE(dev->irq);
-	synchronize_irq(dev->irq);
+	netif_stop_queue(dev);
+	spin_lock_irq(&nl->lock);
+	nl->closing = true;
+	spin_unlock_irq(&nl->lock);
+	plip_disable_irq(dev);
 
 	if (dev->irq == -1)
 	{
@@ -1153,14 +1203,23 @@ plip_close(struct net_device *dev)
 	disable_work_sync(&nl->immediate);
 	disable_delayed_work_sync(&nl->deferred);
 
-#ifdef NOTDEF
-	outb(0x00, PAR_DATA(dev));
-#endif
+	/*
+	 * closing is still set, so preempt() refuses to take the port while
+	 * the IRQ source is disabled and the data register is restored.
+	 */
+	spin_lock_irq(&nl->lock);
+	owned = nl->port_owner;
 	nl->is_deferred = 0;
 	nl->connection = PLIP_CN_NONE;
-	if (nl->port_owner) {
-		parport_release(nl->pardev);
+	spin_unlock_irq(&nl->lock);
+
+	if (owned) {
+		disable_parport_interrupts(dev);
+		write_data(dev, 0x00);
+		spin_lock_irq(&nl->lock);
 		nl->port_owner = 0;
+		spin_unlock_irq(&nl->lock);
+		parport_release(nl->pardev);
 	}
 
 	snd->state = PLIP_PK_DONE;
@@ -1174,10 +1233,16 @@ plip_close(struct net_device *dev)
 		rcv->skb = NULL;
 	}
 
-#ifdef NOTDEF
-	/* Reset. */
-	outb(0x00, PAR_CONTROL(dev));
-#endif
+	if (nl->irq_disabled) {
+		nl->irq_disabled = false;
+		enable_irq(dev->irq);
+	}
+
+	/* The port has been released; allow other clients to claim it. */
+	spin_lock_irq(&nl->lock);
+	nl->closing = false;
+	spin_unlock_irq(&nl->lock);
+
 	return 0;
 }
 
@@ -1186,14 +1251,25 @@ plip_preempt(void *handle)
 {
 	struct net_device *dev = (struct net_device *)handle;
 	struct net_local *nl = netdev_priv(dev);
+	unsigned long flags;
+
+	spin_lock_irqsave(&nl->lock, flags);
 
 	/* Stand our ground if a datagram is on the wire */
 	if (nl->connection != PLIP_CN_NONE) {
 		nl->should_relinquish = 1;
+		spin_unlock_irqrestore(&nl->lock, flags);
+		return 1;
+	}
+
+	/* Let close restore the port state before the port changes hands. */
+	if (nl->closing) {
+		spin_unlock_irqrestore(&nl->lock, flags);
 		return 1;
 	}
 
 	nl->port_owner = 0;	/* Remember that we released the bus */
+	spin_unlock_irqrestore(&nl->lock, flags);
 	return 0;
 }
 
@@ -1202,6 +1278,7 @@ plip_wakeup(void *handle)
 {
 	struct net_device *dev = (struct net_device *)handle;
 	struct net_local *nl = netdev_priv(dev);
+	unsigned long flags;
 
 	if (nl->port_owner) {
 		/* Why are we being woken up? */
@@ -1217,8 +1294,28 @@ plip_wakeup(void *handle)
 		/* Don't need the port when the interface is down */
 		return;
 
+	/* close() is releasing the port; do not take it back underneath it. */
+	spin_lock_irqsave(&nl->lock, flags);
+	if (nl->closing) {
+		spin_unlock_irqrestore(&nl->lock, flags);
+		return;
+	}
+	spin_unlock_irqrestore(&nl->lock, flags);
+
 	if (!parport_claim(nl->pardev)) {
+		/*
+		 * close() may have started while we were claiming the port.
+		 * Recheck under the lock that guards its ownership snapshot
+		 * and hand the port straight back if so.
+		 */
+		spin_lock_irqsave(&nl->lock, flags);
+		if (nl->closing) {
+			spin_unlock_irqrestore(&nl->lock, flags);
+			parport_release(nl->pardev);
+			return;
+		}
 		nl->port_owner = 1;
+		spin_unlock_irqrestore(&nl->lock, flags);
 		/* Clear the data port. */
 		write_data (dev, 0x00);
 	}
-- 
2.50.1.windows.1
