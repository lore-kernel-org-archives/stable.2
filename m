Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.216.42
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793550682;
	b=PhVvInfzo/WC9kg5mgErm755f9qSXQ8bxUeSpUR2EsQuPz9pz5qhb0vUkkBFtTE9N1GZ
	 pxllGXAYTuGY9hHtctL9yq3PYZc08BfU6B2P+lVs3ybtb6y3wG2EVWPxSWdBdKXm44JpR
	 ZhPTCmgDIEn0leJfYNRnOsm8NEaJ2pHXiEtVcVpneEG+Krc8sI2p0QBqaLwmGZj1JOCWI
	 AhFHkCgzUZquKKzi1UUXAgJHd6CMHK9z/oaGymiJCRMoikmEoPcsRXhFFEhe9JDB9sdh7
	 NzkfoyytywTd24gxpjpzK/zYOWtrQXs8gzS0/1u7rw8Y7RAeRLd71IYcF5zpagXflCQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793550682;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding;
	bh=z1wgGnLaHoKZu2/+Ud078CAK3gozxrFVUFtZdHR2t7Q=;
	b=MNo4TJ4uGUtGIp8/idrakvtiofCRXbhKKhvVj1heXfMLvfedBRlCLPJMDyS0tHu0I/yU
	 rngY2Jczw7Z1i3lbGADvECh8vtMO8Az3uuYKWeFyHrRBshoHJmL0j7D2Q2KmLbZjyGPDG
	 Y6BsbHkjV7xc7P14yKJCkZof4nyCAcrL6vSPlbVNnn2SbROH/eB2JpRLwbw4SFz/99HSu
	 sJwIRt9q+qcE9f3YLav96O78JjfEPXkd3qiQ+lm4/ZRowAqHxMMHE1Pq7h6G6m2lkRDNR
	 5Onwaeg2Ks1nAKvQwG34kjfqL5+CPro9rWu0g+JVUx9PZ5qFon7XsvnQ3SE3/GJSw4A==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=JA4m2Ns4;
	arc=none smtp.remote-ip=209.85.216.42
Received: from mail-pj1-f42.google.com (mail-pj1-f42.google.com [209.85.216.42])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4A0CC606A331
	for <stable@vger.kernel.org>; Sun,  1 Nov 2026 16:31:21 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 4A0CC606A331
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=JA4m2Ns4
Received: by mail-pj1-f42.google.com with SMTP id 98e67ed59e1d1-3adb9cbb0c3so302729a91.1
        for <stable@vger.kernel.org>; Sun, 01 Nov 2026 08:31:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793550681; x=1794155481; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=z1wgGnLaHoKZu2/+Ud078CAK3gozxrFVUFtZdHR2t7Q=;
        b=JA4m2Ns40pxtAJ0B0P+Apj0Caferb//RL/RdbQHGvGyLjmAJ661bHSRKsH+u2pLmEo
         zWKn9R+UAQGSmuZ1egI7pZtERHb9SFkWQnl1Vqp/ubDT6tl9Qit7v3WxzGD5tdi0f+GY
         k5iGNn2FuVCnoDLnbLAA3LyL9PQbXS56aetV9r1dfywrCDD6QlcM0yKhgfujFVp8ENxq
         N/sQKIQS0xdl2lNlXCYQFwrdLZFvZk95ig1EzRjTspquwegJ3b8Jhq8Z4ihMIdXhTG1o
         P84pi9y54esfjSEl3eibipuoKv7er51jnmxtor9rbbV2guKpA6Rxz02UTyARgHvo6Wlk
         NLng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793550681; x=1794155481;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=z1wgGnLaHoKZu2/+Ud078CAK3gozxrFVUFtZdHR2t7Q=;
        b=ZLi+zBQFeqRAwZzoWEsk0BqaXsRTnSt/IMhSxLOzgjKtTKk6EP6vneLgR51VBeDt2D
         38Yt0wGMsqIh1imUNmY8Px7vmcLW7+k1M9fiJlMYMThJdbpS58cIB7GS6Seu5/J4dSyB
         xVSNtjyloCgGr++TbEEUvUnotmxfvVD/ApxrWtfSD8oyBrnYoGiBDu47iVKeTf1hKsYR
         DFgV68vNcIZcrrU7+lPgbhaGQptZYsH1hkInBEE+WqM9LAN4i0V3hvJerSbtg4MJpjYN
         xV7yUmhsWJIe0XBO5J5P9MM0AIzJ5IdNwk5xM2FR9DneL9Fx9JIdMAErDxOWhsiCus7t
         hHlQ==
X-Forwarded-Encrypted: i=1; AKwUvBy85ettPaVkahb/oezJrKuSLuv0TI6u468b5QaR9QeeEBEzUvGzhVhZeS5AA+/asniWV5t3C+0=@vger.kernel.org
X-Gm-Message-State: APuU4Z8MjgWQfUsKY9J3AxvuxrJsYMVUv2ZaFx714LOY6I7s6DEVyyO3
	RUJFTh07/ZHuGDp5QW7VauxC0VINPLW5Z4+CU85WNoUl91vOkYlHDT12
X-Gm-Gg: AYBFou1OK2JvA9CI8l7LLN4dglJdbSALthl4N7S9/IdfEhyozCKNrERIn9cF3WEsKFv
	THHUTUMezMYu5wwVEVQPhOb3st4ORlZOe2wSIWEte42QFVGN8H19OFdzpVasgPpXrG4u2rmhuw6
	4zmbtmx2PfXKEFyiBqtd7OPPdp4cmHsI4M7DCKd7oYAJhVwoShuy0MN5CBNl7uqiA2C057Zf3FL
	DGL9NoFcvYiSgMwq92kxdBjeG5O7oDX5nE2W/hlreaH3cCMqCpg9lwGYyT8eukFGevFckt9sMuk
	u5ka6icWHCoCdkKGSaocp+G+PI82CDtYzZqGrKnRbXFz9/Z5kvKDINV4qYbb92HRQl3xPyJar5p
	iYG3/yVvSAfG37bF0+2Nl8EERacOgMhFmrBB8CTCC1zyCuv4HWnDCOi9fb/pKy2B+5dTcT2YzbJ
	8jG0Na1U4wdMB6IfMjaTKPNqW0Lv7azF1IZyzjTQhgvpD788xY1EqoyrGPSq24P/9c85Uw2iHkK
	PFufsDa1rkvOHxIBuO+JbIJQRIkC3iOApm8e9kbXIxFttwQjl8ACaI91gcxnQhv8CQdHz/pFpOK
	n0VX2Xe3XIHLyAs2DU1W0E9ZeCrk+EoUM8Np22CCuc4lr8/+M8oOdL5sbxFPiy15pev1eJGR2Y+
	v95L6zZO9cbG6qO2zM6Bus5c=
X-Received: by 2002:a17:90b:28c7:b0:3a0:238b:db4d with SMTP id 98e67ed59e1d1-3ae897f82c4mr10848258a91.5.1793550680657;
        Sun, 01 Nov 2026 08:31:20 -0800 (PST)
Received: from localhost.localdomain ([113.102.236.131])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3ae6e944ba9sm15038585a91.8.2026.11.01.08.31.17
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Sun, 01 Nov 2026 08:31:20 -0800 (PST)
From: Qihang <q.h.hack.winter@gmail.com>
To: Juergen Gross <jgross@suse.com>,
	xen-devel@lists.xenproject.org
Cc: Stefano Stabellini <sstabellini@kernel.org>,
	Oleksandr Tyshchenko <oleksandr_tyshchenko@epam.com>,
	Viresh Kumar <viresh.kumar@linaro.org>,
	linux-kernel@vger.kernel.org,
	Qihang <q.h.hack.winter@gmail.com>,
	stable@vger.kernel.org
Subject: [PATCH] xen/privcmd: fix double free when an irqfd is shut down twice
Date: Mon,  2 Nov 2026 00:31:07 +0800
Message-ID: <20261101163107.55037-2-q.h.hack.winter@gmail.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20261101163107.55037-1-q.h.hack.winter@gmail.com>
References: <20261101163107.55037-1-q.h.hack.winter@gmail.com>
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

irqfd_deactivate() takes the irqfd off irqfds_list and queues
irqfd_shutdown().  queue_work() is not a once-only gate: it refuses to
enqueue a work item only while WORK_STRUCT_PENDING is set, and
process_one_work() clears that bit before it calls the work function.  So
nothing records that the shutdown work has already been queued, and
nothing protects the window between the start of irqfd_shutdown() and the
kfree() at its end.

Two paths call irqfd_deactivate() for the same irqfd:

  - privcmd_irqfd_deassign(), from the PRIVCMD_IRQFD_FLAG_DEASSIGN ioctl;

  - irqfd_wakeup(), with EPOLLHUP set, when the last reference to the
    eventfd file goes away, which runs wake_up_poll(&ctx->wqh, EPOLLHUP)
    from eventfd_release().

irqfds_lock serialises the two calls, but it does not make the second one
a no-op, and eventfd_ctx_fdget() takes a reference to the eventfd_ctx,
not to the struct file, so the last fd can still be closed while the
ioctl is running:

  CPU0                                 CPU1

  eventfd_ctx_fdget()
  spin_lock(irqfds_lock)
  list_del_init(&kirqfd->list)
  queue_work(&kirqfd->shutdown)        close(fd)
                                         eventfd_release()
                                           wake_up_poll(EPOLLHUP)
                                         irqfd_wakeup()
                                         spin_lock(irqfds_lock)
                                         irqfd_deactivate() again

If the work item has already started by then, its pending bit has been
cleared and the second queue_work() succeeds.  irqfd_shutdown() then runs
twice, so eventfd_ctx_remove_wait_queue(), eventfd_ctx_put() and kfree()
each hit the same object a second time; and when the second queue_work()
lands after the irqfd has been freed, the workqueue list operations write
to freed memory.

virt/kvm/eventfd.c has the same two callers and has had this guard since
the original irqfd support (721eecbf4fe99): irqfd_wakeup() calls
irqfd_deactivate() only if irqfd_is_active().  The comment there explains
why that is enough: the other side deactivates the irqfd before it takes
it off the waitqueue, and irqfd_shutdown() needs the waitqueue lock,
which this callback holds, so the irqfd cannot be freed under it.

Do the same here.  list_del_init() leaves the list head empty and the
irqfd stays off the list until kfree(), so it serves as a one-way
"active" flag.  The test is in irqfd_deactivate() rather than in
irqfd_wakeup() because privcmd_irqfd_deassign() walks irqfds_list and can
therefore never reach an inactive irqfd; only the wakeup path can, and a
single test covers both callers.

Fixes: f8941e6c4c712 ("xen: privcmd: Add support for irqfd")
Cc: stable@vger.kernel.org
Signed-off-by: Qihang <q.h.hack.winter@gmail.com>
---
 drivers/xen/privcmd.c | 15 +++++++++++++++
 1 file changed, 15 insertions(+)

diff --git a/drivers/xen/privcmd.c b/drivers/xen/privcmd.c
index 5e56fbc934478..221b31611343e 100644
--- a/drivers/xen/privcmd.c
+++ b/drivers/xen/privcmd.c
@@ -901,10 +901,25 @@ struct privcmd_kernel_irqfd {
 	poll_table pt;
 };
 
+static bool irqfd_is_active(struct privcmd_kernel_irqfd *kirqfd)
+{
+	lockdep_assert_held(&irqfds_lock);
+
+	return !list_empty(&kirqfd->list);
+}
+
 static void irqfd_deactivate(struct privcmd_kernel_irqfd *kirqfd)
 {
 	lockdep_assert_held(&irqfds_lock);
 
+	/*
+	 * Both the deassign ioctl and the eventfd wakeup path can reach
+	 * this function.  list_del_init() marks the irqfd inactive, so
+	 * only the first caller may queue the shutdown work.
+	 */
+	if (!irqfd_is_active(kirqfd))
+		return;
+
 	list_del_init(&kirqfd->list);
 	queue_work(irqfd_cleanup_wq, &kirqfd->shutdown);
 }
-- 
2.54.0 (Apple Git-157)

