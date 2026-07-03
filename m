Received: from zg8tmtyylji0my4xnjqumte4.icoremail.net (zg8tmtyylji0my4xnjqumte4.icoremail.net [162.243.164.118])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DCB3E346E60;
	Fri,  3 Jul 2026 05:03:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=162.243.164.118
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783055029; cv=none; b=o0Q2pLj3WC4xtMQ/z+UkwGqlHH+nttY3PK1WfG86iuBWsAiNZd8YSwOunjyVZL+o+O4L2jj3sijJQG81Kse099yXxq6H7it06DM3tHDeCGL9f7TJef+isNId71WTskEv6grl0Zjr/Ua7zY1fz5wdihE2Qcww1lY3OGy8UqWihe0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783055029; c=relaxed/simple;
	bh=XuAkwMQLiDTOuqdGjbfLJAtaJbzsqn7J3Vva0H9Ss7M=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=dvhUxXm2qD/GxmGe2TF4n0q6ZxiZWL4XZYRGw5yADGyL3hVByuup9zfzSAv5eHac0fZuZBw6UXhG6ub9l4YrbiEOESxiC+BPS9fYdjbfI7i5ULD9Z36rrx/1+rLgSQBeUMCMtN+Iv4mY5KUgZb/8dkcSSwFXZd6CVgOawpmwmoU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=zju.edu.cn; spf=pass smtp.mailfrom=zju.edu.cn; arc=none smtp.client-ip=162.243.164.118
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=zju.edu.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=zju.edu.cn
Received: from zju.edu.cn (unknown [10.98.66.117])
	by mtasvr (Coremail) with SMTP id _____wA3UVmdQkdqvQYAAA--.68S3;
	Fri, 03 Jul 2026 13:03:26 +0800 (CST)
Received: from localhost.localdomain (unknown [10.98.66.117])
	by mail-app3 (Coremail) with SMTP id zS_KCgCHcndkQkdq6c3KAg--.21423S2;
	Fri, 03 Jul 2026 13:02:28 +0800 (CST)
From: Fan Wu <fanwu01@zju.edu.cn>
To: netdev@vger.kernel.org
Cc: shenjian15@huawei.com,
	salil.mehta@huawei.com,
	andrew+netdev@lunn.ch,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org,
	Fan Wu <fanwu01@zju.edu.cn>
Subject: [PATCH] net: hip04: quiesce tx coalesce timer before teardown
Date: Fri,  3 Jul 2026 05:01:33 +0000
Message-Id: <20260703050133.2445155-1-fanwu01@zju.edu.cn>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:zS_KCgCHcndkQkdq6c3KAg--.21423S2
X-CM-SenderInfo: qrstjiaswqq6lmxovvfxof0/
X-CM-DELIVERINFO: =?B?/0WH1gXKKxbFmtjJiESix3B1w3vZ3A9ovKVTomAyoQazvoRs/NHSP8GI2EvgeEEW7R
	sfnZPoDCNGYdHSfuFmYJL54WMVfScoz1GQkz7Jrk8/nqQJcpY11kKBiwOKJAC2sjCqpSvc
	IZLUjRXXY3mEfk5bYd2p9E6mavGmQbzmcFsnzP86
X-Coremail-Antispam: 1Uk129KBj93XoWxWF1DKFyktFWkCr4ruw1fKrX_yoW5Zry3pa
	y5KayxKF4vyrWaqrWkAF4UtFy8ta1UJFWkG3W8G39Y9wnIyr10qrWkKFW5XF48AFWvyFZI
	9r4F9w4DurZ8J3gCm3ZEXasCq-sJn29KB7ZKAUJUUUUU529EdanIXcx71UUUUU7KY7ZEXa
	sCq-sGcSsGvfJ3Ic02F40EFcxC0VAKzVAqx4xG6I80ebIjqfuFe4nvWSU5nxnvy29KBjDU
	0xBIdaVrnRJUUUPjb4IE77IF4wAFF20E14v26r4j6ryUM7CY07I20VC2zVCF04k26cxKx2
	IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48v
	e4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_tr0E3s1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI
	0_Gr1j6F4UJwA2z4x0Y4vEx4A2jsIE14v26rxl6s0DM28EF7xvwVC2z280aVCY1x0267AK
	xVW0oVCq3wAac4AC62xK8xCEY4vEwIxC4wAS0I0E0xvYzxvE52x082IY62kv0487Mc804V
	CY07AIYIkI8VC2zVCFFI0UMc02F40EFcxC0VAKzVAqx4xG6I80ewAv7VC0I7IYx2IY67AK
	xVWUJVWUGwAv7VC2z280aVAFwI0_Jr0_Gr1lOx8S6xCaFVCjc4AY6r1j6r4UM4x0Y48Icx
	kI7VAKI48JM4x0Y48IcxkI7VAKI48G6xCjnVAKz4kxM4IIrI8v6xkF7I0E8cxan2IY04v7
	MxAIw28IcxkI7VAKI48JMxC20s026xCaFVCjc4AY6r1j6r4UMI8I3I0E5I8CrVAFwI0_Jr
	0_Jr4lx2IqxVCjr7xvwVAFwI0_JrI_JrWlx4CE17CEb7AF67AKxVWUtVW8ZwCIc40Y0x0E
	wIxGrwCI42IY6xIIjxv20xvE14v26r1j6r1xMIIF0xvE2Ix0cI8IcVCY1x0267AKxVWUJV
	W8JwCI42IY6xAIw20EY4v20xvaj40_Jr0_JF4lIxAIcVC2z280aVAFwI0_Jr0_Gr1lIxAI
	cVC2z280aVCY1x0267AKxVWUJVW8JbIYCTnIWIevJa73UjIFyTuYvjxU7gAwDUUUU

hip04_start_tx_timer() arms priv->tx_coalesce_timer from both the
TX path and the NAPI poll path. The timer callback, tx_done(), derives
priv from the timer and touches priv->napi, priv->reg_inten and
priv->base before scheduling NAPI.

The remove path currently frees the TX/RX rings before unregistering the
netdev. If the interface is still up, unregister_netdev() will run
.ndo_stop only after those rings have already been freed, while a pending
TX coalesce timer or NAPI instance can still reach the ring state. The
timer is also never cancelled before free_netdev() releases the netdev
private area.

Cancel the timer from hip04_mac_stop() after NAPI and the TX queue have
been disabled. In hip04_remove(), unregister the netdev first, drain the
timeout work and timer, and only then free the rings.

hip04_tx_timeout_task() can also restart the device by calling
hip04_mac_stop() followed by hip04_mac_open(). Serialize that restart with
rtnl_lock(), matching the netdev core's .ndo_stop locking, and skip it if
the device is no longer running.

Fixes: a41ea46a9a12 ("net: hisilicon: new hip04 ethernet driver")
Cc: stable@vger.kernel.org
Signed-off-by: Fan Wu <fanwu01@zju.edu.cn>
---
diff --git a/drivers/net/ethernet/hisilicon/hip04_eth.c b/drivers/net/ethernet/hisilicon/hip04_eth.c
index 18376bc..cb9b01c 100644
--- a/drivers/net/ethernet/hisilicon/hip04_eth.c
+++ b/drivers/net/ethernet/hisilicon/hip04_eth.c
@@ -15,6 +15,7 @@
 #include <linux/of_net.h>
 #include <linux/mfd/syscon.h>
 #include <linux/regmap.h>
+#include <linux/rtnetlink.h>
 
 #define SC_PPE_RESET_DREQ		0x026C
 
@@ -761,6 +762,13 @@ static int hip04_mac_stop(struct net_device *ndev)
 
 	napi_disable(&priv->napi);
 	netif_stop_queue(ndev);
+
+	/* Cancel the TX-coalesce timer after the arming paths (xmit via the
+	 * queue, rx poll via NAPI) are disabled, so a pending tx_done()
+	 * (which dereferences priv) is drained before the device is freed.
+	 */
+	hrtimer_cancel(&priv->tx_coalesce_timer);
+
 	hip04_mac_disable(ndev);
 	hip04_tx_reclaim(ndev, true);
 	hip04_reset_ppe(priv);
@@ -791,8 +799,15 @@ static void hip04_tx_timeout_task(struct work_struct *work)
 	struct hip04_priv *priv;
 
 	priv = container_of(work, struct hip04_priv, tx_timeout_task);
+
+	rtnl_lock();
+	if (!netif_running(priv->ndev))
+		goto out;
+
 	hip04_mac_stop(priv->ndev);
 	hip04_mac_open(priv->ndev);
+out:
+	rtnl_unlock();
 }
 
 static int hip04_get_coalesce(struct net_device *netdev,
@@ -1029,10 +1044,15 @@ static void hip04_remove(struct platform_device *pdev)
 	if (priv->phy)
 		phy_disconnect(priv->phy);
 
-	hip04_free_ring(ndev, d);
 	unregister_netdev(ndev);
-	of_node_put(priv->phy_node);
 	cancel_work_sync(&priv->tx_timeout_task);
+	hrtimer_cancel(&priv->tx_coalesce_timer);
+	/* Free the rings only after the interface is stopped (.ndo_stop via
+	 * unregister_netdev) and the work/timer are drained; the TX/NAPI
+	 * paths touch them while the device is up.
+	 */
+	hip04_free_ring(ndev, d);
+	of_node_put(priv->phy_node);
 	free_netdev(ndev);
 }
 

