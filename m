Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E29B24F96AE
	for <stable@vger.kernel.org>; Mon, 19 Oct 2026 13:49:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792417754; cv=none; b=mrtib7VMcOFOCxm2pV4Rcojh8M6g5LZUZnYtgoyj4pRh70GF6yfevHw0ro1iywvSIWxn0UrjHAfy+IwQNqO3IPsDRDssUbAansgtvtXdeIftIhB74HBu9cwO8rUfp0gua69j4VXks4RWaLsjWSkYWxP3oquuLMkOEVe5CIYrni0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792417754; c=relaxed/simple;
	bh=/H20TjWtP3RF9Z9Q9Z+asSYC920JHsHNVzwlKdyJVLA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=rpzwmMMfO/oVsN66hpl5xcZtFehWhzSURyzNmCMzlkcrfUiWzCrp6rlmee0r/6N0/dKQ6jIXunebU9DV3gd7BiMMnX1WAUTkyvjNWCha8aRZE/rPrcZ76OlINh4pVppHfTsDFuIiWhXk3rH9H8T2HmNwxynWoX5RvHjdc1zqie0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=RouaN5XH; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=REHDnFq4; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="RouaN5XH";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="REHDnFq4"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1792417746;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=F6hG5hEZ3qv63jog/4r6msK9S/4DzwbMWpmaJPtXBWs=;
	b=RouaN5XHtXpetSzTh2uJa7sNqelWXAnYrIe7suxP6DzJJjSX3bRk5mVjdQTytvb5kr2XL9
	tu4ed5aZiacVwtV2Gseflu8lwUUSF1qzNDTqOFxpQjlCYMFt7LhXcEIAwY6/XPTO+6otTB
	6PJPMlsWzS/zlmnKBLSogPdcaTkezmo=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-122-3X8vOgqYPlyDclxhQM_PPQ-1; Mon, 19 Oct 2026 13:48:49 +0000
X-MC-Unique: 3X8vOgqYPlyDclxhQM_PPQ-1
X-Mimecast-MFC-AGG-ID: 3X8vOgqYPlyDclxhQM_PPQ_1792417723
Received: by mail-wr1-f69.google.com with SMTP id ffacd0b85a97d-48dfaaea30cso1435193f8f.0
        for <stable@vger.kernel.org>; Mon, 19 Oct 2026 06:48:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1792417722; x=1793022522; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :content-type:mime-version:references:message-id:subject:cc:to:from
         :date:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=F6hG5hEZ3qv63jog/4r6msK9S/4DzwbMWpmaJPtXBWs=;
        b=REHDnFq48GfNbdMovhouZpmsPr/N5WPzgSt0fkW6UWbjJAHbpPGEU1b65voKOSp/PH
         1eBq+RQ0qfc/7A8c5BQvn1JHb7SmElAa90DrLhU2aLWfrkrpb4cPjyNGHYTDmXzMt/Ii
         bjAKtXA3YdXG6hHqbIVZV/jd7Y70c3lffyoyYX08CHe3pv2X5oeO1qI26pyUKyRmWi5U
         lvyCI+RWb1lWIajqAef1nPzWmpPe34Gizfk44A5HJeigGsmNzY5Miu9W9mpbSLJ9vzyt
         rCgjgWq/5VLQWdnFYgyxx6T25YoAGqsB4z2I9e5HBZAY7Jrz7+ViS3jPxUqw1RQ1z8Z6
         juMQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792417722; x=1793022522;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :content-type:mime-version:references:message-id:subject:cc:to:from
         :date:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=F6hG5hEZ3qv63jog/4r6msK9S/4DzwbMWpmaJPtXBWs=;
        b=BXSYnrSGFok1vJHQaAELbthkP1hjK7vLtiApLAPBpHU/+kfMU71bES6sWyT6TJyQ9T
         C92NRyevtEenfp301k/9FlkZNYCtMhFjj9XQbFHpkwx5hv6ExUgyHYZcnCkKRfK5079r
         fQlQ3nBbzyjkKKuV/hZrbmj5jq2S6hm2fRaI59b8JdgGP8wZD+Um1zOEcnC+rBjmHyLl
         Qi73rLCAQl6wLjGoK/NPFlmohaMW+Ze5F8BO9gkg087alwFCo6aW2GGU9SPXebqgbOB7
         OA4X7Rf577CWWUp6l4eZI2xuyrkXUXiLXC/ZgrCeoTG4j73z5FTO1xWYqVKmUX5Dk7Rn
         A3eg==
X-Gm-Message-State: AFq9FYKuCkaoQ/cOtOlgt6tfgtnE3CHXF7MA6OGUHsyoVtOftJDtYinQ
	BvYNjlYJca/xD7A0/XsL+9TwPMc3rx6XRmGd36tR5lyJcNMkGv0Heg9XSu+zRm7UyYCSjtBEO78
	g5C4JUsGDU6D5NimCMmB56vXLZ0etHcIFrAUEW5O5yR1XGtuGfFkLxhg0rSN0IOnm3MlfDS3uty
	epauZla8hWfcR/qDmmgEYHBPTR/fCB8nXUapL02qFL8Q==
X-Gm-Gg: AYBFou07xjg7YAqAUhq0iGUAaBi/EF1VKA6nrfvwx+iSEBT5LQzTRIYWvq8CXAzH4J8
	ppZZBed5fhSDZcv+pBvMBcbMlSxnUFQ3S/5rWmrGpeUDI/BT59gf0sUg9xRPwPD3pyl1kDXycqr
	Le3mXwW8ldhE8dk02xv3O7DBzQq9QS5wEi21mJdfsa+JVup3NMJZt4VPiSDW8IM9MaO5DcJ13Dr
	jE/RFabWNSg33cMcumETF7UTB0o91XLVr2+ep+cj5rnlZ2R4Mrm/5KLS47S4WFEYELq1lcxNQlm
	ymH4zz53pSEglcbxAyD5O30MlME5VCOeYPBfU/dPpbJCSS0BsGYhpM4L96Cqzl1/TceuMgcZ44a
	RaB1O
X-Received: by 2002:a05:6000:3c6:b0:48e:d26:e0f4 with SMTP id ffacd0b85a97d-48e0d26e2e6mr14585502f8f.55.1792417722487;
        Mon, 19 Oct 2026 06:48:42 -0700 (PDT)
X-Received: by 2002:a05:6000:3c6:b0:48e:d26:e0f4 with SMTP id ffacd0b85a97d-48e0d26e2e6mr14585425f8f.55.1792417721894;
        Mon, 19 Oct 2026 06:48:41 -0700 (PDT)
Received: from sgarzare-redhat ([193.207.74.151])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-48dfd50aafbsm24636418f8f.52.2026.10.19.06.48.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 19 Oct 2026 06:48:40 -0700 (PDT)
Date: Mon, 19 Oct 2026 15:48:24 +0200
From: Stefano Garzarella <sgarzare@redhat.com>
To: stable@vger.kernel.org
Cc: stable-commits@vger.kernel.org, edumazet@kernel.org, 
	"Michael S. Tsirkin" <mst@redhat.com>, Jason Wang <jasowangio@gmail.com>, 
	Eugenio =?utf-8?B?UMOpcmV6?= <eperezma@redhat.com>, Xuan Zhuo <xuanzhuo@linux.alibaba.com>, 
	Stefan Hajnoczi <stefanha@redhat.com>, "David S. Miller" <davem@davemloft.net>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>
Subject: Re: Patch "vsock/virtio: fix potential unbounded skb queue" has been
 added to the 6.1-stable tree
Message-ID: <atYeWYox-fcuEHX0@sgarzare-redhat>
References: <20261018131321.3798770-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20261018131321.3798770-1-sashal@kernel.org>

On Sun, Oct 18, 2026 at 09:13:20AM -0400, Sasha Levin wrote:
> This is a note to let you know that I've just added the patch titled
> 
>     vsock/virtio: fix potential unbounded skb queue
> 
> to the 6.1-stable tree which can be found at:
>     http://www.kernel.org/git/?p=linux/kernel/git/stable/stable-queue.git;a=summary
> 
> The filename of the patch is:
>      vsock-virtio-fix-potential-unbounded-skb-queue.patch
> and it can be found in the queue-6.1 subdirectory.
> 
> If you, or anyone else, feels it should not be added to the stable tree,
> please let <stable@vger.kernel.org> know about it.

Be careful with this patch, this caused data loss. It's fixed upstream 
by commits:
a4f0b001782b ("vsock/virtio: reset connection on receiving queue 
overflow")
2a12c05aef21 ("vsock/virtio: collapse receive queue under memory 
pressure")
c6087c5aaad6 ("vsock/virtio: fix skb overhead accounting to preserve 
full buf_alloc")

So if you want to backport this patch, I strongly recommend that you 
include these others as well in the same backport.

Thanks,
Stefano

> 
> 
> 
> commit 86c46b1c51eea22456caf8a28a43ccc3da623f01
> Author: Eric Dumazet <edumazet@kernel.org>
> Date:   Thu Apr 30 12:26:52 2026 +0000
> 
>     vsock/virtio: fix potential unbounded skb queue
>     
>     [ Upstream commit 059b7dbd20a6f0c539a45ddff1573cb8946685b5 ]
>     
>     virtio_transport_inc_rx_pkt() checks vvs->rx_bytes + len > vvs->buf_alloc.
>     
>     virtio_transport_recv_enqueue() skips coalescing for packets
>     with VIRTIO_VSOCK_SEQ_EOM.
>     
>     If fed with packets with len == 0 and VIRTIO_VSOCK_SEQ_EOM,
>     a very large number of packets can be queued
>     because vvs->rx_bytes stays at 0.
>     
>     Fix this by estimating the skb metadata size:
>     
>             (Number of skbs in the queue) * SKB_TRUESIZE(0)
>     
>     Fixes: 077706165717 ("virtio/vsock: don't use skbuff state to account credit")
>     Signed-off-by: Eric Dumazet <edumazet@google.com>
>     Cc: Arseniy Krasnov <AVKrasnov@sberdevices.ru>
>     Cc: Stefan Hajnoczi <stefanha@redhat.com>
>     Cc: Stefano Garzarella <sgarzare@redhat.com>
>     Cc: "Michael S. Tsirkin" <mst@redhat.com>
>     Cc: Jason Wang <jasowang@redhat.com>
>     Cc: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
>     Cc: "Eugenio Pérez" <eperezma@redhat.com>
>     Cc: virtualization@lists.linux.dev
>     Link: https://patch.msgid.link/20260430122653.554058-1-edumazet@google.com
>     Signed-off-by: Jakub Kicinski <kuba@kernel.org>
>     Signed-off-by: Sasha Levin <sashal@kernel.org>
> 
> diff --git a/net/vmw_vsock/virtio_transport_common.c b/net/vmw_vsock/virtio_transport_common.c
> index 6ea00b8630351..12d5844d98e39 100644
> --- a/net/vmw_vsock/virtio_transport_common.c
> +++ b/net/vmw_vsock/virtio_transport_common.c
> @@ -254,7 +254,9 @@ static int virtio_transport_send_pkt_info(struct vsock_sock *vsk,
>  static bool virtio_transport_inc_rx_pkt(struct virtio_vsock_sock *vvs,
>  					u32 len)
>  {
> -	if (vvs->rx_bytes + len > vvs->buf_alloc)
> +	u64 skb_overhead = (skb_queue_len(&vvs->rx_queue) + 1) * SKB_TRUESIZE(0);
> +
> +	if (skb_overhead + vvs->rx_bytes + len > vvs->buf_alloc)
>  		return false;
>  
>  	vvs->rx_bytes += len;
> 

