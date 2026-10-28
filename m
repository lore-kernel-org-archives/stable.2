Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.49
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793206748;
	b=bryFLBZnVnle1PEkSXmfG1RtNuE4WeM4FYI1PDxh5RidTDN6ERN0jNWms9wtN5+h7W+2
	 yJduTB5townlHqG+59BJbcaqD16bCG8z1bA3ZLYHUcaXqBvKrXhg5N8MOI06hhHsbqysq
	 JUGM7b60D9X9zMutzXqj4e9E5X3XMLEDLEnV2X1n2qbZEoiPDGM8i65UxjRI6krLFIRvj
	 XWlvjgN7XxFmhnl/Sjz5tPuCsyfLukwKOsiC6Aj0W5NBFujcRwdogiWriQ7EDJVGEExpU
	 L5myIDXU/BiYNeHXXIXUIsU7uRGr9vMUP8ZCeh9PXNFB/DZgIDI7V6SO8/YY4XPQYfw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793206748;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:Content-Type:
	 MIME-Version:Content-Transfer-Encoding:Subject:From:To:Cc:Reply-To:
	 Date:Message-ID;
	bh=9bX5Jw/0ve+tDoIQbRM7yp6F0yR0zGDFDQUqejl8ztk=;
	b=uXxlKVRsDYY91fM+Y2JE5SKJRRES/nvIqmB61hh1R6ceKG2YJHidUnQFS0RYVF/bdwm7
	 GqP3L5TOuH7/CM0TXSY64JQBsrdnbcSGXueFVtVeLJq1VrG7+rE2ovJBVOIKpgnP1wPLe
	 isLX3qQ5U5+mkKdT2DYT8loIcolun51LIB7QnurhpR9asf2P5NFybYQBCv7UOFjAvHHWU
	 mlwlPcs7kHHlRyIAqq3ZTnekBr8qs2e+QJY3We8+YuHV6UmPi/SYDCvl7AlIbYYc78M+i
	 hJ/K2YDI0QSPtb22BouWiNGRMroUGo8z/R/2OxTCk+1dMypLjEvVe+qxOgBJILu5dxQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=kernelci.org;
	spf=pass smtp.mailfrom=kernelci.org;
	dkim=pass header.d=kernelci.org header.i=@kernelci.org header.a=rsa-sha256 header.s=google header.b=BQx7Nkxt;
	arc=none smtp.remote-ip=74.125.82.49
Received: from mail-dl1-f49.google.com (mail-dl1-f49.google.com [74.125.82.49])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3BDAC606A31D
	for <stable@vger.kernel.org>; Wed, 28 Oct 2026 16:59:08 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 3BDAC606A31D
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=kernelci.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernelci.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernelci.org header.i=@kernelci.org header.a=rsa-sha256 header.s=google header.b=BQx7Nkxt
Received: by mail-dl1-f49.google.com with SMTP id a92af1059eb24-1a2761c69fbso2790514c88.0
        for <stable@vger.kernel.org>; Wed, 28 Oct 2026 09:59:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci.org; s=google; t=1793206747; x=1793811547; darn=vger.kernel.org;
        h=message-id:date:reply-to:cc:to:from:subject
         :content-transfer-encoding:mime-version:content-type:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=9bX5Jw/0ve+tDoIQbRM7yp6F0yR0zGDFDQUqejl8ztk=;
        b=BQx7NkxtIeW2Ytu0/L9YJHr3lh5fgKOGYZoC0oDAOeQ4HDbMbcjxXycZEaWKmYsaEW
         lGKeaQUJB9wdqgCLyrcPCSgKJ0vvroP+Olcoy8lMminYbDgyFf/nnHbvAEaVuK7IrwJp
         8fbBSSXEVLK97zE+WAfvp2s7S9mJgcQTPAUQElPwZ9xWVdc/MF9Dd00VUmYHItkqZg2E
         JxXGFcVJcdp97XZLnZJ3FBrGz7ryn1+4DIQuyojQKc9jquDBGU0qprg9dAie5lJ2DCNq
         1Pvupbpe/0b7pWMKmPk0xgXOyZfth2zCvlXmrDx7RgB7h5sQ2xMzKs3yffGAfHytV+Gd
         PgGg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793206747; x=1793811547;
        h=message-id:date:reply-to:cc:to:from:subject
         :content-transfer-encoding:mime-version:content-type:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=9bX5Jw/0ve+tDoIQbRM7yp6F0yR0zGDFDQUqejl8ztk=;
        b=vXxkgeskm8jaj68YiLT6Wcz7P31v5NbABJKFCMQ77PjCx4908PRRljfJnbTVI2HieF
         /jY7Oth/lFgqeuUGnsCiD0Xvh7BQDRqYk4ZfSzAt2YQRWR16eWM2RrMODYvvlebnQ+aB
         Ua+xTyJusvbGfqV8uEYaMY4jct6jgRKF3GW2iasLrGUqjxlZvL7lZ2K7yj4JrbT3o1ZN
         O8cOl/Au3D8TDqmtUxkictqXlROdxr40Pb3x3fUd8P45g4mmzcsBQv/d7U/AK+gz4UQE
         AXCm3U/Qa4Ye/dknOv2QI+M+pCWWDrrWu0Lc3R42bIir6NQB0QA0iXbuhHIKzGpbUDxu
         HJuQ==
X-Gm-Message-State: AFq9FYJciFHnzpbr2PXHQzueYa1vZsQ1J0QhWRhzOVrH666LvLYwpGCM
	6Vx5dsJM3eJRnyAqm4QxrtXzlsGnGnnfrYOE+m5Y05r22HCIVqt0ZsBu1vwSM/4FLRVbtCpx0aS
	GfsUJ
X-Gm-Gg: AYBFou0GCayMz/0vvScNKjQGEkLyFaMAtzpyxImA3W0oYVXK1At2Z30iVOfWNLX/hxn
	XF5BmwKQPo1PQ+/iXQjy2mKbUYbN9UO1vNup79dghW+oB4kUCmBNi2oWD/XBgUFxDSpZgdPqz17
	Ud1a7Tg3OvJXeWDHH3s4w1YZCD4CW3qoF+1UYUEaHEaBpjqFr4g1fJZyt1mgTZbKynBqVyBezqV
	ajGujYA/8keid7SjG76BHIgGgYsjccE8jXCAFvRHf/nUMZRknvDIFkqoyGYeZm3kpLyOUO4pv/I
	C5WvTod0sbsN5h8YVMxKH7LNJUX26dXGNaJ4lj876X3PWT1DnVGvQ57JIvIllqCvYBxrZZX2V+m
	tHQ65maCuHC7+Z8Rzy3e9IRnZ7/e99yxTqIudQMX9QuEPnusW8jNE6jPF5VaWPiuZRny+qGDyb6
	vYCbmxBLsl6WLDIsTO/4mtqYD6GJZ5g4dXnav6DPhLQRrWIkQpug53nZCy9H43wXUGT4nid8uL/
	jN3vEfZVCWpw2evmxKf8dUzAND8VkFIyxJO15HTne5JlK+9qejEJrKAaP6sph3Ly+OrXbf+a8fv
	RASzvdQFUtBXAC8pNIYE6w==
X-Received: by 2002:a05:7022:1713:b0:193:9aa3:4748 with SMTP id a92af1059eb24-1a6c84dc7famr3710185c88.1.1793206747130;
        Wed, 28 Oct 2026 09:59:07 -0700 (PDT)
Received: from 4cb1f8191411 ([20.38.40.137])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-1a76056a001sm9755851c88.22.2026.10.28.09.59.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 28 Oct 2026 09:59:06 -0700 (PDT)
Content-Type: text/plain; charset="utf-8"
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: [REGRESSION] stable-rc/linux-6.1.y:
 (build)./include/linux/highmem.h:427:21:
 error: implicit declaration of fu...
From: KernelCI bot <bot@kernelci.org>
To: kernelci-results@groups.io
Cc: stable@vger.kernel.org
Reply-To: kernelci@lists.linux.dev
Date: Wed, 28 Oct 2026 16:59:06 -0000
Message-ID: <179320674592.41040.11581256066219136214@kernelci.org>

New build issue found on stable-rc/linux-6.1.y:

---
./include/linux/highmem.h:427:21: error: implicit declaration of function ‘folio_test_highmem’; did you mean ‘folio_test_hugetlb’? [-Wimplicit-function-declaration] in arch/x86/kernel/asm-offsets.s (arch/x86/kernel/asm-offsets.c) [logspec:kbuild,kbuild.compiler.error]
---

Log excerpt:
=====================================================
                 from arch/x86/kernel/asm-offsets.c:13:
./include/linux/highmem.h: In function ‘memcpy_from_folio’:
./include/linux/highmem.h:427:21: error: implicit declaration of function ‘folio_test_highmem’; did you mean ‘folio_test_hugetlb’? [-Wimplicit-function-declaration]
  427 |                 if (folio_test_highmem(folio) &&
      |                     ^~~~~~~~~~~~~~~~~~
      |                     folio_test_hugetlb

=====================================================

When fixing this issue, please attribute this report according to the
patch submission rules:

Reported-by: kernelci.org bot <bot@kernelci.org>

For complete logs and details about the environment used, see the issue
on the KernelCI dashboard:

- dashboard: https://d.kernelci.org/i/maestro:4cc27348e827518ef9ef02874233e45c244a259d
- giturl: https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git
- commit HEAD:  406de00ce2971abe3010eaabc26c71e84b4ee9b3

# Builds where the incident occurred:

## allnoconfig on (i386):
- compiler: gcc-14
- config: https://files.kernelci.org/kbuild-gcc-14-i386-allnoconfig-6ae228b65c0836a8c2f04af0/.config
- dashboard: https://d.kernelci.org/build/maestro:6ae228b65c0836a8c2f04af0

#kernelci issue maestro:4cc27348e827518ef9ef02874233e45c244a259d

--
This is an experimental report format. Please send feedback in!
Talk to us at kernelci@lists.linux.dev

Made with love by the KernelCI team - https://kernelci.org
