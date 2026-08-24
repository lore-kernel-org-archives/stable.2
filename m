Received: from mail-pj1-f54.google.com (mail-pj1-f54.google.com [209.85.216.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CFE103655F3
	for <stable@vger.kernel.org>; Mon, 24 Aug 2026 02:30:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787538611; cv=none; b=HNVsSsSXm6bDTdU/jrXwj+Xg5zFdKVFaFlAhSqyctpHWoU+5LrHdZ36MB36MPCgLxcRHgDQCQkgzYt11tovWXOUS50hMCVr5DkN/1270DTYRnuaLAL9uk3DpdgUARZBL4DTKzgpZuhDeFWAHidqf5xooe2PJasZWrHGxvLvs1As=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787538611; c=relaxed/simple;
	bh=rzAjPaG55+EO7e28xqDT9n8YBAPhZuZeL0OiEj79tpY=;
	h=Content-Type:MIME-Version:Subject:From:To:Cc:Date:Message-ID; b=rw+kVetWJ1mKs055sGCsGVAP3+AwLUunguxa979HirV5fdSGrLEQUOMTc5zrNiW/ArjUqITntnY8ZOOvwSi+0ADze8rH4P7Fvx+J81IxWMxFoPjFNvB0tonLMEwic450fAjCERwnqqicm6ozj9WU7CeWRXVIe8kakKXVruH5QU8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=kernelci.org; spf=pass smtp.mailfrom=kernelci.org; dkim=pass (2048-bit key) header.d=kernelci.org header.i=@kernelci.org header.b=IdfIcNyl; arc=none smtp.client-ip=209.85.216.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=kernelci.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernelci.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernelci.org header.i=@kernelci.org header.b="IdfIcNyl"
Received: by mail-pj1-f54.google.com with SMTP id 98e67ed59e1d1-38a0c7e841fso4065876a91.2
        for <stable@vger.kernel.org>; Sun, 23 Aug 2026 19:30:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci.org; s=google; t=1787538609; x=1788143409; darn=vger.kernel.org;
        h=message-id:date:reply-to:cc:to:from:subject
         :content-transfer-encoding:mime-version:content-type:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=roxOLlMEFKuv95tAsVhqtiAQvaOPFGVCVIyqVp5whEE=;
        b=IdfIcNylMAc5lInoYWukgnZIOda8LUZZ+L3rSCBpDKZwg3MJx9vY9S2LhdGm/D8iOY
         YicxlTMkJ3SIIuxMZrQwcsWmUyTP9dL2YhUuS7K2pK2vEkIlHuk+4qo0EtnhzpWPyGpH
         lTRSXCHWdsIE3AMya13phBy+engAQdzN+tDk35xZo9BtQnQDXzytMzsO0yPYnIdSdiA7
         NAJHlRYZioYEB4sLFE8ABY1m9lpMrmTwIr5Jm712qpXBRnp1MwwCDuGSxrK6saMF+mR4
         5K6QWNyBB2PHn/V2T5KYT2UW9V7AAzu7z74kUvdJioWWFftGd9Tn0pPgV+9qHaLKRmVq
         4bKg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787538609; x=1788143409;
        h=message-id:date:reply-to:cc:to:from:subject
         :content-transfer-encoding:mime-version:content-type:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=roxOLlMEFKuv95tAsVhqtiAQvaOPFGVCVIyqVp5whEE=;
        b=s1YDvi7P1CHftfpIX1c/GF9HHbN+opix/PGGT4rVRCFx2iVc37LeBZAzMAC9B6fVgf
         HhzLPWToI/UXq4ifRaFenqrvEsvMG1ybeXf0onBdACfVggIQ9yjM4veMOp6BnyYmNtBJ
         vo1kqrMaaFLsCCS3eQzJBHREGL1C+Mt5YEeUJsEohSPBtwj9Unshzz8VqlnnzLhQzji1
         OSia4wauXPfjf6S3tg0Qsksm4GlhvTV/Q0mxaABTic/3gpmbKHMcgqVV+llOYuUEUgyJ
         W4TQWDlqJ0f+TlAG2yVxsW+orl9Qi1QBiBQ7yWSEaaIUEUjO6sGGCzdXkS8WGb+HMcDD
         k6fQ==
X-Gm-Message-State: AFuF++mXtyDN1sTkQ58RYqyNnhQl8OubhFb9XzFC/GF4xFnZt7Uknq6O
	db3mKIdAKipsaxC0QMRRPs20UAmPaaPWKUsMobPeM6sekWVJx0kMRDxGzdm42K0QOsQwfNyEBw0
	APEt0
X-Gm-Gg: AR+sD11cYnLMECCZ61JZ4+J3/6E4IloWb1vu9Eo2j3MpuXv0zDNWvfGOGKR5lAV/Uly
	AUBT0mXpuQ+9sOzLkZe1mRoHbzW5Uz+ZXboevHyHNMdKxEOo8Y4UV11rbBsBG4NA1UzRe61poTe
	tBPKstEQKeP8qjf5MwDp+lifwGXll47/Z03KA27X4e1sdA5Fajhb3nM/nBuDpU7rD3ciyLBmwhE
	ZBcaa+sPZj5C324n3Ck2ol1cxkpoU8Ts2fC7lLI6OeL4GUfFIsfTBpepO7LiVM8AZtyCi5R3I7A
	sxRtWuqcPFmYtD/XeCRuoa2r7vH7OyqVNun0SQJrKyP6v5zw6DnsQquGJ4WLKHWgkRRTomZJzZX
	T4qRl8X4ykLBc/X+muxOxcXbs9cU1qcstXA6S4x7BAO7a/Ggy1v7TvL8azm0gKGi3Ar1NKouLpi
	F3ee5TRByToaii+visYnhVkCDwJjvWl04Gl/AqLWm6/6THpQ6SAdojgWNy9w==
X-Received: by 2002:a17:90b:50c3:b0:395:5eec:b932 with SMTP id 98e67ed59e1d1-395c39e6433mr44560571a91.11.1787538608915;
        Sun, 23 Aug 2026 19:30:08 -0700 (PDT)
Received: from b455de3d9de8 ([20.38.40.137])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-327f91d37d9sm22031524eec.14.2026.08.23.19.30.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 23 Aug 2026 19:30:07 -0700 (PDT)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: [STATUS] stable/linux-6.12.y -
 14c37ff05f22da2fa7076d10f6a07c7ede330c83
From: KernelCI bot <bot@kernelci.org>
To: kernelci-results@groups.io
Cc: stable@vger.kernel.org
Reply-To: kernelci@lists.linux.dev
Date: Mon, 24 Aug 2026 02:30:07 -0000
Message-ID: <178753860715.2405.2001150808601012585@b455de3d9de8>



Hello,

Status summary for stable/linux-6.12.y

Dashboard:
https://d.kernelci.org/c/stable/linux-6.12.y/14c37ff05f22da2fa7076d10f6a07c7ede330c83/

giturl: https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git
branch: linux-6.12.y
commit hash: 14c37ff05f22da2fa7076d10f6a07c7ede330c83
origin: maestro
test start time: 2026-08-23 13:34:05.946000+00:00

Builds:	   56 ✅    0 ❌    0 ⚠️
Boots: 	   97 ✅    0 ❌    0 ⚠️
Tests: 	13466 ✅ 1170 ❌ 2705 ⚠️

### POSSIBLE REGRESSIONS
    
Hardware: sc7180-trogdor-kingoftown
  > Config: defconfig+lab-setup+arm64-chromebook+CONFIG_MODULE_COMPRESS=n+CONFIG_MODULE_COMPRESS_NONE=y
    - Architecture/compiler: arm64/gcc-14
      - kernelci_watchdog_reset.wdt-reset.wdt-trigger-reset
      last run: https://d.kernelci.org/test/maestro:6a8b012c62f33761c005f748
      history:  > ✅  > ❌  
            


### FIXED REGRESSIONS
    
Hardware: imx8mp-evk
  > Config: defconfig+arm64-chromebook+kselftest
    - Architecture/compiler: arm64/gcc-14
      - kselftest.kvm.kvm_arch_timer_edge_cases
      last run: https://d.kernelci.org/test/maestro:6a8b43f162f33761c00833ca
      history:  > ❌  > ✅  
            
Hardware: k3-am625-verdin-wifi-mallow
  > Config: defconfig+arm64-chromebook+kselftest
    - Architecture/compiler: arm64/gcc-14
      - kselftest.kvm.kvm_arch_timer_edge_cases
      last run: https://d.kernelci.org/test/maestro:6a8b1dbb62f33761c006cc33
      history:  > ❌  > ✅  
            
Hardware: mt8195-cherry-tomato-r2
  > Config: defconfig+lab-setup+arm64-chromebook+CONFIG_MODULE_COMPRESS=n+CONFIG_MODULE_COMPRESS_NONE=y
    - Architecture/compiler: arm64/gcc-14
      - kernelci_watchdog_reset.wdt-reset.wdt-get-timeout
      last run: https://d.kernelci.org/test/maestro:6a8aff1a62f33761c005e54a
      history:  > ❌  > ✅  
            


### UNSTABLE TESTS

  No unstable tests observed.


Sent every day if there were changes in the past 24 hours.
Legend: ✅ PASS   ❌ FAIL  ⚠️ INCONCLUSIVE

--
This is an experimental report format. Please send feedback in!
Talk to us at kernelci@lists.linux.dev

Made with love by the KernelCI team - https://kernelci.org
