Received: from mail-pg1-f172.google.com (mail-pg1-f172.google.com [209.85.215.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4CDB51A682F
	for <stable@vger.kernel.org>; Thu, 16 Jul 2026 14:59:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784213949; cv=none; b=EMoo0LnEPDW4QT+Xz4aqejsOvQsM6N4RTuU8AbgmDC0/VvyexD+9JsHTX36LYp3/YwEuO+7x7QmhMyGmLOP1D9CLAHEiUu/viYH0fME7FzoA0hYHK1Ost11Bil/TYPKfRLY3QAWcoXi6si6R6gRjto3cC7urg6BeyRHbfMW5suI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784213949; c=relaxed/simple;
	bh=i1bIveNhgc71ECkXD303OCAQWAi1qdffZpYYy6nmt2Q=;
	h=Content-Type:MIME-Version:Subject:From:To:Cc:Date:Message-ID; b=ZQ759JqeQ9dtEJtzG4k7zRgWVaE+a1BHzXhZzku+xmmwwvwwOhFysvqGAkg7Rglq/qTX1UaALvKsjEfKRMb+gTDnLSU7OP06Pyr3o4k2BjyqTwVdzBqEbLFbVDQXvYwIxFGjbrGFRKUBv01cT9oQfF3gbCFIuaLcbKJCvk4EFG8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=kernelci.org; spf=pass smtp.mailfrom=kernelci.org; dkim=pass (2048-bit key) header.d=kernelci.org header.i=@kernelci.org header.b=F6xeax4p; arc=none smtp.client-ip=209.85.215.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=kernelci.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernelci.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernelci.org header.i=@kernelci.org header.b="F6xeax4p"
Received: by mail-pg1-f172.google.com with SMTP id 41be03b00d2f7-ca97d139d8dso2210267a12.2
        for <stable@vger.kernel.org>; Thu, 16 Jul 2026 07:59:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci.org; s=google; t=1784213947; x=1784818747; darn=vger.kernel.org;
        h=message-id:date:reply-to:cc:to:from:subject
         :content-transfer-encoding:mime-version:content-type:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=jTLproAOM262upqa80shdb3kiCDefKf+WdQHxpBSNs8=;
        b=F6xeax4p7eaJA5ABUd+XmKvfrTyLzlX55Y+s+pgn7c877zl+MiFetsI5bXYumQSlQx
         rxOcsZttsHOo2u8yRZAEg4kF4mc43Eqh08ULg9JkKmaO2zcCR3k9Qgu9EX1oQcpkawJA
         X9hXNYApSDC066jn6099PC2QGTbGq4K/OTfT9l+ldzLn/IbA2HPZ262vyUVePhVWzNzP
         9F+6PAdwfOjx1XcDIdTk3CXMEJo9vModJqSbaD7eVZI2eMEyZAZ+25Mc7BTzuhQYBoNk
         Vmhjz+Mdhy0HL63cwVXp+8CWQJKA9tyEENfyovIuu7dAPjJp6AJxo+i/72qWGPiuQjEN
         dHLg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784213947; x=1784818747;
        h=message-id:date:reply-to:cc:to:from:subject
         :content-transfer-encoding:mime-version:content-type:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=jTLproAOM262upqa80shdb3kiCDefKf+WdQHxpBSNs8=;
        b=HjQtWYMKwuD6LCIlk0FLrVGzcZfXmBury2iCvg5fvVcNc0J8zJq76ERlj/QZkFcxnV
         P6MjPa9RTchfgPDSQv29y2+90Rraq+rD8QUHzG0t38/CGIDRxJeOGjZ71WsZamON0wru
         nmb1LCbUQXmFt+IPEjG/N664HjAEsQ3tFE+HSvIvy4CjH8liZ+H19TIMDzzZpRlmjIv1
         suB5pXNyOuI25IxwRqMuWxcuLVb6VQs/tPHdiEk/8mAcqdAARSSQn02qd0Zc0WvJX840
         e9ReWF1r/Vy8OYi8LACMGk3uCf24nT/41eqsmA2tdW3fmY0qmpMBnDlKdkEkqi9xoaVN
         4mMQ==
X-Gm-Message-State: AOJu0Yyi32aCPftl72AV5f2Qw/EY3iitV1AgaFVoopyWgs2FNndYbM1/
	GZ5WJsEL2hQMPpGKPa4X+GihPKiziTKWZb7Zd0E9c+YuYNKRHqxvI5MqZPpipWw9MrpJ2zjF56E
	Y3sLL
X-Gm-Gg: AfdE7cnJxNOr9aGuEZCysjG9Ul3+6mPgFqTBWtQ9rnLoZdgqgCVv/tn4VQ9TpZ2P3V+
	UsXOfwDjcXehW/jI0wxZ5r9JGiw0if7NgHyG3ecWO7wA1YsYWLBABG2CYpfqDvUld8ETiP5uc3m
	cQZKWT5Qap/jSWClLlY36qIY11lDMZZCevtE4CCJbQIXXUAHsAD3I0GLbLb5dAW8KK8DX57Oa5S
	/ll0ZQqKO9lAbmiQiFAgVbWPVMmjbUBxnqL1QbiTHdMppuAp5aAYADCajJUe41jE5alczsr6aD0
	Ssxld/R5nHryifzCvDlX1pF0tvelsFc2A+ZO6kKZrDE5obbYGbJV8PP1BpLG/FNjrLSnigZ8PwO
	fUV8GvpRra7CUFpDFAmcUMTt8g0xzAKQSsG7bWnh+kgQz7F7PMLdGzwJxR/z3NPCgmfcjgVw=
X-Received: by 2002:a05:6a21:9216:b0:3b3:486f:f2d1 with SMTP id adf61e73a8af0-3c1103cee5fmr26287896637.3.1784213946536;
        Thu, 16 Jul 2026 07:59:06 -0700 (PDT)
Received: from 963b246bc1b3 ([20.38.40.137])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-3140e4fd3e9sm12458508eec.1.2026.07.16.07.59.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 16 Jul 2026 07:59:05 -0700 (PDT)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: 
 =?utf-8?q?=5BREGRESSION=5D_stable-rc/linux-5=2E10=2Ey=3A_=28build=29_implici?=
 =?utf-8?q?t_declaration_of_function_=E2=80=98reset=5Fcontrol=5Frearm?=
 =?utf-8?q?=E2=80=99=3B_did_you_me=2E=2E=2E?=
From: KernelCI bot <bot@kernelci.org>
To: kernelci-results@groups.io
Cc: stable@vger.kernel.org
Reply-To: kernelci@lists.linux.dev
Date: Thu, 16 Jul 2026 14:59:05 -0000
Message-ID: <178421394549.11493.16122973897392996970@kernelci.org>

New build issue found on stable-rc/linux-5.10.y:

---
 implicit declaration of function ‘reset_control_rearm’; did you mean ‘reset_control_reset’? [-Werror=implicit-function-declaration] in drivers/usb/dwc3/dwc3-meson-g12a.o (drivers/usb/dwc3/dwc3-meson-g12a.c) [logspec:kbuild,kbuild.compiler.error]
---

Log excerpt:
=====================================================
drivers/usb/dwc3/dwc3-meson-g12a.c:946:9: error: implicit declaration of function ‘reset_control_rearm’; did you mean ‘reset_control_reset’? [-Werror=implicit-function-declaration]
  946 |         reset_control_rearm(priv->reset);
      |         ^~~~~~~~~~~~~~~~~~~
      |         reset_control_reset
  CC      drivers/power/supply/power_supply_leds.o
  CC      drivers/power/supply/power_supply_hwmon.o
cc1: some warnings being treated as errors

=====================================================

When fixing this issue, please attribute this report according to the
patch submission rules:

Reported-by: kernelci.org bot <bot@kernelci.org>
Link: https://lore.kernel.org/all/178421394549.11493.16122973897392996970@kernelci.org/

For complete logs and details about the environment used, see the issue
on the KernelCI dashboard:

- dashboard: https://d.kernelci.org/i/maestro:1ff36cf904ab1de792fc099e8e6ade024c54a8a4
- giturl: https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git
- commit HEAD:  6bb9d231b054d4343f7d9fa35fb4333ed9ace2d6

# Builds where the incident occurred:

## defconfig+arm64-chromebook+CONFIG_CPU_BIG_ENDIAN=y+kselftest on (arm64):
- compiler: gcc-14
- config: None
- dashboard: https://d.kernelci.org/build/maestro:6a58e6c63427a5b0fbe2c85d

## defconfig+arm64-chromebook+kcidebug+lab-setup on (arm64):
- compiler: gcc-14
- config: None
- dashboard: https://d.kernelci.org/build/maestro:6a58e6be3427a5b0fbe2c84e

## defconfig+arm64-chromebook+kselftest on (arm64):
- compiler: gcc-14
- config: None
- dashboard: https://d.kernelci.org/build/maestro:6a58e6ba3427a5b0fbe2c84b

## defconfig+lab-setup+arm64-chromebook+CONFIG_MODULE_COMPRESS=n+CONFIG_MODULE_COMPRESS_NONE=y on (arm64):
- compiler: gcc-14
- config: https://files.kernelci.org/kbuild-gcc-14-arm64-chromebook-6a58e66d3427a5b0fbe2c782/.config
- dashboard: https://d.kernelci.org/build/maestro:6a58e66d3427a5b0fbe2c782

## defconfig+lab-setup+kselftest on (arm64):
- compiler: gcc-14
- config: None
- dashboard: https://d.kernelci.org/build/maestro:6a58e6aa3427a5b0fbe2c7dc

## defconfig+lab-setup+kselftest on (arm64):
- compiler: gcc-15
- config: None
- dashboard: https://d.kernelci.org/build/maestro:6a58e6ae3427a5b0fbe2c7df

## defconfig+netdev+nfs-root-boot+kselftest on (arm64):
- compiler: gcc-14
- config: https://files.kernelci.org/kbuild-gcc-14-arm64-nfsboot-6a58e6b23427a5b0fbe2c80e/.config
- dashboard: https://d.kernelci.org/build/maestro:6a58e6b23427a5b0fbe2c80e

## defconfig+netdev+nfs-root-boot+kselftest on (arm64):
- compiler: gcc-15
- config: https://files.kernelci.org/kbuild-gcc-15-arm64-nfsboot-6a58e6b63427a5b0fbe2c811/.config
- dashboard: https://d.kernelci.org/build/maestro:6a58e6b63427a5b0fbe2c811

## multi_v7_defconfig on (arm):
- compiler: gcc-14
- config: None
- dashboard: https://d.kernelci.org/build/maestro:6a58e6903427a5b0fbe2c7ac

## multi_v7_defconfig on (arm):
- compiler: gcc-15
- config: None
- dashboard: https://d.kernelci.org/build/maestro:6a58e6943427a5b0fbe2c7af

## multi_v7_defconfig+kselftest on (arm):
- compiler: gcc-14
- config: None
- dashboard: https://d.kernelci.org/build/maestro:6a58e69b3427a5b0fbe2c7b5

#kernelci issue maestro:1ff36cf904ab1de792fc099e8e6ade024c54a8a4

--
This is an experimental report format. Please send feedback in!
Talk to us at kernelci@lists.linux.dev

Made with love by the KernelCI team - https://kernelci.org
