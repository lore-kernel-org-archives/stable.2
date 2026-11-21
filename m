Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.128.50
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795225894;
	b=yDQLtL8UV2GC4Wd6GHRpACs9NxDZ8bAQmWS5+I9hlv+wGdPIUpSIo/JXangVe1UYfVqs
	 8Gr1RAxKpEle0lF+ZBCbavmU8H/qHDuSr6gITD1Vu3Y42UORVVgyem9P4GtlkoDTZJ3cj
	 yIBLIj6ys0koJmAdTf7qloTlaUkOpAyc+EdemWe+cdtRhjVAoHcLCN0iregqcSB9eAUcz
	 n+y4W5d9a8176fmu6j+c3mmp/RHlKLV43v9FaqMn8ht3HHTdeBvxzidO+SCvBwm+nMXOc
	 q5ScrUes3RSignNDRDH9kOn+vhOwYOUW64IlZ+5oPYdUEXgQOnflwpYSo50n7Xampmg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795225894;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Message-ID:Date:MIME-Version:User-Agent:Subject:Content-Language:To:
	 Cc:References:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding;
	bh=ZhsI3lhwD+t6nMHv4Tk5Gvew3vT8WrKD/K7/YEVJPaw=;
	b=ikiWO+NYoPNhxenpbSTVJN/e85ApEcoyQyqQ64xuY/3YYQaVajP5DhpumROaHCJBqCsk
	 Jz1oULzTVlRPliI/K8F2vgZaKh/su2LUErfpNTEHfc+yHDIiiEllpfiaMomb2QaCMwUnB
	 tKN5emsIohEJGyB2ng8V+kcdg92A1isCRTkWs8UdNFaGxNfUZa83Hza0zfJ20TQiTA7SO
	 F3mIrkQkRyRZNwqIrApXiXeZ8/pGLyV7MP1QixQ7i32r8lN0aiep1Qt6m6keK3dp6algf
	 7MxQAVQG+Eq6dLSj8OEYhJ3zX2q04NkFwj20zg/KaAllO8tr38s5tpkuti5ZFrsRnKA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=googlemail.com;
	spf=pass smtp.mailfrom=googlemail.com;
	dkim=pass header.d=googlemail.com header.i=@googlemail.com header.a=rsa-sha256 header.s=20260707 header.b=GriKDtLc;
	arc=none smtp.remote-ip=209.85.128.50
Received: from mail-wm1-f50.google.com (mail-wm1-f50.google.com [209.85.128.50])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B6738606A6BE
	for <stable@vger.kernel.org>; Sat, 21 Nov 2026 01:51:32 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org B6738606A6BE
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=googlemail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=googlemail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=googlemail.com header.i=@googlemail.com header.a=rsa-sha256 header.s=20260707 header.b=GriKDtLc
Received: by mail-wm1-f50.google.com with SMTP id 5b1f17b1804b1-4a3517554f7so15095795e9.2
        for <stable@vger.kernel.org>; Fri, 20 Nov 2026 17:51:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20260707; t=1795225891; x=1795830691; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from:references
         :cc:to:content-language:subject:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=ZhsI3lhwD+t6nMHv4Tk5Gvew3vT8WrKD/K7/YEVJPaw=;
        b=GriKDtLcKMPkRF/s4LcGU+eYEMs7fQYr22/aNjOx4fsc6pWNjyZ3GImkVKDKtSL7x6
         zWDh5CHOzoo9TAfFQy7nb5hkSoqJ2bSL/qgWuP1EqmHCp77whYR9V+NmP37krlDqJP7Q
         76m+Y6tk9gUFlnCl4fqfhcxRIkZ7lkTlS7pexjcffvLFP3VaK+a6KWh+HXC7Bew+ngRI
         AzM9p67nKW+D7oQzpkx4i2gH4GrKTlB3KwrxBtxxuxA9WGpCLyqmmOHSrz2NhfhzxwHP
         d6tFLfUX+a4OQM9Kj3StAxUJzqL7NWKBWUdJll9GB+CWWnC9SC4xcMCeEd2PJe9Xq7rr
         uKcQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795225891; x=1795830691;
        h=content-transfer-encoding:content-type:in-reply-to:from:references
         :cc:to:content-language:subject:user-agent:mime-version:date
         :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=ZhsI3lhwD+t6nMHv4Tk5Gvew3vT8WrKD/K7/YEVJPaw=;
        b=bft3z41urp1cWLuRWjys2IXRFLUiXcJtwM+U0cAxEa1rCOrV4INRMVvFfR2h8DFcnk
         3ULZgofgHUrb9ej3usam0X8UPOA3FUc4Mkl8E44y4Q+M+S29PrJZoTpV4C+P6CFUA7WE
         nTJZl8ox4qF+AJ42bHpxWfUWadnJIBLaLaZYMyaDxXTi8+UBu5DhhdFzPqS0YuwlM17F
         V6tCF95d1aP5u3vJMXomPjCQ3j/9eQKypm8buS8h1gFaI7Evwr8Ba/1g83lmPh4pkoKe
         FO11wsW1BOG8CLjfOCl0vRtrAT0ZquG8uXo3pMpCDc3nVy0czjTVlnTJBHkeh0x3H4i/
         OsmA==
X-Forwarded-Encrypted: i=1; AL+hErG73Rzz/n6JdzcsRPqobA+gPlhqvNNIukT+VIZLZCe83uVfOQJWVAae5SeRsfw8YlVggaAcRl0=@vger.kernel.org
X-Gm-Message-State: APuU4Z8ivEMycrgz9X42bzNnaBjMUnX0K9ajkfFtwQKxQBT/f5zm4xqM
	XJVu1SsO3YBMdAUT+KcVf67MHXR40TfzTM6qUjB88RhS5O9J4ZZqwXU=
X-Gm-Gg: AYBFou2T7sN3isQJgnAjUcwLvNogvtSlQaMAVh5Cyov8/nQh8RxFOB43n3H6LBozkbC
	TDQz2XLPJ4YuXfL+dZgaQJnbdKy2X31XsX51i3hFTrs8gkYfE3uPV1Mkn+HkNJVuxUMWDosnS4+
	NpVhwKq0YedzPSr8CPpYRuFsGhYrH9+wIdnUnw3kcvjUDfx5MntX+sYe2BaDZesbNtjaL4O7jCA
	j4OaJnTi2HjPXxiya8pY9Vf6dcJNMCPYXH6dz5d6Pci03f+6suFNkL2tS8mkeCFKSo7Ldr/BEei
	WooOSlKtt0dzRx47lakDbLa+8rjd+Juwo3uwLSBEw6fGo4MJanF2ByObr0udBOSHjm+48gM6X28
	3YtEvR/A/QjUilsLVzGjE0NBtlAZopeqpLy4w2tzUXlfjCwNGpqhbmfqNanOjK69AXQ/oGUfl28
	oF1p7V6UbxCe827VZwtASgbRbOH0dZ+FTTJBcU3AdqEIc0QbtaGRxlpKramIumnbgA3IcYfFEuJ
	LRL0K0a1HBgaPdQicP5QNUQuhhFHQS6XSCc7zpSrf3amJCOtfQdAjudGmhsY3ipxsUXQZxwjJk4
	/9JC2X/IvsjFuRSrBeJ1EGOV6QcKS0ILBPZhLhnA6UoQbzwNNA9reaoHmCSceFqah8EdSXjqT6j
	2MJ0=
X-Received: by 2002:a05:600c:a51:b0:4bb:5f43:23bb with SMTP id 5b1f17b1804b1-4bb88828173mr107576685e9.33.1795225890849;
        Fri, 20 Nov 2026 17:51:30 -0800 (PST)
Received: from [192.168.1.3] (p5b2b4923.dip0.t-ipconnect.de. [91.43.73.35])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4bb85399d52sm150309475e9.6.2026.11.20.17.51.29
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 20 Nov 2026 17:51:30 -0800 (PST)
Message-ID: <4f3c5405-fde4-43af-9624-6a28041e673c@googlemail.com>
Date: Sat, 21 Nov 2026 02:51:29 +0100
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
User-Agent: Betterbird (Windows)
Subject: Re: [PATCH 6.1 0000/2812] 6.1.193-rc2 review
Content-Language: de-DE
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, stable@vger.kernel.org
Cc: patches@lists.linux.dev, linux-kernel@vger.kernel.org,
 torvalds@linux-foundation.org, akpm@linux-foundation.org,
 linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
 lkft-triage@lists.linaro.org, pavel@nabladev.com, jonathanh@nvidia.com,
 f.fainelli@gmail.com, sudipm.mukherjee@gmail.com, rwarsow@gmx.de,
 conor@kernel.org, hargar@microsoft.com, broonie@kernel.org,
 achill@achill.org, sr@sladewatkins.com
References: <20261120055200.707545519@linuxfoundation.org>
From: Peter Schneider <pschneider1968@googlemail.com>
In-Reply-To: <20261120055200.707545519@linuxfoundation.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Am 20.11.2026 um 06:57 schrieb Greg Kroah-Hartman:
> This is the start of the stable review cycle for the 6.1.193 release.
> There are 2812 patches in this series, all will be posted as a response
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
