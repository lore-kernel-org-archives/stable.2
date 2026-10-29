Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.161.53
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793288058;
	b=RDakn4E4siyKVExov62VNNf5u3Q/ELSO/cjWq/BZHeQdrkP9PuK6XmL83ZVoRjEKRzT/
	 fyqXoAuo14Z50YTtWDhQYXgmRCP8leq2q6YRZr6QR/6nFf7LZYlZfs0bRuXhJEOk3hP7C
	 fN/msF2ILFYa9K0Wpgud/wR/x1qnqQdhvBGuxv4u+lESDtTXLcj4R8OZTSGRRF5Y03dH2
	 kxgge5r2cf879qaAllLRtkTl4Jtg4ypbpv1W+cdrNyHWw3CDR/uLOG1nxI9DhecZaieXg
	 wnfmZk4Ty2AkGiR5mPg/natvSZid34igXY9gwHD8rNQ4G/DKMnvFAAosLL3Gdm5KEhw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793288058;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Message-ID:Date:MIME-Version:User-Agent:Subject:To:Cc:References:
	 Content-Language:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding;
	bh=2V4JLnzK67IJcCHq2My/KdT+6D1UK3FIaHGDhvNAL2Q=;
	b=39G6+yCA5d3FVYn+l0aJiUuJJGsxHP/w0nlnRe0JFnI+C8I2kmRMuMY25m2S4/wZTSq7
	 wleo8kXHL1HUdQPrQXEH/IihvsCuxub2BPQKJ63zQPCCRqRioA8CNnY5N9V3cmQOaELmn
	 3AvCRHH9Us8/UhbT7ACgfowoc4/o9efzVCZhGFYENN9cZE62EUQn74+oGn8MYmi8PopfA
	 1aStuxnzaV+fvWbHiWqcl0HjtudeLBp2Jo2V60eyb1x1J3wnHU1FUQtbrYPois0GgFZ/h
	 5qho2StWRJH53oAtFjyec5egdtCkCF8JkRMN5kAoHzAbS3iUMDrMqkl3ow16IizgWKw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linuxfoundation.org;
	spf=pass smtp.mailfrom=linuxfoundation.org;
	dkim=pass header.d=linuxfoundation.org header.i=@linuxfoundation.org header.a=rsa-sha256 header.s=google header.b=UkBsmMXn;
	arc=none smtp.remote-ip=209.85.161.53
Received: from mail-oo1-f53.google.com (mail-oo1-f53.google.com [209.85.161.53])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4C825606A31A
	for <stable@vger.kernel.org>; Thu, 29 Oct 2026 15:34:16 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 4C825606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.a=rsa-sha256 header.s=google header.b=UkBsmMXn
Received: by mail-oo1-f53.google.com with SMTP id 006d021491bc7-6dd059478dcso1655593eaf.0
        for <stable@vger.kernel.org>; Thu, 29 Oct 2026 08:34:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google; t=1793288055; x=1793892855; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=2V4JLnzK67IJcCHq2My/KdT+6D1UK3FIaHGDhvNAL2Q=;
        b=UkBsmMXnccbCiWHhLetXNJ2WE+yUUywZCbA9ZdAwXSl9aWrv9AUrjiiRNHpRQ3/UXT
         62BkjP1O9NPrzJH0wMe71imxsPvN6QHsdXyzXTWi6uAwKCQAwpQM/OXb5z5AKK1xKvf7
         sVfh/vrUNBQY39TW6X9Gm4t3LBGUTx3yZphQo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793288055; x=1793892855;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=2V4JLnzK67IJcCHq2My/KdT+6D1UK3FIaHGDhvNAL2Q=;
        b=mkmJkdlx1SPwJTSxNaOuDVQRxdNy6JdAU1XfR0uH+cPAuYjY9sPQSahlXrGEsITLjf
         lpKcnq67xkmgUHxrJpVvkI1kVa1F5hUg7pXuiVw3jWPmYubiYsNNkzUkQnVrV2qKh9qw
         yj5KEl3AO5kEHXIMx6e6YehArLja+pSC5iZJRWWTHLoYg5CJzj0woyW+mcEH9PSwNsQd
         PZ8+YkuJbOiEcdz4YouenepnrWHNkm6ilYg37SlXNIygOnC2dw4lhjerBx8r6Wla7plM
         9GXFCsnYo/WKkqTYes5MKzHPMuE481VHf/jMJW14KDSsXcl08bHnw8BaKpiGZqx5ej4K
         3osw==
X-Forwarded-Encrypted: i=1; AKwUvBw7Q+KFn00h+x1KlQL44U0geZ29pd4SQRS3/CwXA1ZiRhLuzZ0lxGVj7/AWUGdpdXelISM8qYs=@vger.kernel.org
X-Gm-Message-State: AFq9FYIsUT8sBxsXv7aC7FELOPIhjry/GVV2p4/dlQOoM4K3oHUxXXbI
	6Dd/ndddAeC23jkw1jKT/dwXF7A2Jjlk6Bv9xBgb6JgnRpOjdpSWQIRRuLVaVT4W5Wk=
X-Gm-Gg: AYBFou1nyZRoVi3naR0fprH73I75PhpBFeFDjfuYdvQsGn9dmtehNYK3hYNrvITIUom
	j17Rj1eeBJAYie6UZZms96bzydyIEFolnQlOQyx2r7DZ2Q/Tx0uYXWi4bbkQYWyysPk6tRAnygL
	ZxsxvYEPPw1iuC06Die0MEg747JFG/ZufHDSEgWchKSf1SM+iP7lRl7p/BEvhHm1MsrRq+TbXik
	5Z3Uzoda4bycBHRjdi/1vDoL3aouVqvXAPLp3z2y8cYMhf7GNq8USVUfJ+hcRrpZVbB0aGLWFhD
	yXphbBTpnjKULobEPIJveYYkU68/khjPEC46399qprhW2Wn0x4fgdUl4FMkYZhYe1UAHKur/R/F
	PTF7XRqtXIMcS1HZvl8MIPbZo5SowoDHryEnrPAO01rsyOm2kkYQk+uh0fcTtZLhc3N4sHjuvC6
	k53VIOYUugDIsA6/N28zAHaQTztVaFq7NdEsFnL0lBCzB2RRZWTy0D+nGQoofBSPmEOy/6H6sdP
	zl6Gi9aHWmlQKio4FttcI1o+zjWZ4eb32CpmZniWfk5KywPsqpKnxM5CHkpGAAZ2nZyKIvfKbCC
	xtTQk7ocb6bb5Ja30eeGkmz7ngWTY8BnXGU8TQ==
X-Received: by 2002:a05:6820:7093:10b0:6d8:462d:2759 with SMTP id 006d021491bc7-713ef924163mr2829588eaf.90.1793288055258;
        Thu, 29 Oct 2026 08:34:15 -0700 (PDT)
Received: from [192.168.1.128] ([38.15.57.99])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-85d3400540asm79447a34.19.2026.10.29.08.34.10
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 29 Oct 2026 08:34:14 -0700 (PDT)
Message-ID: <03dcc5c7-5d14-412f-bf6c-723af54a3b77@linuxfoundation.org>
Date: Thu, 29 Oct 2026 09:34:09 -0600
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
Subject: Re: [PATCH 6.1 0000/1887] 6.1.191-rc1 review
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, stable@vger.kernel.org
Cc: patches@lists.linux.dev, linux-kernel@vger.kernel.org,
 torvalds@linux-foundation.org, akpm@linux-foundation.org,
 linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
 lkft-triage@lists.linaro.org, pavel@nabladev.com, jonathanh@nvidia.com,
 f.fainelli@gmail.com, sudipm.mukherjee@gmail.com, rwarsow@gmx.de,
 conor@kernel.org, hargar@microsoft.com, broonie@kernel.org,
 achill@achill.org, sr@sladewatkins.com,
 Shuah Khan <skhan@linuxfoundation.org>
References: <20261028170459.200466217@linuxfoundation.org>
Content-Language: en-US
From: Shuah Khan <skhan@linuxfoundation.org>
In-Reply-To: <20261028170459.200466217@linuxfoundation.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 10/28/26 10:34, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 6.1.191 release.
> There are 1887 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Fri, 30 Oct 2026 17:02:34 +0000.
> Anything received after that time might be too late.
> 
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v6.x/stable-review/patch-6.1.191-rc1.gz
> or in the git tree and branch at:
> 	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-6.1.y
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

