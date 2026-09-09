Received: from mail-pz2-f12.google.com (mail-pz2-f12.google.com [74.125.228.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7401149DBA5
	for <stable@vger.kernel.org>; Wed,  9 Sep 2026 16:59:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.228.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788973148; cv=none; b=d7Ok1usmISQOQfsnfmkpDqCG4eIu2MALGslsTIMPT1pIexLAFn3v16YL8OvFV59WDLI4SozOiIm818/EqRxLLdhQV6GGAK5GYtK75NGY2xFIvAhhgcm21ru27iZM2J9xESuuB7oNeNO0ej0zNcC65OQmnNLW5T3Y1Ia7Jx6HCTw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788973148; c=relaxed/simple;
	bh=c5R7aVdNEg2x7N3okHiAz18CWUe0QkTlPRrjxsUaCQ0=;
	h=Content-Type:MIME-Version:Subject:From:To:Cc:Date:Message-ID; b=RCtiz5BntxqwMRGJdIaI3BzUy5B/AqCnF2tKxiU2Ibs/O/weQJAHOi8NBRZVusE5apJhial7BnmZT5cvYUGVItYvidpOAFvHnkK1BLcZ2lwy4wj1VjoYfkOi/hbtf9ezIrHYHmvlTzIzw2UMzubYcgG7eeqtjHvb7HfBtZuUHrY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=kernelci.org; spf=pass smtp.mailfrom=kernelci.org; dkim=pass (2048-bit key) header.d=kernelci.org header.i=@kernelci.org header.b=fUwOkIlC; arc=none smtp.client-ip=74.125.228.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=kernelci.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernelci.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernelci.org header.i=@kernelci.org header.b="fUwOkIlC"
Received: by mail-pz2-f12.google.com with SMTP id 41be03b00d2f7-cc1cebad4acso1111844a12.3
        for <stable@vger.kernel.org>; Wed, 09 Sep 2026 09:59:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci.org; s=google; t=1788973146; x=1789577946; darn=vger.kernel.org;
        h=message-id:date:reply-to:cc:to:from:subject
         :content-transfer-encoding:mime-version:content-type:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=JBgbMPD5yqnCjyJH2HgvdDeZjemhOiTRiokghl4UlSQ=;
        b=fUwOkIlCddiRHvXy5xmcmHRsgwy+l9t9S5E6garAi9fvErf51waTaAJhNfOsu7Ikqv
         XjDF5A9OHCdCvIIuuFG7Hnfrku39xY62IV9XlQ0V/IWl5ptDopVs1/3T3HUjTeihbMMU
         rQnoElBQFrJFsZ+3090nz6PO8pVTu1apBEmPPAob/OTLgGTmSpYLMwkg8KOCpYFhvTy8
         We0cioKbN3wv6suRRgz03qKwPcQA4cLD9zxF+CcgLagVGFzTdXRCv2TP+PcOVcPyQmYi
         60K6KpjTdZQvcA3R3q5c+3a1zQh9rZkY4bMqLp06zhtHDljYqYKuy1W3LjG23CVITkrs
         lVeg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788973146; x=1789577946;
        h=message-id:date:reply-to:cc:to:from:subject
         :content-transfer-encoding:mime-version:content-type:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=JBgbMPD5yqnCjyJH2HgvdDeZjemhOiTRiokghl4UlSQ=;
        b=euI3VzQdp/3+SQn7WTKW94nrDmlYsO9T0Zf8Fq9h958HxwjAeMVS3uwfwbwegwSCMd
         l3edoUvjJCkHhiy4/JhZeo9L3tagD5YAjASj7oprLsTxV9hoQIfSkuU+IsYXKMxUdYOS
         k8OTqwySC766Z5I2AUVkL0XZ+d3T8hr9Juco4DP1FUYSTl1zqOgopFeUZ2EPHtLOi0wN
         GOzFI/DqYzpFt9tHNuynJpQAPSbi7iRKOP/Yu3WLbLTCA4HwkF9vhheGpAHDRBr8eYAT
         crExcj3/qGIna/o/pM7A9UFQs8nJ2N856k8vA+zqrDwd46E9BGFQYbUuCN9bvkSJw4yK
         oENA==
X-Gm-Message-State: AFuF++lTs4XReK8mxzYDddunYkYTRDHyP5LcLQNL3fNASic3k8n1ZgNy
	pHjjxapem4RR/tzamV9ATmKaEvH352d2K20f5++Vawu+MkmgkFlAK2C2eMcW1H7J49zsBV09S1n
	d3DMY
X-Gm-Gg: AYBFou0CIdGPfQtTNhp0qgN0uNNBgWiZCBf7H9WSwzJ7hvHBAY1OT2vfIeu2n6EJpLC
	ualG9G8ckGWcCrncv5D2rSinb0XM2usIi1Ga7OXdIthp4xEJaO4nmL7VvcrKuVaPQeG3Xs+UmVZ
	c6JDmtFz5bEERUaxVOHWplx5qjTk4tMpEqGlGR6IU5H8snTPTedC3zEcM6zKyAbyyPap7N2AUkP
	Jfo+OiDMSa6OYVQ93XBSpvn+LgJYedR2TSMYGAD3NY3cgUSaCX+l8Xekm0M16R6vn5Kaq/+kUm8
	lqYsTOT8r5oWzLvW5wXaRBV70+VSThS5c94djCzF+cHuVkApDH6a6L4WpY3ZlN3g0R1U7HAkC7A
	ZR0fTJnD3exHEFJwuNrubox0FGL0/3S1ixsbBvayuwHX00YdHoMrOwE1RhJzl0bQWquaObN680U
	cvDT4IlZBKr3KyL3OBcFW4uazo2fKUbKYyB2SEr0I4AoeO4+rTUOfeC0SPO5VNt/Yz51NlK/e+M
	g==
X-Received: by 2002:a05:6a21:6f88:b0:3d3:adad:f174 with SMTP id adf61e73a8af0-3dabb2713ffmr11608567637.22.1788973146415;
        Wed, 09 Sep 2026 09:59:06 -0700 (PDT)
Received: from 41049dfc76e5 ([20.38.40.137])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-3339befe870sm50470403eec.30.2026.09.09.09.59.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 09 Sep 2026 09:59:05 -0700 (PDT)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: 
 =?utf-8?q?=5BREGRESSION=5D_stable-rc/linux-5=2E15=2Ey=3A_=28build=29in_expan?=
 =?utf-8?q?sion_of_macro_=E2=80=98scoped=5Fguard=E2=80=99_in_arch/s390/kvm/k?=
 =?utf-8?q?vm-s390=2Eo_=28a=2E=2E=2E?=
From: KernelCI bot <bot@kernelci.org>
To: kernelci-results@groups.io
Cc: stable@vger.kernel.org
Reply-To: kernelci@lists.linux.dev
Date: Wed, 09 Sep 2026 16:59:05 -0000
Message-ID: <178897314512.3498.2949760605624382996@kernelci.org>

New build issue found on stable-rc/linux-5.15.y:

---
in expansion of macro ‘scoped_guard’ in arch/s390/kvm/kvm-s390.o (arch/s390/kvm/kvm-s390.c) [logspec:kbuild,kbuild.compiler.note]
---

Log excerpt:
=====================================================
/tmp/kci/linux/arch/s390/kvm/kvm-s390.c:3781:25: note: in expansion of macro ‘scoped_guard’
 3781 |                         scoped_guard(srcu, &vcpu->kvm->srcu)
      |                         ^~~~~~~~~~~~
/tmp/kci/linux/include/linux/cleanup.h:112:9: note: use option ‘-std=c99’, ‘-std=gnu99’, ‘-std=c11’ or ‘-std=gnu11’ to compile your code
  112 |         for (CLASS(_name, scope)(args),                                 \
      |         ^~~
/tmp/kci/linux/arch/s390/kvm/kvm-s390.c:3781:25: note: in expansion of macro ‘scoped_guard’
 3781 |                         scoped_guard(srcu, &vcpu->kvm->srcu)
      |                         ^~~~~~~~~~~~

=====================================================

When fixing this issue, please attribute this report according to the
patch submission rules:

Reported-by: kernelci.org bot <bot@kernelci.org>

For complete logs and details about the environment used, see the issue
on the KernelCI dashboard:

- dashboard: https://d.kernelci.org/i/maestro:a26662f49ef81f4cc2232274b0706dad1204b32a
- giturl: https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git
- commit HEAD:  270d4b1b855a6af72269a92c6949f7a8f9d1521c

# Builds where the incident occurred:

## defconfig on (s390):
- compiler: gcc-14
- config: None
- dashboard: https://d.kernelci.org/build/maestro:6aa16ac4e41d7f97d61b20dc

#kernelci issue maestro:a26662f49ef81f4cc2232274b0706dad1204b32a

--
This is an experimental report format. Please send feedback in!
Talk to us at kernelci@lists.linux.dev

Made with love by the KernelCI team - https://kernelci.org
