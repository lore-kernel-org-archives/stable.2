Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.210.170
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795029398;
	b=2dp+wH6kVMNuJC4vhYaaovCld2JDdUwVjZ/KVlmxOZAU6OHWZaelPJSDH8HlUf3N1vMD
	 bHMusPcTdiNHQ/l4FlBPyavAJMzgZjOOJGfT5dUuBtT9sq4E5y7uSq1jfJ+3U4maTJx6+
	 W2/irZCikAef+f63PyvuWTClUWt4HckWVRwgGDIq1JTd2STx7/9/ICkDKqeiUOUs+rq2a
	 E8VizkEoOAp9HS7q/fYcmqIB8ENcnxGBhWmx0P0/n0x6nRbFPG1XQ6fBeP26YiSQdXhpB
	 6euMhfGeZLfoXhDccDV4p8oZHCKSCJRfyafwq/cuO7WUa32OCGg6pSslnjc4/N6KWWg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795029398;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Message-ID:Date:MIME-Version:User-Agent:Subject:To:Cc:References:
	 Content-Language:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding;
	bh=58b5SUFBCY4/MY2JUfmGH8gHdBS79YyzhPLRjlW4m0U=;
	b=u1fymOMYdXjjGvX+rsROWqw+ZRtmQxg6hQK51T+T1SvO4dHADoP8BjfXpjpVi/5dJAlH
	 sBcCTQbAT2t85oOfQyqrAmVtp4FoCFFreACy1At7agirqRS+wF9+NVk0czaRM/8v4jA0x
	 YpzWCOUU+CTKXw1j68bi598eqq2lf+AacBrPLdPAOuyw7PJXQ6Bs/6tXaP5EWxf4zTAyk
	 mgh90MKVRCttv4YOurZIwiF2BGJmQhW5DhvEQcpuXM8d99hmPVr1L21vjC3Q9vXOgFLNb
	 oxRdSzxxuDJYiUaRjWkDZOJ4BfgyicTxAcOWLkq5EBYyeyHY//Z+ixbUSgOHSYrtjIQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=tJYexqmp;
	arc=none smtp.remote-ip=209.85.210.170
Received: from mail-pf1-f170.google.com (mail-pf1-f170.google.com [209.85.210.170])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9DA09606A325
	for <stable@vger.kernel.org>; Wed, 18 Nov 2026 19:16:37 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 9DA09606A325
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=tJYexqmp
Received: by mail-pf1-f170.google.com with SMTP id d2e1a72fcca58-8b58d6f67a5so840260b3a.2
        for <stable@vger.kernel.org>; Wed, 18 Nov 2026 11:16:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795029397; x=1795634197; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=58b5SUFBCY4/MY2JUfmGH8gHdBS79YyzhPLRjlW4m0U=;
        b=tJYexqmpB1JqjQGtscML6/STrXZSc3Zf/53lM6/iVI+Lp3aqnTaQk1NbjW5KKOb4BC
         wdT4sl8305PhWVaBETctmMi6n9bHgdThPbx4CCPY6sdren85WFDhcebDlSmNOKdg8lgz
         qP5JT14iXk7D5/MguF9AIPPm6bN0OkZNFh3GMOYkffuWqQs39r1204o/C13KnJFRBMTu
         19SR9+hDSgU0CC1h8oBYIhkLuaBuJRVSUXjABjOJJd2DGIdj/8joy2OLZ348YytSY22O
         8lfWisihe2ewhIxhtQstSAsPkq+VqLEL67gzBWQGFJXH3VkNDr7tdHdzfxMiMLtK4MKt
         zLnw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795029397; x=1795634197;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=58b5SUFBCY4/MY2JUfmGH8gHdBS79YyzhPLRjlW4m0U=;
        b=0+jNCi8ZP84k82yznA9/3cOVRVScRAUKW2XLbUR/oaJsbsM9GPqy368EZlq4EXmBCz
         gr1C5TPKhqCo3uQNxcL1YKOJIsOFP/jcoA/U0tSZ0uPlkO9ErVKKctaDsg+Gl5wTPxV/
         xDmLpn2tIfKUj4W1rp8MxmzXsbh5kc609fA4RV0A5toZdr/NOXqKpVwIRGAr5txz4N6E
         hidhB6CJVHPuoneRNcubcLhThG1GDo/rqgIqRHGz62DPLOhWyABdhjIWfvhSaIJ92qmL
         z8ZZbeBH7F8bKQ4Vs4gWwhDm1xwj7ugONNpqo6aPjHtWtA7Lqn38HQeQh/wMvx7cwIew
         0wqg==
X-Forwarded-Encrypted: i=1; AL+hErF3vHPdER+8ZWlP8Z/F/DWUhmL00HAA3gQABt/D8xbJ5Gd92+2AnGGyfYLEBfpYa4EJM3/M/EI=@vger.kernel.org
X-Gm-Message-State: APuU4Z+Yad9QQCobe4SVYPqdr+9tfnYInaNlp761NF+RJbN/qNoNfbuR
	UV3MuYqxrOol513xf21QbP6B9VN/op9Qv5WArk/OIvMkUel3tvQgt8F+
X-Gm-Gg: AYBFou1IKQ5XJjfSzIzkmxYGiXMK8FKZEbjh/q9J4gUF9c6WENiTRwVNE7L8ZrYMp5b
	DSQTFjoLXdfToScSD5DMMZT8AymOypgJckaSW8Am/fk9fVoHmQQSRRfq/35XmqYH3N5NGKxp678
	VMBpjobm4N8ALQSyNtF0GW0wp1ZgI0F0PokFCJXr48jtLpF7+wamJjNS0zsi3d1D18r81ScljqY
	xuC1XC6kGqF8pP1YmmaIp8E8b+OQtUM/TdGxdx/sW59TolfZAdrOlq87c3fKJqr0W8rPbEtXKKy
	XpwWJa7hDw+oHg4mpjazCM9wWz5WDkz93kInliwxDQPHJNMESD/pD7t7ndM0aq4TWWSTVxu2DPm
	1TfRM8tGUyYthjCggDQMvQ9Wzg/OPklBS6CMLuh/tz4Q26Bt4m3gf6maARkc6boPVITD+wdtmTt
	kFGxMhCeKHghHVGRAO4pISJfs/1mWIj9SyF9s6b0A+2MAoDFn7wSg9dJlNe+aSgeM6ZSrvZ0zH/
	MGGkQxyPtPTm0S6NCE9f7+PMUsPqKogrYwUEBd5CAbCD31SqjDl0RlWdsW+lDSeOZ6OMOU9MW2N
	V2RSlr2hRFgOb+cUkWu1aRroeTg9yazrH8PRby05ubQCnAfft7iqi5UA
X-Received: by 2002:a05:6a21:b8c:b0:3fb:1091:bfdc with SMTP id adf61e73a8af0-3fe97bf78a2mr3539072637.37.1795029396924;
        Wed, 18 Nov 2026 11:16:36 -0800 (PST)
Received: from [10.67.48.245] ([192.19.223.252])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-cde534854b1sm453228a12.12.2026.11.18.11.16.35
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 18 Nov 2026 11:16:36 -0800 (PST)
Message-ID: <65c24a95-1087-4f30-9f9c-9e8636da211c@gmail.com>
Date: Wed, 18 Nov 2026 11:16:34 -0800
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
Subject: Re: [PATCH 5.15 0000/2214] 5.15.226-rc1 review
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, stable@vger.kernel.org
Cc: patches@lists.linux.dev, linux-kernel@vger.kernel.org,
 torvalds@linux-foundation.org, akpm@linux-foundation.org,
 linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
 lkft-triage@lists.linaro.org, pavel@nabladev.com, jonathanh@nvidia.com,
 sudipm.mukherjee@gmail.com, rwarsow@gmx.de, conor@kernel.org,
 hargar@microsoft.com, broonie@kernel.org, achill@achill.org,
 sr@sladewatkins.com
References: <20261118150009.797899913@linuxfoundation.org>
Content-Language: en-US, fr-FR
From: Florian Fainelli <f.fainelli@gmail.com>
In-Reply-To: <20261118150009.797899913@linuxfoundation.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 11/18/26 06:27, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 5.15.226 release.
> There are 2214 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Fri, 20 Nov 2026 14:55:35 +0000.
> Anything received after that time might be too late.
> 
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v5.x/stable-review/patch-5.15.226-rc1.gz
> or in the git tree and branch at:
> 	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-5.15.y
> and the diffstat can be found below.
> 
> thanks,
> 
> greg k-h

perf fails to build with:

/local/stbopt_p/toolchains_303/stbgcc-12.4-2.0/bin/../lib/gcc/arm-unknown-linux-gnueabihf/12.4.0/../../../../arm-unknown-linux-gnueabihf/bin/ld: 
/local/users/fainelli/buildroot/output/arm/build/linux-custom/tools/perf/perf-in.o: 
in function `test_truncated_branch_stack':
/local/users/fainelli/buildroot/output/arm/build/linux-custom/tools/perf/tests/sample-parsing.c:358: 
undefined reference to `__evsel__parse_sample'
/local/stbopt_p/toolchains_303/stbgcc-12.4-2.0/bin/../lib/gcc/arm-unknown-linux-gnueabihf/12.4.0/../../../../arm-unknown-linux-gnueabihf/bin/ld: 
/local/users/fainelli/buildroot/output/arm/build/linux-custom/tools/perf/tests/sample-parsing.c:360: 
undefined reference to `perf_sample__exit'
/local/stbopt_p/toolchains_303/stbgcc-12.4-2.0/bin/../lib/gcc/arm-unknown-linux-gnueabihf/12.4.0/../../../../arm-unknown-linux-gnueabihf/bin/ld: 
/local/users/fainelli/buildroot/output/arm/build/linux-custom/tools/perf/tests/sample-parsing.c:361: 
undefined reference to `evsel__put'
/local/stbopt_p/toolchains_303/stbgcc-12.4-2.0/bin/../lib/gcc/arm-unknown-linux-gnueabihf/12.4.0/../../../../arm-unknown-linux-gnueabihf/bin/ld: 
/local/users/fainelli/buildroot/output/arm/build/linux-custom/tools/perf/perf-in.o: 
in function `test_truncated_swapped_raw':
/local/users/fainelli/buildroot/output/arm/build/linux-custom/tools/perf/tests/sample-parsing.c:406: 
undefined reference to `__evsel__parse_sample'
/local/stbopt_p/toolchains_303/stbgcc-12.4-2.0/bin/../lib/gcc/arm-unknown-linux-gnueabihf/12.4.0/../../../../arm-unknown-linux-gnueabihf/bin/ld: 
/local/users/fainelli/buildroot/output/arm/build/linux-custom/tools/perf/tests/sample-parsing.c:408: 
undefined reference to `perf_sample__exit'
/local/stbopt_p/toolchains_303/stbgcc-12.4-2.0/bin/../lib/gcc/arm-unknown-linux-gnueabihf/12.4.0/../../../../arm-unknown-linux-gnueabihf/bin/ld: 
/local/users/fainelli/buildroot/output/arm/build/linux-custom/tools/perf/tests/sample-parsing.c:409: 
undefined reference to `evsel__put'
collect2: error: ld returned 1 exit status
make[4]: *** [Makefile.perf:670: 
/local/users/fainelli/buildroot/output/arm/build/linux-custom/tools/perf/perf] 
Error 1
make[3]: *** [Makefile.perf:238: sub-make] Error 2
make[2]: *** [Makefile:70: all] Error 2
make[1]: *** [package/pkg-generic.mk:286: 
/local/users/fainelli/buildroot/output/arm/build/linux-tools/.stamp_built] 
Error 2
make: *** [Makefile:29: _all] Error 2

which is coming from fb1a8ab598b3 ("perf evsel: Validate branch stack 
before byte swapping") and 2bdbf51d3627 ("perf evsel: Validate RAW 
sample before byte swapping")
-- 
Florian
