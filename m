Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.210.42
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792453801;
	b=LP/K/dAUhlVuRDjw+byeVUSkJbWAdWRqskafMJdvht73BfFI4IVBF/bar/q+phi9hBWj
	 XgEeHQZCY9BEb3Arx+RH/s/Ydws/98BqfcoxzPSPnbMkliWSZ/aNz3rtTlvhhlP5zJy5b
	 xdI9ppV4Bc/H6Wl7mWJCj69y81/kPzYe9nxZ1kNTNTCySnAVDUKz7g/zHeLMKqHYYIoyO
	 QVguuOkqUr0TSiYdzd8iHKzMupvvEmoHpDwBpjYoghIKu97ITnqjvBhtB5V2YIPB0LW6l
	 7fM0Qz+dI5DvCYIlSPF2YJ/TvBd6zmZYQDZEftrGDtNJPYmrXlka6CN9xbj0/6umkcA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792453801;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Message-ID:Date:MIME-Version:User-Agent:Subject:To:Cc:References:
	 Content-Language:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding;
	bh=DD8Fwe5v4TmgrbD+fiaZCMxv0O6FicbhV371nOaahNo=;
	b=vdz07tofIUn7uuNo330i77StacPSGAVcua9sdygrgYAc11YTLa0DtQZOX1UvZh86lsk7
	 zzVCvnTygDhJhwj6jXKFAFtpublwQ9/j4ionkRzfa99YaBLt2YYpVCGdN7ReqDwpjHeGY
	 NbM0twU/qxlCiSD1b4E7Fb2jEtxOcdUEt7HMQMJqTuOwfqoSALOAW7lnV4wKGCrh79A8b
	 B9w3FgtifxbxU615zCFsHG1o4s1txe8S5irTjwZqTGncUxDlGzCrcqQY5405Worw73dUC
	 qvwDSsHxTYt6Nbceb9jWOPt7UfSWruwWk7VJV5RP5eN76Y4LsVbRINdIo4eks5wHKvA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linuxfoundation.org;
	spf=pass smtp.mailfrom=linuxfoundation.org;
	dkim=pass header.d=linuxfoundation.org header.i=@linuxfoundation.org header.a=rsa-sha256 header.s=google header.b=BuBitvpw;
	arc=none smtp.remote-ip=209.85.210.42
Received: from mail-ot1-f42.google.com (mail-ot1-f42.google.com [209.85.210.42])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3BAEA606A31A
	for <stable@vger.kernel.org>; Mon, 19 Oct 2026 23:50:00 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 3BAEA606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.a=rsa-sha256 header.s=google header.b=BuBitvpw
Received: by mail-ot1-f42.google.com with SMTP id 46e09a7af769-845f3fa7f38so1152587a34.3
        for <stable@vger.kernel.org>; Mon, 19 Oct 2026 16:49:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google; t=1792453799; x=1793058599; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=DD8Fwe5v4TmgrbD+fiaZCMxv0O6FicbhV371nOaahNo=;
        b=BuBitvpwDNha2KoIMFUJffgsDubBjIpaqFrYn8XYX9wcTIZ36LW31ysJLNvqiEN1x/
         Bo08/cpMI7CbvzNBVfP92BIIAjTE7Wirrx+OQJAr8aVbZUQjGZUlvMuihQ76VrJ10vAe
         bfydW3rcaLyRdsFezRDA6GlT2OHLpVsN3drz8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792453799; x=1793058599;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=DD8Fwe5v4TmgrbD+fiaZCMxv0O6FicbhV371nOaahNo=;
        b=qHVhXJ26lrnC1PlqwULXf/Fx0uBP7aE/oTaa4EdMhlu/CM5qcGeg4NxeUHHi4YuTlT
         HpN0nUPgq7+zYTaVG6g27LaKOmCnUVWIRSlBi6ZHzL/L4u90sJwiUlJielZIXtFpT1OC
         Xxbczu+K6zCZCcC1exjjQJgDpYvfioKUjF1GlZOSBs+y7yiWqzOi0WGjMT4eUJUeHgCN
         iI+RmIiMDo1nOscpuVZ93lzBo/kbfQU5mWzgZR4hz8rcuzpc237XrWOeacsZw4VR0oYw
         0Sv6P6Za5HPQqKBVT0JqJDUN3wDt2URolxqAtrXYFVMd7OkVioEKHPU68kkQyFhyBagj
         x2aQ==
X-Forwarded-Encrypted: i=1; AKwUvBwMNIkwNk4Y2h2X23ox879xrdXqEaoB5LpBsh8v9yiZcmZYFdkDq60vW+I3GFHHFyQzpPEH/BU=@vger.kernel.org
X-Gm-Message-State: AFq9FYIGWfqp3sn5KEv60KOt8XV8tYrhDNMXfMOyrJz7zmEGBrWAWof5
	JCoOd3PEdca6tR6AUFBroLDB4ssjvMT/kZCi92V4fltvMhtzvqdh5gXqacnvG65NNlw=
X-Gm-Gg: AYBFou3qkMQSTjawwNJUmwOehEjl1b1nzDB7Hsu/30QU0btdikLcZeKWYGLa3wv72qn
	gRzSmk6fF+c6e3GtfydUTE119ZfhKML/pWlTtJS/mPWSiu2JYaLdcsnQUt9G6cknffpnkLN8uRc
	vJH/cWfEp10XoEyNMgJljdIeEcntHCQ8H6snti2/Fpuikchxd3YNInRdq0UFNhAiLyAIeTMq05S
	U6caPZxYY9Ue22Sc40NhegxCklA28glVHYLXxMcn9LkcmeZpPf6inUpC0/VC0lpTgrvByFPajJj
	TT3f360SfmYoMH4noUSdW/ky0lH+8SUV1VpSnywAzqxn3g+OLeuVGntswI9sEP0S+u9qPvQtWj0
	oXLQAuFRfEGK8uSZ3IqtQye6Z5gTewojMNNZsnauYvVfEn6b7n2MYYQA7RrPR497vqZJ3tHis6r
	Hcq+ZRYh24mpv+UrFS3eCsg7azyT1VERDJBWMsvrqx37sOSsiU+4pOgIjbIi9knjSx2XJ0x+Rrs
	xgXUHBL
X-Received: by 2002:a05:6830:83b4:b0:7fa:5c68:d04d with SMTP id 46e09a7af769-8450097d1fcmr9148770a34.23.1792453799136;
        Mon, 19 Oct 2026 16:49:59 -0700 (PDT)
Received: from [192.168.1.128] ([38.15.57.99])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-842a53d8a52sm10631518a34.11.2026.10.19.16.49.53
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 19 Oct 2026 16:49:58 -0700 (PDT)
Message-ID: <c93ef8f1-5d63-4a99-ac1c-c07ed233e22d@linuxfoundation.org>
Date: Mon, 19 Oct 2026 17:49:51 -0600
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
Subject: Re: [PATCH 6.12 000/869] 6.12.114-rc1 review
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, stable@vger.kernel.org
Cc: patches@lists.linux.dev, linux-kernel@vger.kernel.org,
 torvalds@linux-foundation.org, akpm@linux-foundation.org,
 linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
 lkft-triage@lists.linaro.org, pavel@nabladev.com, jonathanh@nvidia.com,
 f.fainelli@gmail.com, sudipm.mukherjee@gmail.com, rwarsow@gmx.de,
 conor@kernel.org, hargar@microsoft.com, broonie@kernel.org,
 achill@achill.org, sr@sladewatkins.com,
 Shuah Khan <skhan@linuxfoundation.org>
References: <20261017160036.979869304@linuxfoundation.org>
Content-Language: en-US
From: Shuah Khan <skhan@linuxfoundation.org>
In-Reply-To: <20261017160036.979869304@linuxfoundation.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 10/17/26 09:47, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 6.12.114 release.
> There are 869 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Mon, 19 Oct 2026 15:59:15 +0000.
> Anything received after that time might be too late.
> 
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v6.x/stable-review/patch-6.12.114-rc1.gz
> or in the git tree and branch at:
> 	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-6.12.y
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
