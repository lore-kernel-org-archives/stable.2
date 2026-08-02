Received: from azure-sdnproxy.icoremail.net (azure-sdnproxy.icoremail.net [13.75.44.102])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 37A7C2EFD95;
	Sun,  2 Aug 2026 08:29:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.75.44.102
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785659402; cv=none; b=Sz6XIia65LWqLxyeqM/9QjM3fImoW/W2vPr2NUgnj7NnopUOZYIum8554O1TRXIe9OXP1W4gCYcDqBZRN0X/ni/Ahq+I0zg+O/ki/XrfqJOb6KpK6qwaNBT+HS95rHa6RSWr0IF0jeAFXP0C/lR3zshe+h7p+W3T7NTgeKKqqS0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785659402; c=relaxed/simple;
	bh=PlE4ERs74VtIy+/wCICNFBzU9jcPbmoDZq356zqocUg=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=LTdmtCt+1Ry2/SVvS8DOeqrdHLhJgk2jM2gRaMEEnLtsij0OmIqs4t0ts0txDRB0NR6LufSkzWbCFSGnW/tZh17s0vdts4lre5E5uiQzo8xkdzURtAYX1f6Q2k4iyU65d2si2INcDRXhKnhDJwVktY2kLN3gfm56vcwp89XIlTc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=zju.edu.cn; spf=pass smtp.mailfrom=zju.edu.cn; arc=none smtp.client-ip=13.75.44.102
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=zju.edu.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=zju.edu.cn
Received: from zju.edu.cn (unknown [10.98.66.117])
	by mtasvr (Coremail) with SMTP id _____wD3_3_6_25q6fxZAA--.11052S3;
	Sun, 02 Aug 2026 16:29:47 +0800 (CST)
Received: from localhost.localdomain (unknown [10.98.66.117])
	by mail-app1 (Coremail) with SMTP id yy_KCgBHl5_6_25qCD5sAw--.1884S2;
	Sun, 02 Aug 2026 16:29:46 +0800 (CST)
From: Fan Wu <fanwu01@zju.edu.cn>
To: jic23@kernel.org
Cc: dlechner@baylibre.com,
	nuno.sa@analog.com,
	michal.simek@amd.com,
	bgolaszewski@baylibre.com,
	DileepKumar.Nagavarapu@amd.com,
	linux-iio@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	Fan Wu <fanwu01@zju.edu.cn>,
	stable@vger.kernel.org
Subject: [PATCH] iio: adc: xilinx-xadc: free IRQ before cancelling the unmask worker on unbind
Date: Sun,  2 Aug 2026 08:28:51 +0000
Message-Id: <20260802082851.433476-1-fanwu01@zju.edu.cn>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:yy_KCgBHl5_6_25qCD5sAw--.1884S2
X-CM-SenderInfo: qrstjiaswqq6lmxovvfxof0/
X-CM-DELIVERINFO: =?B?btb02gXKKxbFmtjJiESix3B1w3vZ3A9ovKVTomAyoQazvoRs/NHSP8GI2EvgeEEW7R
	sfnVCjTgEH9dVomQuWcozCBBGRo8lAmPKWKST9FZp3JmJ1akyYodxcOZO9HHuCIM8aHHvc
	sBZVXB3MBxuveE04HEYB5rM+H8XhqwExY4Cjs2QP
X-Coremail-Antispam: 1Uk129KBj93XoW7KF4DWr4xJFWrAryxCr1ruFX_yoW8Kw1xpr
	W5GFZ8CrWUZr4IqF98uF48ZFyj9rnxJw17Cr4Ig34fJwn8Xr40vF15tFZ2ga15WrZ7u3Wq
	vr4IqaykuFZ8uFcCm3ZEXasCq-sJn29KB7ZKAUJUUUUU529EdanIXcx71UUUUU7KY7ZEXa
	sCq-sGcSsGvfJ3Ic02F40EFcxC0VAKzVAqx4xG6I80ebIjqfuFe4nvWSU5nxnvy29KBjDU
	0xBIdaVrnRJUUUP0b4IE77IF4wAFF20E14v26r4j6ryUM7CY07I20VC2zVCF04k26cxKx2
	IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48v
	e4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_tr0E3s1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI
	0_Gr1j6F4UJwA2z4x0Y4vEx4A2jsIE14v26rxl6s0DM28EF7xvwVC2z280aVCY1x0267AK
	xVW0oVCq3wAac4AC62xK8xCEY4vEwIxC4wAS0I0E0xvYzxvE52x082IY62kv0487Mc804V
	CY07AIYIkI8VC2zVCFFI0UMc02F40EFcxC0VAKzVAqx4xG6I80ewAv7VC0I7IYx2IY67AK
	xVWUJVWUGwAv7VC2z280aVAFwI0_Gr0_Cr1lOx8S6xCaFVCjc4AY6r1j6r4UM4x0Y48Icx
	kI7VAKI48JM4x0Y48IcxkI7VAKI48G6xCjnVAKz4kxM4IIrI8v6xkF7I0E8cxan2IY04v7
	MxAIw28IcxkI7VAKI48JMxC20s026xCaFVCjc4AY6r1j6r4UMI8I3I0E5I8CrVAFwI0_Jr
	0_Jr4lx2IqxVCjr7xvwVAFwI0_JrI_JrWlx4CE17CEb7AF67AKxVWUtVW8ZwCIc40Y0x0E
	wIxGrwCI42IY6xIIjxv20xvE14v26r1j6r1xMIIF0xvE2Ix0cI8IcVCY1x0267AKxVWUJV
	W8JwCI42IY6xAIw20EY4v20xvaj40_Jr0_JF4lIxAIcVC2z280aVAFwI0_Jr0_Gr1lIxAI
	cVC2z280aVCY1x0267AKxVW8JVW8JrUvcSsGvfC2KfnxnUUI43ZEXa7IU86c_DUUUUU==

The ZYNQ XADC interrupt handler xadc_zynq_interrupt_handler() arms the
zynq_unmask_work delayed work via schedule_delayed_work() every time an
alarm condition is observed, and that worker re-arms itself for as long
as the alarm stays asserted.

In xadc_probe() the IRQ is requested with devm_request_irq() before the
devm_add_action_or_reset() that registers xadc_cancel_delayed_work().
Because devres release runs in LIFO order, on unbind the delayed work is
cancelled before the IRQ is freed. The IRQ is still live at that point,
so a pending alarm can make the handler run once more and re-arm
zynq_unmask_work after it has been cancelled; that instance then runs
after the xadc structure that embeds zynq_unmask_work has been freed, a
use-after-free in xadc_zynq_unmask_worker().

Register the cancel-work devm action before requesting the IRQ so devres
LIFO teardown frees (and synchronizes) the IRQ first, then cancels the
delayed work. After free_irq() the handler can no longer re-arm the
work, and the subsequent cancel_delayed_work_sync() drains any instance
armed just before the IRQ was torn down.

This issue was found by an in-house static analysis tool.

Fixes: 2a9685d1a3b7 ("iio: adc: xilinx: use more devres helpers and remove remove()")
Cc: stable@vger.kernel.org
Assisted-by: Codex:gpt-5.6
Signed-off-by: Fan Wu <fanwu01@zju.edu.cn>
---

 drivers/iio/adc/xilinx-xadc-core.c | 11 +++++++----
 1 file changed, 7 insertions(+), 4 deletions(-)

diff --git a/drivers/iio/adc/xilinx-xadc-core.c b/drivers/iio/adc/xilinx-xadc-core.c
--- a/drivers/iio/adc/xilinx-xadc-core.c
+++ b/drivers/iio/adc/xilinx-xadc-core.c
@@ -1395,13 +1395,16 @@ static int xadc_probe(struct platform_device *pdev)
 	}

 	if (irq > 0) {
-		ret = devm_request_irq(dev, irq, xadc->ops->interrupt_handler,
-				       0, dev_name(dev), indio_dev);
+		/* devm LIFO: register the cancel-work action before the IRQ,
+		 * so unbind frees the IRQ first, then drains the work.
+		 */
+		ret = devm_add_action_or_reset(dev, xadc_cancel_delayed_work,
+					       &xadc->zynq_unmask_work);
 		if (ret)
 			return ret;

-		ret = devm_add_action_or_reset(dev, xadc_cancel_delayed_work,
-					       &xadc->zynq_unmask_work);
+		ret = devm_request_irq(dev, irq, xadc->ops->interrupt_handler,
+				       0, dev_name(dev), indio_dev);
 		if (ret)
 			return ret;
 	}
--
2.43.0

