Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.176
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795010355;
	b=LIx0PXDCerbgvqtYB3DEFQRnxrld5FHoxMmN55eL1hS/0CSkAobmJnCTZgAf+m8w2LyH
	 ORfgyLsCzm06J3/gkhmdItq90R3qszZv4UBEy9LBKZPGTzHqIe2KPcfTH7Ze3prFZUbYd
	 DChVvbQ5zZ4Nf0vibrINTvW3v+K1SgHJKayAl10kwR9UFuianKmuhaDTklAJXo6MHqJF6
	 U9AewrRk0bcxyXiEl7KCm+lx3uytS+x1yI6Zd7fGI7UcKbH0zFbc12wdL5PDWb6sCUkDk
	 NfGEAmA8gThW5efXviUD1mxoZ5PfZEUV/PuWfyY2lOsVP4Mzjsjj6kfAbnfB7dWF4qQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795010355;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:Content-Type:
	 MIME-Version:Content-Transfer-Encoding:Subject:From:To:Cc:Reply-To:
	 Date:Message-ID;
	bh=txkFGuGpCnXzxTh2qSvjTprjA71bkpl648fqI57Fejc=;
	b=Pzm1T9dSgu4Mc1tN8L1Tg6kntmYgOsWv0x1VIkNJdJBsYR7g0lWXoLvzTydNrByFE05e
	 SaYQAPrte4zJaOesrzKst8htLBLqleHiuoqn1KCKScd1Zwkm1Muv+M5grXo2LXT4tqfdq
	 HktpHXRoNcLX/fsbX5vy3nvkQtZJUQ3KfHoCwaG4NpMSuOt0t79rwTkqilFNb2B0jc/0D
	 zD8QOF0a8oazDmuFh93eKikc1Hgsy8L9jyFADr4Gk98HRArVA+APPMbQAHzzl4AAkkL4H
	 17HQRadA/1zLyclCkcLeCu9mrhiJMlI/0OKyXfMWLWKC6M6GOIJTF4O/K9s36gS30eg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=kernelci.org;
	spf=pass smtp.mailfrom=kernelci.org;
	dkim=pass header.d=kernelci.org header.i=@kernelci.org header.a=rsa-sha256 header.s=google header.b=YF6CV2y6;
	arc=none smtp.remote-ip=74.125.82.176
Received: from mail-dy1-f176.google.com (mail-dy1-f176.google.com [74.125.82.176])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 307FF606A32F
	for <stable@vger.kernel.org>; Wed, 18 Nov 2026 13:59:14 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 307FF606A32F
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=kernelci.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernelci.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernelci.org header.i=@kernelci.org header.a=rsa-sha256 header.s=google header.b=YF6CV2y6
Received: by mail-dy1-f176.google.com with SMTP id 5a478bee46e88-3282db206d3so2760880eec.0
        for <stable@vger.kernel.org>; Wed, 18 Nov 2026 05:59:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci.org; s=google; t=1795010354; x=1795615154; darn=vger.kernel.org;
        h=message-id:date:reply-to:cc:to:from:subject
         :content-transfer-encoding:mime-version:content-type:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=txkFGuGpCnXzxTh2qSvjTprjA71bkpl648fqI57Fejc=;
        b=YF6CV2y6bk5a4h0QV8sJG77kbmN/C7m+CU8R/bkDAJQOXZQA35LEDUpskHGKJ/8Uoa
         WvNrNl72lSCoiX9fXy9sv75m2JZ/EKRuYQNNhMUG7cElpPEinIEtEzatNJG76VxvJdkM
         tGJlHtoLdZ3iwCmV4Z3bwdVQYCUYMKQQka3OJ4u1b5O9JVgkIJEXwC/DoLu9eK5ihXQd
         wAqFKYVOouGlaeTLj9h0j4pFjy3X55kiXVihG9ffkGmDpvvn4fB6v0qpdAfmQWo1wwIt
         RRCpGiLzFjp7Q2IMYNEVLDfN/0Ib5b4tr2OEMKnhLEq6BgGpP7/G2eaVcf5UDddu8ul8
         QadA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795010354; x=1795615154;
        h=message-id:date:reply-to:cc:to:from:subject
         :content-transfer-encoding:mime-version:content-type:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=txkFGuGpCnXzxTh2qSvjTprjA71bkpl648fqI57Fejc=;
        b=OULAV6Iy+g9kJxlrmi7Nz3o6bCnjgRXsl0V5SKR0ObYZtCZ0np0rXjCoJeemuGPdio
         CpdAqHAFf7tO5YUUhfSG2UitvkYIZybLr3EiXDTcwiNDMqZj9w6m4vD3AxO4CWsFWgnR
         8g+wg6E3eHj4tuCecgRwmGfdQ2jH3VEs29dzhTquBW1JVw3F5d4POtHXQkqpXc4AH1K5
         I7EtkEbaCq/Cof2DKKD16Gs477cfmywpPhnNO/NevzpOEgx+Q6clzjjGx5+EqkXpE5qD
         iycgRlrVoZlfR0z9vntDvqrdHI0nO8Y6zby+6m2/dH99n049bneOZ3NLyI80zDkRiFcC
         g2fg==
X-Gm-Message-State: APuU4Z8f18TFHI97/K/W5I6qbJhSZPl6nxlt8fPjCe+TmL5rRDxMsCNP
	VKml/QZCRNXWFzr7SIwjMdo6md6ia1sv8NWSqKaAZmqDuB5jIF731rDUSdG3ny18Qg8=
X-Gm-Gg: AZFdTZcMA6X/iXRthPeizEg/q3xr/INnOHKxtsh65V6U0EVoJ8KpKLMBkRISq52jreb
	k2R8H9giqiT7Su51gESo5ytT3VC7sao7mjpNumJFPgbksKDMjZFXERaQqM3HPaL+Kr7Ud/YSTVB
	id7o0g+kN5pM8YW8SC1BFTVPMkIvlWX5nznw8idXCOc3dyhYPR1lgQo1C6KWP4ZSq1Ez4BKkfZC
	9v2s3o2et/McW4xcbAK9S8Gy0jDOsJ1pRAjE4B1gSq242GqOTnUo7u6ZQUn2VT+bP4TBIEW7KVl
	dPvk+PAQIYhrlo31/npZMt0kMKnCKblfAEYaRFGx380tXCjaJdpeh586gDnxpzyUOYGujEJWjUI
	c/kmRBKnV4fz9FjqAQ55ycXcR00UqzjmVhawdQEJzKapKqxiiLVgNTFALXua3LfuMKlpR+FzqvP
	OwB2USbdba0ddYpIouwihs/XAw1MHSwu6vY0tT0j6p+ksdtTtA3aCbzsv9ZHMvV64m8RqhnezIy
	qK6kzkooDXPMoq4LFYWvtrD+KJyVQViVFvneGhcoPUpbXmKv//Bfh8FRR59aXMT/UQoWrq5AGhf
	7pCXOFJIzW3i+AdnYt+QuA==
X-Received: by 2002:a05:7300:bc03:b0:369:fc93:eda5 with SMTP id 5a478bee46e88-38281427c34mr3453874eec.39.1795010354062;
        Wed, 18 Nov 2026 05:59:14 -0800 (PST)
Received: from 8439c401ee69 ([20.38.40.137])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-382a6304ff2sm8334848eec.6.2026.11.18.05.59.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 18 Nov 2026 05:59:13 -0800 (PST)
Content-Type: text/plain; charset="utf-8"
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Subject: [REGRESSION] stable-rc/linux-6.1.y: (build)call to undeclared
 function
 '__pud_trans_huge_lock'; ISO C99 and la...
From: KernelCI bot <bot@kernelci.org>
To: kernelci-results@groups.io
Cc: stable@vger.kernel.org
Reply-To: kernelci@lists.linux.dev
Date: Wed, 18 Nov 2026 13:59:13 -0000
Message-ID: <179501035165.303994.8178203120371436058@kernelci.org>

Cc from: regression/stable-rc.yaml

New build issue found on stable-rc/linux-6.1.y:

---
call to undeclared function '__pud_trans_huge_lock'; ISO C99 and later do not support implicit function declarations [-Wimplicit-function-declaration] in mm/mremap.o (mm/mremap.c) [logspec:kbuild,kbuild.compiler.error]
---

Log excerpt:
=====================================================
/tmp/kci/linux/mm/mremap.c:395:12: error: call to undeclared function '__pud_trans_huge_lock'; ISO C99 and later do not support implicit function declarations [-Wimplicit-function-declaration]
  395 |         old_ptl = __pud_trans_huge_lock(old_pud, vma);
      |                   ^
/tmp/kci/linux/mm/mremap.c:395:12: note: did you mean 'pud_trans_huge_lock'?
/tmp/kci/linux/include/linux/huge_mm.h:392:27: note: 'pud_trans_huge_lock' declared here
  392 | static inline spinlock_t *pud_trans_huge_lock(pud_t *pud,
      |                           ^
/tmp/kci/linux/mm/mremap.c:395:10: error: incompatible integer to pointer conversion assigning to 'spinlock_t *' (aka 'struct spinlock *') from 'int' [-Wint-conversion]
  395 |         old_ptl = __pud_trans_huge_lock(old_pud, vma);
      |                 ^ ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
2 errors generated.

=====================================================

When fixing this issue, please attribute this report according to the
patch submission rules:

Reported-by: kernelci.org bot <bot@kernelci.org>

For complete logs and details about the environment used, see the issue
on the KernelCI dashboard:

- dashboard: https://d.kernelci.org/i/maestro:157c25d482810f84a92d1e7d0afd2eb7d8647272
- giturl: https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git
- commit HEAD:  80555b0524e00b3e34b4619457160cbb971ec8e8

# Builds where the incident occurred:

## x86_64_defconfig on (x86_64):
- compiler: clang-21
- config: None
- dashboard: https://d.kernelci.org/build/maestro:6afd9e7199c74e1a997dc67e

#kernelci issue maestro:157c25d482810f84a92d1e7d0afd2eb7d8647272

--
This is an experimental report format. Please send feedback in!
Talk to us at kernelci@lists.linux.dev

Made with love by the KernelCI team - https://kernelci.org
