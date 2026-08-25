Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1EA673E3C50
	for <stable@vger.kernel.org>; Tue, 25 Aug 2026 08:33:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787646811; cv=none; b=gYCphYbIO0KcPYfb2Z+3W9g0hqOckUblxUll4a1Ov1FbiU2aburJJQuHKClT47dr6GTBMiEbLYiP7X/IcEpLg5TlAve8XpO5LjdT4KnK18olGKFQUCv/3VHKawrfDHE6NGZy0hCPpgSz4GveZnTp/1iLao8YO/9Slscq+sjMzLY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787646811; c=relaxed/simple;
	bh=fWBWy64iKsCBFztcv+VWls7yQvkNtUNfFO4diiqfAXI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=N8+sGdpSJgyjzeTSmxnSnLGowrje1/vkwDP4bmtBmP/n3hZuMVUEnZMqjQqK10L8ojL1thzuJZE0RoLSDMNmCIEGdrP78S4UVFIfZF9aes4naWuX3Crp7vfgJeBV3LV6ocwoxjYKQQj2odtwZuUc8sjOLQcb9kZZpZ8ZoaH3/6U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=MBxAWYe9; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=LDnCWZCh; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="MBxAWYe9";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="LDnCWZCh"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1787646809;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=eWBD3iJL83l1SuUqrEcE1y4U7JlqfeuMYAAUlvs1TeI=;
	b=MBxAWYe9hYeE2ao76nRMRB9097+/NE96agSvIEuvPFc6FloWNRqh/QUYGJ5UfmQ+wpxxg3
	H8akLv+kKs82RIEn5rzMNIrbmmMC86SiCVUlKLgj/OS/8aEYTzecDrVbbFUGealsW8ilJG
	0wM+/j+pWhYD3pH7NheYqAgdl+guxnE=
Received: from mail-ed1-f72.google.com (mail-ed1-f72.google.com
 [209.85.208.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-695-XFRYju5cPqKOkm1NPr1c7g-1; Tue, 25 Aug 2026 04:33:26 -0400
X-MC-Unique: XFRYju5cPqKOkm1NPr1c7g-1
X-Mimecast-MFC-AGG-ID: XFRYju5cPqKOkm1NPr1c7g_1787646805
Received: by mail-ed1-f72.google.com with SMTP id 4fb4d7f45d1cf-69abf97d53aso4486577a12.3
        for <stable@vger.kernel.org>; Tue, 25 Aug 2026 01:33:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1787646805; x=1788251605; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:content-language
         :from:references:cc:to:subject:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=eWBD3iJL83l1SuUqrEcE1y4U7JlqfeuMYAAUlvs1TeI=;
        b=LDnCWZChj7xQkek9pge7fRybuz6XJ6VIMdh4aB0HorddldiodU0kMS5baszmXAqG4n
         ARTFU/EFi2N4zllkD1xvW+QddD9U0Fagx+j2T61005yz9tX4/d9ReCL73x8bW4Sgs6EV
         BVIGJLunu52rBzGq/KP0I5HhajtRMgQPk4Z0ZNL/w2Ylf/ir7A7or+lVyadDSxJx6zvu
         C2S38D6OajPgKfaeNmrJpk6Di6EOLmCZ8NYPE7CXFAhDZtAnonemFqHyVTBRyjZR7htY
         L8pESCV8GxfcqahiQW0WMjNssjCWxQ5ewEZpZXBMM8KtMlB3nIeHnWILZJYy+XqCnIOU
         iKZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787646805; x=1788251605;
        h=content-transfer-encoding:content-type:in-reply-to:content-language
         :from:references:cc:to:subject:user-agent:mime-version:date
         :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=eWBD3iJL83l1SuUqrEcE1y4U7JlqfeuMYAAUlvs1TeI=;
        b=BHgTTi4B1K6tMR+Ifd+ZshXnN67iD17pjWFKlvpbxQTZMJQHEK+SeNUYOjBvoTHdxO
         /Yszp5vssPaI52nxY26gSx7HdRnRnRi2oR+GtqArEknYacwvgfmfAxt+ES3JGsPp1E3d
         efzbuV/tITsSGmXEFkEVaYP+fqYxjgE5vkoQhqvGWrTYBKJ+sghYN56ao5WAXyCmHF6H
         2zCiuEwi/CC9Brv42RGVzrEX35NZlCzkLhDN2qTF6t8JzbT1zGsB76BH8SA6g/L1y+0O
         lXaqZxkbPfhHY3ppnSAEp7F48jEwqGymYQh8/vPkR1dhcf6v49FAVcQGacP9CPGVSrwR
         Cd1w==
X-Forwarded-Encrypted: i=1; AHgh+RpXijmyzUIeC6aJury/BdlH0bwDZtaID7lKvuNfeJGJuO0l7JFfWQAukKVOUfiDuPeegoUjsHw=@vger.kernel.org
X-Gm-Message-State: AFuF++n5pSt6bJEd/O8GIqGOUHGLAa5YRO8tdv7ZmO63/Dnhdq7DlE18
	Rd5X6hwtKdrwyMD6JyljSInflKAx4ZC90iOcXwD6KgAGsC3RJMJhl+xCF8Cr52y7CXxs/VlMtV1
	TPfKM3dxqQESq6uoXvOrHNF+K8bLGJXGdhDAUlAFBXdb/ybEXjdCcZJPpSw==
X-Gm-Gg: AR+sD11C3QKMHn2Vol+RukM7Y3/RkYfbTkIM3gig3MssgWt6RTS+PJMt9hqp11owWV6
	523QgBCRCiw2QjkR75SjgZ+grsb6X4xJPUwf9YHRIxSemX7chZCwqykgnLpPlD4OTPSftCxL6RU
	+oVJKKVZmcspGzNstweTZOiv6gIlAGnDcFmS+cECXyT8GhESWm/yl9Qk6E+ywavLz+bsf0UW/42
	eWp99BcN0dNvw6OwP/nCWN4WXioNu7YdYEKkV2lwQdUtrAvwkCcgxz5+EaSsnOhHIaxlEIFQfyc
	4BGzFcXrNF+2yXYWVwIws7p37B1JzPPyScBcf97BHcOrvOO2QlF40YP5fYwSspd642/wUR4XYcl
	sok8uSbEqM/0EcMEtQ0EVSymBtDU9lir5nwtxwSSyo0u9pVVKEkdqcS/sbnxSb6o/PfU2vFXn
X-Received: by 2002:a05:6402:52cb:b0:6a1:f7f4:200b with SMTP id 4fb4d7f45d1cf-6a42f1d6913mr37890513a12.12.1787646805113;
        Tue, 25 Aug 2026 01:33:25 -0700 (PDT)
X-Received: by 2002:a05:6402:52cb:b0:6a1:f7f4:200b with SMTP id 4fb4d7f45d1cf-6a42f1d6913mr37890401a12.12.1787646803937;
        Tue, 25 Aug 2026 01:33:23 -0700 (PDT)
Received: from [192.168.188.103] (ip46-47-231-195.pool-bba.aruba.it. [195.231.47.46])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-6a59e2ddad2sm12253271a12.30.2026.08.25.01.33.21
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 25 Aug 2026 01:33:22 -0700 (PDT)
Message-ID: <62618ef6-28f1-4d0d-916a-96fc54dfc2e3@redhat.com>
Date: Tue, 25 Aug 2026 10:33:19 +0200
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net v3 4/6] net/sched: fq_pie: clamp default quantum to
 avoid signed overflow
To: Jamal Hadi Salim <jhs@mojatatu.com>, netdev@vger.kernel.org
Cc: Jiri Pirko <jiri@resnulli.us>, "David S. Miller" <davem@davemloft.net>,
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
 Simon Horman <horms@kernel.org>, "Mohit P. Tahiliani"
 <tahiliani@nitk.edu.in>, "Sachin D . Patil" <sdp.sachin@gmail.com>,
 "V. Saicharan" <vsaicharan1998@gmail.com>,
 Mohit Bhasi <mohitbhasi1998@gmail.com>, Leslie Monis
 <lesliemonis@gmail.com>, Gautam Ramakrishnan <gautamramk@gmail.com>,
 stable@vger.kernel.org, vega@nebusec.ai,
 Victor Nogueira <victor@mojatatu.com>
References: <20260822195509.112717-1-jhs@mojatatu.com>
 <20260822195509.112717-5-jhs@mojatatu.com>
From: Paolo Abeni <pabeni@redhat.com>
Content-Language: en-US
In-Reply-To: <20260822195509.112717-5-jhs@mojatatu.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi,

On 8/22/26 9:55 PM, Jamal Hadi Salim wrote:
> fq_pie_init() sets q->quantum = psched_mtu(qdisc_dev(sch)) without
> clamping. A device with a huge MTU (e.g. dummy with max_mtu == 0
> accepting MTU 2147483634) makes psched_mtu() return 0x80000000, which
> overflows the signed flow->deficit to INT_MIN in fq_pie_qdisc_dequeue(),
> causing an infinite loop and soft lockup. Emulate fq_pie_policy which
> is already bounded to [1, 1 << 20]; clamp the default to [256, 1 << 20].
> 256 matches fq_codel's floor and is a sane minimum for a DRR quantum.
> 
> Conditions to recreate the bug: a device whose MTU (plus
> hard_header_len) wraps psched_mtu() into the sign bit (e.g. a dummy
> device with max_mtu == 0 accepting MTU 2147483634). Requires
> CAP_NET_ADMIN in a user namespace.
> 
> Fixes: ec97ecf1ebe4 ("net: sched: add Flow Queue PIE packet scheduler")
> Reported-by: vega@nebusec.ai
> Tested-by: Victor Nogueira <victor@mojatatu.com>
> Signed-off-by: Jamal Hadi Salim <jhs@mojatatu.com>
> ---
>  net/sched/sch_fq_pie.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/net/sched/sch_fq_pie.c b/net/sched/sch_fq_pie.c
> index 069e1facd413..b27d95418707 100644
> --- a/net/sched/sch_fq_pie.c
> +++ b/net/sched/sch_fq_pie.c
> @@ -427,7 +427,8 @@ static int fq_pie_init(struct Qdisc *sch, struct nlattr *opt,
>  	pie_params_init(&q->p_params);
>  	sch->limit = 10 * 1024;
>  	q->p_params.limit = sch->limit;
> -	q->quantum = psched_mtu(qdisc_dev(sch));
> +	q->quantum = clamp_t(u32, psched_mtu(qdisc_dev(sch)),
> +			     256, 1 << 20);

Sashiko thinks that the soft lookup is still reachable via pie_change:

https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20260822195509.112717-1-jhs%40mojatatu.com

and has similar concerns for patch 6/6, too. It marks the issues as
pre-existing, but AFAICS they overlap with the things addressed here.

WDYT?

/P

