Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=213.97.179.56
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795088072;
	b=PhI5ZAmcdfwUlTK5J0yW9MhGa7ljF+WWyTCk0Mh2/atLNKrOeDWzmfYocdC8qEZpEQxc
	 /znIgken1cmFi2HBNWHphzL1IwjZ6S2uCxpN5un1ts4bygJzZNZTU/RziYXOLEUFI2N0B
	 9ykPR2gWw/cRZo2SPVqhX3RZK2tUV/suzR4LqBHboSf4eFhKTCDk/ldgHDIgMMyPwAH8b
	 jTbv9AYXClWrHsRTw3+AlHQlPGwjFCQtsRy1abikNCEq9M8IyxUsCax3YgTceSrFGSR/p
	 +nBBZPqlHYzTehbc1bnwt10Vkz80GpAkoE7+h/XPs6aI9an9KZd3n7hWGGGnOGocHMA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795088072;
	h=DMARC-Filter:DKIM-Signature:Received:Message-ID:Date:MIME-Version:
	 User-Agent:Subject:To:Cc:References:From:Content-Language:Autocrypt:
	 In-Reply-To:Content-Type:Content-Transfer-Encoding;
	bh=as/xbQd6btjek9NqkbwnfZXg1yO8+Tx8iUfeqSMu6CE=;
	b=3+gTSRke54tNXrjk9wwvI9W2z78YJ4PcpqEX2M+EG2i9kNHESBlMGN720P+uNxTJizoZ
	 mJun+Rrc5Hv2GXRd3igv5BaAo0okf1cLcD57jODBepFFNyHzzVbpt2mLchvet0bq82InC
	 i3vy0XAdwsJZBz18fUIfE2v+GJ0VC6lOvKO2PubbduLa+YgMa16lKz6i9x+NBc6SvJkVw
	 HdsOwDqsW4BgmmCEsUlTRd19t6Js1YeII80zl3lLwux9w+iJpgwYAMgUaRzGIsDFa4cBw
	 d/6Zv709j19jUAsU/7KHbFvPwV3/mwAausXLzT3MJaowslc5nvur9FidgFum5h/U3cQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=igalia.com;
	spf=pass smtp.mailfrom=igalia.com;
	dkim=pass header.d=igalia.com header.i=@igalia.com header.a=rsa-sha256 header.s=20170329 header.b=iVajAg4V;
	arc=none smtp.remote-ip=213.97.179.56
Received: from fanzine2.igalia.com (fanzine2.igalia.com [213.97.179.56])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (prime256v1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9FAD0606A320
	for <stable@vger.kernel.org>; Thu, 19 Nov 2026 11:34:31 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 9FAD0606A320
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=igalia.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=igalia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=igalia.com header.i=@igalia.com header.a=rsa-sha256 header.s=20170329 header.b=iVajAg4V
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com;
	s=20170329; h=Content-Transfer-Encoding:Content-Type:From:Cc:To:Subject:
	MIME-Version:Date:Message-ID:From:Reply-To;
	bh=as/xbQd6btjek9NqkbwnfZXg1yO8+Tx8iUfeqSMu6CE=; t=1795088071; x=2110448071; 
	b=iVajAg4VPfYi+VDf+oUB7GRS/+e5TJT+/CmqB5xo9TI4kS7TRb07kKeoR+0aGUx2SauMFA5JtJ4
	OKOFkYfIsuez3jX79dhRLoslPMSNIJ5qt5JzHjLsFFaLNw8a8FOsnZXTxlZwQgK8LYT17S9wsyEGW
	zrl+heR6ZF0QqmnzUlhCI72rpn0ljEoMBTJPIp7lqJnMcobDrg9TkYXakDCbp7IdkcEiSmfHzyYJh
	JMnJHkZCaqkXutViTiIZrcVrwkugWaxIPYJeJNhKg2CUENTfevpv9oY89p18HJHe/AZcvrByvEUWO
	c3cP6DIGhROwiKlKRZzu1oogKyT8k+qiGkDA==;
Received: from [179.105.94.163] (helo=[192.168.0.4])
	by fanzine2.igalia.com with esmtpsa 
	(Cipher TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_128_GCM:128) (Exim)
	id 1xU0PK-00000001Qjw-3oGx;
	Thu, 19 Nov 2026 12:34:27 +0100
Message-ID: <584c3855-5fa5-4b06-a95f-c6c0816cea08@igalia.com>
Date: Thu, 19 Nov 2026 08:34:20 -0300
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
Subject: Re: [PATCH 0/4] drm/vc4: Work around GFXH-16 instruction cache
 livelock
To: Iago Toral <itoral@igalia.com>,
 "Juan A. Suarez Romero" <jasuarez@igalia.com>,
 Dave Stevenson <dave.stevenson@raspberrypi.com>,
 Raspberry Pi Kernel Maintenance <kernel-list@raspberrypi.com>,
 Maxime Ripard <mripard@kernel.org>, David Airlie <airlied@gmail.com>,
 Simona Vetter <simona@ffwll.ch>
Cc: kernel-dev@igalia.com, dri-devel@lists.freedesktop.org,
 stable@vger.kernel.org
References: <20261118-vc4-icache-workaround-v1-0-5b8adc2c84fe@igalia.com>
 <e945bdd00b4eecec4b7e451e35cb39855ad2e0de.camel@igalia.com>
From: =?UTF-8?Q?Ma=C3=ADra_Canal?= <mcanal@igalia.com>
Content-Language: en-US
Autocrypt: addr=mcanal@igalia.com; keydata=
 xsBNBGcCwywBCADgTji02Sv9zjHo26LXKdCaumcSWglfnJ93rwOCNkHfPIBll85LL9G0J7H8
 /PmEL9y0LPo9/B3fhIpbD8VhSy9Sqz8qVl1oeqSe/rh3M+GceZbFUPpMSk5pNY9wr5raZ63d
 gJc1cs8XBhuj1EzeE8qbP6JAmsL+NMEmtkkNPfjhX14yqzHDVSqmAFEsh4Vmw6oaTMXvwQ40
 SkFjtl3sr20y07cJMDe++tFet2fsfKqQNxwiGBZJsjEMO2T+mW7DuV2pKHr9aifWjABY5EPw
 G7qbrh+hXgfT+njAVg5+BcLz7w9Ju/7iwDMiIY1hx64Ogrpwykj9bXav35GKobicCAwHABEB
 AAHNIE1hw61yYSBDYW5hbCA8bWNhbmFsQGlnYWxpYS5jb20+wsCRBBMBCAA7FiEE+ORdfQEW
 dwcppnfRP/MOinaI+qoFAmcCwywCGwMFCwkIBwICIgIGFQoJCAsCBBYCAwECHgcCF4AACgkQ
 P/MOinaI+qoUBQgAqz2gzUP7K3EBI24+a5FwFlruQGtim85GAJZXToBtzsfGLLVUSCL3aF/5
 O335Bh6ViSBgxmowIwVJlS/e+L95CkTGzIIMHgyUZfNefR2L3aZA6cgc9z8cfow62Wu8eXnq
 GM/+WWvrFQb/dBKKuohfBlpThqDWXxhozazCcJYYHradIuOM8zyMtCLDYwPW7Vqmewa+w994
 7Lo4CgOhUXVI2jJSBq3sgHEPxiUBOGxvOt1YBg7H9C37BeZYZxFmU8vh7fbOsvhx7Aqu5xV7
 FG+1ZMfDkv+PixCuGtR5yPPaqU2XdjDC/9mlRWWQTPzg74RLEw5sz/tIHQPPm6ROCACFls7A
 TQRnAsMsAQgAxTU8dnqzK6vgODTCW2A6SAzcvKztxae4YjRwN1SuGhJR2isJgQHoOH6oCItW
 Xc1CGAWnci6doh1DJvbbB7uvkQlbeNxeIz0OzHSiB+pb1ssuT31Hz6QZFbX4q+crregPIhr+
 0xeDi6Mtu+paYprI7USGFFjDUvJUf36kK0yuF2XUOBlF0beCQ7Jhc+UoI9Akmvl4sHUrZJzX
 LMeajARnSBXTcig6h6/NFVkr1mi1uuZfIRNCkxCE8QRYebZLSWxBVr3h7dtOUkq2CzL2kRCK
 T2rKkmYrvBJTqSvfK3Ba7QrDg3szEe+fENpL3gHtH6h/XQF92EOulm5S5o0I+ceREwARAQAB
 wsB2BBgBCAAgFiEE+ORdfQEWdwcppnfRP/MOinaI+qoFAmcCwywCGwwACgkQP/MOinaI+qpI
 zQf+NAcNDBXWHGA3lgvYvOU31+ik9bb30xZ7IqK9MIi6TpZqL7cxNwZ+FAK2GbUWhy+/gPkX
 it2gCAJsjo/QEKJi7Zh8IgHN+jfim942QZOkU+p/YEcvqBvXa0zqW0sYfyAxkrf/OZfTnNNE
 Tr+uBKNaQGO2vkn5AX5l8zMl9LCH3/Ieaboni35qEhoD/aM0Kpf93PhCvJGbD4n1DnRhrxm1
 uEdQ6HUjWghEjC+Jh9xUvJco2tUTepw4OwuPxOvtuPTUa1kgixYyG1Jck/67reJzMigeuYFt
 raV3P8t/6cmtawVjurhnCDuURyhUrjpRhgFp+lW8OGr6pepHol/WFIOQEg==
In-Reply-To: <e945bdd00b4eecec4b7e451e35cb39855ad2e0de.camel@igalia.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Hi Iago,

On 19/11/26 05:17, Iago Toral wrote:
> Looks good to me:
> Reviewed-by: Iago Toral Quiroga <itoral@igalia.com>
> 
> I was not aware that hang checks were happening at second boundaries,
> regardless of the time at which the hangcheck was queued, it doesn't
> sound like a good idea, so I think it is good to change that.
> 
> On the other hand, now we rearm the hang check every 100ms instead
> which is a much smaller window. I understand this reduces visible
> impact of the workaround when the issue happens, but I am wondering
> whether this alone has any visible performance impact for the 99% of
> the time we are not hitting the problem, I presume you haven't seen
> any?
> 

I benchmarked glmark2-wayland --off-screen (800x600, under labwc) and
glmark2-es2-drm (1920x1080 fullscreen), which I believe are
representative applications for RPi 3B+, and I observed no performance
impact. I even tested 50 ms and I didn't observe a performance impact as
well.

If you have other applications you would like to see the benchmark
results, just let me know and I can test it.

Best regards,
- Maíra

> Iago
> 
> El mié, 18-11-2026 a las 18:47 -0300, Maíra Canal escribió:
>> Mesa issue #16652 [1] reports GPU resets every few minutes on the
>> Raspberry Pi 3. They happen when text labels are drawn over their
>> shadows:
>> two different threaded fragment shaders, plus untextured single-
>> threaded
>> ones, in the same tiles.
>>
>> During a hang, the performance counters show four QPUs fetching
>> instructions with 0 cache hits, ~6.5M misses per 100 ms, and 0 valid
>> instructions executed. This matches HW erratum GFXH-16: the QPUs of a
>> slice share one instruction cache and can livelock, evicting each
>> other's
>> fills. Since shader code always starts at offset 0 of a page-aligned
>> BO,
>> every shader competes for the same cache sets.
>>
>> This series works around it:
>>
>>    - Patch 3 starts each shader's code at one of four offsets in its
>> BO,
>>      spreading shaders across cache sets.
>>
>>    - Patch 4 clears the slice instruction and uniforms caches when the
>>      hangcheck finds no progress, and resets the GPU only if the stall
>>      persists. It is meant to recover from livelocks the offsets don't
>>      prevent.
>>
>> Patches 1 and 2 fix an off-by-one in the shader BO handle check and a
>> NULL pointer dereference in validate_gl_shader_rec(), found while
>> working
>> on patch 3.
>>
>> Tested on a Raspberry Pi 3B+ with the issue's reproducer, 4 x 15 min
>> runs:
>>
>>    without the series:  29 GPU resets
>>    with patches 1-3:     0 GPU resets
>>
>> [1] https://gitlab.freedesktop.org/mesa/mesa/-/issues/16652
>>
>> Best regards,
>> - Maíra
>>
>> ---
>> Maíra Canal (4):
>>        drm/vc4: Fix off-by-one in the shader record BO handle check
>>        drm/vc4: Check for a validated shader before reading its thread
>> mode
>>        drm/vc4: Start shader code at varying offsets in its BO
>>        drm/vc4: Clear the slice caches before resetting a stalled GPU
>>
>>   drivers/gpu/drm/vc4/vc4_bo.c               | 43
>> +++++++++++++++++++++++-------
>>   drivers/gpu/drm/vc4/vc4_drv.h              | 15 ++++++++++-
>>   drivers/gpu/drm/vc4/vc4_gem.c              | 20 ++++++++++++--
>>   drivers/gpu/drm/vc4/vc4_validate.c         | 17 +++++++-----
>>   drivers/gpu/drm/vc4/vc4_validate_shaders.c |  7 ++---
>>   5 files changed, 79 insertions(+), 23 deletions(-)
>> ---
>> base-commit: 80ac6d197218c3399d66674167a4d7c9051a25e2
>> change-id: 20261112-vc4-icache-workaround-d11b444bc7e8
>>
>>
> 

