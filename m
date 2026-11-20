Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.160.169
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795219019;
	b=x8JIUkvmQH1B5qm9vEEsQUiIsb+CyVDrRcrHW7gJBqFxsrssSTCmhzPEj9vqs7yonGLP
	 e5FcOMrLsujhU3TzQy9bX36x493KKA7/T3D1XGkP7llFTBY2YZcOvFeb6c8xrSd+ttft8
	 5e6Pic/ajZINPuYUAxd6ANvGKke84uq6nJJ/6l8AsOuOOLOtfGLFRuqWvbzhClq6mFbn3
	 6gsLlcySAoJiLi+hongEE5rzJXwM09thtS1SSDesvp9aYBaGtlwmMfzFbNGKugfCBoyWM
	 MwaiisIpZx75y04X3jruw3uYjm1HOsqMJ9fZBBH7LeAPwsRDv9u3vtaSIQvc5DlcU4A==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795219019;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Message-ID:Date:MIME-Version:User-Agent:Subject:To:Cc:References:
	 Content-Language:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding;
	bh=kVgYuwZfK6/XOH25sVcw/XaxSILhNtXWSKbZSzmcIJo=;
	b=2Qfya//TcpixEn/OuUOrI3k9hIcVWoN7QGrJVF2V9I5exxGjx0P5BqqHIIXptqJh6pwq
	 iNkwL4CvSfUpvG0gE43n9h1Ag+jUQqFzmTGGfacWWe2n/tAxdJQ5BSHefJk/y8NjFj2U0
	 tD6FJNmEIUJsBn0VlNVTeI8ZwN/c7ZLBa3kDWBI46YoGdXKiVA9mOmroDYAAcfIkeXZ4v
	 kMzPwy3ghiOhibtbJ6BISd4aJqCXos1f4kGrwlhrs7nAf5kniwyHkec9pOKBS7skz/dBS
	 iAMyaIlYg452or+Y8shfGU0eL1akt4HE1o7wk2KeeKtOp4K7qOAZ2qkXk7OKQkUJhvQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=iyiVdIbB;
	arc=none smtp.remote-ip=209.85.160.169
Received: from mail-qt1-f169.google.com (mail-qt1-f169.google.com [209.85.160.169])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C468B606A690
	for <stable@vger.kernel.org>; Fri, 20 Nov 2026 23:56:57 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org C468B606A690
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=iyiVdIbB
Received: by mail-qt1-f169.google.com with SMTP id d75a77b69052e-55c38cdd5b7so10611821cf.2
        for <stable@vger.kernel.org>; Fri, 20 Nov 2026 15:56:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795219017; x=1795823817; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=kVgYuwZfK6/XOH25sVcw/XaxSILhNtXWSKbZSzmcIJo=;
        b=iyiVdIbBJScr0uHl2CQqYIrz2MuH/xjWhEzXjma2JGWT6Db/ZRCQUSwiY5aPIpLP4R
         7hEUXeBBhzf3k/r6Vm66nztnJmVhot2/zAcsdnEN4716/uzrqGpUn11P2o55gGtn8F4C
         4sJ43zIzyWChPNJJyAUQCeolFKSReqIUd42/iCcVfa82alUjLpOLGrOP0LwE6OcrnJli
         ymkGRP0afLpzEwJC1RF8OkUn8sHpA5S1wO5+e5fAdT5XNLOEKVSteJRBarNRdrZH85Er
         UyES5j2EzW1FRdzQweKIgAG/IxOX+bD98ynB4q70fapDjK/QoHJmCieVdu2gdTjmrXyU
         O6Bg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795219017; x=1795823817;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=kVgYuwZfK6/XOH25sVcw/XaxSILhNtXWSKbZSzmcIJo=;
        b=c59T4tmSk3EUmbcOCX2jS+vMZepBGRbNfWJdBaLChqTJToMrZl215sWkEzLTp2r3fk
         bcqIWGCcA7fpXQ+RBD6hpc7srJe2gRV79rtVfi/dKwzRY6cr8KrK1hMVuxkAOcLT1Yxb
         u1iENuR1t4tdP0TZrju2hL/JfZR2XZlklGwXHJ+HSWqusG2KdEvWbdzsnzvW3s9M+NUU
         n+xTtoC0R2jST+W7ksNh1pgjxqgd6+Irc1x+4qDrS5eso7E2DiM9QhEZZwa9aJKA+izk
         7mXs1GYeA0Xw0vfWKMnQMSeEHIXoVIDeNqegk5BUQs9UUZXQaHOScyEXomByw0WN6nCC
         VoXA==
X-Forwarded-Encrypted: i=1; AL+hErFDisUQnBgODzqnGopU19ha0/1S6Ayxvh7JrsLM8s9IB2VeN1VSj/LBo8MJoxqMziBFSoAbXI8=@vger.kernel.org
X-Gm-Message-State: APuU4Z+/mQT9hyCsHFTCaVGXFXq9FLHSEWGnb0lwApZWI3F/zIEDtFTq
	Wq4gPwEHi/fZ3upud+j11shg79Tg5ENhPX2toe2CTn+90RYjEOs8/Rw8
X-Gm-Gg: AYBFou1OjsUEHyr8DUuPMOVFNdh5UQRC2MYAvFpTVi4UeEiocGTzk6VpWPU6ldaT00n
	3G2faiTsBftGs9LrF0UcFnIUw4ezQDvYLzszN2diuPAqn4+AhOaSEf1Rnv8R8SGddjr7zkgOjh2
	g60dfT97TcDZy/HluPiDIvdzTwTqfAtlYw94RlFsXlowmy5Si73C/73VUf78fp23W+0DmIKnzfl
	nbgJyyGbuYKdPTBGgLXAyHv3wWnnHJlDy976vzyh9A0v3qB3fdGOHwF9fhYCLCmmrCJnNby8Z76
	4NqOaVKl1C0MMmyGwJVwKoEegYYFriJEaKnunSHoWcXOwO8WXKZmyfbDtFPtwmJEleYgSi7FcpC
	oES0GjSTGTMyDyUo/MpptzfxbnEw/yStYZPgul3QyVm6Y7Qx2wmQ/Ndn4prs/1YrlOmn1Qpnrqc
	dySGuFybhxlllVhcKeplXAGBqgYDaOt21z8HKZCZ5MA2nzptSkVBYwyqIKlsp5M5WduCQ4A8mw2
	nR8oQEVskSFMA3mFvboFd1GUYsPEYuq1tX9bh5KMbXXlrUvXb6poF1kRJ17glJ+Rj41kn929Gir
	TgHPetUfPTKLCjz1jKgtc6L//AlS9vc2YqSKrkGWzbZQEZ0eKFF/UMyUMgpjeLyzwgLKdYL569d
	izCQ=
X-Received: by 2002:a05:622a:5590:b0:536:3a49:f76 with SMTP id d75a77b69052e-55d76a1f01dmr81789071cf.27.1795219016833;
        Fri, 20 Nov 2026 15:56:56 -0800 (PST)
Received: from [10.67.48.245] ([192.19.223.252])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-92134a16754sm39125006d6.39.2026.11.20.15.56.54
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 20 Nov 2026 15:56:56 -0800 (PST)
Message-ID: <e3d03f4c-0c66-46d1-8fbe-554642eebe34@gmail.com>
Date: Fri, 20 Nov 2026 15:56:53 -0800
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
Subject: Re: [PATCH 7.3 0000/2642] 7.3.6-rc2 review
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, stable@vger.kernel.org
Cc: patches@lists.linux.dev, linux-kernel@vger.kernel.org,
 torvalds@linux-foundation.org, akpm@linux-foundation.org,
 linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
 lkft-triage@lists.linaro.org, pavel@nabladev.com, jonathanh@nvidia.com,
 sudipm.mukherjee@gmail.com, rwarsow@gmx.de, conor@kernel.org,
 hargar@microsoft.com, broonie@kernel.org, achill@achill.org,
 sr@sladewatkins.com
References: <20261120055248.913352689@linuxfoundation.org>
Content-Language: en-US, fr-FR
From: Florian Fainelli <f.fainelli@gmail.com>
In-Reply-To: <20261120055248.913352689@linuxfoundation.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 11/19/26 21:58, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 7.3.6 release.
> There are 2642 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Sun, 22 Nov 2026 05:44:39 +0000.
> Anything received after that time might be too late.
> 
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v7.x/stable-review/patch-7.3.6-rc2.gz
> or in the git tree and branch at:
> 	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-7.3.y
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
