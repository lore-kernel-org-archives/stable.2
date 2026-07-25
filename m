Received: from mail-pl1-f180.google.com (mail-pl1-f180.google.com [209.85.214.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 30A4A386C22
	for <stable@vger.kernel.org>; Sat, 25 Jul 2026 02:30:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784946632; cv=none; b=AAmc7xDCXpHihvi+z4EfuzxO+qJIOhHXC0Rko/HtimWFSLa0CWK95MVYjmGQ2XExIEs9r9o8/zv44LpJisLgNe/BvppOk1bkDIGXS9PWufu6gT9+3dZhslNVODZ2W0eqOUah2U18bI5KSb/eE6bo7Y2zF3MdVNelZfQJN4VXOLY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784946632; c=relaxed/simple;
	bh=P5Cu2ixwuCh5Bkpq5o7mlJq0hYjWtK6FseCDTs1JQ9Q=;
	h=Content-Type:MIME-Version:Subject:From:To:Cc:Date:Message-ID; b=cpqYtV9UQ5BSt11dKKbTNyCt9n4izIcHITsWwV0qBiDe+UC5jg8yf8ksT3AWvJQy0VUZDGeoYwSXJEz0Ai+nRWS+XQmkyJaYgn7fsQs06mRbPSjaVcLSvlCFjumJFsSM/8lCkkgWlyMbQeYuJDSlISsuJeX+33WIbU7dp4yQQ1c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=kernelci.org; spf=pass smtp.mailfrom=kernelci.org; dkim=pass (2048-bit key) header.d=kernelci.org header.i=@kernelci.org header.b=jnWL8vyc; arc=none smtp.client-ip=209.85.214.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=kernelci.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernelci.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernelci.org header.i=@kernelci.org header.b="jnWL8vyc"
Received: by mail-pl1-f180.google.com with SMTP id d9443c01a7336-2cc7ef7ec27so13884125ad.1
        for <stable@vger.kernel.org>; Fri, 24 Jul 2026 19:30:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci.org; s=google; t=1784946629; x=1785551429; darn=vger.kernel.org;
        h=message-id:date:reply-to:cc:to:from:subject
         :content-transfer-encoding:mime-version:content-type:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=RBcugPYe5X/eXm5HhhLIzL3GpygWKGrb/P24qeqW4L8=;
        b=jnWL8vycVkYRMCuqfNGdN9ca+iQW+giaqllzziBYmoya6vaJ8zDqsRtF5pfasaFmVd
         KXPbML8xrIHvf9QvkUzYV4sFRYAR6gV7w8SbFbTpM9IUSoxxDkvGy79tBrjEFG7QggT1
         x0/l2lg+3mwMy4nYHoVS5+/7kmLp26GEZNEZTSJntqVPZNA4LefrdlueHrYF6zG54eGq
         rveWWo/rHw/16/PFvTwuE7VuGm7JSf8kbNF7SZS4+9xMf/9w4PipmZtZxVz6dQlBJJW3
         4AYsxAq9dufHeuc/5AhP1u8BTIJ8sKIJFYF+tnDNTw/y40TqoCTp2lUUcid+lfsUPEyW
         UZuA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784946629; x=1785551429;
        h=message-id:date:reply-to:cc:to:from:subject
         :content-transfer-encoding:mime-version:content-type:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=RBcugPYe5X/eXm5HhhLIzL3GpygWKGrb/P24qeqW4L8=;
        b=XeO6r0pee8qvdJAKWnX0NGCP4tpLM6zhxXYbWOVer4W2uOBCs+KgQKEtk3jOsOxe2Z
         HzuS2svALpXNIx1y+PtaO7e1b0qSrVfS6zTed5vqrGwNyW2lwZon5MzVdFpNhUoLHdVU
         hmgctgiCrViEsG8Ybiu4miv/cVKxniPRn/krMb+pfTuJth22odmVMHu23bGLJ86Ua+Ql
         m9BqpCx7+J2WA1nU0w3s8azjhZfO8GN9P85uHEXhp/IeGZCVtzs1SfcqXjuWr4TKV5NW
         ruUtHQeqOMIrB3G53FBcFdKn/z1uRxkam4ZMOxWBHg08lW11PM+vT0F7GJCvaqrljMTp
         7iqw==
X-Gm-Message-State: AOJu0YwwsZNrk83WIYp69PDB6lLXh+al9ffTBJG/qqwxue9RAhInbV1h
	pu4+iKUism9apwMvJKhs4wM8ZURGijtW4DXz4xTMhyMBsYG4LgCrFdVklsKe5QXKIFY=
X-Gm-Gg: AR+sD13upi5g3x5nfFSXbrnsXdaekfL0AQ9qjPWPj/BZkQvSPVV5gwKLjYwzmZ/S/Is
	oagoaILuspfNgKbmjklwfBCgOFN32KnEjpzsLDbUBQNMXUvRvu0kKvW4KfUHJgLVUiI81NYftbQ
	xP8QmFmCAMgqGNAWO5D60anhtcehDIwuUTZ/6RZhWqzD0Dfp4p3Q51iPn8+slHRZeoJhOhT85rd
	qMTkYoFtoLDtu3a2BCFoyIWOKyiVwgySb+XJ3CnG7olLOTOA1fi9qWBsoaEuTcKwgZFxgMhJrmn
	VQfyzPDF5tK9rirgN/r9oBT9W2HLdBrx8fCEVeE3+ecT/0dVbtO8bS1J3M/3tTeKQN/IMbAsfnd
	3lF6oEiVTFxwx3/QP1WKIW0ZWBkoTOjm/IJE9x0yVuG7N640ezzL6+b4a7tuxXQMMsxUFcNM=
X-Received: by 2002:a17:903:2ec4:b0:2cc:f4d4:299f with SMTP id d9443c01a7336-2cfde85fe0bmr8726105ad.27.1784946629359;
        Fri, 24 Jul 2026 19:30:29 -0700 (PDT)
Received: from 92650adf53de ([20.38.40.137])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-314bc3e127asm6907389eec.2.2026.07.24.19.30.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 24 Jul 2026 19:30:28 -0700 (PDT)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: [STATUS] stable/linux-6.12.y -
 0fdd40630ea1ca5eb0bb70113cdac90d5788511a
From: KernelCI bot <bot@kernelci.org>
To: kernelci-results@groups.io
Cc: stable@vger.kernel.org
Reply-To: kernelci@lists.linux.dev
Date: Sat, 25 Jul 2026 02:30:28 -0000
Message-ID: <178494662803.1348.11623299012805090598@92650adf53de>



Hello,

Status summary for stable/linux-6.12.y

Dashboard:
https://d.kernelci.org/c/stable/linux-6.12.y/0fdd40630ea1ca5eb0bb70113cdac90d5788511a/

giturl: https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git
branch: linux-6.12.y
commit hash: 0fdd40630ea1ca5eb0bb70113cdac90d5788511a
origin: maestro
test start time: 2026-07-24 15:33:27.174000+00:00

Builds:	   56 ✅    0 ❌    0 ⚠️
Boots: 	   96 ✅    0 ❌    0 ⚠️
Tests: 	13255 ✅ 1148 ❌ 2609 ⚠️

### POSSIBLE REGRESSIONS
    
Hardware: bcm2837-rpi-3-b-plus
  > Config: defconfig+lab-setup+kselftest
    - Architecture/compiler: arm64/gcc-14
      - kselftest.proc
      last run: https://d.kernelci.org/test/maestro:6a63bc22798ea6c1ef697298
      history:  > ✅  > ❌  
            
      - kselftest.proc.proc_read
      last run: https://d.kernelci.org/test/maestro:6a63deba798ea6c1ef6b7a13
      history:  > ✅  > ❌  
            
Hardware: k3-am625-verdin-wifi-mallow
  > Config: defconfig+arm64-chromebook+kselftest
    - Architecture/compiler: arm64/gcc-14
      - kselftest.kvm.kvm_memslot_perf_test
      last run: https://d.kernelci.org/test/maestro:6a63951f798ea6c1ef67c917
      history:  > ✅  > ❌  
            
Hardware: qcs6490-rb3gen2
  > Config: defconfig+lab-setup+kselftest
    - Architecture/compiler: arm64/gcc-14
      - kselftest.proc
      last run: https://d.kernelci.org/test/maestro:6a63bbfb798ea6c1ef6970b4
      history:  > ✅  > ❌  
            
      - kselftest.proc.proc_read
      last run: https://d.kernelci.org/test/maestro:6a63c355798ea6c1ef69d643
      history:  > ✅  > ❌  
            
Hardware: mt8195-cherry-tomato-r2
  > Config: defconfig+lab-setup+arm64-chromebook+CONFIG_MODULE_COMPRESS=n+CONFIG_MODULE_COMPRESS_NONE=y
    - Architecture/compiler: arm64/gcc-14
      - kernelci_watchdog_reset.wdt-reset.wdt-get-timeout
      last run: https://d.kernelci.org/test/maestro:6a6390d0798ea6c1ef67970c
      history:  > ✅  > ❌  
            


### FIXED REGRESSIONS
    
Hardware: mt8183-kukui-jacuzzi-juniper-sku16
  > Config: defconfig+lab-setup+arm64-chromebook+CONFIG_MODULE_COMPRESS=n+CONFIG_MODULE_COMPRESS_NONE=y
    - Architecture/compiler: arm64/gcc-14
      - kernelci_watchdog_reset.wdt-reset.wdt-trigger-reset
      last run: https://d.kernelci.org/test/maestro:6a6390b8798ea6c1ef6796e8
      history:  > ❌  > ✅  
            
Hardware: qcs6490-rb3gen2
  > Config: defconfig+lab-setup+kselftest
    - Architecture/compiler: arm64/gcc-14
      - kselftest.dt.dt_test_unprobed_devices_sh_soc_0_iommu_3da0000
      last run: https://d.kernelci.org/test/maestro:6a63c20d798ea6c1ef69a8a2
      history:  > ❌  > ✅  
            


### UNSTABLE TESTS

  No unstable tests observed.


Sent every day if there were changes in the past 24 hours.
Legend: ✅ PASS   ❌ FAIL  ⚠️ INCONCLUSIVE

--
This is an experimental report format. Please send feedback in!
Talk to us at kernelci@lists.linux.dev

Made with love by the KernelCI team - https://kernelci.org
