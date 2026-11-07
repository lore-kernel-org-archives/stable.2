Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.174
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794063554;
	b=cgC9EcIq1vNRUhgIzli2pgs6KP6+Jjti4UUWZuzQ5ABsarhrgGl8y6o1ThZF5c5CIY48
	 Yp/kw7NWNvI431XuwhSpcmKwQomIQPZIEFEeMqqxtS+0GUMqLrV3Da2rYL6aRbbYNhARe
	 2RXDQWqsWprP8WNEEYXZD7IVH38OrxxLTS98klxDWANQtYSBCA1MZcRP1dsMdohIJoUPa
	 ShoTFNT3DXLLpbYiDHs8ZSMcZ9jHviZUmMQuQpJVk79b1QXNpZY0IFhXmEjtY9floaM2N
	 QOFVnfoEoT+mGr9LBdODwpLNwoL+kKEZnQFmmrl93nHRJCcF2ZYoef85QN1WNTliM+w==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794063554;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:Content-Type:
	 MIME-Version:Content-Transfer-Encoding:Subject:From:To:Cc:Reply-To:
	 Date:Message-ID;
	bh=fR2GTGjHyhNDJbNdPktknSrLvBkncXuHVFTgw++MrmA=;
	b=f7fzeyNUEbqi7+ZmhOlcMP4dHJbe9BoAC4FOgM1bgUN8ak8wtcothpantQRVrzgE4fQo
	 ShAd/jQqgmGvqMRUzLkHUzA8wPnoUBI1g7arSBjQLwfdf5bSB3DUEQk47rIrlGK+PLp0q
	 Z4lW0HXzE1RWy58BEht16DfYmhHEp39ZacTTJWxZxoH+VjsPNNAA9RhmzJeVzv7qNXrRH
	 iFg8Elann1U/JTE7Hvo69SKV98j6e7zs2FPrK2bojV7RNJZ/8Os+Ve2xufvucWrjg6O6R
	 +AsFNWn1YTQeCDl1jZ7O44JwNbEF9rEvkdS8b9Tx1aDAor+nIS34MP1hdSA9Yn6k6oA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=kernelci.org;
	spf=pass smtp.mailfrom=kernelci.org;
	dkim=pass header.d=kernelci.org header.i=@kernelci.org header.a=rsa-sha256 header.s=google header.b=UWkPcUsE;
	arc=none smtp.remote-ip=74.125.82.174
Received: from mail-dy1-f174.google.com (mail-dy1-f174.google.com [74.125.82.174])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6E12E608361F
	for <stable@vger.kernel.org>; Sat,  7 Nov 2026 14:59:13 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 6E12E608361F
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=kernelci.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernelci.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernelci.org header.i=@kernelci.org header.a=rsa-sha256 header.s=google header.b=UWkPcUsE
Received: by mail-dy1-f174.google.com with SMTP id 5a478bee46e88-36eb1cb7aabso2499645eec.0
        for <stable@vger.kernel.org>; Sat, 07 Nov 2026 06:59:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci.org; s=google; t=1794063552; x=1794668352; darn=vger.kernel.org;
        h=message-id:date:reply-to:cc:to:from:subject
         :content-transfer-encoding:mime-version:content-type:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=fR2GTGjHyhNDJbNdPktknSrLvBkncXuHVFTgw++MrmA=;
        b=UWkPcUsED+EAitXNVMW2meLr+PPSXD3zAwE+GPCzNJihenbHHoZMosGh+J+5UAGZRF
         3Qms3ZVGaA0Z4Q22n+eGKlJeq7rmYtCBkGJYsINEHDA0XOHiXNObS3sYIVi/TcSG03Mw
         utXxMj9kS+DJAQagu5SakMg9uw9nxc3slgSosN3igUzMX8EG5OZvsHSSeOARNFTbx1vO
         so/f0zZGNGUGe5c2ZP8H2SWxEnWKROi+fZOyvDPZlUV8gz2cL8bKhzh9gx8dPdFsBihw
         fUOMGus9KOt1ISoNiA5lMYlOT/EnBrhF4FQaLq6jpecMseLdt0qLzFhL5ARNEnFQEKir
         nsAQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794063552; x=1794668352;
        h=message-id:date:reply-to:cc:to:from:subject
         :content-transfer-encoding:mime-version:content-type:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=fR2GTGjHyhNDJbNdPktknSrLvBkncXuHVFTgw++MrmA=;
        b=iD8uQeTalTiYoR1VZssDi6SPzsX5/cXRDDahDX7QqiXFB6UwhPr36nPshuBd/SFhHJ
         VpDR+nipWQ5KERwVO5EJWLsiQSA8hpAoFelRGeKvMzbNgJwGk2lY687VnrI9dX2ZO1JQ
         XibVK9W+tqrUTBRUcmzdtfXYxH51ojeO0CNOHCmbwmgxtVXh7hhvZRa29G4onRcHubLz
         HalJJLGcyUUUFM8rbyJddU6nauh8+jpfBVlg++FtnS+I+ajbCgqKwGz0w3jfWLCEL+XV
         5UDNzGJe184TscYX6puzYLKXp17Zny+RZR1pPK64ezyWNYlytMz5WLBOoT3e9Bl2rIVp
         elVA==
X-Gm-Message-State: APuU4Z+qevX1kyCWeKpDiCpoTloTcoauoIYLkT+7O9//VdoyV70E3t0X
	0I4J859TQXOrHx/U+LCg7hE8rUiKcbSug1F0ce7UMRSHxPMc957aN1TrnWYG+kpJ0kO/KbWkLvT
	9yfZ6
X-Gm-Gg: AYBFou2UkTS8UokfIr91JvmMyje17ht0ymNhRPtyiSm25EPYdlC2+jnfqcI6przOgNu
	pZKvKigCYA5nxiS3gSgCPkSiLf4m3zHwGx6t7dONMWS3hMB0Jvl1O8GFkr6518P/EX3U5t+DzSp
	3N9HaW01sy+4fPmKddZrsBkFvF2RQ2c8gK7fbNjOPR2BpXV2k5lHeOwtHwInRvgFcrY3QdenRWh
	Q3g2ddLyMeXPXLC+TSZ2iGjN0QN+jgnKiGCaGQeMQ9DdqgPMG6roPrRuwY02/JS4PeIfVZc+1g2
	7+fKiuOniWZxKwL2jUOD9dx7ovdQ7PAA+BTAVgOhBU/+FRsEt2aReu28FHY4JpVM9svEuUqgkc3
	i4eHLVKztAPxkwowJvvXsLJJ6807uJVzRyI1rsQanQ8r8xc4TSgB1n93UIDwlSPHS1dxfMCULeE
	C6v6VGrIZGHTFEBiHLiq4XREAFFkVGnp7vakZs3acxVbaKArNx2n7AodRDRl+3Ac3Gu10KZKywu
	/HLCBytdRz0GDyvQJUPpgcPSEoKFbM2ivoXXxPtY2r4tV1OsjfMliu8cwE96Glar22p+hmTH536
	2ixY4kiSCZWw7IaTkJvz+A==
X-Received: by 2002:a05:7300:10c:b0:36a:1e9e:ae61 with SMTP id 5a478bee46e88-36f7710a6e3mr7904937eec.38.1794063552310;
        Sat, 07 Nov 2026 06:59:12 -0800 (PST)
Received: from 34406640b1f4 ([20.38.40.137])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-36fa8e3a718sm18222128eec.4.2026.11.07.06.59.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 07 Nov 2026 06:59:10 -0800 (PST)
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
Subject: [REGRESSION] stable-rc/linux-5.10.y: (build)linux/cfi_types.h: No
 such file or
 directory in arch/arm/mach-omap2...
From: KernelCI bot <bot@kernelci.org>
To: kernelci-results@groups.io
Cc: stable@vger.kernel.org
Reply-To: kernelci@lists.linux.dev
Date: Sat, 07 Nov 2026 14:59:09 -0000
Message-ID: <179406354853.477229.7656181427115001030@kernelci.org>

New build issue found on stable-rc/linux-5.10.y:

---
linux/cfi_types.h: No such file or directory in arch/arm/mach-omap2/sleep44xx.o (arch/arm/mach-omap2/sleep44xx.S) [logspec:kbuild,kbuild.compiler.fatal error]
---

Log excerpt:
=====================================================
/tmp/kci/linux/arch/arm/mach-omap2/sleep44xx.S:9:10: fatal error: linux/cfi_types.h: No such file or directory
    9 | #include <linux/cfi_types.h>
      |          ^~~~~~~~~~~~~~~~~~~
compilation terminated.

=====================================================

When fixing this issue, please attribute this report according to the
patch submission rules:

Reported-by: kernelci.org bot <bot@kernelci.org>

For complete logs and details about the environment used, see the issue
on the KernelCI dashboard:

- dashboard: https://d.kernelci.org/i/maestro:342a33d4e71e4485572152211755444ef71491a8
- giturl: https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git
- commit HEAD:  7a87f3505170e2196b67ec5e2713c06767ef1601

# Builds where the incident occurred:

## multi_v7_defconfig on (arm):
- compiler: gcc-14
- config: None
- dashboard: https://d.kernelci.org/build/maestro:6aef38ea5b429d354e114f0b

## multi_v7_defconfig on (arm):
- compiler: gcc-15
- config: None
- dashboard: https://d.kernelci.org/build/maestro:6aef38d95b429d354e114efc

## multi_v7_defconfig+kselftest on (arm):
- compiler: gcc-14
- config: None
- dashboard: https://d.kernelci.org/build/maestro:6aef38e35b429d354e114f05

## multi_v7_defconfig+netdev+nfs-root-boot+ltp+crypto+ima on (arm):
- compiler: gcc-15
- config: None
- dashboard: https://d.kernelci.org/build/maestro:6aef38dc5b429d354e114eff

#kernelci issue maestro:342a33d4e71e4485572152211755444ef71491a8

--
This is an experimental report format. Please send feedback in!
Talk to us at kernelci@lists.linux.dev

Made with love by the KernelCI team - https://kernelci.org
