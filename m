Received: from mail-pl1-f170.google.com (mail-pl1-f170.google.com [209.85.214.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D2A6649B1E0
	for <stable@vger.kernel.org>; Mon, 14 Sep 2026 17:43:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789407838; cv=none; b=KoKuCIZwbKLrR+kbzDizSH4+hSqKh3H1AL9qs6hgpCFikPtU46OOMHJaADJ9bcDJJ0SFbD9gRAXqtTNKc+e12nmfndHdHvA3BHD+Z3vuItohbQflXB+7w6ipYgR0umIOwRdYo6IZVX+3B3nklt1sg1zWg0bT1YDOxlELnSSILJw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789407838; c=relaxed/simple;
	bh=8gcIc5zX6si5qsb6q2DxuxxIhhXy9/rwBO1dH9VLJV8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Dlc/q5FivYfwZI+xvBpuaHRUGwCXWSrie+Y8TQzohqjSqcCyEKBrVehUcLLfTXur2P/AEuMbZ/PQ5m5QeoUb3U4l+cUMZn8NFV4xEQQar2WrcYbO23FJlQclIA8m1uKbS6X6uX3JdaWx5CyQEyqYfBKVqFeKW+QSK6aO0cL4AoU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=s7LNkvbj; arc=none smtp.client-ip=209.85.214.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="s7LNkvbj"
Received: by mail-pl1-f170.google.com with SMTP id d9443c01a7336-2cfbbdfa60bso38056405ad.3
        for <stable@vger.kernel.org>; Mon, 14 Sep 2026 10:43:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1789407829; x=1790012629; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=FBKrvUeumU+i5r59LsbnvjiB+I7jzK030rNSwtlDdoI=;
        b=s7LNkvbjlM1WZODfDH1x461XwS7BeKHKwrqj7CM0BKifVJcCLNQe53rdvSK80VuuLs
         SUdY510Iml4USVxAV0LA98dnylYu6zGjfWfvk9/D95sC8gRLVgdG7PzjZmI5kBILAXwz
         4g8XwbCoLB6Duv/gCbK2mfTDb0uwNUOuMZ4xQD1bbcCdlDIB2ve1IDu8Nv5hmsaWepqj
         +3puSQd+cJeaSzyLb5iW4iPvy359PYVMoPw8QFg0qVK3yHf97HEhB66dPCL4T+Zuc1+2
         hamLrHjJtvtVkudyQl2FSQP6RzY53LRcrIm13MhhICSilAtgdeqNb0y+wnWpmCIAgws5
         SrtA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1789407829; x=1790012629;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=FBKrvUeumU+i5r59LsbnvjiB+I7jzK030rNSwtlDdoI=;
        b=hcRJvEwID6oq1/LGz3OoBFaL0p1+uKpAQo4L6AXNU5VpJf+v3TJYWmkL7AvW9QYOXb
         y+OchjV1opdxAO7W87OvK0Mr3HLQsFwNij9hu0HL+NLh6ReX5/rt2xRo8SCjFqsVkGzj
         o77fJcfzfoUjmytS/ZyhFxULpGq2e5n3Io3AJgZZEitgqf6Lcwts985VnaeqHLeYSSHW
         TpUi6MpDwppC7Zx1M4wpmW8ko1mbGikFdjL0EJNcND4MeHGamNmfnzEcTs8PVLAORWGq
         fBJDrCBmZLs38e5f5qAF2+qvHUPxOY4uJc5/GPwOz1aue3G6fc8SV9LPv6JcAucwB0w2
         isgQ==
X-Forwarded-Encrypted: i=1; AKwUvBzrJRttaXh7pQjAAOh1kj0+YRphOiyv4rzq09QS68q1s79lYsvl56SxZGuA314IH2YgDLsgvgI=@vger.kernel.org
X-Gm-Message-State: AFuF++lexpvQ9gN13w09qUXCVKc9AhSyLaFyKZuc/CmjLtMDJV5Waeiw
	kISOSStbVvKRINyoPEKALdK+0RcWDLodZZUpeXEiCFPw+InaINQenIBN
X-Gm-Gg: AYBFou21vM4YBSV+omSjmjAyyqR8v9uXlVwQ6Q4rNB5hp6tEu7+ef3FY58rI6txiXWz
	gs/VdLGtC2vkSNVahIaR1GuzbvnVdTETpCy5wTtGAtPkeAESqncPMc04GYeEEshkkG/yXOgzgW2
	1l9o7e5uJIqZFgmFVueoOJjHBF3kAc9Idii1jKbGGHECf0Y44PeDnPOv1swEMbVedPtPhFwmw7n
	eXLqXwfpCvnISi1e9hnImtIgaVDFkvZ4aVppk1tqEC1JR9k/HzmtVQ4qxGToES1+KucljQKPGar
	yaevfhfzPwJwwN6bg4tIibauD5dDO2tQ60TkKLcgpII7hZOfoxvdvifAJL4vQjlMwW/ZdRFVYgL
	6rk/x6fRe3q1uK7desijT9SW+RnA1EJ2UU3STLa3O4TO8QHk94fmRcPxT8H0pwOIvOir6yxq6df
	3TbGetOI1DAWrxkiOfLFWu39pQqHzfwl8YvkIwa6frE1Ejhquz4DjDRDCHD9IZXw1NI0BGyozOv
	IBWBmy8c+z91V+7Q2EyT/xCm5sxq9QmGRDS
X-Received: by 2002:a17:902:e801:b0:2db:331b:e187 with SMTP id d9443c01a7336-2dd6c5f3c7fmr68629005ad.8.1789407829308;
        Mon, 14 Sep 2026 10:43:49 -0700 (PDT)
Received: from [10.67.48.245] ([192.19.223.252])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2dd3e2dab98sm46940725ad.28.2026.09.14.10.43.47
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 14 Sep 2026 10:43:48 -0700 (PDT)
Message-ID: <80a9813f-13fd-4048-a479-5615105335e0@gmail.com>
Date: Mon, 14 Sep 2026 10:43:46 -0700
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 6.6 0000/1424] 6.6.157-rc1 review
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, stable@vger.kernel.org
Cc: patches@lists.linux.dev, linux-kernel@vger.kernel.org,
 torvalds@linux-foundation.org, akpm@linux-foundation.org,
 linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
 lkft-triage@lists.linaro.org, pavel@nabladev.com, jonathanh@nvidia.com,
 sudipm.mukherjee@gmail.com, rwarsow@gmx.de, conor@kernel.org,
 hargar@microsoft.com, broonie@kernel.org, achill@achill.org,
 sr@sladewatkins.com
References: <20260912065607.279695368@linuxfoundation.org>
Content-Language: en-US, fr-FR
From: Florian Fainelli <f.fainelli@gmail.com>
In-Reply-To: <20260912065607.279695368@linuxfoundation.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 9/11/26 23:40, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 6.6.157 release.
> There are 1424 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Mon, 14 Sep 2026 06:54:17 +0000.
> Anything received after that time might be too late.
> 
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v6.x/stable-review/patch-6.6.157-rc1.gz
> or in the git tree and branch at:
> 	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-6.6.y
> and the diffstat can be found below.
> 
> thanks,
> 
> greg k-h

Same perf build issue on arm/arm64/mips with:

util/hisi-ptt-decoder/hisi-ptt-pkt-decoder.c:14:10: fatal error: 
linux/unaligned.h: No such file or directory
  #include <linux/unaligned.h>
           ^~~~~~~~~~~~~~~~~~~
compilation terminated.
make[7]: *** 
[/local/users/fainelli/buildroot/output/stbgcc-8.3-2.0/bmips/build/linux-custom/tools/build/Makefile.build:98: 
/local/users/fainelli/buildroot/output/stbgcc-8.3-2.0/bmips/build/linux-custom/tools/perf/util/hisi-ptt-decoder/hisi-ptt-pkt-decoder.o] 
Error 1
make[6]: *** 
[/local/users/fainelli/buildroot/output/stbgcc-8.3-2.0/bmips/build/linux-custom/tools/build/Makefile.build:154: 
hisi-ptt-decoder] Error 2
make[6]: *** Waiting for unfinished jobs....

-- 
Florian
