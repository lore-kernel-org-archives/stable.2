Received: from zg8tmtyylji0my4xnjeumjiw.icoremail.net (zg8tmtyylji0my4xnjeumjiw.icoremail.net [162.243.161.220])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E90923AAF66;
	Tue, 29 Sep 2026 06:15:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=162.243.161.220
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790662520; cv=none; b=qCDaOB12QEuixb3sd5fSG+8yZHC+Rzqa8Dh97LVB52ll+fdhbpq2Phea64eGk9laUSySuyXAkI+geYkVcgGzT6eOd4NECDeiDwCedHfGMcHVC8Xtkz6Lozb8aw0HcAvGhI0AI6UmMOrjrf2ylydbyXMxe6hyrnelSB3+XPnbnuU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790662520; c=relaxed/simple;
	bh=/P7PwiwuEP4yHQxftuoqXexct0tzJklqgwFJ2Et95kM=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=s1ak0KQsp0D+yagniQjm3k2U7Ddc0WhK9xtnjWyJqnKO/kCBMicEs+RDR8C5+nYVFEkMLBdwri24coPingcskvaRvw7CxJ1wYEJB+812BQb5l4JUhRmFgUu9cEtc2PnQKFp73O6Aw4WppJrcQbvxuX1NNRKizsbeQEdk0vCD2uQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=zju.edu.cn; spf=pass smtp.mailfrom=zju.edu.cn; arc=none smtp.client-ip=162.243.161.220
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=zju.edu.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=zju.edu.cn
Received: from zju.edu.cn (unknown [10.98.66.117])
	by mtasvr (Coremail) with SMTP id _____wBnEz1oV7tqwndFAQ--.37345S3;
	Tue, 29 Sep 2026 14:15:04 +0800 (CST)
Received: from localhost.localdomain (unknown [10.98.66.117])
	by mail-app1 (Coremail) with UTF8SMTPA id yy_KCgBXqoloV7tqaY4WAA--.27369S2;
	Tue, 29 Sep 2026 14:15:04 +0800 (CST)
From: Fan Wu <fanwu01@zju.edu.cn>
To: lgirdwood@gmail.com,
	broonie@kernel.org
Cc: alsa-devel@alsa-project.org,
	linux-sound@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Vijendar.Mukunda@amd.com,
	Syed.SabaKareem@amd.com,
	stable@vger.kernel.org,
	songl@zju.edu.cn,
	fanwu01@zju.edu.cn
Subject: [PATCH v2] ASoC: amd: ps: fix snd_acp63_remove() teardown ordering
Date: Tue, 29 Sep 2026 06:13:49 +0000
Message-Id: <20260929061349.3879-1-fanwu01@zju.edu.cn>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:yy_KCgBXqoloV7tqaY4WAA--.27369S2
X-CM-SenderInfo: qrstjiaswqq6lmxovvfxof0/
X-CM-DELIVERINFO: =?B?EQBSZwXKKxbFmtjJiESix3B1w3vZ3A9ovKVTomAyoQazvoRs/NHSP8GI2EvgeEEW7R
	sfnRrXgS1QiyEChzQk8Vd3wxXCJom/K3jHdUmscrYtYM7B6UxpCitQShXrdejT8bDJEo99
	ud8K5EjMC5kJEwD3ns/N5RPxYw6l01w8CbPzC/8w
X-Coremail-Antispam: 1Uk129KBj93XoWxXFW3AFW8ArW5KFW3ZFWkAFc_yoW7Jry5pa
	9xGFWDtrWkJr129a17Wayj9r15A3s3CFy3CrWvkw1xCw1DurZavFZ2yr15ZF95CrWkC3W2
	yFZ0ga4rWF9xtwcCm3ZEXasCq-sJn29KB7ZKAUJUUUUU529EdanIXcx71UUUUU7KY7ZEXa
	sCq-sGcSsGvfJ3Ic02F40EFcxC0VAKzVAqx4xG6I80ebIjqfuFe4nvWSU5nxnvy29KBjDU
	0xBIdaVrnRJUUU9Gb4IE77IF4wAFF20E14v26r4j6ryUM7CY07I20VC2zVCF04k26cxKx2
	IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48v
	e4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_tr0E3s1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI
	0_Gr1j6F4UJwA2z4x0Y4vEx4A2jsIE14v26rxl6s0DM28EF7xvwVC2z280aVCY1x0267AK
	xVW0oVCq3wAac4AC62xK8xCEY4vEwIxC4wAS0I0E0xvYzxvE52x082IY62kv0487Mc804V
	CY07AIYIkI8VC2zVCFFI0UMc02F40EFcxC0VAKzVAqx4xG6I80ewAv7VC0I7IYx2IY67AK
	xVWUXVWUAwAv7VC2z280aVAFwI0_Jr0_Gr1lOx8S6xCaFVCjc4AY6r1j6r4UM4x0Y48Icx
	kI7VAKI48JM4x0Y48IcxkI7VAKI48G6xCjnVAKz4kxMxAIw28IcxkI7VAKI48JMxC20s02
	6xCaFVCjc4AY6r1j6r4UMI8I3I0E5I8CrVAFwI0_Jr0_Jr4lx2IqxVCjr7xvwVAFwI0_Jr
	I_JrWlx4CE17CEb7AF67AKxVWUtVW8ZwCIc40Y0x0EwIxGrwCI42IY6xIIjxv20xvE14v2
	6r1j6r1xMIIF0xvE2Ix0cI8IcVCY1x0267AKxVW8JVWxJwCI42IY6xAIw20EY4v20xvaj4
	0_Jr0_JF4lIxAIcVC2z280aVAFwI0_Jr0_Gr1lIxAIcVC2z280aVCY1x0267AKxVW8JVW8
	JrUvcSsGvfC2KfnxnUUI43ZEXa7IU818BUUUUUU==

The ACP IRQ handlers dereference the SoundWire, SoundWire DMA, and PDM
child platform devices, but snd_acp63_remove() unregisters them while
the interrupt is still held by devres, which frees it only after remove
returns. An interrupt in this window is a use-after-free.

Mask the ACP interrupt sources and call devm_free_irq() before the
first child device is unregistered. The masking goes through the new
acp_hw_ops->disable_interrupts callback, keeping the remove path
platform-agnostic. The interrupt line is shared, and acp_hw_deinit()
clears the sources only after the children are gone, which would
leave the line raised with no handler left to ack it. The window
predates the tagged refactor, which only reshaped the dereferences.

devm_free_irq() waits for in-flight handlers, but not for work the
hardirq has already queued: acp63_irq_handler() schedules
amd_sdw_irq_thread on the SoundWire manager. Draining that work in
the manager's remove path is a soundwire-side change and follows
separately.

This issue was found by an in-house static analysis tool.

Fixes: eaf825037d6d ("ASoC: amd: ps: refactor acp child platform device creation code")
Cc: stable@vger.kernel.org
Co-developed-by: Song Li <songl@zju.edu.cn>
Signed-off-by: Song Li <songl@zju.edu.cn>
Signed-off-by: Fan Wu <fanwu01@zju.edu.cn>
---

Link to v1: https://lore.kernel.org/linux-sound/20260923092640.502145-1-fanwu01@zju.edu.cn/

- mask ACP interrupt sources via the new acp_hw_ops->disable_interrupts
  callback instead of open-coding the register writes in
  snd_acp63_remove(), as suggested by Vijendar Mukunda.

 sound/soc/amd/ps/acp63.h     | 8 ++++++++
 sound/soc/amd/ps/pci-ps.c    | 2 ++
 sound/soc/amd/ps/ps-common.c | 2 ++
 3 files changed, 12 insertions(+)

diff --git a/sound/soc/amd/ps/acp63.h b/sound/soc/amd/ps/acp63.h
index 62cb6bef1..d0cfbd4da 100644
--- a/sound/soc/amd/ps/acp63.h
+++ b/sound/soc/amd/ps/acp63.h
@@ -294,6 +294,7 @@ struct acp63_dev_data;
  * struct acp_hw_ops - ACP PCI driver platform specific ops
  * @acp_init: ACP initialization
  * @acp_deinit: ACP de-initialization
+ * @disable_interrupts: disable ACP interrupt sources
  * @acp_get_config: function to read the acp pin configuration
  * @acp_sdw_dma_irq_thread: ACP SoundWire DMA interrupt thread
  * acp_suspend: ACP system level suspend callback
@@ -304,6 +305,7 @@ struct acp63_dev_data;
 struct acp_hw_ops {
 	int (*acp_init)(void __iomem *acp_base, struct device *dev);
 	int (*acp_deinit)(void __iomem *acp_base, struct device *dev);
+	void (*disable_interrupts)(void __iomem *acp_base);
 	void (*acp_get_config)(struct pci_dev *pci, struct acp63_dev_data *acp_data);
 	void (*acp_sdw_dma_irq_thread)(struct acp63_dev_data *acp_data);
 	int (*acp_suspend)(struct device *dev);
@@ -397,6 +399,12 @@ static inline int acp_hw_deinit(struct acp63_dev_data *adata, struct device *dev
 	return -EOPNOTSUPP;
 }
 
+static inline void acp_hw_disable_interrupts(struct acp63_dev_data *adata)
+{
+	if (adata && adata->hw_ops && adata->hw_ops->disable_interrupts)
+		ACP_HW_OPS(adata, disable_interrupts)(adata->acp63_base);
+}
+
 static inline void acp_hw_get_config(struct pci_dev *pci, struct acp63_dev_data *adata)
 {
 	if (adata && adata->hw_ops && adata->hw_ops->acp_get_config)
diff --git a/sound/soc/amd/ps/pci-ps.c b/sound/soc/amd/ps/pci-ps.c
index 729f9aaba..b604db494 100644
--- a/sound/soc/amd/ps/pci-ps.c
+++ b/sound/soc/amd/ps/pci-ps.c
@@ -738,6 +738,8 @@ static void snd_acp63_remove(struct pci_dev *pci)
 	int ret;
 
 	adata = pci_get_drvdata(pci);
+	acp_hw_disable_interrupts(adata);
+	devm_free_irq(&pci->dev, pci->irq, adata);
 	if (adata->sdw) {
 		amd_sdw_exit(adata);
 		platform_device_unregister(adata->sdw_dma_dev);
diff --git a/sound/soc/amd/ps/ps-common.c b/sound/soc/amd/ps/ps-common.c
index 7b4966b75..ea71cdf19 100644
--- a/sound/soc/amd/ps/ps-common.c
+++ b/sound/soc/amd/ps/ps-common.c
@@ -248,6 +248,7 @@ void acp63_hw_init_ops(struct acp_hw_ops *hw_ops)
 {
 	hw_ops->acp_init = acp63_init;
 	hw_ops->acp_deinit = acp63_deinit;
+	hw_ops->disable_interrupts = acp63_disable_interrupts;
 	hw_ops->acp_get_config = acp63_get_config;
 	hw_ops->acp_sdw_dma_irq_thread = acp63_sdw_dma_irq_thread;
 	hw_ops->acp_suspend = snd_acp63_suspend;
@@ -484,6 +485,7 @@ void acp70_hw_init_ops(struct acp_hw_ops *hw_ops)
 {
 	hw_ops->acp_init = acp70_init;
 	hw_ops->acp_deinit = acp70_deinit;
+	hw_ops->disable_interrupts = acp70_disable_interrupts;
 	hw_ops->acp_get_config = acp70_get_config;
 	hw_ops->acp_sdw_dma_irq_thread = acp70_sdw_dma_irq_thread;
 	hw_ops->acp_suspend = snd_acp70_suspend;
-- 
2.34.1

