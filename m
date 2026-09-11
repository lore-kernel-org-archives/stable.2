Received: from mail-pf1-f172.google.com (mail-pf1-f172.google.com [209.85.210.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 434CC360ECF
	for <stable@vger.kernel.org>; Fri, 11 Sep 2026 14:59:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789138756; cv=none; b=WmInoNrNBqMoHz2LVS71EIHInXxthSJVCydpBOOqZms6L43EEoRNOBgLq3wzrYzJ7FZ5FUUxPN60uf53MND8seIIUUhW/tpesxjcjEcztoq7nLQmW0eeBnjdKMj+GEgG8DN+nwcOPFgJ0o8QiIxYutlejugZWML6yeggafuHHfs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789138756; c=relaxed/simple;
	bh=kUzYawNpb0ha8PWkIZl96pxIs691uTS0lRY0RadNZh0=;
	h=Content-Type:MIME-Version:Subject:From:To:Cc:Date:Message-ID; b=U5gS142WSe5h/CoQwnXZB0LDCvnLnFdiTug9XbQ/S2bTNezUxVR81b44NELhagFFayY0LE6TXntW18SHoQHDLtvWM9dp/tglEVe4DnwEzdMyxUpJ4DRqg8tcsEmb9dkCknKjBQjeE/7nLo+wpbFKuBlSjYYTMgvdsR78XCwDmJU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=kernelci.org; spf=pass smtp.mailfrom=kernelci.org; dkim=pass (2048-bit key) header.d=kernelci.org header.i=@kernelci.org header.b=CIXPkpEB; arc=none smtp.client-ip=209.85.210.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=kernelci.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernelci.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernelci.org header.i=@kernelci.org header.b="CIXPkpEB"
Received: by mail-pf1-f172.google.com with SMTP id d2e1a72fcca58-86959a6f7f6so806396b3a.2
        for <stable@vger.kernel.org>; Fri, 11 Sep 2026 07:59:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci.org; s=google; t=1789138750; x=1789743550; darn=vger.kernel.org;
        h=message-id:date:reply-to:cc:to:from:subject
         :content-transfer-encoding:mime-version:content-type:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=b2b9X1/4+PCc0o9SA4jZwUOhU78P/n4TW+5PDhOxSm0=;
        b=CIXPkpEBbLjGHhEl6z+2s1n2dk9t1lNloc3zg2ii0MN7ybZ9Hkk77+3u7YjNT3ER1a
         ZWmCsaXSaYRSg5TMtW0mOC6Ugj63p8p296BGWawosd41TKn7o9wHt/UuC5BT1iL+Qdrb
         /bP+R8j300tQhscAidDw/4bjjAMQM197QlyRhpWC1LCs1zfuMG/BiNVcEHfeac4fwBpV
         SxgI4eLiFWZMG/kNBoKHVAwUHGhKAFr43z39tTSwugw+dQxuiakPWZLuWmjLhgT1KBg2
         dmmgk0OHVjv4EsdUHN6QksNXWmOtUrVTQEoE3gz1SP34HTh7eiGIlOBxj97awedO2oSH
         fyYQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1789138750; x=1789743550;
        h=message-id:date:reply-to:cc:to:from:subject
         :content-transfer-encoding:mime-version:content-type:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=b2b9X1/4+PCc0o9SA4jZwUOhU78P/n4TW+5PDhOxSm0=;
        b=cAYUlb4ffJrFEy9Ns41ZyjT7Vifz/wNJHhOsDzJBWEAJzaeX4C1fwbefMFW+7+60Iw
         iYXHOkwQ3wuEhVTWPydB7ivDTvMWY1bdVQ26cOEDdJZtINS7Yh9/8lR43SsYrilmB1t2
         2QLIOVw0ycNrJHUwhsKl4b8ZxXolMUsY64dI2DHZh1oDOy/RdV/6B8c0058Eo0ImcJDY
         qs1Y1e4+mQw9ir7KNFVM4aQxSx9zoP3HA6EmJwwsqlv5fkOOqFf2CaeTv+ZMvd9R1eVz
         Z6giweZjNEAT5I3SiySOHBvpjevgEXz2DihSko3E9pFEF3Um4mWZUCS+y7dF6Rb1Hu4b
         A3Jg==
X-Gm-Message-State: AFuF++mXc6rBewT2QxOah3xoGq30FT8KTMWBisNhZUJIMUY6itdF5wru
	RR7WltQc+E6EegTO/H8P16DZ37y2n2NaacsAqEac7g/YXAdUYXBCT2EgRBHQ2G4LzxJOluMdlTQ
	9fTQn
X-Gm-Gg: AYBFou37xDxI37Ceqn4/yK80X+Zh7rGpxgnRt38ETyimx3WcRbydTOZZYPsLD7TXABq
	l/QSQP4dZ4eLoAB3C2NhGO7tS0DWOYpVCX142WoRXO3nL+/39PB2qQL+UX7kFTahRtZnNNJRFsM
	8+sJc+jt4Q7oKGQ0Gs5yvXnId5I2dtrgn/VqVxu+JrcIzqFz3AJkWFeG2YHa4YTyxOdHIasmtzZ
	Gc4Z9WGDbOj7gMgpj/9LOzhgDqdexyowzmtMjw6bxDcsPYdkvv51oeyUmqAxwKYQsYvWE60Nrft
	SX1qghu8Y+kIQaTxhm/jfzDPcZi2v9bo1sF3TAaTwwGaMrcp/mx/zcBXCwtjoudBOgne4tzkw5c
	kYcz4nCs/Q/3W+xsXNLtiXGlDZTHolQ24zwDsGnkvoZvuCDbJ2gH5zXGRg3AoSvuuQ84s4vsm17
	yaP8js5T4ysSw7nvUAe5x6sOwLmmqCo4wyocjE+qc/VxjqsCc78iCcMjZvgUBbCmE=
X-Received: by 2002:a05:6a20:be8f:b0:3d3:af85:eb99 with SMTP id adf61e73a8af0-3daed434175mr8891166637.27.1789138750605;
        Fri, 11 Sep 2026 07:59:10 -0700 (PDT)
Received: from 41049dfc76e5 ([20.38.40.137])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-14365ba729dsm11187467c88.14.2026.09.11.07.59.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 11 Sep 2026 07:59:10 -0700 (PDT)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Subject: [REGRESSION] stable-rc/linux-6.6.y: (build)Error in
 kernel/irq/irqdomain
 (x86_64-linux-gnu-ld) [logspec:kbuild...
From: KernelCI bot <bot@kernelci.org>
To: kernelci-results@groups.io
Cc: stable@vger.kernel.org
Reply-To: kernelci@lists.linux.dev
Date: Fri, 11 Sep 2026 14:59:10 -0000
Message-ID: <178913874960.4387.17388412132836337883@kernelci.org>

New build issue found on stable-rc/linux-6.6.y:

---
Error in kernel/irq/irqdomain (x86_64-linux-gnu-ld) [logspec:kbuild,kbuild.compiler.linker_error]
---

Log excerpt:
=====================================================
x86_64-linux-gnu-ld: /tmp/kci/linux/kernel/irq/irqdomain.c:292:(.text+0xded): undefined reference to `irq_domain_remove_generic_chips'
pahole: .tmp_vmlinux.btf: Invalid argument
.btf.vmlinux.bin.o: file not recognized: file format not recognized

=====================================================

When fixing this issue, please attribute this report according to the
patch submission rules:

Reported-by: kernelci.org bot <bot@kernelci.org>

For complete logs and details about the environment used, see the issue
on the KernelCI dashboard:

- dashboard: https://d.kernelci.org/i/maestro:90a50186893242a7bac9c21e6aaedceb3f59e703
- giturl: https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git
- commit HEAD:  c33bbcf64a1d0e2170b7cdee977e2c00e258a70f

# Builds where the incident occurred:

## tinyconfig+kselftest on (x86_64):
- compiler: gcc-14
- config: None
- dashboard: https://d.kernelci.org/build/maestro:6aa40cab20239ade9022a703

#kernelci issue maestro:90a50186893242a7bac9c21e6aaedceb3f59e703

--
This is an experimental report format. Please send feedback in!
Talk to us at kernelci@lists.linux.dev

Made with love by the KernelCI team - https://kernelci.org
