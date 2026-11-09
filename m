Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.161.41
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794254572;
	b=YIKvoXxkve7OHZQxGQdR8ZuRavNITlHKEaK9He/R+9tCvQH1iHm2keRpJDyGEZzp18os
	 r2sDFLeoQATV1KH3eXVXm5nrYrfM7c5VdTue9Jq9V/Qf/DPvKMhgYPYE4MEILR4WxH/3P
	 gd1BgeL9LTvyzsPPn9UDFooAh5rUa1c2BlVN+fXZ1ZyHZ09JA3eg57NhUjxQRd1HovLFP
	 RSbSlua6c9gRm2mxrn7sYg3LpxN+P8JFFnJACM9pfW+4G8XqgjLCOWUD0+MxPuiJIbb8g
	 BAxwEyj9nl4UJKxjHfUIta0pmcIGjUaWgmd8l7Tn20VrMBDOV4GRsIn9k1+YHxp08ZA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794254572;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Message-ID:Date:MIME-Version:User-Agent:Subject:To:Cc:References:
	 Content-Language:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding;
	bh=erhI7CgGmnjEIhSdlY+i5ow50tWs7bchacWIGAhyT1Y=;
	b=nvdpokzV+LXKgzs7jISRH8HCE9RHlZ6m11u+1YANB2balxbvXZPTP42NXGo2/dY8rFfb
	 JaY6x7Hh1xyKFoChF5etb6c/3PDO6RzfQldDQc0b+MeDtxooMgXCQXzH/A2uxNfbtuDLw
	 t3ci6H8Aat6KDb7LYMZ7Cg83KaqvW1da9WLwruAZIob3jeMoY5aluC/d7o2OJNuAUwAyi
	 H7uRpMY1jM85y3rDH+tLV1CYEXKpvG3CdpLXhrzw1H9TAniPSp90o34+frdxwJxmV6DxC
	 gbB50gZ/ijuBS3T26U8CAxbAu4UaIa4nU6mBZo6yAlXmM1RhnZIv78gSFfxhLcOzwEA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linuxfoundation.org;
	spf=pass smtp.mailfrom=linuxfoundation.org;
	dkim=pass header.d=linuxfoundation.org header.i=@linuxfoundation.org header.a=rsa-sha256 header.s=google header.b=NkwQf4nG;
	arc=none smtp.remote-ip=209.85.161.41
Received: from mail-oo1-f41.google.com (mail-oo1-f41.google.com [209.85.161.41])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 77E9860A2607
	for <stable@vger.kernel.org>; Mon,  9 Nov 2026 20:02:50 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 77E9860A2607
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.a=rsa-sha256 header.s=google header.b=NkwQf4nG
Received: by mail-oo1-f41.google.com with SMTP id 006d021491bc7-6ddef424972so1120172eaf.3
        for <stable@vger.kernel.org>; Mon, 09 Nov 2026 12:02:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google; t=1794254569; x=1794859369; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=erhI7CgGmnjEIhSdlY+i5ow50tWs7bchacWIGAhyT1Y=;
        b=NkwQf4nGPmAtZiWcPVVUOW1mb9v/UEMjXpTwCEjLg5/GenLJQ3M9liEkWkEEHB6qPi
         qI5v7uwsEXE8WZcGoIHbKE3+RibPy6ykDG7ZVLsJzn5LTNzWGrALHUoSlleVZ1LuJtqK
         JetSAEqm0zTeCrF1NUoeKTzPFMoGxg+DcS5DU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794254569; x=1794859369;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=erhI7CgGmnjEIhSdlY+i5ow50tWs7bchacWIGAhyT1Y=;
        b=v/By5DxsxvQSifsJSOZQBOspzhKZMz3q183A5MUuwL+dpCLqVroNMetLChdIQ1RYM/
         Ez8Tnqxj5jmtKQs1bYp7PSsjObIMzV9Kf8oqjk2WmmVKyCTR9ktu97F60nqFYQP5EvA2
         ipU2Ow2dWQQAcEF5XM+g5IAa75Kc/TQoPUg12Ekg7A8KZKovrBmGrYIVYtQEM6ovmfGm
         OqYcfkBCTvZBl9j8qTPeDkh+Ipdx3Ge0M4BKHhGcj19EGfjs25SQ/J0n36vCx4Di+K7j
         rdHgBS4KiFv7C1ZW03zajmT3trcw9U/zrvcD+svtt0OEyody5K302JWiXGFi7aTq7kus
         I/+A==
X-Forwarded-Encrypted: i=1; AL+hErG3ptDPozB4uIxzX51e5VQqpkfS7VOND0eL4mT+FG/X5U9MK0bcdwTUZaoiXHopHSmmmbu/4Lg=@vger.kernel.org
X-Gm-Message-State: APuU4Z9L12A7w99rnP0LN0H3UwAjc/VNHd5hpIn3IpepCs5FUsat7eye
	IYl6YoHfUyQ6YlJwVfblbtHn5Je18MSHWLme5hlkJBm2p+RZ2BM2FXWqM07fwuHHX4I=
X-Gm-Gg: AYBFou1cx/97mcczwj+UOvKmclFrtU3fbwz7YkBs2mPtAdSTFpNLbu5EdIpzwXRHsMq
	j6CGj+ZYV11FTEELZmbCGbR0aGN+ImhcQ0UmDSYOPLrzDWkjeKg/Gzpsgc8cJkNhn21I6BYenc6
	5LcPkHxgXJy7g6VeVH7XDNEGDX2vhHzgUTQd0mVgGxoVxQukIrp+VJg95uZxZsTv24WXyBlwgib
	CQDZyHmXCcNOPypA0LqSWV8YFeWmHshm3PV/mbIxtGK635YqqwRfFCVUMz2ZnpYhWKKahMhf6OC
	Lu2yL2tnRPiBTXerGqe7xObPtt8ZI2b3sUWN7E2ZgE/iWH/DMfglka66hTkgS1WWDANY8EuMSbu
	yqhCAZ+Xa/uSxcU7mTsXPmzwgMqMMiziqPVooBzMkF6WxbbULR+Siv/Nq0COaCKO2IjWNdTCB7K
	OeS+VLp7BouaJmR/Wzq4beaqhfSikGrb5sX0Fic4v6geYQXngYYhnMnioXlutgjNpiUaQ+hog1G
	NxezR7sNBH4jtnAwUUXOHpQ7Z7PXzae3ca+OsS4f2Jfq4wm7oNG8tWXPuCb/8IT/JoaJczN3TwO
	ljTlQR2jRhUCr1qhipAuPpKXjYXbHoZ7UZsxsw==
X-Received: by 2002:a05:6820:1391:b0:6b7:8415:d78b with SMTP id 006d021491bc7-718a5a6057fmr114851eaf.54.1794254569267;
        Mon, 09 Nov 2026 12:02:49 -0800 (PST)
Received: from [192.168.1.128] ([38.15.57.99])
        by smtp.gmail.com with ESMTPSA id 006d021491bc7-718a8f660b2sm109293eaf.4.2026.11.09.12.02.46
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 09 Nov 2026 12:02:47 -0800 (PST)
Message-ID: <0860d94e-c972-4159-8fc2-75885451eb64@linuxfoundation.org>
Date: Mon, 9 Nov 2026 13:02:44 -0700
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
Subject: Re: [PATCH 7.3 0000/1257] 7.3.4-rc1 review
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, stable@vger.kernel.org
Cc: patches@lists.linux.dev, linux-kernel@vger.kernel.org,
 torvalds@linux-foundation.org, akpm@linux-foundation.org,
 linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
 lkft-triage@lists.linaro.org, pavel@nabladev.com, jonathanh@nvidia.com,
 f.fainelli@gmail.com, sudipm.mukherjee@gmail.com, rwarsow@gmx.de,
 conor@kernel.org, hargar@microsoft.com, broonie@kernel.org,
 achill@achill.org, sr@sladewatkins.com,
 Shuah Khan <skhan@linuxfoundation.org>
References: <20261107134939.434104957@linuxfoundation.org>
Content-Language: en-US
From: Shuah Khan <skhan@linuxfoundation.org>
In-Reply-To: <20261107134939.434104957@linuxfoundation.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 11/7/26 06:38, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 7.3.4 release.
> There are 1257 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Mon, 09 Nov 2026 13:46:08 +0000.
> Anything received after that time might be too late.
> 
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v7.x/stable-review/patch-7.3.4-rc1.gz
> or in the git tree and branch at:
> 	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-7.3.y
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
