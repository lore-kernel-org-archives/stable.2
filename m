Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.210.51
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793039926;
	b=LwNsPzy2RtWjKjiy4jXFpFjedVKSuFb/wi7oLo64SN0u8v3AXvbY6HXOUDkkE/zg8zMy
	 N2cJBjZdGy/s732lwOgDlfxvWqzfcBViLsmsbxTFWuCQhisfaNXw2tljkSOJuPkPxRDtK
	 pmuOzW08Fz9XX+uUR7j+W8tKzRRyB82MABZZtIVwnaVQdS0Ik8fl0JJ1loe3zkcYZyA/R
	 ZWWeTMbiVDJmGjNS6JUy9E1tCRfQBN+xURcB6qWvRu4KeYZ5m4mzlSbMGtjBErJkhX8Rd
	 zQpgGMFdF4kJ0czYHMWtQSydSfjFG5YllIjdBBFvU6FWKSvz1T2nRZgtvXdqrQJJzOw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793039926;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Message-ID:Date:MIME-Version:User-Agent:Subject:To:Cc:References:
	 Content-Language:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding;
	bh=qtkfCa1ACFlx/Umc0D+/jZFN6SiMdUN5vaZm0FGpPXQ=;
	b=KoVL6V7kUWUhUp5HHUZezxi6j/mIsc28HT1QHe/48zpm0A3bQjD+ZM5AmXGs2+gsR2WC
	 +TDgh6k7GOUH30qCX3HErls85mKxn4mhZnLb2iKdNaL95h16s0BbPMS90cqoDgDJYyqQY
	 zkiQNui2gVQZ0+Q2/QFxMpms+mfJYn1Du3TPUO1NFjSxA/lINNjfK1kkRBHthVFq1Qugx
	 Ze6Gj+VB4I8qLE88wxj8kas/yqQdPHrqB3j5itwR38ZBN8BxXLpSKImRhD1316GVIPC7x
	 s6EdnyTjQ60+/qLDZgU3jkm7jKCDm0D4ZUVQ3qZe2G99Cb1vht+TstCq4yJ4pjwJeiA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linuxfoundation.org;
	spf=pass smtp.mailfrom=linuxfoundation.org;
	dkim=pass header.d=linuxfoundation.org header.i=@linuxfoundation.org header.a=rsa-sha256 header.s=google header.b=gbqFxgya;
	arc=none smtp.remote-ip=209.85.210.51
Received: from mail-ot1-f51.google.com (mail-ot1-f51.google.com [209.85.210.51])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3D61D606A31F
	for <stable@vger.kernel.org>; Mon, 26 Oct 2026 18:38:45 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 3D61D606A31F
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.a=rsa-sha256 header.s=google header.b=gbqFxgya
Received: by mail-ot1-f51.google.com with SMTP id 46e09a7af769-8241a56cd70so2160353a34.3
        for <stable@vger.kernel.org>; Mon, 26 Oct 2026 11:38:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google; t=1793039924; x=1793644724; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=qtkfCa1ACFlx/Umc0D+/jZFN6SiMdUN5vaZm0FGpPXQ=;
        b=gbqFxgyaSJpwnPMXEHEl8DRMN0FH5f+eZmyf7f2x5yINhWDC0h+TI9fLbmGVXrriTb
         IVX2UKfZbpWhTHtZSiooDsuNCBRCnMLM30hT6S3h50adSBK7Pw2Deh6iFyu8CBclN/z4
         9C4rCb+Un3r64IpzDxakAemSIEHFSiRml0wqY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793039924; x=1793644724;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=qtkfCa1ACFlx/Umc0D+/jZFN6SiMdUN5vaZm0FGpPXQ=;
        b=m83Ou9FzMJkYexOWzAJfsHqJqyyV3EUkifeve121MI2lCPpeoybEQhSseVk1u8U/P0
         Ldtb+tn2AdiXOdJRnI9JZ4FXouqHgn8OPCEOGeGVGsXUnwESusqNku6RRbINEYpGN5Kc
         DT0KQQ/pUnXrIZBNzP+UjFexIjvIJdjQoSEfG9THsAP6pvsxnWY9LRXhnaLpDfVQxehp
         D57HOIImZlrkFirEu6YVlwwk244TDWcgkN6xzUreGfFCi3sHJFSIEoUAOlqFjQjpInLY
         DSsf6JevMwatXvk563vRmuB1JrrZ7/86uuIBihoSvy249Qrm2DbMxc527XIfv88eBJh/
         byGQ==
X-Forwarded-Encrypted: i=1; AKwUvByoI+k/74Aaj/9dif7ABWiBmDqxQ3fBezC2rah1nGlzaLpiG/9pc0rBkss93a/7RuuQcX0sH1E=@vger.kernel.org
X-Gm-Message-State: AFq9FYJSxfLDKH2KJBSK+ShxhWaGbrHs8F+72zOoZTEbzvc4gbedoduu
	Qki8YRy/WXXG2vcr5Y3RUebOPQAskxGUhnlANHMp6WDJsRrbFTqyyo692VXE/zklqho=
X-Gm-Gg: AYBFou01nNjY+w6YoFkRSLQSBl/VbS1YYj6aMiGxKDPVh3n46OUCtosdctgvfvq3Ftm
	+Xm/lKFPHLDh/KxIZ4mt/n5sUzEYlwtUV1wWrxsRbq4j7vUk2UMbiU6ueeBYiUeVXiR+1d27fVW
	v5IIrEapRw/BiK/sihPACIy3HZ+rs63MkaQ3c+2VFc5+PmyrTPAg+PT0KBcsqhfh8ieS8A9OULX
	WpUrG2JGeb1GIPMYFhWODrVP2ttVbBcdzV+b04eVIdthrQ0I9439Em+/Q4o+Zr1QIDM/wr1UdAR
	ShWPsfr7zVkysLUe6w16a3Lgt+1dfvQkGd+qeIS9Vzh6e17UHmBts7At5QhxfpSWMGcqXsmbWza
	V7+CdP0CA+chmeLA21qK7qbT0R3YMhr8q+GdNOwmhQvwy/OlkpCx/g+E02aAfdO7883CxwMDxR7
	Gikt0VV+ffFNvrKWnHCiFI9lZ171tS8RhUqZyeweb5kt9vCOSxiHfgeYkYylqk67tHH+sFpK6NG
	8flNt8UanjwfKV9mFcVHvZ7msVxWXL4fMCiOV6ADXVvzx6b7FhrCNxXHYMrSjxHQ5c=
X-Received: by 2002:a05:6830:2b11:b0:834:b015:aed2 with SMTP id 46e09a7af769-850fda467b9mr5329495a34.6.1793039924057;
        Mon, 26 Oct 2026 11:38:44 -0700 (PDT)
Received: from [192.168.1.128] ([38.15.57.99])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-850fa99bd35sm8395712a34.8.2026.10.26.11.38.40
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 26 Oct 2026 11:38:43 -0700 (PDT)
Message-ID: <a072b675-62ef-4076-b3fe-7a344516e992@linuxfoundation.org>
Date: Mon, 26 Oct 2026 12:38:38 -0600
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 7.2 000/231] 7.2.13-rc3 review
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, stable@vger.kernel.org
Cc: patches@lists.linux.dev, linux-kernel@vger.kernel.org,
 torvalds@linux-foundation.org, akpm@linux-foundation.org,
 linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
 lkft-triage@lists.linaro.org, pavel@nabladev.com, jonathanh@nvidia.com,
 f.fainelli@gmail.com, sudipm.mukherjee@gmail.com, rwarsow@gmx.de,
 conor@kernel.org, hargar@microsoft.com, broonie@kernel.org,
 achill@achill.org, sr@sladewatkins.com,
 Shuah Khan <skhan@linuxfoundation.org>
References: <20261025125805.309934791@linuxfoundation.org>
Content-Language: en-US
From: Shuah Khan <skhan@linuxfoundation.org>
In-Reply-To: <20261025125805.309934791@linuxfoundation.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 10/25/26 06:58, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 7.2.13 release.
> There are 231 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Tue, 27 Oct 2026 12:57:40 +0000.
> Anything received after that time might be too late.
> 
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v7.x/stable-review/patch-7.2.13-rc3.gz
> or in the git tree and branch at:
> 	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-7.2.y
> and the diffstat can be found below.
> 
> thanks,
> 
> greg k-h
> 

Compiled and booted on my test system. No dmesg regressions.

Tested-by: Shuah Khan <skhan@linuxfoundation.org>

thanks,
-- Shuah
