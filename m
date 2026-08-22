Received: from mail-pg1-f178.google.com (mail-pg1-f178.google.com [209.85.215.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D980033A9CB
	for <stable@vger.kernel.org>; Sat, 22 Aug 2026 17:05:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787418337; cv=none; b=AgS9Dx8PCBzMrWVAxN+rXz99DfwYSTuowfuyI7bzYYg6TDO5ipFyu7OHYcrW9heF4MNN+1NPJv38eR8Pnx3DEaIz7RwhTPLyUnOvLzrpB/QjSD+tCBfJ6Uo5teeZCR+VkhMcjRI8dojD6GaQl/kP9el48CZA31mwRZ5l4Dpoo4o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787418337; c=relaxed/simple;
	bh=QPLlNMMbjesKQsWEfI/phjjPWXr60vHoWmwqRuUuxs0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=rLCGcmY/uZ+tqD8Pwg8nX51tH+WCtvJXDRp3vhs9GVmTcICro2ruh73OqtkeY3VHTth6NUBxu/mz2R+M7i/cR+/31jsq3Bn31QJiWcaX93w8K332OhbxeXtrCg/wdb3CmSnEWKNrBIh+Sfnebl0yhx1fNMXJjdlCNSpD7qFqCGo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=sK4dqwcz; arc=none smtp.client-ip=209.85.215.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="sK4dqwcz"
Received: by mail-pg1-f178.google.com with SMTP id 41be03b00d2f7-cc147d86bebso1742876a12.0
        for <stable@vger.kernel.org>; Sat, 22 Aug 2026 10:05:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1787418335; x=1788023135; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=94g4E3XXKB5hk3Ok+4/woZgjePfy9NT9YGo5t3pERx8=;
        b=sK4dqwczWA7zHHpziCwQ2JQVG8hc+QbkE468P5qU1ilhioCdytKf2wRVUQt53qrJse
         PwhRNtDMDWbzjj43EkT7AyAxES8QX76aq2eVJS4xBmUod36SIFJBIw0F1SyMa4tyBFTh
         sP83UlCbjY4T2cwWqkqdU4wKfw9xJ57gtLup8ug9uARo8Hf33AyXND4V6zIHUoTyx4K9
         56l84GH/BeMDd57w95fSmYLna6aF37oDcSteT84asn3Q/h+2KsFSlO4sgGaO0Hwys67Q
         p6e8lXLUQH4k7J/nxnNbOK+KW53vo+SvS6/kmBv8Z+Z76qLL32bbluE2ornYqj01K10v
         fOIg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787418335; x=1788023135;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=94g4E3XXKB5hk3Ok+4/woZgjePfy9NT9YGo5t3pERx8=;
        b=ZpNBj0dMpRI9PVzH+3rHNlL2Wu9EA2+9abNSwldBZyUpVZ3B50XMMY/q1xcp0fyrA3
         0GZEE3ER+8soD4peca7kCFIEZ81T93fH+vc5ylEc8IlBDXItyiAxVmhTdIZIL33VJQ56
         4e/2pu7nq6iEdbeM/85ADJyJnvVRw/a8PvNs5J+NdOdYqs1Vv8bMqoQ13pyaAOCSPhNx
         yp6xHWuYQAwaMqlXmQwi+Lmg6ZXpbPyVmQ0Sqyw7k7sLudVXK1+eAwge+3iCe5xYoI1d
         Ll93XdTTjY17JpsuUABG3tppBQvhStyTZO3Bk7I6xLJ2++Vb1q9tkoWexGL5s7k2/UAR
         Mhtw==
X-Forwarded-Encrypted: i=1; AHgh+Rpc82JEEft7jq16H1mUuvDn3Tfxgc4CCJPoCj7eGGsN9ifCG8SsTrOWHiNEE+jmeVOtJCUELpY=@vger.kernel.org
X-Gm-Message-State: AFuF++m5JAk9K7WEGAfbGPuUHFqkLJ70uiSnLLlPmXYSwdKU5SctB7dL
	H3jQAewf3n/4gg8/w3/eVmO3kdHvju89GKvBIvwV3tEZuT4Bk8b4ZGZ7
X-Gm-Gg: AR+sD12x33OYBXhyJVk0HrNpaULIVrpU/4I0TSEUvI6QcCRfsbWRmussqHxZQhZLhnW
	BWJS/JfS115mtBJ/tO4P9EBu7e9kHnWrP76u5o8dV78AXHYXLis3YAMUPqerNEp7u6+VuK5m0rv
	M6mA2mGKldcoSVzBi6TVs/7vGqacp4ncSudADZsyJTp+32O7CF6niYEShJ/KSq7IYUN2sABFgg0
	rUupLVCPfeoAH2fsms5YslkgtqHwfpmRlNxwE7Qu08BOwBoxDMuSegpbc/mkvK/gayr0CMWdptb
	mwUWpWH+7PCgp+lyrjkjcRJFjCX5bOuhWLBDXZUVnTnqsz4J1DBUvoBOSQFL3mHXdCLpuo5HoJM
	eqHDK4kAsW5uOa5EDp1MMwAW3HfYty4RcGxyjZUEccdN4bJV6U8ARkTRU3I0Vcdi3hPKF8ZlzPM
	m6zoO2Q+Js67ZUaDvOZwk+3TTPbQFfsxvcadIM1aUEs65XmIWT/tKWO8jLyUT0R9MxW43iMD+Xx
	nEdu9WA+vQtkftN7Yxvx+717ar4fQ==
X-Received: by 2002:a17:90b:3bcc:b0:37f:a913:1554 with SMTP id 98e67ed59e1d1-395a06bc47amr26496228a91.16.1787418335043;
        Sat, 22 Aug 2026 10:05:35 -0700 (PDT)
Received: from [192.168.1.3] (ip68-4-215-93.oc.oc.cox.net. [68.4.215.93])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-1418617378bsm8669683c88.11.2026.08.22.10.05.31
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 22 Aug 2026 10:05:33 -0700 (PDT)
Message-ID: <aaf725f0-c618-4b01-9233-4547fb1ece84@gmail.com>
Date: Sat, 22 Aug 2026 10:05:31 -0700
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 6.6 000/160] 6.6.153-rc2 review
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, stable@vger.kernel.org
Cc: patches@lists.linux.dev, linux-kernel@vger.kernel.org,
 torvalds@linux-foundation.org, akpm@linux-foundation.org,
 linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
 lkft-triage@lists.linaro.org, pavel@nabladev.com, jonathanh@nvidia.com,
 sudipm.mukherjee@gmail.com, rwarsow@gmx.de, conor@kernel.org,
 hargar@microsoft.com, broonie@kernel.org, achill@achill.org,
 sr@sladewatkins.com
References: <20260821142844.249995408@linuxfoundation.org>
Content-Language: en-US
From: Florian Fainelli <f.fainelli@gmail.com>
In-Reply-To: <20260821142844.249995408@linuxfoundation.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 8/21/2026 7:30 AM, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 6.6.153 release.
> There are 160 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Sun, 23 Aug 2026 14:28:27 +0000.
> Anything received after that time might be too late.
> 
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v6.x/stable-review/patch-6.6.153-rc2.gz
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

