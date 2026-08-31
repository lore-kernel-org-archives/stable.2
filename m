Received: from mail-pl1-f175.google.com (mail-pl1-f175.google.com [209.85.214.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9F3BB4AE12D
	for <stable@vger.kernel.org>; Mon, 31 Aug 2026 17:25:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788197116; cv=none; b=kOayr//eDuIss+hn7k/OeL0ssYDTtBzxDQOfLOkZriwZOF2nN+MzVqWIBNBxQX4kTuKZhkkXxAB9aC4eteH8+M2Fc47oahUcu+N2dIaa4Hzhd+9Qb8dPP5qphLlrfnn7LeypHgSg/UJ7OVCYhfBzdvlOC6MK3vY/+DlbY8s0lcM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788197116; c=relaxed/simple;
	bh=AHbx0/i7Pgt9YZiuONnuRmcHvLJTE+va4kW7G4fKV+M=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Ya3cuTCEuI+/4Z3bdTCaNJA86lMTbsDen6UhJIYaokHn2sarXjj5AYroLygeR1yY8KXFMkTpCgthl/NNeuzqnXjSziXWw9SkzLTw4MRWApiFMDec4hIzizmzq0RQEgnrE6aBYTSJnBEVD14BoyhaoHSM6QvaHlagt0dnHIeqAfc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=dZKuaFdQ; arc=none smtp.client-ip=209.85.214.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dZKuaFdQ"
Received: by mail-pl1-f175.google.com with SMTP id d9443c01a7336-2d712281f8bso42747855ad.1
        for <stable@vger.kernel.org>; Mon, 31 Aug 2026 10:25:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1788197113; x=1788801913; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=XK77W5HmajvK4RgjL9G18trFUO/IP7eMuuZI6UF8qGs=;
        b=dZKuaFdQGBVg0RM2DFlUP2u1rNto8vnfy6argN7oKH5JQ82YvZxDoyJBAFw9O9JZOn
         AeuRUFa3AnpiRG47GGMv/IjzWbVNV/cxPJMJumB0ng4uEteKm4RKgAFCRVK1YJIoydmq
         yR15gsgpCVjIfUQYeGfTNInniWlt3qQI9ikVZ6X7UuFoJIfIbILI7vLVlMbYp2kVlgnj
         SoKaMF1G+3JlV/x/5dPdXoP5TWfSrZ+W5Q03KlcWeUKHSPHsBl+Kyym2M6k63Z+otqs9
         +hCDRbSloNWeeIpL46FUet6TpeaJSmSK/BU2NGUCYv/qMrMKa2Sn87R3ShXvEe6mtm0e
         bpXQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788197113; x=1788801913;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=XK77W5HmajvK4RgjL9G18trFUO/IP7eMuuZI6UF8qGs=;
        b=S64L2VtAzeeLWFFhwjcEiVe0FqBGchLOmkNX+iIm+KR3sz8IuMeTkIFRxQYEQu8ZzL
         uPBkmNCUuwJtyzHzPHmEUhDUolXE6X9uvoDeOfM5A/sOZ2ahx2EsaqFG3Cu6CY0VAKLM
         U4pfG0Tyw3aGc+t+wNDrGk0bMtr+vJqQMp+dz3TGDpeqxbPCQaZloLD2g8s7Msr6Whx+
         bIsZ48JCuP28ldwRAhT3MBIJ13oKpQHc4b2EmTl0wmsW/uesDht5/uQ3NU5F3zOxEgok
         ykN5QOA9WnVYZuiAldNJ+ADWCE0U2+roB20IYmBx/tG66YRPD2nQOPfsHc5ggcmvKbaN
         /jsA==
X-Forwarded-Encrypted: i=1; AKwUvBwb0mY3Wj0LmMdnNaKVK4XnwsHTXcoAbKaxGPCa/0SBUOD/H1cju6512PWBa1dGKOpl1cpqTpg=@vger.kernel.org
X-Gm-Message-State: AFuF++l/wDFgfA11Eqz7tjRyZ6JKbESyl+QDCxqhgkfkIYyNvwcaFSRD
	qlB3Huflt1ywhOJWyvIgLKRma5AUiO4S7923Y529bAL2NNhTRtalgBkF
X-Gm-Gg: AYBFou3Od4q/7pRL6PnEUFipcx/6WOptYHYIkooZldbIU+RfGtd1to1maCt4QK5CME+
	xmfzBty78VtdmuU7F/8EQ/Nu/I9SuFUUfKbuV/AS8n1wpKEM7X2ELGpVwbNtPxq6e1FZZyjfe08
	A+QgsSJhoGgyzT/yaY05JRQxNUxSDAMT+3HYpx3mAp40753yedY3vgVc1wzeGLL7ei5mjlMYdEn
	710dueCjMw9l4si2/gAAUlAd8FDPed1v47VtSa7MjLnKb1OVihd3e/AlSzvFDkNL+HdMDs3Woha
	TGFKEqy+0PuGK2wLFM+H1WViUbHD1BsenYXEa0TLqWaUFmdWRV9Lymk8ehSJbl/iQAm7D3XKWt2
	1SeXroMPanbcSm75ZnwYUNtL7qCqeJ3yQ+tNphCtRvhWD2r6XuZlA7R4YbMYEIZGa1legAd+WjS
	qpc3SCe5IBuVA18OglBEAcDD5acxv6D/WOUVvPEG5IxipyoUezHryxJWqLwW7kp+W0pkXxXJQLL
	f+3ngFNplYwsSD7h5WvnHHMsYqfQQ==
X-Received: by 2002:a17:903:324e:b0:2c9:deec:f564 with SMTP id d9443c01a7336-2d94a8d59acmr32476955ad.13.1788197112756;
        Mon, 31 Aug 2026 10:25:12 -0700 (PDT)
Received: from [192.168.1.3] (ip68-4-215-93.oc.oc.cox.net. [68.4.215.93])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-32b28ab0571sm23256193eec.4.2026.08.31.10.25.10
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 31 Aug 2026 10:25:11 -0700 (PDT)
Message-ID: <5893399d-bef6-4888-acaa-3bb4ca3ffc01@gmail.com>
Date: Mon, 31 Aug 2026 10:25:19 -0700
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 5.15 00/69] 5.15.220-rc1 review
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, stable@vger.kernel.org
Cc: patches@lists.linux.dev, linux-kernel@vger.kernel.org,
 torvalds@linux-foundation.org, akpm@linux-foundation.org,
 linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
 lkft-triage@lists.linaro.org, pavel@nabladev.com, jonathanh@nvidia.com,
 sudipm.mukherjee@gmail.com, rwarsow@gmx.de, conor@kernel.org,
 hargar@microsoft.com, broonie@kernel.org, achill@achill.org,
 sr@sladewatkins.com
References: <20260831133358.601894154@linuxfoundation.org>
Content-Language: en-US
From: Florian Fainelli <f.fainelli@gmail.com>
In-Reply-To: <20260831133358.601894154@linuxfoundation.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 8/31/2026 6:34 AM, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 5.15.220 release.
> There are 69 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Wed, 02 Sep 2026 13:32:19 +0000.
> Anything received after that time might be too late.
> 
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v5.x/stable-review/patch-5.15.220-rc1.gz
> or in the git tree and branch at:
> 	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-5.15.y
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

