Received: from mail-wr1-f41.google.com (mail-wr1-f41.google.com [209.85.221.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5378938AC72
	for <stable@vger.kernel.org>; Mon,  6 Jul 2026 10:29:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783333777; cv=none; b=s03L1fP35KzTT/hGZJPsbLcBBOkFHNRlf4KnCTibTDPkRa7OWNpi6rgQoL39B3MAUlQ+dqsBmMH6pKLye7igPzyTcfCFI9o64/N3hOMuvqKcmil/otFcpvlunow1O7oOkQnxVBLOhjBQsnWUdh61JWX3xNVrjQ0jjhNqxg6JCs8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783333777; c=relaxed/simple;
	bh=hQGFqx4IJ46LMfGQptkfnFSJjPUglR76Hzn2hDUlyrM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=pgWRmwbOp0xbKY/43c7q2u1gYglQiK23yvIGUYubF2jsHW0ENxnSLiJ7eTW7ei6U+xmo4d+16fA8E7Fl8/GDztGZj3fTDxdGdJdD7sWfPiT74H1duIFhxgWOh2l+bROgvnKsmvXE9SZpW5MtY3hccNynO8H9B7IcWFtkNeTSx7A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=iyb1G52l; arc=none smtp.client-ip=209.85.221.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="iyb1G52l"
Received: by mail-wr1-f41.google.com with SMTP id ffacd0b85a97d-45fd464d51fso1430464f8f.3
        for <stable@vger.kernel.org>; Mon, 06 Jul 2026 03:29:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1783333775; x=1783938575; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=DgZGkATc9v6IJyoP0jVfXRsi6k/bycnl80rgTX/hwpQ=;
        b=iyb1G52lQbBs6fBRC3uKy2e0WR/4BbRhHfPZ4m0FYsoFMfXM6+nKgHBP6lLNHDRVw5
         3yYP2/1qWv1BoBgE+ctsLCPPc/y/Kuif0N9Ll83lTlvRh8hw2IcUqI56QytmuV9vzhI3
         JHwW/rwZa9AKvNgXUm/5AKPQ9MHoCWLwm4q9/tCQkaWXzX8n78ZI/dWKxTfy9iXXy/Do
         Kdhnw4AlPCeciQDhzWCxaMdThcPAukPOWNdd/50TAHWMa3tgVSsRSBJ5GGh3G0dEWax1
         4biC8CWJo3ebb6E8Px7ANezHVL7Jt5jhuZmuIFXW/74tD0l9v9cJ/evzAQHXh72Z/oZD
         QYEQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783333775; x=1783938575;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=DgZGkATc9v6IJyoP0jVfXRsi6k/bycnl80rgTX/hwpQ=;
        b=cNz25Glcy2I+f0KRPTt2tiJ1vRMEHMU/wpILUmylxE8ykGia4fl0nEVfk7sXU8e92s
         slqY57pvsIboKbegraiBHVNDBmRNUFT1iWxrlinFmTyzgBBLaLXYhEkovuaZ4Jg+pGcj
         sHbmMq61UL1NOv7Hu6mXi2vAFi9Uijm0sb3NQVOs5prpvn8BXBhqFmuBkcpLkgJ0TZaj
         8NmD/x46HcarSpTSomH5s+zhbTDxkPJkkvXdvtW/BXzNBktLXFD28P68pb0MidEqgmdh
         4WE5bYnCUzgRX7C64zUiH0/2ov6VBbjjK63jNhjSeCYf56FEu5F1/wNTk7pme4x1NUqX
         cJjQ==
X-Forwarded-Encrypted: i=1; AHgh+RqQdIyeJm3VHzVCizPHFTgXyLJuPP84Dedq6SQqkXSZHeNDUyClVyU70599sCnqpbztTfJluKE=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxzt7tnJ7ZuE5nDWtKTWyil8uHY4ASQg4thggTRiw38bNZcFbEL
	FyuD4jLT+orytrr8GG5J2k0lMYPA4vdWcxrIJS2L7n8Sj4Tx/kkIpTRm
X-Gm-Gg: AfdE7cmIB7712ZBs72nT152BYvW9KpLadshzTd7Kj+F1t/paH4fvQsf+na2Q8WIAj/C
	NpZUd54KQHZVClAIpkNDxtKTe5j7IWdgw1UWlaC+s6O3k2yaTn95WEYLqVAJPOv7YrX2MZNHdJU
	JqfaVgA1gcI2WnGBMAR5Ho2Qtd/z/IMYnmWBVnFSpiWP91PdFUBmHeP2pjHzIfOPO5hsVUF7oyR
	VXmcXWtcKTb5BdU7986c8w0hL58KIMH4+4KbUzstWC538LmoLGv73l43IuX4FdGnoDmfSaDLOt6
	dp4zespwzSWlD/CokSj+OUjtUZa6ecDqOpbcAIz/9MNDSggDT2iqTDMMap8vq4Ly0kLrSxtQTls
	JbFnjzG3EuASNawEC8FvUCj9NdOMASU6ZpVzO+jwTaMUDuioQ1ql63whosfbDMrR9qD1UkCw0zs
	rzZPIE1t0BnsjaLEdiMlTqRIfWVqUx7w==
X-Received: by 2002:adf:f288:0:b0:475:f100:360d with SMTP id ffacd0b85a97d-47aac5e3774mr9178054f8f.60.1783333774411;
        Mon, 06 Jul 2026 03:29:34 -0700 (PDT)
Received: from [192.168.1.23] ([92.183.46.167])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-47a9b4d850dsm24605054f8f.0.2026.07.06.03.29.31
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 06 Jul 2026 03:29:33 -0700 (PDT)
Message-ID: <2728e1ae-dac5-4b6d-9e6b-8948b558a341@gmail.com>
Date: Mon, 6 Jul 2026 12:29:33 +0200
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 5.10 00/96] 5.10.260-rc1 review
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, stable@vger.kernel.org
Cc: patches@lists.linux.dev, linux-kernel@vger.kernel.org,
 torvalds@linux-foundation.org, akpm@linux-foundation.org,
 linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
 lkft-triage@lists.linaro.org, pavel@nabladev.com, jonathanh@nvidia.com,
 sudipm.mukherjee@gmail.com, rwarsow@gmx.de, conor@kernel.org,
 hargar@microsoft.com, broonie@kernel.org, achill@achill.org,
 sr@sladewatkins.com
References: <20260702155108.949633242@linuxfoundation.org>
Content-Language: en-US
From: Florian Fainelli <f.fainelli@gmail.com>
In-Reply-To: <20260702155108.949633242@linuxfoundation.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 7/2/2026 6:18 PM, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 5.10.260 release.
> There are 96 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Sat, 04 Jul 2026 15:50:58 +0000.
> Anything received after that time might be too late.
> 
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v5.x/stable-review/patch-5.10.260-rc1.gz
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

