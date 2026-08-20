Received: from mail-pj1-f41.google.com (mail-pj1-f41.google.com [209.85.216.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4DF5D448393
	for <stable@vger.kernel.org>; Thu, 20 Aug 2026 15:59:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787241558; cv=none; b=Mde6di8WYiXWiTNwmhMn8dG8KN7J2Dl7LBdz1lWXOD1QiRcHUjBkLxegbI+wvwW64YXawusPT3JHflv8Hrse5iq0iO8sih7qtM16LYDgKA3r958NwLk3gbz429ppJOm4iNI5eBTd9P82YV7jPW0Qy2bdd7IP2nEC7Jfy5RLJUhA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787241558; c=relaxed/simple;
	bh=1K6hu7YcQma5LusQ/758gTXljvBf3oxp5PaHvuTF7Lo=;
	h=Content-Type:MIME-Version:Subject:From:To:Cc:Date:Message-ID; b=EJIgwaQDPKu155pTzFdWTm+zeYsnlRx528j6QGlTaTmI5iI9hWtweQCwwCO+QHFxnH7cXKxIBRTJwmRJEjeAbizo87ApO5x048OMOaS8PU1Swj6XDtg9rCeIXyCsdWVxURWEcRJivg/N4u6li0vTBw/CYiqTCRfrR8UyvziMchs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=kernelci.org; spf=pass smtp.mailfrom=kernelci.org; dkim=pass (2048-bit key) header.d=kernelci.org header.i=@kernelci.org header.b=jpcu5tHF; arc=none smtp.client-ip=209.85.216.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=kernelci.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernelci.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernelci.org header.i=@kernelci.org header.b="jpcu5tHF"
Received: by mail-pj1-f41.google.com with SMTP id 98e67ed59e1d1-38e58034d05so2045503a91.2
        for <stable@vger.kernel.org>; Thu, 20 Aug 2026 08:59:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci.org; s=google; t=1787241557; x=1787846357; darn=vger.kernel.org;
        h=message-id:date:reply-to:cc:to:from:subject
         :content-transfer-encoding:mime-version:content-type:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=BacCuE0bJBOcULdQV9aYfdSN1DL60z+MvrCnIvy4/7w=;
        b=jpcu5tHFjrvqVGz3iHgUHlGqINlQnrgAk5a6t9MESU7LNZKPNVyHoOL1DxE93D4OcK
         0cthM/YD0NXCTUe3ltfqIRSm+ykpsGI7M+JDdP1WZMWJetQO9CgE/rQBxAwty1nEe92z
         17NThV242sno0uDo21zE2GVfXNqpb8eLPHZyZIDXUm6Ivqx0xfQyXjpZiiZLNIcls7cC
         9t4+PV10Z8a0JLOnd+6k0Z+34JNP0gFPyvXenSyS+8AXAOjvoq+r4dTrTvcyHtk97Tek
         2Jqf6oHDAz1dqvvvwOMBDB24unGnHgyAET/YrThX7F9FL9Jx4iKyTg6i1ZFcZGIahfk4
         JM4Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787241557; x=1787846357;
        h=message-id:date:reply-to:cc:to:from:subject
         :content-transfer-encoding:mime-version:content-type:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=BacCuE0bJBOcULdQV9aYfdSN1DL60z+MvrCnIvy4/7w=;
        b=nUBuLq26tZdAf72e5m7alVQo8HpoGU7ipqH04prY7gxnzzXwbP7xMjCIUJs219ZpMr
         zX+IiIVAEAySIA2xIq8MxmTVzkZtV+pnFO8jzWuE+92832yhvxlSw+Bh6WMTcz6F4tpz
         mtUuK369uvUEruk7iNcpWkINvHh/Co2ZaqNd60CDdJh4w+jBmQKxRSzL+HrCgywqNSQJ
         LcHGDa7nsaE0I2hjPPHRe/rcsS5jIgXvox8WBZ7IchAF5VrPA4DGqeB4QX9szlNGRidW
         ZwN98MggMeF2/t1eOzwhwk2HaZpNdUkfIJtjQVX1MUlgmGtqkrGNyoDs6zyb+YsS+eut
         YJDA==
X-Gm-Message-State: AFuF++m1m6edOsLhQ+c/hZjUD9bl8hKzLNblnWRroeeRQRJ4EHRahn4/
	rvP8ecCMAOPn9CVN1v86D/OpkTjRKy1+pT1Fnw5bjTrcc+aLzvFuoEsNhkT5rYiDEpU=
X-Gm-Gg: AR+sD12KaLcFgRtGttVizmfQLLuaZgpNlKd8q/LHLU0Nv/JKG5IAyhoHkP39NFPZ4vl
	TLlYozOfMphYSF3Y4uSXZbK4JofxnTn0nBT4nHhYquHPaLTO0Lw2WxcEeBmQcLjt+AdoxtlRZlm
	f0FiI7CdMYnvqgUmEajN7Ntv4Flm1h+dKKu7WPwGW4cedXCf00Sea4lCdFB5ckyybzPQYYo3dto
	sPtNmovNTI3huLhCk1nwxhgofW0Uvnco1o3Hi17a++eStNDo0F/IFDUy3wMNbQC4kBjJLLNq4PU
	PrIuv1MUAbrJc/YmmYptdGc/pdhqSSuzJCpBCfjMyeQJvNT3D3StV/1Ivdc3tMDPO02qn7OSetN
	9zBJpU5cKsQalHbRh2El4Nx88SRcvKUrfQCxOU5zGyuQEHnEc0UsLfEbHqtLHvuUbWN8BtigS4r
	L/jZUhhTV+MOWqkdXY5X8RnofU/i3Zf8UDiTKh43uXTPGDuKukhSyY
X-Received: by 2002:a17:90b:1dd0:b0:395:4e0d:bc60 with SMTP id 98e67ed59e1d1-39580f3bcffmr27077713a91.9.1787241556494;
        Thu, 20 Aug 2026 08:59:16 -0700 (PDT)
Received: from b455de3d9de8 ([20.38.40.137])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-327bec30f49sm16235004eec.0.2026.08.20.08.59.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 20 Aug 2026 08:59:15 -0700 (PDT)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Subject: [REGRESSION] stable-rc/linux-5.15.y: (build) no member named
 'bh_work' in
 'struct atmel_mci' in drivers/mmc/hos...
From: KernelCI bot <bot@kernelci.org>
To: kernelci-results@groups.io
Cc: stable@vger.kernel.org
Reply-To: kernelci@lists.linux.dev
Date: Thu, 20 Aug 2026 15:59:15 -0000
Message-ID: <178724155461.746.4100725414273763076@kernelci.org>

New build issue found on stable-rc/linux-5.15.y:

---
 no member named 'bh_work' in 'struct atmel_mci' in drivers/mmc/host/atmel-mci.o (drivers/mmc/host/atmel-mci.c) [logspec:kbuild,kbuild.compiler.error]
---

Log excerpt:
=====================================================
/tmp/kci/linux/drivers/mmc/host/atmel-mci.c:2632:26: error: no member named 'bh_work' in 'struct atmel_mci'
 2632 |         cancel_work_sync(&host->bh_work);
      |                           ~~~~  ^
1 error generated.

=====================================================

When fixing this issue, please attribute this report according to the
patch submission rules:

Reported-by: kernelci.org bot <bot@kernelci.org>

For complete logs and details about the environment used, see the issue
on the KernelCI dashboard:

- dashboard: https://d.kernelci.org/i/maestro:86840c8d53f86eedf35e284be24a30e500b6c742
- giturl: https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git
- commit HEAD:  62fcde3a6c435b1cfa487525cd28e01d879b0c09

# Builds where the incident occurred:

## multi_v7_defconfig on (arm):
- compiler: clang-21
- config: None
- dashboard: https://d.kernelci.org/build/maestro:6a871d3362f33761c0f0f570

#kernelci issue maestro:86840c8d53f86eedf35e284be24a30e500b6c742

--
This is an experimental report format. Please send feedback in!
Talk to us at kernelci@lists.linux.dev

Made with love by the KernelCI team - https://kernelci.org
