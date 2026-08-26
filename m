Received: from mail-wr1-f47.google.com (mail-wr1-f47.google.com [209.85.221.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 32A8A383305
	for <stable@vger.kernel.org>; Wed, 26 Aug 2026 12:04:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787745885; cv=none; b=AuqoJohqKLiWNyHcfJ/ZsswQc/iyMicqJmsKy/+jyS5B20oJXCPi55riSfue8qH2iTxekt3T7mzqRvEB6LyajHaDmAHtzVxBkKx7VVHpD1SFB75P6V+JLVgWwQvSseWlv58GUcHvl56+f8LlaKK+GvN+hieLPgXIW6jyT/76okw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787745885; c=relaxed/simple;
	bh=t8r9fwHDfwrrDslghKcdGeSg+FPh7HR538uqlbJfIIs=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=YFCU6AhQRSzwmEntOcWRQRZdWzkPYemsAFUhDm3pbFIrqOzKZ2fDyF2U/uj40v6KIZ5U30iP9f07IlnLXBb3sJ6iffvqY5436nLM00l/s8WJpWGsybcQdvo/vEsroOU1b2fOhB4FpCCAmS7GNmazwC7PaT3TUPBJENo8LHKfafQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=googlemail.com; spf=pass smtp.mailfrom=googlemail.com; dkim=pass (2048-bit key) header.d=googlemail.com header.i=@googlemail.com header.b=h+Xp92A6; arc=none smtp.client-ip=209.85.221.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=googlemail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=googlemail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=googlemail.com header.i=@googlemail.com header.b="h+Xp92A6"
Received: by mail-wr1-f47.google.com with SMTP id ffacd0b85a97d-482c58a8683so656078f8f.0
        for <stable@vger.kernel.org>; Wed, 26 Aug 2026 05:04:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20251104; t=1787745879; x=1788350679; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from:references
         :cc:to:content-language:subject:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=LUtXgdw64E4AMmrHZa4KMdOAunPgCi0nfhsHNUCmvGQ=;
        b=h+Xp92A6JT8K9M/eIAOaduLyo42C5MT1xbj+AKhqSB+O38iXn+UoxtPpPWnftY21/t
         XAzVR72sxW9wY0YdtlF5tqCrZToxl8QlCSK1TyheUGAH3HAclPDcZc1PoqjquwDIjWeB
         hHK0KfnrzB9IvkgB/gyVzI9AW70PzmYlz2/v99/G0z3Fbo+x9Ic4EnljKk/pxgrRn3hi
         qM6YPQuC0wAy5TUe15+viLMwikVUn8Q/EjcZMoG7hOnL7Q1xRI0eJ8eoYax+O9bt3mqD
         jCnaHnebvxqlUnshXkMZ+c2Isj7aiXFXClyJOlv62gluwI/39ITLrkVb5uUHYfpe6/wV
         sH9g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787745879; x=1788350679;
        h=content-transfer-encoding:content-type:in-reply-to:from:references
         :cc:to:content-language:subject:user-agent:mime-version:date
         :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=LUtXgdw64E4AMmrHZa4KMdOAunPgCi0nfhsHNUCmvGQ=;
        b=erorMOJIYjgm1EY13yGa4tJnF5l/XDphy9uDAksfmzzVB/VJAYGx7aBaLRDtY89IeM
         idZi9x5DxXuYX/LjHkNj1soGROzoajJS12NnQcE0KQeauO274QXUNokeqswXjElCREpQ
         EnFKXWptrtxHaO6SUJkTFXboSuAAjsLPoDChHfjzYtD8egz00ZDpbbaYjh/7mfo1XIM4
         7LtpYCJAcLr5tUhYC+JTibuuAOoseWVc5WZFXT2drrujxQoEGZuC9LGbNcThhsFk/kvV
         DzElGwKwHJTsq5s71jDhnroFDY6rbZOuAwFcnuGN2v3g15H4qqYXVLyGVTXSQu1T/ILb
         tEGQ==
X-Forwarded-Encrypted: i=1; AHgh+RrH7z58kTR9QyzHdarL+nxGfxvHsgbMA8SI4z8axhUgtmX8paSw5pWnSnAexJGYdCeemGkd5tY=@vger.kernel.org
X-Gm-Message-State: AFuF++k3+kExK6WQHzlB91BmQmON5h2/1gdf1cnRjnCKCVV0LNLlmLB1
	Tc6Mx938vMFUReQBF+80S57aaRFIzXKxrUZ8t2tWnFG4pMWpnqG15mhcEhA4
X-Gm-Gg: AR+sD12UAjRpvCjmMTZQf/ud938Dbh4PWfTfo7MifpHHJzWpdZNdkKWdKvIbpKrvrfr
	T5eEsGEQ5zzzyEqtwerV3aUIXJhFCvIya3F7hzVNo/UgG9tiFFr6iZ1y1CZLYCSM6APWJ21BR/f
	CrUEfmhtaob2GyBi96RN9Pz1zpNkiN0mcr3aFIInHZmPfMPPDOJt5RqTWTJHZUD8P9OolYt5VKA
	XZHUbzEcjVNMxQtMyhTqDpH4ewDb3W+L3bUS4W3nIk+9Fv8bcaUM8uSUv1lKeWF8ErJjLWKs87w
	Mu4U0TCX/QV7+7CyaLupULRhLLGk5tO7oCcrpbdFLcgm9aTJMXpScBTCylw5mJYJXVknk+5dl6o
	ixt22D/qmY1FbE0qPKE3/XguSoneSi1GsCi1B+5GnzXMEM5Re72kwSaMxSDemqmgxGbntDBNTHQ
	0woPB7dMEYkr5VEJnMJ5w9DALp9F14YE1reGEf46ep5HjAzv0j7M93Q2bxtzdCzMhKNQUHlVqHl
	tpUEwfGVwY+d7Dv/7OmXYry1XjBCxR7eik4LWU=
X-Received: by 2002:a17:906:9c8a:b0:c16:3187:997e with SMTP id a640c23a62f3a-c250bb69c32mr689989466b.7.1787745842844;
        Wed, 26 Aug 2026 05:04:02 -0700 (PDT)
Received: from [192.168.1.3] (p5b2ace5e.dip0.t-ipconnect.de. [91.42.206.94])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-c250dfd6e6asm350863266b.19.2026.08.26.05.04.01
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 26 Aug 2026 05:04:02 -0700 (PDT)
Message-ID: <5c014a1c-9139-4b7d-83a7-746b4a7d14a9@googlemail.com>
Date: Wed, 26 Aug 2026 14:04:01 +0200
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Betterbird (Windows)
Subject: Re: [PATCH 6.6 00/87] 6.6.154-rc1 review
Content-Language: de-DE
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, stable@vger.kernel.org
Cc: patches@lists.linux.dev, linux-kernel@vger.kernel.org,
 torvalds@linux-foundation.org, akpm@linux-foundation.org,
 linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
 lkft-triage@lists.linaro.org, pavel@nabladev.com, jonathanh@nvidia.com,
 f.fainelli@gmail.com, sudipm.mukherjee@gmail.com, rwarsow@gmx.de,
 conor@kernel.org, hargar@microsoft.com, broonie@kernel.org,
 achill@achill.org, sr@sladewatkins.com
References: <20260825132541.813800447@linuxfoundation.org>
From: Peter Schneider <pschneider1968@googlemail.com>
In-Reply-To: <20260825132541.813800447@linuxfoundation.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Am 25.08.2026 um 15:25 schrieb Greg Kroah-Hartman:
> This is the start of the stable review cycle for the 6.6.154 release.
> There are 87 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.

Builds, boots and works on my 2-socket Ivy Bridge Xeon E5-2697 v2 server. No dmesg oddities or regressions found.

Tested-by: Peter Schneider <pschneider1968@googlemail.com>


Beste Grüße,
Peter Schneider

-- 
Climb the mountain not to plant your flag, but to embrace the challenge,
enjoy the air and behold the view. Climb it so you can see the world,
not so the world can see you.                    -- David McCullough Jr.

OpenPGP:  0xA3828BD796CCE11A8CADE8866E3A92C92C3FF244
Download: https://www.peters-netzplatz.de/download/pschneider1968_pub.asc
https://keys.mailvelope.com/pks/lookup?op=get&search=pschneider1968@googlemail.com
https://keys.mailvelope.com/pks/lookup?op=get&search=pschneider1968@gmail.com
