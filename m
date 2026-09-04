Received: from mail-pg1-f174.google.com (mail-pg1-f174.google.com [209.85.215.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 543BB377AB6
	for <stable@vger.kernel.org>; Fri,  4 Sep 2026 06:59:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788505159; cv=none; b=lSSwo1C61X/s287wVTQsXz71TkYBa7GKIAc8NDD2XI87b7QGerBV92P872OShdHD3J6av97kATJ639osAvVjBW6a89dzgJ3SVGIBE/dXI5z92QfHmV7wIfLX20IN7uXtmdY8mQyqRVxuLOP3dPoz/e8Qg+/4nNtj1CbMtYxdmdk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788505159; c=relaxed/simple;
	bh=1ivyFHyI5GeXLnezrxv9NKWb14XNX/q+Mi7QHDIhh6w=;
	h=Content-Type:MIME-Version:Subject:From:To:Cc:Date:Message-ID; b=fCQM4UP2Mtq8rORNi0c62yTGEU/X2bNCXhMdEZXDBMw2L2JQN0lZHQrA8vg7T0J0lTJSp0nO3Z9YHRSkpuq5puAMCC6WuXy4mHUZ1FjGmQwnXrC7D7TOjch0xrpo6PUWORuIQth61P0nSuNyyG6Gkpw8iiNZ4PxX/+8p5mmFrPU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=kernelci.org; spf=pass smtp.mailfrom=kernelci.org; dkim=pass (2048-bit key) header.d=kernelci.org header.i=@kernelci.org header.b=bgo7nvYy; arc=none smtp.client-ip=209.85.215.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=kernelci.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernelci.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernelci.org header.i=@kernelci.org header.b="bgo7nvYy"
Received: by mail-pg1-f174.google.com with SMTP id 41be03b00d2f7-cc1d57602e8so715115a12.3
        for <stable@vger.kernel.org>; Thu, 03 Sep 2026 23:59:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci.org; s=google; t=1788505157; x=1789109957; darn=vger.kernel.org;
        h=message-id:date:reply-to:cc:to:from:subject
         :content-transfer-encoding:mime-version:content-type:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=9j+di7PwoHDlYj5ykzQrp8EKEuntXVjEfdcqzQ2J66s=;
        b=bgo7nvYyLQkD92rG/S8NtN9Qf5miUyMVdfDayahAXpFh65IklbejWw+tfWXCtT3kft
         bcAvEJagREhnpYWOWQXRFkHhXOO5BstZXWgjBkBPjBcvvDCN7h9Ak+MLxttTD0/BTb7W
         46Nv5f0Z4GoBum1HNU//bZdLe6iTv5/y1GOSS1wwayvBTekNP1PxNV0ca9iCtHLdAmcj
         A7f/sH9cbqwqyosV+IvqosT4yDaGN0R9qBBFSm084HELI2PyoO0GFV/uIEtFvjWm2dSS
         m0ZBODfi1SwD9WTA9DkWRpSgGhU6af3NcZmAYqgqBYp+sb7xXzDc3kSSG+7n6IcDOpT6
         TfUQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788505157; x=1789109957;
        h=message-id:date:reply-to:cc:to:from:subject
         :content-transfer-encoding:mime-version:content-type:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=9j+di7PwoHDlYj5ykzQrp8EKEuntXVjEfdcqzQ2J66s=;
        b=BQ5/Fc2iWbZRey0NqAp+4MJpa/8QA/jnnFxz312RMEKJPcul4TWXYcAXHfg7sF9m5J
         68Dl4pjgdzs0bdSMbrUp4RbLC4aKbhXlOdGJa3Xtm7hH4Y1Dm637t+IY3qR/MGNmlPyq
         XL9eyfQkvVTKqJO3FhQ1CMtVbN3t0beCVqURryAyM2Us1nmbNtuJ1Klxlq/FJl4++xmC
         UixO5p6hfqRKAfWiF6WaqIQReZ7cJwGDhDXDm/dQF/R5qDq4mQs3SvfJTgVkdkMLRwmX
         0ErmvbEN5XYU4Aw9Qi0AXQAsQQC8CRiG9jiaA3+wDFFQA8eCrQMLTcQVEpn3jz6T2r7g
         M/8A==
X-Gm-Message-State: AFuF++mBP9wVpvYqsttvO76JdCFQKaam2s+z0eE2cMfLoDn73yOGth4+
	kZ5BkSela1OPZHehdRJ+YZTBt8CpOA8+IxzeHzFyUueg2b1B4kqZWwU8n2A5H8BTh+w=
X-Gm-Gg: AYBFou2E+X5rYXX66GC43tvq4OBGcG5vZ/3niO/J4Lt3z72uXCzUted0e1IGXPpoElA
	qYx6THlg7dVFur7POZd73CdDUj6H/4aon+hWuKucJqNVFQvFdXOO+vjwStfSeBJoXpZdVx6qkEO
	fnYQ+ma0fKR6ShHg95J6YOpphCYlCBC3DRM/7wGuD9jgXJ/j59iLgIbmBjzyhn76QewPUKd2wLf
	skt8ygRzmDGLNmSQjlbtAkCsjOCIAd+3mjnXQ3Whi5Wv76Nk3c1jruvYHG0bxSrZUQ/J698zQ34
	qDGeEaN2IJt9ZAMc6b+yZnM1XHa+3oiuj1K9gO69qX/sNfojXyR5jNcvewaP+Ql8f0f1KNHVUZa
	thBsOzgEhuDy0blpABsFGrpsuC5ZtqjBXRTqIjx9pV8teB9fWCouBetzkag8yJkcWdDCv0tntJA
	+R1k2B0INmhT16oo5+KIHHqOUjGIsRHypXQTDkmLMWbtnDOp6A63wHQLRa6F1NZNU=
X-Received: by 2002:a05:6a20:3ca8:b0:3c4:46ca:334b with SMTP id adf61e73a8af0-3da39cf4744mr6092021637.9.1788505156273;
        Thu, 03 Sep 2026 23:59:16 -0700 (PDT)
Received: from 41049dfc76e5 ([20.38.40.137])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-3339a534d25sm4391767eec.5.2026.09.03.23.59.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 03 Sep 2026 23:59:15 -0700 (PDT)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: 
 =?utf-8?q?=5BREGRESSION=5D_stable-rc/linux-5=2E10=2Ey=3A_=28build=29implicit?=
 =?utf-8?q?_declaration_of_function_=E2=80=98put=5Funaligned=5Fle16=E2=80=99?=
 =?utf-8?q?_=5B-Werror=3Dimpl=2E=2E=2E?=
From: KernelCI bot <bot@kernelci.org>
To: kernelci-results@groups.io
Cc: stable@vger.kernel.org
Reply-To: kernelci@lists.linux.dev
Date: Fri, 04 Sep 2026 06:59:15 -0000
Message-ID: <178850515502.887.10241922684330722879@kernelci.org>

New build issue found on stable-rc/linux-5.10.y:

---
implicit declaration of function ‘put_unaligned_le16’ [-Werror=implicit-function-declaration] in drivers/pci/pci-sysfs.o (drivers/pci/pci-sysfs.c) [logspec:kbuild,kbuild.compiler.error]
---

Log excerpt:
=====================================================
/tmp/kci/linux/drivers/pci/pci-sysfs.c:887:17: error: implicit declaration of function ‘put_unaligned_le16’ [-Werror=implicit-function-declaration]
  887 |                 put_unaligned_le16(*(u16 *)&val, buf);
      |                 ^~~~~~~~~~~~~~~~~~
/tmp/kci/linux/drivers/pci/pci-sysfs.c:890:17: error: implicit declaration of function ‘put_unaligned_le32’ [-Werror=implicit-function-declaration]
  890 |                 put_unaligned_le32(val, buf);
      |                 ^~~~~~~~~~~~~~~~~~
/tmp/kci/linux/drivers/pci/pci-sysfs.c: In function ‘pci_write_legacy_io’:
/tmp/kci/linux/drivers/pci/pci-sysfs.c:922:23: error: implicit declaration of function ‘get_unaligned_le16’; did you mean ‘get_unalign_ctl’? [-Werror=implicit-function-declaration]
  922 |                 val = get_unaligned_le16(buf);
      |                       ^~~~~~~~~~~~~~~~~~
      |                       get_unalign_ctl
/tmp/kci/linux/drivers/pci/pci-sysfs.c:925:23: error: implicit declaration of function ‘get_unaligned_le32’; did you mean ‘get_unalign_ctl’? [-Werror=implicit-function-declaration]
  925 |                 val = get_unaligned_le32(buf);
      |                       ^~~~~~~~~~~~~~~~~~
      |                       get_unalign_ctl
cc1: some warnings being treated as errors

=====================================================

When fixing this issue, please attribute this report according to the
patch submission rules:

Reported-by: kernelci.org bot <bot@kernelci.org>

For complete logs and details about the environment used, see the issue
on the KernelCI dashboard:

- dashboard: https://d.kernelci.org/i/maestro:1ce528eff43e511bde656e686058bf44907b8d46
- giturl: https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git
- commit HEAD:  2b07654b68968d4dd0b6e68a6c8d7fdf199666ee

# Builds where the incident occurred:

## ppc64le_defconfig on (powerpc):
- compiler: gcc-14
- config: None
- dashboard: https://d.kernelci.org/build/maestro:6a9a5d3ae41d7f97d6fd6ddc

#kernelci issue maestro:1ce528eff43e511bde656e686058bf44907b8d46

--
This is an experimental report format. Please send feedback in!
Talk to us at kernelci@lists.linux.dev

Made with love by the KernelCI team - https://kernelci.org
