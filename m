Received: from azure-sdnproxy.icoremail.net (azure-sdnproxy.icoremail.net [4.193.249.245])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7AFD143E9C9;
	Fri, 14 Aug 2026 08:27:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=4.193.249.245
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786696033; cv=none; b=oXr0V2d5gpB7wqA6fcdYAoO1ATpgWvBkAw6nj6JT1KDA5k9aBdr/7ssEIq4N69N/zsPmtRdmbJKBhM19YyGCu8iZd+hgFSoALU+MJwE8X0Wq/VYQEN2Ss1hq/bZ8gM6iiBPeJvL0XGs5EjOMZmASUfpbnbjHpvLborj/kU11O6A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786696033; c=relaxed/simple;
	bh=jrxy6ltZbF1O4LWClHfK+e6GYIHG+TPuuHkWM9kg8bE=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=H4t26pjYH8pAp54ewFxcbbfBD4TuP/H35+w43U/Saij8yOR/DhhQN5vetooiI29ImRrwUvKe1Ph1g/dzzgTMEMu4UHgB0g9TH0gZl4k19KAmrAmzsZM5x1tUbdG7pC8QzajPKHn+GdYWgzYWFIRiEGRDKgl6hL8jxqaZb7pUbGc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=zju.edu.cn; spf=pass smtp.mailfrom=zju.edu.cn; arc=none smtp.client-ip=4.193.249.245
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=zju.edu.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=zju.edu.cn
Received: from zju.edu.cn (unknown [10.98.66.117])
	by mtasvr (Coremail) with SMTP id _____wCnr39G0X5qoK+RAA--.11800S3;
	Fri, 14 Aug 2026 16:26:46 +0800 (CST)
Received: from localhost.localdomain (unknown [10.98.66.117])
	by mail-app1 (Coremail) with SMTP id yy_KCgCXUppF0X5qAh_dAw--.15203S2;
	Fri, 14 Aug 2026 16:26:45 +0800 (CST)
From: Fan Wu <fanwu01@zju.edu.cn>
To: linux@armlinux.org.uk,
	ulf.hansson@linaro.org
Cc: linux-mmc@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linus.walleij@linaro.org,
	stable@vger.kernel.org,
	Fan Wu <fanwu01@zju.edu.cn>
Subject: [PATCH] mmc: mmci: Fix use-after-free in busy-timeout work
Date: Fri, 14 Aug 2026 08:25:50 +0000
Message-Id: <20260814082550.211496-1-fanwu01@zju.edu.cn>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:yy_KCgCXUppF0X5qAh_dAw--.15203S2
X-CM-SenderInfo: qrstjiaswqq6lmxovvfxof0/
X-CM-DELIVERINFO: =?B?bUJ4AgXKKxbFmtjJiESix3B1w3vZ3A9ovKVTomAyoQazvoRs/NHSP8GI2EvgeEEW7R
	sfnVCjTgEH9dVomQuWcozCBBGgP0LOd0j1uYmdfBtL/HWQ4pvpN8AVY7NZMG5U03C88Qja
	JT2m5cSu+Jdz41juMb+p9E6mavGmQbzmcFsnzP86
X-Coremail-Antispam: 1Uk129KBj93XoWruF48Gw4xtrW8uw4ktFWDGFX_yoW8JF4UpF
	Wru3y7KrZ8KF4ayayDCwnFgF15AwsYy393Gr1xG3yFvwn8KF9xGF1fKayFqFWDXF97KFs2
	vF48Jw1DurnYyFgCm3ZEXasCq-sJn29KB7ZKAUJUUUUU529EdanIXcx71UUUUU7KY7ZEXa
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
	I_JrWlx4CE17CEb7AF67AKxVWUAVWUtwCIc40Y0x0EwIxGrwCI42IY6xIIjxv20xvE14v2
	6r1j6r1xMIIF0xvE2Ix0cI8IcVCY1x0267AKxVW8JVWxJwCI42IY6xAIw20EY4v20xvaj4
	0_Jr0_JF4lIxAIcVC2z280aVAFwI0_Gr0_Cr1lIxAIcVC2z280aVCY1x0267AKxVW8JVW8
	JrUvcSsGvfC2KfnxnUUI43ZEXa7IU818BUUUUUU==

ux500_busy_complete() can queue ux500_busy_timeout_work for an R1b
command, but mmci_remove() never cancels it. The work can subsequently
dereference the devm-allocated mmci_host after it has been released.

Mask the controller interrupts and disable the delayed work during
removal. This drains any queued instance and stops an IRQ handler that
is still in progress from queueing the work again once it has been
disabled.

This issue was found by an in-house static analysis tool.

Fixes: b1a665932dc2 ("mmc: mmci: Add support for SW busy-end timeouts")
Cc: stable@vger.kernel.org # v6.10+
Assisted-by: Codex:gpt-5.6
Signed-off-by: Fan Wu <fanwu01@zju.edu.cn>
---
 drivers/mmc/host/mmci.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/mmc/host/mmci.c b/drivers/mmc/host/mmci.c
index e500051bd..416bdb184 100644
--- a/drivers/mmc/host/mmci.c
+++ b/drivers/mmc/host/mmci.c
@@ -2511,6 +2511,9 @@ static void mmci_remove(struct amba_device *dev)
 		writel(0, host->base + MMCICOMMAND);
 		writel(0, host->base + MMCIDATACTRL);
 
+		if (variant->busy_detect)
+			disable_delayed_work_sync(&host->ux500_busy_timeout_work);
+
 		mmci_dma_release(host);
 		clk_disable_unprepare(host->clk);
 	}

