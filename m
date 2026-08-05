Received: from azure-sdnproxy.icoremail.net (azure-sdnproxy.icoremail.net [13.75.44.102])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7353A37BE93;
	Wed,  5 Aug 2026 14:20:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.75.44.102
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785939664; cv=none; b=lZnXvy306DoK8OcqujI8Th4J3rHZP1o/eQ1n2tjCd1kyFTu+e3U5tkuwZfCpeLJx8UzQj+A4ZLMXSjczHXX7j/92M9LmRDNxPF8atvkntWiPOrm0bqBTHXmg6UU0tZ595mtA74yd1+X+rtCGuevUOdtLDpx1tHcKBiOZTuVX/T4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785939664; c=relaxed/simple;
	bh=XMBb6d/y1n/AwFvVUXVb8hKhKFloTDk1XVYh2Q2UY4k=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=SLdkZAT38/bet2XiOFqGpCZiAceJZeN8Z3sFnylETw9yN79IRGageWe63LoWCebuJTgqAzcG2N1Kikk4HCSIKaZhSxJ3wqfF8gM/ow+JRNJGZdpwPrYdWutoJHdxq7C1XXaNtzzD0jnYy+r6lcISPAhQDVWoSbsn12/+gdNDdHw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=zju.edu.cn; spf=pass smtp.mailfrom=zju.edu.cn; arc=none smtp.client-ip=13.75.44.102
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=zju.edu.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=zju.edu.cn
Received: from zju.edu.cn (unknown [10.98.66.117])
	by mtasvr (Coremail) with SMTP id _____wDHoX6+RnNqoadpAA--.24993S3;
	Wed, 05 Aug 2026 22:20:46 +0800 (CST)
Received: from localhost.localdomain (unknown [10.98.66.117])
	by mail-app2 (Coremail) with SMTP id zC_KCgDHFMm+RnNqKSyTAw--.13400S2;
	Wed, 05 Aug 2026 22:20:46 +0800 (CST)
From: Fan Wu <fanwu01@zju.edu.cn>
To: netdev@vger.kernel.org
Cc: "K . Y . Srinivasan" <kys@microsoft.com>,
	Haiyang Zhang <haiyangz@microsoft.com>,
	Wei Liu <wei.liu@kernel.org>,
	Dexuan Cui <decui@microsoft.com>,
	Long Li <longli@microsoft.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	linux-hyperv@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: [PATCH net] net: mana: fix reset work race with device removal
Date: Wed,  5 Aug 2026 14:19:37 +0000
Message-Id: <20260805141937.217114-1-fanwu01@zju.edu.cn>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:zC_KCgDHFMm+RnNqKSyTAw--.13400S2
X-CM-SenderInfo: qrstjiaswqq6lmxovvfxof0/
X-CM-DELIVERINFO: =?B?nVl1gAXKKxbFmtjJiESix3B1w3vZ3A9ovKVTomAyoQazvoRs/NHSP8GI2EvgeEEW7R
	sfncGSG+szpQCInt5Y8rbJUI1JaegsrYP5HYBdt5oM7HSW4wMYqaDAhteXpNQnYhTsXxI9
	3Ub46l9QECHFwvNoaUfN5RPxYw6l01w8CbPzC/8w
X-Coremail-Antispam: 1Uk129KBj93XoWxGF47Gw1rZFyrKr15GF4ftFc_yoW5AryDpF
	W5Wa48KryDKF17ua1UXw48ZFy5ua9aq3yrCrWIk3ZIkwnIyw4kJrn5tFy2qrWfJrZ5tFnI
	vFW8t3W5uFyqq3XCm3ZEXasCq-sJn29KB7ZKAUJUUUUU529EdanIXcx71UUUUU7KY7ZEXa
	sCq-sGcSsGvfJ3Ic02F40EFcxC0VAKzVAqx4xG6I80ebIjqfuFe4nvWSU5nxnvy29KBjDU
	0xBIdaVrnRJUUUPYb4IE77IF4wAFF20E14v26r4j6ryUM7CY07I20VC2zVCF04k26cxKx2
	IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48v
	e4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_tr0E3s1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI
	0_Gr1j6F4UJwA2z4x0Y4vEx4A2jsIE14v26rxl6s0DM28EF7xvwVC2z280aVCY1x0267AK
	xVW0oVCq3wAac4AC62xK8xCEY4vEwIxC4wAS0I0E0xvYzxvE52x082IY62kv0487Mc804V
	CY07AIYIkI8VC2zVCFFI0UMc02F40EFcxC0VAKzVAqx4xG6I80ewAv7VC0I7IYx2IY67AK
	xVWUXVWUAwAv7VC2z280aVAFwI0_Gr0_Cr1lOx8S6xCaFVCjc4AY6r1j6r4UM4x0Y48Icx
	kI7VAKI48JM4x0Y48IcxkI7VAKI48G6xCjnVAKz4kxM4IIrI8v6xkF7I0E8cxan2IY04v7
	MxAIw28IcxkI7VAKI48JMxC20s026xCaFVCjc4AY6r1j6r4UMI8I3I0E5I8CrVAFwI0_Jr
	0_Jr4lx2IqxVCjr7xvwVAFwI0_JrI_JrWlx4CE17CEb7AF67AKxVWUtVW8ZwCIc40Y0x0E
	wIxGrwCI42IY6xIIjxv20xvE14v26r1j6r1xMIIF0xvE2Ix0cI8IcVCY1x0267AKxVW8JV
	WxJwCI42IY6xAIw20EY4v20xvaj40_Jr0_JF4lIxAIcVC2z280aVAFwI0_Gr0_Cr1lIxAI
	cVC2z280aVCY1x0267AKxVW8Jr0_Cr1UYxBIdaVFxhVjvjDU0xZFpf9x07jn-B_UUUUU=

The reset service work runs on the system workqueue and obtains the
GDMA context through PCI drvdata.  It can race with device removal
(mana_gd_remove()), which frees the context.  A reset work that runs
after removal can therefore dereference the freed context.

Serialize mana_serv_reset() with device removal by taking the PCI
device lock across its drvdata access and reset sequence.  The driver
core holds the same lock while invoking the remove callback, so remove
waits for an in-progress reset.  Work that runs after remove observes
the drvdata cleared before the context is freed.

Drop the lock before rescanning, since the rescan path may remove the
device and acquire the device lock again.  Also clear GC_IN_SERVICE
before rescanning after a failed resume, so this exit follows the same
service-state cleanup as the other reset exits.

This issue was found by an in-house static analysis tool.

Fixes: fbe346ce9d62 ("net: mana: Handle Reset Request from MANA NIC")
Cc: stable@vger.kernel.org
Assisted-by: Codex:gpt-5.6
Signed-off-by: Fan Wu <fanwu01@zju.edu.cn>
---
 drivers/net/ethernet/microsoft/mana/gdma_main.c | 18 +++++++++++++-----
 1 file changed, 13 insertions(+), 5 deletions(-)

diff --git a/drivers/net/ethernet/microsoft/mana/gdma_main.c b/drivers/net/ethernet/microsoft/mana/gdma_main.c
index e8b7ffb47eb9..ae03d7a53 100644
--- a/drivers/net/ethernet/microsoft/mana/gdma_main.c
+++ b/drivers/net/ethernet/microsoft/mana/gdma_main.c
@@ -591,15 +591,16 @@ static void mana_serv_fpga(struct pci_dev *pdev)

 static void mana_serv_reset(struct pci_dev *pdev)
 {
-	struct gdma_context *gc = pci_get_drvdata(pdev);
+	struct gdma_context *gc;
 	struct hw_channel_context *hwc;
 	int ret;

+	device_lock(&pdev->dev);
+	gc = pci_get_drvdata(pdev);
 	if (!gc) {
 		/* Perform PCI rescan on device if GC is not set up */
 		dev_err(&pdev->dev, "MANA service: GC not setup, rescanning\n");
-		mana_serv_rescan(pdev);
-		return;
+		goto rescan;
 	}

 	hwc = gc->hwc.driver_data;
@@ -621,8 +622,8 @@ static void mana_serv_reset(struct pci_dev *pdev)
 	if (ret == -ETIMEDOUT || ret == -EPROTO) {
 		/* Perform PCI rescan on device if we failed on HWC */
 		dev_err(&pdev->dev, "MANA service: resume failed, rescanning\n");
-		mana_serv_rescan(pdev);
-		return;
+		clear_bit(GC_IN_SERVICE, &gc->flags);
+		goto rescan;
 	}

 	if (ret)
@@ -632,6 +633,12 @@ static void mana_serv_reset(struct pci_dev *pdev)

 out:
 	clear_bit(GC_IN_SERVICE, &gc->flags);
+	device_unlock(&pdev->dev);
+	return;
+
+rescan:
+	device_unlock(&pdev->dev);
+	mana_serv_rescan(pdev);
 }

 static void mana_do_service(enum gdma_eqe_type type, struct pci_dev *pdev)
@@ -2436,6 +2443,7 @@ static void mana_gd_remove(struct pci_dev *pdev)

 	pci_iounmap(pdev, gc->bar0_va);

+	pci_set_drvdata(pdev, NULL);
 	vfree(gc);

 	pci_release_regions(pdev);
--
2.34.1

