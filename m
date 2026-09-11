Received: from mail-pg1-f178.google.com (mail-pg1-f178.google.com [209.85.215.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 29B4149F123
	for <stable@vger.kernel.org>; Fri, 11 Sep 2026 16:59:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789145964; cv=none; b=uQsJ994hL62RIlw7sQMcLsJhSQzs9oT3hBZ3WpiHgR9MzO76EJ5xr6qjZ2Uk3e17qOaiiB7Y+zS+ghHo5yUBo/ORHT71EDe5EtlLOtuU78fd+/fES0pmobQq5ktUVXy2vyD9QSZyHMj8wcjjl18MAb7wKCVKwZ1LhSgo05+yQu4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789145964; c=relaxed/simple;
	bh=mbkTi6O8Ww+y+r0RQUx/mpGHHMGWybmdBeY0BKt+6aY=;
	h=Content-Type:MIME-Version:Subject:From:To:Cc:Date:Message-ID; b=Udp7Dc0xF003lGmcR13rv+OyV5rre/woKJCtCjtec+khxuSuNIFqAil5L1uMy6wOAN6sNOMjgs8YpStMhIVxqtlkRYrO0BX4H/Ji37+ibWezTR03I/2Xoy8hXm5jpnwvJc/Z8RphYhJas8Go9bld64zsA0gUZh4adqX+/4vPguw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=kernelci.org; spf=pass smtp.mailfrom=kernelci.org; dkim=pass (2048-bit key) header.d=kernelci.org header.i=@kernelci.org header.b=WewQ06De; arc=none smtp.client-ip=209.85.215.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=kernelci.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernelci.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernelci.org header.i=@kernelci.org header.b="WewQ06De"
Received: by mail-pg1-f178.google.com with SMTP id 41be03b00d2f7-cc4c02ddd62so972024a12.0
        for <stable@vger.kernel.org>; Fri, 11 Sep 2026 09:59:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci.org; s=google; t=1789145952; x=1789750752; darn=vger.kernel.org;
        h=message-id:date:reply-to:cc:to:from:subject
         :content-transfer-encoding:mime-version:content-type:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=sLVb4cW3xoeEGa6R5hI5x1BI3sRaprmULVC1Bf1KrPE=;
        b=WewQ06DeTEVykExbnpOpDA1ujFt8m0BrmFdHptRSTpOnSZI5YJ3SfVlEZtu+gAiDD/
         pz+q+nR7KGWaXJyT8J73LIErdytODPwP6JnzOkF8h7JAPaFdU99+1HJAiWhpelrmCxmB
         C90BTPiV1iwaTCHT23fkJHND9gxG+884mp7qsKeaKv1JcX3HhlTdb05TSI5a2cUFcph0
         rUG0R3KYjQDuUNCmzZc69ABEFor2v4DcdP3/RAii8beIyIuSO6E//4vRB3y3VFKGyTlm
         Bokxs0w+ciqHjpsj96BmEXHX/uRBBDtnXIEIxlgiPtQjK00Ra+7tT3v6HKUaNSlXevdW
         +98Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1789145952; x=1789750752;
        h=message-id:date:reply-to:cc:to:from:subject
         :content-transfer-encoding:mime-version:content-type:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=sLVb4cW3xoeEGa6R5hI5x1BI3sRaprmULVC1Bf1KrPE=;
        b=dG1zarZGZi+l4liZfVAopsqHv0DLfDRc37rMceXCFD/x8yNeygTIDoreAM94GhaDq1
         Dgb0f58ltDd7t9fYxzVIAhsy7MMPRPhAAB9LOc72cIe0I6/Zg9qI0+HbI7O6qe3fykhN
         IQa1WxOwg1dzUeW1aw9Dl29QVL8qqLOwCykSR3LKJ4tJy+txOVA3WS82YEJPz+Tz70Pp
         LrG6fXDizGjz6TZxzwh1/zJuowIZcyQk5f8z5f9gTnNprvOR4SY+MZsZZrWLeEZvOx/r
         s1C0nqLcF/TzYp6Gg9nyzVAig8Rl5PCqoMrLnEh6fDwOteYuOHOAUdzlZxchw30SiN1e
         2rQg==
X-Gm-Message-State: AFuF++mdykaZEUOeblm8bPdXK+4KE2iSH7QsuXw24cZBnwEcr76JUKjP
	3Mg4TtbF76/BHEU/p5cv/B2v0vG6/gibasFNzQK7Vpnn0I1VvgFUd05Lji4cH4FcisrCeG8e6Fc
	+BVhs
X-Gm-Gg: AYBFou1dy5B8XOa+4QELiCEhlY3yswgTXHrlcEtbDXjSFT0H1GYs1pMWlTW8Q6RfELS
	0ERhfJne4OtNIfzzpZpGbooUtqF6daWY4HvHA10qZMkBsSjyTPh2i5r+eOJLF8qSUSrVG2ybxWe
	pWPNZuYcftoat3XAJ5fj+G+ooKHfUI4EmkjZV4B0PmGL0MHTMFZGU/U6j6LG8RAnegqadootE1W
	YZin27fbj1KlPdjKRfRTRJ0+6HY2BImvsXmcKa1PP0EgdQAGQCvtWZyn2TdxFjNrxht8Mag8a4g
	4fE9kKKjXuMxpmeugVF1Ta2izqiL92Kb5HGYDbVutRinlatttNr2F3HK5fjtvXXpyuqMH95yd1J
	2KO3+tt8wOCiZdOA3xWfPur1ztt4BTMKd6RbPTbgPQST0mX3xfw2xsaSCmbIHdTXL3BYUW8Manu
	WQy0a9tfahtRRzPVvSLBND5I4xTXut168SJOJfXOQ5Yn1Bp7Munk1OO4j7jX+J+Ew=
X-Received: by 2002:a05:6a20:a123:b0:3da:b089:dbaa with SMTP id adf61e73a8af0-3daed46af97mr9546050637.6.1789145950811;
        Fri, 11 Sep 2026 09:59:10 -0700 (PDT)
Received: from 41049dfc76e5 ([20.38.40.137])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-33ba4f82c69sm8420421eec.27.2026.09.11.09.59.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 11 Sep 2026 09:59:10 -0700 (PDT)
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
Date: Fri, 11 Sep 2026 16:59:10 -0000
Message-ID: <178914594999.4423.3321312755347005607@kernelci.org>

New build issue found on stable-rc/linux-6.6.y:

---
undefined reference to `irq_domain_alloc_generic_chips' in kernel/irq/irqdomain (kernel/irq/irqdomain.c) [logspec:kbuild,kbuild.compiler.linker_error]
---

Log excerpt:
=====================================================
arc-elf32-ld: kernel/irq/irqdomain.o: in function `irq_domain_instantiate':
irqdomain.c:(.text+0x8de): undefined reference to `irq_domain_alloc_generic_chips'
arc-elf32-ld: irqdomain.c:(.text+0x8de): undefined reference to `irq_domain_alloc_generic_chips'
arc-elf32-ld: irqdomain.c:(.text+0x9a2): undefined reference to `irq_domain_remove_generic_chips'
arc-elf32-ld: irqdomain.c:(.text+0x9a2): undefined reference to `irq_domain_remove_generic_chips'

=====================================================

When fixing this issue, please attribute this report according to the
patch submission rules:

Reported-by: kernelci.org bot <bot@kernelci.org>

For complete logs and details about the environment used, see the issue
on the KernelCI dashboard:

- dashboard: https://d.kernelci.org/i/maestro:9f7f10979fbb935f418d79e4916c05cf5bb7a751
- giturl: https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git
- commit HEAD:  c33bbcf64a1d0e2170b7cdee977e2c00e258a70f

# Builds where the incident occurred:

## haps_hs_smp_defconfig on (arc):
- compiler: gcc-14
- config: https://files.kernelci.org/kbuild-gcc-14-arc-haps_hs_smp_defconfig-6aa40c1620239ade90229e86/.config
- dashboard: https://d.kernelci.org/build/maestro:6aa40c1620239ade90229e86

#kernelci issue maestro:9f7f10979fbb935f418d79e4916c05cf5bb7a751

--
This is an experimental report format. Please send feedback in!
Talk to us at kernelci@lists.linux.dev

Made with love by the KernelCI team - https://kernelci.org
