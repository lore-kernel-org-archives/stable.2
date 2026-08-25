Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 92C693DE430
	for <stable@vger.kernel.org>; Tue, 25 Aug 2026 09:43:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787651027; cv=none; b=YtyeLYyHDy2t7FRgE2H2cnaQByWc+s+bEmbNCp87uUUkhIWkfmF2Iol/6Q8uvRg6DF6Oa8zMN+l8roXSAWCwX++NRr2js01KZ9PCoJnQIUCU+SzkDroKdTmVYWFW+6MtPYalrulqwEpECiTak3xaZQN0hQ9Y9TBVcuCEUQo7mjM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787651027; c=relaxed/simple;
	bh=mhiYnl+gernWAPvHo7mQ/8wqLE+pcYamLw1rCTnplfY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=SwKGkmR6Uv1rEUPcp76WKOhJFyVfdEKbVdG9YO5fKVie7NK+SwHMBRVL6fj7Yl5XuMakNrMYISCOIrx5NsVn7JIu6anVf1T91Y0xll3QdhoTWuNrKYlS4cwMrasVg/yeY/Jw77G7uu1/5vdqQRs/3ZJl5i9TGR3zlavaL15SRhw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=g0CaBNA5; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=oqrtITXN; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="g0CaBNA5";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="oqrtITXN"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1787651024;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Bb9SRFUspKocDJKx5xpLMfOx3Raa6741IhcUh4pMwnw=;
	b=g0CaBNA5c+XoYU+SjMKaVjyYVMy+FKD+zzyrjsrQOdOXiVqyMc9nb2wpRnrEoxYSNeT6Eh
	8BxOukFeXn4JY4Qo/CG+25Vqp3J/CHnmtul3ynps4GRlm9nZSNm22QvbztZSQ6l4IPIo+3
	EkOn3U8Kqs3Aw+j23q50RILDKPPc+l0=
Received: from mail-ed1-f70.google.com (mail-ed1-f70.google.com
 [209.85.208.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-313-tS7KyIvSPeyfJsUm9gYmFQ-1; Tue, 25 Aug 2026 05:43:41 -0400
X-MC-Unique: tS7KyIvSPeyfJsUm9gYmFQ-1
X-Mimecast-MFC-AGG-ID: tS7KyIvSPeyfJsUm9gYmFQ_1787651021
Received: by mail-ed1-f70.google.com with SMTP id 4fb4d7f45d1cf-6a5c483cdc7so820939a12.3
        for <stable@vger.kernel.org>; Tue, 25 Aug 2026 02:43:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1787651020; x=1788255820; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:content-language
         :from:references:cc:to:subject:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=Bb9SRFUspKocDJKx5xpLMfOx3Raa6741IhcUh4pMwnw=;
        b=oqrtITXNvNzFr7s1UCGokW4uDkwp0jBxeBLQLX3farZINrpsyV3U1JwRyPqtrLVMuM
         w5wazkx5j7sEcJJF4SsCy/77g5AR8OSt+i1caoNSGh6GqXNWa5UlCPzhhNmBC0o39RNz
         DwEcI9N8pVUxBIWHhZJC1kKiCL3Vwg/s55m71NfkN+GP7FxHZGb8HSDS0ucFDVz3eUTs
         ohLjMq7W47CLWdbo0y2slQ+tomf5zReNabD/nhsYxkcy/DFwY6GkElieurfqMTYWQHm0
         9Q522NP54eT86FZGvj2kDzDdN5V8SviERIeAlDMNWsqLfEX6W9QmepWAnmBZOtuHtLkB
         wZDQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787651020; x=1788255820;
        h=content-transfer-encoding:content-type:in-reply-to:content-language
         :from:references:cc:to:subject:user-agent:mime-version:date
         :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=Bb9SRFUspKocDJKx5xpLMfOx3Raa6741IhcUh4pMwnw=;
        b=ZlW4prrdVBZdnBAtmYkxC0HkZM71Fw+rf4PRCADcSdx5XwMOF0OQ88m+fNQWMi7P2p
         nBL+juyyWbwZoyMX1vHZegNDZGbrQ5mExNiIAq/gk9uKjDaVJfCrWKW+17NkjmxgP3E+
         tgjZSzG/1+AfmTx8cCp8mbJA8tdxdekZw/Y8Hzpb+adk6yCvQ94bYMLYNIWH4y+wAqq6
         kgaXeoMbLpVgmwwrb+VUEjsLagXied/d7uw7fXv4UGKrsSlx3r6I0mULHnXoP0BdJO5M
         tn/TqpaSKv1WOrOzqOmgIIk3RN9CaucPYITYK7p319JFd8a4qpqJqW2JDxf5tcSMnc1D
         jFcw==
X-Forwarded-Encrypted: i=1; AHgh+RrJ3EXnfCUQwJxLvkjxvRLaUnFlOo0YQGxsWn7cMieZKe2ONjWn/oU1QNPkplxEGrxIOut1wzw=@vger.kernel.org
X-Gm-Message-State: AFuF++mluyWQcoFMEhpEnMyED4+SiWF+OvnDOJALdjgsNc8bxhtWTtu4
	HbfOUWDmrrBdjRrWNp/9cwNqUZwQZmJ+wzZ4ZzBf8lZGc9GdDAnuLj2tjg4L4FrrP/rfD+IBwUO
	dpvjdNpKgppF1LwRKAwJ1/LbED/yUDlA14+N8MpP4/bSyVEL5Ocq6mr75cQ==
X-Gm-Gg: AR+sD12UnZCTMXKdWlCm6SZ3J0J8dtk1SQ/+hOXpxHoA8J8+ijGzBdybhUggbDxVWM/
	od0BD9J13eatQ2N2UCgpxdIRHf4AE6T+XZlW7sCd0dqsfWh1UGNgd9IPLHVh5qlQvLiXzgLRExJ
	NPA/qiL/3Y2se1VdRaOgiJZu1uiwB361PGcTwEqyvUcTHA0QvDDjuZChLH5F7LQ4gd+80eZobkX
	AgbaJ8RZewn5SrH71TW1Wcn0r2YO3aKh53jywnPsot5H5Eo+iK4Ry7N/fnAnTyCsYorjh26WQjk
	k2OyS7y4FCdEEsB5xfe/LO4TR+5OXs6YfjI6nIj8aW890DffD79sHDp5c3kKc4/MDXQO4FXinXY
	LXtjLiBZAo+xQ2sEuB8DrBeAKKJF40LlHprQkPOHCR9IARCYCjQbGhORUEj4qgF+9gnu9eCWK
X-Received: by 2002:a05:6402:2187:b0:6a3:905b:3c40 with SMTP id 4fb4d7f45d1cf-6a42f1d0649mr36483737a12.8.1787651020648;
        Tue, 25 Aug 2026 02:43:40 -0700 (PDT)
X-Received: by 2002:a05:6402:2187:b0:6a3:905b:3c40 with SMTP id 4fb4d7f45d1cf-6a42f1d0649mr36483690a12.8.1787651020227;
        Tue, 25 Aug 2026 02:43:40 -0700 (PDT)
Received: from [192.168.188.103] (ip46-47-231-195.pool-bba.aruba.it. [195.231.47.46])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-6a59e1d741asm12982348a12.27.2026.08.25.02.43.38
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 25 Aug 2026 02:43:39 -0700 (PDT)
Message-ID: <4d9d542e-e25d-4ba4-b7c4-e51c82f3732d@redhat.com>
Date: Tue, 25 Aug 2026 11:43:37 +0200
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net v3 4/6] net/sched: fq_pie: clamp default quantum to
 avoid signed overflow
To: Jamal Hadi Salim <jhs@mojatatu.com>
Cc: netdev@vger.kernel.org, Jiri Pirko <jiri@resnulli.us>,
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Simon Horman <horms@kernel.org>,
 "Mohit P. Tahiliani" <tahiliani@nitk.edu.in>,
 "Sachin D . Patil" <sdp.sachin@gmail.com>,
 "V. Saicharan" <vsaicharan1998@gmail.com>,
 Mohit Bhasi <mohitbhasi1998@gmail.com>, Leslie Monis
 <lesliemonis@gmail.com>, Gautam Ramakrishnan <gautamramk@gmail.com>,
 stable@vger.kernel.org, vega@nebusec.ai,
 Victor Nogueira <victor@mojatatu.com>
References: <20260822195509.112717-1-jhs@mojatatu.com>
 <20260822195509.112717-5-jhs@mojatatu.com>
 <62618ef6-28f1-4d0d-916a-96fc54dfc2e3@redhat.com>
 <CAM0EoMkwr5idTgLSfB3azrfbBasGVGXrOPSJMUpyQKkgCgZgTw@mail.gmail.com>
From: Paolo Abeni <pabeni@redhat.com>
Content-Language: en-US
In-Reply-To: <CAM0EoMkwr5idTgLSfB3azrfbBasGVGXrOPSJMUpyQKkgCgZgTw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 8/25/26 11:16 AM, Jamal Hadi Salim wrote:
> On Tue, Aug 25, 2026 at 4:33 AM Paolo Abeni <pabeni@redhat.com> wrote:
>> On 8/22/26 9:55 PM, Jamal Hadi Salim wrote:
>>> fq_pie_init() sets q->quantum = psched_mtu(qdisc_dev(sch)) without
>>> clamping. A device with a huge MTU (e.g. dummy with max_mtu == 0
>>> accepting MTU 2147483634) makes psched_mtu() return 0x80000000, which
>>> overflows the signed flow->deficit to INT_MIN in fq_pie_qdisc_dequeue(),
>>> causing an infinite loop and soft lockup. Emulate fq_pie_policy which
>>> is already bounded to [1, 1 << 20]; clamp the default to [256, 1 << 20].
>>> 256 matches fq_codel's floor and is a sane minimum for a DRR quantum.
>>>
>>> Conditions to recreate the bug: a device whose MTU (plus
>>> hard_header_len) wraps psched_mtu() into the sign bit (e.g. a dummy
>>> device with max_mtu == 0 accepting MTU 2147483634). Requires
>>> CAP_NET_ADMIN in a user namespace.
>>>
>>> Fixes: ec97ecf1ebe4 ("net: sched: add Flow Queue PIE packet scheduler")
>>> Reported-by: vega@nebusec.ai
>>> Tested-by: Victor Nogueira <victor@mojatatu.com>
>>> Signed-off-by: Jamal Hadi Salim <jhs@mojatatu.com>
>>> ---
>>>  net/sched/sch_fq_pie.c | 3 ++-
>>>  1 file changed, 2 insertions(+), 1 deletion(-)
>>>
>>> diff --git a/net/sched/sch_fq_pie.c b/net/sched/sch_fq_pie.c
>>> index 069e1facd413..b27d95418707 100644
>>> --- a/net/sched/sch_fq_pie.c
>>> +++ b/net/sched/sch_fq_pie.c
>>> @@ -427,7 +427,8 @@ static int fq_pie_init(struct Qdisc *sch, struct nlattr *opt,
>>>       pie_params_init(&q->p_params);
>>>       sch->limit = 10 * 1024;
>>>       q->p_params.limit = sch->limit;
>>> -     q->quantum = psched_mtu(qdisc_dev(sch));
>>> +     q->quantum = clamp_t(u32, psched_mtu(qdisc_dev(sch)),
>>> +                          256, 1 << 20);
>>
>> Sashiko thinks that the soft lookup is still reachable via pie_change:
>>
>> https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20260822195509.112717-1-jhs%40mojatatu.com
>>
>> and has similar concerns for patch 6/6, too. It marks the issues as
>> pre-existing, but AFAICS they overlap with the things addressed here.
>>
>> WDYT?
> 
> You are right, they overlap. I had them as followups (with a few
> others derived from the sashiko feedback with justification that the
> v3 init-path clamps are independently correct and the stab cap already
> mitigates the change-path worst case to a stall; but those two a
> (adding max(256U, ...) to both fq_pie_change() and sfq_change(),
> matching the fq_codel_change()) are more serious.
> So if you'd prefer a v4 respin of the whole series, I can do that.

I initially did not notice that the _change path would lead to
"upper-bounded" stall, I think a follow-up is fine.
> Sashiko is a double edge sword - i think code quality is improving but
> it feels like the work load has doubled ;->

FWIW, I agree with the "double edge" assessment.
A reference we must keep in mind is that there is no way back, so we
need to adapt somehow.

> Here's what i had as followups (some still to be vetted, just noting
> what sashiko is stating to be reviewed later when cycles available and
> potential followup patches sent):
> - sch_dualpi2 unclamped psched_mtu
> - sch_pie unclamped psched_mtu → AQM disable / div-by-zero
> - hhf TCA_HHF_HH_FLOWS_LIMIT unbounded
> - fq_pie_change() / sfq_change() 256 floor missing (one that you bring up here)
> - DRR/ETS quantum=0 spin (have a patch, was reported already as a bug by vega@)
> - Consider two separate clamps for fq_codel/sch_codel (nipa
> gpt-5-6-sol-3-15): quantum in [256, FQ_CODEL_QUANTUM_MAX], mtubounded
> separately (no 256 floor on mtu)
FWIW, LGTM!

/P

