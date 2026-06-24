Received: from mail-ot1-f51.google.com (mail-ot1-f51.google.com [209.85.210.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8A3173672BD
	for <stable@vger.kernel.org>; Wed, 24 Jun 2026 13:30:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782307818; cv=none; b=fbYxUEJgz/OnefsemWFy+fAXiTKm/P9u1SVqJO5jytGU9bPeA21XeYjDgMAKHotnng4kIsmx+O+fQpXkl13zxVlbVr5jmM42wtKyvHXUvIKGuKwDlcVaFc/7VtGCfesajmXNec5Pid7ke5ooFP1lewILpVtGTYzVBaFo/pqxhEM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782307818; c=relaxed/simple;
	bh=x5J///5NPUcpX55tKsjGNahFZmgb6VfI1DKrdJb5DwA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=MnJNuA//dsgnmlbiDh9//oqZbbJMvHabvge3QHVXO5U6cyq4TSFs0/kDuNMaf/1tuHMNUSHSKPuoHpB/ho9bOF2PITNyiwqsJfdtqwIRrK218eMUcrr3CHiO8czZQNytzVW0MZ1abofL1VSHlTK0JK9tiQmJY9hwwrl2TTLp3Hc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=IoCBCgC8; arc=none smtp.client-ip=209.85.210.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="IoCBCgC8"
Received: by mail-ot1-f51.google.com with SMTP id 46e09a7af769-7e9797ec365so843064a34.2
        for <stable@vger.kernel.org>; Wed, 24 Jun 2026 06:30:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1782307816; x=1782912616; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=nJMUfV0d4iL8GIoizfgvCU8470KRE9mKLUPI4sCYS14=;
        b=IoCBCgC8J/FaPjb3ZmV3dvAWFh1cGzYjQ+5K8fgyXGPNVIljDt6xT4UXEu4+cv4y/9
         DeBVwlxZMztbZL4E+e13jCkSA1IZTaJmMlCdmMHIRMpitSDY/lmLpjEtM3pF4oYITJzZ
         ABhpQmn/IAY2FgjuGE4XKCnw6sWQHVDo5MxS8IzRQHKkSSz8uBS5yLefqJwtHwUux26C
         P3Ke24y4GxblSfUQZFm53iFlm3yjnOAfAteDRVGBx0giT4F4S1zC/dqaau9JlXXI6LYk
         zN4/31Aev4CLe61zMLdaOGkSlRBQfuSa9poB6r2voQYH2Nfl3Lct6O6yPa2DwYhgDkwR
         VEpA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782307816; x=1782912616;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=nJMUfV0d4iL8GIoizfgvCU8470KRE9mKLUPI4sCYS14=;
        b=dRAfzqVJCfOa6vulMiXBpUmLDE/2YU/pYSvbhlBdGr5VX972bIMj21unlQZLGbJAGr
         b3o4LGpjdBJ3bqOXeTXbnbV0hHjobLXFEWRXWJQYeIhNXceOQzB19oH5bkts3ZJF8Bwk
         BakZeu9qKRUB54sOEuPuctWGNyO18iv7GreNi1tDeGP4qwmAnG0bRo3VYB+9vw9ohfxO
         WwwfNll8uKye7LI4wjTmHapkP5i2D1mwpzvoWA3lo9AAkVFGPyYQuop1EYsYDdWgAYwP
         dJEBa5rQ3ObwUWFLwOCpxEVqdW7VkJbYBrJfTyv6H2IQ26/TKWPtLPjAvb0Nx58iFxOh
         HyxQ==
X-Forwarded-Encrypted: i=1; AFNElJ+aVbVmT0xTLfTRGY/IFmu+mQQ1Uer6sMcuVpEabycFnLmJWRYNKmOtxKnzIuIZ39EEPvI6siM=@vger.kernel.org
X-Gm-Message-State: AOJu0YyFsPBvB3r3vaGPc34tVr6LDhaFl0u8nH+9St5NilnkQBsNgi8G
	4mp5eeX92jMom4zA2sl9aEQ8Xe4l81f/AOOcw68EecfQVQ1EdwzaXD2t
X-Gm-Gg: AfdE7cl7UsSTR0vzIOg51IIMp3zu+qAeZUKAwA6qlTbbIpI+q9XOH5LzGKeOSgl/4LT
	ocrw2Jt65tcdI74JesUSvZtBbdbIT2x6gKCYAxKXUTIiKX81UjeouEXUZfQMjzvIhwiDr8re90T
	9B+aCERMkUl8URYYbFQEkYK+CnFimWl8zvaMM8Nh/WD/R8xNCU3xBtI5cXGQko7GvfAOdvtUGzI
	ZsB0hQjYjovUqLyhemAvk1KmhI6ndKbZCShPFPaRSJtCoX1HTUN+RxiVQUrHw9+vGSXFJwOuF7J
	j9Us0ICZP9noy79Ov90x8Z/NFZZ2u87QzA68uVuohhcqVWiDyG872Uoy+0s4i0jJQDiCqPoY2fh
	55lA6H+sLHVHfj6OPYdDbNYyTiiWjSEJPzsh7Q7Tgh+/npBaDO1QrYSiz5nUpwIUjltS3A9EKnD
	G/vrD/N7p66Aj2W6GykrkWLDFRwSEQEqa+
X-Received: by 2002:a05:6830:2a0d:b0:7e7:62f:727e with SMTP id 46e09a7af769-7e986cc0cb8mr2435079a34.22.1782307816330;
        Wed, 24 Jun 2026 06:30:16 -0700 (PDT)
Received: from [100.125.248.95] ([124.70.231.46])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-7e944008fe7sm11846550a34.6.2026.06.24.06.30.01
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 24 Jun 2026 06:30:15 -0700 (PDT)
Message-ID: <7471b9cb-158a-4ed4-a1ce-95270ef38974@gmail.com>
Date: Wed, 24 Jun 2026 21:29:58 +0800
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] ext4: cancel dirty accounting for folios without buffers
To: Jan Kara <jack@suse.cz>, Zhu Jia <zhujia.zj@bytedance.com>
Cc: Zhang Yi <yi.zhang@huaweicloud.com>, tytso@mit.edu,
 adilger.kernel@dilger.ca, libaokun@linux.alibaba.com, ojaswin@linux.ibm.com,
 ritesh.list@gmail.com, linux-ext4@vger.kernel.org,
 linux-kernel@vger.kernel.org, stable@vger.kernel.org
References: <20260623094947.7853-1-zhujia.zj@bytedance.com>
 <81ed36cc-b5c8-41cf-8b7d-16611e61e294@huaweicloud.com>
 <20260624094535.1-zhujia.zj@bytedance.com>
 <x3jm3mhgsr7zx4hvfgdvmwoqyz5vxx2fjyxy6gs6him46767f6@dkkirnw54x6x>
Content-Language: en-US
From: Zhang Yi <yizhang089@gmail.com>
In-Reply-To: <x3jm3mhgsr7zx4hvfgdvmwoqyz5vxx2fjyxy6gs6him46767f6@dkkirnw54x6x>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 6/24/2026 8:32 PM, Jan Kara wrote:
> On Wed 24-06-26 17:52:06, Zhu Jia wrote:
>> Hi Yi,
>>
>> Thanks for taking a look.
>>
>> Yes, clearing PAGECACHE_TAG_DIRTY/TOWRITE would make the page-cache state
>> cleaner. I had a version that did this by adding a helper around
>> folio_cancel_dirty() and clearing the xarray tags after confirming the
>> folio was still the same clean page-cache entry.
>>
>> It looked like this:
>>
>> static void ext4_cancel_dirty_folio(struct address_space *mapping,
>> 				    struct folio *folio)
>> {
>> 	XA_STATE(xas, &mapping->i_pages, folio->index);
>> 	unsigned long flags;
>>
>> 	folio_cancel_dirty(folio);
>>
>> 	xas_lock_irqsave(&xas, flags);
>> 	if (xas_load(&xas) == folio && !folio_test_dirty(folio)) {
>> 		xas_clear_mark(&xas, PAGECACHE_TAG_DIRTY);
>> 		xas_clear_mark(&xas, PAGECACHE_TAG_TOWRITE);
>> 	}
>> 	xas_unlock_irqrestore(&xas, flags);
>> }
>>
>> The reason I left the tags unchanged in this version is that I was not sure
>> whether it is appropriate for ext4 to open-code xarray tag cleanup directly.
>>
>> If you think this is the right direction, I can add the helper back and
>> send a v2.
> 
> That was a good judgement! Playing with xarray tags like this in filesystem
> code is certainly not a good thing. For now, I'd leave the xarray tags
> dangling - they will be eventually synced with reality on next writeback
> attempt. If this inconsistency of tags needs to be fixed, the fix belongs
> to the generic code (so that it can be used in other places as well).
> 
> 								Honza

Yes, I agree. Directly clearing the tag via open code is not a good
approach. However, I took a look at the !nr_to_submit branch in
ext4_bio_write_folio(), and it seems to have a similar simple handling
pattern—it directly calls __folio_start_writeback() and
folio_end_writeback(), which appears to be an elegant way to clear them.
Could we also call these two helpers just after folio_cancel_dirty()
here?

Thanks,
Yi.


