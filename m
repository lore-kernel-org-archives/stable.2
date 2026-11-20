Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.160.172
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795205758;
	b=QWPKniw0sJCbFikfJFL3JeBTiIcufK1nO5QlPxHmxH1Aazd9IacEHON6mgQMWNNr/D1+
	 nYx0zV/W6zv4ro8mxK/jNzWv6B6RdLzbNslbkgZJBpGCCcq4fCsc9WVMKrayqTzdtnnPW
	 toguKMJp05pfZL/we1mJVkUv0iQKM/QCXGPU82qLI1Br8SoP0C7dJZQ2VIJyOJfif+I8L
	 6hkDVuwQ1io0nlwzTEwnUDBl6KOvui/9UP/VF2nAEbafg44HKwLUpBEsudzg5ZZZJI8ZO
	 F5+Z5Lv03F02fa6nk/1eMnPZyU7rctjhE+6MG+xZGXMbQ35CG0fJNQfCO177wLMec8A==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795205758;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Message-ID:Date:MIME-Version:User-Agent:Subject:To:Cc:References:
	 Content-Language:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding;
	bh=Bmres2veI4WmKoOO0djqwZlxjU4vTSr8LiYOV14rpMI=;
	b=nn5cZgsve4klQhMlP2hSw4hAFsXp2iYlFjoNZ+xsYHdvbomhtbRvqIQGDFOgE6Cyvfzk
	 CXWWTCHvn8tkcrtPAg2EC4wc4Mzk8Wek/sPGRZJxcvjXVEAlIimUazINwl4+lCamuoAsa
	 ZHO0gKHpMFI/QrjyOKdsrb1l0mgrMpNbnOn8mlx7Xas0kU0RTmGXVrosRrxqQlwl2wNNH
	 hkjLDORnc1pcTHcXTMJkdlx2xd39nMS+WJs5cO9k6gE6zGBC2v+yGJjldMbgLV6Iz5eIq
	 mlHAs/POA60htoenpE82paS+qSeuMOZGuCG+F8Ua9h22v4xfUP46U0nczeWg9dLlllA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=GqEgBK21;
	arc=none smtp.remote-ip=209.85.160.172
Received: from mail-qt1-f172.google.com (mail-qt1-f172.google.com [209.85.160.172])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 39805606A6E8
	for <stable@vger.kernel.org>; Fri, 20 Nov 2026 20:15:49 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 39805606A6E8
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=GqEgBK21
Received: by mail-qt1-f172.google.com with SMTP id d75a77b69052e-55d846e884eso3991201cf.2
        for <stable@vger.kernel.org>; Fri, 20 Nov 2026 12:15:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795205748; x=1795810548; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=Bmres2veI4WmKoOO0djqwZlxjU4vTSr8LiYOV14rpMI=;
        b=GqEgBK21StO8Cxd+na/3iiN3yW+IrI9rHKRE1HvRhb95+XwkQmrGisIz0yzLAIaFNy
         NpJ2dNGzkqNEZ1SZ1WFUAYGLbyQ+LzQOwWuZbi8L487BrUtOh9lOzYdA+g+zlichDGq0
         kMqpxk6aRRrEPMoLvS+XgJ/QYdsA/A7qpwxdVSfhkMLKIchu6NvpyjlcgnuC2lOUY29I
         48bqAnwtN1jVGJ5AYZ4A+DB+TJxvFtuEyGURmvOqezNtYIX/+7SS9keoRkBJAIL/ALpi
         rx3bkx9wSkTcVW0UuO/L3OPge3pxKnO+qkpg4SH8wuWBQf/XLTq8CEcKvPJ2Z5Zn4cxq
         MKoA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795205748; x=1795810548;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=Bmres2veI4WmKoOO0djqwZlxjU4vTSr8LiYOV14rpMI=;
        b=YZ2s9rDpFl0nAoRArvXpu6lvZy7QDt128a5m47wpRgZ+W/Oh+fwnZnSPxSbN0MxSik
         VlzO21OYsBQfisatpK0oLpkqwngL9hSgnZfKaIn64bGGrwex2b01LK2pOMnjG/GTMYzP
         oODwBOk7I0um8lkPgyZy/ODhyJU4pOrI0WbUHKyWIKKTWaNx347KbhUKJqOPm3WgCS/t
         WpyPdvZFJgozWXJcHMrOmFfo51fg8ii5XzvBqqG2YAqjOV5luCA5A1sK2U5yBGotHSzK
         BZCF5m87AwZH0GlGqzJXrt+YN7r1JnERq2HVKTxdh9PhXGI/hDD9w0jravnKQr8x6Fsb
         aH6Q==
X-Forwarded-Encrypted: i=1; AL+hErEaVdlstx01s4lv7H8aLwuTVvRZNmLu8QwM5kiIugRDI1uqPtAfc8Ejn3MLNCvvsmdv+cp/EZE=@vger.kernel.org
X-Gm-Message-State: APuU4Z/bVKX/IqzX8GVS74ScCAnHVhOIBdotA29QZsHJStnH/np+L9qv
	o791ZMHTBB6QHhMPm+eXqkAmbfED1TXQmkqLUKKTVO5IjDm+TAmpmjvZ
X-Gm-Gg: AYBFou2CQbLUsT/wtgmVU8rTLb0Foyj4rOMEKhywha1H2tkVxP4jVwQnCTeWtJbvC5K
	17ej9qkdPbeQxvbqHR6+j+N/RPxuTwYWBtVCCuQx4rNrqU51uBt6ORy9NHUSJ0e84o78RhRC5EX
	EJlsrg15wgxPNgJ4gxcNJ15RskWfHYw49XCiwjzXgA2x6xx7ipW7lEChVQGnzXAcQH2EidsBa56
	QSKtalRjRAPFJAvvBr1tOB6j9VGf5Ej3aeUr39DUE/Rfp2+u0WsE8xesj6TLLbGfBBF4+ll/qQx
	U6LeENKMVx9/ZAHZW6dDkYD1biVbNnl30hWNMrwqfYClnK5PjgBHy2rksvYGoVRN5oF7wsVOjhI
	UMxWBXXckiCwAxYyjrfjyPyv3LdPTMzREehEGrw8hixcMpWpwNQE97B95/zR+wrs1spNIhUYusy
	zJB4qxSAtgcpz/FPV0VELZ/0Yy0yVG7w58qZVGk2axwQbgxMvjKXPb4lRdIf3Z5h04OFFI0m1rV
	LJ+oe2+6qRU92eUsJsPAsm40R7nqFfkfXaFIeB3/UY1tSfiImpU1AJ5qZxsLHpghgstLMJRx0Ds
	EpRaNUGpbGMh0Ch182UtKMbGeJQv/VGTLX2wjhdXUbdDZXgu+tyry+ZXl6VzNcfgRbim/hBrRj8
	Veg==
X-Received: by 2002:a05:622a:230b:b0:55b:f621:e7ce with SMTP id d75a77b69052e-55d76a26c80mr68335001cf.25.1795205748149;
        Fri, 20 Nov 2026 12:15:48 -0800 (PST)
Received: from [10.67.48.245] ([192.19.223.252])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-55d78807b5fsm31219881cf.6.2026.11.20.12.15.45
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 20 Nov 2026 12:15:47 -0800 (PST)
Message-ID: <ac9a7cea-0d4e-4856-b796-03a1b887476a@gmail.com>
Date: Fri, 20 Nov 2026 12:15:44 -0800
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
Subject: Re: [PATCH 5.15 0000/2178] 5.15.226-rc2 review
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, stable@vger.kernel.org
Cc: patches@lists.linux.dev, linux-kernel@vger.kernel.org,
 torvalds@linux-foundation.org, akpm@linux-foundation.org,
 linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
 lkft-triage@lists.linaro.org, pavel@nabladev.com, jonathanh@nvidia.com,
 sudipm.mukherjee@gmail.com, rwarsow@gmx.de, conor@kernel.org,
 hargar@microsoft.com, broonie@kernel.org, achill@achill.org,
 sr@sladewatkins.com
References: <20261120055015.328810133@linuxfoundation.org>
Content-Language: en-US, fr-FR
From: Florian Fainelli <f.fainelli@gmail.com>
In-Reply-To: <20261120055015.328810133@linuxfoundation.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 11/19/26 21:57, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 5.15.226 release.
> There are 2178 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Sun, 22 Nov 2026 05:44:39 +0000.
> Anything received after that time might be too late.
> 
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v5.x/stable-review/patch-5.15.226-rc2.gz
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
