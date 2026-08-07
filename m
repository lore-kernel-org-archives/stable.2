Received: from zg8tmtyylji0my4xnjeumjiw.icoremail.net (zg8tmtyylji0my4xnjeumjiw.icoremail.net [162.243.161.220])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 883DE263F44;
	Fri,  7 Aug 2026 03:36:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=162.243.161.220
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786073787; cv=none; b=fgNuV3qk+X0gIPZjPOe1z304YodeI2UG5I2QKuTXrTaywHBSwxNiY19ytAeKhcuczaFFXXmuRwXWXDUOdUHebszpRcQhAtpGXqris9OGLcZ7ubrHQfeoOz/55oPX2CXdpBw70HIu27Ny4JammyshWUAv6/F6cUGz9TfEiS+Vu3c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786073787; c=relaxed/simple;
	bh=MNRvP6qn2uQWLuqkPH1ENweAZY/IbhBI3i9U6zQiwi0=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=gewfv9FHx8DHggy+YnEh1CYmukYbWFZtmzgGwp3HvzWXObnHLxGoyb/rbK3+daXUua5aIaP4qVl2AC/LruXfRV6rVjN4SfUi3iPVZol2Koj5B2N1LZqmQt3QYeHcoa0zfgg+BBquIHzaUzaHTGjXULPk4yAUwxoSJSx8hWtkywk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=zju.edu.cn; spf=pass smtp.mailfrom=zju.edu.cn; arc=none smtp.client-ip=162.243.161.220
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=zju.edu.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=zju.edu.cn
Received: from zju.edu.cn (unknown [10.98.66.117])
	by mtasvr (Coremail) with SMTP id _____wCHnnywUnVqWgRxAA--.757S3;
	Fri, 07 Aug 2026 11:36:16 +0800 (CST)
Received: from localhost.localdomain (unknown [10.98.66.117])
	by mail-app4 (Coremail) with SMTP id zi_KCgB3fDawUnVqY774Ag--.61218S2;
	Fri, 07 Aug 2026 11:36:16 +0800 (CST)
From: Fan Wu <fanwu01@zju.edu.cn>
To: sre@kernel.org
Cc: linux-pm@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Fan Wu <fanwu01@zju.edu.cn>,
	stable@vger.kernel.org
Subject: [PATCH] power: supply: lp8727: fix use-after-free in lp8727_release_irq()
Date: Fri,  7 Aug 2026 03:35:20 +0000
Message-Id: <20260807033520.8551-1-fanwu01@zju.edu.cn>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:zi_KCgB3fDawUnVqY774Ag--.61218S2
X-CM-SenderInfo: qrstjiaswqq6lmxovvfxof0/
X-CM-DELIVERINFO: =?B?zF189QXKKxbFmtjJiESix3B1w3vZ3A9ovKVTomAyoQazvoRs/NHSP8GI2EvgeEEW7R
	sfnXz+g1OQfMo27QHy5TwQyZwTBuZ9Xr0BnyP0TluZkNXp9hrpjqB4/anm/ED4m6oMY5Ct
	lkZxRgqngEeZ/cMkGeap9E6mavGmQbzmcFsnzP86
X-Coremail-Antispam: 1Uk129KBj93XoW7uF13tryDKr1DGrWftFy7urX_yoW8XF13p3
	9xGr90kF1jqF4Ut3ZrZanFgFy5GFsIyFy5CrW8Aw13Z3W3tw4Utw15WFWagFy7Ar92vFWS
	9r9IqFn2vF15GrXCm3ZEXasCq-sJn29KB7ZKAUJUUUUU529EdanIXcx71UUUUU7KY7ZEXa
	sCq-sGcSsGvfJ3Ic02F40EFcxC0VAKzVAqx4xG6I80ebIjqfuFe4nvWSU5nxnvy29KBjDU
	0xBIdaVrnRJUUU9Gb4IE77IF4wAFF20E14v26r1j6r4UM7CY07I20VC2zVCF04k26cxKx2
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
	0_Jr0_JF4lIxAIcVC2z280aVAFwI0_Jr0_Gr1lIxAIcVC2z280aVCY1x0267AKxVW8JVW8
	JrUvcSsGvfC2KfnxnUUI43ZEXa7IU8I_M3UUUUU==

lp8727_isr_func(), the threaded IRQ handler, is the only caller that arms
pchg->work via schedule_delayed_work().  lp8727_release_irq() currently
cancels the work before freeing the IRQ, so an IRQ delivered in between
can re-arm the work through the threaded handler.  After .remove returns
the devm layer frees pchg while lp8727_delayed_func() may still run and
dereference it.

Free the IRQ first so the threaded handler is quiesced and can no longer
queue work, then cancel the delayed work to drain the final generation.

This issue was found by an in-house static analysis tool.

Fixes: d71fda016102 ("lp8727_charger: Clean up the interrupt handler")
Cc: stable@vger.kernel.org
Assisted-by: Codex:gpt-5.6
Signed-off-by: Fan Wu <fanwu01@zju.edu.cn>
---
 drivers/power/supply/lp8727_charger.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/power/supply/lp8727_charger.c b/drivers/power/supply/lp8727_charger.c
index 4186fcd37512..e81bb393340c 100644
--- a/drivers/power/supply/lp8727_charger.c
+++ b/drivers/power/supply/lp8727_charger.c
@@ -280,10 +280,10 @@ static int lp8727_setup_irq(struct lp8727_chg *pchg)

 static void lp8727_release_irq(struct lp8727_chg *pchg)
 {
-	cancel_delayed_work_sync(&pchg->work);
-
 	if (pchg->irq)
 		free_irq(pchg->irq, pchg);
+
+	cancel_delayed_work_sync(&pchg->work);
 }

 static enum power_supply_property lp8727_charger_prop[] = {
--
2.34.1

