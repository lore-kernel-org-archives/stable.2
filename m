Received: from mail-dy1-f171.google.com (mail-dy1-f171.google.com [74.125.82.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DE755EADC
	for <stable@vger.kernel.org>; Fri, 16 Oct 2026 02:30:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792117832; cv=none; b=cpOyZx2w3kaAP4uxDgjH1icdB/DmWWoHY54NDvP2Kzm2F1Y6E3bUH1/UbSjH5yMWkOpszUCRqXlkS8l8NBHF7OZtZj8OLMfi9YQDKTI+j1owoUTDNuiHJ0QeHpiGHt7Y+fT9WNzCvNrkulmcN0yOEAeKG/d3hVRoZTFDHYGilrU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792117832; c=relaxed/simple;
	bh=2aHBKyzyDPwxKjLFuG/lKfSApDi21HJro/0T2g9ZUSQ=;
	h=Content-Type:MIME-Version:Subject:From:To:Cc:Date:Message-ID; b=m90Bmd8rNt/liLEpZpXm5UeZfN+MxadJvso2NL62uglDtu/TuCrZrDsovnt2sBrfs/VbWWg205hDMTVnY55QY15PHBDHlCkHUqIaIPVq9Irp4cwZ81cmWEKG3Bxt1wc84sKmBAeVSPXtapp/VFGkhUqB7FbauNbiMydluicu8rc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=kernelci.org; spf=pass smtp.mailfrom=kernelci.org; dkim=pass (2048-bit key) header.d=kernelci.org header.i=@kernelci.org header.b=Rz/W7qMZ; arc=none smtp.client-ip=74.125.82.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=kernelci.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernelci.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernelci.org header.i=@kernelci.org header.b="Rz/W7qMZ"
Received: by mail-dy1-f171.google.com with SMTP id 5a478bee46e88-30b6dad2382so14215231eec.0
        for <stable@vger.kernel.org>; Thu, 15 Oct 2026 19:30:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci.org; s=google; t=1792117830; x=1792722630; darn=vger.kernel.org;
        h=message-id:date:reply-to:cc:to:from:subject
         :content-transfer-encoding:mime-version:content-type:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=raleUUidVU5SiH4f5deCBNkKoHT0gs/9NJstJDzip4s=;
        b=Rz/W7qMZyiED5S/hzsI2nfK62vX9e0+NHCj4INQuAFuD7dvPN5e10vg08P/N4W2ERS
         MCwiNc1CnwZoGiYxQCUE3oJ9D7kQzEFxC+7t2OM0BDnLSsK140xVh75R/iFoJhHwt/ev
         Ta/XQ0t68Ca9ZCwwGqCZIJ3w4+gUo56+FEFPrvHDaWIbwysohLTV14t+UsCMt4lFXw/t
         85Jb6/6JggSZiHjYPldH+olp7NsbId/0l+Dr9JzHzzVrQvROwRZ7s/i07zHb+l2+iKub
         YEi+whR5wpMKboSZx/AVHr35GbN9T6Xqk+2N8ETPH1fIxylaI78B0G5VeXBV9VrDEcMo
         n/kg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792117830; x=1792722630;
        h=message-id:date:reply-to:cc:to:from:subject
         :content-transfer-encoding:mime-version:content-type:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=raleUUidVU5SiH4f5deCBNkKoHT0gs/9NJstJDzip4s=;
        b=Rc5JbCnIEXn8tPcQ4AHqHeA6b9J8CTb+SdS2tVyl9q3XmgInCp2mbSykbortIXp0sf
         GsDT7Vd7zSI9extwDvtxCBs2MAW2LPeXXIATYnN5Xk9Q9EQWy99ZhgJ/icYjjovFh8MC
         7NyDZAjaeyh2hFEPlTcYG6HRXg+7NfXjFbcup+9r0tHuv066ZknCLT+djC4ScCVi2myl
         taP77NDns29Z9zng0bpNW5bwxur/88c1oa/DCvL+2T/tkT2QXOTscxN2xAXbh72ucNOQ
         00jx9K1HAMsWpdXOtZWhRNuuEPI0jimM6gF5kN2+zW4BA+6+bPonTVtHCsOclPlu0Y9h
         ziTA==
X-Gm-Message-State: AFq9FYLBSDvt2Z0FmcY1ZtQgdonUJFek9d3XOEp+Xg5x8X9I5viyG85Z
	lpCYFmsIPX+W51TxXt//V8avFGkdhLp48YAbhILQdOAt/lxi/IW3n8S42XW9sJhOqPM=
X-Gm-Gg: AYBFou1N9VBCSe8mC2M719jfTPKrD8oz312Dw0iCgoZ8z1lICZVTCCz/eBn7nZHFkTT
	a8ctmeCiN2uQ9AidoUovuYEwiu+lu2t7PbXmm6IDSP+K5mYMHUoBcG+mUjWaFF+vVYcNec7kMsl
	5eWIEYi9VParf4i0LhsAOco7UNmbaTpJAwVFfp1nGcTKsF/0Uo9M2VERK9/vopAz7Jefwa+F5XY
	SWK/L0bc60br5E39y2mqBPGefFFiV6cHUZddSMH9awPKGtb8s1gKmJ5151Ggae4DHkIN94XikVX
	tRJqaVPDd8XxWftCQ8HrtDn5d1F955diV1jOjuymcjFeZl499EXdT2zNg8Cym8keKBuYhGvb2Us
	At+tUYRXdY5yfWgwU45F0GF7SlcN9BF/VMO3TB6jbCZf6R+62yEdBx6WMkZVrPOivpZFsCkyYCU
	tj4djxHAYVPRPH1hIoiT364DBKIDoofOW70LmY716m0RwFRxLLC0euAOAsviK30zY=
X-Received: by 2002:a05:7301:78cb:b0:351:515b:4e85 with SMTP id 5a478bee46e88-3537e088bd7mr28237870eec.16.1792117828724;
        Thu, 15 Oct 2026 19:30:28 -0700 (PDT)
Received: from 244668f92ec4 ([20.38.40.137])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-36081ab80f9sm2771982eec.12.2026.10.15.19.30.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 15 Oct 2026 19:30:28 -0700 (PDT)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: [STATUS] stable/linux-5.10.y -
 aca95a35f1bcc0626c4fa4d1252bf2d4c990a1a2
From: KernelCI bot <bot@kernelci.org>
To: kernelci-results@groups.io
Cc: stable@vger.kernel.org
Reply-To: kernelci@lists.linux.dev
Date: Fri, 16 Oct 2026 02:30:28 -0000
Message-ID: <179211782780.391248.15440734606510588202@244668f92ec4>



Hello,

Status summary for stable/linux-5.10.y

Dashboard:
https://d.kernelci.org/c/stable/linux-5.10.y/aca95a35f1bcc0626c4fa4d1252bf2d4c990a1a2/

giturl: https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git
branch: linux-5.10.y
commit hash: aca95a35f1bcc0626c4fa4d1252bf2d4c990a1a2
origin: maestro
test start time: 2026-10-15 13:13:47.611000+00:00

Builds:	   50 ✅    0 ❌    0 ⚠️
Boots: 	   35 ✅    0 ❌    0 ⚠️
Tests: 	 3918 ✅  607 ❌  656 ⚠️

### POSSIBLE REGRESSIONS
    
Hardware: beaglebone-black
  > Config: multi_v7_defconfig
    - Architecture/compiler: arm/gcc-14
      - ltp
      last run: https://d.kernelci.org/test/maestro:6ad0da06a3f195e1aa8a109c
      history:  > ✅  > ✅  > ❌  > ❌  > ❌  
            


### FIXED REGRESSIONS

  No fixed regressions observed.


### UNSTABLE TESTS
    
Hardware: qemu-arm64
  > Config: defconfig+netdev+nfs-root-boot+ltp
    - Architecture/compiler: arm64/gcc-15
      - ltp
      last run: https://d.kernelci.org/test/maestro:6ad0e50fa3f195e1aa8aa84f
      history:  > ✅  > ✅  > ❌  > ✅  > ❌  
            


Sent every day if there were changes in the past 24 hours.
Legend: ✅ PASS   ❌ FAIL  ⚠️ INCONCLUSIVE

--
This is an experimental report format. Please send feedback in!
Talk to us at kernelci@lists.linux.dev

Made with love by the KernelCI team - https://kernelci.org
