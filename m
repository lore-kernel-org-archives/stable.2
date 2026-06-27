Received: from cstnet.cn (smtp81.cstnet.cn [159.226.251.81])
	(using TLSv1.2 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9CCBB2566D3;
	Sat, 27 Jun 2026 03:01:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=159.226.251.81
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782529322; cv=none; b=dlWyvyOxfne/26nD9fyW7tQVu1NzBP/+NJ5I8UAOh8yTiY6CdGZDLqWbS/2hoBtVsCxRRPqqdUYoenMDt2/A6VEthx/ov3X+zXCch2n/Op7EknV4ZpQuRCEapFI5jnbpR51ub4ePy0QQ3vNkB+a0XgkYgIKh7/XiFNrN6E4FVWA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782529322; c=relaxed/simple;
	bh=KVeztTHdJ7/0E+mYjiYMnMBBSoY1HiIX6lOCudzujKM=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=C2coaFWeDqoSqIEdhV38wkEUth+XNLRFFX2umW0TIsUZcWMhekqwJO4ISJMudO21tME+z1V564AqLIjGv6cyfQVTFFoLzVJYGwoezCO7xdv2giRdDPcrMcbpMmFSSgCgv/sdMoCbpu9sokO0Ueq44YHhLzrs6c3C/hohBFl1IA0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iscas.ac.cn; spf=pass smtp.mailfrom=iscas.ac.cn; arc=none smtp.client-ip=159.226.251.81
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iscas.ac.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=iscas.ac.cn
Received: from localhost.localdomain (unknown [117.182.75.66])
	by APP-03 (Coremail) with SMTP id rQCowABngNcfPT9qBfcAFg--.1157S2;
	Sat, 27 Jun 2026 11:01:52 +0800 (CST)
From: WenTao Liang <vulab@iscas.ac.cn>
To: pawell@cadence.com,
	gregkh@linuxfoundation.org
Cc: linux-usb@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	WenTao Liang <vulab@iscas.ac.cn>,
	stable@vger.kernel.org
Subject: [PATCH] fix: drivers/usb/cdns3: cdnsp_pci_probe: missing pci_dev_put for func on success path
Date: Sat, 27 Jun 2026 11:01:48 +0800
Message-Id: <20260627030148.57607-1-vulab@iscas.ac.cn>
X-Mailer: git-send-email 2.39.5 (Apple Git-154)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:rQCowABngNcfPT9qBfcAFg--.1157S2
X-Coremail-Antispam: 1UD129KBjvdXoW7XF1xZry5Cw4rJF1kZw4fXwb_yoWDAFg_u3
	yruFs2qFWUZFyDJw1xCryfZrZ7K3ZIvF1kWan7tr43Cayakr1kAry3Zw1kGr17uw4UKF1D
	Kr1kKr4S9rs2vjkaLaAFLSUrUUUUjb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
	9fnUUIcSsGvfJTRUUUb4xFF20E14v26r1j6r4UM7CY07I20VC2zVCF04k26cxKx2IYs7xG
	6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48ve4kI8w
	A2z4x0Y4vE2Ix0cI8IcVAFwI0_Gr0_Xr1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI0_Gr0_
	Cr1l84ACjcxK6I8E87Iv67AKxVWxJr0_GcWl84ACjcxK6I8E87Iv6xkF7I0E14v26F4UJV
	W0owAS0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC0VAKzVAqx4xG6I80ewAv7VC0
	I7IYx2IY67AKxVWUJVWUGwAv7VC2z280aVAFwI0_Jr0_Gr1lOx8S6xCaFVCjc4AY6r1j6r
	4UM4x0Y48IcxkI7VAKI48JM4x0x7Aq67IIx4CEVc8vx2IErcIFxwCY1x0262kKe7AKxVWU
	AVWUtwCF04k20xvY0x0EwIxGrwCFx2IqxVCFs4IE7xkEbVWUJVW8JwC20s026c02F40E14
	v26r1j6r18MI8I3I0E7480Y4vE14v26r106r1rMI8E67AF67kF1VAFwI0_JF0_Jw1lIxkG
	c2Ij64vIr41lIxAIcVC0I7IYx2IY67AKxVWUJVWUCwCI42IY6xIIjxv20xvEc7CjxVAFwI
	0_Jr0_Gr1lIxAIcVCF04k26cxKx2IYs7xG6r1j6r1xMIIF0xvEx4A2jsIE14v26r1j6r4U
	MIIF0xvEx4A2jsIEc7CjxVAFwI0_Gr0_Gr1UYxBIdaVFxhVjvjDU0xZFpf9x0JUSNtxUUU
	UU=
X-CM-SenderInfo: pyxotu46lvutnvoduhdfq/1tbiBwULA2o-ErFazQAAsr

In cdnsp_pci_probe(), cdnsp_get_second_fun() acquires a reference on func
via pci_get_device(). All error paths correctly jump to put_pci label
which calls pci_dev_put(func). However, the success path returns 0
directly without releasing the func reference, leaking it.

Add pci_dev_put(func) before returning 0 on the success path.

Cc: stable@vger.kernel.org
Fixes: 3d82904559f4 ("usb: cdnsp: cdns3 Add main part of Cadence USBSSP DRD Driver")
Signed-off-by: WenTao Liang <vulab@iscas.ac.cn>
---
 drivers/usb/cdns3/cdnsp-pci.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/usb/cdns3/cdnsp-pci.c b/drivers/usb/cdns3/cdnsp-pci.c
index 566d94e49102..9c0feaec282d 100644
--- a/drivers/usb/cdns3/cdnsp-pci.c
+++ b/drivers/usb/cdns3/cdnsp-pci.c
@@ -162,6 +162,7 @@ static int cdnsp_pci_probe(struct pci_dev *pdev,
 	if (pci_dev_run_wake(pdev))
 		pm_runtime_put_noidle(&pdev->dev);
 
+	pci_dev_put(func);
 	return 0;
 
 free_cdnsp:
-- 
2.39.5 (Apple Git-154)

