Received: from azure-sdnproxy.icoremail.net (azure-sdnproxy.icoremail.net [13.75.44.102])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 39385374E74;
	Wed,  9 Sep 2026 09:58:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.75.44.102
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788947892; cv=none; b=oS2mMkhII9cs5b3kIHF0PDPKYfNUNmgcTPPS49EO6JxLNX3pSa6ip/dvRy/4ZYb3G1tV+D8gDsXAYnTmzhzW+AHph5xtbzyEFY7vwmmebLD7XLirEJ8ggPLYh5giagVlhzQBRpXA0N48CyAXeWjB++s2Hl6raVTrVA6f9PV5OqE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788947892; c=relaxed/simple;
	bh=Nj3EVXKwlfNLDYegToFfkspo4D9W2IFkM1BJ90/B/9U=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=G5+sSfPCkIZxU3Vl55DGUhZ/dXAIb3TYNvPDMMp7RbIlGJU1IvIJOGqWl0pdQ0liCVTzF23BlSaBfNzFhfmr5qAOH4kO55MRUL+US0dAqgEQ7ej6KDvKbazGwhs5+AUBKZYlW4lwEZ7HafSCuyfTi7evCCl537DxG//AC2vXQK8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=zju.edu.cn; spf=pass smtp.mailfrom=zju.edu.cn; arc=none smtp.client-ip=13.75.44.102
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=zju.edu.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=zju.edu.cn
Received: from zju.edu.cn (unknown [10.98.66.117])
	by mtasvr (Coremail) with SMTP id _____wCXkAujLaFq49ECAQ--.1695S3;
	Wed, 09 Sep 2026 17:57:56 +0800 (CST)
Received: from localhost.localdomain (unknown [10.98.66.117])
	by mail-app3 (Coremail) with SMTP id zS_KCgD3DnGhLaFqkkoKBQ--.60073S2;
	Wed, 09 Sep 2026 17:57:53 +0800 (CST)
From: Fan Wu <fanwu01@zju.edu.cn>
To: linux-usb@vger.kernel.org
Cc: Peter Chen <peter.chen@kernel.org>,
	Pawel Laszczak <pawell@cadence.com>,
	Roger Quadros <rogerq@kernel.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org,
	Song Li <songl@zju.edu.cn>,
	Sicong Huang <congei42@163.com>,
	Fan Wu <fanwu01@zju.edu.cn>
Subject: [PATCH] usb: cdns3: fix use-after-free in cdns3_gadget_exit()
Date: Wed,  9 Sep 2026 09:56:55 +0000
Message-Id: <20260909095655.694527-1-fanwu01@zju.edu.cn>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:zS_KCgD3DnGhLaFqkkoKBQ--.60073S2
X-CM-SenderInfo: qrstjiaswqq6lmxovvfxof0/
X-CM-DELIVERINFO: =?B?gMQ6AAXKKxbFmtjJiESix3B1w3vZ3A9ovKVTomAyoQazvoRs/NHSP8GI2EvgeEEW7R
	sfnZPoDCNGYdHSfuFmYJL54WOJf1TmBfj9V/FX62qiNmpj7C/rZCZO5Px88A8M3Vc63aFF
	qyiUrJk52N752BmG4h6p9E6mavGmQbzmcFsnzP86
X-Coremail-Antispam: 1Uk129KBj93XoW7uFWUtF4DWw4UKFy7JF1rXwc_yoW8ZFyrpa
	95KFW5AFWkJrZ8t3WqywsrurW5Ww4Yya42krZ2y39xZFsxAF15KryakrWjgF4UAFykuF4j
	yrn8W3Wv9F4YyFgCm3ZEXasCq-sJn29KB7ZKAUJUUUUU529EdanIXcx71UUUUU7KY7ZEXa
	sCq-sGcSsGvfJ3Ic02F40EFcxC0VAKzVAqx4xG6I80ebIjqfuFe4nvWSU5nxnvy29KBjDU
	0xBIdaVrnRJUUU9Gb4IE77IF4wAFF20E14v26r4j6ryUM7CY07I20VC2zVCF04k26cxKx2
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
	0_Jr0_JF4lIxAIcVC2z280aVAFwI0_Gr0_Cr1lIxAIcVC2z280aVCY1x0267AKxVW8JVW8
	JrUvcSsGvfC2KfnxnUUI43ZEXa7IU86c_DUUUUU==

cdns3_gadget_start() arms two works on system_freezable_wq:
pending_status_wq for the deferred ep0 status stage and aligned_buf_wq
for realigned request buffers. Both handlers use the cdns3_device the
works are embedded in, and cdns3_pending_setup_status_handler() also
calls the ep0 request completion.

cdns3_gadget_exit() does not wait for these works. It frees all
endpoints and aligned buffers and drops the last reference to the
gadget device, which frees priv_dev, so a work queued before the exit
can run after the free.

Fix this by waiting for both works after the gadget driver is unbound
and the IRQ is freed, when no new work can be queued, and before the
endpoints and buffers are released.

This issue was found by an in-house static analysis tool.

Fixes: 7733f6c32e36 ("usb: cdns3: Add Cadence USB3 DRD Driver")
Cc: stable@vger.kernel.org
Reported-by: Sicong Huang <congei42@163.com>
Closes: https://lore.kernel.org/linux-usb/7f5719b.8700.18f67b324d3.Coremail.congei42@163.com/
Suggested-by: Sicong Huang <congei42@163.com>
Assisted-by: Codex:gpt-5.6
Co-developed-by: Song Li <songl@zju.edu.cn>
Signed-off-by: Song Li <songl@zju.edu.cn>
Signed-off-by: Fan Wu <fanwu01@zju.edu.cn>
---
 drivers/usb/cdns3/cdns3-gadget.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/usb/cdns3/cdns3-gadget.c b/drivers/usb/cdns3/cdns3-gadget.c
index 42311c1bf..0d272e9c5 100644
--- a/drivers/usb/cdns3/cdns3-gadget.c
+++ b/drivers/usb/cdns3/cdns3-gadget.c
@@ -3269,6 +3269,10 @@ static void cdns3_gadget_exit(struct cdns *cdns)
 	usb_del_gadget(&priv_dev->gadget);
 	devm_free_irq(cdns->dev, cdns->dev_irq, priv_dev);
 
+	/* The works can still be queued until the IRQ is freed. */
+	cancel_work_sync(&priv_dev->pending_status_wq);
+	cancel_work_sync(&priv_dev->aligned_buf_wq);
+
 	cdns3_free_all_eps(priv_dev);
 
 	while (!list_empty(&priv_dev->aligned_buf_list)) {

