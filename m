Received: from mail-qv1-f49.google.com (mail-qv1-f49.google.com [209.85.219.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A71B65427F6
	for <stable@vger.kernel.org>; Tue, 13 Oct 2026 19:47:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791920845; cv=none; b=H2JMmASxBhjD5HqqLXxqXsg20pZmiIIOLG67E7w4aLBhwu1YLMvCwGLGJXBIji1HjrxCfDnM+ZauCGzCSf9V2Y6gFkGk5IYPSoEPx+UxIdZctfixnLUubl3guEHKk/ygA7JLRVR6JZ12esMeNEZddebz5KCxewJ+vjBQukNhqTg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791920845; c=relaxed/simple;
	bh=xkNdboA04KFzUV3kNY2lng94XpmmiyHm8J7T5ogGRxc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Be7ZL/rJHbu+PfM0gLCZh3cLDW3VQhSuz2ji5nBq8Sl4oykxlIbQqtBlSW/OA+Id0xa270/3G3fB5Ibf+1d4jQcru9UBirl8el0FSzTAKnsbc5xHAauNMQx7JU07N7lKPvTYmRHMmIRQzhNIHhj65s90NHd1UMOzET+6Lxk8p/s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=tJUqOy4q; arc=none smtp.client-ip=209.85.219.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="tJUqOy4q"
Received: by mail-qv1-f49.google.com with SMTP id 6a1803df08f44-91ba8fcc684so3507376d6.3
        for <stable@vger.kernel.org>; Tue, 13 Oct 2026 12:47:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1791920842; x=1792525642; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=NTjEEqSqe2isomaMSLDVTGf6TgdKb/jqa049850vzw8=;
        b=tJUqOy4q/oQzmdqeH1LYctKeAGChJEWcDs4k+GVHAOZshwUBUvOJzwuwfl9xuzrQZ+
         8vBS516VMFNSF+yBwJwtbTgj2x0TxEA+gM1mUjPXfCNZv8IavaVrTM5p5qcK46MOsEtY
         e1BC+3PpeypRRbfjH7HeMBKEv3wmu2T4civuIfhfnWA/dssYdOzdNV7leHidfHfcHdKu
         INYl8H6X7SHDLf+kGJrxu5Ktn1ZWgTqj91+eBhugXind65ZZDw0IhL9gHhc3qUvB8is7
         d5t+W8Rw8XbD2YTBSOt5MV4BLkx/jNHinLFj2XGitgx1pmOg+e5gV9M3pcMKdpFua7tx
         dOsw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791920842; x=1792525642;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=NTjEEqSqe2isomaMSLDVTGf6TgdKb/jqa049850vzw8=;
        b=EGK3IX5ms6dwNuBK+F9XVz68WcN5oyc7tezb6tzINaOWP2JSpT59vQg7bGhQbWLMg7
         KJBTjUnM/DAvTmiY3qm8rk1PD/KCRmQD9gjamySyJpleQqo2tNgN9sOXXQD7UAWK3qGG
         xasFkOGthg1YeNFLpiREoVY02mcLSFxyPJhEavvbXoqD0azsZ3YvoLqZOa3ebXrkiXgw
         0cgvusjsfqpFP0N6l50W9c1t0MP8SXYn3gnnWDbBlsw/FtkUrfsT2YLezO3RqWJzN5gS
         hsg/gP3UjI8xyJkCaQ+oZAAa9FgI6tSM/dQEkoedkYledT85GJm3ryz9K+AtK67g2AuV
         wwPg==
X-Forwarded-Encrypted: i=1; AKwUvBwn4UcUoCiW6MWUc/LR88fijIjGVs6+Pyxq0dHJHfPKcJWpP6M5BjGi0UgPx0n5KUPjJ+FOLPk=@vger.kernel.org
X-Gm-Message-State: AFq9FYKU4YW02uI0yJERcDpnIG2AMOpXgEF9f/YXeFKtk3Sod1oVeSKQ
	tCXcx6oTu4JYn6/5NWnfuCPqxF+Q9t+cZzCCJmwisr+c42sx0xuLDHfI
X-Gm-Gg: AYBFou2DhP/Kl4IqYK0qyENqFxxYP3x8XLYbWz/AfhgjfTbmUSEjVfxbw/7GJ73RYSc
	zwEU+FcG+yrmFihJc/ZdRkBlmfcc/Tl3kDJ2KV6Z0xDF3asyEyLrz0fSAHZ3Z8TCURNNYbozgVn
	hKM+xYbC4YhP9QvZ40qRQw8Tx6APuCDk0kXzekisCV5u7P0xfagtW7eHn2EpDkuHnMSYAxGsnyj
	jGoHEiWYYeivSXETctGmdEHMphxVCXMKbyNuvOGSGeHJfH+hyDCAD41BTlsC5An+lOhfGud46qP
	QZUJRxHiNYjlH6CKwr7n7ljpDUOQHUwaHtB/F+6fYSqHrzxWq/hf4h+UdSnJv4X6V/svck/4ucP
	IHZ9gtDltiEs9M/yMQRYZeTMAlTnKFg/uSZRAX43PQPYALfaNxKLUcLR2JV2HOaG42EeXKJlxb1
	fKt5z9c7mBoTncXwO9GiLj1xu88krAu6q8f/c1Cn1JGI7hQGQ8lKlJ2iLb0TWa5Uy6mxK7q4o1/
	MwAy4RtXMYR2b0Lu+SuEms7
X-Received: by 2002:a05:620a:40d5:b0:93a:f9:614a with SMTP id af79cd13be357-93ebd21ffc4mr2195060185a.34.1791920842369;
        Tue, 13 Oct 2026 12:47:22 -0700 (PDT)
Received: from [10.67.48.245] ([192.19.223.252])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-93ef5090050sm312910585a.40.2026.10.13.12.47.18
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 13 Oct 2026 12:47:21 -0700 (PDT)
Message-ID: <0873cca2-2f48-42bf-9297-e543981161b3@gmail.com>
Date: Tue, 13 Oct 2026 12:47:17 -0700
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 7.2 000/281] 7.2.11-rc1 review
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, stable@vger.kernel.org
Cc: patches@lists.linux.dev, linux-kernel@vger.kernel.org,
 torvalds@linux-foundation.org, akpm@linux-foundation.org,
 linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
 lkft-triage@lists.linaro.org, pavel@nabladev.com, jonathanh@nvidia.com,
 sudipm.mukherjee@gmail.com, rwarsow@gmx.de, conor@kernel.org,
 hargar@microsoft.com, broonie@kernel.org, achill@achill.org,
 sr@sladewatkins.com
References: <20261013112855.045212108@linuxfoundation.org>
Content-Language: en-US, fr-FR
From: Florian Fainelli <f.fainelli@gmail.com>
In-Reply-To: <20261013112855.045212108@linuxfoundation.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 10/13/26 04:35, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 7.2.11 release.
> There are 281 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Thu, 15 Oct 2026 11:28:22 +0000.
> Anything received after that time might be too late.
> 
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v7.x/stable-review/patch-7.2.11-rc1.gz
> or in the git tree and branch at:
> 	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-7.2.y
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
