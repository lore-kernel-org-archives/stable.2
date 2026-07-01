Received: from mail-ot1-f53.google.com (mail-ot1-f53.google.com [209.85.210.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9546E372EEF
	for <stable@vger.kernel.org>; Wed,  1 Jul 2026 16:34:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782923688; cv=none; b=sumxyYLEcvBCecXQVtSwajLRzlp4m2fvpECsSbhNvNdKyd2O0pbmKtv7r8DBd4d9/xLjBRqye6S4478kafYTFXFOlgS7VSuIb/bmfnO05/1u3EX62gTXdnBvtOSwWfhss6JUXrqkO0cAC3PluI1zrXwDd/x0VU87QHaGlnQK9Mc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782923688; c=relaxed/simple;
	bh=IgxZJkAX83JEoUd7zhGT0HcnVVm/OyxbDgl2DsEOM60=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Rjnj/gkQyFYQYOf4/leIL6QWGKvaIj8yndyU8NHDESSop5XX3dGl50b5YVBMTmCeyLwohzklu80acXdBpQLzzMyi5RDp1JpkaZNAW0AflWaQpClpF7FO3OLU5QSk9CKdKcbiCKPgUNieUJLkC3Ig5oK1SjG7CktzbPeWJtpkrOM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=VF7TYWZE; arc=none smtp.client-ip=209.85.210.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VF7TYWZE"
Received: by mail-ot1-f53.google.com with SMTP id 46e09a7af769-7e9ef94c0e2so420390a34.3
        for <stable@vger.kernel.org>; Wed, 01 Jul 2026 09:34:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1782923683; x=1783528483; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=1aq9FrQ86evQJPeL1WihgSaD08JDHC1d1jP4T/r4tmg=;
        b=VF7TYWZEJtU6xvbF+N5I18va+RpqBL5W9T8utPvXEVC2XCAy+yl8Hqs+DyusYprh6/
         oS5zCXsbtb1yQCnCNNyPbFoijcq2wiCeV+oVDfFUBVnIfRKhnLYmLFWCTjE5SKHFUfMc
         ag8e7gx6ozqOf0NzfFGZix2ZFVZAnBcp9K33zMDW+Pyzdv6bR1n999XzawPZ3LLTPxyh
         tvMyivJLY7K6QYGyU6/cQ0p7z8YBo0PHz46qTuvphTNTgFV46GnkwBdruB2HN+1V8oXv
         /dSEcOw+t6F34jewZQEQ01skUi2QER/unrWUx+IGVt46r/a2XUzsQT6cozu9EEDGDnt4
         w8Pg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782923683; x=1783528483;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=1aq9FrQ86evQJPeL1WihgSaD08JDHC1d1jP4T/r4tmg=;
        b=cKLi1il0X46nb+tNIXBcVrU1egA8KGnzKriq290ndwInMSbr/A1nYw9fWTs2a5CAKW
         ChPCaOkCxaiTvfjeUFfBIWfe9q/tbZcySQuR+eBkt9ThkPy+FLfHzy53iRufVtioe4kY
         nTGjRisO217U64xhKlYZW60Qa+jhd5eyDH21I96z21kzSIEVFE5FgqVmrJNZUtIwazE+
         J0F6ToguN2kN76RQbMfXAfMnudICacHzndFVZ6s7A5Yu5pVvKX4iTBpgnnwbBAY9wYaI
         YcchqESxXhP/kJfxj7087vAUYiKdMrs5dA/BCZh8JBOPZXVZXPxb7ISom3xBdK+biE7G
         BTag==
X-Forwarded-Encrypted: i=1; AFNElJ/B5CGT6aIKKT4Z9ogIdOYctpporaFjt5uc8/6Fz1OqBso2/V1lGbYq75yLfEmgTh82ZrPOhCU=@vger.kernel.org
X-Gm-Message-State: AOJu0YzSaiDXNpgw27r9znyY305N9bga551fWxstA01lAVAnHc2db1JV
	va4dpiUnw9hN72C4YHpBNSQRKYuw1aN2WmWJHjPlQHIeB65DGnhamkR1
X-Gm-Gg: AfdE7cl0ApSe9ayJkX613kqFTP1I2TsO+Teqtd9WoZ/lyRG5nxitzv3mCLaGfMuHr0w
	7Dl58BxQ3hho9QtEB3dGqbTXz7epnyf1TXi54oDH3lFu8z5GLXY5qxJ9CYjXx06IJexf0qred3m
	Evn46Q6H2LKQS62+RVgtszKrniA9AFwbtohXxpb8pHOpN1HvInKtL9TgcrI+LXMg5Z6FdeDyCaY
	Q7fsUDZ1TF67lqmX9IjGX21+sAz/gMShwDHDV8OQ6uDUiL+SAVTrs9TjL6Jspmp8KCbax1FF+rS
	FT5Ws1rZ5eRUHetEZpPOIOcjFEM5oRc8xJ9IGGkmJAl+3tG1+aLsS9hAPgDhZLdAVAbieylyLsH
	0kRXYkeJ2ozEIkCCIhDc0AIi4si9nuKGoXVbUdCi7m00NJNZVS0VuZ54zRW2LneqoC0AXKDSHY9
	gNBd9k4mHtU7qw7Wux5j4p9b/muG2yt7gQwQ==
X-Received: by 2002:a05:6830:3784:b0:7e9:c2d8:1789 with SMTP id 46e09a7af769-7eb504be755mr1070845a34.18.1782923683262;
        Wed, 01 Jul 2026 09:34:43 -0700 (PDT)
Received: from devvm29614.prn0.facebook.com ([2a03:2880:ff:50::])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-7eb542d017csm410999a34.8.2026.07.01.09.34.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 01 Jul 2026 09:34:42 -0700 (PDT)
Date: Wed, 1 Jul 2026 09:34:35 -0700
From: Bobby Eshleman <bobbyeshleman@gmail.com>
To: Stefano Garzarella <sgarzare@redhat.com>
Cc: netdev@vger.kernel.org, Jason Wang <jasowang@redhat.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	"Michael S. Tsirkin" <mst@redhat.com>, kvm@vger.kernel.org,
	virtualization@lists.linux.dev,
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>,
	Eric Dumazet <edumazet@google.com>, Simon Horman <horms@kernel.org>,
	linux-kernel@vger.kernel.org, Stefan Hajnoczi <stefanha@redhat.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eugenio =?iso-8859-1?Q?P=E9rez?= <eperezma@redhat.com>,
	stable@vger.kernel.org, Brien Oberstein <brienpub@gmail.com>
Subject: Re: [PATCH net 1/2] vsock/virtio: collapse receive queue under
 memory pressure
Message-ID: <akVBmydgSd0Eb46/@devvm29614.prn0.facebook.com>
References: <20260626134823.206676-1-sgarzare@redhat.com>
 <20260626134823.206676-2-sgarzare@redhat.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260626134823.206676-2-sgarzare@redhat.com>

On Fri, Jun 26, 2026 at 03:48:22PM +0200, Stefano Garzarella wrote:
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
> +		struct virtio_vsock_hdr *hdr = virtio_vsock_hdr(skb);
> +		u32 src_off = VIRTIO_VSOCK_SKB_CB(skb)->offset;
> +		u32 src_len = skb->len - src_off;
> +		bool keep = false;
> +
> +		if (!virtio_transport_can_collapse(skb, collapse_max)) {
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
> +		}
> +
> +		if (!new_skb) {
> +			unsigned int alloc_size;
> +
> +			alloc_size = virtio_transport_collapse_size(skb, &vvs->rx_queue,
> +								    collapse_max);
> +
> +			/* Only this skb's data is eligible, nothing to merge
> +			 * with. Keep as-is.
> +			 */
> +			if (alloc_size <= src_len) {
> +				keep = true;
> +				goto next;
> +			}
> +
> +			new_skb = virtio_vsock_alloc_linear_skb(alloc_size +
> +					VIRTIO_VSOCK_SKB_HEADROOM, GFP_KERNEL);
> +			if (!new_skb)
> +				goto out;
> +
> +			memcpy(virtio_vsock_hdr(new_skb), hdr,
> +			       sizeof(struct virtio_vsock_hdr));
> +			virtio_vsock_hdr(new_skb)->len = 0;
> +		}
> +
> +		/* Cannot fail since src_off/src_len are within bounds, but if
> +		 * it does, discard new_skb to avoid queuing corrupted data.
> +		 */
> +		if (WARN_ON_ONCE(skb_copy_bits(skb, src_off,
> +					       skb_put(new_skb, src_len),
> +					       src_len))) {
> +			kfree_skb(new_skb);
> +			new_skb = NULL;
> +			goto out;
> +		}
> +
> +		le32_add_cpu(&virtio_vsock_hdr(new_skb)->len, src_len);
> +		virtio_vsock_hdr(new_skb)->flags |= hdr->flags;
> +
> +next:
> +		__skb_unlink(skb, &vvs->rx_queue);
> +		if (keep)
> +			__skb_queue_tail(&new_queue, skb);
> +		else
> +			consume_skb(skb);
> +	}
> +out:
> +	if (new_skb)
> +		__skb_queue_tail(&new_queue, new_skb);
> +
> +	skb_queue_splice(&new_queue, &vvs->rx_queue);

I think the new skbs will also need skb_set_owner_sk_safe(skb, sk)
when adding to rx_queue?

Best,
Bobby

> +}
> +
>  static bool virtio_transport_inc_rx_pkt(struct virtio_vsock_sock *vvs,
>  					u32 len)
>  {
> @@ -1363,8 +1494,21 @@ virtio_transport_recv_enqueue(struct vsock_sock *vsk,
>  	spin_lock_bh(&vvs->rx_lock);
>  
>  	can_enqueue = virtio_transport_inc_rx_pkt(vvs, len);
> -	if (!can_enqueue)
> -		goto out;
> +	if (!can_enqueue) {
> +		/* Try to collapse the receive queue to reduce skb overhead and
> +		 * make room for this packet.
> +		 * Unlock rx_lock since the collapse may sleep or, in any case,
> +		 * take some time to collapse the skbs, but this is safe, since
> +		 * sk_lock is held by caller so no one else can enqueue or
> +		 * dequeue.
> +		 */
> +		spin_unlock_bh(&vvs->rx_lock);
> +		virtio_transport_collapse_rx_queue(vvs);
> +		spin_lock_bh(&vvs->rx_lock);
> +		can_enqueue = virtio_transport_inc_rx_pkt(vvs, len);
> +		if (!can_enqueue)
> +			goto out;
> +	}
>  
>  	if (le32_to_cpu(hdr->flags) & VIRTIO_VSOCK_SEQ_EOM)
>  		vvs->msg_count++;
> -- 
> 2.54.0
> 
> 
