Received: from mail-dy1-f173.google.com (mail-dy1-f173.google.com [74.125.82.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8692B3B42FA
	for <stable@vger.kernel.org>; Sun,  4 Oct 2026 02:30:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791081009; cv=none; b=K6vvq5RaKANx0Z1XVdly7jDcW/c/6axRj2rjjCWODaFfpWV6QFKbiF/R7G2chO7mPCEIrY1PSP7Ix+lFMup5MXMGVWuxCnhJdqPS6KIPiBTC5hP2q4gpkWq17DtX2/cigLtbJn3AEXOxMQIikE/qE/F80OstosYt01ICNZysW7M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791081009; c=relaxed/simple;
	bh=sWsYvesYnU5c+i58lp531XeDIngeCeCzRlMjgbPm8lU=;
	h=Content-Type:MIME-Version:Subject:From:To:Cc:Date:Message-ID; b=sNTcZx4Ry/gNgDTgULfgexhRvb0xCRfdQTDAo95DTGH3pAEWKVd95wx35Dl5Bsap5jESEpBhNorCEeCprmdprdvSJzioIOc+9/zy38GSpi+dVkCFMO+TfHpJyHcwiFARdX35uxf8Qf+ythoGU4WeseHT81nVMQ9zL9b1QTey2zs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=kernelci.org; spf=pass smtp.mailfrom=kernelci.org; dkim=pass (2048-bit key) header.d=kernelci.org header.i=@kernelci.org header.b=ZNMtjDi+; arc=none smtp.client-ip=74.125.82.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=kernelci.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernelci.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernelci.org header.i=@kernelci.org header.b="ZNMtjDi+"
Received: by mail-dy1-f173.google.com with SMTP id 5a478bee46e88-34ca2d54925so1150963eec.0
        for <stable@vger.kernel.org>; Sat, 03 Oct 2026 19:30:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci.org; s=google; t=1791081006; x=1791685806; darn=vger.kernel.org;
        h=message-id:date:reply-to:cc:to:from:subject
         :content-transfer-encoding:mime-version:content-type:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=71dESqg5wR+TOuOQTrtYNZXdWnf6cp/vQz6JnD/BYow=;
        b=ZNMtjDi+eObS+c9GWt4SYnc9EaS4XJ8nEsmFrjPOXYW2HZcBpcdDBwqzyVldBcbais
         csNUup2i0PED+5/6WZY39u6oQi27LHDRdM/9Kiews6hBL6s+WkgpigwOABlVhLyZMVjD
         WsFEXhvKjmNXddMlRqqcQ1+W15uqfvjr4c2KRdbmk5bq0bU/5oIyRt4tQkZkdJX2LoVT
         VtivG2Fxg6S8YI5yhFXS1c1p8J+azmW6bLrIhtk5/LWBlwR+8uHoala3rNL5M30eRf6y
         eqXAZcwHedVL+651w5TALi1Y9YjNu/X3k793Q1AKeIIwc0GZgar2hgGZrRm8R9zwKcYU
         qnTQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791081006; x=1791685806;
        h=message-id:date:reply-to:cc:to:from:subject
         :content-transfer-encoding:mime-version:content-type:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=71dESqg5wR+TOuOQTrtYNZXdWnf6cp/vQz6JnD/BYow=;
        b=TF3NPirr4jW9mhvWwrYnv0COi+kNLqTt4TBbc3LLA6+NWpP9lFiTxQhvpb9NN+j27g
         N4dyqHLkJR/AW6kASGONxRKZgLdJLK0wAzWoCPZ0Mvcf3ksP+b+F2S0gNsnKTMRmfsGu
         2koIJ7G5wFSoySBh1Zqk5c8LCpjJq2XK3EGYA+a64gN409CBoPn2evjBgvaBVMPegBE2
         UcIoTY+V10yWcZ8oQn1b/R5YBafzKfys2GZG062Un8KJ0X/LyJzgPVd5vv8oIH89Ryz7
         yctcuDt7v8H7M56F5kjdr3rOw2KLOsnyz5JVZptm1WWYrWVqH5uNm6EfZlvqtsA9al6S
         nIxA==
X-Gm-Message-State: AFq9FYKggtihBHX2uAvtqENyG70S2vSD7UuYSuPXgq2DOUD3HpAnjetM
	1suSAp427lgp/I/Sdsn1TZYUpuMXVS/zkPTfevSU249gewYSf0WabfyZqtFnmGqJHSM=
X-Gm-Gg: AYBFou37NvOy19tzqDgGIMurCrUDjAq2qpeSos6VEMacre1B1PJEa+ic/RXAGOwFnzD
	VfOZWtD3D8uwpNEEQcc/X2Ov4Cq7cwTRVpRx/WQ1q04PjrzsnrCs1BKae1MNZHCve8Z8EUbPOjR
	wPNFwOWGojm5hNzMcptUyrij27FxbyI8BYVm2VzBGlTplMP5rMx+WDfIcSgkUtlNSwAVx4yFY4h
	gWpMEL808Jm+hhDn21x9zZW/bEAQq/P/uxlMejmsyu4/Pidy9YAKaOCqgShpDzXIokPOUaaItxF
	Uf7EdYT/d/OwYCODEGjMPlc0PxVLS36CyyfyBCg4yKNd2LGX16P2XrXtV+3u6BSMonoXJccRovq
	f1Nbr8FfumNxk1XhNQ3nZqJJvl4czoNhoOedvy9DWCmm1/3jsRMUoKFdak8ofANUCV6K1A5hIem
	LO3TbhdPauBXmHsCfFCztOC54XVoaOL7Cupvua6kvsK4uAIRpVdM4rG/jtOzSlXIU=
X-Received: by 2002:a05:693c:8809:20b0:314:267f:46e2 with SMTP id 5a478bee46e88-351114743e7mr4779244eec.20.1791081006214;
        Sat, 03 Oct 2026 19:30:06 -0700 (PDT)
Received: from 5a6d9a2c18a2 ([20.38.40.137])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-351272a45a8sm836511eec.22.2026.10.03.19.30.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 03 Oct 2026 19:30:05 -0700 (PDT)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: [STATUS] stable/linux-5.15.y -
 a051a4bf909f76f470ccb3761ee0cf6e2395616e
From: KernelCI bot <bot@kernelci.org>
To: kernelci-results@groups.io
Cc: stable@vger.kernel.org
Reply-To: kernelci@lists.linux.dev
Date: Sun, 04 Oct 2026 02:30:05 -0000
Message-ID: <179108100486.282967.14491913626578253257@5a6d9a2c18a2>



Hello,

Status summary for stable/linux-5.15.y

Dashboard:
https://d.kernelci.org/c/stable/linux-5.15.y/a051a4bf909f76f470ccb3761ee0cf6e2395616e/

giturl: https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git
branch: linux-5.15.y
commit hash: a051a4bf909f76f470ccb3761ee0cf6e2395616e
origin: maestro
test start time: 2026-10-03 11:23:56.478000+00:00

Builds:	   50 ✅    1 ❌    0 ⚠️
Boots: 	   35 ✅    0 ❌    0 ⚠️
Tests: 	 2966 ✅  397 ❌  552 ⚠️

### POSSIBLE REGRESSIONS

  No possible regressions observed.


### FIXED REGRESSIONS
    
Hardware: beaglebone-black
  > Config: multi_v7_defconfig
    - Architecture/compiler: arm/gcc-14
      - ltp
      last run: https://d.kernelci.org/test/maestro:6ac0f727a3f195e1aa2a982d
      history:  > ❌  > ❌  > ❌  > ✅  > ✅  
            


### UNSTABLE TESTS

  No unstable tests observed.



This branch has 1 pre-existing build issues. See details in the dashboard.

Sent every day if there were changes in the past 24 hours.
Legend: ✅ PASS   ❌ FAIL  ⚠️ INCONCLUSIVE

--
This is an experimental report format. Please send feedback in!
Talk to us at kernelci@lists.linux.dev

Made with love by the KernelCI team - https://kernelci.org
