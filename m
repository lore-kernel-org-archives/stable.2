Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 34D3E3FAE0C
	for <stable@vger.kernel.org>; Wed,  1 Jul 2026 10:13:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782900841; cv=none; b=BZCt+CxENajAt/TK/kkK2JWQvaH7wAegfh0KC6E/QntJxVJRIkuuEWpIVgTvKpYqvPTgnX2wRSLqfNwnIEszefbv/vRG+12KlP6elp08N5cYp3HS1xWx1ezPZbwdHLcms+ZV576qQE/pkHSVBvtNzL9QguWWvWHWYReRKLwuyKQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782900841; c=relaxed/simple;
	bh=GBtUTmM/TptETllHS9g9icbUVF6l6FK8VygeaCK4Sl8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ZZDtJCvbL8pMbCgMEKHfqrdyazO+EY723QQ5zxWGxKyRT36HRYPc1oHgxmr/c3SyIbgo4O6nHqKgxB0df7RmSwSg/kmyW9+XK8yPjI3mz0f5RURF2ZVULmL1+7+rvyNzE+riIvrTOijPdE0Ut7edCykrKwq+im+aPWnWiJ34XxA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=gtRUTBBJ; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=bJvLaoR5; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="gtRUTBBJ";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="bJvLaoR5"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1782900839;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=ZP4pVQuwbXb6A4JsfHgerWuH1Q6CnZ/ETjBsK07QGkY=;
	b=gtRUTBBJLBuQWUDXKV+tfNrjyl1UvzPifDaqwH0ShIEqvMLKWR9TmYSWaEGazDn2I2sNRN
	gUtAn0xO9x7LpcKs2uAXFnmA6vzVflMZ5M3T+MH8fUiv67EOX84PZet3RKI80FV7r7ewqF
	yXx/Fi0umMqYXM/K/obzWFnDescrAsk=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-390-Uz-69IwqOrSfgNxGbFzwTw-1; Wed, 01 Jul 2026 06:13:57 -0400
X-MC-Unique: Uz-69IwqOrSfgNxGbFzwTw-1
X-Mimecast-MFC-AGG-ID: Uz-69IwqOrSfgNxGbFzwTw_1782900837
Received: by mail-wm1-f72.google.com with SMTP id 5b1f17b1804b1-493bab443f7so5406825e9.0
        for <stable@vger.kernel.org>; Wed, 01 Jul 2026 03:13:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1782900836; x=1783505636; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=ZP4pVQuwbXb6A4JsfHgerWuH1Q6CnZ/ETjBsK07QGkY=;
        b=bJvLaoR5YxgGt9mn6ew2PhSelvZC6TFHqdpal/i0b8HyIDxUCrovavTTON/1y10zL0
         IjYSkA4mL94AOWVi7grMyYO9SPgnhRNgsojQe69P+wd/OboVabbcheNdwqYFN8WvgJl6
         eNPJWOo0mfkUUT6wx7np26EeY+z6GnlkiOhT1te39rFB785FJT2tcEUR/1Em7fA2/iQd
         y5bxK2KnM/EvucMeuZL8P766eaFGNg6fqSNshX1nNL7LgNCVlwCi86v59zZ/zoERAmzj
         CASUeINXyaBOAJr4OAzPeoEfFowJoSUlZp1japWGjAAx4RhXOMNUb4Fh9SW/MopywmiH
         BKbw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782900836; x=1783505636;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ZP4pVQuwbXb6A4JsfHgerWuH1Q6CnZ/ETjBsK07QGkY=;
        b=XEjHDjxMkLCeOCoCwLouF9tM7sb4LLOvW5Af56zdxqYuId8L7DSjJ2a6/twfsFpfHD
         ZWf85JkObHZi8cVKPkL/C/1cLeA0ujz2ktEkKxbOocpMNpe+SfzPCy1C7TNx7+RcY7p9
         Zu47sfW8szwQ5pIXuGPkFMaHNspwCBxjztgeLWqJ8v+NBVQKTD+us6NFNMftoxlbE3dT
         okvVQRVtqIL3YvJiMZYLQD+hF1iuS2KClrLeva6Ip89JWrILrNdU22+mRBDQeUIgDsrm
         +x5zltP38QFutajCeyf4nL99KDkEJdovStDOg3X8iZeHeifTyNW1j3JxoWzAbbSGlXQH
         EhJg==
X-Forwarded-Encrypted: i=1; AFNElJ/M0BguGeSv5KxV2Tq9q/wbFMk81eJFZTmSwsmxLh95sySbRHkjXzy7i1lDCA3hKNR6vBftQsE=@vger.kernel.org
X-Gm-Message-State: AOJu0YwsJYcmUgD+yl0/2kF4kJx30Cftv1iVI42ULRqZx2gcdzGDNTLg
	ScJ/V/JJjV/s/voWh3e0Uf7qhXLEnIkmuYtAapGIGA61Vx8dH+R/+LVghlic/ZOYRuvZTC4J6xB
	CgUwYkbFwJ0k/CxHo4FlxjSmnz7MBH9LZgXd36NOBeS5iJzFnkHsHAf7Nbg==
X-Gm-Gg: AfdE7ckMaXXEIkwdxLtkn/HckA9f5qC8QZhug3/EiIL+Hv8hhzOtAMbrC7QpAcBvQs0
	YLJCdf+TA1P3L7wRE/huY2HwSagIpQLqGaxeTYa2ax2wGsJhuSG4pSE5szAUIsh5Av+zwOAY2rg
	3zKQdDO5u5R10aIz5ufIBb3TDm4IRPoWkpK0nYYtv4Irl5QweRK7EIvtruEeiLjRdHw9ntzrcPg
	Fly0LzrX0xOQ+Mj4zen12MuUFzFZY2v1Ptz6Qa2bM+3t808YsJUbci7MjYIXQweSl6jriNqBVUd
	YediGEn3KAn0SYEYpGzgDdlH490cBtToziObXRZKSR/lyDgITgcbLnvsevxk+M0Ybdp6rrAzoWH
	3Eqi4MHaWGfWFn/gHYRDs6obUWdugG5umbZSkohmfXxdI9XwR6ooysD8uhMMg
X-Received: by 2002:a05:600c:4f83:b0:493:c064:316f with SMTP id 5b1f17b1804b1-493c230bb07mr13955675e9.3.1782900835810;
        Wed, 01 Jul 2026 03:13:55 -0700 (PDT)
X-Received: by 2002:a05:600c:4f83:b0:493:c064:316f with SMTP id 5b1f17b1804b1-493c230bb07mr13955285e9.3.1782900835180;
        Wed, 01 Jul 2026 03:13:55 -0700 (PDT)
Received: from sgarzare-redhat (host-79-34-22-35.business.telecomitalia.it. [79.34.22.35])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-493be82fd71sm91335615e9.15.2026.07.01.03.13.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 01 Jul 2026 03:13:53 -0700 (PDT)
Date: Wed, 1 Jul 2026 12:13:47 +0200
From: Stefano Garzarella <sgarzare@redhat.com>
To: Paolo Abeni <pabeni@redhat.com>
Cc: netdev@vger.kernel.org, Jason Wang <jasowang@redhat.com>, 
	Jakub Kicinski <kuba@kernel.org>, "Michael S. Tsirkin" <mst@redhat.com>, kvm@vger.kernel.org, 
	virtualization@lists.linux.dev, Xuan Zhuo <xuanzhuo@linux.alibaba.com>, 
	Eric Dumazet <edumazet@google.com>, Simon Horman <horms@kernel.org>, linux-kernel@vger.kernel.org, 
	Stefan Hajnoczi <stefanha@redhat.com>, "David S. Miller" <davem@davemloft.net>, 
	Eugenio =?utf-8?B?UMOpcmV6?= <eperezma@redhat.com>, stable@vger.kernel.org, Brien Oberstein <brienpub@gmail.com>
Subject: Re: [PATCH net 1/2] vsock/virtio: collapse receive queue under
 memory pressure
Message-ID: <akTMf-DWZVAzYIPu@sgarzare-redhat>
References: <20260626134823.206676-1-sgarzare@redhat.com>
 <20260626134823.206676-2-sgarzare@redhat.com>
 <6a6be4b0-e02d-46ca-b8bf-c27bd681d253@redhat.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <6a6be4b0-e02d-46ca-b8bf-c27bd681d253@redhat.com>

On Tue, Jun 30, 2026 at 11:53:04AM +0200, Paolo Abeni wrote:
>On 6/26/26 3:48 PM, Stefano Garzarella wrote:
>> From: Stefano Garzarella <sgarzare@redhat.com>
>>
>> When many small packets accumulate in the receive queue, the skb overhead
>> can exceed buf_alloc even while the payload is within bounds. This causes
>> virtio_transport_inc_rx_pkt() to reject packets, leading to connection
>> resets during large transfers under backpressure.
>>
>> The issue was reported by Brien, who has a reproducer, but it is also
>> easily reproducible with iperf-vsock [1] using a small packet size:
>>
>>   iperf3 --vsock -c $CID -l 129
>>
>> which fails immediately without this patch but with commit 059b7dbd20a6
>> ("vsock/virtio: fix potential unbounded skb queue").
>>
>> Inspired by TCP's tcp_collapse() which solves a similar problem, add
>> virtio_transport_collapse_rx_queue() that walks the receive queue and
>> re-copies data into compact linear skbs to reduce the overhead.
>>
>> The collapse is triggered from virtio_transport_recv_enqueue() when
>> virtio_transport_inc_rx_pkt() fails. A pre-scan counts the eligible bytes
>> to size each allocation precisely, avoiding waste for isolated small
>> packets. Partially consumed skbs are kept as-is to preserve
>> buf_used/fwd_cnt accounting, EOM-marked skbs to maintain SEQPACKET
>> message boundaries, and skbs already larger than the collapse target
>> because they already have a good data-to-overhead ratio.
>>
>> [1] https://github.com/stefano-garzarella/iperf-vsock
>>
>> Fixes: 059b7dbd20a6 ("vsock/virtio: fix potential unbounded skb queue")
>> Cc: stable@vger.kernel.org
>> Reported-by: Brien Oberstein <brienpub@gmail.com>
>> Closes: https://lore.kernel.org/netdev/618701dd023e$063de350$12b9a9f0$@gmail.com/
>> Tested-by: Brien Oberstein <brienpub@gmail.com>
>> Signed-off-by: Stefano Garzarella <sgarzare@redhat.com>
>> ---
>>  net/vmw_vsock/virtio_transport_common.c | 148 +++++++++++++++++++++++-
>>  1 file changed, 146 insertions(+), 2 deletions(-)
>>
>> diff --git a/net/vmw_vsock/virtio_transport_common.c b/net/vmw_vsock/virtio_transport_common.c
>> index 09475007165b..304ea424995d 100644
>> --- a/net/vmw_vsock/virtio_transport_common.c
>> +++ b/net/vmw_vsock/virtio_transport_common.c
>> @@ -420,6 +420,137 @@ static int virtio_transport_send_pkt_info(struct vsock_sock *vsk,
>>  	return ret;
>>  }
>>
>> +static bool virtio_transport_can_collapse(struct sk_buff *skb,
>> +					  unsigned int size)
>
>Why passing a `size` argument here? AFAICS the actual argument is always
>a constant and IMHO rightfully so.

This comes from a previous implementation where this was not constant.
With the current code, I agree that a macro should be better.

I'll fix it.

>
>> +{
>> +	/* skbs that are partially consumed, mark a SEQPACKET message boundary,
>> +	 * or are already large enough should not be collapsed: they either
>> +	 * need special accounting, carry protocol state, or already have a
>> +	 * good data-to-overhead ratio.
>> +	 */
>> +	if (VIRTIO_VSOCK_SKB_CB(skb)->offset)
>> +		return false;
>> +	if (le32_to_cpu(virtio_vsock_hdr(skb)->flags) & VIRTIO_VSOCK_SEQ_EOM)
>> +		return false;
>> +	if (skb->len >= size)
>> +		return false;
>> +	return true;
>> +}
>> +
>> +/* Iterate through the packets in the queue starting from the current skb to
>> + * count the number of bytes we can collapse.
>> + */
>> +static unsigned int
>> +virtio_transport_collapse_size(struct sk_buff *skb,
>> +			       struct sk_buff_head *queue,
>> +			       unsigned int max_size)
>> +{
>> +	unsigned int target = skb->len - VIRTIO_VSOCK_SKB_CB(skb)->offset;
>> +
>> +	while ((skb = skb_peek_next(skb, queue)) &&
>> +	       virtio_transport_can_collapse(skb, max_size)) {
>> +		unsigned int len = skb->len - VIRTIO_VSOCK_SKB_CB(skb)->offset;
>> +
>> +		if (len > max_size - target)
>> +			return target;
>> +
>> +		target += len;
>> +	}
>> +
>> +	return target;
>> +}
>> +
>> +/* Called under lock_sock when skb overhead exceeds the budget. */
>> +static void virtio_transport_collapse_rx_queue(struct virtio_vsock_sock *vvs)
>> +{
>> +	/* Use the same linear allocation threshold as virtio_vsock_alloc_skb()
>> +	 * to avoid adding pressure on the page allocator.
>> +	 */
>> +	unsigned int collapse_max = SKB_MAX_ORDER(VIRTIO_VSOCK_SKB_HEADROOM,
>> +						  PAGE_ALLOC_COSTLY_ORDER);
>> +	struct sk_buff *skb, *next_skb, *new_skb = NULL;
>> +	struct sk_buff_head new_queue;
>> +
>> +	__skb_queue_head_init(&new_queue);
>> +
>> +	skb_queue_walk_safe(&vvs->rx_queue, skb, next_skb) {
>
>If the queue is relevantly big, walking all of it may take a significant
>amount of time/cache misses and causes traffic burstines. I think you
>could add an additional stop condition, i.e. when the current queue size
>is below a reasonable threshold (allowing the current packet to be
>inserted plus some more slack).

Makes sense, any suggestion on the threshold?

I was thinking something like this: merge until we have space for at 
least 2 skbs (because for now we estimate the overhead based on the 
number of skbs, but in the future I'd like to support truesize), but 
still trying to fill collapse_max as much as possible.

Does that make sense, or should we be more aggressive?

>
>/P
>
>> +		struct virtio_vsock_hdr *hdr = virtio_vsock_hdr(skb);
>> +		u32 src_off = VIRTIO_VSOCK_SKB_CB(skb)->offset;
>> +		u32 src_len = skb->len - src_off;
>> +		bool keep = false;
>> +
>> +		if (!virtio_transport_can_collapse(skb, collapse_max)) {
>
>Minor nit, possibly something alike the following lead to more
>compact/more readable code:
>
>
>		keep = !virtio_transport_can_collapse(skb, collapse_max);
>		if (keep) {
>

Yeah, so I can remove the initialization to false. I'll change it.

>> +			/* Finalize pending collapsed skb to preserve packet
>> +			 * ordering.
>> +			 */
>> +			if (new_skb) {
>> +				__skb_queue_tail(&new_queue, new_skb);
>> +				new_skb = NULL;
>> +			}
>> +			keep = true;
>> +			goto next;
>> +		}
>> +
>> +		/* Finalize if this packet won't fit in the remaining tailroom,
>> +		 * so we can allocate a right-sized new_skb.
>> +		 */
>> +		if (new_skb && src_len > skb_tailroom(new_skb)) {
>> +			__skb_queue_tail(&new_queue, new_skb);
>> +			new_skb = NULL;
>
>Possibly introduce an helper for the above 2 statements?

Do you mean something like this?

static void virtio_transport_queue_skb(struct sk_buff_head *queue,
				       struct sk_buff **skb)
{
	__skb_queue_tail(queue, *skb);
	*skb = NULL;
}

Not sure, just for 2 places, but if you prefer it, I can change.

Thanks,
Stefano

