Received: from mail-dy1-f169.google.com (mail-dy1-f169.google.com [74.125.82.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 089E933C1B7
	for <stable@vger.kernel.org>; Tue,  2 Jun 2026 02:30:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780367432; cv=none; b=W/8IXC+80wwFF3hZ85liEFGOzeXsEsPGQ2LYmV2dgEkUTQULdXTCXsY73v3/wdRnUM1RxTM5dHC/R6CwZ3C2JyXGMQzrrhkMEhps7D+Qvwc77Ld23+xWtawLQr9+AP4TWAejj3EFGk9YZV014ctWKn9o93EnxmIBBTV1gBI0Xs8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780367432; c=relaxed/simple;
	bh=mDsD3kRDaf3QAIDLrcOxfH1Fw2I/F56arUGI36o4usE=;
	h=Content-Type:MIME-Version:Subject:From:To:Cc:Date:Message-ID; b=PownnAZeN3f18dASSXOzNGypk0X9m3jjiSzSQKF9NdYubRsejYMrlXowDJJVPHhZRCBUuhA27OshcUF+FxbAbcPXw2i8/vbp3O+kfVhCGTlJJsJ4fl2eIPP5U5x+KyXEMdwp+gBpZ/hsoq1M+dciwgn2+prggEta28d3vS0ng5I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=kernelci.org; spf=pass smtp.mailfrom=kernelci.org; dkim=pass (2048-bit key) header.d=kernelci.org header.i=@kernelci.org header.b=YMWwKZ0G; arc=none smtp.client-ip=74.125.82.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=kernelci.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernelci.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernelci.org header.i=@kernelci.org header.b="YMWwKZ0G"
Received: by mail-dy1-f169.google.com with SMTP id 5a478bee46e88-304f0039c02so7097335eec.1
        for <stable@vger.kernel.org>; Mon, 01 Jun 2026 19:30:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci.org; s=google; t=1780367430; x=1780972230; darn=vger.kernel.org;
        h=message-id:date:reply-to:cc:to:from:subject
         :content-transfer-encoding:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=YsmEWBDZzOG5N/hZmtHVyPqgiM9gI9tFX+u8GXbkU3k=;
        b=YMWwKZ0Gl6ay5Lu0B0NcnyweDjH09iFB9bfLBEz3InHdSyQ4p7XY10teLxuDCxptel
         19rchoGIF1Im5HWKKjJsLLdmEtVcrOYWokO10WWrdW4b5VcKCGHftGqGcwI4sYnmaPGt
         RXNe2JdPS3GQvEHWfn6P2AiNI2RM4FkUYeT6QjDADOpNSc1WrVS/PMs9rCPk89MFEpqp
         oDpnUsNYh1OH1gFsBMQdx7gEomy01wOpow+72GJV77PRA8rrf74W64xzNOFWAhdh9QkM
         7912xO5G+0pY7p8PCS8oev77oTcjGFxTGh9DmAbI/K2/oXRPuZNM9Z99b0mTiywC/bcC
         0weQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780367430; x=1780972230;
        h=message-id:date:reply-to:cc:to:from:subject
         :content-transfer-encoding:mime-version:x-gm-gg:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=YsmEWBDZzOG5N/hZmtHVyPqgiM9gI9tFX+u8GXbkU3k=;
        b=JYbSQXVL5SIsoYon7TcPfUTQp2brXmRPhuyxZ3NbAKp1DZEnvvhuD1jjB4yoxX5X6D
         NUMAd6J5ELih4d9Jdo12Si1BjlKFY4xoEGVX5M2h6000PShF6cQ3LUn8KZ6Tg3uct+Qe
         GmxDBSMS+zd/T1t7C81hgubv1odO9e3SZLEhxevNSSiiwjiS4u0QDNvXr/9dSqtiCLYJ
         XepJ9JM/dzkhvKni2HRjlWB/I4O+zi7YMf8kE2bh7vVJwLgSRjsfwHwc6s2Whxsu7vty
         6Hk5mizeajvi5QyAW8ZMds30J3L8peB00k0af8YnEdC2uBkC/v8PZ9NYL2JoiusGBY9V
         AQXg==
X-Gm-Message-State: AOJu0Yzi5Mpp2yZYP28lNyQOQGO3O7LvTW7smLX4ANEPnH1H3iLNZYoq
	NPXWWU2npmpELAkQU7h3DyFcfhgcDGcz4XH03UbQ9vu4R1rIGFxp4ZPJxfcXL11MeaDMyVEgdni
	lQ4kl
X-Gm-Gg: Acq92OGH+YXG45TmrTiASVQs3Glo2aontL4tTEoImNCzG2vzBPuiS5untbHnbQZshLa
	/QwtoZlhnoGKY6DNvxNWUzIph/AbNHhLc3JvQPgYDToriuyyfZaYQLXL0wqBQ7477TihhgkHOzf
	zA3uK5DskNdqWQbalB8QhNwcP24LaikYjKz1khhjit0b0J5bJ0Y7fxcTUUmL8Nuo/V6ZN+vooW1
	nTpCMJWhtoOZ8DvOcGeJFmuFWc1nflcievcul5viGBq12qX7uw2LRyWr/ttMtIxgahrd4LHzTol
	qNiMw4PSHE+VChsnRR5/63wW6LQxYZ1clbcoUorgCLfm8sXwTYeanrgJ60abceI0QXDROVY1I+d
	3v7LJRIfymuPBplD0Dl041R+qsAeBMuk6WWK0/VBOIXERlITlCBiYZ+jeuKqYCTuEx7AteIRase
	RtM9rDfCvY4xuWhOTS25SGkULBWMQ=
X-Received: by 2002:a05:693c:2c0e:b0:2ea:b7a9:580d with SMTP id 5a478bee46e88-304fa4df21dmr6182929eec.9.1780367425203;
        Mon, 01 Jun 2026 19:30:25 -0700 (PDT)
Received: from 330cfa3079ca ([20.38.40.137])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-304ed53d06asm11280243eec.14.2026.06.01.19.30.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 01 Jun 2026 19:30:24 -0700 (PDT)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: [STATUS] stable/linux-5.15.y -
 dc027a595035729e290c0adffae363a653acde7c
From: KernelCI bot <bot@kernelci.org>
To: kernelci-results@groups.io
Cc: stable@vger.kernel.org
Reply-To: kernelci@lists.linux.dev
Date: Tue, 02 Jun 2026 02:30:24 -0000
Message-ID: <178036742399.9044.7165101612909060731@330cfa3079ca>





Hello,

Status summary for stable/linux-5.15.y

Dashboard:
https://d.kernelci.org/c/stable/linux-5.15.y/dc027a595035729e290c0adffae363a653acde7c/

giturl: https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git
branch: linux-5.15.y
commit hash: dc027a595035729e290c0adffae363a653acde7c
origin: maestro
test start time: 2026-06-01 16:34:32.365000+00:00

Builds:	   41 ✅    1 ❌    0 ⚠️
Boots: 	   33 ✅    0 ❌    5 ⚠️
Tests: 	  155 ✅   54 ❌  218 ⚠️

### POSSIBLE REGRESSIONS

  No possible regressions observed.


### FIXED REGRESSIONS

  No fixed regressions observed.


### UNSTABLE TESTS
    
Hardware: bcm2711-rpi-4-b
  > Config: defconfig+lab-setup+kselftest
    - Architecture/compiler: arm64/gcc-14
      - boot
      last run: https://d.kernelci.org/test/maestro:6a1dc6262cc72b6e94adb843
      history:  > ⚠️  > ✅  > ✅  
            
Hardware: beaglebone-black
  > Config: multi_v7_defconfig
    - Architecture/compiler: arm/gcc-14
      - boot
      last run: https://d.kernelci.org/test/maestro:6a1dc4dd2cc72b6e94adb0c3
      history:  > ✅  > ⚠️  
            
Hardware: qemu-x86_64
  > Config: x86_64_defconfig+lab-setup+x86-board+kselftest
    - Architecture/compiler: x86_64/gcc-14
      - boot
      last run: https://d.kernelci.org/test/maestro:6a1dc7172cc72b6e94adb9d0
      history:  > ✅  > ⚠️  > ✅  
            



This branch has 1 pre-existing build issues. See details in the dashboard.

Sent every day if there were changes in the past 24 hours.
Legend: ✅ PASS   ❌ FAIL  ⚠️ INCONCLUSIVE

--
This is an experimental report format. Please send feedback in!
Talk to us at kernelci@lists.linux.dev

Made with love by the KernelCI team - https://kernelci.org
