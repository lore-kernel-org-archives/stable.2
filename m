Received: from mail-pg1-f177.google.com (mail-pg1-f177.google.com [209.85.215.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3FC7B361956
	for <stable@vger.kernel.org>; Fri,  4 Sep 2026 08:59:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788512350; cv=none; b=nESN4hW+oToWa+pDd0/bc9RjNjgb79um1wHXTMlt96DUuohaYwx/FGbrDm8xqwtVcZsVIo5A8/3s0/KEx5aoz/wN8i/8W8QkJp8l+ATfxDthHaYqQKbE5lnUt4Y3LuAI2uT9o3SoMJIRpUPmZMU6lSZgcP7jUsZaNG0nlXUUMms=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788512350; c=relaxed/simple;
	bh=SozhmnzFeLOWBvp9LHmCR7SRqfv6JZZgW6xkk5DNtyg=;
	h=Content-Type:MIME-Version:Subject:From:To:Cc:Date:Message-ID; b=U9iuq7BAD2FaNEuzygkmm+KuYy/UStov84ziSF10uvnZ69Ymbrr5+sWgdK7c23/XkY2oSu2U3Ufi+tcZD5kP96PddpSnutI+s/qxw8cDbK5c27fAWX0hpGoS+NYqKFkdrfJIxfzuYSxU8+Z7YqzF45Qeq6YCfSzxfMxCE8FxeEI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=kernelci.org; spf=pass smtp.mailfrom=kernelci.org; dkim=pass (2048-bit key) header.d=kernelci.org header.i=@kernelci.org header.b=ZDS+O1wL; arc=none smtp.client-ip=209.85.215.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=kernelci.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernelci.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernelci.org header.i=@kernelci.org header.b="ZDS+O1wL"
Received: by mail-pg1-f177.google.com with SMTP id 41be03b00d2f7-ca80d708489so587120a12.1
        for <stable@vger.kernel.org>; Fri, 04 Sep 2026 01:59:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci.org; s=google; t=1788512347; x=1789117147; darn=vger.kernel.org;
        h=message-id:date:reply-to:cc:to:from:subject
         :content-transfer-encoding:mime-version:content-type:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=14VxQqR+vTCHKrJiJq/aScbH6G6cx0vqmm2HyaxsnbA=;
        b=ZDS+O1wL8qIzKPIJkThhHV3578GJDGM3ZDGkibgAAx3/5LZleIzjF0EvdrI6Hccd1V
         RVh6eF1QxIrCtjWGIqIn/B11+orqrYd43tSnuWtKW6/rOForBpQsyV9yHPDZrui2HyjO
         4mP57pjfYEGLdnFOqR2LOH3kXN+JJEr+DappyzEM4Q3xKYnYH31sUq+++wAZb1vGVnGH
         k1glhagYMaEUhe4CEeYpz2SLmjFh91P9wijvO5rFauCmjuVrRRVlQGgeSUpGlUUPjNt2
         DcXcTEQ28IyvYGnrtjfLSNxg3/fEm0Vbm8esIfU0ShfpcD53GtSIME9hHZhyklMicUQR
         dB8Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788512347; x=1789117147;
        h=message-id:date:reply-to:cc:to:from:subject
         :content-transfer-encoding:mime-version:content-type:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=14VxQqR+vTCHKrJiJq/aScbH6G6cx0vqmm2HyaxsnbA=;
        b=YxjP+5qN226a8chqioQ72oleBXGbPbbdS4pGqHnLiayL9y153Bf0ElZLBmhp7hUkPn
         4fVtl0moqZpp6GaJcZLE4OWsa3E4mhQotOYZCqjVVOht6Qp0FvUX8lbQz6L77UuM2T9D
         zYIkgzwXO/2lTTxCRYj7+qxalTzx1bvcBsKF6GUm7mvaL1C2+rdtD5H7WvnLexzObWQn
         Zb2PpsPiBM8hHKMhAQyo2d7kkKF1+/SgQCZqtoAEeQQDly+YyTv3T3Ya/KPnRjJpnHMq
         JZ34c8Jgq1nsug0shtILvSUYqCiZrS1pE22lnuzZDaMyibBJ3RXEjYPioILgHF2VQ642
         WLyw==
X-Gm-Message-State: AFuF++ljIbzAQ19zMam7Fx+AU/cTVVuzoIrQ494CpIRuh3WS0aceet1G
	COtvJNMErT46xEs8VWcEP5fbm/UTozRBYon8GmwCzoXstFI9IhEzB7xWj55uXmrcZPo=
X-Gm-Gg: AYBFou0tpD9g/liBnX5b37ftU7vN+2U1a3d1WtU0Xj72az68MW8d+x+r/O/ZJyyDc4C
	gzXwbqwP24YsnnGEfLwwZ77Q7R7SgWolNG+enc+3RaIw8esU3YMOsOKU9tv/cv+yxZUl/LzzhWL
	pZOwV1rD/TeWAzXPjZl8HTH3JAsxswd90v1N4ZccL//fDh7guk0J4MexfrtmCp7kJfDbXlx6vpU
	KVS51floalAoDnYujbP8EpEoT2iTmWr+Qqt3RXmYu2GW+bfafe8MFrqJVQxKLVxkUmUUixWtqyB
	aUF8lsNDYCMLgBxrrXK8gpVO0rx2qU0wD22teCosIjxxUZfce0Aa66aLXRL7HqRs+1a2xtDT71N
	K1hSW5QAQdThj57fBZNSmNtBKIw613WAIpv8nyhK6xlyQM7f2GWKkSthJ87OjnvoCrxlOoJ/rau
	GLBn0fgiVfz2igZlKHuqZgZ0np5d8SMZnil4JTt5AuLImITWEyPzi79Yk7kKZOtKB5EA==
X-Received: by 2002:a17:90a:c88f:b0:380:8bb9:aba9 with SMTP id 98e67ed59e1d1-39b07f3216bmr13222483a91.3.1788512347318;
        Fri, 04 Sep 2026 01:59:07 -0700 (PDT)
Received: from 41049dfc76e5 ([20.38.40.137])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-1432435ec2bsm4736832c88.3.2026.09.04.01.59.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 04 Sep 2026 01:59:06 -0700 (PDT)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Subject: [REGRESSION] stable-rc/linux-6.18.y: (build)call to undeclared
 function
 'huge_ptep_get'; ISO C99 and later do n...
From: KernelCI bot <bot@kernelci.org>
To: kernelci-results@groups.io
Cc: stable@vger.kernel.org
Reply-To: kernelci@lists.linux.dev
Date: Fri, 04 Sep 2026 08:59:05 -0000
Message-ID: <178851234496.923.2041501270018737797@kernelci.org>

New build issue found on stable-rc/linux-6.18.y:

---
call to undeclared function 'huge_ptep_get'; ISO C99 and later do not support implicit function declarations [-Wimplicit-function-declaration] in mm/page_vma_mapped.o (mm/page_vma_mapped.c) [logspec:kbuild,kbuild.compiler.error]
---

Log excerpt:
=====================================================
/tmp/kci/linux/mm/page_vma_mapped.c:110:11: error: call to undeclared function 'huge_ptep_get'; ISO C99 and later do not support implicit function declarations [-Wimplicit-function-declaration]
  110 |                 ptent = huge_ptep_get(pvmw->vma->vm_mm, pvmw->address,
      |                         ^
1 error generated.

=====================================================

When fixing this issue, please attribute this report according to the
patch submission rules:

Reported-by: kernelci.org bot <bot@kernelci.org>

For complete logs and details about the environment used, see the issue
on the KernelCI dashboard:

- dashboard: https://d.kernelci.org/i/maestro:cc8e3250a79e15d3b98cd0b7eee6825df4d6d4a0
- giturl: https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git
- commit HEAD:  96ff57c9007ff0391c80864ebe06496d592e3b02

# Builds where the incident occurred:

## defconfig+allmodconfig+CONFIG_FRAME_WARN=2048 on (arm):
- compiler: clang-21
- config: None
- dashboard: https://d.kernelci.org/build/maestro:6a9a5fe6e41d7f97d6fd77bf

## multi_v7_defconfig on (arm):
- compiler: clang-21
- config: None
- dashboard: https://d.kernelci.org/build/maestro:6a9a5fe2e41d7f97d6fd7777

#kernelci issue maestro:cc8e3250a79e15d3b98cd0b7eee6825df4d6d4a0

--
This is an experimental report format. Please send feedback in!
Talk to us at kernelci@lists.linux.dev

Made with love by the KernelCI team - https://kernelci.org
