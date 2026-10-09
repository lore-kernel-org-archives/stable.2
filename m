Received: from mail-ed1-f47.google.com (mail-ed1-f47.google.com [209.85.208.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 14AD34EB843
	for <stable@vger.kernel.org>; Fri,  9 Oct 2026 15:42:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.208.47
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791560536; cv=pass; b=j+I4hi5/lxkQA861k+DmnSBqVQqsjx1EutmMx0B/JB/22CqeECQKFW0UIApbh5PhJY6wJgkAnMJlqHvIE3+BGcQPxy4doTkIdIAeJu8lUWlMH1HRK0DDTM16Yj6Kumk7VaQif0F2ZUt5ZQpWmGYLBDNnVL2gt1M9ow5uVr8Aqx0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791560536; c=relaxed/simple;
	bh=ODP9oLFkSTTxNwHzgn/OPjr02NM8N6qGs+/FJBL1okc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=G4IFZh7Eg3z7tLb+4eQvgjiN5T8me31DI3yP1k4U82mbATtXMh49RqwoUSC+BGSJIE90jpkC4Le9ZPmqHOwKu1myr7LFoFpgGlqYTx1FbFBcZjKtQYTeCWHP54/Q43MSG8lCB+PJ4j8mgddjvFhE8AFXEOp/4AJX2DSdPHCizws=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=OpWNGM9H; arc=pass smtp.client-ip=209.85.208.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="OpWNGM9H"
Received: by mail-ed1-f47.google.com with SMTP id 4fb4d7f45d1cf-6ae14cdc63aso11876a12.1
        for <stable@vger.kernel.org>; Fri, 09 Oct 2026 08:42:14 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1791560533; cv=none;
        d=google.com; s=arc-20260327;
        b=JOfE4oQmVpnkp+AKwXNZJM5sFH+hkF+XY/QsAXCXuqz7LDgteobVXsrKtLW5+Ht1VP
         bjy5oA5bXGdJy7oXfhVUIdj0uTCssoCRJ8wigaPByd/Ut69+zMaG4Ntcp4AhqyaP7olC
         PIOInyWex4UvYyqhLPBkt91Y+z7+1jOlTgJ3BpjxbOLL3lsRfYyOL40UauCArSROZI4i
         iLTZNu2zKkFBTBEzI+dPRZg1H2l2mIcy7kpXPVh32Qbw3z5HaDuQcx3e/fWP+kjT+PMz
         pqSZKz9lMjayF5nK8aCXh8mjYKY8cw9AH+RoY22yxD8b1LqS8wYy7p82pSpftfwUeKAc
         n5vg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=lyiu94Q8CWOzAbPl0E5395hB8F0rcFgV/E8an3zhytw=;
        fh=tbLoJhYiMcqJcFEV+3fzFQQrwWUoIpuUGlVmobGsvKc=;
        b=dBR8/B8TS04sODedgRFBOFPhiN/4ffNRGfp2DkHLaInrIXlGa8WnsvQUgtCXAK3lyn
         AmqbwOpaGIoCpv9STY9D1b0W48/c00JN1/UlDgqG0OzY2i1MYlRHwn6pbZybtyNFW3k6
         S43lVF5PylQ4ipBFzH5tSeExQ0mlcs3cZQa9bF7v0xpSfbQDg+/+YMoVpkcZiqJvY6Ke
         tm/FAyyLNleElNUvHr+trwPYMttTFAeS9RZY59e9N+m1oCvN3y1zdNJGp4oWW1qa9l1a
         2G7Jnld3yJxaOC0EqX3HwRqtmjMBrBzCUwF2wqaGhTVOCN9jc566oHVYnC+mnYGRga4h
         +nAg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1791560533; x=1792165333; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=lyiu94Q8CWOzAbPl0E5395hB8F0rcFgV/E8an3zhytw=;
        b=OpWNGM9HITmmWSeHCLHNZygXvrbRXZTpgSNet7PIJQyLHGQotT7mi/q2rCg2Ci6i5T
         etqnW0c+vAJPRoLb4NLKqpg7EdyGWSgCFCMpinHioKNroNs4qoIsIk9qoDPfNBrqgfBl
         /EwfICwupKgSGzQvQxJxi33xzcyRMzVTh+F9lgSdNXbdK2Y7DzKarxHBW028MxYENpkx
         xJgCbJmyNSmGRu7fUt6KdcNkRV3PvcA/wC8PUUzxcMB08Q/DezG/eyoPquHPxjkivk1G
         d6nfjdcbFmoqKsRTkOi7fhpv4Ut9AeMFQMMd+t18BFwYgm0WSk1v995wvaHySokz72PG
         higQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791560533; x=1792165333;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=lyiu94Q8CWOzAbPl0E5395hB8F0rcFgV/E8an3zhytw=;
        b=G9hp3gtt2DDQYCCojKoCoBWtRJeEAWLgFK85Y7q5XwbXcdqspIuU37qLCQfCBTv9Cy
         EKiA7AC16jmZNgmMZ3E1wq3xiFTjPke+dqjht7gzD9ITGXJXi/BuM2TuRTQfNJLS7jTQ
         ggcUWpfHKcP0UwOwL0NlzYc3ykkg9JjAAOxivHQYHytE+9M8tcATX6sPIlEtfTJ/PLss
         18Rc4GMw5sakbg3cJkkFV2tXp293+xOK73fqI2WsPCp3YG5HXZ29VU4cceKY+LlZ/DNL
         J8Oy/k9U9psfeBFToQjueCGQV9M6PGMTd96l9FPTf7Yg+o4ugSlN68u5PKj6p2Fb+emp
         dhtg==
X-Forwarded-Encrypted: i=1; AKwUvBxwS9Z7JQPt/yBKfm5VGqf40z2kOCHhbg4fxv4OyNVHhPWUft8ofAHAE7ziAi0mn2emDLXioFA=@vger.kernel.org
X-Gm-Message-State: AFq9FYI0jLK6FFIXC4Jy891dv4K1SFRGEoGXnNRCDd4z9wmOU4QbHcAH
	kUtiLvpnh/En7kphp/vDBpi9g/n+fM2JxkpXcAH4oG7lXZ4BVT7ISz+dZrDqbHnbqIAZ6AZx+/Z
	7HuZfC6H1cQRWn85J8iiVztkJSzAjZctr1yE/b6Xp
X-Gm-Gg: AYBFou2dDqBFIORmeY060PF/vOBFV0t1S/l0lMEmS37bGY8Sq5koJ0tY7WVCNq70Ext
	KZWUZ+u4Bjz3pKONQYcqhK4mhQ3hmiwKqQWdm6bG9Tpccd+V8OIh01EIb2MpzSw02pGulxv8JOT
	UHQmgCrsuLr2FTGV5UdfJjNLx2m1H7BUd03WHMMcTEfJjYDTxZZ5txP16Y4Ou1DJ9qsNKFNHR+v
	maMD2rLPScIDyEiBNLSsKmGTPSsF0RGTKFU9XRINzM7tWpTBb0FnKJo05kAa+bkP1kuEF7mCjlD
	Z9yqUpv/ziB0w0y0IxLT4l8JSJMVG3HIvDn9D5OY/ZiUXibSCdERYWsJh+IZH0cG
X-Received: by 2002:aa7:d743:0:b0:6a6:7dff:61ab with SMTP id
 4fb4d7f45d1cf-6b17b963117mr40705a12.15.1791560532616; Fri, 09 Oct 2026
 08:42:12 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20261009-b4-skb-segment-nosg-unreadable-v1-1-7e2334a55fe8@toxicpanda.com>
In-Reply-To: <20261009-b4-skb-segment-nosg-unreadable-v1-1-7e2334a55fe8@toxicpanda.com>
From: Mina Almasry <almasrymina@google.com>
Date: Fri, 9 Oct 2026 08:42:00 -0700
X-Gm-Features: AclHuK_-OS7FzcusCgigYqbLXBGGgd8VVdGqpOopI3dxHJrjPaF9OMOOxoHmqMY
Message-ID: <CAHS8izOAGUcKKBuU8uyANr9-xCacBq43PHfqW5yyR=35PXxi0g@mail.gmail.com>
Subject: Re: [PATCH net] net: skbuff: don't segment unreadable skbs without SG
To: Josef Bacik <josef@toxicpanda.com>
Cc: "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@kernel.org>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, 
	Willem de Bruijn <willemb@google.com>, Kaiyuan Zhang <kaiyuanz@google.com>, netdev@vger.kernel.org, 
	linux-kernel@vger.kernel.org, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Oct 9, 2026 at 6:32=E2=80=AFAM Josef Bacik <josef@toxicpanda.com> w=
rote:
>
> Without NETIF_F_SG, skb_segment() copies each segment's payload out of
> head_skb.  With checksum offload it uses skb_copy_bits(), which fails on
> unreadable frags, so skb_segment() errors out.  Without checksum offload
> it uses skb_copy_and_csum_bits() and keeps the checksum that returns.
>
> Since commit ab9414ed70bd ("net: skbuff: don't leave stale bytes in
> skb_copy_and_csum_bits()") that copy zero-fills whatever it can't read
> and returns 0, which is the correct checksum for zeroes.  A devmem TCP
> skb keeps its whole payload in unreadable frags, so every segment ends
> up with a payload of zeroes, tcp_gso_segment() writes a valid TCP
> checksum over it, and the peer accepts the zeroes as stream data.
> Before that commit the segments carried uninitialized memory with a
> checksum that almost never matched, so they leaked but were dropped.
>
> This is reachable when both SG and TX checksum offload are turned off
> on a device used for devmem TX.  sk_setup_caps() still gives TCP SG and
> HW_CSUM, so the dmabuf send is accepted, validate_xmit_unreadable_skb()
> lets the skb through for a NETMEM_TX_NO_DMA device or a matching
> binding, and software GSO then segments it with neither feature.  With
> only SG off the copy goes through skb_copy_bits() and is already
> refused, and with only checksum offload off the segments keep sharing
> the frags.
>
> Refuse to segment unreadable skbs without SG, which is what the checksum
> branch already does through skb_copy_bits().  Check the frag_list
> members as well, since their payload is copied the same way.
>
> This was found by the Sashiko AI review of that commit.
>
> Fixes: ab9414ed70bd ("net: skbuff: don't leave stale bytes in skb_copy_an=
d_csum_bits()")
> Fixes: 65249feb6b3d ("net: add support for skbs with unreadable frags")
> Link: https://lore.kernel.org/all/179148235783.434549.1432237422747783281=
7@kernel.org/
> Cc: stable@vger.kernel.org
> Assisted-by: LLM
> Signed-off-by: Josef Bacik <josef@toxicpanda.com>
> ---
> Follow-up to Sashiko's review of ab9414ed70bd:
> https://lore.kernel.org/all/179148235783.434549.14322374227477832817@kern=
el.org/
>
> Tested with a module that hands skb_segment() a TCPv4 GSO skb whose
> 3000-byte payload sits in an unreadable frag, with SG off.  Without this
> patch it returns three segments with all-zero payloads and a checksum
> of 0; with it, -EINVAL.  The same skb with checksum offload was already
> refused, and a readable skb still segments and copies normally.
>
> Thanks,
> Josef
> ---
>  net/core/skbuff.c | 20 ++++++++++++++++++++
>  1 file changed, 20 insertions(+)
>
> diff --git a/net/core/skbuff.c b/net/core/skbuff.c
> index 41beaf625421..4ba544b5f3ba 100644
> --- a/net/core/skbuff.c
> +++ b/net/core/skbuff.c
> @@ -4782,6 +4782,18 @@ struct sk_buff *skb_segment_list(struct sk_buff *s=
kb,
>  }
>  EXPORT_SYMBOL_GPL(skb_segment_list);
>
> +static bool skb_segment_unreadable(const struct sk_buff *head_skb)
> +{
> +       const struct sk_buff *iter;
> +
> +       if (!skb_frags_readable(head_skb))
> +               return true;
> +       skb_walk_frags(head_skb, iter)
> +               if (!skb_frags_readable(iter))
> +                       return true;
> +       return false;
> +}
> +
>  /**
>   *     skb_segment - Perform protocol segmentation on skb.
>   *     @head_skb: buffer to segment
> @@ -4842,6 +4854,14 @@ struct sk_buff *skb_segment(struct sk_buff *head_s=
kb,
>         sg =3D !!(features & NETIF_F_SG);
>         csum =3D !!can_checksum_protocol(features, proto);
>
> +       /* Without SG every segment's payload is copied out of head_skb, =
which
> +        * can't be done for unreadable frags.
> +        */
> +       if (!sg && skb_segment_unreadable(head_skb)) {
> +               err =3D -EINVAL;
> +               goto err;
> +       }
> +

For this one, IMO we cannot have random unreadable checks in the code
because high level functions will eventually do something that
requires readability deep in the call stack. The code deep inside the
call site will change and we (the LLM) will forget to update the
accompanying unreadable check way up the stack.

I would say for this one, if possible make the innermost helper
requiring readability should perform the check, and return an error,
and then update the callers to handle that error generically. You may
end up with a larger, more complicated change but I think it will be a
more sustainable change than this 1-off.

Thanks,
Mina
