Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=117.135.210.4
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792821026;
	b=yuqsAE2nfkuMhFxysh9UYP2lJIMwqr2j8B273wTmWRk5lGueecd1O333eS6dDFHtJMlf
	 dBAOJnJ2jCpBiL+MAYyM96yCDqaDFrs++CRKYUYWXiAS4zxn/1zMBlMuUqYLgODHj0mJO
	 ZhIPuF+6k2tWJfFGWYUbzmeAjKoDpMcdaGFcDiyv6qZCPfebpf3S/ACoGHNvRsiATNPZz
	 IrLk9lyFal4n6lTwoTMZnwXNKp9b1KRsHAFNrqk5/RsGLrICdwAy8GlRW5Wuiq+xD+vxB
	 E2RU251not/7fMWpjDMIBdkYIpdUMh97gcNZd2ppAlsMPA1qbvxiMrfMvv7ht/Wt6aA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792821026;
	h=DMARC-Filter:DKIM-Signature:Received:From:To:Cc:Subject:Date:
	 Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:X-CM-TRANSID:X-Coremail-Antispam:
	 X-Originating-IP:X-CM-SenderInfo;
	bh=4eeCO3rC80X62fcq/OXH4080ngr+dUvjk6HNy82lOk4=;
	b=1+5AsmKA5dZp3NZk4DB4VYkJVNeu9r+wpAyEiUCeiR3QXyXh3K1olN9zCOrFMHYUScEv
	 H+FKW3z4rm2pxTd0D2VSoKb4xQedNblxdorbPrvKAopqva+7yOq2eMq0KGDAr30ggIkye
	 8lnoJND3N+xnlWUOizJgDL71WViUXXB+k31mNy0Of+/oON92QKmtg2ybGbHZpzT13uSkH
	 IzE088QS3IU1m3wOPXTyBrQRVQfJGGPGduPd39PGjZJFDWy+CG7pHSgpeR4zQVFZFXZ7o
	 0lyQaSEL3KTT2cchH/6C5kSFftsca0giEEqP6J5D8rw2lfpbLgYYX8ungs5yaGGNXGg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=163.com;
	spf=pass smtp.mailfrom=163.com;
	dkim=pass header.d=163.com header.i=@163.com header.a=rsa-sha256 header.s=s110527 header.b="Xf/73uos";
	arc=none smtp.remote-ip=117.135.210.4
Received: from m16.mail.163.com (m16.mail.163.com [117.135.210.4])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0BF3E606A323;
	Sat, 24 Oct 2026 05:50:22 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 0BF3E606A323
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=163.com header.i=@163.com header.a=rsa-sha256 header.s=s110527 header.b=Xf/73uos
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:To:Subject:Date:Message-ID:MIME-Version:
	Content-Type; bh=4eeCO3rC80X62fcq/OXH4080ngr+dUvjk6HNy82lOk4=;
	b=Xf/73uosj8Kq/DH1BxCXNhWCXU3rUmi6dvy+F4UR+//GnUxXRVVkSMOnvSU47J
	ykUxAm7a14ANlDG8oJeRVHtjw5Jo/Ri+cFB+l4Cr08agz3NaFKid0tQoV0nPOvFx
	7RSzvZwRQRb1uEkQbWYsHfoZtNZreI+JHU9jUxAhUv1vk=
Received: from localhost.localdomain (unknown [])
	by gzsmtp4 (Coremail) with SMTP id PygvCgCX95oGR9xqGesABw--.21036S2;
	Sat, 24 Oct 2026 13:50:00 +0800 (CST)
From: Wu Enqiang <janussss@163.com>
To: luzmaximilian@gmail.com
Cc: platform-driver-x86@vger.kernel.org,
	ilpo.jarvinen@linux.intel.com,
	chris@nilk.net,
	Wu Enqiang <janussss@163.com>,
	stable@vger.kernel.org
Subject: [PATCH v2] surface: aggregator: propagate -EPROBE_DEFER from ssam_irq_setup()
Date: Sat, 24 Oct 2026 13:49:21 +0800
Message-ID: <20261024054921.48209-1-janussss@163.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20261003044844.63157-1-janussss@163.com>
References: <20261003044844.63157-1-janussss@163.com>
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:PygvCgCX95oGR9xqGesABw--.21036S2
X-Coremail-Antispam: 1Uf129KBjvJXoWxGF1UuF1fKw4xXF1kAw4xJFb_yoW5urykpa
	95GF43Xr98JF1rGanYgw1xuFWrtw1kArW0gF4kWrnru3s8XryfZryjgFy3W3ZxCrW8XFyY
	vFn5X3W8CFyDAFJanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x0pRHlkcUUUUU=
X-CM-SenderInfo: 5mdq32xvvvqiywtou0bp/xtbC3gmlD2rcRwmk1wAA32

gpiod_get() can fail with -EPROBE_DEFER when the GPIO controller
providing the "ssam_wakeup-int" GPIO has not been probed yet. The
current error path falls back to fwnode_irq_get(), which returns
-EINVAL because this device only declares GPIO resources. The probe
then fails hard and is never retried.

This has been reported across various Surface devices since v6.12,
including the Pro 6 and Pro 9 that were used to reproduce it. With
the SSAM controller down, dependent ACPI devices, e.g. the battery
with its _DEP on the SAN node, are never enumerated and battery
status is missing.

Use gpiod_get_optional() and propagate errors to the caller so that
probing is deferred until the GPIO controller becomes available. Only
when no wakeup GPIO is described at all, fall back to fwnode_irq_get().

Fixes: b27622f13172 ("platform/surface: Add OF support")
Reported-by: Chris Simpson <chris@nilk.net>
Link: https://lore.kernel.org/platform-driver-x86/d0bb21cc-6d3c-4526-8204-2511da51a6ac@nilk.net
Link: https://github.com/linux-surface/linux-surface/issues/2219
Tested-by: Chris Simpson <chris@nilk.net>
Tested-by: Wu Enqiang <janussss@163.com>
Cc: stable@vger.kernel.org
Signed-off-by: Wu Enqiang <janussss@163.com>
---
v2:
 * Per Ilpo's comment, pass any gpiod_get_optional() error on directly
   instead of special-casing -EPROBE_DEFER; keep the fwnode_irq_get()
   fallback only for the "no GPIO described" (NULL) case. Suggested by
   Ilpo Järvinen and matching the variant Chris Simpson tested on a
   Surface Pro 9.
 * Add missing final period (Ilpo Järvinen).
 * Use full name in Signed-off-by (Ilpo Järvinen).
 * Add Reported-by/Tested-by for Chris Simpson, and Fixes:/Cc: stable
   for the v6.12 regression he identified.
 * Note the reports span various Surface devices (linux-surface
   #2219, #1645, #2064, #2039); the Pro 6/Pro 9 are just the ones
   used to reproduce.
 * Tested on a Surface Pro 6: probe no longer fails with the -EINVAL
   "failed to setup IRQ" in dmesg, and battery plus dependent ACPI
   devices are enumerated again.
---
 drivers/platform/surface/aggregator/controller.c | 16 ++++++++++++----
 1 file changed, 12 insertions(+), 4 deletions(-)

diff --git a/drivers/platform/surface/aggregator/controller.c b/drivers/platform/surface/aggregator/controller.c
index 6a8430cb9..8846d22c6 100644
--- a/drivers/platform/surface/aggregator/controller.c
+++ b/drivers/platform/surface/aggregator/controller.c
@@ -2753,12 +2753,20 @@ int ssam_irq_setup(struct ssam_controller *ctrl)
 	 */
 	const int irqf = IRQF_ONESHOT | IRQF_TRIGGER_RISING | IRQF_NO_AUTOEN;
 
-	gpiod = gpiod_get(dev, "ssam_wakeup-int", GPIOD_ASIS);
-	if (IS_ERR(gpiod)) {
-		irq = fwnode_irq_get(dev_fwnode(dev), 0);
-	} else {
+	/*
+	 * Only fall back to the fwnode IRQ if no wakeup GPIO is described
+	 * at all. Any other error, in particular -EPROBE_DEFER while the
+	 * GPIO controller has not been registered yet, must reach the probe.
+	 */
+	gpiod = gpiod_get_optional(dev, "ssam_wakeup-int", GPIOD_ASIS);
+	if (IS_ERR(gpiod))
+		return PTR_ERR(gpiod);
+
+	if (gpiod) {
 		irq = gpiod_to_irq(gpiod);
 		gpiod_put(gpiod);
+	} else {
+		irq = fwnode_irq_get(dev_fwnode(dev), 0);
 	}
 
 	if (irq < 0)
-- 
2.55.0

