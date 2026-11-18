Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.43
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795006752;
	b=J6wg10Put9gP2ECbyUrpfJRjQP24pohMf0w0DIUexxR7FkF7iK8KuDZQODFTPUQS5hc6
	 9sb7hW7f9BkOC3JGpu881Ai/+T6kQ74KlRnCXIcobBIA8Gq7TBI/20MDoTMDBBSRHnzpF
	 YWbVePqgCPW5WwKeHLjN6vjEbfZyoDL34mirJYdYS3pthk9aBVXB7FhYWiuE0FvYyk0kR
	 VPZ6QPDvzFULzx3P+dlRbDLBETI7USKn4o4gsslwQYiClKkfjtJWZDpUGeApnG41qfCtZ
	 yTFC5G0bGUyqMSq+0bPxpWd/Aj6iEOZQjmLDXoEwq1hqaT7OODDzT7areGSmResepow==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795006752;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:Content-Type:
	 MIME-Version:Content-Transfer-Encoding:Subject:From:To:Cc:Reply-To:
	 Date:Message-ID;
	bh=3VPBRUwXflzpEDcsKUF1UXfnKKxKyX1fpIFiSaQeDdo=;
	b=Z+YitnfBGoJpWOHW/qR4oNH2HkvasiL20FlYc24jggVbR7isbSX66az1N64dWDx9VYy/
	 yX8H7qhuYo45Hk3cJCH6ZzB6+2YFKNr1ifTrQ05CchF+VZesXB7701P9t/yZmVlKF0+7h
	 vAnY0XQgepabwEvGplM7PcpQnHD4OGYA1DTOwr3QbusetiIzteO/2dN0+3ysH5IB10tda
	 B/OvxbOAOKy3tj6cu+78dLnuC3eVvgzTazjtnuP/0i+j0E/xpcrLljwboTsxg1MADgpbW
	 JfpYCZIxXDdoj6jCmK5hHQRCbeBK8a9wIgC/a2DJSZAk4oo6aI0XH+InCWN+9WJbzDQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=kernelci.org;
	spf=pass smtp.mailfrom=kernelci.org;
	dkim=pass header.d=kernelci.org header.i=@kernelci.org header.a=rsa-sha256 header.s=google header.b=RbltlyqR;
	arc=none smtp.remote-ip=74.125.82.43
Received: from mail-dl1-f43.google.com (mail-dl1-f43.google.com [74.125.82.43])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E6912606A330
	for <stable@vger.kernel.org>; Wed, 18 Nov 2026 12:59:11 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org E6912606A330
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=kernelci.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernelci.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernelci.org header.i=@kernelci.org header.a=rsa-sha256 header.s=google header.b=RbltlyqR
Received: by mail-dl1-f43.google.com with SMTP id a92af1059eb24-1a8cc11ac42so1316559c88.0
        for <stable@vger.kernel.org>; Wed, 18 Nov 2026 04:59:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci.org; s=google; t=1795006751; x=1795611551; darn=vger.kernel.org;
        h=message-id:date:reply-to:cc:to:from:subject
         :content-transfer-encoding:mime-version:content-type:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=3VPBRUwXflzpEDcsKUF1UXfnKKxKyX1fpIFiSaQeDdo=;
        b=RbltlyqRP5xbZSiCSEl7nuOV77jtI8ZaZG92oUgcAUhm5MBzbRUYShjTw2fzE1zpyh
         8/hXA59n44klPAaQCwFa2i7WwX+uVsgoO/mZDU/TCkdcf/xNZmkwv1ukV5XFgP7n90O+
         BWGc1dF3apn/v3uqGOXfY/y4adtHciMNCypRbsAsptAOTSqk0t0Zlg92uX79l8NT75fP
         u+JoxrvbIUcmN8h9UKUOpE5/HESqOSrklywJ2Bb1gqr0/1XxonVFZlUh2yKCLLyC+dSd
         hve33EZitkNzrVZrvpLaHq5wnJ3DKl1xeXcwIz5FQDThOajtanfgSLwXxiTjWZeBkGDv
         tS+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795006751; x=1795611551;
        h=message-id:date:reply-to:cc:to:from:subject
         :content-transfer-encoding:mime-version:content-type:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=3VPBRUwXflzpEDcsKUF1UXfnKKxKyX1fpIFiSaQeDdo=;
        b=xZLebhSASJzgk1QJ8x4KqDmHnL7FSuYN/baZQ0VVqW7w60UwNK7KK6G8YlnB3o9dOs
         wJavsy/pkiLYjYUqagKG5/QNT3zpyEb+iYlW4ouGB3YsJne+n+6JcKK9T7wa+s8lOisA
         XidXGcqCoh0UKq4zLzVubj4O44+jn/kOkXXLtSJHYboih5+yBtuUNW/+awDAMavoR9dp
         9op0T2Ad0nRK+Kb/eTZuwkO5H+CZSQ6SOMWf/gHgWmgnHbcAzbQOemxtgQoO+yla7fcC
         rN1pxLn1SyWJIuQDzCpgWL7gpZNKmMv1UjdVH2YYB15GUNHgQP0pJ+mmd1J6HucRth31
         1LMA==
X-Gm-Message-State: APuU4Z9kBsrJS33DCL0Cb6jUgdpuGdl19UftjcU1tAWsk2Mk+dZUFraL
	9K/eYM+5FPsvbzIc5Ag2fwB/AaxAzc3FKH2Xlx9b11aSs2agOrA14DdxiEaSFIZAvxSQKNyJFKv
	oAhYQ
X-Gm-Gg: AYBFou0LS7eEAS5ILE/z2HQT2qnwCbIm4eroxL7jByzmaxPIykXKPJghaFHPJSxb38n
	CfNVh/yWcdWWmLo0KLZsOK+HujYHB+JGdwhQBEuvQlHDbZFzKNOY4ZjZn9R974RgLkeYToG3gZE
	AN+7++w18P+9eAmlvLhwZaoGeLe4lNbRqHd34edv3tQLC70/EpZC3/sbrYb+aJZmfLVmb1c4OPE
	FwnWxjt8aP5u6PRceKaQe2pXqwNHfs3CJo0J1LwFByNnLkx53WzJoTMNAMi6I40B3HZSNtZ7IaU
	HDG7Mo8ChOUlAqO2svMrbpmuL4E2tdwFtICRg/zEbTjyOQeiQ+mgRvQlhDYl+UT3CjCjiBan4gz
	7GLJ2+OG5H5kC1vFc7WpKCu4DZI9LQiW7Es47+lHxFOAr4SNI7dhDdX37oWByz/IejwD8H1myCY
	yM1K5mNSDscIUqs2e1TyaZnofE+uZ3tVSczGGrhG8Gt4mNZEfbl1r11R+5HIIyk+7JjsNzflwWr
	l6A/6vRfDfWcNE6Z/QvvToD27BspMY0DyLW6RhLywKNp3E8EBQESm/K8Kn1EgnLPKfkElP24AQp
	xZlDFRzVvlDi9vpbQUapYw==
X-Received: by 2002:a05:701a:844a:10b0:1b2:529c:5b6c with SMTP id a92af1059eb24-1b543cc6449mr2419735c88.14.1795006750611;
        Wed, 18 Nov 2026 04:59:10 -0800 (PST)
Received: from 8439c401ee69 ([20.38.40.137])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-1b5447dc596sm6290610c88.10.2026.11.18.04.59.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 18 Nov 2026 04:59:10 -0800 (PST)
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
Content-Transfer-Encoding: 7bit
Subject: [REGRESSION] stable-rc/linux-6.1.y: (build)too few arguments to
 function call,
 expected 2, have 1 in drivers/d...
From: KernelCI bot <bot@kernelci.org>
To: kernelci-results@groups.io
Cc: stable@vger.kernel.org
Reply-To: kernelci@lists.linux.dev
Date: Wed, 18 Nov 2026 12:59:10 -0000
Message-ID: <179500674956.301701.7324165274049576968@kernelci.org>

Cc from: regression/stable-rc.yaml

New build issue found on stable-rc/linux-6.1.y:

---
too few arguments to function call, expected 2, have 1 in drivers/dma/ste_dma40.o (drivers/dma/ste_dma40.c) [logspec:kbuild,kbuild.compiler.error]
---

Log excerpt:
=====================================================
/tmp/kci/linux/drivers/dma/ste_dma40.c:1694:42: error: too few arguments to function call, expected 2, have 1
 1694 |         ret = pm_runtime_get_if_active(base->dev);
      |               ~~~~~~~~~~~~~~~~~~~~~~~~          ^
/tmp/kci/linux/include/linux/pm_runtime.h:76:12: note: 'pm_runtime_get_if_active' declared here
   76 | extern int pm_runtime_get_if_active(struct device *dev, bool ign_usage_count);
      |            ^                        ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
/tmp/kci/linux/drivers/dma/ste_dma40.c:3305:11: error: incompatible integer to pointer conversion returning 'int' from a function with result type 'struct d40_base *' [-Wint-conversion]
 3305 |                         return -EINVAL;
      |                                ^~~~~~~
2 errors generated.

=====================================================

When fixing this issue, please attribute this report according to the
patch submission rules:

Reported-by: kernelci.org bot <bot@kernelci.org>

For complete logs and details about the environment used, see the issue
on the KernelCI dashboard:

- dashboard: https://d.kernelci.org/i/maestro:bcd5dd62ffb8c7a4fc47caa85ff61b6fe4069e00
- giturl: https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git
- commit HEAD:  80555b0524e00b3e34b4619457160cbb971ec8e8

# Builds where the incident occurred:

## multi_v7_defconfig on (arm):
- compiler: clang-21
- config: None
- dashboard: https://d.kernelci.org/build/maestro:6afd912999c74e1a997d3815

#kernelci issue maestro:bcd5dd62ffb8c7a4fc47caa85ff61b6fe4069e00

--
This is an experimental report format. Please send feedback in!
Talk to us at kernelci@lists.linux.dev

Made with love by the KernelCI team - https://kernelci.org
