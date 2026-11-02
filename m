Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=170.10.133.124
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793640613;
	b=ZT2KlblDOXcmiegsUs0vb9KZptPpA96K7C7+J9Mj/FVf7tqANNjM6L6X0ikiXl/P5JUR
	 a0SFUuhqb558QVvj7vYpEguWKZSjtdRdTOTvEM0DDyQAWuzeq7jIhcpnzeeTAFv0DhBSk
	 RyLL93zEGAR8JoiPUSM+njbgEb2rvAlNBF/IlztXKt0PbNt+2FjY0WmBSFmRE88yqOkvR
	 WnOzu5wO+7ztHvqQGG+YqMo8/SGERcWA/7qmkveWOTXyU9oG0Y4dPp1HGZKM5ZvUjy2ah
	 J4DMxisZSPmk7YdXjrqTGV+qHhuAmGpc3CaWDdfCkg2R5W2Rlg7arowcQdVN5pUsfzA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793640613;
	h=DMARC-Filter:DKIM-Signature:Received:X-MC-Unique:
	 X-Mimecast-MFC-AGG-ID:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 X-Received:Received:Date:From:To:Cc:Subject:Message-ID:References:
	 MIME-Version:Content-Type:Content-Disposition:In-Reply-To;
	bh=6iS3CAxGQE93xDrvwr4yw98qv93SkzvwRHW7OrIP7aI=;
	b=JYzHxalxlkQ61dCDJwuKfW0/Cy+5Olz6h4KDfd00d2QimDi2t/l5p96hbv7PIbW2hFNs
	 378JEmF5wDQntFT4J6QabD4+mWm0UpagDyco6whWGvpfzpGSLCWQwSIrkjB6NyIEksmvE
	 YvUy2F4nqZ58A7OrsA+b5W9cyjNjnSWrriFiWzQ3rcUrDCUO7BltQ8xGZOewosByeMn7E
	 GIStw9pAuYNdZFhxdzKRnpz6EwLllAUoPsYaoF3wNM+/j0qhT/Zqz+a03S/0WSF15W7Eq
	 ZE/4ngHVqN3kNaDEbR+EsaKrxd1R9TuMERwqmMfNmrvi/oztsEcyGZrU4pSohFjXOLg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=redhat.com;
	spf=pass smtp.mailfrom=redhat.com;
	dkim=pass header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=cVHqKo+c;
	dkim=pass header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=google header.b=O4pI9YlU;
	arc=none smtp.remote-ip=170.10.133.124
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 796BA606E022
	for <stable@vger.kernel.org>; Mon,  2 Nov 2026 17:30:12 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 796BA606E022
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=cVHqKo+c;
	dkim=pass (2048-bit key, unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=google header.b=O4pI9YlU
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1793640611;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=6iS3CAxGQE93xDrvwr4yw98qv93SkzvwRHW7OrIP7aI=;
	b=cVHqKo+cR9hVdRp1gzTzOB/gO+4Bn1DxpQ+r2nfHdNNUg5zRVkKpD20/bc3WGMp0fvGXlG
	knCu3vQkM2t5YKrQ+cYMcP9d5UYUz02NU4LTexEoVGZ8B4et0ohJ3ujfCrnc1iSS8jCBHK
	UJilzCTU6vlv7xjzgyVpBGjgif7jB/s=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-370-0pcAWqNpOqmcc5ZoY-U5dQ-1; Mon, 02 Nov 2026 12:30:10 -0500
X-MC-Unique: 0pcAWqNpOqmcc5ZoY-U5dQ-1
X-Mimecast-MFC-AGG-ID: 0pcAWqNpOqmcc5ZoY-U5dQ_1793640609
Received: by mail-wr1-f70.google.com with SMTP id ffacd0b85a97d-48af4046a3bso3235426f8f.2
        for <stable@vger.kernel.org>; Mon, 02 Nov 2026 09:30:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1793640609; x=1794245409; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=6iS3CAxGQE93xDrvwr4yw98qv93SkzvwRHW7OrIP7aI=;
        b=O4pI9YlU92DDxrrSy6abElpco/qX3degbuogWx2SVyZyGnQ8Ljm8FwI4vtxoPyfDyC
         rhCe1JAnalublysmvZ6emIRr4ywccBIFc/TvwrdeH/FMuISwOSIg5cHb6MSYJ7MzZu0y
         yFsgAi16SjhXDtpLRy7vETL/sUyNwc/N2NMNodNJ1l9y/dGEvLTF4VA2p5XJdmE7+kzQ
         kEebFLK9C9ODAhgFXrTA1Gqx4IU7k9Bj9P3/jQPyW7Kmze2YxH2EFHVfP2KGGOCElP4M
         G9zeKnZ7EUvP59V4zJiHeV/v/BkOMR99FE1/Bjog31DElcdlOg1M5UQSgwPTzPtD52Vm
         ZixA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793640609; x=1794245409;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=6iS3CAxGQE93xDrvwr4yw98qv93SkzvwRHW7OrIP7aI=;
        b=X1Dt8WwcQYj/pb6raM4+3DhobYpSZjDiNF3O7JmhGlfmbDvFFSJMBp4aKRuJWvnTXM
         HtrxSqxTT0uL4Z1oIIiBDX10/DDyblh4OKgrMYNsvhy1f7iRanXcFOnMKewxvrau0uzv
         P7K/W8BSeHZyQuqQiAcECEq3lFkn2f7akNpaQQKJpeEcl5DQ15ZD9IDbyFgEgtlowWIO
         EFpV2xmnX6ncYjInQgb8lQLUq3xFktL+eb4AECabM3jhkanuNf7fZq2g4esLgESjmpuZ
         7xwRzgw6XoZ34s47vT8BB46pENAhknWhm1b9DEfpYpNz9SD98hd3o1lSC/T0O8rBfmpD
         scRw==
X-Forwarded-Encrypted: i=1; AKwUvByClG3//6HXqi+zWtp77kanu1ZaxptGbjlBaA+UrXBvLCNQjl2DA000//ubOS6F6WrUxf1E/2k=@vger.kernel.org
X-Gm-Message-State: AFq9FYINbZEUwenur8HJ2QdIKp05IXk78l8WutVxJfCEmWcuriTDD70F
	jzKmVxiO7R+qTrRH6NkYi9VOnEndJc3/trYgNbe51oOWW1g+VJZ0fHGG+QoLQPNmH9kMM18fXkT
	JLxeDgY806bBCSlye2ysR1xkVNspNBPtLidGDZn49JJ/uuQIB54Pkz3bhSg==
X-Gm-Gg: AYBFou2pqurislxvHzxcq0QZdypiL6C9RaCaTkWIiJsQIGyMxdSAqTcgVXHutMWXWjS
	5bc8BVS8g+j1fv0qRLuZi86HTuBBJPc+nGaSYSsq+b8VnQnrVFzA2sBS8lvEIrUJvHDLY5rNUBp
	mLhcdexD8UzINlpNgIZtmoNwetCI4BMZj8lj8QpU7XiAStnXCcvfxbqnDrLFY4vYdj+j39j0skH
	T/5JVTpeZLyBDL1HY16Gc3a2WfwGuE7akrKPjfhBDFL2jIojpDfgiwVp3y7D7KP+QL0GsvhXPNV
	DJqPL4KU0zHBoT9B9QDxLuKKzYc1xzOGh17Yn+5xZ47myEMM7c50LXbjyBRQgmP07erGIQeVVY2
	iWEprXw/Jj7p76CsKxwmjLO1I5XBhF/P4R7p3lKvuZQ==
X-Received: by 2002:a05:600c:c088:b0:4ac:da92:2bd4 with SMTP id 5b1f17b1804b1-4acda922e24mr165297195e9.1.1793640608962;
        Mon, 02 Nov 2026 09:30:08 -0800 (PST)
X-Received: by 2002:a05:600c:c088:b0:4ac:da92:2bd4 with SMTP id 5b1f17b1804b1-4acda922e24mr165296615e9.1.1793640608457;
        Mon, 02 Nov 2026 09:30:08 -0800 (PST)
Received: from redhat.com ([2a0d:6fc0:1506:fd00:9e19:9994:44b1:e6f2])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4b2a8d60ca0sm1461205e9.7.2026.11.02.09.30.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 02 Nov 2026 09:30:07 -0800 (PST)
Date: Mon, 2 Nov 2026 12:30:04 -0500
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Fang Xieyan <fangxy@xiaopeng.com>
Cc: Jason Wang <jasowang@redhat.com>,
	Eugenio =?iso-8859-1?Q?P=E9rez?= <eperezma@redhat.com>,
	Stefano Garzarella <sgarzare@redhat.com>,
	virtualization@lists.linux.dev, kvm@vger.kernel.org,
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
	stable@vger.kernel.org, Guanglei Zhu <zhugl3@xiaopeng.com>
Subject: Re: [PATCH] vhost/vringh: reject zero-length indirect descriptor
 tables
Message-ID: <20261102122942-mutt-send-email-mst@kernel.org>
References: <20261021070242.75009-1-fangxy@xiaopeng.com>
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261021070242.75009-1-fangxy@xiaopeng.com>

On Wed, Oct 21, 2026 at 03:02:42PM +0800, Fang Xieyan wrote:
> move_to_indirect() accepts an indirect descriptor with a zero length,
> setting desc_max to 0. __vringh_iov() then reads descs[0] before
> checking the descriptor bounds, resulting in an out-of-bounds read.
> 
> Reject a zero-length indirect table in move_to_indirect() so the
> caller returns -EINVAL before dereferencing the table. Also use the
> converted length in the warning to report invalid lengths correctly
> when the vring byte order differs from the CPU byte order.
> 
> Fixes: f87d0fbb5798 ("vringh: host-side implementation of virtio rings.")
> Cc: stable@vger.kernel.org
> Reviewed-by: Guanglei Zhu <zhugl3@xiaopeng.com>
> Signed-off-by: Fang Xieyan <fangxy@xiaopeng.com>


Isn't this already addressed by
Subject: [PATCH v2] vringh: reject empty / undersized indirect descriptor tables
that you posted previously?

> ---
>  drivers/vhost/vringh.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/vhost/vringh.c b/drivers/vhost/vringh.c
> index 9066f9f12ba1..ce4f5a02c8d2 100644
> --- a/drivers/vhost/vringh.c
> +++ b/drivers/vhost/vringh.c
> @@ -197,8 +197,8 @@ static int move_to_indirect(const struct vringh *vrh,
>  	}
>  
>  	len = vringh32_to_cpu(vrh, desc->len);
> -	if (unlikely(len % sizeof(struct vring_desc))) {
> -		vringh_bad("Strange indirect len %u", desc->len);
> +	if (unlikely(!len || len % sizeof(struct vring_desc))) {
> +		vringh_bad("Strange indirect len %u", len);
>  		return -EINVAL;
>  	}
>  
> -- 
> 2.50.1

