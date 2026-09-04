Received: from mail-pg1-f180.google.com (mail-pg1-f180.google.com [209.85.215.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AE41941F36F
	for <stable@vger.kernel.org>; Fri,  4 Sep 2026 06:59:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788505152; cv=none; b=nVbnlrNExdkOd0wd3Q7J8y1yP3llmt6jFGNUNZKcV5JbFYXxkq4wIEUlff60lZU04hVKG90WZwaPR3eTmEsgGOTpWOyM0wIAfEE4OKKkfuuLGNHTruBilaWf3C8JOvJVyH624xSOkR0ITKqZAH39TzHEjRQZrvLILo6u3ktyBbk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788505152; c=relaxed/simple;
	bh=KeYUB0XI6EvhXTv9ejemv9cgS0h7v3e0glAAc6eN0L4=;
	h=Content-Type:MIME-Version:Subject:From:To:Cc:Date:Message-ID; b=i7L5Z21M61zd4kgYz2Ci/1bvKXEuRbY7lbIH3rp47zixOb4ZNKrxE+jQd/p9Wknn8TStnfov+XN4nhXrLwq0z1U+s+Sy2btLoszMsk9znb0Btpixd9pxbD8gDor6+LuUObycqVQPdAbvStpXQN59BdDo4iPzd5PoFPjyusQWJUQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=kernelci.org; spf=pass smtp.mailfrom=kernelci.org; dkim=pass (2048-bit key) header.d=kernelci.org header.i=@kernelci.org header.b=aNYwUxWS; arc=none smtp.client-ip=209.85.215.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=kernelci.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernelci.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernelci.org header.i=@kernelci.org header.b="aNYwUxWS"
Received: by mail-pg1-f180.google.com with SMTP id 41be03b00d2f7-ca97d139d5fso757298a12.0
        for <stable@vger.kernel.org>; Thu, 03 Sep 2026 23:59:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci.org; s=google; t=1788505149; x=1789109949; darn=vger.kernel.org;
        h=message-id:date:reply-to:cc:to:from:subject
         :content-transfer-encoding:mime-version:content-type:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=cM0TgPVOVOOtK4nVZ8nSOxCCgM3fFGQVAExhBymouhw=;
        b=aNYwUxWSgiZIcVj2PHDZHj5/LLsn8Js9f8YO8h9REVfKdNHxVYnTZzNiP+RjVcu5Tr
         wNQhtsxjFwKCsvmvpWSoTX5P95OgZ/zyzVLz/bO3Tla/TTcPGjERcV7iyq9FBfshaYx4
         +WXkbIZvOqpUedsj3EQCIxzY5WgYxwWCI4rN+ZkWXe0QCI0ZiUUGZF2M70NxgGS3XsZb
         glI2KwlfY9Cj6stUFmQ/KWxXoYMYocGGijyme5BGTgrFFk+N8/hW57sVfc3pizHKJjUn
         iOwzLYlY3jTn470QOUEfXMEG61aoRhF9fnAWBoWg9R1w3Bp1UqY3HpfZrJGBuVIEq8gn
         i2DQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788505149; x=1789109949;
        h=message-id:date:reply-to:cc:to:from:subject
         :content-transfer-encoding:mime-version:content-type:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=cM0TgPVOVOOtK4nVZ8nSOxCCgM3fFGQVAExhBymouhw=;
        b=aqiWDMtIf7nmDGPmuXhv2XhtYdYLHCKy6CXIdcn940vBvnIl+t2BbfSMEv58Zp48ZP
         IDyOcuHVTfYu6Z1Unx0brszJxkow8jK68VcD654HZ9/Q7hufAh2CQHcbC0BENH+1G6P9
         s+zAq0OXyZgqahrua5b5EeQZErqgdHV2x3HBPaMzVryNxSpp5cdQV8iY5Kz1UUm80n4V
         +XigSCzEFDWzTNVxvI6F8DfyEltGgj/mSmMM+03UWCzlylrHoLBn/GR17HeLn9e+rjKI
         UGmPAAMLq5pm+X+inWYehK9HSPd7aAF+PpmgCyR0FjuOvI3c0taX7RvyA+7CDTzQfW6a
         J6qA==
X-Gm-Message-State: AFuF++mrBNFxmil/mFwNN3ttetsoGiVhaYYUxUdGZsw9MML1wogeFb0k
	ccw/qlKOcq5fNRYfPs1SBryFlBchz+AHtN6wYrtsFas4HaQohhWvkcesLizwNeWJRhsLIkDCySA
	JjsA7DMg=
X-Gm-Gg: AYBFou3pu91/NrfY8a1ahGt8o4v76JlBKqlXi/tzvYi3ptIXp9p/8CPt1++DADdqNpW
	MfQNRUlRGbQi3kBdlBpGkvOjgzVqOtUd8GYFKVyY50T4xXYjPI5A6zIgnfm3mAVY+zS/5sL5RHi
	1K0Myc7+XvBrUdkkr7jI7aERsVGvufoEbBxbRpA+LioItTwDm3C+T0pWjjy+mV+8O3j9Seuc2e4
	hzpcaxaayPlxJWcFbmUSdqjrOW58+PnZpV2n6DiyNj7ERZMoUuCPxx2D7vqFhQ255HIBz3tY57R
	a8o5sSlWrvrcfAiXZyQxnjgAEJZK0sR/FjX5xcC2rFVLGARjBirmmPxc26mPEXqObi6/xx+2vM3
	ep1u1WB7AmPQS6KRDtIUTClKWaOuk2jGn7Q5fzmNA+9P7YQea8j9du0Ki3H2buh7K+uXhvzRxky
	qNqFsgIyjmbXEgOQLEW0xOlubq1S5KSPPJj0oFNxgXik76NLHFexbs4efhe38R3FU=
X-Received: by 2002:a05:6a21:9d8a:b0:3c3:791e:5e18 with SMTP id adf61e73a8af0-3da39e6cd73mr6724888637.7.1788505149603;
        Thu, 03 Sep 2026 23:59:09 -0700 (PDT)
Received: from 41049dfc76e5 ([20.38.40.137])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-3339885ca07sm4725823eec.1.2026.09.03.23.59.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 03 Sep 2026 23:59:08 -0700 (PDT)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Subject: [REGRESSION] stable-rc/linux-6.12.y: (build)call to undeclared
 function
 'huge_ptep_get'; ISO C99 and later do n...
From: KernelCI bot <bot@kernelci.org>
To: kernelci-results@groups.io
Cc: stable@vger.kernel.org
Reply-To: kernelci@lists.linux.dev
Date: Fri, 04 Sep 2026 06:59:08 -0000
Message-ID: <178850514846.887.13176095181387511630@kernelci.org>

New build issue found on stable-rc/linux-6.12.y:

---
call to undeclared function 'huge_ptep_get'; ISO C99 and later do not support implicit function declarations [-Wimplicit-function-declaration] in mm/page_vma_mapped.o (mm/page_vma_mapped.c) [logspec:kbuild,kbuild.compiler.error]
---

Log excerpt:
=====================================================
/tmp/kci/linux/mm/page_vma_mapped.c:103:11: error: call to undeclared function 'huge_ptep_get'; ISO C99 and later do not support implicit function declarations [-Wimplicit-function-declaration]
  103 |                 ptent = huge_ptep_get(pvmw->vma->vm_mm, pvmw->address,
      |                         ^
1 error generated.

=====================================================

When fixing this issue, please attribute this report according to the
patch submission rules:

Reported-by: kernelci.org bot <bot@kernelci.org>

For complete logs and details about the environment used, see the issue
on the KernelCI dashboard:

- dashboard: https://d.kernelci.org/i/maestro:db4a124b30ac7f3175f6a2c01666b4dd94711dac
- giturl: https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git
- commit HEAD:  ee6921fed8a481c1d78d55e7958748fc4b31d30f

# Builds where the incident occurred:

## multi_v7_defconfig on (arm):
- compiler: clang-21
- config: None
- dashboard: https://d.kernelci.org/build/maestro:6a9a5f2ce41d7f97d6fd7606

#kernelci issue maestro:db4a124b30ac7f3175f6a2c01666b4dd94711dac

--
This is an experimental report format. Please send feedback in!
Talk to us at kernelci@lists.linux.dev

Made with love by the KernelCI team - https://kernelci.org
