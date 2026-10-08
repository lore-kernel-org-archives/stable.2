Received: from mail-ed1-f46.google.com (mail-ed1-f46.google.com [209.85.208.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B06DB3D8107
	for <stable@vger.kernel.org>; Thu,  8 Oct 2026 07:29:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.208.46
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791444551; cv=pass; b=h0tbFvS8n6ZeTKSHsie+5RiFpJJC0J2p8fSwQFcMhTuwHSft8LHsV5pka+6SvlHV004PJFYLJq2TQEONA8XzXNYAeChLlYe5bIJCe5wg8YMdX4riLY2NshGJNDS0ec7UeEwB7HhCTzraxQWPXKYM23j/R3xQDAwgBvOjmE6rThs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791444551; c=relaxed/simple;
	bh=UeBb5/Usyxx4tpcXjikXZiATTLeoysYCvbBWoXLg6pc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=RQ8P/tTOhWmIXdldxKdeh5HsBSZv5MB8XcIDhaLi8rHrMDYmeeKfnszx7IktQCTj5JgGEEbKQazl9jD+0uJYwfLvMr1TAV7WHHKrsf0tUV7TZwIEIf3csChkSwIAjO89jWGY8vZKFqshDclAkBA9kENCqvHdYsDdzYvV+uyKAGQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=B1m+at3X; arc=pass smtp.client-ip=209.85.208.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="B1m+at3X"
Received: by mail-ed1-f46.google.com with SMTP id 4fb4d7f45d1cf-6aa046a99c6so121296a12.2
        for <stable@vger.kernel.org>; Thu, 08 Oct 2026 00:29:08 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1791444547; cv=none;
        d=google.com; s=arc-20260327;
        b=Dm3bHkIINPLdzK0PpdpV9Og305VQ5vZnNNj7KjJNxVKLYj9YCFFCMYb31UGs21Rdfh
         mLu4U8ky+cZebXQV0fDyJiKKKNPkEzqltfWF/h6B2AQ/492RitlTf9HDS32+X9f8N+4g
         RM35NJRFvejsxWwmREkwoTqh9mFGrvxzmlXokS+qxdOE6vzDgXzrCulndof6Iuzpy+zO
         MSGc+8mmWPcL6AowDGD2ydw+QkJjcYEmsvLi/q7ALfWvIJoSqs3M07SaVkhw8A0B0NeB
         zKXIenl+4Xe57Tg61+QFnHDV1JhHxwJ7FFblqh2JBWxyG7tYO5C7HneqmA15Gg6KYjA4
         9cVw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=9o0oJaFKufMNjlilQDJWX/nZeJhX0+Oq7E8MvusdFBU=;
        fh=8Eg0hYVWM/fA5u5H4/UC2VOPdpSUUcKYB2T716oC4Ps=;
        b=i5Yp35EAGSg/ebfDPPxMkDY8f5dTIhKZi81Hmsx53MfBEatmQv3+5cNFVqDOdDZrin
         9Wg8aU77552vuJo/1DfIPnA0PHk8xwoXXKty21k0+yq0fjZ9TPZWPkLLG7C3DnmHyhva
         dg8jLYg1sW+NPWKV1tDxqMzJ0Y5y7PgRCVGVCh7q4563nqJOjniTUgoQdfAe2Hb2RJD5
         NSmqp9hXItaKv0RD5PoMGSmUxwPin7dJQsIXX6njXGLHnYeZ8TXyjBYDIAzSrntuwxPn
         T0D2g23awcrZ8r0mGbf9K2xJdoNdKXIk5nmY45ySY+sgEuQc/BO2JA1YG/2UlQXfmJPG
         wa2A==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1791444547; x=1792049347; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=9o0oJaFKufMNjlilQDJWX/nZeJhX0+Oq7E8MvusdFBU=;
        b=B1m+at3XgSsBEgsM4ST3zlmvvf1HVGEdJ2cakEhA6kzw8SlrVFy/OTljpWdHz7aK4k
         IzWfZR7Maq2TI8Bgr3wzxA5yfYIgha7zWk0Mb8KpvyrhhGvgNqmFi4wZl3xWYx6+tf4J
         SGt0TR2A/olVuKf37zIUD9/nSbSdY9/7MPU14PkD9zeq6m6/PR8vAgHTHxN/kG4u8phT
         5QYqmkL7jNd7f29ZCrsL4+Tw4tjVA6D55tvqlAcTeeFxVAAXWqva4I5Vk/mdLQDiwtZH
         dvVrU39H8Dr/LAvjbOGtE3aXlsAjv/c0zpM8InZHddYRBORen4qgzdxIrk6sf2f5BD59
         Gg3Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791444547; x=1792049347;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=9o0oJaFKufMNjlilQDJWX/nZeJhX0+Oq7E8MvusdFBU=;
        b=hUwY+4UPKsd+C4Tkca/IzMt8wncTPeE7tqJQ9A50AWf9vPRz8YWKWmwQu7xdrBlw/u
         S00LDksSr/PMfn9XbqKFVjdO99/nf0bNFi7ekIaPmCma2fPl1Z8dwhF0qLPLch8xbQn5
         4eAGvlZL9wZ1V8zbvO97t0pt6cJA2n5q21F6I+bQsN/HGTk+s7rkRW8d+ZNnyvYTv0pO
         /Bk3NF+cCR1l7wl0xF0YYzONYnqDp5666QByEm1vApEshlC3b/7+DvpNlVuu8YM5xn2q
         NkA3wStdnGkz55N98da6TJBJTDVUQrP8cfi++W+c+09F0QdFJapAZSp2N0a36gMsY2/a
         VNog==
X-Forwarded-Encrypted: i=1; AKwUvBx7vT2QxMwdTAj6uZ2qX5ehvNEy3HVEixwqcfUvkUUJnyCNoNsh0uWhzrY6/B0A5UCLrymmbi8=@vger.kernel.org
X-Gm-Message-State: AFq9FYINXKDF3pdF5JDyp57B+tuaU5ABed4uk8y59RB1oUIV2lBALaVm
	Wr8l6pCQbcJGVmgqqmsNPEBbzIjYYXmF0DBAJ3TkxorOzUZD3Ii299JMl4YxCg5i0hNFjg8xo2Z
	S0XZ3k8tCdIzixqdPs5C7wT0uQYf4ocmtltvpNqMZU38ehlg=
X-Gm-Gg: AYBFou32MWTQZY1Jyj31TKvVNwsIe8JXSsIPvkbVa6ORKzSaJHXSxhc5tj1u+CRZc30
	ZUHuDQTEvTTtk2jkl2aoLynYsfOR/zNpOoXpL86VY1r6E3pJyG2mabAYfudv5M4XrCBSBkIc3Tm
	6eyO3tZoSQZ3CZpmKB27ECTi4Vty6V4zSTRiMjlO6I7Egp0NrmxR/QzE+eoBLgmXotprzlXje1R
	T6PTi2phmMmInRWP3ngYin8P6mHrsb6ei8l+Qg0RJESWDy9cTcGPVLHKHKIlbt3zpGm6RXr8GKr
	ElA9ylFsbp6KBkRrBDym04ZqsgcySt9L4Ev1Mup5lRgVSbtP9fbkIkErFGEJRASR5GrUdANyPot
	lzDGphK543J0=
X-Received: by 2002:a17:907:d0b:b0:c2e:e3c:ddf3 with SMTP id
 a640c23a62f3a-c3190945b02mr159128366b.1.1791444546597; Thu, 08 Oct 2026
 00:29:06 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260926175209.2618167-1-nicoyip.dev@gmail.com>
In-Reply-To: <20260926175209.2618167-1-nicoyip.dev@gmail.com>
From: Chengfeng Ye <nicoyip.dev@gmail.com>
Date: Thu, 8 Oct 2026 15:28:54 +0800
X-Gm-Features: AclHuK9EXpr0HefVuYLsA4YdaqlPkdVI9gNgl9pcgqj8r75fsnYM3PffrDC4sJA
Message-ID: <CAAo+4rX15W_cvz6VwDDrwkvvo34iSU0snkAuM00-geV0tD0J1Q@mail.gmail.com>
Subject: Re: [PATCH] netfilter: conntrack: wait for RCU readers before freeing
 the hash
To: Pablo Neira Ayuso <pablo@netfilter.org>, Florian Westphal <fw@strlen.de>, Phil Sutter <phil@nwl.cc>, 
	"David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, 
	=?UTF-8?B?VG9rZSBIw7hpbGFuZC1Kw7hyZ2Vuc2Vu?= <toke@toke.dk>
Cc: netfilter-devel@vger.kernel.org, coreteam@netfilter.org, 
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sun, Sep 27, 2026 at 1:52=E2=80=AFAM Chengfeng Ye <nicoyip.dev@gmail.com=
> wrote:
>
> nf_ct_get_tuple_skb() calls into conntrack under rcu_read_lock() without
> holding a module reference. CAKE can use this hook to look up a packet
> without an attached conntrack, even during nf_conntrack module teardown.
>
> nf_conntrack_cleanup_end() clears nf_ct_hook but frees nf_conntrack_hash
> without waiting for existing readers. The grace period in per-net cleanup
> runs while the hook is still published, so a later reader can race as
> follows:
>
>   CPU 0 (packet path)                 CPU 1 (module teardown)
>   rcu_read_lock()
>   ct_hook =3D rcu_dereference(nf_ct_hook)
>                                      RCU_INIT_POINTER(nf_ct_hook, NULL)
>                                      kvfree(nf_conntrack_hash)
>   ct_hook->get_tuple_skb()
>     nf_conntrack_find_get()
>       access freed hash bucket
>   rcu_read_unlock()
>
> The same missing grace period affects initialization failure after
> nf_conntrack_init_end() publishes the hook. During module teardown,
> KASAN reported:
>
>   BUG: KASAN: vmalloc-out-of-bounds in __nf_conntrack_find_get.isra.0
>   Read of size 8 at addr ffffc900012e2ae0 by task poc/90
>   Call Trace:
>    __nf_conntrack_find_get.isra.0+0xf87/0x10c0 [nf_conntrack]
>    nf_conntrack_get_tuple_skb+0x255/0x400 [nf_conntrack]
>    nf_ct_get_tuple_skb+0x75/0xb0
>    cake_hash+0xfdb/0x1e10
>    cake_enqueue+0x5cd/0x36e0
>    dev_qdisc_enqueue+0x40/0x170
>    __dev_queue_xmit+0x1e90/0x3110
>
> Wait for an RCU grace period after clearing nf_ct_hook, before releasing
> the hash table and the remaining conntrack resources.
>
> Fixes: b60a60405fb9 ("netfilter: Add nf_ct_get_tuple_skb global lookup fu=
nction")
> Cc: stable@vger.kernel.org
> Signed-off-by: Chengfeng Ye <nicoyip.dev@gmail.com>
> ---
>  net/netfilter/nf_conntrack_core.c | 1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/net/netfilter/nf_conntrack_core.c b/net/netfilter/nf_conntra=
ck_core.c
> index d0d9e5ea84a0..b07e94e75d4d 100644
> --- a/net/netfilter/nf_conntrack_core.c
> +++ b/net/netfilter/nf_conntrack_core.c
> @@ -2455,6 +2455,7 @@ void nf_conntrack_cleanup_start(void)
>  void nf_conntrack_cleanup_end(void)
>  {
>         RCU_INIT_POINTER(nf_ct_hook, NULL);
> +       synchronize_rcu();
>         cancel_delayed_work_sync(&conntrack_gc_work.dwork);
>         kvfree(nf_conntrack_hash);
>
> --
> 2.43.0
>

Hi,

The issue still appears in the current nf tree, and I'd appreciate any feed=
back.

Best regards,
Chengfeng
