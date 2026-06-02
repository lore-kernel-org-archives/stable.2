Received: from mail-dy1-f176.google.com (mail-dy1-f176.google.com [74.125.82.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B76DA36604F
	for <stable@vger.kernel.org>; Tue,  2 Jun 2026 02:30:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780367422; cv=none; b=ekLFkmBkdv53eVSQzAbefdXzF+Sx/x2EccfTzCCr4F9K43Vl32W9gSet5MDgHcSca0BuPHAAPiyRS8goAv5K/rQC6Ceqj2dk8HmWgK6vf/gI6KimbEDwn8fGhHDITsMbCDGD/dOpFUuGQ3w/HKBAfjOzyAhHztf7Xi1mWIyQKKg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780367422; c=relaxed/simple;
	bh=gQA2125pJ470xFU+F+1HYzIQBUGcBzLqq//RGy+PezI=;
	h=Content-Type:MIME-Version:Subject:From:To:Cc:Date:Message-ID; b=ukJ1tRofqfzho4cMIYaJyzc4nKc5uxhkRnETB7PQzY2yeYF1uwgikr2FVLvtZsd1c+Ki+wEyB+MIyxBJU6XltmVtcCr35jaZw1yfYuR75o6HWcNAsh3tcpFAmNPi8wzTeB53N0+kzzFM71jyIDT+G7HDh2FXh8ITNnuaReP8Org=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=kernelci.org; spf=pass smtp.mailfrom=kernelci.org; dkim=pass (2048-bit key) header.d=kernelci.org header.i=@kernelci.org header.b=Lmc9LanT; arc=none smtp.client-ip=74.125.82.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=kernelci.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernelci.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernelci.org header.i=@kernelci.org header.b="Lmc9LanT"
Received: by mail-dy1-f176.google.com with SMTP id 5a478bee46e88-304d8e3bb72so7177017eec.1
        for <stable@vger.kernel.org>; Mon, 01 Jun 2026 19:30:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci.org; s=google; t=1780367421; x=1780972221; darn=vger.kernel.org;
        h=message-id:date:reply-to:cc:to:from:subject
         :content-transfer-encoding:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ozcxtYiumZ2/L/XtbbOFKXlwHbtdTdsqD/XctTwvANI=;
        b=Lmc9LanT1wrrSziw0u+RLyLbjHdcGUpIbiBGJ8logyHnEk4O19lG0gT0oD+XYxNU/m
         YslrEnpMg2IPkqBSQp9UPvHdqWHcVLXcGVsOS4oFkDcwptsNC9AYS6l790u2l3yo1L5n
         QE53cGs4BAroDzg9dKvShji29j7ByLo/d8VCMjFilH9I9NXK9G+xDrVqW/5YtnZ340WF
         sdhuf0GfofBnFojlDRJLIJCClpBEyqFAE0iTXDDnGaobvxZeiPm2dJIGHuZWeuYxJBSe
         7vQyM0S1wmV/WNl1tolbf70Ohn0UYHtHbXNcrxQ6kJ/9KJF8H8rrOg5uERPZkxNzqzqd
         eAyQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780367421; x=1780972221;
        h=message-id:date:reply-to:cc:to:from:subject
         :content-transfer-encoding:mime-version:x-gm-gg:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=ozcxtYiumZ2/L/XtbbOFKXlwHbtdTdsqD/XctTwvANI=;
        b=JgtwDAuVOToC4Z4sLrG7RcCpCndhhQ8lv2kqVxtGxjovxTSPcqj+xosJKcdeS495Bp
         Bu24mGkPi+4SzjTa2mAM/MfeOjwD99lri13pC5sRE9H/9RlD9X5LpCfjQgfJ5mNf0hd7
         8FFLy4EWXOAf2mKPAszpd27r8iuLLYBhsCx4P6eWwv4Qrs636NGT/lVOPcB4m9bPIkJd
         iZD4Ztam/qlc2WVxfu4Oz4dV6NIxDSgoNrFUUKG6quudD5vwQA6141ruq9lI8g5Eumx6
         707r7CfkUfHxuVMO5TCktX7VODpHwXZ+jGnUQPMMpN+N6OaQfSpph9cJuDD75ExHJ9xs
         ppWA==
X-Gm-Message-State: AOJu0YzJVF38q2mJ79e386cw/i/7WTu8r4c8nFDdLVBFdLW6RuAsncg0
	8uLTuViJc9sbW6CiY5E5WJhPZGk4/+A7K5vNa89tGhZySzCnl9dqQKf5dsRZNWc3PB+5RvxhJ+i
	ipf9V
X-Gm-Gg: Acq92OFBLBWkFqtCVeGUZNIHj3aHjG0beBIyLdHaEbhqToOsqyWxZoco7Nh4tWLU7GM
	he4o4sDQuqT+NKhXeZSDe56cD8Zwc7vee5DlznvRKdF0O/k3vMpvqgvCTCEEVAlAZBEDnFMQei3
	4af4ssm820VXUa+mbLjblltZNeVZEFmrhu638zYEF77apGLLdeMSI8HGJZcduhrMM+mnu+gAQUt
	9Q+iNYoODhZ4z6Hp8PfgfcOHPer5ORSf7qcjeaDKBSu2QPKhkiUTKf/OhPs0rME91iaKsxc9C6h
	xuC9uVnxM9OvE/t72JMDBzw1w/fHSyF7iL5Dq/X4+c380+zYrCN3nbbCG/HdMIwDUAlMkcGpEuP
	WrbdhdH3mPzN0KdKybZ7NMRBj9yGEDuxKpKwAcRX3ur6a0/9JNkwlc2ShdBEFWSIPklnwrtqsfw
	2QoWeRcv4dCK4zo6h0jhYEcbXys7A=
X-Received: by 2002:a05:7301:fa06:b0:304:6448:dfea with SMTP id 5a478bee46e88-304fa774efbmr7103655eec.33.1780367420763;
        Mon, 01 Jun 2026 19:30:20 -0700 (PDT)
Received: from 330cfa3079ca ([20.38.40.137])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-304ed2bdda4sm9573792eec.2.2026.06.01.19.30.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 01 Jun 2026 19:30:20 -0700 (PDT)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: [STATUS] stable/linux-6.6.y -
 924b4a879cbb75aef37c160b955b92f6894b11a4
From: KernelCI bot <bot@kernelci.org>
To: kernelci-results@groups.io
Cc: stable@vger.kernel.org
Reply-To: kernelci@lists.linux.dev
Date: Tue, 02 Jun 2026 02:30:20 -0000
Message-ID: <178036741976.9044.7171249950062987129@330cfa3079ca>





Hello,

Status summary for stable/linux-6.6.y

Dashboard:
https://d.kernelci.org/c/stable/linux-6.6.y/924b4a879cbb75aef37c160b955b92f6894b11a4/

giturl: https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git
branch: linux-6.6.y
commit hash: 924b4a879cbb75aef37c160b955b92f6894b11a4
origin: maestro
test start time: 2026-06-01 16:34:33.207000+00:00

Builds:	   44 ✅    0 ❌    0 ⚠️
Boots: 	   59 ✅    0 ❌    6 ⚠️
Tests: 	 3891 ✅ 1546 ❌  924 ⚠️

### POSSIBLE REGRESSIONS

  No possible regressions observed.


### FIXED REGRESSIONS

  No fixed regressions observed.


### UNSTABLE TESTS
    
Hardware: bcm2711-rpi-4-b
  > Config: defconfig+lab-setup+kselftest
    - Architecture/compiler: arm64/gcc-14
      - boot
      last run: https://d.kernelci.org/test/maestro:6a1dfc752cc72b6e94afb3dc
      history:  > ⚠️  > ✅  > ✅  
            
Hardware: beaglebone-black
  > Config: multi_v7_defconfig
    - Architecture/compiler: arm/gcc-14
      - boot
      last run: https://d.kernelci.org/test/maestro:6a1df98e2cc72b6e94afa9c5
      history:  > ✅  > ⚠️  > ✅  
            
Hardware: imx6dl-udoo
  > Config: multi_v7_defconfig
    - Architecture/compiler: arm/gcc-14
      - boot
      last run: https://d.kernelci.org/test/maestro:6a1df9902cc72b6e94afa9c8
      history:  > ⚠️  > ✅  
            
Hardware: qemu-x86_64
  > Config: x86_64_defconfig+lab-setup+x86-board+kselftest
    - Architecture/compiler: x86_64/gcc-14
      - boot
      last run: https://d.kernelci.org/test/maestro:6a1dc25f2cc72b6e94ad9754
      history:  > ✅  > ⚠️  > ✅  
            


Sent every day if there were changes in the past 24 hours.
Legend: ✅ PASS   ❌ FAIL  ⚠️ INCONCLUSIVE

--
This is an experimental report format. Please send feedback in!
Talk to us at kernelci@lists.linux.dev

Made with love by the KernelCI team - https://kernelci.org
