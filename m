Received: from mail-pj2-f13.google.com (mail-pj2-f13.google.com [74.125.227.141])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7082B3328E6
	for <stable@vger.kernel.org>; Thu, 17 Sep 2026 12:59:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.227.141
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789649953; cv=none; b=BnnqvZCsYfV1+o8H+5Qj2uY1nzxzgkijjelhCoAeRpZUlljJ//73H6to6dWI6Ttlb4mXM3QcEtgSL1Br1zd5EbCWH0qPtk5J6AWzta/FpMLEURC0BIgyR7ru76xremNdCX7onrVNiIqmUFd0iqFKmcpDJ3qhsW9GR9XDTjGB1OU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789649953; c=relaxed/simple;
	bh=Prfm9CQOpiJmgBanT1cgMHo6mY1JCoZ0/JW18n1QA8M=;
	h=Content-Type:MIME-Version:Subject:From:To:Cc:Date:Message-ID; b=CG3cL50ZZIGaonoEu65PyCshAAw2fOmpcHWdXF18pmhK+57fOV7o8/GI/0PjaTHF28kDlBd5NZsAx5DuB8aN96sIkHhz5nI3i+KOC7EqOkmYJ6quuuwt/eVBETjaq8yrHhBmYEBkNpj6pUsyx2pSi/RaP1L2K/2qTP0agjHLXME=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=kernelci.org; spf=pass smtp.mailfrom=kernelci.org; dkim=pass (2048-bit key) header.d=kernelci.org header.i=@kernelci.org header.b=KOFaWEes; arc=none smtp.client-ip=74.125.227.141
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=kernelci.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernelci.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernelci.org header.i=@kernelci.org header.b="KOFaWEes"
Received: by mail-pj2-f13.google.com with SMTP id 98e67ed59e1d1-396ccc02279so669397a91.1
        for <stable@vger.kernel.org>; Thu, 17 Sep 2026 05:59:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci.org; s=google; t=1789649946; x=1790254746; darn=vger.kernel.org;
        h=message-id:date:reply-to:cc:to:from:subject
         :content-transfer-encoding:mime-version:content-type:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=Qu/28W7mf1JwFoyU0LtmNJTZpNzdx5k08QQurwwj5Fs=;
        b=KOFaWEesADB3Sice5SlPfkk9VVDPXxply4ZsX1ZYdHGYYYfOweALyGnNDtZ2V9HIe+
         /om8TANhk/7UjKKBb4VCdA24HeYvbrFsJU6oIrWWkOYQM16/LKhVbgL7ccgNaQmkXeBG
         D5KMiM1lnUZpeXcD3oFVJz/EHQIPBheeycIT9afBa+YNT2SvRTq0iq6Tn/AlyySxXVVf
         RlNQ3xP2IxXpUo7C1/7MFFFDKvrlpdaGybdYlI3jJdXdGV0KI5527KWuyoLWqUixI3MC
         TLmechRe9yko7MgnHg3rqY3nM7L+AE76CBODgJWzgPts7/hzUwPPYrfeqTBlHQfyKzY6
         Bo6Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789649946; x=1790254746;
        h=message-id:date:reply-to:cc:to:from:subject
         :content-transfer-encoding:mime-version:content-type:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=Qu/28W7mf1JwFoyU0LtmNJTZpNzdx5k08QQurwwj5Fs=;
        b=LK9bzISzwk4lIR7gUi0YxqB/cEmjJ9Ku+w3D45nkpKOhLcUSVbzPsSM/BhD4Eh2Bv2
         iH8dLCqXJDvcNn3xca4tfmP8ztLRrDi/SeDrloYqjZoPJkujHMKbvMhdNQ+LHd0k0/2j
         GbBXHI3jjb6TX1sqjRDkBQDURa/5jFvBifDQc9VcvtI5B0zicUAudlXwVTMBziZesgj5
         WMj6sMLCBpBsm3fb5tjQ2jHBNZxuuFCPEnAq+2qhe5gT5aFePnW29E6nW0pBtF8umD0n
         B8flpbtHNXgkRz4KA6pmCq5fSCMwRqoK7Oinz8B5yVvIxBuatIA8C088/quBwDLmcCWv
         ql8Q==
X-Gm-Message-State: AFuF++nQL9hw26/tXXbaAmIbc21YUxhgGjAPMMap/RTdwI1T0EEUIEKn
	obDDPe34d9d7gbsoXslnFBNxLOV0uHCNCvCwk2T7gLHAks9YsiARfXsoMRmuOLOsjFo=
X-Gm-Gg: AYBFou0nS85G2HYHUcYjdoCji25WIrUGi/Sm8qJUP/VBzUjfbG9antzZGAuHl2M9ZpP
	3nTLxN6m1GAf7RPu1jy4LYwFnTZRgQfy/PgfUeiH19gDzfc0hsGFOPqYcrNbOqt8d1qrSyD48wn
	VtWBes5cwIifJzdwoi2aWax4oKpVXBvzYJmEGFgGSLPaUSEs+fzBMmmkY+zYUhKQTo+RHVbHMv/
	HbMe/BX7KsAp7wXDUpIbVnzjVeUE0K2yxu0bMKYWYytrysWac6hXJTrBMp+lUAMiweVglMkAJdN
	Qkkn2BIXQiWwJHTVbXh9S92kT4+VEHiVol2kDrFcAImpJUkT4BB36OXAwvUBHHccfiG7gSRCwzT
	VH7DiMseR0FCXKDctomu8amiUQvJyszF+b2d0OalALr+pFjIWATfPT5T9vrK6ajf29xRPbB5+W2
	AQhwkKMUDQnRDusq2FVj5NNj0LwkobN0FcQjtfjB3F6pGdvOdU3cAM+lKfc0Rj8ug=
X-Received: by 2002:a17:90b:4408:b0:39d:ec24:5ffe with SMTP id 98e67ed59e1d1-39e1e284fd8mr14000564a91.9.1789649946295;
        Thu, 17 Sep 2026 05:59:06 -0700 (PDT)
Received: from ec7b70f3a45c ([20.38.40.137])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-33bf5ad25bbsm13750752eec.19.2026.09.17.05.59.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 17 Sep 2026 05:59:05 -0700 (PDT)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: 
 =?utf-8?b?W1JFR1JFU1NJT05dIHN0YWJsZS1yYy9saW51eC01LjEwLnk6IChidWlsZClpbXBs?=
 =?utf-8?b?aWNpdCBkZWNsYXJhdGlvbiBvZiBmdW5jdGlvbiDigJhrdmZyZWXigJk7IGRpZCB5?=
 =?utf-8?b?b3UgbWVhbiDigJhrZnJlZeKAmT8gWy0uLi4=?=
From: KernelCI bot <bot@kernelci.org>
To: kernelci-results@groups.io
Cc: stable@vger.kernel.org
Reply-To: kernelci@lists.linux.dev
Date: Thu, 17 Sep 2026 12:59:05 -0000
Message-ID: <178964994501.141985.8613990755737198148@kernelci.org>

New build issue found on stable-rc/linux-5.10.y:

---
implicit declaration of function ‘kvfree’; did you mean ‘kfree’? [-Werror=implicit-function-declaration] in net/9p/client.o (net/9p/client.c) [logspec:kbuild,kbuild.compiler.error]
---

Log excerpt:
=====================================================
net/9p/client.c:935:9: error: implicit declaration of function ‘kvfree’; did you mean ‘kfree’? [-Werror=implicit-function-declaration]
  935 |         kvfree(fid->rdir);
      |         ^~~~~~
      |         kfree
  CC      fs/fs-writeback.o
  CC      drivers/video/backlight/gpio_backlight.o
  CC      fs/pnode.o
  CC      fs/splice.o
cc1: some warnings being treated as errors

=====================================================

When fixing this issue, please attribute this report according to the
patch submission rules:

Reported-by: kernelci.org bot <bot@kernelci.org>

For complete logs and details about the environment used, see the issue
on the KernelCI dashboard:

- dashboard: https://d.kernelci.org/i/maestro:f5cc2c371d72240942f0d1e05e7b6a67f460556b
- giturl: https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git
- commit HEAD:  64790d9e5f2890daf10c6d0ce0d312ec41df8adc

# Builds where the incident occurred:

## defconfig+lab-setup+arm64-chromebook+CONFIG_MODULE_COMPRESS=n+CONFIG_MODULE_COMPRESS_NONE=y on (arm64):
- compiler: gcc-14
- config: https://files.kernelci.org/kbuild-gcc-14-arm64-chromebook-6aabda3bfc1857a999dea496/.config
- dashboard: https://d.kernelci.org/build/maestro:6aabda3bfc1857a999dea496

#kernelci issue maestro:f5cc2c371d72240942f0d1e05e7b6a67f460556b

--
This is an experimental report format. Please send feedback in!
Talk to us at kernelci@lists.linux.dev

Made with love by the KernelCI team - https://kernelci.org
