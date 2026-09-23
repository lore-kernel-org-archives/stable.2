Received: from fraori-sdnproxy-3.icoremail.net (fraori-sdnproxy-3.icoremail.net [132.226.202.154])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 29A7B41737C;
	Wed, 23 Sep 2026 09:27:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=132.226.202.154
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790155668; cv=none; b=Zmx+78Z6SCX/4jgfq5+5hZLwBlo+s7KSg3umBgrpjdJwuafY2JsSZcpT9MoLEvaUugLoJK0uGQK9CYrS2TCWrrGrcEH5ifaWTeact1JJti/lXepIcha1NMhpgoiia9oWV0VaJZbHWuVuadr9leaZmaiPu6nR/3tx83zBO3HF+g8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790155668; c=relaxed/simple;
	bh=SKXZvELSgzm1NgdhcAWNDInqrqia7MJiwhHAvfh/KPc=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=qpwGlljbuPaN0HChCKy+yIrIEaNvkSzn22Ap+grh0t413BF8GU4CnJyX+Md0U9D72V2DTCS0X9VOoOPVR/LOIqXzk4Yb+RDksMsJ865BrDrGPE8UKPPCSoL/aQssb2L9YzNFqyMiwR0bdXAWiCXlPnW3I390R+43YotCObUK71E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=zju.edu.cn; spf=pass smtp.mailfrom=zju.edu.cn; arc=none smtp.client-ip=132.226.202.154
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=zju.edu.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=zju.edu.cn
Received: from zju.edu.cn (unknown [10.98.66.117])
	by mtasvr (Coremail) with SMTP id _____wD3kyyHm7NqSUMxAQ--.7042S3;
	Wed, 23 Sep 2026 17:27:36 +0800 (CST)
Received: from localhost.localdomain (unknown [10.98.66.117])
	by mail-app3 (Coremail) with SMTP id zS_KCgDHcHOHm7Nq7V5ZBQ--.10433S2;
	Wed, 23 Sep 2026 17:27:35 +0800 (CST)
From: Fan Wu <fanwu01@zju.edu.cn>
To: lgirdwood@gmail.com,
	broonie@kernel.org
Cc: alsa-devel@alsa-project.org,
	linux-sound@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Vijendar.Mukunda@amd.com,
	Syed.SabaKareem@amd.com,
	stable@vger.kernel.org,
	Fan Wu <fanwu01@zju.edu.cn>,
	Song Li <songl@zju.edu.cn>
Subject: [PATCH] ASoC: amd: ps: fix snd_acp63_remove() teardown ordering
Date: Wed, 23 Sep 2026 09:26:40 +0000
Message-Id: <20260923092640.502145-1-fanwu01@zju.edu.cn>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:zS_KCgDHcHOHm7Nq7V5ZBQ--.10433S2
X-CM-SenderInfo: qrstjiaswqq6lmxovvfxof0/
X-CM-DELIVERINFO: =?B?ee7CXQXKKxbFmtjJiESix3B1w3vZ3A9ovKVTomAyoQazvoRs/NHSP8GI2EvgeEEW7R
	sfnZPoDCNGYdHSfuFmYJL54WOJv/C88MNEzSiSpndfKYR2FTTyGypo2l/i3sVkfjsSLcEe
	bUepNW8khWwfHADVnD+p9E6mavGmQbzmcFsnzP86
X-Coremail-Antispam: 1Uk129KBj93XoW7Kr1xZrWDKFW7AryrJF13GFX_yoW8CF1Dpr
	Z8GFZxtrWkJw4jyw4UXayjvFn8CrZ3uF45C39akw1xJFn5GrWvkrWSkFy0vFZ5CrWvya12
	qrW5Ja4YkrZ8AabCm3ZEXasCq-sJn29KB7ZKAUJUUUUU529EdanIXcx71UUUUU7KY7ZEXa
	sCq-sGcSsGvfJ3Ic02F40EFcxC0VAKzVAqx4xG6I80ebIjqfuFe4nvWSU5nxnvy29KBjDU
	0xBIdaVrnRJUUU9Cb4IE77IF4wAFF20E14v26r4j6ryUM7CY07I20VC2zVCF04k26cxKx2
	IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48v
	e4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_tr0E3s1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI
	0_Gr1j6F4UJwA2z4x0Y4vEx4A2jsIE14v26rxl6s0DM28EF7xvwVC2z280aVCY1x0267AK
	xVW0oVCq3wAac4AC62xK8xCEY4vEwIxC4wAS0I0E0xvYzxvE52x082IY62kv0487Mc804V
	CY07AIYIkI8VC2zVCFFI0UMc02F40EFcxC0VAKzVAqx4xG6I80ewAv7VC0I7IYx2IY67AK
	xVWUJVWUGwAv7VC2z280aVAFwI0_Gr0_Cr1lOx8S6xCaFVCjc4AY6r1j6r4UM4x0Y48Icx
	kI7VAKI48JM4x0Y48IcxkI7VAKI48G6xCjnVAKz4kxMxAIw28IcxkI7VAKI48JMxC20s02
	6xCaFVCjc4AY6r1j6r4UMI8I3I0E5I8CrVAFwI0_Jr0_Jr4lx2IqxVCjr7xvwVAFwI0_Jr
	I_JrWlx4CE17CEb7AF67AKxVWUtVW8ZwCIc40Y0x0EwIxGrwCI42IY6xIIjxv20xvE14v2
	6r1j6r1xMIIF0xvE2Ix0cI8IcVCY1x0267AKxVWUJVW8JwCI42IY6xAIw20EY4v20xvaj4
	0_Jr0_JF4lIxAIcVC2z280aVAFwI0_Gr0_Cr1lIxAIcVC2z280aVCY1x0267AKxVW8Jr0_
	Cr1UYxBIdaVFxhVjvjDU0xZFpf9x07jeAp5UUUUU=

The ACP threaded interrupt handler dereferences the SoundWire and PDM
child platform devices, but snd_acp63_remove() unregisters them while
the interrupt is still registered: devm_request_threaded_irq() ties its
release to devres cleanup, which runs only after the remove callback
returns. A completion in this window is a use-after-free.

Fix this by masking the ACP interrupt sources and calling devm_free_irq()
before the first child device is unregistered. The interrupt line is
shared, and acp_hw_deinit() clears the sources only after the children
are gone, which would leave the line raised with no handler left to
ack it. The window predates the tagged refactor, which only reshaped
the dereferences.

This issue was found by an in-house static analysis tool.

Fixes: eaf825037d6d ("ASoC: amd: ps: refactor acp child platform device creation code")
Cc: stable@vger.kernel.org
Co-developed-by: Song Li <songl@zju.edu.cn>
Signed-off-by: Song Li <songl@zju.edu.cn>
Signed-off-by: Fan Wu <fanwu01@zju.edu.cn>
---
 sound/soc/amd/ps/pci-ps.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/sound/soc/amd/ps/pci-ps.c b/sound/soc/amd/ps/pci-ps.c
index 729f9aa..01ee697 100644
--- a/sound/soc/amd/ps/pci-ps.c
+++ b/sound/soc/amd/ps/pci-ps.c
@@ -738,6 +738,12 @@ static void snd_acp63_remove(struct pci_dev *pci)
 	int ret;
 
 	adata = pci_get_drvdata(pci);
+	/* Mask the interrupt sources before freeing the shared IRQ. */
+	writel(ACP_EXT_INTR_STAT_CLEAR_MASK,
+	       adata->acp63_base + ACP_EXTERNAL_INTR_STAT);
+	writel(0, adata->acp63_base + ACP_EXTERNAL_INTR_CNTL);
+	writel(0, adata->acp63_base + ACP_EXTERNAL_INTR_ENB);
+	devm_free_irq(&pci->dev, pci->irq, adata);
 	if (adata->sdw) {
 		amd_sdw_exit(adata);
 		platform_device_unregister(adata->sdw_dma_dev);

