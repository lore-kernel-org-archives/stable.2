Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 008A34398E6
	for <stable@vger.kernel.org>; Tue, 28 Jul 2026 13:05:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785243930; cv=none; b=Ck/V0UeNYcHOJ1AK74wqRGeyn2giHeLvAAudkdO8vJK59EU74XkNzD0lCuxY2yM0V9+eO4vKpnX2JOHiHoj8OYfvDepGegMN5bboL6BHuP3qB5Z3JIO3Z4eUeQB3Ap00eapkIuRnBagk2hHyDDdDl/1UCJ6/OipoFd5lza/kTVo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785243930; c=relaxed/simple;
	bh=VZUu52k9Z5MfA1fYd4LT55UaXLqszf/GacD1Ov5Ezso=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=t6nA1/Am6BL3jkL/8fvQ/5DHbnPvpthdtjfo+yPWZb/jMyL/vlgsJsnGdZTvPTfTUu1A1EK88IKRg4kUFqhTx1BqpH29oVn+Xaq+cKbD7slUP9sGfQop8HuEuFFpXj1lNT3wkqMrvGOgOXGkXghGSO/K03N33pcaZE/oeMPmnKk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=gSiF+epV; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=tIKbQTzl; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="gSiF+epV";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="tIKbQTzl"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1785243926;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=tZyVt2V6D6nQ8yu5WvKNeFjpvQegaEAq/A8BjMLpajk=;
	b=gSiF+epVw11JquoDKqK1W4/fTXUabuGuu0XSiKhJy6YSd4oxtMdw0L6Xogu3J5P6eF5Avc
	zsc4/jRnzjsr0c1dWemn1F/a+aNGayi/GqXqQIa0coCE144NM6Z1wmHvATXljg1gBj/nM6
	t0UFJWEvwsP3AsAPyD27wDpP6crL3IM=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-226-wgZ0CtX-OMyTdk07p99GMA-1; Tue, 28 Jul 2026 09:05:25 -0400
X-MC-Unique: wgZ0CtX-OMyTdk07p99GMA-1
X-Mimecast-MFC-AGG-ID: wgZ0CtX-OMyTdk07p99GMA_1785243924
Received: by mail-wr1-f71.google.com with SMTP id ffacd0b85a97d-47faa02f707so763282f8f.1
        for <stable@vger.kernel.org>; Tue, 28 Jul 2026 06:05:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1785243924; x=1785848724; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=tZyVt2V6D6nQ8yu5WvKNeFjpvQegaEAq/A8BjMLpajk=;
        b=tIKbQTzl3trTEc6eTUvxFtBAGJe0m4D03TUY4ol3V1GMtUndMpQbKHhT7ZN1N5TR8H
         NzSbqKZdMegdu8/zH7D6BcfsCUKVrIwh+zJ4Cqc1BsHV9pePYsRLW1MbhW8eERWxknom
         LixUQwos8sY+Bqq+Dl9TzReb6fm4uuIF0vfBqsdipqPhBJvZt1iCFNUZcVA2eekMPZip
         x/+TZLdsAF1+Y+IlTbURqp9W1yXGPo5Xs1uK8ayulVhnGPX+13vOG3sahxorWRIGGjZk
         QD3j8KT8vTwv18zZx/j7Wjf9r7d8dDrM/jzWJAMDLyE46RR1tWhv4OnQ/rD8Bju4jm/n
         rjsQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785243924; x=1785848724;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=tZyVt2V6D6nQ8yu5WvKNeFjpvQegaEAq/A8BjMLpajk=;
        b=SUv7Ukzd1Uln8WzlCtviYdbOB1OFNE/1d9OIibh27uIiIMAk5gfK97dOTbQXOQdigE
         OvcEhRntWAFEullRdoB1ZRZ5fJrH2ff2SrDh56Y51EByfpc8Ff1CdY3BFkE6FTJOx4uB
         hOCNhE+6+ptheqIxIjkVFKVZjlbNGdjIo5TLv38mm951/XnfX1x5no4dH5Asz1sh1sNx
         Vyref6/eZjxsU9rDFxC9qUSlhuBaei0CpQD+b0zKXLGQ1uJNJe7ctOahQAnh1Pc8sHg3
         r0tKqrhAtcmvxuaBs8f/swynlXGaKqQfavLDjZYphBeE2jwAHBt+oMP2eIqAG0Uji0Le
         nc5A==
X-Forwarded-Encrypted: i=1; AHgh+Ro7voV/7Fus1R8bJYytuOunVF6HV+qZnf+kyiQU+AjRwuOZ6sPm59Wb+PX2iCbN8WRtKIb3XJk=@vger.kernel.org
X-Gm-Message-State: AOJu0YxesIHKCJSWgHOPee9IgeCh9GSSfYE51USmKSTEB8MH67qX9J+x
	FBbc22TDTg5QdA/etXydrA9VWFLThNfS0RhJ/5sfJEHvOcj5ibN8lQ5QBbI0JwE0noTKD/EFYEU
	4gJEcejRvaUHHTsuQul1YdJySAdpkdek17fXMXhwgLx/E2+DW4IcLOzLh+WI7kYSHBg==
X-Gm-Gg: AR+sD12tkm796WjdJHcXjT0JfoC7g5rgKpQgE2R81uRJjDfryhRvDCLOCclT1YX1yAw
	7/fzj+xrI593wvK0+mfhgBsQGxf3CqCU6W/eCsF3heHjULSc6kBUcA8ZjOmen9URdxari/54xUy
	wsJMI688AOhGNDluaDI+FLAbD6v5Ay3uCFHzlNh5OGDiVWf/BBf9N7CYi4MvimwqiZg6yveXCpQ
	I2jsfwIrzm3Z2MEMCx1fzCdDQyv2+lh4Lcq6lMD0AuF140QbYhdNmn8y9Qppc/fUblurDFxCINV
	iRsi6MPolE5Yor8OvbL31HTWszka2iTaDnx1V9CBq2IWRCVHZcScrFPKGCWxN4VV4S+acmKJ73p
	n4UG70LLjSdnSq54wS4DrQrqnfaRyiWyySvM1fK6gy9oJjMGq+xGU4/ejMfUzlEEjtv4l2l/zVE
	z+KQ==
X-Received: by 2002:a05:6000:310a:b0:47f:6e8b:699c with SMTP id ffacd0b85a97d-47fb1ecab50mr2857069f8f.14.1785243923411;
        Tue, 28 Jul 2026 06:05:23 -0700 (PDT)
X-Received: by 2002:a05:6000:310a:b0:47f:6e8b:699c with SMTP id ffacd0b85a97d-47fb1ecab50mr2856992f8f.14.1785243922897;
        Tue, 28 Jul 2026 06:05:22 -0700 (PDT)
Received: from ?IPV6:2a0d:3344:5521:6b10:58fd:68f:7756:389d? ([2a0d:3344:5521:6b10:58fd:68f:7756:389d])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-47f85b9a64dsm63979180f8f.1.2026.07.28.06.05.20
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 28 Jul 2026 06:05:21 -0700 (PDT)
Message-ID: <da0313c5-1060-49fb-a1a3-72197eda4d8e@redhat.com>
Date: Tue, 28 Jul 2026 15:05:19 +0200
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net 1/1] net/sched: cls_route: fix fastmap use-after-free
 on filter
To: Jamal Hadi Salim <jhs@mojatatu.com>
Cc: netdev@vger.kernel.org, kuba@kernel.org, davem@davemloft.net,
 edumazet@google.com, horms@kernel.org, john.fastabend@gmail.com,
 jiri@resnulli.us, zdi-disclosures@trendmicro.com, sh.kalluri129@gmail.com,
 victor@mojatatu.com, security@kernel.org, stable@vger.kernel.org,
 Santosh Kalluri <santosh.kalluri129@gmail.com>
References: <20260723105210.817079-1-jhs@mojatatu.com>
 <3914dd5c-77c8-4f96-8bfc-986f0a00f722@redhat.com>
 <CAM0EoMn6sLJ_OMXY8-B4RE3r9XunFB=OkHbYJ-c-VBpADyO29Q@mail.gmail.com>
Content-Language: en-US
From: Paolo Abeni <pabeni@redhat.com>
In-Reply-To: <CAM0EoMn6sLJ_OMXY8-B4RE3r9XunFB=OkHbYJ-c-VBpADyO29Q@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 7/28/26 2:37 PM, Jamal Hadi Salim wrote:
> On Tue, Jul 28, 2026 at 6:34 AM Paolo Abeni <pabeni@redhat.com> wrote:
>>
>> On 7/23/26 12:52 PM, Jamal Hadi Salim wrote:
>>> diff --git a/net/sched/cls_route.c b/net/sched/cls_route.c
>>> index bd6f945bd388..700f878fc3cd 100644
>>> --- a/net/sched/cls_route.c
>>> +++ b/net/sched/cls_route.c
>>> @@ -297,16 +297,29 @@ static void route4_destroy(struct tcf_proto *tp, bool rtnl_held,
>>>                                       next = rtnl_dereference(f->next);
>>>                                       RCU_INIT_POINTER(b->ht[h2], next);
>>>                                       tcf_unbind_filter(tp, &f->res);
>>> -                                     if (tcf_exts_get_net(&f->exts))
>>> -                                             route4_queue_work(f);
>>> -                                     else
>>> -                                             __route4_delete_filter(f);
>>> +                                     /* Always defer the free.  The direct
>>> +                                      * __route4_delete_filter() path has no
>>> +                                      * grace period and races with readers
>>> +                                      * that cached f in the fastmap.
>>> +                                      */
>>> +                                     tcf_exts_get_net(&f->exts);
>>> +                                     route4_queue_work(f);
>>
>> Sashiko fears the above would be race prone:
>>
>> https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20260723105210.817079-1-jhs%40mojatatu.com
>>
> 
> That was fixed in v2. Is there something i can do next time (message
> patchwork?) to not waste your time looking at an older version?

Usually the tool properly updates the old revision status, but sometimes
it fails do to that.

Double checking that the old revision is marked as superseded in PW
after posting the new one could help.

>>>                               }
>>>                       }
>>>                       RCU_INIT_POINTER(head->table[h1], NULL);
>>>                       kfree_rcu(b, rcu);
>>>               }
>>>       }
>>> +
>>> +     /* All filters are unlinked; no new reader can find them on the
>>> +      * chain.  Wait for in-flight readers that may still hold a filter
>>> +      * pointer and have published it into the fastmap after we unlinked.
>>> +      * Then flush the stale entries while head is still valid under
>>> +      * RTNL, matching the route4_delete() pattern.
>>> +      */
>>> +     synchronize_rcu();
>>> +     route4_reset_fastmap(head);
>>
>> This really looks like quite a big hammer.
> 
> It is.
> I viewed  it as bug fix to original intent of 1109c00547fc - that
> commit even though had the intent of protecting the fast map as as
> well (based on the wording of comment i saw).
> If performance is a big concern: another approach that maybe worth
> considering is to totally remove the fastpath. It maybe more
> performant than imposing the rcus.

Given the amount of effort involved in rtnl lock contention reduction, I
think it would be great if we could avoid the synchronize_rcu(), if it
does not block the fix for an unreasonable amount of time.

>> Since there is already a
>> synchronization point for both reader and write while acquiring the
>> fastmap_lock, I'm wondering if something alike the following could work ?!?
>> (completely untested!!!):
>>
> 
> Your approach has some holes, example misses the most dangerous part -
> destroy(), etc
> I will mull over it and see if it can be fixed to handle all the
> issues. I think it's possible i just need to put time to
> validate/test.
I would appreciate that, thanks!

Paolo

