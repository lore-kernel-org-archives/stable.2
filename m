Received: from mail-pf1-f177.google.com (mail-pf1-f177.google.com [209.85.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7DE8C3DA5AF
	for <stable@vger.kernel.org>; Fri,  4 Sep 2026 06:59:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788505155; cv=none; b=tgkqLFDhW02vXZHIR10HL6CNeARarm34S0Cabvjpu8y+ft/pu3c5ayFKvHqCgJAg8uxYTzaq/kmbViawWK5BYczGzlgwa3pNOGHCarg1Yf9rNXpDjaqi+l3lz0uXE2HYp4PAVVQejBV6txOLtyzrg7fMWZSMtnSo2pouUZZrQCE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788505155; c=relaxed/simple;
	bh=7UhrGCo6TJyoRbp+mg0jJ6oXTHO/03lnAP9weOg7PY0=;
	h=Content-Type:MIME-Version:Subject:From:To:Cc:Date:Message-ID; b=AsQRNp5jwd4Jbdnt9c8iLeT7doulnitu2lHckMcjBdCwL5/O6cSvmmAHkXcBIDjVeTrKjyNPwJ3V9FfPzssia2CuP7n8pU0i3YDlInH138/60T1vNGbV3/RtEz7SGKeM83apUpgtyaqhQ4luyolK/Z0sbC4zMZpC+BvTVucd0as=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=kernelci.org; spf=pass smtp.mailfrom=kernelci.org; dkim=pass (2048-bit key) header.d=kernelci.org header.i=@kernelci.org header.b=OwHxO10n; arc=none smtp.client-ip=209.85.210.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=kernelci.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernelci.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernelci.org header.i=@kernelci.org header.b="OwHxO10n"
Received: by mail-pf1-f177.google.com with SMTP id d2e1a72fcca58-854f8068301so393449b3a.0
        for <stable@vger.kernel.org>; Thu, 03 Sep 2026 23:59:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci.org; s=google; t=1788505154; x=1789109954; darn=vger.kernel.org;
        h=message-id:date:reply-to:cc:to:from:subject
         :content-transfer-encoding:mime-version:content-type:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=1QUoT8rf3hn9RZvqEGT1zHzpwA8Wtj2UaqfjA5bhsqo=;
        b=OwHxO10nWZPORelVELfvVCO9peuvEAsPIBFDhBBP+AA5SBzmRSgOiHQK4sg/ZyHrWs
         DiM3pAg9Ja4aphCAYl4yCkp5eQLiJAp17lZfMEa7YegvfFlaDZg/d3CDL/1PCKPMPcoc
         3wWcOvn3GCgqno4XyTRQuQCDKiX9xRtx9xOLmHbNSEXm1ahYpzzSQJim7onBmLgSontq
         CbusLxVYi0FBML5g4q87TIrtHon+lXjzEUDWYdS8u6EltCE7NLVLyj7Ni+UE1BAKiXWa
         ODqdPgVP1O9Om9Z4TtB30jRU96T5N6s3XFWHB2SmtAyAjT4L2D6weCrqlFYbDH/dlbyN
         81hA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788505154; x=1789109954;
        h=message-id:date:reply-to:cc:to:from:subject
         :content-transfer-encoding:mime-version:content-type:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=1QUoT8rf3hn9RZvqEGT1zHzpwA8Wtj2UaqfjA5bhsqo=;
        b=BCFEd55Z0lyGs8eUekir5uB5g7tGqJQWlRefTt61y2pDFJb1k+vsSqPQNjF6LupIj+
         eoVRDal4T7MAn6uZwuy14EHXcl+ZPqhYVplRsAs9rSCp5kV4uMtQ3InycY92C4NcwXy5
         Y8RmKlbpQmvkCWIUJjK/ufKe2TTHjKmPLKbgYtV/e/X93VcLIMUSkZF7oSPIBCZXLxs8
         zHJyubWOsfZbFK2GAyVVdFVas5mLhLr9dIqBDyoQodnRyBX1PRCiPhTjrMVYNnqOMZ0N
         ZAvvaDhjoSlG46m72JAPBvBhdm6HInvBIKWR6DHUPOnNg232+3pEvFTL4zlc+hMbD5T5
         I7+w==
X-Gm-Message-State: AFuF++lIFgYlA6GCtE9Y6ouF6D6mLNAVZYc4FWvw3KrX9wLrVIduHv5J
	ufSd0Y178lMwvk1v79XDiiXfTyS8UqMFfD/W+7EiZKYJ4cdotHrSPMpkZS37qa5m1cm2+aurG8I
	C74zq5f0=
X-Gm-Gg: AYBFou23RJx+POBBcGxFJTApKAAt1V0o4WzxU5k+/PqriZHWlg2aMuKzqrdFpErQiMc
	a9LyHfXzD99kYxRPcquG629FcUhproLM1Sx5PZCKPZ0fByxER1KnSOTWG7b/ExXrM5xOom4hh+H
	7174SrWfKFJfS0cb1ElDf/WHvf7SpvRTA/Xf3kdEmeoYVVGc68tX51FWRGGJnEg7ZWMWRNk9qeb
	B+iT7WqVCHzdPPdAYF5GD3KLlkk+ElrJzbT+TWU9CfArg8yZ2JAOg6w/lJ8/3LAFqF6Wd5CY2JR
	+I1Sp15q80iyy7iGOSGORe2ymJ/r/fx7z68Hwa/UkAalzYgx50yoY/fuUvlb1LWP34Zd7sGMspz
	R4z5HQTQjC3GWyAX9f9FfFjJuTcBrJh2pyO4JVdEJAUm4RdArA9JbYAX3OfKW+0f6U/qJIlnh9z
	u46/bWWEZ2D1Eg59aruoY8xcQEgUHRs1rkxM0/fUnz06lhB/fArP+t
X-Received: by 2002:a05:6a21:2291:b0:3d0:88f5:f812 with SMTP id adf61e73a8af0-3da39d147e0mr6219455637.10.1788505153754;
        Thu, 03 Sep 2026 23:59:13 -0700 (PDT)
Received: from 41049dfc76e5 ([20.38.40.137])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-3339b8f787esm3878125eec.23.2026.09.03.23.59.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 03 Sep 2026 23:59:13 -0700 (PDT)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: 
 =?utf-8?q?=5BREGRESSION=5D_stable-rc/linux-5=2E15=2Ey=3A_=28build=29implicit?=
 =?utf-8?q?_declaration_of_function_=E2=80=98put=5Funaligned=5Fle16=E2=80=99?=
 =?utf-8?q?_=5B-Werror=3Dimpl=2E=2E=2E?=
From: KernelCI bot <bot@kernelci.org>
To: kernelci-results@groups.io
Cc: stable@vger.kernel.org
Reply-To: kernelci@lists.linux.dev
Date: Fri, 04 Sep 2026 06:59:13 -0000
Message-ID: <178850515244.887.3444376375023736219@kernelci.org>

New build issue found on stable-rc/linux-5.15.y:

---
implicit declaration of function ‘put_unaligned_le16’ [-Werror=implicit-function-declaration] in drivers/pci/pci-sysfs.o (drivers/pci/pci-sysfs.c) [logspec:kbuild,kbuild.compiler.error]
---

Log excerpt:
=====================================================
/tmp/kci/linux/drivers/pci/pci-sysfs.c:915:17: error: implicit declaration of function ‘put_unaligned_le16’ [-Werror=implicit-function-declaration]
  915 |                 put_unaligned_le16(*(u16 *)&val, buf);
      |                 ^~~~~~~~~~~~~~~~~~
/tmp/kci/linux/drivers/pci/pci-sysfs.c:918:17: error: implicit declaration of function ‘put_unaligned_le32’ [-Werror=implicit-function-declaration]
  918 |                 put_unaligned_le32(val, buf);
      |                 ^~~~~~~~~~~~~~~~~~
/tmp/kci/linux/drivers/pci/pci-sysfs.c: In function ‘pci_write_legacy_io’:
/tmp/kci/linux/drivers/pci/pci-sysfs.c:950:23: error: implicit declaration of function ‘get_unaligned_le16’; did you mean ‘get_unalign_ctl’? [-Werror=implicit-function-declaration]
  950 |                 val = get_unaligned_le16(buf);
      |                       ^~~~~~~~~~~~~~~~~~
      |                       get_unalign_ctl
/tmp/kci/linux/drivers/pci/pci-sysfs.c:953:23: error: implicit declaration of function ‘get_unaligned_le32’; did you mean ‘get_unalign_ctl’? [-Werror=implicit-function-declaration]
  953 |                 val = get_unaligned_le32(buf);
      |                       ^~~~~~~~~~~~~~~~~~
      |                       get_unalign_ctl
cc1: some warnings being treated as errors

=====================================================

When fixing this issue, please attribute this report according to the
patch submission rules:

Reported-by: kernelci.org bot <bot@kernelci.org>

For complete logs and details about the environment used, see the issue
on the KernelCI dashboard:

- dashboard: https://d.kernelci.org/i/maestro:ef78acc1fe7f81c99c7ff09fa07720fe9a5d29ab
- giturl: https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git
- commit HEAD:  deded5764dda984425c73274bfbd0d2c951d26f5

# Builds where the incident occurred:

## ppc64le_defconfig on (powerpc):
- compiler: gcc-14
- config: None
- dashboard: https://d.kernelci.org/build/maestro:6a9a5dc4e41d7f97d6fd72ab

#kernelci issue maestro:ef78acc1fe7f81c99c7ff09fa07720fe9a5d29ab

--
This is an experimental report format. Please send feedback in!
Talk to us at kernelci@lists.linux.dev

Made with love by the KernelCI team - https://kernelci.org
