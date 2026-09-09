Received: from mail-pj2-f12.google.com (mail-pj2-f12.google.com [74.125.227.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1CB0657268E
	for <stable@vger.kernel.org>; Wed,  9 Sep 2026 15:59:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.227.140
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788969548; cv=none; b=OJEUs8GknmOC8QQsORNZiukJxsyZG+gvakx41qlWhlsh2ZKtfe/BQJm3PaN2LoL+lpgeaCXc6rxBFXsQOVTVCDUXXUReMYk9GyX0totGeWbZaP2YKwZX1X+YdasiWtdmlVlk382QzEGd49FrifBTf8quenT58px6/eDD8jal8VI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788969548; c=relaxed/simple;
	bh=gBQwiUObHCjswxQqLYufmzRF4dGRW6X6aAwSiz1kGQ0=;
	h=Content-Type:MIME-Version:Subject:From:To:Cc:Date:Message-ID; b=Ma/cy9IK7FxSJ05JwcwgiUBgxhp4N26q5ym0CrUW/j30fjyAm1ifYS0K54BEfU7wpaVkmdEqr8F2r/QP9SGXMDMAxwyuI2xFfW7kJiTIzcjVPNRaiZ8Hi/CU/E+PGBs6DvJqgT6dbCmedKY26YRpc8HYlAlicjy8Fq8XtFQiHNw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=kernelci.org; spf=pass smtp.mailfrom=kernelci.org; dkim=pass (2048-bit key) header.d=kernelci.org header.i=@kernelci.org header.b=J/F6O7Al; arc=none smtp.client-ip=74.125.227.140
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=kernelci.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernelci.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernelci.org header.i=@kernelci.org header.b="J/F6O7Al"
Received: by mail-pj2-f12.google.com with SMTP id d9443c01a7336-2d8fb334e72so12317015ad.1
        for <stable@vger.kernel.org>; Wed, 09 Sep 2026 08:59:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci.org; s=google; t=1788969546; x=1789574346; darn=vger.kernel.org;
        h=message-id:date:reply-to:cc:to:from:subject
         :content-transfer-encoding:mime-version:content-type:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=IWNy7sGDUKXI7Dt9dyb+v5J/5pX3Y+aqgZWJNSwwTfU=;
        b=J/F6O7All4+Duaj4XipJVdW69a1uOUHMJ3cWUWbNdUt/r07HP/83GCEGqj4Tt9stu4
         13Jc2ZFHkQuInB8GT9BVnyqbSCUPeTLQThNFi3MxRAlvPxMoVmEhRIWA0KvdzniCsUa9
         X/PkDTdiH/G46N9sVvQ217OOuhic2p6WakM/wmzsJrPmb5i5sQZV9D6Q1U4wAxz7kFgS
         zgfT+wJsMDrZJtmunZL03WGahRd5Es+6yLeiX6EuXrbFjtI5nTLYhi7s7an/wUNURFs/
         tMT8MqC0tw8Yy+7+pKeiBo1ijW3T9381BPJuq2p85OVC5NSRXy2iSus8E0zZG/fR1jEE
         xlmg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788969546; x=1789574346;
        h=message-id:date:reply-to:cc:to:from:subject
         :content-transfer-encoding:mime-version:content-type:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=IWNy7sGDUKXI7Dt9dyb+v5J/5pX3Y+aqgZWJNSwwTfU=;
        b=ErymmGTjDRJl98/i72fFqagP+yJBHk5xXzfF4KtlKmNmgi8eIps2Ak5fiRTd+cidAg
         tDCUTyR1cZjT9P4UXwBzlPdMVkQ5gzVDeq80W59Cb1D7WOUW0ZuPk33PC6Nb0ev/QBEj
         YqVPsn7zYHQKCOiqdnxJao6d6Ce8ctg5y3jM/q5ylfMJ9uYHrJwNy3llWxyj6LewWOUG
         /tS8zKPaR+kHej/6MpYrN+puoYASP2aAgsJ2nBdkYIvYc9VnYX7dT0Schfyv3lnpfbK7
         sd9Dj9zApyB5rWlkZOR5Dx8uczjD0/Oxqw9w3H29II9Ly/xatbNurMhXf/1ITOFvbZbp
         XlcQ==
X-Gm-Message-State: AFuF++mTVF/r7WGzMa4zjFaFpgpiAzs0uEq1hgG9/8nBaDwTqPrMmC4h
	oQa9Vjf49Wm9WMKl68N+obmK9byKSI26Pzw6oidhfdW5BuIF8iiNqCYg0ZioRhjEQXU=
X-Gm-Gg: AYBFou2wDjZsXtQETZX3rQtFuMRrpKhJLTZ1oiFf4qEGnnuLWbfJm06qKxwAV26pA9y
	M2Y7coFb/InCnU+EYqlDTO1BjBN7A0zPvEjrjtH+K/75WKiZmr6pDAS4lqpwpn0m/7mytX4EnkR
	K+t8Cjp48wlHgvheNCXOVwxNFbxWxa0r50VWIIS7Rc9s0POcvO1a7SaiSoGjYo72wG+DgBLaI+d
	ZnEkbDoJt6x/p2UXymhL+R65OfxN/+z6iVzMdImUjGFO4oIeg2ET6RZxeG/w2EPMmL3wNSLsu84
	t6sW43xcZaJfelEYeKe2SKDJzxSfvSo7SuwuywYoVCnKUKOeOsZH/oSRlOAjvTrxiv3URZixbPk
	kPc+1uKc70xMvgWehSnnUgU2XkdxLTTMyKj+ahYF91yY1K6qqemL8bQej+9zy8yC6sZhovuLD4D
	yQkY+UtZfUtzB7IH7MINEGNYAZE7QrzeQ5j/1nynAXjc9dp4FOGdhJUQAXuYfITCy7
X-Received: by 2002:a17:90b:2e86:b0:398:9be8:ea64 with SMTP id 98e67ed59e1d1-39bac3b0c7emr10174108a91.17.1788969546214;
        Wed, 09 Sep 2026 08:59:06 -0700 (PDT)
Received: from 41049dfc76e5 ([20.38.40.137])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-33987ccf483sm5663477eec.20.2026.09.09.08.59.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 09 Sep 2026 08:59:05 -0700 (PDT)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Subject: [REGRESSION] stable-rc/linux-6.12.y: (build)too few arguments to
 function
 call, expected 3, have 2 in arch/arm6...
From: KernelCI bot <bot@kernelci.org>
To: kernelci-results@groups.io
Cc: stable@vger.kernel.org
Reply-To: kernelci@lists.linux.dev
Date: Wed, 09 Sep 2026 15:59:05 -0000
Message-ID: <178896954493.3480.14842088435118924984@kernelci.org>

New build issue found on stable-rc/linux-6.12.y:

---
too few arguments to function call, expected 3, have 2 in arch/arm64/kvm/vgic/vgic-v3.o (arch/arm64/kvm/vgic/vgic-v3.c) [logspec:kbuild,kbuild.compiler.error]
---

Log excerpt:
=====================================================
/tmp/kci/linux/arch/arm64/kvm/vgic/vgic-v3.c:419:32: error: too few arguments to function call, expected 3, have 2
  419 |                 irq = vgic_get_irq(kvm, index);
      |                       ~~~~~~~~~~~~           ^
/tmp/kci/linux/arch/arm64/kvm/vgic/vgic.h:205:18: note: 'vgic_get_irq' declared here
  205 | struct vgic_irq *vgic_get_irq(struct kvm *kvm, struct kvm_vcpu *vcpu,
      |                  ^            ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
  206 |                               u32 intid);
      |                               ~~~~~~~~~
1 error generated.

=====================================================

When fixing this issue, please attribute this report according to the
patch submission rules:

Reported-by: kernelci.org bot <bot@kernelci.org>

For complete logs and details about the environment used, see the issue
on the KernelCI dashboard:

- dashboard: https://d.kernelci.org/i/maestro:b754fc21ecd3108c08717d4c2c1a695352b31cc0
- giturl: https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git
- commit HEAD:  cd6b5cb26a00de8e1d2e7f19be729928388441ae

# Builds where the incident occurred:

## defconfig+arm64-chromebook+kselftest on (arm64):
- compiler: clang-21
- config: None
- dashboard: https://d.kernelci.org/build/maestro:6aa16c5fe41d7f97d61b26a3

#kernelci issue maestro:b754fc21ecd3108c08717d4c2c1a695352b31cc0

--
This is an experimental report format. Please send feedback in!
Talk to us at kernelci@lists.linux.dev

Made with love by the KernelCI team - https://kernelci.org
