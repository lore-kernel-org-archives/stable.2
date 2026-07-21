Received: from mail-pg1-f169.google.com (mail-pg1-f169.google.com [209.85.215.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C171B415F10
	for <stable@vger.kernel.org>; Tue, 21 Jul 2026 22:59:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784674748; cv=none; b=cnhOXDjsjvOEF4G3Esyms15Q+VagHKvInp5StvjwM4PFj6M0B0FQHSXMND/Wo/bnzMqhHJ1tn7VBNjFzKEXJylG4ugmhhlN+hzhOpGuTno1e99my3cjfMdALdHnwFsdyO3+cty20RwXEYuFTkbGJRLWc+oxnAALQl2YfK1LcXJ4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784674748; c=relaxed/simple;
	bh=yPPyhKdCmE6QGc8yrkOxHItAfXWR84CUk3qi2UMfV0E=;
	h=Content-Type:MIME-Version:Subject:From:To:Cc:Date:Message-ID; b=N7WOb8lCZ6fGZQGQRuofkzPUAoibgsySzWSUCB95A2igxbrkkTqEtEt5UB+HbbqgJG5kZWxdXAscWjh/nwcBzKc4HSV+pfUZHMC5Dkfo8lgnoIsKsQm86c/QBJEHR29OS39sA0UyrB4iX+rwQPyw2Na9oF/JANA64aFMRpjoWMQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=kernelci.org; spf=pass smtp.mailfrom=kernelci.org; dkim=pass (2048-bit key) header.d=kernelci.org header.i=@kernelci.org header.b=b32WMjS0; arc=none smtp.client-ip=209.85.215.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=kernelci.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernelci.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernelci.org header.i=@kernelci.org header.b="b32WMjS0"
Received: by mail-pg1-f169.google.com with SMTP id 41be03b00d2f7-ca2fad0ae38so9248357a12.3
        for <stable@vger.kernel.org>; Tue, 21 Jul 2026 15:59:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci.org; s=google; t=1784674746; x=1785279546; darn=vger.kernel.org;
        h=message-id:date:reply-to:cc:to:from:subject
         :content-transfer-encoding:mime-version:content-type:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=OVahHf6G4xrG16gxb2iCfC9LNdMI7+OUtN8GR2ILZU4=;
        b=b32WMjS0hPzSKRWY+3bhkfTKjHQqtNcjOjGtG7HLGcUZx6BU8ZmFpZIkopH0UZRmbP
         06aOTiYG56Iuk0plH9PnmYH65gR+vwofyz1iAn1EzUXdMRv+QVtxUtjgEviSxtToPbbd
         aSKfk+CUmZToX+mmT/7H+rfUCVa7Onz+lg/WaVe/zjo9V12Pyl2rh67MAHDiUaeCNfKC
         ievXyYYBwvfdAjGjnGdadxIGRa1xA7PAJ+yaYqsqQ9g5C4oF8OS4/czsNj1yuhljFSuq
         qf5FjQ4rNEWuVQAnm2/5rA96fW4Ml3Ccul4eF2hKeAjlxnd1Omk98Zg6WdHvgUXIpJl8
         rf8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784674746; x=1785279546;
        h=message-id:date:reply-to:cc:to:from:subject
         :content-transfer-encoding:mime-version:content-type:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=OVahHf6G4xrG16gxb2iCfC9LNdMI7+OUtN8GR2ILZU4=;
        b=ckjJXH4o8wzb049JgkMc1E28e1p+0Ux3Hy5gmrowGuulIJVTqH4TCF0b1UtVLu+txz
         k7QJ23xJ1PtHkSEaET0v38Su0qygYHq4tfpGIm0/VhkzQSGo8tWhV+10U35M9gyQYpO7
         3pGx/UFsSyi0AXYnW1i/uxdyOtlpZ3vFNDF9WuVOG9AlxaXtGFoRLeUrIoreCOsJzRz3
         Ar3DhMEjGU+ehB9gvqbm4PfLbUHcl+RHSrdgnc4k8dETlsWjKONqQJ7r3Ik6Uham1X6b
         gGfYeWCnmu8pW+VW//VZHAe5BSEYlEkENerXCxHsGo76jviQ6EI24dgj3wjKyiiPU076
         N/nA==
X-Gm-Message-State: AOJu0YxS8ft54cE9RXisxXer0JduCg9gpTjRyFZqb6EtYPWThgONYDBp
	0kljnv5wVQWDqcDaef9qoWUILINV6y64d6oEvfezWbUAZLvWdgbTcxCdAPenl24+nvco1FfA4MW
	QW6wX
X-Gm-Gg: AR+sD13VyaCrZWkzXjyWSQu8wcsrQbRbQqbCPGMcp2ONM1pcR5fwnLnv0ZEoTJUIYxi
	2WeYtsRB1+LB7PmMI8ePAE+4pxd1b3mF1ejxXQVU8Nw19+IqzIjDZIjVFFHHCCgZrLVpx0+ZKj/
	33EzzjONyhurL7LOlzkKLDy887ik5Uh8Z15PFfvm3GG4EniUSd6GAQszxkxe64ig4HWlqKx5mX3
	mT8V+5vKRXBvKW2qFmUTvtRgewWa9D0/HoVi2QYSGGX6q4gLlVSCfMKLm2upKdVLEZTKw9dvQHF
	OIVfj0T3tmg67dCClPXNIDScX2W+6++d6Nj148zueXrjRGIK3g102AVynUYnXxC0cQX2EvzQsXx
	wqZTR5SfqW50C4HoEXDX8Nn83xU69aZ7lAKD/bwXZxAzJS1i9otSISnILKhwGOweQJ604Rrw=
X-Received: by 2002:a05:6a20:2583:b0:3bf:6222:2e7e with SMTP id adf61e73a8af0-3c3ad601a5cmr22333811637.4.1784674746087;
        Tue, 21 Jul 2026 15:59:06 -0700 (PDT)
Received: from 4104846f2ebf ([20.38.40.137])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-3147e0818e4sm2495128eec.22.2026.07.21.15.59.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 21 Jul 2026 15:59:05 -0700 (PDT)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Subject: [REGRESSION] stable-rc/linux-5.15.y: (build) mixing declarations and
 code is a
 C99 extension [-Werror,-Wdeclara...
From: KernelCI bot <bot@kernelci.org>
To: kernelci-results@groups.io
Cc: stable@vger.kernel.org
Reply-To: kernelci@lists.linux.dev
Date: Tue, 21 Jul 2026 22:59:04 -0000
Message-ID: <178467474395.1334.6033734617150761914@kernelci.org>

New build issue found on stable-rc/linux-5.15.y:

---
 mixing declarations and code is a C99 extension [-Werror,-Wdeclaration-after-statement] in arch/arm64/kvm/vgic/vgic-its.o (arch/arm64/kvm/vgic/vgic-its.c) [logspec:kbuild,kbuild.compiler.error]
---

Log excerpt:
=====================================================
/tmp/kci/linux/arch/arm64/kvm/vgic/vgic-its.c:716:2: error: mixing declarations and code is a C99 extension [-Werror,-Wdeclaration-after-statement]
  716 |         guard(srcu)(&kvm->srcu);
      |         ^
/tmp/kci/linux/include/linux/cleanup.h:109:15: note: expanded from macro 'guard'
  109 |         CLASS(_name, __UNIQUE_ID(guard))
      |                      ^
/tmp/kci/linux/include/linux/compiler-clang.h:20:29: note: expanded from macro '__UNIQUE_ID'
   20 | #define __UNIQUE_ID(prefix) __PASTE(__PASTE(__UNIQUE_ID_, prefix), __COUNTER__)
      |                             ^
/tmp/kci/linux/include/linux/compiler_types.h:60:22: note: expanded from macro '__PASTE'
   60 | #define __PASTE(a,b) ___PASTE(a,b)
      |                      ^
/tmp/kci/linux/include/linux/compiler_types.h:59:23: note: expanded from macro '___PASTE'
   59 | #define ___PASTE(a,b) a##b
      |                       ^
<scratch space>:133:1: note: expanded from here
  133 | __UNIQUE_ID_guard463
      | ^
1 error generated.

=====================================================

When fixing this issue, please attribute this report according to the
patch submission rules:

Reported-by: kernelci.org bot <bot@kernelci.org>

For complete logs and details about the environment used, see the issue
on the KernelCI dashboard:

- dashboard: https://d.kernelci.org/i/maestro:501da437b2af08f7b75636c19b2a7543fcc11ea8
- giturl: https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git
- commit HEAD:  84542dc850e7585c7955126241840610f34ecb08

# Builds where the incident occurred:

## defconfig+allmodconfig on (arm64):
- compiler: clang-21
- config: None
- dashboard: https://d.kernelci.org/build/maestro:6a5f8d1075cb84fb216ed766

#kernelci issue maestro:501da437b2af08f7b75636c19b2a7543fcc11ea8

--
This is an experimental report format. Please send feedback in!
Talk to us at kernelci@lists.linux.dev

Made with love by the KernelCI team - https://kernelci.org
