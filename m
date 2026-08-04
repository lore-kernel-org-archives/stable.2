Received: from mail-pg1-f173.google.com (mail-pg1-f173.google.com [209.85.215.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B47EE3515F1
	for <stable@vger.kernel.org>; Tue,  4 Aug 2026 02:31:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785810702; cv=none; b=VZO+mpBCFEKvq4qv1ymW57cv7euUYEjOnBuwQZ5XacuupW2Bc688x9uVOS/tBZLsRJe+ZQkmiN8M9mwYBIOEPZGywUemGLw5bg77ePdF6P7gbFCT7/agwFroHsBbBWAhWNi7X0Abq5dpP8hfRwyix3czBCzJsUxkEo9FLdL9HYA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785810702; c=relaxed/simple;
	bh=iQ+mQCnnbwMjmZkQq4GaN2hEB6Xt1fHGf/+LhYZDJo8=;
	h=Content-Type:MIME-Version:Subject:From:To:Cc:Date:Message-ID; b=CoNJMPTy6gxT1AOvzMfAxINlHsbHJ7GH+mG9/crm9rjkSIRDpEsm733hZOdKV2oYo1KgK/iBMhqqulfLw9BJLNa0VJaR6wGYZ+mLrnZGc61Yb8+y13PRK4owIcSdmvfUD5NzmlAR774tCE7CF3ebYmn78s0IDDTPzWppR9nKWzY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=kernelci.org; spf=pass smtp.mailfrom=kernelci.org; dkim=pass (2048-bit key) header.d=kernelci.org header.i=@kernelci.org header.b=QnwncfO+; arc=none smtp.client-ip=209.85.215.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=kernelci.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernelci.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernelci.org header.i=@kernelci.org header.b="QnwncfO+"
Received: by mail-pg1-f173.google.com with SMTP id 41be03b00d2f7-c99eaa1f020so3952653a12.2
        for <stable@vger.kernel.org>; Mon, 03 Aug 2026 19:31:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci.org; s=google; t=1785810700; x=1786415500; darn=vger.kernel.org;
        h=message-id:date:reply-to:cc:to:from:subject
         :content-transfer-encoding:mime-version:content-type:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=q2XsA3hduxe/OQJ9r6QHNVyxShNydlQkRXSYc1SFatI=;
        b=QnwncfO+WuCQp22/umudkR40SrHEwuZLjvtiFhGQOy5mOA+cj1bTMgVPkGdx473M/k
         cZVPimiE/KL8dIOlVB03g2KijVCqkeQH3nZ4bfozc4s0299hBhNlr+9zqbptP+jviN8c
         dEs/tmYNehGM88BqCq0ZXN/Hv74hoMg7rvGt1BqnsgWH643heGMY1YgaD14VmHWiVOqw
         WosS4ewkZksoyLEcK1YZwdCApL2LIpm7dszi+xxiFq6IzSaiqI1yFMpT/u9QiPlDPR6j
         vfYd4TdPcuJ0NqlaJJ3dEiHOzBR5XQa3rTs5IsAmCT+GPG2/2AISzlhwu2m5y7eZhuHO
         51LQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785810700; x=1786415500;
        h=message-id:date:reply-to:cc:to:from:subject
         :content-transfer-encoding:mime-version:content-type:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=q2XsA3hduxe/OQJ9r6QHNVyxShNydlQkRXSYc1SFatI=;
        b=kK0E+eSRUOyndW4U1oJtlsvtsi5r4TWuIfS9GvNmWVKAeARXjrP8AFgR/UyxPFTfbL
         7HWIZLutkrvR13noZ8rnHwtT79lIDIVNVJ0sSEcNSe1RtD75uAMFgp6EYDHNre61JhFJ
         MztumYPFWJa/iMK3onJCH/PVbGen8U4ZAvop7ipq11a9IJ2JBGXV1pvjyGuoC1aFM5VT
         KJgVmGGIXVyz0FbqJKyEDdKrhopU7/UUNOMfl/mo3S+ny+I8wMWQPKrB83aIeg/UwDop
         VJ7LzRsC4l4NNHFwXJ5Z7GNBNr9uqcWaXflWtF0y4gV1y3ny4F0UT9o7mClYp8+ODC/s
         x1ew==
X-Gm-Message-State: AOJu0YxGhjni7b00nwzpugSjVuBp1ot5Mmxge2m2l/poLQto+g1OWzKa
	0EVxJZu02ZfVos/jttghypHa2VCbwhXiSs2x5B1TVGUIBufGMEdHFcaBglMF29aUbd3xupcZJwG
	RRRp9
X-Gm-Gg: AR+sD13e/jldhpgG6enunGPue9WrQR1L8tzIyL+eR8agGvLY31yL/uPS1CsOc/J0wyc
	JeIxQ/+ZpUJOXYq3bYKgThkge6rytp+RDHEU7PjzCjYiAq99WHqdd7pdUHHsLnMarvUDCAfeWLT
	KxCPimcxAeVdgWenPhPZjVfpI/d4iSDQCStE5cot4wuUFKqJTpQ19brjVMoVxpqxX8nNOsfjU4s
	NwoSSXOnXucnI0uVTESJ5RwewWUKjW5i22kZBFccTJRZlZ4g05I8mv6T0/9k9fpN06UNoqli29R
	Vm8FZfnErIx2UBELFBcUk3GgC3ERpaTLKaRmHGMriNOKYqRf4IHTvsNdwOsU+UHChqy4RPz5/xu
	Jdz9erVEcBVjqWODBFXHdlOZqc9taZHD0314YL3Xhn7ctABq5j5lgwCKexixW2CMpmuMNvHmhHq
	XR94xJ8KxVosgI0aP+Y+kqqj3dnqKnL1dUuTY7rMOoSIA1vq3Wo23fMg==
X-Received: by 2002:a05:6a21:1644:b0:3b2:8685:1473 with SMTP id adf61e73a8af0-3c92a51df40mr12238146637.7.1785810699724;
        Mon, 03 Aug 2026 19:31:39 -0700 (PDT)
Received: from 92650adf53de ([20.38.40.137])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-3153e1886e7sm48600016eec.26.2026.08.03.19.31.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 03 Aug 2026 19:31:39 -0700 (PDT)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: [STATUS] stable/linux-6.6.y -
 aa0e49877a2e61e9f4ca10e039727a34f59e9964
From: KernelCI bot <bot@kernelci.org>
To: kernelci-results@groups.io
Cc: stable@vger.kernel.org
Reply-To: kernelci@lists.linux.dev
Date: Tue, 04 Aug 2026 02:31:39 -0000
Message-ID: <178581069862.6069.16895111882872883441@92650adf53de>



Hello,

Status summary for stable/linux-6.6.y

Dashboard:
https://d.kernelci.org/c/stable/linux-6.6.y/aa0e49877a2e61e9f4ca10e039727a34f59e9964/

giturl: https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git
branch: linux-6.6.y
commit hash: aa0e49877a2e61e9f4ca10e039727a34f59e9964
origin: maestro
test start time: 2026-08-03 10:15:52.855000+00:00

Builds:	   56 ✅    0 ❌    0 ⚠️
Boots: 	   77 ✅    0 ❌    0 ⚠️
Tests: 	 7878 ✅ 2086 ❌ 1326 ⚠️

### POSSIBLE REGRESSIONS
    
Hardware: mt8195-cherry-tomato-r2
  > Config: defconfig+lab-setup+arm64-chromebook+CONFIG_MODULE_COMPRESS=n+CONFIG_MODULE_COMPRESS_NONE=y
    - Architecture/compiler: arm64/gcc-14
      - kernelci_watchdog_reset.wdt-reset.wdt-get-timeout
      last run: https://d.kernelci.org/test/maestro:6a7075b654179f15da91af6e
      history:  > ✅  > ❌  > ❌  
            


### FIXED REGRESSIONS
    
Hardware: sc7180-trogdor-kingoftown
  > Config: defconfig+lab-setup+arm64-chromebook+CONFIG_MODULE_COMPRESS=n+CONFIG_MODULE_COMPRESS_NONE=y
    - Architecture/compiler: arm64/gcc-14
      - kernelci_watchdog_reset.wdt-reset.wdt-trigger-reset
      last run: https://d.kernelci.org/test/maestro:6a70747954179f15da919cf4
      history:  > ❌  > ✅  > ✅  
            


### UNSTABLE TESTS
    
Hardware: bcm2711-rpi-4-b
  > Config: defconfig+arm64-chromebook+kselftest
    - Architecture/compiler: arm64/gcc-14
      - kselftest.mm.mm_run_vmtests_sh
      last run: https://d.kernelci.org/test/maestro:6a70be8254179f15da9485b2
      history:  > ❌  > ⚠️  > ❌  
            
      - kselftest.mm.mm_run_vmtests_sh_khugepaged
      last run: https://d.kernelci.org/test/maestro:6a70be8254179f15da9485d7
      history:  > ❌  > ⚠️  > ❌  
            
      - kselftest.mm.mm_run_vmtests_sh_split_huge_page_test
      last run: https://d.kernelci.org/test/maestro:6a70be8254179f15da9485d5
      history:  > ❌  > ✅  > ❌  
            


Sent every day if there were changes in the past 24 hours.
Legend: ✅ PASS   ❌ FAIL  ⚠️ INCONCLUSIVE

--
This is an experimental report format. Please send feedback in!
Talk to us at kernelci@lists.linux.dev

Made with love by the KernelCI team - https://kernelci.org
