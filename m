Received: from mail-pj1-f53.google.com (mail-pj1-f53.google.com [209.85.216.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E66C0376BF4
	for <stable@vger.kernel.org>; Fri,  4 Sep 2026 06:59:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788505153; cv=none; b=CwMLV5BMP/JcAj7gluUi7SQReio271UFxkzcVMiUuKQfYeeNPrv2U2Qvo3V8k9ZnjaE4zrU6DFh8MjZbE8rWA2mpl+6gcVNS5r6SUhrvcnQRCFmIPyLvr1gM93p9jGpdo6kNr+gLEgPRXWnPZ22VWG/vbsPU9icbz8qVoGRIXJo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788505153; c=relaxed/simple;
	bh=O0sG6ZoVdFDCnTNWXqfYD7RUqrFKGfuFLI8jFtHfs18=;
	h=Content-Type:MIME-Version:Subject:From:To:Cc:Date:Message-ID; b=IFfYpKHReG/LzNPVTVcoxEzSma7mCTCrwmC3NnEb2u59cY5OPrIf+ueUKw42NiFuUzdUq/v4u597l70/6JmK+N3mj3zrWPj5eyG9zOk8o87aa7Ld4Wx9L21fYdMvFr3QVoWm9gAawzWw/MC6E2xB+DsdrX4ObJdWFLnxK0z6BYs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=kernelci.org; spf=pass smtp.mailfrom=kernelci.org; dkim=pass (2048-bit key) header.d=kernelci.org header.i=@kernelci.org header.b=YXk6LgYa; arc=none smtp.client-ip=209.85.216.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=kernelci.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernelci.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernelci.org header.i=@kernelci.org header.b="YXk6LgYa"
Received: by mail-pj1-f53.google.com with SMTP id 98e67ed59e1d1-38a0c7e841fso951058a91.2
        for <stable@vger.kernel.org>; Thu, 03 Sep 2026 23:59:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci.org; s=google; t=1788505151; x=1789109951; darn=vger.kernel.org;
        h=message-id:date:reply-to:cc:to:from:subject
         :content-transfer-encoding:mime-version:content-type:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=Veb72cdAK/1w/9RVXRszzaNb5FzRWVtbagLqIXSIiEg=;
        b=YXk6LgYaqM7vrKFhftw4Z5oH8mVEkFmVrad/b6mFNfwcfcpjM7/+73Q+sPBmCeDJIZ
         wcK4LBNg3HUTUy50nnMW/e5TUvhXo/46xg4XdMnyNCVaG0G8apCPuwYEuzmHDJu5Fvcp
         CBxGrdynnNgrCmESO4jFVt8MIJkBYgrRjzc0h6vQfJTCAXTfVHCW7ivdbW+/GymZ7vSO
         fDIWcsnObLaDtSL/LD4g1ydK6T6cIBxMqMdPvancaA6NAmbWZVEyERahYyK8bSCkTHzE
         5sxuRHrgKZAhyS1WC+YlRm/pUYuj0RfzQptZUbQC6bWZayAsb7bHSaGOXWgNXgvVONaH
         uOIw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788505151; x=1789109951;
        h=message-id:date:reply-to:cc:to:from:subject
         :content-transfer-encoding:mime-version:content-type:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=Veb72cdAK/1w/9RVXRszzaNb5FzRWVtbagLqIXSIiEg=;
        b=ErbUMDHTMFqAMxAQ8sStjKA1A8mp9ua2W0MP3uDuUYp8KMsWf4MDhGlz6Uf928S35d
         j70Lvmzc5m6yVSysTfb/Bt72CKuQGEXVxvAO0XMvRb1/uxkcZZIxLxhc30ofxDBNAbkM
         9LtZDhkyIcrbgVP61YMEUdckmTzgLg94I8+48ATfsC96uPHqtyYW3S+DFB3LNo7swWou
         W7F5WhFh5D8Z/thgW16pNOGXOcL7kk2R5m4u4epL0rEAZdpq8kJwdC2BPH4WCmYM5qH1
         afAuVBgiwmLJNtXCwMiBB37EYeZWuC7aKNJAima5+sn4uzVVO5PO31x91s+wOoUMWPar
         GoCA==
X-Gm-Message-State: AFuF++n33NIrXR1OtFp7/0dFAyPiWnGzA1UbhYNHfO1I0obbKFZ1zFYG
	5uBF2NsaRDywD+Ec8e2ketJodmKXnexTehPXa58JnrBZHNpEYLnd2knCkNA9j3a0wNXM8rd0jYh
	sij0lyFY=
X-Gm-Gg: AYBFou3rGg8iGxtmJ9RtVUe5CgNW5N2RMcbD1cGItMJJNLcxhpMv2q7Zt47FifnUtcM
	+w3Kwr+Ihqc0PrfnSEWxevOYn0DhFdavN02/D5yX2X0LmiqMtWljlzKP8ljh86LU4/fil+/vkM5
	OOD2pk/3MW2vgzWwgy2eYB0scvQJkizHcyNbtzLqRwxa73NF6mcUQ6mgVdenPZxFfP8xkKXa2eA
	WJ5gM1H+N/eJZLJGBtRgAeW7WwCD4n1A450IoHMk4BhL+OA9LYzgrJuBiIXickMy3P+mGDWltYs
	Hb5WsD+NhTKRCiE3X67i7WS7ge10S/OfmFtqCcoSLXd3dXl4jn4BZfpwuuf2MIDUrAxpBHv5Uvk
	SKX9M1SXh5Q4xM7UwFVHYLMYa+YUyrDMHgXEhewN723LOHbw9HvJ/orYGE/xUm3+TpkuFYkirjf
	e3TltHhyYERXukMHvIPwsHGnBn5+Dk/nGOU5eNwBmt70EBp3cWmEL7oVAytoKrAJbn/g==
X-Received: by 2002:a17:90b:3943:b0:398:d8eb:cb2a with SMTP id 98e67ed59e1d1-39b26273e31mr7193777a91.23.1788505150892;
        Thu, 03 Sep 2026 23:59:10 -0700 (PDT)
Received: from 41049dfc76e5 ([20.38.40.137])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-3339aa31b24sm4269879eec.13.2026.09.03.23.59.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 03 Sep 2026 23:59:10 -0700 (PDT)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: 
 =?utf-8?q?=5BREGRESSION=5D_stable-rc/linux-6=2E18=2Ey=3A_=28build=29implicit?=
 =?utf-8?q?_declaration_of_function_=E2=80=98huge=5Fptep=5Fget=E2=80=99_=5B-?=
 =?utf-8?q?Wimplicit-functi=2E=2E=2E?=
From: KernelCI bot <bot@kernelci.org>
To: kernelci-results@groups.io
Cc: stable@vger.kernel.org
Reply-To: kernelci@lists.linux.dev
Date: Fri, 04 Sep 2026 06:59:10 -0000
Message-ID: <178850514975.887.14425313947880761588@kernelci.org>

New build issue found on stable-rc/linux-6.18.y:

---
implicit declaration of function ‘huge_ptep_get’ [-Wimplicit-function-declaration] in mm/page_vma_mapped.o (mm/page_vma_mapped.c) [logspec:kbuild,kbuild.compiler.error]
---

Log excerpt:
=====================================================
/tmp/kci/linux/mm/page_vma_mapped.c:110:25: error: implicit declaration of function ‘huge_ptep_get’ [-Wimplicit-function-declaration]
  110 |                 ptent = huge_ptep_get(pvmw->vma->vm_mm, pvmw->address,
      |                         ^~~~~~~~~~~~~

=====================================================

When fixing this issue, please attribute this report according to the
patch submission rules:

Reported-by: kernelci.org bot <bot@kernelci.org>

For complete logs and details about the environment used, see the issue
on the KernelCI dashboard:

- dashboard: https://d.kernelci.org/i/maestro:0152e156881110033b6ad4000bce713f17d25858
- giturl: https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git
- commit HEAD:  96ff57c9007ff0391c80864ebe06496d592e3b02

# Builds where the incident occurred:

## allnoconfig on (i386):
- compiler: gcc-14
- config: https://files.kernelci.org/kbuild-gcc-14-i386-allnoconfig-6a9a604fe41d7f97d6fd79be/.config
- dashboard: https://d.kernelci.org/build/maestro:6a9a604fe41d7f97d6fd79be

## allnoconfig+kselftest on (x86_64):
- compiler: gcc-14
- config: None
- dashboard: https://d.kernelci.org/build/maestro:6a9a6088e41d7f97d6fd7a8f

## multi_v5_defconfig on (arm):
- compiler: gcc-14
- config: None
- dashboard: https://d.kernelci.org/build/maestro:6a9a6015e41d7f97d6fd7943

## multi_v7_defconfig on (arm):
- compiler: gcc-14
- config: None
- dashboard: https://d.kernelci.org/build/maestro:6a9a6019e41d7f97d6fd7946

## multi_v7_defconfig on (arm):
- compiler: gcc-15
- config: None
- dashboard: https://d.kernelci.org/build/maestro:6a9a6008e41d7f97d6fd787d

## tinyconfig on (i386):
- compiler: gcc-14
- config: https://files.kernelci.org/kbuild-gcc-14-i386-tinyconfig-6a9a6053e41d7f97d6fd79cb/.config
- dashboard: https://d.kernelci.org/build/maestro:6a9a6053e41d7f97d6fd79cb

## vexpress_defconfig on (arm):
- compiler: gcc-14
- config: None
- dashboard: https://d.kernelci.org/build/maestro:6a9a601de41d7f97d6fd7949

#kernelci issue maestro:0152e156881110033b6ad4000bce713f17d25858

--
This is an experimental report format. Please send feedback in!
Talk to us at kernelci@lists.linux.dev

Made with love by the KernelCI team - https://kernelci.org
