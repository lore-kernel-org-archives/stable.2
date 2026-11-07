Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.179
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794063550;
	b=ef0TwIJH/UKBqimnsPUj7m6ngFvdZ495mjLzmyAwGKjE6lm3et1qxruNRy78B8R8OOFm
	 ZvRiCIzAmfziYVkq7tFs703mwBpq/gLgyZ3o4EK4bqBofsMqmMn6RiUtdVHU6h819h5d0
	 ehRNg7gEvVrnW5NVeq45qp1mT31SNWUcYWNTIaK+Pm5uKpJgX3Tm0eRdDCCHQ/Cs3xsKt
	 1D0pnmM3FAJQ5yxPt6YDyhBu3C/idp+PaYxfDwYCzHEWjsnDsMhNHExyfE030uGKFyJNy
	 oMYBdaT0J3yEGAzYNyrr77pFBsu/8AbakvMmNHnm+yvnA1x/VRu/zNm2ckOnVhfGjPg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794063550;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:Content-Type:
	 MIME-Version:Content-Transfer-Encoding:Subject:From:To:Cc:Reply-To:
	 Date:Message-ID;
	bh=M9I59tZUkJu3SsIlj0ghniQMBYuug51tK+YlhNCaR9w=;
	b=aWTZG6ijT1Hf14jpwYZRSHRi3UbaKtcHQCaZrkQS8aBHepGIAhkAAy1LjE9N2GH6E2IH
	 2Q7zZfqwLLXYsRv1i7V0ARDgZfr6ib9uopGuJLz8bXL71FScMzW9pTQrwHgr3kvaOZ8zG
	 120vvIBpax/q6qelKCKFFKjAOK7ZRWFLWuzEtu1xfNzbZb9F7o6GlueNiWhqc3iT3CVvO
	 MKmyrY1oKFRPGxof3ol58wguonBi3Ir8AwQgBQF7N4eFw5pOk5m5qJC+clt9nYOwFjgef
	 GRhsa9OazEPoWKV7QgS0/v115qDp0+JrUr9wp7Fgi8cufMLNLqTmc1nf9yWTuDEJY0g==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=kernelci.org;
	spf=pass smtp.mailfrom=kernelci.org;
	dkim=pass header.d=kernelci.org header.i=@kernelci.org header.a=rsa-sha256 header.s=google header.b=NnY+jo2m;
	arc=none smtp.remote-ip=74.125.82.179
Received: from mail-dy1-f179.google.com (mail-dy1-f179.google.com [74.125.82.179])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4876D6082BC9
	for <stable@vger.kernel.org>; Sat,  7 Nov 2026 14:59:09 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 4876D6082BC9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=kernelci.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernelci.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernelci.org header.i=@kernelci.org header.a=rsa-sha256 header.s=google header.b=NnY+jo2m
Received: by mail-dy1-f179.google.com with SMTP id 5a478bee46e88-3282db206d3so3606665eec.0
        for <stable@vger.kernel.org>; Sat, 07 Nov 2026 06:59:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci.org; s=google; t=1794063548; x=1794668348; darn=vger.kernel.org;
        h=message-id:date:reply-to:cc:to:from:subject
         :content-transfer-encoding:mime-version:content-type:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=M9I59tZUkJu3SsIlj0ghniQMBYuug51tK+YlhNCaR9w=;
        b=NnY+jo2mKhuJ/S+mhWX4cHnxBxYU/FOyMiMQ9bmLhp4S82FLGVXS+rvt3IYPk9Id/F
         iTZKGzvnD+Kk36WuMhn/UR2LJxJJwJLvcqMPmTG97SXhH5/ISjT8IqNBAiGEVxx2ANHv
         R4Wc5eD+C46mA1LcH8ozT8YkqAuZcmizPizsruAbXWZLMHIvEGRqEtDloZeEPQuIogev
         8E2YrT3QpJCN0/cDgo0p86elJtlYazuaB2fLAzmyr4duEqfRQdWOyNrv7HwEMCOOp7CZ
         louMWIAQ7X43J/23NzxQZJ1WVJ60u9yMD1PpkqCzbzF2c4CQMT2YA9Qs97O8ilnyMgxj
         Y2XA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794063548; x=1794668348;
        h=message-id:date:reply-to:cc:to:from:subject
         :content-transfer-encoding:mime-version:content-type:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=M9I59tZUkJu3SsIlj0ghniQMBYuug51tK+YlhNCaR9w=;
        b=pxkHBkwcTc+ghjpJiQy6UfqFvElQEUyAjg2XdFygnnFAtUrmOmCV21rRy5as8rPs1N
         3E3okg7ds6Jo7ETgeEaccuG1GPXaQ955+3zsHuIruwpQLrWq6K1dwYU4tp91rs/e/8He
         a4KM1cZ1qoVRttcQVDaqQ6LT5J1UNNmzubD9/GBz5jvkGfd89yNtxLGdm2nEEF7he/zZ
         2IfY2JNJMYLrLlFi8swHqjmctnlqa9+scy49XQ4rU1PeCQvSus6TBufZwd8HXJt8Z9TF
         A46rLu53fJMzFNJ3Mnm/nZiHdfQvt0dT0DlUWtLvLGNfZYO7YrYMCO4zGle/7cmE/HBc
         m7Ng==
X-Gm-Message-State: APuU4Z8zxbIKiEnwCZtkB/a5uMmpU2IlJzgA2XpsycqG9ScqoA/ap/ze
	Hu0hm+2+4U0qratJxlTlzrU11+pcdA03r+Q+Bo2Kza7QO0/7pxGwoxCOloDucMbDhIPzGw5A2Pq
	rVJxB
X-Gm-Gg: AYBFou1NboaADf3RspRDr2bzVmjU0hHpFoMFUAHRbQob90rFHcpgidxgGciPoW9tl8u
	JF7JGU2c1JYKpw/VzOnGrQ4x5QuXVsYQE0kCojv0SK42DHrghMkUClNa2kHFaUiWz/eZKmd9Wa6
	XxrGMnPr08zbnaBmsw1RCaD1R88EgqHP5AEiglZ3quHzttWzjSQ4+DO0zRpHQc8WoT6noUGiKss
	eJkt2ri1SyVrkuI5GH37hrlHDyzfkCZfyHveys5pZ/fe5RUkdA+6swcEmSjtKaCMJ3MLBonPJMx
	WQnLNDCUQYTvcqdqOBCVhzVlAAKOYaLML6MGflAB6LHSzVAxFhdi2vMU677/stGusRTRauYf8Pj
	5s3ekH56Pt21s1YjdmU6i/fGireiewe4WKnN4xpPql+k8pD7C8ptAFE3PA+NXusd+OF5XfWFg1c
	WyNE3cySBoynR3pvHf+FqULXjHIS4+82ZqhJ+CjCsRt6RZ6pj0NFgfN8mGZovkd5KM2uVUcTOK1
	RiRRYWrS41UwkeXRi4hd2JjVCFU0QdakbU6nzpa3/Sf687IcGy4MtCWbT5Bs8BW/6kqprMgXu2F
	WP0Fg+g8fjmU5+aGA7kC4g==
X-Received: by 2002:a05:7301:5044:b0:36d:4570:a32d with SMTP id 5a478bee46e88-36f727d41ecmr8241473eec.2.1794063548392;
        Sat, 07 Nov 2026 06:59:08 -0800 (PST)
Received: from 34406640b1f4 ([20.38.40.137])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-36faa6a649csm16763177eec.26.2026.11.07.06.59.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 07 Nov 2026 06:59:06 -0800 (PST)
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
Subject: [REGRESSION] stable-rc/linux-5.15.y: (build)linux/cfi_types.h: No
 such file or
 directory in arch/arm/mach-imx/s...
From: KernelCI bot <bot@kernelci.org>
To: kernelci-results@groups.io
Cc: stable@vger.kernel.org
Reply-To: kernelci@lists.linux.dev
Date: Sat, 07 Nov 2026 14:59:06 -0000
Message-ID: <179406354527.477229.3973475863060849354@kernelci.org>

New build issue found on stable-rc/linux-5.15.y:

---
linux/cfi_types.h: No such file or directory in arch/arm/mach-imx/suspend-imx6.o (arch/arm/mach-imx/suspend-imx6.S) [logspec:kbuild,kbuild.compiler.fatal error]
---

Log excerpt:
=====================================================
/tmp/kci/linux/arch/arm/mach-imx/suspend-imx6.S:6:10: fatal error: linux/cfi_types.h: No such file or directory
    6 | #include <linux/cfi_types.h>
      |          ^~~~~~~~~~~~~~~~~~~
compilation terminated.

=====================================================

When fixing this issue, please attribute this report according to the
patch submission rules:

Reported-by: kernelci.org bot <bot@kernelci.org>

For complete logs and details about the environment used, see the issue
on the KernelCI dashboard:

- dashboard: https://d.kernelci.org/i/maestro:233744f37edfc04604bb8c9c0af351e081a5c51e
- giturl: https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git
- commit HEAD:  59e2b400009b8e4dddb59189d3ce116e3c0fb6f7

# Builds where the incident occurred:

## multi_v7_defconfig on (arm):
- compiler: gcc-15
- config: None
- dashboard: https://d.kernelci.org/build/maestro:6aef39765b429d354e114fbe

#kernelci issue maestro:233744f37edfc04604bb8c9c0af351e081a5c51e

--
This is an experimental report format. Please send feedback in!
Talk to us at kernelci@lists.linux.dev

Made with love by the KernelCI team - https://kernelci.org
