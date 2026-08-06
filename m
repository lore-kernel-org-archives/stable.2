Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 252A23BB69F
	for <stable@vger.kernel.org>; Thu,  6 Aug 2026 14:53:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786027996; cv=none; b=MbYRRQ7sNFTYk0jGlKUvKBNuDyjN+TZPaFROtQQEPPG6sR53AzU1QlD9flDObw03uun/AVwsv8PD5KIAuAytRZ2+JAr2n/uNEWQWLv19gGfZpIhMvTLurmLQyHCN5v2SAXersVW55Cgi7CsH8fSHKIp30O9yKjy2ngF5XHsNzWI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786027996; c=relaxed/simple;
	bh=yJSWJFc5C7SDNBShiCvkMljbua50fRK5eldREClOYiw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=NJkIfTWsvd/pWaeflPqCy76W9jHuP3v34OgwISUdrp96V+I4x7+tW1736r/Zb3Y6VNRwJmccurtw9T9kF7I/+9tXiBdw5AcByI0LTuULt3bVKotsRoLS3DlDWhoflmfageJ+2zjzk6yeir9iHSbt3+eLXHgYwuSmLhzTTH2KE3w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=a0fRANTA; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=bd95L1k5; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="a0fRANTA";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="bd95L1k5"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1786027994;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=ZX9Lc9HnIcANYvTu7RwrLXcqyyBe53wJ1JQ3SHKRvnU=;
	b=a0fRANTAa/esgRiDSRRqb37D+JBXOALwaEdxLLAN5CE555+ffG0AsK4HT2hKF+BhMgJ9LA
	1iYeSVhk6ORdWXeTDFMfX0z43Pa/V7FVbeI3txkiL3HJKmymapGRLsXeP1hvLUciW3SltQ
	piZvikm/oaHr1YDPPY3kg5sgM1NZGy0=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-128-r953uAXDOy--JNuZlT7FUQ-1; Thu, 06 Aug 2026 10:53:12 -0400
X-MC-Unique: r953uAXDOy--JNuZlT7FUQ-1
X-Mimecast-MFC-AGG-ID: r953uAXDOy--JNuZlT7FUQ_1786027991
Received: by mail-wm1-f72.google.com with SMTP id 5b1f17b1804b1-495529a93f9so21290175e9.3
        for <stable@vger.kernel.org>; Thu, 06 Aug 2026 07:53:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1786027991; x=1786632791; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:autocrypt
         :content-language:from:references:cc:to:subject:user-agent
         :mime-version:date:message-id:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=ZX9Lc9HnIcANYvTu7RwrLXcqyyBe53wJ1JQ3SHKRvnU=;
        b=bd95L1k5QUPNQ7oshmJPYnxhVUWuPc7DjdOfQMEFhDBlIijLXNHSaME07lJCErmQfP
         Ngdm6OYT04Sc1I1uuY1hXWHRlSDrmhF0MUQkXwqlGCmYTqiCehdPH681jDI5uhRz3Js3
         bzTz1Oyir+VVcl5gf4TjhC+FfjTU7VqD2Dawu80bWLCoPAeGlxTWgPYFXm5b4dNEs9oB
         GKUIdUEVJaEHWEzd9UzTmzDmlz77u6pVFvNJS9oYD8tE9JtPwl+CL4Q2YeLlgJe+HI58
         vI3gc/2f9Q5evYlKe17SxKoNJrT051u7GIX/ZIYlfzBgXn/9i2O1sZhNoPPZ0khLozMA
         OFkg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786027991; x=1786632791;
        h=content-transfer-encoding:content-type:in-reply-to:autocrypt
         :content-language:from:references:cc:to:subject:user-agent
         :mime-version:date:message-id:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=ZX9Lc9HnIcANYvTu7RwrLXcqyyBe53wJ1JQ3SHKRvnU=;
        b=dzpog3TH+LfIf0Ko0XpA7Wc7MOxNtL+FBiEJLIFdnoZ4DTD6pm7rJR+GRYqYTGCYn2
         pzahCjyrIFyoN/6z+mFtiWIJHORzxFR/1Z7R/LoQpczNfdCQADti9UbvXaq3FTnGW2at
         Hbkvp86umaI3KLX/9rLy7x2AGFgsnXKXhyPWT6SOiXd6CRRR5tmedwR/vFvVKfbOFZTF
         cyONkMzOsbkT7r2BNAXw7qdAIPv7eb3U3vkwAtLLKMRMoSxXPsRBO3d0sVqY23hV97fI
         QgQP+BxKfTLIOpgxS0TNviE06+GVundZCf0WY/9SPcA+1ODVjJyGWOeU2RTOz8WCHfYb
         oHZw==
X-Forwarded-Encrypted: i=1; AHgh+RpcaCaEKM5bi0sc5xg/8iQdMLHOJsX283PUlIJzf3xLjEqfIXNMLG4Jbz9ZD2n1w8Iv+HjS65I=@vger.kernel.org
X-Gm-Message-State: AOJu0YyD07VevxUNxKYKqsom8s8vyzoIzHsRc+GI+ubYc5x+UMjFcxnH
	HjwllHcHGBQUO4aACm5Nc/YYbYEFLUyn6LAXQvuP5vbj3Kr+yWn3z26HJgaaOM+9Z5PEDi/b0iP
	XMkqZ9ug98mGOhkaXCGiXKyKxjIvz2hOCpFRddJlrqp9U5UgE0vImZDLyaA==
X-Gm-Gg: AR+sD12dTPsACcNbkhrBGV91d2NmUQcX6zk+GQRSgDTSQyRMOCpEtLJmIguCf1sAdY6
	19Qoyj1gVVCYAPz2gMLpvFBuYM+hLPRfmLYAS5PCBY6PmnhTCXHah5M3AODE/vDl/7XbNsP/OJ5
	xniES1nmprWft9De220H6U24bad7uzFQNEyUITbLmdWpJ7K3tXtbZZdDwG4Ftr8wIj5TvmfBQex
	9n8Lu3IfHoJyd44b/j4xXsQ0ZKTk/21LL6M80Fgc5iSHXpM0blnbzxh1vYlm1370Z2gMfCnmANg
	lCz1zpxaL8SeLDS7PucNeeVjsXUCZA4SzkFRHagxn2E6ACX3j11m8Enz9Qf2W//FJ8TxwNWPZBv
	v8szVXrGGhdTF7yd8IaPs6BOweEisJOxRf7ivUhY=
X-Received: by 2002:a05:600c:1f8c:b0:493:f5bf:4dc6 with SMTP id 5b1f17b1804b1-4994e7a820dmr189774135e9.7.1786027991491;
        Thu, 06 Aug 2026 07:53:11 -0700 (PDT)
X-Received: by 2002:a05:600c:1f8c:b0:493:f5bf:4dc6 with SMTP id 5b1f17b1804b1-4994e7a820dmr189773475e9.7.1786027990960;
        Thu, 06 Aug 2026 07:53:10 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:280:24f0:576b:abc6:6396:ed4a? ([2a01:e0a:280:24f0:576b:abc6:6396:ed4a])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4994e4b1904sm142424745e9.0.2026.08.06.07.53.09
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 06 Aug 2026 07:53:10 -0700 (PDT)
Message-ID: <363d24da-7324-4ea6-addc-453ef468f1bb@redhat.com>
Date: Thu, 6 Aug 2026 16:53:09 +0200
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] mm/huge_memory: let special huge VMAs bypass the THP
 policy check
To: "David Hildenbrand (Arm)" <david@kernel.org>,
 "Lorenzo Stoakes (ARM)" <ljs@kernel.org>
Cc: Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org,
 Peter Xu <peterx@redhat.com>, Alex Williamson <alex.williamson@redhat.com>,
 Jason Gunthorpe <jgg@nvidia.com>, Zi Yan <ziy@nvidia.com>,
 stable@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20260805055544.1568534-1-clg@redhat.com>
 <0e52d0b4-064d-4602-8e7b-5744b05f24ea@kernel.org> <anSZpAjt84Pn7O_b@lucifer>
 <5b7e84f5-2007-458c-910f-7a6e1e3d3eab@redhat.com>
 <cf533fc1-db58-4c6b-a206-a8dac3fff391@kernel.org>
From: =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@redhat.com>
Content-Language: en-US, fr
Autocrypt: addr=clg@redhat.com; keydata=
 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
 uVKe8BVz4atMOoktmt0GWTOC8P4=
In-Reply-To: <cf533fc1-db58-4c6b-a206-a8dac3fff391@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 8/6/26 16:47, David Hildenbrand (Arm) wrote:
> On 8/6/26 16:42, Cédric Le Goater wrote:
>> On 8/6/26 16:28, Lorenzo Stoakes (ARM) wrote:
>>> On Thu, Aug 06, 2026 at 04:26:20PM +0200, David Hildenbrand (Arm) wrote:
>>>>
>>>> emdash in a code comment?
>>
>> There are quite a few of these in the code in fact.
>>
>>>> Then I spot
>>>>
>>>>      Assisted-by: Claude:claude-opus-4
>>>>
>>>> and really have to shake my head.
>>
>> It's a one liner. Good enough to raise the discussion no ?
> 
> Just to be clear: Unchecked AI slop in any form is making my life worse every day.
> 

Point taken. This is not the case here. There is quite a lot of work
behind this from several people on the analysis. Lorenzo is taking over
to address it cleanly.

Thanks,

C.

