Received: from mail-pz2-f43.google.com (mail-pz2-f43.google.com [74.125.228.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 00EC8559C82
	for <stable@vger.kernel.org>; Thu, 17 Sep 2026 13:59:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.228.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789653549; cv=none; b=hTASQUbHNX5IxaZC3JutLUgkPnpO/j+cyR1g1q8BCMyxZyrNJDakhykjXlgdTM05ub0jPw14DBUEJXIvvTvnH73QS1OQv20fuz/mcKtrMvn9fcAd0aPIKNjLmMUPhOpAz4cLajSRjei5oHIpnZfS+3NZwBNvqtCmRr4VWBJJscE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789653549; c=relaxed/simple;
	bh=BcoN3zrc+2sErV8GK11ArLKp2HsqNppB2tUKlcN/dpA=;
	h=Content-Type:MIME-Version:Subject:From:To:Cc:Date:Message-ID; b=GJbMucJyHJ6oCMhrngsMjkHxP9Wjj9oqcwUhcGxGoQpSntwxZqEn2eUdJ79JKHrYVRAJ+uHwEX2onGjszPLyUGlBPVtNwq6Uv/UQZlJBbNLstc7h1HSNtzPJC/THpBOtG0iJjZ3ytlq4bHvNEhpjjCTAIrC6ahnWkuGY9UwiPPQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=kernelci.org; spf=pass smtp.mailfrom=kernelci.org; dkim=pass (2048-bit key) header.d=kernelci.org header.i=@kernelci.org header.b=afyYeXhA; arc=none smtp.client-ip=74.125.228.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=kernelci.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernelci.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernelci.org header.i=@kernelci.org header.b="afyYeXhA"
Received: by mail-pz2-f43.google.com with SMTP id 41be03b00d2f7-cc433d52421so509511a12.3
        for <stable@vger.kernel.org>; Thu, 17 Sep 2026 06:59:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci.org; s=google; t=1789653547; x=1790258347; darn=vger.kernel.org;
        h=message-id:date:reply-to:cc:to:from:subject
         :content-transfer-encoding:mime-version:content-type:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=U62kvdiIa7UNdt+umFt88aAc8uGWzk/3wpb8wY72Ma4=;
        b=afyYeXhAH2i5M0XSoxpKvEn3Dc+WQ8CkARc/zXJ4aOsA9GDa4DrJi+8UZvk3/lCqLU
         5Ay8nCtbHrZCYG4d0Y3xJcQWiOZBeKqZPJ1+4t26xxn9zRF41TjxM+vkn7ZvKKGkuUeg
         qMSQnboRkoCUiyVblZeARyZuyGg2MB1vQhr8X+tXt9pmQ7gBwNqBKxYF+0tP3HUrFXd/
         9sfmDsxViyudjr728WUBg7km2IN4y+Ssk3kV0bqJa+Sh/IFRhSUIKP4xM/oEKEMRtMOF
         sAqhsFxGAuZxJyVh/JWWFD3Q6tsUSBSdzVS5CoqUggHAdYR/ZApPoCkrHApgZSum1hyf
         uqPQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789653547; x=1790258347;
        h=message-id:date:reply-to:cc:to:from:subject
         :content-transfer-encoding:mime-version:content-type:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=U62kvdiIa7UNdt+umFt88aAc8uGWzk/3wpb8wY72Ma4=;
        b=eAKpEvI12o0qy2vbAeQfRhiCqnJkVcPiNovS2IsYgK5O3Vc2byHDgYkYPdcmE9Bohs
         ZXgrfe2bi7SXcoY/TlNjsrZv1+AcrpDKq2tCeBboFRjV7noUevHhzhSwPJFQlcbd8Cup
         204iDmJeA+DVfEcboTRqA/J7oslcHMcYKNG8EUKTrNSYIhmAIKZ106sdRESReQmfpzO2
         q1fmn3nrcrJqZu4xcZzNsngErBn5xRHNvINbnRMfTt04eWy90RizyKnSWnDe6X86wm90
         SippzlLZ6bZes7IqsIxmSCPxH1F3fvMXpXUJ93NSkze+jxyMkrkThvE2Ekmhn/F3iW6j
         V2GQ==
X-Gm-Message-State: AFuF++mx0xgnoYtxOYTi0q+lHCpwME4s372hoM+XyXr5SF5s81QY+tI5
	DAxRxk/swFVWgoK9wWhf17rxD7sWbRgTA6nICzGyyLNj7WHF3OPHh+gDpf4nlRHkA9Y5tnWI3ym
	GP7rx
X-Gm-Gg: AYBFou0mpwgpB1SxCScYqu5qetL3Z58hF+3cnJXWKDXNMII6OKZsYUQBuUgjwu2tHrf
	holrsNXB8Bu/P1fJ7ZNA23Mo00w1tz9b6e6v/pVyCA/Y6UWVvgoIUyxG/PkZsrNHgfLyx1X6yMo
	IU6iy/5TpvNYzEJyRf0v0jgN3k7W6v1vbpkaeMFYgr0LrW/JGzxtvM6BB9TEt4M7D8uzQe0E2lu
	qOrlAR7qYcUrb0Onqr93ws37OjngbvLigREWGdIU1MzW7aZ/iECgzfc2RlbsfrJL+d6dyZeqUHs
	bvnC56XhPwwkWA5RGbq3wbbEP/nG/MuT2aTQLbsO8YhM+9ZcdzLmL45hvMs9eflh8u37bRWuUkB
	x1taQ0eWIQzh1vy3wHC5L92x3aQ3nfKkBTo3/tdBuXtvdgybV5vi8cKGMxAyzbvtJBPPgDyHZng
	/V5vkgsh3VZwrbZP2l7EnWubqyS7UZOrSqd4d0P9uvbDfcQij08D1+RZnygMcP/nIb
X-Received: by 2002:a05:6a20:20c3:b0:3bf:6d96:ac40 with SMTP id adf61e73a8af0-3dd5f475f34mr17280807637.12.1789653547141;
        Thu, 17 Sep 2026 06:59:07 -0700 (PDT)
Received: from ec7b70f3a45c ([20.38.40.137])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-33bf56d7e5bsm16533538eec.0.2026.09.17.06.59.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 17 Sep 2026 06:59:06 -0700 (PDT)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Subject: [REGRESSION] stable-rc/linux-6.12.y: (build)incompatible integer to
 pointer
 conversion passing 'u32' (aka 'unsi...
From: KernelCI bot <bot@kernelci.org>
To: kernelci-results@groups.io
Cc: stable@vger.kernel.org
Reply-To: kernelci@lists.linux.dev
Date: Thu, 17 Sep 2026 13:59:06 -0000
Message-ID: <178965354629.144182.1416377918696578290@kernelci.org>

New build issue found on stable-rc/linux-6.12.y:

---
incompatible integer to pointer conversion passing 'u32' (aka 'unsigned int') to parameter of type 'unsigned long *' [-Wint-conversion] in drivers/net/phy/phy_device.o (drivers/net/phy/phy_device.c) [logspec:kbuild,kbuild.compiler.error]
---

Log excerpt:
=====================================================
/tmp/kci/linux/drivers/net/phy/phy_device.c:3059:16: error: incompatible integer to pointer conversion passing 'u32' (aka 'unsigned int') to parameter of type 'unsigned long *' [-Wint-conversion]
 3059 |         linkmode_fill(phydev->eee_broken_modes);
      |                       ^~~~~~~~~~~~~~~~~~~~~~~~
/tmp/kci/linux/include/linux/linkmode.h:13:49: note: passing argument to parameter 'dst' here
   13 | static inline void linkmode_fill(unsigned long *dst)
      |                                                 ^
1 error generated.

=====================================================

When fixing this issue, please attribute this report according to the
patch submission rules:

Reported-by: kernelci.org bot <bot@kernelci.org>

For complete logs and details about the environment used, see the issue
on the KernelCI dashboard:

- dashboard: https://d.kernelci.org/i/maestro:3662b5fff663a014d59eb7d42efc6ba25ad893fb
- giturl: https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git
- commit HEAD:  09da4c7d441294e4264cc4804d8bc76433d5e0c1

# Builds where the incident occurred:

## x86_64_defconfig on (x86_64):
- compiler: clang-21
- config: None
- dashboard: https://d.kernelci.org/build/maestro:6aabead8fc1857a999df102e

#kernelci issue maestro:3662b5fff663a014d59eb7d42efc6ba25ad893fb

--
This is an experimental report format. Please send feedback in!
Talk to us at kernelci@lists.linux.dev

Made with love by the KernelCI team - https://kernelci.org
