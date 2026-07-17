Received: from mail-qk1-f180.google.com (mail-qk1-f180.google.com [209.85.222.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A1000351C22
	for <stable@vger.kernel.org>; Fri, 17 Jul 2026 19:21:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784316086; cv=none; b=C8t25YsBMnBcJemTnXN6wtfjdWfob/MVR/V8M459uYRsfm3rXFaCS2hsxwBSplUPxBNRODXByIX4kXT8AcYoSQCc5g/OQhCEiz9UYQ6li3qxFpKpehkcEIedGpBxC4+10e4BDNGLPx2Qjn8izb+nMBbeZFJQY2aHJNq3gT3Fg2M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784316086; c=relaxed/simple;
	bh=TNZU/YiFC+FsIbAl1irw5ZUIraHra9PmNSU39qnz7m0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=UJ6KVXNtH77kXJO5cb7hwJt+baMdjVjNssoZXaEyCKYr7OhImR/g9j9KyBj6BwAKP40xXQabMLt+77urisTehxFWAj6ngQJuEaUvlDjzFCzuhe92oDSPe+Kqqn1myi6dmCY3vEhSVDE6gzXwLqW2BN5TVagsF09ow59nfSsIctA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=dn84AMpC; arc=none smtp.client-ip=209.85.222.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dn84AMpC"
Received: by mail-qk1-f180.google.com with SMTP id af79cd13be357-92e7632b193so512918385a.2
        for <stable@vger.kernel.org>; Fri, 17 Jul 2026 12:21:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1784316083; x=1784920883; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=CDkCqE8cWXVEopMtK+O2wnclYWikImjloNtGs1ltFx8=;
        b=dn84AMpCmIE0Sizl9oBdUuxUvtRO6bRgik8qj9BapqnS41D5+kGsvAuSQJ6tTNJOL7
         sltUwGxYfh55k+uSgi+E05k8rnhVhdUZ/l5coFGGLkR2vdoEO+RWRkPoo2PcYGoGy8UJ
         5nQ4pHUaA4bczP/V7ErjkdejpOEB5UidNzZ5EAJpIgFTc+A9WTerdZqE51YobSjEnQyy
         s3uUKPc0sOXHuJLTyg8YArfZkInPS+lAIuJDeexK1VEt+fDISS+QJLqkLeXT8paT8Fih
         E0xT8flaRuCYwCp/5rIH2MFbELX/GZ5uPT+N1HfCwLIsWF/AdauxBULnXWxnKY+vlZ/5
         rz9A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784316083; x=1784920883;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=CDkCqE8cWXVEopMtK+O2wnclYWikImjloNtGs1ltFx8=;
        b=dYcBoJya1dcQ7PWqSNB6wn2Vbz5/faTF2i+JRn72T4s96I88PdMdGajgvXP7iV1nbT
         E0IPQ6uRCyaq3dgceQbsNGViK0Gt4MfRfjbYanCr4/ZZ7KI1k/LnqZg5IOiHcvuKmA5V
         M+KYg10Giv8FIGYTRWf24U+HI671VoWIEHJ1B9uI1bKB6ugDYdSbpMK/4LSZIDTALomy
         BOwQwRsUqhG6oB5NBSFrnwFXsVZUg9JWjzPbkyFsV4u8sFE03gMvgP56fh91dZsU57m1
         oAdNbAeacGG7hLpxeFLzY1ShqbEsfC3/U5o5WvJPCSHSlXFtKKV2Yy4BQvY+svB33udr
         K/nQ==
X-Forwarded-Encrypted: i=1; AHgh+RpBd2KnVhfNEspmhe5b8q88cqRchejp1rl+7b3e13qCbomqGNfQVGafn42jyam7BY1LVWupcPE=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx7C9GHwQ55mM1tiTwQhoZOo7m8k6kLQ5bMMGbolmkzCcbx26GJ
	NIpLOGAmVTrEq9/tnpe1pmt1zF3Whf0bjgWtQcpSMxfHlj0Oiqqsum/x
X-Gm-Gg: AfdE7cmEoV/2gjq1dhrOIRVXnWyGUHsg6Beg0zD1IhlGS4QDW5AjBbrFkI8F4AzEfbA
	nY0J6LC3ED8YikkZrDIuvWLSN5I9oaAtLkyRSEKXu9+h8MYggZdvbv81ScuKIiI3TC5TjKuOsto
	Z0tF4vdFdyGeItaDBr1Sr+4mP07t8KxI/otPLaomMbo5St+YetvuRFPTaBwEf892YysIsOYMiSH
	xtMATXrDyOKOfEnqfwlklsrZJvk5g90M1JG+Zc0+wFEYKoDiAbwj9DzZwX0gTQHcf4NF9FWh/1p
	G7wPVuyMp5Yp/ORdpjyC63yxJ2PQlxMUogV3++jmJQAf80gASQsGXkW91i4XE0p+rKfky/y2irA
	jNSRpAmwErla6CDWJHKsrOm2EMfqp3c5h/fs67UMGm7LNszTI5eqGUgk5ZZYYPDeJSifnCKiQ15
	5MC75VWxOmYWO589tLIDyG0itmuQrE
X-Received: by 2002:a05:620a:2246:10b0:930:bb30:6921 with SMTP id af79cd13be357-930bb30701dmr197590085a.29.1784316083411;
        Fri, 17 Jul 2026 12:21:23 -0700 (PDT)
Received: from [10.67.48.245] ([192.19.223.252])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-930b5494cf0sm229407685a.46.2026.07.17.12.21.21
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 17 Jul 2026 12:21:22 -0700 (PDT)
Message-ID: <3caf8d09-8c05-40ff-bfbc-2c3695d10bf5@gmail.com>
Date: Fri, 17 Jul 2026 12:21:20 -0700
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 7.1 000/533] 7.1.4-rc2 review
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, stable@vger.kernel.org
Cc: patches@lists.linux.dev, linux-kernel@vger.kernel.org,
 torvalds@linux-foundation.org, akpm@linux-foundation.org,
 linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
 lkft-triage@lists.linaro.org, pavel@nabladev.com, jonathanh@nvidia.com,
 sudipm.mukherjee@gmail.com, rwarsow@gmx.de, conor@kernel.org,
 hargar@microsoft.com, broonie@kernel.org, achill@achill.org,
 sr@sladewatkins.com
References: <20260717101912.682013354@linuxfoundation.org>
Content-Language: en-US, fr-FR
From: Florian Fainelli <f.fainelli@gmail.com>
In-Reply-To: <20260717101912.682013354@linuxfoundation.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 7/17/26 03:41, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 7.1.4 release.
> There are 533 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Sun, 19 Jul 2026 10:18:26 +0000.
> Anything received after that time might be too late.
> 
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v7.x/stable-review/patch-7.1.4-rc2.gz
> or in the git tree and branch at:
> 	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-7.1.y
> and the diffstat can be found below.
> 
> thanks,
> 
> greg k-h

On ARCH_BRCMSTB using 32-bit and 64-bit ARM kernels, build tested on 
BMIPS_GENERIC:

Tested-by: Florian Fainelli <florian.fainelli@broadcom.com>
-- 
Florian
