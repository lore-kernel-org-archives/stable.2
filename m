Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C0CC13ED100
	for <stable@vger.kernel.org>; Thu,  9 Jul 2026 08:54:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783587287; cv=none; b=iSSoWLo2J538AN2fugKrg+ynrjAt5HIl4pI4DcMgkJJTA/pF/V6FVT1GhcduTEjvd2m2cW/ku7RiFJg2DQDZMBcLeVIADIp6I965Rxk/j1M+5bvNL3XTwiagSkuCr+lBYJaLZa9DKFFbEPW+/BmgPQPwsBMarHz+HvDiSOVZiwg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783587287; c=relaxed/simple;
	bh=wRRaBds4GutgazHTelDLWoEKQjUD+qekfGeab8oKIas=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=u/1k1A9UosB7iliCA1U9FlaBZFTQwZoQOeJZokgWhIu3guZrLqiE5LZXfKmNd8VfY2++jjOblre+Mwy5Jff4rSU/OPzojE/Zal7hxCykOP0OAVyqshsylDx4scVHn10vepc/bS0Eq0ryMUn+TXJI2Bq4Tu7oQ+VCmQRZMmuDafc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=BlAyjAbL; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=VRfyHjBN; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="BlAyjAbL";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="VRfyHjBN"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1783587284;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=jKBatJUUTBddrBcocZDnsS1t1LpIJaEaNIf3BrEu4hE=;
	b=BlAyjAbLykGVnxtSiIUcYYke3Ot7vTQth/cP4NWIv/m6yme76bTdo9jqpsi3IYY+qSWdvD
	SKW+4Du4VQksNJlpdpoG0V2F1lHYKZGzb9QLREV/M3l1h9mJ0K4HFkiHgR3ii7CKsWXGyS
	7EePKe9LQiCImxRy38vrkBO56kdltGw=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-680-63YfB9_6OgaCUM5Maek61A-1; Thu, 09 Jul 2026 04:54:43 -0400
X-MC-Unique: 63YfB9_6OgaCUM5Maek61A-1
X-Mimecast-MFC-AGG-ID: 63YfB9_6OgaCUM5Maek61A_1783587282
Received: by mail-wr1-f71.google.com with SMTP id ffacd0b85a97d-4629f312a67so1414030f8f.2
        for <stable@vger.kernel.org>; Thu, 09 Jul 2026 01:54:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1783587282; x=1784192082; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=jKBatJUUTBddrBcocZDnsS1t1LpIJaEaNIf3BrEu4hE=;
        b=VRfyHjBNh75myXSj6eNN9uojHY/fPLF/k/3P9YZXppPcS7iBiRZqeTWfibSaIP70v6
         XGR8dPfKKBQF9kBq9xpuF42VD6BcpktQA7kWflvLltjUTxAocimpGwiAX00jK6WNBwkl
         vwKNXNuj8dCSYzNRfPjR9A99k7L1oUpHYF9utMTVxIEU7TatuRs5RNPNDDTJLxi8K0Gd
         OxEEogW7gkOBtgHO4BZpFOD4z5IYpLXMm6WsdhziMWAs3Ua7lgVYlbPEurPN9YgR7QJF
         PZ16ptZigP6FjrVoVuAZDd8hY/eODzEveoxkPZ7hnjG+aOgR9yT5IUJADM990A/bNhJK
         3B8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783587282; x=1784192082;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=jKBatJUUTBddrBcocZDnsS1t1LpIJaEaNIf3BrEu4hE=;
        b=L9rLYDIsTgECaoPG3O+RyQcjqHapbqS1fct0/ag6pKx0FZKEtv+HRU7k/cPBqllLTS
         nelx3k+p8bFRYmj6l9rGZtCm7HCxyfMSbY5J+LOXhlh8wBlnXU+CK9kOqqOzqUnAdsci
         prl03ZiCHYB+6oz2oU6fo/gpul568l6s5LwuBcxtqHzGFvxMOOgFDDCipzlvY4W50JPi
         QZteMCZglDKbCWYvRmfGTAhUwipAHyl/8Jw6yO0QZhUVevvC3LvWtMjqrKSAFSFFZs3n
         S8T4I3hNM2Ab5HRPXgHFFp/LBgHFBG4EGQNXM/vJHSFsbHSAc5H9sp8rtCpsECYb7sVy
         tnoQ==
X-Forwarded-Encrypted: i=1; AHgh+Rrzj9eVuYcMZ6JPO95XGt9IVQs0CpWwoTRgK19vCe780kExN9HVs1BiMYXzV3fEZ3Onb2mkysk=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywly7V2+u3AsfH8mlqejutFZF1ETmvV+3LpFoMmKUeQBsQaVIx8
	47zvCYE8bb06rY3PgFwUkefan/u3qp6HlBZOwTFi+dw791QcFnkcTINDaiWu/i3FwIXLlQgUn1q
	4SxOeQM6UUlLoy5umIGhQdEKffbq4ehHwgULCL4v/4Ro+hJAlZ0/l4ZZkRQ==
X-Gm-Gg: AfdE7cmOtMg9fdAn6M7pPg8PHBDVMaMNiMo66g7wTRnDuuCWBL4yg0ZkqoIZMII8nHU
	q/y902jVWae+lNZtbnzLaUi2X7w+XntFY4TiyVYKX3lP1Pp1XAPejRxESj8Y36TXsoeDaLdjQvU
	pTkf7GNGbpU9aARbCUUOWBKj8fOiwYi5+OTyP+4BJVV/G98zS6R60lW+3MHIFs6QzTo2F+xHTIU
	dfo/G0o5yuLgb/EFt+qt5lxVwMaF9KTYlSDmP2OrQATcFX8+IO/nE9SX13JOSYEmO/vBYklcknR
	nQoHDmSw14H6+sD9KMsRevkOckDI/u3XgwokAXJtNP/ME5u+aK1T5cCBWVnBEM8IxpsJYb3YXYl
	dUfQLnQFdK0UPVqsc5onf1nIk9nNr2DCjQEdqqF6wYn4Laqwe4fOyNc31Zp3A
X-Received: by 2002:a05:600c:1993:b0:48a:906b:14ca with SMTP id 5b1f17b1804b1-493e68c6c98mr55722845e9.20.1783587282381;
        Thu, 09 Jul 2026 01:54:42 -0700 (PDT)
X-Received: by 2002:a05:600c:1993:b0:48a:906b:14ca with SMTP id 5b1f17b1804b1-493e68c6c98mr55722455e9.20.1783587281922;
        Thu, 09 Jul 2026 01:54:41 -0700 (PDT)
Received: from sgarzare-redhat (host-79-34-22-35.business.telecomitalia.it. [79.34.22.35])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-493eb6df6d9sm54564705e9.7.2026.07.09.01.54.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 09 Jul 2026 01:54:41 -0700 (PDT)
Date: Thu, 9 Jul 2026 10:54:34 +0200
From: Stefano Garzarella <sgarzare@redhat.com>
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: netdev@vger.kernel.org, Jason Wang <jasowangio@gmail.com>, 
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>, Eric Dumazet <edumazet@google.com>, 
	Eugenio =?utf-8?B?UMOpcmV6?= <eperezma@redhat.com>, Simon Horman <horms@kernel.org>, 
	Stefan Hajnoczi <stefanha@redhat.com>, "David S. Miller" <davem@davemloft.net>, 
	linux-kernel@vger.kernel.org, kvm@vger.kernel.org, Paolo Abeni <pabeni@redhat.com>, 
	virtualization@lists.linux.dev, Jakub Kicinski <kuba@kernel.org>, 
	Jason Wang <jasowang@redhat.com>, stable@vger.kernel.org, Brien Oberstein <brienpub@gmail.com>
Subject: Re: [PATCH net v2 1/2] vsock/virtio: collapse receive queue under
 memory pressure
Message-ID: <ak9fGNnW7gdqVXie@sgarzare-redhat>
References: <20260708102904.50732-1-sgarzare@redhat.com>
 <20260708102904.50732-2-sgarzare@redhat.com>
 <20260708065947-mutt-send-email-mst@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <20260708065947-mutt-send-email-mst@kernel.org>

On Wed, Jul 08, 2026 at 07:00:00AM -0400, Michael S. Tsirkin wrote:
>On Wed, Jul 08, 2026 at 12:29:03PM +0200, Stefano Garzarella wrote:
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
>> The collapse is triggered proactively from when the number of skb queued
>> is close to exceeding the overhead budget.
>>
>> A pre-scan counts the eligible bytes to size each allocation precisely,
>> avoiding waste for isolated small packets. Partially consumed skbs are
>> kept as-is to preserve buf_used/fwd_cnt accounting, EOM-marked skbs to
>> maintain SEQPACKET message boundaries, and skbs already larger than the
>> collapse target because they already have a good data-to-overhead ratio.
>>
>> Walking a large queue may take a significant amount of time and cache
>> misses, causing traffic burstiness. To limit this, the collapse stops
>> once enough room is freed for this packet and the next one, but may
>> opportunistically free more to fill each collapsed skb to capacity.
>>
>> [1] https://github.com/stefano-garzarella/iperf-vsock
>>
>> Fixes: 059b7dbd20a6 ("vsock/virtio: fix potential unbounded skb queue")
>> Cc: stable@vger.kernel.org
>> Reported-by: Brien Oberstein <brienpub@gmail.com>
>> Closes: https://lore.kernel.org/netdev/618701dd023e$063de350$12b9a9f0$@gmail.com/
>> Tested-by: Brien Oberstein <brienpub@gmail.com>
>> Signed-off-by: Stefano Garzarella <sgarzare@redhat.com>
>
>
>this is the right approach

Yeah, I have a follow up to start to use skb->truesize, etc. but I guess 
more net-next material.

>
>Acked-by: Michael S. Tsirkin <mst@redhat.com>

Thanks,
Stefano

