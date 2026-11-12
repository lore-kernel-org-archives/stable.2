Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.175
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794499507;
	b=MPUoyuiiR0Qz8CCK3Cwy+15pYBCDy9bR1gkMgw9+aVWLZbIR2UNDE9qtav+QS0qPez7Z
	 UzqLzSvAR6FrGUcik7a4mFEBkr1xZaeFwuUj++hD/AExHC1ETsohlhLkoMkLQ1iPAG9A+
	 fyiCYxVmywD6eO5RKzngUYiZHFoDfVcpFwFdn9MzoWhgYxLCjkREXSj1vSAZtDmAGnatH
	 Hfvjs4hzVCM5EsxBVcl8MxoHGRBN/1/yHnqNdWLuT1nYpbj+JVP/afJfvX/MctG5nKdKg
	 03iE8d2tqfrgqnUykbjMaSSqaeQbjIwFPTN5i7KDS5gFK6G1KR5KBv9nSX6j2oNdNag==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794499507;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-Id:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding;
	bh=c5fUWHXnz9/d2cpHdb7ew9JGxO2bNNQHDUJStnqKQgQ=;
	b=h4dqu3a5W+qn+4J0bktvypbLtpsvhCwNwUhJi46C/saV+0kwEZebdf7SyPUFBqeWC6t9
	 O4OMFn4OAh1k9OaAH5oKDrw4jBqOXhi7zZ2NEQ2vHAnEvGcDz8QswXIHsnxXiwQBSOQss
	 VN9wGP26K2Vhs2n42+MllTVghnfzcMIllUm42MYAgnFAioN6RrFY+4YxsQB5+sY98wmhY
	 2yPyd5R1eRodqD5jahFTM0FfkQhQMNa/I2Vlzh+ghXDWhZmotjTXojfl0lqn2N6S2EIyx
	 eX7algP4dl2PMpkmeyEMHq0s9ZKkOcX/VOw+/DBUb6yR5+iqkF2YFIyDdxEyPXKCyeQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=RgxezAXx;
	arc=none smtp.remote-ip=74.125.82.175
Received: from mail-dy1-f175.google.com (mail-dy1-f175.google.com [74.125.82.175])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 01B77606A338
	for <stable@vger.kernel.org>; Thu, 12 Nov 2026 16:05:06 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 01B77606A338
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=RgxezAXx
Received: by mail-dy1-f175.google.com with SMTP id 5a478bee46e88-370f4e5cfc9so3955eec.0
        for <stable@vger.kernel.org>; Thu, 12 Nov 2026 08:05:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794499506; x=1795104306; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=c5fUWHXnz9/d2cpHdb7ew9JGxO2bNNQHDUJStnqKQgQ=;
        b=RgxezAXxzugSUgmEKKuaXhj1uqmjMeLkQpSgnb9KDNlzU+jE3UU+hP4THbr/bFvPeI
         k1y0wSZv2YIJQvL/+WX2WxbhPzT/lRSMOfJ8ZU7xcWwGZdeSb0qweWJwn15y+2jBI81D
         yyw2gR1RWk5tHj0CD/SzEFEnE8vz6dbZqQaQXjBekG87IlvhTqfeAajkeQxo3MyuzReL
         b+dGFdPsfwiIMt0ngyGZBcqHuvU7RE8ob/0SqAxPf/V6JU14kx2Kve+ZchnBNeh2VBC2
         +skZga7FN956o3knCntxYOZ6uWICgDn5hzgOwwk0uG3v9PKaWwsNolHiho5F1R9OYNca
         mXFA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794499506; x=1795104306;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=c5fUWHXnz9/d2cpHdb7ew9JGxO2bNNQHDUJStnqKQgQ=;
        b=xZWvsV/38Pqu/nYuCGPGY7VxqFiL0D8DB0pcTGJHSFq3E4OxLflkpBla+kXNs74bT0
         0uDcNzF4GeMQTY2qbCDHzXLC3QwcOHphbrsNmSM5rLKWGJmzg8a9qJZjD4eOh5MSPaBt
         JDovbD7KjN1IYS3uT5x6bY2siIZNp7sUWBLl2Y0t9+kQ1FbNyWlKMt8B447ckiE2fnbx
         Ys6+5z5n4inR5SLYMlCLQIIwnKR2enXzB9/Rc23fJQKT+hkOBZW5enkjXWmNEbelhpWS
         DEU3I2DW1wpUIQiExCfy3mVg9laYSiTIKGf7r5jWJRv5H+etkOhwFehHXHnUEdVsbi++
         FRqw==
X-Forwarded-Encrypted: i=1; AL+hErGWb2orS0sqpaHNplK1UCfP92WWWaLWJxil+37eGQ1MtPr1aVofRawX5sQlJSP8qalUeQoOGyc=@vger.kernel.org
X-Gm-Message-State: APuU4Z+WEhJht3wlXQImrrLJ1IYqTxkWkJZ156Wbrnn9l9rUQZaJr0Jd
	xlLH76eqT+GzenyhuNUllDD9ysM2X/GAX3N8gBGdkI2aLXUq6/vb+kJO
X-Gm-Gg: AYBFou2QvDFLH2cQ0KW4whHFc9GCsHNZS1vQ7yDjTbQWRzmU8dTYOJVBHU6VJ2/5g04
	l7WSp3GqZ/Cipk9texHEAH0x4RNk8ZlTmesP1C+iehkyFFL1n4PyIJARxZCEw7U41rrlG0Ckjpq
	RbP3qrhjX7ui8Q0pj4yYMuXj+RAwW6BbGfaTS5guoKAOeTCAWgsdLnHr3X2cH/rmqvfWP7Bvvm0
	mvOCoN8Jmm3aYt9JE60tGNlkGgiBoo0T8W7YdNdEaSpJwotgsHlGdQFScWM1ozMtFqD8yKOjtom
	oYnYhCjfzam1a4hDnSbTjbT+uECRMzcJrTMQ24wOlb8Kr9mXN9kD2E8A64Q02jVuLJtRgbtR4lD
	RIVLwiXkYBZxSOT/6zGsedOrcLv1AeXjQphIMPWyKO6djYfdq6bGT9979U1JV4L1Hw8/B57OKq4
	H5/EUZpKpic0miwf1kZJ4ANSdwfgDYt569xAbmMF1kU36ugo2nvgSfwriOxwuq+J7ig1bwLTQ4K
	5R4btmOElR0p8bomRHQoEir2H+BLvlF8d3/cmn+SoVETILmPZLiziWFMQOBvP9Rnky+5SoKLET7
	X3vzSO7UOEHc+f4UKrm5OZL208twcIfodAxsxKfRQ10I5FMJR1f9qH/8UQ/saXU=
X-Received: by 2002:a05:693c:41cb:20b0:36e:66d8:1424 with SMTP id 5a478bee46e88-37680a60bbdmr9273913eec.0.1794499505681;
        Thu, 12 Nov 2026 08:05:05 -0800 (PST)
Received: from CRASHEDROM.localdomain ([142.249.36.161])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-37922d49049sm613673eec.1.2026.11.12.08.04.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 12 Nov 2026 08:05:04 -0800 (PST)
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
Subject: [PATCH 1/4] usb: musb: cancel irq_work after masking interrupts in musb_remove()
Date: Fri, 13 Nov 2026 00:04:45 +0800
Message-Id: <20261112160448.41566-2-lui2012qwq@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20261112160448.41566-1-lui2012qwq@gmail.com>
References: <20261112160448.41566-1-lui2012qwq@gmail.com>
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

musb_stage0_irq() can schedule irq_work while handling stage-0 USB
interrupts, and the work can also re-arm itself from the session
recheck path (musb_pm_runtime_check_session()).  musb_remove()
cancels irq_work while the interrupt is still enabled and the IRQ
line not yet freed: an interrupt landing after the cancel re-arms
the work, and musb_irq_work() then runs after musb_free() has
released the struct.

Move the cancel behind musb_disable_interrupts() and synchronize the
IRQ line first, so no handler can be running or re-arm the work past
the cancel.

Found by static analysis.

Fixes: c5340bd14336 ("usb: musb: cancel work on removal")
Cc: stable@vger.kernel.org
Signed-off-by: Chengyu Liu <lui2012qwq@gmail.com>
---
Build-tested on x86_64: musb_core.o compiles clean
(USB_MUSB_HDRC).  No runtime reproducer: requires MUSB-based OTG
hardware.  Fix written with AI assistance.

 drivers/usb/musb/musb_core.c | 10 +++++++++-
 1 file changed, 9 insertions(+), 1 deletion(-)

diff --git a/drivers/usb/musb/musb_core.c b/drivers/usb/musb/musb_core.c
index 9b63b56edc45..eea43a20a1d0 100644
--- a/drivers/usb/musb/musb_core.c
+++ b/drivers/usb/musb/musb_core.c
@@ -2630,7 +2630,6 @@ static void musb_remove(struct platform_device *pdev)
 	 */
 	musb_exit_debugfs(musb);
 
-	cancel_delayed_work_sync(&musb->irq_work);
 	cancel_delayed_work_sync(&musb->finish_resume_work);
 	cancel_delayed_work_sync(&musb->deassert_reset_work);
 	pm_runtime_get_sync(musb->controller);
@@ -2642,6 +2641,15 @@ static void musb_remove(struct platform_device *pdev)
 	musb_disable_interrupts(musb);
 	musb_writeb(musb->mregs, MUSB_DEVCTL, 0);
 	spin_unlock_irqrestore(&musb->lock, flags);
+
+	/*
+	 * musb_stage0_irq() arms irq_work, so it can only be cancelled
+	 * for good once interrupts are masked and any in-flight handler
+	 * has completed.
+	 */
+	synchronize_irq(musb->nIrq);
+	cancel_delayed_work_sync(&musb->irq_work);
+
 	musb_platform_exit(musb);
 
 	pm_runtime_dont_use_autosuspend(musb->controller);
-- 
2.25.1

