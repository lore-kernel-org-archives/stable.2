Received: from mail-pj2-f13.google.com (mail-pj2-f13.google.com [74.125.227.141])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0B2363EF0D7
	for <stable@vger.kernel.org>; Fri, 11 Sep 2026 17:59:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.227.141
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789149552; cv=none; b=OaQrucgB9x0rNfnpyzv5EHz7kLmbN4JGL4AR8Ut2lg298wRdfrcRJd6zgYo5sRyZYRUpVVkhnIn4jVgMcAuJoz7XzfeyfK3kAn19wvsqLZgLpByLqvD0eYBHTczillapwAhIf9QZH7e/TKJOoyxVLrhTwRzcpLicLxxO7pQFZpA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789149552; c=relaxed/simple;
	bh=lzXbJYDkP5Js04N+SIMdbt5b+DDjxqYLyMSiJ6+7GgQ=;
	h=Content-Type:MIME-Version:Subject:From:To:Cc:Date:Message-ID; b=CYCAtFlpAqSeSk4lXPeydNi1BPQyqFJ8IH89nKyU3DiDNucNbjA95DfISXlJ8qQLxULjtEYLgSsUT75GdMfpRnqg2BACwVKIjSlj7uLkTQRbORwxe27k2uSAI85qzwjgAwqOb7Du2mZz/3p3h1a5a8PtVQ98EhN4an8emEq6q3w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=kernelci.org; spf=pass smtp.mailfrom=kernelci.org; dkim=pass (2048-bit key) header.d=kernelci.org header.i=@kernelci.org header.b=QyKdudfv; arc=none smtp.client-ip=74.125.227.141
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=kernelci.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernelci.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernelci.org header.i=@kernelci.org header.b="QyKdudfv"
Received: by mail-pj2-f13.google.com with SMTP id d9443c01a7336-2d90ba1d807so2037385ad.3
        for <stable@vger.kernel.org>; Fri, 11 Sep 2026 10:59:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci.org; s=google; t=1789149550; x=1789754350; darn=vger.kernel.org;
        h=message-id:date:reply-to:cc:to:from:subject
         :content-transfer-encoding:mime-version:content-type:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=/1ShsrqaiW7UZGoWo4E16528ZH4kR/YO+r5D4mbNkrU=;
        b=QyKdudfvuIHgi6c6jTALdFz+noAuKb0Y4tnDcUVIsRKbtp9tvngYncBXVB9/R8FU+r
         CcxplNpCvvCkEPUA1RWwQ/tAzAyN0EL9ajQFxv/8xEAuG4535b8hcDHbgggSPaA0aDap
         G1RwrkCIEru3QLNYW9ucGYasrgyGXTwmBpBlRSogWGTNz7GE+FS+nlaOJzlWB4pEcJff
         EJY7hHYENQJIyUI+tiZcxM9S7q03BkEy/CCApgTw153vHbtCyMFlLZFomGLOC509sI51
         LAlN6x7mp2BjF/Wa4F+5zu4crfMmciaWXFrOdw/mW8Kjj59AFuK03Sih0yah+fLdsZ7J
         jFxA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1789149550; x=1789754350;
        h=message-id:date:reply-to:cc:to:from:subject
         :content-transfer-encoding:mime-version:content-type:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=/1ShsrqaiW7UZGoWo4E16528ZH4kR/YO+r5D4mbNkrU=;
        b=T9xSEqQa0+nlX7nYW1Pbx9ZJuozlgwz3S1XKbsHUeKcyBx4nUjsC3axd4G/Z2VN19u
         hBU3bd9erOvin1qmkZiTQSj118+ominndZUSJ06j5jmYA/mDPhX5Bvs1kzOIFxfkbqry
         5Lia35Al7KNWzX15RqBXxO9cks3hBsq6xUDCrMj5MHXpBgryw4EtJtV4Edu+RStcn8YN
         NbSMIjyXISL9B7nM4oKHIXvjjcmbGHyUu/TSWVaNzsvwiLJdT0AMEPA36CZ7BbuDh9ON
         ryKw00L4vwr/2qSHY+CI2zaF+xbh97TIFGW8/CGsNiGzsTJ49d2oOQBFyrhs8zKDE6BN
         dVVw==
X-Gm-Message-State: AFuF++kKkcU2giYBu6zr5M+97NqfsmHZBJE1gPnKEDwof4UpRwrbTl7k
	L8AOPZkRj6fTBKVXwxlTF7xGcl/ul5pqJrPBJ7/S3IFwn3XAOHVM6hhmYlYq3aBBio4=
X-Gm-Gg: AYBFou37hl4vxE+dyq1W3JXsqnksRnEAYwJRBNTx1OUcAhAXl6SSp7b0FWr8J9GAPZ5
	Hkf86INUjEjbi8B8FjUKQuk8mFxMW5Vz5hrcJgAjOXYebT2wg718rb9qRBc8Xx82BeZJL8l8zWk
	znmhqLX1lz5H3MiJZcpulLXmWCDozBcoBezdm2yi+vFhVxBkbU78N9AWCBjMHSbcOTTaECIZtYk
	rfuVaq6GTRIA4U7+j+SeNARh2cReLDGpGq8OAv0cRgFRQqqh5L55oJFqpZQWQ3HyQ+vOArkY7Wd
	vN2z0DoKzsUL//5BcCBbZUHcdGjfufuZ0X8bQKWiuogcpW/H63IZl1aE0fWZrKxZuvDNr0cZwzi
	NxoMKjF3X2D7UBhP6FXHiQHioo8oqILqYIQJaV1cNGDGcAULdUFYW3PMU9D3SrG3YFUxczWLY+g
	GW/gdKpNURAPbiyokiEmabk0a7Eax1w9D018iic99C0LrzU6fc7rdzbX5Slyhvgk4=
X-Received: by 2002:a17:903:2451:b0:2db:7269:38ef with SMTP id d9443c01a7336-2dd2a3362camr95238155ad.14.1789149550278;
        Fri, 11 Sep 2026 10:59:10 -0700 (PDT)
Received: from 41049dfc76e5 ([20.38.40.137])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-33bac1c716csm6667723eec.2.2026.09.11.10.59.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 11 Sep 2026 10:59:09 -0700 (PDT)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Subject: [REGRESSION] stable-rc/linux-6.6.y: (build)undefined reference to
 `irq_domain_alloc_generic_chips' in kernel/i...
From: KernelCI bot <bot@kernelci.org>
To: kernelci-results@groups.io
Cc: stable@vger.kernel.org
Reply-To: kernelci@lists.linux.dev
Date: Fri, 11 Sep 2026 17:59:09 -0000
Message-ID: <178914954912.4461.15612519535901309681@kernelci.org>

New build issue found on stable-rc/linux-6.6.y:

---
undefined reference to `irq_domain_alloc_generic_chips' in kernel/irq/irqdomain (kernel/irq/irqdomain.c) [logspec:kbuild,kbuild.compiler.linker_error]
---

Log excerpt:
=====================================================
powerpc64le-linux-gnu-ld: kernel/irq/irqdomain.o: in function `irq_domain_instantiate':
irqdomain.c:(.text+0x1748): undefined reference to `irq_domain_alloc_generic_chips'
powerpc64le-linux-gnu-ld: irqdomain.c:(.text+0x17c0): undefined reference to `irq_domain_remove_generic_chips'

=====================================================

When fixing this issue, please attribute this report according to the
patch submission rules:

Reported-by: kernelci.org bot <bot@kernelci.org>

For complete logs and details about the environment used, see the issue
on the KernelCI dashboard:

- dashboard: https://d.kernelci.org/i/maestro:831dfb93f8bd5de8edffac3306ace19b7838c782
- giturl: https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git
- commit HEAD:  c33bbcf64a1d0e2170b7cdee977e2c00e258a70f

# Builds where the incident occurred:

## ppc64le_defconfig on (powerpc):
- compiler: gcc-14
- config: None
- dashboard: https://d.kernelci.org/build/maestro:6aa40c7e20239ade9022a05c

#kernelci issue maestro:831dfb93f8bd5de8edffac3306ace19b7838c782

--
This is an experimental report format. Please send feedback in!
Talk to us at kernelci@lists.linux.dev

Made with love by the KernelCI team - https://kernelci.org
