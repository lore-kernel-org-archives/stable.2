Received: from mail-pf1-f170.google.com (mail-pf1-f170.google.com [209.85.210.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 213A63AFB0C
	for <stable@vger.kernel.org>; Mon, 20 Jul 2026 14:59:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784559548; cv=none; b=aoL43ayWVQ4170yCsEUsO6abUiDeMOBxOG9wW/7LIGp6ILp4sUHNil4ql60kxW0WNJYDyhAQlJJI4MDMVS4gY5YbSXyeoIKK6iq5j5AmQeDx0KR0FbWuwbJicYeSljOBb3xQzdu+dNLVIgOolCs5yeXj1l7xmgVBJsse5YoHiSg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784559548; c=relaxed/simple;
	bh=Fe394zlpx8nT+8W9eMuUDGzXRg0CAQlei56/dMNQhmo=;
	h=Content-Type:MIME-Version:Subject:From:To:Cc:Date:Message-ID; b=fWLf/IMkpRcvkr/XbBbdpGXA4q3+8V+ERX39KgJRxkxtCkV5u8uBKigguTa0SG6GQjt+5FEW/1wlJlizjuALniE2bdFWs9NKqE133XlQifxr5izpnLU3cJe20gZg4BML0eGTdhOv0AevCJ/5FpqWuQsRKQAozGdRz/Z3ErKMucU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=kernelci.org; spf=pass smtp.mailfrom=kernelci.org; dkim=pass (2048-bit key) header.d=kernelci.org header.i=@kernelci.org header.b=FTEFpPvG; arc=none smtp.client-ip=209.85.210.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=kernelci.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernelci.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernelci.org header.i=@kernelci.org header.b="FTEFpPvG"
Received: by mail-pf1-f170.google.com with SMTP id d2e1a72fcca58-84536ecfc5bso6709447b3a.2
        for <stable@vger.kernel.org>; Mon, 20 Jul 2026 07:59:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci.org; s=google; t=1784559546; x=1785164346; darn=vger.kernel.org;
        h=message-id:date:reply-to:cc:to:from:subject
         :content-transfer-encoding:mime-version:content-type:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=QQo1R3D+cKD/ZxJ4cRw1B+/hOAzWuzSzHsW3MiBjO78=;
        b=FTEFpPvGBQm7URAJfsS/zSnK1c/PWiePXGiIGS6xG2bmW1BvQpbj2JpibGNfWnOdiE
         pN8NNWcWGPiSI+nWO/kyAtKcY/6QAwadDTMPRq2okoIiF+Yp5VBQ2hHkzUTUg+N3Cm6n
         P1BCOYwuLBdnYW+AMTjOHLH5mioqJE9W+8MRysnxctIPYtAJrrWGt2Lv/56qHT9L9Ah9
         eOzbdddgEsezfSjkXgAYYiffc/5YrS7E6B3dmpNw1EAkovXuayYf5OdQRlCwrIeAQK8j
         kjVKLwJBrmsHdwRBrZx1kwTeOr4z0OhPXlUuMy6GdV6YkG6bktArztWWcCgFK6EvvlB+
         vHhQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784559546; x=1785164346;
        h=message-id:date:reply-to:cc:to:from:subject
         :content-transfer-encoding:mime-version:content-type:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=QQo1R3D+cKD/ZxJ4cRw1B+/hOAzWuzSzHsW3MiBjO78=;
        b=N1vM4FEfOc3H8mrXeEzwbFMo6xcFhUwpBWfgE5o0zpZQUeXCKsZwQdDwOFF7CIMx3f
         xn8tSvdCmruUI4rKM1wbmDe4E57ned/OtIi7/W+Epnw8fQxCnK/CEbXdPaK+kJjCHTyZ
         kPJ6PilXgWlrWMccaBa0afJmgpcPOXYlmbOKNE9z7Omx7mGHn87m46GcRQTb4RUJTkZi
         Y0Q9arPIeaqJsgANTdJ5wdVk5tvQa5GxLL2ri0XlMXPebfcZgPc3h/toGlZO46ucc3wp
         6+5BhTxwO0tGJZBvcuXxpl+KyhIozd9veXSbMcgpjtYuJDTGjtwAnau+rfESWbFJsj/m
         ah4w==
X-Gm-Message-State: AOJu0YxsD/lqHv3Xp3d3oZikidHjbkAXmjYPkmPNslg5/vjE25Fz5xOm
	F7uQwnlDJNhEG7/VJdnctkI0LpZScvudvrk8lbNR0N0BRezJAynsuJvelB+rKsr8gvzN93A3ysK
	ZeqE7
X-Gm-Gg: AfdE7cm/wEtMHakSlG/W+fSwo0hcN1fBrz5kFCg+DLEA3rfk35u4YRLI74gNC2vz4vl
	sCJB6t+UazrdLdQpvgOyrTpheep/FXgfyfszhY10d6YTcgKYmJiBcif+uA4YvXS6D74Ix/UkSdG
	UUj1P2tku6Od+wrboSI3Fkin+4TkJoX8biyfBSdi/ilCQs83kPg/SNyaWN+0sA4r2lVNBUc2zq3
	Vbd2hn6bvhNFYMsl/qgqRzsPmCfxpqIHmbXMpuDy6WQ1ZbXM6I9LHGpVcR0qRLbbwx5i48Rb/yL
	VaQPywlT4SYh+QiWbOhL5Ae8+OJkaB2CxLJssbn3z5TGLWxj6COycmvW2GXtQH9gSwEHg115Bzk
	hMXJByXY0ZEUnv/UG3mkx+m0Wjn2nEm8D/pF3bgCKu0/SIoh00np/b25C++wRtfuMf1cInPw=
X-Received: by 2002:a05:6a21:9206:b0:3c3:a9ad:a747 with SMTP id adf61e73a8af0-3c3ad7f47cbmr16354417637.26.1784559546335;
        Mon, 20 Jul 2026 07:59:06 -0700 (PDT)
Received: from 963b246bc1b3 ([20.38.40.137])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-3142a1dde81sm64717141eec.21.2026.07.20.07.59.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 20 Jul 2026 07:59:04 -0700 (PDT)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: 
 =?utf-8?b?W1JFR1JFU1NJT05dIHN0YWJsZS1yYy9saW51eC03LjEueTogKGJ1aWxkKSDigJh2?=
 =?utf-8?b?ZHNvX3N0YXJ04oCZIHVuZGVjbGFyZWQgKGZpcnN0IHVzZSBpbiB0aGlzIGZ1bmN0?=
 =?utf-8?b?aW9uKTsgZGlkIHlvdSBtZWFuLi4u?=
From: KernelCI bot <bot@kernelci.org>
To: kernelci-results@groups.io
Cc: stable@vger.kernel.org
Reply-To: kernelci@lists.linux.dev
Date: Mon, 20 Jul 2026 14:59:04 -0000
Message-ID: <178455954409.13463.336399957099402658@kernelci.org>

New build issue found on stable-rc/linux-7.1.y:

---
 ‘vdso_start’ undeclared (first use in this function); did you mean ‘vfs_stat’? in arch/riscv/kernel/alternative.o (arch/riscv/kernel/alternative.c) [logspec:kbuild,kbuild.compiler.error]
---

Log excerpt:
=====================================================
/tmp/kci/linux/arch/riscv/kernel/alternative.c:207:41: error: ‘vdso_start’ undeclared (first use in this function); did you mean ‘vfs_stat’?
  207 |                 apply_vdso_alternatives(vdso_start);
      |                                         ^~~~~~~~~~
      |                                         vfs_stat
/tmp/kci/linux/arch/riscv/kernel/alternative.c:207:41: note: each undeclared identifier is reported only once for each function it appears in
/tmp/kci/linux/arch/riscv/kernel/alternative.c:210:41: error: ‘vdso_cfi_start’ undeclared (first use in this function)
  210 |                 apply_vdso_alternatives(vdso_cfi_start);
      |                                         ^~~~~~~~~~~~~~

=====================================================

When fixing this issue, please attribute this report according to the
patch submission rules:

Reported-by: kernelci.org bot <bot@kernelci.org>
Link: https://lore.kernel.org/all/178455954409.13463.336399957099402658@kernelci.org/

For complete logs and details about the environment used, see the issue
on the KernelCI dashboard:

- dashboard: https://d.kernelci.org/i/maestro:482d83fda2a85d2639f3d961a3ceed25b20b71a8
- giturl: https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git
- commit HEAD:  4829d3468b16a4febae16a110e897b61ed3095bd

# Builds where the incident occurred:

## nommu_k210_defconfig on (riscv):
- compiler: gcc-14
- config: None
- dashboard: https://d.kernelci.org/build/maestro:6a5e0d693427a5b0fb02352a

#regzbot introduced: 2ae9949ee67292d39e9d29836f648d87c026c450..4829d3468b16a4febae16a110e897b61ed3095bd
#regzbot link: https://d.kernelci.org/i/maestro:482d83fda2a85d2639f3d961a3ceed25b20b71a8

#kernelci issue maestro:482d83fda2a85d2639f3d961a3ceed25b20b71a8

--
This is an experimental report format. Please send feedback in!
Talk to us at kernelci@lists.linux.dev

Made with love by the KernelCI team - https://kernelci.org
