Received: from cstnet.cn (smtp25.cstnet.cn [159.226.251.25])
	(using TLSv1.2 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 98F3E4E2F31;
	Thu, 17 Sep 2026 13:29:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=159.226.251.25
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789651802; cv=none; b=bEeQKO+dnBQn5taSYu5n/gdVBtVgyDMz/RD4fwLNBaxLEjrpEfxpB415LS3a05kLxy7bFc1UQ3iRfqLxngsGhtFRm2fEv2MzhQMTNQ4ddWX9FaMuUsf+K6owEZ2pY/v4lTEJVlnkGQR0CpIn1WmfwEvtKpRgaTueNdnVWi/xdms=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789651802; c=relaxed/simple;
	bh=IHKyhwi9VOur496O1HNCX9aPf++wgIxyKFwtl5/Je8s=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=DhPpLgypFX1yJ62CJ7V6nnoK05PrYkyfIzre3+/DLaNsnMZYb+CiL///0XuqNj+TjoQsVPv5XOp9Jmyza1dqCQ8NrxEpRwhSxn2SItfY158NO0qXlbfrHCh6T9I+b2ZErSuMF4vgE4/VxIVsyOONU6U3t7CW0ZisJNX2LcG44JY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iscas.ac.cn; spf=pass smtp.mailfrom=iscas.ac.cn; arc=none smtp.client-ip=159.226.251.25
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iscas.ac.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=iscas.ac.cn
Received: from dfae2b116770.home.arpa (unknown [36.110.52.2])
	by APP-05 (Coremail) with SMTP id zQCowACXADtI66tqC3qBCA--.3599S2;
	Thu, 17 Sep 2026 21:29:44 +0800 (CST)
From: Wentao Liang <vulab@iscas.ac.cn>
To: bhelgaas@google.com
Cc: boris.ostrovsky@oracle.com,
	jgross@suse.com,
	linux-kernel@vger.kernel.org,
	linux-pci@vger.kernel.org,
	oleksandr_tyshchenko@epam.com,
	sstabellini@kernel.org,
	u.kleine-koenig@pengutronix.de,
	xen-devel@lists.xenproject.org,
	Wentao Liang <vulab@iscas.ac.cn>,
	stable@vger.kernel.org
Subject: [PATCH] xen/pcifront: Fix PCI device reference leak in pcifront_common_process()
Date: Thu, 17 Sep 2026 13:29:44 +0000
Message-Id: <20260917132944.2153421-1-vulab@iscas.ac.cn>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:zQCowACXADtI66tqC3qBCA--.3599S2
X-Coremail-Antispam: 1UD129KBjvJXoW7WF1Uur1rKw1fAFWxWry5twb_yoW8uw1fp3
	98AF13Ars0ya40qrZxAF4jga45ZFsrJ3y7C3ySg3s7X34aq3Z5Jw15JF1a9r48G395Zrnx
	trnxJa1UZF1UXaDanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUPqb7Iv0xC_Kw4lb4IE77IF4wAFc2x0x2IEx4CE42xK8VAvwI8I
	cIk0rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2ocxC64kIII0Yj41l84x0c7CEw4AK67xGY2
	AK021l84ACjcxK6xIIjxv20xvE14v26ryj6F1UM28EF7xvwVC0I7IYx2IY6xkF7I0E14v2
	6F4j6r4UJwA2z4x0Y4vEx4A2jsIE14v26rxl6s0DM28EF7xvwVC2z280aVCY1x0267AKxV
	W0oVCq3wAS0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC0VAKzVAqx4xG6I80ewAv
	7VC0I7IYx2IY67AKxVWUAVWUtwAv7VC2z280aVAFwI0_Cr1j6rxdMcvjeVCFs4IE7xkEbV
	WUJVW8JwACjcxG0xvY0x0EwIxGrwACjI8F5VAI37AI020EjII2zVCS5cI20VAGYxC7M4II
	rI8v6xkF7I0E8cxan2IY04v7MxkF7I0En4kS14v26r1q6r43MxAIw28IcxkI7VAKI48JMx
	AIw28IcVCjz48v1sIEY20_Gr43Wr1UJr1l4I8I3I0E4IkC6x0Yz7v_Jr0_Gr1lx2IqxVAq
	x4xG67AKxVWUJVWUGwC20s026x8GjcxK67AKxVWUGVWUWwC2zVAF1VAY17CE14v26r1q6r
	43MIIYrxkI7VAKI48JMIIF0xvE2Ix0cI8IcVAFwI0_Jr0_JF4lIxAIcVC0I7IYx2IY6xkF
	7I0E14v26F4j6r4UJwCI42IY6xAIw20EY4v20xvaj40_Jr0_JF4lIxAIcVC2z280aVAFwI
	0_Gr1j6F4UJwCI42IY6I8E87Iv6xkF7I0E14v26rxl6s0DYxBIdaVFxhVjvjDU0xZFpf9x
	07bb5rxUUUUU=
X-CM-SenderInfo: pyxotu46lvutnvoduhdfq/1tbiBgQNA2qrq3bHZgAAsx

pcifront_common_process() gets a reference to the PCI device with
pci_get_domain_bus_and_slot() and only drops it on the early error
path.  Returning directly from the AER handler switch instead of
recording the result and falling through to the common
pci_dev_put(pcidev) leaks the reference on every successful call.

Collect the handler result in a variable and drop the reference on the
single exit path again.

Fixes: 34ab316d7287 ("xen/pcifront: Drop pcifront_common_process() tests of pcidev, pdrv")
Cc: stable@vger.kernel.org
Signed-off-by: Wentao Liang <vulab@iscas.ac.cn>
---
 drivers/pci/xen-pcifront.c | 15 ++++++++++-----
 1 file changed, 10 insertions(+), 5 deletions(-)

diff --git a/drivers/pci/xen-pcifront.c b/drivers/pci/xen-pcifront.c
index cffc32d66032..5fdce7c41af5 100644
--- a/drivers/pci/xen-pcifront.c
+++ b/drivers/pci/xen-pcifront.c
@@ -579,6 +579,7 @@ static pci_ers_result_t pcifront_common_process(int cmd,
 	int bus = pdev->sh_info->aer_op.bus;
 	int devfn = pdev->sh_info->aer_op.devfn;
 	int domain = pdev->sh_info->aer_op.domain;
+	pci_ers_result_t result = PCI_ERS_RESULT_NONE;
 	struct pci_dev *pcidev;
 
 	dev_dbg(&pdev->xdev->dev,
@@ -597,21 +598,25 @@ static pci_ers_result_t pcifront_common_process(int cmd,
 		pci_dbg(pcidev, "trying to call AER service\n");
 		switch (cmd) {
 		case XEN_PCI_OP_aer_detected:
-			return pdrv->err_handler->error_detected(pcidev, state);
+			result = pdrv->err_handler->error_detected(pcidev, state);
+			break;
 		case XEN_PCI_OP_aer_mmio:
-			return pdrv->err_handler->mmio_enabled(pcidev);
+			result = pdrv->err_handler->mmio_enabled(pcidev);
+			break;
 		case XEN_PCI_OP_aer_slotreset:
-			return pdrv->err_handler->slot_reset(pcidev);
+			result = pdrv->err_handler->slot_reset(pcidev);
+			break;
 		case XEN_PCI_OP_aer_resume:
 			pdrv->err_handler->resume(pcidev);
-			return PCI_ERS_RESULT_NONE;
+			break;
 		default:
 			dev_err(&pdev->xdev->dev,
 				"bad request in aer recovery operation!\n");
 		}
 	}
 
-	return PCI_ERS_RESULT_NONE;
+	pci_dev_put(pcidev);
+	return result;
 }
 
 
-- 
2.34.1

