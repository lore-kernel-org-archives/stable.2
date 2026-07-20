Received: from fanzine2.igalia.com (fanzine2.igalia.com [213.97.179.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 974F73E0730
	for <stable@vger.kernel.org>; Mon, 20 Jul 2026 10:51:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.97.179.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784544686; cv=none; b=RAJ2LxLZX+mFoTXLgbJ0SvGGI23U0MYDYXbFr8Uw6TKJ0Nch6r1sXHwaBPqc/cR4Z8gQWPa68K9PgzF3j0fFQy3NBCRry+51pEIjYLG/Z6oQ+VxeDqkSmnQHCVkXNBWIczn6jWibT9nC/7lxJzPS9HkyutgK45sgGHWg/bS/FP8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784544686; c=relaxed/simple;
	bh=leEbpYuwhyT10yXsjsjvXBLVjDBk66ZGyLbR/8EVFA8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=YNFa5GiMxk+g9ZBjEpEvGHbV8uR01QTDrp2XRn7FTBcY+xvExyAC1QbFBoqnmW5xhjA6XKKZ+vd0tKsoUoOBRWFzg8ofu66SdWE+/rQ0E1zHvEPOMBa9qTlORBrikX9d7EkaGXQlqYLO/XjeKzgFDd3L0m8b8PEeJ6eT3rIslhk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=igalia.com; spf=pass smtp.mailfrom=igalia.com; dkim=pass (2048-bit key) header.d=igalia.com header.i=@igalia.com header.b=pX19tnTS; arc=none smtp.client-ip=213.97.179.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=igalia.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=igalia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=igalia.com header.i=@igalia.com header.b="pX19tnTS"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com;
	s=20170329; h=Content-Transfer-Encoding:Content-Type:From:Cc:To:Subject:
	MIME-Version:Date:Message-ID:From:Reply-To;
	bh=KJKAyQcsco6SBzscz84riJCl4l2UDg9GwNoMz1ewLeU=; b=pX19tnTSpwXH5LBEo+Bv8r51MV
	nlQmozX6Td2Ukd2lUZLgAII/Lt51P0Aa4CcuQHEQ8YRAE4Bh8/xuw148t1pJJxR+z1qOl0zM8iBYG
	waqPIL/bRXF17QqLLScwmLf1xk27V18JnbGHrcwC9VhcLmQsCy9V76hI55f7tK6E5rptgBW8MmaRS
	JK2+M8VQd/Lq+DUI+Y2UB9swMfyRjtvkFuhqLMAvArScXjsP4nnaZmrzzvmFcMWqHgdm3tILtNhFl
	d7T3J1gFooHFmmXcmM85Nlg+37ym+zizDvS57Bomsnc2PXuFKcCXrl28euF1nZ8PQsAqKSCXcmHkU
	EmYak6vw==;
Received: from [189.7.87.67] (helo=[192.168.0.2])
	by fanzine2.igalia.com with esmtpsa 
	(Cipher TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_128_GCM:128) (Exim)
	id 1wllaT-000yYM-Vy; Mon, 20 Jul 2026 12:51:06 +0200
Message-ID: <4a933063-14da-4164-9422-3b110ddad675@igalia.com>
Date: Mon, 20 Jul 2026 07:51:00 -0300
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/2] drm/v3d: Idle AXI transactions before disabling the
 clock on suspend
To: Iago Toral <itoral@igalia.com>, Melissa Wen <mwen@igalia.com>,
 Florian Fainelli <florian.fainelli@broadcom.com>
Cc: kernel-dev@igalia.com, dri-devel@lists.freedesktop.org,
 stable@vger.kernel.org
References: <20260718-v3d-pm-axi-transactions-v1-0-4ecd7729ed70@igalia.com>
 <20260718-v3d-pm-axi-transactions-v1-2-4ecd7729ed70@igalia.com>
 <c4b5bfd3a5fe8d4ee1d283b77db3530158bb3a17.camel@igalia.com>
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
In-Reply-To: <c4b5bfd3a5fe8d4ee1d283b77db3530158bb3a17.camel@igalia.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Hi Iago,

On 20/07/26 04:38, Iago Toral wrote:
> Hi Maíra,
> 
> I question below:
> 
> (...)
> 
> El sáb, 18-07-2026 a las 10:44 -0300, Maíra Canal escribió:
>> diff --git a/drivers/gpu/drm/v3d/v3d_power.c
>> b/drivers/gpu/drm/v3d/v3d_power.c
>> index ade8e932fb9c..f608e6d5516a 100644
>> --- a/drivers/gpu/drm/v3d/v3d_power.c
>> +++ b/drivers/gpu/drm/v3d/v3d_power.c
>> @@ -56,8 +56,15 @@ int v3d_power_suspend(struct device *dev)
>>   
>>   	v3d_clean_caches(v3d);
>>   
>> +	/* Wait until V3D has no active or pending AXI transactions.
>> */
>> +	v3d_idle_axi(v3d, 0);
>> +	v3d_idle_gca(v3d);
> 
> Don't we need to do anything on the resume path for these?

The documentation states that we don't need to re-enable the AXI
transactions after a V3D reset/shutdown.

Best regards,
- Maíra

> 
> Iago
> 
>> +
>>   	ret = v3d_suspend_sms(v3d);
>>   	if (ret) {
>> +		/* Staying active: undo the GMP STOP_REQ from
>> v3d_idle_axi(). */
>> +		V3D_WRITE(V3D_GMP_CFG(v3d->ver),
>> +			  V3D_READ(V3D_GMP_CFG(v3d->ver)) &
>> ~V3D_GMP_CFG_STOP_REQ);
>>   		v3d_irq_enable(v3d);
>>   		return ret;
>>   	}
>>
> 

