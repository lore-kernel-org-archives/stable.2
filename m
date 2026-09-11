Received: from mail-pg1-f179.google.com (mail-pg1-f179.google.com [209.85.215.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 52DC32576E
	for <stable@vger.kernel.org>; Fri, 11 Sep 2026 15:59:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789142350; cv=none; b=GSItw0jXcKR1Qgx1SRdz+7ojCIm1Dh+3xCRPFVS/2oiKD6tV4V4CcUji+wgY2K18sa+rG0so2yyoJEUT3A3B8g+9OrtYaI+K71xhAe1/esMUh2kPERJHYErcjkqOjBHFsuyh+gR2ueZ6KEVwjKTAlbQvyWm9kExQdXHXDDRwVsM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789142350; c=relaxed/simple;
	bh=71vCwOFgATP05CmxqNzrqz0YBUC0lSbYY7P9kaWQayg=;
	h=Content-Type:MIME-Version:Subject:From:To:Cc:Date:Message-ID; b=hSAvPfWgW/CAWEo6KBRh2MJ/S1Nmh+TaeJOgBDsLJd5PArtlzC4ksVyn80L2uoX6dndeCPzhGU8Og7bRw4FIe2cu0kMonXynVY1k8Wca8Ega/S7qD8kjC6qkPkh+7iqbxDC+3Ka/fpdnRuSNXuHlzs16O6YkjIu1i3olSj8hakQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=kernelci.org; spf=pass smtp.mailfrom=kernelci.org; dkim=pass (2048-bit key) header.d=kernelci.org header.i=@kernelci.org header.b=GZZGDpcz; arc=none smtp.client-ip=209.85.215.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=kernelci.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernelci.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernelci.org header.i=@kernelci.org header.b="GZZGDpcz"
Received: by mail-pg1-f179.google.com with SMTP id 41be03b00d2f7-cc4b62d118aso1195849a12.2
        for <stable@vger.kernel.org>; Fri, 11 Sep 2026 08:59:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci.org; s=google; t=1789142348; x=1789747148; darn=vger.kernel.org;
        h=message-id:date:reply-to:cc:to:from:subject
         :content-transfer-encoding:mime-version:content-type:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=wH14jyOqAZdlj4QDbFMObPRkXk0Puc0VpZjAZ2rtKGA=;
        b=GZZGDpczdClbmr2HpCbF6kHFPo/aJI0ejw+btNe+ITRuOBmsTWu+WNnUonawxR+D2h
         ChqV28INUsRDWiheRt/JZSZdiiB5gnVtm+xkqmBvMSGJpQCmK0Ww4sfbXbGveP58kw0y
         ZEy8y3MOgl/3QTc+RGXjWvMgKWtmC77PMDnh0J8mxD4JhQVX1cZmx9R9ubibqlEoh1qI
         iz/sK67Da1pmhEBcQvaF9qwuS55VuWqk3NzA1zB3fDzYh0/eGnAoqzIRs0tWPPSx+NCX
         WTVdcX7SWfvvIU6eQh6mwea8fREhuM2oZtk6D1iMwi9alE6aA7qCOpxvN2TqJ8zL+AWd
         tZUQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1789142348; x=1789747148;
        h=message-id:date:reply-to:cc:to:from:subject
         :content-transfer-encoding:mime-version:content-type:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=wH14jyOqAZdlj4QDbFMObPRkXk0Puc0VpZjAZ2rtKGA=;
        b=s6kmdKJcEw0Tb+ehzzRgp+pQLwxXp7NgPZ820QXgVja09iVADdqLXu0+9ORDRvV8wK
         IMnQwliSY2GVidEicuzHOGzTt1Q8zcVPsm0M9gUsx2pH17DcoT8KrRRzZ5AxDKyvbnul
         czT5/cKXZxyXhJ/CA/2mnQx0mt+cnzz8/y7BkG121b5LpDO6SnEonVbgjyoqYk3V/VIo
         vTlgMJ/gi7zf7vbygT087ChA3MGeyci3HgOoWHe+55MDkmapYeUAe6MQkdTsAE036k8U
         UkGAOYgf8yzjCcnCX9373b6K/FrJS4vNCBpXJD+F+y2pJMFbh1yIFbQ29dE7BifEIRxa
         tlkA==
X-Gm-Message-State: AFuF++lDVoU++KLsuKw6YDfo+mAyZzkRQ3kyCCeW8wEifVRJ58d+7Kke
	hTxq7jktXfuLMQGwwAOAyePOi8pI89EkuMYz7iWtLjJITtpuRYKwV5dVrQ+14AM5W+hC4nR5nM+
	B4Fgh
X-Gm-Gg: AYBFou11QDieyTgDBtlrUa7NvnXLdxnXbfSfZfw6le/7vmAh+rauZUseBVFJ6R3AqjX
	sYek+P+Wi4wsfyO3OVfmZvkDiOWPQ1v4stYkAjJRi1feEjLONCcxQjBTPO1Zyqn5ms8pgC+ktLJ
	EOKcTMZXIyKomGUEPfXkeqcsF9H9txDnBiv7HFxjKYFdluu0VXCeRVxwIZly+FE9A3tebyiwosr
	MFOCAr3l305Uyb1ui540W9YIgJ/h+/KxTgUKIxlOc6vj4C4rLoYhSNUyUtRHLIkh5CXSXKp4LtS
	iUEXyFD3VOqNExsKqCb5iVTH+GoUR7wAGNA+6RFcAgvZm4nS8zdJ+lTBPBDhe/UL94g+LG2pgYX
	5B9DsJ1dHSDRjhJ6eIdGP0IyZWYumQG+75A8dZC5ZIyF8+p3FKQnvvv1DVBPRrBmk6/iFURJIqr
	edvQiRdFe59iJoM2FVfKJ2avVlRmGHyof9HNXHAVhgJYVe5AIvZCJx1lPxLhtKcI8=
X-Received: by 2002:a05:6a21:3292:b0:3cc:f0c7:5999 with SMTP id adf61e73a8af0-3daed321b34mr8225493637.16.1789142348438;
        Fri, 11 Sep 2026 08:59:08 -0700 (PDT)
Received: from 41049dfc76e5 ([20.38.40.137])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-14365b759d0sm8262757c88.7.2026.09.11.08.59.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 11 Sep 2026 08:59:08 -0700 (PDT)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Subject: [REGRESSION] stable-rc/linux-6.12.y: (build)undefined reference to
 `crc32c' in
 fs/ext4/bitmap (fs/ext4/bitmap.c...
From: KernelCI bot <bot@kernelci.org>
To: kernelci-results@groups.io
Cc: stable@vger.kernel.org
Reply-To: kernelci@lists.linux.dev
Date: Fri, 11 Sep 2026 15:59:08 -0000
Message-ID: <178914234758.4405.6682565745609412476@kernelci.org>

New build issue found on stable-rc/linux-6.12.y:

---
undefined reference to `crc32c' in fs/ext4/bitmap (fs/ext4/bitmap.c) [logspec:kbuild,kbuild.compiler.linker_error]
---

Log excerpt:
=====================================================
riscv64-linux-gnu-ld: fs/ext4/bitmap.o: in function `ext4_block_bitmap_csum_set':
bitmap.c:(.text+0x1de): undefined reference to `crc32c'
riscv64-linux-gnu-ld: fs/ext4/extents.o: in function `__ext4_ext_check':
extents.c:(.text+0x532): undefined reference to `crc32c'
riscv64-linux-gnu-ld: fs/ext4/extents.o:extents.c:(.text+0xb02): more undefined references to `crc32c' follow

=====================================================

When fixing this issue, please attribute this report according to the
patch submission rules:

Reported-by: kernelci.org bot <bot@kernelci.org>

For complete logs and details about the environment used, see the issue
on the KernelCI dashboard:

- dashboard: https://d.kernelci.org/i/maestro:4586c701a55d71d4169a0eec43a7e1b3a0883ab1
- giturl: https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git
- commit HEAD:  f97429de1ef3e1b6f7986abbcb45bb115b876977

# Builds where the incident occurred:

## defconfig on (riscv):
- compiler: gcc-14
- config: None
- dashboard: https://d.kernelci.org/build/maestro:6aa40d4820239ade9022b114

#kernelci issue maestro:4586c701a55d71d4169a0eec43a7e1b3a0883ab1

--
This is an experimental report format. Please send feedback in!
Talk to us at kernelci@lists.linux.dev

Made with love by the KernelCI team - https://kernelci.org
