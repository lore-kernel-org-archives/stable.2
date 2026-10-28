Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.47
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793221954;
	b=q/Yl4JWlcqtCulWyYyrXbDItEnXuqysW2Mh7EVR43WWbuGEJxoZvJnWKfeaEKDV3D15+
	 kOPmsPmk4CGTDhzyhXPELI+bdsn5mhgQbptqnweBjiLQReeja1WYviKLzLHSw9yfZ60kP
	 SDi/WXvRA29BWnRnk4qy41hc1yxBzIQVkvXvhUmeF2JkdS6tN09JOqRBGl9Tlur4Faq4L
	 9qUdaQcz5jSp5wI6ujwgVrR/R+Q0mgZRimCpnDp86KoRy+AN0yfVTyMSVbYzD9pl9Jhgh
	 HVrFXfXIVPHmn3pI2mDzYA2GCu7HCBTXhf2vNdvT4CT6Gcyhm9MA0eLH5gZswXCJCJg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793221954;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Message-ID:Date:MIME-Version:User-Agent:Subject:To:Cc:References:
	 Content-Language:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding;
	bh=82VJuvmKc1OoqFuJLY+l5up9uTowgLJIPwv+wCQN7vo=;
	b=QdIIWgXPDC6F1flD2Mp8LBI0E9WFBi2Pw+BUcqiUgELQADbLgvrQCyWgKhpuQErZUygJ
	 wVHlSjwm2JeaKeZu5MWXcXna6NKTo7KsI4m0hDk0LfoSVHsQENPnEBeLYUUAXVvS82JFQ
	 xrt6KJuPueFNUubxGmbh5y1EcB6K2ygr5DEKlH8wGIoit26BzV/OVilyncCp0HJK6qYH5
	 bbaiQIpOVwxVSH/ub4Q+jB4EDs+ol4b4e29V58O4wmGvauGftrLNMZDBFtLG4e+Ypb/XM
	 p/fOS4vTNQVOYXG70UXLaAEcR3Qs17aHWBb1kP77P8yY/5aiSnx6h8bM/KRHkz6SYbg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=jCtW4bL8;
	arc=none smtp.remote-ip=74.125.82.47
Received: from mail-dl1-f47.google.com (mail-dl1-f47.google.com [74.125.82.47])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 23994606A31E
	for <stable@vger.kernel.org>; Wed, 28 Oct 2026 21:12:34 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 23994606A31E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=jCtW4bL8
Received: by mail-dl1-f47.google.com with SMTP id a92af1059eb24-1a2af4c8d00so408292c88.0
        for <stable@vger.kernel.org>; Wed, 28 Oct 2026 14:12:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793221953; x=1793826753; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=82VJuvmKc1OoqFuJLY+l5up9uTowgLJIPwv+wCQN7vo=;
        b=jCtW4bL8ViyeaPeGnkvFW0Tzyl2oJjwAx+AaO1JohvbXzWXa5Tl400aetJxSp2/g2b
         F7QGxATCzvbMzO4Tpnf2AdjeNhF06hg2rmS7jnCt4rJimBqjGXl26MNBvjCLzyKyirrn
         M3z2JoBV6xqTH+c8Z2rtkdhWnvQd/TRWi6abLIIr1uivkt7TyVpsm5LRqzqFWqjwXzZl
         H8SkJ7c5uHdqj2q4/Hb0f/dRHQgiRR4176TkgCVBMk9fq6Ii4sQG1e2ua58o81Uxw7vY
         I6uxnJ3BpOh2sdYuxyqjC1lGzpc5vcgTAJYtQU11zPzAu4op2oMg+ue7HUvb/ttxyMMZ
         m0sA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793221953; x=1793826753;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=82VJuvmKc1OoqFuJLY+l5up9uTowgLJIPwv+wCQN7vo=;
        b=X0CY/f+Bqp0UC3ca6ZeHjVZpFciNKzquAzthA/t5jhytV0TkKMFrdLnjxMFqL/mewG
         HTZxyIFiF08lKfInu4lFQ533vFsLOoTguLM/V/PN0mKErQtJTzf34cYxJW88za8zAb1o
         3IyIL8xPaOLOgdYfxDP0m8LnBHZvVjXomStnb7LaJMDWTsvp9zxn7eYngKX8sL7yPX1P
         3zXfz8ru4Mh0RRSeCy5WVqNjypqLxyFyfd+HpERaWY2/qJLuOO9t8cL/1g4+mosoXOwA
         w8erKK9QExwVBNnGlN20UlD7vqChfkiTIdTk8SJY2YA29vvTdhnkhcGkxvdIgpu56QHI
         yfhw==
X-Forwarded-Encrypted: i=1; AKwUvBwrEtfwWo4D4ywg1HunEArDzGFWUNglVvjd5hatW6mtH0KiEGtxV2uBxQkCMHuqjVPEdv9Q15Q=@vger.kernel.org
X-Gm-Message-State: AFq9FYLZiGaXf8FjU41jADeIy4AjLsU0M3T32ixHL4ki4JMCbMnmPS4p
	vQhOyQkwcSu844104/sWp4MT7KOXaxmCEYWWGWKP+pE/Bkf+/7VFpta/
X-Gm-Gg: AYBFou36nj3VOLmJv0fKwH+jZ1mqVfYjhmtezZv+49J162iWk8z8JVR2FZxWWYF0aHm
	aq5q22nBVDZ2HamHgpmoKreabNm37cWVoUbgDSuUtxW9sqr6vhg/JKSzkILIkAIK4ZPloTQrxqc
	lPyCBNQeb0X6aJcj2gaL49BGkjfYXuuRT8F06KGOUogE+3n1M9c34KJwH/TyryVuGv6YmD7a7uS
	IffulNjf9iUivOHteV57WugLdM4KhJPAdMEFX7wp96MUmTFELrWgXyWFDYBbk/1yThOqZIc+0Li
	tYbS608IfLr9xQ1F+7Z/Bg7SWMA1pijKBojfMUF5RUo9fSgtXDzq84Aq4GlpREYksf/VtoXY/Vc
	OGJmqU9cwewHkdoe0eg4mpt0O++QRgF9ANJFvq/nhFa3f/pOTFKeELh82aadSXGooUwrHEVsclb
	KEIDca8BhrHWIvlyr6B8h1rJXM3A75aWqZ5jGw8SE0FOtjhbV0ebPiftaZ1t9gHEpuCpX++f4aq
	qv02f9fA91M3j+sIde0GcuFqY1IU2qFizMR8kRQ0dHMBAKhqFRZgNKu83DCuPxjx5oEjvXFpsVf
	97GIxIFnylmcRcsi9z8NVZUvNNFaATRx9wL1aanncXG+C3xcb7r0KVRK
X-Received: by 2002:a05:7023:88c:b0:143:2984:6518 with SMTP id a92af1059eb24-1a6ce209cdbmr5369225c88.39.1793221953208;
        Wed, 28 Oct 2026 14:12:33 -0700 (PDT)
Received: from [10.67.48.245] ([192.19.223.252])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-1a75a37093esm7126375c88.3.2026.10.28.14.12.31
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 28 Oct 2026 14:12:32 -0700 (PDT)
Message-ID: <f09f94df-c5e7-45d5-86a6-50be145f6655@gmail.com>
Date: Wed, 28 Oct 2026 14:12:30 -0700
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
 sudipm.mukherjee@gmail.com, rwarsow@gmx.de, conor@kernel.org,
 hargar@microsoft.com, broonie@kernel.org, achill@achill.org,
 sr@sladewatkins.com
References: <20261028170459.200466217@linuxfoundation.org>
Content-Language: en-US, fr-FR
From: Florian Fainelli <f.fainelli@gmail.com>
In-Reply-To: <20261028170459.200466217@linuxfoundation.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 10/28/26 09:34, Greg Kroah-Hartman wrote:
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

The ARM 32-bit kernel fails to build with:

In file included from arch/arm/probes/uprobes/core.c:9:
./include/linux/highmem.h: In function 'memcpy_from_folio':
./include/linux/highmem.h:427:21: error: implicit declaration of 
function 'folio_test_highmem'; did you mean 'folio_test_hugetlb'? 
[-Werror=implicit-function-declaration]
   427 |                 if (folio_test_highmem(folio) &&
       |                     ^~~~~~~~~~~~~~~~~~
       |                     folio_test_hugetlb
cc1: some warnings being treated as errors
host-make[6]: *** [scripts/Makefile.build:250: 
arch/arm/probes/uprobes/core.o] Error 1
host-make[5]: *** [scripts/Makefile.build:503: arch/arm/probes/uprobes] 
Error 2
host-make[5]: *** Waiting for unfinished jobs....
   AS      arch/arm/lib/csumpartial.o
   CC      lib/math/lcm.o
   CC      drivers/video/console/dummycon.o
   CC      sound/core/control.o
host-make[4]: *** [scripts/Makefile.build:503: arch/arm/probes] Error 2
host-make[4]: *** Waiting for unfinished jobs...

this is due to 341d4e6294d9 ("highmem: add memcpy_to_folio() and 
memcpy_from_folio()"). We would need to also back port 00cdf76012ab 
("("mm: add memcpy_from_file_folio()")
-- 
Florian
