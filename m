Received: from mail-pg1-f175.google.com (mail-pg1-f175.google.com [209.85.215.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 32CF258E2B3
	for <stable@vger.kernel.org>; Wed,  9 Sep 2026 14:59:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788965949; cv=none; b=gPYN8rEQCwCSCAc2I+P2AAxkXrNxlm4f39CpMDUWTqytfsH5YgHq7RqQy/fcFMkW9Gfv2bk4FYIwv7clPO7R477M2xJzbezqJLeOiB2U+DORbnzNIexYy01QsYTc0moBIfuhHBdVxpPutAChgqkA+1AGONos+rv5DrqIGH69A2k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788965949; c=relaxed/simple;
	bh=K+OBkKSCu2GnnPkaZgMd3UDeUXOqmpA7tFD8NPHqPpw=;
	h=Content-Type:MIME-Version:Subject:From:To:Cc:Date:Message-ID; b=a3sa08yz1K6yhdld1N0Xa9nbJPILXFOFX5O2qs6lJLmvdQpp7ZMmdNb7fTyl0DQ471H7pdiHNoHbZLB4P7dhAkYyAPoASxcMmgWSxp9/Y7OKY/aHigRHede/nf21+3/5BZ8nSH7bPDM0a01alPCGOkX/OPZPxFSwceOXJaJJBMA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=kernelci.org; spf=pass smtp.mailfrom=kernelci.org; dkim=pass (2048-bit key) header.d=kernelci.org header.i=@kernelci.org header.b=Vg8Ga8/f; arc=none smtp.client-ip=209.85.215.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=kernelci.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernelci.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernelci.org header.i=@kernelci.org header.b="Vg8Ga8/f"
Received: by mail-pg1-f175.google.com with SMTP id 41be03b00d2f7-cc1cb472b76so4604317a12.0
        for <stable@vger.kernel.org>; Wed, 09 Sep 2026 07:59:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci.org; s=google; t=1788965945; x=1789570745; darn=vger.kernel.org;
        h=message-id:date:reply-to:cc:to:from:subject
         :content-transfer-encoding:mime-version:content-type:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=j4FQ1Lf4wgSUbGxEvksGHs9TGcHkApy5kyDYT44Rr0s=;
        b=Vg8Ga8/fk3gDGqc1pK7wPiMOMnBmAegsRMLPsnfCrpaz3TMFsrLbMpS/fSa7y3+iGF
         78V2GhszqtzaIpBo8Tpp2PVkYoBD/Eo6pTYsobuLcwai8UoWgdjarrdwNUjQPy3ap720
         EA+8f+SIOZh3ihrqGsrgvIHI3t6TiPqXBnuoX9KWQcWQ88vAWLUU5mBHhcbsDzKLQNGB
         jmQ5pGGv2mcUJiukSogdlewB6jye3/rsfnuTV1TVEmhKq9F+AJXoRPZZFfdCkdhvakXB
         U4CrlOgvmtqQvwjkglMMihKYRVmLK/8RSoeGYz0dKhXtlPUtJPlXx2UU6RTUonejRKdV
         P3Ew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788965945; x=1789570745;
        h=message-id:date:reply-to:cc:to:from:subject
         :content-transfer-encoding:mime-version:content-type:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=j4FQ1Lf4wgSUbGxEvksGHs9TGcHkApy5kyDYT44Rr0s=;
        b=h+YIFQJ4rBHw5KXh990fO6Krc9CtIM1/dZcB7jGK8IXz/06piyRn9nZm8iVzuW08yy
         v/qK8xu2ecJ9Evqb2zkfV8i0HmzV+NJQtIU0pKbBM3egs/XAmDnZ0sD50xfcxeiooNC8
         xtaQQ+vlhd+ytPM95Oos5p7/D1vEOyKs9ihzlQv+1eQcZGmPm5foVFqVFTGKshnBP4fo
         fpT14UIdjRcxqlJ3uHqNmG6eKjWtumIGr+hkCXG+VnTembHo7p37yC18w0Xbc9deEAH+
         5YYSVn1nTDzoMbE7kTB/C6gXVAPEsZKRD4VPr7ENf1fT2oFGqd6nCHCqdmmyH+Fypzzh
         CyiA==
X-Gm-Message-State: AFuF++nGnyfXK/nb0ymg63uSHYDuUSMpbzoLbKW8XomJ1zc6BtTn/BP/
	JYmv7ZKDhrj1ZYAcU8H9yi5m+bsP/AWy5ARtBou5QPCgsUYHxdimt0FhVYYcwTJZcmrhuN3Lyf3
	cC+yd
X-Gm-Gg: AYBFou3Zaak3T70tBi0PHGfrdnJW7DcstCwkKOlMj5cgkimq5atL/T00ZZlga4s4lgi
	jRirM0ZwW2DeAD8OBQ30IyX6ghaMUiZjUJ7+zf3XWele8mP9fI5jt71GbwtFGikhGJSHAscR1m/
	M2mbUURMpq5sAX0erEFWoAo4oC4he1OR4GafqbuV6StrjMGij9s/MhSELWeiv4gWTFVurKNTtdg
	DsWB4QLkXId2x/+CJCwfq9k9wOASZoZGjTaPWH8Fb9C6DDkKfGZgeaUaTxOsoy4Q0KWEj43DzoF
	YBzqcUSXJEBAB2sX4P/bc7SG/dtpgKVYc3awUmjLGuYKfTXCQTAXWHB0/R3J/vJ1oIIDuWbQwJT
	MsU+JihgF65jBb4Ln1HRJO/7f0VO6J9NiVOiobG4sjvizwjHiL1/BrH+7Muo0JF/Eb8O5Tu7Duw
	ryFFeTlRyr71wVlEPkl9MW4I0p9FWvetn+XcYmw1Fc9VBsrJMaAt65WCri+mzYC+Dk
X-Received: by 2002:a05:6a20:3ca8:b0:3c4:46ca:334b with SMTP id adf61e73a8af0-3da39cf4744mr54804587637.9.1788965945030;
        Wed, 09 Sep 2026 07:59:05 -0700 (PDT)
Received: from 41049dfc76e5 ([20.38.40.137])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-3339a534df1sm51791291eec.7.2026.09.09.07.59.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 09 Sep 2026 07:59:03 -0700 (PDT)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: 
 =?utf-8?q?=5BREGRESSION=5D_stable-rc/linux-6=2E6=2Ey=3A_=28build=29=E2=80=98?=
 =?utf-8?q?index=E2=80=99_undeclared_=28first_use_in_this_function=29_in_arc?=
 =?utf-8?q?h/arm64/kvm/v=2E=2E=2E?=
From: KernelCI bot <bot@kernelci.org>
To: kernelci-results@groups.io
Cc: stable@vger.kernel.org
Reply-To: kernelci@lists.linux.dev
Date: Wed, 09 Sep 2026 14:59:03 -0000
Message-ID: <178896594310.3462.14164357826786854060@kernelci.org>

New build issue found on stable-rc/linux-6.6.y:

---
‘index’ undeclared (first use in this function) in arch/arm64/kvm/vgic/vgic-v3.o (arch/arm64/kvm/vgic/vgic-v3.c) [logspec:kbuild,kbuild.compiler.error]
---

Log excerpt:
=====================================================
/tmp/kci/linux/arch/arm64/kvm/vgic/vgic-v3.c:406:41: error: ‘index’ undeclared (first use in this function)
  406 |                 irq = vgic_get_irq(kvm, index);
      |                                         ^~~~~
/tmp/kci/linux/arch/arm64/kvm/vgic/vgic-v3.c:406:41: note: each undeclared identifier is reported only once for each function it appears in
/tmp/kci/linux/arch/arm64/kvm/vgic/vgic-v3.c:406:23: error: too few arguments to function ‘vgic_get_irq’; expected 3, have 2
  406 |                 irq = vgic_get_irq(kvm, index);
      |                       ^~~~~~~~~~~~
In file included from /tmp/kci/linux/arch/arm64/kvm/vgic/vgic-v3.c:14:
/tmp/kci/linux/arch/arm64/kvm/vgic/vgic.h:204:18: note: declared here
  204 | struct vgic_irq *vgic_get_irq(struct kvm *kvm, struct kvm_vcpu *vcpu,
      |                  ^~~~~~~~~~~~

=====================================================

When fixing this issue, please attribute this report according to the
patch submission rules:

Reported-by: kernelci.org bot <bot@kernelci.org>

For complete logs and details about the environment used, see the issue
on the KernelCI dashboard:

- dashboard: https://d.kernelci.org/i/maestro:0e0aae90fead98c0782263a4a2ae2b01cdf0363d
- giturl: https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git
- commit HEAD:  f372d2b0a4d6679d02035fc0619f569c8404982d

# Builds where the incident occurred:

## defconfig+arm64-chromebook+kselftest on (arm64):
- compiler: gcc-14
- config: None
- dashboard: https://d.kernelci.org/build/maestro:6aa16befe41d7f97d61b2499

## defconfig+aws-ec2 on (arm64):
- compiler: gcc-15
- config: None
- dashboard: https://d.kernelci.org/build/maestro:6aa16bdee41d7f97d61b2483

## defconfig+netdev+nfs-root-boot+kselftest on (arm64):
- compiler: gcc-14
- config: https://files.kernelci.org/kbuild-gcc-14-arm64-nfsboot-6aa16be2e41d7f97d61b2486/.config
- dashboard: https://d.kernelci.org/build/maestro:6aa16be2e41d7f97d61b2486

#kernelci issue maestro:0e0aae90fead98c0782263a4a2ae2b01cdf0363d

--
This is an experimental report format. Please send feedback in!
Talk to us at kernelci@lists.linux.dev

Made with love by the KernelCI team - https://kernelci.org
