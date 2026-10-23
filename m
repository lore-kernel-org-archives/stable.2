Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.46
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792778358;
	b=o6OD5OXsE6DOMTatX2g9PvS9jakv2LOqRYl4oQSH4VA8ueeapYwsKrQx4VONK6Dmx1ty
	 9OPHgzNFcsCfMURnm9mRAVRn4i0Dg1JnGb8EdKLFR/mrdZb8OepWliVLt5q38+26/i1C4
	 aNeuLlUyjHu8eE3RwVoBo+Rt/O27onXGR5HTxcHQfT6LSMrd4Co0+ePaYl+i2Wd49Uynz
	 EaqqzeTu8IBdAkou8U1/1oI0YbZuWEtzP0CSkhVDPfphEL6veWf0tqNmBcpxRNaJJADp3
	 2JIKPTI5rsYxs4d9eNjehVPUXQV4t7Y2m/2qI9I36hDLJOp3qRte2+NY7razM2QgUmA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792778358;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:Content-Type:
	 MIME-Version:Content-Transfer-Encoding:Subject:From:To:Cc:Reply-To:
	 Date:Message-ID;
	bh=MdAbwTQO0AAuxssRDpcTDcBZ0+YQLP4jO8SP6YasX7E=;
	b=Mn0+H/BB1LIpvyC42q8VfdE8BbaQ1CVcoaelNXKTrVMWrLKzmb7YpnBQmdNZ/l3QFd3u
	 OLucjjCQxX5q44iXxV3whOb+reLlBcme1SZUxrCPN3GJKfz1gakQCVqFHBluQGBPwv8D3
	 aCZntHkjPWIk4SNsxD64VCDoZ+DTRtv3YFToqfOr/96Ha9GjeS+bAED1uMlyNQ7ynLURu
	 zfvCbxjaCOtEzBb0Dy9mqPAXtM3MKu/1SnEAD2gTQYBtlLJ90LGUiXJFDCkieU99KtRGc
	 Dd3OG1BqSdZWxYQSUtEsXj46ZuN5i9fWASaCjnU5356F1EG74VfiTDDqKSQsZJFCIhA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=kernelci.org;
	spf=pass smtp.mailfrom=kernelci.org;
	dkim=pass header.d=kernelci.org header.i=@kernelci.org header.a=rsa-sha256 header.s=google header.b=YZ663VYy;
	arc=none smtp.remote-ip=74.125.82.46
Received: from mail-dl1-f46.google.com (mail-dl1-f46.google.com [74.125.82.46])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 628B3606A321
	for <stable@vger.kernel.org>; Fri, 23 Oct 2026 17:59:18 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 628B3606A321
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=kernelci.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernelci.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernelci.org header.i=@kernelci.org header.a=rsa-sha256 header.s=google header.b=YZ663VYy
Received: by mail-dl1-f46.google.com with SMTP id a92af1059eb24-188406bb948so940839c88.1
        for <stable@vger.kernel.org>; Fri, 23 Oct 2026 10:59:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci.org; s=google; t=1792778357; x=1793383157; darn=vger.kernel.org;
        h=message-id:date:reply-to:cc:to:from:subject
         :content-transfer-encoding:mime-version:content-type:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=MdAbwTQO0AAuxssRDpcTDcBZ0+YQLP4jO8SP6YasX7E=;
        b=YZ663VYyBWyWS195dyOuDr6uF+9rhfYmPw3BoWVCyYEJGHJhCovAuuPuurW4tcJ3Uv
         YqWlL06dyWyzM2/+IGlZtBe0FTMR10LxssL3Dyk6XMGGM8eOz/1QPfahwsIm+v6gri58
         MxONA8zxXehWoMtpdK5Q1wdHvbTTKfBHyGjM63h5lLeDgkp5gmFubM+9JWA8m2av3ItZ
         0cwJEH6KlFnvldsRtdYNYKbGTrhs4keNrTOedf/m/WRcwQqNSCgZHdUc8GBO6Lj4qCjL
         +/Geyyrsa2gBgyHUwZnPq45wsDgavoUSD94x9QLZszZtZEN+67LjzdRfZJW3aio/a/nd
         uf9A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792778357; x=1793383157;
        h=message-id:date:reply-to:cc:to:from:subject
         :content-transfer-encoding:mime-version:content-type:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=MdAbwTQO0AAuxssRDpcTDcBZ0+YQLP4jO8SP6YasX7E=;
        b=vIedFyFH/clC/Hbs+6dc5zrb3hIH8nZr6umOF55rAgEIcJzl/dH93K/pOvqCRRPWSN
         e6BErhEPJ7jtXgb3j9qSvkCE4xXJrhPKY4RMgDHuRTxmQYTouT/X7D0uY5UJVlLQdemR
         OUZ2X/avBIjfzox7r+97fnwbBlbX+Ba+QEw2K5BUGHc0Fh0nYT+td7zppLAkJ8uo+8PV
         mAAacUMInswF49UCpRtduuXUh+/WMgE060Lw+jTA8sb6z9VB8gCpCmwaF9olej3Nekys
         mSKXgDgAC/Il8zGyGUx0pB5Owl3pziW6mqUDC8/Dly22SibDqFCWXRX8I8tLkK5t7wTH
         oO0w==
X-Gm-Message-State: AFq9FYLKWM8liUcIRek2FdVy4F7o/AgLCXV4VpYTViJuA348TYlqWyEw
	FKN0QqhzmebjQFZvE6F+uH5ox8LPB1MCXmP4C4dnuJt6uj1cCuR9V9eYTKWD2Z6yRpP653Vh9T5
	v7C6T
X-Gm-Gg: AYBFou2duH61pKpkgIM0KJWoRCE6JLsLI6wb+VX+ASLId1J588K7qWU4plJksCaX4bN
	af3DbFBrPuQoC3YANzuFEC+2LOahfDBDY4ssaiElH3L2rDeXoghmCg5XStBfkCvkCauHjpQmR2G
	HvXtCroFJwiZ6F542fT0X9tWB6e4GsJCA78+acxSe6cwsrZs7oNfi4J4MCwVPTllvCUbK5vxxIj
	XO0hYTemToT5gpSNna2Z9cHd6wTsjvt6q6GVgUuafVX83QQNcBxmAaBa74PbZqd1r6lgR4zWKnC
	6qHn1Qv2o/Oy0RM/7icLyLZr5cwC3yh46KV7wFklBnSHax2NCNBAhXkbAv4koi2WtrEHJ6n+MkR
	KaAdBQDigRpjIBliQzJGDJVqVDUTj47Yeu8by90iPJF1AZCckQNwSI2JGjw27VBEPrQBoaBBy3R
	LUQaVLjSkhj9Cnp6HUDhUa4W7aTZcFqP28aIwTYleRMb+kGn0M6CP1+PLDtss483aenOmQyRg+L
	aCK4lAi+neHJrH5f5qf0vnGHDnzdT82oVLiB7J2LjE9Kcz7
X-Received: by 2002:a05:701b:2212:b0:149:1b5b:1f25 with SMTP id a92af1059eb24-195c4f4f973mr3044072c88.15.1792778357054;
        Fri, 23 Oct 2026 10:59:17 -0700 (PDT)
Received: from 6e52bff8000c ([20.38.40.137])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-198a1bfaebfsm163777c88.15.2026.10.23.10.59.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 23 Oct 2026 10:59:16 -0700 (PDT)
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
Content-Transfer-Encoding: 8bit
Subject: 
 =?utf-8?q?=5BREGRESSION=5D_stable-rc/linux-6=2E18=2Ey=3A_=28build=29implicit?=
 =?utf-8?q?_declaration_of_function_=E2=80=98=5F=5Fresource=5Fcontains=5Funb?=
 =?utf-8?q?ound=E2=80=99_=5B-Wi=2E=2E=2E?=
From: KernelCI bot <bot@kernelci.org>
To: kernelci-results@groups.io
Cc: stable@vger.kernel.org
Reply-To: kernelci@lists.linux.dev
Date: Fri, 23 Oct 2026 17:59:16 -0000
Message-ID: <179277835551.362500.4805176370233812752@kernelci.org>

New build issue found on stable-rc/linux-6.18.y:

---
implicit declaration of function ‘__resource_contains_unbound’ [-Wimplicit-function-declaration] in drivers/acpi/acpi_platform.o (drivers/acpi/acpi_platform.c) [logspec:kbuild,kbuild.compiler.error]
---

Log excerpt:
=====================================================
drivers/acpi/acpi_platform.c:92:21: error: implicit declaration of function ‘__resource_contains_unbound’ [-Wimplicit-function-declaration]
   92 |                 if (__resource_contains_unbound(res, new_res) ||
      |                     ^~~~~~~~~~~~~~~~~~~~~~~~~~~
  GZIP    kernel/config_data.gz

=====================================================

When fixing this issue, please attribute this report according to the
patch submission rules:

Reported-by: kernelci.org bot <bot@kernelci.org>

For complete logs and details about the environment used, see the issue
on the KernelCI dashboard:

- dashboard: https://d.kernelci.org/i/maestro:020f7ba53cb9aa377916d1fef4e8154fc3a10959
- giturl: https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git
- commit HEAD:  df222b43007251fa44d69b6294830e4a3f9289c2

# Builds where the incident occurred:

## defconfig on (loongarch):
- compiler: gcc-14
- config: None
- dashboard: https://d.kernelci.org/build/maestro:6adb8fce55fda50760744c89

## defconfig on (riscv):
- compiler: gcc-14
- config: None
- dashboard: https://d.kernelci.org/build/maestro:6adb8fdd55fda50760744cb6

## defconfig+arm64-chromebook+kcidebug+kcidebug-arm64+lab-setup on (arm64):
- compiler: gcc-14
- config: None
- dashboard: https://d.kernelci.org/build/maestro:6adb8fa655fda5076074498a

## defconfig+aws-ec2 on (arm64):
- compiler: gcc-14
- config: None
- dashboard: https://d.kernelci.org/build/maestro:6adb8f8e55fda50760744941

## defconfig+lab-setup+arm64-chromebook+CONFIG_MODULE_COMPRESS=n+CONFIG_MODULE_COMPRESS_NONE=y on (arm64):
- compiler: gcc-14
- config: https://files.kernelci.org/kbuild-gcc-14-arm64-chromebook-6adb8f2b55fda50760744556/.config
- dashboard: https://d.kernelci.org/build/maestro:6adb8f2b55fda50760744556

## defconfig+lab-setup+kselftest on (arm64):
- compiler: gcc-14
- config: None
- dashboard: https://d.kernelci.org/build/maestro:6adb8f7e55fda50760744891

## defconfig+netdev+nfs-root-boot+kselftest on (arm64):
- compiler: gcc-14
- config: https://files.kernelci.org/kbuild-gcc-14-arm64-nfsboot-6adb8f9755fda50760744975/.config
- dashboard: https://d.kernelci.org/build/maestro:6adb8f9755fda50760744975

## defconfig+netdev+nfs-root-boot+ltp on (arm64):
- compiler: gcc-15
- config: https://files.kernelci.org/kbuild-gcc-15-arm64-nfsboot-ltp-6adb8fa155fda50760744984/.config
- dashboard: https://d.kernelci.org/build/maestro:6adb8fa155fda50760744984

## i386_defconfig+kselftest on (i386):
- compiler: gcc-14
- config: https://files.kernelci.org/kbuild-gcc-14-i386-kselftest-6adb8fca55fda50760744c7f/.config
- dashboard: https://d.kernelci.org/build/maestro:6adb8fca55fda50760744c7f

## x86_64_defconfig+kselftest+x86-board on (x86_64):
- compiler: gcc-14
- config: None
- dashboard: https://d.kernelci.org/build/maestro:6adb900455fda50760744d8d

## x86_64_defconfig+lab-setup+x86-board+kselftest on (x86_64):
- compiler: gcc-15
- config: None
- dashboard: https://d.kernelci.org/build/maestro:6adb8ff055fda50760744d77

#kernelci issue maestro:020f7ba53cb9aa377916d1fef4e8154fc3a10959

--
This is an experimental report format. Please send feedback in!
Talk to us at kernelci@lists.linux.dev

Made with love by the KernelCI team - https://kernelci.org
