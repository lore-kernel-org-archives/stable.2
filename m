Received: from mail-pj1-f48.google.com (mail-pj1-f48.google.com [209.85.216.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E260656E06A
	for <stable@vger.kernel.org>; Wed,  9 Sep 2026 14:59:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788965949; cv=none; b=BbhCvXvUtkrINWwhM2pW0KoG4dc2C5J8H2a+nO6Xd53EuYo9QclUtEesVnEa8QLpM+A3jSxIIs58AGYSD2LG+gCA5yimJJmGf1JBpKLfdEA1IX2ciDVlNyS5QvP2cczVB5B7ZvB2H5zHwH6el4SP98yTls5FfzD7Yl/hUw3/HOM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788965949; c=relaxed/simple;
	bh=Dirj4iBugy8XyBCZEgf7nM754iFc3uQ6mJhu1T26A2s=;
	h=Content-Type:MIME-Version:Subject:From:To:Cc:Date:Message-ID; b=oLU3z2RLByYxdWYH/IRqDTS1xxvNjkX5+awnY5jyaul/5MYQ7pHxwdMKYTI63BiiedxHwTsVCYNuwiKTxmxYcMqUmwt8aIzLSS6M+m/jKU8lFf9EHB7bwLnEe9wz7vYtyC+nnAtgwJKpvftev7nVwg0OxZKTUbksQhaQcVe1XEw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=kernelci.org; spf=pass smtp.mailfrom=kernelci.org; dkim=pass (2048-bit key) header.d=kernelci.org header.i=@kernelci.org header.b=KY+HqyZa; arc=none smtp.client-ip=209.85.216.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=kernelci.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernelci.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernelci.org header.i=@kernelci.org header.b="KY+HqyZa"
Received: by mail-pj1-f48.google.com with SMTP id 98e67ed59e1d1-398b3c37877so5615617a91.0
        for <stable@vger.kernel.org>; Wed, 09 Sep 2026 07:59:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci.org; s=google; t=1788965947; x=1789570747; darn=vger.kernel.org;
        h=message-id:date:reply-to:cc:to:from:subject
         :content-transfer-encoding:mime-version:content-type:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=us9ik9rh6SHjIh/pKE1zxa+8Uu7d5v0RcD2yQ5s9OKE=;
        b=KY+HqyZaEnwo52vqiIWaEHH2snidQEiGNw9P+PjmOx/VWKAp+ID/0zUR2xbRErGaOE
         1fRhB4aDpqIpwnBcWnFQ+/JSVu6dF8aVHrdSIVf8y1AdDaCjFrG/8Qj3AuN1w0V/EN6O
         ZfG9A/p8atdGK02ZXsQ/PY2D3dqERVXMASA8mziEGKfk8TtvT+eLHtZdcyQFv9/cCldc
         t5y52h2nMMxQtIiiMWa4RkvT0ld0SWZf7sCaIt3fXSu2Rhknjl+jDSl7fGsPDI+qprvG
         9X3+57FWhsZ66zn9pQ3M0mFn0wnSDQjMPJ7cOatqDQMr7sV1shSzBjnSfujIuOZfoPxl
         NUMA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788965947; x=1789570747;
        h=message-id:date:reply-to:cc:to:from:subject
         :content-transfer-encoding:mime-version:content-type:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=us9ik9rh6SHjIh/pKE1zxa+8Uu7d5v0RcD2yQ5s9OKE=;
        b=VHqTfO5MUTLiwVGzl+jZmZVpICERtDh9KZCtT4F6e2bfilQtw0Mf7UG0V3gaz+k9FT
         Nw6UCQ8uzWiw9+xinOqkV02zj/5FBmPDhZRib+wtclLyuKOytlPFBfvK6h5kThn3O6FB
         jjxEQ0Lq5eVEZGjfmd/Qq3H7yhlzldwa5hUKVXU7I/36K1jBsOCdmBd6TREOvE3sG8xl
         aJkpq5RU6BGc6sgNyPs8nZye6LXOITq6tXcF7pXJM0Dki0PP/Lxh199OK9p+XS6qESa2
         MVzn89px0hLmmuT73fGIpy2EKev+VG8DlZwYeEAuUVEUWkm2M0y2IPCPotl/YCP+vQwU
         pJDg==
X-Gm-Message-State: AFuF++lkPHCLq97uvOwtAWjeab29czICiw3tvfvssNEfcD9y7GfJFLkT
	ZWMw0DbJ5TTcJKTJ95QRR4M6c55DgxrVBDduYrOW7y5xez1XJzDWrnS5krgaGjWvK0QiAnhviZu
	OOgDf
X-Gm-Gg: AYBFou1bWd8MTvnFIubSmZK07+CCLV9XKHOvceexvL91WeGlyWoAsBdr2xs5AAEMPrU
	59YbCCLKqDvq+c+RkkPhrKu3hCzqy6KU3WREmZePm5cf02n2DMx+OnJzRaYyhNdcJxqTpS337t2
	vnR7GMIxCY6E9hvCYJIFNtCmsh792JF1PRZmwxOrEZhgecN7XvTN9XkhijzCQVD3Fq+Is2FLSFl
	gU7uJ9iL4gXrVkZndJ83rT8SkvHmyHlui9VrNXV9Kv60fd8ItmPlM6zdfO26Fd1Kr8+Rz9E6XNG
	gFmsSHmd1ztdedMLedbjvmgph2qWQI66ovjUiTN9xOno+Vg6lYZp6bOJml6/qG39DehtIUAVEk0
	C7tSBDe+DanJqk33zZrMmYxhO7IByV3nHzqbiUcnnXAIPerVFVrZVR7kAkEI5LITjFPToeNJGP3
	fXzLQviiDM6EzDeO0tbJjQCvWBhaJGIH6Eqmdp4DJb2s/ojoB/S8Uy9BxQ9LJ39ks=
X-Received: by 2002:a17:90a:d2c6:b0:395:4de4:92c7 with SMTP id 98e67ed59e1d1-39b260d2f07mr53882315a91.3.1788965946724;
        Wed, 09 Sep 2026 07:59:06 -0700 (PDT)
Received: from 41049dfc76e5 ([20.38.40.137])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-3339b314cfcsm44860843eec.19.2026.09.09.07.59.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 09 Sep 2026 07:59:06 -0700 (PDT)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: 
 =?utf-8?q?=5BREGRESSION=5D_stable-rc/linux-6=2E12=2Ey=3A_=28build=29passing_?=
 =?utf-8?q?argument_2_of_=E2=80=98vgic=5Fget=5Firq=E2=80=99_makes_pointer_fr?=
 =?utf-8?q?om_integer_wit=2E=2E=2E?=
From: KernelCI bot <bot@kernelci.org>
To: kernelci-results@groups.io
Cc: stable@vger.kernel.org
Reply-To: kernelci@lists.linux.dev
Date: Wed, 09 Sep 2026 14:59:05 -0000
Message-ID: <178896594524.3462.12406575323642365551@kernelci.org>

New build issue found on stable-rc/linux-6.12.y:

---
passing argument 2 of ‘vgic_get_irq’ makes pointer from integer without a cast [-Wint-conversion] in arch/arm64/kvm/vgic/vgic-v3.o (arch/arm64/kvm/vgic/vgic-v3.c) [logspec:kbuild,kbuild.compiler.error]
---

Log excerpt:
=====================================================
/tmp/kci/linux/arch/arm64/kvm/vgic/vgic-v3.c:419:41: error: passing argument 2 of ‘vgic_get_irq’ makes pointer from integer without a cast [-Wint-conversion]
  419 |                 irq = vgic_get_irq(kvm, index);
      |                                         ^~~~~
      |                                         |
      |                                         long unsigned int
In file included from /tmp/kci/linux/arch/arm64/kvm/vgic/vgic-v3.c:14:
/tmp/kci/linux/arch/arm64/kvm/vgic/vgic.h:205:65: note: expected ‘struct kvm_vcpu *’ but argument is of type ‘long unsigned int’
  205 | struct vgic_irq *vgic_get_irq(struct kvm *kvm, struct kvm_vcpu *vcpu,
      |                                                ~~~~~~~~~~~~~~~~~^~~~
/tmp/kci/linux/arch/arm64/kvm/vgic/vgic-v3.c:419:23: error: too few arguments to function ‘vgic_get_irq’
  419 |                 irq = vgic_get_irq(kvm, index);
      |                       ^~~~~~~~~~~~
/tmp/kci/linux/arch/arm64/kvm/vgic/vgic.h:205:18: note: declared here
  205 | struct vgic_irq *vgic_get_irq(struct kvm *kvm, struct kvm_vcpu *vcpu,
      |                  ^~~~~~~~~~~~

=====================================================

When fixing this issue, please attribute this report according to the
patch submission rules:

Reported-by: kernelci.org bot <bot@kernelci.org>

For complete logs and details about the environment used, see the issue
on the KernelCI dashboard:

- dashboard: https://d.kernelci.org/i/maestro:e559f72e88347198a2cfd9c9c88a749433094738
- giturl: https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git
- commit HEAD:  cd6b5cb26a00de8e1d2e7f19be729928388441ae

# Builds where the incident occurred:

## defconfig+arm64-chromebook+kcidebug+kcidebug-arm64+lab-setup on (arm64):
- compiler: gcc-14
- config: None
- dashboard: https://d.kernelci.org/build/maestro:6aa16cafe41d7f97d61b293e

## defconfig+lab-setup+kselftest on (arm64):
- compiler: gcc-14
- config: None
- dashboard: https://d.kernelci.org/build/maestro:6aa16c94e41d7f97d61b288b

## defconfig+lab-setup+kselftest on (arm64):
- compiler: gcc-15
- config: None
- dashboard: https://d.kernelci.org/build/maestro:6aa16c99e41d7f97d61b28e3

#kernelci issue maestro:e559f72e88347198a2cfd9c9c88a749433094738

--
This is an experimental report format. Please send feedback in!
Talk to us at kernelci@lists.linux.dev

Made with love by the KernelCI team - https://kernelci.org
