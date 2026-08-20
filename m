Received: from mail-pg1-f180.google.com (mail-pg1-f180.google.com [209.85.215.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2DC19478875
	for <stable@vger.kernel.org>; Thu, 20 Aug 2026 15:59:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787241556; cv=none; b=umwE6L3C0CmGPZvTaEZhI4VYKtIUnIMoh2kmG3WMRViKUI0BOanaT81WYaqAUXmGlWQ2CNoFo+m/ZGChBVbZHW48YGsG69B0yzqjgg/yBCNhEA0WS7aYq3r5mWNv/zzh9ZwGRCFieznBUkmkp/d4Px8Zq7YDwQ0hpL5JUa47Ekg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787241556; c=relaxed/simple;
	bh=jvnAP4dvVij2UOzQhL27OEYCYmmTMztR+2eVi3Uudpw=;
	h=Content-Type:MIME-Version:Subject:From:To:Cc:Date:Message-ID; b=IWoTbsbkPiGW4etSdf3lIHE2RF0dj/hP8iLPv4iMPxyeQuXGtlBggvzoKcY5B9sEIyEJfn6SvUy9FDqiOqRAFCGsfkOEJsT34YpM/Z6VpPxYDB0BIPn0rOS24tbLHMVglT4yGamAxVTONwZBfcw1yvyAnoh54sT6doco+KBEcu0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=kernelci.org; spf=pass smtp.mailfrom=kernelci.org; dkim=pass (2048-bit key) header.d=kernelci.org header.i=@kernelci.org header.b=Xrp6QM02; arc=none smtp.client-ip=209.85.215.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=kernelci.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernelci.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernelci.org header.i=@kernelci.org header.b="Xrp6QM02"
Received: by mail-pg1-f180.google.com with SMTP id 41be03b00d2f7-cbee846deecso68802a12.1
        for <stable@vger.kernel.org>; Thu, 20 Aug 2026 08:59:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci.org; s=google; t=1787241554; x=1787846354; darn=vger.kernel.org;
        h=message-id:date:reply-to:cc:to:from:subject
         :content-transfer-encoding:mime-version:content-type:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=lIfzOb1FddEP5PHbFDoKKuhZU1DEZMM/n+vAYvYgZ2k=;
        b=Xrp6QM02oOGM9Ccx3RLIC5uQKW/VifqeXaKSuhm0kZE7fwXmRFz7fPYoLPhduUeVnr
         if5H4jffY0IAbzzi3pdPRgEj0xeY4RYmoQkfXfMYo52fJyIWnOh8IY5kpjq4oXDil4WZ
         Ha7WIii6KXxDnTdi4cCvg4wRtxRNnVPe2eO+QHSN38ISAAgjN8pfSaToz6Ur/c+IlnlT
         GuJ9W2mEbmnQnlgjMLYdUEX/9/FQPJxz1jDgs6b/14Yez+tjH1KoKk3IATmww1f3fcoW
         MQlYDc4QE73WfmcED08//lDazVz61LtY8wY+huCeRvSPGafDyVJiWuljGmhkYoOPl/Qw
         uSeQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787241554; x=1787846354;
        h=message-id:date:reply-to:cc:to:from:subject
         :content-transfer-encoding:mime-version:content-type:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=lIfzOb1FddEP5PHbFDoKKuhZU1DEZMM/n+vAYvYgZ2k=;
        b=RHWNyDd0isTGzF1iS8URML9yF5FCMKlv9g7Cuf6s7oQ45gji6auqXGjTVSgIt1u6lL
         Y0HUDVrPoy4Hg/hF35z4yXF9QVK113kG0eCMb9tOgF1tZcewQiRtasM0qy+aMTeG/99u
         UB5Fcuehlyk/YdiG49WU21Cr01R+ca4Fb0wHYm084fAJoGToOphlbtN0CMKmPcy3sHg9
         pQ4+dsh/BJ6nF4QKISG9dqF1LJdlBKoCBeQs2N/mTTe2HgQ5N8zjxhJEfRimCpKrBsGC
         gkiKfsIEQ+3ZqDjWHTZjmYwfJEiXlYXIsVZ/BJMuNwfbDX6YXmpLizMGH6mEG9JYwllJ
         4DXQ==
X-Gm-Message-State: AOJu0YxGgaLfcQ6gw1Zc3pQkj1NihfsJYo+Me86XWKLkmqD59HW9r6Ef
	1uPm+fdJx52+vQSUFn570UOe4HQUtD6pLTTnzCPiPQRoqSajtTdDsdZLVp8hY6iurRGF1EPaCmQ
	g4Wcf
X-Gm-Gg: AR+sD10bpVfRFsYOW6g6vhA0zDgI6l1RQk7ABEHSlGVs4DULXFNqt84KvL4v8cCytYl
	h9nOBoyxSIKh6DwZdGZuVHy8OoUtAhKHbN2dk5vZiVBzmj+hDspWPScHQyQ2nr9zuzQwpZnJ9pl
	GXENTPAsI67I3CJUBk0K3/u28BcYxMOQCEQT6Aja+WA0rDPOCfH43AHCjZhER8fuJznysseewCU
	fE/YSCnC9O+8qN+tJ0x5MZaI/ilUywGViBJEh9d9WRNpfCvdCoEwK4daOCgOFLk3V66va2Dxn5Z
	+3uJlnEaz02/81TLs8F/8Z4QZIx02efVE49ot5AoNeEbaDPynvW87E3S1oI020puW7S2ANlSJXO
	7ld26pA9QMO1t1zxGgTIIkJyjmyG9lDXk1Moj7uoLZYrBefYeyOqtJPyoNVm8oW+rHBATndZSQ8
	xHrr/a7GoewvISUWUSKR3bHqRcOdwerNWVY15hnZvWIzadymO9PauX
X-Received: by 2002:a05:6a20:3d19:b0:3bf:b1d3:393e with SMTP id adf61e73a8af0-3cd00dcb3dfmr27913771637.2.1787241554482;
        Thu, 20 Aug 2026 08:59:14 -0700 (PDT)
Received: from b455de3d9de8 ([20.38.40.137])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-327bef3bb5csm20137618eec.2.2026.08.20.08.59.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 20 Aug 2026 08:59:13 -0700 (PDT)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: 
 =?utf-8?b?W1JFR1JFU1NJT05dIHN0YWJsZS1yYy9saW51eC02LjYueTogKGJ1aWxkKSB1bmtu?=
 =?utf-8?b?b3duIHR5cGUgbmFtZSDigJhkbWEzMl904oCZIGluIGRyaXZlcnMvczM5MC9jaW8v?=
 =?utf-8?b?dmZpb19jY3dfY3AubyAoZHJpLi4u?=
From: KernelCI bot <bot@kernelci.org>
To: kernelci-results@groups.io
Cc: stable@vger.kernel.org
Reply-To: kernelci@lists.linux.dev
Date: Thu, 20 Aug 2026 15:59:13 -0000
Message-ID: <178724155315.746.406627267216422835@kernelci.org>

New build issue found on stable-rc/linux-6.6.y:

---
 unknown type name ‘dma32_t’ in drivers/s390/cio/vfio_ccw_cp.o (drivers/s390/cio/vfio_ccw_cp.c) [logspec:kbuild,kbuild.compiler.error]
---

Log excerpt:
=====================================================
/tmp/kci/linux/drivers/s390/cio/vfio_ccw_cp.c:481:32: error: unknown type name ‘dma32_t’
  481 | static int ccwchain_build_ccws(dma32_t cda, struct channel_program *cp)
      |                                ^~~~~~~
/tmp/kci/linux/drivers/s390/cio/vfio_ccw_cp.c: In function ‘cp_init’:
/tmp/kci/linux/drivers/s390/cio/vfio_ccw_cp.c:745:15: error: implicit declaration of function ‘ccwchain_build_ccws’; did you mean ‘ccwchain_fetch_ccw’? [-Wimplicit-function-declaration]
  745 |         ret = ccwchain_build_ccws(orb->cmd.cpa, cp);
      |               ^~~~~~~~~~~~~~~~~~~
      |               ccwchain_fetch_ccw

=====================================================

When fixing this issue, please attribute this report according to the
patch submission rules:

Reported-by: kernelci.org bot <bot@kernelci.org>

For complete logs and details about the environment used, see the issue
on the KernelCI dashboard:

- dashboard: https://d.kernelci.org/i/maestro:bbbe0670d5dab671f8224d8185fad12beebba08e
- giturl: https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git
- commit HEAD:  ca37407fccb96f6ba527cc8274afa5038874b131

# Builds where the incident occurred:

## defconfig on (s390):
- compiler: gcc-14
- config: None
- dashboard: https://d.kernelci.org/build/maestro:6a87142d62f33761c0f0bcb0

#kernelci issue maestro:bbbe0670d5dab671f8224d8185fad12beebba08e

--
This is an experimental report format. Please send feedback in!
Talk to us at kernelci@lists.linux.dev

Made with love by the KernelCI team - https://kernelci.org
