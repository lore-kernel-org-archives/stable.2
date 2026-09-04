Received: from mail-pf1-f169.google.com (mail-pf1-f169.google.com [209.85.210.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1E40F41F36F
	for <stable@vger.kernel.org>; Fri,  4 Sep 2026 06:59:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788505154; cv=none; b=Lilzn0sjoxx/zMhVqbGfqkaRWMwCVE8a6UfgEz24uUp8/0EtzqLZ3yr1W/cqJyvV6r5WdeE16MydWwwELJgpTn1XowvzqKHdeKqNoKb/CEkOv97g8hX19CBidajGjS//9Jjzv/OoHtuYEE7yb5bxMhN6w5wPqykw7n/LqT3I+8A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788505154; c=relaxed/simple;
	bh=WAnauYb3PxijcDC7SD4nC/Vo+89ZmJiAVBmu3Lve8Eo=;
	h=Content-Type:MIME-Version:Subject:From:To:Cc:Date:Message-ID; b=KTHAgsuOwOGpcpe8uQPUSGiG9hX20TlYAN7hUGmiuZow4jsO3B5hHbw5NBwBaMQAT5wDa+8jmd/iLpZ/4TkbqNPW+gC4IODoawEQqpXTmkwKvi6riGv4TAS5F6js3hWRJ6QKOi+Ewm26AiLE8w9wO5JA1hfTAPW6TcGjRVHLyMQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=kernelci.org; spf=pass smtp.mailfrom=kernelci.org; dkim=pass (2048-bit key) header.d=kernelci.org header.i=@kernelci.org header.b=bzYQ5Fcb; arc=none smtp.client-ip=209.85.210.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=kernelci.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernelci.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernelci.org header.i=@kernelci.org header.b="bzYQ5Fcb"
Received: by mail-pf1-f169.google.com with SMTP id d2e1a72fcca58-85590c5aeabso536265b3a.3
        for <stable@vger.kernel.org>; Thu, 03 Sep 2026 23:59:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci.org; s=google; t=1788505152; x=1789109952; darn=vger.kernel.org;
        h=message-id:date:reply-to:cc:to:from:subject
         :content-transfer-encoding:mime-version:content-type:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=zqopTEjZbXobXViL6+txSRjbOz3iRuTG36DOaCc7AcM=;
        b=bzYQ5Fcb6+tzdbNANZdhiIupMV5PH/Z8WVaxOUSFJ1LbZSdkMuPsb0TElHs5SWJFPB
         voRau6bAvwlrmdreSwOFPkjFbPcb1l20QA2ipUJtEh478pdKZ3ozIlpRPwd7VtcReT3D
         aOJH74vZa5s7Jbc759vGPTUkljBNLOUm6GaMk3PJJxnnaoEzTIJsMPuvxIVXw4IgJSfK
         xjjZisuLzs2aPrI7OOkCW1Ip05b298Oh3pycsdnOzjQ2xv5u++HL1cTMZckhXaKas/Jh
         MjGyzQcPSFomMS8zXjQ6itl+QKuALfMDtK2FFMV+WKFbVcfS1lSU52Z5Hbinhud2uPhp
         rYzw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788505152; x=1789109952;
        h=message-id:date:reply-to:cc:to:from:subject
         :content-transfer-encoding:mime-version:content-type:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=zqopTEjZbXobXViL6+txSRjbOz3iRuTG36DOaCc7AcM=;
        b=ER+8aLbnFA23VTurzJG7UcnVy7LY6iVRyEmzeoNaTG2UirQXr8rBnrkeATACd5U5eR
         rrKVZgtLLmZCmXrqMkc7GJJ0pq14FzOX/5dopPrbgmQh6npck4QvvwEsm9r9z+LifXbM
         Fkb+hgSNhKJEFqZN5SZyo+eJm9tARZcgbDLnwEoHFh+CSw6Rg4SM624nu5/jG5WUvPjb
         X9Uo8mcWwYfjSK+nUCc5m0Jwj8/0AIvhAUJgXXKhujw3FScN8PZFkwY0eD7gBqRpNEbH
         x+ov72XHD3R2kZVROrp+A7O1t5xNnnkI5HtOiGj0ogWYqW3AV4SySmfNqtuWsOGlvL4t
         vkVQ==
X-Gm-Message-State: AFuF++lDCd64xvYz72dptrpYqJeVKb/JfVewrTTGxUDBmHo/95W2zgZz
	5dHP6R1IbPkx/MAg2yhlgNYtazydNQkwjQM6BFnawaYOfd+LxmQdGgGz9aGLOGzBRPXpGgqSrD2
	9XgGvWfk=
X-Gm-Gg: AYBFou2d9Wh9ArTGXzuL2Cpb4Ot/e1Q6wcwErBSdOGVyMM0+9kGb+/4wcM0svMQsjsk
	KY9yYDq2qhmBCKWK686QxZOmNciZ7e4mrUyP5KHzNLpR/FLid6wCAy5u1b6J4zoQR3WTRPnRmUg
	sjviMF9DBdKqHKz9FCxBd+EEGxVlPWSlaaR88aOPfona6L4vNqAhE3TAbIjDRiHt9MEaYJz06oa
	hTsZQquulHHa5YduNTpREXHxAu03QYvO3XC5M+pTaoTlxQe1snyy4D38MKLm6mrNlLdn050LUWP
	d8icQcvWOQsORNMqpUrDfqgs9WhfIyby1UuVfo9ffjbStP808pD9TxcMwbIi7iwlVNjSdyv9bJb
	2oi2Wvj1/XTTYGVVcvm3vD1kwsXJ0jX2mwNIF/tXCBRhOsTqxaBwddHoEYJqDty5Vyy0toJeKnd
	Z6yhsDf8YAS64gikG9icpk6cvAtXEso0Edn0KMO6Tvl2zUIb5Qlmnv
X-Received: by 2002:a05:6a21:7a46:b0:3bf:9b61:f7ae with SMTP id adf61e73a8af0-3da3a0055abmr6476903637.14.1788505152266;
        Thu, 03 Sep 2026 23:59:12 -0700 (PDT)
Received: from 41049dfc76e5 ([20.38.40.137])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-3339aa31b24sm4270032eec.13.2026.09.03.23.59.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 03 Sep 2026 23:59:11 -0700 (PDT)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: 
 =?utf-8?q?=5BREGRESSION=5D_stable-rc/linux-6=2E1=2Ey=3A_=28build=29implicit_?=
 =?utf-8?q?declaration_of_function_=E2=80=98put=5Funaligned=5Fle16=E2=80=99_?=
 =?utf-8?q?=5B-Wimplicit-f=2E=2E=2E?=
From: KernelCI bot <bot@kernelci.org>
To: kernelci-results@groups.io
Cc: stable@vger.kernel.org
Reply-To: kernelci@lists.linux.dev
Date: Fri, 04 Sep 2026 06:59:11 -0000
Message-ID: <178850515101.887.14849460440735922732@kernelci.org>

New build issue found on stable-rc/linux-6.1.y:

---
implicit declaration of function ‘put_unaligned_le16’ [-Wimplicit-function-declaration] in drivers/pci/pci-sysfs.o (drivers/pci/pci-sysfs.c) [logspec:kbuild,kbuild.compiler.error]
---

Log excerpt:
=====================================================
/tmp/kci/linux/drivers/pci/pci-sysfs.c:918:17: error: implicit declaration of function ‘put_unaligned_le16’ [-Wimplicit-function-declaration]
  918 |                 put_unaligned_le16(*(u16 *)&val, buf);
      |                 ^~~~~~~~~~~~~~~~~~
/tmp/kci/linux/drivers/pci/pci-sysfs.c:921:17: error: implicit declaration of function ‘put_unaligned_le32’ [-Wimplicit-function-declaration]
  921 |                 put_unaligned_le32(val, buf);
      |                 ^~~~~~~~~~~~~~~~~~
/tmp/kci/linux/drivers/pci/pci-sysfs.c: In function ‘pci_write_legacy_io’:
/tmp/kci/linux/drivers/pci/pci-sysfs.c:953:23: error: implicit declaration of function ‘get_unaligned_le16’; did you mean ‘get_unalign_ctl’? [-Wimplicit-function-declaration]
  953 |                 val = get_unaligned_le16(buf);
      |                       ^~~~~~~~~~~~~~~~~~
      |                       get_unalign_ctl
/tmp/kci/linux/drivers/pci/pci-sysfs.c:956:23: error: implicit declaration of function ‘get_unaligned_le32’; did you mean ‘get_unalign_ctl’? [-Wimplicit-function-declaration]
  956 |                 val = get_unaligned_le32(buf);
      |                       ^~~~~~~~~~~~~~~~~~
      |                       get_unalign_ctl

=====================================================

When fixing this issue, please attribute this report according to the
patch submission rules:

Reported-by: kernelci.org bot <bot@kernelci.org>

For complete logs and details about the environment used, see the issue
on the KernelCI dashboard:

- dashboard: https://d.kernelci.org/i/maestro:d12d858ba20eb1ec61585810aa083b418ea877d9
- giturl: https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git
- commit HEAD:  32d7721d428b58fb2445db8001f81293315057b7

# Builds where the incident occurred:

## ppc64le_defconfig on (powerpc):
- compiler: gcc-14
- config: None
- dashboard: https://d.kernelci.org/build/maestro:6a9a5ef7e41d7f97d6fd757f

#kernelci issue maestro:d12d858ba20eb1ec61585810aa083b418ea877d9

--
This is an experimental report format. Please send feedback in!
Talk to us at kernelci@lists.linux.dev

Made with love by the KernelCI team - https://kernelci.org
