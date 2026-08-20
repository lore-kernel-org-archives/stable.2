Received: from mail-pj1-f42.google.com (mail-pj1-f42.google.com [209.85.216.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D93B125B0BE
	for <stable@vger.kernel.org>; Thu, 20 Aug 2026 14:59:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787237947; cv=none; b=VulxMh4FPEng8t+/MgH2v54IYhyEGaiGGUtqdoRo7m+muK4OBdxTJ+Jd5TRWSPfJ+Q6petheEYPD/P84irSXW3hWO7dEIdJBH60MxVPABBj7XrTl2uctHJhzQ9hdWFkYGOzjBbfqHCKHY/K/5zjLvt0wFh677d6PXblZlBVHe+0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787237947; c=relaxed/simple;
	bh=BlpgD2/RYVCo4FOIhacbHM22gwINRBJP1IVunUe+Z4I=;
	h=Content-Type:MIME-Version:Subject:From:To:Cc:Date:Message-ID; b=QEghurrkHW8DM4/18tvrILWM/khOdRgqEeLRlyi7UmoRG8z1AOqTmqKPtf1U1sgKWCEk3pedkC6P9YqboxHSqJLceBiVnfFKcn9ndv6zJGLOBY3aoxb1LsKolkoVq8h6jQlGHSFOgWpeqdtBBKdASyTPXlo7ppxmh1bg2uT507w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=kernelci.org; spf=pass smtp.mailfrom=kernelci.org; dkim=pass (2048-bit key) header.d=kernelci.org header.i=@kernelci.org header.b=ZwoTsCoa; arc=none smtp.client-ip=209.85.216.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=kernelci.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernelci.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernelci.org header.i=@kernelci.org header.b="ZwoTsCoa"
Received: by mail-pj1-f42.google.com with SMTP id 98e67ed59e1d1-38e7109321dso1548343a91.3
        for <stable@vger.kernel.org>; Thu, 20 Aug 2026 07:59:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci.org; s=google; t=1787237945; x=1787842745; darn=vger.kernel.org;
        h=message-id:date:reply-to:cc:to:from:subject
         :content-transfer-encoding:mime-version:content-type:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=vZ/0uLkNaWHtT80luQHiLN3+q9eiKIqFh4/44lAOp/s=;
        b=ZwoTsCoaHTmlcgJ5J2k4Cb/PkyVnxIZQIbZYB2Ho1C0z4s6MUKv8KOw0/diCFb9p0k
         JHeGO+npvQEhTJLuMbjzcDK4JAdd/3adocd61hXinmF9ENA4kXZ9Qwoz3YwamVQ0mX17
         8bw5nv+EjeMAT5SwV+q+1cM9Ff4EtmEsxMpCvHygeb40Up6T0ZGMIAv1fAiCZdwonTXr
         2AgTZEDvtZA7UejEvapJEBGRlaCBPnyTvSxKsOmbstvV/7uv0rpVnM/y4NyZB1ejlovY
         MtNk25HBgkQqBnM1ShQiw5MAMS4gNXjV/juIPOhDbtT4kG9bQ4vqte/3z/TRH835gNV3
         2G/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787237945; x=1787842745;
        h=message-id:date:reply-to:cc:to:from:subject
         :content-transfer-encoding:mime-version:content-type:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=vZ/0uLkNaWHtT80luQHiLN3+q9eiKIqFh4/44lAOp/s=;
        b=NNVFewFl8rkcgzwTESfgD27ny3fsAHElyNj21DK2yM00Hzp1+Nd8I4VTiaeIWGtYTV
         YXr84WKxwDmeT3ay6z0E4LGuXBSF6BGHHAEkU4oIPJObKvjz7u/yC427zRGea6sPyKal
         6gMv5zMHCRgQ8tyN3xjpRBnI28kTEi2q8x7DoFe6i/YNJ8QWWDrQ7K3JuEe/wo65Pbsf
         eNbLtJ+4VTYeh7fIty4jYClVv6XFn5EpJlOyhhuUuYNI+3+lso0c0fW808xvAMnqWGPB
         f/++sqhpbXzBUEYkHmDAplZhVLVW9i6iM+4+T/gRrhiHtHCE8+f139iqg9uOziFo8Jwg
         CRBg==
X-Gm-Message-State: AFuF++nKOgB/vVphqm3LFqdRSBogevuoHh2ZOqON4uO7a7W4cpR33WCP
	aqVJFIo9RNlJXs6VylozJ0asW1T1QLXc3fO2JbJtx3sOm+rSqWjfTeJEIs57wm+sfFziFGxzIiu
	aP48A
X-Gm-Gg: AR+sD13Ti21zNVP+qfTNjTAYkt+EPCAiV9sjU7mHZjz3QTa8MpXz59DQGyXim+WDvh2
	m9BPxqAkvbc/weHeBIsWzuV7O+FFDisPKFW2AGyJ3y7NnfUquqbT2x3rQInbdfLHEzH+gLdYgIG
	hQ3SLyCmFKdZapSrh+MK9r/QMPmblyKndkTjEvQL1VmA9LQ3/i6VpmDK0aHtTr1NvDqaDE9dj0v
	tYHuKDWj4K5xRXSqF/8KkcyxuZX7fYDN0VynpBaHu+z/OmtWS/rN8k5q88QqIA6uJXuBaq/Q4T1
	2pLb+d1EL/PfdnEnS3UIsc4w++YPSmk1Cot+Hul5wsnqDilEsrPoL4SsMpoPuR+iM654w7L47ng
	J8AqT/UVjzYttNvS8MqHyaJ2ifj1N8jVxUKZIhwlDWgs7wRyU2KjO8Gd9CQ/vOW/hyCTPoy2Flk
	sWMkem4jB7IvONTK9binCCq+GFQ5p+FmD6TAhvlbXdURuGPmdmwkLi
X-Received: by 2002:a17:90b:3c47:b0:38f:1a2e:6e56 with SMTP id 98e67ed59e1d1-395813f4f3dmr26191937a91.9.1787237944895;
        Thu, 20 Aug 2026 07:59:04 -0700 (PDT)
Received: from b455de3d9de8 ([20.38.40.137])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-327bf10a94dsm17393090eec.15.2026.08.20.07.59.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 20 Aug 2026 07:59:04 -0700 (PDT)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: 
 =?utf-8?b?W1JFR1JFU1NJT05dIHN0YWJsZS1yYy9saW51eC01LjEwLnk6IChidWlsZCkg4oCY?=
 =?utf-8?b?c3RydWN0IGF0bWVsX21jaeKAmSBoYXMgbm8gbWVtYmVyIG5hbWVkIOKAmGJoX3dv?=
 =?utf-8?b?cmvigJkgaW4gZHJpdmVycy9tbWMvaG8uLi4=?=
From: KernelCI bot <bot@kernelci.org>
To: kernelci-results@groups.io
Cc: stable@vger.kernel.org
Reply-To: kernelci@lists.linux.dev
Date: Thu, 20 Aug 2026 14:59:04 -0000
Message-ID: <178723794346.723.17997246893434888702@kernelci.org>

New build issue found on stable-rc/linux-5.10.y:

---
 ‘struct atmel_mci’ has no member named ‘bh_work’ in drivers/mmc/host/atmel-mci.o (drivers/mmc/host/atmel-mci.c) [logspec:kbuild,kbuild.compiler.error]
---

Log excerpt:
=====================================================
/tmp/kci/linux/drivers/mmc/host/atmel-mci.c:2632:31: error: ‘struct atmel_mci’ has no member named ‘bh_work’
 2632 |         cancel_work_sync(&host->bh_work);
      |                               ^~

=====================================================

When fixing this issue, please attribute this report according to the
patch submission rules:

Reported-by: kernelci.org bot <bot@kernelci.org>

For complete logs and details about the environment used, see the issue
on the KernelCI dashboard:

- dashboard: https://d.kernelci.org/i/maestro:a235e401da435f22770035d96bbf70369b2f20f9
- giturl: https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git
- commit HEAD:  14df5e0143e243ed3fb811cd7bfdcd730f29c9f4

# Builds where the incident occurred:

## multi_v5_defconfig on (arm):
- compiler: gcc-14
- config: None
- dashboard: https://d.kernelci.org/build/maestro:6a8711be62f33761c0f0b4d4

## multi_v7_defconfig on (arm):
- compiler: gcc-15
- config: None
- dashboard: https://d.kernelci.org/build/maestro:6a8711b162f33761c0f0b4ca

## multi_v7_defconfig+kselftest on (arm):
- compiler: gcc-14
- config: None
- dashboard: https://d.kernelci.org/build/maestro:6a87126562f33761c0f0b6a8

#kernelci issue maestro:a235e401da435f22770035d96bbf70369b2f20f9

--
This is an experimental report format. Please send feedback in!
Talk to us at kernelci@lists.linux.dev

Made with love by the KernelCI team - https://kernelci.org
