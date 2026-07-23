Received: from mail-wr1-f52.google.com (mail-wr1-f52.google.com [209.85.221.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 960DD36197B
	for <stable@vger.kernel.org>; Thu, 23 Jul 2026 07:45:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784792728; cv=none; b=DjdjkKrCeureYBkLkutZnQaClrVCvF22kfPBaVSprcG0WaN3BNgw7h3Q3QoSLXmp2lIbZB4TdLVhvOUThCcmuLRO8lJ4XxEvP0jB4syCu+SuaMutDRxiQ2+69/OWVZN7q4w2D9VTmXRvd3uppIvR52vM2K7xeK/WkNokqex0DmQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784792728; c=relaxed/simple;
	bh=FK4nuECWzh/2cINKiJS9Y1w/QvpKWO46HahbEljsyGI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=fGHfA3aIe5yRJDFXhFAXphzIdgBqAjCrCP/qtxcu06PJKLKEWJ2e4wavalY68Xl02mwPRlxrSlok3d7uI0qR5vr4r6jgXcwBxtBSxHut446iqgP38+GyG+qe5Af7iXSLh6H+8kf08R8aQrwqUIFolrwwWN3lF3FGAd/1VdD+ihA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linbit.com; spf=pass smtp.mailfrom=linbit.com; dkim=pass (2048-bit key) header.d=linbit-com.20251104.gappssmtp.com header.i=@linbit-com.20251104.gappssmtp.com header.b=HQKJJhgX; arc=none smtp.client-ip=209.85.221.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linbit.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linbit.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linbit-com.20251104.gappssmtp.com header.i=@linbit-com.20251104.gappssmtp.com header.b="HQKJJhgX"
Received: by mail-wr1-f52.google.com with SMTP id ffacd0b85a97d-47de008b020so136712f8f.1
        for <stable@vger.kernel.org>; Thu, 23 Jul 2026 00:45:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linbit-com.20251104.gappssmtp.com; s=20251104; t=1784792723; x=1785397523; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :content-type:mime-version:references:mail-followup-to:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=FK4nuECWzh/2cINKiJS9Y1w/QvpKWO46HahbEljsyGI=;
        b=HQKJJhgX3Hpl3ppNoFquPeiqoZrhP3jSwCEo0h2hydimR0E8Ycvv/GYt2HTWVgnuhI
         sf2yD+GSsuPE2tXVZf78Fzt/nVZurHaEsrtj/jh8k9Zxvorz568sbFHG5XEVYEo/b0bf
         HzKZugvionrYMamph9fItcTvKwKVcGFZRkfdetnxs761tyj4Um8u6zoOsHbPWld8f5GY
         9ScNDn4UAlBcXVdTlwo4LUzSZnGk82OAEGRMy2Oh/cXizEGRtTyUfQGwqo+x82ZQVNhz
         pZQbZr8ECNlJPPdP0CDJzg2bI0J7P3v6sb2vYUFJ9WUXBXNwr9hzOxWJXQkRQ79O6ruC
         50pw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784792723; x=1785397523;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :content-type:mime-version:references:mail-followup-to:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=FK4nuECWzh/2cINKiJS9Y1w/QvpKWO46HahbEljsyGI=;
        b=UjaGFCvPog+jg/HB0DF5XDmLAwv143WWetkOafZ7AfUfX8Tnf/ldw3RQsxEMkCz80b
         Ij0fLUJoZzbqw2IVivkV9sh2QfU3Di4U9pxJAIrwiQchvUX8BqNeD/XwhGc49jM+m6CI
         4i4v5xIink7Nz9F436d4Km2vlghLg5aTnMEFdo9aJqZf0ueIYOgSjZ4T74oZsCNIwhjb
         vMvA4TwvpaCe+A8iTprt5Kf9aLNIjkoaGNqE1DP1Oz4c6c2e7x5dHT86V+MeQah0MFnl
         0fdC2MNCfnvBhOTTcxwgy4Dj2zeTSi7Sk/I9YZtviFWADW9FK2WsKruo5lF1ZtNdgws9
         0GVQ==
X-Forwarded-Encrypted: i=1; AHgh+Ro/ad5LGkz5If+LvHkjKfQLFWl7UX+/nTyB/XdVyxBj2eVDpiorAVe9TRkvLXT4tki9Z541Mhc=@vger.kernel.org
X-Gm-Message-State: AOJu0YxiCRkpY8sMPnyUGWrhkTrEV5c5ornpNkpWAMUuOTMppt4DjBNn
	GD5gIuVXp5OeWD0fhK89VC4J0XmPrnKUYBaz43R/xAIUqrlOR0pVZJTSNa+iIrN8lGEYeeH3Y+D
	qqyt1
X-Gm-Gg: AR+sD115Q8FeG8UFc4qH4FVFYHTr/wBNv/mxK6zJYX/K1b2EI0Fci4GDWHy6HVHLejr
	S6hKTYf2zEn6t12ML2ArIa/aEqJFGR2HEP7MxMdB7qEVxCc8uctK5KOKns1MHL7ljySDQedMQKL
	tD5mETOsvNthxYGJ5akshTBIJJlO8HRwD6qAo7mR1VR24h0HJ+jb41f3BFxSvXL+8czF4ElA4Ev
	6BqQH7omKflW5PFlKWLg2iiD0mGq3Faizi1dPll8jvAahOe8W+VlaWYmLWXMdITgBYZDsfH7JIv
	95mxIqN7n28WyQqFCFauSRGjrGX6AVMAnJNSz6UbpxAokCl7Fja2+GFA6qux04DqQqhOLslyYLE
	qhax1lw2n8DXwgMT6jgRVultyB4cs5MPDd6P6OU8mtP0hmBj5xHSs2862QK5lYeonbyJdS6zhsR
	FArKKH/I8RGKCW+vZ5G7YWNZPBz3E4zfTVeZOFl6CCLN9mEg==
X-Received: by 2002:a05:6000:1acd:b0:47f:70f2:ccf6 with SMTP id ffacd0b85a97d-47f90215a85mr1739490f8f.6.1784792722721;
        Thu, 23 Jul 2026 00:45:22 -0700 (PDT)
Received: from localhost (h082218129081.host.wavenet.at. [82.218.129.81])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-47f85c6dc25sm13663180f8f.33.2026.07.23.00.45.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 23 Jul 2026 00:45:22 -0700 (PDT)
Date: Thu, 23 Jul 2026 09:45:21 +0200
From: Christoph =?utf-8?Q?B=C3=B6hmwalder?= <christoph.boehmwalder@linbit.com>
To: Linmao Li <lilinmao@kylinos.cn>
Cc: Philipp Reisner <philipp.reisner@linbit.com>, 
	Lars Ellenberg <lars.ellenberg@linbit.com>, Jens Axboe <axboe@kernel.dk>, drbd-dev@lists.linux.dev, 
	linux-block@vger.kernel.org, linux-kernel@vger.kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH] drbd: reject out-of-range sizes when draining data
Message-ID: <amHEWfR808gFEanV@linbit.com>
Mail-Followup-To: Linmao Li <lilinmao@kylinos.cn>, 
	Philipp Reisner <philipp.reisner@linbit.com>, Lars Ellenberg <lars.ellenberg@linbit.com>, 
	Jens Axboe <axboe@kernel.dk>, drbd-dev@lists.linux.dev, linux-block@vger.kernel.org, 
	linux-kernel@vger.kernel.org, stable@vger.kernel.org
References: <20260713023434.288279-1-lilinmao@kylinos.cn>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260713023434.288279-1-lilinmao@kylinos.cn>

On Mon, Jul 13, 2026 at 10:34:34AM +0800, Linmao Li wrote:
>drbd_drain_block() receives the peer-provided payload size through a
>signed int argument. A wire length above INT_MAX therefore becomes
>negative. The receive loop still runs, converts the negative result of
>min_t() to an unsigned length, and may receive more than the single
>allocated page can hold.
>
>Commit bd910a7660d2 ("drbd: reject data replies with an out-of-range
>payload size") addressed the same issue in recv_dless_read(), but the
>error paths which discard payload data still use drbd_drain_block().
>
>Reject negative sizes before allocating and mapping the temporary page.
>
>Fixes: b411b3637fa7 ("The DRBD driver")
>Cc: stable@vger.kernel.org
>Signed-off-by: Linmao Li <lilinmao@kylinos.cn>
>---
> drivers/block/drbd/drbd_receiver.c | 5 +++++
> 1 file changed, 5 insertions(+)

Yep, same thing -- DRBD usually chooses to trust its peers, but the
consequences here are pretty bad and the fix is trivial, so let's do it.

Reviewed-by: Christoph Böhmwalder <christoph.boehmwalder@linbit.com>

Thanks,
Christoph
