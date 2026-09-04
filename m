Received: from mail-pj1-f48.google.com (mail-pj1-f48.google.com [209.85.216.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6905F42376F
	for <stable@vger.kernel.org>; Fri,  4 Sep 2026 06:59:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788505149; cv=none; b=l6UboG3A0lxLHkoCFD2UsLarPg5TwRwn7LOvZdf1kLoIkGZVqo6hU0pQaGoEi83N9iMWMCjG/Al9zeyoi4mLG2cwiRCxzLSmN+LvAdIqWFAtp7f9gWFsa8jDcw4qejOOMn5X/yL25tpydfoqDgTYZSE9EKTFpe78uoaqvParmcE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788505149; c=relaxed/simple;
	bh=PZ1J8aYIusMuJOTKguAVRmXtz7YMKt3Ppx3w0xCMyrk=;
	h=Content-Type:MIME-Version:Subject:From:To:Cc:Date:Message-ID; b=k2NVpt835mswOw56Ft0KBu2/uXnjXccAG2f03asFOXNtohQF2cfpnzV5VFHfMT8tyE9iLmtF8Tt4tFvn5+gTwmQNsd89rK32dD5PB8JBzNPgGu+pwu1vroB4iBMR7jp0wtUq1rQemFDk4tkp8DZX/eaw1Gdx6qGY5gFjQbhcM7s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=kernelci.org; spf=pass smtp.mailfrom=kernelci.org; dkim=pass (2048-bit key) header.d=kernelci.org header.i=@kernelci.org header.b=CD5Yq3ec; arc=none smtp.client-ip=209.85.216.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=kernelci.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernelci.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernelci.org header.i=@kernelci.org header.b="CD5Yq3ec"
Received: by mail-pj1-f48.google.com with SMTP id 98e67ed59e1d1-38e42560ebcso565231a91.1
        for <stable@vger.kernel.org>; Thu, 03 Sep 2026 23:59:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci.org; s=google; t=1788505147; x=1789109947; darn=vger.kernel.org;
        h=message-id:date:reply-to:cc:to:from:subject
         :content-transfer-encoding:mime-version:content-type:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=0PoDrHevUlZmwJ9t1xhyxHYNY0LigVDrcYueRIVSVzM=;
        b=CD5Yq3ecbeMKRLlO5b7vtgmpPJRWQrLmS6EO+ZgigURcPAOwfsFlHwltaACY5FOCcg
         A+FKb0oimf3sUokUWzWHDUfalWWCcofbu2ihPAmDmDFSthnanFmg0sZerQ7848VvWgzT
         wApgY3Org77LQj5Ya/c2MnpSiUz3nLhhFnpgjkBvAf2G4QgyvA+kMLOhH3IhCZ+VStJ1
         HjUHbZNyqBtlUbeJwWy9JFZqyky2K7wDbuWd4ntDGA8WmtoMHqDo5JSFWmX9uoOMJHdf
         nUjZDgykp/UX8vx67NzsyolphYDzEjrSjwqmtRz1LOtSRuyKAil2u/LLDdqvp+h6fkMB
         IaIw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788505147; x=1789109947;
        h=message-id:date:reply-to:cc:to:from:subject
         :content-transfer-encoding:mime-version:content-type:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=0PoDrHevUlZmwJ9t1xhyxHYNY0LigVDrcYueRIVSVzM=;
        b=U2UNZuJmS86Vzj5k+NG34tZuouY13yNrnn0yWpwmiKkDBD8LgWIVw5Uz3VlA+c8a7q
         dTCglrBo0ZWqzlu7IdEwkFbYPkzixtS4thzQMo/g/9TQge+v0B4HaCHxI33Cd1N49fVT
         vdH4fOQgds8XHDzthXxQW/O2BilqaMEa3Rh7QtbZ4DdqRSnH9ssc03RVxFLEEJ+9IN1j
         y4Iqj9rwc3rmGfGisdp6dzGzqiFuzE/s5MVQCM0ATaquWF2J+4xQutr9sUw6gPyy2qHb
         cwK4wiLZX4rcDqdmBLn4tTG0244HnDtArVngDoTvVQAb0/UnUkcx0HqQoz+QWrWb+gpT
         k2lw==
X-Gm-Message-State: AFuF++kE/nzmicqXBTtL+tRfBa6Bj3yHOcVnbx9jN1OVjKfI1EFEeTdj
	BaQnco55FmnKvpDrQynl4uzg9FrrGNEYnzOt2Yh9xLlC/G9Z83r0VZPRkbzt71eFRHk=
X-Gm-Gg: AYBFou0kamFYOIkf+eNVzA3aaQ9WWkB22Jz3xy0f1Ir14BCXy7/7/XdyoE9YRdK04kJ
	FAF6twnRDpcqnLfwl9l1Jy05TADT13wGF4e3aOWzSHkCnhMtHVw/pPZXVEMOTc+FS0hxa9rxSx5
	a+hmGw55cZNCCs1HkMKMYQHbKv/lJ6sxXzAMWUUOFrOqg1YpuvBf+4TvQfsrnqZw9FNiOoe92eE
	GaZNncvBrLIK/Mg3R4lNGf3ks4YV3K5jUQUQXBFbH+XMC5AGLsOl6U6fwd4KZwE2kKGbZXLJLht
	ys7nysM3PFPweF09miGlvEWY5LwxDMWOfHtrZ5sYUrmylXTODAh8rshYm3/IoMB1CFnG0GmH6F1
	w+E/4bVBy3GH/oCQs64BbcEFFeNbfzNJrrZ7gigU/bFhBA1R2cBU745cc24zglKDXIizn+9dwJI
	djqfMbEhetJN5E9ub3To9oQywvjOTsT5QzEKFQRz4B3UfVn9wIcPvm
X-Received: by 2002:a17:90b:4e8f:b0:38e:5c6:4db9 with SMTP id 98e67ed59e1d1-39b261ba63bmr6457034a91.11.1788505146616;
        Thu, 03 Sep 2026 23:59:06 -0700 (PDT)
Received: from 41049dfc76e5 ([20.38.40.137])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-3342af0bc08sm1901049eec.17.2026.09.03.23.59.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 03 Sep 2026 23:59:06 -0700 (PDT)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Subject: [REGRESSION] stable-rc/linux-6.12.y: (build)implicit declaration of
 function
 'huge_ptep_get' [-Werror=implicit-...
From: KernelCI bot <bot@kernelci.org>
To: kernelci-results@groups.io
Cc: stable@vger.kernel.org
Reply-To: kernelci@lists.linux.dev
Date: Fri, 04 Sep 2026 06:59:06 -0000
Message-ID: <178850514572.887.9646625024472154385@kernelci.org>

New build issue found on stable-rc/linux-6.12.y:

---
implicit declaration of function 'huge_ptep_get' [-Werror=implicit-function-declaration] in mm/page_vma_mapped.o (mm/page_vma_mapped.c) [logspec:kbuild,kbuild.compiler.error]
---

Log excerpt:
=====================================================
mm/page_vma_mapped.c:103:25: error: implicit declaration of function 'huge_ptep_get' [-Werror=implicit-function-declaration]
  103 |                 ptent = huge_ptep_get(pvmw->vma->vm_mm, pvmw->address,
      |                         ^~~~~~~~~~~~~
mm/page_vma_mapped.c:103:25: error: incompatible types when assigning to type 'pte_t' from type 'int'
cc1: some warnings being treated as errors

=====================================================

When fixing this issue, please attribute this report according to the
patch submission rules:

Reported-by: kernelci.org bot <bot@kernelci.org>

For complete logs and details about the environment used, see the issue
on the KernelCI dashboard:

- dashboard: https://d.kernelci.org/i/maestro:4fa2b7be76a49c679b6ea55b9dcf39235143cc9f
- giturl: https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git
- commit HEAD:  ee6921fed8a481c1d78d55e7958748fc4b31d30f

# Builds where the incident occurred:

## haps_hs_smp_defconfig on (arc):
- compiler: gcc-14
- config: https://files.kernelci.org/kbuild-gcc-14-arc-haps_hs_smp_defconfig-6a9a5f47e41d7f97d6fd7625/.config
- dashboard: https://d.kernelci.org/build/maestro:6a9a5f47e41d7f97d6fd7625

#kernelci issue maestro:4fa2b7be76a49c679b6ea55b9dcf39235143cc9f

--
This is an experimental report format. Please send feedback in!
Talk to us at kernelci@lists.linux.dev

Made with love by the KernelCI team - https://kernelci.org
