Received: from mail-pl1-f172.google.com (mail-pl1-f172.google.com [209.85.214.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EF89358E2AD
	for <stable@vger.kernel.org>; Wed,  9 Sep 2026 14:59:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788965951; cv=none; b=ahpjh/MUt1JMpVA9TubKd8d7YfknnPtmVlYcUuZIotJUYNYqvw5U9ixgwfO4nvrJcaMfWKqd1E0qXYAf3BHD9orgARfEtq93Bc4Q4dNvL7NUPLp0AzUumFIXyc9Pa1SfYP9xugOZE2zAhg7I/3fp/2DQq4o3AdOeBXUEsM2SKDs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788965951; c=relaxed/simple;
	bh=5MAVzkk8JypYcFZR06qN64R1t3R/J3Ccn/PvyyeCqi0=;
	h=Content-Type:MIME-Version:Subject:From:To:Cc:Date:Message-ID; b=TSnJAqB+YhER00H0oCedhcFfoxcwn+qUE2WKpDz7fevPlD8niUs80wtpPPzqHD0w+wUszLVV2rdBQ5loFVZ6lXsUX0zq4JZ2mHzrGi22oqJjaKMe5dedFuoSlfGMDqCiS/0v11Go/cxj3S5rCpfJfNjEQO0XfyvSb6pSRiQXPTc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=kernelci.org; spf=pass smtp.mailfrom=kernelci.org; dkim=pass (2048-bit key) header.d=kernelci.org header.i=@kernelci.org header.b=aZkCiU3Z; arc=none smtp.client-ip=209.85.214.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=kernelci.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernelci.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernelci.org header.i=@kernelci.org header.b="aZkCiU3Z"
Received: by mail-pl1-f172.google.com with SMTP id d9443c01a7336-2dd020a2e44so6580885ad.1
        for <stable@vger.kernel.org>; Wed, 09 Sep 2026 07:59:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci.org; s=google; t=1788965949; x=1789570749; darn=vger.kernel.org;
        h=message-id:date:reply-to:cc:to:from:subject
         :content-transfer-encoding:mime-version:content-type:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=8Tj5UPHhcRhyRXvn0B6wproJh3BP1RayaBpH/THZkyc=;
        b=aZkCiU3ZZTZG6Oh3VvLo1bVG3jhFjea8ag0DKH+kuzu+tZG6PZ33rFDbXV9kSIEcnd
         skUHFVLCABB930hE/YPxqeVc6SJKrGCc1vfdY6HLtiiL9ewZg80X4sm7nK3wKjEe2C3C
         x3JbWda+F29lc8g/u1DMkyCtLmL33F8lLb60diE+qUwIi6FEF4g7KY5rLhRe1UeImo9h
         ZS3I4bFEYsoANxIhCJFygilFrCeizj5HPbqVYKc47YNyZoAPTOrY5RI9kbYPrfYEW7wV
         Cr+HilOfX0oxH+eU58RHNLq/hewvEvd2nAC2ggQhq6Dy/txsM5wkyg3qZFdHHrgJ3kMN
         CmZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788965949; x=1789570749;
        h=message-id:date:reply-to:cc:to:from:subject
         :content-transfer-encoding:mime-version:content-type:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=8Tj5UPHhcRhyRXvn0B6wproJh3BP1RayaBpH/THZkyc=;
        b=jzPjDtt2ZAEs1rot8JM11VGzrB0z8YzcHr/sXFP/36rHqwvV9UxUfF5GZ7prEiz+0n
         BYxGFCBaqwMdCQJyWpHNPHsU+wbxug0L35PYMf8Xaz/QeWg/UF6IQ2iNyh0SWWz48OUJ
         7tZDImZFPY63ehMk7+V669yv+jFu3F1jk08tl+HHos78xjDhxk2L9vte3ZFVw2aCo+T1
         2V8FNLhmCGDieGVylzDj5oYI/NEWWtGfjhnj39TFA+RHgbqPIarpm9nRYEKhPA30KRnY
         cHRQRYdwidM56wfQNOjkI01bU2wpqbenJIhzrW/GrMm/iSl+g1KSaAKrEGzU7+1S3jN5
         SfZQ==
X-Gm-Message-State: AFuF++lx/rgx1QCLGGTck/7gGgjChroA9dJZabrsLiPjesDC6jVppW1H
	tGsZ/+o81tmo5XKrfhuSvtAdOR/T8JOEVFOcLylObkZdhQQBPSaHpxOu33Sx4Cxg6hANiC1ks9w
	2xey1
X-Gm-Gg: AYBFou26PonyeMReNXV7pKx7dDeGaMt3Q1OIDc/nE2kxj8slc6BlaUpkLfSEJd9xOWH
	HGoerdPeutQeDwdX0UPruZ5ylAJwoA5y51qR1q4UGODnhJAg6AFSGX5C5CjyfBhKLBFSrgbGhCa
	n1eLY54RvjdAsnTHNbmSkiPpCv2wG99C28HWQxla94vcMh8bPIfZTg/Hg1a+dGMJ2AdeeZuhCep
	77KGjG+RDRlNCn2QzbE3SgEAEeO1dzixy5cJ40TMAuJH/D9dWeSv1lmPbxt0BHgffkDD2cg5ZsQ
	tgeq5yk6lNl/+maP95aJwyGpGaauMl+r3vYeAXV8gFdohNKTE5oTaqJdQBNpK8j+v98IVXB75uQ
	/wuuLY3+m7ECWf07CsXjYW2a9/ueprfLAfBXqev0W3ZlwqArpFiyyUZ+3Grah9j42X1D0orQtMi
	VHz1hBDHJ/mkBHajvk3y2eD6loZ6xX59aVGet9ToKPgCba4O7VJmGQ7TZlITUexnk=
X-Received: by 2002:a17:90b:578c:b0:398:e6b6:acc2 with SMTP id 98e67ed59e1d1-39b261e7649mr56433407a91.12.1788965948258;
        Wed, 09 Sep 2026 07:59:08 -0700 (PDT)
Received: from 41049dfc76e5 ([20.38.40.137])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-333c9db92b1sm45069423eec.9.2026.09.09.07.59.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 09 Sep 2026 07:59:07 -0700 (PDT)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: 
 =?utf-8?b?W1JFR1JFU1NJT05dIHN0YWJsZS1yYy9saW51eC02LjEueTogKGJ1aWxkKXBhc3Np?=
 =?utf-8?b?bmcgYXJndW1lbnQgNCBvZiDigJh2Z2ljX2l0c193cml0ZV9lbnRyeV9sb2Nr4oCZ?=
 =?utf-8?b?IG1ha2VzIGludGVnZXIgZnJvLi4u?=
From: KernelCI bot <bot@kernelci.org>
To: kernelci-results@groups.io
Cc: stable@vger.kernel.org
Reply-To: kernelci@lists.linux.dev
Date: Wed, 09 Sep 2026 14:59:07 -0000
Message-ID: <178896594691.3462.11787845150728818388@kernelci.org>

New build issue found on stable-rc/linux-6.1.y:

---
passing argument 4 of ‘vgic_its_write_entry_lock’ makes integer from pointer without a cast [-Wint-conversion] in arch/arm64/kvm/vgic/vgic-its.o (arch/arm64/kvm/vgic/vgic-its.c) [logspec:kbuild,kbuild.compiler.error]
---

Log excerpt:
=====================================================
/tmp/kci/linux/arch/arm64/kvm/vgic/vgic-its.c:2227:66: error: passing argument 4 of ‘vgic_its_write_entry_lock’ makes integer from pointer without a cast [-Wint-conversion]
 2227 |                 return vgic_its_write_entry_lock(its, gpa, 0ULL, ite);
      |                                                                  ^~~
      |                                                                  |
      |                                                                  struct its_ite *
In file included from /tmp/kci/linux/arch/arm64/kvm/vgic/vgic-its.c:23:
/tmp/kci/linux/arch/arm64/kvm/vgic/vgic.h:148:69: note: expected ‘long unsigned int’ but argument is of type ‘struct its_ite *’
  148 |                                             u64 eval, unsigned long esize)
      |                                                       ~~~~~~~~~~~~~~^~~~~

=====================================================

When fixing this issue, please attribute this report according to the
patch submission rules:

Reported-by: kernelci.org bot <bot@kernelci.org>

For complete logs and details about the environment used, see the issue
on the KernelCI dashboard:

- dashboard: https://d.kernelci.org/i/maestro:56b2a9c4ef5f419c46a86044aebc6c22046e263f
- giturl: https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git
- commit HEAD:  73c3a49cbd7ef9a5fb689a3625b01178f041fe17

# Builds where the incident occurred:

## defconfig+arm64-chromebook+kcidebug+kcidebug-arm64+lab-setup on (arm64):
- compiler: gcc-14
- config: None
- dashboard: https://d.kernelci.org/build/maestro:6aa16b37e41d7f97d61b21b0

## defconfig+netdev+nfs-root-boot+kselftest on (arm64):
- compiler: gcc-14
- config: https://files.kernelci.org/kbuild-gcc-14-arm64-nfsboot-6aa16b2fe41d7f97d61b21a3/.config
- dashboard: https://d.kernelci.org/build/maestro:6aa16b2fe41d7f97d61b21a3

#kernelci issue maestro:56b2a9c4ef5f419c46a86044aebc6c22046e263f

--
This is an experimental report format. Please send feedback in!
Talk to us at kernelci@lists.linux.dev

Made with love by the KernelCI team - https://kernelci.org
