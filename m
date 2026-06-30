Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D3EB03EA94A
	for <stable@vger.kernel.org>; Tue, 30 Jun 2026 14:10:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782828619; cv=none; b=g578U9+iAwf0G9AlzEhvjrWHXQM6aLJy0B+qHg/SCO9ZmrjKMEEwhkxjq2KzmiuAootpaxXctQy85ctEtN0IllyHduMd+8TsiVCyh8gTKgm1sQ7415ZBo6YWQQOOTr7GX4Q/14L5fOIkA3cYhEusQgd3jOxfayJSa0W1ll7oiNs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782828619; c=relaxed/simple;
	bh=/wypLRgPYUhUm8w1lzxMnTMb4D5cfhEnCejHG8k/hTQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=uutFecuSMA3WKAMCr3YrhGlVMAQaXBfb1hGKBSdT6blcz5TCXgPdOcy61+WJJdjqgjZwccgEZl3ECrV7s4af4SXZ3LEWqumohLDPtvn4n2Mvamc0j9GeZYWUV+DFXbwdmxOgXx6zXZ084P8kGjuWGcK4CCNipgJVNDVz77RzrYU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=KnFO/KZS; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=Bl03F6d7; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="KnFO/KZS";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="Bl03F6d7"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1782828617;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=BFDdj7mBxvpQB1df0Zv0Bo5GXWFLdAHUl/QXNj3kRfg=;
	b=KnFO/KZSn4PIEcxqmT1YfnhzaR5k+2zNEqsPlVbab3Y7dLrWi62bfVPLr0RV/xEhXZgIwO
	GwwDuk35vgYe8jD8JFFzBk3ZythqX5sdqgfuxEWmfv8WfqjAEucc5lSuxh6P+vg6upf9Z0
	Ab4hAksbumUOmasznawud5PusduREvM=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-70-2VFYJfrwP62o2hpw7tV-NA-1; Tue, 30 Jun 2026 10:10:14 -0400
X-MC-Unique: 2VFYJfrwP62o2hpw7tV-NA-1
X-Mimecast-MFC-AGG-ID: 2VFYJfrwP62o2hpw7tV-NA_1782828613
Received: by mail-wr1-f70.google.com with SMTP id ffacd0b85a97d-473f4a48e9aso1492389f8f.2
        for <stable@vger.kernel.org>; Tue, 30 Jun 2026 07:10:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1782828613; x=1783433413; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=BFDdj7mBxvpQB1df0Zv0Bo5GXWFLdAHUl/QXNj3kRfg=;
        b=Bl03F6d75Sadz8/djnBa62uP7Zk3opI7XIZ5LYa8InPxAFyyAnO2zXPKXJHI9nFkmQ
         Kt3yVNELD2EVtg4S3Wn73Ducfr2ILcI+l2XIPqLf6OHN+GLQViLE7Cy6vnCm0w1JD9yS
         ux9XM9Ub2HTbD6X7LDCAd8mF093VYJrct9wJngklVBmYn9Lom90Y4rIDtlxzP1FZvvof
         +MSvv/avG5f/at6EJMYBHSp73j5fv3l18daWOv7oIvlFr4YYajm7OPXjwmgRG5ML2eyB
         IXna10V/+v+1K+T8dmdpLrydyOfXO+7yiQVaieEogFYZADc5yzQdF3nz6HA0e+3R/6Pf
         AUmg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782828613; x=1783433413;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=BFDdj7mBxvpQB1df0Zv0Bo5GXWFLdAHUl/QXNj3kRfg=;
        b=hhwn7+PxrbnEAX5cZpGSaiMJcFMSNammq7HoVAaRLQ3pA7bAWI3W923X/a4Ks6tGyt
         5SAj5lovpBDhbE7fDc7PwjLHnRET7GtlrNp9pYlygvFvfrWXK6km0YsvFhjei98+pca4
         p/m2U87yDT6biywis6NEIFJXT1D3cbAW2Dk058CBA5NSYN8kP6OM4VOm5GJcjM7ZlypI
         VZ1ZR78xhrw9D6lqNCD1ibzM914NM710uDIDq68gfopftQXrcINakIRgDyz3Uv/BgdAt
         2vx303O4p79sd93TGNL2bPONxZvTwY+LRfOdQwwL/pDmgixYMpqWMfU7hUnVodnLQdVf
         wxBw==
X-Forwarded-Encrypted: i=1; AFNElJ91GzVOJK8k54SzoiX95L7AtqT/+tOGk04hL334Arc1gMAgUEq9IM1TIw3cZ8TxSAC9NlXD7qk=@vger.kernel.org
X-Gm-Message-State: AOJu0YxYL5Y1OlgztqU3dpQqXtixHKiTZ7fG6sP0es2O9DNgCjK09ewF
	mmlKvICOPsSeHd+CfAZh/6UU/DJFUMW38HbiuLjkcr+fk0a7N+Td3TBWTg1CX+cTAV00oHFLtWH
	ZhYcerpdD3CNplTwCRYEAWsiyVGdG2bTxhopInjyfp/103+GhnfQgcgVR9A==
X-Gm-Gg: AfdE7cmrWsdQWhsSFlZYVPA70yxddH5FY1xOOIjpiiJfYtlsFnZZb1B/SVbtyrmFvzk
	yZBpN1nL6jtRdp6gDkQ2nQuBKYasD1JVL10IwOoDsuxFDOxaxzyhDYJvunSgVALTCGPuisQaJji
	U7BH6HF/ue3EQmOUR7KjBJurOgoEMG9tc3Hb5pz2l+gPwBk8rRp/qmDWmibX7RWUUIcC7CeTIH/
	PTfjywUqMZ1CdGSRJV5gUoOwRl+nOX24J/pdBwbJuVLWFYyQ7QUdy8qX1bkb5CovFqlD0QmPOVz
	fmElr6isqVbjurwaSUMfXzum0BD1rN25Y94BSct0uLLNp4rO7US9hl1vxPymM0SApJPLg7BnWN/
	OUMLGLwtC0MnGiGKFoNPNDpsIhvsZQqCtIFbScFe3/SUe14zS9+lWQZp6pZYNXVCec6P7p3Hvvp
	EEqBQDS80fAw==
X-Received: by 2002:a05:600c:4747:b0:490:a1dc:e542 with SMTP id 5b1f17b1804b1-493b827db4dmr55140395e9.6.1782828612954;
        Tue, 30 Jun 2026 07:10:12 -0700 (PDT)
X-Received: by 2002:a05:600c:4747:b0:490:a1dc:e542 with SMTP id 5b1f17b1804b1-493b827db4dmr55139705e9.6.1782828612365;
        Tue, 30 Jun 2026 07:10:12 -0700 (PDT)
Received: from ?IPV6:2a0d:3344:5521:6b10:2eb7:f61a:75:4534? ([2a0d:3344:5521:6b10:2eb7:f61a:75:4534])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-493b8c79baasm74104705e9.7.2026.06.30.07.10.11
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 30 Jun 2026 07:10:11 -0700 (PDT)
Message-ID: <3dab7c8e-aed3-41f2-97e0-558c7a82f925@redhat.com>
Date: Tue, 30 Jun 2026 16:10:09 +0200
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net v3 1/1] net/sched: sch_teql: Introduce slaves_lock to
 avoid race condition and UAF
To: Jamal Hadi Salim <jhs@mojatatu.com>
Cc: netdev@vger.kernel.org, davem@davemloft.net, edumazet@google.com,
 kuba@kernel.org, horms@kernel.org, victor@mojatatu.com, jiri@resnulli.us,
 security@kernel.org, zdi-disclosures@trendmicro.com, stable@vger.kernel.org
References: <20260628111229.669751-1-jhs@mojatatu.com>
 <de40b1a5-663e-43ab-9fb7-5a49f029cc4b@redhat.com>
 <CAM0EoMn-6Ayjd3mxsiifDXwN1zdefx9eiRk_wWRpsuEh22LziA@mail.gmail.com>
Content-Language: en-US
From: Paolo Abeni <pabeni@redhat.com>
In-Reply-To: <CAM0EoMn-6Ayjd3mxsiifDXwN1zdefx9eiRk_wWRpsuEh22LziA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 6/30/26 1:49 PM, Jamal Hadi Salim wrote:
> On Tue, Jun 30, 2026 at 7:15 AM Paolo Abeni <pabeni@redhat.com> wrote:
>> On 6/28/26 1:12 PM, Jamal Hadi Salim wrote:
>>> The teql master->slaves singly linked list is not protected against
>>> multiple writes. It can be mod'ed concurently from teql_master_xmit(),
>>> teql_dequeue(), teql_init() and teql_destroy() without holding any list
>>> lock or RCU protection.
>>>
>>> zdi-disclosures@trendmicro.com has demonstrated that the qdisc is freed
>>> after an RCU grace period, but teql_master_xmit() running on another
>>> CPU can still hold a stale pointer into the list, resulting in a
>>> slab-use-after-free:
>>>
>>> BUG: KASAN: slab-use-after-free in teql_master_xmit+0xf0f/0x16b0
>>> Read of size 8 at addr ffff888013fb0440 by task poc/332
>>> Freed 512-byte region [ffff888013fb0400, ffff888013fb0600) (kmalloc-512)
>>>
>>> The fix?
>>> Add a per-master slaves_lock spinlock that serializes all mutations of
>>> master->slaves and the NEXT_SLAVE() links in teql_destroy() and
>>> teql_qdisc_init(). teql_master_xmit() also takes the same slaves_lock
>>> around those updates.
>>> Annotate master->slaves and the per-slave ->next pointer with __rcu and
>>> use the appropriate RCU accessors everywhere they are touched:
>>> rcu_assign_pointer() on the writer side (under slaves_lock),
>>> rcu_dereference_protected() for the writer-side loads (also under
>>> slaves_lock), rcu_dereference_bh() for the loads in teql_master_xmit() and
>>> rtnl_dereference() for the loads in teql_master_open()/teql_master_mtu(),
>>> which run under RTNL.
>>> Pair this with rcu_read_lock_bh()/rcu_read_unlock_bh() around the list
>>> traversal in teql_master_xmit(), so that readers either observe a fully
>>> linked list or are deferred until the in-flight mutation completes. The two
>>> early-return paths in teql_master_xmit() are updated to release the RCU-bh
>>> read-side critical section before returning, since leaving it held would
>>> disable BH on that CPU for good.
>>>
>>> Fixes: 1da177e4c3f4 ("Linux-2.6.12-rc2")
>>> Reported-by: zdi-disclosures@trendmicro.com
>>> Tested-by: Victor Nogueira <victor@mojatatu.com>
>>> Signed-off-by: Jamal Hadi Salim <jhs@mojatatu.com>
>>
>> Looks good, thanks!
>>
>> Please note that sashiko/gemini found a pre-existing issues which may
>> require a follow-up/separate fix:
>>
>> https://sashiko.dev/#/patchset/20260628111229.669751-1-jhs%40mojatatu.com
>>
>> (the 2nd one in the above link, IDK how to generate a direct link to a
>> specific comment)
> 
> I just sent v4 which covered that but i will send a followup instead
> if you already applied.

The PW bot is went on vacation and no 'patch applied' notification is
reaching the ML; v3 is already applied.

> BTW: What is the ruling on when Sashiko finds a pre-existing issue?
> Should we address that as a separate follow-up patch? It is unclear
> what the policy is.

The general guidance is that pre-existing issues should be addressed
separately.

> This teql patch was one of the hardest to deal with in terms of
> reproduciability and the fact sashiko kept coming up with pre-existing
> issues - including the one Simon and I were discussing. Note: None of
> the pre-existing issues affected reproducibility at all although i am
> sure one of the AI-kiddies reading the sashiko reports will find a way
> to create a poc (this is why i entertain fixing them when they look
> simple enough)
Not an ideal situation both ways (which is increasingly the case).

Addressing incrementally pre-existing issues can lead to an huge/endless
number of iterations when touching some unfortunate area (4 is _not_ a
big number ;) delaying the actual fix indefinitely.

/P


