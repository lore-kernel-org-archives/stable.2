Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=159.226.251.81
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793702553;
	b=pwi4q8IaKqLXg2t211Rhc0LDv0mCkaTE4h5AtoQ0und2XAPv2CVq0E5ITSsMgOyDW2UB
	 h4tHbkN6S00BpJ9EnWrOVeP9UX9amUNs4Y/HtYh3s9zQQBrHKVunnU8PxWbmG6BGKjbQv
	 3tU7kBURZkUpNgc4qyZfXLX5cmhc/oMkX+PahD6sVByfoepfNPA8+eVmsP/FtibfAT72V
	 LJjEM/dGkpd6QuLiW5gaqOfP6v1+COg/KOMR9FYXUoBoe2lOK+6Zv0prGUndn/TW6uhGL
	 EN29zak5u6S6+2bnZ8lMDBk0tm0lOYYVe7znIMhpPyDI3Gxw/r+o7q2vyD6UyMeaFyA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793702553;
	h=DMARC-Filter:Received:From:To:Cc:Subject:Date:Message-Id:X-Mailer:
	 MIME-Version:Content-Transfer-Encoding:X-CM-TRANSID:
	 X-Coremail-Antispam:X-Originating-IP:X-CM-SenderInfo;
	bh=6SH6uL3pqMWX7iR37l4I7tLX+tjbaLR2gdsfju8JZf0=;
	b=j9GaBYARfcw+Ao9Vacj35B+Kk71GtTNOtd1cwP6gaGiMBDRDv9uLDxCHA+V7Sbd/NIIH
	 LVIAIPmZdJVEBkcMbhlpPFJlr/ZnRx0fLXnC4YFCmMUVkqJ5PJqo7EvL1k1P7rInVCroU
	 jJKAegl302/U1C4SCaBW/eZ8+Yt6GYQ3kvijtRcRHdmYvhVICrMqw2R3h0GbVwKXH/EvZ
	 i3oxHs05dtwC1MxGtvLC6VNdHcNpDC96uCk9rHjT5N4ppXNvFgXNnjwJDpU71pqG83RWN
	 1NZ34xts/+Rh4NxjprYK04bMEg6qKwurS+tih2Kz7O6AnGGTDdwBfu2R7i6eFRDzSXg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=iscas.ac.cn;
	spf=pass smtp.mailfrom=iscas.ac.cn;
	arc=none smtp.remote-ip=159.226.251.81
Received: from cstnet.cn (smtp81.cstnet.cn [159.226.251.81])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B778F60775F5;
	Tue,  3 Nov 2026 10:42:32 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org B778F60775F5
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iscas.ac.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=iscas.ac.cn
Received: from dfae2b116770.home.arpa (unknown [36.110.52.2])
	by APP-03 (Coremail) with SMTP id rQCowAA3QpOWuulql8g7AA--.3191S2;
	Tue, 03 Nov 2026 18:42:30 +0800 (CST)
From: Wentao Liang <vulab@iscas.ac.cn>
To: Lorenzo Pieralisi <lpieralisi@kernel.org>,
	=?UTF-8?q?Krzysztof=20Wilczy=C5=84ski?= <kwilczynski@kernel.org>,
	Manivannan Sadhasivam <mani@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Bjorn Helgaas <bhelgaas@google.com>
Cc: linux-pci@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Wentao Liang <vulab@iscas.ac.cn>,
	stable@vger.kernel.org
Subject: [PATCH] PCI: keystone: drop host bridge reference in ks_pcie_quirk()
Date: Tue,  3 Nov 2026 10:42:39 +0000
Message-Id: <20261103104239.1373754-1-vulab@iscas.ac.cn>
X-Mailer: git-send-email 2.34.1
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
X-CM-TRANSID:rQCowAA3QpOWuulql8g7AA--.3191S2
X-Coremail-Antispam: 1UD129KBjvJXoW7Kw1rKFy7ur43Cr4DuFW8Xrb_yoW5Jr1Dpr
	sIqa4YyFy8Xr4Yqw4xZ3WY9F15AFnayay5Xws7KryI9r15XFn8GF9rtasYqwn3AFZaq34U
	Gw1Utr1rG3WkAFJanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUU9mb7Iv0xC_Kw4lb4IE77IF4wAFF20E14v26r4j6ryUM7CY07I2
	0VC2zVCF04k26cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rw
	A2F7IY1VAKz4vEj48ve4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Ar0_tr1l84ACjcxK6xII
	jxv20xvEc7CjxVAFwI0_Gr1j6F4UJwA2z4x0Y4vEx4A2jsIE14v26rxl6s0DM28EF7xvwV
	C2z280aVCY1x0267AKxVW0oVCq3wAS0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC
	0VAKzVAqx4xG6I80ewAv7VC0I7IYx2IY67AKxVWrXVW3AwAv7VC2z280aVAFwI0_Cr1j6r
	xdMcvjeVCFs4IE7xkEbVWUJVW8JwACjcxG0xvY0x0EwIxGrwACjI8F5VAI37AI020EjII2
	zVCS5cI20VAGYxC7MxkF7I0En4kS14v26r1q6r43MxAIw28IcxkI7VAKI48JMxC20s026x
	CaFVCjc4AY6r1j6r4UMI8I3I0E5I8CrVAFwI0_Jr0_Jr4lx2IqxVCjr7xvwVAFwI0_JrI_
	JrWlx4CE17CEb7AF67AKxVWUtVW8ZwCIc40Y0x0EwIxGrwCI42IY6xIIjxv20xvE14v26r
	yj6F1UMIIF0xvE2Ix0cI8IcVCY1x0267AKxVW8Jr0_Cr1UMIIF0xvE42xK8VAvwI8IcIk0
	rVWUJVWUCwCI42IY6I8E87Iv67AKxVW8Jr0_Cr1UMIIF0xvEx4A2jsIEc7CjxVAFwI0_Cr
	1j6rxdYxBIdaVFxhVjvjDU0xZFpf9x07bOAw3UUUUU=
X-CM-SenderInfo: pyxotu46lvutnvoduhdfq/1tbiCRUAA2rpnIB7nwAAsk

pci_get_host_bridge_device() takes a kobject reference on the host
bridge device.  ks_pcie_quirk() returns without releasing it on every
path after the lookup, including the AM654 PG1.0 path that only limits
the MRRS, so the reference is leaked once for each enabled downstream
device below an AM654 root complex.

Move the AM654 handling out of the enclosing conditional and release
the reference through a single cleanup label.

Fixes: 86f271f22bbb ("PCI: keystone: Add workaround for Errata #i2037 (AM65x SR 1.0)")
Cc: stable@vger.kernel.org
Assisted-by: DeepSeek-V4.1-Flash and OpenAI Codex
Signed-off-by: Wentao Liang <vulab@iscas.ac.cn>
---
 drivers/pci/controller/dwc/pci-keystone.c | 45 +++++++++++++----------
 1 file changed, 26 insertions(+), 19 deletions(-)

diff --git a/drivers/pci/controller/dwc/pci-keystone.c b/drivers/pci/controller/dwc/pci-keystone.c
index edfbc32904cd..0c46887de0d5 100644
--- a/drivers/pci/controller/dwc/pci-keystone.c
+++ b/drivers/pci/controller/dwc/pci-keystone.c
@@ -579,26 +579,33 @@ static void ks_pcie_quirk(struct pci_dev *dev)
 	 * when MRRS is set to more than 128 bytes. Force the MRRS to
 	 * 128 bytes in all downstream devices.
 	 */
-	if (pci_match_id(am6_pci_devids, bridge)) {
-		bridge_dev = pci_get_host_bridge_device(dev);
-		if (!bridge_dev || !bridge_dev->parent)
-			return;
-
-		ks_pcie = dev_get_drvdata(bridge_dev->parent);
-		if (!ks_pcie)
-			return;
-
-		val = ks_pcie_app_readl(ks_pcie, PID);
-		val &= RTL;
-		val >>= RTL_SHIFT;
-		if (val != AM6_PCI_PG1_RTL_VER)
-			return;
-
-		if (pcie_get_readrq(dev) > 128) {
-			dev_info(&dev->dev, "limiting MRRS to 128 bytes\n");
-			pcie_set_readrq(dev, 128);
-		}
+	if (!pci_match_id(am6_pci_devids, bridge))
+		return;
+
+	bridge_dev = pci_get_host_bridge_device(dev);
+	if (!bridge_dev)
+		return;
+
+	if (!bridge_dev->parent)
+		goto put_bridge;
+
+	ks_pcie = dev_get_drvdata(bridge_dev->parent);
+	if (!ks_pcie)
+		goto put_bridge;
+
+	val = ks_pcie_app_readl(ks_pcie, PID);
+	val &= RTL;
+	val >>= RTL_SHIFT;
+	if (val != AM6_PCI_PG1_RTL_VER)
+		goto put_bridge;
+
+	if (pcie_get_readrq(dev) > 128) {
+		dev_info(&dev->dev, "limiting MRRS to 128 bytes\n");
+		pcie_set_readrq(dev, 128);
 	}
+
+put_bridge:
+	pci_put_host_bridge_device(bridge_dev);
 }
 DECLARE_PCI_FIXUP_ENABLE(PCI_ANY_ID, PCI_ANY_ID, ks_pcie_quirk);
 
-- 
2.34.1

