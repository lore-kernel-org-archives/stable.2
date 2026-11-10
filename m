Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794283241;
	b=cYecOWk02W9CM0rxfqiYP2Dvmj3eWOuUBE2P0AUdOcRY+C7ytLc4LJAuQ2Av0cLaqHdj
	 uTXuRkn7v6VV/mpgqdpGzNxnWkpBsh67Go+1cMoz4tCz+uUY1yd6DyGzMe7aJmQYTA/tN
	 JDmTvBFMJ/U1Gs+kcLCzrF/49Pi+p6f8pyjAehBwujwIsmXiCnL5wK1x3vUgn9BbOwjYt
	 jcsiRdt6doZ6BBa7s1toGRMmAHUACsMw/F+Eza7ZgnV6L2xVEAFkrQ5AJAi6fuwrawbzQ
	 yH9XX0JB1hbkB9jcBz26OagSSafVtUDLgQN2dR8a2XNYaHkiTfAn1MT9egD6WUi1PjQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794283241;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=DfOm5q5+ojDNZF7RCnn5n0D6B92I2N9o0UhQOtaUI78=;
	b=TUUoVlZYcfyA5XwdrTe5uEYK0vZoFxkaedg4l6mSDj4Wo1ljCPHPrm4mUjx1KSYdqMLl
	 yYxE0jORWe25yhp2/Jb7zHC4AYyCuDdjpztvipgsCHmNjcuxs/U6v42iKytYIHXdSooTS
	 yXfPcnBlKsnbXCKzp5QKQekAbJ2bNearZOx6g3litGf4zSyjKXfIKvqXwDsFrBz8lr6x+
	 f8L/xoX2D0aymcIXGWmNdU0hApXZZYB3iYpFs5AvgkXP8y6a0kJQwvdH433XtrOZ4g10G
	 HY9ls/VBQHAwFKLsYBIrcY2A1t9ApwW+VaAhhZ0qwM+mfVJ+ncTnN9CN44re1qTacSg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=TNhzrO80;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 112F160A262E
	for <stable@vger.kernel.org>; Tue, 10 Nov 2026 04:00:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=TNhzrO80
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8F8EA1F008A6;
	Tue, 10 Nov 2026 04:00:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794283240;
	bh=DfOm5q5+ojDNZF7RCnn5n0D6B92I2N9o0UhQOtaUI78=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=TNhzrO80DcL0+l4cczaywEXOI4okV31cVs0U3XF78DSap+/Pq/zLdDQ5AiKDO46jc
	 kLyJRyxQda2KQmHljErrLT0Fzz7rft6nWn9qa8rL5KVn7f/o/xyFU0Vjx/loaMfzSY
	 DcLcIAqZrH95K/kvWDAVDBDpSQdIb60tDm8wF6NmldlGsKT23dN3lSzwJS4Wbx8lAm
	 zfHT7ATArhdDLv6U0zA5bLX0irhMltS/7FVPwFossO6a+K3k36gUVEUZ53TFwqIyCa
	 pOG021t7GukpIZ3W9M5iqLpVXDciIBWnqKZJW3pEQ7zWazan1rEtCxX2QUUbF1753q
	 RBCHMBs+j1RqQ==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Koichiro Den <den@valinux.co.jp>,
	Manivannan Sadhasivam <manivannan.sadhasivam@oss.qualcomm.com>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Frank Li <Frank.Li@nxp.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.12.y] PCI: endpoint: pci-epf-vntb: Manage virtual NTB and PCI bus lifetime
Date: Mon,  9 Nov 2026 23:00:38 -0500
Message-ID: <20261110035937.278079-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261107051656-failed-6.12-5cdbd6d3a3a1@kernel.org>
References: <20261107051656-failed-6.12-5cdbd6d3a3a1@kernel.org>
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Koichiro Den <den@valinux.co.jp>

[ Upstream commit 5cdbd6d3a3a147fa9975e35f2602cbec9a72a932 ]

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
[ sashal: adapted NTB pointer changes to the existing polling doorbell implementation. ]
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/pci/endpoint/functions/pci-epf-vntb.c | 69 +++++++++++++++----
 1 file changed, 55 insertions(+), 14 deletions(-)

diff --git a/drivers/pci/endpoint/functions/pci-epf-vntb.c b/drivers/pci/endpoint/functions/pci-epf-vntb.c
index 963a1a1f983db..710bddc30cdfc 100644
--- a/drivers/pci/endpoint/functions/pci-epf-vntb.c
+++ b/drivers/pci/endpoint/functions/pci-epf-vntb.c
@@ -116,7 +116,7 @@ struct epf_ntb_ctrl {
 } __packed;
 
 struct epf_ntb {
-	struct ntb_dev ntb;
+	struct ntb_dev *ntb;
 	struct pci_epf *epf;
 	struct config_group group;
 
@@ -142,10 +142,15 @@ struct epf_ntb {
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
@@ -171,7 +176,7 @@ static int epf_ntb_link_up(struct epf_ntb *ntb, bool link_up)
 	else
 		ntb->reg->link_status &= ~LINK_STATUS_UP;
 
-	ntb_link_event(&ntb->ntb);
+	ntb_link_event(ntb->ntb);
 	return 0;
 }
 
@@ -259,7 +264,7 @@ static void epf_ntb_cmd_handler(struct work_struct *work)
 	for (i = 1; i < ntb->db_count; i++) {
 		if (ntb->epf_db[i]) {
 			ntb->db |= 1 << (i - 1);
-			ntb_db_event(&ntb->ntb, i);
+			ntb_db_event(ntb->ntb, i);
 			ntb->epf_db[i] = 0;
 		}
 	}
@@ -760,7 +765,6 @@ static int epf_ntb_epc_init(struct epf_ntb *ntb)
 	}
 
 	INIT_DELAYED_WORK(&ntb->cmd_handler, epf_ntb_cmd_handler);
-	queue_work(kpcintb_workqueue, &ntb->cmd_handler.work);
 
 	return 0;
 
@@ -1009,6 +1013,7 @@ static int vpci_scan_bus(void *sysdata)
 		pr_err("create pci bus failed\n");
 		return -EINVAL;
 	}
+	ndev->vpci_bus = vpci_bus;
 
 	pci_bus_add_devices(vpci_bus);
 
@@ -1053,7 +1058,7 @@ static int vntb_epf_mw_set_trans(struct ntb_dev *ndev, int pidx, int idx,
 	int ret;
 	struct device *dev;
 
-	dev = &ntb->ntb.dev;
+	dev = &ndev->dev;
 	barno = ntb->epf_ntb_bar[BAR_MW0 + idx];
 	epf_bar = &ntb->epf->bar[barno];
 	epf_bar->phys_addr = addr;
@@ -1153,7 +1158,7 @@ static int vntb_epf_peer_db_set(struct ntb_dev *ndev, u64 db_bits)
 	ret = pci_epc_raise_irq(ntb->epf->epc, func_no, vfunc_no,
 				PCI_IRQ_MSI, interrupt_num + 1);
 	if (ret)
-		dev_err(&ntb->ntb.dev, "Failed to raise IRQ\n");
+		dev_err(&ntb->epf->dev, "Failed to raise IRQ\n");
 
 	return ret;
 }
@@ -1236,13 +1241,18 @@ static const struct ntb_dev_ops vntb_epf_ops = {
 
 static int pci_vntb_probe(struct pci_dev *pdev, const struct pci_device_id *id)
 {
-	int ret;
 	struct epf_ntb *ndev = (struct epf_ntb *)pdev->sysdata;
 	struct device *dev = &pdev->dev;
+	struct ntb_dev *ntb;
+	int ret;
 
-	ndev->ntb.pdev = pdev;
-	ndev->ntb.topo = NTB_TOPO_NONE;
-	ndev->ntb.ops =  &vntb_epf_ops;
+	ntb = devm_kzalloc(dev, sizeof(*ntb), GFP_KERNEL);
+	if (!ntb)
+		return -ENOMEM;
+
+	ntb->pdev = pdev;
+	ntb->topo = NTB_TOPO_NONE;
+	ntb->ops = &vntb_epf_ops;
 
 	ret = dma_set_mask_and_coherent(dev, DMA_BIT_MASK(32));
 	if (ret) {
@@ -1250,16 +1260,33 @@ static int pci_vntb_probe(struct pci_dev *pdev, const struct pci_device_id *id)
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
+
+	/* Stop the work reader */
+	cancel_delayed_work_sync(&ndev->cmd_handler);
+
+	ntb = xchg(&ndev->ntb, NULL);
+
+	ntb_unregister_device(ntb);
+}
+
 static struct pci_device_id pci_vntb_table[] = {
 	{
 		PCI_DEVICE(0xffff, 0xffff),
@@ -1271,6 +1298,7 @@ static struct pci_driver vntb_pci_driver = {
 	.name           = "pci-vntb",
 	.id_table       = pci_vntb_table,
 	.probe          = pci_vntb_probe,
+	.remove         = pci_vntb_remove,
 };
 
 /* ============ PCIe EPF Driver Bind ====================*/
@@ -1351,12 +1379,25 @@ static int epf_ntb_bind(struct pci_epf *epf)
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

