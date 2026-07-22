Received: from mail-qt1-f180.google.com (mail-qt1-f180.google.com [209.85.160.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A7887405C38
	for <stable@vger.kernel.org>; Wed, 22 Jul 2026 17:17:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784740678; cv=none; b=qL6SAMD+hid6hZZ4D9+aa9I/O6tak8LAcoh4EH3fk1DHGUGd6TH91mZxtMt9M0eu2XiWE8MdnejxvKyOyvAt468d4EmjePUiaQLP0UXjy3fPm4MyxcX73kVnjFuGWTthcMAiBQF8dLTaxEej+2HwtRBcjXhFgJjUXEGmQS3wk1U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784740678; c=relaxed/simple;
	bh=yBog/2jRFIDxukHm/5g7WlFhjk9IVCUZ4sxIuyNdUCU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=vE84oa7SGJymc8NAlgvzFSp+e7Wl1AUdtoMMCAoYYhK1w8hC3PpfHOJ8/H/GgcE2ajkeTVFymKv8cEqZsE+61MIbgFd4wcfRW9wRthN8lhJLEwcGCa088lzNbWjrEJHDZZYW+sY3GqLyLRTIqWzGjWEOM6JePlKwG+wMU49xOVA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Yi3Ly4Y6; arc=none smtp.client-ip=209.85.160.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Yi3Ly4Y6"
Received: by mail-qt1-f180.google.com with SMTP id d75a77b69052e-51c0c68aa31so94100231cf.3
        for <stable@vger.kernel.org>; Wed, 22 Jul 2026 10:17:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1784740674; x=1785345474; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=kSNy5VOSaYTtujmoWy320tYz+BN9oHmew4YUUk1LVBo=;
        b=Yi3Ly4Y6ak50yapUInJ7SGtNeeio9YtR/s5C26g/8e3INMRBtMHzsAFdGWWRfrhvDk
         zfihoG0pFdJGmirJP0mjP0sWjLNefSbK8N15gmp/tp3ZcreJm2riKcx/n8LQcog9tT93
         MOBQhRA0la/UkAkPTv/xRHloD5doL5u+jA8WL4PgfXcOuh5pMYy/5G3tIkJsT2F1nzAf
         vUyCpro6oyDFWNQtNwu04Sy5D9bFz9tk4LYCqqHFIZy/LqHAfLbiJPfBD8HJXSYqJLgB
         lF9bzaaQeH8FscDXbK52QChavP6j70uiN09mqg3dZICwlKYyM0nqH6np+4/e7s8Wue4t
         hsyA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784740674; x=1785345474;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=kSNy5VOSaYTtujmoWy320tYz+BN9oHmew4YUUk1LVBo=;
        b=Lt0rRuxdTuq61z3jWWvchm2PmeRROONODldFY7VSuwCjUxhxBZR3N0T3vuY95tKlCg
         GHVYIRYhMDZ5E8xFVfkfoCU15Z4mKsXOms3Kr/kBh2/f+8lP4GM6pXA/0l4MGPxdYcC3
         cfvGZfr/wpy6wFPj/lcUU/e3A8eiinzvftXDNId/qipFmc4rMFz7mrjb6Aic6OSS0zwK
         x0z8rVf/K+rs7Szco5wfdqISXELzp6z17g9l3wtVehm6T8wJK4Nb9tCHIfdS77O4BSV0
         U972Soo1cw6pCRVQY+SW0e5FL7kzjlOMHmxU+UbTmualfmp9ZAmoE5OUBGmOuIjp/hRr
         BEMw==
X-Forwarded-Encrypted: i=1; AHgh+RpJc51wxpVsrC7nKEQTzfZhXPtuDln46IY6ydkEfF2Y6To7lyMHroQLVDAD23EB/jvpoJYOjzU=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw6OnbA2snDKQiVJB1KBlfVNxhP2gY5ZoMCK/Duxi012dF0WLYF
	EnHxxdl4WudxG204bQLOKdncRi7cz/6Z/a9tWrCLDSmN/dw8yDfk56Pt
X-Gm-Gg: AR+sD11bN6e6n17Xn3IMT1xNMzkprPoSeupO14tunZjyJ5m80mj7o80aBqhb/V8wCiD
	vqzCOvZ8fN/xEVmAO+42Qy0auKCbH0PIH5s7ToFS3qkWBWeMNLZrBQfOwZNRk5b/PE9zL+iT2Lk
	ho142uek+B87ErII2gnsJBpRSaQXRoJgx6lq5QkBJ8tQQ432Q+mdp3Xx7enPdJkafKu6IZgDg/1
	pfCtLlh664ZjCEwGPFe8+uBbsjao9bMTFU903Dww5xQyg/Q4k3ROlMt1WufxVvk4tPm1cF5rC7b
	P4Af1CjeQJQvNhoT+UX674g26iQKjtklVt/VXN/k2Gt0112YdHIyS/BbwR4sGihlNJWeEVarYaW
	VdxXh240w+TKkZkPeQqmGmuOED/YHXHDlP1ofjAH/hfk2YF9nwDPBDL3tZlirV46XfEtGpX6cVv
	8DvBHBw7R+P/FFUcUaLWWEoP1Jx7+M
X-Received: by 2002:ac8:7f8f:0:b0:51a:8c9b:649c with SMTP id d75a77b69052e-5213d0c5b54mr227513001cf.64.1784740674468;
        Wed, 22 Jul 2026 10:17:54 -0700 (PDT)
Received: from [10.67.48.245] ([192.19.223.252])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-527d402cb05sm19671511cf.31.2026.07.22.10.17.49
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 22 Jul 2026 10:17:51 -0700 (PDT)
Message-ID: <07004d68-6189-42af-8a56-686d0d46d532@gmail.com>
Date: Wed, 22 Jul 2026 10:17:48 -0700
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 5.10 000/674] 5.10.261-rc2 review
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, stable@vger.kernel.org
Cc: patches@lists.linux.dev, linux-kernel@vger.kernel.org,
 torvalds@linux-foundation.org, akpm@linux-foundation.org,
 linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
 lkft-triage@lists.linaro.org, pavel@nabladev.com, jonathanh@nvidia.com,
 sudipm.mukherjee@gmail.com, rwarsow@gmx.de, conor@kernel.org,
 hargar@microsoft.com, broonie@kernel.org, achill@achill.org,
 sr@sladewatkins.com
References: <20260722142749.280611149@linuxfoundation.org>
Content-Language: en-US, fr-FR
From: Florian Fainelli <f.fainelli@gmail.com>
In-Reply-To: <20260722142749.280611149@linuxfoundation.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 7/22/26 07:30, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 5.10.261 release.
> There are 674 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Fri, 24 Jul 2026 14:26:57 +0000.
> Anything received after that time might be too late.
> 
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v5.x/stable-review/patch-5.10.261-rc2.gz
> or in the git tree and branch at:
> 	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-5.10.y
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
