Received: from mail-lf1-f50.google.com (mail-lf1-f50.google.com [209.85.167.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AC7513C3432
	for <stable@vger.kernel.org>; Sat, 13 Jun 2026 12:27:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781353643; cv=none; b=ud93c1VzaSxKmBoGQZ4vF8jrwSJxC7A2Bc7OWWMe8FyMTMQmO5Vjtkv/B3lziSOaELau9c1RWjl+Ti6FsTS+c2cuzPhz89fm0d/fVREz7Bl3OvDLHyJ2BGgfPM532w8bIBqcX4uFw6bS508+4bxVKf0UbMP3EzGe97NtIKsjjOs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781353643; c=relaxed/simple;
	bh=5q6l40SW5GCFqUD5KFtgslh4wXLEHyDhKFKwFuZnP2I=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=LeVia0yhIo9a7lTi6wWnpPabSUp3m/yMMO4D5hFndKINqNpfoXonSSkRO5ueLliJot09ERzg2n1bAGKs8x3t6ygc99BjuQiPMAvIZluVDUp4Nky+1H0pZyTbu0J5n9hmXCYj/09mkwqHHUedkJr/gWORnYwwC8lP2ncfSED2nYE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=AFhFseIC; arc=none smtp.client-ip=209.85.167.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="AFhFseIC"
Received: by mail-lf1-f50.google.com with SMTP id 2adb3069b0e04-5aa9326af17so76839e87.0
        for <stable@vger.kernel.org>; Sat, 13 Jun 2026 05:27:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1781353639; x=1781958439; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to:subject
         :user-agent:mime-version:date:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Lf6/s9VnK2HpT2bt2UhBhYgE68skc15jixFZftcr760=;
        b=AFhFseICsV8LGQRiuZBjqhkhL8lI7K9QbseuXcfT8rNXitrkxDSnVeONkvYMPd2hLh
         b9ur2Z7AP5Sk8enHjEGL2hPeonu1oiaWcz/+N+GUlODA7BYKYM3yW/bGea1DkWTFV3tv
         8OL4oy6MxBPpi+CRQHFwSXOZDyA9+bllrqgDDo5JzQvvhHjrK9R4IQflOTfOzyf9Pq/i
         ftUVg38UybI7MigXRBPO0vMqRKm2h5SUtywFbQYyu4OzcSVyDo+A7yL1ZLM8SQBpdFwD
         rus9lPXDoUPz+BliY3X3MKkpIZDlhrPYIbd1jJwYXydo09R2Y67cn/oSBtCGqMZ50wIz
         K7yA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781353639; x=1781958439;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to:subject
         :user-agent:mime-version:date:message-id:x-gm-gg:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Lf6/s9VnK2HpT2bt2UhBhYgE68skc15jixFZftcr760=;
        b=DItbINt4c+KTFaWEMcSZ0itrB9U1EstRxzihZJxVm/j2oF1TVvnFWYnbv01dsDdFp9
         Dz2kdldUp4Sf0IrpGmMJ8E7ameFevhp1Qxof6sQl7Sqxw+fES0eIeUgcSYuEu+jmx8Ds
         Lpt+M53BL12KIlIL6X6LRCYwf28N0KAEOHNqPT7z+iMULo29D98qz5Bp4GLuieENobJV
         mABobAP76AaeOpMQzaGX42+GZq0o87HSMzwyKaZo9vqyPoEEjicsY5XeVp409zdMC0xU
         25MHtIMbqEOW5wQwzp3sJvQPcCWvHj3hamsqTGcHDvlZe34AUgDkI1rA7lH7gAn7XI0S
         77TA==
X-Forwarded-Encrypted: i=1; AFNElJ+55Yc/vdLv10woEbHBMxF6tA9yqgUYXVg9eks+N4kFTEaXkWSKlhA04/C0GhdYUuBBoCgvn20=@vger.kernel.org
X-Gm-Message-State: AOJu0YyXQMyYvpSPxuVjvqHCXw0BirSrXrL/do7l1kQDnpxVEChbpemK
	3iZDDz6KBB9fvb3cWKWZjIxUrZ7EHRjRI4LT9SvDpyuk+TL9CdN7HRxEZ45ZEJxSKg99kql3mzW
	LXNO6Zik=
X-Gm-Gg: Acq92OHIcivw86IhJYVcx5rT/t724jZPyX1CE2rbWZbCMxszwPrtXXO3C9z04FxxfVm
	lbIBtMH3DJibhzMp8NUllB58VTIZzS7Zd0JIr8lP2xTICvpk3tS6PvwGrSxttzfcRMwW7y0/vlv
	qfZV4GnNRWzsJP9w/dVbSJOT+lFMeIn98JjPqu/tqbKzIDgbGujn/+uiD4D9QxDF17lc7tCVcbj
	xOnOh2bG/EMxmnGVMp+4o8jXF2v3bpuSEard86QFfW8CZ3nt3Hl9g6tWgtWCN3puLS0PqQu2HWS
	0Qss/GwhtXE1c1Lv5eQ6383cHYSfgX6f2ZqIf3usQ1x3VsX87yAzA7Aw6i4AC8J5FArf4KCYLlr
	KssTL19RoMUhd3vZ7U5kG/k/bIaH/zSA+kgc76VuCqf5QqR2K9OltWOZPHCN3DmYktldYHsF57N
	TmPARYOJXW+ClbQOMVDZ5OiA/XEGSwvFnCnFopC3BUXBtAS1YOPn6wAjNs4Pt6LS2RlLHhVQqYX
	lRFGA==
X-Received: by 2002:a05:6512:3994:b0:5aa:628b:5890 with SMTP id 2adb3069b0e04-5ad2db3a233mr780108e87.2.1781353638649;
        Sat, 13 Jun 2026 05:27:18 -0700 (PDT)
Received: from [192.168.1.100] (91-159-24-186.elisa-laajakaista.fi. [91.159.24.186])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-5ad2e1ae1f2sm1237452e87.61.2026.06.13.05.27.17
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 13 Jun 2026 05:27:17 -0700 (PDT)
Message-ID: <dae9b1b5-5d3d-4201-b23d-5d02fb43547e@linaro.org>
Date: Sat, 13 Jun 2026 15:27:16 +0300
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] media: i2c: ov02a10: fix endpoint parsing
 use-after-free and error leak
To: Biren Pandya <birenpandya@gmail.com>, linux-media@vger.kernel.org
Cc: sakari.ailus@linux.intel.com, mchehab@kernel.org,
 dongchun.zhu@mediatek.com, stable@vger.kernel.org
References: <20260613112920.64617-1-birenpandya@gmail.com>
From: Vladimir Zapolskiy <vladimir.zapolskiy@linaro.org>
In-Reply-To: <20260613112920.64617-1-birenpandya@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 6/13/26 14:29, Biren Pandya wrote:
> The ov02a10_check_hwcfg() function calls fwnode_handle_put(ep)
> immediately after allocating and parsing the endpoint. However, it
> subsequently calls fwnode_property_read_u32() using the same 'ep'
> handle, leading to a potential use-after-free.
> 
> Additionally, reading the optional 'ovti,mipi-clock-voltage' property
> used to overwrite the 'ret' variable. If the property was missing,
> 'ret' would become negative, and this failure code would be incorrectly
> returned at the end of the function, causing probe to fail entirely.
> 
> Fix the use-after-free by moving fwnode_handle_put(ep) to the end of
> the endpoint property reading block, and adding it to the error path of
> v4l2_fwnode_endpoint_alloc_parse().
> 
> Fix the error leak by avoiding assigning the result of
> fwnode_property_read_u32() to 'ret'.
> 
> Fixes: 91807efbe8ec ("media: i2c: add OV02A10 image sensor driver")
> Cc: stable@vger.kernel.org
> 
> Signed-off-by: Biren Pandya <birenpandya@gmail.com>

Reviewed-by: Vladimir Zapolskiy <vladimir.zapolskiy@linaro.org>

-- 
Best wishes,
Vladimir
