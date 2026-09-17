Received: from mail-pz2-f12.google.com (mail-pz2-f12.google.com [74.125.228.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 78DA140801E
	for <stable@vger.kernel.org>; Thu, 17 Sep 2026 20:59:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.228.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789678747; cv=none; b=tMECRbCV8uX1OAZtTnF8Atb65KMhqLlEkp9hwY3FMPKdVEPyufXqVgUoAnQdDJado3c+hRBD3WYaPk2wUR7W/da8ijUBXxvJM6DYrG0R5P9QJngyTc4CxlgyvfC+NEwT1kcgijiGZawL4u1X0bbmTc8tQkS3S4JG94qTDXKt8Ww=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789678747; c=relaxed/simple;
	bh=fsNeOBYRqjD9nmetAZIqU+SCOSN0Uh40ZK/zrdKlBbA=;
	h=Content-Type:MIME-Version:Subject:From:To:Cc:Date:Message-ID; b=vA6weJXVnxAbmavZxKOvZvi2JPDl5KcUSEVuuLmCTshW4lkqEb+0kR7eVMWeGPXjgkKms90c8y1AVficVAUA4H9W1FAz6ggeDCrpOYfg5uTz49ld9LD1qnnaUyKI3L7SnW6OzmqZAb2AQGKmWP4dXJ2x2UOQn1R0oRSyYGJm0BY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=kernelci.org; spf=pass smtp.mailfrom=kernelci.org; dkim=pass (2048-bit key) header.d=kernelci.org header.i=@kernelci.org header.b=LSqM81IN; arc=none smtp.client-ip=74.125.228.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=kernelci.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernelci.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernelci.org header.i=@kernelci.org header.b="LSqM81IN"
Received: by mail-pz2-f12.google.com with SMTP id d2e1a72fcca58-86212a185dcso113815b3a.1
        for <stable@vger.kernel.org>; Thu, 17 Sep 2026 13:59:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci.org; s=google; t=1789678744; x=1790283544; darn=vger.kernel.org;
        h=message-id:date:reply-to:cc:to:from:subject
         :content-transfer-encoding:mime-version:content-type:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=rRV/6tRRwfsgLBqItuOijAZfTK2jbsXFArHvx2gJ7Lg=;
        b=LSqM81IN31a+YOLqe9PMg4a9LkQaIgPbc+TdibybPPykXEDhUMaLS6mX8hOJp8fW4g
         IYyNvnIRUym94dXOVdhMw6Ja8YYrz1DKSju1Y3Cpqne4ClQYfeRF1WtAMF3SQOQC8X71
         cRmldDdSTzs136KjLdxUtx6hLgMLbTYj8+Ar6YLAU6c+YjNEbEcvhlLI8cVj48ScSAxP
         1rM9HOkdqrqSNC0saGI2XPyr2JZQ0BhFbuVHVVTccmXsKRqKX4JchtEforT0oV5M4j1j
         UcgAM4wCHxfJMhIDRwsXd/uo96uUi8+CYq2RBpW+aoercaISpFfTA5h9+/ubxP4aRo7H
         KFaA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789678744; x=1790283544;
        h=message-id:date:reply-to:cc:to:from:subject
         :content-transfer-encoding:mime-version:content-type:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=rRV/6tRRwfsgLBqItuOijAZfTK2jbsXFArHvx2gJ7Lg=;
        b=TtarpXEhSfNMg58p8/X2sZ7sYaTGVmTf6kXlmWuPQQO2frLePGA42DFtT44NXu/s+5
         0kuI1zWXTpqwCsc6zir7KnwhcCULWKYOhCd0+vp819wtBikT3c2sR6j+nzyzjy01SrkC
         vnz7j1tKqhDLE5KR5d4hLVmEA0ip6GAiGC+wgUE+OuFbQSkusE+fqfcS5vieb1NYQW10
         xwb0r6iCNnBPWA3Av9X/6iudUxNnqCXsIkvWBfRPbMXdz8N6u2MZjYLQL8t/jIZJGO10
         eihaYAPQu2Tdx11z7hZJbBFZ2k/a8hXCKSf6Eh2Ss0hy3aXZf+40/N1PCACJvMLShLPD
         yZnw==
X-Gm-Message-State: AFuF++nAkJW+JgJ3P3R30fKc3KKmqP1oadfegbFzPdhoVVu/cQl/XHwD
	JClmwqmHtzWrqVCc0r1FNe0bJinfZEiioOziQ5qPlrDKpHjImWzGF4yWx3cYnESN8U7XixZ+BRW
	q46rP
X-Gm-Gg: AYBFou3kcZ6rF5adU983izMGqV0xW5CR0AD66HbiqGAIwQQOr0mCEChwRHW5RbWZs7u
	eRWJ/VBAXTz3lgo+TYwq/wLh+9k8sijjcOvtdrTxn8yzW56avOqU9C5XK2j+JQ8ox5NrUbAIf5o
	tZywu+kib8bn0ZVdWz2RJNQrmDWpbQX00v71PSddeZvhKODUf0T4wQxHwQlCHMgxyqYWp9sNU72
	RTXHmh24idcDmQyCk6NW/sL2pigSKF9THNA2XsJoiXptLP7ZD3D+ng+Y05m7tOYd+K5hfQsccJl
	/N+MLzuww4CGb+JA9zlWVsnlbi3y4lfCwqDV/VOOb5S9ejQr72ap6krbnzKlyHC1oZuAVg2ycF0
	8JyYh6ENDEhRky8L6u3S0JukfUKqX+8k+vJM4uFtVXKKxTclz+ziNL5fXSbahIHssWCaPIsGlQ+
	Ki1OLHx8i3i7MVPv62t23MkSS913n3m1WuUyUVgC4+2pYsAhnAl4/CP4VnpUg1oIiL
X-Received: by 2002:a05:6a20:6a08:b0:3dd:7b24:b344 with SMTP id adf61e73a8af0-3dd8c52f8demr387821637.18.1789678744575;
        Thu, 17 Sep 2026 13:59:04 -0700 (PDT)
Received: from ec7b70f3a45c ([20.38.40.137])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-33c13f09408sm6541890eec.7.2026.09.17.13.59.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 17 Sep 2026 13:59:04 -0700 (PDT)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Subject: [REGRESSION] stable-rc/linux-6.6.y: (build)call to undeclared
 function
 'devm_reset_control_get_exclusive_deass...
From: KernelCI bot <bot@kernelci.org>
To: kernelci-results@groups.io
Cc: stable@vger.kernel.org
Reply-To: kernelci@lists.linux.dev
Date: Thu, 17 Sep 2026 20:59:04 -0000
Message-ID: <178967874357.159480.14346448764257002967@kernelci.org>

New build issue found on stable-rc/linux-6.6.y:

---
call to undeclared function 'devm_reset_control_get_exclusive_deasserted'; ISO C99 and later do not support implicit function declarations [-Wimplicit-function-declaration] in sound/soc/ux500/ux500_msp_dai.o (sound/soc/ux500/ux500_msp_dai.c) [logspec:kbuild,kbuild.compiler.error]
---

Log excerpt:
=====================================================
/tmp/kci/linux/sound/soc/ux500/ux500_msp_dai.c:728:10: error: call to undeclared function 'devm_reset_control_get_exclusive_deasserted'; ISO C99 and later do not support implicit function declarations [-Wimplicit-function-declaration]
  728 |         reset = devm_reset_control_get_exclusive_deasserted(&pdev->dev, NULL);
      |                 ^
/tmp/kci/linux/sound/soc/ux500/ux500_msp_dai.c:728:10: note: did you mean 'devm_reset_control_get_exclusive_released'?
/tmp/kci/linux/include/linux/reset.h:600:14: note: 'devm_reset_control_get_exclusive_released' declared here
  600 | __must_check devm_reset_control_get_exclusive_released(struct device *dev,
      |              ^
/tmp/kci/linux/sound/soc/ux500/ux500_msp_dai.c:728:8: error: incompatible integer to pointer conversion assigning to 'struct reset_control *' from 'int' [-Wint-conversion]
  728 |         reset = devm_reset_control_get_exclusive_deasserted(&pdev->dev, NULL);
      |               ^ ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
2 errors generated.

=====================================================

When fixing this issue, please attribute this report according to the
patch submission rules:

Reported-by: kernelci.org bot <bot@kernelci.org>

For complete logs and details about the environment used, see the issue
on the KernelCI dashboard:

- dashboard: https://d.kernelci.org/i/maestro:83b83278ca77cd99806e45140a067700eb38a4bf
- giturl: https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git
- commit HEAD:  02cc578650bea44d7dbb965be9f8bfb13b1ea8de

# Builds where the incident occurred:

## defconfig+allmodconfig+CONFIG_FRAME_WARN=2048 on (arm):
- compiler: clang-21
- config: None
- dashboard: https://d.kernelci.org/build/maestro:6aabe9e7fc1857a999df0bda

#kernelci issue maestro:83b83278ca77cd99806e45140a067700eb38a4bf

--
This is an experimental report format. Please send feedback in!
Talk to us at kernelci@lists.linux.dev

Made with love by the KernelCI team - https://kernelci.org
