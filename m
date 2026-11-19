Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.210.46
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795103214;
	b=ul9grYXVQjCTeS/0TyNgFTzQvHrDtF/669v/lj55oi/XiO2PaqMRiWu+dN9gkqaK/62C
	 XqxRDRKsYKOJBjDSpc2j9JBxk2EXpi5FWuS8yjBMJ767uRsijxR9prV+PM6k6IWNU32J9
	 oNstFECGyE7+dparKipRCZpk3+fp1I2o4xxLCIcwtaJXXQkTH26w7xCHaiTu5ag5BjvAe
	 S1/Gxp0CTMK17yBVHno34KqEVfGIM4wTfMmkKuZZswkrKrgsrBgIeNMf7OcWHcQ/yb61w
	 LDw2OGmrLWq+Qe+SLg4aqzuGAv9JApDJkvND/Gfxz94X3idxnxW/4usouM6D5p0y2Ow==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795103214;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Message-ID:Date:MIME-Version:User-Agent:Subject:To:Cc:References:
	 Content-Language:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding;
	bh=EI6AD+cTGv9AwoAU/9fE+a06GaJxs25LC5gaQkSzbV0=;
	b=BMHkfGNtI0JomQApooLNp8wMVtYNBe6pNFENOYw4OcKoPFFq25JjpRZZNPl79h20VL/4
	 JR9hGOa5vHpjScqHO9tiRU66v3VgHqchkdStfw8H9cXy09297qC4AIRoZMs4s2OH0ntOJ
	 3Ol4LpkOxfNZpwjHztgj+0b2BWJhhaqwYPa4Mfd+jk4Ouc9rrvqmsdWFZSiHw35cP+wNr
	 XdfLhJbNJZpAjyOE6ZhrIpoexeaug6kWQ8yj1/uVDR4dCMHkfWdT97zTvWDN4OyXYWzKy
	 4KiQyiKWDTMDhoaxLy/ImShxckqoTpS3pWNXRUHjnJyiqYYiEj5dhT8/ojEtFVtVLeA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linuxfoundation.org;
	spf=pass smtp.mailfrom=linuxfoundation.org;
	dkim=pass header.d=linuxfoundation.org header.i=@linuxfoundation.org header.a=rsa-sha256 header.s=google header.b=QhMRcIfN;
	arc=none smtp.remote-ip=209.85.210.46
Received: from mail-ot1-f46.google.com (mail-ot1-f46.google.com [209.85.210.46])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 35D96606A326
	for <stable@vger.kernel.org>; Thu, 19 Nov 2026 15:46:53 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 35D96606A326
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=linuxfoundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.a=rsa-sha256 header.s=google header.b=QhMRcIfN
Received: by mail-ot1-f46.google.com with SMTP id 46e09a7af769-8629ef8613aso934346a34.3
        for <stable@vger.kernel.org>; Thu, 19 Nov 2026 07:46:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google; t=1795103212; x=1795708012; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=EI6AD+cTGv9AwoAU/9fE+a06GaJxs25LC5gaQkSzbV0=;
        b=QhMRcIfN71Uuts9P6BAtbMUQ3AynRUNnBFCiQI9h+yHaMhra+WZNjpGZYp8wXz90uq
         jgKhHIKWTFhwaBMPVe9zMkEH6+XvebqGcBoC48UIcWaBPKN59tl/fgpjLriAyBd60GiX
         GlORa1Cga6uwza04VGIR204LAbvvZuhk9yG9A=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795103212; x=1795708012;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=EI6AD+cTGv9AwoAU/9fE+a06GaJxs25LC5gaQkSzbV0=;
        b=pI6oD4YZzKb4caLsETnRkmgknUDN0PopmDlpkHKAtl9sfWnrHW7fN+zSV10Qfct2EE
         m9r+AokcJNFZEuBytTVFRjknvUJUMo5abUpMnw7oo/7a/pzgnm0/5901Kvdf4tYmsU3Q
         B7DhlWyjL40spE2GsZgxhdhClTZg7rNSBAqG8YFVl9sdRDXYxbD9rhipLWtwX1GxxTsn
         pknPIDvjynhHT8YDA8NMDnTfot4Y+rOlL17CYbEAMKaCtyGmAkGNH33qeDXPUpYgNmzg
         JRJuG3E0cuAyopJQAAWSPMXxwTsIief+CKqpQgve+B3dTrthZWkUAnvY3azYXAMCqd+n
         x0BQ==
X-Forwarded-Encrypted: i=1; AL+hErEVDEfyhXwdJYbenD9dJx2xdizknbG+mtLJrhQRlce1m5NOQif/B/tpryIgL8acunD8i/Zyuxs=@vger.kernel.org
X-Gm-Message-State: APuU4Z+nqOLQBBETYaPpItY7hLxMCeLc4Z2B3Mqn0cE/jd/zcx7eZNLG
	jqy/LrkMPIzzT642nBcwGJH1E323NW4fppIhKwjeGEZpl3lxle2miIEhfKbhx+eclzc=
X-Gm-Gg: AYBFou3eSPOKRbg8uj1j9PjmKDiI61dy7Ca4B+RuExkA8vofIHBG4Ws/zSUpnmzEYhF
	IorfQMXTbBx1g4kl0ieUKOvH8f7hk6/pShFoGJJs10AYYJCEmGMpfjBds6hi4yeGyandcJHNAq9
	sOD0DOJHdNrJZhwcBGlHa+3ez74WcZk9OvFbEUNMFTtqwvc175iqqG50wYcCiqwBJCvinPHwRrT
	hdWzfVS04/jpJSO8iZsDLzBZyv67535/3FPgvix8knFBcrHqbpBKJOZceJx6G2Ir27T+KNIP4HD
	W2beXzNuyzszN/q/K+8+dxhZHkyS0xlmzNjbi7bTzrwj5+jrj0C07t4r9p7MqhBptkiWSTRi5lR
	4BmoU3MiWXLaSJURAxDAoghLeg62LMJXN9GsJoAsO0WC4C08jio24N/KaopcZw75igbKSHJQ4zd
	tDpnGokoFK+DuJxzK93u6OoJhpsNBsnu0FhvsOpjd/1vQU3EXJSPdgdKUHAb4yPlB5jDmQI7/kA
	C0YP5ybC5iSfTSnLvoG9NAyj7JPoY2nfK8opU5lzI89ezSwQQdU66qtTf9wn5xkoamfTGWV0lSx
	WvFItbG/nxSdtvJbIXMP1IrlnNcyn5NOvvXhQA==
X-Received: by 2002:a05:6830:448d:b0:85f:1601:d3 with SMTP id 46e09a7af769-863157af868mr264649a34.23.1795103211993;
        Thu, 19 Nov 2026 07:46:51 -0800 (PST)
Received: from [192.168.1.128] ([38.15.57.99])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-862f023760asm5047157a34.19.2026.11.19.07.46.47
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 19 Nov 2026 07:46:51 -0800 (PST)
Message-ID: <9f67da18-8dcd-4f2e-8599-c41779b5eaf0@linuxfoundation.org>
Date: Thu, 19 Nov 2026 08:46:45 -0700
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
Subject: Re: [PATCH 6.6 0000/3318] 6.6.163-rc1 review
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, stable@vger.kernel.org
Cc: patches@lists.linux.dev, linux-kernel@vger.kernel.org,
 torvalds@linux-foundation.org, akpm@linux-foundation.org,
 linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
 lkft-triage@lists.linaro.org, pavel@nabladev.com, jonathanh@nvidia.com,
 f.fainelli@gmail.com, sudipm.mukherjee@gmail.com, rwarsow@gmx.de,
 conor@kernel.org, hargar@microsoft.com, broonie@kernel.org,
 achill@achill.org, sr@sladewatkins.com,
 Shuah Khan <skhan@linuxfoundation.org>
References: <20261118150313.527275416@linuxfoundation.org>
Content-Language: en-US
From: Shuah Khan <skhan@linuxfoundation.org>
In-Reply-To: <20261118150313.527275416@linuxfoundation.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 11/18/26 07:10, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 6.6.163 release.
> There are 3318 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Fri, 20 Nov 2026 14:55:42 +0000.
> Anything received after that time might be too late.
> 
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v6.x/stable-review/patch-6.6.163-rc1.gz
> or in the git tree and branch at:
> 	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-6.6.y
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
