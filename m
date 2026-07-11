Received: from zg8tmtyylji0my4xnjeumjiw.icoremail.net (zg8tmtyylji0my4xnjeumjiw.icoremail.net [162.243.161.220])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 243BA3770B;
	Sat, 11 Jul 2026 05:30:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=162.243.161.220
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783747843; cv=none; b=bp5yoNDUBPGPn3oWgcoXZusw4U7eQoOE8DGTOjWrw9+Fm0NyU9nX4bB2OYP2qcYSes0eiKCXKDGRfbcp02LdFSwzv0fvDHSqVjjqWBGaFsEtfGB8I5UKQw8D6ONm9gTQqN+dFUUFMvuc9jLRvFGganHjaZt2SrAlQiJZV75myPo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783747843; c=relaxed/simple;
	bh=G0IMDCsHZn9637YiSTEfdtPOSOs5FpHbF3Ab1eAvPZ0=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=QEpwOx00oaevuF7vgJ4va81mm+/5+WS/T9rC4VqSHLM9aV799yPpSE/H2KMgye4drFrjfsuOiUo5mdQ/xtD/bOLhdlFxPh3tEbS4naHRNaaHXzhvOpWZZmIPlMwfCOSLdU3mcfnRmfEkiZIqs43wQYlIuZB2cjcc3MKQ6aNzmUY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=zju.edu.cn; spf=pass smtp.mailfrom=zju.edu.cn; arc=none smtp.client-ip=162.243.161.220
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=zju.edu.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=zju.edu.cn
Received: from zju.edu.cn (unknown [10.98.66.117])
	by mtasvr (Coremail) with SMTP id _____wAHKV3r1FFqrKw3AA--.20663S3;
	Sat, 11 Jul 2026 13:30:20 +0800 (CST)
Received: from localhost.localdomain (unknown [10.98.66.117])
	by mail-app3 (Coremail) with SMTP id zS_KCgB3kHLp1FFq38APAw--.24487S2;
	Sat, 11 Jul 2026 13:30:17 +0800 (CST)
From: Fan Wu <fanwu01@zju.edu.cn>
To: netdev@vger.kernel.org
Cc: shenjian15@huawei.com,
	salil.mehta@huawei.com,
	dingtianhong@huawei.com,
	przemyslaw.kitszel@intel.com,
	horms@kernel.org,
	andrew+netdev@lunn.ch,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org,
	Fan Wu <fanwu01@zju.edu.cn>
Subject: [PATCH net v3] net: hip04: fix tx coalesce timer and IRQ teardown races
Date: Sat, 11 Jul 2026 05:29:22 +0000
Message-Id: <20260711052922.1634837-1-fanwu01@zju.edu.cn>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:zS_KCgB3kHLp1FFq38APAw--.24487S2
X-CM-SenderInfo: qrstjiaswqq6lmxovvfxof0/
X-CM-DELIVERINFO: =?B?uCrOiAXKKxbFmtjJiESix3B1w3vZ3A9ovKVTomAyoQazvoRs/NHSP8GI2EvgeEEW7R
	sfnZPoDCNGYdHSfuFmYJL54WPsNDoajOlnwjpY/9ehveo+tEDJ4fpDi5AaZmM1fFJgL7+Q
	GOwuDsm6pLLZHigh1nSp9E6mavGmQbzmcFsnzP86
X-Coremail-Antispam: 1Uk129KBj93XoW3Zr1fGFyftFWDKFWxGw17Arc_yoWkWw4xpa
	yrKaykJrWvy3ySgrZrtF40qryIya1xJa9rGw18G3s5u3ZIyr10qr4kKryjvF4UJFWvkrn3
	Xr4FvFWUuw4DJ3gCm3ZEXasCq-sJn29KB7ZKAUJUUUUU529EdanIXcx71UUUUU7KY7ZEXa
	sCq-sGcSsGvfJ3Ic02F40EFcxC0VAKzVAqx4xG6I80ebIjqfuFe4nvWSU5nxnvy29KBjDU
	0xBIdaVrnRJUUUP0b4IE77IF4wAFF20E14v26r4j6ryUM7CY07I20VC2zVCF04k26cxKx2
	IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48v
	e4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_tr0E3s1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI
	0_Gr1j6F4UJwA2z4x0Y4vEx4A2jsIE14v26rxl6s0DM28EF7xvwVC2z280aVCY1x0267AK
	xVW0oVCq3wAac4AC62xK8xCEY4vEwIxC4wAS0I0E0xvYzxvE52x082IY62kv0487Mc804V
	CY07AIYIkI8VC2zVCFFI0UMc02F40EFcxC0VAKzVAqx4xG6I80ewAv7VC0I7IYx2IY67AK
	xVWUJVWUGwAv7VC2z280aVAFwI0_Jr0_Gr1lOx8S6xCaFVCjc4AY6r1j6r4UM4x0Y48Icx
	kI7VAKI48JM4x0Y48IcxkI7VAKI48G6xCjnVAKz4kxM4IIrI8v6xkF7I0E8cxan2IY04v7
	MxAIw28IcxkI7VAKI48JMxC20s026xCaFVCjc4AY6r1j6r4UMI8I3I0E5I8CrVAFwI0_Jr
	0_Jr4lx2IqxVCjr7xvwVAFwI0_JrI_JrWlx4CE17CEb7AF67AKxVWUtVW8ZwCIc40Y0x0E
	wIxGrwCI42IY6xIIjxv20xvE14v26r1j6r1xMIIF0xvE2Ix0cI8IcVCY1x0267AKxVW8JV
	WxJwCI42IY6xAIw20EY4v20xvaj40_Jr0_JF4lIxAIcVC2z280aVAFwI0_Jr0_Gr1lIxAI
	cVC2z280aVCY1x0267AKxVW8JVW8JrUvcSsGvfC2KfnxnUUI43ZEXa7IU85l1PUUUUU==

The hip04 remove path frees the TX/RX rings before unregistering the
netdev. If the interface is still up, unregister_netdev() then runs
.ndo_stop, whose TX reclaim and NAPI poll touch the already-freed DMA
ring memory. The TX coalesce timer and the platform IRQ also outlive the
netdev private data they dereference.

Reorder hip04_remove() so the netdev is unregistered (which runs .ndo_stop
synchronously, stopping NAPI and the TX queue) before the rings are freed.
Free the devm-managed IRQ explicitly before free_netdev(), so
hip04_mac_interrupt() (whose dev_id is the netdev) cannot fire against
freed memory: devm would otherwise release it only after .remove returns.

hip04_mac_stop() must quiesce both arming sites of the coalesce timer.
The NAPI poll arms it, and napi_disable() returns once the poll calls
napi_complete_done(), not when the poll function returns, so move that
arm before napi_complete_done().  The early-exit paths in hip04_rx_poll()
do not call napi_complete_done(); NAPI stays scheduled and will be polled
again, so there is no need to arm the coalesce timer on that pass.  The
Tx path also arms it, and mac_stop() is reached directly from
hip04_tx_timeout_task() as well as via .ndo_stop, so use netif_tx_disable()
rather than netif_stop_queue() to wait for an in-flight
hip04_mac_start_xmit() to finish.  The timer is then drained with
hrtimer_cancel().  A "closing" flag, checked at the single arming site,
guards against a later arm.

hip04_tx_timeout_task() restarts the device with mac_stop() + mac_open().
Serialize that restart against .ndo_open/.ndo_stop with a driver-private
state_lock instead of rtnl_lock(): mac_open()/mac_stop() are split into
internal __hip04_mac_open()/__hip04_mac_stop() helpers, and the
.ndo_open/.ndo_stop wrappers as well as the timeout worker take the lock.
This avoids extending RTNL usage; netdev_lock() is not sufficient here, as
hip04 does not opt into netdev-ops locking.  If timeout recovery is in
progress when a close begins, .ndo_stop waits on the lock and performs the
final MAC stop; if .ndo_stop acquires the lock first, the worker sees the
device is no longer running and returns.  Either way, recovery cannot
re-enable the MAC
during teardown.

This issue was found by an in-house static analysis tool.

Fixes: a41ea46a9a12 ("net: hisilicon: new hip04 ethernet driver")
Cc: stable@vger.kernel.org
Assisted-by: Codex:gpt-5.5
Signed-off-by: Fan Wu <fanwu01@zju.edu.cn>
---

v3: address review from Przemek Kitszel.

- Drop the rtnl_lock()/rtnl_unlock() and the #include <linux/rtnetlink.h>
  added to hip04_tx_timeout_task() in v2. Serialize the tx-timeout restart
  against .ndo_open/.ndo_stop with a driver-private state_lock instead:
  mac_open()/mac_stop() are split into __hip04_mac_open()/__hip04_mac_stop()
  helpers, and the .ndo_open/.ndo_stop wrappers and the timeout worker all
  take the lock. This avoids new RTNL usage. netdev_lock() was considered
  but does not help: hip04 does not opt into netdev-ops locking, so its
  .ndo_open/.ndo_stop run under RTNL and the netdev instance lock does not
  protect them.

- Rephrase the sentence about napi_complete_done() / early-exit paths that
  was hard to read.

- s/Tx xmit/Tx/.

v2: Address review comments from Simon Horman. Use netif_tx_disable() rather
   than netif_stop_queue() in hip04_mac_stop() so that an in-flight
   hip04_mac_start_xmit() finishes before the TX ring is reclaimed;
   mac_stop() is also called directly from the tx-timeout work, not only
   via .ndo_stop. Arm the coalesce timer in hip04_rx_poll() before
   napi_complete_done(), so that napi_disable() observes the final arm and
   the subsequent cancel cannot miss it. Free the devm-managed IRQ
   explicitly in hip04_remove() before free_netdev() so that
   hip04_mac_interrupt() cannot run against freed memory, placing it after
   unregister_netdev() so that the device is stopped first. Reorder
   hip04_remove() so that the netdev is unregistered (running .ndo_stop)
   before the PHY is disconnected and the TX/RX rings are freed. Check the
   return value of hip04_mac_open() in the tx-timeout restart path.

v2: https://lore.kernel.org/netdev/20260710015730.630775-1-fanwu01@zju.edu.cn/
v1: https://lore.kernel.org/netdev/20260703050133.2445155-1-fanwu01@zju.edu.cn/

 drivers/net/ethernet/hisilicon/hip04_eth.c | 107 ++++++++++++++++++++++++++----
 1 file changed, 96 insertions(+), 11 deletions(-)

diff --git a/drivers/net/ethernet/hisilicon/hip04_eth.c b/drivers/net/ethernet/hisilicon/hip04_eth.c
index 18376bcc7..4bd192094 100644
--- a/drivers/net/ethernet/hisilicon/hip04_eth.c
+++ b/drivers/net/ethernet/hisilicon/hip04_eth.c
@@ -15,6 +15,7 @@
 #include <linux/of_net.h>
 #include <linux/mfd/syscon.h>
 #include <linux/regmap.h>
+#include <linux/mutex.h>
 
 #define SC_PPE_RESET_DREQ		0x026C
 
@@ -232,6 +233,8 @@ struct hip04_priv {
 	int tx_coalesce_frames;
 	int tx_coalesce_usecs;
 	struct hrtimer tx_coalesce_timer;
+	bool closing;
+	struct mutex state_lock; /* Serializes MAC open/stop and timeout recovery. */
 
 	unsigned char *rx_buf[RX_DESC_NUM];
 	dma_addr_t rx_phys[RX_DESC_NUM];
@@ -497,6 +500,12 @@ static void hip04_start_tx_timer(struct hip04_priv *priv)
 {
 	unsigned long ns = priv->tx_coalesce_usecs * NSEC_PER_USEC / 2;
 
+	/* Do not (re-)arm the Tx coalesce timer once teardown has begun.
+	 * Both arming sites (Tx and NAPI Rx poll) go through here.
+	 */
+	if (smp_load_acquire(&priv->closing))
+		return;
+
 	/* allow timer to fire after half the time at the earliest */
 	hrtimer_start_range_ns(&priv->tx_coalesce_timer, ns_to_ktime(ns),
 			       ns, HRTIMER_MODE_REL);
@@ -649,12 +658,15 @@ static int hip04_rx_poll(struct napi_struct *napi, int budget)
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
 
@@ -720,7 +732,7 @@ static void hip04_adjust_link(struct net_device *ndev)
 	}
 }
 
-static int hip04_mac_open(struct net_device *ndev)
+static int __hip04_mac_open(struct net_device *ndev)
 {
 	struct hip04_priv *priv = netdev_priv(ndev);
 	int i;
@@ -743,6 +755,13 @@ static int hip04_mac_open(struct net_device *ndev)
 		hip04_set_recv_desc(priv, phys);
 	}
 
+	/* RX mappings are established; clear the closing flag before
+	 * re-enabling traffic.  The store-release pairs with the load-acquire
+	 * in hip04_start_tx_timer(); state_lock serializes this against
+	 * mac_stop()'s store-release.
+	 */
+	smp_store_release(&priv->closing, false);
+
 	if (priv->phy)
 		phy_start(priv->phy);
 
@@ -754,13 +773,42 @@ static int hip04_mac_open(struct net_device *ndev)
 	return 0;
 }
 
-static int hip04_mac_stop(struct net_device *ndev)
+static int hip04_mac_open(struct net_device *ndev)
+{
+	struct hip04_priv *priv = netdev_priv(ndev);
+	int ret;
+
+	mutex_lock(&priv->state_lock);
+	ret = __hip04_mac_open(ndev);
+	mutex_unlock(&priv->state_lock);
+	return ret;
+}
+
+static int __hip04_mac_stop(struct net_device *ndev)
 {
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
@@ -779,6 +827,16 @@ static int hip04_mac_stop(struct net_device *ndev)
 	return 0;
 }
 
+static int hip04_mac_stop(struct net_device *ndev)
+{
+	struct hip04_priv *priv = netdev_priv(ndev);
+
+	mutex_lock(&priv->state_lock);
+	__hip04_mac_stop(ndev);
+	mutex_unlock(&priv->state_lock);
+	return 0;
+}
+
 static void hip04_timeout(struct net_device *ndev, unsigned int txqueue)
 {
 	struct hip04_priv *priv = netdev_priv(ndev);
@@ -791,8 +849,23 @@ static void hip04_tx_timeout_task(struct work_struct *work)
 	struct hip04_priv *priv;
 
 	priv = container_of(work, struct hip04_priv, tx_timeout_task);
-	hip04_mac_stop(priv->ndev);
-	hip04_mac_open(priv->ndev);
+
+	/* Serialize the restart with .ndo_open/.ndo_stop, which take the
+	 * same lock.  If a close has completed or is in progress the
+	 * netif_running() check bails; if that check races the core's
+	 * running-state clear, .ndo_stop still runs under state_lock
+	 * afterwards and stops the device, so this worker cannot leave the
+	 * MAC re-enabled against a teardown.
+	 */
+	mutex_lock(&priv->state_lock);
+	if (!netif_running(priv->ndev))
+		goto out;
+
+	__hip04_mac_stop(priv->ndev);
+	if (__hip04_mac_open(priv->ndev))
+		netdev_err(priv->ndev, "restart after tx timeout failed\n");
+out:
+	mutex_unlock(&priv->state_lock);
 }
 
 static int hip04_get_coalesce(struct net_device *netdev,
@@ -983,6 +1056,7 @@ static int hip04_mac_probe(struct platform_device *pdev)
 	}
 
 	INIT_WORK(&priv->tx_timeout_task, hip04_tx_timeout_task);
+	mutex_init(&priv->state_lock);
 
 	ndev->netdev_ops = &hip04_netdev_ops;
 	ndev->ethtool_ops = &hip04_ethtool_ops;
@@ -1026,13 +1100,24 @@ static void hip04_remove(struct platform_device *pdev)
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
 

