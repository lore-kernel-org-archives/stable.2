Received: from mail-wm1-f44.google.com (mail-wm1-f44.google.com [209.85.128.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A4F8A34A3BF
	for <stable@vger.kernel.org>; Tue, 11 Aug 2026 10:42:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786444944; cv=none; b=VUQO9QX+oOEoI5yBtALM1eEpHS6G6+5FS8tlY3g6s9lGufzHkTRPdCEB7xAUA7T1HqClTk9btoBAgip7UcFoERhr2kUXU3e/1sqRLoF+GO2gtN5IuOL5/rjkTowoS/RLIHOKAveFQwj4O1/Ul7Y+Zy7mO2yhIk9R5cypS+4mNPA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786444944; c=relaxed/simple;
	bh=9DWwyp1KRArEjU+uq1Qkw7+RtV8sKm9Jirs8RjgfOuM=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=o2W88NnkoZ48VVrWyMMXDIqqKOaHTRbLo+zNd6vmBXyFGTHXe9t9PaF96inSG7e8/0wT2ZeVIpTxt21hi8zFIbj4AgkZ9ajkdXiq+ER3M5ATkb15eCI8KAwOySTArjhKzcFWLX1sz23eZz+H93Cyolag/aqY+gITOL+UVUfIsOs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=JbYAdc17; arc=none smtp.client-ip=209.85.128.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="JbYAdc17"
Received: by mail-wm1-f44.google.com with SMTP id 5b1f17b1804b1-4954a2e73a9so17644565e9.3
        for <stable@vger.kernel.org>; Tue, 11 Aug 2026 03:42:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1786444941; x=1787049741; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:content-language
         :references:cc:to:from:subject:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=FOccx3o7YzspIOPN4VOMh1mmGB1X25Vq6yEwYlGFjto=;
        b=JbYAdc1725Squ0YBQLUBaIlhUtifEtQYD3uRDi7rnwo6zGZg1hT4zJ4Fecc+T0C6tO
         kn4A+JgbMPNQ4I5hGD8j8b2WYLLulmom8B+u2biH3E4ntg8vCVXRQt1MKk30cUb/Z3SW
         YIl9OcpBnA6JNqekiW1dnI7gvBDxKvwi35Pp4V5g/T2EL2GYzWJv9QeRoCvibEuPIVjs
         gKAuOcUKUJOzThG4F4ls0gr5q8VcjCiuZEtXlJblkt1nfz1xt1LG4deghg94KcI24zSF
         o7DYqEenGeA8J3NBDLYzR4kKMyU/FXpa+yi6/VJevXhYqm6PPRvfZ8Mpz87WL90/d8KS
         7JlA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786444941; x=1787049741;
        h=content-transfer-encoding:content-type:in-reply-to:content-language
         :references:cc:to:from:subject:user-agent:mime-version:date
         :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=FOccx3o7YzspIOPN4VOMh1mmGB1X25Vq6yEwYlGFjto=;
        b=Cc9hJvEK1WMcrYkAtwOV4kxf437YrCWK0dsNIvVebKIVeB1+2Qdwi7IC4Ky83Ny5ua
         CPlL2ytA8CKFza7kncADBhGRnYvpqRMZQ0+0CsmvDy4Y59RuFjbJFD6Jk7uHLVkVbxPb
         mJYPBmItlan/cz7RPQj8FdTLZIoS0FzgGdqJPTkBmM7jsfRDHibtzDLrOz13/XuWVjfd
         T14GwPcygpeVJuI+gwr58RuTWjsitzGrm5N2A4Gc4tTMMEFGN/+OEYxpali6mTOBtW4g
         xkVqcS2sKf9LnS2CsHrqp50WpXlDTb6wUYSPaGE/NNIrPvrSW+FW7IjHH+gLzC+fOzSd
         xx+w==
X-Forwarded-Encrypted: i=1; AHgh+RpBc24r+jo/bzAePYsRUJQb23YyLEIx+FntyPp3rE16JwNsIfof8ufuYvqc6nuDCDdfvPE2r+o=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy6sG6spTndvZ9R+84McIHDR1Amvac9NPVwC2dlggYxKd8PTPGj
	R6iT2dJeMngsRD3629bzrgp3Q++eRlsG1jonpYgs/6SFWqpBT3mRCLfGXb16UcO0tzI=
X-Gm-Gg: AR+sD13RlBMDOj1Tlpf3qi0+oUSLXSKzBQYt8fDKaNQRQEIis2+R6M5MdOQoSKeWxvL
	0tjDJI4/wfL6kandIamCx9YvtKnQe7j/gC5qo+CB4n6K+jr1nCQ1MIMYOHIQ5RfEc0GwcES72Ug
	s/LN3o5l4DfA8sfLl7Hz9xrpzVQ4QNXdBhsF07a0JDLPf291HcOo0FzC0+f0YFro2HWt6WS3J2V
	7a52MQGVjsaZEkogWdkivhGsrv8cU6T8gZ0U3E8LmBsFhqISs2NeKjQSUOFGVLI5WXpRzRcLAsE
	3E1C1tDisTwUehq5wBw3CTz3fAB7mmpH9wXm8N9XmfXvMllcIuJCl+YuxrPC02NUGUVGAjR2qhQ
	CW31C/AeSqxy4stH8h5PNfximVh5ZBVm10lTVVD0EECFFbeYAl4QiJZdatJArVM63c0ze+r9po4
	NhVe9mszNqzpm5Hk0HFh2K+TSP6jxKmgVW0rWy/4kj6cg3btpyJ4bJcg38fU8qQq0WwyNcvxc=
X-Received: by 2002:a05:600c:4753:b0:498:943:ccc0 with SMTP id 5b1f17b1804b1-49978437740mr26481275e9.6.1786444940360;
        Tue, 11 Aug 2026 03:42:20 -0700 (PDT)
Received: from [192.168.0.252] ([79.115.156.91])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-49977e57785sm37389935e9.2.2026.08.11.03.42.19
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 11 Aug 2026 03:42:19 -0700 (PDT)
Message-ID: <56991b48-cbe9-45bf-a24c-d7aa771c55d2@linaro.org>
Date: Tue, 11 Aug 2026 13:42:17 +0300
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3] mtd: spi-nor: use guard() in
 spi_nor_rww_start_exclusive
From: Tudor Ambarus <tudor.ambarus@linaro.org>
To: Runyu Xiao <runyu.xiao@seu.edu.cn>,
 Miquel Raynal <miquel.raynal@bootlin.com>
Cc: Pratyush Yadav <pratyush@kernel.org>, Michael Walle <mwalle@kernel.org>,
 Miquel Raynal <miquel.raynal@bootlin.com>,
 Richard Weinberger <richard@nod.at>, Vignesh Raghavendra <vigneshr@ti.com>,
 linux-mtd@lists.infradead.org, linux-kernel@vger.kernel.org,
 stable@vger.kernel.org, jianhao.xu@seu.edu.cn
References: <20260811041349.333176-1-runyu.xiao@seu.edu.cn>
 <20260811083111.403453-1-runyu.xiao@seu.edu.cn>
 <0ff8afdc-7a11-4a6c-9f62-6f8ba712c4ac@linaro.org>
Content-Language: en-US
In-Reply-To: <0ff8afdc-7a11-4a6c-9f62-6f8ba712c4ac@linaro.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi, Runyu, Miquel,

On 8/11/26 1:11 PM, Tudor Ambarus wrote:
> 
> 
> On 8/11/26 11:31 AM, Runyu Xiao wrote:
>> Commit 03e7bb864d9a ("mtd: spi-nor: use scope-based mutex cleanup
>> helpers") converted the RWW start helpers to scoped mutex cleanup, but
>> left spi_nor_rww_start_exclusive() using a plain mutex_lock().
>>
>> spi_nor_rww_start_exclusive() is used as a wait_event_killable()
>> condition. When it returns false on the busy path, the raw mutex_lock()
>> leaves nor->lock held and blocks the operation that must clear the RWW
>> state in spi_nor_rww_end_exclusive().
>>
>> Use guard(mutex) here as well so this helper matches the other RWW
>> start helpers and releases nor->lock on the false return path.
>>
>> Fixes: 03e7bb864d9a ("mtd: spi-nor: use scope-based mutex cleanup helpers")
> 
> The fixes tag is wrong. The blamed commit did not change the functionality
> of the code, while yours does.
> 
> You shall instead blame the commit that failed to release the lock in the
> first place. But then if you want to have this backported to stable kernels
> you may want to add 03e7bb864d9a ("mtd: spi-nor: use scope-based mutex
> cleanup helpers") as a prerequisite patch, as it includes <linux/cleanup.h>.
> 

Runyu, please also update the commit subject, the point of the patch is
that it fixes a mutex leak, thus I suggest to reword it with something like
"mtd: spi-nor: core: Fix mutex leak in spi_nor_rww_start_exclusive()"

>> Cc: stable@vger.kernel.org
>> Signed-off-by: Runyu Xiao <runyu.xiao@seu.edu.cn>
>> ---
>> Changes in v3:
>> - Reframe the changelog around the scoped-helper conversion that missed
>>   spi_nor_rww_start_exclusive().
>>
>> Changes in v2:
>> - Replace the analysis-style explanation with a short maintainer-facing
>>   description of the busy-path lock hold.
>> - Keep the fix focused on using guard(mutex) so the mutex is released on
>>   both paths.
>>
>> drivers/mtd/spi-nor/core.c | 2 +-
>> 1 file changed, 1 insertion(+), 1 deletion(-)
>>
>> diff --git a/drivers/mtd/spi-nor/core.c b/drivers/mtd/spi-nor/core.c
>> index ccf4396cdcd0..8bc117b46e02 100644
>> --- a/drivers/mtd/spi-nor/core.c
>> +++ b/drivers/mtd/spi-nor/core.c
>> @@ -1310,7 +1310,7 @@ static bool spi_nor_rww_start_exclusive(struct spi_nor *nor)
>>  {
>>  	struct spi_nor_rww *rww = &nor->rww;
>>  
>> -	mutex_lock(&nor->lock);
>> +	guard(mutex)(&nor->lock);
>>  

Miquel,

Have you seen sashiko's review at 
https://sashiko.dev/#/patchset/20260811083111.403453-1-runyu.xiao%40seu.edu.cn?

Both concerns look valid to me. Do you think you can allocate time to fix them?

Cheers,
ta

>>  	if (rww->ongoing_io || rww->ongoing_rd || rww->ongoing_pe)
>>  		return false;
> 

