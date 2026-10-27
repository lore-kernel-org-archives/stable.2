Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=213.97.179.56
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793106485;
	b=meupQh7hu+dfVTZL6QeNbC73Khu1alQeWLBHz4B6hdiPWiu5b8vXL8LvSppKg1KYizBv
	 0FTRD9xNwyFVmRW7/pQq1A3G0zYcJ7OlQdaP4gz0nFs71kRCI183xqmr2Ry3kILITOAMl
	 iU9jbTu9970gsKS4Vx2t499zTGoOuqAdb/3W8gnqkhvl481iGtyhbz2sH6d2En9R2Hj0q
	 p49LFj4SHrAVtbkw5EfMemQkhIiWzvPXEy9hx/SThVmTn2RcBzzu49ByQgAT3WXhkHYN1
	 YNLyKFvFoiSURRQZ0NCb4+e7Ki61f6/2kE0gTLpRFHxC2Xefm7Sczeyq9ezS0ge17mg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793106485;
	h=DMARC-Filter:DKIM-Signature:Received:Message-ID:Date:MIME-Version:
	 User-Agent:Subject:To:Cc:References:From:Content-Language:Autocrypt:
	 In-Reply-To:Content-Type:Content-Transfer-Encoding;
	bh=Go1xjrAL7q/1AARqhv9eE2FyOWcMjJhhydc8QRK0djk=;
	b=jl1cPw60GK0MjoSvOJWL/Jz8HFweq5PaOheMEO8JhWNpZXqjvsdouZ4kTnhc1jzjn6C9
	 VEPzqc57hOLm3MBv4H7Kdajjns3uHHLcekwoZFevokO+si3fUX4e+6I1pYzOiYeB7ZFHI
	 /pDpSmWGNc+Bu4e7gj8z9cvq7zS3mADcI9Rimor8OJ0hK5Sj8HGYiURzumjoXHPoBpQvG
	 YEnJ3s1Ukwykg+IVgPD8bJrPTC5U7nTCOeIYmxz/LOyBQhNmeMof1U2G3MCmMUl4MHg5K
	 LUwJJ35o8LfSMDJDo/iLJjBDwHc5Vzz/utEVWl8CqfHAqPwxqgnFzp5r9NXdnwfZkCw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=igalia.com;
	spf=pass smtp.mailfrom=igalia.com;
	dkim=pass header.d=igalia.com header.i=@igalia.com header.a=rsa-sha256 header.s=20170329 header.b=Dsn0KVV7;
	arc=none smtp.remote-ip=213.97.179.56
Received: from fanzine2.igalia.com (fanzine2.igalia.com [213.97.179.56])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (prime256v1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 28A28606A31B;
	Tue, 27 Oct 2026 13:08:02 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 28A28606A31B
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=igalia.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=igalia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=igalia.com header.i=@igalia.com header.a=rsa-sha256 header.s=20170329 header.b=Dsn0KVV7
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com;
	s=20170329; h=Content-Transfer-Encoding:Content-Type:From:Cc:To:Subject:
	MIME-Version:Date:Message-ID:From:Reply-To;
	bh=Go1xjrAL7q/1AARqhv9eE2FyOWcMjJhhydc8QRK0djk=; b=Dsn0KVV7avfjTIwunE5xqU9MlA
	/Sd9aDdiwTR70tn36rCVE9ocOsuRhayewl5VmWltbtieVzdIP0HBTzDZ3Edvs5ssAkBfQpU7Hup5O
	PPyVvKxI0HGyen6EO7sPfIgif5PtksZgW1Y43rRof08PNEtD2cT+67rRZ7G4LEPAOuEmiO8wALjAV
	f86Eq9xUipvJaaKnI7FvAmtzOOYo8Q6v5nJ8yc8KD0hnpOAO6mpMSOdKfhNtYHJh98xSFxIDlSXvj
	rYjye5jiw+3uXNbTO/3bvYLKCYy9nE4BBwoYTyd0vZgTVEAR3xqfXuhXZB9zmHCnnwZtZMXl5YdRK
	cbEEuYSQ==;
Received: from [179.105.94.163] (helo=[192.168.0.2])
	by fanzine2.igalia.com with esmtpsa 
	(Cipher TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_128_GCM:128) (Exim)
	id 1xLgtt-00BnnE-NI; Tue, 27 Oct 2026 14:07:37 +0100
Message-ID: <a8b9450f-af4b-47bf-b7b1-3b326ed52dfc@igalia.com>
Date: Tue, 27 Oct 2026 10:07:32 -0300
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
Subject: Re: [PATCH v3 0/3] drm/vc4: hdmi: enable scrambling before the TMDS
 clock starts
To: Cristian Ciocaltea <cristian.ciocaltea@collabora.com>,
 Lucas Tanure <lucas.tanure@neat.no>
Cc: Maxime Ripard <mripard@kernel.org>,
 Dave Stevenson <dave.stevenson@raspberrypi.com>,
 Dom Cobley <popcornmix@gmail.com>,
 Raspberry Pi Kernel Maintenance <kernel-list@raspberrypi.com>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>,
 Simona Vetter <simona@ffwll.ch>, dri-devel@lists.freedesktop.org,
 stable@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20261026164028.78792-1-lucas.tanure@neat.no>
 <at_4EgWZFghkRHzH@collabws.localdomain>
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
In-Reply-To: <at_4EgWZFghkRHzH@collabws.localdomain>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Hi Cristian,

On 26/10/26 22:23, Cristian Ciocaltea wrote:
> Hi Lucas,
> 
> On 2026/10/26, Lucas Tanure wrote:
>> HDMI 2.0 asks the source to set TMDS_Bit_Clock_Ratio in the sink while
>> the TMDS clock is stopped and to start the clock at least 1 ms later.
>> vc4 writes the bit, and enables the scrambler, at the end of the enable
>> sequence, long after the PHY has started, and clears it before the PHY
>> stops. A sink that samples the bit when the clock appears never locks
>> a 4K60 signal from a Raspberry Pi 5, while laptops that follow the
>> order work on the same sink.
>>
>> Patch 3 is the fix. Patch 1 is needed on BCM2712, where phy_disable()
>> was an empty stub upstream, so the PHY kept running after disable; the
>> Raspberry Pi tree has carried this since 2024. Patch 2 fixes a
>> pre-existing race in the scrambling work cancel that the fix would
>> otherwise make easier to hit.
>>
>> v1 was tested on a Raspberry Pi 5 running the Raspberry Pi 6.18 kernel
>> with the same change applied, against the sink that showed the
>> problem: plain enable at 4K60, 1080p60 to 4K60, 4K30 to 4K60, a sink
>> reset and a sink power cycle all lock with zero character errors. v2
>> and v3 carry the same code; the hardware test of the final form is
>> still pending and will be reported in this thread. Mainline was not
>> booted on the Pi 5. The BCM2711 path is unchanged except for the
>> enable order; I have no Pi 4 at hand.
> 
> While converting vc4 to the common HDMI 2.0 scrambling infrastructure, I
> ran several tests on the Raspberry Pi 5 and didn't notice any (obvious)
> issues.
> 
> Hence, could you please verify whether your problem reproduces with a
> recent mainline kernel?  If it does, could you also give [1] a try and
> report back the actual behavior?
> 

I suspect you didn't hit this on mainline because vc6_hdmi_phy_disable()
is a stub, so the TMDS clock never stops between disable and enable.

Best regards,
- Maíra

> [1] https://lore.kernel.org/lkml/20261014-vc4-common-scramb-v3-0-c68d58d959a2@collabora.com/
> 
> Regards,
> Cristian

