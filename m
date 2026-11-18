Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.177
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795006748;
	b=CcCcczeCWdQEaa6D5/Tcnnki4/t3a8r0Z4xyv2AiHs6/jJ1AX7cCjM6rgo3Ws+uhaCPr
	 NCAy9oWGsZm4B0Dje325D3xJ6CF9s64uAzPdNadKhmZ5+x8cYPYjjiwG+ji5ZXy4gHJ2b
	 ZfITtQw0YUtInGUne6dZzUv07iNQF66sgWa9b4OK8R7oznRjVZ4WyRIJ8KnimMom1W9sH
	 TGsqzxoeZrvvXVPu4iA2xASiNvZHNy8hwd9bTxE3mYJXep66OfHTu/unuX/3UbPe7iRkT
	 30+BytrIX2XKYHfuc2cj8HOhModB0j/BiT22Nvjkh7cPVOVJBfxhs5iK8R8RqG3AcSg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795006748;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:Content-Type:
	 MIME-Version:Content-Transfer-Encoding:Subject:From:To:Cc:Reply-To:
	 Date:Message-ID;
	bh=3trFUOiWff30ewlUuM0XY5bu0iPbT7Wz/JObVPFu1Xk=;
	b=TbtugWEzfz/OQO5sk3ueCrXe3VsMYc3UjGRoa/U+yWWi3E5FM+xcZdSNgagEsz1oMgMm
	 oMTeP7EZIQVIbyJZqxJY7W1SnYsMiK3tugngyWxThCblu8kA8yowZGQ2Zb/N5Mn7icjHy
	 DbRvVc63ru3a+OYOB/lPG7J3MRRiV3yVuBWMlB7ibnblAQ9vq8spuhdmi3bvUcC7jK1J/
	 gWtLXDVU16/tIM6HaJMpwne9+UYUm4KoJlhwZ3JfjuG6tTsrJ54jbyWABo6M3wyd5fYyZ
	 g2dnPwnHrR0Brl7aQwRXzJSY+vldtwZg9ZMLDZTDkzW0hBtKvWHmOZi5LJ/pDYoERvA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=kernelci.org;
	spf=pass smtp.mailfrom=kernelci.org;
	dkim=pass header.d=kernelci.org header.i=@kernelci.org header.a=rsa-sha256 header.s=google header.b=GCcK9w+g;
	arc=none smtp.remote-ip=74.125.82.177
Received: from mail-dy1-f177.google.com (mail-dy1-f177.google.com [74.125.82.177])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2E33B606A32C
	for <stable@vger.kernel.org>; Wed, 18 Nov 2026 12:59:07 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 2E33B606A32C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=kernelci.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernelci.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernelci.org header.i=@kernelci.org header.a=rsa-sha256 header.s=google header.b=GCcK9w+g
Received: by mail-dy1-f177.google.com with SMTP id 5a478bee46e88-381d542bc29so1811252eec.1
        for <stable@vger.kernel.org>; Wed, 18 Nov 2026 04:59:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci.org; s=google; t=1795006747; x=1795611547; darn=vger.kernel.org;
        h=message-id:date:reply-to:cc:to:from:subject
         :content-transfer-encoding:mime-version:content-type:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=3trFUOiWff30ewlUuM0XY5bu0iPbT7Wz/JObVPFu1Xk=;
        b=GCcK9w+gGazN1J5oA1alxYVVgCve6NN++SghTg89hNNBAR2J2aEtt5s6GneIOWNekw
         IeqaGfNNg4VnY/rAAa+qrjh2w4nMnbYNgtLml5pXY7L5tGaKSXlgN5fAn85JNbYmosyQ
         IBNte3vaObwReCw/1e/vS5uHj3TDVUIWlAqxvTxOtVPLnZvvZ/AW8YPgaomIOv3wYevR
         Wi5B7rndYsK3k8FR4TaplXsQl8UwjpYvlkR8PXBrCF9FcxtjSTxNdD3HVaZNcfXtXVPU
         saKQBp2YXqHkAzzNFW3rNkizuGyX/ZW9oLDNJAn8WnqX7YZ7L3RQKFHPrNYYf7Y6m0CG
         7j0A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795006747; x=1795611547;
        h=message-id:date:reply-to:cc:to:from:subject
         :content-transfer-encoding:mime-version:content-type:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=3trFUOiWff30ewlUuM0XY5bu0iPbT7Wz/JObVPFu1Xk=;
        b=WYqUmQdUN7acYZsAP3c1BvpBh/ZRIxZCo1O07GFILbCeKqLskwC+iU0umQbbthpXbh
         r4QPSrtVfrI8OZa+MESwdsDVsAGbOcnb89l5UokATCcWR1o3ww5l5s3pcNer0hpkwWXO
         VzL/5vWzLaMkWn5eFKKS4a8zG6miVf0ZISA0CtqDUuxzeKlv5KX4nqjQXfiEelpGEH8Y
         Wd+fRQ1PzZ9MEXdMdMFkE4/f8GaTeumOPI07d8OWYSz58WEKDf6CAiEAcajbfRjjI787
         axDRz7cusCRgfhEbd9APmjnuzD4xGDLLRX/jQ6FErSMSsMkJIXB3dL39OicHnNc4sGGk
         utrg==
X-Gm-Message-State: APuU4Z8lgva2205ffm5H8FKXKcGgPH/m6MOazQxENR9DvEYXaPQK4rGq
	dUxtzdfW183d+MC5bXvY/0/MT7FI9qpUXyLEya1nKuSaN8PbQ+MzpDFQE6/Mzao1CkI=
X-Gm-Gg: AZFdTZc2boWThflUYO+F4u0ax6dFAKQZnPk38D+QuAGrD5EauIlp6T6mCepvmKF1kOA
	ZWHIhMIscisa83JL7+pO30aHAIc0FramjZ++DwBQKpt6mH+TG8sKPReow381vKhJKmJWJ+qATUp
	pn+EM3lw8MEDjHgzq4IAUwNMgp5Okic/E5+7ic/1a1jslWnJhrs/fsTRQZbYNDfu1snnFRHs7RH
	1hUTayBZ+pXLYR3tlb1JkUo4Cuk2VnHYp3/1vul7urOjzB91ouQICK4VITpv/RqYUO7rWMr3MGm
	Bs/DeZvD/vpV1O+jNigWucWP0VY7HendbujD7LN1CexELQO6vLXMo0KU7MbX4j3eYvk1XxI9F+D
	WSC1rx3DXtu8rYN/jmjq54X3nUWFIEEdBIaAQC6dA8aVMJel5qfarzVrgGwnM1tdOPlYD4zfLwq
	ecWiqM5He+AyjyKYU4m5OdfumZtxCu13vReLCLugUG8rrDSE0JKmBC1j6jZDGjeI0oCQW38tIah
	C1+eX27vHej9ms2YYAHX5m65e+lQLGCf024dE8KTugw0mIHs/N2U5ioKCwG4Kr0KkljWpbo5vAy
	sQzl3vQGO7d/4j89ZS8WGA==
X-Received: by 2002:a05:7301:da17:b0:378:314:402c with SMTP id 5a478bee46e88-382814260bamr2455271eec.28.1795006747029;
        Wed, 18 Nov 2026 04:59:07 -0800 (PST)
Received: from 8439c401ee69 ([20.38.40.137])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-382a63059f8sm13482119eec.9.2026.11.18.04.59.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 18 Nov 2026 04:59:06 -0800 (PST)
Content-Type: text/plain; charset="utf-8"
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Subject: [REGRESSION] stable-rc/linux-6.12.y:
 (build)/tmp/kci/linux/arch/arm/boot/dts/qcom/qcom-msm8974.dtsi:4:10: fatal...
From: KernelCI bot <bot@kernelci.org>
To: kernelci-results@groups.io
Cc: stable@vger.kernel.org
Reply-To: kernelci@lists.linux.dev
Date: Wed, 18 Nov 2026 12:59:06 -0000
Message-ID: <179500674598.301701.17208472766834689427@kernelci.org>

Cc from: regression/stable-rc.yaml

New build issue found on stable-rc/linux-6.12.y:

---
/tmp/kci/linux/arch/arm/boot/dts/qcom/qcom-msm8974.dtsi:4:10: fatal error: 'dt-bindings/clock/qcom,dsi-phy-28nm.h' file not found in arch/arm/boot/dts/qcom/qcom-apq8074-dragonboard.dtb (arch/arm/boot/dts/qcom/qcom-apq8074-dragonboard.dts) [logspec:kbuild,kbuild.compiler.error]
---

Log excerpt:
=====================================================
In file included from /tmp/kci/linux/arch/arm/boot/dts/qcom/qcom-apq8074-dragonboard.dts:6:
/tmp/kci/linux/arch/arm/boot/dts/qcom/qcom-msm8974.dtsi:4:10: fatal error: 'dt-bindings/clock/qcom,dsi-phy-28nm.h' file not found
    4 | #include <dt-bindings/clock/qcom,dsi-phy-28nm.h>
      |          ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
1 error generated.

=====================================================

When fixing this issue, please attribute this report according to the
patch submission rules:

Reported-by: kernelci.org bot <bot@kernelci.org>

For complete logs and details about the environment used, see the issue
on the KernelCI dashboard:

- dashboard: https://d.kernelci.org/i/maestro:083dbb76bc1591f8415baabcdfe1aa56de7df802
- giturl: https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git
- commit HEAD:  691938ae89f0ace741b11bd0b1e6b369a8334d46

# Builds where the incident occurred:

## multi_v7_defconfig on (arm):
- compiler: clang-21
- config: None
- dashboard: https://d.kernelci.org/build/maestro:6afd92bd99c74e1a997d3dee

#kernelci issue maestro:083dbb76bc1591f8415baabcdfe1aa56de7df802

--
This is an experimental report format. Please send feedback in!
Talk to us at kernelci@lists.linux.dev

Made with love by the KernelCI team - https://kernelci.org
