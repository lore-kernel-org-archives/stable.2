Received: from mail-pg1-f171.google.com (mail-pg1-f171.google.com [209.85.215.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3C137348445
	for <stable@vger.kernel.org>; Tue, 13 Oct 2026 12:59:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791896353; cv=none; b=MVhH8GPi/LbgIzt9toDbGF/EoXyJREvYGP1pACorfyFjlozKQhge71eI296S9hgCuVU+GgazNW1MC82htxzT6YBmML/NNHT+ZTzqOTBpFcXT7B8BXPust7iTZF2R2u2gCeZD8LyqiLnRpX+fKfvE4m3wUYvFQnEPafXMO1fKbHs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791896353; c=relaxed/simple;
	bh=qyYb4Eq726CUS2SNReYaAzM5j+ZVcsjAdSZMVaJR+VE=;
	h=Content-Type:MIME-Version:Subject:From:To:Cc:Date:Message-ID; b=D4ZRo88s7S6tVD2shA4oKseLem5PI29LM3zAkot7Vp9Y0cULce3Uqii0qMGVanexqTVG0z04vgFur0t5p1b0gtO1YyjH+IJkAKClPcP4kbr7xeZs+SJVMXf6W47NWmdtc/XVb3f8gK0v41X5pNzhCL9aieCQs4GtcjYQ/us13zE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=kernelci.org; spf=pass smtp.mailfrom=kernelci.org; dkim=pass (2048-bit key) header.d=kernelci.org header.i=@kernelci.org header.b=jfftfPeq; arc=none smtp.client-ip=209.85.215.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=kernelci.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernelci.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernelci.org header.i=@kernelci.org header.b="jfftfPeq"
Received: by mail-pg1-f171.google.com with SMTP id 41be03b00d2f7-cc4c7fab7b6so1840376a12.0
        for <stable@vger.kernel.org>; Tue, 13 Oct 2026 05:59:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci.org; s=google; t=1791896351; x=1792501151; darn=vger.kernel.org;
        h=message-id:date:reply-to:cc:to:from:subject
         :content-transfer-encoding:mime-version:content-type:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=cLvW9/4iBafexcRcmFxADFITNJkPKYRhKK9DKhGCLUA=;
        b=jfftfPeqoyxr5MxRfZyyLap5Fy6WxGvN+GDVsUb1iSWNAgb5aGCLaBEC1BDAgtkesw
         EdExvoyyDvbm1pd5/km14a9rK2d0eIYweUmgTp8/7DSax5VAypTJGGQ8HauFLpWQSYur
         n/XLWdvURxnM34FyYNBdZP5/elTpHKqC8v5G8LBTx6WwfA8tuYp9nYRBcIhK8xSTRlBA
         V3pCAc2yNzYX1AKMJAJ8tjwro4yfpkvRTNPH3AP8BI8p/4muZtl0/nQBIMaWtSar2Ldf
         DnkIfrk3Xaj29KnZGxoi6SCiAX7jtgjXmCmLvACdMzXbyjqnYdxacqkfg1WSDDd19OVI
         BzHw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791896351; x=1792501151;
        h=message-id:date:reply-to:cc:to:from:subject
         :content-transfer-encoding:mime-version:content-type:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=cLvW9/4iBafexcRcmFxADFITNJkPKYRhKK9DKhGCLUA=;
        b=ZRw722lhs9QaN5Pep1NPzwLnKeF2ApXQMw9hbOxluia+5S01+RChlzCgG0ugJgrJhY
         DdUuMlf/bu4K+qtMbkPvcFrvnDTiQLj9W8U5B7hB1BYvvrTLKy58ZX+7FG8umajoIbOg
         8BnttJTLJaH/12uT4nfHWgjFqkS5lapM4bhSutzKJRK5deP82i+6yiJrTC+l0757JFcN
         YB2j1Xfk56ZRmZJ5MfbRQ2+Xhwnfrah1wBw3QAVGSF61eAuUrcTjEmax8nptJLpMUelm
         /RvAV4BWf21Tzo0l4LISjVYFZZVzDTc5RH3Ssp91gh/kFX+J1rfJXC5k0QMYvuPmSHnr
         QfWQ==
X-Gm-Message-State: AFq9FYLbRgaQJRCJz8kjgSYp8OTr87qc3rKHbUZdzXE/RVYSkbHUgwv0
	5++Lw9kCUBk90lkgQV3EO0bbhffteC75xQLeFxJtqJpDPhTpnyD1xiYYNASpIiO4mI1yax2odok
	ZBo7g
X-Gm-Gg: AYBFou10nVDxMw2N7gALPOFnPsPm4rxnZwhZf5Kx6lAXQWx5me1VXStx6h9MfM4+5WQ
	OtkXBaotDFVaLXswEfh6vkP9JMj63/WaONhaK+ReYgDkhRMOnp4S3NHcSggRglEq8b2IO25j8ps
	YBL1hkfS4lYXLl0QtnDU9kkGJjRJqZPf6RQN/vt0F2xIwiUSMm857czpcCKV673/+KRw+nD+1E1
	adDMAZcfIrnP9yXZcJ6uicrUqs2588VLq1bu7bgAnL2dvKfVxyeF9u0n964U384sow7bTaquK0C
	BAuNIuxYyxWgihsTsH74kucDdD315oqrQrCTpzbGcge2bh2UOS2O2iBErhYbzXhMl5Yeg0/4uSA
	MELn87Bfacg55VFQhfyCgXxPN9PftffoaqIqheideSrCy7oIxh8OaDM2mKwH49zhJTr+g4ByVbV
	zWunfyprVeIKGu4Zv5XaLS4uiGJkID9eq14dAMZ5LmLX2LdFBndjOtpbhIGRAhHP8E73HvooKu3
	g==
X-Received: by 2002:a05:701b:2411:b0:170:aeef:a170 with SMTP id a92af1059eb24-170aeefa475mr11811707c88.36.1791896351147;
        Tue, 13 Oct 2026 05:59:11 -0700 (PDT)
Received: from 244668f92ec4 ([20.38.40.137])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-1746482c978sm18811478c88.13.2026.10.13.05.59.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 13 Oct 2026 05:59:10 -0700 (PDT)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: 
 =?utf-8?q?=5BREGRESSION=5D_stable-rc/linux-5=2E10=2Ey=3A_=28build=29implicit?=
 =?utf-8?q?_declaration_of_function_=E2=80=98timer=5Fshutdown=5Fsync?=
 =?utf-8?q?=E2=80=99_=5B-Werror=3Dimp=2E=2E=2E?=
From: KernelCI bot <bot@kernelci.org>
To: kernelci-results@groups.io
Cc: stable@vger.kernel.org
Reply-To: kernelci@lists.linux.dev
Date: Tue, 13 Oct 2026 12:59:10 -0000
Message-ID: <179189634982.259497.9375661127898345576@kernelci.org>

New build issue found on stable-rc/linux-5.10.y:

---
implicit declaration of function ‘timer_shutdown_sync’ [-Werror=implicit-function-declaration] in drivers/usb/gadget/udc/at91_udc.o (drivers/usb/gadget/udc/at91_udc.c) [logspec:kbuild,kbuild.compiler.error]
---

Log excerpt:
=====================================================
/tmp/kci/linux/drivers/usb/gadget/udc/at91_udc.c:1815:9: error: implicit declaration of function ‘timer_shutdown_sync’ [-Werror=implicit-function-declaration]
 1815 |         timer_shutdown_sync(&udc->vbus_timer);
      |         ^~~~~~~~~~~~~~~~~~~
cc1: some warnings being treated as errors

=====================================================

When fixing this issue, please attribute this report according to the
patch submission rules:

Reported-by: kernelci.org bot <bot@kernelci.org>

For complete logs and details about the environment used, see the issue
on the KernelCI dashboard:

- dashboard: https://d.kernelci.org/i/maestro:29e7664f098f6157e6e013888bd3bb7e5aa1f9b3
- giturl: https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git
- commit HEAD:  1757ae41a94814c347aa9db18b08da11b3a7e7be

# Builds where the incident occurred:

## multi_v5_defconfig on (arm):
- compiler: gcc-14
- config: None
- dashboard: https://d.kernelci.org/build/maestro:6ace2519a3f195e1aa756377

#kernelci issue maestro:29e7664f098f6157e6e013888bd3bb7e5aa1f9b3

--
This is an experimental report format. Please send feedback in!
Talk to us at kernelci@lists.linux.dev

Made with love by the KernelCI team - https://kernelci.org
