Received: from mail-wm1-f47.google.com (mail-wm1-f47.google.com [209.85.128.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 598513191BA
	for <stable@vger.kernel.org>; Sat,  8 Aug 2026 02:36:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786156628; cv=none; b=tMh9Kv8zp4aSftAfodi8Vrpcak7PKdkY17d5IZs7L9jM6fWO4pPnWK93qfn7/AlzjSNrssPx19CBGYxk1actK9uIi2i2w4pdbyV+XuviiLjKfjGzZs/8Su8r2hXr5dtD1Qc9xIEMBWhgVzz3DwPcjlqU2Q9ChQ+qS+c/1uzHkDU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786156628; c=relaxed/simple;
	bh=ayl39V9jsQDthU7IaTZneV4r/w49CMyZM2LysxNqjZQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=qyUDERzPOQ2St17wFhaB+B0qufkmgrtq8cNa9rZHdNiHcLZyjz1+Rs+MW0hvUC+l4IqtpWHmrh1f+PhWuLjo+MSB6BhgwAsHS8RVYRuVOopEi7QimhfYENkd56PkJJSEdV2mQq/q/jK1fQQ2bUt0yUI28T7UPF2vMWWoC0TOOtU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=googlemail.com; spf=pass smtp.mailfrom=googlemail.com; dkim=pass (2048-bit key) header.d=googlemail.com header.i=@googlemail.com header.b=p58wMe8B; arc=none smtp.client-ip=209.85.128.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=googlemail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=googlemail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=googlemail.com header.i=@googlemail.com header.b="p58wMe8B"
Received: by mail-wm1-f47.google.com with SMTP id 5b1f17b1804b1-4956242332dso1500825e9.2
        for <stable@vger.kernel.org>; Fri, 07 Aug 2026 19:36:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20251104; t=1786156602; x=1786761402; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from:references
         :cc:to:content-language:subject:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=6wWRjzPoteH1nOSgNqvE8hQzRiTcCSs1CVRLNPvnqLg=;
        b=p58wMe8BDPL5hj0Vu6sfjY+BAtWd2RDZvSSdynNR2PlajB9kW+bm4r7OYhq6Dp9m3Z
         x0+qhhYFSeJC90fDCpt8UYkxpc8phdaw/DwT4hquL9w5aEpVOHT+qtREP4ssdjrM7cQD
         fe1m7tiY3FfsG/dVzzAALw3KqhYfl8m2TzaEwpH5mIt3Q18yMoLHU2BiEu3DJCiUC8uj
         /ZqFKE9CiIOr4h1bKCEm6Bnc79z+CzUwG7u/U9o5CuJnelzU+H/L+b5JzelaXZPG9XgU
         MtnxvOfkLsEOdzj01RyE+2IvlzFJ7Argni4TOTMQOjDXzV1kwtN6hwjlwNN/lsSkFNY4
         J1zg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786156602; x=1786761402;
        h=content-transfer-encoding:content-type:in-reply-to:from:references
         :cc:to:content-language:subject:user-agent:mime-version:date
         :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=6wWRjzPoteH1nOSgNqvE8hQzRiTcCSs1CVRLNPvnqLg=;
        b=dTPCIy7IwFFQ7/EZRvxg5gYRlpWcedkz+dV1k/AZGw99C+oUq0tofTxOt3DhsslTRz
         s/XsvAoqZlmNBkKi3fGOAc6iYMUIxFoCLnDFMf7XoW/TMsz/1VA4mteBCBY+8+WOE0MV
         xEhNtwPU2q4fdtqq5EuT42Z9M0ysIMHa4oNfweMoliUgL0o61g+TNYz33S7K7ww2QuN2
         Xl4Xebfivo9vg6wWxoQXuYh4GII5HGPLhjNmo/kxlsrvpbU9yK+qiDolGCBjqPnSIToW
         /TZtTCS5oEzEBMWHKHhNyXxYlf9YSbW9p3oN3TgfULzE1ugo3P7+aEE551pYqVHJnBHv
         U45A==
X-Forwarded-Encrypted: i=1; AHgh+Ro7lNAYX9zhtR220A2K/E7OuJwOdEtxJ3/Us+Mav7dIwbS3nU+FRtM3QP+fY6M3swStAhtNxrk=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz2P183efggW3Jadlot2t71Cf7pApJjK3V1frRjvFA29LT/diCn
	hWu0I+DixCQlaMXkFGk0DAVEJsosw52d+3rijesFLO7JccEZrUgi7Rg=
X-Gm-Gg: AR+sD12zaBD0yDWS4VvTW/kY2HpswwiJyppVKCcsux6lonGDW8nqFRvtrN355mD1fhg
	NQsVYRObOYJlNlOtEJOXhUL4SCmN8/w+smmAH5YvcDMage5CoqcTsh9jdlJEg+5qethkL8D8EIW
	y3CLibB6yWHgu+fypj48mH2Df2QYpf5cYKGh+L7xMYYSzdqTuiVdPh5ppoVOQRUHgcbedDurcTc
	BnO8es89AY4rSPTN1HFZmqS/LXFAlYPGvLqfZVCxzjN03W0fuv/ZvOxT94U9V5vpNjqXmRQF8Lx
	VGpDDVi2KKHk5STbHlkrDDgPRGiFljmBGLwLtI5Pi1+Eiy+zeqU86f+hvbGemgyYSMVlCydmsw5
	3CGXYaRQI8z67boJ0Qf99AxeIZDUkM5nCC/vNsH9aG71Sj6VEDQXGbrFjSalyO2dhI1ICHaBmup
	hJVj4CCl9cObuQdi29D/E6lxt2agQNxHC11+qupaD2Z8cIqdwGJsanvsSlIUpb5qlVl8IawaOTB
	iKeubQlq/pVFvljBWPcPIWWPMtRIsUcdJ1Z/1koRg==
X-Received: by 2002:a05:600c:3153:b0:493:f0f5:f2d7 with SMTP id 5b1f17b1804b1-49961960a21mr53227935e9.7.1786156601796;
        Fri, 07 Aug 2026 19:36:41 -0700 (PDT)
Received: from [192.168.1.3] (p5b2b4d93.dip0.t-ipconnect.de. [91.43.77.147])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4995ea27ec7sm88291985e9.10.2026.08.07.19.36.40
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 07 Aug 2026 19:36:41 -0700 (PDT)
Message-ID: <f720b5a5-5595-416c-bf4d-d1e760cf0efb@googlemail.com>
Date: Sat, 8 Aug 2026 04:36:40 +0200
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Betterbird (Windows)
Subject: Re: [PATCH 6.12 000/337] 6.12.103-rc1 review
Content-Language: de-DE
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, stable@vger.kernel.org
Cc: patches@lists.linux.dev, linux-kernel@vger.kernel.org,
 torvalds@linux-foundation.org, akpm@linux-foundation.org,
 linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
 lkft-triage@lists.linaro.org, pavel@nabladev.com, jonathanh@nvidia.com,
 f.fainelli@gmail.com, sudipm.mukherjee@gmail.com, rwarsow@gmx.de,
 conor@kernel.org, hargar@microsoft.com, broonie@kernel.org,
 achill@achill.org, sr@sladewatkins.com, Ilya Maximets <i.maximets@ovn.org>,
 Pablo Neira Ayuso <pablo@netfilter.org>, Sasha Levin <sashal@kernel.org>
References: <20260807143418.516897842@linuxfoundation.org>
From: Peter Schneider <pschneider1968@googlemail.com>
In-Reply-To: <20260807143418.516897842@linuxfoundation.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Am 07.08.2026 um 16:33 schrieb Greg Kroah-Hartman:
> This is the start of the stable review cycle for the 6.12.103 release.
> There are 337 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.

Builds, boots and works on my 2-socket Ivy Bridge Xeon E5-2697 v2 server. No dmesg oddities or regressions found.

Tested-by: Peter Schneider <pschneider1968@googlemail.com>


Beste Grüße,
Peter Schneider

-- 
Climb the mountain not to plant your flag, but to embrace the challenge,
enjoy the air and behold the view. Climb it so you can see the world,
not so the world can see you.                    -- David McCullough Jr.

OpenPGP:  0xA3828BD796CCE11A8CADE8866E3A92C92C3FF244
Download: https://www.peters-netzplatz.de/download/pschneider1968_pub.asc
https://keys.mailvelope.com/pks/lookup?op=get&search=pschneider1968@googlemail.com
https://keys.mailvelope.com/pks/lookup?op=get&search=pschneider1968@gmail.com
