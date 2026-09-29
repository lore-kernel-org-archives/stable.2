Received: from mail-yx2-f40.google.com (mail-yx2-f40.google.com [74.125.224.168])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1EAE85293F7
	for <stable@vger.kernel.org>; Tue, 29 Sep 2026 15:04:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.224.168
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790694264; cv=none; b=mj/0Ec+7HWpnRoKjXo1DCKOAFBvsDdkEQ3V3t6oiFck3r9UnVPm4H/7Gs7Jb4NH9Ny8F7KGftSrTiuqaT7PbDSd+sHKqjCPWDmYIu+GdpkiYZPKz/wQkaBxALqs1xXIGNIf5OMc5+NGc8jU1iw/kPAngI9smoz+XsB+6h6AxoN8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790694264; c=relaxed/simple;
	bh=ctXSxhL8cB96oM2LlBR4kk7hbE12PJXfiPWlYJLZFo0=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=YrjMZBRyKvbCDIuVWThmKJKTGfYVU2ynaAW1LZhbvaUo8Ys+1jsbJcDq3Cu1ZQfzgriNzoIFU9CWNAK+KlGIEE5OyQtgk7G8AKRh3MPpE3/XEx17I3ZamI46P55KSRYmP6pxCmGWHS0TdVUayyhZIU49FnkUPDsZQKroip9speo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=dRzkyfQL; arc=none smtp.client-ip=74.125.224.168
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dRzkyfQL"
Received: by mail-yx2-f40.google.com with SMTP id 00721157ae682-8ab445ac183so8333407b3.3
        for <stable@vger.kernel.org>; Tue, 29 Sep 2026 08:04:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790694251; x=1791299051; darn=vger.kernel.org;
        h=cc:to:message-id:content-transfer-encoding:content-type
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=+edsoFX5PqL65dJFkIJ/uSxWsDbol4HH9AaqaASjRno=;
        b=dRzkyfQLetYpbbmiXtBUtOfaMMMw5wu8Yhdh21W4oOXf7aCPZPlGxbV76gD30R7HI3
         8I7X+cyR/zVXQuI18na54naOwGZDYwfKC2JZMPTH2TZ1+k/k4l8EleNhEfs0kd03+V2W
         6XFt2Bky0lGQz1WqD+C8yywbwIJESihqI3U2WbRhuqjwVdXuUzyNaB/zLkuOsyuIci3O
         m7yBd4m1EY1u+03+GsffFmqopAnuIvfvglIkFMhz0wDLKmmX3IwvBnnd/TJhmOV8UBAL
         ZnZjDE7yhRxYsg1eSZBy22avhMer3J36whLN7q83vp6tTbAvyFijiiwtv93hKFy2qj4S
         8tKA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790694251; x=1791299051;
        h=cc:to:message-id:content-transfer-encoding:content-type
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=+edsoFX5PqL65dJFkIJ/uSxWsDbol4HH9AaqaASjRno=;
        b=TYteBcJySgCsXoc/0XdCeIMlrPmdPzdB0LnkNZxwYQrymb5X3z7al41BlwML8gAFFY
         D1hJPMTXq2yRS6scvu2bxKKWLWj3AvSN7rT2tjruA8p/i1yaC82TTwhDxev9s/W4npRL
         Ap3W0hUI1xbqHvye1igIqN37EZQd+WFcs6L0r+OA9dI8q/AmUdBbHzyMLQJOHtGODa+W
         Sut5EedjanROwQXJEJ9zq58Qv8hdgnVx9jf0T2kp4oWeeC34lJ6/EtKnLhZTD3cwOUqV
         jsA7/LB6HAa4rzqH9Sj0RwwR7jDougZIq7wrHiMWUUXZfb+3MX9hcO4XNxWGU4kEfp5j
         Gh7g==
X-Forwarded-Encrypted: i=1; AKwUvBwGKzKiHlYdQyVWapI9hHDcAry8eE3fRLv/QcSKuXWLEwxXLW1MqGL5BDs8bcRxxda2zeG8b8g=@vger.kernel.org
X-Gm-Message-State: AFq9FYJe/L9XkBXXhpqc/H2v02scHJL6Oq6bcSFKU5o64AuS22p6TCEA
	7kglhjevN98K5Lopg2Re+e/aaXmm+/svlrzL2gT6JHsVd0TIqSExx0ZB
X-Gm-Gg: AYBFou0nbbW0qa9LCsDFlpQTH1BNYseP8lmE21EVuFIiZBzjSadJaLN11Z90DY4z6qD
	nlpnzk65ga2+m/NkRjd0/n4A5uahnNyeiDp9atWEeSOI4NHt7B0TwDhei5urqefFgnQG+4skZpF
	yyYlPY3WwboyXIkowA/ARIxhLH5FiwTMtg7/c0ZLBgkwF0HZyh6HcoJCx1iT+8GXfgpyvHs1eOq
	+knRZc8sFOXsmCDWQhoTkTtSYyhUFNtuE+7GemBxbUzWipqh4Gc7kJU7mp14NJ2CFIjEdhrDRLF
	jO3NS343/2Qr9vyKpSrUdn/Wxf2vpZtyBOM2S7PBUU2+Pgr3KVRP8CIkyrg+IT+nkHB+BwHRWqV
	maHRStiQyL5m9YtALiYusS3GTLRXLHDV7IBDloAIeOnIdLy/f5U14jLraAcaQAApK6IFVtXwDia
	1pvdXgdv5u3eikoYc4zFX6wS4sxnMG/LJ9904KUYsz8Ct/h91XlTPyj0HI7AGhwQJCqA==
X-Received: by 2002:a05:690c:e3e8:b0:841:e9e4:8ab9 with SMTP id 00721157ae682-8a64949ac2dmr92204867b3.25.1790694251364;
        Tue, 29 Sep 2026 08:04:11 -0700 (PDT)
Received: from [192.168.18.164] ([2600:8804:5716:d800::2620])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-8ab40a699b9sm9871467b3.43.2026.09.29.08.04.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 29 Sep 2026 08:04:09 -0700 (PDT)
From: Ryan Brue <ryanbrue.dev@gmail.com>
Date: Tue, 29 Sep 2026 10:04:05 -0500
Subject: [PATCH RESEND] usb: mtu3: don't run gadget completion callbacks
 with interrupts disabled
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260929-usb-mtu3-gadget-completion-callback-fix-v1-1-8b75b48fab96@gmail.com>
To: Chunfeng Yun <chunfeng.yun@mediatek.com>, 
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: linux-usb@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
 linux-mediatek@lists.infradead.org, linux-kernel@vger.kernel.org, 
 stable@vger.kernel.org, Ryan Brue <ryanbrue.dev@gmail.com>
X-Mailer: b4 0.16.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1790694249; l=3859;
 i=ryanbrue.dev@gmail.com; s=20260906; h=from:subject:message-id;
 bh=ctXSxhL8cB96oM2LlBR4kk7hbE12PJXfiPWlYJLZFo0=;
 b=yw9LSE1i8GiNOL28F+XSvLaDLH7wn1idNjPtWu+r9QdBnFtrnSjo5+Rv8f6OF2gtorNSDOtWI
 rwGwjhX4Z1JB8caumEIvOiFYMI3N524g6ZrHKXJhw00Al65rItA0TYm
X-Developer-Key: i=ryanbrue.dev@gmail.com; a=ed25519;
 pk=KsUvVaP//v/2q+ZBuacc7cLbsyEYn+AD71Sn28oZWKo=

mtu3_irq() is a threaded handler, so it runs in process context, but it
takes mtu->lock with spin_lock_irqsave(). mtu3_req_complete() then drops
the lock with a plain spin_unlock() around
usb_gadget_giveback_request(), which leaves hardware interrupts disabled
across the gadget function's completion callback.

That breaks any callback that reaches netif_rx(). Since the threaded
handler is in neither hardirq nor softirq context, netif_rx() takes its
local_bh_disable()/local_bh_enable() path, and enabling softirqs with
interrupts disabled is not allowed:

  WARNING: kernel/softirq.c:430 at __local_bh_enable_ip+0x17c/0x188
    __local_bh_enable_ip
    netif_rx
    rx_complete [u_ether]
    usb_gadget_giveback_request
    mtu3_req_complete
    mtu3_qmu_isr
    mtu3_irq
    irq_thread_fn

With CONFIG_TRACE_IRQFLAGS, __local_bh_enable_ip() ends with an
unconditional local_irq_enable(), so the plain spin_lock() re-taking
mtu->lock afterwards runs with interrupts on and is recorded
SOFTIRQ-ON-W, while mtu3_gadget_queue() takes the same lock from a
softirq (ncm's tx hrtimer), and lockdep follows up with an inconsistent
lock state report naming mtu->lock.

The locking was right when mtu3_irq() was a hardirq handler. It stopped
being right when the handler became threaded without a primary handler;
dwc3 hit the same thing the same way and fixed it in the controller
driver, in commit 84918a89d6ef ("usb: dwc3: gadget: Let the interrupt
handler disable bottom halves.").

mtu->lock is never taken in hardirq context: the only handler is
threaded and has no primary handler, so disabling softirqs is enough.
Take it with spin_lock_bh() in mtu3_irq(). The completion callback then
runs with interrupts enabled and softirqs disabled, which is the context
netif_rx() expects. The other sites keep spin_lock_irqsave(), which is
strictly stronger and still correct; several of them really can be
reached from softirq context.

Both reports need lockdep to be seen, but the context violation is real:
netif_rx() wants either hardirq/softirq context or interrupts enabled,
and mtu3 gives it neither. The fallout on a PROVE_LOCKING kernel is not
cosmetic either - copying a 21 MB file over USB ethernet hung and reset
this board repeatedly before this change. Once interrupts have been
left enabled while the thread holds mtu->lock, the tx hrtimer softirq on
the same CPU spins on it forever, which is the "CPU0: lock(&mtu->lock);
<Interrupt> lock(&mtu->lock);" scenario lockdep names. The same copy is
reliable after it.

Fixes: 13118959cb1a ("usb: mtu3: register mtu3_irq by threaded irq")
Cc: stable@vger.kernel.org
Assisted-by: LLM
Signed-off-by: Ryan Brue <ryanbrue.dev@gmail.com>
---
 drivers/usb/mtu3/mtu3_core.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/drivers/usb/mtu3/mtu3_core.c b/drivers/usb/mtu3/mtu3_core.c
index a40bf5bad2d5..ed0e426645fd 100644
--- a/drivers/usb/mtu3/mtu3_core.c
+++ b/drivers/usb/mtu3/mtu3_core.c
@@ -790,10 +790,9 @@ static irqreturn_t mtu3_u2_common_isr(struct mtu3 *mtu)
 static irqreturn_t mtu3_irq(int irq, void *data)
 {
 	struct mtu3 *mtu = (struct mtu3 *)data;
-	unsigned long flags;
 	u32 level1;
 
-	spin_lock_irqsave(&mtu->lock, flags);
+	spin_lock_bh(&mtu->lock);
 
 	/* U3D_LV1ISR is RU */
 	level1 = mtu3_readl(mtu->mac_base, U3D_LV1ISR);
@@ -814,7 +813,7 @@ static irqreturn_t mtu3_irq(int irq, void *data)
 	if (level1 & QMU_INTR)
 		mtu3_qmu_isr(mtu);
 
-	spin_unlock_irqrestore(&mtu->lock, flags);
+	spin_unlock_bh(&mtu->lock);
 
 	return IRQ_HANDLED;
 }

---
base-commit: df2908090cda368b01ff43709f51890076c56157
change-id: 20260913-usb-mtu3-gadget-completion-callback-fix-d334f7e99a17

Best regards,
--
Ryan Brue <ryanbrue.dev@gmail.com>
-- 
Ryan Brue <ryanbrue.dev@gmail.com>

