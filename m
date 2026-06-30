Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E0920366DB5
	for <stable@vger.kernel.org>; Tue, 30 Jun 2026 09:53:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782813195; cv=none; b=ZvvLJIK0XP66JikK7Uada1zbfXANbHstVdND41Fa/c8CL3VpiZQ8DxGG1xmGhGpd80ZAiMUhMfZ7dQIqRNwF93WCBO3fdP42yN/dErFS0N4S7Nn7zfSHr6gdcVuBm73ungA4rZ6bAm49c6DhVhvErNjupoBE0xsJZhwAtfIpMk4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782813195; c=relaxed/simple;
	bh=NbDEHp0gquR5Nq2A/cm+7E2L5SZ1Jhgmv94kZhkUywY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=d5OcmtHP8kJ5+r7QCj8zR0qwpYw2Gc2P4bxvtLkrANvCtkb238MuYN/ENt0TRKH5t2q60foORRjIxiAdYQLxPic3DXg3Sg5Ixcom+OXoTF1etj2oMnCCWDjAJxAAFAPnJTz/ZHsGmMzFBdPjRk3mSTW/4aZsdvgTxZWvjqPWoIU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=ajjACraE; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=flG5IDJ2; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ajjACraE";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="flG5IDJ2"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1782813193;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=4wTpFP+uURpV7Es5gbDN0xr6tXZLlBB9VR1MULvKZf4=;
	b=ajjACraEAs7QxAl/5WwiafHfYKzCCF903h/10kt1IW05pHLh3aXqvWOzFOvhURBCl4ROMF
	GvyBXUsVSiIG+AoZonSTHyIQKXU7R+/s8R09isqxZHGLDZzSOxJobWkSaJKWU0xbV12ELi
	y9n2rEJYpQOgz/wiRUobnb+hxno+IIs=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-26-uVj9zf6aPK-a5WIB19YTfg-1; Tue, 30 Jun 2026 05:53:09 -0400
X-MC-Unique: uVj9zf6aPK-a5WIB19YTfg-1
X-Mimecast-MFC-AGG-ID: uVj9zf6aPK-a5WIB19YTfg_1782813188
Received: by mail-wr1-f70.google.com with SMTP id ffacd0b85a97d-47162f83c75so281087f8f.1
        for <stable@vger.kernel.org>; Tue, 30 Jun 2026 02:53:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1782813188; x=1783417988; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=4wTpFP+uURpV7Es5gbDN0xr6tXZLlBB9VR1MULvKZf4=;
        b=flG5IDJ2hqHW0esT+mbR1XlgzZp+A3gpWkh+I4LyDmUY21Ok86j1MXal/n3wpcvbPa
         EUfEzabuf4xebj87SDEHm8gtvrsUe3JJlOhC9XW/naZdU/qAdYABRt3JRjgiB6uS5eSN
         oQ8mCFg7JRyQGhnLjuOtQtZKIZJ15+bFVGrDmPlSAZOStGKRQAH3f+lwHDGwlDQKtyy/
         DnjcGAoFMdNagtSMyCZbOVIkxB5EOadqirFKlR1d8lZjD5MiAEB3IMBD0VMu6U5Cmq0j
         ZvPNlaeiVYrLdXgLH5msXPaVcUDBr9u8IZ3BCiKtFgBf0Dg7/FE/gq1cGS24n3hUHYut
         OYEA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782813188; x=1783417988;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=4wTpFP+uURpV7Es5gbDN0xr6tXZLlBB9VR1MULvKZf4=;
        b=YMMdLw4ACDvdElOmqhGZsTGX8vzggUu2xBfoHJS3/S0S068TrCzs8dKOqRd2rbDq37
         K4FSEQe6XQF3+cSVYjAYOPmjBjrwsgOx7W/gEvrRbcC3ecK41wS2wdx25UBI8xvJK42F
         Gt1wF9J7vOpSDLi2GlNBy/y5+huf5xNwJuRKp4dRpolKCL3Ghsgbm0q4BmWwQM38I6JW
         d4lddF3c4ZZSYS9vnX3jj4TBsdWUN+pmQC3tIF9pIQ/q5bWPn0ZRS2RAJmnZxt4V207q
         aqAWj8vZceC+WaMlxB8Mc4Cz+OOpAcZRh9wNgBlaxaYCPJe8ThOMcNhqRZ1P9YUoZfX4
         pUpg==
X-Forwarded-Encrypted: i=1; AHgh+RqanwcqVKwuyJQ53qyQWJ0EbD538YK4WtMXPiHy52Oxta/fhxdiD0W3K/SnqwCUxdVkb28VTYM=@vger.kernel.org
X-Gm-Message-State: AOJu0YwEhy5EGjFwn0EO0dJl2e6XCYljiEvKBH++4QQNzCmw3zcq/ux+
	QJyG/evJzevtAAv0HYzCMRt4nLxOE7XwdS7bope0BP2HxQVto0gdaSurqviHrpHqZnrft2KyS07
	aUzfyJB1Sc2NBU8dliVRl0uMhhHqQH28TkL9E0sAnephdbTbJYxANVEqg9w==
X-Gm-Gg: AfdE7ckyzpbWqUaOE7ORCyM8n4WrLkmfSVs6dfp6hvGI3IwWDj4PyHtyMUJuCUBXRGd
	U1bYh8WPWtlxFjS2Qi0wnWSBsShgsnGQIS0AeKQFH1dI1R+ey/E11vqwmJJSRwTi96L0553VbZJ
	XfaPdm2FUJ2oZfAXhaQ6wLWVNv1/YOg/7Zo/mSAVeX2KyNGd0NIteUTyCsNq3dUXgDDW4PgRrqy
	O5umT+8vXXEX9RG4Zb4S5yudwS+XFMYdDMiMP1NEJtvqc+JfVWgeoyypfGVg3xCQ8UC8Q5Kwvl+
	7tm1fBZ82PxySQmIWUTFopOzpkxBT7iAl5Na2HYt1SsZ60Blv6SW90XR9iMJRcTiJC/APerWCD1
	WvRt1Tj2J9kA1UThwzW2Uu3O4la0c5Iv2abC/qwUPVbRoVMgIMLSsztYrgmwqNJdCWTQAmO1Ftd
	QcMkY1S4tBfA==
X-Received: by 2002:a05:6000:1847:b0:45d:4c30:81a6 with SMTP id ffacd0b85a97d-475f4fb5d50mr1344059f8f.5.1782813188245;
        Tue, 30 Jun 2026 02:53:08 -0700 (PDT)
X-Received: by 2002:a05:6000:1847:b0:45d:4c30:81a6 with SMTP id ffacd0b85a97d-475f4fb5d50mr1344016f8f.5.1782813187784;
        Tue, 30 Jun 2026 02:53:07 -0700 (PDT)
Received: from ?IPV6:2a0d:3344:5521:6b10:2eb7:f61a:75:4534? ([2a0d:3344:5521:6b10:2eb7:f61a:75:4534])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4756636cf65sm6669391f8f.21.2026.06.30.02.53.05
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 30 Jun 2026 02:53:05 -0700 (PDT)
Message-ID: <6a6be4b0-e02d-46ca-b8bf-c27bd681d253@redhat.com>
Date: Tue, 30 Jun 2026 11:53:04 +0200
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net 1/2] vsock/virtio: collapse receive queue under memory
 pressure
To: Stefano Garzarella <sgarzare@redhat.com>, netdev@vger.kernel.org
Cc: Jason Wang <jasowang@redhat.com>, Jakub Kicinski <kuba@kernel.org>,
 "Michael S. Tsirkin" <mst@redhat.com>, kvm@vger.kernel.org,
 virtualization@lists.linux.dev, Xuan Zhuo <xuanzhuo@linux.alibaba.com>,
 Eric Dumazet <edumazet@google.com>, Simon Horman <horms@kernel.org>,
 linux-kernel@vger.kernel.org, Stefan Hajnoczi <stefanha@redhat.com>,
 "David S. Miller" <davem@davemloft.net>, =?UTF-8?Q?Eugenio_P=C3=A9rez?=
 <eperezma@redhat.com>, stable@vger.kernel.org,
 Brien Oberstein <brienpub@gmail.com>
References: <20260626134823.206676-1-sgarzare@redhat.com>
 <20260626134823.206676-2-sgarzare@redhat.com>
From: Paolo Abeni <pabeni@redhat.com>
Content-Language: en-US
In-Reply-To: <20260626134823.206676-2-sgarzare@redhat.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 6/26/26 3:48 PM, Stefano Garzarella wrote:
> From: Stefano Garzarella <sgarzare@redhat.com>
> 
> When many small packets accumulate in the receive queue, the skb overhead
> can exceed buf_alloc even while the payload is within bounds. This causes
> virtio_transport_inc_rx_pkt() to reject packets, leading to connection
> resets during large transfers under backpressure.
> 
> The issue was reported by Brien, who has a reproducer, but it is also
> easily reproducible with iperf-vsock [1] using a small packet size:
> 
>   iperf3 --vsock -c $CID -l 129
> 
> which fails immediately without this patch but with commit 059b7dbd20a6
> ("vsock/virtio: fix potential unbounded skb queue").
> 
> Inspired by TCP's tcp_collapse() which solves a similar problem, add
> virtio_transport_collapse_rx_queue() that walks the receive queue and
> re-copies data into compact linear skbs to reduce the overhead.
> 
> The collapse is triggered from virtio_transport_recv_enqueue() when
> virtio_transport_inc_rx_pkt() fails. A pre-scan counts the eligible bytes
> to size each allocation precisely, avoiding waste for isolated small
> packets. Partially consumed skbs are kept as-is to preserve
> buf_used/fwd_cnt accounting, EOM-marked skbs to maintain SEQPACKET
> message boundaries, and skbs already larger than the collapse target
> because they already have a good data-to-overhead ratio.
> 
> [1] https://github.com/stefano-garzarella/iperf-vsock
> 
> Fixes: 059b7dbd20a6 ("vsock/virtio: fix potential unbounded skb queue")
> Cc: stable@vger.kernel.org
> Reported-by: Brien Oberstein <brienpub@gmail.com>
> Closes: https://lore.kernel.org/netdev/618701dd023e$063de350$12b9a9f0$@gmail.com/
> Tested-by: Brien Oberstein <brienpub@gmail.com>
> Signed-off-by: Stefano Garzarella <sgarzare@redhat.com>
> ---
>  net/vmw_vsock/virtio_transport_common.c | 148 +++++++++++++++++++++++-
>  1 file changed, 146 insertions(+), 2 deletions(-)
> 
> diff --git a/net/vmw_vsock/virtio_transport_common.c b/net/vmw_vsock/virtio_transport_common.c
> index 09475007165b..304ea424995d 100644
> --- a/net/vmw_vsock/virtio_transport_common.c
> +++ b/net/vmw_vsock/virtio_transport_common.c
> @@ -420,6 +420,137 @@ static int virtio_transport_send_pkt_info(struct vsock_sock *vsk,
>  	return ret;
>  }
>  
> +static bool virtio_transport_can_collapse(struct sk_buff *skb,
> +					  unsigned int size)

Why passing a `size` argument here? AFAICS the actual argument is always
a constant and IMHO rightfully so.

> +{
> +	/* skbs that are partially consumed, mark a SEQPACKET message boundary,
> +	 * or are already large enough should not be collapsed: they either
> +	 * need special accounting, carry protocol state, or already have a
> +	 * good data-to-overhead ratio.
> +	 */
> +	if (VIRTIO_VSOCK_SKB_CB(skb)->offset)
> +		return false;
> +	if (le32_to_cpu(virtio_vsock_hdr(skb)->flags) & VIRTIO_VSOCK_SEQ_EOM)
> +		return false;
> +	if (skb->len >= size)
> +		return false;
> +	return true;
> +}
> +
> +/* Iterate through the packets in the queue starting from the current skb to
> + * count the number of bytes we can collapse.
> + */
> +static unsigned int
> +virtio_transport_collapse_size(struct sk_buff *skb,
> +			       struct sk_buff_head *queue,
> +			       unsigned int max_size)
> +{
> +	unsigned int target = skb->len - VIRTIO_VSOCK_SKB_CB(skb)->offset;
> +
> +	while ((skb = skb_peek_next(skb, queue)) &&
> +	       virtio_transport_can_collapse(skb, max_size)) {
> +		unsigned int len = skb->len - VIRTIO_VSOCK_SKB_CB(skb)->offset;
> +
> +		if (len > max_size - target)
> +			return target;
> +
> +		target += len;
> +	}
> +
> +	return target;
> +}
> +
> +/* Called under lock_sock when skb overhead exceeds the budget. */
> +static void virtio_transport_collapse_rx_queue(struct virtio_vsock_sock *vvs)
> +{
> +	/* Use the same linear allocation threshold as virtio_vsock_alloc_skb()
> +	 * to avoid adding pressure on the page allocator.
> +	 */
> +	unsigned int collapse_max = SKB_MAX_ORDER(VIRTIO_VSOCK_SKB_HEADROOM,
> +						  PAGE_ALLOC_COSTLY_ORDER);
> +	struct sk_buff *skb, *next_skb, *new_skb = NULL;
> +	struct sk_buff_head new_queue;
> +
> +	__skb_queue_head_init(&new_queue);
> +
> +	skb_queue_walk_safe(&vvs->rx_queue, skb, next_skb) {

If the queue is relevantly big, walking all of it may take a significant
amount of time/cache misses and causes traffic burstines. I think you
could add an additional stop condition, i.e. when the current queue size
is below a reasonable threshold (allowing the current packet to be
inserted plus some more slack).

/P

> +		struct virtio_vsock_hdr *hdr = virtio_vsock_hdr(skb);
> +		u32 src_off = VIRTIO_VSOCK_SKB_CB(skb)->offset;
> +		u32 src_len = skb->len - src_off;
> +		bool keep = false;
> +
> +		if (!virtio_transport_can_collapse(skb, collapse_max)) {

Minor nit, possibly something alike the following lead to more
compact/more readable code:


		keep = !virtio_transport_can_collapse(skb, collapse_max);
		if (keep) {

> +			/* Finalize pending collapsed skb to preserve packet
> +			 * ordering.
> +			 */
> +			if (new_skb) {
> +				__skb_queue_tail(&new_queue, new_skb);
> +				new_skb = NULL;
> +			}
> +			keep = true;
> +			goto next;
> +		}
> +
> +		/* Finalize if this packet won't fit in the remaining tailroom,
> +		 * so we can allocate a right-sized new_skb.
> +		 */
> +		if (new_skb && src_len > skb_tailroom(new_skb)) {
> +			__skb_queue_tail(&new_queue, new_skb);
> +			new_skb = NULL;

Possibly introduce an helper for the above 2 statements?

/P

