Received: from mail-pl1-f173.google.com (mail-pl1-f173.google.com [209.85.214.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 55C5330FC26
	for <stable@vger.kernel.org>; Sat,  8 Aug 2026 02:30:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786156211; cv=none; b=CLenT6gM6P5fk1CcXU1x24/RNwUFvIRGTAgQMjlpyx+CV+I0s4HW3Nx2CuwJ1QPvSTLHaNg64pIpBLsGiRq+ut9kCRZHJFUzjoDAxba1ow6KtWGXoK1pf7j9q6UEq+9zEnO5yMn2RnS7oQRyVkGpXC83zDjHtLGd0OS/eMsAnD8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786156211; c=relaxed/simple;
	bh=ZU6OPA7vZrGn4nbX0QOF3aq0DdVKoNu+RzE3SD5KE4Q=;
	h=Content-Type:MIME-Version:Subject:From:To:Cc:Date:Message-ID; b=M78D8SRwPsA08M/ESYjzej3PzJt9N1ibwO12wj7OVV+o8zOUiXkAGrxxqb9Ugyi6nuz73heuBpBASRHCncdlnMTdABUTkFmFYZ47avt+hBeiJnQp46ycgj4fdi6zxfwkvJQQLh+6uEadkp+eILNfI/mheSmnK+InQtxWPyZSzkI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=kernelci.org; spf=pass smtp.mailfrom=kernelci.org; dkim=pass (2048-bit key) header.d=kernelci.org header.i=@kernelci.org header.b=PrV6bBq+; arc=none smtp.client-ip=209.85.214.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=kernelci.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernelci.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernelci.org header.i=@kernelci.org header.b="PrV6bBq+"
Received: by mail-pl1-f173.google.com with SMTP id d9443c01a7336-2cfff5f88dbso2872795ad.3
        for <stable@vger.kernel.org>; Fri, 07 Aug 2026 19:30:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci.org; s=google; t=1786156208; x=1786761008; darn=vger.kernel.org;
        h=message-id:date:reply-to:cc:to:from:subject
         :content-transfer-encoding:mime-version:content-type:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=w+NktnFEaXR0e1cTVlcevHG4ufKVO88eeNbH3nqrH/8=;
        b=PrV6bBq+AurPSq0DfFjWwJCpZjlt5Q21nfpGV3KZcb8YyZVx2G2oeDIJHLpxuGCLiF
         th+bTe5KZOtv1Mv4MFWe1Ql0wjlvJcvBscBysd9H/Vb+EwyiQskduuil4uHEMW1WQHpc
         8klivb+LbDqMKfLBOxgMEUf9X4+gDRzSV0GpnlYO6kMEWqR8CrDD8cbRHZmaypcaimEE
         m3uo5vcVp7SHvPhOQwx7w5epgrdUPf3H/RpjpMIENIvukCloJcZ7TPwGL1ydEOiEDcNw
         WIPoeqXBq66fJILBDIVoLzskrTFy9VeJ+qSeiRCJ0UQ0kp8r+z5K8aD3NQY0qYxalpCc
         YGnw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786156208; x=1786761008;
        h=message-id:date:reply-to:cc:to:from:subject
         :content-transfer-encoding:mime-version:content-type:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=w+NktnFEaXR0e1cTVlcevHG4ufKVO88eeNbH3nqrH/8=;
        b=Hq9hG8NknP4Jbyu0n4jzx7AQFVkLv/4HmEWfkAU7LbcXLOYqdiGsjFyHmQS1hVAFXx
         pQ9t+pbR36Yj8AXZbd0P+j1sgQ9Znz9JjbwfIZEqy1vsU1ePzqEvJnMr2Zo+51JZIqgO
         u6BkoM2bpMXaQbhUMQs1XpfgphmdMrd4NT7FwLgY+jic45zeoO6e31CtZSA+1oYRKo5s
         FmcDslTtWpF8L9IYLw+KuIjMtHFeOf+QCN/r3AK0CVma7dvDFx57n60Ujaulan9S6Lyq
         RjrvnF+suFPOBHk3Y33UopuZtUCBb/uDmAifcw4asdTjtRxj5YASEmII3J1NQI9cfLiL
         aTwQ==
X-Gm-Message-State: AOJu0YzNfbb9hWuOEivgzFlGD4/+mSwUywttrwuy0Sz93C39MOlmiu5Z
	kYpGynW5xff5spNbD9H/KaVOs6Va0H//Zl5cMj2AaXYXd+Z4U2YcRQ8WWSQLO5Ku3eY=
X-Gm-Gg: AR+sD11PONrbkSB196/MRa6eafFwd+vh2PAzJMo2CLkMjo/3L6z9b6cv3Jz0Vrfp+5s
	HS28TiLM82Jdlx/mr9OMZYETid10JObyRzmbKjeYmwX7NgadSRzkcgn5GmxAy/pJ1ZyAwKXJzTB
	IlSTdxLhO/7aqFwN1aO5tLP1lURwDMEwkCHqQTFWyfecegDYEyPQrygi3cbiFwnWmo4/5ZC9goM
	i9xDuhNNjR/nTPtkA1jq78FmlKB+P0qjYdNJJXqFxrCq1IhMRy9N5Re+95VIFtG0JF9UqKKLuef
	hnravhp0BvHCmBkyHYqksEmcn/6fJW5j/GlsRydUk39n0setVsMZTudKHzIbm6ygW8uQxQkBAPu
	BjSmTVx8+H4yvTtSM5eTVp16Y2fzPNdB8Qk0ZNOiQ/5n6IR4z8J2FOkAVS268vxKsA8SDeE4x+6
	r4gDA8nEgsOTRakrNYdIIxWkZT9MlBR9wgOG3fkGD/m/0vZtCy8Pxj2Qo=
X-Received: by 2002:a05:6a21:3a82:b0:3c3:791e:5e18 with SMTP id adf61e73a8af0-3cb85df09cbmr32723378637.7.1786156208034;
        Fri, 07 Aug 2026 19:30:08 -0700 (PDT)
Received: from 9a65d8f5b626 ([20.38.40.137])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-315bec29672sm13283341eec.29.2026.08.07.19.30.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 07 Aug 2026 19:30:07 -0700 (PDT)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: [STATUS] stable/linux-6.6.y -
 6436c12a2ced865a3382b867e3882d08c2d2bf8d
From: KernelCI bot <bot@kernelci.org>
To: kernelci-results@groups.io
Cc: stable@vger.kernel.org
Reply-To: kernelci@lists.linux.dev
Date: Sat, 08 Aug 2026 02:30:07 -0000
Message-ID: <178615620654.286.8492829844994782316@9a65d8f5b626>



Hello,

Status summary for stable/linux-6.6.y

Dashboard:
https://d.kernelci.org/c/stable/linux-6.6.y/6436c12a2ced865a3382b867e3882d08c2d2bf8d/

giturl: https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git
branch: linux-6.6.y
commit hash: 6436c12a2ced865a3382b867e3882d08c2d2bf8d
origin: maestro
test start time: 2026-08-07 06:49:26.567000+00:00

Builds:	   56 ✅    0 ❌    0 ⚠️
Boots: 	   63 ✅    0 ❌    0 ⚠️
Tests: 	 5485 ✅ 1842 ❌  210 ⚠️

### POSSIBLE REGRESSIONS

  No possible regressions observed.


### FIXED REGRESSIONS
    
Hardware: mt8183-kukui-jacuzzi-juniper-sku16
  > Config: defconfig+lab-setup+arm64-chromebook+CONFIG_MODULE_COMPRESS=n+CONFIG_MODULE_COMPRESS_NONE=y
    - Architecture/compiler: arm64/gcc-14
      - kernelci_watchdog_reset.wdt-reset.wdt-get-timeout
      last run: https://d.kernelci.org/test/maestro:6a758b7662f33761c08e57fd
      history:  > ❌  > ❌  > ✅  
            


### UNSTABLE TESTS

  No unstable tests observed.


Sent every day if there were changes in the past 24 hours.
Legend: ✅ PASS   ❌ FAIL  ⚠️ INCONCLUSIVE

--
This is an experimental report format. Please send feedback in!
Talk to us at kernelci@lists.linux.dev

Made with love by the KernelCI team - https://kernelci.org
