Received: from mail-qt1-f179.google.com (mail-qt1-f179.google.com [209.85.160.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F180D39769B
	for <stable@vger.kernel.org>; Mon, 10 Aug 2026 22:40:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786401651; cv=none; b=EKs+MefkhvKVdgEcD+hI8iceymxZWaFEkElrDOCIgZivb6BLPu+zT7SJpHMQo3iFwDiSro8embWJ2P+G+CsRFbLyIEEqZLkANSgNtf3aAMyhUCf2uSRKyRi3jBCDlLVHXHJvM52jnp9XMmuY5FVg/XkAKP4VphFP2SSTgFrbYOw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786401651; c=relaxed/simple;
	bh=RqZ00Lwt59eQqtrWfELjRgeFke/UR6w09M3T3ynK/9A=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ae/wvNEJkmh2ysGVKSyUw5aj83NfMVQAQ9B3QkA2Z/m5cU8tX+L8ikhyLwJizYm/MoyvMRZUvhf/lPsgGAm2ljh09yU2bx/nS+b1/DbaS4wUvpnvln0UI3IYaQSFIDVYVskiQmLObPty4KxXUGtsUIXt+TFnEiDAeYOT+gNxA34=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=HJ1ZNWVM; arc=none smtp.client-ip=209.85.160.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HJ1ZNWVM"
Received: by mail-qt1-f179.google.com with SMTP id d75a77b69052e-52d37b65926so1163181cf.2
        for <stable@vger.kernel.org>; Mon, 10 Aug 2026 15:40:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1786401649; x=1787006449; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=WsE2s3pfDs2VrzXHHCACS8hxsvv+gu3KAaZUVts9x8M=;
        b=HJ1ZNWVMQGKQBlyrKgsCMMhRblmLheF1EJEVRvrBVtzcEdf3lB6ri24frOlv0PfqYR
         8Q5tGEcAlLVW/a9gkDarQLhCVjxoISnqjPiHKinGwwfevwFXRa/GnqDpX7sNpqQpjpJN
         Gvfuk45OSnmehJWdCTIcyrd2Gvc6XYHgVkIDmnU5qwhNyfsNm8Td3YdXk5qSjrnsqBrR
         JYL8+w6JqE2/39mUxpWDOyQ78xmaSy4ee3gtOw2J3FEappcVn/34GWbYnF1/CbCaex98
         hMOvL9ZevGc65dJq9zybfzYSoTJBbDTHJ8aGqksCMrOJEIT9wB0mzGMXNIv8MC5A+4/S
         sLbg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786401649; x=1787006449;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=WsE2s3pfDs2VrzXHHCACS8hxsvv+gu3KAaZUVts9x8M=;
        b=B43rPYVhk3/7LFOs+El8S/dIwtVwwk5SzRz2Hr5uAWQ+0PRRVPmeN4FOurtZ171OrP
         K/RBekZkeTutKU7ndSl1rsyytXmtiChroGuOi1RNujFnYt1z8fwMfY+KGra3Ho1vwcIE
         u9pmyRwOmI3+vmQxPB+9cYwN3+I83xUq1su8crLFjyagPTQQPRnzMmA4b8e5yBLcs59i
         93MYXSOQ6LeC1mhIfBknf4Ma/OB5NFDULP4Mo8ODUQGigzJELeb22olDCVdfIIlweO8s
         sx/LHVaMP/vM7Ed04zoko/18cyYmJ9hzACLlV0voGt6LmEXS4fwbzGm4oXP0XVtvzUY8
         ZPEA==
X-Forwarded-Encrypted: i=1; AHgh+RpSHLmVWUQZuJQFHPz97xBCjUaaoMCmSca0kiDBAb7fWFPsqXXLmFhsYGLcrPgQr2P8DWF8toE=@vger.kernel.org
X-Gm-Message-State: AOJu0YzF1dcsrHYGNVwOMM+Zy75zj94En4jK0lZ7lnjmtwA8xWJOUWTk
	3Sp9bzgv/zD2VgVH8llZ/hPTxlXCJf7hx06aSOZbA60Nk5P5DgXTvr5n
X-Gm-Gg: AR+sD12BS/GP3xTxEoyqaHoruG5bIZiOze0KeKnxRm7j1jx4AMbvOBp9KPbYe6iKhEk
	fqIc9RuM+p2aCIVSsAAPqwESm0mFhrVawAaQnh4fXZlihQZdCqOuQp6i+Qr5DOyfjbsmNUVJIai
	3pf31cf2/D+ifUVDRMvh9yVmFQjVhD/pAxElOWx9xAh93Qf2nW6s7cysuovRw7huQ4NRJo/WCi0
	fm7KrO6iXETxqRQerZlg43TbfHPwwxDwqLvh5ZWzm2rjsseGfiqKqOnXPzPigw7rhYyqi3lWimu
	T5G/Tqh7NYZ1ftNGyvI2Q3/Apf3p4a6pV03xWRJCkVN9edlxDDW68/oIAvUvCOdu1t4Esmv83Hc
	LJifhoTRoiGKo5+ONPd7jkGx1Jwv20+XTwGqeZMPUZOO9QXZbzzRDGbYV4toY50paP7vk7N+1WR
	E9ua/Dyl/L9vwNSfU/DHKaR41Z4VXrE1RP0bvb4o5dt+jZoSw4RsJZaa6KlGilBsux5B3Bzs16l
	HwJ31dIrb4fSys=
X-Received: by 2002:a05:622a:509:b0:517:78c7:d93a with SMTP id d75a77b69052e-52ce602ce1fmr476338761cf.16.1786401648817;
        Mon, 10 Aug 2026 15:40:48 -0700 (PDT)
Received: from [10.67.48.245] ([192.19.223.252])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-52d1659c1d8sm82836961cf.16.2026.08.10.15.40.44
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 10 Aug 2026 15:40:47 -0700 (PDT)
Message-ID: <e59a44a1-1724-41e4-b766-bcb03ad98e04@gmail.com>
Date: Mon, 10 Aug 2026 15:40:43 -0700
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 6.18 000/396] 6.18.44-rc1 review
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, stable@vger.kernel.org
Cc: patches@lists.linux.dev, linux-kernel@vger.kernel.org,
 torvalds@linux-foundation.org, akpm@linux-foundation.org,
 linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
 lkft-triage@lists.linaro.org, pavel@nabladev.com, jonathanh@nvidia.com,
 sudipm.mukherjee@gmail.com, rwarsow@gmx.de, conor@kernel.org,
 hargar@microsoft.com, broonie@kernel.org, achill@achill.org,
 sr@sladewatkins.com
References: <20260807143424.272339768@linuxfoundation.org>
Content-Language: en-US, fr-FR
From: Florian Fainelli <f.fainelli@gmail.com>
In-Reply-To: <20260807143424.272339768@linuxfoundation.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 8/7/26 07:32, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 6.18.44 release.
> There are 396 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Sun, 09 Aug 2026 14:33:46 +0000.
> Anything received after that time might be too late.
> 
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v6.x/stable-review/patch-6.18.44-rc1.gz
> or in the git tree and branch at:
> 	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-6.18.y
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
