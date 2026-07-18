Received: from zg8tmja2lje4os43os4xodqa.icoremail.net (zg8tmja2lje4os43os4xodqa.icoremail.net [206.189.79.184])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ABED025B09F;
	Sat, 18 Jul 2026 02:44:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=206.189.79.184
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784342699; cv=none; b=bfM08KBp4+fSaXnSxwIn5JQThHBTmRIakfCkPTslO9Ejax4G7REVJgzpVo+MDg0y7xRWq7+6Pgy1QPzk5yDAAuiTiJAIhLqevNNYCWEd4WYNosYNajjVJQAt+NW/NHyKesNGJY8fE6gBUyXUjaBwDdOH6vAfnT/XHXD33YIuFmc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784342699; c=relaxed/simple;
	bh=67J5Fgv1g+WjNPQavQi2nkbOwU2YuDTAPjsDdjDvZk4=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=TZIuV2SuI94pW3oWI0TDL7SeB65uUL46CfGQJwLKiRxa05GRm7oXxHgDe5g+AaiEmPXGKc1RFdowAN4puUNOYSVcxvOuYSY/GOv0LryL/uCFgTGO8xUHmbaZblTWSQnkcD//AlvtbCkCDZMHvWuCW8zQ0Lj3YgDtHf97MYKd3Og=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=zju.edu.cn; spf=pass smtp.mailfrom=zju.edu.cn; arc=none smtp.client-ip=206.189.79.184
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=zju.edu.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=zju.edu.cn
Received: from zju.edu.cn (unknown [10.98.66.117])
	by mtasvr (Coremail) with SMTP id _____wC3NjWi6FpqgykLAA--.4810S3;
	Sat, 18 Jul 2026 10:44:50 +0800 (CST)
Received: from localhost.localdomain (unknown [10.98.66.117])
	by mail-app3 (Coremail) with SMTP id zS_KCgBnMXWg6Fpq+aBHAw--.27942S3;
	Sat, 18 Jul 2026 10:44:50 +0800 (CST)
From: Fan Wu <fanwu01@zju.edu.cn>
To: arend.vanspriel@broadcom.com,
	kvalo@kernel.org
Cc: eddiephillips@google.com,
	franky.lin@broadcom.com,
	hante.meuleman@broadcom.com,
	wright.feng@infineon.com,
	linux-wireless@vger.kernel.org,
	brcm80211@lists.linux.dev,
	brcm80211-dev-list.pdl@broadcom.com,
	SHA-cyfmac-dev-list@infineon.com,
	linux-kernel@vger.kernel.org,
	Fan Wu <fanwu01@zju.edu.cn>,
	stable@vger.kernel.org
Subject: [PATCH v2 1/2] wifi: brcmfmac: make release_scratchbuffers idempotent
Date: Sat, 18 Jul 2026 02:43:52 +0000
Message-Id: <20260718024353.3147201-2-fanwu01@zju.edu.cn>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260718024353.3147201-1-fanwu01@zju.edu.cn>
References: <20260718024353.3147201-1-fanwu01@zju.edu.cn>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:zS_KCgBnMXWg6Fpq+aBHAw--.27942S3
X-CM-SenderInfo: qrstjiaswqq6lmxovvfxof0/
X-CM-DELIVERINFO: =?B?CIqjvQXKKxbFmtjJiESix3B1w3vZ3A9ovKVTomAyoQazvoRs/NHSP8GI2EvgeEEW7R
	sfnZPoDCNGYdHSfuFmYJL54WNxrLdUUyojjsh/MFpH0EOURAe6WXmf9rU7cGu361cagswD
	49fJYyanNG7eGj/tRo8nLJuT1O+x+sR/9gt+BHM5
X-Coremail-Antispam: 1Uk129KBj93XoW7ZryUKFW7tw4DCrWxAr4fWFX_yoW8KF1xpF
	y3KFWjyF4UArWkW393uF13ZFyFkanYy345C3yxJ34fu3y5AryrXr40kFy0vrZ8ArWftay2
	qw48t345Xr15WacCm3ZEXasCq-sJn29KB7ZKAUJUUUUU529EdanIXcx71UUUUU7KY7ZEXa
	sCq-sGcSsGvfJ3Ic02F40EFcxC0VAKzVAqx4xG6I80ebIjqfuFe4nvWSU5nxnvy29KBjDU
	0xBIdaVrnRJUUUP0b4IE77IF4wAFF20E14v26r4j6ryUM7CY07I20VC2zVCF04k26cxKx2
	IYs7xG6rWj6s0DM7CIcVAFz4kK6r106r15M28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48v
	e4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_tr0E3s1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI
	0_Gr1j6F4UJwA2z4x0Y4vEx4A2jsIE14v26rxl6s0DM28EF7xvwVC2z280aVCY1x0267AK
	xVW0oVCq3wAac4AC62xK8xCEY4vEwIxC4wAS0I0E0xvYzxvE52x082IY62kv0487Mc804V
	CY07AIYIkI8VC2zVCFFI0UMc02F40EFcxC0VAKzVAqx4xG6I80ewAv7VC0I7IYx2IY67AK
	xVWUJVWUGwAv7VC2z280aVAFwI0_Jr0_Gr1lOx8S6xCaFVCjc4AY6r1j6r4UM4x0Y48Icx
	kI7VAKI48JM4x0Y48IcxkI7VAKI48G6xCjnVAKz4kxM4IIrI8v6xkF7I0E8cxan2IY04v7
	MxAIw28IcxkI7VAKI48JMxC20s026xCaFVCjc4AY6r1j6r4UMI8I3I0E5I8CrVAFwI0_Jr
	0_Jr4lx2IqxVCjr7xvwVAFwI0_JrI_JrWlx4CE17CEb7AF67AKxVWUtVW8ZwCIc40Y0x0E
	wIxGrwCI42IY6xIIjxv20xvE14v26r1j6r1xMIIF0xvE2Ix0cI8IcVCY1x0267AKxVW8JV
	WxJwCI42IY6xAIw20EY4v20xvaj40_Jr0_JF4lIxAIcVC2z280aVAFwI0_Jr0_Gr1lIxAI
	cVC2z280aVCY1x0267AKxVW8JVW8JrUvcSsGvfC2KfnxnUUI43ZEXa7IU8D5r7UUUUU==

brcmf_pcie_release_scratchbuffers() frees the shared.scratch and
shared.ringupd DMA buffers with dma_free_coherent() but does not clear
the pointers afterwards, unlike the sibling release_ringbuffers() which
NULLs commonrings/flowrings/idxbuf on release.

Both the bus_reset .reset callback (brcmf_pcie_reset) and
brcmf_pcie_remove() call release_scratchbuffers.  When reset teardown
has run before removal, remove's own teardown would call
dma_free_coherent() a second time on the already-freed DMA allocation.

NULL the pointers after free, matching release_ringbuffers(), so a later
release observes that the allocation has already been released.  This
patch makes repeated sequential release safe; the reset-work lifetime is
handled separately by the following patch.

This issue was found by an in-house static analysis tool.

Fixes: 4684997d9eea ("brcmfmac: reset PCIe bus on a firmware crash")
Cc: stable@vger.kernel.org
Signed-off-by: Fan Wu <fanwu01@zju.edu.cn>
Assisted-by: Codex:gpt-5.6
---
 drivers/net/wireless/broadcom/brcm80211/brcmfmac/pcie.c | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/drivers/net/wireless/broadcom/brcm80211/brcmfmac/pcie.c b/drivers/net/wireless/broadcom/brcm80211/brcmfmac/pcie.c
index 13662aa4b..9f10b3fff 100644
--- a/drivers/net/wireless/broadcom/brcm80211/brcmfmac/pcie.c
+++ b/drivers/net/wireless/broadcom/brcm80211/brcmfmac/pcie.c
@@ -1383,16 +1383,20 @@ static int brcmf_pcie_init_ringbuffers(struct brcmf_pciedev_info *devinfo)
 static void
 brcmf_pcie_release_scratchbuffers(struct brcmf_pciedev_info *devinfo)
 {
-	if (devinfo->shared.scratch)
+	if (devinfo->shared.scratch) {
 		dma_free_coherent(&devinfo->pdev->dev,
 				  BRCMF_DMA_D2H_SCRATCH_BUF_LEN,
 				  devinfo->shared.scratch,
 				  devinfo->shared.scratch_dmahandle);
-	if (devinfo->shared.ringupd)
+		devinfo->shared.scratch = NULL;
+	}
+	if (devinfo->shared.ringupd) {
 		dma_free_coherent(&devinfo->pdev->dev,
 				  BRCMF_DMA_D2H_RINGUPD_BUF_LEN,
 				  devinfo->shared.ringupd,
 				  devinfo->shared.ringupd_dmahandle);
+		devinfo->shared.ringupd = NULL;
+	}
 }
 
 static int brcmf_pcie_init_scratchbuffers(struct brcmf_pciedev_info *devinfo)
-- 
2.34.1

