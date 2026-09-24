Received: from mail-qk2-f13.google.com (mail-qk2-f13.google.com [74.125.230.205])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 95677424646
	for <stable@vger.kernel.org>; Thu, 24 Sep 2026 16:37:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.230.205
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790267881; cv=pass; b=n/4+oSQbxpturJBKbaDRr1q633N/OpLFyOePEp9O85yGhv13VAKWX4KYMGUfPHwzx8Yb6X5L3dK4BbYKoOStrPItBJmkbecYnpAhQYv2wh5om2Oa+EpCzFgGxioB/kjSHxYbDMuNqJMpEKSXkpthuCuqOhloryJNQ/8UQVO2xSY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790267881; c=relaxed/simple;
	bh=8DhApwnuG2SUXRqEGXwamkFlChUC9h4uRKP2o2goLGc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=s/S4SRB+2KakYCNr9aFPLS3sKaUFA406YlTPcaa4X3JZFnc1bZnOxQr6a9zmhuqpDMsyzTT8ugh8uV5BCOuttdpxb3E+aP81JZN5eINmvDlL9y4GKJbBNsLJpmEsliXDSXhO2W5vQ6BHzh6F0VlF/BbegoYlm5KuDp2FnR6SWNE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=Eu2aeafy; arc=pass smtp.client-ip=74.125.230.205
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Eu2aeafy"
Received: by mail-qk2-f13.google.com with SMTP id d75a77b69052e-530e2f50d01so480991cf.0
        for <stable@vger.kernel.org>; Thu, 24 Sep 2026 09:37:59 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1790267878; cv=none;
        d=google.com; s=arc-20260327;
        b=gf6fV80iz2/FZSIZjiJtZ0dpH/rz4knjXpmzCV3hTBEBUoUKtQaVZrGY1n927syxpc
         ISw0gDbTHP/YxbfvOe1zjIwKOGCptFwNCMgnJxa+I87TwrBYBF28uY9Z9shJMk2deDBR
         qwfs0a1HG7bsIfGv4j0gXnPyS8D1WN9XjAKdYl1ZIn2Fr1924o7uSzxOHJyM0EEEmdkd
         I0Gr/lx//VT3FjY9QaKS1QNFCulGG+v/9ypLWtHAI/o4sGEXq2aQZGp6fAPuDl/IwXGj
         bQwfcQMfK8rzhD7TwCWx4B/K6+yxUbtCC7nOUEwA8kJsA8iTw0NoCxSle6x+u1NVZSHQ
         Dg2Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=0t7BSzswocE9VaUuD88aROz/tY5wZD53opr7p8td3kE=;
        fh=zWYFdudKv0SADXlPiMuW3zQnJCqfdTOq0MEzzzMO+Co=;
        b=Az1o47oA13jLxIKguNMf8HdSp8WuveaC/k1tW2XgIxECwFKkCQt6SDg5ZBPZTUWZbr
         jz9czMZhE+SaQKMOw995FaO0uoqeRWCDnSBjLB+lZ+1bRez38EHVfVkvu4mOzLJf27Q5
         XkMcD8Jwft+N+5AmTgb8FOTrcmiKASEjz9W9Job1nKxOy6J+supze2H2LZZmoN3L9xVb
         rbsI3z/Uk8j3qz7S6O5PIREGTfICFKUjUMG6eTKu+ws86YaTLWWHKB/YCDH2FBbPCR2R
         /M+mal+huxiyVLXXXFfPtQMZn2zaXbo56hajkUbZ6ae+TD5CT17sx0OId1xaiQH5Lio9
         lKFg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1790267878; x=1790872678; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=0t7BSzswocE9VaUuD88aROz/tY5wZD53opr7p8td3kE=;
        b=Eu2aeafyf4TKHbjA1fT89Xz0b30d/45EfZoA4kJxDvf14RUhyqv0qYBGdN3VkvML5O
         KK569ZYCi/MdAMUdOg5tl/+0YFG9tDI/A5NyTBF0yW8dlGfNo9st8mmR/bkFPDwsP3Xz
         PylIZj4523BRvHXne9K63sxaCp3bBxeLGuymqnHxnm7AewMDSWryzTqKcIjmoAvUWByk
         lzx9ndQeZAqOuYBJ+BKNoOodlrnfJj4Nkkg3FKi5GHwS4ez5A5+LLiovzAtIF2xv2e39
         vEPAccQYSYL6XfKV7/n0yCKBQS7Qdw4XO2A438VQBxAWp9xo9ZkJHWC44tEhHSTkoRcF
         4HaQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790267878; x=1790872678;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=0t7BSzswocE9VaUuD88aROz/tY5wZD53opr7p8td3kE=;
        b=2jp480YYIAn2oxUC8JNT1iy1qU65Hs34sAzeVPfOPkbydOWf2a0q+eJTLVqbQJzmB0
         Xw+/95s4p4dx4igBEvi65awDsJ9x+oNv4v+ug4Fvxj+NTptBk4eaizY0/vbOo86ZaYx3
         QzEEPcE+EKzuitKT2SgYz0IgvKoaIpZs7eBwRE8iMtMgbDPxm3YEcBTv9GIsBmBG9Cco
         RSN2yXKtcx3QYN8aLX3p+eRyITTtvGyAwKCPTeSoUMHMbJaQ+Pqale0w2K9bQM2w13b3
         HVKGrtKs0LZfxXXyovAsUUZ8J7bf8su0JWJ8FaP9SVPkIxgHv/1ut4+u+oyGlonHb5ll
         ki9Q==
X-Forwarded-Encrypted: i=1; AKwUvBxiPz6HZIGcSvdO9OKjHuLI4MmjiMFLZFvIQQ3CkWa0nDHyGLtC1JgtGEkDPrMoItbOpsWIMKA=@vger.kernel.org
X-Gm-Message-State: AFuF++nF7OXqeTGcLffn22wrdlg73D0Ir9JzYuFwGhzD4UCPgAV2eL52
	s8mlXO3gC9W70A2g1u/GZbHhFoEGWcbU8Hv0pwza8vG5eVNqKdGJhj1rDgTlRSNreZ/JrsWXT39
	cGEo4vEc+f3uF6QFdc7wecMRylWUOKwIjVECDy4+J
X-Gm-Gg: AYBFou1AuRmLaw05C8iw0LHPARYfMXS55pI58h2Cm+N2v4IqaF+1YeIxMhrIy5sS0K5
	16dp0Cn8mfPhry6tbJVPsv5vxcR5qiJA5tjiK1QAdQUp3Y6yNKr6I7FuYJ4HWP92bTu75b/pjFD
	MX8mzCg5NgPVqHMVpw5O9YMBhBBVYMrwnAUZlnzpamHKsytL5McttHA2eoYmxn9X+SSmc7m42xO
	ASbN54ZyjzL0lFh/ta923y9jFYkijQ6tQFuS09Xr2joIbLmB4eV31whu3Fo0fYEiOOkAbKsy8Io
	PT2/OLuQn8Ki2ybZNEGeSPQC1yjeENdF/Uwxrzfktrx/nECewqBHg47UVBcbllHFyJaFL3hZxzX
	NwuP/J8+RyycvEldzSIHH6hVPvu1Bq1jPRmk13Dud6JlhNYP1FUhdTt2EMUm5BUvd8irs
X-Received: by 2002:ac8:5f0e:0:b0:532:e4bc:b81b with SMTP id
 d75a77b69052e-532feb5ac3dmr31404411cf.46.1790267877634; Thu, 24 Sep 2026
 09:37:57 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260924154427.953800-1-willemdebruijn.kernel@gmail.com>
In-Reply-To: <20260924154427.953800-1-willemdebruijn.kernel@gmail.com>
From: Eric Dumazet <edumazet@google.com>
Date: Thu, 24 Sep 2026 18:37:46 +0200
X-Gm-Features: AclHuK_p6hC3gQAmvi0ifLB2kr_OPUO-K3WBvQ9rf3FXHeGGU6WjgCdFPaSV-XY
Message-ID: <CANn89i+b=8F-1uoDW1Cdx7EVAtjDgCGtamQfF4wkiSXmSPq0TQ@mail.gmail.com>
Subject: Re: [PATCH net] tcp: prevent collapsing skbs across boundary in rtx queue
To: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
Cc: netdev@vger.kernel.org, davem@davemloft.net, kuba@kernel.org, 
	pabeni@redhat.com, horms@kernel.org, andrew+netdev@lunn.ch, dzahka@meta.com, 
	john.fastabend@gmail.com, sd@queasysnail.net, 
	Willem de Bruijn <willemb@google.com>, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Sep 24, 2026 at 5:44=E2=80=AFPM Willem de Bruijn
<willemdebruijn.kernel@gmail.com> wrote:
>
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

Reviewed-by: Eric Dumazet <edumazet@google.com>

Thanks!
