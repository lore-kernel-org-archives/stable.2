Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.160.182
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793224649;
	b=zwGkGwsoWMcAf3FvEQCEeu6pVdagVqLaITi4lCShWdphTWGNuvjHGHvF6wPMyCLcMaE6
	 Lo8a7N3cZcSDX0fbzPhIMc58suUMM4xK7E8xUjZomiiPTxb/aQIzJzlxNdU3/ANXYf1Ji
	 2IxL0sGIWdTAMCCaWoKKLLSp/nYF4n9PtsIqs6r7r0+WpOr7W6cSmkX/50b/2xyU61MRa
	 xWgd0SrNNyMk1sQUtr+RHRuT8sT7RK4SzxJUprlR8wlh1K0t50nE9fZePnLEgTCq/6QS/
	 vrw6tGNQc1AX8rxFdRFqEwiqSBfrd2Bxwl3l6QrIcFstcjD3le4Ntw7OgbeVMkJ0JCg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793224649;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Message-ID:Date:MIME-Version:User-Agent:Subject:To:Cc:References:
	 Content-Language:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding;
	bh=Nmob0PGZGbhgpel5Pzhl/DhX+5a07M/6tXtKDShuMAY=;
	b=M0IOfAyinjhybmdGQRmi7KeDSKwWgCRvDVLBR2gPUg9QIDeiGUlDSTieeeaFdERXUpH1
	 Qk0TLEBnLiO+unW/5/1Cy16ASc8fKbACpY5tJ+Vy9FT2jKjmewbaRHq+qhMtMWFJmreA3
	 fpa9YH3v6+ymHhflwDtD9SPlQdkk6nKwjXuOBeKhXaM6YJlkbvBudPR2DjyNitSGH6UuG
	 U1xx+bYmPoXZc5sGteiAgrd8UfcVX8CzXBIhlruv1lhybaAh4T+FH9AnsN5aEGUdf/uEJ
	 TrCMGEPKCGwH6l4+JGi9BXmKMG6OM9DhquWiTKJrpZSvtdA6VfScLHhIrOMP1nAla3Q==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=Tsb2Mc8B;
	arc=none smtp.remote-ip=209.85.160.182
Received: from mail-qt1-f182.google.com (mail-qt1-f182.google.com [209.85.160.182])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2AA96606A338
	for <stable@vger.kernel.org>; Wed, 28 Oct 2026 21:57:28 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 2AA96606A338
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=Tsb2Mc8B
Received: by mail-qt1-f182.google.com with SMTP id d75a77b69052e-53634b8328eso14134841cf.0
        for <stable@vger.kernel.org>; Wed, 28 Oct 2026 14:57:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793224648; x=1793829448; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=Nmob0PGZGbhgpel5Pzhl/DhX+5a07M/6tXtKDShuMAY=;
        b=Tsb2Mc8BGe9O8MzLV5MjTldRsH/mdPqcyBLYayiQC1vD15CTOR+0wbRKk/wh4Y673v
         cGCooyKDfJVJ67YtcH/vyphZmtnXyTZHookTN4V71caM/HbJBh14gL9aqN0LwvPYJ7cN
         J1LlQErWqUw4x0SOhhsQE2i8Hy8n2N7HKgq6R/gjKsnJ4nuW205Jw00m2PZXnrQgj8UJ
         27cE9xfqcqAQqL5xLGpctv8+IgeznsQtmnNKo8vdsHGm/b4pQgB6TXx+4tTqUVEcDuaE
         rCqBvjImRM2FO4HbJQaPi3r5vLUDAVAGBNsu7YwG4XwQQ03aZYrz/Uf6K28UEzzwarql
         B4eA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793224648; x=1793829448;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=Nmob0PGZGbhgpel5Pzhl/DhX+5a07M/6tXtKDShuMAY=;
        b=eI8Zs6sdnhUfHXatMuK+Yxw0FY9f4YQB+jaTp47wa4Xt7NQG7n7065VlxWuhgzV8/r
         VauV39d5ZGncWKiZRfP+ZPm4KhtHGMxTJMqIpOPQ4FxGFO+bR/vRcWka2qCZfrCin1eG
         3/jI+mtld9TouwJjn7b+q/uhU4E3vX2FPo3mdoZrGAXPcbEde4axznF19iJGPy939bfa
         G3dCQCwHSvgmICixpINvL+EFPTG+mk/rgnJL/d+vgScbNB2UnNB+LJtNL+4S4EZQb50w
         5Y3/tPUjBOrreIODn7X2qG3LfVKj4Rx1mwyJpgOtC9nuXnAxyDWEQhimUM7binl6h37F
         7KkQ==
X-Forwarded-Encrypted: i=1; AKwUvBxRo+0PBJFWl1hQONZv3i4RMG3U/92egiucUdwDBO4QvsLgDunZg19HdMsbQLUEAgQWQuCpyds=@vger.kernel.org
X-Gm-Message-State: AFq9FYLHLszFdOmkKZGtda99sDggRBzn2gAKoqSe2oadcJh75ELbg/vw
	Von6eK2nUoob0OlKa6aO2nCHnjSmy7pFzjzbK28/JbEp8k4jPOZ1Oetj
X-Gm-Gg: AYBFou30uZUCEER3ECrBY9gslhi58QG6QSrdqs+xq5yk4hPIXbyQOqUOwe802FHZJy8
	0nKE+XhSU3cOMZBSPyKDVaTz+GZHlWcVsbygqJpDB9w1X5r+CkvoX4+LOwiqaLhK0nxHuXmLI1D
	i7r+QXR41hVhx4FRYOIOaBasRUDAAlbwN6k5cPbetTEdAV090R11NRu9zATreJGl7qbQgMfLjrB
	r7h6CPiSAOYdykoqeUmuawZ7jws8+iwVeAIQeTSsP9GOq9dBIxDgWB+K19vHTtEbOQUqeIT78/G
	7Yt+dYbx7KlVlkpZlT98XFf2lQNjD/f3zYqr88ANTGgbJmqF6OKP6C9R2i6TkWDTAmhrBXDenqA
	3N8GE2ZVf4MhVDBHbRslI4uuNLwRXz3rfe1CtBQiASJH+A4LbdLhwuIhduA+D4VzslTyy1yv5FN
	GbhUEbk7K6YzZ8+mKAzmnPNe1wcOtZOsiG+rg034Ev9XA0hs7p1y6eFHHW6XGbtMXgHb9PgbL07
	47iJNLsH/P1wlBmx4RO2VHdaXl0x6tLuRy9RGRcXQgYBK6dKnJS1S6e1aa2FptwlIpl2UZBQ5zj
	KCAMJ5w4KmvFGLo6mLlyQi5Sy4jNawXWaJj3+nwNOfBlY+Z4gvz2ng8Gt1TiAGxR1l2kSNdzDJO
	qJA==
X-Received: by 2002:ac8:5a54:0:b0:536:35e1:b5 with SMTP id d75a77b69052e-53fc8fac376mr65585691cf.1.1793224647994;
        Wed, 28 Oct 2026 14:57:27 -0700 (PDT)
Received: from [10.67.48.245] ([192.19.223.252])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-91c6c4e7565sm69904596d6.15.2026.10.28.14.57.25
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 28 Oct 2026 14:57:27 -0700 (PDT)
Message-ID: <3a7c5852-820b-4991-a14e-c74b8ce76db7@gmail.com>
Date: Wed, 28 Oct 2026 14:57:24 -0700
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
Subject: Re: [PATCH 6.6 000/168] 6.6.161-rc1 review
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, stable@vger.kernel.org
Cc: patches@lists.linux.dev, linux-kernel@vger.kernel.org,
 torvalds@linux-foundation.org, akpm@linux-foundation.org,
 linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
 lkft-triage@lists.linaro.org, pavel@nabladev.com, jonathanh@nvidia.com,
 sudipm.mukherjee@gmail.com, rwarsow@gmx.de, conor@kernel.org,
 hargar@microsoft.com, broonie@kernel.org, achill@achill.org,
 sr@sladewatkins.com
References: <20261028165943.089486480@linuxfoundation.org>
Content-Language: en-US, fr-FR
From: Florian Fainelli <f.fainelli@gmail.com>
In-Reply-To: <20261028165943.089486480@linuxfoundation.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 10/28/26 09:58, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 6.6.161 release.
> There are 168 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Fri, 30 Oct 2026 16:59:22 +0000.
> Anything received after that time might be too late.
> 
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v6.x/stable-review/patch-6.6.161-rc1.gz
> or in the git tree and branch at:
> 	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-6.6.y
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
