Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.210.180
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795028986;
	b=J3uc1mfLR0+DNA90WGA+LDccIoWngghgiYhYDVcF34rO+ZFj4H9wSpSHIF5magKkMfxo
	 32CmAEG7Bhtd5dgywinP1sXrPeYiXinJsjaZ0QqKX/2ud5M2vzApcSwGgEZBxB5IoRW8i
	 P+yvmp7L/n8iMZJjZQX3F+IHr+S3iW3YjO71QhP7B9YGAJZG2ViQ+f9DNhwlllLkJXRyT
	 BNyWfs+dc3ykG/0KTxJD3eQ9fgcfXr60vK3/Bs6HdHuwPi+4w3Cqpki/ZHQTWhmUmlqOk
	 ETgWSx7p6WYz9MOX89VOOLgOG/YdFbcPtkKJGSzZqdEqkeElHSNBGHC7kJ5t/2guIxg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795028986;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Message-ID:Date:MIME-Version:User-Agent:Subject:To:Cc:References:
	 Content-Language:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding;
	bh=brrMobb22TVB7XAlElAFp7KL45XZpi3Q5Uug9IjkUY8=;
	b=kU064y9/oSI1ZlonsjpIP0ekBAP4mgSzBTmZV/nrOcCz6805ff6rUOn+oQnvlzFJ6tKC
	 IYuCf9bI5iXzk13JTlvQKp+WO+HrY+ZdLReUtOql58yQgOtvRHeHS8iiru/sJ2eTqd81E
	 al9/pMEQKMV3eW9QQnfcPGWFb4nD2w8Vgz1drh5s3x63slw+M+LJ2Zg1LpTp9mFLRGK+Q
	 m5YjW1AQJgIXPlaP0B9T04GNjP02XhQA357UV8U/p79IKemv/AYZTqhkFoS8r4BI0XViZ
	 eyF6F5gA7myRLmcmDOmJdxtYYwADUDWO5Dydr1Z7J3MfTe3//h7tlnSmG6W5ZWjaMlQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=gT+EETXY;
	arc=none smtp.remote-ip=209.85.210.180
Received: from mail-pf1-f180.google.com (mail-pf1-f180.google.com [209.85.210.180])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 95BB5606A325
	for <stable@vger.kernel.org>; Wed, 18 Nov 2026 19:09:46 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 95BB5606A325
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=gT+EETXY
Received: by mail-pf1-f180.google.com with SMTP id d2e1a72fcca58-8b32bc605d9so867855b3a.2
        for <stable@vger.kernel.org>; Wed, 18 Nov 2026 11:09:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795028986; x=1795633786; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=brrMobb22TVB7XAlElAFp7KL45XZpi3Q5Uug9IjkUY8=;
        b=gT+EETXYIE010bwxKo6vWpa7kf0l4yi8HQnH7m1lMN7Wh5ilMCZOoPC27ui0OnQ6Xq
         DlitK6G2tGPyXdSNdFI0wnxICAsHb/JS8TjVu3Aw6bj7BBNBC//kSvugcV2q8Jrd64p4
         WSn2DmTbPXAS7YD3xc2YD8VanB7KJNp9ejN73TQqKDP+rQcHgM6j0J9fIsNywpuL+FuN
         N0dcbf5Hd7CVxYc5E7sJ8m6hFfD6tNKuSWuTnzuwdyI9LV6B6mFJSQCqPcQRzDck5yOQ
         hWuDfjTk0B9zyfiEftR3Ev28PCj06NZbVIWjwvSJjhFtREKz+r6PM6h8k5VncprWhpGd
         aNYg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795028986; x=1795633786;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=brrMobb22TVB7XAlElAFp7KL45XZpi3Q5Uug9IjkUY8=;
        b=gqyTF/aevJypx5pJNhcALro8Sf6XhT+Op3kACvLMn2rCIujUeUn3HNR6N2Stesangu
         Q7xBqw8XAesCIxETN+CVsmNADn9Bpbe8v+fDYjn66oxzT5ehAvnlnq519Du+1ikwzf+w
         X1vrDLr9qlAUIYZafRQkU2NHx1kjp/xiO2WL2bu0JRfuGq3+3lo3QYU8wrPc54l8dnx3
         el/ixbedpu6h6gQxVfTN14iQbSyI2ReaP++uxk1kTZkFBo2X6BseuHwfqcmkevnHsGml
         ZF10VqmA7HjYqTkFugKnEzmlk85UcRUXrF/1LqEAxbinRVXGnUhu77vBMJX14NX2yhzB
         bV7g==
X-Forwarded-Encrypted: i=1; AL+hErGkagsBrs59zlryBYTAM2VlVK/XHsBSaTf9bASdqB6OVP/mFt0LsEIKHEWEKi/eG1ZOk8XDh/M=@vger.kernel.org
X-Gm-Message-State: APuU4Z+McBMgPxsH/LZoMoOrrEEy0+tfCm9h7zVxq/lq/WSZTn6xV0K6
	Us73JvP7l4RmGu8bHzQn+G/gibG00DDrSPNH965ZfW8cTgACXYXThjsk
X-Gm-Gg: AYBFou2CatdsUsGTcpPEksSjvIml69BgQ4JPDGdmtA55ElDyH03hpK3E5PoRHXAvWl6
	SBBBNx0DrXkdKTjEo3MvkWZ7t+fElWDMYiK5IeovmlpanN3g3CmDd3KUmx/KCVI46VU9cHNA2dG
	KiT3Y0VbTAr7vaio9hAxhE9rV+QO16hxm/ck+A0zgkKMEXyFsakQAkSaalccm7A9679cU56xVx8
	JbRLSaCpMCGxooMlcJ1J1GZTT51kM6jVM+O9Hop5tBdvpiDmKIYdieAwiidB0l3KKlvnouybW6h
	MaAwW4A2CIwHP7+n81N8mAhuwe9HjRGyRErGuVCzVnsbMhkTeu+g19FX6sjc3TCPT5e8MVgWfAN
	lhilBTnLXSZVeOfrYFUvgebpIDsj9fqKaruS0wRy1r8iI28NxDeCNbl9/oS/yjXchTmr5Wl1YXM
	60guEzLT71QaSnuq/kUNlHeKttJoT5YlRRxEhb9uCDMRZCekP95/17zghGlBJUOji0zlVCtCYzO
	fHPPAaTAwZnHBDWy3OLJqHomnamvb/mczjL3gqd6KymuUArWx14OtCS2y2qfElYInfnS+U/PZFb
	eaVXXziNnDQIQ7Pq0dsPtXhG+Py9o5phm3QVKnILgxY9vOGjpLcKRVw6
X-Received: by 2002:a05:6a21:32a0:b0:3f5:ef59:3aaa with SMTP id adf61e73a8af0-3fe970fafc7mr3891623637.16.1795028985604;
        Wed, 18 Nov 2026 11:09:45 -0800 (PST)
Received: from [10.67.48.245] ([192.19.223.252])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-cde53462820sm453966a12.10.2026.11.18.11.09.43
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 18 Nov 2026 11:09:44 -0800 (PST)
Message-ID: <42cce255-f459-4386-a763-ff46e77d5f6f@gmail.com>
Date: Wed, 18 Nov 2026 11:09:42 -0800
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
Subject: Re: [PATCH 5.10 0000/1848] 5.10.275-rc1 review
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, stable@vger.kernel.org
Cc: patches@lists.linux.dev, linux-kernel@vger.kernel.org,
 torvalds@linux-foundation.org, akpm@linux-foundation.org,
 linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
 lkft-triage@lists.linaro.org, pavel@nabladev.com, jonathanh@nvidia.com,
 sudipm.mukherjee@gmail.com, rwarsow@gmx.de, conor@kernel.org,
 hargar@microsoft.com, broonie@kernel.org, achill@achill.org,
 sr@sladewatkins.com
References: <20261118145911.150052362@linuxfoundation.org>
Content-Language: en-US, fr-FR
From: Florian Fainelli <f.fainelli@gmail.com>
In-Reply-To: <20261118145911.150052362@linuxfoundation.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 11/18/26 06:33, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 5.10.275 release.
> There are 1848 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Fri, 20 Nov 2026 14:55:32 +0000.
> Anything received after that time might be too late.
> 
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v5.x/stable-review/patch-5.10.275-rc1.gz
> or in the git tree and branch at:
> 	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-5.10.y
> and the diffstat can be found below.
> 
> thanks,
> 
> greg k-h

perf fails to build with:

util/jitdump.c: In function 'jr_entry_pid':
util/jitdump.c:416:31: error: 'struct nsinfo' has no member named 'in_pidns'
   416 |         if (jd->nsi && jd->nsi->in_pidns)
       |                               ^~
util/jitdump.c: In function 'jr_entry_tid':
util/jitdump.c:423:31: error: 'struct nsinfo' has no member named 'in_pidns'
   423 |         if (jd->nsi && jd->nsi->in_pidns)
       |                               ^~

which is coming from 428d7a722786 ("perf inject jit: Add namespaces 
support") we need to also back port 2b51c71be599 ("perf namespaces: Add 
'in_pidns' to nsinfo struct") as a dependency.
-- 
Florian
