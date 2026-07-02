Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 56DEF38A70C
	for <stable@vger.kernel.org>; Thu,  2 Jul 2026 08:56:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782982576; cv=none; b=iuZrynXTQmamr2/LOpp4JwBGLvU3JRRfuB/SkZsN+U+Qm7sU3DU7R8Hu9MDYPMqUhNU/XhFGJxi9W1+d0aDeHvTEFPp9vAMXoFkPNnpSm4uL8IPwYeGNs361delW31ytp4o5gl46t5xIchijEIXW+jXNz5dbrLZ3oajIUyilRwg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782982576; c=relaxed/simple;
	bh=IqR1f/AEimWy9td6sTkb7Jq/+F4NeD8zy8Z1IlmH0fM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=EH7FQ44cbYxyz2bRHxZTjEIkbXyzMneLFpsLArVohJv0uEsVaPqtRO13/Hu5HZGohZCz+GP/43ffF01ntbAvPff7fJ8oryvO1Tz/zGHOT2Ms/GF5N5jxWGBqXV8/F0hwVIbmskklT3AVTp35Vf67gbfAhBcqU1bkY1DXKALcNHw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=NIAkYwu7; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=g+H1OBUj; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="NIAkYwu7";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="g+H1OBUj"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1782982573;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=jzu6+yi+0UPBChb/E9Oct0h9dnkvsRVovpFSB+irYu0=;
	b=NIAkYwu7JBsTy1fzH/eXQQ6PmDA9VEozqbBtoL8sGuh5QQxT7BqKYp4nZEUXNwLkbZEIzS
	yAFAvIxcqrjAZCAGxPsbe8zK0LZdnacQ3WKjwr64yMCwNP9QoiN05gySUJEPYuzTHcfWrE
	9aT5a+V6UdHZSFXo004LgEFVJY4xyX0=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-687-CLeAvVW8PKOMTavdB_PARQ-1; Thu, 02 Jul 2026 04:56:12 -0400
X-MC-Unique: CLeAvVW8PKOMTavdB_PARQ-1
X-Mimecast-MFC-AGG-ID: CLeAvVW8PKOMTavdB_PARQ_1782982571
Received: by mail-wm1-f72.google.com with SMTP id 5b1f17b1804b1-492714d002cso11302675e9.0
        for <stable@vger.kernel.org>; Thu, 02 Jul 2026 01:56:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1782982571; x=1783587371; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=jzu6+yi+0UPBChb/E9Oct0h9dnkvsRVovpFSB+irYu0=;
        b=g+H1OBUjhsMBbbQW0qzr+CQZod/o5/IvBj2mdzDYzZ2Kd1COtqsUb4fLZHQiuCLDv1
         FXTSkJTGHC03c5CIBDky5P385pJXxoUGYjzh9lGEig+OyrIiLNle7OdDiQ22ntFpaRzY
         WoxmpdSBi6vikaaMbxC5b4tf6xpdQ6y2tf1WyegdSbHMj92t5Kz8Ma1yhyLLP27ji11Q
         chnKeTNzoxWlQT+51J7v0Ln4pYCy/mNxbPnQtglPHzaI0FyPa0TiXjzOSywIQBW9FDJk
         /6K73a9CVDAh2QyA8DW2XSyu0fOobhVW6dA6I0DU66IYEJT3lJ+sZUTIYdDgq21KTIGs
         kLYA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782982571; x=1783587371;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=jzu6+yi+0UPBChb/E9Oct0h9dnkvsRVovpFSB+irYu0=;
        b=b8gFLB2pLiHxV6N8KxIbULslH+iCIeFCGcOkumI7nXduXU77i5p8keevoxT1JIxcGs
         AgkOakJGicSGXGVQo96qZbomOp3hqCAJN0CinQUx/BijN9zRTDtVaHxPsyRdc9UqF90N
         awNl+g23oBBPP7POeVyANZtOM3baBzxuDyV2345FePFf9PsFg5CJdeFO/pAZpfLC4zSc
         /wcTccsTXnpPvCB+DmSHvhxPme/ldozKvzEBXxXhnwiVbjefQhjxaOwVVVE/T/IpdvXq
         c4GiuADyPo8xUmToQE4igpUwc8AfBKkKIsONn4vDJSqjej9/cPEjoH5eka9jPrxdnuYV
         NCAg==
X-Forwarded-Encrypted: i=1; AFNElJ8xCcjvE3P9jz6CX7wm6slQDdz8iM+P4crxvpH8sKxErMcqboShBs44282zO1LmqDDRu3eqClE=@vger.kernel.org
X-Gm-Message-State: AOJu0YyOz2gLPC71FDbs+qWt22icI3UM3Yos0181UoNk7/YtN6Qt2xX/
	hyAKxVXcc5OeUW8Vrf51rAfeMD89F42QrbUq3nLd12Sd12r5SfQIOHVwME9ADYGPx53pUsJT5vM
	CqiD4CkCEbINMoM8ITbK7u/8MSoUnKibuY7kGnNn/1IP5f1wmyeaZjxno6A==
X-Gm-Gg: AfdE7ckxRhHcp/lPaXhA7Dbmkh6vkp7cf2LRbOIdaaEzcPXq/NptlW3pA0XdqrBdfKR
	PEKTDQnRonWrDrWjLiivl33t5ia2gypARWH/y+fLy/NXfcTFXmHZmphvDgbD0Fu9Zud3XVFPVqw
	J0AJOvrmUTccl8TG9DnpwplIwNgCIXSzuJcJ2qgbR1GqMkDCKnr9qWjZsl4SYU0DB1ohsmxmID8
	TC7CRn/ITHrKVGjWRPnjUStHoNXjz/1mUdO0fAWHOB9dUiUkIF9OVVIVJfMIjzGGpxDYnXy/cFD
	qhSOzCTJzjTBwnJzKnsCo10UARJcmpxNGonKsApRZ8ycyET9IX8wQ1UN3j7O9KyOhb6Swa8Pibk
	J/fd9X/NdFlrW5Ate0xarx8xOnXdv/mL89HARNh3N1AMrgtBj+Xq8BYg0eGfp
X-Received: by 2002:a05:600c:5391:b0:490:c032:ae92 with SMTP id 5b1f17b1804b1-493c3df2b42mr53317755e9.33.1782982570900;
        Thu, 02 Jul 2026 01:56:10 -0700 (PDT)
X-Received: by 2002:a05:600c:5391:b0:490:c032:ae92 with SMTP id 5b1f17b1804b1-493c3df2b42mr53317205e9.33.1782982570427;
        Thu, 02 Jul 2026 01:56:10 -0700 (PDT)
Received: from sgarzare-redhat (host-79-34-22-35.business.telecomitalia.it. [79.34.22.35])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-477ddf0f27bsm6829505f8f.30.2026.07.02.01.56.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 02 Jul 2026 01:56:09 -0700 (PDT)
Date: Thu, 2 Jul 2026 10:56:04 +0200
From: Stefano Garzarella <sgarzare@redhat.com>
To: Bobby Eshleman <bobbyeshleman@gmail.com>
Cc: netdev@vger.kernel.org, Jason Wang <jasowang@redhat.com>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	"Michael S. Tsirkin" <mst@redhat.com>, kvm@vger.kernel.org, virtualization@lists.linux.dev, 
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>, Eric Dumazet <edumazet@google.com>, 
	Simon Horman <horms@kernel.org>, linux-kernel@vger.kernel.org, 
	Stefan Hajnoczi <stefanha@redhat.com>, "David S. Miller" <davem@davemloft.net>, 
	Eugenio =?utf-8?B?UMOpcmV6?= <eperezma@redhat.com>, stable@vger.kernel.org, Brien Oberstein <brienpub@gmail.com>
Subject: Re: [PATCH net 1/2] vsock/virtio: collapse receive queue under
 memory pressure
Message-ID: <akYl38_9Y4ydXuqE@sgarzare-redhat>
References: <20260626134823.206676-1-sgarzare@redhat.com>
 <20260626134823.206676-2-sgarzare@redhat.com>
 <akVBmydgSd0Eb46/@devvm29614.prn0.facebook.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <akVBmydgSd0Eb46/@devvm29614.prn0.facebook.com>

On Wed, Jul 01, 2026 at 09:34:35AM -0700, Bobby Eshleman wrote:
>On Fri, Jun 26, 2026 at 03:48:22PM +0200, Stefano Garzarella wrote:

[...]

>> +out:
>> +	if (new_skb)
>> +		__skb_queue_tail(&new_queue, new_skb);
>> +
>> +	skb_queue_splice(&new_queue, &vvs->rx_queue);
>
>I think the new skbs will also need skb_set_owner_sk_safe(skb, sk)
>when adding to rx_queue?

IIRC we added it in the rx path, mainily for loopback to pass the 
ownership from the tx socket to the rx socket, but here we are already 
in the rx path, so the skb will never leave this socket.

Maybe it's necessary for the eBPF path?

In any case, I can add it, but if you can help me better understand what 
it prevents, that will also help me add a comment above it.

Thanks,
Stefano

