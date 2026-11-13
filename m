Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.180
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794551673;
	b=mLGq3ouH7rpOAm6G93lSam67/3u2MusjkeD6uEiMAZCZ4+tJ4APEYV0sLJEWYBtJQk28
	 S7f0UEybr72R+paP4QTcXZ47K6Efqbfn03bifyxGC7UFSLt+BrT5LuxOSomegSY+wnrxG
	 KWwXqdt1ax0N95Q8s7uddddAanL03GUYZFcq4AXVWKqdZ8Zkwem72lLC6P2fzjuhlvcwO
	 1/qE0l4XExbft/QlnTAMFpUXvLSPrV6jmjns/WL9pVHfh9qZqgu+yO+LURKU0XMjkBJ04
	 TvVsxTZjgswXR7gakRJcqV+zSqSqlffrThNwCIx4j0lm1hnU+27ZB6jSxoegK/rcvLQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794551673;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-Id:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding;
	bh=YofMid7RpzpBeuOJEqJTlM4NYFRjnqyXKJCv56rsYTc=;
	b=MxrvbhHVJz/1/wW6EJOskWdDVKthlXUmpwLMYV9s0+HiyfcFbfBnHamP2CaK3tutyJEq
	 R/dcc/egcH8aJg7TpWJk9R4YPbb6UchKtB5cj2cqabyd8vgBo5DbA0lIVr8BoCpPvaa6S
	 iWSaXJ6vouX84DCwuU7FVQzAAfLWRx+HtUPAdjVlKWwgF+iYMuzFpoPbANQxNODUh6KZN
	 K+WOxjObAJ9v+SeGWQ7+qgynaQAQIcPZgou4e/Zpn3IJgu1zveLL3JdglY+ye5h3c3+vG
	 OGvKqgRQpUPbzvNfO6FUx0Naas97OIyVPJvqMlxuBwaH/cxCyEmWFISbfzHSHAl1XhQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=EqRBi2bH;
	arc=none smtp.remote-ip=74.125.82.180
Received: from mail-dy1-f180.google.com (mail-dy1-f180.google.com [74.125.82.180])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8220F606A327
	for <stable@vger.kernel.org>; Fri, 13 Nov 2026 06:34:33 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 8220F606A327
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=EqRBi2bH
Received: by mail-dy1-f180.google.com with SMTP id 5a478bee46e88-35159e0092aso72864eec.2
        for <stable@vger.kernel.org>; Thu, 12 Nov 2026 22:34:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794551673; x=1795156473; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=YofMid7RpzpBeuOJEqJTlM4NYFRjnqyXKJCv56rsYTc=;
        b=EqRBi2bHbscU7Sn1G8o5z/iPY/BRg6yYR3WwKQ2FCgy0LUd85YrE1JZbxjmrsAAclI
         OYw9FBCaGCg5jTuxUwmLGc0gm+8XEFHEZOxtTrQ0/cJq+WS36HKewvRUdPy8CGOsXhrN
         1nKMoDOxAd7Ahc9SMBHLMP5Q9rWEoKKIDhnulBxXc8ADBaK76a7gRt2IHBTyiI86+cGd
         4j8DKaSqiwYBVaaoKVTUPg1ETEJeWCe3inTqp7YZhDp9qZNUezx/rCFyzDlB3aP0o6vS
         dWxtC9qbF7oXPCwmSdMcMwItrlGcQvAW7i0JvEaG2Z/eKad7KyzcMNj+eNhdRRWtyZzC
         9nwQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794551673; x=1795156473;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=YofMid7RpzpBeuOJEqJTlM4NYFRjnqyXKJCv56rsYTc=;
        b=wZwyRp1OnX6ZYMLLH6S1+kkUllH4f/rxLUgHvFLDh9bnMPQrnVG+8ArGpQ67caxNb6
         nJWv1vQbt9xb+8ftdAJjicdyfBqbEla+Uuzhg/fz5Z6SoQxs5ad0BnzwW+wYJYEeCk2Q
         6vYXMGlemLDd5obj4LVhEWiiYfp/nRVyeqIKpqxtIWkUyjbAs57iBnOmFJTlwjQThEGE
         52ETj9dp8h5u07stkMMb9lTAljqPh9hR1MQay+FvOpTgEKFobpUANhqMppMQ/h6CYh3N
         MyohMFnmiEGZCfaHC+CSajhN5IOF3RGKT3dPjsHO4IrIjMBSfMUP+K7G1zgZ4qWriHSm
         GsnA==
X-Forwarded-Encrypted: i=1; AL+hErGiTvICRxwhdil/Y4ei1EWTZjVUcs8lqPbfX0sHJ1xWbP+xi/4zl/6KTRP8CNZb4mRNXZmi7D8=@vger.kernel.org
X-Gm-Message-State: APuU4Z8FclFQlgDFujXl8GGJSSnYq16OUUwJQ+zOk+ciwrXKjOlj+3h1
	rHLbpOCeOt0cSG3tjB/mKvpEI/ShOB4nRIcVHzTqrdbt4lGM3wnz2oYW
X-Gm-Gg: AYBFou3bA0dKuD06w9opkuBNYrWFvA9Pgd7txmQfEt/rIna/9mLek5dPNBW1Zkhy92i
	zke5K20jK+mJVaAYYci7ptzc32PcwgHLJwI4RlH1KBUzbqBKvF15rtFbLfMvtcuHKu2a9TF+L7I
	Jp9UMytc1qJdKKhxhTmXi+yjkPiDKLQMPtkqmikJZ6XrR33TvB8iWrfVSy/G/DFWAOslGyEZ3Gr
	L//WnZ7/Y/QlygsSwWnd4747AJKmkc+4SIAi9WdFV8t7Ggj7NEWjcsYK0uQFg7mUBRcCF/ffx63
	1fDoaVzCr5MIbx9q4mWXCU7O+/8FO5dq+XCFOMETe/QTllDp+/N6GwVj29p8nMaJcrAQwTzrmi5
	yOAKzFzG9Nw8ukBMkTk0AWtBPQ+cBgWOjMsYAlAHOG+4Ewg4w7cxltQ1DWq0thx/0iwwxCuaujt
	oesKAd/YtZZmk1gaRjGYgLqe9xfR8Ie8GYzh4bsAC5hwZPXjtuP7sjNF6ua4piMh6/dG7Y6xOvE
	BbaqFMvsiIYiDnjEdZECW67KqklJ119gPTemZUFsYaq81E8YkQ1ogLDnKsQEgTr7GIeBjFRMAHz
	Ku6sQ6koTnNZpNC4DlYmst/pqRzi4FD1VfKco4fDhg==
X-Received: by 2002:a05:693c:83cf:20b0:376:6ba5:6090 with SMTP id 5a478bee46e88-37964e03109mr2624201eec.1.1794551672482;
        Thu, 12 Nov 2026 22:34:32 -0800 (PST)
Received: from CRASHEDROM.localdomain ([142.249.36.161])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-379569b8389sm6745027eec.25.2026.11.12.22.34.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 12 Nov 2026 22:34:32 -0800 (PST)
From: Chengyu Liu <lui2012qwq@gmail.com>
To: linux-usb@vger.kernel.org
Cc: b-liu@ti.com,
	gregkh@linuxfoundation.org,
	nkapron@google.com,
	tony@atomide.com,
	bigeasy@linutronix.de,
	balbi@ti.com,
	shimoda.yoshihiro@renesas.com,
	robert.jarzmik@free.fr,
	Chengyu Liu <lui2012qwq@gmail.com>,
	stable@vger.kernel.org
Subject: [PATCH v2 1/4] usb: musb: cancel the delayed works after quiescing the interrupt
Date: Fri, 13 Nov 2026 14:34:06 +0800
Message-Id: <20261113063409.47485-2-lui2012qwq@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20261113063409.47485-1-lui2012qwq@gmail.com>
References: <20261113063409.47485-1-lui2012qwq@gmail.com>
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

musb_remove() cancels finish_resume_work and deassert_reset_work up
front, while the interrupt is still enabled and the root hub is still
registered, and cancels irq_work only later.  All three works can be
armed past their cancel:

- musb_handle_intr_resume() schedules finish_resume_work from
  interrupt context (RESUME in OTG_STATE_A_SUSPEND, via
  musb_stage0_irq());
- musb_hub_control() schedules finish_resume_work (ClearPortFeature
  SUSPEND -> musb_port_suspend()) and deassert_reset_work
  (SetPortFeature RESET -> musb_port_reset()) from process context,
  and the root hub is only torn down by musb_host_cleanup();
- musb_stage0_irq() schedules irq_work, which can also re-arm itself
  from the session recheck path (musb_pm_runtime_check_session()).

A work armed after its cancel runs musb_host_finish_resume(),
musb_deassert_reset() or musb_irq_work() after musb_free() has
released the struct.

Tear down the host and gadget sides first so no process-context
producer remains, mask the interrupts and synchronize the IRQ line so
no interrupt handler can be running, and only then cancel all three
works.  This also restores the pre-f730f205cc51 ordering, which had
the cancels behind the interrupt masking.

Found by static analysis.

Suggested-by: Neill Kapron <nkapron@google.com>
Fixes: f730f205cc51 ("usb: musb: Split PM runtime between wrapper IP and musb core")
Cc: stable@vger.kernel.org
Signed-off-by: Chengyu Liu <lui2012qwq@gmail.com>
---
v1 -> v2:
- also move the finish_resume_work and deassert_reset_work cancels
  behind the interrupt quiesce, per Neill Kapron's review:
  finish_resume_work is armed from interrupt context as well
  (musb_handle_intr_resume()), and both it and deassert_reset_work
  can additionally be re-armed via musb_hub_control() until
  musb_host_cleanup() tears the host down.
- correct the Fixes tag to f730f205cc51 (the 2016 PM-runtime split
  moved the cancels ahead of the interrupt masking)
v1: https://lore.kernel.org/linux-usb/20261112160448.41566-2-lui2012qwq@gmail.com/

Build-tested on x86_64: musb_core.o compiles clean
(USB_MUSB_HDRC).  No runtime reproducer: requires MUSB-based OTG
hardware.  Fix written with AI assistance.

 drivers/usb/musb/musb_core.c | 15 ++++++++++++---
 1 file changed, 12 insertions(+), 3 deletions(-)

diff --git a/drivers/usb/musb/musb_core.c b/drivers/usb/musb/musb_core.c
index 9b63b56edc45..25115217e0af 100644
--- a/drivers/usb/musb/musb_core.c
+++ b/drivers/usb/musb/musb_core.c
@@ -2630,9 +2630,6 @@ static void musb_remove(struct platform_device *pdev)
 	 */
 	musb_exit_debugfs(musb);
 
-	cancel_delayed_work_sync(&musb->irq_work);
-	cancel_delayed_work_sync(&musb->finish_resume_work);
-	cancel_delayed_work_sync(&musb->deassert_reset_work);
 	pm_runtime_get_sync(musb->controller);
 	musb_host_cleanup(musb);
 	musb_gadget_cleanup(musb);
@@ -2642,6 +2639,18 @@ static void musb_remove(struct platform_device *pdev)
 	musb_disable_interrupts(musb);
 	musb_writeb(musb->mregs, MUSB_DEVCTL, 0);
 	spin_unlock_irqrestore(&musb->lock, flags);
+
+	/*
+	 * musb_stage0_irq() arms irq_work (and finish_resume_work on
+	 * remote wakeup) from interrupt context, so the works can only be
+	 * cancelled for good once interrupts are masked and any in-flight
+	 * handler has completed.
+	 */
+	synchronize_irq(musb->nIrq);
+	cancel_delayed_work_sync(&musb->irq_work);
+	cancel_delayed_work_sync(&musb->finish_resume_work);
+	cancel_delayed_work_sync(&musb->deassert_reset_work);
+
 	musb_platform_exit(musb);
 
 	pm_runtime_dont_use_autosuspend(musb->controller);
-- 
2.25.1

