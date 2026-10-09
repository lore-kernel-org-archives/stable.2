Received: from mail.loongson.cn (mail.loongson.cn [114.242.206.163])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4B6C649D587;
	Fri,  9 Oct 2026 09:37:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=114.242.206.163
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791538661; cv=none; b=Ye7kLCwcYuqfCXlmGGWXtkHYtpdh2XL3FEchGGkRtzGi0MeNZvXugNmA8FKW+TMYY/22bosaa0AV2zX/A4Buwi7uHQThVGuLNDbqNvTP3BAJ2YuWaAhm5PRelXlUN2GoKcq/37ENnkvzqObKRitOmC6+ogW530JIqP6+fGyb6aA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791538661; c=relaxed/simple;
	bh=6UzabKbW7/W4ItnNK/pguJFy0TBdcBXWtlkqalkBenU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=V/LIIdy5NjvaomKziTBk0G6cdhwXRn8pfu4w+gX/dxLlwUj67Rf0gmKqIl8gwYE72WGkI01TfjETTqmu6FWNVxXoVHtd52kwavVj52UUlbMS9ANBgEpoc3H7rbaDepQ/CU3bC02vB/hC7PbqmVjCAJP9F70EB1I33FzrhD9PdWw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=loongson.cn; spf=pass smtp.mailfrom=loongson.cn; arc=none smtp.client-ip=114.242.206.163
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=loongson.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=loongson.cn
Received: from loongson.cn (unknown [10.20.42.172])
	by gateway (Coremail) with SMTP id _____8BxhvDTtchq0BYUAA--.58299S3;
	Fri, 09 Oct 2026 17:37:23 +0800 (CST)
Received: from [10.20.42.172] (unknown [10.20.42.172])
	by front1 (Coremail) with SMTP id qMiowJDxg8zTtchqAWkqAA--.61825S2;
	Fri, 09 Oct 2026 17:37:23 +0800 (CST)
Message-ID: <be30e2f2-e126-4be5-910f-75d068526c87@loongson.cn>
Date: Fri, 9 Oct 2026 17:37:28 +0800
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/2] drm/loongson: Fix double free on BO initialization
 failure
To: Icenowy Zheng <zhengxingda@iscas.ac.cn>, Evanshenf <archwse@gmail.com>,
 dri-devel@lists.freedesktop.org
Cc: Jianmin Lv <lvjianmin@loongson.cn>, Huacai Chen <chenhuacai@kernel.org>,
 Mingcong Bai <jeffbai@aosc.io>, Xi Ruoyao <xry111@xry111.site>,
 stable@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20261003093415.e64386de1e64-1-archwse@gmail.com>
 <dce8506787ff72b5a9fac15571d4c59624348430.camel@iscas.ac.cn>
Content-Language: en-US
From: wuqianhai <wuqianhai@loongson.cn>
In-Reply-To: <dce8506787ff72b5a9fac15571d4c59624348430.camel@iscas.ac.cn>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:qMiowJDxg8zTtchqAWkqAA--.61825S2
X-CM-SenderInfo: 5zxtxtpqkdxqxorr0wxvrqhubq/
X-Coremail-Antispam: 1Uk129KBj93XoW7ZFWUXw4rGr13JF47Zr1xtFc_yoW5JrW3pa
	n3Ga4jyrWDJFs2kr9Fy3WrAa40kayxWrWkWF45G3Wfur1jyw1kJFy3u3s0gFnrXFy7Cr12
	qanxG3ZxXF1qv3XCm3ZEXasCq-sJn29KB7ZKAUJUUUUr529EdanIXcx71UUUUU7KY7ZEXa
	sCq-sGcSsGvfJ3Ic02F40EFcxC0VAKzVAqx4xG6I80ebIjqfuFe4nvWSU5nxnvy29KBjDU
	0xBIdaVrnRJUUUvEb4IE77IF4wAFF20E14v26r1j6r4UM7CY07I20VC2zVCF04k26cxKx2
	IYs7xG6rWj6s0DM7CIcVAFz4kK6r1Y6r17M28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48v
	e4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Jr0_JF4l84ACjcxK6xIIjxv20xvEc7CjxVAFwI
	0_Jr0_Gr1l84ACjcxK6I8E87Iv67AKxVW8Jr0_Cr1UM28EF7xvwVC2z280aVCY1x0267AK
	xVW8Jr0_Cr1UM2kKe7AKxVWUXVWUAwAS0I0E0xvYzxvE52x082IY62kv0487Mc804VCY07
	AIYIkI8VC2zVCFFI0UMc02F40EFcxC0VAKzVAqx4xG6I80ewAv7VC0I7IYx2IY67AKxVWU
	XVWUAwAv7VC2z280aVAFwI0_Jr0_Gr1lOx8S6xCaFVCjc4AY6r1j6r4UM4x0Y48IcVAKI4
	8JMxAIw28IcxkI7VAKI48JMxC20s026xCaFVCjc4AY6r1j6r4UMxCIbckI1I0E14v26r1Y
	6r17MI8I3I0E5I8CrVAFwI0_Jr0_Jr4lx2IqxVCjr7xvwVAFwI0_JrI_JrWlx4CE17CEb7
	AF67AKxVWUtVW8ZwCIc40Y0x0EwIxGrwCI42IY6xIIjxv20xvE14v26r1j6r1xMIIF0xvE
	2Ix0cI8IcVCY1x0267AKxVWUJVW8JwCI42IY6xAIw20EY4v20xvaj40_Jr0_JF4lIxAIcV
	C2z280aVAFwI0_Jr0_Gr1lIxAIcVC2z280aVCY1x0267AKxVWUJVW8JbIYCTnIWIevJa73
	UjIFyTuYvjxU2MKZDUUUU


Reviewed-by: Qianhai Wu <wuqianhai@loongson.cn>

The fix looks correct and the TTM ownership analysis is accurate.

Thanks,
Qianhai Wu

在 2026/10/9 16:42, Icenowy Zheng 写道:
> 在 2026-10-03六的 09:34 +0000，Evanshenf写道：
>> If ttm_bo_init_validate() fails, it drops the buffer object's
>> reference
>> and cleans it up through the supplied destroy callback.
>> lsdc_bo_destroy()
>> releases the GEM object and frees the enclosing lsdc_bo, so freeing
>> it
>> again in lsdc_bo_create() causes a double free on a synchronous
>> failure
>> path.
>>
>> Let TTM own the cleanup after initialization has started and return
>> the
>> error directly. Keep the explicit free on drm_gem_object_init()
>> failure,
>> which occurs before ownership is passed to TTM.
>>
>> Tested on LS7A2000 by making drm_vma_offset_add() return -ENOSPC for
>> one
>> selected dumb-buffer creation. The error reached userspace, the
>> destroy
>> callback ran once, and no handle was published or tracked BO
>> retained.
>> Normal buffer creation, zeroing, mapping, readback and release
>> passed.
>>
>> AI assistance was used for the ownership analysis, fix, fault-
>> injection
>> tools, build and test execution.
>>
>> Fixes: f39db26c5428 ("drm: Add kms driver for loongson display
>> controller")
>> Cc: stable@vger.kernel.org
>> Assisted-by: LLM
>> Signed-off-by: Evanshenf <archwse@gmail.com>
>> ---
>>   drivers/gpu/drm/loongson/lsdc_ttm.c | 4 +---
>>   1 file changed, 1 insertion(+), 3 deletions(-)
>>
>> diff --git a/drivers/gpu/drm/loongson/lsdc_ttm.c
>> b/drivers/gpu/drm/loongson/lsdc_ttm.c
>> index d7441d9..88536e2 100644
>> --- a/drivers/gpu/drm/loongson/lsdc_ttm.c
>> +++ b/drivers/gpu/drm/loongson/lsdc_ttm.c
>> @@ -475,10 +475,8 @@ struct lsdc_bo *lsdc_bo_create(struct drm_device
>> *ddev,
>>   
>>   	ret = ttm_bo_init_validate(bdev, tbo, bo_type, &lbo-
>>> placement, 0,
>>   				   false, sg, resv,
>> lsdc_bo_destroy);
>> -	if (ret) {
>> -		kfree(lbo);
>> +	if (ret)
>>   		return ERR_PTR(ret);
> 
> It looks like this fix is valid, ttm_bo_init_reserved() (called by
> ttm_bo_init_validate() ) will do a ttm_bo_put() operation when failure,
> which leads to calling the destroy callback.
> 
> ```
> Reviewed-by: Icenowy Zheng <zhengxingda@iscas.ac.cn>
> ```
> 
> Thanks,
> Icenowy
> 
>> -	}
>>   
>>   	return lbo;
>>   }
>>
>> base-commit: bca45af5998a05f34b13a2ef11e639bac9c62643

