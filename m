Received: from mail-pf1-f173.google.com (mail-pf1-f173.google.com [209.85.210.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 758962AF00
	for <stable@vger.kernel.org>; Sat, 29 Aug 2026 02:31:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787970661; cv=none; b=UzrHmrWKn9NJzDsRgYETYyWMLGO9vgmankjMg2H4S3ryyquxOt2lbmF//kHs9Ouvb3z0+6P8G8mk1A73gllfAGfAoR7dxnwonUQcKONW9WU9NAROlF//DJ8RgkJITEJzTzsCfO+/MrQDBIf5ccOWPpG46J3mlGspRaXdeOmWlXU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787970661; c=relaxed/simple;
	bh=JLRqHca6V5+8EONR3KrMaVml6BhoNvZisjlrB4PMfVQ=;
	h=Content-Type:MIME-Version:Subject:From:To:Cc:Date:Message-ID; b=lbnzWvoYL6f851Dd1IAYgGjUVDCpAxUWspZ25qrtx+CYm2FBm7+3YcTs7eKjCtkI2rjTW3sP4mtjtHJnj+7PFrN1xShUoE7N6NRaRo9AoLDua4Z9b6Kaa/l5afCIkGUJbSglCuobAjo5pZW9Wch7f8WIGut9oMFsv2kYtgqKv6Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=kernelci.org; spf=pass smtp.mailfrom=kernelci.org; dkim=pass (2048-bit key) header.d=kernelci.org header.i=@kernelci.org header.b=eyFiyo6b; arc=none smtp.client-ip=209.85.210.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=kernelci.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernelci.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernelci.org header.i=@kernelci.org header.b="eyFiyo6b"
Received: by mail-pf1-f173.google.com with SMTP id d2e1a72fcca58-853c401326eso1031913b3a.2
        for <stable@vger.kernel.org>; Fri, 28 Aug 2026 19:31:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci.org; s=google; t=1787970660; x=1788575460; darn=vger.kernel.org;
        h=message-id:date:reply-to:cc:to:from:subject
         :content-transfer-encoding:mime-version:content-type:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=Db3JAqua+/rhxmKBrFo8UwBAuuZcADahbrV4QQKckH0=;
        b=eyFiyo6booJvf/e1lVcuT32xg6fkbyfkgCfu3EQQx5qFRA3T8zMJ+f9k72nhF/AEUd
         LEPXrEbGKByy/y0ibXAn8JI/mRmd8ueIPszhvufpC993NJvTwsmBZ4AgOovH/RRqOqaQ
         rYRXfnHhgpilYMZSXjS6TMG7bPXr28Lxm1ptwmt8FeufjzCbvT/Rxc1sh8Y5E0AawJsI
         AttKgOsskXzy0n8RAxCFP0Sup6r5vYYlapXgMFKDQBE3TwnPU51Rx+QUr09A7TMH8iC3
         okBTl9keJoplX7G9mapcCNz4lcq4HHyxsxg2DiTePWYOKn6dusMyUrjbDKdHvxfmqr3i
         ZnzA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787970660; x=1788575460;
        h=message-id:date:reply-to:cc:to:from:subject
         :content-transfer-encoding:mime-version:content-type:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=Db3JAqua+/rhxmKBrFo8UwBAuuZcADahbrV4QQKckH0=;
        b=g5LdzucfOvM9657a9r7TodIVN1tMDJZu6n4rOUXbeInnDn1T3RzGvNKKMFmiNX+yja
         jZlyuLgzTkedmtntQlqG4OK+Xc+NL4XaXqZOFcQ94bqGix5meiwIwwc72+aT3jSMLrVO
         Nk4af4fosD26q8zV/pBvEUk3OZMum4p5iN8HiWn71X5DDjgpbmg5b5sxortuOca1IMZI
         zLb2jWdhGKDJHAx+wcYdEhfGRlOYZoPZk0qXFfjHhvDe9tVIZxzZz9a7ml6gyu5XQXtk
         eIkD1NJHMmg1xE5zpksMNbQswkhxSCFAvmCw1vr2c7TOzNho5TqJ3gm+wqxeSQJzm+7G
         8dRw==
X-Gm-Message-State: AFuF++kmTpfWkmB4SVoMNybtEVvuD0Hf+HuwGUdJ6OtJBI2EgaekOhjL
	X2u3OYBirX65GpjJVln95SxYAk+KxEAGuabTTL5zPa9Ty6weXAyO8+IRV4HorQ8qeqrTPU2Tm2d
	bfMJx
X-Gm-Gg: AR+sD10b9QDZ8ov/TgWub1v9v+fyAaVtSlAjqEUH+oryK0JXp05jUCsC/TzyWFLVHXV
	VPPBn0D5FB9ACfuH2adBUSI/DUx2zC2wqmOEvTnHSgDlErFl7yYS/QgUvAegXcrAwm9TDsq9Gqk
	RoQWh3BcAGY10jsFF1etffE8nR3kiiimRkox9W8PzVI8OnLzu2YWC9WnaRWyrYolk56zK4qJFxc
	R67ts0DCm7nkYl5SqaHbQ3lYO/ePM9djC4XEX4fCw8Zlfm14/1G5Iaf+QGq97Ssqy3iL91nRmj4
	UXaSCKoPqE/aj7ZY8285t/hlfIPsJdFAtDQziE0LZ6Dr/wtRp1+S1x6reiQTIDOf/X1eAlCiV4d
	yzbJdDbNMzJF6lbPVGXX81se5uE2UDWUjffhZfpJQZknCjv9l+uIIa7pN7opCU9LYH0GW/7IDae
	6Gd/Zh+aJYO7YkUbBRkbDaBsAtPIhf5OmjZjVmtdWPqh2cJzb9oVIB
X-Received: by 2002:a05:6a20:3ca1:b0:3d3:adbf:777e with SMTP id adf61e73a8af0-3d3adbf81b8mr5321368637.19.1787970659732;
        Fri, 28 Aug 2026 19:30:59 -0700 (PDT)
Received: from b455de3d9de8 ([20.38.40.137])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-3286f7bc825sm11600770eec.9.2026.08.28.19.30.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 28 Aug 2026 19:30:59 -0700 (PDT)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: [STATUS] stable/linux-6.12.y -
 f717995cb7dcd8998ab15516b8006aea09cfde0d
From: KernelCI bot <bot@kernelci.org>
To: kernelci-results@groups.io
Cc: stable@vger.kernel.org
Reply-To: kernelci@lists.linux.dev
Date: Sat, 29 Aug 2026 02:30:58 -0000
Message-ID: <178797065856.6229.10796431688656345044@b455de3d9de8>



Hello,

Status summary for stable/linux-6.12.y

Dashboard:
https://d.kernelci.org/c/stable/linux-6.12.y/f717995cb7dcd8998ab15516b8006aea09cfde0d/

giturl: https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git
branch: linux-6.12.y
commit hash: f717995cb7dcd8998ab15516b8006aea09cfde0d
origin: maestro
test start time: 2026-08-28 07:16:01.786000+00:00

Builds:	   52 ✅    0 ❌    0 ⚠️
Boots: 	   48 ✅    0 ❌    0 ⚠️
Tests: 	 7800 ✅  484 ❌  271 ⚠️

### POSSIBLE REGRESSIONS
    
Hardware: mt8183-kukui-jacuzzi-juniper-sku16
  > Config: defconfig+lab-setup+arm64-chromebook+CONFIG_MODULE_COMPRESS=n+CONFIG_MODULE_COMPRESS_NONE=y
    - Architecture/compiler: arm64/gcc-14
      - kernelci_watchdog_reset.wdt-reset.wdt-get-timeout
      last run: https://d.kernelci.org/test/maestro:6a91485fc5867fba946b0051
      history:  > ✅  > ❌  
            
Hardware: mt8195-cherry-tomato-r2
  > Config: defconfig+lab-setup+arm64-chromebook+CONFIG_MODULE_COMPRESS=n+CONFIG_MODULE_COMPRESS_NONE=y
    - Architecture/compiler: arm64/gcc-14
      - kernelci_watchdog_reset.wdt-reset.wdt-get-timeout
      last run: https://d.kernelci.org/test/maestro:6a9146a1c5867fba946af8f9
      history:  > ✅  > ❌  
            


### FIXED REGRESSIONS
    
Hardware: asus-CM1400CXA-dalboz
  > Config: x86_64_defconfig+lab-setup+x86-board+kselftest
    - Architecture/compiler: x86_64/gcc-14
      - kselftest.iommu.shardfile-iommu
      last run: https://d.kernelci.org/test/maestro:6a917231c5867fba946ba40a
      history:  > ❌  > ✅  > ✅  
            
Hardware: sc7180-trogdor-kingoftown
  > Config: defconfig+lab-setup+arm64-chromebook+CONFIG_MODULE_COMPRESS=n+CONFIG_MODULE_COMPRESS_NONE=y
    - Architecture/compiler: arm64/gcc-14
      - kernelci_watchdog_reset.wdt-reset.wdt-trigger-reset
      last run: https://d.kernelci.org/test/maestro:6a91467dc5867fba946ad9d6
      history:  > ❌  > ✅  
            
Hardware: asus-CX3402CVA-brya
  > Config: x86_64_defconfig+lab-setup+x86-board+kselftest
    - Architecture/compiler: x86_64/gcc-14
      - kselftest.iommu.shardfile-iommu
      last run: https://d.kernelci.org/test/maestro:6a916ac1c5867fba946b708e
      history:  > ❌  > ✅  > ✅  
            
Hardware: acer-chromebox-cxi5-brask
  > Config: x86_64_defconfig+lab-setup+x86-board+kselftest
    - Architecture/compiler: x86_64/gcc-14
      - kselftest.iommu.shardfile-iommu
      last run: https://d.kernelci.org/test/maestro:6a916afac5867fba946b73cb
      history:  > ❌  > ✅  > ✅  
            
Hardware: acer-cp514-3wh-r0qs-guybrush
  > Config: x86_64_defconfig+lab-setup+x86-board+kselftest
    - Architecture/compiler: x86_64/gcc-14
      - kselftest.iommu.shardfile-iommu
      last run: https://d.kernelci.org/test/maestro:6a916afcc5867fba946b743b
      history:  > ❌  > ✅  > ✅  
            
Hardware: acer-R721T-grunt
  > Config: x86_64_defconfig+lab-setup+x86-board+kselftest
    - Architecture/compiler: x86_64/gcc-14
      - kselftest.iommu.shardfile-iommu
      last run: https://d.kernelci.org/test/maestro:6a916af5c5867fba946b72fa
      history:  > ❌  > ✅  > ✅  
            
Hardware: dell-latitude-3445-7520c-skyrim
  > Config: x86_64_defconfig+lab-setup+x86-board+kselftest
    - Architecture/compiler: x86_64/gcc-14
      - kselftest.iommu.shardfile-iommu
      last run: https://d.kernelci.org/test/maestro:6a916af9c5867fba946b738d
      history:  > ❌  > ✅  > ✅  
            
Hardware: hp-x360-14a-cb0001xx-zork
  > Config: x86_64_defconfig+lab-setup+x86-board+kselftest
    - Architecture/compiler: x86_64/gcc-14
      - kselftest.iommu.shardfile-iommu
      last run: https://d.kernelci.org/test/maestro:6a916b00c5867fba946b7764
      history:  > ❌  > ✅  > ✅  
            
Hardware: lenovo-TPad-C13-Yoga-zork
  > Config: x86_64_defconfig+lab-setup+x86-board+kselftest
    - Architecture/compiler: x86_64/gcc-14
      - kselftest.iommu.shardfile-iommu
      last run: https://d.kernelci.org/test/maestro:6a916b5cc5867fba946b7a58
      history:  > ❌  > ✅  > ✅  
            
Hardware: acer-cbv514-1h-34uz-brya
  > Config: x86_64_defconfig+lab-setup+x86-board+kselftest
    - Architecture/compiler: x86_64/gcc-14
      - kselftest.iommu.shardfile-iommu
      last run: https://d.kernelci.org/test/maestro:6a916af7c5867fba946b7332
      history:  > ❌  > ✅  > ✅  
            
Hardware: acer-cp514-2h-1130g7-volteer
  > Config: x86_64_defconfig+lab-setup+x86-board+kselftest
    - Architecture/compiler: x86_64/gcc-14
      - kselftest.iommu.shardfile-iommu
      last run: https://d.kernelci.org/test/maestro:6a916af4c5867fba946b72eb
      history:  > ❌  > ✅  > ✅  
            
Hardware: acer-cp514-2h-1160g7-volteer
  > Config: x86_64_defconfig+lab-setup+x86-board+kselftest
    - Architecture/compiler: x86_64/gcc-14
      - kselftest.iommu.shardfile-iommu
      last run: https://d.kernelci.org/test/maestro:6a916ac1c5867fba946b70dc
      history:  > ❌  > ✅  > ✅  
            


### UNSTABLE TESTS

  No unstable tests observed.


Sent every day if there were changes in the past 24 hours.
Legend: ✅ PASS   ❌ FAIL  ⚠️ INCONCLUSIVE

--
This is an experimental report format. Please send feedback in!
Talk to us at kernelci@lists.linux.dev

Made with love by the KernelCI team - https://kernelci.org
