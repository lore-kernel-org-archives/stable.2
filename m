Received: from mail-pj2-f12.google.com (mail-pj2-f12.google.com [74.125.227.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 817585540A0
	for <stable@vger.kernel.org>; Wed,  9 Sep 2026 15:59:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.227.140
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788969547; cv=none; b=b08tbeTopT8GbFCvKHt4VKqmcvOoZYhMvVo9uCQhUJ3LkW71sq29XwHy9qYdEyjSMQ2iwqb8iFZr3SRitLHxpwPLMFXJnXbCxi3nSjY2FFQV0ICbdTatFBbB9ehPUQ4d9pJKH6T0qdLDm5N0lWKrD63lUE2Q1eE3g62agPFvAlU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788969547; c=relaxed/simple;
	bh=/ru7/I/XMtKxLUAuERo5NLneP0WB9lsUJ4zzGb3xq+4=;
	h=Content-Type:MIME-Version:Subject:From:To:Cc:Date:Message-ID; b=iOiPV/SrDc/Z9QC9s1UWxMqJC79b3cbWvM94+Z6uFA4EbF2r4abeot9wUEMLj7ZgzWpQJru5mWptoQjrrVEKF/wX6nVYiVRG4x5FHi627hg/eilBgVa0dOTz6JIQRy5rrBctdKdJS84JPFYI8lsIky25ZmEGXYjuXj4AFQr28EA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=kernelci.org; spf=pass smtp.mailfrom=kernelci.org; dkim=pass (2048-bit key) header.d=kernelci.org header.i=@kernelci.org header.b=Pz041B5Z; arc=none smtp.client-ip=74.125.227.140
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=kernelci.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernelci.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernelci.org header.i=@kernelci.org header.b="Pz041B5Z"
Received: by mail-pj2-f12.google.com with SMTP id d9443c01a7336-2d8fe517774so15664225ad.0
        for <stable@vger.kernel.org>; Wed, 09 Sep 2026 08:59:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci.org; s=google; t=1788969545; x=1789574345; darn=vger.kernel.org;
        h=message-id:date:reply-to:cc:to:from:subject
         :content-transfer-encoding:mime-version:content-type:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=wAyQRcCYF6d1kTq/5OHkKv/8O6IEWndwF7dkuMdX6cQ=;
        b=Pz041B5ZgZJuATxRWIRQsS0+HKbZv1lkvot6YN0sYT6EMzBT8615bG/GO7ATxjSuC7
         bks39K+ptA2X20C4FOA8/oUiN7/QQv/aLT30XQeCw+3EJkZUNc5tS/cCWKI9glCbAr5g
         r0H6YQAeEpBbFo3Uznlqyjyl+ectpkqoQ2pO2YjN8mKuc4oTFLH2UHsRTE5xzUzsFCti
         amqoRuG/6/kSVyX1NIQayDzxJnN2bV39WqcLKUvfQrjQirP7x+XcHVhk7xD4Zs6hJlG6
         qZSkyfkusReKGeDl/+/mGtMy9tgJzFWD5dHdJL8YCKsZ5XDYXhKU4Ch5lH3F0dm86ioy
         STiQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788969545; x=1789574345;
        h=message-id:date:reply-to:cc:to:from:subject
         :content-transfer-encoding:mime-version:content-type:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=wAyQRcCYF6d1kTq/5OHkKv/8O6IEWndwF7dkuMdX6cQ=;
        b=FMNFeK+Np/MAzIeDtzKw2k98xYPnZvNTneneeNf5SbdRTADatLviWvdvAwfBL4uY8w
         Mr7B4bALsiSrKFL4UCnyCYKc1+AkbENpHPOZHPMjI+csQXDYaAOCjFj0lC4yeLeOynwl
         0I5ab8CjGMNAfJu6nfDSpiQo/Jzi4+15zqh6csG7937dXYlYkrOIGt94CKPcocVg+tw+
         Jzk4mMJFFamV20fderjprFdkBgTeF63B04DrxVrWdZemn5KMfuySXbAS442AmehoQrsJ
         uxyIo3hXLd9dctylUs0m0D7tqsgIpMfnyX2OV8Y61tNzVbP2P1vsxkaKkFnRuZ2Bu8sb
         sxmQ==
X-Gm-Message-State: AFuF++lc358PJtAqhC3LSOowAkP/ZzcmSZ/EK6m6sk0HSlI1tkV8G7R/
	7DFgg1zzUHaN0w1zIca2RhOlzlya+Xd209SQ8WLW2QaX0rlUrz1VFk/9zAwidPYylSHQqTkRx2G
	2GN9r
X-Gm-Gg: AYBFou0Xqt1gkgr/tDNGKsnFsqWCY0kAZ4LP77AdFNlykEx+e7Nn91GIOgBkrvnMAC/
	MJkYf6/O2KBDU342LoY2J1M441FTPs4w8Om9TyDQTcVLXkAa8tETKcN/PW9IoO7SJZG+k5e101J
	inJ7MTDxgofdjubRsaCtugqU7vicBFpHV1tePRDt8mjpzVNXqHOss4gGX6XYayz7hRAJnYsoHCZ
	XwisNadoz4m4Rj7wxZi9LXOl9hr8OAhuvF4lzZTwp7tD247c4BPyGLHkoOuzJuE4MiTwLf8YU51
	IAS/M9psMXQH9oR5ep7tk9V7KyY2UP88CkQxe99wqs+ZdhBmTdKknPH5YRPwyWZxvwjXmQdo/eS
	mxO2DJS5t2qOgu/d5YlUK4Y7sefg3sQ8GNf8eTwYHSZTRQp1vj5rkp+r6CDStBSE9ZSsoC1lHno
	6JtXjhW8pQvLJd/Ptlu9kTHXMjpUWmXBJ+rHqF2TXGLGFtXozp20Yq8oJraexa6RM=
X-Received: by 2002:a17:90b:3d89:b0:398:dcfe:968e with SMTP id 98e67ed59e1d1-39bac3f9063mr10287713a91.20.1788969544783;
        Wed, 09 Sep 2026 08:59:04 -0700 (PDT)
Received: from 41049dfc76e5 ([20.38.40.137])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-1434bb7d71fsm13584411c88.15.2026.09.09.08.59.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 09 Sep 2026 08:59:04 -0700 (PDT)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: 
 =?utf-8?q?=5BREGRESSION=5D_stable-rc/linux-5=2E10=2Ey=3A_=28build=29in_expan?=
 =?utf-8?q?sion_of_macro_=E2=80=98scoped=5Fguard=E2=80=99_in_arch/s390/kvm/k?=
 =?utf-8?q?vm-s390=2Eo_=28a=2E=2E=2E?=
From: KernelCI bot <bot@kernelci.org>
To: kernelci-results@groups.io
Cc: stable@vger.kernel.org
Reply-To: kernelci@lists.linux.dev
Date: Wed, 09 Sep 2026 15:59:03 -0000
Message-ID: <178896954331.3480.8894268600332692242@kernelci.org>

New build issue found on stable-rc/linux-5.10.y:

---
in expansion of macro ‘scoped_guard’ in arch/s390/kvm/kvm-s390.o (arch/s390/kvm/kvm-s390.c) [logspec:kbuild,kbuild.compiler.note]
---

Log excerpt:
=====================================================
/tmp/kci/linux/arch/s390/kvm/kvm-s390.c:3729:25: note: in expansion of macro ‘scoped_guard’
 3729 |                         scoped_guard(srcu, &vcpu->kvm->srcu)
      |                         ^~~~~~~~~~~~
/tmp/kci/linux/include/linux/cleanup.h:112:9: note: use option ‘-std=c99’, ‘-std=gnu99’, ‘-std=c11’ or ‘-std=gnu11’ to compile your code
  112 |         for (CLASS(_name, scope)(args),                                 \
      |         ^~~
/tmp/kci/linux/arch/s390/kvm/kvm-s390.c:3729:25: note: in expansion of macro ‘scoped_guard’
 3729 |                         scoped_guard(srcu, &vcpu->kvm->srcu)
      |                         ^~~~~~~~~~~~

=====================================================

When fixing this issue, please attribute this report according to the
patch submission rules:

Reported-by: kernelci.org bot <bot@kernelci.org>

For complete logs and details about the environment used, see the issue
on the KernelCI dashboard:

- dashboard: https://d.kernelci.org/i/maestro:52bd189a003d679b0a6cab75ce843a67765c75a0
- giturl: https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git
- commit HEAD:  38adf93fff4adacf792704fb2ad9df849b7a0ed0

# Builds where the incident occurred:

## defconfig on (s390):
- compiler: gcc-14
- config: None
- dashboard: https://d.kernelci.org/build/maestro:6aa16a25e41d7f97d61b2018

#kernelci issue maestro:52bd189a003d679b0a6cab75ce843a67765c75a0

--
This is an experimental report format. Please send feedback in!
Talk to us at kernelci@lists.linux.dev

Made with love by the KernelCI team - https://kernelci.org
