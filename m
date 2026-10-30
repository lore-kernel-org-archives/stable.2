Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.210.43
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793394326;
	b=Cq9hO4wLua4VnRk7JbmEkjIvo/0v6kzZWFPxkMPa29GcOSVfNDXDsTTB8zmY6XwZNMic
	 Tn6MTrzFYLnWNilAwTwzwN8/S5Z1gT7FLgosFrbjkeJOCWcx6vFSWDtBq4w1K5bgV5T/Z
	 Eg2mskd0Ft1hAF2UKIqkPkbiGyqX569KeeUTIYJ29Xaa6faDN6Us1MaVwbC10/DQwivKO
	 hZKO4rEBMT5FujKDKcwaYS/xQF+adtll6Blj8j/lCiWHhLRTe9Qa+h9KNpPHR5ywj2lYR
	 Sr3gI8Yvq89IiOZeYBj+gWC/vEYD04UimozNj9Sx1VT5LaKSZBLEI8T3/HarWCzi0qQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793394326;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Message-ID:Date:MIME-Version:User-Agent:Subject:To:Cc:References:
	 Content-Language:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding;
	bh=Y7H7nb9mTg2yg96+dA1v16VbiSLf+tKxcACbeKkZCEw=;
	b=35jPlCmg1Queuzf5f4KyUr+2yI0KrBAWgyt8tQaOcCy4zwSX2b9UwqaZsa3xJX+hqHmq
	 83UeDvi5BHiRzP63Iw1fquu40CHELcW9EtSdVgI4bqDyBqefeOztng/htZI+Fq39hhMHK
	 GxkB+VYSViDPBge6ceXXv1pvQt2jPdiJAqfvxP8aN8LBzCWRPZu0PVPhKlVF/EWSlcNBX
	 H1d1tNbUQ7lfNAVjLWbsH9BETOdv6VjFsuucwVZte5q+2mCCYWw139gfbdv0metHUCvhx
	 ejbJRMppz+JU+kkqz8bi45tMF8/pdvVEqzkESh5QOiWtOAC0khmQolx2LaV9soyyixw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linuxfoundation.org;
	spf=pass smtp.mailfrom=linuxfoundation.org;
	dkim=pass header.d=linuxfoundation.org header.i=@linuxfoundation.org header.a=rsa-sha256 header.s=google header.b=cIFigwcs;
	arc=none smtp.remote-ip=209.85.210.43
Received: from mail-ot1-f43.google.com (mail-ot1-f43.google.com [209.85.210.43])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 79091606A31A
	for <stable@vger.kernel.org>; Fri, 30 Oct 2026 21:05:24 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 79091606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.a=rsa-sha256 header.s=google header.b=cIFigwcs
Received: by mail-ot1-f43.google.com with SMTP id 46e09a7af769-825b40f8a26so571263a34.1
        for <stable@vger.kernel.org>; Fri, 30 Oct 2026 14:05:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google; t=1793394323; x=1793999123; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=Y7H7nb9mTg2yg96+dA1v16VbiSLf+tKxcACbeKkZCEw=;
        b=cIFigwcsUzF2Ea1wKU6hHLN9UxujibfQ/SQr9OWt/QSZPp3s7gXfTg7oRDGepbn5Nj
         HJgV9jvzvHJd2/g/esIE8e0Ok483KChqxpATCF5YaSacRnZMq5p92Og73wiFxz33sRDH
         sLpRf7WvZHNGkWjnSZkG3aTxVCNTqNWb2578A=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793394323; x=1793999123;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=Y7H7nb9mTg2yg96+dA1v16VbiSLf+tKxcACbeKkZCEw=;
        b=YPodreFyl4oTpCVUMSqwDsLYJMpO12zJxnpTYEUtTs51ueJU8BwB71WVjHCRUJPBaf
         57RltSXqxp4nI6pMQ+kx+EpEcqFJbB1Fj9V/lqr2ilzpgepE01dcoULHJBhG+tJn58FS
         JyaOj7NRBPds8B0v+AtLgkx+77nIdji1SJnmncTwpXlGnuAkQImAL6ylOzVlfbKtkDZ7
         ycSfDaENdcnwYo4sWlil9Qq8PB9KEbcIq2xIbnsOSLWrWJiRMBc9ouFp5mShsiq0fkVh
         iYDJ57+0AaWYnwuGStX87Oc+j7l3RfUiIERobyOFbw0QG4+5AsqZo7UPmXHPaNTtUrLy
         sZ3g==
X-Forwarded-Encrypted: i=1; AKwUvBykcmZ2fO4Gi2sKz0r93mp1QFBEpKgEUMtKQyJ7fLyzkD+yKPjR0bwogjQyoSq8R/3Guc9CyR0=@vger.kernel.org
X-Gm-Message-State: AFq9FYK7vmK5FZejHneIT6bQOriEMSCt6l8k14Dp8L0AmMk9z5g8qRsZ
	YrdxtU1z3nJCc8btQTW+jooyrrqPsDZ1H3/hEpd3njFTOmLuq34OCEQ9sKlhrKHL8js=
X-Gm-Gg: AYBFou023uz4yqicDpIv/HQ4pysWjhbPQRt6iJ9W5JUrCSacO0515opxSi+TLVxL4fo
	Z4pX6p/ImRf589GYQl1a38TesSV5EFNG9tsEKSLO4kGgtSwj9qc/vuFL22ADvlOw0k9mJ5/bMko
	kA9b5Di6o3WBWL36NURGX3JA+J5OWYO7GYPwoc0UaXnPfoFmQ+xPBrYnOdiTx7Sds4lSPFMEeNx
	T08Qr/ciUE8ROwYFxgktzv9enj7FWam48ABOv1dG9xzK4NI8/ntUEE0UK8UaLyQHEMtTgtDpoE2
	4TWAMohv2IfVciDkbKNfXOeQBwBQ4EIBRvVzBocJrI7q9GQpLyHFZFH17gjmaGP/aWRE4zLzgi/
	XukDLVUfczfeXYoqCc5T9FeIDZvS5XvMWOnszzOdzc0hnYERJBNVLjhDqnlfqVtmN733WfmezTN
	F1Apf7R58JtjKdFzH2mYRwxS837KyCu7HruTEQOIBgwUJCNyzadj18qgUDJl+2Xh00+SPWLgr8/
	BtNXRC+jwTx7ucx1z/rUvjXDusrhZnuAPbj4d8l4mBgLr2SI54cMoGQBTTZJZOMd7CWncacSaRO
	FiwpJaWJdLveJAEt/9DStI9rnc3g61WrpVpaWg==
X-Received: by 2002:a05:6830:640e:b0:821:a94d:3b51 with SMTP id 46e09a7af769-85d36660667mr2466155a34.25.1793394323484;
        Fri, 30 Oct 2026 14:05:23 -0700 (PDT)
Received: from [192.168.1.128] ([38.15.57.99])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-85d3545b875sm2999366a34.5.2026.10.30.14.05.20
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 30 Oct 2026 14:05:22 -0700 (PDT)
Message-ID: <01c04f5c-5a39-4a51-ab0a-4bb4dd89b80a@linuxfoundation.org>
Date: Fri, 30 Oct 2026 15:05:19 -0600
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
Subject: Re: [PATCH 7.2 00/10] 7.2.15-rc1 review
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, stable@vger.kernel.org
Cc: patches@lists.linux.dev, linux-kernel@vger.kernel.org,
 torvalds@linux-foundation.org, akpm@linux-foundation.org,
 linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
 lkft-triage@lists.linaro.org, pavel@nabladev.com, jonathanh@nvidia.com,
 f.fainelli@gmail.com, sudipm.mukherjee@gmail.com, rwarsow@gmx.de,
 conor@kernel.org, hargar@microsoft.com, broonie@kernel.org,
 achill@achill.org, sr@sladewatkins.com,
 Shuah Khan <skhan@linuxfoundation.org>
References: <20261030121255.257615100@linuxfoundation.org>
Content-Language: en-US
From: Shuah Khan <skhan@linuxfoundation.org>
In-Reply-To: <20261030121255.257615100@linuxfoundation.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 10/30/26 06:15, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 7.2.15 release.
> There are 10 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Sun, 01 Nov 2026 12:12:50 +0000.
> Anything received after that time might be too late.
> 
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v7.x/stable-review/patch-7.2.15-rc1.gz
> or in the git tree and branch at:
> 	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-7.2.y
> and the diffstat can be found below.
> 
> thanks,
> 
> greg k-h
> 

Compiled and booted on my test system. No dmesg regressions.

Tested-by: Shuah Khan <skhan@linuxfoundation.org>

thanks,
-- Shuah
