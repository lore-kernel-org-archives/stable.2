Received: from mail-pj1-f53.google.com (mail-pj1-f53.google.com [209.85.216.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 513F4233932
	for <stable@vger.kernel.org>; Wed,  9 Sep 2026 17:59:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788976751; cv=none; b=oQyKqUXqev1/rSVRSY7rTpyVV+3E1iIlYWG31HfpmeZiYYjWOY8gQ9vXwJqnaBC0OH/dsoTvqimZrPmUfc2cxx64degz/GjTYC6UCgQix8dmoSN3BpJ/p0Xe/a5N8JByjiHC8fWpe1ms+79O/TKknyWqXEDIAqClkKX0jYyhALY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788976751; c=relaxed/simple;
	bh=JbAfRA7CvUqmboA/QL3IDJhEsjBbiI+q5Ia+kJu1K0A=;
	h=Content-Type:MIME-Version:Subject:From:To:Cc:Date:Message-ID; b=PfvZ5FJkIotoo7hSwSK48O0RPR5pggehduc3q+nfxi5B5sXkNHoLZ0rENSano7XG89jKrRT0J6we5ZZG/BvfF6msnZwjsLl9hPIw3VUe5minwNf198ISly5l+lTCIUVs8ap6rOd+zIbkd48b3/Ct/tA9xkCz5e3kAunRI1BcWBY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=kernelci.org; spf=pass smtp.mailfrom=kernelci.org; dkim=pass (2048-bit key) header.d=kernelci.org header.i=@kernelci.org header.b=RLVjYNtk; arc=none smtp.client-ip=209.85.216.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=kernelci.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernelci.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernelci.org header.i=@kernelci.org header.b="RLVjYNtk"
Received: by mail-pj1-f53.google.com with SMTP id 98e67ed59e1d1-39b9a99469fso2169083a91.3
        for <stable@vger.kernel.org>; Wed, 09 Sep 2026 10:59:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci.org; s=google; t=1788976748; x=1789581548; darn=vger.kernel.org;
        h=message-id:date:reply-to:cc:to:from:subject
         :content-transfer-encoding:mime-version:content-type:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=9eNd9Lwk53MMreXwJmBAdkr2qB5dQavls6/lmYhi3P0=;
        b=RLVjYNtk9MuIGR4StilYbjgj1Y+yjalJAzbFcMnrmfPTJUyahI722mwCk6n3BozRrH
         dSYUvKLpIAk+SDmnVHDumq4+HhEpQweHk6+aVDy5yj4rkyuXQNAQGraXIbAki9Xj1wej
         vSvaC7t6xPEL5r//1JHVhkXJVncDzVfjkhAkRciIVQzatWaMiDOLLgFVZJ9UMnUa1oWg
         NjUTNAuYNPmkL9FOjmnv0pbeAYVvhSQuMq74eM3wC0/e3kqF7kD0HgzQEh480Hx3ZTk2
         mts5ofUSXUHzw+is94rggd1g9Tdw0Y10wM6dsyIRwmYZdHZaq6+sqLTGfObwBLVH2mhS
         G/Tw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788976748; x=1789581548;
        h=message-id:date:reply-to:cc:to:from:subject
         :content-transfer-encoding:mime-version:content-type:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=9eNd9Lwk53MMreXwJmBAdkr2qB5dQavls6/lmYhi3P0=;
        b=GauGfKS1dFb/aHglA3Q7QVH1kD1ijafGJHEYjZWGlCHcirBGF/pOybN4qjvzXwN17a
         omsz3bcVh0LRzbESOSnVQvHnlxwRYh2RlD+YhzGRF/iahr15rBT7A+XWHg03Xy9NUaIY
         tW6L6QD0fCqF+a82snohb/c8w63on6regSZKVoQQr4ReJZJ+eH2CkuOM4wAEhl8GHlkq
         rBar9Zd2S5/l7K1mOxYOgDcHEgGz47vUoGpilrhD0p/jB1uUxMP2A1zEEvoYQegZW9A6
         BtNVczG0K2BuzOSN8elK1v6HUD7DjYPN/FZjVTYXu0fFqZNcM1RFZ8cGEuza1vlpQzgO
         19+A==
X-Gm-Message-State: AFuF++l5f6QiWyKEOKCsvnqMMgr+m75PYy8FpJaJjh6ikk4XyEt738+B
	cQpLdbqvS4TsGJq64n3kPKaNPVmqdPtPNrgx2Pnnm1miFQKeQbNontUdEmh+YxjYe4Vfhxag8dQ
	YsHj8
X-Gm-Gg: AYBFou28NWKir97Y1aQnRg9F3bOVaDz6Df/JRyQWwLEiqegwAifoky4jgHIZJjLcjHz
	QW/EJ6SA3Ldx5lzm79R2Lce/K+Pkb+xfrwaFGigPBsVlI8ZgylDh61ILbOPFFzrHmK883r7JtRH
	nka+QPPEXyz1p2Kk/o3Yq4sCXUT0/hAlim4lk3teK3m+TLseFEUeEVRnn8zixI1nO8juldVbk4u
	rrOHKgc96HWk9WjF2eD/l16jEdk7AesnZodzCMen3BCffCHVe324TT+JEM2QJ2XA/DCKEMhSJhe
	kZoPpBJpgFD/R8ClueYM5AmTs/u/HDDXo7x2wCuuOQIVfXMz/i8NZ0tPBY3mVYz6F2S2W5iGfPP
	RivBAzy8ozW1SIPa8cEDiW8Rv030wRPe3sbfA5GC8Dg+sVxvvfQy4gKqluFsiIZd1suqQX0dYt2
	ClTTq9qH+gy8iBeyrTO9SZguBWuf0b9bPvxdB6GvggUhQCVLogs/33wLlQ0kBkX+c=
X-Received: by 2002:a17:90b:4fd1:b0:398:bd37:6a49 with SMTP id 98e67ed59e1d1-39b261cfd8cmr54371587a91.12.1788976746861;
        Wed, 09 Sep 2026 10:59:06 -0700 (PDT)
Received: from 41049dfc76e5 ([20.38.40.137])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-334fbd5e6f6sm38478071eec.23.2026.09.09.10.59.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 09 Sep 2026 10:59:05 -0700 (PDT)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Subject: [REGRESSION] stable-rc/linux-6.6.y: (build)call to undeclared library
 function
 'index' with type 'char *(const...
From: KernelCI bot <bot@kernelci.org>
To: kernelci-results@groups.io
Cc: stable@vger.kernel.org
Reply-To: kernelci@lists.linux.dev
Date: Wed, 09 Sep 2026 17:59:05 -0000
Message-ID: <178897674444.3516.14489542062715635576@kernelci.org>

New build issue found on stable-rc/linux-6.6.y:

---
call to undeclared library function 'index' with type 'char *(const char *, int)'; ISO C99 and later do not support implicit function declarations [-Wimplicit-function-declaration] in arch/arm64/kvm/vgic/vgic-v3.o (arch/arm64/kvm/vgic/vgic-v3.c) [logspec:kbuild,kbuild.compiler.error]
---

Log excerpt:
=====================================================
/tmp/kci/linux/arch/arm64/kvm/vgic/vgic-v3.c:406:27: error: call to undeclared library function 'index' with type 'char *(const char *, int)'; ISO C99 and later do not support implicit function declarations [-Wimplicit-function-declaration]
  406 |                 irq = vgic_get_irq(kvm, index);
      |                                         ^
/tmp/kci/linux/arch/arm64/kvm/vgic/vgic-v3.c:406:27: note: include the header <strings.h> or explicitly provide a declaration for 'index'
/tmp/kci/linux/arch/arm64/kvm/vgic/vgic-v3.c:406:32: error: too few arguments to function call, expected 3, have 2
  406 |                 irq = vgic_get_irq(kvm, index);
      |                       ~~~~~~~~~~~~           ^
/tmp/kci/linux/arch/arm64/kvm/vgic/vgic.h:204:18: note: 'vgic_get_irq' declared here
  204 | struct vgic_irq *vgic_get_irq(struct kvm *kvm, struct kvm_vcpu *vcpu,
      |                  ^            ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
  205 |                               u32 intid);
      |                               ~~~~~~~~~
2 errors generated.

=====================================================

When fixing this issue, please attribute this report according to the
patch submission rules:

Reported-by: kernelci.org bot <bot@kernelci.org>

For complete logs and details about the environment used, see the issue
on the KernelCI dashboard:

- dashboard: https://d.kernelci.org/i/maestro:4b4fc4c671572137da420351e118576fc7266d54
- giturl: https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git
- commit HEAD:  f372d2b0a4d6679d02035fc0619f569c8404982d

# Builds where the incident occurred:

## defconfig+allmodconfig on (arm64):
- compiler: clang-21
- config: None
- dashboard: https://d.kernelci.org/build/maestro:6aa16b98e41d7f97d61b225c

#kernelci issue maestro:4b4fc4c671572137da420351e118576fc7266d54

--
This is an experimental report format. Please send feedback in!
Talk to us at kernelci@lists.linux.dev

Made with love by the KernelCI team - https://kernelci.org
