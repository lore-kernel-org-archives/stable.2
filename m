Received: from cstnet.cn (smtp25.cstnet.cn [159.226.251.25])
	(using TLSv1.2 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C63BB3876C6;
	Tue,  9 Jun 2026 10:08:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=159.226.251.25
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780999690; cv=none; b=QzByeBb8KYa/4ALPGW2lLalh/iodx/d8NauMK1fHkTAhGpRCWZMu+6JSwYyaincu8+drzba1KLdznBDZ3zYXL/ghY0FzxShaxYDn/fo7d6r7rfGev6T3faChLulcBxZiqtc70GJu9UvWzrjNK+rfm0AoYdXOQ1aIwAN8qs6wxwk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780999690; c=relaxed/simple;
	bh=Twuh2akfEPxR92zr4393O32/zUOb2/TLbsekpBVKQqI=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=jFthosigD3yUs8yC5YkwPYzkD/ay3Ix+IQVSAx9AW/bfak9DWmRgtExONzbFGHvtGOwZsA3wgI0of6jg+fIknc3bWqhcIqljgQYZ316k+TAAuZZL+xKUxQB9eUlc6FPEYnCSstuXk3GRAdQs5N9yFUjs9nz3PB3hn9pczb3GvNo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iscas.ac.cn; spf=pass smtp.mailfrom=iscas.ac.cn; arc=none smtp.client-ip=159.226.251.25
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iscas.ac.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=iscas.ac.cn
Received: from dfae2b116770.home.arpa (unknown [36.110.52.2])
	by APP-05 (Coremail) with SMTP id zQCowADXYQX65SdqzyPREg--.80S2;
	Tue, 09 Jun 2026 18:07:55 +0800 (CST)
From: Wentao Liang <vulab@iscas.ac.cn>
To: mani@kernel.org,
	lpieralisi@kernel.org,
	kwilczynski@kernel.org,
	robh@kernel.org,
	bhelgaas@google.com
Cc: linux-pci@vger.kernel.org,
	linux-arm-msm@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Wentao Liang <vulab@iscas.ac.cn>,
	stable@vger.kernel.org
Subject: [PATCH] PCI: qcom-ep: fix refcount leak in qcom_pcie_ep_probe()
Date: Tue,  9 Jun 2026 10:07:47 +0000
Message-Id: <20260609100747.230521-1-vulab@iscas.ac.cn>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:zQCowADXYQX65SdqzyPREg--.80S2
X-Coremail-Antispam: 1UD129KBjvJXoW7tF18Kw1ftry5ZF1DArW5ZFb_yoW8tr45pa
	1Sqa9YyF18XF40qrZFya1DZFn09rZYyryUG3ykWa4xZ3WfZw1Utr45tFyFq3WktrWkXa4U
	Jw47ta17ZF4jyaDanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUU9F14x267AKxVW8JVW5JwAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
	rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2ocxC64kIII0Yj41l84x0c7CEw4AK67xGY2AK02
	1l84ACjcxK6xIIjxv20xvE14v26r4j6ryUM28EF7xvwVC0I7IYx2IY6xkF7I0E14v26F4j
	6r4UJwA2z4x0Y4vEx4A2jsIE14v26rxl6s0DM28EF7xvwVC2z280aVCY1x0267AKxVW0oV
	Cq3wAS0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC0VAKzVAqx4xG6I80ewAv7VC0
	I7IYx2IY67AKxVWUAVWUtwAv7VC2z280aVAFwI0_Cr1j6rxdMcvjeVCFs4IE7xkEbVWUJV
	W8JwACjcxG0xvY0x0EwIxGrwACjI8F5VA0II8E6IAqYI8I648v4I1lFIxGxcIEc7CjxVA2
	Y2ka0xkIwI1lc7CjxVAaw2AFwI0_Jw0_GFyl42xK82IYc2Ij64vIr41l4I8I3I0E4IkC6x
	0Yz7v_Jr0_Gr1lx2IqxVAqx4xG67AKxVWUJVWUGwC20s026x8GjcxK67AKxVWUGVWUWwC2
	zVAF1VAY17CE14v26r1q6r43MIIYrxkI7VAKI48JMIIF0xvE2Ix0cI8IcVAFwI0_Jr0_JF
	4lIxAIcVC0I7IYx2IY6xkF7I0E14v26r4j6F4UMIIF0xvE42xK8VAvwI8IcIk0rVWUJVWU
	CwCI42IY6I8E87Iv67AKxVW8JVWxJwCI42IY6I8E87Iv6xkF7I0E14v26r4UJVWxJrUvcS
	sGvfC2KfnxnUUI43ZEXa7VU8nNVPUUUUU==
X-CM-SenderInfo: pyxotu46lvutnvoduhdfq/1tbiCRANA2onp3T6LAAAsf

qcom_pcie_ep_probe() obtains a runtime PM reference via
pm_runtime_get_noresume() but only releases it on the successful
completion of the function using pm_runtime_put_sync().  The devm
cleanup registered by devm_pm_runtime_enable() does not put the
reference - it only disables autosuspend and calls
pm_runtime_disable(), which does not decrement usage_count.  Thus
if any of the probe error paths are taken (e.g. resource acquisition
or endpoint init failure) the reference is leaked, permanently
elevating the device's usage_count and preventing proper runtime
suspend or clean removal.

Add a new error label that calls pm_runtime_put_noidle() and
pm_runtime_disable() before returning the error, and convert the
early return statements to use that label.  This ensures the
reference is correctly released on all error paths.

Cc: stable@vger.kernel.org
Fixes: 5b026a9e714d ("PCI: qcom-ep: Add support for firmware-managed PCIe Endpoint")
Signed-off-by: Wentao Liang <vulab@iscas.ac.cn>
---
 drivers/pci/controller/dwc/pcie-qcom-ep.c | 10 +++++++---
 1 file changed, 7 insertions(+), 3 deletions(-)

diff --git a/drivers/pci/controller/dwc/pcie-qcom-ep.c b/drivers/pci/controller/dwc/pcie-qcom-ep.c
index 257c2bcb5f76..c01d4d3b4952 100644
--- a/drivers/pci/controller/dwc/pcie-qcom-ep.c
+++ b/drivers/pci/controller/dwc/pcie-qcom-ep.c
@@ -892,16 +892,16 @@ static int qcom_pcie_ep_probe(struct platform_device *pdev)
 	pm_runtime_set_active(dev);
 	ret = devm_pm_runtime_enable(dev);
 	if (ret)
-		return ret;
+		goto err_rpm_put;
 
 	ret = qcom_pcie_ep_get_resources(pdev, pcie_ep);
 	if (ret)
-		return ret;
+		goto err_rpm_put;
 
 	ret = dw_pcie_ep_init(&pcie_ep->pci.ep);
 	if (ret) {
 		dev_err(dev, "Failed to initialize endpoint: %d\n", ret);
-		return ret;
+		goto err_rpm_put;
 	}
 
 	ret = qcom_pcie_ep_enable_irq_resources(pdev, pcie_ep);
@@ -932,6 +932,10 @@ static int qcom_pcie_ep_probe(struct platform_device *pdev)
 err_ep_deinit:
 	dw_pcie_ep_deinit(&pcie_ep->pci.ep);
 
+err_rpm_put:
+	pm_runtime_put_noidle(dev);
+	pm_runtime_disable(dev);
+
 	return ret;
 }
 
-- 
2.34.1

