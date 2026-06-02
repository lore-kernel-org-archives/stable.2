Received: from mail-dy1-f170.google.com (mail-dy1-f170.google.com [74.125.82.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3F56D3655F8
	for <stable@vger.kernel.org>; Tue,  2 Jun 2026 02:30:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780367421; cv=none; b=M8K8L0U1FjZnyQZBCgkW3l+Z1ex34fc/cnuFMAjSVUeSig+qY/3FGtjrE0eNjF++EiVotfjlF/DosAAsY4/i2rxieJrfNvvzdE2uLyHoliZb+SaPITrTrRihnovQ69fKYYhk1lk2SbnSnkTMdB/0t8jb/KTLzHzKX5Esi0puOhY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780367421; c=relaxed/simple;
	bh=aNCY4Nq5ceBE7HoT3WZkwMVjg1SBA6PiZRePzYRybEo=;
	h=Content-Type:MIME-Version:Subject:From:To:Cc:Date:Message-ID; b=TapAU4G6nnQCU+Y6JnBplQzr3+Jy1ZXbHsYoYXctDRbdRFsfBBO8ax2YXE4d74+nwqO6n1cBaMOuw5ZGcyysJ0mw2q20n4jPV6EGLyf+/XV+CTcMwBVlP7+GkB9n5tx+YKz6/PukusiQsPDh+pcouwm0SuGgCW5P6KskiQEParA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=kernelci.org; spf=pass smtp.mailfrom=kernelci.org; dkim=pass (2048-bit key) header.d=kernelci.org header.i=@kernelci.org header.b=Qge5bvG/; arc=none smtp.client-ip=74.125.82.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=kernelci.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernelci.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernelci.org header.i=@kernelci.org header.b="Qge5bvG/"
Received: by mail-dy1-f170.google.com with SMTP id 5a478bee46e88-307263ad0cbso1760842eec.0
        for <stable@vger.kernel.org>; Mon, 01 Jun 2026 19:30:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci.org; s=google; t=1780367419; x=1780972219; darn=vger.kernel.org;
        h=message-id:date:reply-to:cc:to:from:subject
         :content-transfer-encoding:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=PQYZrl+XAeWhFuy7ePSShrqD8baJpYflZDNrv2mZ/y0=;
        b=Qge5bvG/ZpcNA3qrOjKi03Xt5sa33aWbniNi8bgE2tR5zp4jn+rqrZvov8SIwdO1In
         TQmeSr4VPNs9znIrmDZXCQKtDEZVRJhpjxhExE/Cm8WKIbR+nhrx0P0bTvJxaKgvIPVi
         QUfqmyvkBcQ21Lq/QkULyk3IaagPe599hOyh29zLLe1w36jH4RoR/FvJVY4xkymUSWHx
         QA7eJfOEuKWEckPicks1eRNw2qMzImb5mTYDpGIqDcviMt/KySc8mgv0tg5ZoZQ4WJQx
         tTaR00d+UwzscVptHnQ12BUIUowBru85Xngv4JlceADcxleoQY6bdEiK5NHslZ+0QVm4
         FQDQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780367419; x=1780972219;
        h=message-id:date:reply-to:cc:to:from:subject
         :content-transfer-encoding:mime-version:x-gm-gg:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=PQYZrl+XAeWhFuy7ePSShrqD8baJpYflZDNrv2mZ/y0=;
        b=Zr5GNxmCPlFbsiW4ECwR1lgI/YWf5YdMXZycLUXKja4YVMkWqcR0c3RIk6eLJIYgnT
         rOn9wLAnRBPYdMFQHRcrXyjLSddokulwbvrczaFu7EpyZhYurB0gNojq6BsuARnjrNyU
         9WMVnSaF7f4tZO6pLKuNpgVwRPud5uM5Ui6/u2BTjd/maUb1inOjxpQipJylhrPhySDv
         2BKtvDZZ0hINBKhjMm/pwYGX3Z9keQF9Y0J8d852VIqmD9sQKg66PmTJOZvhehG+uyEY
         2C27+vsJRWByIxVwO4j6wlNAKA5JeRRmx/f+FI6NKv9DtETtH0Ubxc9wP1Zta5m1zZTL
         e1Mw==
X-Gm-Message-State: AOJu0YxTGhfisYulPDsRWTNkxSbUz41kBGlQEQKBHCbjmYENXwye/DWF
	+4H4TXqwYilp0mUdKySa1OO55pKuq+hTV4yXmCXi51WLfsr+sh667EwDviv1aur9YVR0KmMD7hV
	qjkai
X-Gm-Gg: Acq92OFNiL+BYzuwvZcww80Wt+r7xxqKb8YZRx7Df70N/rHdSbrTQY7RDGxSCNhXQdL
	9tV4ZTaG0715cQU3vczVvhZOfAyMMxzwpKAdw2KOAfbljwsB5HWV5qr6AdVDAi+tfjjqR2eqLgX
	iyAYOtEhAQDhHuIgpyTtiV3HzsYg+eEpGEZywFSJX4Pp+SQoChH+GbebCUP7QII8U8fImR7kLI8
	820jDXZXcqztLBISBTDLjnfwgWiKew/6Z0G5FY8nPie76j2PcNpGfr0ZfRzRKfVugoUlWDPQR46
	l2sjAaqB4UdEuDdrj2oqXIY62WWcMvgsA5kyoAhYgMHdpoSVd2J6DlcccFGhQyQmRtQJXiZ+3qQ
	vaHlY+HZ87fVm8rY7Z0h6aOVC2j64KX3T0GoOPfzSC+uGT+SbOwQpR39+jzpLsLD2DjaYBKuY9A
	mHcqMF2Sua8r/ZP8m+5KP6tsCfzCw=
X-Received: by 2002:a05:7300:6ca7:b0:304:4f23:4466 with SMTP id 5a478bee46e88-304fa50140fmr7440455eec.15.1780367418910;
        Mon, 01 Jun 2026 19:30:18 -0700 (PDT)
Received: from 330cfa3079ca ([20.38.40.137])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-304ed53d06asm11279966eec.14.2026.06.01.19.30.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 01 Jun 2026 19:30:18 -0700 (PDT)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: [STATUS] stable/linux-5.10.y -
 5dbd240ac9a06a52a2c7e70b69b6fd7d11aeb359
From: KernelCI bot <bot@kernelci.org>
To: kernelci-results@groups.io
Cc: stable@vger.kernel.org
Reply-To: kernelci@lists.linux.dev
Date: Tue, 02 Jun 2026 02:30:18 -0000
Message-ID: <178036741789.9044.4944475782934688113@330cfa3079ca>





Hello,

Status summary for stable/linux-5.10.y

Dashboard:
https://d.kernelci.org/c/stable/linux-5.10.y/5dbd240ac9a06a52a2c7e70b69b6fd7d11aeb359/

giturl: https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git
branch: linux-5.10.y
commit hash: 5dbd240ac9a06a52a2c7e70b69b6fd7d11aeb359
origin: maestro
test start time: 2026-06-01 16:34:31.937000+00:00

Builds:	   42 ✅    0 ❌    0 ⚠️
Boots: 	   33 ✅    0 ❌    4 ⚠️
Tests: 	  229 ✅   49 ❌   33 ⚠️

### POSSIBLE REGRESSIONS

  No possible regressions observed.


### FIXED REGRESSIONS

  No fixed regressions observed.


### UNSTABLE TESTS
    
Hardware: bcm2711-rpi-4-b
  > Config: defconfig+lab-setup+kselftest
    - Architecture/compiler: arm64/gcc-14
      - boot
      last run: https://d.kernelci.org/test/maestro:6a1dd9812cc72b6e94ae7639
      history:  > ⚠️  > ✅  > ✅  
            
Hardware: beaglebone-black
  > Config: multi_v7_defconfig
    - Architecture/compiler: arm/gcc-14
      - boot
      last run: https://d.kernelci.org/test/maestro:6a1dcd9c2cc72b6e94ae14e7
      history:  > ✅  > ⚠️  
            
Hardware: qemu-x86_64
  > Config: x86_64_defconfig+lab-setup+x86-board+kselftest
    - Architecture/compiler: x86_64/gcc-14
      - boot
      last run: https://d.kernelci.org/test/maestro:6a1dc86c2cc72b6e94adc384
      history:  > ✅  > ⚠️  > ✅  
            


Sent every day if there were changes in the past 24 hours.
Legend: ✅ PASS   ❌ FAIL  ⚠️ INCONCLUSIVE

--
This is an experimental report format. Please send feedback in!
Talk to us at kernelci@lists.linux.dev

Made with love by the KernelCI team - https://kernelci.org
