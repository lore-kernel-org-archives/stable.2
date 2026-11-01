Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.216.41
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793550793;
	b=qTsCMCzSRueMkFD2IQMwESfY20YI3h6AvZNia600x6vcslHshDUUEeAKFRwntW5biGAp
	 lJU9ZmlNHQXh+maVq46IzHkpDgFNoOaM/m9G1bBugpJr5UKVJJsVAFb9fNvt3pRBtjAXs
	 blLeMSki66gmz141oOR6ZwwCXwOq4759b66sG9iaye1IHqkK6+LAvyqChonuPbDEjK15y
	 xGu2doo81QfnTjKfvvFmEBHQn0HpbA9MJ1S5HOJSqEOb1ZXbEamNcqEIyQ/Xj6zyjnzOG
	 Ruwcfh+ZMUBpbXYRiJGFcmcYxn3+vMldLSMOWTyYQp1tgzDmy2xrfNysd++nPpoFnQA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793550793;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:MIME-Version:
	 Content-Transfer-Encoding;
	bh=z1wgGnLaHoKZu2/+Ud078CAK3gozxrFVUFtZdHR2t7Q=;
	b=u9/jttJy0nR0gQSUGWjFBy/JXPE0/1kaKvUg2EPN/SAjPoF38mCXlBnLS0oI4tgPptO3
	 HSMdLxe1NCahqRAo5EOkR1crMT2AcLNOiCEegcw7172CjSOfm8MBg8hx7skpEEAJV5nP9
	 IrRq1LbtrEsq21jcQMV2iRdtZ2Na4UwgLN3coDUSmf1rWTYDjNgmVqapqInHs22uNhzXu
	 GyafbSePWqnbPyxW1/tRd+Ht44v16JYOcNQaSvqkI6cQVwgsmbbeXdQBmhfqs+NgCkjUw
	 cwtpOfTrJKw2OPJc4rtQ2r3sMTLWIBVtArYYf9Vl6ZjalFKPgZoLNh3Pdyvdba/w8Cg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=i+MmRGdI;
	arc=none smtp.remote-ip=209.85.216.41
Received: from mail-pj1-f41.google.com (mail-pj1-f41.google.com [209.85.216.41])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 77636606A325
	for <stable@vger.kernel.org>; Sun,  1 Nov 2026 16:33:13 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 77636606A325
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=i+MmRGdI
Received: by mail-pj1-f41.google.com with SMTP id 98e67ed59e1d1-3ac6008c914so292656a91.3
        for <stable@vger.kernel.org>; Sun, 01 Nov 2026 08:33:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793550792; x=1794155592; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=z1wgGnLaHoKZu2/+Ud078CAK3gozxrFVUFtZdHR2t7Q=;
        b=i+MmRGdIPHvaRXB6Fj5arp1lNW1XvIIeAqBKs39M6I8fVaRMTNTti9f8p04KTbn2XG
         gbDrcBvUa4PwHLtFllbkEw7Lv3nKjpseY45dmaOaWamcTIPECpieM203pt0MX3DPu6wL
         0Ko55HWdibTQBzFsD5RjIN0rN13+B0e1jnKQgPTWpX9ruwkSZ9SuomHRJeFnowbRAfWE
         eDl/9ndwfg2OVwP2o3kPLE7ThVvlsVMAUtT6Uyrk70DkfjRxq/8lnslsaOXH+5GzyIeM
         QqogZYk1vFXPM6tzNa0oBql/6pITmvdDOy5OEq9VQPlgR2eyb9pL3u/4CS7YYAXr9Rvj
         sssw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793550792; x=1794155592;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=z1wgGnLaHoKZu2/+Ud078CAK3gozxrFVUFtZdHR2t7Q=;
        b=SAwRzUm2CoYFnEcS202d4cgQKjf8xzIhvWhddCwgd3a1i0ICwq5KD5hQe+KzkOvdkn
         JNSoHk+L8X/qjfuxY3vCR9ucX2xaqdHt+jQlZk3iwutZ3P+sxs7/5mUc5xcCZafv4Laq
         1ulztfrwVOUV/2EE3ySziCvBq1qaxlA3EQP/TVtI9O6wlH/NRXY4GOVzbHEK4+/mJ2BD
         WsCyExN5v2ptubqU3eYJQc5jhHEUpjcPaC2xKAR/nfDaqotr5I3L1CGu9sRKiPukR/VK
         OvOTluWuD7p6O+JyTerSTPUdpSzeowsMGo8RNanFuZlaq7hjhP4FIp/H9Jlol/jPTrDU
         ptzw==
X-Forwarded-Encrypted: i=1; AKwUvBxp9kqhPLdJqzOfyAMon7+kdQZ3qq+RYsYiBkVe/jPpS79Uv9wC9KtArO4HY43Ty9hKQ1HejXA=@vger.kernel.org
X-Gm-Message-State: APuU4Z8zJ/wkV/FOsWeuY2m2SefolbwBjy+0D/+4MVnRSRr008RTT4Iu
	eMieEtbR3jV5kXWKvjIXZUcdxxNOj6L6w9EYcikFtq8HCzyip3ISDObPUrHFThTiU6qAdw==
X-Gm-Gg: AYBFou2Bb4emW7iLu6yZOOqNXFq1J0MNmR/feXfa9bAZOaYi68EKLenFjxKww5m1/aa
	NOVuo2UCvYz47+GpnHJlj09zcgCN/OGXyzF2Y6zyGZ6a/hOTJLcMr3X6ck3p8bpZ1anmHhNqCfy
	VvPK5/YI3zJPTXujVuRz9Z231A5SUIUKSF67utWS+zk8aWSiSSz9S095aoGDEtaKBfXl6hUIvRL
	TONX1sJ5eGueUE/sOBVolqG+wuD0u26hVfJc6GZ3NcSSlLVGV9LNvB67QRr58SjIvaYauCGuWra
	aP48lQ6/wQSFPymvGRn99VjPpRIApR56+ZhpQQaA+QmZRGDqeSylEU1lQ8GHPkvmVO+PG+UjljK
	FHLRrp6rNN1MY7jVNoqzZqLGqw9DdgbPu1pE7yf/qz3WmI3qBdXSQ6qA8wknoyZU2Axf7ROQKeg
	crQl46hrtBCpxFvddQSAhOglwXXY0yxpT13aOZhdiUmWwoVl7XoPFh94sC8BgDg4l7SvjThj/0h
	oQJ+uQfxzWAN4DunFidf+gbPaWDt8z8NfiEA5iCBJfxdX1wnXBK5YN0Dh1hJbwv244pxOyN1+NJ
	JZ+9JDPiFhmLPlSwJ9oJtvs6TxavafR9rLEyJyCt1HRYpEZ4MM0LY4PeymiNiZOJxO7wz+WodJ3
	JPEI2FCgU6zen5lvts71dp4s=
X-Received: by 2002:a17:90b:1808:b0:3ab:a188:b898 with SMTP id 98e67ed59e1d1-3ae895f8623mr10840887a91.2.1793550792550;
        Sun, 01 Nov 2026 08:33:12 -0800 (PST)
Received: from localhost.localdomain ([113.102.236.131])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-cdb0981c5desm2063394a12.27.2026.11.01.08.33.06
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Sun, 01 Nov 2026 08:33:11 -0800 (PST)
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
Date: Mon,  2 Nov 2026 00:32:50 +0800
Message-ID: <20261101163251.55099-1-q.h.hack.winter@gmail.com>
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

