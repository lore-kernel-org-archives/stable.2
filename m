Received: from mail-pj1-f47.google.com (mail-pj1-f47.google.com [209.85.216.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 50922371860
	for <stable@vger.kernel.org>; Mon, 24 Aug 2026 02:30:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787538644; cv=none; b=h4Raw4oC02mbEF4fnMpe5uXm3k8j69HAasILo0KtbQkqHPl2agqZ0lMjilnI5P5N5mZ+3QOnOrECBJGKz4Y3+rLWH+0BVhzTpZ4EOgN1mLerszaVoPDaCkll++Y+Vma3D9BOUVq5brXBFQSxWy3dLIzQR0E9rStVPPehlSyIdcw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787538644; c=relaxed/simple;
	bh=JgXw25tHUGDX2B+GzYMeEAHLx2bI9iAYFZ3IUzFQ0mk=;
	h=Content-Type:MIME-Version:Subject:From:To:Cc:Date:Message-ID; b=kXb7fKh2AMsjU4afpwMDq4IaYIuAtYNFNndlmBapYTsMY5ck5GVFOUPy9N+7yk3tdaC+w5K5+MRNl33j7eQlaeFwNt9GYGv5WldXlZDu2JUG5b+irQMuAoONgcdZzJFHzAiE1sT0RnBD3iuAbFyMC9t2tcEPKiqNmR/AeLieKXM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=kernelci.org; spf=pass smtp.mailfrom=kernelci.org; dkim=pass (2048-bit key) header.d=kernelci.org header.i=@kernelci.org header.b=GrtwE3Ra; arc=none smtp.client-ip=209.85.216.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=kernelci.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernelci.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernelci.org header.i=@kernelci.org header.b="GrtwE3Ra"
Received: by mail-pj1-f47.google.com with SMTP id 98e67ed59e1d1-38e58034d05so2393513a91.2
        for <stable@vger.kernel.org>; Sun, 23 Aug 2026 19:30:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci.org; s=google; t=1787538639; x=1788143439; darn=vger.kernel.org;
        h=message-id:date:reply-to:cc:to:from:subject
         :content-transfer-encoding:mime-version:content-type:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=C9iO+DXTpHzGbZlhfcMuAapQ5BJFrOQFOemO6Hh8WxI=;
        b=GrtwE3RaQUgK0mKEIGJrnk4CbFLpR0JXrs1wwBjq1u8T7uNOmPJigI9lQWXoLzgzFQ
         BX8p4GOoQFu+b0FMS15RcHcLnB0pLmG5dLllMQsaFRAIrmFiBaNE9eqr+K3kRmQqSEEA
         xDTFdA7sTJsUP95LqwoSfXQg9a9rk6AdXIJQy96XCHIn9s251yCdVVC88wvFX9FZfsb3
         3fuk6hnyv8rH9rki7xGUcnhWIkjdL6UBwwaXB7d5L+20gVyS8r3FY52k4LuOZ8TxHRPq
         uvv75/T29oJldoVQOKGL3sUpRqcm7Ykd2+GrcUtxUZdhxVVBp7hrLxMy0tBv007XzO33
         sQbA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787538639; x=1788143439;
        h=message-id:date:reply-to:cc:to:from:subject
         :content-transfer-encoding:mime-version:content-type:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=C9iO+DXTpHzGbZlhfcMuAapQ5BJFrOQFOemO6Hh8WxI=;
        b=Be6/wNmOW1eo6iFNGA9ZVOucIO9JHkYXUlfyB3RBEFTOdRdra8b3kHvZDaAdb0SRSV
         dr9fTe62lU2oSYkUyk2HQ/3PMAYE1r1jOspveaKbB1L1SEcQsWTBQG+w2qL6eHPsC+Qg
         yVe2vkRPquX5J3K6snaHZ3dokDjgbLx3iXFzo2tCG9hP4IwzgaohzN0EmLNV7bof2YGn
         cnl/C5CHJP1or1H2r2ueIf42XuJc8tL/1m66cmp9JWRJfSp0sq4ndLeePBRfuFyTLTp7
         JuiMuz4gfL4Ax4bQvE0drDsCNcO+/0D2uxmzFtld3fYY38y2xx4i5lv3GT29tB1DQNka
         nBJQ==
X-Gm-Message-State: AFuF++mYM667ceA/6LKXGiQJ1KOaSoxrnkEAmZuA7+HAxNF9Kp4wC4Wk
	C6sy82vcE0FgKhxL5dnM0FKS/RVaHQL4T7imeGa96UxBrce+Y54QDirmhH+FnRcMURFmK0WchPZ
	lSlzN
X-Gm-Gg: AR+sD13j7laPot5Cy0T/RgQ21L0qAeJHf3CoHiIdxVOTrXrYhILLA/BMd6Z1/w18rLZ
	YWvlt0/CRo2sdcru1eR6cbolB4XiPcglYmG0PSk3INSZ4ISJPpjOHwSqU+sN+lajMjexE6c3946
	IXoTPO39kUO+lXBoOIJjWuFkYVvEKD0Oah9C1GWFEr0oENMZ/Eqor1pIOCmuNgI9xvzqZLi1XwX
	8fCeS/Mo5aDflAFb2G+vJT4/b8yddkDUqUvqsYz3BFhNEvfPd5S7pPtmHWOZA4FiICDk4Pwe0wO
	1VmVlw0EmgU7xhjYRyvrvoQTwqKN9bWYR6T2/znCNYx12is5dEk4GyYchGJms5xjSQvcfNXXNSd
	dr+GgdP/UCKRNllHPcGSuO3C/chr9i2JnEPR6flcCSuK5IHTU+vicB7mG9sBERn//YILJC03BEV
	/QPHdmR6HJQYI3gRFS+WtjFhjHvooAe3DGE/Kii+askSCALGQ5q1HJ
X-Received: by 2002:a17:90b:3d85:b0:392:c80b:8eff with SMTP id 98e67ed59e1d1-395c3573af2mr40061449a91.11.1787538639325;
        Sun, 23 Aug 2026 19:30:39 -0700 (PDT)
Received: from b455de3d9de8 ([20.38.40.137])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-327f90c0dd3sm22205222eec.7.2026.08.23.19.30.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 23 Aug 2026 19:30:38 -0700 (PDT)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: [STATUS] stable/linux-6.6.y -
 dc6160265ffc795a1832bc1424f58291d152c7bb
From: KernelCI bot <bot@kernelci.org>
To: kernelci-results@groups.io
Cc: stable@vger.kernel.org
Reply-To: kernelci@lists.linux.dev
Date: Mon, 24 Aug 2026 02:30:38 -0000
Message-ID: <178753863774.2405.13785329850754741038@b455de3d9de8>



Hello,

Status summary for stable/linux-6.6.y

Dashboard:
https://d.kernelci.org/c/stable/linux-6.6.y/dc6160265ffc795a1832bc1424f58291d152c7bb/

giturl: https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git
branch: linux-6.6.y
commit hash: dc6160265ffc795a1832bc1424f58291d152c7bb
origin: maestro
test start time: 2026-08-23 12:29:45.614000+00:00

Builds:	   56 ✅    0 ❌    0 ⚠️
Boots: 	   73 ✅    0 ❌    0 ⚠️
Tests: 	 7851 ✅ 1949 ❌ 1319 ⚠️

### POSSIBLE REGRESSIONS
    
Hardware: bcm2711-rpi-4-b
  > Config: defconfig+arm64-chromebook+kselftest
    - Architecture/compiler: arm64/gcc-14
      - kselftest.mm.mm_run_vmtests_sh_split_huge_page_test
      last run: https://d.kernelci.org/test/maestro:6a8b739b62f33761c00ab057
      history:  > ✅  > ❌  
            
Hardware: mt8183-kukui-jacuzzi-juniper-sku16
  > Config: defconfig+lab-setup+arm64-chromebook+CONFIG_MODULE_COMPRESS=n+CONFIG_MODULE_COMPRESS_NONE=y
    - Architecture/compiler: arm64/gcc-14
      - kernelci_watchdog_reset.wdt-reset.wdt-get-timeout
      last run: https://d.kernelci.org/test/maestro:6a8afa1a62f33761c005b4aa
      history:  > ✅  > ❌  
            


### FIXED REGRESSIONS
    
Hardware: bcm2711-rpi-4-b
  > Config: defconfig+arm64-chromebook+kselftest
    - Architecture/compiler: arm64/gcc-14
      - kselftest.kvm
      last run: https://d.kernelci.org/test/maestro:6a8af0f762f33761c005672c
      history:  > ❌  > ✅  
            


### UNSTABLE TESTS
    
Hardware: bcm2711-rpi-4-b
  > Config: defconfig+arm64-chromebook+kselftest
    - Architecture/compiler: arm64/gcc-14
      - kselftest.mm.mm_run_vmtests_sh
      last run: https://d.kernelci.org/test/maestro:6a8b739b62f33761c00ab034
      history:  > ⚠️  > ❌  
            
      - kselftest.mm.mm_run_vmtests_sh_khugepaged
      last run: https://d.kernelci.org/test/maestro:6a8b739b62f33761c00ab059
      history:  > ⚠️  > ❌  
            
Hardware: qemu-arm64
  > Config: defconfig+netdev+nfs-root-boot+kselftest
    - Architecture/compiler: arm64/gcc-15
      - ltp
      last run: https://d.kernelci.org/test/maestro:6a8af1fd62f33761c0057029
      history:  > ✅  > ❌  > ✅  > ✅  > ✅  
            


Sent every day if there were changes in the past 24 hours.
Legend: ✅ PASS   ❌ FAIL  ⚠️ INCONCLUSIVE

--
This is an experimental report format. Please send feedback in!
Talk to us at kernelci@lists.linux.dev

Made with love by the KernelCI team - https://kernelci.org
