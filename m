Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=213.97.179.56
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794229019;
	b=Wu0jXB6GkukLYDNP7TVCd9Qub7l9jjSpfQkTghlLthlRzw8TohOD31Rg7CoobiX/LA7f
	 AyIWna6Tx5YbffwZjiFgRgohQvx0F3F/THA38QOEQZ5reSIQ762hWqevoyHclssPNvVEG
	 uK8GUEsDJ1hMDnqo936ZVpZFYi3NVgaBu6sbXm6nAAuaSeQ8UTKnSz+Bs7n6EVL9IsBR6
	 qrw1megA4Em+ftabmtmn7FOTrUUovWBdfedaJOHOnqyT2NChDuuRBr4Wj2v6zrpOpA0R5
	 3JEKUy1PCvPHWyS5QxC4DRQAqze8QfLEjU94tJYKuh0ziivGfDsGOF6Ki7FSADuVW8w==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794229019;
	h=DMARC-Filter:DKIM-Signature:Received:Message-ID:Date:MIME-Version:
	 User-Agent:Subject:To:Cc:References:From:Content-Language:Autocrypt:
	 In-Reply-To:Content-Type:Content-Transfer-Encoding;
	bh=X8bKScF8eV0DybP5B8iH86pIo6Qb/6M8n/7AiE59994=;
	b=DHUqcwZWaTv82RMSHgq33Ga98rsGhVWznwxmPnOVuzc7Gs4pNJu+Go70uA2fLmPpIiLD
	 uzoUDQDfiWwXc+2oB36C0XLR90pc5fsZIli5eYyrOFTJj6Ib4eKAv6ok34nmLeacyk7l/
	 JBvlLdzaA8PaYocubedPrK8sHr9Bk5juuAI2VAcqq6ETsUpavDhTtJJYLptbSytaXUzar
	 bpHX1VG+ckLkOX4nSWwbuynZYc5HL32MP/tMEU9ODne8icULwJk6qPGmJLkGwyg3Qpsi8
	 2mcvAe+xSoMK2RpPwLrK+aWeFJouEkR+4XVeJtQzoNodwE4ewfFvsq3NPmRZQWAp+Vw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=igalia.com;
	spf=pass smtp.mailfrom=igalia.com;
	dkim=pass header.d=igalia.com header.i=@igalia.com header.a=rsa-sha256 header.s=20170329 header.b=oDBcAO84;
	arc=none smtp.remote-ip=213.97.179.56
Received: from fanzine2.igalia.com (fanzine2.igalia.com [213.97.179.56])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (prime256v1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3D6F4606A322
	for <stable@vger.kernel.org>; Mon,  9 Nov 2026 12:56:57 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 3D6F4606A322
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=igalia.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=igalia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=igalia.com header.i=@igalia.com header.a=rsa-sha256 header.s=20170329 header.b=oDBcAO84
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com;
	s=20170329; h=Content-Transfer-Encoding:Content-Type:From:Cc:To:Subject:
	MIME-Version:Date:Message-ID:From:Reply-To;
	bh=X8bKScF8eV0DybP5B8iH86pIo6Qb/6M8n/7AiE59994=; t=1794229017; x=2109589017; 
	b=oDBcAO84R+bf3VZyzDPHTqE4AdXVWVHo62zLAIpdALvjtonC33f4j6pF+jTk4bVXOhZl2z+fSNv
	PH8miNOAXMR2ymn81VIeIPDZ5bA88vZ/BDbxF9VGnxaPZwh/SiXIpPfjEY6tmD8+Q/iLGPcTMvRov
	vcGQMoZOVL0rzPjMduQ7lMkvcVhKqHTpnwcSGwaVGOiEnIFkv3HSFk5qmjQgrmN8b4wcKhnXzns6+
	z8h5Xfe4tEVzCU/Aln+FwGP6/AC/fLceCbkbRy/k1SsNPXycKm7SUsNDFNiNDwm00tJTHXpPRVvGN
	6wwV0XrF9ivp7Wu3UUjnLNlMziA+gr4wATeQ==;
Received: from [179.105.94.163] (helo=[192.168.0.4])
	by fanzine2.igalia.com with esmtpsa 
	(Cipher TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_128_GCM:128) (Exim)
	id 1xQOve-007Hdt-Il; Mon, 09 Nov 2026 13:56:54 +0100
Message-ID: <6fccc8da-1c81-45c4-83ad-f71f48846342@igalia.com>
Date: Mon, 9 Nov 2026 09:56:48 -0300
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
Subject: Re: [PATCH 1/2] drm/v3d: Initialize timedout_batches when running a
 CSD job
To: Iago Toral <itoral@igalia.com>,
 Jose Maria Casanova Crespo <jmcasanova@igalia.com>,
 Melissa Wen <mwen@igalia.com>
Cc: dri-devel@lists.freedesktop.org, kernel-dev@igalia.com,
 stable@vger.kernel.org
References: <20261101125619.2465064-1-mcanal@igalia.com>
 <179362541395.53188.8652440988836179813.b4-ty@igalia.com>
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
In-Reply-To: <179362541395.53188.8652440988836179813.b4-ty@igalia.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit


On 02/11/26 10:16, Maíra Canal wrote:
> 
> On Sun, 01 Nov 2026 09:53:57 -0300, Maíra Canal wrote:
>> v3d_csd_job_timedout() decides whether a compute job made progress by
>> comparing CSD_CURRENT_CFG4, the number of batches the dispatcher still
>> has to start, against the value saved at the previous timeout. That
>> saved value is never initialized, so it is zero on the first timeout.
>>
>> On V3D 7.1.6 and later, CFG4 counts down to zero once the dispatcher has
>> started the last batch, but the dispatch keeps running until the batches
>> in flight complete. If the first timeout fires in that window, the
>> handler sees no change and resets the GPU while the job is about to
>> complete. For example, this happens with long dispatches that only keep a
>> single supergroup in flight.
>>
>> [...]
> 
> Applied to drm-misc-fixes, thanks!
> 
> [1/2] drm/v3d: Initialize timedout_batches when running a CSD job
>        commit: 0afdbdd5b1af729108de8f893d179c3b99eac29d
> 
> I'll apply the second patch to drm-misc-next after the back merge.

Applied to drm-misc-next, thanks!

Best regards,
- Maíra

