Received: from mail-pf1-f181.google.com (mail-pf1-f181.google.com [209.85.210.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B763D351C35
	for <stable@vger.kernel.org>; Fri,  4 Sep 2026 06:59:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788505157; cv=none; b=upDiH6KNWttycCv7oyfgKY39KY51KRZ+yoHgy7hox7l6rNzKtvzfpBm6EVZCgOFrX0FeHNG6XAnnkpKIexOGyAtqdpWvxz+Bepk1zhk65bYsZ65JVL72KthgoFrHchdwO1uJO/ZKmTOImDPW4KC4sXY79z3ZslGF2n06rVCM+5o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788505157; c=relaxed/simple;
	bh=wxBQVRVO3LNlIxLPFPouPuiUuLSrny1kKfkcZ1Gx3tA=;
	h=Content-Type:MIME-Version:Subject:From:To:Cc:Date:Message-ID; b=ogck48yuGGPBDiiOk5H+ky5X+ET3KnfyDvwfHEfqAJIv03vRj6D/CnKu/s54KXSz1UBfiRmDPKJDMWmgxTa05tS/w4a44rbuuXxhdBjgl5cnWVFU3/WUX4uY6ipSjeBojKhfZgyUA0qhhZTNIcPuwdLS1RWbW+Ei0m/aA+18rdo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=kernelci.org; spf=pass smtp.mailfrom=kernelci.org; dkim=pass (2048-bit key) header.d=kernelci.org header.i=@kernelci.org header.b=cy7nfy2K; arc=none smtp.client-ip=209.85.210.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=kernelci.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernelci.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernelci.org header.i=@kernelci.org header.b="cy7nfy2K"
Received: by mail-pf1-f181.google.com with SMTP id d2e1a72fcca58-8568e3ed034so495748b3a.0
        for <stable@vger.kernel.org>; Thu, 03 Sep 2026 23:59:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci.org; s=google; t=1788505155; x=1789109955; darn=vger.kernel.org;
        h=message-id:date:reply-to:cc:to:from:subject
         :content-transfer-encoding:mime-version:content-type:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=0Mvge/bodYeo4ZQWwXbk3QulcRv2Vcc36cHQ0qZC5gI=;
        b=cy7nfy2KpdToNm++x6yjHX3K7FeGz0Xbh647vouvx0dVDSiBDcs2cdoPYxRMDt1YfL
         xnYZTOVi+rosMMZTR+wO6c069QGOrsRmxo3wkoC90ThpcA/hO3s824QsMjF5MMYLjrTf
         f40PWh7UCfagc6OtJ2LpHWiQHN736mdWkucQ/0FcBhnjjkISPLd2QiV2waYKYY/11FtT
         /1LQ0SAqq4lutt7V3lX0yt/9CEuBunOV10V9PsffNZIECHYzCD5VPsLVC9tnMRwkJFZO
         WBi7z7A96dDKUOnOzqvwxhjWp8qh2iL5P3TEePeqWffuqir7aoyG6yALRDMExtxXHDdK
         PwEQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788505155; x=1789109955;
        h=message-id:date:reply-to:cc:to:from:subject
         :content-transfer-encoding:mime-version:content-type:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=0Mvge/bodYeo4ZQWwXbk3QulcRv2Vcc36cHQ0qZC5gI=;
        b=Otr9+7CotXCeQOyZIR5+K60JDmouBC6ibZalz8E5m6f0WTXbwyCOxwy3BVHHvaxbFC
         QvR37CaLeipcAUHYa4p9ifLO9hfZISvkrL+dPMr0lCqmID7dkcR4LxXwWxuGkWz6YbDf
         2mnYKQ9g5vG5dOS5uhHAQ/r6LrWJWTPBsg6y7YiMYK5TSJd8DgEo1yCfuILz9pt+OYPH
         7/oCkfPZY1yxPhxrJvHHZ6LVcOFYvqXNAz62/K0X/ikgnHRMdqDQXmFHr0ngfMuor4pA
         a2cukgbRp8u0EuRNtO5Nxp+2Vl2LmNnQIofhg0C6Dhjb25P5tDrvus8KvYvVHqvN73/C
         9Xmg==
X-Gm-Message-State: AFuF++mKFAFKlRaWuSoT5qRDLyQJTgP3HYj3N61oj/GMUZvdNu8bWlx9
	EUsUdBzH/axNDf2y06ulVJzyl2hPbfDl9N71bNVXV1hEbkoNqVGhBN4kCOCuSzjwJgk=
X-Gm-Gg: AYBFou3WYE6MZzjst05DWd4xwoomjkDF5/OhE/QbDXkC9XREQynvgOILBdCQx8aXDa0
	6DXXYOyx/8wVcjm8OSgbJt88GWfaU0N5JHf3q1+sQhKkezVibzT0NgIDLTjsq8dHwUhTnjer/Ey
	m7O6fccJQcX4P68mNaSekcidL9MfQdPcQ0Sgw7lFQZ7Yvk5qU8XZyYF/sydEFi7gFviwftUwI0R
	434VtjBiiyMo68jiwOZWk+6ZU+zlr6jYstLzhideEbd44HYw3nKo4Uv0Hv1uquAtT0WKUIiRXKn
	z9icKZSVK/H4MLsq8CDObx0ORdMqEd4qhQOxT1DxyLkMUaOj46nsrNaqwbNfgGafc83EeM4//pu
	bkjWx8jY497YHLgBFZfE9tiIHwBB8KdsdavpTscw6NSANuPm2V4OmfdjyD1HbbbiHOLilDriOyc
	zJKEINXjaYOixiC0Kt6fV/Zfh45saHMJxo2ZlxrJSL0tni2kr8JDBE
X-Received: by 2002:a05:6a20:6a1d:b0:3c3:a31b:3949 with SMTP id adf61e73a8af0-3da39d2e51amr5936242637.11.1788505154779;
        Thu, 03 Sep 2026 23:59:14 -0700 (PDT)
Received: from 41049dfc76e5 ([20.38.40.137])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-3339a534d25sm4391632eec.5.2026.09.03.23.59.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 03 Sep 2026 23:59:14 -0700 (PDT)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: 
 =?utf-8?q?=5BREGRESSION=5D_stable-rc/linux-6=2E12=2Ey=3A_=28build=29implicit?=
 =?utf-8?q?_declaration_of_function_=E2=80=98huge=5Fptep=5Fget=E2=80=99_=5B-?=
 =?utf-8?q?Wimplicit-functi=2E=2E=2E?=
From: KernelCI bot <bot@kernelci.org>
To: kernelci-results@groups.io
Cc: stable@vger.kernel.org
Reply-To: kernelci@lists.linux.dev
Date: Fri, 04 Sep 2026 06:59:14 -0000
Message-ID: <178850515394.887.11666988684623649966@kernelci.org>

New build issue found on stable-rc/linux-6.12.y:

---
implicit declaration of function ‘huge_ptep_get’ [-Wimplicit-function-declaration] in mm/page_vma_mapped.o (mm/page_vma_mapped.c) [logspec:kbuild,kbuild.compiler.error]
---

Log excerpt:
=====================================================
/tmp/kci/linux/mm/page_vma_mapped.c:103:25: error: implicit declaration of function ‘huge_ptep_get’ [-Wimplicit-function-declaration]
  103 |                 ptent = huge_ptep_get(pvmw->vma->vm_mm, pvmw->address,
      |                         ^~~~~~~~~~~~~
/tmp/kci/linux/mm/page_vma_mapped.c:103:25: error: incompatible types when assigning to type ‘pte_t’ from type ‘int’

=====================================================

When fixing this issue, please attribute this report according to the
patch submission rules:

Reported-by: kernelci.org bot <bot@kernelci.org>

For complete logs and details about the environment used, see the issue
on the KernelCI dashboard:

- dashboard: https://d.kernelci.org/i/maestro:213250d577a597f48990eb1ff352c0739cb6a701
- giturl: https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git
- commit HEAD:  ee6921fed8a481c1d78d55e7958748fc4b31d30f

# Builds where the incident occurred:

## 32r2el_defconfig on (mips):
- compiler: gcc-14
- config: https://files.kernelci.org/kbuild-gcc-14-mips-32r2el_defconfig-6a9a5fa5e41d7f97d6fd768c/.config
- dashboard: https://d.kernelci.org/build/maestro:6a9a5fa5e41d7f97d6fd768c

## allnoconfig on (i386):
- compiler: gcc-14
- config: https://files.kernelci.org/kbuild-gcc-14-i386-allnoconfig-6a9a5f94e41d7f97d6fd7677/.config
- dashboard: https://d.kernelci.org/build/maestro:6a9a5f94e41d7f97d6fd7677

## allnoconfig+kselftest on (x86_64):
- compiler: gcc-14
- config: None
- dashboard: https://d.kernelci.org/build/maestro:6a9a5fcbe41d7f97d6fd775a

## imx_v6_v7_defconfig on (arm):
- compiler: gcc-14
- config: None
- dashboard: https://d.kernelci.org/build/maestro:6a9a5f53e41d7f97d6fd7633

## multi_v5_defconfig on (arm):
- compiler: gcc-14
- config: None
- dashboard: https://d.kernelci.org/build/maestro:6a9a5f5be41d7f97d6fd763a

## multi_v7_defconfig on (arm):
- compiler: gcc-14
- config: None
- dashboard: https://d.kernelci.org/build/maestro:6a9a5f4be41d7f97d6fd762a

## multi_v7_defconfig on (arm):
- compiler: gcc-15
- config: None
- dashboard: https://d.kernelci.org/build/maestro:6a9a5f4fe41d7f97d6fd762d

## multi_v7_defconfig+kselftest on (arm):
- compiler: gcc-14
- config: None
- dashboard: https://d.kernelci.org/build/maestro:6a9a5f57e41d7f97d6fd7637

## tinyconfig on (i386):
- compiler: gcc-14
- config: https://files.kernelci.org/kbuild-gcc-14-i386-tinyconfig-6a9a5f98e41d7f97d6fd767a/.config
- dashboard: https://d.kernelci.org/build/maestro:6a9a5f98e41d7f97d6fd767a

## tinyconfig+kselftest on (x86_64):
- compiler: gcc-14
- config: None
- dashboard: https://d.kernelci.org/build/maestro:6a9a5fd4e41d7f97d6fd7761

## vexpress_defconfig on (arm):
- compiler: gcc-14
- config: None
- dashboard: https://d.kernelci.org/build/maestro:6a9a5f63e41d7f97d6fd764a

#kernelci issue maestro:213250d577a597f48990eb1ff352c0739cb6a701

--
This is an experimental report format. Please send feedback in!
Talk to us at kernelci@lists.linux.dev

Made with love by the KernelCI team - https://kernelci.org
