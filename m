Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.172
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794067155;
	b=yFuMhRwUrVK93zBSxQj6H9Py17cna65zCEey+9KXan8Nc76kEKt3z8S8ux/ar3whqGw/
	 srv/AAdoxLKdVBxuGrs5lKRRWRp9tWR+nO/jlpoP70VAWQae/B5f9dxXyadJwluhECKfh
	 xy5/pJAtZ+tnK2UrKxxKqa1dGWjb6oKBlHB6mfYMZeB253DEO7FaEWmHVyNjaSyfusofV
	 sIAUmDYuCHK3+ymop5ez85D9eMPL2AWiMnPntnZ29uMo4sQhZrv6JISCUtWVqhCCXuPS/
	 84VwZ5QPQpSe80rg571QDKD6G0KONSTMmNxwymO6kTgHmgbW4Zcm3/f+SL47aMUzU9A==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794067155;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:Content-Type:
	 MIME-Version:Content-Transfer-Encoding:Subject:From:To:Cc:Reply-To:
	 Date:Message-ID;
	bh=nIgFliDx0GsgHQg0oIX+EwzPbAuaYHifGeNbbSEUnqk=;
	b=BZoeOgeBR0HDBkIaRHi9eZSNO7C2fAHHqVmRO1qTgCDFYixsZOBBO4QBG/NXjVWxT0Vd
	 Rgp/fOcbgppm2tpxIVUXh+5SoUrcdsXdlww0lGTrItAuMzKgh24y/IaCfJz78tor2D4KX
	 jLk0wsONV0NiJnm0n7W7Nk9YEoOIsYRATZibilMXEyrZT08S5iVOgvDia4QrWm4JCtX2y
	 +JwwORSbU9Fz0jwN8XKdj8OtGBii15kWKH5ycf1YgibF58hadn6F7tCNEqPy8ueR8XU4O
	 EZ/QyM6mMV4T5z7/WEcY/oeLPr7otpxq73zbSNfS7Pf5KhvfLwo6crK3iOvPgL1UABA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=kernelci.org;
	spf=pass smtp.mailfrom=kernelci.org;
	dkim=pass header.d=kernelci.org header.i=@kernelci.org header.a=rsa-sha256 header.s=google header.b=WbFubmWl;
	arc=none smtp.remote-ip=74.125.82.172
Received: from mail-dy1-f172.google.com (mail-dy1-f172.google.com [74.125.82.172])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E32ED606A326
	for <stable@vger.kernel.org>; Sat,  7 Nov 2026 15:59:14 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org E32ED606A326
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=kernelci.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernelci.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernelci.org header.i=@kernelci.org header.a=rsa-sha256 header.s=google header.b=WbFubmWl
Received: by mail-dy1-f172.google.com with SMTP id 5a478bee46e88-37071c0f42aso2227431eec.0
        for <stable@vger.kernel.org>; Sat, 07 Nov 2026 07:59:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci.org; s=google; t=1794067154; x=1794671954; darn=vger.kernel.org;
        h=message-id:date:reply-to:cc:to:from:subject
         :content-transfer-encoding:mime-version:content-type:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=nIgFliDx0GsgHQg0oIX+EwzPbAuaYHifGeNbbSEUnqk=;
        b=WbFubmWlR2Y8FwQlc+rWOwKSPATozwsLwydg4DOh/xYna2H8rLQNrzArOgyATgyRWA
         GTjBqnGxXwzOMZbt9GvHHHFJ2HEpdJJ+379t2Tufd16RXBeozGfzssrOBLP+p6KCe7cO
         W1inN9FTsIPuI+ad0poyuSXF/B7u7HGKW+iUVdr9HY0Ikca0ldxyptIwrNg30FVQ6ckb
         o4TJxeUlF2Emorn/lCbhGmuLBGr+zEEtmLpGZSFxKrL19A9Ep/dg26TpP12Z3Ta+Liqc
         RScd52N0HqKiZM0FhFeBefkVTQ12TYS6aOdfvxZuUCWlTvi+JGtHlWZTE23ELS6soeSC
         HSUw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794067154; x=1794671954;
        h=message-id:date:reply-to:cc:to:from:subject
         :content-transfer-encoding:mime-version:content-type:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=nIgFliDx0GsgHQg0oIX+EwzPbAuaYHifGeNbbSEUnqk=;
        b=co9pmAtahI5txMOxA+6g+McEHH7509MORnaXQhW1uoLpmesF3UICp9INDryg9osmEZ
         zrpY/iQ2qn8lgyDhTKDjURoT96llIq6OSo9dqPZJ11JnAnIrIXVCEbJDLVamrI2unUta
         KPD4PzVhcqS0rBKC16f3rnwipRStTc5tN1nMyjrorfdODRkSj65eHYgfNkLsAcc7lQyX
         8O+0ncREtsguy5A2/5QGxAXqv6mMVmri5tv9SYSw4NkbpdjTPuNLDig6BQeSx0cSfcer
         Yi7bkDte34N26jqGGoCI3zCj+HGPy2PixUuRoCq7lbMB4XY4ZujC56NrfLLyH2gZu9dt
         qZqg==
X-Gm-Message-State: APuU4Z9RILLV7avIeu6p1akJhBgVhI36wCJCcnFADuUaRiKNR05lCv+l
	wX9RW8S/Xq28cWXQVyzUXslqKKcI8cvsPCmvidd58P7xH319dcgxqm6UgjoofotrKgKl5l60bF8
	ZwEAE
X-Gm-Gg: AYBFou0zeXMmWTQMbA8WED7nsVOPbPUK6wDzkdJ6yosAHDv00t3mKiF5yEmGby0fqi2
	aiKiVtTdonshL9ikDatWY2NPN5uffu94dFB411O3WQvC388mjlY8Ec+d7/VSNVRtHyzEHw9tDNU
	ifhMXEB1LW5kiTif9b9J8g/QSjujeNMy2q5iDTtPJWU6curUvqfXIfd8UBsDPLIDDZkviNxaNrb
	GPR0eqMC6AME8QCINT40cNY/S1nzUxKjzZ7PFCRRypcc54ilQnNTwhUNmoriAWTqAPwJjAoT3d1
	km9KV2pvfR0IdeVHL8zMp7ebrApFtqvwrZ8o185feIRmOiO+29AXAim+6m4V13TqoTtmgCmFIru
	toJximkI0Uy31c9GQSoNzCV0zT523zkW8ZDEdJzkfjwQTzLrTZt+EY43/W6/80krjiNOM7Zn3Jl
	WX5ZAHTwNzGJRWQ0/rFjvdUHxQgcAU4BF+nwA3502VGec/EL42WA36rHvZw7MCYH0eAO1SBD3x4
	Qwme7/ecERalEdTdK0hZwMhX2SgtPvYIeyEAOS29lZLa13MDqh/mQcccf/p6Ip5Otm+K9dXfqbV
	juaMjVRYnLK5j+BoPWye2A==
X-Received: by 2002:a05:7301:7195:b0:368:7c2d:a612 with SMTP id 5a478bee46e88-36f7494ced7mr7770230eec.10.1794067153823;
        Sat, 07 Nov 2026 07:59:13 -0800 (PST)
Received: from 34406640b1f4 ([20.38.40.137])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-36fa8d44a5fsm15925821eec.7.2026.11.07.07.59.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 07 Nov 2026 07:59:13 -0800 (PST)
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
 =?utf-8?b?W1JFR1JFU1NJT05dIHN0YWJsZS1yYy9saW51eC02LjEueTogKGJ1aWxkKWltcGxp?=
 =?utf-8?b?Y2l0IGRlY2xhcmF0aW9uIG9mIGZ1bmN0aW9uIOKAmGNmaV9nZXRfZnVuY19oYXNo?=
 =?utf-8?b?4oCZIFstV2ltcGxpY2l0LWZ1Li4u?=
From: KernelCI bot <bot@kernelci.org>
To: kernelci-results@groups.io
Cc: stable@vger.kernel.org
Reply-To: kernelci@lists.linux.dev
Date: Sat, 07 Nov 2026 15:59:13 -0000
Message-ID: <179406715268.479450.435225849364303597@kernelci.org>

New build issue found on stable-rc/linux-6.1.y:

---
implicit declaration of function ‘cfi_get_func_hash’ [-Wimplicit-function-declaration] in arch/arm/mach-imx/pm-imx6.o (arch/arm/mach-imx/pm-imx6.c) [logspec:kbuild,kbuild.compiler.error]
---

Log excerpt:
=====================================================
/tmp/kci/linux/arch/arm/mach-imx/pm-imx6.c:588:17: error: implicit declaration of function ‘cfi_get_func_hash’ [-Wimplicit-function-declaration]
  588 |                 cfi_get_func_hash((void *)((uintptr_t)&imx6_suspend & ~1UL));
      |                 ^~~~~~~~~~~~~~~~~

=====================================================

When fixing this issue, please attribute this report according to the
patch submission rules:

Reported-by: kernelci.org bot <bot@kernelci.org>

For complete logs and details about the environment used, see the issue
on the KernelCI dashboard:

- dashboard: https://d.kernelci.org/i/maestro:879b87c04968bc11b409c0217c028fd10c7c5379
- giturl: https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git
- commit HEAD:  07f920ac6ca0ecfc2aa02a15d7f2040bd35c9e89

# Builds where the incident occurred:

## multi_v7_defconfig on (arm):
- compiler: gcc-14
- config: None
- dashboard: https://d.kernelci.org/build/maestro:6aef3a1e5b429d354e11507d

## multi_v7_defconfig on (arm):
- compiler: gcc-15
- config: None
- dashboard: https://d.kernelci.org/build/maestro:6aef3a225b429d354e115080

## multi_v7_defconfig+kselftest on (arm):
- compiler: gcc-14
- config: None
- dashboard: https://d.kernelci.org/build/maestro:6aef3a2f5b429d354e1150ce

## multi_v7_defconfig+netdev+nfs-root-boot+ltp+crypto+ima on (arm):
- compiler: gcc-15
- config: None
- dashboard: https://d.kernelci.org/build/maestro:6aef3a265b429d354e115083

#kernelci issue maestro:879b87c04968bc11b409c0217c028fd10c7c5379

--
This is an experimental report format. Please send feedback in!
Talk to us at kernelci@lists.linux.dev

Made with love by the KernelCI team - https://kernelci.org
