Received: from azure-sdnproxy.icoremail.net (azure-sdnproxy.icoremail.net [52.175.55.52])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8BB1F1FE471;
	Fri, 10 Jul 2026 01:58:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=52.175.55.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783648740; cv=none; b=smnIrFbkitDJRNLA81DY5vlzK5xmWzD3TbM9PEbF7VBSUwODrVBK6CFrRCWeWdO1WtgKrB0WNTlVGmZoTJ4xbXRFAG1BOIP1blGDff+cpyFquQEgyrPtXT8tAwJCoKrIOoboDkUbI9blaGJ6RXR0qdh/ukZoCxzi3Tx7RMgCWsU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783648740; c=relaxed/simple;
	bh=f0cXaBA3jdW99H4NxUqPacfR/UpWvSvZUZpMvT1az40=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=UK+/FONXrtWnWL6Oyq8wYFOdngE3KRQiPPtWkMsqGO3NpWzF1W/h9rZ8Fkjkn2Cu3DoHsn+OglvFzEHuMEDbdOvaiBOJ1yS3NPpvDgC3Y2cl+7iFqmsUlS+XkoiStpEdeNBF7WJzJu9CRYJNcveVYFsVfjFMSeZLBwhVM2ZhJr8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=zju.edu.cn; spf=pass smtp.mailfrom=zju.edu.cn; arc=none smtp.client-ip=52.175.55.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=zju.edu.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=zju.edu.cn
Received: from zju.edu.cn (unknown [10.98.66.117])
	by mtasvr (Coremail) with SMTP id _____wDnslLDUVBqucQuAA--.200S3;
	Fri, 10 Jul 2026 09:58:29 +0800 (CST)
Received: from localhost.localdomain (unknown [10.98.66.117])
	by mail-app4 (Coremail) with SMTP id zi_KCgCn2jHCUVBqpzAzAg--.28839S2;
	Fri, 10 Jul 2026 09:58:26 +0800 (CST)
From: Fan Wu <fanwu01@zju.edu.cn>
To: netdev@vger.kernel.org
Cc: shenjian15@huawei.com,
	salil.mehta@huawei.com,
	dingtianhong@huawei.com,
	horms@kernel.org,
	andrew+netdev@lunn.ch,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org,
	Fan Wu <fanwu01@zju.edu.cn>
Subject: [PATCH net v2] net: hip04: fix tx coalesce timer and IRQ teardown races
Date: Fri, 10 Jul 2026 01:57:30 +0000
Message-Id: <20260710015730.630775-1-fanwu01@zju.edu.cn>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:zi_KCgCn2jHCUVBqpzAzAg--.28839S2
X-CM-SenderInfo: qrstjiaswqq6lmxovvfxof0/
X-CM-DELIVERINFO: =?B?Ll45+wXKKxbFmtjJiESix3B1w3vZ3A9ovKVTomAyoQazvoRs/NHSP8GI2EvgeEEW7R
	sfnXz+g1OQfMo27QHy5TwQyZzn0M4BCIM3p6ZDevjuTU4/UUiz/pS3Ua37ORSf1XF+NAVA
	hC9W9qgB9RK9HxbpaO+p9E6mavGmQbzmcFsnzP86
X-Coremail-Antispam: 1Uk129KBj93XoW3WrW5Ar4UJF4kGr45uw4fXrc_yoW3Zr1kpa
	yfGa93tr4vyw4SqrZxJF48tryrAa1xJFZrGw1xGrZYkwnIyr1Utr1kKFyYgF4UAFWvyrsx
	ur4FvFWru398A3gCm3ZEXasCq-sJn29KB7ZKAUJUUUUU529EdanIXcx71UUUUU7KY7ZEXa
	sCq-sGcSsGvfJ3Ic02F40EFcxC0VAKzVAqx4xG6I80ebIjqfuFe4nvWSU5nxnvy29KBjDU
	0xBIdaVrnRJUUUPjb4IE77IF4wAFF20E14v26r4j6ryUM7CY07I20VC2zVCF04k26cxKx2
	IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48v
	e4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_tr0E3s1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI
	0_Cr1j6rxdM28EF7xvwVC2z280aVAFwI0_GcCE3s1l84ACjcxK6I8E87Iv6xkF7I0E14v2
	6rxl6s0DM2vYz4IE04k24VAvwVAKI4IrM2AIxVAIcxkEcVAq07x20xvEncxIr21l57IF6x
	kI12xvs2x26I8E6xACxx1l5I8CrVACY4xI64kE6c02F40Ex7xfMcIj6xIIjxv20xvE14v2
	6r1j6r18McIj6I8E87Iv67AKxVWUJVW8JwAm72CE4IkC6x0Yz7v_Jr0_Gr1lF7xvr2IYc2
	Ij64vIr41lF7xvr2IYc2Ij64vIr40E4x8a64kEw24lFIxGxcIEc7CjxVA2Y2ka0xkIwI1l
	42xK82IYc2Ij64vIr41l4I8I3I0E4IkC6x0Yz7v_Jr0_Gr1lx2IqxVAqx4xG67AKxVWUJV
	WUGwC20s026x8GjcxK67AKxVWUGVWUWwC2zVAF1VAY17CE14v26r1q6r43MIIYrxkI7VAK
	I48JMIIF0xvE2Ix0cI8IcVAFwI0_Jr0_JF4lIxAIcVC0I7IYx2IY6xkF7I0E14v26r4j6F
	4UMIIF0xvE42xK8VAvwI8IcIk0rVWUJVWUCwCI42IY6I8E87Iv67AKxVWUJVW8JwCI42IY
	6I8E87Iv6xkF7I0E14v26r4j6r4UJbIYCTnIWIevJa73UjIFyTuYvjxU7gAwDUUUU

The hip04 remove path frees the TX/RX rings before unregistering the
netdev. If the interface is still up, unregister_netdev() then runs
.ndo_stop, whose TX reclaim and NAPI poll touch the already-freed DMA
ring memory. The TX coalesce timer and the platform IRQ also outlive
the netdev private data they dereference.

Reorder hip04_remove() so the netdev is unregistered (which runs .ndo_stop
synchronously, stopping NAPI and the TX queue) before the rings are freed.
Free the devm-managed IRQ explicitly before free_netdev(), so
hip04_mac_interrupt() (whose dev_id is the netdev) cannot fire against
freed memory: devm would otherwise release it only after .remove returns.

hip04_mac_stop() must quiesce both arming sites of the coalesce timer.
The NAPI poll arms it, and napi_disable() returns once the poll calls
napi_complete_done(), not when the poll function returns, so move that
arm before napi_complete_done().  The existing early exits that jump to
done do not call napi_complete_done(), so they remain outside the
completion-after-arm window this change closes.  The TX xmit path also
arms it, and mac_stop() is reached directly from hip04_tx_timeout_task()
as well as via .ndo_stop, so use netif_tx_disable() rather than
netif_stop_queue() to wait for an in-flight hip04_mac_start_xmit() to
finish.  The timer is then drained with hrtimer_cancel().  A "closing"
flag, checked at the single arming site, guards against a later arm.

hip04_tx_timeout_task() restarts the device with mac_stop() + mac_open();
serialize that restart against .ndo_stop with rtnl_lock(), matching the
netdev core's locking, skip it if the device is no longer running, and
emit an error if the restart fails instead of silently leaving it down.

This issue was found by an in-house static analysis tool.

Fixes: a41ea46a9a12 ("net: hisilicon: new hip04 ethernet driver")
Cc: stable@vger.kernel.org
Assisted-by: Codex:gpt-5.5
Signed-off-by: Fan Wu <fanwu01@zju.edu.cn>
---
v2:
  - Address review comments from Simon Horman. Use netif_tx_disable() rather
    than netif_stop_queue() in hip04_mac_stop() so that an in-flight
    hip04_mac_start_xmit() finishes before the TX ring is reclaimed;
    mac_stop() is also called directly from the tx-timeout work, not only
    via .ndo_stop.
  - Arm the coalesce timer in hip04_rx_poll() before napi_complete_done(), so
    that napi_disable() observes the final arm and the subsequent cancel
    cannot miss it.
  - Free the devm-managed IRQ explicitly in hip04_remove() before free_netdev()
    so that hip04_mac_interrupt() cannot run against freed memory, placing it
    after unregister_netdev() so that the device is stopped first.
  - Reorder hip04_remove() so that the netdev is unregistered (running .ndo_stop)
    before the PHY is disconnected and the TX/RX rings are freed.
  - Check the return value of hip04_mac_open() in the tx-timeout restart path.

v1: https://lore.kernel.org/netdev/20260703050133.2445155-1-fanwu01@zju.edu.cn/

 drivers/net/ethernet/hisilicon/hip04_eth.c | 74 ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 66 insertions(+), 8 deletions(-)

diff --git a/drivers/net/ethernet/hisilicon/hip04_eth.c b/drivers/net/ethernet/hisilicon/hip04_eth.c
--- a/drivers/net/ethernet/hisilicon/hip04_eth.c
+++ b/drivers/net/ethernet/hisilicon/hip04_eth.c
@@ -15,6 +15,7 @@
 #include <linux/of_net.h>
 #include <linux/mfd/syscon.h>
 #include <linux/regmap.h>
+#include <linux/rtnetlink.h>
 
 #define SC_PPE_RESET_DREQ		0x026C
 
@@ -232,6 +233,7 @@
 	int tx_coalesce_frames;
 	int tx_coalesce_usecs;
 	struct hrtimer tx_coalesce_timer;
+	bool closing;
 
 	unsigned char *rx_buf[RX_DESC_NUM];
 	dma_addr_t rx_phys[RX_DESC_NUM];
@@ -497,6 +499,12 @@
 {
 	unsigned long ns = priv->tx_coalesce_usecs * NSEC_PER_USEC / 2;
 
+	/* Do not (re-)arm the TX coalesce timer once teardown has begun.
+	 * Both arming sites (TX xmit and NAPI rx poll) go through here.
+	 */
+	if (smp_load_acquire(&priv->closing))
+		return;
+
 	/* allow timer to fire after half the time at the earliest */
 	hrtimer_start_range_ns(&priv->tx_coalesce_timer, ns_to_ktime(ns),
 			       ns, HRTIMER_MODE_REL);
@@ -649,12 +657,15 @@
 		priv->reg_inten |= RCV_INT;
 		writel_relaxed(priv->reg_inten, priv->base + PPE_INTEN);
 	}
+	/* Arm the coalesce timer BEFORE napi_complete_done(): napi_disable()
+	 * in hip04_mac_stop() returns once SCHED is cleared here, not when
+	 * the poll function returns, so arming afterwards can slip past the
+	 * stop path's hrtimer_cancel().
+	 */
+	if (tx_remaining)
+		hip04_start_tx_timer(priv);
 	napi_complete_done(napi, rx);
 done:
-	/* start a new timer if necessary */
-	if (rx < budget && tx_remaining)
-		hip04_start_tx_timer(priv);
-
 	return rx;
 }
 
@@ -729,6 +740,11 @@
 	priv->rx_cnt_remaining = 0;
 	priv->tx_head = 0;
 	priv->tx_tail = 0;
+	/* A plain write is sufficient here: mac_open() runs under RTNL, so it
+	 * cannot race mac_stop()'s store-release, and napi_enable() below orders
+	 * this reset before any TX/NAPI traffic can resume.
+	 */
+	WRITE_ONCE(priv->closing, false);
 	hip04_reset_ppe(priv);
 
 	for (i = 0; i < RX_DESC_NUM; i++) {
@@ -759,8 +775,26 @@
 	struct hip04_priv *priv = netdev_priv(ndev);
 	int i;
 
+	/* Stop new timer arms before draining: set the closing flag (checked
+	 * at the single arming site), wait for the NAPI poll and any in-flight
+	 * TX to finish, then cancel the timer.
+	 *
+	 * netif_tx_disable() (not netif_stop_queue()) is required because this
+	 * function is also called directly from hip04_tx_timeout_task(), not
+	 * only via .ndo_stop where the core has already deactivated TX;
+	 * netif_tx_disable() waits for an in-flight hip04_mac_start_xmit(),
+	 * which arms the timer, to finish.
+	 *
+	 * Because hip04_rx_poll() arms the timer before napi_complete_done(),
+	 * napi_disable() returning means that arm has happened, so the
+	 * hrtimer_cancel() below cannot miss it.  The store-release pairs
+	 * with the load in hip04_start_tx_timer().
+	 */
+	smp_store_release(&priv->closing, true);
+
 	napi_disable(&priv->napi);
-	netif_stop_queue(ndev);
+	netif_tx_disable(ndev);
+	hrtimer_cancel(&priv->tx_coalesce_timer);
 	hip04_mac_disable(ndev);
 	hip04_tx_reclaim(ndev, true);
 	hip04_reset_ppe(priv);
@@ -791,8 +825,21 @@
 	struct hip04_priv *priv;
 
 	priv = container_of(work, struct hip04_priv, tx_timeout_task);
+
+	/* Bail if the device was taken down (dev_close/unregister).  The
+	 * mac_stop() below is called directly and does not clear
+	 * __LINK_STATE_START, so this guard does not match the restart's
+	 * own stop; it exists only to avoid restarting a torn-down device.
+	 */
+	rtnl_lock();
+	if (!netif_running(priv->ndev))
+		goto out;
+
 	hip04_mac_stop(priv->ndev);
-	hip04_mac_open(priv->ndev);
+	if (hip04_mac_open(priv->ndev))
+		netdev_err(priv->ndev, "restart after tx timeout failed\n");
+out:
+	rtnl_unlock();
 }
 
 static int hip04_get_coalesce(struct net_device *netdev,
@@ -1026,13 +1073,24 @@
 	struct hip04_priv *priv = netdev_priv(ndev);
 	struct device *d = &pdev->dev;
 
+	unregister_netdev(ndev);
+
+	/* The IRQ is devm-managed and would otherwise be freed only after
+	 * this function returns.  Free it now, after unregister_netdev() has
+	 * run .ndo_stop to stop the device and mask its interrupt source, but
+	 * before the manual free_netdev() below, so that hip04_mac_interrupt()
+	 * (dev_id == ndev) cannot fire against freed memory.  free_irq() also
+	 * drains any in-flight handler.
+	 */
+	devm_free_irq(d, ndev->irq, ndev);
+	cancel_work_sync(&priv->tx_timeout_task);
+	hrtimer_cancel(&priv->tx_coalesce_timer);
+
 	if (priv->phy)
 		phy_disconnect(priv->phy);
 
 	hip04_free_ring(ndev, d);
-	unregister_netdev(ndev);
 	of_node_put(priv->phy_node);
-	cancel_work_sync(&priv->tx_timeout_task);
 	free_netdev(ndev);
 }
 

