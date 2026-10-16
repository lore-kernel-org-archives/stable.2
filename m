Received: from mail-dy1-f169.google.com (mail-dy1-f169.google.com [74.125.82.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7065939E9BD
	for <stable@vger.kernel.org>; Fri, 16 Oct 2026 02:30:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792117826; cv=none; b=YDmbwiranrcUyD6ggXhST40/W+WZt3iC5hDQavHGtnA/P1lYxXCuqhSZZd92uf+ImjmECEjiJ0vNfi/Z8pKZtKD5MO9TNdwV87ID+cA+3w1jOPMm0I3U0zW0/KZd56gWSztXA+ngpyhDt+KI3fQfKhoA1vvkDTMUidRSXjyMt10=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792117826; c=relaxed/simple;
	bh=0RVh8/26f2nub13PHEaTpfnMu3+gxS8buW/rlY5fLj8=;
	h=Content-Type:MIME-Version:Subject:From:To:Cc:Date:Message-ID; b=suSsqPMXclD0TNq9yVCxbN2YIYiXJLqKSqrZVdt5tdSKMG11VYniE9RiuUbaKanN8rk10FSKQcCi1DcnZdOTbn8YVZjO4d8vrxEPyiEL972PZbs9sPsJsgQ43Qdmv6EuMaDWDjmLI0Xoe2MjoeZeH2EWfxrsdwTp4IvYrzj8xoE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=kernelci.org; spf=pass smtp.mailfrom=kernelci.org; dkim=pass (2048-bit key) header.d=kernelci.org header.i=@kernelci.org header.b=jT+RXrQP; arc=none smtp.client-ip=74.125.82.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=kernelci.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernelci.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernelci.org header.i=@kernelci.org header.b="jT+RXrQP"
Received: by mail-dy1-f169.google.com with SMTP id 5a478bee46e88-33fb4680717so1361347eec.1
        for <stable@vger.kernel.org>; Thu, 15 Oct 2026 19:30:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci.org; s=google; t=1792117823; x=1792722623; darn=vger.kernel.org;
        h=message-id:date:reply-to:cc:to:from:subject
         :content-transfer-encoding:mime-version:content-type:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=LKEiMK5fmmCtUzzKN2NU/k+f0pOgJSdlcupM0XeW7ME=;
        b=jT+RXrQP39aChpDd28oP9+qUI6zzaNEcT9wHH1l4xRBLm+MALJRAUhHN0lIy2L1aFc
         sbhcSbimvgl0UvF12/be9HhMl1H/YPhnxlUb6EdKUk6Nlw0r5iSHxJVHq3xlNs5x3q2K
         emPpiTMhwzpOjaON2bz2VVWOBPn36ALQMorFY1Df+GtA0DrQafBji93OSal8mNRCdh5o
         HjIKtuJr8E1FUh8ayMPKry7RcG/5jMaZL3YJR9rrETSTFLJhie8WW5X5CX5rGmScF5Pf
         ZkhQ6c00vQnqiFR3DRMDpFyc0T8cHGwZAjpvZzvczpYym8J5tFpSt/NJCwB/HR3vSWjb
         S+dQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792117823; x=1792722623;
        h=message-id:date:reply-to:cc:to:from:subject
         :content-transfer-encoding:mime-version:content-type:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=LKEiMK5fmmCtUzzKN2NU/k+f0pOgJSdlcupM0XeW7ME=;
        b=xVS6CgieKTgLhvJ5xqL2Slz92m/Iaw84mI+CIRx1Re1AuTJ5IMdX7DLaRiIlgJj+5b
         aRdRdPIlNxosgfYqldrn6vFFPpeIETVo9eS6oZiAmwhkgXrFOXqQhxdvbbuHw0AHzxAm
         mViNO4xfzMfGIhaTN4Wu1XeGUcConM0aBludh9msKu5LHQN6ksFPjeBhP/2A9q90D8k9
         2RTfAejppij5xcdyELuQ4GvGUncYSCJTl6raguXw8IvDEhUFOD2qGPEmeRSWoa8f7nFC
         TyCHmKAcokIilUEw58wdHZw8Lae6jjIK3k2z/NNBZbZP3P3tJ3QUBFfvbCxLPd3KQRvb
         6Ngw==
X-Gm-Message-State: AFq9FYI6UWYOdFoXiA1x4wtgEBOacQaGrxQ8Hl6WsndIHeeGOh6uYZyP
	7fGy9XqzVvkwOgllbQpYVWICm9dqFrNDu73tvyNAvEvHp1D/TJLeYaZJKJU7eUqTg42g5yk5e9F
	hr9W8
X-Gm-Gg: AYBFou2vPDSABwer71/JAbygjajbe68hr1h4aA3QZat1R6f0lXZsfVvnA/gOF5rAEUY
	fAC2Ce2RHTqx0jr3rBVg6pFR7Ft4cnqMxCEw05o2qvxoV6isrRj2iH5vaMfY4u5w6L6oHH/ezcW
	JcgXab3NG4nuNYyvGHSSpf21Ys6deaWicN8wTOTwKXON4OOArz+ppQwpt86qcvSx1ZYf65XOXpc
	636bbfiMA8HUrPYyaPEcoInx72flUjoaHnHD5VQU5QX/jQvHc+Fua3Ar+ANSQmq48RBwrz+1EfS
	oFUxklECWjjNx6kmVBmLSj2dKjfFxuu5LzjGDOekwYQFDeI7Jo11dLu/YNRIx6rmj35Zd/nMHds
	q/PPyuwGFAy26y5BQBAZhbGh4K0SZ/GInhCrjC6HJM7oT+6MeKrpHSLBuxwJrF4F7scIfYAS/6h
	aIHkPSyPxZW5N9RMvzp+HNgwVX9uGBd83ZUBSMcJW2QkS63oeEjrbODt+n4vLTqBY=
X-Received: by 2002:a05:7300:881a:b0:343:fb75:a5f2 with SMTP id 5a478bee46e88-3537df8cec0mr33287226eec.9.1792117823096;
        Thu, 15 Oct 2026 19:30:23 -0700 (PDT)
Received: from 244668f92ec4 ([20.38.40.137])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-36082e81a06sm1818295eec.26.2026.10.15.19.30.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 15 Oct 2026 19:30:22 -0700 (PDT)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: [STATUS] stable/linux-5.15.y -
 792fbe1537d8daeca9bd1917e84078b5432aadc2
From: KernelCI bot <bot@kernelci.org>
To: kernelci-results@groups.io
Cc: stable@vger.kernel.org
Reply-To: kernelci@lists.linux.dev
Date: Fri, 16 Oct 2026 02:30:22 -0000
Message-ID: <179211782215.391248.4144883080170789624@244668f92ec4>



Hello,

Status summary for stable/linux-5.15.y

Dashboard:
https://d.kernelci.org/c/stable/linux-5.15.y/792fbe1537d8daeca9bd1917e84078b5432aadc2/

giturl: https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git
branch: linux-5.15.y
commit hash: 792fbe1537d8daeca9bd1917e84078b5432aadc2
origin: maestro
test start time: 2026-10-15 13:13:47.999000+00:00

Builds:	   48 ✅    0 ❌    0 ⚠️
Boots: 	   34 ✅    0 ❌    0 ⚠️
Tests: 	 4452 ✅  583 ❌  917 ⚠️

### POSSIBLE REGRESSIONS

  No possible regressions observed.


### FIXED REGRESSIONS
    
Hardware: beaglebone-black
  > Config: multi_v7_defconfig
    - Architecture/compiler: arm/gcc-14
      - ltp
      last run: https://d.kernelci.org/test/maestro:6ad0e38ca3f195e1aa8a76e0
      history:  > ❌  > ❌  > ❌  > ✅  > ✅  
            


### UNSTABLE TESTS
    
Hardware: qemu-arm64
  > Config: defconfig+netdev+nfs-root-boot+ltp
    - Architecture/compiler: arm64/gcc-15
      - ltp
      last run: https://d.kernelci.org/test/maestro:6ad0dfc0a3f195e1aa8a60e1
      history:  > ✅  > ✅  > ❌  > ✅  > ❌  
            


Sent every day if there were changes in the past 24 hours.
Legend: ✅ PASS   ❌ FAIL  ⚠️ INCONCLUSIVE

--
This is an experimental report format. Please send feedback in!
Talk to us at kernelci@lists.linux.dev

Made with love by the KernelCI team - https://kernelci.org
