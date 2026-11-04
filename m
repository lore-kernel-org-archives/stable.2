Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.231.74
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793792570;
	b=F4eBqzAqx6e/nVJ8li0+ph8hQk/bSnusiQr5ujsa2vcAkOaqZ6IDiUrTgpcJM8lfAY/E
	 b1+3gjjwIackxmPr8bcwuDvirN3sZQvUZOLy1+cmQJw3dilPuhL7zTfA/FWyOAS6AeNwj
	 PxvEodxII5/3IJpF7PYjDcOiCFpleThlnNUl5f81Ytfek65bHiKi9hpJgRIbrwY7i3o8t
	 nnxcCAPYQdcQLob+js3ugTytbTzkMa66JDsqshlHbd+9Aosw8fgs4mpaLCr4Bz4eAWe+s
	 y6R4YH1PSCal7xSncjcxvTSaYImzhVC5FlrK4M/0x5LgJSHUl+hzOxcZGQmZ/L6kPNw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793792570;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:Date:Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:
	 Message-Id:X-B4-Tracking:X-Change-ID:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key;
	bh=ntkvK9vArmmau6WntPJJCQysHHMrqtIZmeCGFS6XyDs=;
	b=YfsfOb98ppYIm8Iwh9Ssij/yhrfMsPjH02N6DfcByeWVLqG1I5/Mk+E6b4IViMuzGL7K
	 VtEoBXiSAYY/ZeEsQqPdPPd+xKRoKON80syeZ4+a+7kVWLP3Bj1R3a7ikTCTWjai8bYo6
	 1KnMBPaO7frnKJGmqeQ9JGK8OHfYWfBShvx6iHhx8odYRhZXGTGX+ch9SvebosbRkFuFt
	 3sYz6RqDlQBNtrUmOxRz9VvHNEDAOGozYXY7J0x820FuCFBhvAgJUQu2eSYMUr+bGf/E4
	 jfEc62qXquQG1LZET/TyrurORNduIwm72W9piIHvy59YIqZylFMDfBK3/WwMZ2KRgqQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=Vxq50WYg;
	arc=none smtp.remote-ip=74.125.231.74
Received: from mail-oa2-f10.google.com (mail-oa2-f10.google.com [74.125.231.74])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1C2B3606A31B
	for <stable@vger.kernel.org>; Wed,  4 Nov 2026 11:42:50 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 1C2B3606A31B
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=Vxq50WYg
Received: by mail-oa2-f10.google.com with SMTP id 586e51a60fabf-4a76f0cce5eso81563fac.0
        for <stable@vger.kernel.org>; Wed, 04 Nov 2026 03:42:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793792569; x=1794397369; darn=vger.kernel.org;
        h=cc:to:message-id:content-transfer-encoding:content-type
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=ntkvK9vArmmau6WntPJJCQysHHMrqtIZmeCGFS6XyDs=;
        b=Vxq50WYgGsTUXBFOSzPxBqJPhWt2Bq7sYhyd8/yPt130upAsPr43WmT4y+J7JGTk37
         5V32/PqQvtdMPHyQe0pd81JMCBJGkxJmRSIx+yQeXQLauSR3nUOiWk9muCqGoYG5eLDP
         8gmNUe7WiFGKVX/L+nRjXQiqFXDtRHXP46jthYOZmOmPKLVR55LyqZiqkEMZ9CDm0hqM
         qYgKXQNcuWcNKeVsMpJAQRgjia7Rqni7rw7Fep9XEboI2SnP6XrAIUigWe8NDPGDH+tZ
         88zx6bkN2G75DHG9tFXZxUuOnNcxTvfQIEw3/6RiGUM7OZ20iIqyMJBv362MNAxh+qTc
         t/Zw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793792569; x=1794397369;
        h=cc:to:message-id:content-transfer-encoding:content-type
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=ntkvK9vArmmau6WntPJJCQysHHMrqtIZmeCGFS6XyDs=;
        b=k9v2CpbHKyHrG3oFDFyLDHyuTpZlsLXFH1MV8/a4P2ViWF3IswzpwkP+4vqwiexKth
         lRxMdIaOFK6Xsh0smEqVmkqKwTX5V2Acpb3XhLNz+eGfY04bESuA3LKBfv2GCbFCkpyz
         bE/U6ZqWc32/1dp9GUvwgSxNoDqhQ/tMyypQYDjQvKqL/F2afyBhDYYkHRo+nC2oUauE
         6m1rRnwae5WFtZaBXgV0TC8b6T0UMatzg+/y2X3vyUJX5nPe+5EB5Wt+uJy6dEfbpFAn
         a7Kkj4jgNS7hXvEURLl0Uq8X/anZv7GjuHJlZbZYzQuoDCN2eFHjSmGaM605f8jZKp59
         0xtA==
X-Forwarded-Encrypted: i=1; AKwUvBzdQUpMQm7kZ/hufhaC+Lfi+LXJtXZ6TuSMRsEcOwm5vhIXWrzCAJDKup7t5m1/SgQ4QVsg2v8=@vger.kernel.org
X-Gm-Message-State: APuU4Z/TkYEnVp23Axkzo6xWIFbybqYn/6AfPxXMgvu6qwi/FkDgHLR4
	P6rzNYvljPxfHCn4O5pD8sBZqETSIWcrpeUQM0oENxT6KaE8gUpk70ulvLQPSUZQJT4=
X-Gm-Gg: AYBFou2HPayy0xn5o7SOT1w3rlscnrocIGHJhHp+h4fRBdQVwH4ZSHoDiaM2isvpbhm
	9akkp5rlwN8o95bckXUx/f7jxYWi8Mb2rka8v/wuCdzVVTAqdOROdrjwlXp4IsIBqmsWXNYOpsD
	spTXmwnzPmxxou1jpdq6LkkpHPws/zQr8miSyp7Qy7yI6zSUvv0CX/H8iEUcZ8h2yq17mFYFXvU
	niB157hjqUfEkZV2mZocYjM3giACmEUs2DgFURSQndFCb7g3VKtHWg4VoiM8+/A5qchfXFR4JNA
	9JMBk7Ansfe1Pbuz0StAplFkBbSmiZA53JUpqlX84Ll53PscbylHFyjieGLxUIdIJ74jiEMAch+
	e2M5TDTIg6l1UZUs3/bDG+uhBRyKmP4HhcbgeIYdezGPUOpN2XxlOdGt/TSh4L93oLWNomAv5m4
	961I3bG6Zlor5biOL7f4O7vgXp5WbRom1GnNd2MEoXM3Xyii+GEb1PjQ1/+N918kuMyxM8U4qgr
	deLaxpWQ/PEtKjJMBpRXQLsnvcoZ6g4INpKbwc5Xic6qg7KeEliVO8Bfn3ip4gO+XfeGdeUu0Rk
	UE4dMnRpDWEygjiZZcHzV9MTzQ==
X-Received: by 2002:a05:6808:1806:b0:4b9:a88b:888e with SMTP id 5614622812f47-5640dd023c6mr10688054b6e.36.1793792568941;
        Wed, 04 Nov 2026 03:42:48 -0800 (PST)
Received: from [192.168.18.164] ([2600:8804:5716:d800::f01a])
        by smtp.gmail.com with ESMTPSA id 5614622812f47-567a9fdc42dsm1443858b6e.14.2026.11.04.03.42.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 Nov 2026 03:42:47 -0800 (PST)
From: Ryan Brue <ryanbrue.dev@gmail.com>
Date: Wed, 04 Nov 2026 05:42:37 -0600
Subject: [PATCH v2] usb: mtu3: disable bottom halves in the threaded
 interrupt handler
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261104-usb-mtu3-gadget-completion-callback-fix-v2-1-2769533a39cb@gmail.com>
X-B4-Tracking: v=1; b=H4sIAAAAAAAA/5WOQQ6CMBBFr9LM2jEtJSKsvIdhUcoAo0BJWwiGc
 HcDnsDlT17+exsE8kwBCrGBp4UDuxEKkVwE2M6MLSHXUAhIZHKTudI4hwqHOGtsTd1SROuGqaf
 IbkRr+r4y9o0Nr1hrnTYZ5blRGVwETJ4aXk/Ts/ztMFcvsvG4P4iOQ3T+c6Ys6uD+ty4KFZJO7
 1LKtKFEP9rBcH+1boBy3/cvTtkLYfAAAAA=
X-Change-ID: 20260913-usb-mtu3-gadget-completion-callback-fix-d334f7e99a17
To: Chunfeng Yun <chunfeng.yun@mediatek.com>, 
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: linux-usb@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
 linux-mediatek@lists.infradead.org, linux-kernel@vger.kernel.org, 
 stable@vger.kernel.org, Ryan Brue <ryanbrue.dev@gmail.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1793792565; l=4420;
 i=ryanbrue.dev@gmail.com; s=20260906; h=from:subject:message-id;
 bh=YKrWQc6X594nxsi6j6O7RkIqP4KUVuw16YHFth6q4aA=;
 b=kplKluc55m0ByUTEidjz+o5BPLPKs32RJFwusMLDnxrxB+Jj6Dr9y/he45mi/xR8jzpbfVMHO
 U0XTYhmgwiZAXt6/F6OextvdklivIZ3FMwQGkfV8KeBC0kS0DFH/xVd
X-Developer-Key: i=ryanbrue.dev@gmail.com; a=ed25519;
 pk=KsUvVaP//v/2q+ZBuacc7cLbsyEYn+AD71Sn28oZWKo=

mtu3_irq() is a threaded handler, so it runs in process context, and it
takes mtu->lock with spin_lock_irqsave(). mtu3_req_complete() drops the
lock with a plain spin_unlock() around usb_gadget_giveback_request(), so
the gadget function's completion callback runs with interrupts disabled,
as the gadget API promises, but in neither hardirq nor softirq context.

That breaks any callback that reaches netif_rx(). netif_rx() disables
bottom halves itself when it is called outside hardirq and softirq
context, and enabling them again with interrupts disabled is not
allowed:

  WARNING: kernel/softirq.c:453 at __local_bh_enable_ip+0x128/0x134
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

Do the same: disable bottom halves around the lock in mtu3_irq().
netif_rx() then finds softirqs disabled and leaves them alone, the
completion callbacks keep running with interrupts disabled, and the
softirq it raises runs at local_bh_enable(), once the lock is dropped
and interrupts are on again.

Both reports need lockdep to be seen, but the context violation is real.
The fallout on a PROVE_LOCKING kernel is not cosmetic either - copying a
21 MB file over USB ethernet hung and reset this board repeatedly. Once
interrupts have been left enabled while the thread holds mtu->lock, the
tx hrtimer softirq on the same CPU spins on it forever, which is the
"CPU0: lock(&mtu->lock); <Interrupt> lock(&mtu->lock);" scenario lockdep
names. The same copy is reliable with this change applied.

Fixes: 13118959cb1a ("usb: mtu3: register mtu3_irq by threaded irq")
Cc: stable@vger.kernel.org
Signed-off-by: Ryan Brue <ryanbrue.dev@gmail.com>
---
v1 took mtu->lock with spin_lock_bh() in mtu3_irq(), which left
interrupts enabled across the gadget completion callbacks. Sashiko
pointed out that struct usb_request's @complete must run with them
disabled, and that u_serial's console relies on it [1]. v2 keeps
spin_lock_irqsave() and disables bottom halves around it, as dwc3 does.

This patch was developed with the help of an LLM.

[1] https://lore.kernel.org/all/sashiko-outbox-193807@kernel.org/
---
Changes in v2:
- Keep interrupts disabled across the completion callbacks: disable
  bottom halves around the existing spin_lock_irqsave() instead of
  taking the lock with spin_lock_bh() (Sashiko)
- New subject; v1 was "usb: mtu3: don't run gadget completion callbacks
  with interrupts disabled"
- Rebased onto v7.4-rc1
- v1 was resent on 2026-09-29 and 2026-11-02:
  https://lore.kernel.org/all/20261102-usb-mtu3-gadget-completion-callback-fix-v1-1-93c3a6dda31f@gmail.com/
- Link to v1: https://patch.msgid.link/20260913-usb-mtu3-gadget-completion-callback-fix-v1-1-e3480004fe23@gmail.com
---
 drivers/usb/mtu3/mtu3_core.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/usb/mtu3/mtu3_core.c b/drivers/usb/mtu3/mtu3_core.c
index 990e2e8e6bc2..3127709acc22 100644
--- a/drivers/usb/mtu3/mtu3_core.c
+++ b/drivers/usb/mtu3/mtu3_core.c
@@ -793,6 +793,7 @@ static irqreturn_t mtu3_irq(int irq, void *data)
 	unsigned long flags;
 	u32 level1;
 
+	local_bh_disable();
 	spin_lock_irqsave(&mtu->lock, flags);
 
 	/* U3D_LV1ISR is RU */
@@ -815,6 +816,7 @@ static irqreturn_t mtu3_irq(int irq, void *data)
 		mtu3_qmu_isr(mtu);
 
 	spin_unlock_irqrestore(&mtu->lock, flags);
+	local_bh_enable();
 
 	return IRQ_HANDLED;
 }

---
base-commit: 6628e7d4c6b25c8d18f1345e3a20d21829aae7e4
change-id: 20260913-usb-mtu3-gadget-completion-callback-fix-d334f7e99a17

Best regards,
-- 
Ryan Brue <ryanbrue.dev@gmail.com>

