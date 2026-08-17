Received: from mail-pg1-f179.google.com (mail-pg1-f179.google.com [209.85.215.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E388D3F12C6
	for <stable@vger.kernel.org>; Mon, 17 Aug 2026 19:21:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786994510; cv=none; b=iMKVol8BhgqI5b1MNc7E56vyT7IDOI8j0Fe1dWjAPwd/3EJqi7051RSlTuleNImZ48lFudbykFGnknN+aOEEKr1bTNu26pPSDqHk2Yco30QewyGkGClCJc+y/Nwl8LYFS02rqfQcVFQbZJjFj21S+QtHR9HjNnCh32P6nZkCUEc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786994510; c=relaxed/simple;
	bh=KRC5vjh9ZY0mAYTh/SgInP4F3Xdu2TfS7cFRD0/ai6M=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=CoCNXICSOKnXmqwwWlrcWOboAjKt1C06Nr7Fu32SxSF7GlPZU5XEThgsugbUAJlAWMF5soL5dm0jkpickjX8yrh4XfzeXbSp7k24UdIW8oGJvS3ZmADpd2/4c7bzBUhrXAAXIfimT21t8tbMR+PIL2/jlf/N/gcpoXAPXjP6MB8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=K2UbXucT; arc=none smtp.client-ip=209.85.215.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="K2UbXucT"
Received: by mail-pg1-f179.google.com with SMTP id 41be03b00d2f7-ca88130e09aso2295562a12.3
        for <stable@vger.kernel.org>; Mon, 17 Aug 2026 12:21:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1786994508; x=1787599308; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=cM1SIZAjBdh5eZFlS3AbyknYyI3Q/Arjw1M8NUpX+ns=;
        b=K2UbXucT6HzA8A4itPodJHa7cK5ez0M/SvjcOa4PghGvf4ZyD/hb5wHQCX5Zz7vuuD
         4qJmS9UQVwOv0ini5M2nMiq/r+fNmbd5EDaf802QxSCRfhI0aK7ZyDwTis94FqfGrzeu
         wTTAdeF9FkzTXamY27aOkARgkoGW7SNEPmjetAv6ibM5gfMHzer4SS2zXHa6YYXncwRt
         B1yPh9Jx4R+qKGAuX6ewguRbkIkI/gzj4qglmmCl2vPax2Ql+bVNMUmq/IabyuOIxjVQ
         CaP8KBYKxJGIgyF4Rxxn+adrn3L8zk7sSewAWcSluYREAXcwqBzU7nSxdKJ9J9cIqk2o
         TzcA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786994508; x=1787599308;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=cM1SIZAjBdh5eZFlS3AbyknYyI3Q/Arjw1M8NUpX+ns=;
        b=kUexJj/k9PQHmxIIVzM2R3Qu72qxexfUlxgnaAX4FkC+dzk/C6gTciQyGswktI1uda
         JbiVp/+7RE8AcOx8oyr+BA2/G3eP8vbBj2dTHv+wbMzao7ZyFoHk8qoYBg5+CNLwlagp
         lKN9IUEcPWLdx4gT9KC30JA8LLMZEiKis5gZRH/OKda5IbskcCicA9udpQnA31HYYyfN
         tSsa92j5boH92DkfesabWWcSqZI2T+W4WZ54wLbJ0nKprPel4XQ14l3TXrqELvEeOpuh
         oSvGwMIOXaA11OY+yDu4VbR9UWGfdyFSdehty4oAdfzyalcNe073gV/OkZ3gajH0/MYp
         UKLQ==
X-Forwarded-Encrypted: i=1; AHgh+Roi+CUnIV/1lIZGiULBm662BNax/ofllhgWksLbQt0YUPK94+/QapsukhKVs5AegFjOpVsk+dw=@vger.kernel.org
X-Gm-Message-State: AOJu0YzYixncJxXJOlGzZc9yKSQoFqVr2DHWsxCQyKo33Eg4ObeqO5UL
	FikDO3W/r/PBr7WiDjyARjvhRcRJaEpaljKfYdqtaOe32DyFLSIs6ykE
X-Gm-Gg: AR+sD11Z2OSG/LM4Kiz9k/eVEkb0JQUcbbTxGN4hZ1aeyHIYsEzxCUmiQL2YTjLfN+E
	Pp8YUKQWJiTTSJ2PPCcPd/ahliEKJthjD/yACMDsUYjoK6WCRZIGcOjP3MPXMDVnB6Bdnaf9BPy
	78KreTb2IPf2sZ6gpGVzFInIXR7/fIz03v17obc3YdiFvmSxHOO8tsZz57Qsf2A4YgdNppsiu+C
	3q75/eUwicIK/d83pcuegTK00azc1a+iF3TDb7kMEgmcrBJCcQBty+z/+YOq4VFm/GDxQa1unGm
	EfjTMdKhGTrtis2FgSRhDRyQdfPI+gqeMYyAkCwIeiCWoGtdhzwRlv+DQLL2QQqpjmdlHmRemd+
	V0p6CkSkK4/+H9TCb3V9+j44qLPujrBMsiFpDvjK+lvFgb6nIbxUSRarIOH9fk3YN4yvNQ/6k6N
	rRmmSq9K8nLD3Hlr2at+4+hrDf1xcanGmTTkoR3AXB65wFsSiQabXcNDpSjWjhUUXsJC/qcJFGT
	GDI+kJ9zIWM/+39O52fDJTrdp0=
X-Received: by 2002:a05:6a21:690:b0:3bd:3800:7538 with SMTP id adf61e73a8af0-3ccda76957bmr2613010637.33.1786994508103;
        Mon, 17 Aug 2026 12:21:48 -0700 (PDT)
Received: from [10.67.48.245] ([192.19.223.252])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-3267c389363sm8404556eec.23.2026.08.17.12.21.47
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 17 Aug 2026 12:21:47 -0700 (PDT)
Message-ID: <b3f3b342-5d4f-4e87-a94f-1bf1da7cbfd5@gmail.com>
Date: Mon, 17 Aug 2026 12:21:46 -0700
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 5.15 000/456] 5.15.216-rc1 review
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, stable@vger.kernel.org
Cc: patches@lists.linux.dev, linux-kernel@vger.kernel.org,
 torvalds@linux-foundation.org, akpm@linux-foundation.org,
 linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
 lkft-triage@lists.linaro.org, pavel@nabladev.com, jonathanh@nvidia.com,
 sudipm.mukherjee@gmail.com, rwarsow@gmx.de, conor@kernel.org,
 hargar@microsoft.com, broonie@kernel.org, achill@achill.org,
 sr@sladewatkins.com
References: <20260817132539.792407575@linuxfoundation.org>
Content-Language: en-US, fr-FR
From: Florian Fainelli <f.fainelli@gmail.com>
In-Reply-To: <20260817132539.792407575@linuxfoundation.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 8/17/26 06:26, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 5.15.216 release.
> There are 456 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Wed, 19 Aug 2026 13:23:44 +0000.
> Anything received after that time might be too late.
> 
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v5.x/stable-review/patch-5.15.216-rc1.gz
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
