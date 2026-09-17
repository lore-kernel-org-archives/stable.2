Received: from mail-pz2-f17.google.com (mail-pz2-f17.google.com [74.125.228.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 347D1559CB8
	for <stable@vger.kernel.org>; Thu, 17 Sep 2026 13:59:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.228.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789653548; cv=none; b=Ne6N0eXdJ9IBjX1tMEiasr+6EdZVVvzn0ErjKIFXReDHTahe0QBoQYWvxmtPHCdJqOdqn5hb41q/nwV4zm5wO5KAlCSBRcSeR9UCeRB29SzlmaheD9nBjO/d4zK0AyjgCXagjqcK/wrHBsaEhIXGj7YIM0kGX60wqCkK+zUhABA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789653548; c=relaxed/simple;
	bh=kvY2xVqoArkbT8C7B36gVOOr0/fhEvrzaZ5vr2zSEkM=;
	h=Content-Type:MIME-Version:Subject:From:To:Cc:Date:Message-ID; b=rr0dUcCNC8ezUWJVA7kQjiUAI4Cfjpe3ig9hTQFXshHvhQvaogfqboGfTh1fPAVbefSmPojgxaIWzhVpkJXDmSPBnusju7W2eyMjhj/6HTKzmgCY+K4DAbLiwiCzfhqVXKEsLdPLJRgopxcoWKv7+mvbtp2BHy2LHEZV4ub06rs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=kernelci.org; spf=pass smtp.mailfrom=kernelci.org; dkim=pass (2048-bit key) header.d=kernelci.org header.i=@kernelci.org header.b=Gd9/EltC; arc=none smtp.client-ip=74.125.228.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=kernelci.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernelci.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernelci.org header.i=@kernelci.org header.b="Gd9/EltC"
Received: by mail-pz2-f17.google.com with SMTP id 41be03b00d2f7-cc4c3304784so640148a12.3
        for <stable@vger.kernel.org>; Thu, 17 Sep 2026 06:59:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci.org; s=google; t=1789653546; x=1790258346; darn=vger.kernel.org;
        h=message-id:date:reply-to:cc:to:from:subject
         :content-transfer-encoding:mime-version:content-type:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=wKM+oUyAD1hFPxp2Jk+V3HxjJkeuBudhSXmzaIxmPgI=;
        b=Gd9/EltCmdWdWBh6ZsXy2ws9twpuOWBleaBxWSxKvJYIG49O8YnnekqJ+ZRe38GsWw
         wYzQcscTFRaVCf7/89Uax/hzUoB/4nOuTX6H4gFkZkHGadL5e5INUBc3nMnpGaFWGIjC
         F8o34dgbiugP9W3+/7aN3AC/j4rsaDyxwjcV4xyc05lE4690qxa5Cldz1OOuZGSX0KXc
         /9FLIFe/DnxZ4q/1jQ2D9RZ5w/HkWJpspvnT0ucOMb67RoKeLJ14SqBmzgr/DYORggDx
         d/vXn9HYwvc2R4fKmqgW81R0HMvbGEBNVbnVwfI4k0CSxFkh85o+TPTjiNBOtbZxr3OQ
         0j+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789653546; x=1790258346;
        h=message-id:date:reply-to:cc:to:from:subject
         :content-transfer-encoding:mime-version:content-type:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=wKM+oUyAD1hFPxp2Jk+V3HxjJkeuBudhSXmzaIxmPgI=;
        b=E6ijpK2XTyMrRCkh/2fqUlAvyEcyph8XhkDA3P/T21Wm/7Jnm9rF9TkcxqDFlucjDt
         J6ou3OJB3xcFiGDjqoM7kDs5KfZ3jLXadszWyPBTl7CBBikjY38uC0KSJhbl0JMT0MMm
         foSEss7HblChhrtVe22zoE7xFpbok0BlE2a4nwiuUOV832GH0gmkrtnIQgv21mfBLDnf
         eIfKhkhfuRMFrdp0UkEtNYcKuqV8VAfs315aiLHLzz0jkNzuvcwjrUKgPHK3zy9LzU6f
         MTVKABjxtwe07jXCa98Y/qXERM8aod2RqFmpz9GDXBT7YMmDV2wBc2QYCpeXiev8GI+I
         vRqw==
X-Gm-Message-State: AFuF++nYn6aXSNf41BSlw+b2/FNBfTrV8y9nEDaoprsn8S3gn7MXSQxJ
	+V6bJHSU+I/nUmrzq4bwV0PHETYYD9wHKOExHzCu/hj/0baIdTBflQH2UaqZjVBi1VY=
X-Gm-Gg: AYBFou0/DsnquffR1zZg5HsXmcZRm/bsI4Eni0NjiW3INmIgHmeag2anhvCWuXp7ZCo
	FHwKVeJ4jrpGCKyvIUZ6V0uqFIfUzfl4eWd1Wgd/Y+cNvNItFHyK4PgB0gPNmmwKIw2PkWrHUOq
	zoEogo37lZpNp4J2g5swQFqYgDIhgOXg03Wdnc5NnNDjNG8uF4lO1PBpxf7Ut25vGR9g9qpyjU8
	dsE486C+M2oaCbXghbm6UYjKibj7brJsFHVTCD5x6ra5m6mR3lZUaA8X+ezx57jpwNPPkGg/Av1
	aIpeNpHfcuXA7LbEq5DqYeCnBYV7Wn3rWA3ZmM1+ZYVX61PjVur2i3/+EIUFtqu10zpvnZU87s4
	pI3DhM4rJOfusfooSzg43nAu90p1Mvc1JLV6jUGeDkdpUueeA0KWnEW0Ne6zmNs/lSBUkd/9obT
	2MB07I3WrqB4HafdrFIObcqFWkFfSUkg40IwSx6ni5F5yGbbQHckbZeT15hpzv33w=
X-Received: by 2002:a05:6a20:7faa:b0:3d8:f78a:9349 with SMTP id adf61e73a8af0-3dd5f5c9013mr14284465637.13.1789653546129;
        Thu, 17 Sep 2026 06:59:06 -0700 (PDT)
Received: from ec7b70f3a45c ([20.38.40.137])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-14395d4cbc9sm13143032c88.11.2026.09.17.06.59.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 17 Sep 2026 06:59:05 -0700 (PDT)
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
 =?utf-8?q?argument_1_of_=E2=80=98linkmode=5Ffill=E2=80=99_makes_pointer_fro?=
 =?utf-8?q?m_integer_wi=2E=2E=2E?=
From: KernelCI bot <bot@kernelci.org>
To: kernelci-results@groups.io
Cc: stable@vger.kernel.org
Reply-To: kernelci@lists.linux.dev
Date: Thu, 17 Sep 2026 13:59:05 -0000
Message-ID: <178965354504.144182.1209886168149833440@kernelci.org>

New build issue found on stable-rc/linux-6.12.y:

---
passing argument 1 of ‘linkmode_fill’ makes pointer from integer without a cast [-Wint-conversion] in drivers/net/phy/phy_device.o (drivers/net/phy/phy_device.c) [logspec:kbuild,kbuild.compiler.error]
---

Log excerpt:
=====================================================
/tmp/kci/linux/drivers/net/phy/phy_device.c:3059:29: error: passing argument 1 of ‘linkmode_fill’ makes pointer from integer without a cast [-Wint-conversion]
 3059 |         linkmode_fill(phydev->eee_broken_modes);
      |                       ~~~~~~^~~~~~~~~~~~~~~~~~
      |                             |
      |                             u32 {aka unsigned int}
In file included from /tmp/kci/linux/include/linux/mii.h:13,
                 from /tmp/kci/linux/include/uapi/linux/mdio.h:15,
                 from /tmp/kci/linux/include/linux/mdio.h:9,
                 from /tmp/kci/linux/drivers/net/phy/phy_device.c:23:
/tmp/kci/linux/include/linux/linkmode.h:13:49: note: expected ‘long unsigned int *’ but argument is of type ‘u32’ {aka ‘unsigned int’}
   13 | static inline void linkmode_fill(unsigned long *dst)
      |                                  ~~~~~~~~~~~~~~~^~~

=====================================================

When fixing this issue, please attribute this report according to the
patch submission rules:

Reported-by: kernelci.org bot <bot@kernelci.org>

For complete logs and details about the environment used, see the issue
on the KernelCI dashboard:

- dashboard: https://d.kernelci.org/i/maestro:bdb28b77374b282063c23c44b336428b1a4691fb
- giturl: https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git
- commit HEAD:  09da4c7d441294e4264cc4804d8bc76433d5e0c1

# Builds where the incident occurred:

## defconfig on (riscv):
- compiler: gcc-14
- config: None
- dashboard: https://d.kernelci.org/build/maestro:6aabeb69fc1857a999df1355

## defconfig+lab-setup+arm64-chromebook+CONFIG_MODULE_COMPRESS=n+CONFIG_MODULE_COMPRESS_NONE=y on (arm64):
- compiler: gcc-14
- config: https://files.kernelci.org/kbuild-gcc-14-arm64-chromebook-6aabeab8fc1857a999df0f48/.config
- dashboard: https://d.kernelci.org/build/maestro:6aabeab8fc1857a999df0f48

## x86_64_defconfig+aws-ec2 on (x86_64):
- compiler: gcc-15
- config: None
- dashboard: https://d.kernelci.org/build/maestro:6aabeb88fc1857a999df1404

#kernelci issue maestro:bdb28b77374b282063c23c44b336428b1a4691fb

--
This is an experimental report format. Please send feedback in!
Talk to us at kernelci@lists.linux.dev

Made with love by the KernelCI team - https://kernelci.org
