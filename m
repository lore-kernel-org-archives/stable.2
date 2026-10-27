Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.228.5
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793109201;
	b=CxGv7O19tzxjMrxEYdhH757hUaPkxYKtYxg6hyGqTaQ5RrCBLg1Kyahe3Swa1zdYewNC
	 Ulf8VwJYt92DLQzA010PIN0RmU0qTCwt7ISh99Wm9mvnSZe3YM4ihaqRUhoSLKStSaJGj
	 WTnfHzPjgvaPed7MRnJo9WFKLFCxxdNyrZyFtmNabxaTX1olOefZoa+iGwR0yFZlboX2j
	 Vs8p1fHJRtPMGimT8eWO5HxoEJ8UCaX015tcBxOk2LrlHWSYmSF4Yxlt+6eadjnxIWzbj
	 17SnOyJ55a5d1Rfl4IHwbJ6tTEUOrmkx4x75DfdSKOg3wQScUU70NZ7ojmcNMyPnXJQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793109201;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To;
	bh=seoLYPoPk5mt5piMxvDgKwZd5rMW4AsZNb6zEMwZMTU=;
	b=cJDD3tvKlVL/13LrVfJMpppg1TY3quluIZjgzo/t+J7YgwuWGwmCNmCCkWV0G0Y3BLqL
	 bYvfQbprDrXP6aHuZ32T1BuOZ6ojjM0T7uXcWZs/XVRQYq9D7Zxl+mrZduwesiBoNk8De
	 Y29HZwOuDhmBUnYZr0zvUYwKO/BbmxYyCmCDTakslZ47PkyFrl35XUx1tOMZ53LJPS24w
	 mqd6t6Xwzp3QbzLC1ayFNDyQVmTn5/mXykkZtzElndFTReS57h1Z45Rx67x99+qk/79yu
	 gL8K1NEP8sCul0SOE6lgbai8YGvSFZ87oaac9qmH3VcB4+Y3lZFL98J61CG4GP5XTyg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b="ao/YHcb0";
	arc=none smtp.remote-ip=74.125.228.5
Received: from mail-pz2-f5.google.com (mail-pz2-f5.google.com [74.125.228.5])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3D3CE606A33B
	for <stable@vger.kernel.org>; Tue, 27 Oct 2026 13:53:21 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 3D3CE606A33B
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=ao/YHcb0
Received: by mail-pz2-f5.google.com with SMTP id 41be03b00d2f7-cc7c286026aso1658855a12.0
        for <stable@vger.kernel.org>; Tue, 27 Oct 2026 06:53:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793109200; x=1793714000; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=seoLYPoPk5mt5piMxvDgKwZd5rMW4AsZNb6zEMwZMTU=;
        b=ao/YHcb0a9EZt2JZ0Jw43sww0NwPRYR9JMmJw1T10j5LNFrQXEBicgmlxBSANOKCg+
         /XTzCfSG6FkkshfhKJjgOm+6/i8qfeB13uF80OHWQmN70t8gBUzKAJ5ZUbehP6EqBPH3
         3MHBwG+3gclSvnpjCid/OXjbXF/R2qgkdySo1CrVILv/4zVG7T4SFPWxCifPlYWhyf9R
         FKOjZlQbuXOYQ3O1RcnHjr/cE9FM8Xn5PcaMAbNG89Rzjs8ylNX7UXqxWELflCPDKe3N
         WBrLE+r2H6F+rfJUAUoBYFHAf6fN1fZN3BrBfkYQ/4VwK/wiCEd1ywrCj3YOGn9ieoXj
         KN1A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793109200; x=1793714000;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=seoLYPoPk5mt5piMxvDgKwZd5rMW4AsZNb6zEMwZMTU=;
        b=QBS7dkuVXpILvfZaKU0WVkdziV8aPxKBtu2JLrxpiuBZe2gvtw8pbUXlGyV+wAdjv/
         eNrNEcD6b2HUKffIbfOtSh4Q5xv4NguJaxsxWk8abbqRXmKJQgORIW794ie9BYV2cCUC
         ldIwyWl2tKZzFphVbJGNZVA4ltA4u8EmY9BDA5hnpDxedYiZyTmp5kJdjw1/XECEurLd
         5YgZu7SJ/RXNktuHzirLO8/f/xNkuvUmECEh97C87tSXGKXHjqJn+cRQvYpdywQcGO01
         /fDJl/tdA/wIDEC4OQuZsJE2/PeR89kILnNwSspuuuSSu0nagkMVmov80ILDoEoCUPlP
         6w3g==
X-Forwarded-Encrypted: i=1; AKwUvBzThzUJBxHftwoDiLVCvgD1JlE5TvTFLSp5mIEW1AGxqk0duQSJ4r9Zd8ZvLlRi1tf4DSX6PMM=@vger.kernel.org
X-Gm-Message-State: AFq9FYLTtXQXoJXk0ztGHLoLMcBzeibHmV7XyUH9T1FgNQsS+i4DUnWl
	aVk8ZiEPwtVaW+oLOktkoQwMLnQzbBKRwAqBj2vPAZsOrF8w8x1N+olj
X-Gm-Gg: AYBFou1ENkgA0Y4VNGfJ4PMKoPUXmkN/ibSLsyCKvQf7Ga3ickvFhqhRSChvrSkUkxQ
	GAjKqCufX4C19FQU4pa1uiHdvV//Q4lj362Rw/EBZszZmkdhO7vQnnCb80DHxeqG3ZSXH/maBoy
	Yi6jXdkVRrvYgwlOJQoWUrUrM5NmWlJ7RyMRZuw/UYschWbISWacXRAYC6glg1nU6lOcFdq4Ps8
	XfoDUhoaWjh1tJ/gNY3C4G0Bi60tup1v2ObZNZ8HiXMy8+UoZ0IzHi8ctbXs01ZR1ZNPhaEv/XA
	vJFwECAE9Kf/d0UdUKd1WAM30U3jPk5wNHA4x1bqjPVrzIMf5c8tpf+il1MCwBAI96XATn+5ymV
	MKQERpZEmUvKYn5YqISR3gxL9TVrOwc36pMMTYQjM+9UARWEuKBmh1uKOXGw7U0E30NqebCggbk
	W2Mh0DAV0IfnjcoSCse7rRpStDNHi5eLcjzi8CQChOZQI5WM4Mhq6tq35gvtYtvKTJPrTCWGkDM
	14JtUsjOub/R5hVQ6dG8eGMyvLAyzSpLBWdJzp6NgPaDGpQGPwQsEyH2qRnxG1BCJblebKG7gWf
	HmXu7O0pHVEuIbs5gCAdX8R6O27V5UR1ilD+AWmCIcOl8vZ3viU0/nSQqGRYYmEEafeZpn7CLrq
	a5fOBKhpgRAHc5ntl1WPTVwgWlDYb7wn0MLAr4jkgBY1hny7ipnJ/+8ou09yyK3G5XHZ2Ygr+PT
	N6
X-Received: by 2002:a05:6a00:3a17:b0:89e:779b:cff with SMTP id d2e1a72fcca58-8a364b4ce5fmr8249181b3a.6.1793109200511;
        Tue, 27 Oct 2026 06:53:20 -0700 (PDT)
Received: from wang0.localdomain ([133.11.33.33])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-8a6a5f652aasm50188b3a.17.2026.10.27.06.53.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 27 Oct 2026 06:53:19 -0700 (PDT)
Date: Tue, 27 Oct 2026 22:53:16 +0900
From: Lianjie Wang <karin0.zst@gmail.com>
To: Paolo Abeni <pabeni@redhat.com>
Cc: "Michael S. Tsirkin" <mst@redhat.com>, 
	Jason Wang <jasowangio@gmail.com>, Eugenio =?utf-8?B?UMOpcmV6?= <eperezma@redhat.com>, 
	Andrew Lunn <andrew+netdev@lunn.ch>, "David S. Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@kernel.org>, Jakub Kicinski <kuba@kernel.org>, 
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>, netdev@vger.kernel.org, virtualization@lists.linux.dev, 
	linux-kernel@vger.kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH net] virtio_net: reject stats replies for queues outside
 the request
Message-ID: <auCkXHi6IulXgm7v@wang0.localdomain>
References: <20261022182710.2055771-1-karin0.zst@gmail.com>
 <096bd22b-c569-4998-a943-0381c3fa9998@redhat.com>
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <096bd22b-c569-4998-a943-0381c3fa9998@redhat.com>

On Tue, Oct 27, 2026 at 01:06:41PM +0100, Paolo Abeni wrote:
> On 10/22/26 20:26, Lianjie Wang wrote:
> > [...]
> > @@ -4976,6 +4977,10 @@ static int __virtnet_get_hw_stats(struct virtnet_info *vi,
> >   	for (p = reply; p - reply < res_size; p += le16_to_cpu(hdr->size)) {
> >   		hdr = p;
> >   		qid = le16_to_cpu(hdr->vq_index);
> > +		if ((qid < first_vq || qid > last_vq) &&
> > +		    !(enable_cvq && qid == vi->max_queue_pairs * 2))
> > +			return -EINVAL;
>
> I think the above check could be simplified to:
> 		if (qid < first_vq || qid > last_vq)
> 			return -EINVAL;
>
> squashing the following in virtnet_get_hw_stats():
>
> -       if (enable_cvq)
> +       if (enable_cvq) {
>                 virtnet_make_stat_req(vi, ctx, req, vi->max_queue_pairs * 2, &j);
> +               last_vq++;
> +       }
>
> (likely with some meaningful comment).

Thanks for the review!

I looked into this, and I think last_vq + 1 matches the control vq
only when all queue pairs are in use. The control vq index is
max_queue_pairs * 2, while last_vq is curr_queue_pairs * 2 - 1 for
ethtool -S. After ethtool -L lowers the queue count, or when probe caps
curr_queue_pairs at num_online_cpus(), last_vq + 1 is the receive vq at
index curr_queue_pairs * 2, which is not in the request. The simplified
check would accept a record for it. Since the ethtool -S array has
slots for only curr_queue_pairs queue pairs, with the transmit slots at
its end, virtnet_fill_stats() would write the counters of that record
into the transmit slots, and can write past the end of the array.

Would you like me to keep the current check or change it in some
other way?

As for the comment, I would add the following above the check in v2:

		/* The control vq comes after all max_queue_pairs pairs, so it
		 * exceeds last_vq + 1 when fewer pairs are in use.
		 */

Thanks,
Lianjie Wang
