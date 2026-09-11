Received: from mail-wm1-f51.google.com (mail-wm1-f51.google.com [209.85.128.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AA97345629E
	for <stable@vger.kernel.org>; Fri, 11 Sep 2026 08:24:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789115074; cv=none; b=RNX9r+KykJmpaejwm9dzm7sGHASk3xM5HhUOXVQaSD4JcF0DedX9r8a6fNKiEC+Ku1nIvU1WkiD/p3M6PZPQ5dVepoq6DSFL2SHv8iubk9I0MH7rqVY2KwhE4NqeV8iqje8hZmh3BLDDtqoXJDPiwrSWSg2v6UBaxJeUEzDk35I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789115074; c=relaxed/simple;
	bh=Iq+fpSyK4ILX+urSkwlTvDb34gQ3oxCb6Di9PgY+GDw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=bDuZDKlGVm+44DxlCZQWR5nB/1ZxMuU0I7AEso6fsm/C2/wVGfyaXONw/lEu93EVTD+uUDd0TqPXGnVg/IBYfYb/BGkyNkn0+Q1NVl8zLIBgMkLFoVM2VZ2/i6AMYhQIT19ZwnZL6l5/NyvhqkWyClfal5JBVO8uqf0sGPBBNRg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=googlemail.com; spf=pass smtp.mailfrom=googlemail.com; dkim=pass (2048-bit key) header.d=googlemail.com header.i=@googlemail.com header.b=EWe1pMFa; arc=none smtp.client-ip=209.85.128.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=googlemail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=googlemail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=googlemail.com header.i=@googlemail.com header.b="EWe1pMFa"
Received: by mail-wm1-f51.google.com with SMTP id 5b1f17b1804b1-49d0da752ffso8422885e9.3
        for <stable@vger.kernel.org>; Fri, 11 Sep 2026 01:24:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20251104; t=1789115071; x=1789719871; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from:references
         :cc:to:content-language:subject:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=2WWeljkn3dRICBmDHnyIQXWg+zBlpnH6+buSyxyqyJI=;
        b=EWe1pMFaSKyW/8ATBOV5NHQWw3u0iT+K2cBTZgw6KRUmD2/eK+ZpJu09FrYfvHGecu
         C+slkZKWbZGEjHBH04S79zZmYe2ew/ekpBAjw46gn0tqbyc7KhYKX4vyV24zgdUmaK/N
         cR54sITVTPvw0z2AAknDL6y0+e+UpZ+Xr2hJrAARFj/s0Ks8y1pGwCCsn+G2OloxW2QW
         1cN7rC1tHiHb5RZPXpW7w2zrEL8EfSrGy/umJoTiq/khRNvfMentO1+kaGTxvNzWH86K
         9YIo3sfjvnWUZWcPc2tVbnyZVcAC62iEYKSLqNIFMj9laOgdHttXHqpDHJovIvbQCp2W
         SEgw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1789115071; x=1789719871;
        h=content-transfer-encoding:content-type:in-reply-to:from:references
         :cc:to:content-language:subject:user-agent:mime-version:date
         :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=2WWeljkn3dRICBmDHnyIQXWg+zBlpnH6+buSyxyqyJI=;
        b=kAdD6b6TlvVE6ej6SqbgBExMBULHqS9unDp8a54QuJWlnyknqnuk/n2vUvD1U43ekR
         G3dY7lwna4bOS3wfcgfA90D+cy3TjTG78QiNvvgro6zQRHzQu1FpjcWvytlJTYSuiZmE
         B7nQRpt360NeFBAojPaX5HGJPwxpFgSf0TsCXWEP+W6WGVkK3EdDe60g2V5dt8QEUgtm
         o6IYtCJRHJMQIbxzUSYwJEMYj7ppNFtmWnO6b/yBZJr8dyCQQ9f8A4j0MkPIINe9z0aB
         qPH7X9DhhWpqopNeInKyMexafX49YYC1N7f/GB5gikJTCIyO2K3vaEssBx68cOYNiazu
         k2gw==
X-Forwarded-Encrypted: i=1; AKwUvBz9OtCYPQTt+Qy/J0VwdrOk+cPjWAZ4DkVhTJDuI+MJhBANPDXq7oYExEwg1nh1JxZTA/pAnd4=@vger.kernel.org
X-Gm-Message-State: AFuF++mzInsSkhmqw3nx6vfJQ2Z0L1iEAfxDqU0zKlwrCRLtcZ2Y+6uU
	uQ9u4fKD2BwTFMSR+ltuPzILgUHVFvYzjk79j1ZeRQ+6aUNbZXyLVY8=
X-Gm-Gg: AYBFou3EItIt71+P6FWAc+xyWwnKswf1hHNknmagrecdgE0e/YVbvAIrS/DYC0JVByK
	IStCL5Hb5yYthd0EXmuQk5oEPygrQCftHa+IdeIOK//f9fBS7Tbpg/yNAQd6KxjHsm21g+ho7+L
	Fsq9HJMUoLkMPI4oHru3EfkN8Q/HpTdpQbnXMVcmiu048RAmGJ75OtQa9u+rS4ym582gOZMhteM
	Surjxs/bnZGC97mt6fcRLrFwo9xFVlWsRnOB2G5AAJWIgEcGKL3dBtCvoQPXjmfjYEQiL9CI/Jc
	CWeSIeK0JkJNnutxMa1v2wPwOwv+Gkknho48ysF9bThi76TNd+lcE3Ja81zTiPW5YeVbe6K9qdm
	/LLPAUpW59sTHglB6gn+Gk1n5+5yvwAtsKsDY8OmZkULsNib497E30GckVGgunKCeIvTCcSuN/p
	bkA2jPwr4QcwGWpeT++goOJfFP2WfZ0dGBJ6mqhx+Uc1Q57+aBfsXQ6UnjZsfDnBur0o0zwr7iQ
	HkmpT8vleOYYfjAdBSs3wpXeJGN0YB9N45GmvBShLa66nQMBTw=
X-Received: by 2002:a05:600d:4453:20b0:49c:fed6:cd3f with SMTP id 5b1f17b1804b1-49e619c4d59mr22948105e9.23.1789115070582;
        Fri, 11 Sep 2026 01:24:30 -0700 (PDT)
Received: from [192.168.1.3] (p5b2ace69.dip0.t-ipconnect.de. [91.42.206.105])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-49e5765152asm88890415e9.11.2026.09.11.01.24.29
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 11 Sep 2026 01:24:30 -0700 (PDT)
Message-ID: <4a5a443d-28b3-4da5-8749-447ea5b009f2@googlemail.com>
Date: Fri, 11 Sep 2026 10:24:29 +0200
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Betterbird (Windows)
Subject: Re: [PATCH 7.2 000/556] 7.2.5-rc1 review
Content-Language: de-DE
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, stable@vger.kernel.org
Cc: patches@lists.linux.dev, linux-kernel@vger.kernel.org,
 torvalds@linux-foundation.org, akpm@linux-foundation.org,
 linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
 lkft-triage@lists.linaro.org, pavel@nabladev.com, jonathanh@nvidia.com,
 f.fainelli@gmail.com, sudipm.mukherjee@gmail.com, rwarsow@gmx.de,
 conor@kernel.org, hargar@microsoft.com, broonie@kernel.org,
 achill@achill.org, sr@sladewatkins.com
References: <20260909134230.441546314@linuxfoundation.org>
From: Peter Schneider <pschneider1968@googlemail.com>
In-Reply-To: <20260909134230.441546314@linuxfoundation.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Am 09.09.2026 um 15:34 schrieb Greg Kroah-Hartman:
> This is the start of the stable review cycle for the 7.2.5 release.
> There are 556 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.

Builds, boots and works on my 2-socket Ivy Bridge Xeon E5-2697v2 server. No dmesg oddities or regressions found.

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
