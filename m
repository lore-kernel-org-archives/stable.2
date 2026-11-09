Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.51
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794259115;
	b=Yo1IkiAB+vY7vyURHL5sgmhwbAz47B410QiPtGGAQhFfBFCXQd0O2kWaTaNQOXMhiRBF
	 4rJn1P18LGxrNZmubHlGB5ZlgS6aI1iB7oee4B/XACQGXEclMApFgIQ6uTPuHP1ldibYI
	 G/fFFw7jDlQwzc2VOxWrOKlPA9UgNzh0GQOQKe6fRXsz+M2aj7jb7k1csubtnUorB+ORJ
	 Lmh9WGHhVqarZaK2vsQsh3Gb2MtQjllQEefKThith81LLZ8hRpYfBFAUkJCbQM6hj0rlm
	 YyB6DLW2k7ZV5BvPQWMRIXK7ofN1nD3UjRwSOwF6hvcQGDLiICVqvR7dpHIWPCw23dg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794259115;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Message-ID:Date:MIME-Version:User-Agent:Subject:To:Cc:References:
	 Content-Language:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding;
	bh=m1QU3+7laS+fNdEWDXJJYocSvhG3rmU21yfPePi389Y=;
	b=pmlTvBUjtyRFvFMB4KCqQIQd/xZz8VHPkjK7N7wZ945Z9MMm7Fspuc9s4iHvIpzGzaKy
	 ALn1WFTFLsqxpCShdHWZeeQy4V8tpH/BeZsKVGnR5yzhZFpQyMTtlM5iMtq7LSqTiyoUd
	 BhmAvAuU9hVdgrdpyzc+ugFNM9t3AWO8wfu9ZhbLy9epam78zg5DRRmBT0vNn5z/Z0GAu
	 SZC9kWqif9vjxHJyZ3UEMenm2BBySE1ZiPUPOY2qRkNGPnph9ric/UFUlObkobJoPv0r9
	 DKaZBQMbrhO1FtAFyLi5PneylLUWWTVX3YaPOwlculy0QBU4VNqBR0JbERMart0cwrA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=vCulz2a4;
	arc=none smtp.remote-ip=74.125.82.51
Received: from mail-dl1-f51.google.com (mail-dl1-f51.google.com [74.125.82.51])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1EC1F606A326
	for <stable@vger.kernel.org>; Mon,  9 Nov 2026 21:18:35 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 1EC1F606A326
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=vCulz2a4
Received: by mail-dl1-f51.google.com with SMTP id a92af1059eb24-1ae58d17cd9so950564c88.1
        for <stable@vger.kernel.org>; Mon, 09 Nov 2026 13:18:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794259114; x=1794863914; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=m1QU3+7laS+fNdEWDXJJYocSvhG3rmU21yfPePi389Y=;
        b=vCulz2a4lw9GCsTVs2Ce29kE5YChwlsi67cSXQmnJD93SP4JzWrcOmb34uOD2obKI9
         WD52l+HXFKD+YFGb5GRcfdI1eqgY5EReukXaVi/Cqbk3Lp4gX1jhNm/L2w/PO+Ut5k++
         eHMM7OmqCwrxizH0B5BeywZGf5QnzlO+C6L+Ejinidhq4kFhCjK80wgp4QFvDaPmTk/b
         aSPaphuaJVdijD4ep7ORk7y2Ea4Z0xwFR+h5bn3LASQYOE0aCuPDYUwG30/kDaktGS4r
         iTrsyj7zd7oN1RWFg3ICTlvbRr2G73g6cThPts9lpm0JlyzQUKf8aj3OuNQ4XgnnrxSW
         OhHg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794259114; x=1794863914;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=m1QU3+7laS+fNdEWDXJJYocSvhG3rmU21yfPePi389Y=;
        b=AUWsszXwcWff55GgG2xrm3t9UeJxK1MUhTC/OJzKV6XwAXFfy+MyO1yvTtUIwtP2hX
         7Mugj6hUtYUDJd97GBjw7l5t/v/+//PFyphY87gRgq80z9BU+/GLNosXMNrggqu86yDX
         7yNhdqV0DaNcfU57QiVWWgBhYp7rrsT2Z8mXQyziRh7FthonGVaUwuzOPK0HSbh3+HBX
         hokB+EleBe60k0r9ncDjaa5GvnmPclTIlzl6bo6LVtMbBNbgBrpU1qiDoOdtvFhlXcU7
         2KtFJN+j7OfnXPHy2m7HIGhOyjyRDspuYzos1LgRBYPNI2PpNF5X4MFzuj4KnAEQFNjn
         8xhg==
X-Forwarded-Encrypted: i=1; AL+hErFHWKa/kMWJMHDaMhNSBhN49AhXzAzKyKtsKq6cjoEhKInWK4Zv/h53rqJTBD0S4jACwyyFA9M=@vger.kernel.org
X-Gm-Message-State: APuU4Z/faNyZopRU0e6acwaQmIk6ni2JUFutS9hSBTbvsx19W6InlXHT
	Fg+yybE6OhZm9gDALjGuNkFWHmKmML78bSdEUt9Sv3nzhwWWdv+9eli/
X-Gm-Gg: AYBFou24mIFVInW4chO1ZUxVdbAWLQVsW2E/Be8RPBB4BIDhXZcb1C0G1Q5Qj3ANGoi
	8TFm+puxvClphq/gO3az4i+znXINB9Mp0p4NOfJBWBQ+bfqcMwGypiC4sIsIT1dW3MqxriALTlH
	+jFOJJUibei/R8gnpb/BZqbmQMeWDRyJBPX2yo9x2qSPzGfuQGYdQWf5nEhWs/4IHXD2OP8np5D
	U0TyQOz8uCiH/3wbWqkAfurqHmjExeVODQ6S6hZOhfKdca3O6KaBwGZCyiuxaTmGhV+VECHMFxG
	Yh9cfnxNIsI8t0QTnP2FA8bijMr1XeQR/7ffx37KsJFBqaw/uysutRQVmTp2rxs9T7BmOGMOXEu
	ezV+sl+3MNiqGw01XJPM4I4jV0trpE1PZsn6shx4azK3pUBo257Iclz2UeJnOxyZtDKhzdDdhTT
	BfivVAkmkOhjiMIDmnKbh+scwbxjvpjsi+l3qU1U3zitgr59MWh9BfZU8IAFyJqHKV6+Cs2LsnL
	Q4NKxF9Y+I0E0p//TafM7hJD/sqPSCca1+PCspHWyWJVRHGs1vpbzZ8UGo6gO4sXVRX8GKaSBb1
	BppEZ6sIcsrXyj3dETRWD9rTb3RKtzJboi4a/GSMd9mSEZwlBiQiIYv/
X-Received: by 2002:a05:7301:488e:b0:371:7ecc:b82a with SMTP id 5a478bee46e88-3751f659215mr639626eec.21.1794259113833;
        Mon, 09 Nov 2026 13:18:33 -0800 (PST)
Received: from [10.67.48.245] ([192.19.223.252])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-3751dae63a6sm1001100eec.1.2026.11.09.13.18.32
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 09 Nov 2026 13:18:33 -0800 (PST)
Message-ID: <d76da9ba-a22a-4cea-b0a2-c2d0278668b1@gmail.com>
Date: Mon, 9 Nov 2026 13:18:31 -0800
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
 sudipm.mukherjee@gmail.com, rwarsow@gmx.de, conor@kernel.org,
 hargar@microsoft.com, broonie@kernel.org, achill@achill.org,
 sr@sladewatkins.com
References: <20261107134939.434104957@linuxfoundation.org>
Content-Language: en-US, fr-FR
From: Florian Fainelli <f.fainelli@gmail.com>
In-Reply-To: <20261107134939.434104957@linuxfoundation.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 11/7/26 05:38, Greg Kroah-Hartman wrote:
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

On ARCH_BRCMSTB using 32-bit and 64-bit ARM kernels, build tested with 
BMIPS_GENERIC:

Tested-by: Florian Fainelli <florian.fainelli@broadcom.com>
-- 
Florian
