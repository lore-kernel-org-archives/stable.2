Received: from mail-pg1-f175.google.com (mail-pg1-f175.google.com [209.85.215.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 002D04A3D3F
	for <stable@vger.kernel.org>; Fri, 11 Sep 2026 16:59:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789145967; cv=none; b=d+f9K+33mOhkQ4+JkJ6ygv31Ypb1hjqlGsrxBLlAA1OFea4Oge6DfZxA18Y2mQzAuI7krSJyJcUYaqtE8um3AXnrG4zN6LrNdQS1IxT9qSCKQhJdSCaFGx2L5WovM5veIkT+2jEuMrKkBZx46qI5D3ys447N2zKqHMMxUKThaXI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789145967; c=relaxed/simple;
	bh=qhiqdIHtYujQGrF+5+QEVuVxSiAvhoJN9ueuN+UnKX0=;
	h=Content-Type:MIME-Version:Subject:From:To:Cc:Date:Message-ID; b=a7fFElx8rQlXp8n39cwL1tT/C9NW79DhmS5KVfuTV6u03kcCDBgmdKsACj2voyJB+Ri/cZZkpRI6niyaDxOUSb5yP9hSaO7w5kaVRo75EKztV42pEwcAIrZKUywPj68ksisFuKNFDCmEVsCO0xtvl839ItCwzXNTPlvcc5bpd2w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=kernelci.org; spf=pass smtp.mailfrom=kernelci.org; dkim=pass (2048-bit key) header.d=kernelci.org header.i=@kernelci.org header.b=i2zbFwLg; arc=none smtp.client-ip=209.85.215.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=kernelci.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernelci.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernelci.org header.i=@kernelci.org header.b="i2zbFwLg"
Received: by mail-pg1-f175.google.com with SMTP id 41be03b00d2f7-cc4d03f95dfso523644a12.2
        for <stable@vger.kernel.org>; Fri, 11 Sep 2026 09:59:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci.org; s=google; t=1789145952; x=1789750752; darn=vger.kernel.org;
        h=message-id:date:reply-to:cc:to:from:subject
         :content-transfer-encoding:mime-version:content-type:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=RoS3J+Eh0eqOn/NddRHnr0PqtxMtAN0qArSIirbialw=;
        b=i2zbFwLgxFsl5znMCoHpCXU51R9Kbp4ZsdxbCXTZonFBWZOHgaM+Ge1uN72ziIPowK
         RwPXD77D5PaC3xzDji8Xu4AIaQ+WxYqzKP+5BhUpkdAnwS7qc6sWaKaBFAqGEGoyhaGo
         8Cx+W3095hmk0CveELqln+CI/1LCZpiGh90mhKiTvV2JivSRrzXHOe4rUEbx+vtHmpAF
         Vmrrc4uxGX6G8yTThVznILBFgJCi/zqOllLDyOkychxQVhIFPlJWFKcPqnCYXPyyasSR
         Z6+x6HLIOeAMJ1yjDmvvT/3IQGcjVCMrSXQpoCxQrDeRVBYixuHcgYBW0c4rH9uUHzDL
         pEdQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1789145952; x=1789750752;
        h=message-id:date:reply-to:cc:to:from:subject
         :content-transfer-encoding:mime-version:content-type:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=RoS3J+Eh0eqOn/NddRHnr0PqtxMtAN0qArSIirbialw=;
        b=Ok38TjY0uTZZdHtAmpSN1Cm6ud9jI/y4o4igOcSaR2oKXK3AQputrpNUww31wgLojS
         uRGT7pa22iVIIkpTRr6vAF6TU3up3zSe7GutdWf1OMW8G2Rp4Vj8JXQVUQ/CvCV11Ba8
         3AAqJh21JhvATieqFjVF8eMbUsG9RWgtFI55bQQVLpiv2HIfon24Xu4MW2YiZegmlKHy
         j57Zuk4D0j+4g4IPMfac6Fs8nwgVkJXdO+a/PKH6fk5HRnbgC77ExOGcwfrQT9oU9ZQv
         hu7+ZTlTuqt2AZ/Z4EF5jujdB0sZpJQ3n6OARPZKM/Hj8Zah5LzTLekH6p3lzI8R0SV7
         1tgg==
X-Gm-Message-State: AFuF++mAQwM+aTtteoiUCncV7bCueXG+rVo/kjFcQ1fRHlmCOA+QMN98
	+Aglan6cCB+EDaqYEspRFr19LO5RGZaMGGCkiWFhxwQWzIjx7UtZoFQeGO1CilwxMdk1e1V9LNN
	/rMY6
X-Gm-Gg: AYBFou27+X7/+VIKkCph5GQz8lnoZJrL1+LQoGiy0xfcciGZgY801W1AmTx2DW2JKjX
	3d14Mux3YFhYwNxkWZAkK0ZUn/pxxGvwuWuylC7kYour6ctAd3fvjGAU2oroypm5loai9v3X+bo
	XZMUkFA7ixpl34IvpXFzkgdN6BAI59iE4m/YCrd6Gfm/WZBkErMkWYJfL6qZpcKuRd+HLb+TPmk
	9IiQobsPpPdqFeLbzyzTP53DlB+D2+GwMZ5db/jA0UM3Y5HKBfX4Ntk2s7pNep+ToQgqZbMtkuj
	Oc0qQQ54gIkEtrdXCWKrJAxL5CpUurYUAh+OPPckuPzuYckvIvFuK9GgUBA50eP2GTOp/cd3G9T
	cwUkCudq5dlYlT/44zPcHhNUPtWuVH2+iH9sC8beHgymUBhMBthth+JDXA7CQ6s2tpHNfRdoA5u
	Jsl+uYim7E+In7qXiTdPPL23m8fUVViIQ+K+Hj+bXQGZ+rLbDwlweO9BhIw8hBbOo=
X-Received: by 2002:a05:6a21:3391:b0:3cc:b26a:7686 with SMTP id adf61e73a8af0-3daed1515f5mr10616412637.6.1789145952129;
        Fri, 11 Sep 2026 09:59:12 -0700 (PDT)
Received: from 41049dfc76e5 ([20.38.40.137])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-33ba4ee07f2sm6945964eec.18.2026.09.11.09.59.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 11 Sep 2026 09:59:11 -0700 (PDT)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Subject: [REGRESSION] stable-rc/linux-6.1.y: (build)undefined reference to
 `crc32c' in
 fs/ext4/bitmap (fs/ext4/bitmap.c...
From: KernelCI bot <bot@kernelci.org>
To: kernelci-results@groups.io
Cc: stable@vger.kernel.org
Reply-To: kernelci@lists.linux.dev
Date: Fri, 11 Sep 2026 16:59:11 -0000
Message-ID: <178914595126.4423.2404790726810259458@kernelci.org>

New build issue found on stable-rc/linux-6.1.y:

---
undefined reference to `crc32c' in fs/ext4/bitmap (fs/ext4/bitmap.c) [logspec:kbuild,kbuild.compiler.linker_error]
---

Log excerpt:
=====================================================
ld: fs/ext4/bitmap.o: in function `ext4_block_bitmap_csum_set':
bitmap.c:(.text+0x1bd): undefined reference to `crc32c'
ld: fs/ext4/extents.o: in function `__ext4_ext_check':
extents.c:(.text+0x767): undefined reference to `crc32c'
ld: fs/ext4/extents.o:extents.c:(.text+0xa91): more undefined references to `crc32c' follow

=====================================================

When fixing this issue, please attribute this report according to the
patch submission rules:

Reported-by: kernelci.org bot <bot@kernelci.org>

For complete logs and details about the environment used, see the issue
on the KernelCI dashboard:

- dashboard: https://d.kernelci.org/i/maestro:ac05bcf65b328ed9ac6e71fe7de384a53ab329c3
- giturl: https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git
- commit HEAD:  9f5e4631f281f1f3c92f33dcb2dc004f416196a0

# Builds where the incident occurred:

## i386_defconfig on (i386):
- compiler: gcc-14
- config: https://files.kernelci.org/kbuild-gcc-14-i386-6aa40bae20239ade90229bb1/.config
- dashboard: https://d.kernelci.org/build/maestro:6aa40bae20239ade90229bb1

#kernelci issue maestro:ac05bcf65b328ed9ac6e71fe7de384a53ab329c3

--
This is an experimental report format. Please send feedback in!
Talk to us at kernelci@lists.linux.dev

Made with love by the KernelCI team - https://kernelci.org
