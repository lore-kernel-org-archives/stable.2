Received: from mail-pg1-f179.google.com (mail-pg1-f179.google.com [209.85.215.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3717022A4E1
	for <stable@vger.kernel.org>; Fri, 28 Aug 2026 02:30:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787884233; cv=none; b=RrC52wQ1WRRNuuNHWDCLDEKpsw07bdYzfKhl3SP37zzQbY3x7aLfkUY9Sx8SKus08heb1SqNdckUfXe1fA6xdX+pD0wI6tKxRRKO0LbKTQjRbC6m+3QuMeAtFcoy3qsorhB4BYij81AqmkI+MJjUdDd1V7j1B/65pM1qJmSAu2E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787884233; c=relaxed/simple;
	bh=1zlwdzXzTugteWVD/PpPX3Q+dB0iZnP+Tj/jXcXOklw=;
	h=Content-Type:MIME-Version:Subject:From:To:Cc:Date:Message-ID; b=YW1Fdt0W96tgRVc3Q6YbylaUonoQJ2YJTT4ofGlEf/obWTgcm765eqrcawI2sq92SWIPcmsw2F4wZDHvJnQA7OMobGCCBk6W+F0igzvdZn/v1EFokTy+ldm5zqlMz+uiysjUAgEjE/y2YsLeUK0Rs6G+JS0L1eOnxi/oldC5lLA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=kernelci.org; spf=pass smtp.mailfrom=kernelci.org; dkim=pass (2048-bit key) header.d=kernelci.org header.i=@kernelci.org header.b=BUeQlC3C; arc=none smtp.client-ip=209.85.215.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=kernelci.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernelci.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernelci.org header.i=@kernelci.org header.b="BUeQlC3C"
Received: by mail-pg1-f179.google.com with SMTP id 41be03b00d2f7-cc1ceadbd16so403069a12.2
        for <stable@vger.kernel.org>; Thu, 27 Aug 2026 19:30:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci.org; s=google; t=1787884231; x=1788489031; darn=vger.kernel.org;
        h=message-id:date:reply-to:cc:to:from:subject
         :content-transfer-encoding:mime-version:content-type:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=1Ht5cjCVO5CtyzknVOJmcQoZ0VpVFsQg3Od+g5KndyA=;
        b=BUeQlC3C/QxfYsL0Ecy2tnMYZ433tv0Mf3p6GNam0tTeVHAaRhQZbssI2h75/QrCZ1
         jtG25acVX6tbZhCTH7jNh5hV7udiTpWBzAGo0WeUWSF30JktgzQfa621zRrDxWFsX96L
         52BAznLILVWA4aq4xj3olP7rxuLbg/iiukoO3wOUoBcUhsl4GVsdNlKQ8FYVsMTkr8xl
         E1PFIcG5ve01sAduPxlifUkOyinMpx8Igw0C4WGY3pSrERtCr5EG6MJttvXaNNmRNvMK
         mfwAoAcW1oVLVyQutZWZW9GwlekcoZfDTzCuhCET7wYw74ZKMRF7IZ4pavwSoRrphp2M
         +k5g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787884231; x=1788489031;
        h=message-id:date:reply-to:cc:to:from:subject
         :content-transfer-encoding:mime-version:content-type:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=1Ht5cjCVO5CtyzknVOJmcQoZ0VpVFsQg3Od+g5KndyA=;
        b=ZMybdxq2hIy0CksaEm3Gah2xvbumJ4ww7046byU5sSl4KRor+7ATz9qwgT5+FRpp89
         WlMp+ZkI1tv1ALZrylNuH1N1IuSr23u054zsINyHsiFzKBq7T53eGoF2bD7SzzrlevVP
         SeY9yr60bEBQjLilprVo62fevwCQRanzC1VUHF8cS3IUDcvxJ+f2cXT4SwNa6e/Zur68
         v0Ypol4/lsla3IlTn7dQyHYo9ZV+Y++snTV24LuKll2Up4fz6/jyRBlQKWeQAfLedrLB
         JeRJux5I/mRV3zf9meCni6aUkg4ancQQhoXqtbW3mt85jpit4WCnZPVlOvI75RH7TD3P
         CfpA==
X-Gm-Message-State: AFuF++mX8RKZ3nZfKE8rSB1nt1uKNUdK1OZ1LOaL17xcTgzWMSgyEx2G
	Bx36EY1kdzRht8NS2lsgC3EJVbOVdYVaDQcJLlboNL/JYk+gKXaUQfoMSpukVLMHoyg=
X-Gm-Gg: AR+sD12JNibeaU+ZNS6cmB6ZHcFcHCXA0wKNqGsAQXEoHiyRsPdl68F8JGY2R/CbKbf
	wcYBZsH4gPcQmqu+In0252HPTrPJAeN0eeozY/aegBSA9lcMkCaLPwb+mESfVQN4UEqqoW52TP/
	ToYFHKRNuqI9R3TtGFadHi6i8cfgMbwVz2DZdxXersA8T46UxHykZJ2qzZnlm7f65baqj6kZmCz
	75xljeSwGygimJCdzrpOMuWa8mXzzXTVc36haG+e7CYjv089vNTCmwnxqaUBkDZfozWJPtjgsDs
	zk2J85SeeJrk76QxoyzVL8RWQm6ZojhWufKG5my4nm6792Ch+vugwI2cXmy66COmvs9uyiCyWRG
	uap+DoiPiNORx5C4zESfW4iYrXni9I+L37GhuVx5sJQwZaHsytBsJwN66eMOMcKK936c7usbnZW
	xL+8A8GNEB0JwVnANhfyknyCDqRCzPPWbJSNOwvpGWrrUKRN+Goi4Z
X-Received: by 2002:a17:90b:3d88:b0:38e:5964:97a8 with SMTP id 98e67ed59e1d1-396d0f52b40mr7521315a91.16.1787884231431;
        Thu, 27 Aug 2026 19:30:31 -0700 (PDT)
Received: from b455de3d9de8 ([20.38.40.137])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-142e0df264csm2073186c88.14.2026.08.27.19.30.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 27 Aug 2026 19:30:30 -0700 (PDT)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: [STATUS] stable/linux-6.12.y -
 8b74a2fbba5adab77f2ea88386e9d9fc224be987
From: KernelCI bot <bot@kernelci.org>
To: kernelci-results@groups.io
Cc: stable@vger.kernel.org
Reply-To: kernelci@lists.linux.dev
Date: Fri, 28 Aug 2026 02:30:30 -0000
Message-ID: <178788423040.5582.3522868379850167467@b455de3d9de8>



Hello,

Status summary for stable/linux-6.12.y

Dashboard:
https://d.kernelci.org/c/stable/linux-6.12.y/8b74a2fbba5adab77f2ea88386e9d9fc224be987/

giturl: https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git
branch: linux-6.12.y
commit hash: 8b74a2fbba5adab77f2ea88386e9d9fc224be987
origin: maestro
test start time: 2026-08-27 13:10:47.668000+00:00

Builds:	   56 ✅    0 ❌    0 ⚠️
Boots: 	   47 ✅    0 ❌    0 ⚠️
Tests: 	 8181 ✅  536 ❌  262 ⚠️

### POSSIBLE REGRESSIONS
    
Hardware: qcs6490-rb3gen2
  > Config: defconfig+lab-setup+kselftest
    - Architecture/compiler: arm64/gcc-14
      - kselftest.proc
      last run: https://d.kernelci.org/test/maestro:6a905175c5867fba9464a69b
      history:  > ✅  > ❌  
            
      - kselftest.proc.proc_read
      last run: https://d.kernelci.org/test/maestro:6a907145c5867fba9465ed1b
      history:  > ✅  > ❌  
            


### FIXED REGRESSIONS
    
Hardware: acer-cbv514-1h-34uz-brya
  > Config: x86_64_defconfig+lab-setup+x86-board+kselftest
    - Architecture/compiler: x86_64/gcc-14
      - kselftest.iommu.shardfile-iommu
      last run: https://d.kernelci.org/test/maestro:6a90487ac5867fba946460d1
      history:  > ❌  > ✅  
            
Hardware: acer-chromebox-cxi5-brask
  > Config: x86_64_defconfig+lab-setup+x86-board+kselftest
    - Architecture/compiler: x86_64/gcc-14
      - kselftest.iommu.shardfile-iommu
      last run: https://d.kernelci.org/test/maestro:6a904897c5867fba946463cc
      history:  > ❌  > ✅  
            
Hardware: acer-cp514-2h-1130g7-volteer
  > Config: x86_64_defconfig+lab-setup+x86-board+kselftest
    - Architecture/compiler: x86_64/gcc-14
      - kselftest.iommu.shardfile-iommu
      last run: https://d.kernelci.org/test/maestro:6a90487dc5867fba946460e8
      history:  > ❌  > ✅  
            
Hardware: acer-cp514-2h-1160g7-volteer
  > Config: x86_64_defconfig+lab-setup+x86-board+kselftest
    - Architecture/compiler: x86_64/gcc-14
      - kselftest.iommu.shardfile-iommu
      last run: https://d.kernelci.org/test/maestro:6a90489dc5867fba9464655e
      history:  > ❌  > ✅  
            
Hardware: acer-cp514-3wh-r0qs-guybrush
  > Config: x86_64_defconfig+lab-setup+x86-board+kselftest
    - Architecture/compiler: x86_64/gcc-14
      - kselftest.iommu.shardfile-iommu
      last run: https://d.kernelci.org/test/maestro:6a9048a0c5867fba9464668a
      history:  > ❌  > ✅  
            
Hardware: acer-R721T-grunt
  > Config: x86_64_defconfig+lab-setup+x86-board+kselftest
    - Architecture/compiler: x86_64/gcc-14
      - kselftest.iommu.shardfile-iommu
      last run: https://d.kernelci.org/test/maestro:6a9048bac5867fba946468e9
      history:  > ❌  > ✅  
            
Hardware: asus-CM1400CXA-dalboz
  > Config: x86_64_defconfig+lab-setup+x86-board+kselftest
    - Architecture/compiler: x86_64/gcc-14
      - kselftest.iommu.shardfile-iommu
      last run: https://d.kernelci.org/test/maestro:6a9048a6c5867fba946466f5
      history:  > ❌  > ✅  
            
Hardware: asus-CX3402CVA-brya
  > Config: x86_64_defconfig+lab-setup+x86-board+kselftest
    - Architecture/compiler: x86_64/gcc-14
      - kselftest.iommu.shardfile-iommu
      last run: https://d.kernelci.org/test/maestro:6a904879c5867fba946460c9
      history:  > ❌  > ✅  
            
Hardware: dell-latitude-3445-7520c-skyrim
  > Config: x86_64_defconfig+lab-setup+x86-board+kselftest
    - Architecture/compiler: x86_64/gcc-14
      - kselftest.iommu.shardfile-iommu
      last run: https://d.kernelci.org/test/maestro:6a9048a0c5867fba94646682
      history:  > ❌  > ✅  
            
Hardware: hp-x360-14a-cb0001xx-zork
  > Config: x86_64_defconfig+lab-setup+x86-board+kselftest
    - Architecture/compiler: x86_64/gcc-14
      - kselftest.iommu.shardfile-iommu
      last run: https://d.kernelci.org/test/maestro:6a9048e0c5867fba94646cca
      history:  > ❌  > ✅  
            
Hardware: lenovo-TPad-C13-Yoga-zork
  > Config: x86_64_defconfig+lab-setup+x86-board+kselftest
    - Architecture/compiler: x86_64/gcc-14
      - kselftest.iommu.shardfile-iommu
      last run: https://d.kernelci.org/test/maestro:6a904919c5867fba94646fde
      history:  > ❌  > ✅  
            


### UNSTABLE TESTS

  No unstable tests observed.


Sent every day if there were changes in the past 24 hours.
Legend: ✅ PASS   ❌ FAIL  ⚠️ INCONCLUSIVE

--
This is an experimental report format. Please send feedback in!
Talk to us at kernelci@lists.linux.dev

Made with love by the KernelCI team - https://kernelci.org
