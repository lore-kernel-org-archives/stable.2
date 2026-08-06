Received: from zg8tmtyylji0my4xnjeumjiw.icoremail.net (zg8tmtyylji0my4xnjeumjiw.icoremail.net [162.243.161.220])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8DE431C5499;
	Thu,  6 Aug 2026 13:03:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=162.243.161.220
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786021428; cv=none; b=meizSuF239EWQ2gFo/ubbnqAB2+NDvgoWD9tiQlrpiJ16RSpMr+q6bRdwuJB7zHHGIFzEcm7s4vQ4IL72kPtCG4dZHa84GHj13Pqi84tO5m16Ys9CL9y2jSjaO3UucJdVFHYwPgdjBsfMeN3oNOV0W0tCZjm96UTdenoWj4h+Pc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786021428; c=relaxed/simple;
	bh=YgTWFgzC8mTBxns/Pi3eku74E2Vn36aGhI8IqrJKKPU=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=SdxynwoHM2SOgmUMNbPj8W2xovslN7l2In8rKwWXFy6a/y1lAtfq1ZnTridhsFo7nZ8yAoWCHedxn0U9rSZvhLy6QGWa40l5oOeNhgAEqwCzq7TWxMR0t6FS/UNso/Mo3uf1X8cwqqZUMTZYo0aLNy1911o3TZCb/Usek84kNIo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=zju.edu.cn; spf=pass smtp.mailfrom=zju.edu.cn; arc=none smtp.client-ip=162.243.161.220
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=zju.edu.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=zju.edu.cn
Received: from zju.edu.cn (unknown [10.98.66.117])
	by mtasvr (Coremail) with SMTP id _____wAHIT0ghnRq2zZuAA--.29244S3;
	Thu, 06 Aug 2026 21:03:28 +0800 (CST)
Received: from localhost.localdomain (unknown [10.98.66.117])
	by mail-app2 (Coremail) with SMTP id zC_KCgBn+tAghnRq5GCcAw--.32056S2;
	Thu, 06 Aug 2026 21:03:28 +0800 (CST)
From: Fan Wu <fanwu01@zju.edu.cn>
To: Ulf Hansson <ulf.hansson@linaro.org>
Cc: linux-mmc@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org,
	Fan Wu <fanwu01@zju.edu.cn>
Subject: [PATCH] mmc: core: Cancel SDIO IRQ work before freeing host
Date: Thu,  6 Aug 2026 13:02:33 +0000
Message-Id: <20260806130233.465653-1-fanwu01@zju.edu.cn>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:zC_KCgBn+tAghnRq5GCcAw--.32056S2
X-CM-SenderInfo: qrstjiaswqq6lmxovvfxof0/
X-CM-DELIVERINFO: =?B?XFss5gXKKxbFmtjJiESix3B1w3vZ3A9ovKVTomAyoQazvoRs/NHSP8GI2EvgeEEW7R
	sfncGSG+szpQCInt5Y8rbJUI0M7GWogc7cFz+b3EwRemTZEK5O1zVZUdLh9M5Bxfwi0vBh
	UcEb0jb9nnCHXmHnwfkgbBHHLWcKaCRkBzV/TL6J
X-Coremail-Antispam: 1Uk129KBj93XoW7Kry3JF4UJrWrAFW8Wr15GFX_yoW8Gr47pF
	Z3Wr9rKFWUGFs0ywnrG3WxZFyru3Z3t3yUC3s2gw1xZrn8Ca4jyrnrCFWFgFyYyrZ7ta1a
	vF4Iq34jgFyYyFXCm3ZEXasCq-sJn29KB7ZKAUJUUUUU529EdanIXcx71UUUUU7KY7ZEXa
	sCq-sGcSsGvfJ3Ic02F40EFcxC0VAKzVAqx4xG6I80ebIjqfuFe4nvWSU5nxnvy29KBjDU
	0xBIdaVrnRJUUU9Gb4IE77IF4wAFF20E14v26r1j6r4UM7CY07I20VC2zVCF04k26cxKx2
	IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48v
	e4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_tr0E3s1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI
	0_Gr1j6F4UJwA2z4x0Y4vEx4A2jsIE14v26rxl6s0DM28EF7xvwVC2z280aVCY1x0267AK
	xVW0oVCq3wAac4AC62xK8xCEY4vEwIxC4wAS0I0E0xvYzxvE52x082IY62kv0487Mc804V
	CY07AIYIkI8VC2zVCFFI0UMc02F40EFcxC0VAKzVAqx4xG6I80ewAv7VC0I7IYx2IY67AK
	xVWUAVWUtwAv7VC2z280aVAFwI0_Jr0_Gr1lOx8S6xCaFVCjc4AY6r1j6r4UM4x0Y48Icx
	kI7VAKI48JM4x0Y48IcxkI7VAKI48G6xCjnVAKz4kxMxAIw28IcxkI7VAKI48JMxC20s02
	6xCaFVCjc4AY6r1j6r4UMI8I3I0E5I8CrVAFwI0_Jr0_Jr4lx2IqxVCjr7xvwVAFwI0_Jr
	I_JrWlx4CE17CEb7AF67AKxVWUAVWUtwCIc40Y0x0EwIxGrwCI42IY6xIIjxv20xvE14v2
	6r1j6r1xMIIF0xvE2Ix0cI8IcVCY1x0267AKxVWUJVW8JwCI42IY6xAIw20EY4v20xvaj4
	0_Jr0_JF4lIxAIcVC2z280aVAFwI0_Jr0_Gr1lIxAIcVC2z280aVCY1x0267AKxVW8JVW8
	JrUvcSsGvfC2KfnxnUUI43ZEXa7IU8373PUUUUU==

A host controller that uses sdio_signal_irq() schedules host->sdio_irq_work
from its interrupt handler.  That work is only cancelled on the suspend
path (mmc_sdio_suspend()), not on the remove/free path, so a worker armed
just before the controller freed its IRQ can run after
mmc_host_classdev_release() has freed the host and dereference it through
container_of().

Cancel host->sdio_irq_work in mmc_free_host(), like the existing
host->detect drain added by commit 1036f69e2513 ("mmc: core: Cancel
delayed work before releasing host").

This issue was found by an in-house static analysis tool.

Fixes: 682696605c7093d ("mmc: sdio: Add API to manage SDIO IRQs from a workqueue")
Cc: stable@vger.kernel.org
Assisted-by: Codex:gpt-5.6
Signed-off-by: Fan Wu <fanwu01@zju.edu.cn>
---
 drivers/mmc/core/host.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/mmc/core/host.c b/drivers/mmc/core/host.c
index 88c95dbfd9cf..becb5a850a2f 100644
--- a/drivers/mmc/core/host.c
+++ b/drivers/mmc/core/host.c
@@ -693,6 +693,7 @@ EXPORT_SYMBOL(mmc_remove_host);
 void mmc_free_host(struct mmc_host *host)
 {
 	cancel_delayed_work_sync(&host->detect);
+	cancel_work_sync(&host->sdio_irq_work);
 	mmc_pwrseq_free(host);
 	put_device(&host->class_dev);
 }
--
2.34.1

