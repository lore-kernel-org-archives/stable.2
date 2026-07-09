Received: from mail-ot1-f48.google.com (mail-ot1-f48.google.com [209.85.210.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E236F3AFAF4
	for <stable@vger.kernel.org>; Thu,  9 Jul 2026 19:07:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783624046; cv=none; b=eaml1yQVqn7Ugz1HJzYFqSa5N9oZMsSECbyexlAeIa3QU6kMpvZPlXd2eH+OBDrE7pUa4CG7oAps9m/lS2oza+Jn6SNk5BroSlC13y6yEBvN1AmzyWOs1x4MhL4mRVhcqHM1dLJqCs3Q7OkT4uUY3lFp5qzUjJFHHATqF33BPXI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783624046; c=relaxed/simple;
	bh=VroJ2dbVb3R/itAA7+lxyItCUx+B4jc4xjtV+qTeyaw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=tpID/eHOihG1S8p3lx1CvtjSYLAlwtriwrmvfXqMAoxhVYklhTj4aainkuRtkFSXYG32tQjU7hi9Z0IEkbsnZHRc31o8HKvYmdI2bKsfmkNAnmwTICDHU3NxeXeCvHaSVsQpsIfxZ/2BId6jnyOcBtTwYgHRxrPI2t74bSlKMHw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=svAt+f9T; arc=none smtp.client-ip=209.85.210.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="svAt+f9T"
Received: by mail-ot1-f48.google.com with SMTP id 46e09a7af769-7ebd88be784so154716a34.2
        for <stable@vger.kernel.org>; Thu, 09 Jul 2026 12:07:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1783624042; x=1784228842; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=Zo12XTQ5Euo3ISLCQIk6AAgRt58NE8CSZ/ONmSgOX+c=;
        b=svAt+f9TN0hAdjSfr+G3QYgr43IdBnvTWFaKuxkPBwJ3Nj52YI5PR2yWfH1VFO2tGD
         1wkmnY2C8gI65wF4OLYKsxLkboR+H59NX64OduT6CuVSDKyldS/+mhtmIyxKTkdCrHEn
         Y6RpRIMM1MiBt6G10V5fhW5rKbhaOkX2NAceh0OF8K0WKwmLdnT5fmJLFyl66FFho0XW
         JPN/DUr2K4uQk5wQ/EUdOwGDDOYE7aleLEKGyk6Xgz7291QEUmCDANuztY4SSpD+ZX6M
         +g5RGXLIvIDjj93Xxs9F0eYMAKiB08XBnaOmD3I8A1voNOHltT6j/7eaeecyaM/0mAFw
         wWiw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783624042; x=1784228842;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=Zo12XTQ5Euo3ISLCQIk6AAgRt58NE8CSZ/ONmSgOX+c=;
        b=gl29zhz7xJcT5IJyLynpAwpzvQDeHThRLeptP2PznD/Kf/wFkGtLUeq2Euga55AREz
         ISxqf1oJ44vgeRAY9a5mDFM7JowdlGsGDe6XyyKESJX5n5u5fWSDd1lgySiwb1Zql49w
         TPX/4Ni6rVEIZTi2fqZvVGegUDajcgFyubkEil6TS7KyTGiNxXJnultOPAD/Bvb9vGRp
         zaDjQ2X6r9mYxvE3jd5MqgKvmvbFsuGfvni8aUm/pzRWplR+7RU2E9wpnofWmL9D1NVL
         SumvxvAtFpOskBiL9YTVbCBWkYsW52IfpQMIu2cFAqGZLAGknLL5q2hrfDSf8yWp/7FL
         m30w==
X-Forwarded-Encrypted: i=1; AFNElJ/BOj4faWiGwlAE+iQ3XF34EVvdfoFV+TtWYNraksyY+S1LiXU2hlwMEZF2yLAqNMe2Tqb+NHs=@vger.kernel.org
X-Gm-Message-State: AOJu0YzxGNsPcHXZjuVltBO3GQqVsf/bLoNhk9xtwukWAkhgEaPPY/Oc
	kleUBTBiwddnqbf7deKhzs8tFFfjgjjitU+eSbh+qvzn0KcBpFqeZyJm
X-Gm-Gg: AfdE7clGgAGQhlxxjhkwWiPcM0txovAn7+cbkvpWHXoNWUukNQSAixqTWxDlMl2XJBP
	P+2S3I8OG9CF3zjzIDolNzw0AeuBtV3lV+dGU9EfeezR/Njbpvu6DjXEVRoyPTco6NuYzm6BjHi
	N94v2BFsTpzGle/3Q6Hu5O8PhPqnd9GGDz08Z2r3Sek9Khn9ME/Yi6v0KqoFMNFo8S51adHlAe/
	iaUKqBI0lTTvvVdPS5KjVD2PsDjJGEZj3KV/W1xqIOUsD9GCQ9BBtdycUqsNzryBjOG3l9vGzty
	KPXUTjy+zpi+bRtkRAxgW7dRxw2khAW9IOPIm2pJGTxEfYFX5hKAjdliwXUHdWl2R/Lihc24TLS
	dh62Z9O54cQPtbMy0eBFPE9K6XhvAyiE/1qXUBm/909eAIxnuowRqszu5ZR/Vfjx+h6k4ZtBnw+
	w6Eyo0W831PACbeufptcp82rLgbKle4rp5tw==
X-Received: by 2002:a05:6830:3486:b0:7ea:b8c:41a2 with SMTP id 46e09a7af769-7ebcfb9d02fmr6503635a34.0.1783624041937;
        Thu, 09 Jul 2026 12:07:21 -0700 (PDT)
Received: from devvm29614.prn0.facebook.com ([2a03:2880:ff:4f::])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-7ebcafda2ffsm4763568a34.12.2026.07.09.12.07.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 09 Jul 2026 12:07:20 -0700 (PDT)
Date: Thu, 9 Jul 2026 12:07:16 -0700
From: Bobby Eshleman <bobbyeshleman@gmail.com>
To: Stefano Garzarella <sgarzare@redhat.com>
Cc: netdev@vger.kernel.org, Jason Wang <jasowangio@gmail.com>,
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>,
	Eric Dumazet <edumazet@google.com>,
	Eugenio =?iso-8859-1?Q?P=E9rez?= <eperezma@redhat.com>,
	Simon Horman <horms@kernel.org>,
	Stefan Hajnoczi <stefanha@redhat.com>,
	"David S. Miller" <davem@davemloft.net>,
	linux-kernel@vger.kernel.org, "Michael S. Tsirkin" <mst@redhat.com>,
	kvm@vger.kernel.org, Paolo Abeni <pabeni@redhat.com>,
	virtualization@lists.linux.dev, Jakub Kicinski <kuba@kernel.org>,
	Jason Wang <jasowang@redhat.com>, stable@vger.kernel.org,
	Brien Oberstein <brienpub@gmail.com>
Subject: Re: [PATCH net v2 1/2] vsock/virtio: collapse receive queue under
 memory pressure
Message-ID: <ak/xZI08Ra1fVgm+@devvm29614.prn0.facebook.com>
References: <20260708102904.50732-1-sgarzare@redhat.com>
 <20260708102904.50732-2-sgarzare@redhat.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260708102904.50732-2-sgarzare@redhat.com>

On Wed, Jul 08, 2026 at 12:29:03PM +0200, Stefano Garzarella wrote:
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
> The collapse is triggered proactively from when the number of skb queued
> is close to exceeding the overhead budget.
> 
> A pre-scan counts the eligible bytes to size each allocation precisely,
> avoiding waste for isolated small packets. Partially consumed skbs are
> kept as-is to preserve buf_used/fwd_cnt accounting, EOM-marked skbs to
> maintain SEQPACKET message boundaries, and skbs already larger than the
> collapse target because they already have a good data-to-overhead ratio.
> 
> Walking a large queue may take a significant amount of time and cache
> misses, causing traffic burstiness. To limit this, the collapse stops
> once enough room is freed for this packet and the next one, but may
> opportunistically free more to fill each collapsed skb to capacity.
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
> v2:
> - defined MAX_COLLAPSE_LEN macro instead of using a variable [Paolo]
> - added a threshold to avoid walking all the queue while collapsing
>   [Paolo]
> - collapsed the queue before calling virtio_transport_inc_rx_pkt().
>   While working on the threshold, I figured out that the check I was
>   introducing can also be used to proactively trigger the collapse, so I
>   moved the call to virtio_transport_collapse_rx_queue() before acquiring
>   the rx_lock to have also a better diff to simplify backports
> - improved code readability (removed `out` label, `keep` initialization,
>   etc.) [Paolo + other small stuff]
> - Brien kindly retested this version as well (thank you so much)
> ---
>  net/vmw_vsock/virtio_transport_common.c | 165 +++++++++++++++++++++++-
>  1 file changed, 164 insertions(+), 1 deletion(-)
> 
> diff --git a/net/vmw_vsock/virtio_transport_common.c b/net/vmw_vsock/virtio_transport_common.c
> index 09475007165b..8becad81279c 100644
> --- a/net/vmw_vsock/virtio_transport_common.c
> +++ b/net/vmw_vsock/virtio_transport_common.c
> @@ -26,6 +26,13 @@
>  /* Threshold for detecting small packets to copy */
>  #define GOOD_COPY_LEN  128
>  
> +/* Max payload that can be collapsed into a single linear skb, using the same
> + * allocation threshold as virtio_vsock_alloc_skb() to avoid adding pressure
> + * on the page allocator.
> + */
> +#define MAX_COLLAPSE_LEN \
> +	SKB_MAX_ORDER(VIRTIO_VSOCK_SKB_HEADROOM, PAGE_ALLOC_COSTLY_ORDER)
> +
>  static void virtio_transport_cancel_close_work(struct vsock_sock *vsk,
>  					       bool cancel_timeout);
>  static s64 virtio_transport_has_space(struct virtio_vsock_sock *vvs);
> @@ -420,6 +427,145 @@ static int virtio_transport_send_pkt_info(struct vsock_sock *vsk,
>  	return ret;
>  }
>  
> +static bool virtio_transport_can_collapse(struct sk_buff *skb)
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
> +	if (skb->len >= MAX_COLLAPSE_LEN)
> +		return false;
> +	return true;
> +}
> +
> +/* Iterate through the packets in the queue starting from the current skb to
> + * count the number of bytes we can collapse.
> + */
> +static unsigned int
> +virtio_transport_collapse_size(struct sk_buff *skb, struct sk_buff_head *queue)
> +{
> +	unsigned int target = skb->len - VIRTIO_VSOCK_SKB_CB(skb)->offset;
> +
> +	while ((skb = skb_peek_next(skb, queue)) &&
> +	       virtio_transport_can_collapse(skb)) {
> +		unsigned int len = skb->len - VIRTIO_VSOCK_SKB_CB(skb)->offset;
> +
> +		if (len > MAX_COLLAPSE_LEN - target)
> +			return target;
> +
> +		target += len;
> +	}
> +
> +	return target;
> +}
> +
> +/* Called under lock_sock to compact the receive queue by merging small skbs.
> + * @min_to_free: minimum number of skbs to eliminate from the queue. May free
> + *               more to fill each collapsed skb to capacity.
> + */
> +static void
> +virtio_transport_collapse_rx_queue(struct virtio_vsock_sock *vvs,
> +				   u32 min_to_free)
> +{
> +	struct sk_buff *skb, *next_skb, *new_skb = NULL;
> +	struct sk_buff_head new_queue;
> +	u32 saved = 0;
> +
> +	__skb_queue_head_init(&new_queue);
> +
> +	skb_queue_walk_safe(&vvs->rx_queue, skb, next_skb) {
> +		struct virtio_vsock_hdr *hdr = virtio_vsock_hdr(skb);
> +		u32 src_off = VIRTIO_VSOCK_SKB_CB(skb)->offset;
> +		u32 src_len = skb->len - src_off;
> +		bool keep;
> +
> +		keep = !virtio_transport_can_collapse(skb);
> +		if (keep) {
> +			/* Finalize pending collapsed skb to preserve packet
> +			 * ordering.
> +			 */
> +			if (new_skb) {
> +				__skb_queue_tail(&new_queue, new_skb);
> +				new_skb = NULL;
> +				saved--;
> +			}
> +			goto next;
> +		}
> +
> +		/* Finalize if this packet won't fit in the remaining tailroom,
> +		 * so we can allocate a right-sized new_skb.
> +		 */
> +		if (new_skb && src_len > skb_tailroom(new_skb)) {
> +			__skb_queue_tail(&new_queue, new_skb);
> +			new_skb = NULL;
> +			saved--;
> +		}
> +
> +		if (!new_skb) {
> +			unsigned int alloc_size;
> +
> +			/* Check after finalizing to opportunistically fill
> +			 * each collapsed skb to capacity, merging more skbs
> +			 * than strictly required.
> +			 */
> +			if (saved >= min_to_free)
> +				break;
> +
> +			alloc_size = virtio_transport_collapse_size(skb, &vvs->rx_queue);
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
> +				break;
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
> +			break;
> +		}
> +
> +		le32_add_cpu(&virtio_vsock_hdr(new_skb)->len, src_len);
> +		virtio_vsock_hdr(new_skb)->flags |= hdr->flags;
> +
> +next:
> +		__skb_unlink(skb, &vvs->rx_queue);
> +		if (keep) {
> +			__skb_queue_tail(&new_queue, skb);
> +		} else {
> +			consume_skb(skb);
> +			saved++;
> +		}
> +	}
> +
> +	if (new_skb)
> +		__skb_queue_tail(&new_queue, new_skb);
> +
> +	skb_queue_splice(&new_queue, &vvs->rx_queue);
> +}
> +
>  static bool virtio_transport_inc_rx_pkt(struct virtio_vsock_sock *vvs,
>  					u32 len)
>  {
> @@ -1354,12 +1500,29 @@ virtio_transport_recv_enqueue(struct vsock_sock *vsk,
>  {
>  	struct virtio_vsock_sock *vvs = vsk->trans;
>  	bool can_enqueue, free_pkt = false;
> +	u32 len, queue_max, queue_len;
>  	struct virtio_vsock_hdr *hdr;
> -	u32 len;
>  
>  	hdr = virtio_vsock_hdr(skb);
>  	len = le32_to_cpu(hdr->len);
>  
> +	/* virtio_transport_inc_rx_pkt() rejects packets when the per-skb
> +	 * overhead (skb_queue_len * SKB_TRUESIZE(0)) exceeds buf_alloc.
> +	 * Proactively collapse the queue before that happens.
> +	 * No rx_lock needed: lock_sock is held by caller, preventing
> +	 * concurrent enqueue or dequeue.
> +	 */
> +	queue_max = vvs->buf_alloc / SKB_TRUESIZE(0);
> +	queue_len = skb_queue_len(&vvs->rx_queue);
> +	if (queue_len >= queue_max) {
> +		/* Walking a large queue may take a significant amount of time
> +		 * and cache misses, causing traffic burstiness. Limit the
> +		 * collapse to freeing room for this packet and the next one.
> +		 * It may free more to fill each collapsed skb to capacity.
> +		 */
> +		virtio_transport_collapse_rx_queue(vvs, queue_len + 2 - queue_max);
> +	}
> +
>  	spin_lock_bh(&vvs->rx_lock);
>  
>  	can_enqueue = virtio_transport_inc_rx_pkt(vvs, len);

The changes still look good to me.

Reviewed-by: Bobby Eshleman <bobbyeshleman@meta.com>

Thanks,
Bobby
