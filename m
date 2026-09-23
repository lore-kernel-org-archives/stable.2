Received: from azure-sdnproxy.icoremail.net (azure-sdnproxy.icoremail.net [52.187.6.220])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EC41844A41B;
	Wed, 23 Sep 2026 07:28:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=52.187.6.220
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790148520; cv=none; b=upmoLEr1QhqK5r1qPDloHjRT9aSN5+2Y07XQNm2t25uaebcskK0SurtsOFHMFtTBD3tbUy5mLSXM4a5y3xpWjd0lK7FezS70I/XYcLIq4Y2rjiHSPydCFoPFRCAz8E970YFiN4FXQSDKd57uDmYOdcrp+Bf6gtgEaxHeos/aCCk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790148520; c=relaxed/simple;
	bh=VlHrzSk0Qsa1Y3DMDPyOcIYSNZZ6W1iECCRqeFSmRI0=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=qcrH1h3plW54oPRUD6AhLRPE4gmp0g/qTh2LobkwYCbFiQpAwCjNaM4CV0o7+dEuMqC+Bg407jBA+x35jIC+psV0574bFoTVskUBfvJKwo4OEIf5LD7ly5eSk/xUBDJs4v8pf9aB2upFar5EG/+dkTrng37TV6jUV6HVbFJl+SM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=zju.edu.cn; spf=pass smtp.mailfrom=zju.edu.cn; arc=none smtp.client-ip=52.187.6.220
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=zju.edu.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=zju.edu.cn
Received: from zju.edu.cn (unknown [10.98.66.117])
	by mtasvr (Coremail) with SMTP id _____wCXcT6af7NqC+YwAQ--.6071S3;
	Wed, 23 Sep 2026 15:28:27 +0800 (CST)
Received: from localhost.localdomain (unknown [10.98.66.117])
	by mail-app1 (Coremail) with SMTP id yy_KCgBHS6WZf7Nqb7SfBA--.29256S2;
	Wed, 23 Sep 2026 15:28:25 +0800 (CST)
From: Fan Wu <fanwu01@zju.edu.cn>
To: "Rafael J . Wysocki" <rafael@kernel.org>,
	Daniel Lezcano <daniel.lezcano@linaro.org>,
	Zhang Rui <rui.zhang@intel.com>,
	Lukasz Luba <lukasz.luba@arm.com>
Cc: linux-pm@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>,
	Fan Wu <fanwu01@zju.edu.cn>,
	stable@vger.kernel.org,
	Song Li <songl@zju.edu.cn>
Subject: [PATCH] thermal: intel: int340x: Fix use-after-free in proc_thermal_pci
Date: Wed, 23 Sep 2026 07:27:30 +0000
Message-Id: <20260923072730.487900-1-fanwu01@zju.edu.cn>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:yy_KCgBHS6WZf7Nqb7SfBA--.29256S2
X-CM-SenderInfo: qrstjiaswqq6lmxovvfxof0/
X-CM-DELIVERINFO: =?B?6z8Z2gXKKxbFmtjJiESix3B1w3vZ3A9ovKVTomAyoQazvoRs/NHSP8GI2EvgeEEW7R
	sfnVCjTgEH9dVomQuWcozCBBH+87qL5fRToeAOg89PGCcN6vfkQDGs8fMcgG9o1ygcca8w
	xv9KW99gtQbXPCh4M3rN5RPxYw6l01w8CbPzC/8w
X-Coremail-Antispam: 1Uk129KBj93XoWxur1kZry3CrykKFy7Jw13trc_yoW5Cry5pa
	98WF9xArWkWFWrW3yDZa1xZFs5tr4kK3yfWrn3G34fKr45AFySqryrKFyUArW8CFZ3AF12
	yr15trs7ZF98GFXCm3ZEXasCq-sJn29KB7ZKAUJUUUUU529EdanIXcx71UUUUU7KY7ZEXa
	sCq-sGcSsGvfJ3Ic02F40EFcxC0VAKzVAqx4xG6I80ebIjqfuFe4nvWSU5nxnvy29KBjDU
	0xBIdaVrnRJUUU9Gb4IE77IF4wAFF20E14v26r4j6ryUM7CY07I20VC2zVCF04k26cxKx2
	IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48v
	e4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_tr0E3s1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI
	0_Gr1j6F4UJwA2z4x0Y4vEx4A2jsIE14v26rxl6s0DM28EF7xvwVC2z280aVCY1x0267AK
	xVW0oVCq3wAac4AC62xK8xCEY4vEwIxC4wAS0I0E0xvYzxvE52x082IY62kv0487Mc804V
	CY07AIYIkI8VC2zVCFFI0UMc02F40EFcxC0VAKzVAqx4xG6I80ewAv7VC0I7IYx2IY67AK
	xVWUXVWUAwAv7VC2z280aVAFwI0_Gr0_Cr1lOx8S6xCaFVCjc4AY6r1j6r4UM4x0Y48Icx
	kI7VAKI48JM4x0Y48IcxkI7VAKI48G6xCjnVAKz4kxMxAIw28IcxkI7VAKI48JMxC20s02
	6xCaFVCjc4AY6r1j6r4UMI8I3I0E5I8CrVAFwI0_Jr0_Jr4lx2IqxVCjr7xvwVAFwI0_Jr
	I_JrWlx4CE17CEb7AF67AKxVWUtVW8ZwCIc40Y0x0EwIxGrwCI42IY6xIIjxv20xvE14v2
	6r1j6r1xMIIF0xvE2Ix0cI8IcVCY1x0267AKxVW8JVWxJwCI42IY6xAIw20EY4v20xvaj4
	0_Jr0_JF4lIxAIcVC2z280aVAFwI0_Gr0_Cr1lIxAIcVC2z280aVCY1x0267AKxVW8JVW8
	JrUvcSsGvfC2KfnxnUUI43ZEXa7IU8aQ6JUUUUU==

proc_thermal_pci_remove() cancels pci_info->work before disabling the
interrupt sources that schedule it. A threshold IRQ which arrives after
the cancel but before the THRES_0 and INT_ENABLE_0 MMIO mask makes
proc_thermal_irq_handler() reschedule the work, so
proc_thermal_threshold_work_fn() runs after devm cleanup has freed
pci_info and dereferences pci_info->tzone and proc_priv->mmio_base. The
shared IRQ is never freed in remove(), which widens the window, and the
probe error paths never cancel the work either.

Fix this by cutting off the producers before draining: mask the THRES_0
and INT_ENABLE_0 registers, free the MSI interrupts or the shared IRQ,
and only then cancel the delayed work. The probe error paths cancel the
work before the thermal zone is unregistered.

The work function re-enables the INT_ENABLE_0 bit, but the IRQs are
already freed when it is cancelled and THRES_0 stays cleared, so nothing
can schedule the work again.

This issue was found by an in-house static analysis tool.

Fixes: acd65d5d1cf4 ("thermal/drivers/int340x/processor_thermal: Add PCI MMIO based thermal driver")
Cc: stable@vger.kernel.org
Co-developed-by: Song Li <songl@zju.edu.cn>
Signed-off-by: Song Li <songl@zju.edu.cn>
Signed-off-by: Fan Wu <fanwu01@zju.edu.cn>
---
 .../processor_thermal_device_pci.c                | 10 ++++++++--
 1 file changed, 8 insertions(+), 2 deletions(-)

diff --git a/drivers/thermal/intel/int340x_thermal/processor_thermal_device_pci.c b/drivers/thermal/intel/int340x_thermal/processor_thermal_device_pci.c
index c693d93..1856e76 100644
--- a/drivers/thermal/intel/int340x_thermal/processor_thermal_device_pci.c
+++ b/drivers/thermal/intel/int340x_thermal/processor_thermal_device_pci.c
@@ -409,7 +409,10 @@ static int proc_thermal_pci_probe(struct pci_dev *pdev, const struct pci_device_
 err_free_vectors:
 	if (msi_irq)
 		proc_thermal_free_msi(pdev, pci_info);
+	else
+		devm_free_irq(&pdev->dev, pdev->irq, pci_info);
 err_ret_tzone:
+	cancel_delayed_work_sync(&pci_info->work);
 	thermal_zone_device_unregister(pci_info->tzone);
 err_del_legacy:
 	if (!pci_info->no_legacy)
@@ -424,13 +427,16 @@ static void proc_thermal_pci_remove(struct pci_dev *pdev)
 	struct proc_thermal_device *proc_priv = pci_get_drvdata(pdev);
 	struct proc_thermal_pci *pci_info = proc_priv->priv_data;
 
-	cancel_delayed_work_sync(&pci_info->work);
-
 	proc_thermal_mmio_write(pci_info, PROC_THERMAL_MMIO_THRES_0, 0);
 	proc_thermal_mmio_write(pci_info, PROC_THERMAL_MMIO_INT_ENABLE_0, 0);
 
 	if (msi_irq)
 		proc_thermal_free_msi(pdev, pci_info);
+	else
+		devm_free_irq(&pdev->dev, pdev->irq, pci_info);
+
+	/* Cancel after the IRQs are freed, or the handler may reschedule it. */
+	cancel_delayed_work_sync(&pci_info->work);
 
 	thermal_zone_device_unregister(pci_info->tzone);
 	proc_thermal_mmio_remove(pdev, pci_info->proc_priv);

