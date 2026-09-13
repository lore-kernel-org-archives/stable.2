Received: from mail-oo2-f7.google.com (mail-oo2-f7.google.com [74.125.231.135])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 52A0D3AFD02
	for <stable@vger.kernel.org>; Sun, 13 Sep 2026 22:21:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.231.135
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789338098; cv=none; b=cF051V/bKGuxxF4SlD49V5yVaVkqRVuAYjoX76sNIP34YhQcPpsw19Rqefo8E900aoIaKVWsV72aOKgNN4XAdJR12D9qrwtryV4d0D1QFcaz1KRwIJGDUaVDRo9QoVOCkXp8jdvf1Vu4T4mltCewhbRDa8XoNbzrWA/O4WyXOgY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789338098; c=relaxed/simple;
	bh=Tg9Kq8vx6MVWyGAb8N8rORP+uP72Obd3DRFlHL5xK4Q=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=WFoT7O+FPj0uQqBvas74hWkCpTiV17ZPj32EHn0lLllenvcnsBfnOLM4uSQUxHzuHDUh3r/XzlVPufj3Fb0wtjOf7qmufUgbpWImObJQE0uCit7l2MyzdtUM/Ud8KJclCS2qsxh2NtVFfwjqMAwhxwKZuRs2QuX+oh/7eVCURrg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=jLOSYCup; arc=none smtp.client-ip=74.125.231.135
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jLOSYCup"
Received: by mail-oo2-f7.google.com with SMTP id 006d021491bc7-6c197ff1f3aso641669eaf.0
        for <stable@vger.kernel.org>; Sun, 13 Sep 2026 15:21:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1789338090; x=1789942890; darn=vger.kernel.org;
        h=cc:to:message-id:content-transfer-encoding:content-type
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=k3ZJJYWLWAdknGD5xgQyF6oWUgV2YSWXzpw9ViLpMPo=;
        b=jLOSYCup4UUI9ZBeWXnji2ugi5R7fu8HnJwAx1YqUxTQSPvm9IuRKujbjXX+x9fW4c
         6WE7DL8jfSccWAdN1xELyPTo8VeT7+bc28l8gUsG3rtKYIwikTOcmLf2s8lacSm5+yRh
         I9Y4fhHZU6WuL/B+M7VxpWWXO1FCzInDRxqFaleGwiSpmJm14BEXEHpgitrNySKn+hJy
         yftldqV7zlXG/6o+TCDuvxcMI3zhbvPAYFxs5qgAir+F4hn+EfcVsescZPKE+Dy6kwXQ
         vKC1pjf+D6jJnoS+39uZtA5D/Gr6GjA5TC4EPlzTvxRGQ637jQCQuVNyt8IQJuoWwGvi
         cWWA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1789338090; x=1789942890;
        h=cc:to:message-id:content-transfer-encoding:content-type
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=k3ZJJYWLWAdknGD5xgQyF6oWUgV2YSWXzpw9ViLpMPo=;
        b=WgqoLwIR1ZknBc1fuvMpMZ0nKLJ3131feaOsDqAVVnYkLEU3K1tamA6HqVF0oQhtCd
         wgGzNmRJnD882D2CZFJE+HHkl+lLoE6TjaPDXB3+UZp8Yzsjae3Le4gT8wNbW2Xx7zaZ
         bb8dF+RN9SYli85rOjZwIKhdftE7OqMjHD/52Q9AMYI7d1GbtIevuNy8++fQjvUuitCV
         +s/5IVmXzfLrvLijhfs8SUO9qIANZe1/83OIYMMpfCYfiCFlTzjLQpd0L8nwfaArredx
         pMSIg3ziy2zYmq1EN4iBJyMW14hSH7l7/NfoW9QhjAZW19XZ38Cof2++HVs75XXJ7caS
         h7Yg==
X-Forwarded-Encrypted: i=1; AKwUvBxcA5qZSccWvXOXkhW2MjVnDxFZFjvbl38RqXX3IpcZysGHgcwYqeOD2ci4jsyWDYKhAaiD+hg=@vger.kernel.org
X-Gm-Message-State: AFuF++lc3Yx5+RqwA63yHhn4p2vQTeFZYEyFEMBIkkWQeBrVEdj2I4CW
	3hKP92tCGDxfWQM4l8drElTqJaxYngZXBU4CmLV4vFefhYuf11166IA3
X-Gm-Gg: AYBFou0kFUuD9Liq/Of93EXFDyUu9FouFgCnekbf/ycpjEU30I2VeuPoWtKNoPYbGzW
	brCIErkHXbXG0K+uLfiEP1n3sfvdcxnOmlWJ4E/rR37oNOUAnncSTHVA+Y8jUyczMkK05qgXSbJ
	vd12dp+ctZXMJ6V0Dr3eK0/7mxWveqyX77Kfd017LkDIX4ld75lFWj6g1gobYy5N4O50vIwx4ML
	Gubike9pJRU+rrnOKbHNl6MmhxbCo5u3jhZjlEPYI8LwD4kJJ5/IPTuJsQyaQc5RTlGfo4/yXBO
	srjR2TPzptvO629R0hcFjAVHOI8QG2qgqEcU24pRuZ/+AFp3ndGTE7ogExUnILQRSmddYIiX52Q
	N6wxuid+B4TpWmbdbgxXZyXpWRvCcZn8M4cq5KDjWkPdmJyxEJIRdl3MsYro8mOTE/2fZ3hoZ0d
	12Zv3M05rIb/FdFxV3NVZ93ciOFcPNkTZoOYWehNzg7Nua1mRr1DHRLYJJJ2Nvwpz0klo=
X-Received: by 2002:a05:6820:571c:20b0:6b6:4f90:a62a with SMTP id 006d021491bc7-6c0ba8280bbmr12189996eaf.11.1789338089833;
        Sun, 13 Sep 2026 15:21:29 -0700 (PDT)
Received: from [192.168.18.164] ([2600:8804:5716:d800::b712])
        by smtp.gmail.com with ESMTPSA id 006d021491bc7-6c342ec1ff5sm4343973eaf.14.2026.09.13.15.21.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 13 Sep 2026 15:21:28 -0700 (PDT)
From: Ryan Brue <ryanbrue.dev@gmail.com>
Date: Sun, 13 Sep 2026 17:21:25 -0500
Subject: [PATCH] usb: mtu3: don't run gadget completion callbacks with
 interrupts disabled
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260913-usb-mtu3-gadget-completion-callback-fix-v1-1-e3480004fe23@gmail.com>
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/yWNywrCMBBFf6XM2oGmEUv8FXGRxzRG0weZpAil/
 95Yl+fAPXcDphSI4d5skGgNHOapgrg0YF968oTBVYau7W6tEhILGxxzkei185TRzuMSKdcZWh2
 j0faDQ/iik/I69KSUFj3U2pKo6vPp8fwzF/Mmm3952PcDXmv8Q4sAAAA=
X-Change-ID: 20260913-usb-mtu3-gadget-completion-callback-fix-d334f7e99a17
To: Chunfeng Yun <chunfeng.yun@mediatek.com>, 
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: linux-usb@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
 linux-mediatek@lists.infradead.org, linux-kernel@vger.kernel.org, 
 stable@vger.kernel.org, Ryan Brue <ryanbrue.dev@gmail.com>
X-Mailer: b4 0.16.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1789338086; l=3820;
 i=ryanbrue.dev@gmail.com; s=20260906; h=from:subject:message-id;
 bh=Tg9Kq8vx6MVWyGAb8N8rORP+uP72Obd3DRFlHL5xK4Q=;
 b=YprVcQaOfoVyeaf75GeW9nCb4J5m5vEY6QpXXbHYMQMmSn3VqJ7Ey/kLrFM279kQOjoN7ouGX
 GtYBNWkV6EVCWDGlBclQanK+2Ty+CLHAizBVeQxibpvONvTk2OdAOFk
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

