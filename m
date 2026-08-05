Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 261E547ACFD
	for <stable@vger.kernel.org>; Wed,  5 Aug 2026 16:29:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785947357; cv=none; b=Kr8DLJGDw5zio83/Pzq0uy+odzI7WzhyjE938rLCOqK1geLahmuO0V9ZssgMmJ6QcfAdKmWdQ2WP40vVNG0XhfPNSk9kn9Ha0VQ/Q74gHmyrNJtYvu4dxAnnhpWJYo2afZv2DRz25HrYZU9PAonwxtNdAySJqHNaIV5n0oDYJMc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785947357; c=relaxed/simple;
	bh=VDLc6Fu6ucuz+5L2a+8AeySd6iro8LDpMWymkYDcsaI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=jnzH7nNznGw8R2zAsUN1G43BF8B6V6WuJiQpQx2ZvxVxYVserNqbIS7uOa5ZSdf1ItS6a+0orT0iVWL0vITxy6WpvZHicBPrFpk9EblBLL/EwcaTrtWNDFLnxnbaxXpvn9DjAvjUDIbzvnmlxMo58/fqc1R1xOC6yQda9aMsJM8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=UTxC52qz; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=Yvsrqvz0; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="UTxC52qz";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="Yvsrqvz0"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1785947351;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=Ekaj1w74e/IlHxyDhw3APH1qT4hJfeKb9Oncbh24AZs=;
	b=UTxC52qzIjnGFPsWN+BrPZ+FAFIyZYmm6bdMc3Uqj6f3dHKnymlEojAGKDQ7hZ0iHx2KBk
	yuXkcC/8l9cUUzMdiooRrtb4/0yNlPbLhhfqqTIcnrXb0SIXv3XtLeO8A3Ouq3Y95vygzb
	4YupKS49kV8m05X2d2uhWpbcSX1Mc+4=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-173--1Fn7btJOuSJVLssIlakxw-1; Wed, 05 Aug 2026 12:29:10 -0400
X-MC-Unique: -1Fn7btJOuSJVLssIlakxw-1
X-Mimecast-MFC-AGG-ID: -1Fn7btJOuSJVLssIlakxw_1785947349
Received: by mail-wm1-f70.google.com with SMTP id 5b1f17b1804b1-496bbcf7d1eso7311275e9.0
        for <stable@vger.kernel.org>; Wed, 05 Aug 2026 09:29:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1785947349; x=1786552149; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:autocrypt
         :content-language:from:references:cc:to:subject:user-agent
         :mime-version:date:message-id:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=Ekaj1w74e/IlHxyDhw3APH1qT4hJfeKb9Oncbh24AZs=;
        b=Yvsrqvz0ScfGJG5hIhaSFA2xWc9TAIn0hBI7aQnfPnKRvt9ep5fNCDETf/Yyi1Vzyx
         fZbgWDJq6G+lVfU1u0Vv5ufvQ5O2thcLihNPjN/Fz8T3SAe2bwHsZiE6w7ag4Rb/huke
         KquZnYQXMxjlOU0tQloH7jXu0mH10Smg5EQVXqdB0FN7XwspAYdCCryX1KcUSJM7oEIU
         /ivUYBLkSNd5PjB0WNuLtCMLMeE1INFNvH5jxzxYiFMXYINPxu8l4DhBPSAFxHg2tlKt
         ZngIdjN+8ew5JWkjQiwiNQiyICWwfoIaYNjvpGE0K/Pyu52Qpm/im2TbPf0+hMU2Fu8A
         v8tQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785947349; x=1786552149;
        h=content-transfer-encoding:content-type:in-reply-to:autocrypt
         :content-language:from:references:cc:to:subject:user-agent
         :mime-version:date:message-id:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=Ekaj1w74e/IlHxyDhw3APH1qT4hJfeKb9Oncbh24AZs=;
        b=c87MiVUadDoTd3H/AMqvvKS/yoDbcwYh7Ou7rgA9xfxrJI/tZbAsvo1lFdhYup1o5Q
         PW2PVXgcmvOcLY9JHk/ilo5s6J5rws52HnIiB9lQpyKYm3g7nZOMynLo6fqXHkwiF1V/
         sKlMSTtS4tKU2maAH+gIWeuj7drGKCs4jgbg/1NMgmm74AoNAq9X5t68chBtxi2DgoQw
         G44kC75B2ILLy4R3Hhn+8PNIY95V3c9zzzO1rH1lrF4sV02Ntp6S39qgQrS8/kaRcGtA
         Tcg+vmYfdzvPYlHWomD+n4ruxCgUYUXFxPzwLSHuYMuNKcxpq3L/OOnzEH6BRQbxI006
         /14g==
X-Forwarded-Encrypted: i=1; AHgh+Rp44oTf8PnkPH1RbfBraqq62FZ+M53QuPUQC/YuBJrz/dp3mXrAE3+XACP5PTPwzovtNoDbbiQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YwKln9Gk46ib0+eX7/5Z2/KYhvjaka+VDIcPF8amHEUBFyqKJU2
	d3IcvsoV592wbe1ThWesSWS6HW0vS8zKSUi5PGMRQggF8OvXIMVEILazb1xw3Pb3oXep34rChI7
	u2ElYFWjf+mVza+ehdDdqRm0AUvLK51EvW+b5j0/IQqEFRvwYqer9hDZhZw==
X-Gm-Gg: AR+sD10qUq8PmIh1tzgg1yB4xAwWoVwgF1uJ7+omeoJJ6ng3aDk/G0HxWIh9ByY9GK5
	e7tCfypASS3YnCZlf/0ug/V3Rbi/9GCywIrAe0dohOUFwmiW8kl1W4IhfU0LhZNvvJ2Ib79iEiY
	rixu3PPMwhpqnNIBnmHtehMybM+c4bYG/s3CYElIRmZjXHCiULMwiubXJeMrwKOXxvBA1wA8ENz
	Fm0t2AlOGbl+QGCkURqL/2V2hNO6gN7AH8fMVxIuuJ9csk3Ew2cWZs3k/ehU+hyfR4cNFrUi2bn
	3VXZh9mRvGXU1w7d3Jaf4szQ6EzVCeVAkIaVjF6c2zsYUcboKU9Z59TmiHAdL3GtzessZaFU3fo
	5QTcyr4f7lD/Z6Wgj2iD1FPZQli4/Vyq48djm5t0=
X-Received: by 2002:a05:600c:1992:b0:496:c378:6420 with SMTP id 5b1f17b1804b1-4994e71a1c9mr95297975e9.8.1785947349396;
        Wed, 05 Aug 2026 09:29:09 -0700 (PDT)
X-Received: by 2002:a05:600c:1992:b0:496:c378:6420 with SMTP id 5b1f17b1804b1-4994e71a1c9mr95297075e9.8.1785947348923;
        Wed, 05 Aug 2026 09:29:08 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:280:24f0:576b:abc6:6396:ed4a? ([2a01:e0a:280:24f0:576b:abc6:6396:ed4a])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4994e980559sm63248655e9.2.2026.08.05.09.29.07
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 05 Aug 2026 09:29:07 -0700 (PDT)
Message-ID: <f275f77f-2773-41fa-b4c1-ed3b5123ab41@redhat.com>
Date: Wed, 5 Aug 2026 18:29:06 +0200
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] mm/huge_memory: let special huge VMAs bypass the THP
 policy check
To: "Lorenzo Stoakes (ARM)" <ljs@kernel.org>
Cc: Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org,
 Peter Xu <peterx@redhat.com>, David Hildenbrand <david@kernel.org>,
 Alex Williamson <alex.williamson@redhat.com>,
 Jason Gunthorpe <jgg@nvidia.com>, Zi Yan <ziy@nvidia.com>,
 stable@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20260805055544.1568534-1-clg@redhat.com>
 <anL-NZkNMSSxN0YN@lucifer> <4ddc95f2-8868-4be3-9839-e2d14cf35fef@redhat.com>
 <anNjdDxP5-Oq5eXk@lucifer>
From: =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@redhat.com>
Content-Language: en-US, fr
Autocrypt: addr=clg@redhat.com; keydata=
 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
 uVKe8BVz4atMOoktmt0GWTOC8P4=
In-Reply-To: <anNjdDxP5-Oq5eXk@lucifer>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 8/5/26 18:26, Lorenzo Stoakes (ARM) wrote:
> On Wed, Aug 05, 2026 at 06:21:30PM +0200, Cédric Le Goater wrote:
>> Thanks for the quick feedback Lorenzo !
>>> So I think it should be something more like the attached.
>>>
>>> That way all the handling remains the same and the override is applied in
>>> the right place plus smaps keeps working.
>>
>> LGTM, do you want me to respin a v2 with what's below ? or you'd rather
>> send it yourself.
> 
> Thanks, I think as it's somewhat divergent maybe better if I send it with
> Reported-by/Closes if that makes sense to you?

Of course,
  
> I'd like to get David's input on it first however!

Yep.

Thanks,

C.

