Received: from azure-sdnproxy.icoremail.net (azure-sdnproxy.icoremail.net [52.237.72.81])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 799513E832B;
	Wed, 22 Jul 2026 04:59:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=52.237.72.81
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784696400; cv=none; b=EZcP+M4bpKqgFGFSddU9OU6YpLEGsGsnmfclFie0SmUwpMSbm/uVRXVAgPKjTU3CEG27LTt7q6VzRnivpoY2Q5UU04EPgnJvM9yQvgYOfjftIJGtkYIA5G34atOWwAzwsCbldphBIAlKInsfpdkc/TpKJloHydz/4cq/Xh8B3KY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784696400; c=relaxed/simple;
	bh=ln6+Lhz5HTnAAXUCrPVSupjGC5P309qXb9msf3kuvfE=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=rgISQo2nFohVkjDBWSGP3Hrm9SP0bRuagY2Jle13qpJ3qn75kzht2Z/Sboy3Z1Ig8PDg4jqEKeRAHIzkan3hlLBzQZWra/gFDTyU8wfCZtEd0GCKZ+H/Ey7pv4pBvLiH0eNgv6qbEoiGK7WegbSiri9fX4MsjJynWf1l+HF7kjY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=zju.edu.cn; spf=pass smtp.mailfrom=zju.edu.cn; arc=none smtp.client-ip=52.237.72.81
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=zju.edu.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=zju.edu.cn
Received: from zju.edu.cn (unknown [10.98.66.117])
	by mtasvr (Coremail) with SMTP id _____wDXlDxETmBqt3YoAA--.13764S3;
	Wed, 22 Jul 2026 12:59:49 +0800 (CST)
Received: from localhost.localdomain (unknown [10.98.66.117])
	by mail-app1 (Coremail) with SMTP id yy_KCgCXUppETmBq0JcPAw--.31528S2;
	Wed, 22 Jul 2026 12:59:48 +0800 (CST)
From: Fan Wu <fanwu01@zju.edu.cn>
To: linux-input@vger.kernel.org
Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>,
	linux-kernel@vger.kernel.org,
	Fan Wu <fanwu01@zju.edu.cn>,
	stable@vger.kernel.org
Subject: [PATCH v2] Input: wm831x-ts - drain pen-down work at teardown
Date: Wed, 22 Jul 2026 04:58:53 +0000
Message-Id: <20260722045853.3255262-1-fanwu01@zju.edu.cn>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260722024518.3253280-1-fanwu01@zju.edu.cn>
References: <20260722024518.3253280-1-fanwu01@zju.edu.cn>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:yy_KCgCXUppETmBq0JcPAw--.31528S2
X-CM-SenderInfo: qrstjiaswqq6lmxovvfxof0/
X-CM-DELIVERINFO: =?B?p1bGmwXKKxbFmtjJiESix3B1w3vZ3A9ovKVTomAyoQazvoRs/NHSP8GI2EvgeEEW7R
	sfnVCjTgEH9dVomQuWcozCBBHnl4onf/PFp4juhU4xhfLyq4wOAq9Qh6kxiWx++GHWsc0Y
	P87phS+Z+MVDVMkdpkOp9E6mavGmQbzmcFsnzP86
X-Coremail-Antispam: 1Uk129KBj93XoWxCF4UJw1xAF4kKFWkAFW7KFX_yoW5Zry5pa
	y5AryUK34ktF48ur48W34vvFyrGF4xJ393Ar1DK34fWw15ur1ftr95ZFyvqF4rGrWkJr4j
	yr9I9w48CrZ5AagCm3ZEXasCq-sJn29KB7ZKAUJUUUUU529EdanIXcx71UUUUU7KY7ZEXa
	sCq-sGcSsGvfJ3Ic02F40EFcxC0VAKzVAqx4xG6I80ebIjqfuFe4nvWSU5nxnvy29KBjDU
	0xBIdaVrnRJUUU9Gb4IE77IF4wAFF20E14v26r1j6r4UM7CY07I20VC2zVCF04k26cxKx2
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
	0_Jr0_JF4lIxAIcVC2z280aVAFwI0_Jr0_Gr1lIxAIcVC2z280aVCY1x0267AKxVW8JVW8
	JrUvcSsGvfC2KfnxnUUI43ZEXa7IU8Tv3UUUUUU==

The pen-down and data IRQ handlers queue pd_data_work to switch between the
two IRQs.  The worker obtains wm831x_ts with container_of() and calls
enable_irq().  free_irq() synchronizes an IRQ handler, but does not drain a
work item already queued by that handler.

wm831x_ts_remove() can therefore free the IRQ actions while pd_data_work is
pending or running.  The work may then dereference wm831x_ts after devres
frees it (use-after-free), or re-enable an IRQ whose action has been freed.

The input device is devm-allocated, so the input core unregisters it after
wm831x_ts_remove() returns.  If a userspace handle is still open, that
unregister drives the input close callback, which on pen-down calls
enable_irq(pd_irq) - after wm831x_ts_remove() has already freed the pd_irq
action.  Unregister the input device before freeing the IRQs, so the close
callback runs while the actions are still installed.  This must precede the
IRQ teardown: disabling and cancelling first would still let the close
callback re-enable pd_irq after its action is gone.

After unregistering, drain the work: disable both IRQs so neither handler
can queue another instance, cancel_work_sync() to make the drain final,
then free the actions.  Apply the same drain to err_pd_irq; the input
device is not registered there, so it is not unregistered.

This issue was found by an in-house static analysis tool and confirmed by
manual code review.

Fixes: f5346668150c ("Input: wm831x-ts - fix races with IRQ management")
Cc: stable@vger.kernel.org
Assisted-by: Codex:gpt-5.6
Signed-off-by: Fan Wu <fanwu01@zju.edu.cn>
---
Changes since v1:
- Unregister the input device before freeing the IRQs. v1 drained the
  work in wm831x_ts_remove(), but the input device is devm-managed and is
  unregistered by the input core only after remove() returns; with a
  userspace handle open, that unregister drives the close callback, which
  on pen-down calls enable_irq(pd_irq) after its action has been freed.
 drivers/input/touchscreen/wm831x-ts.c | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/drivers/input/touchscreen/wm831x-ts.c b/drivers/input/touchscreen/wm831x-ts.c
index 98f8ec408cad..a465b1b96fd8 100644
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
@@ -378,6 +382,12 @@ static void wm831x_ts_remove(struct platform_device *pdev)
 {
 	struct wm831x_ts *wm831x_ts = platform_get_drvdata(pdev);
 
+	input_unregister_device(wm831x_ts->input_dev);
+
+	disable_irq(wm831x_ts->pd_irq);
+	disable_irq(wm831x_ts->data_irq);
+	cancel_work_sync(&wm831x_ts->pd_data_work);
+
 	free_irq(wm831x_ts->pd_irq, wm831x_ts);
 	free_irq(wm831x_ts->data_irq, wm831x_ts);
 }
-- 
2.34.1

