Received: from mail-wm1-f52.google.com (mail-wm1-f52.google.com [209.85.128.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D510338F935
	for <stable@vger.kernel.org>; Thu,  6 Aug 2026 14:51:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786027896; cv=none; b=X/kziV0oroEb55FLgHWz7nvtj6l3hsJkN3JJr6zZwIgzuEP60W9RQX8OjUDnEpsjYLoMUOjs8G02YKpjGzzjkRZ52nDdN1jtbu4WWQAxej3MnaG2AZpLKVYfmu6s1GlF+VQqXXfAlH2Ili6+xQipa0IblTFC3og+VK5GOC0iiuk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786027896; c=relaxed/simple;
	bh=Gm4zNo7nyEAnT3TTokUnwY/mnWxoTFTXubMv/mHPneo=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=XWqOB7Om9MEwJao77SMJ0ksB6sQuUTzVPnlJApRWDDS+kx+0053dk94pRykznPX4VsCxuaK8qViOUIHWEuHw91h2JvVmJbeaE3Je5/0BegqQXMxDtdNgI54MzMKxNgDARYbNSz3tlx9de1BBxVNzStcwyLREcAgrhTioL/59Jbw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=Yp3p2i7d; arc=none smtp.client-ip=209.85.128.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="Yp3p2i7d"
Received: by mail-wm1-f52.google.com with SMTP id 5b1f17b1804b1-4994c49f588so10944565e9.0
        for <stable@vger.kernel.org>; Thu, 06 Aug 2026 07:51:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1786027893; x=1786632693; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:content-language
         :references:cc:to:from:subject:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=GWpFkxMOaVwGZ0w80zyQ1pa/gmhP6MxYxEbTBlhIS5E=;
        b=Yp3p2i7dBZL59CsRLcTgTy5EYsDbPruGf31RT5WFWdJJX7B4qpfFcZy+NdaXqvy5Mo
         UDSTyaDyC0IoNiVaNNX2sRAPJ0UEL9GDZiRL3RfPdOhrTP5US3RSv6C/LI2NVIpo9OfX
         n2BLsy7qgZx5gpeW98IsQswHIXQ8Me+c7UtTC5lABPx3ldLUNfRw9Mb5W6o6Apwn/THO
         2Z763En6rY3i1+BD37ZglkHDdC/m86l0EwmKMUdjtWu1mmeTE635H5Jx1rNorZYrq/Xd
         xy4RNZ4g2LRMNmGtGhmZd4L/+e+hMeSGSBrZVbnT2TSPHkX//sAe7j2y7zw4upgqRUgK
         pHhg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786027893; x=1786632693;
        h=content-transfer-encoding:content-type:in-reply-to:content-language
         :references:cc:to:from:subject:user-agent:mime-version:date
         :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=GWpFkxMOaVwGZ0w80zyQ1pa/gmhP6MxYxEbTBlhIS5E=;
        b=GAiQc6z6MC9B/5b/UiCvU8K1uHREQ/ehnygqdrA91+vVRp4kGQ9/wcO7c89dMjAAC1
         5QX6wV2xmy3Br9cLQt/YkeTytniC5ODv48vCVdGjbtr4qi0sA7MS/7dQBjWhurAOy16z
         kXkGM7VMbnzntqkDfw2BxmrtlG2JgKvRsmJHPPH9ViMySRSJi+J/uQXmKP8Ze9WNGdgC
         mb1MvyAI/x4nsd1ZF5zrOZlZ2MHpJGcMYQ5lOBMOhy7mTyc+bQHpLXF8FmjROAbgdmU9
         Zon1G88iU0qSwE4Sv9WX7wHxnRfpavwW2Q3FG9DWQhCuBYllWgo1VRLrFCSqQS2gCXkm
         mTIQ==
X-Forwarded-Encrypted: i=1; AHgh+RpEj3JSKVGZyU5W3cYWkXCM5lNqJW0/0Co2zDCmPcGMIU8L2xAZzLkQXWn/QxgKI82Jcqnfs3c=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz/B5Ld4bXSwUn3ZxqNZEWdAO2rYeG/arHYfo+IxEWii6HYsq5Y
	nJht76i6hmfBRuZFC8dAaY4UQRBoKkJCq1YfEGLUw2O6uBu5Ssus91TsBKiw6Y8sfe8=
X-Gm-Gg: AR+sD13MjUPe1Ykp5GrLRVgALlGDxK/r8EA/I5vy54lfFaodKctOFdelIhpl1oAZYAh
	vIVIEnDX++GdGSpLHAnyMwvFwmzYvgHD6ijLjcDxvjCqmuDJlLkhtXmiNtm05cwYzZcDGfIux2P
	NVkZ5VcALw4roxBGzAOrv7GGDal0dqB/RkA4oZ/EwNJQJZmFOlCMBMytlbKfl/5e+kWc7lZhP1R
	t0IPtheAhl5EqiHKC0b1fU39zM9M2nkbIYweBKmBUXKi8dn/sCZZgRgABKFETq8yX5dFLg79BYu
	YAj/aidiXZsxLZ11GEYTcOs0mX/4joSEBKBxGhAM/Eh3+g/y2PwI+zoM+g2y2KEEdh5MBV8IxxD
	Hppcqut7RKwgTYdOjiKnlzvZZr6YFB7oEaRZoGqUy0kKBm7T4PVK8fISs/cYGMb6NUIWuYdItSE
	ATD5ZVaTC8p0t8BlTXJ6Yq4UCvnkpuwZkck1NJIkrufWp4tEiB3R9DFgkB1VOc4AV5aKqjSYy0q
	L3iPCZjLlarZ5KhGoxGwNLq7Q==
X-Received: by 2002:a05:600c:4fc5:b0:497:ff5a:38b9 with SMTP id 5b1f17b1804b1-499553f8440mr50043225e9.9.1786027892968;
        Thu, 06 Aug 2026 07:51:32 -0700 (PDT)
Received: from ?IPV6:2a07:de40:8100:0:fc6c:f9a2:4a0a:6354? ([2001:af0:8000:1409:193:86:92:181])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4995421b1e2sm85741405e9.8.2026.08.06.07.51.32
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 06 Aug 2026 07:51:32 -0700 (PDT)
Message-ID: <cbe5e31c-1bf3-4b25-b85e-dc98bf0263f5@suse.com>
Date: Thu, 6 Aug 2026 16:51:32 +0200
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] params: fix charp corruption on allocation failure
From: Petr Pavlu <petr.pavlu@suse.com>
To: Jiacheng Yu <yujiacheng3@huawei.com>
Cc: samitolvanen@google.com, rusty@rustcorp.com.au, hannes@cmpxchg.org,
 yosry@kernel.org, nphamcs@gmail.com, liuyongqiang13@huawei.com,
 linux-modules@vger.kernel.org, linux-mm@kvack.org,
 linux-kernel@vger.kernel.org, stable@vger.kernel.org
References: <ff0b7cdd-8fa7-4cb8-9e21-6a7204809766@suse.com>
 <20260729123243.790023-1-yujiacheng3@huawei.com>
 <b5d285a0-1e72-443e-aad0-dcac32d00d01@suse.com>
Content-Language: en-US
In-Reply-To: <b5d285a0-1e72-443e-aad0-dcac32d00d01@suse.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 7/31/26 4:21 PM, Petr Pavlu wrote:
> On 7/29/26 2:32 PM, Jiacheng Yu wrote:
>> param_set_charp() stores charp parameters in allocated memory after slab is
>> available, and releases the previous value when the parameter is updated.
>>
>> The previous value is released before the replacement allocation succeeds.
>> If kmalloc_parameter() fails, the setter returns -ENOMEM with the parameter
>> left as NULL.
>>
>> Failing zswap's compressor update before zswap is initialized can later
>> trigger:
>>
>>   BUG: kernel NULL pointer dereference, address: 0000000000000000
>>   RIP: 0010:strcmp+0x10/0x30
>>   Call Trace:
>>     zswap_setup+0x3b1/0x490
>>     zswap_enabled_param_set+0x5b/0xa0
>>     param_attr_store+0x93/0xe0
>>     module_attr_store+0x1c/0x30
>>     kernfs_fop_write_iter+0x116/0x1f0
>>
>> Allocate and copy the replacement first, then replace the parameter value
>> only after allocation succeeds.
>>
>> Fixes: e180a6b7759a ("param: fix charp parameters set via sysfs")
>> Cc: stable@vger.kernel.org
>> Signed-off-by: Jiacheng Yu <yujiacheng3@huawei.com>
> 
> Looks ok to me.
> 
> Reviewed-by: Petr Pavlu <petr.pavlu@suse.com>
> 
> I'll give others more time to comment. If there are no further concerns,
> I plan to take this on modules-fixes.

I've queued the fix on modules-next for v7.3-rc1.

-- 
Thanks,
Petr
