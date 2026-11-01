Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.216.52
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793550678;
	b=ODw4ZDgrjB2NYPdXL+1gFGx7P9fVu006fIJ6I61QVJuJLlV3ofgqFn6f/RBQln6b4hu5
	 zBzv7nNBnthyOlczEdGYyqCmfnnNwqiJ+peE9P2ihxFCz8FmQv/FQiOMwrXDFx0JeJjMy
	 cxBlzddcdKyUAfhZHr/36tH1BpDqqKU2Rw9avWvTmE9JkB2Bo2bYTd9B3M/3wKn2StcK2
	 SzBqhPshv77SOv+jApBXAbjhVdbGMArXSP+E87QBL6xPdIFYTplU/Q3jSQ+M+0xN7F8p+
	 qDoZjSzGbv3KJzy7rJyE3J6zrPVV3f9AX+YEUevrD5bVenauqoLTQ++N3KT4RetYMDA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793550678;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:MIME-Version:
	 Content-Transfer-Encoding;
	bh=z1wgGnLaHoKZu2/+Ud078CAK3gozxrFVUFtZdHR2t7Q=;
	b=z9AVRpfyFlmdJoqzw2ijOhW9AaRK1FosQeLUdypw0RuuYseh9qLhkGLwQ5hbVe3jhHDc
	 07o3RjHBzphLtJxafJ2Ak8buSAZ0/1I75jqIeBaZaOaIjkEJvmgddJOgtVG97vGYQG3/B
	 fEwj2thT+nK095hq7Ce8Q68BRbQKsssErJHzZvFsADv8Hci9vJvu0sJSiwqoXPv77DRnE
	 gcWgbqYPFtNdPAHbNWiiEi9Q1Z1wmFKxV0rHlpo4KeDl0CYzkkXomDEhCcuGlcrEECZyM
	 A2r3XYeToTpLSPTyMAim/OlnR/i2TzGgWHoxn6pywSPapDa+cWezmzMbsk7N51sXgzQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=Xz7o3aNL;
	arc=none smtp.remote-ip=209.85.216.52
Received: from mail-pj1-f52.google.com (mail-pj1-f52.google.com [209.85.216.52])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DA452606A325
	for <stable@vger.kernel.org>; Sun,  1 Nov 2026 16:31:17 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org DA452606A325
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=Xz7o3aNL
Received: by mail-pj1-f52.google.com with SMTP id 98e67ed59e1d1-3ab2cb02816so398644a91.0
        for <stable@vger.kernel.org>; Sun, 01 Nov 2026 08:31:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793550677; x=1794155477; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=z1wgGnLaHoKZu2/+Ud078CAK3gozxrFVUFtZdHR2t7Q=;
        b=Xz7o3aNLu0EcXJgkFcpNcT9ms9XQbE9FRhuapUyst6lLzOD/XqlbsiUKQjSNbt7WM1
         mustLlBcHK3qKFtAQoCHJ435p/Z+T+JOF7KRfAdSeF3D7q3Uqn8bslYV/P3gC1nDZXAl
         oq1ATQwO2pb8mWXr+dGI5e/gLbKhz06tDjmK9Y5F/5kqAITu6JtGWJZkYg51oc20Pomo
         a2jffLkunx9lY9Z54vt6p7d837s6aRRzT4e6sBF5eEgbIxR5Sc2aVtzqtcg21db9MS6W
         Dm6GmZ9OKvOjbAXBtZdaTWQsUWhEKkITcHgwjc0cvjcI4/M+zz5iZcXbNsamCBuEKev2
         2kpw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793550677; x=1794155477;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=z1wgGnLaHoKZu2/+Ud078CAK3gozxrFVUFtZdHR2t7Q=;
        b=TGLZk5outgNEXyckb15y9KYcF+Y5z277IfTKGaGZtnzIDFWkzTMaby2k40/0+GY95G
         T3V3TmZHfn1ilF/6PdAOqhpE7CzektjWqZ3un3EEyQO0Y/GAMM1TUx/cdQiPLsN8NI9f
         3D+kFwsMi5jRFnJIJnQrnf96T7259CqtnRZ50uU6fR3LwRpS2Z+0cn9IyIa/qMTadvgK
         K+jpjtngRnZuegC2wtq0fXPJC/rTSAJCbPb0jp9KTG3nmdbQtscOBws4fezAcXxeZMzu
         ycvArWUXM0gc6TEs9Q6rVEatwlRpe8LOanJp910cAFLSmpxzu4snluYIzFuSaPf4DFBM
         PjBQ==
X-Forwarded-Encrypted: i=1; AKwUvByK92gCXkduMfQFPv/aKy4N3lcdxlrwgh5GMa4MtR44MpwbFCVOXNwkEBlApNQc0T7tR89HLxU=@vger.kernel.org
X-Gm-Message-State: APuU4Z8aRIMT2sRgYIEIORN16lgsazoU3dM4I6K0eZvBx2BaVtT3rheZ
	9P8yFjE2akXqVtsFz9lZiWb9IMrPsHxtBtnAHQtIhZKrwBS42cl18WCygD9qv/RhwrykRA==
X-Gm-Gg: AYBFou0g12kB7udQURbBDk9+XLmtkXF/YM7cjhlPELV2vCElQUiXuo168rWx8+nG8sA
	eIIuxHz8QJlRjFlGH8K2cqOQySpXS7O6vbqlEYnj1ZUPyUbsh+lw8oY7mffNfNDGl3rtD/me8Wm
	QoX0pELidneONu1kDlf9iVRkWzTYLz5vWxEShtQrHsiA6eqlkYWsB6SIldryI7QMiFs3Bow2KWZ
	jsWcrDIXIUiC9rhpaZitu1/PJg0jyn5xRgaEOOroEWAKXb7O+usCk84EcI/qbFtPjaQQbzBPCfM
	T3Z2UMheWkjRLEE2hob4qc1L6KmKcI5/hxvzsBVJOBH8i7VfhkHLJO1rX0wMwEfK9X6UO88lvuF
	oCB3jPxVfzdgo7S5K1ZP+ABJBgWe60wnWpFXfiC5Jn8o3/RA+MzrJ7fbyso1pcrWmSaxJUh6nJM
	aFG5j2VMqVRuTZMlMscezfIILUlQ2rHzsPcXKDYoS30RXEB+rHyhdhPT3UQnImxqbhWwUHNRH8D
	oANwDQBBbIm3PU2dIBJe5rX1BZBsSH+LmpfslRmIipHRBNaPlRMoUtqmT/HNe97l3TYeqTAsEQ4
	01HoJSNQeyiQ5II7fIujdoqg7HdL+tmzcA18kyWgZ96bYDQZRqtXepzohLHbd9Q1rrl3rl6GgqQ
	BV9Qja7TTwtv/8id8XBj119Q=
X-Received: by 2002:a17:90b:2cc6:b0:3ac:73c7:9c07 with SMTP id 98e67ed59e1d1-3ae89292da7mr11229213a91.0.1793550676949;
        Sun, 01 Nov 2026 08:31:16 -0800 (PST)
Received: from localhost.localdomain ([113.102.236.131])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3ae6e944ba9sm15038585a91.8.2026.11.01.08.31.12
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Sun, 01 Nov 2026 08:31:16 -0800 (PST)
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
Date: Mon,  2 Nov 2026 00:31:06 +0800
Message-ID: <20261101163107.55037-1-q.h.hack.winter@gmail.com>
X-Mailer: git-send-email 2.54.0
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

