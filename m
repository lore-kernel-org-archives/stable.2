Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.208.49
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793964971;
	b=as9QJ49wclCrOJJ5pa5Uh6lJ66WZRp9HNYXbRQTUuuAZ8wtIkwwj6iwBzsEqiUtht9Wk
	 6kSwH1hXD9MlDfr9JEbOKURHeubtx5dzbVzdCWyLaiDFrXhWIScGb6QjO+b5s48xi/+z+
	 bjD/FF3TmVhfsBl8Ti5OU2RDFw9/wr9NnNusZ1KH/hAJiXuxqj3j7TKlELFPjdQAybCc/
	 bNVPNlEjPNblY8a94UEesIcroI7tBc7oZlp2zEDgDL8fY+C+flzLMawZQW+k96zHKURaY
	 zxzjNJwbcK3O8zKpMu1r6zzBeudNfM1n1lzDo1C6lTiSS3vxtqEzYLzJfAN5hdromSQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793964971;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Message-ID:Date:MIME-Version:User-Agent:Subject:To:Cc:References:
	 Content-Language:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding;
	bh=R1fgwrt/J2JYxCxSGOKH3dANX3eXUBpSh/LEwH4Q6no=;
	b=M8eZ2qaldZmd9JVIPRa6yXuj1Y6ElLH/sdrxM+qP4UiNGLrX/MfrLsC/uh602vUbLkpz
	 RhmUGHYEmHOy0Uj9VVpZL9BN79lVyFvBSeojDw+UlTcyT107ViFreWG43BnfY+bBFamGe
	 kC8+MHJzI1uRp1AXB5vRRAinoqiIaZAdZ/WBisolw6mQQn5NkreYCacBepYqTg8SokTEr
	 BkuDhba3ghTAfjOami0WuPAs6dumsQyToMsHwednVsRfGIypNgyN4nlw6FXtUTeORFljx
	 DXbYWQhroeSqQZ9/ZaWKsMms9ReZplzciHnjD96tOLQI5dBddxzd4YDEe1AKrb+pm1A==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=vXeWgUVX;
	arc=none smtp.remote-ip=209.85.208.49
Received: from mail-ed1-f49.google.com (mail-ed1-f49.google.com [209.85.208.49])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A0093606BD51
	for <stable@vger.kernel.org>; Fri,  6 Nov 2026 11:36:10 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org A0093606BD51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=vXeWgUVX
Received: by mail-ed1-f49.google.com with SMTP id 4fb4d7f45d1cf-6b5669a5100so651801a12.1
        for <stable@vger.kernel.org>; Fri, 06 Nov 2026 03:36:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793964969; x=1794569769; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=R1fgwrt/J2JYxCxSGOKH3dANX3eXUBpSh/LEwH4Q6no=;
        b=vXeWgUVXCX1z83xkLBImjwxeEZ+/oy0hXtB4qBbyT7TOupGYjBIgrWZf3XE7Ew8xnS
         LTWciAqFhcO0hL+ROYEyXVlla17tgmlwpzOpKEOnTsN82RRR9scxap6V2dq/wbNh6Nas
         HXKHUavdKTnwj4OSUMGUtUDCa2qlIl2WfVZCG3QuL2ou2l9hBwXqnofxflCKqnEpBwCs
         +V4Huv+kLbW2cNzr1wl+hSlV9oLoXFhhEdeyInEfnXlttSY9k1ioMOQNOAdm7AFZn5IE
         Z1zZeCB30LRA+q90OOBgYtNBSW1Ahzgl55PNW064pKRsiwm87kBbvoU5PlRx5AZc53Tu
         Z9mQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793964969; x=1794569769;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=R1fgwrt/J2JYxCxSGOKH3dANX3eXUBpSh/LEwH4Q6no=;
        b=GsxjF/AFskPiVDXzgikum6uqFnPylbR7hpH8TZu7R6pp2/FXpEyFa2CZKeQyvwIL3g
         pD1FFTYR+2wGDANLyPQVOoXSp/AFAKHZ51Eqd+WhVtd/izlSFIzxayoBQV7s9SJ2Tq6h
         ToIBV9Fz0h1Iv5PbMf07k1eK0c3hRGKYDw1pfeANlR12OIhN2Ms8fHbq1NvxsXC6GSDS
         69Bo36goMrCLHvTftt8e6hwAo4AF8Dapwl3BUO8MKbub7dQGO/hdWwmlVpQnx1ygkkI1
         cu/EO4VKfLFjBv2SmEGPTDuuw5nXtmL74HPssFQAnXTpZNxtQpWjhCb7a8D9E7IVxqHC
         0moQ==
X-Forwarded-Encrypted: i=1; AKwUvBz9aLYTY19QAEwDd4ktMoRwSIeLqGbaqmySdvvtZCBnwdbgrTVJrPiqPY9hHFNQLDu2DJ9w3TI=@vger.kernel.org
X-Gm-Message-State: APuU4Z9GGJrz/lon3lNY8e40LKi+pHWRazocJIX9xhB7J/BDwZsnObUU
	fOhjyj3DVFkLpwJ9hfkUfx58e4jzfMHLoKcQNoEW0CNU9Se22vJA4gPw
X-Gm-Gg: AYBFou1MqUD4KMTDYC19mPnVg8YnoN5xlTnN6oOZDwi3254NTOrPPdpMI8zfe2U7ILV
	aH3SggWERVEainNZYaU1Pf1sHbf+jf1dYjpENx1zVhILPkrJOX8sg2Yi0GPPoPRNBtBWNmVYpOy
	ThQbm7LXU4KyRctgynYqBYm6Hqwg4AC+GgOTPvqSgubFA25dYHSuau0XFUbcYBSAH3wqJXBW2Y+
	AByXC5Jg+Az6l7JyxqXOoVks95QN0RZv0vg8inic5D81mDrI2xmaLY+zOsp/H3L1wACC5tX9HfP
	GOepFhN/xAW1PIvs25DWGwQ3ctMDJRHcfGwd0jdN6A+aVddN9RHu3hgFEeYejwWvhsJKQqDmJMC
	c3ZleFjFvgLbeXC65vtqjhYLoQ13xMh5dNVKD1MdQhS4P3l1At9f1w6V+OSCDO0GG4cS0T0qT+s
	XUUpk/wbUqwM4fNZv5DKXq5P9HKre7keJ17DtEMuSjtRA9552b25wfOa5ZhJjFS6xwjCsq36Y0+
	197Egc63p3LeG6ynRConeQLsr1XukoOfhLvB/uFfQIBcrTsJ5V/Rf4cbypBnc+JOeO6GQjmCzs6
	4VNJD8UpgKcKz8j3NfWBgFY9xIuyhZ8QOybCK7Dc59eYSd+YEGtUO7tSTw+IaYtWgvZAbMGVSiG
	ka47P4IZ/qo4fEf3E4wRzjxO7pPKpQv7CPp0H2z7AarGHh9iWqOitgDBOsokkhblVaXwAo1kAHB
	3GPMvk4j7ETFFWY6kV+CgvjwgQ6/QMLli20RLbXLT6+1EiOvtZgHKoO6O++Vn1G9s=
X-Received: by 2002:a05:6402:2b91:b0:6b4:602d:f1f7 with SMTP id 4fb4d7f45d1cf-6b597816109mr1452325a12.20.1793964968944;
        Fri, 06 Nov 2026 03:36:08 -0800 (PST)
Received: from [192.168.100.100] (87-205-15-91.static.ip.netia.com.pl. [87.205.15.91])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-6b664ae5692sm615592a12.17.2026.11.06.03.36.07
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 06 Nov 2026 03:36:08 -0800 (PST)
Message-ID: <4284c2d3-75cb-4e41-aa45-f7311e60ab4a@gmail.com>
Date: Fri, 6 Nov 2026 12:36:05 +0100
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
Subject: Re: [PATCH v2] mm/filemap: stop fault-around when the walk steps back
To: "Jose Fernandez (Anthropic)" <jose.fernandez@linux.dev>,
 Pedro Falcato <pfalcato@suse.de>
Cc: "Matthew Wilcox (Oracle)" <willy@infradead.org>, Jan Kara <jack@suse.cz>,
 Andrew Morton <akpm@linux-foundation.org>,
 David Hildenbrand <david@kernel.org>, linux-fsdevel@vger.kernel.org,
 linux-mm@kvack.org, linux-kernel@vger.kernel.org, stable@vger.kernel.org
References: <20261031-jf-mm-filemap-map-pages-lower-bound-v2-1-21029744e589@linux.dev>
 <aunPI5eOUOAEUa8d@pedro-suse.tail5790ac.ts.net>
 <20261104-jf-filemap-v2-pedro-reply-r2-74c87c6fbcf@linux.dev>
 <auxvLCiljPhy0n_q@pedro-suse.tail5790ac.ts.net> <au0GBdGqu6cv5PMy@linux.dev>
Content-Language: en-US
From: Krystian Kaniewski <krystianmkaniewski@gmail.com>
In-Reply-To: <au0GBdGqu6cv5PMy@linux.dev>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 11/5/26 23:43, Jose Fernandez (Anthropic) wrote:
> On Thu, 5 Nov 2026 12:19:13 +0000, Pedro Falcato wrote:
>> Thank you. So, if I'm not mistaken, this is the race:
>> First, you map/see this:
>> 	[folio pgoff 4, length 4]
>> Then, at some point in time, someone punches the hole:
>> 	[no folios here]
>> Then, at some point in time, someone faults another folio in the range:
>> 	[folio pgoff 0, length 8]
>> so you step backwards. Is this correct? Or am I misunderstanding this?
> 
> Not quite. In my test a large folio goes away and a small one comes back
> below where the walk started. If that happens during the walk's first
> lookup, the walk can step back. Krystian's fix doesn't cover that
> lookup.
> 
Right. My patch only covers the case where the walk has already
returned an entry. The first lookup, and every lookup after xas_retry(),
starts in the XAS_RESTART branch. My patch does not change that branch.

There, xas_load() can read the sibling slot of the start index before
a concurrent erase, and the canonical slot after it. In that case it
returns NULL, but xa_offset still points to the canonical slot.
xas_find() then moves on to the slot after the canonical slot. That
slot can be below the start index.

I tested this in the userspace XArray harness. I wrote that state into
a node and called xas_find() from XAS_RESTART. It returned an index
below the start, with and without my patch.

Andrew, Jose's Tested-by for the xarray patch is on the filemap patch
in mm-hotfixes-unstable.
-- 
Krystian Kaniewski
