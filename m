Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F1149404BC5
	for <stable@vger.kernel.org>; Thu, 30 Jul 2026 11:02:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785409337; cv=none; b=X9dYPHkmTEHOO6UuMDovmHxK01XjN8zibbJO7DxkFpq5yIul6+SLbignkXutaQKRHtffXMDsslLFQO7C3lZMwFx36Q2QRzsh6AZcJqsWAh36iyEwy2jZN4QO7O7tWifliXz2LYRVf8x+813Z+0cg0pLN0LBQXz3xUFBUmAl4OWU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785409337; c=relaxed/simple;
	bh=4dNV8PH0CaE40xpTad7DkyOXVNy048PvQhAPvDCkzwI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=uMjrfsRNWb0VY2Y5FSiVAgNCmGkNl4UGyyFqDz3CVSchcff0iZpmbFL/WJUyYjeoOnSXPevvASilQYqJ9T4clqZqQ35hRg+D8qTkNyNnPBxxrl9mTb0ZMfsiHZg17QlZvRUsNvjzv9TbTT7/7IgLASR6ZANWRtSZka0IyrJbLcw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=UqXoLe4o; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=juxbA9z6; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="UqXoLe4o";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="juxbA9z6"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1785409334;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=xGF4bBEyPT9GA0aGVwzyimStY//dkrh0h2Ht9VGZr7c=;
	b=UqXoLe4o0pV8vH9tHJ5gH33EIizWCO5d84JXeQZuiSXGLpocoZTWuANNNzkoONMvuFrMB8
	FdYI1e/Knj/qtmE/65a4dNV7YKWIYu7wWZ3/mJNTHOYtEoflKNv+0eqVA3aw9paQ7+9FxW
	mCutB81zrNyPVI597xLT6rU1kcYq+NY=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-120-oQDy4MNaOEKW3X2ydf19Lw-1; Thu, 30 Jul 2026 07:02:12 -0400
X-MC-Unique: oQDy4MNaOEKW3X2ydf19Lw-1
X-Mimecast-MFC-AGG-ID: oQDy4MNaOEKW3X2ydf19Lw_1785409331
Received: by mail-wr1-f72.google.com with SMTP id ffacd0b85a97d-47162f83c75so363387f8f.1
        for <stable@vger.kernel.org>; Thu, 30 Jul 2026 04:02:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1785409331; x=1786014131; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:content-language
         :from:references:cc:to:subject:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=xGF4bBEyPT9GA0aGVwzyimStY//dkrh0h2Ht9VGZr7c=;
        b=juxbA9z6XqwaJNCKcoJ9uv4M1IVgCjDc0YXm8yxZ2l3vGHwftQxeCCkM0uoX6pxUbV
         k5Dhn73wHJGdoRAmhvE5azNSLPVbqAhTWTaLPU9QDdQpxSYIejUPO/jf7O3tn/R+27F9
         1MM0EB9QMF9ljk7hqOYrPMtwTItpVJXfST9Mo7oEhjHnPXtU4FrtKhgYK0labPnXMISq
         9U94puQo7Bgay8+6Tr789dTymCrSXxBF/OIsvIcoex2ugL5a5NstkGLVgv0LVMKcju2C
         HDRpRAP1JAE/pvJysv4ihxXUmGWgtvmH4KF8P/KCy08U/NH32Y5jv6c+DbHvmfq8Eswi
         TSQg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785409331; x=1786014131;
        h=content-transfer-encoding:content-type:in-reply-to:content-language
         :from:references:cc:to:subject:user-agent:mime-version:date
         :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=xGF4bBEyPT9GA0aGVwzyimStY//dkrh0h2Ht9VGZr7c=;
        b=GALV6ZV40oCKh+tV3Bd1sKqHk5gek/XqQGc9uwwJZCuxbw4wLFhlX1DMJMnmHr/8Lv
         ZVPxdnW5GYlI7dCXdIWV2yDD15lQgw7k0rKQTk7qohnY9SKWumvoKblrTTTm87ERHoVv
         CitAkZpBuLmhCxNIE9nDTN3/ETHfJcrPRaJIT0U3wpWAr6HiaH9+uO+/8BSECjNg34Fo
         nH3k5mitIEqGsz9uaK4Y1014ladcSZGkzeCkToZkaV+wWiPaBjiOWBco4Dkl5/3FOd7j
         v7DCbLgNma4VsjjZ1to4W7oBox49RMQ0srKIxL73GAxjpQzVnpEoyN02PKFZexy8hbth
         FVPA==
X-Forwarded-Encrypted: i=1; AHgh+Ro4L6DytzkGeToSw/j85Zy0xzp1psk/jQ/IQZ28w7lvLM070UI5ritCJLhs4A7ppGAWl2//tLc=@vger.kernel.org
X-Gm-Message-State: AOJu0YyPMkmzlKzWMAMM4fg5r5rWIu6Fvy1KtYcN3cTzdD6DZONceK26
	21/dRibDvRlc+u5z5elAwItMwd/iQqG6vVN0vs+GJjByq1Z/Wq/Va/Aw/yDfq84cgoL0Vlud7Br
	MW3ED6bcHJW8Y+96AMtoTNLMBiVb1yphgC7RjTshcOK886n2ZKaSVSVk6cw==
X-Gm-Gg: AR+sD10VTRFZGWjVpe+Od76gQQXIZgQalSv3ydp2dxIgoRNCxJeO/nNuGpme12yK8RL
	tuWv5c36txCmZI0MwtjwnLxmH7Qqtczp6/k9fkTFBjPixJNBFAvOFFDetAmYXW5B/BamK7t3ugQ
	7VYW+lNAj6i8X2RrppAM0gTniR3yZht+ClOHTMdPlWkbFVu4ZJRH7qMaH3f+MhvM1J44/9SpJbd
	wgLucAIyssH08WEoo50jA5+qhyTfH6JejsEptaNyS6JvgVO+ndf3ByNB8yTqIsnDCBHZBj2gdsb
	K2ZC18gHegdm7r7dDntqMRdLzr6Hw6K3ONaDtxz/pZL3wgUmkBueti60OLqUU6AliMIJZwV1RjX
	PwylW6uWtTr6t/FHAYD2LfhF34GRJY4RR2W8YR8vRdKgKfOEgGcn/18Yhf85bG+OSBqRpyfFR9q
	YUkQ==
X-Received: by 2002:a05:6000:469c:b0:47f:70f2:ccf6 with SMTP id ffacd0b85a97d-47fc8bcfa1dmr1198736f8f.6.1785409331067;
        Thu, 30 Jul 2026 04:02:11 -0700 (PDT)
X-Received: by 2002:a05:6000:469c:b0:47f:70f2:ccf6 with SMTP id ffacd0b85a97d-47fc8bcfa1dmr1198714f8f.6.1785409330584;
        Thu, 30 Jul 2026 04:02:10 -0700 (PDT)
Received: from ?IPV6:2a0d:3344:5521:6b10:58fd:68f:7756:389d? ([2a0d:3344:5521:6b10:58fd:68f:7756:389d])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-47fc8934ba3sm4817223f8f.27.2026.07.30.04.02.09
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 30 Jul 2026 04:02:10 -0700 (PDT)
Message-ID: <9da84225-3d4c-4dd2-ac77-192ab0f3c03b@redhat.com>
Date: Thu, 30 Jul 2026 13:02:08 +0200
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net] liquidio: Fix possible memory leak in
 lio_reset_queues()
To: Jacob Keller <jacob.e.keller@intel.com>,
 Abdun Nihaal <nihaal@cse.iitm.ac.in>, andrew+netdev@lunn.ch
Cc: davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org, stable@vger.kernel.org
References: <20260727080258.86279-1-nihaal@cse.iitm.ac.in>
 <54804d01-9254-4482-a0be-c38c3c6177b8@intel.com>
From: Paolo Abeni <pabeni@redhat.com>
Content-Language: en-US
In-Reply-To: <54804d01-9254-4482-a0be-c38c3c6177b8@intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 7/28/26 12:55 AM, Jacob Keller wrote:
> On 7/27/2026 1:02 AM, Abdun Nihaal wrote:
>> The memory allocated in lio_setup_glists() and setup_rx_oom_poll_fn() is
>> not freed in some of the error paths in lio_reset_queues().
>> Fix that by adding the corresponding free functions to the error paths.
>>
>> Fixes: 4b6e326b2d34 ("liquidio: Per queue oom work queue")
>> Cc: stable@vger.kernel.org
>> Signed-off-by: Abdun Nihaal <nihaal@cse.iitm.ac.in>
>> ---
>> Compile tested only. Issue found using static analysis.
>>
> 
> Would be nice if we had a reproduction but I suspect this is tricky to
> do without some kind of fault injection.

We are actually requesting such info, especially for patch touching less
active device drivers.

Also sashiko has a bit to say:

https://sashiko.dev/#/patchset/20260727080258.86279-1-nihaal%40cse.iitm.ac.in

/P

