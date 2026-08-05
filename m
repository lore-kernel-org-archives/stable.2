Received: from azure-sdnproxy.icoremail.net (azure-sdnproxy.icoremail.net [52.237.72.81])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 48BE3305678;
	Wed,  5 Aug 2026 01:16:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=52.237.72.81
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785892601; cv=none; b=Iko8o4GI8US+fVKPWzhcp1PVbNr5zpgzngBStT9xdYOfQqeCl1JVjfGRwNA8suTJ0EW2+GSTEHO6EoqjP1E0zioUGXGMe1OX4i7VqpVz9Q6FGOH3RUacV+cLdu1fkVS0lUkeVJaU5u23Q0HA9mBXOQ05Sap5CWmhDN1ArGI/pjk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785892601; c=relaxed/simple;
	bh=XxZiliwWMsjRBj6o7LvGEYht/qOzQr8nbQOzvAS6Nss=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=UrynLL0RPFis7YLp2q8Pxfu1+nCT8oQIa/Pg41nRWdf7W3WvIDTYN5MUIoqyo/AUBW3DouqIW7SfnTbyCdR+2jzCU6LM9AFF9RWOeOhJ5W5UkuoZ3uH/h2eI6Wk3ItRDLXpsG7im79zYZ4/T5QSS6vU2FJ3vESIsr9xsh/cs+8k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=zju.edu.cn; spf=pass smtp.mailfrom=zju.edu.cn; arc=none smtp.client-ip=52.237.72.81
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=zju.edu.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=zju.edu.cn
Received: from zju.edu.cn (unknown [10.98.66.117])
	by mtasvr (Coremail) with SMTP id _____wD3_z_bjnJqH_JmAA--.15572S3;
	Wed, 05 Aug 2026 09:16:12 +0800 (CST)
Received: from localhost.localdomain (unknown [10.98.66.117])
	by mail-app3 (Coremail) with SMTP id zS_KCgB3j3HajnJqnhH2Aw--.48215S2;
	Wed, 05 Aug 2026 09:16:10 +0800 (CST)
From: Fan Wu <fanwu01@zju.edu.cn>
To: netdev@vger.kernel.org
Cc: davem@davemloft.net,
	kuba@kernel.org,
	edumazet@google.com,
	pabeni@redhat.com,
	andrew+netdev@lunn.ch,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org,
	Fan Wu <fanwu01@zju.edu.cn>
Subject: [PATCH net 1/2] fjes: unregister the netdev before destroying the workqueues
Date: Wed,  5 Aug 2026 01:14:09 +0000
Message-Id: <20260805011410.414431-1-fanwu01@zju.edu.cn>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:zS_KCgB3j3HajnJqnhH2Aw--.48215S2
X-CM-SenderInfo: qrstjiaswqq6lmxovvfxof0/
X-CM-DELIVERINFO: =?B?P5ek3gXKKxbFmtjJiESix3B1w3vZ3A9ovKVTomAyoQazvoRs/NHSP8GI2EvgeEEW7R
	sfnZPoDCNGYdHSfuFmYJL54WNtc0XRFDKAgP1T1yFwOxJk4pbhgJdp6eiUdl/s9fmIWYxP
	t0qCEI3EXzpTlIvTfXGp9E6mavGmQbzmcFsnzP86
X-Coremail-Antispam: 1Uk129KBj93XoW7Cr47GF4fJF1rWr47CFyDurX_yoW8AFWfpF
	45Ga4UtrWktF45K39rJa18tFy8GF4xK3yjk3yUJa1fu3sIyr1UZ34YkFy0qF1rWF95ZF4a
	vFn0v3yDW3s8GrXCm3ZEXasCq-sJn29KB7ZKAUJUUUUU529EdanIXcx71UUUUU7KY7ZEXa
	sCq-sGcSsGvfJ3Ic02F40EFcxC0VAKzVAqx4xG6I80ebIjqfuFe4nvWSU5nxnvy29KBjDU
	0xBIdaVrnRJUUU9Gb4IE77IF4wAFF20E14v26r4j6ryUM7CY07I20VC2zVCF04k26cxKx2
	IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48v
	e4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_tr0E3s1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI
	0_Gr1j6F4UJwA2z4x0Y4vEx4A2jsIE14v26rxl6s0DM28EF7xvwVC2z280aVCY1x0267AK
	xVW0oVCq3wAac4AC62xK8xCEY4vEwIxC4wAS0I0E0xvYzxvE52x082IY62kv0487Mc804V
	CY07AIYIkI8VC2zVCFFI0UMc02F40EFcxC0VAKzVAqx4xG6I80ewAv7VC0I7IYx2IY67AK
	xVWUJVWUGwAv7VC2z280aVAFwI0_Jr0_Gr1lOx8S6xCaFVCjc4AY6r1j6r4UM4x0Y48Icx
	kI7VAKI48JM4x0Y48IcxkI7VAKI48G6xCjnVAKz4kxMxAIw28IcxkI7VAKI48JMxC20s02
	6xCaFVCjc4AY6r1j6r4UMI8I3I0E5I8CrVAFwI0_Jr0_Jr4lx2IqxVCjr7xvwVAFwI0_Jr
	I_JrWlx4CE17CEb7AF67AKxVWUtVW8ZwCIc40Y0x0EwIxGrwCI42IY6xIIjxv20xvE14v2
	6r1j6r1xMIIF0xvE2Ix0cI8IcVCY1x0267AKxVWUJVW8JwCI42IY6xAIw20EY4v20xvaj4
	0_Jr0_JF4lIxAIcVC2z280aVAFwI0_Jr0_Gr1lIxAIcVC2z280aVCY1x0267AKxVW8JVW8
	JrUvcSsGvfC2KfnxnUUI43ZEXa7IU85l1PUUUUU==

fjes_remove() destroys the driver workqueues before unregistering the
netdev. The interrupt handler queues work on them, but the IRQ is only
freed from fjes_close() under unregister_netdev(), so an interrupt in that
window can queue work once the workqueues are gone.

Unregister the netdev first so fjes_close() frees the IRQ and cancels the
workers before the workqueues are destroyed. force_close_task, which the
workers arm on the system workqueue, is handled in the next patch.

This issue was found by an in-house static analysis tool.

Fixes: 658d439b2292 ("fjes: Introduce FUJITSU Extended Socket Network Device driver")
Cc: stable@vger.kernel.org
Assisted-by: Codex:gpt-5.6
Signed-off-by: Fan Wu <fanwu01@zju.edu.cn>
---
 drivers/net/fjes/fjes_main.c | 9 +++------
 1 file changed, 3 insertions(+), 6 deletions(-)

diff --git a/drivers/net/fjes/fjes_main.c b/drivers/net/fjes/fjes_main.c
index 1f0f38980..cddabc965 100644
--- a/drivers/net/fjes/fjes_main.c
+++ b/drivers/net/fjes/fjes_main.c
@@ -1394,17 +1394,14 @@ static void fjes_remove(struct platform_device *plat_dev)
 
 	fjes_dbg_adapter_exit(adapter);
 
-	cancel_delayed_work_sync(&adapter->interrupt_watch_task);
-	cancel_work_sync(&adapter->unshare_watch_task);
-	cancel_work_sync(&adapter->raise_intr_rxdata_task);
-	cancel_work_sync(&adapter->tx_stall_task);
+	/* Unregister first: .ndo_stop frees the IRQ and cancels the workers. */
+	unregister_netdev(netdev);
+
 	if (adapter->control_wq)
 		destroy_workqueue(adapter->control_wq);
 	if (adapter->txrx_wq)
 		destroy_workqueue(adapter->txrx_wq);
 
-	unregister_netdev(netdev);
-
 	fjes_hw_exit(hw);
 
 	netif_napi_del(&adapter->napi);
-- 
2.34.1

