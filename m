Received: from mail-m49197.qiye.163.com (mail-m49197.qiye.163.com [45.254.49.197])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 70F31539774;
	Tue, 22 Sep 2026 11:07:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.254.49.197
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790075265; cv=none; b=QR4HHAUhTDvebxzhVBMKSy55K2XXs0Vura4Vl12Uain/ddRcxvR2tlj6FamqmUhaCFj21YXI346O/eEMLRQS/r+P39OkxVLZdEOiM2x5XFc1vQo1n8eTQnH2zm5OF7fRJAmp9Qr9QbqjErllY4ZnCO3uMs9z9W+QjSgpGC+tYUw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790075265; c=relaxed/simple;
	bh=SHvtGxXgNMvGyygQAiQ1q6w0L9s2Np1w5ba1MsQivro=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=fU0G5QK4WfVI1uDGR05uV6AVBKqIJm4FNrjqFtNqOxO0GGfNUW8RUCWvmhiUd5XGxcOu2EvEK3LgF4qRk8HDQBTY9M2GjVprt/YIEwbsi67mSxlmGm0rHa8fE96KV+dESoBZ2paJVAroLJF8VBbBFo3g6f7Gb9d1VaGD5JtXyN8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=seu.edu.cn; spf=pass smtp.mailfrom=seu.edu.cn; dkim=pass (1024-bit key) header.d=seu.edu.cn header.i=@seu.edu.cn header.b=YErEVXBR; arc=none smtp.client-ip=45.254.49.197
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=seu.edu.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=seu.edu.cn
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=seu.edu.cn header.i=@seu.edu.cn header.b="YErEVXBR"
Received: from PC-202605011814.localdomain (unknown [222.191.246.242])
	by smtp.qiye.163.com (Hmail) with ESMTP id 4eb93f492;
	Tue, 22 Sep 2026 19:07:29 +0800 (GMT+08:00)
From: Runyu Xiao <runyu.xiao@seu.edu.cn>
To: Ronak Doshi <ronak.doshi@broadcom.com>
Cc: Broadcom internal kernel review list <bcm-kernel-feedback-list@broadcom.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org,
	Runyu Xiao <runyu.xiao@seu.edu.cn>,
	Jianhao Xu <jianhao.xu@seu.edu.cn>
Subject: [PATCH net] net: vmxnet3: unwind partial IRQ setup
Date: Tue, 22 Sep 2026 19:07:10 +0800
Message-Id: <20260922110710.1569410-1-runyu.xiao@seu.edu.cn>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-HM-Tid: 0aa0c8cca4df03a1kunm2435552e8ccfb
X-HM-MType: 10
X-HM-Spam-Status: e1kfGhgUHx5ZQUpXWQgPGg8OCBgUHx5ZQUlOS1dZFg8aDwILHllBWSg2Ly
	tZV1koWUFITzdXWRgWCB1ZQUpXWS1ZQUlXWQ8JGhUIEh9ZQVkaSE8eVhkfSR8dT09LHR8fSlYeHw
	5VEwETFhoSFyQUDg9ZV1kYEgtZQVlJSUlVSkJKVUlPTVVJT0lZV1kWGg8SFR0UWUFZT0tIVUpLSE
	pPSExVSktLVUpCS0tZBg++
DKIM-Signature: a=rsa-sha256;
	b=YErEVXBRrBFGGmGslHOHm++mhQzQIPwnL1/Pl1Xdf/PsJBtebymeKrQDpOe3Umzwc9iIJHVoZarqYwY+NoZg6qEluw30PeIJ20IlV22eDN3/j25lk9gTFyut08ScZ4npOyT9KHMM+v9jRr0Riw4aDNvCAPbrlXF/8jsw2L6Neds=; c=relaxed/relaxed; s=default; d=seu.edu.cn; v=1;
	bh=4Vt4GYyH3vk6ruOLyiToHUHMMB3orGntk58ZnG778Vs=;
	h=date:mime-version:subject:message-id:from;

Track which interrupt vectors successfully acquired an IRQ handler and
release that subset when a later request fails. This prevents activation
error paths from leaving handlers registered while queue resources are
being torn down.

Reproducer:

  Build an x86_64 kernel with CONFIG_PCI=y, CONFIG_PCI_MSI=y,
  CONFIG_NET=y, CONFIG_NETDEVICES=y, and CONFIG_VMXNET3=m. For testing,
  add a test-only wrapper around vmxnet3_request_irqs() that lets the
  first request_irq() succeed and returns -EBUSY for the second request.
  Boot QEMU with a vmxnet3 device, for example:

    qemu-system-x86_64 -machine pc -m 1G -smp 2 -nodefaults \
      -no-reboot -display none -serial file:console.log \
      -kernel arch/x86/boot/bzImage -initrd test.cpio.gz \
      -append 'console=ttyS0 rdinit=/init loglevel=7 panic=1' \
      -netdev user,id=n0 -device vmxnet3,netdev=n0

  In the guest, load the driver and open the interface:

    insmod vmxnet3.ko
    ip link set dev eth0 up
    cat /proc/interrupts

  The injected second request makes the open fail with -EBUSY. On the
  unfixed kernel, the first handler remains registered and
  /proc/interrupts contains an eth0-rxtx-0 entry. On the fixed kernel,
  the same failure leaves no vmxnet3 IRQ entry. The injection is
  deliberate to exercise the partial-registration path and is not a
  claim that ordinary interface activation fails this way.

Fixes: d1a890fa37f2 ("net: VMware virtual Ethernet NIC driver: vmxnet3")
Cc: stable@vger.kernel.org
Assisted-by: LLM
Signed-off-by: Runyu Xiao <runyu.xiao@seu.edu.cn>
---
 drivers/net/vmxnet3/vmxnet3_drv.c | 38 ++++++++++++++++++++++++-------
 drivers/net/vmxnet3/vmxnet3_int.h |  1 +
 2 files changed, 31 insertions(+), 8 deletions(-)

diff --git a/drivers/net/vmxnet3/vmxnet3_drv.c b/drivers/net/vmxnet3/vmxnet3_drv.c
index f8df83f99..05373ba4d 100644
--- a/drivers/net/vmxnet3/vmxnet3_drv.c
+++ b/drivers/net/vmxnet3/vmxnet3_drv.c
@@ -53,6 +53,9 @@ static int enable_mq = 1;
 static void
 vmxnet3_write_mac_addr(struct vmxnet3_adapter *adapter, const u8 *mac);
 
+static void
+vmxnet3_free_irqs(struct vmxnet3_adapter *adapter);
+
 /*
  *    Enable/Disable the given intr
  */
@@ -2585,8 +2588,11 @@ vmxnet3_request_irqs(struct vmxnet3_adapter *adapter)
 					"Failed to request irq for MSIX, %s, "
 					"error %d\n",
 					adapter->tx_queue[i].name, err);
+				vmxnet3_free_irqs(adapter);
 				return err;
 			}
+			if (adapter->share_intr != VMXNET3_INTR_BUDDYSHARE)
+				intr->irq_requested[vector] = true;
 
 			/* Handle the case where only 1 MSIx was allocated for
 			 * all tx queues */
@@ -2620,8 +2626,10 @@ vmxnet3_request_irqs(struct vmxnet3_adapter *adapter)
 					   "Failed to request irq for MSIX, "
 					   "%s, error %d\n",
 					   adapter->rx_queue[i].name, err);
+				vmxnet3_free_irqs(adapter);
 				return err;
 			}
+			intr->irq_requested[vector] = true;
 
 			adapter->rx_queue[i].comp_ring.intr_idx = vector++;
 		}
@@ -2631,6 +2639,8 @@ vmxnet3_request_irqs(struct vmxnet3_adapter *adapter)
 		err = request_irq(intr->msix_entries[vector].vector,
 				  vmxnet3_msix_event, 0,
 				  intr->event_msi_vector_name, adapter->netdev);
+		if (!err)
+			intr->irq_requested[vector] = true;
 		intr->event_intr_idx = vector;
 
 	} else if (intr->type == VMXNET3_IT_MSI) {
@@ -2646,11 +2656,14 @@ vmxnet3_request_irqs(struct vmxnet3_adapter *adapter)
 #ifdef CONFIG_PCI_MSI
 	}
 #endif
+	if (intr->type != VMXNET3_IT_MSIX && !err)
+		intr->irq_requested[0] = true;
 	intr->num_intrs = vector + 1;
 	if (err) {
 		netdev_err(adapter->netdev,
 			   "Failed to request irq (intr type:%d), error %d\n",
 			   intr->type, err);
+		vmxnet3_free_irqs(adapter);
 	} else {
 		/* Number of rx queues will not change after this */
 		for (i = 0; i < adapter->num_rx_queues; i++) {
@@ -2693,29 +2706,38 @@ vmxnet3_free_irqs(struct vmxnet3_adapter *adapter)
 
 		if (adapter->share_intr != VMXNET3_INTR_BUDDYSHARE) {
 			for (i = 0; i < adapter->num_tx_queues; i++) {
-				free_irq(intr->msix_entries[vector++].vector,
-					 &(adapter->tx_queue[i]));
+				if (intr->irq_requested[vector])
+					free_irq(intr->msix_entries[vector].vector,
+						 &adapter->tx_queue[i]);
+				intr->irq_requested[vector++] = false;
 				if (adapter->share_intr == VMXNET3_INTR_TXSHARE)
 					break;
 			}
 		}
 
 		for (i = 0; i < adapter->num_rx_queues; i++) {
-			free_irq(intr->msix_entries[vector++].vector,
-				 &(adapter->rx_queue[i]));
+			if (intr->irq_requested[vector])
+				free_irq(intr->msix_entries[vector].vector,
+					 &adapter->rx_queue[i]);
+			intr->irq_requested[vector++] = false;
 		}
 
-		free_irq(intr->msix_entries[vector].vector,
-			 adapter->netdev);
+		if (intr->irq_requested[vector])
+			free_irq(intr->msix_entries[vector].vector, adapter->netdev);
+		intr->irq_requested[vector] = false;
 		BUG_ON(vector >= intr->num_intrs);
 		break;
 	}
 #endif
 	case VMXNET3_IT_MSI:
-		free_irq(adapter->pdev->irq, adapter->netdev);
+		if (intr->irq_requested[0])
+			free_irq(adapter->pdev->irq, adapter->netdev);
+		intr->irq_requested[0] = false;
 		break;
 	case VMXNET3_IT_INTX:
-		free_irq(adapter->pdev->irq, adapter->netdev);
+		if (intr->irq_requested[0])
+			free_irq(adapter->pdev->irq, adapter->netdev);
+		intr->irq_requested[0] = false;
 		break;
 	default:
 		BUG();
diff --git a/drivers/net/vmxnet3/vmxnet3_int.h b/drivers/net/vmxnet3/vmxnet3_int.h
index 9f24d66db..93c545eb6 100644
--- a/drivers/net/vmxnet3/vmxnet3_int.h
+++ b/drivers/net/vmxnet3/vmxnet3_int.h
@@ -362,6 +362,7 @@ struct vmxnet3_intr {
 	enum vmxnet3_intr_type       type;	/* MSI-X, MSI, or INTx? */
 	u8  num_intrs;			/* # of intr vectors */
 	u8  event_intr_idx;		/* idx of the intr vector for event */
+	bool irq_requested[VMXNET3_LINUX_MAX_MSIX_VECT];
 	u8  mod_levels[VMXNET3_LINUX_MAX_MSIX_VECT]; /* moderation level */
 	char	event_msi_vector_name[IFNAMSIZ+17];
 #ifdef CONFIG_PCI_MSI
-- 
2.34.1
