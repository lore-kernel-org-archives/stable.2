Received: from cstnet.cn (smtp25.cstnet.cn [159.226.251.25])
	(using TLSv1.2 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2A73F2FD681;
	Thu, 25 Jun 2026 06:40:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=159.226.251.25
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782369609; cv=none; b=OgO/GXa3PgQlLUknalRP9RfcHbcketuK4T4adKa/T2BecFWy9yBDXRV6IQW9EXDnnvyiDMP/1TRTpaoykXTH5dCgdycAUK2m7JIGOaZ+tDWrmIXo2H21gsA4zQOHrtLhWm1ZvWGZpE3g2z8hRkR43fZwwUrihmvA8dtLqvMNxds=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782369609; c=relaxed/simple;
	bh=2JMoRHKUQ/kQHqvaMEdRcJ0m8VcfYZX/7FHNM/oWlks=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=k5pLMxV6M+u287cFtDJ90TdfJh9nbFIgzRL+CCf6pxW5HA3PY2Q1ooEi8PxIe8AH9jmrE/n1WIlCEIQ0BvZtln2AcrE3RWGOSbVl910CPdg3Tc1H5SR28nfH56Nyc4HTd2MYt8sKxweg53D+wMRcGoAhDeO60p9usZak+bnJJuw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iscas.ac.cn; spf=pass smtp.mailfrom=iscas.ac.cn; arc=none smtp.client-ip=159.226.251.25
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iscas.ac.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=iscas.ac.cn
Received: from localhost.localdomain (unknown [117.182.75.66])
	by APP-05 (Coremail) with SMTP id zQCowAAXbhE6zTxqV6YpFQ--.19217S2;
	Thu, 25 Jun 2026 14:39:56 +0800 (CST)
From: Wentao Liang <vulab@iscas.ac.cn>
To: Sunil Goutham <sgoutham@marvell.com>,
	Linu Cherian <lcherian@marvell.com>,
	Geetha sowjanya <gakula@marvell.com>,
	hariprasad <hkelam@marvell.com>,
	Subbaraya Sundeep <sbhatta@marvell.com>
Cc: Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Wentao Liang <vulab@iscas.ac.cn>,
	stable@vger.kernel.org
Subject: [PATCH] octeontx2-af: Fix pci_dev reference leak in cgx_print_dmac_flt
Date: Thu, 25 Jun 2026 14:39:51 +0800
Message-Id: <20260625063951.44361-1-vulab@iscas.ac.cn>
X-Mailer: git-send-email 2.39.5 (Apple Git-154)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:zQCowAAXbhE6zTxqV6YpFQ--.19217S2
X-Coremail-Antispam: 1UD129KBjvJXoW7AFy7tFW8AFy3Jr1xuw4DArb_yoW8Aw4kpa
	1Y9a4rArW8tryftw4UJa10yr98Ga1vq393K3y8Cw1F93WrJr1Fqa48KayUKF1SyFWkW3W3
	tF1Y9a1xua1Dt3JanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUU9014x267AKxVW8JVW5JwAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
	rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2ocxC64kIII0Yj41l84x0c7CEw4AK67xGY2AK02
	1l84ACjcxK6xIIjxv20xvE14v26F1j6w1UM28EF7xvwVC0I7IYx2IY6xkF7I0E14v26F4j
	6r4UJwA2z4x0Y4vEx4A2jsIE14v26rxl6s0DM28EF7xvwVC2z280aVCY1x0267AKxVW0oV
	Cq3wAS0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC0VAKzVAqx4xG6I80ewAv7VC0
	I7IYx2IY67AKxVWUJVWUGwAv7VC2z280aVAFwI0_Jr0_Gr1lOx8S6xCaFVCjc4AY6r1j6r
	4UM4x0Y48IcxkI7VAKI48JM4x0x7Aq67IIx4CEVc8vx2IErcIFxwACI402YVCY1x02628v
	n2kIc2xKxwCY1x0262kKe7AKxVWUtVW8ZwCF04k20xvY0x0EwIxGrwCFx2IqxVCFs4IE7x
	kEbVWUJVW8JwC20s026c02F40E14v26r1j6r18MI8I3I0E7480Y4vE14v26r106r1rMI8E
	67AF67kF1VAFwI0_Jw0_GFylIxkGc2Ij64vIr41lIxAIcVC0I7IYx2IY67AKxVWUJVWUCw
	CI42IY6xIIjxv20xvEc7CjxVAFwI0_Gr0_Cr1lIxAIcVCF04k26cxKx2IYs7xG6r1j6r1x
	MIIF0xvEx4A2jsIE14v26r1j6r4UMIIF0xvEx4A2jsIEc7CjxVAFwI0_Gr0_Gr1UYxBIda
	VFxhVjvjDU0xZFpf9x0JUd-B_UUUUU=
X-CM-SenderInfo: pyxotu46lvutnvoduhdfq/1tbiDAcJA2o8pXKEjgABsL

In cgx_print_dmac_flt(), pci_get_device() is called to look up the AF
PCI device, but its return value is passed directly to pci_get_drvdata()
without saving the pointer. This means pci_dev_put() can never be called
for the obtained device, causing a reference count leak.

Fix it by saving the return value of pci_get_device() in a local variable
and releasing it via pci_dev_put() after the drvdata is extracted.

Cc: stable@vger.kernel.org
Fixes: dbc52debf95f ("octeontx2-af: Debugfs support for DMAC filters")
Signed-off-by: Wentao Liang <vulab@iscas.ac.cn>
---
 .../net/ethernet/marvell/octeontx2/af/rvu_debugfs.c   | 11 ++++++++---
 1 file changed, 8 insertions(+), 3 deletions(-)

diff --git a/drivers/net/ethernet/marvell/octeontx2/af/rvu_debugfs.c b/drivers/net/ethernet/marvell/octeontx2/af/rvu_debugfs.c
index fa461489acdd..90dc13df9ff9 100644
--- a/drivers/net/ethernet/marvell/octeontx2/af/rvu_debugfs.c
+++ b/drivers/net/ethernet/marvell/octeontx2/af/rvu_debugfs.c
@@ -2949,7 +2949,7 @@ RVU_DEBUG_SEQ_FOPS(cgx_stat, cgx_stat_display, NULL);
 
 static int cgx_print_dmac_flt(struct seq_file *s, int lmac_id)
 {
-	struct pci_dev *pdev = NULL;
+	struct pci_dev *af_pdev, *pdev = NULL;
 	void *cgxd = s->private;
 	char *bcast, *mcast;
 	u16 index, domain;
@@ -2958,8 +2958,13 @@ static int cgx_print_dmac_flt(struct seq_file *s, int lmac_id)
 	u64 cfg, mac;
 	int pf;
 
-	rvu = pci_get_drvdata(pci_get_device(PCI_VENDOR_ID_CAVIUM,
-					     PCI_DEVID_OCTEONTX2_RVU_AF, NULL));
+	af_pdev = pci_get_device(PCI_VENDOR_ID_CAVIUM,
+				 PCI_DEVID_OCTEONTX2_RVU_AF, NULL);
+	if (!af_pdev)
+		return -ENODEV;
+
+	rvu = pci_get_drvdata(af_pdev);
+	pci_dev_put(af_pdev);
 	if (!rvu)
 		return -ENODEV;
 
-- 
2.39.5 (Apple Git-154)

