Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.160.174
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795212219;
	b=UzlfBxRLgrH1pdJyQfJpx314yCFUwCGAseihU28NcFzMn4pTG8kh3XEZODr6b0xU+S+r
	 fYeRl+sDUefbX9aT8H1VgrqCngYHBrnc2wr6z6MzDqmlL74NYlAedeHxohgnqk2LaERxk
	 U8gPMGVOomIYShIWboj8F6AZILofwYX4koxTEsRPUiL/7CN7lLgaxVjRzAz3pisDrbAZE
	 IoqwBrlbvoxwBvUfmRYgXwn5Pa/HDkc4rmhNlTMjcM18cYH53OgmzguS5nTRN68EjnYxk
	 CgSC4+LCRXL/TdQRSS61dyVLBcqun6hCOG9QR7fJF8CENFi2EAGAT1hquSKki39+9Kg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795212219;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Message-ID:Date:MIME-Version:User-Agent:Subject:To:Cc:References:
	 Content-Language:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding;
	bh=Q3/2lSAbQcvG4mJse5Si002aVPhuVugxPukuQMe/+Oc=;
	b=GrJ8LmEFREGhP1k0/wPwRGRvANfa97ULAQGKkQA7xFNm3hgDiRofuj6JkBa4OyBUlvwX
	 bb1zaM8a89AWCws8AyfTiPsjzZz2mV+GLn+ijMAE438+NZz9k2gKaFCGstXqQiqUm+35+
	 /fS4OaqbkqISnDhHSscN8uQQ+RJ0M+JBDPJpBBElY7CHpf9QAnQB8iXAlOxn1eDkQiyxY
	 KaFEi4tHYtQ4JLnN3iI6Ps8DIfWwj+0Cw8Dx3dMEzkG2TTtzd+Pgwpy5uVz4Hei/UvEit
	 U5oBkDZfGncHkP4umegfYmA8vlaTUyC/M4UllnXPJFtt9ud31T/y1P4WsodEkw8qQyQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=WYPwo0eo;
	arc=none smtp.remote-ip=209.85.160.174
Received: from mail-qt1-f174.google.com (mail-qt1-f174.google.com [209.85.160.174])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 80C25606A69C
	for <stable@vger.kernel.org>; Fri, 20 Nov 2026 22:03:38 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 80C25606A69C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=WYPwo0eo
Received: by mail-qt1-f174.google.com with SMTP id d75a77b69052e-536c8f958d7so10112271cf.1
        for <stable@vger.kernel.org>; Fri, 20 Nov 2026 14:03:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795212217; x=1795817017; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=Q3/2lSAbQcvG4mJse5Si002aVPhuVugxPukuQMe/+Oc=;
        b=WYPwo0eox2Pc0+b6FZQ+O5Lnl6PggMtlewkqzCmj1hl8vKRs53yWR6z7QMxREOA7It
         M4SMVfOMKWmGquFBsSJ0DMONhYbKIGgZ3X814rYEO0Zu0AhUj7bKnhliPQpQf68n/e0m
         Kh1FoDT6PH4sp2D3dYZxIHJP2WIu9JnDKl8aLDP7M+czXLLNNBqpc2/qHJLjAmR+megK
         p59h3oPh/O83JuyLjFyZWsAbjAGDoprLbWoavKciCxb/Q/w1t0IbROmE9CRiUDYDp244
         wxl8PS+wg4joMTIub6BmZsdK0jUb3spxlJHvsq5U2n4zWqoj7Hx4NISxUTvo6FjlApse
         sPHA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795212217; x=1795817017;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=Q3/2lSAbQcvG4mJse5Si002aVPhuVugxPukuQMe/+Oc=;
        b=dB34rF9AlsmXcyFfjUXPZkhW9WpzIUq8ESFMALT7MenbfxrzvAYUMFy+R5KMBjj+P8
         MT2Xk95fRz8X343OKmrm1fO+HkRcw0NbqAFQRDo7TwPCHKqTvGas902PhYXYurDxGN9V
         upb1k5Sn21V/fRoN7+K/yadWgTgXAb7Ku32/CR4XJ+H5Cte4OIc4HB+7xQNPT8Oq41z9
         mdrQBNeljIJi2LZ5emwZVuyE2sU53bKrwEUUIU7X6C+q71REVyicK9YFH3rXGiQLf0pf
         kc+Fbp81SLL+uqlSk70j+f6Odpv1kH3xVBnviW1Wr4FdAs43m0FVqjTUaEB5W6P7Vgxi
         tHyw==
X-Forwarded-Encrypted: i=1; AL+hErG55MAXvI9dSZI4qGxnMNpKPZ4GwKdmIM49Ui56bSjIW20BPYMWfnEL/C0MeIVL1PbekwOl+tc=@vger.kernel.org
X-Gm-Message-State: APuU4Z8wLoyOu7yrXX8U4sP9kzPg1orXImmAWLY9VEsJUk/xRpZczXhO
	JPQy54x8SYtCz818cjYH27ukZPcBS3lWIp18MbI5pdpfnlbpfE2cos2Q
X-Gm-Gg: AYBFou1y3TLuvBEUhjy3ZzL5La21AlsnY13S4ni60YxhqTQ3QJr/bLhSaShOpNPM65+
	gQQB5AQIm/RizrDyabSrvh8ulybuDCTRPO8v0nVpOLMtghQP1db0TViqnUP2VBR6TfHNmvIXFsm
	sv6gMAqsMi7KFpPxsh6RPpL/fnrTBzlnP3ecXov2/ONXZzRkJjAHTCyiCUJjhzuVKwbjn9+wFII
	27Htdy3Tnm5IslvUvFvDuAQLNatefMX0Kq6S3SkU6B+HCGmIrlouJ7aduim3NIyP5Az9ce562Ky
	3JHEZOySWtnS9c+UL1XX6P2jQ6gkzOXR3YK+FzeU6/im1Re7t2X68RnJsPSdSIi++ox3yK+54aP
	S+4yrO2wvoQXUrnxfTte2p7n4VYSlocvNlakbV+F3DTQa87AHNwMm2Z2TtEH6k/l59morjl25Pg
	6Ki7d+J/M0CIBUGToQJeg5KxryDBHgHXmMJLYioZaU9HLtIqnXqKEfCK9YTbcpjNyt5+lAM4kPo
	CmGUunmn+aLzvp1+T5Oc38Y5Rcr8/3nx/C1AtPqN2i8K2nkrsj3p4T+nM2VZtQxfXUP0bkHYjJC
	tHZxBBPV/iIg/l92JQPs0AZKTaArgWtRqOFQQ5BRNMbI6yBH675gFKyFfsGKuTda5J5azmlhosP
	0gQ==
X-Received: by 2002:a05:622a:2447:b0:535:ed1:cdbb with SMTP id d75a77b69052e-55d7688e8cbmr78888001cf.1.1795212217393;
        Fri, 20 Nov 2026 14:03:37 -0800 (PST)
Received: from [10.67.48.245] ([192.19.223.252])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-55d7889ea4csm34049871cf.26.2026.11.20.14.03.35
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 20 Nov 2026 14:03:36 -0800 (PST)
Message-ID: <785f0296-6603-4972-bb60-80a75ed9b869@gmail.com>
Date: Fri, 20 Nov 2026 14:03:34 -0800
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
Subject: Re: [PATCH 6.6 0000/3308] 6.6.163-rc2 review
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, stable@vger.kernel.org
Cc: patches@lists.linux.dev, linux-kernel@vger.kernel.org,
 torvalds@linux-foundation.org, akpm@linux-foundation.org,
 linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
 lkft-triage@lists.linaro.org, pavel@nabladev.com, jonathanh@nvidia.com,
 sudipm.mukherjee@gmail.com, rwarsow@gmx.de, conor@kernel.org,
 hargar@microsoft.com, broonie@kernel.org, achill@achill.org,
 sr@sladewatkins.com
References: <20261120055324.975889935@linuxfoundation.org>
Content-Language: en-US, fr-FR
From: Florian Fainelli <f.fainelli@gmail.com>
In-Reply-To: <20261120055324.975889935@linuxfoundation.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 11/19/26 21:57, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 6.6.163 release.
> There are 3308 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Sun, 22 Nov 2026 05:44:39 +0000.
> Anything received after that time might be too late.
> 
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v6.x/stable-review/patch-6.6.163-rc2.gz
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
