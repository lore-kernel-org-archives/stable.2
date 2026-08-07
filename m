Received: from mail-pf1-f175.google.com (mail-pf1-f175.google.com [209.85.210.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4EBB8245005
	for <stable@vger.kernel.org>; Fri,  7 Aug 2026 02:30:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786069808; cv=none; b=YLlnHPYdyRDrQWA89H1PtqbJtBlbYFVXdJEOkluqj6hU1i1dH4yBSoVQh9sA9uOlVMnWMtCAAQ+C4brBxfLry7nT1VSFDKHTeEgb5mWfuTEjjIQKSAEvRtjjNPPVtpAxGtYAdzjoCfhC5pmEiY4Z+9R2SPOShnVBiGzV5vzIz+Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786069808; c=relaxed/simple;
	bh=38nWtdjzOs6uJG9mbj8HOipBbFBWgcG2lSK36wKCtxQ=;
	h=Content-Type:MIME-Version:Subject:From:To:Cc:Date:Message-ID; b=m3UVy78w6KMpfDH/1BJBoqvOBvUgA1VEJ6qZ1E7MgBYe47n9+N0eEUCV54kT3VnipKVLLNMA4iFJtkEKButrMGapJ6rkA0x+qz64ZpwMVnKoBk2U/oS+U2ZxqfKBSPi007OLChSyP2du36kqHCFo6pu2ayQX1DMT4oAHjA1nnwc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=kernelci.org; spf=pass smtp.mailfrom=kernelci.org; dkim=pass (2048-bit key) header.d=kernelci.org header.i=@kernelci.org header.b=dpqHhePU; arc=none smtp.client-ip=209.85.210.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=kernelci.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernelci.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernelci.org header.i=@kernelci.org header.b="dpqHhePU"
Received: by mail-pf1-f175.google.com with SMTP id d2e1a72fcca58-8486ac3f347so1779198b3a.1
        for <stable@vger.kernel.org>; Thu, 06 Aug 2026 19:30:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci.org; s=google; t=1786069805; x=1786674605; darn=vger.kernel.org;
        h=message-id:date:reply-to:cc:to:from:subject
         :content-transfer-encoding:mime-version:content-type:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=b2Rgtbmnykxx9WiWepvpVj3V3VK7TobSit8wnwsD+o8=;
        b=dpqHhePUNk52GqRS6ehB4a5b6OOSYAqVkk8XYTrLbGJCrsw1JTqEgB343UwvJrVvd5
         jtRwvuI5cE2ZnsU4ZZHeKH2lbThQCNEpENQECes2Tgft/V6lKfasWlylnpRSnke1cPEp
         wSLpDlLHSWIcC6gv7GFKfMR+FGTcaJN3sFx6+y8mmUNk8E8s7Xu266IkB0DExc/7rESV
         RaDFCQBk+qbU/wroyb2vV2RdrCxeVyJ+bGYCTVls93Yjby6a6Oro+7nMCdWyAU/9B3pC
         RLEJBzNDO3+VkyzcYy5C9JneZIZuCseupk71DTGBFG0E/E7GTS9VO6NBfmAEzKY+NJNH
         13KA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786069805; x=1786674605;
        h=message-id:date:reply-to:cc:to:from:subject
         :content-transfer-encoding:mime-version:content-type:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=b2Rgtbmnykxx9WiWepvpVj3V3VK7TobSit8wnwsD+o8=;
        b=eLzCAdCbqiaY0e6SZkywzLE9ZDyq16b1mknTwhXdw3c7SSV6c8PICfHOsBuFuuFVtf
         +bdr8Q3AN4UtB+zsEjUqPNIDONaC0m61dY5FtNm4MOIhnGRrZf4YIhz7SD/2lQ8u6IGa
         IAYR9awOcCqf1tlGMRpEU5FrDUiUyWJAaOXih2EEiCIZY0Poipbw75VgS6o42q58Z9qA
         dixZNSnT1jzx+sVAC3A16DL/fz/nVQNLwYOt87DoV1+l9MCnzUTe2aAoEwe2gkeSPP5J
         2MTLO9wz2FI6YQI53nWxl7WH0VxJFkXTYua8YQD/0AtNawMpSRyEdZ2nxzfsLb5Clz3/
         gLvQ==
X-Gm-Message-State: AOJu0YypxWb9rjf9HYAS6RapRpNZB1xBtHSJN4V18P3hhwgmtSCiCHyl
	4j+cjmNv3Qci4689j6iSBEOx53382OQrBCP8zgb4XAqu8jWCko1xqOFpJ1Maok4O1Bs=
X-Gm-Gg: AR+sD10LDsWiZb23OTE/ErFKNa9PY+iajwqvmq2uJe71yhwVOOGTWNxaigq2FeBj4Lo
	d2X3mljm/MSLbsEvEqJBcMlJqMit15t1WiyiIOxseG3fHPNvoR9jB77rvrFjh2u7L4fknd62swz
	9fFabhbO6iyhO66+wUc8Wd92SsjHb9371r9tdU8EnXOkXSLmOqUOhFWcfpzxp0HjbEAWCgaIDP0
	q1cULJlO174NvbP2x1AgMQGtRQtf/EUEpGGj+yGvBOWuDDa4bnkPbiwynnWpPaxEwigD6BHdI8a
	CRZ5Ko3gN9dTsvx3Ou8tw70l2PEH5M0TSBsHO1Yv/AsKJ2ZjgKsDzWTjLoLePIezkqJgYHZWmeQ
	oUcM5ueIyoLLZyjJfNNUX+qdqBrq+WSASk4Sc61RHCblKS70F3drKciBmdz6UCUjhVhnnqn/4yj
	ysXiPSZGwc0HgH1MK/nggkLGk7QL8NtUoHyFilb6f38z0dLEw0W90ZiA==
X-Received: by 2002:a05:6a20:12c7:b0:3c3:75c5:48d5 with SMTP id adf61e73a8af0-3cb9c071bfdmr11689031637.4.1786069805542;
        Thu, 06 Aug 2026 19:30:05 -0700 (PDT)
Received: from 92650adf53de ([20.38.40.137])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-315beb87d3bsm1510988eec.14.2026.08.06.19.30.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 06 Aug 2026 19:30:04 -0700 (PDT)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: [STATUS] stable/linux-6.1.y -
 03f3a99e8e93f6b670c359265b67661c0f0e0446
From: KernelCI bot <bot@kernelci.org>
To: kernelci-results@groups.io
Cc: stable@vger.kernel.org
Reply-To: kernelci@lists.linux.dev
Date: Fri, 07 Aug 2026 02:30:04 -0000
Message-ID: <178606980409.7416.12953627182348603157@92650adf53de>



Hello,

Status summary for stable/linux-6.1.y

Dashboard:
https://d.kernelci.org/c/stable/linux-6.1.y/03f3a99e8e93f6b670c359265b67661c0f0e0446/

giturl: https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git
branch: linux-6.1.y
commit hash: 03f3a99e8e93f6b670c359265b67661c0f0e0446
origin: maestro
test start time: 2026-08-06 18:18:09.538000+00:00

Builds:	   49 ✅    1 ❌    0 ⚠️
Boots: 	   44 ✅    0 ❌    0 ⚠️
Tests: 	 4053 ✅  470 ❌  665 ⚠️

### POSSIBLE REGRESSIONS

  No possible regressions observed.


### FIXED REGRESSIONS

  No fixed regressions observed.


### UNSTABLE TESTS
    
Hardware: qemu-arm64
  > Config: defconfig+netdev+nfs-root-boot+kselftest
    - Architecture/compiler: arm64/gcc-15
      - ltp
      last run: https://d.kernelci.org/test/maestro:6a74ddcc62f33761c08622aa
      history:  > ✅  > ❌  > ✅  > ✅  > ✅  
            



This branch has 1 pre-existing build issues. See details in the dashboard.

Sent every day if there were changes in the past 24 hours.
Legend: ✅ PASS   ❌ FAIL  ⚠️ INCONCLUSIVE

--
This is an experimental report format. Please send feedback in!
Talk to us at kernelci@lists.linux.dev

Made with love by the KernelCI team - https://kernelci.org
