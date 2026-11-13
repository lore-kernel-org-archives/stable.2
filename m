Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.41
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794599379;
	b=TyCBL0d5f0zbmi/X+Gj3Gf9l7nh0m8I9hGUZlhCe5wGnMZ9l6DOh4Sv0vpWCV2zAnC97
	 Qf2OaogNJI20ob64Ubig9N0BpjOhZ50ZvgJuDKx82VRgpYxdhs1ClEZeAf5OVR0fdn6Fp
	 7BJPzUCMS3CfUVnIFga7o9gVOBKlqNMRfCSP1gJZLm6RgiJP0cvCpM5FoqPVLBzmB69tV
	 L2G2rUUtwNiPh5q5zkh2BCUx0IKfpIikvkJ6/rtTSaEiMyA/TaqJi0mSwMktUDEmMILr2
	 iwshVVZejrMKj1nf6cJpCOZyBnIFKQy0lja7huOKP4tBzmmYn2YfO42VdYDKkotJuog==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794599379;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Message-ID:Date:MIME-Version:User-Agent:Subject:To:Cc:References:
	 Content-Language:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding;
	bh=J4rSsefiHQznT/qIvnLX1QXXlawJ9C84nNyE3ha35so=;
	b=lFldcPdYkkKAmcReNBy+0eLsanIMqUlaSBa9fQ4HGlIwD3hYcpiLNsa/IJyIGpQYPyoA
	 T43JWcyUI6pG01+FvkIXtH4I5DvNCq8NZnZihRiObqkygulO1Mj/VxtsH9doWM6Q0tnMe
	 gYEXHUqaAadaya4C9aRaJtn3wP+6/AZznMWUJjrfS06wZzn/IZFreejeORcgdmdlx65ZA
	 uIIwE8T/2yeTxO/dBFDO3r1qK/menKX+LfyZXGHA77An97ZYXR+tdWLw7R9qJ1BNGsa9v
	 X1bZTpB/lqMTHCq9DFh/GZvIfib82sqwJ/+QYsCBDeDGDccEDohWy4uT93OKgf+h0PQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=BiPi2msi;
	arc=none smtp.remote-ip=74.125.82.41
Received: from mail-dl1-f41.google.com (mail-dl1-f41.google.com [74.125.82.41])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 952D6606A891
	for <stable@vger.kernel.org>; Fri, 13 Nov 2026 19:49:38 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 952D6606A891
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=BiPi2msi
Received: by mail-dl1-f41.google.com with SMTP id a92af1059eb24-14394530ec6so1736552c88.1
        for <stable@vger.kernel.org>; Fri, 13 Nov 2026 11:49:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794599378; x=1795204178; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=J4rSsefiHQznT/qIvnLX1QXXlawJ9C84nNyE3ha35so=;
        b=BiPi2msiAb9hBfkpf2tAXQ/EvMpMhbRkURMVn/mJYjGnrmnZ6zVaArGZVMPg0CXMTU
         ue5ep2OCxl8GL1/gtlsXXbhb4zcqkS5Po6Z55Ca6ZxwMhxkxzTHorhV87pdH44fB/zQw
         purbpyGZph2AmiAj9fDo+kmiN3adXT0FdkYpOVJ9utfyS17HrH+EY343jp6zU2UqkvwN
         51fadC7tOzUOLvOLxzMgOriw46G3fBcebrSSlflSp/q1uqA5jv4eb0DZKTqZJa6oisqq
         kcB+ZWEW1FPCzDRI1WRedUhE97eAODoFkqL9npxCh0mXgKgHEetajS4airB03f1d2qpE
         zO2Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794599378; x=1795204178;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=J4rSsefiHQznT/qIvnLX1QXXlawJ9C84nNyE3ha35so=;
        b=LzQcCmJEqbDhsXiv7YPj6MT0W3wpgJ3nVmUcji0gb0YmQWUzgS11x/Y/8QHCdJ+RDp
         4l4jY8LXu4WJffthTsNeF2MKsAeG39Hn6MCaZSCuzJXBtH1wIyWi+RLAyRTtENWd2cUk
         f3Eb7iTK1E2sW194fLmT7PryX7G1AvcyxiL4kf+3jdPpDritMo2nbxs0kxxmCOSodVM6
         xVeGyE734l0S9sMBRRb3U70Ia2n0Rnpc0geFBksob3C2ivgYCZs3zMyoOsb5Blr2wukV
         yxwcdHoAaOz6qwvAWRF7okV26syZtflb4TE/R1s8Hk2X6mdMlBc/upUbNbs6yxDp2Bk/
         A5ow==
X-Forwarded-Encrypted: i=1; AL+hErHoWM/D7wBwoUhYezspqSQAAO18XcNg/lmYyuyUQv5j3+68EjjFH5rooZufpCnxC48l4FFjIlk=@vger.kernel.org
X-Gm-Message-State: APuU4Z8HMPp+F7P6G1ohU4fJjvEGcsfZVNO/ODSX9WscYbGxV1L3eTDz
	J/f0Cnp0IUAlOtih344ybcBP/Buh5vetrW2v7Qm0KgoHJzNPiKREtCqX
X-Gm-Gg: AYBFou1ewuWn98KJE3Sqr4v6dD1DxrkhZXfVfj0mtpbKkOOI4hQPR8nxMUwayypSYgh
	8CZo9baND5u/gHq+5w0dnc7bX0CRM8CrLy4R0i4K4ORb5/Zn2s9Y+ZEhsYZeG9ws0B8PqYfgvWN
	z3y0kN30x9YiOeTQyUr72hOss4VdTczbfIGIkDOF/20HliSJneQoXqhmd5UO/qpPgJw0ECSsdm0
	8pG7Dpw23g7410XobxBI8V6Y2Y9XPQosTGlLLHIiXFKJejSBQ4Wi2vaHn8D7IcoK5OKSrdCA14j
	PWA55KiLrWmoDwE8eJzPYKkUgTpTw3Jkn7oMsEhfL633WRX4sbx/yFuvoSCAAJu48Vm/9ACUty5
	eF2fx/b1SzM53FBcNS5wyVpwxKoqL1qVjh+csvtSMKO294EGDktp7P23ng11n3V1+V7/VBMVR84
	YQGZFBpcDNaYiCTQg3Xgct4obA0+8u36CokljJhzBjfP+IkVc9oJPYzOCXBNCAZo3yruBwzBNxL
	fxlAOqER8RgJcPKzrbApo6/b6nTQt4DVDOG9N/hx+qRT5BFk7uXYBVAYTGPMQbl31RzBX5elWEd
	5CAeBB4N1kMVOUA8BrQt8RfeBF2qbrlOh7FR8XO+lXlex4LUpymcbqf8
X-Received: by 2002:a05:7022:1205:b0:138:30b1:4c00 with SMTP id a92af1059eb24-1b5030681c1mr3144140c88.3.1794599377651;
        Fri, 13 Nov 2026 11:49:37 -0800 (PST)
Received: from [10.67.48.245] ([192.19.223.252])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-1b50316d9c2sm8290085c88.7.2026.11.13.11.49.36
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 13 Nov 2026 11:49:36 -0800 (PST)
Message-ID: <79c5c501-9619-4d8b-8f95-c4e364331db4@gmail.com>
Date: Fri, 13 Nov 2026 11:49:34 -0800
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
Subject: Re: [PATCH 6.18 000/686] 6.18.64-rc1 review
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, stable@vger.kernel.org
Cc: patches@lists.linux.dev, linux-kernel@vger.kernel.org,
 torvalds@linux-foundation.org, akpm@linux-foundation.org,
 linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
 lkft-triage@lists.linaro.org, pavel@nabladev.com, jonathanh@nvidia.com,
 sudipm.mukherjee@gmail.com, rwarsow@gmx.de, conor@kernel.org,
 hargar@microsoft.com, broonie@kernel.org, achill@achill.org,
 sr@sladewatkins.com
References: <20261113153820.902362109@linuxfoundation.org>
Content-Language: en-US, fr-FR
From: Florian Fainelli <f.fainelli@gmail.com>
In-Reply-To: <20261113153820.902362109@linuxfoundation.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 11/13/26 07:42, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 6.18.64 release.
> There are 686 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Sun, 15 Nov 2026 15:36:17 +0000.
> Anything received after that time might be too late.
> 
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v6.x/stable-review/patch-6.18.64-rc1.gz
> or in the git tree and branch at:
> 	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-6.18.y
> and the diffstat can be found below.
> 
> thanks,
> 
> greg k-h

On ARCH_BRCMSTB using 32-bit and 64-bit ARM kernels, build tested on 
BMIPS_GENERIC:

Tested-by: Florian Fainelli <f.fainelli@gmail.com>
-- 
Florian
