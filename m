Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=170.10.129.124
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794967529;
	b=Tif0pk6GnSem+pZZIYar7CK2OL33zzD65BS8QcZ744ba/c1j241sb88hdNfmVXB2C3Qi
	 V/OdSD/OvtSSzl41tsp2gd5SFk1PGnTHDt3q+yzldvEpNai/GIfLvPa/AV4zQkcj4sT9Z
	 Eibqpmi2C7LM1YOYWYICqJ4c7kGlvAeUNE8NLEE3E+TjSUHCK/SpvOk8SWmrMqWmER3uj
	 ZXuJjnmsvjnatp51AbRSxYzTtrPLyodow634teCLpLaccc1waD+ivYIetMcQst9Whj9lp
	 SRYmETMwip25CqFnOwhUcOkQqqigLDnNJetw+JUYlvs67ilQ1Vylb7QclVAqhGT9vpw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794967529;
	h=DMARC-Filter:DKIM-Signature:Received:X-MC-Unique:
	 X-Mimecast-MFC-AGG-ID:Received:Received:From:To:Cc:Subject:Date:
	 Message-ID:In-Reply-To:References:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:X-Scanned-By;
	bh=4O5XL7aJVwLHpgDccyPc1QqbFzWKWd/mmOUKGrKAQ+s=;
	b=z211mCW3HmiyNWIF+b39N15lWo3Ql9rwWXXL1RatbowyKC8+RM6oE1S9V4nFZ0UuTqjA
	 HM0ISEHhU6sRCXcCiGVsYR4gtGnwNmxPUxTp/X3yVEq4NCPWES6cS8gNbe/k+QIQwICJ6
	 PfwmxcK4lW84bSi227UFPf9Tkf+XVpu3tOfSWAaI1px/AhxabU8mm97vxILzHVNRp1Yov
	 Qj+7EkUDxwQY1Tt1S/u0mDs11bXrDcd7HoPj44Odk/P9ytBAIEFCNIbrn2LyAy60/PQ+j
	 SsJGxeaf2A2zMv79nWgrJrTYmnx1qMv8N6YAYqPmENIYPU6GYcNzURgyKSWfv7WS8Pg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=redhat.com;
	spf=pass smtp.mailfrom=redhat.com;
	dkim=pass header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=a7xJRvcD;
	arc=none smtp.remote-ip=170.10.129.124
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4DDDB606A325
	for <stable@vger.kernel.org>; Wed, 18 Nov 2026 02:05:27 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 4DDDB606A325
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=a7xJRvcD
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1794967528;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=4O5XL7aJVwLHpgDccyPc1QqbFzWKWd/mmOUKGrKAQ+s=;
	b=a7xJRvcDqErqtc8ITEYqffEgn2A/k6xcGlMzFbHlA2Wn8ZKp522A1wQmOf5Kl2WoII+sU3
	tIv/UEJ9KBNIitSxOOMBeXTgToROtwxCRMBVvm6yD23BLMBWA5v7hvomBjvXq5TwVap8oj
	/kI/t6io0DlN935P8XorUPJj70+suHM=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-67-Ma6OkOd_Oj6IOlnh7663VQ-1; Wed,
 18 Nov 2026 02:05:23 +0000
X-MC-Unique: Ma6OkOd_Oj6IOlnh7663VQ-1
X-Mimecast-MFC-AGG-ID: Ma6OkOd_Oj6IOlnh7663VQ_1794967522
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id F196D19560BB;
	Wed, 18 Nov 2026 02:05:21 +0000 (UTC)
Received: from cmirabil-thinkpadt14gen6.rmtusma.csb (headnet04.pony-001.prod.iad2.dc.redhat.com [10.2.32.116])
	by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 260443000223;
	Wed, 18 Nov 2026 02:05:20 +0000 (UTC)
From: Charles Mirabile <cmirabil@redhat.com>
To: sashal@kernel.org
Cc: cmirabil@redhat.com,
	pjw@kernel.org,
	radu@rendec.net,
	samuel.holland@sifive.com,
	stable-commits@vger.kernel.org,
	stable@vger.kernel.org,
	tglx@kernel.org,
	Pengpeng Hou <hppiscas@163.com>
Subject: [PATCH] irqchip/sifive-plic: Avoid signed shift in interrupt enable mask
Date: Tue, 17 Nov 2026 21:04:45 -0500
Message-ID: <20261118020449.1810623-1-cmirabil@redhat.com>
In-Reply-To: <2026-11-17-1-daily-reply-0007@kernel.org>
References: <2026-11-17-1-daily-reply-0007@kernel.org>
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
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4

Hi—

On Tue, Nov 17, 2026 at 07:23:02PM -0500, Sasha Levin wrote:
> > This patch makes substantial changes to the driver and how it
> > processes interrupts. I am not sure it is a great candidate for
> > stable.
> 
> Agreed. I dropped it, and the BIT() fix that needed it, from the 6.18, 6.12,
> 6.6 and 6.1 queues. The same applies to your notices for the other three trees.
> 
> Could you send git-am-able BIT()-only backports of 0f214e5bbee5
> ("irqchip/sifive-plic: Avoid signed shift in interrupt enable mask"), one per
> tree ([PATCH 6.18.y] through [PATCH 6.1.y])? I'll queue them. 7.3 already has
> the cache patch in its base release, so it keeps the original fix.

The following (below the scissors) can be am'd on top of all of the trees.
I am not sure exactly what format is desirable for a stable commit, but I
did add the upstream commit hash and my SoB.

> 
> -- 
> Thanks,
> Sasha

Best—Charlie

-- >8 --
commit 9ebdbab003ec949b3739f548f527c18b811d6568
Author: Pengpeng Hou <hppiscas@163.com>
Date: Sun, 20 Sep 2026 21:06:53 +0800

[Upstream commit 0f214e5bbee59d5952d3c061fd65ed9a1e175981]

__plic_toggle() builds a 32-bit interrupt enable mask using a signed
integer literal. A valid interrupt selecting bit 31 evaluates 1 << 31,
which shifts a signed int into its sign bit.

Use BIT(), matching the equivalent mask construction in plic_irq_eoi().
The resulting mask remains representable in u32 on both RV32 and RV64.

The issue was found by our static-analysis tool.

Fixes: 8237f8bc4f6e ("irqchip: add a SiFive PLIC driver")
Signed-off-by: Pengpeng Hou <hppiscas@163.com>
Signed-off-by: Thomas Gleixner <tglx@kernel.org>
Assisted-by: gpt 5
Link: https://patch.msgid.link/caplitmus-rv.v2.plic.87a8fc444de44e109889ba28703c76f3@163.com
Signed-off-by: Charles Mirabile <cmirabil@redhat.com>
---
 drivers/irqchip/irq-sifive-plic.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/irqchip/irq-sifive-plic.c b/drivers/irqchip/irq-sifive-plic.c
index ca70641982ed6..0995e1fdd5b47 100644
--- a/drivers/irqchip/irq-sifive-plic.c
+++ b/drivers/irqchip/irq-sifive-plic.c
@@ -97,7 +97,7 @@ static int plic_irq_set_type(struct irq_data *d, unsigned int type);
 static void __plic_toggle(void __iomem *enable_base, int hwirq, int enable)
 {
 	u32 __iomem *reg = enable_base + (hwirq / 32) * sizeof(u32);
-	u32 hwirq_mask = 1 << (hwirq % 32);
+	u32 hwirq_mask = BIT(hwirq % 32);
 
 	if (enable)
 		writel(readl(reg) | hwirq_mask, reg);
-- 
2.56.0


