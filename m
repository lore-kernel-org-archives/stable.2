Received: from mail-dl1-f43.google.com (mail-dl1-f43.google.com [74.125.82.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 91DCC364935
	for <stable@vger.kernel.org>; Tue,  2 Jun 2026 02:30:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780367419; cv=none; b=aFgupqhot1LY2aYlXziC2gAWAQpZgwWtN7Dz80Wzn0UJoW+rIolVh1F5pdNiicP6LL9w1IKxKUOMRd4B5fj4Yzz37/UD+9vkQUKwwniBbin5Q44Xa96MW8oFgc5DJKbFhY2PQH2z2S2+ikuTZxsQamVbu0vPlU7fsj1cnu3MaPQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780367419; c=relaxed/simple;
	bh=KXyrILcCRnmNCPuYJN6QLIuRlb9sOwoE41urgQBER5Q=;
	h=Content-Type:MIME-Version:Subject:From:To:Cc:Date:Message-ID; b=CNnPoD3NY1NAz+e248qcGxlT5yJaE3hG0Jh9lnKTngPy5ngDmDpdKZjMrH5rVAsoOF3fVqRnfLpb3zxo8aiyrpzNwY78dJJbw5y8ZEHEyOAMQeNBhpgvILc2OgPyiCv8DCvS2eJZ1OMF00RnQK3r1AfoW8XT41GV1cs93bhb0y4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=kernelci.org; spf=pass smtp.mailfrom=kernelci.org; dkim=pass (2048-bit key) header.d=kernelci.org header.i=@kernelci.org header.b=hs6EC41F; arc=none smtp.client-ip=74.125.82.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=kernelci.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernelci.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernelci.org header.i=@kernelci.org header.b="hs6EC41F"
Received: by mail-dl1-f43.google.com with SMTP id a92af1059eb24-1363fe80fe8so12970068c88.0
        for <stable@vger.kernel.org>; Mon, 01 Jun 2026 19:30:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci.org; s=google; t=1780367416; x=1780972216; darn=vger.kernel.org;
        h=message-id:date:reply-to:cc:to:from:subject
         :content-transfer-encoding:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=381flff3FhtIDQrIo11Baa1X+cPozVjFjYASUxHZtDs=;
        b=hs6EC41F8CiOUjUzT0mFYHs7xSsH+peRn20SMWqBd5TfOREOD/nvq7S/nCcSG0Ktht
         XIs1jFbYVqxF4JKqmNYpTjSV5MXJ28dZh2vbaMqielh0i2+7n9JQRz+fs+7PFG4jJmRb
         smPFrk/aBjUVC2uXUNDWtulPuXjPslgHS/oO/2bvvqv0lu8NQXmDSkZc1gwf/NjCI1Tg
         08H3k9KPkj6ya1H5FGCV+Nji00FidjdK527Z95ThZyNfebmdBFEh0T2X/ohcK3jeqDSW
         5l3f4kuCRsW66GRuoXqPWIWhh/hHTe4YJce5vxagSwSC+B16LNx0KPUHjaAJ/8KRNgAH
         bL1A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780367416; x=1780972216;
        h=message-id:date:reply-to:cc:to:from:subject
         :content-transfer-encoding:mime-version:x-gm-gg:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=381flff3FhtIDQrIo11Baa1X+cPozVjFjYASUxHZtDs=;
        b=TP1AS10YbPqkuzFg5kEej1f4g0zn2J3gaiPJP0j1AU1qoPvhTntzI6363Cvq2pNfLA
         PEjrYJ0xRq5gZZAmH85LU3yvlM8lZn+LqJDJ6txsmrzVCeVXS5DyxsZbUIUo12wz7SJf
         mjhNV81DpcyJd89RTY1Wu7OX512+rr4TTINFicfBFLf/zpQyX7FXASLjl8ShdGfxvamW
         MKkTv9AXPFxfCGeGY00GXoz73siN3emsR5AhY4XXlkGChl0+VKaI/2c7S4vFLZe/yb8c
         AhaCBH0NLyf0g213P8nesdnlY9RuPzSTCYIwoQ9pDIhrTBPpSuKaQUV4u32NF7cE0+ET
         0W6Q==
X-Gm-Message-State: AOJu0YyU3rTU51cSQ/nCOIPkNs+hDb7PVQejEUdXRGcJ4wJvM/1s8ilv
	Phs0/oXiW2wlqxg35oJWgh8ZljM9vo0cWvAn0vV800sQ9uA5cOi5r1LX8e9449Nmor05NF3XAqr
	vHP8R
X-Gm-Gg: Acq92OHhUPGn0c6oMrtYdg/g06O9btHeFBqVm31TGjE8Bcdgr4rLjavqNGGzaV6ID2M
	+gyzqff+UTqavvu72cWOQ1O7IV7zjCWB+43L/cTYnJPtiFtTuU5AEq2SbpiY19aAXZM3lXIGroV
	7WoRFlCUPbRMwcgIv6gvSZ44L6Occ+FlhaMs1rxk69criPBerX47fulWPxzK9te8S5j9hPk5TB4
	FmTQeE7UoBFAm4JL/RSq6xyIyLKVFfNm+CkSwmx4GbS8AnjEz1QLPVZ9RlkbGq5rGydRyOgUUnf
	s9zk3utlQ5PWnKqFlJms/hW9RA8J3cSFCzxOTup4K77e3lRYTpBZJaalYp2GkcB7AEwjuGtFNFA
	G/M8Ut5U8Exf/9gHo8UtwO3FkoIvGB5iqDNSJQSPfRmAuz6HOgXHijiBgwbN7z6HofeUhqUN3Cs
	Sm99uL4gVYGbpz3YMPHvN2kBzvdvY=
X-Received: by 2002:a05:7300:f18f:b0:2f5:285c:4374 with SMTP id 5a478bee46e88-304fa75bd1dmr6550465eec.35.1780367415939;
        Mon, 01 Jun 2026 19:30:15 -0700 (PDT)
Received: from 330cfa3079ca ([20.38.40.137])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-304ed2bdda4sm9573625eec.2.2026.06.01.19.30.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 01 Jun 2026 19:30:15 -0700 (PDT)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: [STATUS] stable/linux-6.1.y -
 228da13e907e2b46b7222cfc35290fbfad920bef
From: KernelCI bot <bot@kernelci.org>
To: kernelci-results@groups.io
Cc: stable@vger.kernel.org
Reply-To: kernelci@lists.linux.dev
Date: Tue, 02 Jun 2026 02:30:15 -0000
Message-ID: <178036741495.9044.4537193400559725782@330cfa3079ca>





Hello,

Status summary for stable/linux-6.1.y

Dashboard:
https://d.kernelci.org/c/stable/linux-6.1.y/228da13e907e2b46b7222cfc35290fbfad920bef/

giturl: https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git
branch: linux-6.1.y
commit hash: 228da13e907e2b46b7222cfc35290fbfad920bef
origin: maestro
test start time: 2026-06-01 16:34:32.798000+00:00

Builds:	   41 ✅    1 ❌    0 ⚠️
Boots: 	   40 ✅    0 ❌    4 ⚠️
Tests: 	 1559 ✅   59 ❌  667 ⚠️

### POSSIBLE REGRESSIONS

  No possible regressions observed.


### FIXED REGRESSIONS

  No fixed regressions observed.


### UNSTABLE TESTS
    
Hardware: bcm2711-rpi-4-b
  > Config: defconfig+lab-setup+kselftest
    - Architecture/compiler: arm64/gcc-14
      - boot
      last run: https://d.kernelci.org/test/maestro:6a1de8b72cc72b6e94aefb79
      history:  > ⚠️  > ✅  
            
Hardware: beaglebone-black
  > Config: multi_v7_defconfig
    - Architecture/compiler: arm/gcc-14
      - boot
      last run: https://d.kernelci.org/test/maestro:6a1dce682cc72b6e94ae1a43
      history:  > ✅  > ⚠️  
            
Hardware: imx6dl-udoo
  > Config: multi_v7_defconfig
    - Architecture/compiler: arm/gcc-14
      - boot
      last run: https://d.kernelci.org/test/maestro:6a1dce742cc72b6e94ae1a8b
      history:  > ⚠️  > ✅  
            
Hardware: qemu-x86_64
  > Config: x86_64_defconfig+lab-setup+x86-board+kselftest
    - Architecture/compiler: x86_64/gcc-14
      - boot
      last run: https://d.kernelci.org/test/maestro:6a1dc4d02cc72b6e94adb09e
      history:  > ⚠️  > ✅  
            



This branch has 1 pre-existing build issues. See details in the dashboard.

Sent every day if there were changes in the past 24 hours.
Legend: ✅ PASS   ❌ FAIL  ⚠️ INCONCLUSIVE

--
This is an experimental report format. Please send feedback in!
Talk to us at kernelci@lists.linux.dev

Made with love by the KernelCI team - https://kernelci.org
