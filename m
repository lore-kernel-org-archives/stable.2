Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.181
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795618770;
	b=rq3/onWHSzYC8ng5dfV3I4kCtOG1ZGp6WLEGCxbh7ViIiLCcyQ8sr47s/m6foy8pMT+N
	 daZQa+wy/vn4d67B3WKHzPmQxauswcH3KuI12EnCfLoky6hBPRoEZ0xb35z3xPv7kwqj4
	 1EfEnUjZe/CsALdF0n2mNmo7/KPi883IknQSgXiBUOsmFuRjHV1G2M8p9A9REzAKgzy3m
	 J1w8iiFlb9IjNflQbHoePHZHFyFQ53hTfn8cI0x9kQB1SQWloWvrwVrxJFIXUsoO3EAin
	 5TdkW6zUJ1N9imIICVQ5ZoiRc/7wMVvXIPfRplxhP4Wzz4yvVwFEwLlh/x8wcfRiKmw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795618770;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:Content-Type:
	 MIME-Version:Content-Transfer-Encoding:Subject:From:To:Cc:Reply-To:
	 Date:Message-ID;
	bh=Xm78hw65Ko5AyJSpziphpWa5efhwx1WTcjmnvGu911s=;
	b=FfqCVauEyEHVT9cxOjX/nIvB6MjeFeh1WmU5x5oMDehUBIQKLBLH3ZNnQEGom2Prmwp5
	 mjn/KcZo9AlcVW9LOVDQsFwdDvtYdLdn1LKuaDAE2w01DOXBVY8NGlIz5kibJKqH6dyh5
	 oV1u0bAOyzHdhB3fLIMOsmQzFC2Faed9ZbhkHE6PIrN4MDlC+KOzi6scqYHJOc/9Dt60J
	 JCm+rZSAKXk/XCJladAWgII0kXdJtkm9gK16dfVzc5/s2M0qY7K8tBJtlcmCM1Q5tbyyT
	 b+PK3Y5Pm2d68mmweDpagQcH/xCc7xAOOsXJ9d+1VNdVnte74J8ZWssiYpf3BkeFbZw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=kernelci.org;
	spf=pass smtp.mailfrom=kernelci.org;
	dkim=pass header.d=kernelci.org header.i=@kernelci.org header.a=rsa-sha256 header.s=google header.b=jZBKjzaD;
	arc=none smtp.remote-ip=74.125.82.181
Received: from mail-dy1-f181.google.com (mail-dy1-f181.google.com [74.125.82.181])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 16999606A321
	for <stable@vger.kernel.org>; Wed, 25 Nov 2026 14:59:30 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 16999606A321
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=kernelci.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernelci.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernelci.org header.i=@kernelci.org header.a=rsa-sha256 header.s=google header.b=jZBKjzaD
Received: by mail-dy1-f181.google.com with SMTP id 5a478bee46e88-38190551625so11620585eec.1
        for <stable@vger.kernel.org>; Wed, 25 Nov 2026 06:59:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci.org; s=google; t=1795618769; x=1796223569; darn=vger.kernel.org;
        h=message-id:date:reply-to:cc:to:from:subject
         :content-transfer-encoding:mime-version:content-type:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=Xm78hw65Ko5AyJSpziphpWa5efhwx1WTcjmnvGu911s=;
        b=jZBKjzaDR7NICr9L7/gxPpfLjEv6IJSMvH338FM1YjU7SrYhePKO2owYICoYtE+Dt2
         sJIfEQ3sm2i4qHkV/3TqaiiubntAKzBPakyi/CeXmmHguGlBseu4pr64XvgNmW3JiHX/
         7AOxhAUzyonD3Tym073kWAByugNos47KgTdXGlW3Bk4gQYN8qOlSwLGH6J4Eg0pT5DBM
         hR2RWsdHHCVtJ6ryodshONGhAnCR7hqMIlRofEYMFp5dVJOjE24+2wUljoHIUgHckXWQ
         0Y7Oti5wnK9c3MeRo3kFBLD7Ocg+4C2h8VZnIW3xtJp4gLFfsRGFvHNxxU2uKQG0YZES
         IpBQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795618769; x=1796223569;
        h=message-id:date:reply-to:cc:to:from:subject
         :content-transfer-encoding:mime-version:content-type:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=Xm78hw65Ko5AyJSpziphpWa5efhwx1WTcjmnvGu911s=;
        b=IykJklBJaKMJ5sJVV3l2Bm76235WtyGVrkpXPuLMcF/KRTnNU1V7drLfpL+iOO8d0E
         zfNGPCBJr9v2uKlT+fbb7YctgC/W6FKr8wU0Qm9ns4a4ciLivxQQx1fmKTOUMzpsCcRw
         OQTLJwYwhrCSXpuaNmhMRT2n7yBbxU69HdhrNa3L+Ar96nrTPMPkm4XjQnd+cVTT9atK
         yjB64RXwFLbjqqX3p0wDd17G1HI/0GXTKOrjbbkYS6UU0e288V2I5PHJ4tpLV5Xk+Cuw
         kKiOt5jk2SxDguwhwKWMq9Jm6TCqsYyJHLHsaGpzgXUsZEXhB21T6zXs4h54rwmt/Y2w
         gg8A==
X-Gm-Message-State: APuU4Z/Knif/94G4T3RfOe+Y8Csv4DHrZjuQXOCzXdEUeGVIIROTCZ5u
	2oEI0y3i7EKcMUsrwovNRXkpsRmcbJ1/VEmfKYCZfN5WzTaNwfdsxJlIsqld6HIAsmE=
X-Gm-Gg: AZFdTZcnfUa9pZN0drCe3THXPXZ4o8jUWX376uiLfzYHkjDs8T2uVIeGKu7vkZqoQQl
	bZXdqInIallS+a3crW4QZPEC4I9DukkBYxXUGlQyc+e3VukusM3Sf0ksgyqOFdns6elVlnKnaCy
	UorlgGjYutFeqPKhRcnenaOjSNE3nxpHQaDaIcTKSuh+xMXJykg1561AFryczCbPMW8/LIzwXgO
	zohQi78f1jNz0lps1CWAT/vHijEwhWTWw9GOVb0k489yLWhyvYhx/rNS0oti0g1jXjZgYRuxH0B
	bKTusM/LJ+/BmgamKWkAWvAcTykYaP32+AHmAPgA1NADJ3+vDPWH4MjTEP6Twx9mQu0RbrAjTyP
	hqCZaA1VCc4WlaFl2Jo3SUSkqvb3ArPN+5VVgVCNOrengSwxo0+spT7cbh4VqwkdGw6t/h1qOHK
	hZwxbCIomYbiUQeZebqunDBJBblcheYdLj/5BiAv1ModUzOvWCEjqg5f6f+K61RWHKw0FfUlGJR
	rvpu5BibEonuiHGFpiCakQ10zGLQ3ndseT9ekAs3uMugTBtnGqMcuZPcXBfBRpJTOu8KLE04lN4
	msfCs/bBDW7S3az7Z8K/Ung=
X-Received: by 2002:a05:7300:6da7:b0:384:5885:2f81 with SMTP id 5a478bee46e88-3856c0c7c06mr653455eec.5.1795618769070;
        Wed, 25 Nov 2026 06:59:29 -0800 (PST)
Received: from 52d83ede7c60 ([20.38.40.137])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-386b1965c02sm24656302eec.27.2026.11.25.06.59.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 25 Nov 2026 06:59:28 -0800 (PST)
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
 =?utf-8?q?=5BREGRESSION=5D_stable-rc/linux-5=2E10=2Ey=3A_=28build=29implicit?=
 =?utf-8?q?_declaration_of_function_=E2=80=98init=5Fflush=5Ffput=E2=80=99_?=
 =?utf-8?q?=5B-Werror=3Dimplici=2E=2E=2E?=
From: KernelCI bot <bot@kernelci.org>
To: kernelci-results@groups.io
Cc: stable@vger.kernel.org
Reply-To: kernelci@lists.linux.dev
Date: Wed, 25 Nov 2026 14:59:28 -0000
Message-ID: <179561876780.101431.12231577479808549847@kernelci.org>

Cc from: regression/stable-rc.yaml

New build issue found on stable-rc/linux-5.10.y:

---
implicit declaration of function ‘init_flush_fput’ [-Werror=implicit-function-declaration] in init/do_mounts_rd.o (init/do_mounts_rd.c) [logspec:kbuild,kbuild.compiler.error]
---

Log excerpt:
=====================================================
init/do_mounts_rd.c:277:9: error: implicit declaration of function ‘init_flush_fput’ [-Werror=implicit-function-declaration]
  277 |         init_flush_fput();
      |         ^~~~~~~~~~~~~~~
  CC      arch/mips/generic/irq.o
  CC      arch/mips/generic/proc.o
cc1: some warnings being treated as errors

=====================================================

When fixing this issue, please attribute this report according to the
patch submission rules:

Reported-by: kernelci.org bot <bot@kernelci.org>

For complete logs and details about the environment used, see the issue
on the KernelCI dashboard:

- dashboard: https://d.kernelci.org/i/maestro:af8739d40ff8199d25578188231a7fa47a6270b5
- giturl: https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git
- commit HEAD:  8e2fb60ab96e45de1da9779df42907b2dd01b85f

# Builds where the incident occurred:

## 32r2el_defconfig on (mips):
- compiler: gcc-14
- config: https://files.kernelci.org/kbuild-gcc-14-mips-32r2el_defconfig-6b06eecf286e1965ecb35a1b/.config
- dashboard: https://d.kernelci.org/build/maestro:6b06eecf286e1965ecb35a1b

## imx_v6_v7_defconfig on (arm):
- compiler: gcc-14
- config: None
- dashboard: https://d.kernelci.org/build/maestro:6b06ee7f286e1965ecb33041

## multi_v7_defconfig on (arm):
- compiler: gcc-14
- config: None
- dashboard: https://d.kernelci.org/build/maestro:6b06ee8b286e1965ecb3306b

## multi_v7_defconfig on (arm):
- compiler: gcc-15
- config: None
- dashboard: https://d.kernelci.org/build/maestro:6b06ee77286e1965ecb33034

## multi_v7_defconfig+kselftest on (arm):
- compiler: gcc-14
- config: None
- dashboard: https://d.kernelci.org/build/maestro:6b06ee83286e1965ecb33044

## multi_v7_defconfig+netdev+nfs-root-boot+ltp+crypto+ima on (arm):
- compiler: gcc-15
- config: None
- dashboard: https://d.kernelci.org/build/maestro:6b06ee7b286e1965ecb3303e

#kernelci issue maestro:af8739d40ff8199d25578188231a7fa47a6270b5

--
This is an experimental report format. Please send feedback in!
Talk to us at kernelci@lists.linux.dev

Made with love by the KernelCI team - https://kernelci.org
