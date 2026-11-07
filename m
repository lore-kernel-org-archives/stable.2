Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794048116;
	b=3oEMXkDeWczXwsgrjfDoDuLjEy4A6QhieW9yaa+QXYkKfYjUNGWMkOh5UZV5sKRarN/H
	 wS2Pvogf25fzQqHKAU+KOVutVgd1wZi6YCTXkRbLw0frontOIDuAcn/YKxnevAG3qCLbn
	 TYzgW16hBH+Xgn5HFO+BM65ja4B5cumeIaAIRNIGmIHsDUmyDYlDxMPieJGN77kuwCA4R
	 XYP45MT69+SG3TMD9tOC6fubJjXR8Dy3sk6s4B2ZaGcsi5KESm2Ij0FCxrr/IP82C/aM1
	 eZEMJT56KD77NQroh//yLTs7SEFaunLH1EZBF+nOSJiCz6Ct1AakcEwh54BNy6oAUzw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794048116;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 MIME-Version:Content-Type:Content-Transfer-Encoding;
	bh=VrV0LMe3iUz3g71O9vhO+EvMKOU3bE9wducyvGYdywM=;
	b=FSlm23oBjkwCXH6+I/DqwhQytm34XdH9iw2L2Pqyr87cozoHYUDQfxJE5KmwJmI2qoyC
	 9TGhmF/VvcXNoQmp6ZjvimRdAYIbJN5jPAFVIal1SGaBJXBqiXM5c0bG2rvof1jNaB2Ls
	 qNdFMXgnJXRT+QYI0ucZw5jsx8vHrADWR2Os6ON9g5XRb7h8wcaryn5kHve06FPSXWGbn
	 eztisnEvyT4knEDhZshl9Fy10Qh/7koyy8kIW/21cQ18xlIzq27NIhRafwmNHMeVK254j
	 tE4jiWAtihc9NCHN2dj7geKKgE6q9+BF0eKVAOdZF/xXTrW57ReVtvoJd7jPKhX3yEA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b="fIn/m0bz";
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 62B1E606A330
	for <stable@vger.kernel.org>; Sat,  7 Nov 2026 10:41:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=fIn/m0bz
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A3DCF1F0089F;
	Sat,  7 Nov 2026 10:41:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794048116;
	bh=VrV0LMe3iUz3g71O9vhO+EvMKOU3bE9wducyvGYdywM=;
	h=From:To:Cc:Subject:Date;
	b=fIn/m0bzdNyizDSyTVnUKU0RxHIeaJUXDns6VqauqsIk4W0oKERusq9X9bVmOnf6O
	 PZRme91ZlIzz7j5o8OW7tsUmODS7IF86PYh7Gqe/gBsKXu7eN1cYHOLU9sqqpB3Efl
	 2sqMJs6G2EthF9rte9P4OQvPpnH4kHw5a1qNNhTwLlRxSBdk3eFxLHyHjH6jxu4LHL
	 NycllP3x4ZXca3yAi2jhyDueTwuRacQchsuNCR0VNDB6F6W5fqTQ1TRML3beE71Ljg
	 FE4pkcKP9fiixs49nqS/VPSDHJawXJ2eSqDhhUkAv30po7mP4qjqDz7QByBFuPc2cx
	 /EMDrfS6Oc1SA==
From: Sasha Levin <sashal@kernel.org>
To: den@valinux.co.jp,
	manivannan.sadhasivam@oss.qualcomm.com,
	bhelgaas@google.com,
	frank.li@nxp.com
Cc: stable@vger.kernel.org
Subject: FAILED: patch "[PATCH] PCI: endpoint: pci-epf-vntb: Manage virtual NTB and PCI bus lifetime" failed to apply to 6.1-stable tree
Date: Sat,  7 Nov 2026 05:41:54 -0500
Message-ID: <20261107054154-failed-6.1-5cdbd6d3a3a1@kernel.org>
X-Mailer: git-send-email 2.53.0
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

The patch below does not apply to the 6.1-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-6.1.y
git checkout FETCH_HEAD
git cherry-pick -x 5cdbd6d3a3a147fa9975e35f2602cbec9a72a932
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '20261107054154-failed-6.1-5cdbd6d3a3a1@kernel.org' --subject-prefix 'PATCH 6.1.y' 'HEAD^..'

Thanks,
Sasha

------------------ original commit in Linus's tree ------------------

From 5cdbd6d3a3a147fa9975e35f2602cbec9a72a932 Mon Sep 17 00:00:00 2001
From: Koichiro Den <den@valinux.co.jp>
Date: Tue, 1 Sep 2026 15:32:38 +0900
Subject: [PATCH] PCI: endpoint: pci-epf-vntb: Manage virtual NTB and PCI bus
 lifetime

The virtual PCI driver registers an ntb_dev but has no remove callback.
Unbinding the endpoint function can therefore free BARs while the NTB
device and its client still use them. It also leaves the virtual PCI
devices and root bus allocated.

Allocate an ntb_dev for each virtual PCI probe and unregister it from the
matching remove callback. Start command processing only after registration.
Publish the device for doorbell IRQs at the same point. During remove, stop
the command work and drain IRQ handlers before unregistering the device.

Retain the root bus returned by pci_scan_bus() so it can be removed on
unbind. Unregister the virtual PCI driver before releasing endpoint
resources. Stop and remove the root bus under the PCI rescan/remove lock,
then release its host bridge.

Fixes: e35f56bb0330 ("PCI: endpoint: Support NTB transfer between RC and EP")
Signed-off-by: Koichiro Den <den@valinux.co.jp>
Signed-off-by: Manivannan Sadhasivam <manivannan.sadhasivam@oss.qualcomm.com>
Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>
Reviewed-by: Frank Li <Frank.Li@nxp.com>
Cc: stable@vger.kernel.org # 6.0+
Link: https://patch.msgid.link/20260901063238.631166-3-den@valinux.co.jp
---
 drivers/pci/endpoint/functions/pci-epf-vntb.c | 85 +++++++++++++++----
 1 file changed, 70 insertions(+), 15 deletions(-)

diff --git a/drivers/pci/endpoint/functions/pci-epf-vntb.c b/drivers/pci/endpoint/functions/pci-epf-vntb.c
index 544e00bdf50fb..07ba338732d4e 100644
--- a/drivers/pci/endpoint/functions/pci-epf-vntb.c
+++ b/drivers/pci/endpoint/functions/pci-epf-vntb.c
@@ -132,7 +132,7 @@ struct epf_ntb_ctrl {
 } __packed;
 
 struct epf_ntb {
-	struct ntb_dev ntb;
+	struct ntb_dev *ntb;
 	struct pci_epf *epf;
 	struct config_group group;
 
@@ -166,10 +166,15 @@ struct epf_ntb {
 	void __iomem *vpci_mw_addr[MAX_MW];
 
 	struct delayed_work cmd_handler;
+	struct pci_bus *vpci_bus;
 };
 
 #define to_epf_ntb(epf_group) container_of((epf_group), struct epf_ntb, group)
-#define ntb_ndev(__ntb) container_of(__ntb, struct epf_ntb, ntb)
+
+static struct epf_ntb *ntb_ndev(struct ntb_dev *ntb)
+{
+	return ntb->pdev->sysdata;
+}
 
 static struct pci_epf_header epf_ntb_header = {
 	.vendorid	= PCI_ANY_ID,
@@ -195,7 +200,7 @@ static int epf_ntb_link_up(struct epf_ntb *ntb, bool link_up)
 	else
 		ntb->reg->link_status &= ~LINK_STATUS_UP;
 
-	ntb_link_event(&ntb->ntb);
+	ntb_link_event(ntb->ntb);
 	return 0;
 }
 
@@ -284,7 +289,7 @@ static void epf_ntb_cmd_handler(struct work_struct *work)
 	     i++) {
 		if (ntb->epf_db[i]) {
 			atomic64_or(1 << (i - EPF_IRQ_DB_START), &ntb->db);
-			ntb_db_event(&ntb->ntb, i - EPF_IRQ_DB_START);
+			ntb_db_event(ntb->ntb, i - EPF_IRQ_DB_START);
 			ntb->epf_db[i] = 0;
 		}
 	}
@@ -348,12 +353,18 @@ static void epf_ntb_cmd_handler(struct work_struct *work)
 static irqreturn_t epf_ntb_doorbell_handler(int irq, void *data)
 {
 	struct epf_ntb *ntb = data;
+	struct ntb_dev *ndev;
 	int i;
 
+	/* Pair with smp_store_release() in pci_vntb_probe() */
+	ndev = smp_load_acquire(&ntb->ntb);
+	if (!ndev)
+		return IRQ_HANDLED;
+
 	for (i = EPF_IRQ_DB_START; i < ntb->db_count; i++)
 		if (irq == ntb->epf->db_msg[i].virq) {
 			atomic64_or(1 << (i - EPF_IRQ_DB_START), &ntb->db);
-			ntb_db_event(&ntb->ntb, i - EPF_IRQ_DB_START);
+			ntb_db_event(ndev, i - EPF_IRQ_DB_START);
 		}
 
 	return IRQ_HANDLED;
@@ -985,7 +996,6 @@ static int epf_ntb_epc_init(struct epf_ntb *ntb)
 	}
 
 	INIT_DELAYED_WORK(&ntb->cmd_handler, epf_ntb_cmd_handler);
-	queue_work(kpcintb_workqueue, &ntb->cmd_handler.work);
 
 	atomic64_set(&ntb->peer_db_pending, 0);
 	enable_work(&ntb->peer_db_work);
@@ -1340,6 +1350,7 @@ static int vpci_scan_bus(void *sysdata)
 		pci_unlock_rescan_remove();
 		return -EINVAL;
 	}
+	ndev->vpci_bus = vpci_bus;
 
 	pci_bus_add_devices(vpci_bus);
 
@@ -1425,7 +1436,7 @@ static int vntb_epf_mw_set_trans(struct ntb_dev *ndev, int pidx, int idx,
 	int ret;
 	struct device *dev;
 
-	dev = &ntb->ntb.dev;
+	dev = &ndev->dev;
 	barno = ntb->epf_ntb_bar[BAR_MW1 + idx];
 	epf_bar = &ntb->epf->bar[barno];
 	epf_bar->phys_addr = addr;
@@ -1564,7 +1575,7 @@ static void vntb_epf_peer_db_work(struct work_struct *work)
 			ret = pci_epc_raise_irq(epf->epc, func_no, vfunc_no,
 						PCI_IRQ_MSI, interrupt_num);
 			if (ret)
-				dev_err(&ntb->ntb.dev,
+				dev_err(&epf->dev,
 					"Failed to raise IRQ for interrupt_num %u: %d\n",
 					interrupt_num, ret);
 		}
@@ -1682,13 +1693,18 @@ static const struct ntb_dev_ops vntb_epf_ops = {
 
 static int pci_vntb_probe(struct pci_dev *pdev, const struct pci_device_id *id)
 {
-	int ret;
 	struct epf_ntb *ndev = (struct epf_ntb *)pdev->sysdata;
 	struct device *dev = &pdev->dev;
+	struct ntb_dev *ntb;
+	int ret;
+
+	ntb = devm_kzalloc(dev, sizeof(*ntb), GFP_KERNEL);
+	if (!ntb)
+		return -ENOMEM;
 
-	ndev->ntb.pdev = pdev;
-	ndev->ntb.topo = NTB_TOPO_NONE;
-	ndev->ntb.ops =  &vntb_epf_ops;
+	ntb->pdev = pdev;
+	ntb->topo = NTB_TOPO_NONE;
+	ntb->ops = &vntb_epf_ops;
 
 	ret = dma_set_mask_and_coherent(dev, DMA_BIT_MASK(32));
 	if (ret) {
@@ -1696,16 +1712,41 @@ static int pci_vntb_probe(struct pci_dev *pdev, const struct pci_device_id *id)
 		return ret;
 	}
 
-	ret = ntb_register_device(&ndev->ntb);
+	ret = ntb_register_device(ntb);
 	if (ret) {
 		dev_err(dev, "Failed to register NTB device\n");
 		return ret;
 	}
 
+	/* Publish after ntb_register_device() succeeds */
+	smp_store_release(&ndev->ntb, ntb);
+	queue_delayed_work(kpcintb_workqueue, &ndev->cmd_handler, 0);
+
 	dev_dbg(dev, "PCI Virtual NTB driver loaded\n");
 	return 0;
 }
 
+static void pci_vntb_remove(struct pci_dev *pdev)
+{
+	struct epf_ntb *ndev = pdev->sysdata;
+	struct ntb_dev *ntb;
+	unsigned int i;
+
+	/* Stop the work reader, then close and drain the IRQ gate */
+	cancel_delayed_work_sync(&ndev->cmd_handler);
+
+	ntb = xchg(&ndev->ntb, NULL);
+
+	if (ndev->msi_doorbell)
+		for (i = 0; i < ndev->db_count; i++) {
+			if (epf_ntb_db_irq_is_duplicated(ndev->epf, i))
+				continue;
+			synchronize_irq(ndev->epf->db_msg[i].virq);
+		}
+
+	ntb_unregister_device(ntb);
+}
+
 static struct pci_device_id pci_vntb_table[] = {
 	{
 		PCI_DEVICE(0xffff, 0xffff),
@@ -1717,6 +1758,7 @@ static struct pci_driver vntb_pci_driver = {
 	.name           = "pci-vntb",
 	.id_table       = pci_vntb_table,
 	.probe          = pci_vntb_probe,
+	.remove         = pci_vntb_remove,
 };
 
 /* ============ PCIe EPF Driver Bind ====================*/
@@ -1797,12 +1839,25 @@ static int epf_ntb_bind(struct pci_epf *epf)
  */
 static void epf_ntb_unbind(struct pci_epf *epf)
 {
+	struct pci_host_bridge *bridge;
 	struct epf_ntb *ntb = epf_get_drvdata(epf);
 
+	pci_unregister_driver(&vntb_pci_driver);
+
+	if (ntb->vpci_bus) {
+		bridge = to_pci_host_bridge(ntb->vpci_bus->bridge);
+
+		pci_lock_rescan_remove();
+		pci_stop_root_bus(ntb->vpci_bus);
+		pci_remove_root_bus(ntb->vpci_bus);
+		ntb->vpci_bus = NULL;
+		pci_unlock_rescan_remove();
+
+		pci_free_host_bridge(bridge);
+	}
+
 	epf_ntb_epc_cleanup(ntb);
 	epf_ntb_config_spad_bar_free(ntb);
-
-	pci_unregister_driver(&vntb_pci_driver);
 }
 
 // EPF driver probe
-- 
2.53.0




