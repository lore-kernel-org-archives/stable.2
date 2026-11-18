Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.179
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795006753;
	b=kb4x3EssNeVuzYkzlDjfiPHKNcluL9qtoWZqf6b2MaDdDYKFiKarYt3FWJJE+w+dxNK8
	 y+aXD8Y2urkbcm1Cjr0jHrYu1DYuiPDi5NiOCbYSfsv2XvNsUBaNP8T+Yg195xI1NiVMx
	 14r9HoRZQIjqLTu4cbZIING6gAcPrXd4AY1iwlbu/Ej/qdz4HKxAt14xWfk0XeqRBEFs2
	 ZevazFuBa9oUcM+NY6hJ/hkRiPUArexJoDiyBAGKERMcYLuvv8yosaqs9nyDmgrNUZ3i2
	 dt5Mnzp88PIhB+gfgy7LSv5jTbRxRxGt8GQGKopV7XgxF/lFizetxUC9X5Fpen3Dqpw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795006753;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:Content-Type:
	 MIME-Version:Content-Transfer-Encoding:Subject:From:To:Cc:Reply-To:
	 Date:Message-ID;
	bh=a5mMJBmV7l+mN+FVOFymaBA7JoEKEPpl5VS2v4YnITg=;
	b=nwv/Mkxx0iug9mkOjNk351EpXk0vXoOUlGc1MH2A8BQYWSNVxZofoDkXe+3hZ6NuVPV6
	 89c17TbV7mB7/8uPs6iGUy8Np6cOiDGra556jGdqKk9gWB4Dz0hBlFNXj9V+UiZHbJCYs
	 6V3bExpx2F35aRrwpwZsD/Zr/SLRVdpc4nc6qi/N7Jsf7PGNGECOo5mibdRmTEvYKl0Z5
	 l1r9KxmANeCFsnnNl/+ZLzHiFL4PE79B7i0OTDWT1pKq4t9WJ6S9rZIvEMwQ6d4VPjB8+
	 b1yoNyVbYJUZ6qV6srOr63qyUnxGDIYHsIgSjK2oaVzszMzO7xXMPu9M+Q8hPJTRf3w==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=kernelci.org;
	spf=pass smtp.mailfrom=kernelci.org;
	dkim=pass header.d=kernelci.org header.i=@kernelci.org header.a=rsa-sha256 header.s=google header.b=RBYOL87J;
	arc=none smtp.remote-ip=74.125.82.179
Received: from mail-dy1-f179.google.com (mail-dy1-f179.google.com [74.125.82.179])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EC477606A31C
	for <stable@vger.kernel.org>; Wed, 18 Nov 2026 12:59:12 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org EC477606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=kernelci.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernelci.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernelci.org header.i=@kernelci.org header.a=rsa-sha256 header.s=google header.b=RBYOL87J
Received: by mail-dy1-f179.google.com with SMTP id 5a478bee46e88-3282db206d3so2583299eec.0
        for <stable@vger.kernel.org>; Wed, 18 Nov 2026 04:59:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci.org; s=google; t=1795006752; x=1795611552; darn=vger.kernel.org;
        h=message-id:date:reply-to:cc:to:from:subject
         :content-transfer-encoding:mime-version:content-type:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=a5mMJBmV7l+mN+FVOFymaBA7JoEKEPpl5VS2v4YnITg=;
        b=RBYOL87JzpbSd5Oow97L+4bsV7AW9GxbUtXnmv6Hj/aG8bgoE8UwhRBG6Oztai4UM2
         AbQHxC9Ezle3Y7m/Kj97AQIzQPEAfltGtv1G5QdT/7Dm7KeAKlwGQAxrG8TKzp/vfdf1
         CbUOahlGdNb++fzJv8Ukb12lpPNlazoHTsYe23x0ornD7R6y1tcHWAkmsQ7YviSZl0je
         htv6U+JT5D3lVMFBH1dfxefDJeLWuGYtpmIB6UdrTnGRHEo9IBcEzyQ8x0rhELll9ATy
         tG13fQwBcyXFrToTlBtOiZwfmOSK1eXvA9tXhdszyJm/ymHz4FBnB7zz7bhIswf0dWOk
         u11Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795006752; x=1795611552;
        h=message-id:date:reply-to:cc:to:from:subject
         :content-transfer-encoding:mime-version:content-type:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=a5mMJBmV7l+mN+FVOFymaBA7JoEKEPpl5VS2v4YnITg=;
        b=EbAw0/0NBjJnwCxptsQQv7eD9Pkw6KD+wyoRd6ZmspcilOfWeM+7r/shHX2ZzBt0Do
         sSF4gmkk84YrYSJ0RnHdpC3h4c+KV8wXWq/ObbFmA0VWVybomHr/C1Y/Q/Nb58wf6wTS
         L5xxrfvzwfbjBRU+nT04fBBE67T7PtfC9jDuQPL8Q/oAg0TU6FiJpWeVZ9Qlw1Ya5xDj
         6ONcf+YJXCEISB95B/Lh5fAnHNDcgRW6AGKAkgCViPK4zYkQU/EfS2cUoeYjFoXsJqU6
         1xF3uN7/uBDBg6FdqjXeLrujaXzP8yixJrFg/msE7Uza2A416idQvSBqHhxzhXZDeJg0
         GTFg==
X-Gm-Message-State: APuU4Z9fbpnvFA4mBi2sXSP0Jk5zi5LgtFYnNULCJK2sb1ug1s2dLmO/
	Sinfecaeece9DprZ7ppkv9PYpG6BzoNkSrlwkYxh46+cPIDYWScTONElYvSQOMcNrsxpgTVuu3L
	c0kFu
X-Gm-Gg: AZFdTZcUB+/WB9tnHo+CeL1y6YpJs6eri1zQlio61OQN/DdV8xyCBeDfuIAbUKRI8ib
	Q27eT5UMq1ANv/ZKYNzOqXZ2uFx1XhEBWSCrU7W+nVuQmWZiJGnJ3s/NqUSyBvt8n9tdsmXDpOU
	pxqesqs8jMdXb/XzDK7LeRm5fj1e5Sf8grWiro7Ld/jxjrhzvAyVixvoMpAsPbrOpabdc4efXbU
	o2SvIsWeJnkNLFUQYsWkrIdr8JWCoJ1wAuMcU1klexVbuUOlQ78L8Ipsti1JxkfWXmgb7/vuoce
	en+WYdHrFwJS9GKPepqn/+xCsattIIDRpl/1rCmYFgqG6l39Prw08ntUWdVc6MXgJtbkJRuXocu
	+q+WRGI7tXtvDP50jEN0H6G/WjHFM0hiFDAKwMRxJ/OB70cmhmamT1q3JB0BQVCJ7ndv0HiZY7R
	oOuGBDc0o+6Fm4HEGvzy/yopPR1RO+f5nVRMGF/ZgyaU/+ajlOL4BmKZ3dSxrFQcOH4F5/rAFG/
	NlZ1513+Pg/ZrHY0bgbXLTQram5n1rrTOoqsBXS/mRYvq/3vyoaeXmJIm4viog3+l6PqwB1WUz6
	JMM3QiQczgw8w8CsOebpUUcwseX8WCWup48W7CwASac=
X-Received: by 2002:a05:7300:1c9c:b0:36d:a466:9d0b with SMTP id 5a478bee46e88-38280077ffdmr2528315eec.19.1795006751986;
        Wed, 18 Nov 2026 04:59:11 -0800 (PST)
Received: from 8439c401ee69 ([20.38.40.137])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-382a6df02adsm9174616eec.14.2026.11.18.04.59.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 18 Nov 2026 04:59:11 -0800 (PST)
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
Subject: [REGRESSION] stable-rc/linux-6.6.y:
 (build)/tmp/kci/linux/arch/arm/boot/dts/qcom/qcom-msm8974.dtsi:4:10: fatal...
From: KernelCI bot <bot@kernelci.org>
To: kernelci-results@groups.io
Cc: stable@vger.kernel.org
Reply-To: kernelci@lists.linux.dev
Date: Wed, 18 Nov 2026 12:59:11 -0000
Message-ID: <179500675078.301701.17800513716751824784@kernelci.org>

Cc from: regression/stable-rc.yaml

New build issue found on stable-rc/linux-6.6.y:

---
/tmp/kci/linux/arch/arm/boot/dts/qcom/qcom-msm8974.dtsi:4:10: fatal error: dt-bindings/clock/qcom,dsi-phy-28nm.h: No such file or directory in arch/arm/boot/dts/qcom/qcom-apq8074-dragonboard.dtb (arch/arm/boot/dts/qcom/qcom-apq8074-dragonboard.dts) [logspec:kbuild,kbuild.compiler.error]
---

Log excerpt:
=====================================================
In file included from /tmp/kci/linux/arch/arm/boot/dts/qcom/qcom-apq8074-dragonboard.dts:6:
/tmp/kci/linux/arch/arm/boot/dts/qcom/qcom-msm8974.dtsi:4:10: fatal error: dt-bindings/clock/qcom,dsi-phy-28nm.h: No such file or directory
    4 | #include <dt-bindings/clock/qcom,dsi-phy-28nm.h>
      |          ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
compilation terminated.

=====================================================

When fixing this issue, please attribute this report according to the
patch submission rules:

Reported-by: kernelci.org bot <bot@kernelci.org>

For complete logs and details about the environment used, see the issue
on the KernelCI dashboard:

- dashboard: https://d.kernelci.org/i/maestro:e4f051a6cc1eb0c68fc8c44279cb0d8f10b94701
- giturl: https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git
- commit HEAD:  c64522c1923004699e0b1d3245225f0f8df86312

# Builds where the incident occurred:

## multi_v7_defconfig on (arm):
- compiler: gcc-14
- config: None
- dashboard: https://d.kernelci.org/build/maestro:6afd92e099c74e1a997d3e1d

## multi_v7_defconfig on (arm):
- compiler: gcc-15
- config: None
- dashboard: https://d.kernelci.org/build/maestro:6afd921199c74e1a997d39cf

## multi_v7_defconfig+kselftest on (arm):
- compiler: gcc-14
- config: None
- dashboard: https://d.kernelci.org/build/maestro:6afd921e99c74e1a997d3a6f

## multi_v7_defconfig+netdev+nfs-root-boot+ltp+crypto+ima on (arm):
- compiler: gcc-15
- config: None
- dashboard: https://d.kernelci.org/build/maestro:6afd92e999c74e1a997d3e25

#kernelci issue maestro:e4f051a6cc1eb0c68fc8c44279cb0d8f10b94701

--
This is an experimental report format. Please send feedback in!
Talk to us at kernelci@lists.linux.dev

Made with love by the KernelCI team - https://kernelci.org
