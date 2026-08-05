Received: from azure-sdnproxy.icoremail.net (azure-sdnproxy.icoremail.net [52.237.72.81])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6480421CA03;
	Wed,  5 Aug 2026 05:09:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=52.237.72.81
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785906586; cv=none; b=AjUmcDCgRnV5y4rtLUdGkTIqTXUrcUDcMFNzv3vy+FnDfoG6IJjNMFWbpGBs7aoNszuxe/Dw93W6yq3wL0WcnqW4mFN2GXcMVhULSfGc5oTRbpNGTZWEXrgg05Jsw6MYPJfP3bqq6ng514G4DZQmvKYVJgpQwZ0zBbX9AQf/U0U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785906586; c=relaxed/simple;
	bh=HjWWJefteFWpDlrmQ032rxZi45hf4pcnWZ6kRSCl+5U=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=boMG8fscteDOBR5cwd0jLlUDO8btGH4Ry72F99MPju5BA9s2iTOMfyzFicv4Z5tXRm1hvb1XmUIPRQOjkmTlfhlkBGc+ak++CMeeEr5ihOvRVqTLqCwgorIseqE+nU+G1d99ht254np9y07LFP+Qqk33bjFCsXw16WBF6JKNco8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=zju.edu.cn; spf=pass smtp.mailfrom=zju.edu.cn; arc=none smtp.client-ip=52.237.72.81
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=zju.edu.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=zju.edu.cn
Received: from zju.edu.cn (unknown [10.98.66.117])
	by mtasvr (Coremail) with SMTP id _____wAHIT2QxXJqguhnAA--.17383S3;
	Wed, 05 Aug 2026 13:09:36 +0800 (CST)
Received: from localhost.localdomain (unknown [10.98.66.117])
	by mail-app3 (Coremail) with SMTP id zS_KCgBnMXWQxXJqZyT4Aw--.53983S2;
	Wed, 05 Aug 2026 13:09:36 +0800 (CST)
From: Fan Wu <fanwu01@zju.edu.cn>
To: myungjoo.ham@samsung.com,
	cw00.choi@samsung.com
Cc: hansg@kernel.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org,
	Fan Wu <fanwu01@zju.edu.cn>
Subject: [PATCH] extcon: lc824206xa: Use devm_work_autocancel() for detect work
Date: Wed,  5 Aug 2026 05:08:41 +0000
Message-Id: <20260805050841.7990-1-fanwu01@zju.edu.cn>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:zS_KCgBnMXWQxXJqZyT4Aw--.53983S2
X-CM-SenderInfo: qrstjiaswqq6lmxovvfxof0/
X-CM-DELIVERINFO: =?B?3/16gwXKKxbFmtjJiESix3B1w3vZ3A9ovKVTomAyoQazvoRs/NHSP8GI2EvgeEEW7R
	sfnZPoDCNGYdHSfuFmYJL54WNXXFTAC/IIyQ1Qcoiuv4FqdNs4TPmPIfyvVmC/afttLgDt
	xf8ZGR8K9afn84LHeRbN5RPxYw6l01w8CbPzC/8w
X-Coremail-Antispam: 1Uk129KBj93XoW7trWDJrW5AF45CF17Jw1DJwc_yoW8uw43pF
	Z8CF1Yvr4kAF13KF1qvF42vr17Gw47JF1UurWDKa4a9a9Iqryvvr1q9Fyxtrn8ArW0v3y3
	ZrW5tay8Zr43CFXCm3ZEXasCq-sJn29KB7ZKAUJUUUUU529EdanIXcx71UUUUU7KY7ZEXa
	sCq-sGcSsGvfJ3Ic02F40EFcxC0VAKzVAqx4xG6I80ebIjqfuFe4nvWSU5nxnvy29KBjDU
	0xBIdaVrnRJUUU9Gb4IE77IF4wAFF20E14v26r1j6r4UM7CY07I20VC2zVCF04k26cxKx2
	IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48v
	e4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_tr0E3s1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI
	0_Gr1j6F4UJwA2z4x0Y4vEx4A2jsIE14v26rxl6s0DM28EF7xvwVC2z280aVCY1x0267AK
	xVW0oVCq3wAac4AC62xK8xCEY4vEwIxC4wAS0I0E0xvYzxvE52x082IY62kv0487Mc804V
	CY07AIYIkI8VC2zVCFFI0UMc02F40EFcxC0VAKzVAqx4xG6I80ewAv7VC0I7IYx2IY67AK
	xVWUXVWUAwAv7VC2z280aVAFwI0_Gr0_Cr1lOx8S6xCaFVCjc4AY6r1j6r4UM4x0Y48Icx
	kI7VAKI48JM4x0Y48IcxkI7VAKI48G6xCjnVAKz4kxMxAIw28IcxkI7VAKI48JMxC20s02
	6xCaFVCjc4AY6r1j6r4UMI8I3I0E5I8CrVAFwI0_Jr0_Jr4lx2IqxVCjr7xvwVAFwI0_Jr
	I_JrWlx4CE17CEb7AF67AKxVWUAVWUtwCIc40Y0x0EwIxGrwCI42IY6xIIjxv20xvE14v2
	6r1j6r1xMIIF0xvE2Ix0cI8IcVCY1x0267AKxVW8JVWxJwCI42IY6xAIw20EY4v20xvaj4
	0_Jr0_JF4lIxAIcVC2z280aVAFwI0_Gr0_Cr1lIxAIcVC2z280aVCY1x0267AKxVW8JVW8
	JrUvcSsGvfC2KfnxnUUI43ZEXa7IU8dgA7UUUUU==

The detect work is re-armed by the threaded IRQ handler but nothing drains
it on detach: devm frees the IRQ before kfree(data) without flushing the
workqueue, so a pending work item can run after data is freed, leading to a
use-after-free.

Use devm_work_autocancel() so devm LIFO order frees the IRQ before the work
is cancelled. Register it after the regulator, extcon and power_supply
the work callback dereferences, so those are not freed before the cancel
either.

This issue was found by an in-house static analysis tool.
Compile-tested only; runtime testing is appreciated.

Fixes: 9e1897cb9568 ("extcon: Add LC824206XA microUSB switch driver")
Cc: stable@vger.kernel.org
Assisted-by: Codex:gpt-5.6
Signed-off-by: Fan Wu <fanwu01@zju.edu.cn>
---
 drivers/extcon/extcon-lc824206xa.c | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/drivers/extcon/extcon-lc824206xa.c b/drivers/extcon/extcon-lc824206xa.c
index 56938748aea8..adcea69ac221 100644
--- a/drivers/extcon/extcon-lc824206xa.c
+++ b/drivers/extcon/extcon-lc824206xa.c
@@ -19,6 +19,7 @@
 #include <linux/bits.h>
 #include <linux/delay.h>
 #include <linux/device.h>
+#include <linux/devm-helpers.h>
 #include <linux/extcon-provider.h>
 #include <linux/i2c.h>
 #include <linux/interrupt.h>
@@ -424,7 +425,6 @@ static int lc824206xa_probe(struct i2c_client *client)
 		return -ENOMEM;
 
 	data->client = client;
-	INIT_WORK(&data->work, lc824206xa_work);
 	data->cable = EXTCON_NONE;
 	data->previous_cable = EXTCON_NONE;
 	data->usb_type = POWER_SUPPLY_USB_TYPE_UNKNOWN;
@@ -463,6 +463,11 @@ static int lc824206xa_probe(struct i2c_client *client)
 	if (IS_ERR(data->psy))
 		return dev_err_probe(dev, PTR_ERR(data->psy), "registering power supply\n");
 
+	/* After all resources lc824206xa_work() derefs; before the IRQ producer. */
+	ret = devm_work_autocancel(dev, &data->work, lc824206xa_work);
+	if (ret)
+		return ret;
+
 	ret = devm_request_threaded_irq(dev, client->irq, NULL, lc824206xa_irq,
 					IRQF_TRIGGER_LOW | IRQF_ONESHOT,
 					KBUILD_MODNAME, data);
-- 
2.39.5

