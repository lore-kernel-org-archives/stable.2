Received: from mail-qk2-f41.google.com (mail-qk2-f41.google.com [74.125.230.233])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EBF3946AA97
	for <stable@vger.kernel.org>; Thu, 24 Sep 2026 16:53:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.230.233
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790268791; cv=none; b=idW+6xoNmJoJxFzNEtnuSyeWjcMAs3eSsVqk8NxUWJOfpEgAxYqsYqX8wm5oQUD18jIapLqf0EgrWyX5ghmVbt4VZ0efMm7arvWOmqxZMZqMexzmsM7KwTODJBtjIIVZtuNiNa57t+rbwBZh2d0HNkaQd1mnBD/i0Xng81FQ6Ng=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790268791; c=relaxed/simple;
	bh=LorE3121kbAX0dxZ1po3DR7h466+jIoSoP4ATV7UzDo=;
	h=Mime-Version:Content-Type:Date:Message-Id:Cc:Subject:From:To:
	 References:In-Reply-To; b=PJ+u23DpPFDQ2SVSDGTMlHqd17xpWuL7sNtJ0kgNoAoBhKhE5z+mu9A7oKYtMbQPWXCwYcM6n7IW5JThCerxrm6jBIw3E0InzlsyGQIx7E1Kd8YUJuymJx/XuXpTDgq76gNgri9xnNtrl8Xu8IEH5y/00cgU49THyr5yAe8DrGk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=hOLA4gUy; arc=none smtp.client-ip=74.125.230.233
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hOLA4gUy"
Received: by mail-qk2-f41.google.com with SMTP id d75a77b69052e-532c7643bc4so509401cf.3
        for <stable@vger.kernel.org>; Thu, 24 Sep 2026 09:53:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790268789; x=1790873589; darn=vger.kernel.org;
        h=in-reply-to:references:to:from:subject:cc:message-id:date
         :content-type:content-transfer-encoding:mime-version:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=H7p/7arhw4fENNL3I9usSe+ODbWZbM+M8BPItKrFIF8=;
        b=hOLA4gUy3HaiPHPVeS/aI4XIC7z1Y/kbURnWjnJly1Y8DvKaeMn7D45tn5u8azU5sT
         4CmGa7tcrM90GJTy1RdE3Vzb9jG8u+G6vD9acwzPQv7urDyPzbQ/LURJGRibdmYVHFAS
         Jup9einuw3koekB2Lt1/hWRwooxY2BXCCrDUaBkn4C3U9thDraQEPovhzfV/lmdhdGj0
         nshdbc/mkIQwbS4aVs1JXq+pOAgFULe/ZgPm9zWl1yqrajyb8HNMDUh6OkISBnHcAXVK
         4JTEGmqY7lSHYC+G30vejTXddi1YeWhXa38/bMzPmhBRCf5j5wjJ0BlwviYxaEeg+Szr
         UwNQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790268789; x=1790873589;
        h=in-reply-to:references:to:from:subject:cc:message-id:date
         :content-type:content-transfer-encoding:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=H7p/7arhw4fENNL3I9usSe+ODbWZbM+M8BPItKrFIF8=;
        b=iok1uqqkJhBdSDY1TQrKIC6te2Xdr/gm0etioW0i/OcsOQJ1uEmmNlt1ytVTJ5y31y
         vShi3s5SFrhBG5EEZ7fXFKzZ+/QFZ/swwiUsLBNhSwCLwQmZyWMlM/BSe+H3SoQJs55X
         wbLW4dujSRgz753SS6Bw0SWejNMC6NaUH2wFLS1uDW5bAYi6rvise3muNnCds7+R+Zzc
         enrIViv9Bs1nH29v9x+TijuaBJJ3WQTLINJRpFjIN8+aRa8lGPdGB8VfX2xDXYgzL7f0
         7lWONxKl3hkPmQbsolB9amycyalch16LR/7CojhyuYiToueMYQDYGGYVkYUa0uaH2SAm
         AJAw==
X-Forwarded-Encrypted: i=1; AKwUvBzw63q0/1+lM2JAUhvX8lmtyn/d89tDDz2Fyd2T+IhFU1xUtmoxWC9a1WXvh5zieZPPsE0rt+s=@vger.kernel.org
X-Gm-Message-State: AFuF++mocnyfEsTPUiPFvhJARjKfp97Y+fecY3YSmXhY+9VUuqgz9bSU
	2fgQbgo2CSpiVhgEm8UERYxxd5O2yJveIu+fXkJ5DFfKeFVyJbnm/e6w
X-Gm-Gg: AYBFou2MAWOYd0SJoIc67zFOLvle0c2nGNpzc0ue7SVsX6tyRIdumfHdo2uBTB3R28m
	svT71/l+PA685otC1Y8Q0hYD37rSJWqSmTeDrQ0Aj+veLLOOWB3GP/pxFhOctFP2QE90tRSAAlN
	UqyDu5er2TzIPVeTxtiXVbyIs9bNiQshlTDezAPQrMTBEJTRWOOqWfV+4wcBBUguoL40/UveihR
	SghJB6qP4S9GOGUbCLizJFEFuc8ZGzN0QOTP1JNAQySQ3D0d+ZxhzO1eKAiofhmKqwzF+9tMnia
	RgSSQE24pB0QTZArjPat3HBj/xd/HMYDJJ2NerZbEHXPnw6X890bIXUk2z8Ciw6PYKDYSxYY+f5
	2XSp6rKd5A8GOjQlyGaJNPnB5Vy0Ovd+B7eCeGwlOn6/ys4yUO5A2I6WLboykV5fNpi7aD+PT0j
	xg9QkJ6++wjvFU0RX/gNhi3Epm+QFddD+NCJAUkXU9rMwSCgvmVY19E5BOzUVgiGpkOA3vIuYzh
	wI=
X-Received: by 2002:a05:622a:288:b0:532:d54d:5b34 with SMTP id d75a77b69052e-532feb60341mr30517451cf.57.1790268788761;
        Thu, 24 Sep 2026 09:53:08 -0700 (PDT)
Received: from localhost ([2600:4040:9399:4000:e553:72e5:7d37:c7ef])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-532eb364154sm46019211cf.22.2026.09.24.09.53.07
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 24 Sep 2026 09:53:08 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Thu, 24 Sep 2026 12:53:07 -0400
Message-Id: <DLNPBJ3BV10C.26KWSF0WJ9FAK@gmail.com>
Cc: <davem@davemloft.net>, <kuba@kernel.org>, <edumazet@google.com>,
 <pabeni@redhat.com>, <horms@kernel.org>, <andrew+netdev@lunn.ch>,
 <dzahka@meta.com>, <john.fastabend@gmail.com>, <sd@queasysnail.net>,
 "Willem de Bruijn" <willemb@google.com>, <stable@vger.kernel.org>
Subject: Re: [PATCH net] tcp: prevent collapsing skbs across boundary in rtx
 queue
From: "Daniel Zahka" <daniel.zahka@gmail.com>
To: "Willem de Bruijn" <willemdebruijn.kernel@gmail.com>,
 <netdev@vger.kernel.org>
X-Mailer: aerc 0.21.0-threadmapfix
References: <20260924154427.953800-1-willemdebruijn.kernel@gmail.com>
In-Reply-To: <20260924154427.953800-1-willemdebruijn.kernel@gmail.com>

On Thu Sep 24, 2026 at 11:44 AM EDT, Willem de Bruijn wrote:
> From: Willem de Bruijn <willemb@google.com>
>
> tcp_write_collapse_fence() sets TCP_SKB_CB(skb)->eor =3D 1 on
> tcp_write_queue_tail(sk) to prevent skbs queued after a switch to
> device encryption from being collapsed into earlier skbs.
>
> The fence is a no-op if all earlier data has already been transmitted
> when the switch happens: sk->sk_write_queue is empty. The not yet
> acknowledged earlier skbs wait in sk->tcp_rtx_queue with eor 0.
>
> On a subsequent retransmit or SACK shift, tcp_retrans_try_collapse() or
> tcp_shift_skb_data() can then merge an skb queued after the switch into
> one queued before it.
>
> Both users of the fence are affected:
>
> - psp: devices only encrypt skbs with skb->decrypted set. The merged skb
>   keeps decrypted =3D 0 from the earlier skb, so merged data sent after
>   psp_sock_assoc_set_tx() is retransmitted in cleartext.
>
> - tls device offload: the merged skb straddles the start marker set in
>   tls_set_device_offload(). The software fallback (fill_sg_in() returns
>   -EINVAL) and the mlx5, nfp and funeth drivers cannot handle such an
>   skb and drop it. Every retransmit rebuilds the same skb, so the
>   connection stalls.
>
> Fix this in two places, for defense in depth:
>
> 1. Fall back to tcp_rtx_queue_tail(sk) in tcp_write_collapse_fence()
>    when tcp_write_queue_tail(sk) is NULL.
>
> 2. Check !skb_cmp_decrypted(to, from) in tcp_skb_can_collapse(), as
>    tcp_skb_can_collapse_rx() does on receive. skb_shift(), which both
>    collapse paths call, already has a DEBUG_NET_WARN_ON_ONCE() for this
>    condition.
>
> Fixes: e8f69799810c ("net/tls: Add generic NIC offload infrastructure")
> Cc: stable@vger.kernel.org
> Signed-off-by: Willem de Bruijn <willemb@google.com>
> ---

Reviewed-by: Daniel Zahka <daniel.zahka@gmail.com>
