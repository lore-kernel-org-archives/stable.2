Received: from azure-sdnproxy.icoremail.net (azure-sdnproxy.icoremail.net [13.75.44.102])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9B96D1A0BF3;
	Wed, 22 Jul 2026 02:46:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.75.44.102
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784688395; cv=none; b=qMiQZrV9z3NqqYAxFSyRyky/gsZUVG3gJYjm6W4tOEC0wz0rsRsKWJnab30/S7pvVaED0eXKnK4+hMAbLE0tjGK+hKWaUpqSU2YbQ0cwuIbQpgItagZg4ZxKw802Tjqsr3Sibq/IYySLDPpEgGdnjMFgUFSvOvABaEqlpC/n7wY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784688395; c=relaxed/simple;
	bh=eBEUljZFnGOPLmLa9T+x4M86hM6V7BbUGXRiv914x7s=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=W7osJm+X3QZiLOaX4QHQpzAgzuHtuzBV0iKV9DkgLtr3CLOFxuEyElMuSfrbrXxo+PHUcRPZ4qRTzpYlmsL/Rd9w/1F94rJDEFIEocN/efiJUE5Jcg4SQ9mWRmUCDG7KHi844S0lO8CPMH5c7GP0dq+jPSwytBEs1Ojjc0gRfr4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=zju.edu.cn; spf=pass smtp.mailfrom=zju.edu.cn; arc=none smtp.client-ip=13.75.44.102
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=zju.edu.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=zju.edu.cn
Received: from zju.edu.cn (unknown [10.98.66.117])
	by mtasvr (Coremail) with SMTP id _____wDHhDz1LmBq6ksnAA--.17690S3;
	Wed, 22 Jul 2026 10:46:14 +0800 (CST)
Received: from localhost.localdomain (unknown [10.98.66.117])
	by mail-app4 (Coremail) with SMTP id zi_KCgDH+TD1LmBqyNh+Ag--.10622S2;
	Wed, 22 Jul 2026 10:46:13 +0800 (CST)
From: Fan Wu <fanwu01@zju.edu.cn>
To: linux-input@vger.kernel.org
Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>,
	linux-kernel@vger.kernel.org,
	Fan Wu <fanwu01@zju.edu.cn>,
	stable@vger.kernel.org
Subject: [PATCH] Input: wm831x-ts - drain pen-down work at teardown
Date: Wed, 22 Jul 2026 02:45:18 +0000
Message-Id: <20260722024518.3253280-1-fanwu01@zju.edu.cn>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:zi_KCgDH+TD1LmBqyNh+Ag--.10622S2
X-CM-SenderInfo: qrstjiaswqq6lmxovvfxof0/
X-CM-DELIVERINFO: =?B?DVpB6AXKKxbFmtjJiESix3B1w3vZ3A9ovKVTomAyoQazvoRs/NHSP8GI2EvgeEEW7R
	sfnXz+g1OQfMo27QHy5TwQyZxGfK7p3xnbq4j7hoN9YHI9aJxm5aub9ZEJ1ANCZa3MDPMY
	Rv0J13PrswES+NYY2ogv2+Wb6KUKDY/xT0BrLixK
X-Coremail-Antispam: 1Uk129KBj93XoW7CF45Cw18KryxWF4rKry3GFX_yoW8uFWkpa
	s8AryUK348JF1Fka1UG3sFvFyrAF1Ut397Ar1DCw1fWwn8ZF1ftr1F9Fyvqa1rGr4kJr12
	yr9F9rWrCrZ5A3gCm3ZEXasCq-sJn29KB7ZKAUJUUUUU529EdanIXcx71UUUUU7KY7ZEXa
	sCq-sGcSsGvfJ3Ic02F40EFcxC0VAKzVAqx4xG6I80ebIjqfuFe4nvWSU5nxnvy29KBjDU
	0xBIdaVrnRJUUU9lb4IE77IF4wAFF20E14v26r1j6r4UM7CY07I20VC2zVCF04k26cxKx2
	IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48v
	e4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_tr0E3s1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI
	0_Gr1j6F4UJwA2z4x0Y4vEx4A2jsIE14v26rxl6s0DM28EF7xvwVC2z280aVCY1x0267AK
	xVW0oVCq3wAac4AC62xK8xCEY4vEwIxC4wAS0I0E0xvYzxvE52x082IY62kv0487Mc804V
	CY07AIYIkI8VC2zVCFFI0UMc02F40EFcxC0VAKzVAqx4xG6I80ewAv7VC0I7IYx2IY67AK
	xVWUJVWUGwAv7VC2z280aVAFwI0_Jr0_Gr1lOx8S6xCaFVCjc4AY6r1j6r4UM4x0Y48Icx
	kI7VAKI48JM4x0Y48IcxkI7VAKI48G6xCjnVAKz4kxMxAIw28IcxkI7VAKI48JMxC20s02
	6xCaFVCjc4AY6r1j6r4UMI8I3I0E5I8CrVAFwI0_Jr0_Jr4lx2IqxVCjr7xvwVAFwI0_Jr
	I_JrWlx4CE17CEb7AF67AKxVWUAVWUtwCIc40Y0x0EwIxGrwCI42IY6xIIjxv20xvE14v2
	6r1j6r1xMIIF0xvE2Ix0cI8IcVCY1x0267AKxVWUJVW8JwCI42IY6xAIw20EY4v20xvaj4
	0_Jr0_JF4lIxAIcVC2z280aVAFwI0_Jr0_Gr1lIxAIcVC2z280aVCY1x0267AKxVWUJVW8
	JbIYCTnIWIevJa73UjIFyTuYvjxU2LIDUUUUU

The pen-down and data IRQ handlers queue pd_data_work to switch between the
two IRQs.  The worker obtains wm831x_ts with container_of() and calls
enable_irq().  free_irq() synchronizes an IRQ handler, but does not drain a
work item already queued by that handler.

wm831x_ts_remove() can therefore free the IRQ actions while pd_data_work is
pending or running.  The work may then dereference wm831x_ts after devres
frees it, or enable an IRQ after its action has been freed.

Disable both IRQs before cancelling the work, so neither handler can queue
another instance while cancel_work_sync() drains it.  Free the IRQ actions
only after the work has stopped.  Apply the same sequence to err_pd_irq:
both IRQ actions exist there when input_register_device() fails.

This issue was found by an in-house static analysis tool and confirmed by
manual code review.

Fixes: f5346668150c ("Input: wm831x-ts - fix races with IRQ management")
Cc: stable@vger.kernel.org
Assisted-by: Codex:gpt-5.6
Signed-off-by: Fan Wu <fanwu01@zju.edu.cn>
---
 drivers/input/touchscreen/wm831x-ts.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/drivers/input/touchscreen/wm831x-ts.c b/drivers/input/touchscreen/wm831x-ts.c
index 98f8ec408cad..705772025648 100644
--- a/drivers/input/touchscreen/wm831x-ts.c
+++ b/drivers/input/touchscreen/wm831x-ts.c
@@ -366,6 +366,10 @@ static int wm831x_ts_probe(struct platform_device *pdev)
 	return 0;
 
 err_pd_irq:
+	disable_irq(wm831x_ts->pd_irq);
+	disable_irq(wm831x_ts->data_irq);
+	cancel_work_sync(&wm831x_ts->pd_data_work);
+
 	free_irq(wm831x_ts->pd_irq, wm831x_ts);
 err_data_irq:
 	free_irq(wm831x_ts->data_irq, wm831x_ts);
@@ -378,6 +382,10 @@ static void wm831x_ts_remove(struct platform_device *pdev)
 {
 	struct wm831x_ts *wm831x_ts = platform_get_drvdata(pdev);
 
+	disable_irq(wm831x_ts->pd_irq);
+	disable_irq(wm831x_ts->data_irq);
+	cancel_work_sync(&wm831x_ts->pd_data_work);
+
 	free_irq(wm831x_ts->pd_irq, wm831x_ts);
 	free_irq(wm831x_ts->data_irq, wm831x_ts);
 }
-- 
2.34.1

