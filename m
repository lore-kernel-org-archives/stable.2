Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.215.173
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793776972;
	b=1UIU8oBK6vMRdK2ZKOLALU2D7aGdbxWeW5zf3dawF8ifLAqf9orr5Y3rx6aa8xfp9g8f
	 hcwJPGGg1qqMhCh4XrfdnYHxqIe5obDFqvqAWvX4qJteAHo1e/zQeS/fZs5A4fp/vr1Ja
	 ic1NFzgGorq61EAi6Mjx6O/IQ6/t9k3AEh6N2hnlLkYD90KJ2wzl4vDID/lYrKzsDy+Yt
	 UEPebOjjIhd4z/XQiqoZ7RcJPKML7MUzWN+g/OXOWDzD4cyQuE0QoVTQDxWQGDNifu6Mi
	 XHlKoQbQwMdj18pSjPwF77RRxKc+6v3JPIOVXW3/dsAYHgNMtxfgipzwyUDLZ6I3vLQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793776972;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-Id:X-Mailer:MIME-Version:
	 Content-Transfer-Encoding;
	bh=amOqrW7TRxDYFxl6iI/KQH4BpM0KC+sLlSW8sb3QrDE=;
	b=w05tR9HdccsE25S/dfSoedMILueSh9biSeEUacplzAPWcvhygKKazvt1Cu6ws7g42Tti
	 rI7JVvdcKGnxjy3O95JfHwILl5WOdtMWJgLXKu+32cSVLpX5+KcBCFfzjo07/RDszh4Pv
	 ehIdfJ9qfKK5gi/5PO3XaT8X3HA1WKyC3QSbOhl+z5s7gIIMdjwQdK9dko46syBn+Jhpd
	 o0KfCzVaUrTvVs/6Djx5MuutTJVz8UvXvPr9XNiWgz+8hTkHwVmfZt+Z30mLXMvWS2Jgh
	 ZGhecQ1q7wn/+GyIFk+CmX+0rqpNxv+xgcq5qidT/mnXHUtYc+q6gdaNcSKDPwd43vw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=RLmrkDR0;
	arc=none smtp.remote-ip=209.85.215.173
Received: from mail-pg1-f173.google.com (mail-pg1-f173.google.com [209.85.215.173])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F293A606D807
	for <stable@vger.kernel.org>; Wed,  4 Nov 2026 07:22:51 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org F293A606D807
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=RLmrkDR0
Received: by mail-pg1-f173.google.com with SMTP id 41be03b00d2f7-cdb0c80318cso14616a12.0
        for <stable@vger.kernel.org>; Tue, 03 Nov 2026 23:22:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793776971; x=1794381771; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=amOqrW7TRxDYFxl6iI/KQH4BpM0KC+sLlSW8sb3QrDE=;
        b=RLmrkDR0Ynhfh+WtVHs5vtNl6CjEpV7pPIBN45/FMMsf2sBvXthqPEf4kGKnjdK+6V
         UVUk3vPn8N/bpo9zHuCtl4KowsVhMJ8kmokKUrw54A+0nNUgQA5URNTEolPEWtunN9ie
         bDKw7nfWijHkPlXzxoA1Qg3m7GwNBa0jGO7JiwfVc//xWCPy/UnNlYu5GcUgflDrLKPz
         pVy55rR2xij7EvTu85R0jbSdxoD2StNOjjjxtyXHmExumbSccnCsx4o6HaY0Go1SFBOP
         tJCrVH9MY1aC4atPZ1mJ66BYtwIDrYMS38UEVq35alAhFrT7Zcq4zaQ/VV9qj+493E1J
         qrwA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793776971; x=1794381771;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=amOqrW7TRxDYFxl6iI/KQH4BpM0KC+sLlSW8sb3QrDE=;
        b=k8lV5dNfKuXHgd0G8VaNo2x4jgJFEk4PQTsMOjPp/14IMhiZRLh9Y3/+u4kU7V7EyT
         GnRr5Cq40hfCOHTzf4RgsE127NaUwJ3x4dGisVB4lMPC34lcf9GG7E7nmXqt4eV5T+T0
         Zi5nS1uBCtTW0oJz6umoufPnDQ+cBmaQykPm+tq5cKB9D6f9SkNQLBP8UkJZfbw9LkUw
         BC8f/kzUu7RM6dBXrksLGBjqxwCKlfRvvTDJeEEZDhZNT7nWwFXONFxh7vKQsFdYOoA5
         uMs4/UJgH9kjcLYYYkK0ozkwEdzB9l6vu1hmh24ID7NcT5vixY0lgFsgUSCfI9SmVUVD
         IgkQ==
X-Forwarded-Encrypted: i=1; AKwUvBw9mT2yzDKcyR1vrh//Luvlj+Wto6EeaOtf8l7AOWJoptl/NdFT4qxIqrvMasj94CViCU1xxFw=@vger.kernel.org
X-Gm-Message-State: APuU4Z9qgphmiUfxv5kKYxT9Iglxdh/YjLJb3qY+UOAmtH2NGQQq2OXF
	j/jbZ1ExvrTYL+fIKf2RGGEerFqH33fxn/B1vDzJ4d2l+JLYI3LVgpPN
X-Gm-Gg: AYBFou2NEyOElzcu42krJXmJjy3z+IgbqMsFsJ3gj1WCcQolMh3Lvas8zNqRY8wVHF7
	HRbCWFcvTMLzCwagc1skZc2jRxRxB51YOEfsHDKQLPpww5qrykQILuBDPDxjOja0YJEdS9y9r+G
	GKHN6cngWvjPxD2A83Kh4u8XvaMG7HmusWyQzPrPpUkpGnIiURn/aep3/5OBbGjPCogXpik+7vi
	nWzJsBFdjDlyVIQpC8Dt5AChH3f8GCWBx88ZYyWGrAI3bSEEoquWhvb+3c69V95dobGXPauG2oK
	TYdOYrlS/tfFP9jG/e+T95KWC6iJ+hChYG0meijwZaA61PwWhbYf/2TkLeveV//REixQHKCTmE9
	PbgSxdvbv+sTeO+xlL8v6Wz+oGvPw3bbZsmCijLnu7hj9Wz9fgzRqODvTT9oTIL26JIWjGOxTBw
	M7siuRoslKpIskURw+5+S5FEgkDxgeGLfLvWuDmO0BJ6M7HHq2hnVcyAoYC/J4+OK6yYLNi8R1a
	fEedVaNWdZPK1cJD/VQbFvyM6Q5qk5/c6NadC0cR5gYtXDtVyM+FNsX5frZvmrNO2Ufkv8Vn9lI
	i+PEvawnTMG87Un7KU/SzoJ3nYEh2Q2CApcmcjcd4w==
X-Received: by 2002:a05:6a21:f107:b0:3e2:1823:2b39 with SMTP id adf61e73a8af0-3e9288c9c22mr18484635637.2.1793776971244;
        Tue, 03 Nov 2026 23:22:51 -0800 (PST)
Received: from CRASHEDROM.localdomain ([142.249.36.161])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-8b097fe109fsm533533b3a.8.2026.11.03.23.22.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 03 Nov 2026 23:22:50 -0800 (PST)
From: Chengyu Liu <lui2012qwq@gmail.com>
To: joro@8bytes.org
Cc: suravee.suthikulpanit@amd.com,
	vasant.hegde@amd.com,
	iommu@lists.linux.dev,
	Chengyu Liu <lui2012qwq@gmail.com>,
	stable@vger.kernel.org
Subject: [PATCH] iommu/amd: do not remove the shared IRQ domain on intcapxt failure
Date: Wed,  4 Nov 2026 15:22:41 +0800
Message-Id: <20261104072241.1617661-1-lui2012qwq@gmail.com>
X-Mailer: git-send-email 2.25.1
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

iommu_get_irqdomain() lazily creates a single irq domain and caches
it in the global iommu_irqdomain, shared by all IOMMUs.  Both
failure branches of __iommu_setup_intcapxt() call
irq_domain_remove() on it, which frees the domain, but the global
pointer is never cleared and keeps handing out the freed domain.

The failure does not prevent reuse: register_syscore() runs in the
IOMMU_ENABLED init state, one state before
amd_iommu_enable_interrupts() runs in IOMMU_PCI_INIT, and the error
paths never unregister it.  On resume, amd_iommu_resume() re-runs
amd_iommu_enable_interrupts(); for an IOMMU whose setup failed,
int_enabled was never set, so __iommu_setup_intcapxt() runs again,
gets the freed domain from iommu_get_irqdomain() and passes it to
irq_domain_alloc_irqs().

The shared domain also makes a single failure affect the healthy
IOMMUs: if IOMMU#0 set up fine and IOMMU#1's setup fails, the remove
frees a domain that still has IOMMU#0's irqs mapped, tripping the
WARN_ON(!radix_tree_empty) in irq_domain_remove().

Keep the domain alive on failure; a later attempt (including the
resume path) reuses the cached domain.  The request_threaded_irq()
failure branch still backs out the allocated irq via
irq_domain_free_irqs().

Found by static analysis.

Fixes: d1adcfbb520c ("iommu/amd: Fix IOMMU interrupt generation in X2APIC mode")
Cc: stable@vger.kernel.org
Signed-off-by: Chengyu Liu <lui2012qwq@gmail.com>
---
 drivers/iommu/amd/init.c | 12 ++++++++----
 1 file changed, 8 insertions(+), 4 deletions(-)

diff --git a/drivers/iommu/amd/init.c b/drivers/iommu/amd/init.c
index 8a410d4aa3..78b11b04dd 100644
--- a/drivers/iommu/amd/init.c
+++ b/drivers/iommu/amd/init.c
@@ -2522,6 +2522,13 @@ static int __iommu_setup_intcapxt(struct amd_iommu *iommu, const char *devname,
 	int irq, ret;
 	int node = dev_to_node(&iommu->dev->dev);
 
+	/*
+	 * The IRQ domain is a cached singleton shared by all IOMMUs; a
+	 * setup failure must not remove it, otherwise the global
+	 * iommu_irqdomain is left dangling (and a shared domain could be
+	 * freed while still mapped by another IOMMU).  Leave it in place
+	 * so a later retry (e.g. resume) can use it.
+	 */
 	domain = iommu_get_irqdomain();
 	if (!domain)
 		return -ENXIO;
@@ -2532,16 +2539,13 @@ static int __iommu_setup_intcapxt(struct amd_iommu *iommu, const char *devname,
 	info.hwirq = hwirq;
 
 	irq = irq_domain_alloc_irqs(domain, 1, node, &info);
-	if (irq < 0) {
-		irq_domain_remove(domain);
+	if (irq < 0)
 		return irq;
-	}
 
 	ret = request_threaded_irq(irq, NULL, thread_fn, IRQF_ONESHOT, devname,
 				   iommu);
 	if (ret) {
 		irq_domain_free_irqs(irq, 1);
-		irq_domain_remove(domain);
 		return ret;
 	}
 
-- 
2.25.1

