Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 62F3C3FA5F1
	for <stable@vger.kernel.org>; Tue, 25 Aug 2026 10:45:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787654711; cv=none; b=Ar9dCM/CVwOU8E1bBqbz37/hDXrj2azvikkPWllXNJXBUd2GMufQBakmeLXLFhHH9c1/f+B8w0vIxdITXpBw7nXFDPvxEHeiV+uRsjIJiLKDriIzoNtTDGcEKOX7VYz2dZfZGn2Rf8c2hqrsi1Yo5w40gVyFGKtk0czuqIMflZw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787654711; c=relaxed/simple;
	bh=+7UsDaBxxxafnbkxKKMkg9R+c8fO/Urc0EWFqkAWnpk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=XfFDl9Sc/SW5cFCztNP/LOC93nyXbwGfrdee97iUDXuRWcELZUnXvxveeYmOKXsOk033NXVab2H9y6PwMRuUimVcblZLTXIec4SxsqrYDC6JMGfvHZKvgNZ7C9Nqw2ojV87fT/aK0z22ApPGLftRTwYD7yUP10QzKdSZDP/HCow=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=fp+Gpt6d; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=Fjz6bi6P; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="fp+Gpt6d";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="Fjz6bi6P"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1787654709;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=zHh69naUUhgZLYqy6vySMehZGmJxGjn0KXcTrxIyxOs=;
	b=fp+Gpt6d9OH+zh1/VoUX6HesMKh0HhmZ/1lj9ZQdbVUFVrPGZNS7EF0tvMerz1EjU7Ii6o
	FPXLcKfIC0A9Ai6ro+Yz9W8DyQfPx5MM5gi6mqFeW+rKB+aCR2dZ9TW3aYoGg4QPavJige
	dSkPnt+B62LugLDkxde5d5VzveQmlls=
Received: from mail-ed1-f71.google.com (mail-ed1-f71.google.com
 [209.85.208.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-78-eIxVwuSHNz6RHG11eGZLwA-1; Tue, 25 Aug 2026 06:45:07 -0400
X-MC-Unique: eIxVwuSHNz6RHG11eGZLwA-1
X-Mimecast-MFC-AGG-ID: eIxVwuSHNz6RHG11eGZLwA_1787654706
Received: by mail-ed1-f71.google.com with SMTP id 4fb4d7f45d1cf-698b899b53cso4080470a12.3
        for <stable@vger.kernel.org>; Tue, 25 Aug 2026 03:45:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1787654706; x=1788259506; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:content-language
         :from:references:cc:to:subject:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=zHh69naUUhgZLYqy6vySMehZGmJxGjn0KXcTrxIyxOs=;
        b=Fjz6bi6PKVougUERPCW5WfZtzECM5sA0fIv1lBcZ4rm1YE6eGJxBzSgqB+gxSr0DQH
         do0PXwk5GHPObwHD8p9J2jOAnjUsRi53QeWiLt7pXBOK0Um3Qk/3f51UBKF6QUZI5dcV
         eo3hNXc/0GgMkqN/DIOMjkpyA0p29zxPh2On5zEmIEylNsc+SElO7I6zNyyDsrE/028D
         TeOTYlsSnH1lvZ0D/FpmJp2DVXe9av07W6V9e6DljO2mvhOOGxQO0BYmqsz2/NvDl3Cd
         pWq+PYb889cpnFjicbFIEglJYB9r/CvTPptqWs+IphiFGFUkampqyZ6EjhgD1Lt48lgV
         xZqQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787654706; x=1788259506;
        h=content-transfer-encoding:content-type:in-reply-to:content-language
         :from:references:cc:to:subject:user-agent:mime-version:date
         :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=zHh69naUUhgZLYqy6vySMehZGmJxGjn0KXcTrxIyxOs=;
        b=TdeANdKDJYW88Dyy2jdLekjBpUht58osYG79ckajMKJIwlp7Om1r9/0WF7xYudD11H
         L2xbT/+jrHWDjbpu9INGAMC80aly+hlfPVUMjIUit1MvrhpKaYMebLNUz+WeKwQSstNr
         CZKKbUaKpCaCYhXbn1Ysxi2KxJBcpYCYbTVI2hHrCFMQIdNsXHlgWLk7R8VOm0ETIlRa
         YZ1FqQZGM14QuxCv8JUzcMk3GGJyrAkM11Xnn7y4gfTrm/a5JN1q9xecZzjAfwua8XN4
         vK65AkdTImZOyJkQSJLf3XbqBGiO+xrD1Ap6ZBoFjRnSouKBRps/gxsKjIiUiHwy4kDr
         ml8g==
X-Forwarded-Encrypted: i=1; AHgh+RqJpwOPCcgZNzxtb7W4sYLAhv8c9Y7Q7emrLxJatC1YzwJS5fx9qrtPwwr+N8FCB/9fydnANdU=@vger.kernel.org
X-Gm-Message-State: AFuF++mYDfQG5hTHZ1OL0McfCEznNcT4myBkLGPaqiT/daIkfQmbugRy
	T5bYtwUVA8Hbiokvvhgvwy0ecCqcTi0QnkLY9E766MsoHd9Rmtq2zd71n4WYjpQNpP/hKZYW4Lx
	932erF/SSsk2vFEQw/CfKp+y/o/ct0A8c3ml97RYVS5d7897f1wSKPIGDAA==
X-Gm-Gg: AR+sD13p170HApSCvmUaSkFVRGCVGDTYNH89S1XnE8hm2vCWv1p/53C7rXxec5DQJpl
	xoe2szBlq6Lyn+LlkaEo92iMdBpRyAqP6Hjj+86dDXTCN9du2ix02foOB0z2AR/IEpujaZExh4u
	zj12ESjzPJtV1/O54/0kmObIwDVeV8bJeeZ6AiTcH6mWOsET653wyuTe9wdHhbYISNqRY6Djwie
	R48DYOwcpgZo9xNDLWp80hVJPp/iVLoQyFhqcBYFbyTRj7fwEB+dc0zoyFpM/Nd+N4u0MDHPSJj
	lAVXTg2Y9y8EWem+0h80Qtk6ZQFlUHLNWGAVykyKIUAESOFL5fjF+8NYDXCO6RkZ/1+HDyZM+rr
	rASRPk9+C11smp929Q2P6c3axSgYavP46BrC8t2ltZ9Sr0vCGXb3CjeBt85i+NdWN/HHN+Rex
X-Received: by 2002:a05:6402:52d0:b0:6a3:fdb0:c374 with SMTP id 4fb4d7f45d1cf-6a5c414ce78mr6312908a12.13.1787654706157;
        Tue, 25 Aug 2026 03:45:06 -0700 (PDT)
X-Received: by 2002:a05:6402:52d0:b0:6a3:fdb0:c374 with SMTP id 4fb4d7f45d1cf-6a5c414ce78mr6312834a12.13.1787654705668;
        Tue, 25 Aug 2026 03:45:05 -0700 (PDT)
Received: from [192.168.188.103] (ip46-47-231-195.pool-bba.aruba.it. [195.231.47.46])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-6a59e001305sm13901866a12.4.2026.08.25.03.45.03
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 25 Aug 2026 03:45:04 -0700 (PDT)
Message-ID: <f3a9dd1f-43a7-4644-bf1a-45dcd422abcb@redhat.com>
Date: Tue, 25 Aug 2026 12:45:02 +0200
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net] net: pktgen: keep device lookup under RCU protection
To: Chengfeng Ye <nicoyip.dev@gmail.com>,
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Simon Horman <horms@kernel.org>,
 Willem de Bruijn <willemb@google.com>,
 Nikolay Aleksandrov <razor@blackwall.org>, Qi Zhang
 <marsy12010123@gmail.com>, Randy Dunlap <rdunlap@infradead.org>,
 Alice Mikityanska <alice.kernel@fastmail.im>, Florian Westphal
 <fw@strlen.de>, Jesper Dangaard Brouer <hawk@kernel.org>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
 stable@vger.kernel.org
References: <20260824152331.216494-1-nicoyip.dev@gmail.com>
From: Paolo Abeni <pabeni@redhat.com>
Content-Language: en-US
In-Reply-To: <20260824152331.216494-1-nicoyip.dev@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 8/24/26 5:23 PM, Chengfeng Ye wrote:
> pktgen_find_dev() releases its RCU read-side critical section before
> returning pkt_dev. __pktgen_NN_threads() then sets removal_mark through
> that unprotected pointer.
> 
> The worker can concurrently remove the device and queue it for RCU
> freeing:
> 
>   CPU 0 (netdevice unregister)     CPU 1 (kpktgend)
>   rcu_read_lock()
>   find pkt_dev
>   rcu_read_unlock()
>                                    list_del_rcu(&pkt_dev->list)
>                                    kfree_rcu(pkt_dev, rcu)
>                                    RCU grace period ends
>   pkt_dev->removal_mark = 1
> 
> The mutex held by CPU 0 does not cover the worker and does not delay an
> RCU grace period, so the final write can access freed memory. KASAN
> reported:
> 
>   BUG: KASAN: slab-use-after-free in __pktgen_NN_threads+0x241/0x280
>   Write of size 4 at addr ffff88810dab804c
>   Call Trace:
>    __pktgen_NN_threads+0x241/0x280
>    pktgen_device_event+0x24e/0x3d0
>    unregister_netdevice_many_notify+0xde8/0x1ec0
>    rtnl_dellink+0x35d/0xa90
>   Allocated by task 92:
>    __kasan_kmalloc+0x8f/0xa0
>    pktgen_thread_write+0x498/0x14e0
>   Freed by task 0:
>    __kasan_slab_free+0x43/0x70
>    rcu_core+0x50a/0x1850
> 
> Move the existing RCU read lock into the sole caller and release it only
> after setting removal_mark. The object therefore remains alive through
> the dereference, while lookup order and control handling remain
> unchanged.
> 
> Fixes: 8788370a1d4b ("pktgen: RCU-ify "if_list" to remove lock in next_to_run()")
> Cc: stable@vger.kernel.org
> Signed-off-by: Chengfeng Ye <nicoyip.dev@gmail.com>
> ---
>  net/core/pktgen.c | 7 ++++---
>  1 file changed, 4 insertions(+), 3 deletions(-)
> 
> diff --git a/net/core/pktgen.c b/net/core/pktgen.c
> index 7f81aed46672..4fb1853589b3 100644
> --- a/net/core/pktgen.c
> +++ b/net/core/pktgen.c
> @@ -2032,14 +2032,17 @@ static struct pktgen_dev *__pktgen_NN_threads(const struct pktgen_net *pn,
>  	bool exact = (remove == FIND);
>  
>  	list_for_each_entry(t, &pn->pktgen_threads, th_list) {
> +		rcu_read_lock();
>  		pkt_dev = pktgen_find_dev(t, ifname, exact);
>  		if (pkt_dev) {
>  			if (remove) {
>  				pkt_dev->removal_mark = 1;
>  				t->control |= T_REMDEV;
>  			}
> -			break;
>  		}
> +		rcu_read_unlock();
> +		if (pkt_dev)
> +			break;
>  	}
>  	return pkt_dev;

Side note: returning the RCU protected ptr outside the RCU read lock
safe, as the caller never deference it, but quite confusing.

It would be nice to follow-up on net-next replacing the return type here
with a bool.

/P

