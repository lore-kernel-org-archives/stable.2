Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=170.10.129.124
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793779841;
	b=0N9Usf2jKWwFDODhepwT5CkqrcELSlZ6nBSilb/V+RLEYqIKnZSVEP3AonInn3Q3LNgV
	 X82XHMgyiykxYgoLH88gKERi/5bsBPKywcRXJNMQSufG44O9aRFSKbNH9x43yq5IgKh9B
	 4EhbeyfIjBx3PyNhN1FFdzkiGRIwKUesMC8BnyvOu/M4vUq3McyH0tcDqCg+siDNZlUi2
	 0+Wo6QtYBk5QDsVAq57mRveMOpqTzseuZGH9jh7Lj4ThLhw6sIr1H9C3qtR4gEuFk/0lC
	 XR08ZbXtKpne4FEkEL+6nOue+PdXuv/Wi4BHggnGIGM3QSx/njMLF3kjYF5uk50ApFg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793779841;
	h=DMARC-Filter:DKIM-Signature:Received:X-MC-Unique:
	 X-Mimecast-MFC-AGG-ID:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 X-Received:Received:Message-ID:Date:MIME-Version:User-Agent:Subject:
	 To:Cc:References:Content-Language:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding;
	bh=AIXih/+g+9WTOCjrd3v2llW1L1i6Jm4IJcUxf1FA9ws=;
	b=urSIs/AnWG8prLPWgKBIv1KkXOEPNEGoJTLt6SMJ0zrVkibylhjRG4SrDA+T9uMin/N5
	 mZ+TAsCYYHoH9DrtncuPVq5PshIbRRZhm17woovLpT1Ci3JcSpGuuvEZ9tNDoOoKZj+KM
	 hkJhVpjr7zYDV/ecjiU3v6AX2VOwto+BAr0te6UpRHJ3kgUXIim8tv9WNUzIcqlrmXVxE
	 JAybp6MDkudkMmEymLYvKhetGNiHNRnk3rHMN6SfnwOR/xoSCj7W6/K1FLNNanzG5lPii
	 iUOkvOvkLV3gZpFLn9izNjE/X/4/QgH0G6JS1BLZazAoitYLKlm6h27h/gN0AntdIhA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=redhat.com;
	spf=pass smtp.mailfrom=redhat.com;
	dkim=pass header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=BfssRooC;
	dkim=pass header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=google header.b=h56TphMe;
	arc=none smtp.remote-ip=170.10.129.124
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 931F3606A332
	for <stable@vger.kernel.org>; Wed,  4 Nov 2026 08:10:40 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 931F3606A332
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=BfssRooC;
	dkim=pass (2048-bit key, unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=google header.b=h56TphMe
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1793779839;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=AIXih/+g+9WTOCjrd3v2llW1L1i6Jm4IJcUxf1FA9ws=;
	b=BfssRooC5UFgIECUtCytQtm25wzxNrUZdc/+TUBauFqbZtl34J183AjfVT2j4XJykLb7vF
	UgtixEUBB9r6JmwU/HhGz1LGmHk7+90ioEenJLjALabxEfRoTx+iE6dfsgk5/4CnJOGOQO
	8Oo5u/ugCfXhIOrWc6GUgRhBPiBK0A4=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-621-Xdixx9sjOVeUY-GlDSXDkA-1; Wed, 04 Nov 2026 03:10:38 -0500
X-MC-Unique: Xdixx9sjOVeUY-GlDSXDkA-1
X-Mimecast-MFC-AGG-ID: Xdixx9sjOVeUY-GlDSXDkA_1793779837
Received: by mail-wr1-f71.google.com with SMTP id ffacd0b85a97d-48df5b058ddso261809f8f.0
        for <stable@vger.kernel.org>; Wed, 04 Nov 2026 00:10:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1793779837; x=1794384637; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=AIXih/+g+9WTOCjrd3v2llW1L1i6Jm4IJcUxf1FA9ws=;
        b=h56TphMeazGFab3XJ5SBMl+iJ45Yb80vSGCPMbVFEIGmQYcRU/nOViZvvQkcako54G
         eqKr9ulvIpeug/TB2FLfbP6GTPqT+RKhFEVLIhBKCrq299+HrCGgtcZ+1HtNQv2gEAoH
         Sp0QFRk1xy8eW+dFZauJYGqd97dwZsPcO//MofnckUw7QXxLNuU2bJ9pW6ejHcbUUa/+
         gOa2xq+m2P4SeanDXJjfAtV7ZQeirGA0328AuAtc+6qPbwtMI0EOpITi7g/X9NBKX1bv
         aGJPlfDJP+OAUw9hXLgT188vR4ZIaHgTamf+BCaIO6WFBuspvd8IfDtsCY4ATqN+EumI
         adDg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793779837; x=1794384637;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=AIXih/+g+9WTOCjrd3v2llW1L1i6Jm4IJcUxf1FA9ws=;
        b=VjEH1lNsln7Sv0Hwz0BE4LehJt4YHgkB8Qfc55C1G6MnPgr4R8XeJmS/Go+OHdXBgT
         AedToIfj7GUpdM2uLZ9y6p/BEFtaTvnHr8dc09e5Dr0TecdiVB8XMq/kE6F9a2aUr6J5
         j3REjaK/0FcR6Rz3JpFJ7m0ZcoSyY6FYPbBUc6Kqum8Si1VPdtybK9Wyx8bReFRrswud
         2cWNl/30BsmpXy1v4eq/yv4/KWeWjwrk21p1kWo5PjKuolDxi5cICsSDVVvif0C84iP/
         QHUUrPGisd1dsETnE89VJw9OBZljZZf2IJKZ0McaXakoGAJvc9dwVxkOKrrg+ALImt4f
         d+Ng==
X-Forwarded-Encrypted: i=1; AKwUvBxha1y3Sbgm2EUamgGgNuNfN3zoWbO0KtCv7No8ITnOcU6ndssJv3o+fjVWLnm9J/Wv+NTu4Us=@vger.kernel.org
X-Gm-Message-State: APuU4Z9LhDTAu9w76VHGB4Y6GM4+nzkCIIKRBkOhxh9zWtfkOshgPOB+
	LKxe7lFUL5GTBNtrU1+9jW8lF6rWmH11D8T8G0xw5WMyLSxN+hG2zAOmKRaKJi7adf+4ihC8mmd
	cekfEbVFIB5U/amPllZXHYFQCj3jpMWiFvlYl3/mhEbt9twRcuhdePx52SnS8yZNH4Q==
X-Gm-Gg: AYBFou29aXZ5Z4SRMEbS7nJi5eNB+Jfzr1DfcQBIzgedHXpqW6KUbE7/I0ubqrdejh2
	u8oK1tzgq+8iMadK9+quvDs3bLfDBlGllX24UiT0yiZp5sHDcgkFo8tx2uNCt4clMViyqcU39mB
	dvNub2IsYKOJl4wuE5dSsHmzETybbE4rm1CuDgNbW1E/scWF1a2v5XFcL/Qkj+MIbyii3RTvwpS
	BvqhqHT+bIxUF5KkJszo9cnQuQ5Id6hGz10sbk1Jk7+CNWlWHysrZteYalb7mvXdRR2NQ3ZqNo9
	2Zr61K8cFZrlFt2pev2a/Ppk/b23gTwA1b3XbVv3GJ6q+vrxcOZqksH+Gilfn3uqU1kp64gk9Rr
	ou7W2lAyfgqQjHNZFd01guVuVdAouQUcNpcmJrIaiuV7J+yczTx+6B0cdpJqFWE7zL+imjreBSy
	HczfIHYzjNSvph5U1F3FecJAPjeYrk5RUIXk10wlEUz6M=
X-Received: by 2002:a05:6000:40dc:b0:48e:412:3829 with SMTP id ffacd0b85a97d-48e6e3071f9mr35514459f8f.15.1793779837109;
        Wed, 04 Nov 2026 00:10:37 -0800 (PST)
X-Received: by 2002:a05:6000:40dc:b0:48e:412:3829 with SMTP id ffacd0b85a97d-48e6e3071f9mr35514390f8f.15.1793779836215;
        Wed, 04 Nov 2026 00:10:36 -0800 (PST)
Received: from [192.168.88.30] (ip231-128-192-82.pool-bba.aruba.it. [82.192.128.231])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-48fece99b33sm2302373f8f.23.2026.11.04.00.10.35
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 04 Nov 2026 00:10:35 -0800 (PST)
Message-ID: <1e517947-48cb-4733-9e51-8a165d3ba534@redhat.com>
Date: Wed, 4 Nov 2026 09:10:34 +0100
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
Subject: Re: [PATCH net] net/sched: fix rate estimator use-after-free when
 clearing NOLOCK
To: "Cen Zhang (Microsoft)" <cenzhang@linux.microsoft.com>,
 Jamal Hadi Salim <jhs@mojatatu.com>, Jiri Pirko <jiri@resnulli.us>
Cc: "David S. Miller" <davem@davemloft.net>,
 Eric Dumazet <edumazet@kernel.org>, Jakub Kicinski <kuba@kernel.org>,
 Simon Horman <horms@kernel.org>, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, stable@vger.kernel.org,
 AutonomousCodeSecurity@microsoft.com, tgopinath@linux.microsoft.com
References: <20261030030453.31928-1-cenzhang@linux.microsoft.com>
Content-Language: en-US
From: Paolo Abeni <pabeni@redhat.com>
In-Reply-To: <20261030030453.31928-1-cenzhang@linux.microsoft.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 10/30/26 04:04, Cen Zhang (Microsoft) wrote:
> qdisc_create() creates the rate estimator requested by TCA_RATE before
> qdisc_graft() converts a lockless child of a locking parent. The
> conversion in qdisc_clear_nolock() frees the per-CPU statistics, but
> the estimator keeps its own copy of the cpu_bstats pointer and its
> timer keeps reading the freed per-CPU memory on every estimator tick.
> 
> An unprivileged local user can trigger this. The estimator timer can
> access freed per-CPU statistics in softirq context and panic the kernel:
> 
>    BUG: unable to handle page fault for address: ff9d8b20ffa47920
>    RIP: 0010:gnet_stats_add_basic+0x77/0xc0
>    Call Trace:
>     <IRQ>
>     est_fetch_counters+0x31/0x50
>     est_timer+0x52/0x170
>     call_timer_fn+0x9f/0x210
>     run_timer_softirq+0x6e/0xb0
>     </IRQ>
>    Kernel panic - not syncing: Fatal exception in interrupt
> 
> Fix by doing the NOLOCK conversion in qdisc_create(), right before
> the estimator is created, instead of in qdisc_graft(), so that the
> estimator captures the final statistics pointer. Removing the
> conversion from qdisc_graft() is safe: a new qdisc is created by
> qdisc_create() with the parent it is grafted under, and since
> commit bc50835e83f6 ("net: sched: Disallow replacing of child qdisc
> from one parent to another") an existing qdisc can only be grafted
> again under its original parent. Either way the qdisc was already
> converted for that parent at creation.
> 
> Fixes: 8a53e616de29 ("net: sched: when clearing NOLOCK, clear TCQ_F_CPUSTATS, too")
> Cc: stable@vger.kernel.org
> Cc: AutonomousCodeSecurity@microsoft.com
> Signed-off-by: Cen Zhang (Microsoft) <cenzhang@linux.microsoft.com>
> ---
> 
> The bug was found and this fix was developed with the assistance of an
> LLM-based code analysis tool.
> 
> Backport note: trees without commit bc50835e83f6 (v6.14) still allow
> regrafting an existing child qdisc under a different parent and need
> an additional fix for that path, for example cherry-picking that
> commit as well.
> 
>   net/sched/sch_api.c | 14 ++++++++------
>   1 file changed, 8 insertions(+), 6 deletions(-)
> 
> diff --git a/net/sched/sch_api.c b/net/sched/sch_api.c
> index f36c41224bcc..d89f3f0a3c5f 100644
> --- a/net/sched/sch_api.c
> +++ b/net/sched/sch_api.c
> @@ -1247,10 +1247,6 @@ static int qdisc_graft(struct net_device *dev, struct Qdisc *parent,
>   		unsigned long cl;
>   		int err;
>   
> -		/* Only support running class lockless if parent is lockless */
> -		if (new && (new->flags & TCQ_F_NOLOCK) && !(parent->flags & TCQ_F_NOLOCK))
> -			qdisc_clear_nolock(new);
> -
>   		if (!cops || !cops->graft)
>   			return -EOPNOTSUPP;
>   
> @@ -1327,6 +1323,7 @@ static int qdisc_block_indexes_set(struct Qdisc *sch, struct nlattr **tca,
>   
>   static struct Qdisc *qdisc_create(struct net_device *dev,
>   				  struct netdev_queue *dev_queue,
> +				  struct Qdisc *parent_qdisc,
>   				  u32 parent, u32 handle,
>   				  struct nlattr **tca, int *errp,
>   				  struct netlink_ext_ack *extack)
> @@ -1405,6 +1402,11 @@ static struct Qdisc *qdisc_create(struct net_device *dev,
>   			goto err_out4;
>   	}
>   
> +	/* Only support running class lockless if parent is lockless */
> +	if ((sch->flags & TCQ_F_NOLOCK) && parent_qdisc &&
> +	    !(parent_qdisc->flags & TCQ_F_NOLOCK))
> +		qdisc_clear_nolock(sch);
> +
>   	if (tca[TCA_RATE]) {
>   		err = -EOPNOTSUPP;
>   		if (sch->flags & TCQ_F_MQROOT) {
> @@ -1817,7 +1819,7 @@ static int __tc_modify_qdisc(struct sk_buff *skb, struct nlmsghdr *n,
>   create_n_graft2:
>   	if (clid == TC_H_INGRESS) {
>   		if (dev_ingress_queue(dev)) {
> -			q = qdisc_create(dev, dev_ingress_queue(dev),
> +			q = qdisc_create(dev, dev_ingress_queue(dev), NULL,
>   					 tcm->tcm_parent, tcm->tcm_parent,
>   					 tca, &err, extack);
>   		} else {
> @@ -1834,7 +1836,7 @@ static int __tc_modify_qdisc(struct sk_buff *skb, struct nlmsghdr *n,
>   		else
>   			dev_queue = netdev_get_tx_queue(dev, 0);
>   
> -		q = qdisc_create(dev, dev_queue,
> +		q = qdisc_create(dev, dev_queue, p,
>   				 tcm->tcm_parent, tcm->tcm_handle,
>   				 tca, &err, extack);
>   	}

Jamal: could you please have a look?

Side note: I'm not sure if you are aware but we process the pending patches
in this order:

https://netdev.bots.linux.dev/suie.html?delegate=netdev

And you can restrict the list to the tc subsystem selecting the appropriate
filter with the funnel icon in the top right.

/P

