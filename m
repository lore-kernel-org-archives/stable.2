Received: from mail-pf1-f174.google.com (mail-pf1-f174.google.com [209.85.210.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AED672309B2
	for <stable@vger.kernel.org>; Fri, 31 Jul 2026 02:30:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785465038; cv=none; b=CsFr0M6QbX3XIVLgjIv80998nwq7GB3yqPX/6/M533RfONnvOL8RwO0n7u+a8d1No/XFtgW5tv9Gn0bI6YjPQoiaJoa5QSNnJzk1VKOteXJYUG31CJ3pbFjhS0jMjf5SbD7N3tASIRFs6LFVd1wpA3E6JfF9xDkhtPR3mpFDDzE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785465038; c=relaxed/simple;
	bh=4CmpQCLLyM5vZ07moDU7qwMQ78V35CCFMvMgRZiyS4o=;
	h=Content-Type:MIME-Version:Subject:From:To:Cc:Date:Message-ID; b=K5S8Sb0B5tND0oOY95RFvu/yJrGB7G3Y4CwQJZLphP5j+8rBE1uofyNnLNPUuwHmdhNbKEZKwaRegNiy5TRGxxb9JxNhnwsCd+2gyerwlB9o/2GeqqR8IGvsEbURh/0xLk3HvD2bY73J8UIxeJHDCOiBjgUkiOjZSQp8IXn4qZA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=kernelci.org; spf=pass smtp.mailfrom=kernelci.org; dkim=pass (2048-bit key) header.d=kernelci.org header.i=@kernelci.org header.b=d4NarkPY; arc=none smtp.client-ip=209.85.210.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=kernelci.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernelci.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernelci.org header.i=@kernelci.org header.b="d4NarkPY"
Received: by mail-pf1-f174.google.com with SMTP id d2e1a72fcca58-84874b52eabso778924b3a.0
        for <stable@vger.kernel.org>; Thu, 30 Jul 2026 19:30:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci.org; s=google; t=1785465036; x=1786069836; darn=vger.kernel.org;
        h=message-id:date:reply-to:cc:to:from:subject
         :content-transfer-encoding:mime-version:content-type:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=JrUcCfVDICl1pZnJUpOt/09Eet/KP9AjECx4QmWqDsQ=;
        b=d4NarkPYEBADqv8xCyGsh9zFjfk2ofsuKQ6rBjzd237V+nx9k5wwDfYSnqMDTPt7bV
         828F0jCvHgSKfuTI0Ps2CpOb3Jc8V4jaATvksTWin70ePBfta11iMqiPf3oYC9U74RRu
         1jYN5DS7w+abSoKGCxLK8UBgWrTtj7GV1kQHqLa6+AFdLyGMWQI68iUKuCpA6g6aFFKP
         XYrG8ENBL/3oTQXLm6ZIdpQqn7RrxbAGTqKrEocQU+QIcQ18FNyNqNz/ADb4TFQ3sCiI
         1UIEOliRAeKujJ2DIfgD5mA3MyAa4lZjK5CLezn16QTM+ZudfuKlX0pAyD+KiYU8OCMT
         blTw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785465036; x=1786069836;
        h=message-id:date:reply-to:cc:to:from:subject
         :content-transfer-encoding:mime-version:content-type:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=JrUcCfVDICl1pZnJUpOt/09Eet/KP9AjECx4QmWqDsQ=;
        b=owh5tYib3ibj4t7WYL9NK6h9SM7GZHtEbhg/+PnL4+RKWoK7R4U15eHnh+h1QZojKu
         +c3PhJkye9vw+hAgckUScrOiGWZDSPM1iYySiNPqThB2uDDyk95oPqtWkKTi1yiOBuDn
         Yzx1Pa+3yQN3rcB1kEidscalq5UAhzH0C8wGO+gPNmeTcAPmbnrOfHA6iE7hDOFT/gEH
         TF6ZPrsDaIQ9Y/aXqgUBK+9q6A3mXu+RPR7p/rPyFHvGROzDypKACBDcXtFWzUD4RYF5
         E+Q7xR9VUdIsvM2Nw8oMvHCE5krfxGhn3eT6wV4ChMf0nsDiR03qN4gmaAwuL+gURSgQ
         daDg==
X-Gm-Message-State: AOJu0Yy6bxoU1sTajHXtTc+ErGSo2PFoKmVayIPOfEzKE2bEc1bnrVh8
	Ff0JZLgkpIIJ73b6VFfrIFw5Xa0eN5sG+OcsHBes/yyHCGqejoWgEBGVZ8zL0ubdmVXorCq8pJP
	6N+bP
X-Gm-Gg: AR+sD119NddeSS4Rsd2QtZNqla7h3FTQJh/jLerJwCIJUDfYtLir0ykPmlJBVIF5omq
	cV/RCXLXP84ZR/ern1FPfOt/kFL1xAYdsMScysAJLywt9MSgbYPhTUyDhCsWqHTj41Zbbx/ZK4P
	mkI4BzNKjADD1D3cRj0hUH6bQYCw+5WJFr5tYuGKpqqfHT4u1Xr0t001Wiey6Q2lJSB1n/GSvyX
	RKmYvgQb1RH0g/RaD9q9lMs/4N4diRH4pVFeX2SPSr2NPVPd2zpFoDtiisdKDj6/iGWPaPnV04j
	ZmgzgVZ15iYdFcP0BWqOXIVaFnG1zUvasW+PuXhFy7xXgqv0xiiVkL02BfIig1ZuQY5rjGaJgEk
	yZV0IUaivuhDd6lAc1UBaM84uFPG5vB0SrtisVZvZ6z7RsUuJG12iZsOV+nnz8zBDsr3FbqeeOA
	8/khi4JYO2OwLs/F7wy36YbW4XYy0NhB0/oiP/44EBI+VIlM1IqqwGpg==
X-Received: by 2002:a05:6a21:116:b0:3c0:b62a:2b89 with SMTP id adf61e73a8af0-3c91b3fe226mr26887637.67.1785465035945;
        Thu, 30 Jul 2026 19:30:35 -0700 (PDT)
Received: from 92650adf53de ([20.38.40.137])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-13fa748fbc6sm396900c88.8.2026.07.30.19.30.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 30 Jul 2026 19:30:35 -0700 (PDT)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: [STATUS] stable/linux-6.6.y -
 a1153c0deb44f75190f07677c0c6d61efd887246
From: KernelCI bot <bot@kernelci.org>
To: kernelci-results@groups.io
Cc: stable@vger.kernel.org
Reply-To: kernelci@lists.linux.dev
Date: Fri, 31 Jul 2026 02:30:35 -0000
Message-ID: <178546503473.4267.11350335257938373822@92650adf53de>



Hello,

Status summary for stable/linux-6.6.y

Dashboard:
https://d.kernelci.org/c/stable/linux-6.6.y/a1153c0deb44f75190f07677c0c6d61efd887246/

giturl: https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git
branch: linux-6.6.y
commit hash: a1153c0deb44f75190f07677c0c6d61efd887246
origin: maestro
test start time: 2026-07-30 11:31:38.829000+00:00

Builds:	   56 ✅    0 ❌    0 ⚠️
Boots: 	   73 ✅    0 ❌    0 ⚠️
Tests: 	 6041 ✅ 2002 ❌  229 ⚠️

### POSSIBLE REGRESSIONS

  No possible regressions observed.


### FIXED REGRESSIONS
    
Hardware: sc7180-trogdor-lazor-limozeen
  > Config: defconfig+lab-setup+arm64-chromebook+CONFIG_MODULE_COMPRESS=n+CONFIG_MODULE_COMPRESS_NONE=y
    - Architecture/compiler: arm64/gcc-14
      - kernelci_watchdog_reset.wdt-reset.wdt-trigger-reset
      last run: https://d.kernelci.org/test/maestro:6a6b4b1c798ea6c1ef90cc48
      history:  > ❌  > ✅  > ✅  
            


### UNSTABLE TESTS
    
Hardware: sc7180-trogdor-kingoftown
  > Config: defconfig+lab-setup+arm64-chromebook+CONFIG_MODULE_COMPRESS=n+CONFIG_MODULE_COMPRESS_NONE=y
    - Architecture/compiler: arm64/gcc-14
      - kernelci_watchdog_reset.wdt-reset.wdt-trigger-reset
      last run: https://d.kernelci.org/test/maestro:6a6b4753798ea6c1ef90ae9a
      history:  > ✅  > ❌  > ✅  
            
Hardware: mt8195-cherry-tomato-r2
  > Config: defconfig+lab-setup+arm64-chromebook+CONFIG_MODULE_COMPRESS=n+CONFIG_MODULE_COMPRESS_NONE=y
    - Architecture/compiler: arm64/gcc-14
      - kernelci_watchdog_reset.wdt-reset.wdt-get-timeout
      last run: https://d.kernelci.org/test/maestro:6a6b4850798ea6c1ef90bb11
      history:  > ❌  > ✅  > ❌  
            


Sent every day if there were changes in the past 24 hours.
Legend: ✅ PASS   ❌ FAIL  ⚠️ INCONCLUSIVE

--
This is an experimental report format. Please send feedback in!
Talk to us at kernelci@lists.linux.dev

Made with love by the KernelCI team - https://kernelci.org
