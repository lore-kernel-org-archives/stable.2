Received: from mail-pf1-f181.google.com (mail-pf1-f181.google.com [209.85.210.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4BE1C3A544F
	for <stable@vger.kernel.org>; Tue,  4 Aug 2026 02:30:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785810616; cv=none; b=mEroKMUYOXvfnR0gPuXH/EbzR9Eg6yGLFRz77jt3hMCdu5hjNGyxifCmnbIfgo5zDCOnyySaVTlLnOWLU6l46CScLobcC2TGC+2RghH1v0U64ENG9lw0slJyXBFYD8ms7M1o/WrS09EHLJ46ETHaa61qfPXYkyHabsL72tmIwh0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785810616; c=relaxed/simple;
	bh=UL6kXCdsVivojqq5/4JutkmR9D6WiuNVdUcYYzPsCyU=;
	h=Content-Type:MIME-Version:Subject:From:To:Cc:Date:Message-ID; b=ubj5hfuPfhe/A5t43NfS0XyRianmBbnEiYxjE7Z0WyG/ORFPRbzmIrcp5ClOFlQESZIbsNVB1+dDECsslPFnqc8jwV54qxicFRysGwLNqSmSrL/9ftq9X5cmNB5RCRcGxNK9usJoy+qBW7T82o5prWdez6803K2A1SNPRYXb28A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=kernelci.org; spf=pass smtp.mailfrom=kernelci.org; dkim=pass (2048-bit key) header.d=kernelci.org header.i=@kernelci.org header.b=XfxL4yKy; arc=none smtp.client-ip=209.85.210.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=kernelci.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernelci.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernelci.org header.i=@kernelci.org header.b="XfxL4yKy"
Received: by mail-pf1-f181.google.com with SMTP id d2e1a72fcca58-848595b338cso5133203b3a.0
        for <stable@vger.kernel.org>; Mon, 03 Aug 2026 19:30:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci.org; s=google; t=1785810613; x=1786415413; darn=vger.kernel.org;
        h=message-id:date:reply-to:cc:to:from:subject
         :content-transfer-encoding:mime-version:content-type:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=jP7+zNChwUcJOw5O+bCc7xzzRdJyBQKmX0eqERjp6s8=;
        b=XfxL4yKycYxucD0NI+tPbasWQUwY0fwBA5pg7guu1jRNtvVmuBmJLuJeCt0Pco2dEo
         sUHh6bw+Lj1KpvQNobnAyCf6F1w406J+hq7Qhd8pcQSeRkQDOmGd0C2O7LMRlQFvlb1N
         W25ZvGHlG82VLNpSxGFO2K1YwxJ1/NZ4UO3ET2RSyoRr+B9R1Q+S+31noQUVmMhLD7kx
         ux2JaJBkJhdvvS7vsSlGwVkotsvNRfyi5cIAhHEVN5UaoA057Smd3wNYfEMTo1wbwdmf
         4kqwBRsC07UDEYlZsk1SvFMEGz4zcz6Mb4s+KMd4NeotoKxYaOq3Dr2VsGX3pAOToyo1
         3UAw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785810613; x=1786415413;
        h=message-id:date:reply-to:cc:to:from:subject
         :content-transfer-encoding:mime-version:content-type:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=jP7+zNChwUcJOw5O+bCc7xzzRdJyBQKmX0eqERjp6s8=;
        b=H4HltjmytpDt6R6P4C/oBhjeXQYk4maSaLtdZ0YXymCHokyPLhpeR7LSdZhj/eJl1u
         q+CWiRbx8NS9KZ6UQsZCJNS3fSorPC856wiMTsaQqq3qxDFynlRAV8NX6TYBuJpT4b/s
         nIsOmwJFlMtX0yE3N5PjvW1h+vq0T8oh0HSwAfwVGpwKDoqEXGwbHPU0pxw/pN1TVQVt
         Z6tYZOYv896Kd65cQ1UXkYgcOzOjuP3N0UA1XtyLOQxzqElOB+WYQ3XUxvSBSyxGqDYX
         IL2YrufDXizl5hsg3WjCOpHDvK4pvjfoXEmOqDiDz+kn2DZOsDVcvZYXcsCVHSZoKHhY
         H+iA==
X-Gm-Message-State: AOJu0Yy6JNI6UU1da2s1GT5ZYQqbq4FW8pqVufn1LRraEOSGL2T2ASZk
	RXDs3Dx3g1DcJHUNyCtYuMYLD7+vMtQ2ENQtphHYCxFdhc7RX3dlCpF+uUakm1Ff0kw=
X-Gm-Gg: AR+sD11bpnaj4YDwNcTeS2oSfUk5w5ZLeNemS2qPfsuakwuqLTDyg7B76POhj6/VPOb
	c1lZ+AzVkNc/lqs3sfzYwT338M8WqrPv6eNApA3OXrmfclKtLdzOKKxwmURyz3jhN4HnWYJ1RaA
	uMl0VkloKwM5KytGQrBALm1OeCuNmGrB/BZKJwMhMx4EnV0r7kFgY8AomWo/hk1b27O1grpkkWi
	E87SM4I/UCF0KdkOyZwH6NT7eRZ3ecs3gmkhCcscJIETkO35YfdnZm74i/xBR8Z/FY9ja+kvvH6
	58WXpdpVkbrfo4WibdL2fIfzX70LR5tmRv5p2rcsYSb1vZkLWPLyfA3fOjYrVHzKSakKrBdt3DL
	7L60GytmAWKWRT2zXE6lts72pt18OINedaq49ALBJ/HadTAG4Qq4fgTe9QbkGE9jyQoHpEnhh/5
	DgHE+dXeMY5M4oS17hdfFRghFiiS4ubjCeKDll/+USDx8gzJaNulPGCw==
X-Received: by 2002:a05:6a21:338a:b0:3c3:791e:5e12 with SMTP id adf61e73a8af0-3c92a8e2cedmr12881264637.72.1785810613377;
        Mon, 03 Aug 2026 19:30:13 -0700 (PDT)
Received: from 92650adf53de ([20.38.40.137])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-3153e04506csm45701030eec.17.2026.08.03.19.30.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 03 Aug 2026 19:30:12 -0700 (PDT)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: [STATUS] stable/linux-6.12.y -
 833291ee77846538926c990bcb468f6f54e9af50
From: KernelCI bot <bot@kernelci.org>
To: kernelci-results@groups.io
Cc: stable@vger.kernel.org
Reply-To: kernelci@lists.linux.dev
Date: Tue, 04 Aug 2026 02:30:12 -0000
Message-ID: <178581061213.6069.17640131642805719227@92650adf53de>



Hello,

Status summary for stable/linux-6.12.y

Dashboard:
https://d.kernelci.org/c/stable/linux-6.12.y/833291ee77846538926c990bcb468f6f54e9af50/

giturl: https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git
branch: linux-6.12.y
commit hash: 833291ee77846538926c990bcb468f6f54e9af50
origin: maestro
test start time: 2026-08-03 10:15:53.266000+00:00

Builds:	   55 ✅    0 ❌    0 ⚠️
Boots: 	  101 ✅    0 ❌    0 ⚠️
Tests: 	12874 ✅ 1097 ❌ 2429 ⚠️

### POSSIBLE REGRESSIONS
    
Hardware: k3-am625-verdin-wifi-mallow
  > Config: defconfig+arm64-chromebook+kselftest
    - Architecture/compiler: arm64/gcc-14
      - kselftest.kvm.kvm_arch_timer_edge_cases
      last run: https://d.kernelci.org/test/maestro:6a70938b54179f15da930522
      history:  > ✅  > ✅  > ❌  
            
Hardware: mt8195-cherry-tomato-r2
  > Config: defconfig+lab-setup+arm64-chromebook+CONFIG_MODULE_COMPRESS=n+CONFIG_MODULE_COMPRESS_NONE=y
    - Architecture/compiler: arm64/gcc-14
      - kernelci_watchdog_reset.wdt-reset.wdt-get-timeout
      last run: https://d.kernelci.org/test/maestro:6a70776354179f15da91bfdc
      history:  > ✅  > ❌  > ❌  
            


### FIXED REGRESSIONS
    
Hardware: meson-gxl-s905x-libretech-cc
  > Config: defconfig+lab-setup+kselftest
    - Architecture/compiler: arm64/gcc-14
      - kselftest.mqueue
      last run: https://d.kernelci.org/test/maestro:6a70989954179f15da932ded
      history:  > ❌  > ❌  > ❌  > ✅  
            
Hardware: mt8183-kukui-jacuzzi-juniper-sku16
  > Config: defconfig+lab-setup+arm64-chromebook+CONFIG_MODULE_COMPRESS=n+CONFIG_MODULE_COMPRESS_NONE=y
    - Architecture/compiler: arm64/gcc-14
      - kernelci_watchdog_reset
      last run: https://d.kernelci.org/test/maestro:6a70753254179f15da91ad36
      history:  > ❌  > ✅  > ✅  
            
      - kernelci_watchdog_reset.wdt-reset.wdt-trigger-reset
      last run: https://d.kernelci.org/test/maestro:6a70775554179f15da91bfa8
      history:  > ❌  > ✅  > ✅  
            
Hardware: sun50i-h5-libretech-all-h3-cc
  > Config: defconfig+arm64-chromebook+kselftest
    - Architecture/compiler: arm64/gcc-14
      - kselftest.uevent
      last run: https://d.kernelci.org/test/maestro:6a707f4354179f15da91fac4
      history:  > ❌  > ✅  > ✅  
            
      - kselftest.uevent.uevent_uevent_filtering
      last run: https://d.kernelci.org/test/maestro:6a70b6f654179f15da9429c7
      history:  > ❌  > ✅  > ✅  
            
      - kselftest.uevent.uevent_uevent_filtering_global_uevent_filtering
      last run: https://d.kernelci.org/test/maestro:6a70b6f654179f15da9429c8
      history:  > ❌  > ✅  > ✅  
            


### UNSTABLE TESTS
    
Hardware: k3-am625-verdin-wifi-mallow
  > Config: defconfig+arm64-chromebook+kselftest
    - Architecture/compiler: arm64/gcc-14
      - kselftest.kvm.kvm_memslot_perf_test
      last run: https://d.kernelci.org/test/maestro:6a70938b54179f15da9304d3
      history:  > ❌  > ✅  > ❌  
            


Sent every day if there were changes in the past 24 hours.
Legend: ✅ PASS   ❌ FAIL  ⚠️ INCONCLUSIVE

--
This is an experimental report format. Please send feedback in!
Talk to us at kernelci@lists.linux.dev

Made with love by the KernelCI team - https://kernelci.org
