Received: from mail-pz2-f40.google.com (mail-pz2-f40.google.com [74.125.228.40])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B40B4214812
	for <stable@vger.kernel.org>; Thu, 17 Sep 2026 23:59:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.228.40
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789689547; cv=none; b=r8Ba92QRXwZtMtPtfq5f1I6jTxJtODLhIh3YkuRRYFs4xqa2hHuDMZUrYkO6azgKZvdOP2oxlAkKo7Z3gXH9iDZds2LdWF2jjPrLKgIIbSoV/2DRuGAUf0AOHmLbGa2rFX8NYxRHEvQeFkhn8fIoHA7RF/EATRjegl/Qi0YM7xc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789689547; c=relaxed/simple;
	bh=HQ3G/9Gls9Yp2q+4jNAVoTcvDy6l+LosXL0ad7P3/ug=;
	h=Content-Type:MIME-Version:Subject:From:To:Cc:Date:Message-ID; b=LM1LmZHU5grMRx2RiHIZXNAGBL1RtY4FbCERvBc380n6QbVkY+hUrDKuzH0O+PXvvVr7f9Df8BjozHEh/AtX3w0HlRWadhmRLcXjMqo2ksDiEqLW1nqxc8PbUfIuxg49Yxqm0yD0RUZAwMoE30YKJ+1Jp/MTLzaete9+0rwOMnA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=kernelci.org; spf=pass smtp.mailfrom=kernelci.org; dkim=pass (2048-bit key) header.d=kernelci.org header.i=@kernelci.org header.b=PwZGzyfb; arc=none smtp.client-ip=74.125.228.40
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=kernelci.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernelci.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernelci.org header.i=@kernelci.org header.b="PwZGzyfb"
Received: by mail-pz2-f40.google.com with SMTP id 41be03b00d2f7-cc5121bcf1aso65573a12.1
        for <stable@vger.kernel.org>; Thu, 17 Sep 2026 16:59:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci.org; s=google; t=1789689545; x=1790294345; darn=vger.kernel.org;
        h=message-id:date:reply-to:cc:to:from:subject
         :content-transfer-encoding:mime-version:content-type:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=vMEsPmzL54sy7vfjV2WjwFXyVMgYd8lXUVEf19p4Y7I=;
        b=PwZGzyfbPuIt+Httd19SKyDyC5/dPbLlm/oxfXjDDZMbwNfptqaKIrE3JiycqfTR3c
         XIzdScMwRL0BLbW1QFewg2BvAXIOujT58hiGYYJ9QUWB7xNAwZlz7eiuPSB9DxUCvGM9
         Tynq9mMBeOTsH5g9MDr2XindvWq4f5stEQcpCJdxvTzV5PlHDRxj+zExhTxPjBJPfUSJ
         xZlTPOWyP7+LU49LKorQqpyJnJ/RUrutwJ7lu9wZ6VeA9e78dwO7dZxvItZt2lNgwzRw
         jr5BGftrlAwmLqro2J+6TVNv5urhhufbFbOevT/BcJS68yOKM2qs6uKlRXKdnOoDG0nk
         dQnA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789689545; x=1790294345;
        h=message-id:date:reply-to:cc:to:from:subject
         :content-transfer-encoding:mime-version:content-type:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=vMEsPmzL54sy7vfjV2WjwFXyVMgYd8lXUVEf19p4Y7I=;
        b=SL+4VvfcWEkxMur+Y6QGfGVN+ZQDe9Ej7/I62OHFxlRRymEz+gKlhqrA55Y20OlZOh
         Ui/tnnse9gghOyEBX1YxgZPwlAHNqxP6aSkF2BzX/3rCIRWjf64s9F8PdHpS7X+DKHP8
         8/7QtNPWhbsfeCxdpixrevAJx9o/5Q1wRtLAZlm2et1i3nhkQQlbrIxQr5Ybfmw6pnQv
         Ad3E26int4muuYO3JHto9+tJdT5sz/dyLkw4m5LspSzxF9sGVJDIvr0QF9M4YwjZ6Ty6
         Zy+yTivGqx7kwsidE1OFQQyNk8AN6bHZO0PrGfwSuQxBH5vZaqE2LYU9W9ByN2pC4OGc
         iDYA==
X-Gm-Message-State: AFuF++m8ReLpx1v5jYtJp0zggxoYoaUAXissmKgsN6BJv7cPnm8j4wPY
	43zG87eHGSVRJ/gOOKDu8AljxGHL9L6AXVg5CuEA9xGPxcjUlozhB3Nsv4TPqRnp/YMvIKyL5aT
	CkwGG
X-Gm-Gg: AYBFou2T+9C6U7Wc7ew3qHzHXozCio3AifGnIrcNy7u03bDA1ZHgWHQ679gdkeTwMzj
	YJUsJnITdS+SAymk4GpfMY5V460Bv/Ki5WscEEyn8rt/EFDqq5VDF02jkP+1PunSkp0TQRP+lmk
	5240hReCZxR2lPduypapzwzRlErUuX770No7Z8cedwjajRxkL+X85Awlwzf74HLWcB7KWRPRD09
	IZtuiU/NjCG/oBN6TR4Vyyt6EIUC1hqHVUwa8ZCPE/6xmCQi3zAO8o4f48bXRQeHtY5Tf4rxjjl
	hiSLAR5b+cH8s+Eife2B0seMukApoqv1STfljQ0FxjpIgQ2KPa038B5Aa5ikx1RIhi9mf4obTeE
	ATnEGMGf5AogVodDf3LsQy9pIp1HJaaH6B+Gjn5ywG9WQeic0BqjcXnvA8x3+dVnqfR4KdL0EO2
	nwES8sbSS4W2lT7iZOeRfF3wKs3OrYf5VIWr5EZBczvPsDwGiXXT5kI8kW4g8Y+pw=
X-Received: by 2002:a17:90b:48c5:b0:39d:f247:bb3 with SMTP id 98e67ed59e1d1-39e54e7c1camr1565179a91.21.1789689544744;
        Thu, 17 Sep 2026 16:59:04 -0700 (PDT)
Received: from ec7b70f3a45c ([20.38.40.137])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-144cddb4cf8sm160112c88.1.2026.09.17.16.59.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 17 Sep 2026 16:59:04 -0700 (PDT)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: 
 =?utf-8?q?=5BREGRESSION=5D_stable-rc/linux-6=2E6=2Ey=3A_=28build=29implicit_?=
 =?utf-8?q?declaration_of_function_=E2=80=98sized=5Fstrscpy=E2=80=99_=5B-Wim?=
 =?utf-8?q?plicit-functi=2E=2E=2E?=
From: KernelCI bot <bot@kernelci.org>
To: kernelci-results@groups.io
Cc: stable@vger.kernel.org
Reply-To: kernelci@lists.linux.dev
Date: Thu, 17 Sep 2026 23:59:04 -0000
Message-ID: <178968954371.166080.15020453237932822382@kernelci.org>

New build issue found on stable-rc/linux-6.6.y:

---
implicit declaration of function ‘sized_strscpy’ [-Wimplicit-function-declaration] in arch/s390/boot/ipl_parm.o (arch/s390/boot/ipl_parm.c) [logspec:kbuild,kbuild.compiler.error]
---

Log excerpt:
=====================================================
/tmp/kci/linux/arch/s390/boot/ipl_parm.c:170:25: error: implicit declaration of function ‘sized_strscpy’ [-Wimplicit-function-declaration]
  170 |                         sized_strscpy(delim + 1, command_line_buf, COMMAND_LINE_SIZE - len - 1);
      |                         ^~~~~~~~~~~~~

=====================================================

When fixing this issue, please attribute this report according to the
patch submission rules:

Reported-by: kernelci.org bot <bot@kernelci.org>

For complete logs and details about the environment used, see the issue
on the KernelCI dashboard:

- dashboard: https://d.kernelci.org/i/maestro:ec6c0498fec452e0776b230caf5d0eff194b9b43
- giturl: https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git
- commit HEAD:  b3e867981242a1161809dfee76d6ae8fe106bc60

# Builds where the incident occurred:

## defconfig on (s390):
- compiler: gcc-14
- config: None
- dashboard: https://d.kernelci.org/build/maestro:6aabdcf4fc1857a999ded386

#kernelci issue maestro:ec6c0498fec452e0776b230caf5d0eff194b9b43

--
This is an experimental report format. Please send feedback in!
Talk to us at kernelci@lists.linux.dev

Made with love by the KernelCI team - https://kernelci.org
