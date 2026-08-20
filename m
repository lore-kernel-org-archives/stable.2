Received: from mail-pg1-f182.google.com (mail-pg1-f182.google.com [209.85.215.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0AAD347884A
	for <stable@vger.kernel.org>; Thu, 20 Aug 2026 15:59:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787241551; cv=none; b=bqxeRzK+gHBMWWqdW3qi5EZv54KiuvnbKUtBjC4JOpYPuVV/CfO9uu1mqj6JbjGYTtgBkalcMy9FxiwlB8vnkbyiOOh58o3dyuDpC3wFc7Ifp/MLY0DW1CsG/tUQvvHEDsPQof5zNeUu0VOHNLUB3L9aZYf0g8UorDJr4KKoXjo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787241551; c=relaxed/simple;
	bh=stHPQub1xNdmZb6RnHmbZ9yrQmJ0AmVBo9UHfgyoEFM=;
	h=Content-Type:MIME-Version:Subject:From:To:Cc:Date:Message-ID; b=K6I5DeMftTy+PgyVdRcfSOZoQeID53UBAkp+go6DYvJJQW+0V2VxmJWhjAWoKl1Iy9mUn3qr/tP6FUsAxkTnJZfKMNvOy9tv2tm5OQBEy1Arf3Exbe13hupqpCT1gqdPH6Wlj1zyPvv0L0tuDvR8T7kFelMSn6Bm/njbhRpSQJE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=kernelci.org; spf=pass smtp.mailfrom=kernelci.org; dkim=pass (2048-bit key) header.d=kernelci.org header.i=@kernelci.org header.b=Cm50g7xT; arc=none smtp.client-ip=209.85.215.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=kernelci.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernelci.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernelci.org header.i=@kernelci.org header.b="Cm50g7xT"
Received: by mail-pg1-f182.google.com with SMTP id 41be03b00d2f7-cc11a905ba5so38764a12.2
        for <stable@vger.kernel.org>; Thu, 20 Aug 2026 08:59:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci.org; s=google; t=1787241549; x=1787846349; darn=vger.kernel.org;
        h=message-id:date:reply-to:cc:to:from:subject
         :content-transfer-encoding:mime-version:content-type:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=2ywqmGh3NQx7J9fcFbxxw+aeUMnbS/J9/aK0PNfeyCU=;
        b=Cm50g7xTADveajxzXk1jJiChaoTg5vUfJR1FjA9BIqufqAaRFIE2wCy86Q3Ci8N6V0
         HEGWely8PfUWW3TRk7PIaob+AB3d8AnRsx+tORKmK3JUhi/VxMuhlOLWQQZ38RfUzNoq
         5l2/rzILGJfs+OMh/xh2U6f3ZQJ4DR+GqAFvOFgg/+v5H7kksRqcpbRCxWJFKGdyprpi
         pvXn33edoB6OS1SK29YNpIBBCtkB3mVwf5UG9DfIYIXETOokPECL5W+a/N30gU/Kf1Xk
         4hgWZJ9pKHRYcaukXblPQvMSxvr9LE3gttFT44jnVFjbxvUwAW7glmiN7J7KuvRPnldm
         n4MA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787241549; x=1787846349;
        h=message-id:date:reply-to:cc:to:from:subject
         :content-transfer-encoding:mime-version:content-type:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=2ywqmGh3NQx7J9fcFbxxw+aeUMnbS/J9/aK0PNfeyCU=;
        b=f9YNoObaouAg2J5UylsflH62noiehSIbIpU+6ciwu63Gpv6Ok60WBPkianUtgpHsZ6
         QZ3Kfg3jCFPwG5z02EZNGxrPh/1bfnyPrfrrnSp2ZR8KjWQmkLwlNG0gMgqq/44ZpfI1
         zzyx1Eu5wHUMUFxlzCpjPir2ZEMvTkUpWCclloFnN91NFnLhxEac6fnhx+zbsUjDaLEQ
         McEsofIVKhSmJTeKNko/GksEcMuBdzO0Mm77e1sTdF3zQTrZdo2QNm3mIlsW183gwZVQ
         xoMMTKSAtSHaDAIawm1jk+xNdOp2CazDA1ZqrhRmRwxLm/ZjKqSk7S/ieIuNNjq/WXQj
         lI3w==
X-Gm-Message-State: AOJu0YzBYyDtEA2NoXgl0zDYypuV0yfZm3Z0UM84LNfRI0gIzVlQ7WtK
	Xxu/FYQtw9CsU5ZxruXGkpio7dws5EfmieIab8bcfJnycqdIlQEUs7+o3gj81p2G5LOjhltOGic
	cpLQT
X-Gm-Gg: AR+sD12iu3UUqxg4uXh0gVS2/wHhfsv6xe0IL1xSjErmnGL8rbnnTrE4UPlAZoNYpVo
	1uLCxxogxUwW6DcGeMpqxOZQpjSz2az8FoDcKJp7eYjPqjWWECwtihlnP0rFIEU8w7rkn6fqbgt
	4PUq+OZv4HyjlvR/gp3RQWQLPY0rIKKtvKBRCOh95bt/VuQSRL3vdCg8ZATQEcsJt6iCeKQPWiP
	8q2f0U6umyZB9/25zsX1FPFFFQyEV3VsHajfXWCRTAA8Ub855XrUDbSyN+YWMGNOPM6Q1+rYUYX
	ty+lVnvoF0sdHzkP/XduWH6qolt414L2/sWQHx9/Lk6MuHAI6QE0P4uCvf8PrmlcpVK4KTKa+VL
	+rUir014n/Yv3OovPKrvVy4yroOh37QO7eWUt6y3cQ1j9ZB7ZCDZ3ZZtcvDg1bX3NWO5f07ED/j
	llQgAMbSEY04JuRQUcQ89Xm9m7F8cPGp3yuqWGxAhu/lRir29pXUKQ
X-Received: by 2002:a05:6a20:5483:b0:3b4:6026:6c5d with SMTP id adf61e73a8af0-3cd00e18007mr25898639637.5.1787241549380;
        Thu, 20 Aug 2026 08:59:09 -0700 (PDT)
Received: from b455de3d9de8 ([20.38.40.137])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-327bf173b02sm18065483eec.27.2026.08.20.08.59.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 20 Aug 2026 08:59:08 -0700 (PDT)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: 
 =?utf-8?b?W1JFR1JFU1NJT05dIHN0YWJsZS1yYy9saW51eC02LjYueTogKGJ1aWxkKSDigJhz?=
 =?utf-8?b?dHJ1Y3QgYXRtZWxfbWNp4oCZIGhhcyBubyBtZW1iZXIgbmFtZWQg4oCYYmhfd29y?=
 =?utf-8?b?a+KAmSBpbiBkcml2ZXJzL21tYy9oby4uLg==?=
From: KernelCI bot <bot@kernelci.org>
To: kernelci-results@groups.io
Cc: stable@vger.kernel.org
Reply-To: kernelci@lists.linux.dev
Date: Thu, 20 Aug 2026 15:59:08 -0000
Message-ID: <178724154762.746.5687417139322820415@kernelci.org>

New build issue found on stable-rc/linux-6.6.y:

---
 ‘struct atmel_mci’ has no member named ‘bh_work’ in drivers/mmc/host/atmel-mci.o (drivers/mmc/host/atmel-mci.c) [logspec:kbuild,kbuild.compiler.error]
---

Log excerpt:
=====================================================
/tmp/kci/linux/drivers/mmc/host/atmel-mci.c:2661:31: error: ‘struct atmel_mci’ has no member named ‘bh_work’
 2661 |         cancel_work_sync(&host->bh_work);
      |                               ^~

=====================================================

When fixing this issue, please attribute this report according to the
patch submission rules:

Reported-by: kernelci.org bot <bot@kernelci.org>

For complete logs and details about the environment used, see the issue
on the KernelCI dashboard:

- dashboard: https://d.kernelci.org/i/maestro:f46fdd3213fa9af68112f3670381272cad761cd9
- giturl: https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git
- commit HEAD:  ca37407fccb96f6ba527cc8274afa5038874b131

# Builds where the incident occurred:

## multi_v5_defconfig on (arm):
- compiler: gcc-14
- config: None
- dashboard: https://d.kernelci.org/build/maestro:6a8713ca62f33761c0f0ba28

## multi_v7_defconfig on (arm):
- compiler: gcc-15
- config: None
- dashboard: https://d.kernelci.org/build/maestro:6a871faa62f33761c0f10cd0

#kernelci issue maestro:f46fdd3213fa9af68112f3670381272cad761cd9

--
This is an experimental report format. Please send feedback in!
Talk to us at kernelci@lists.linux.dev

Made with love by the KernelCI team - https://kernelci.org
