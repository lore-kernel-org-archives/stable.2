Received: from mail-pz2-f43.google.com (mail-pz2-f43.google.com [74.125.228.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0E0073CEB9E
	for <stable@vger.kernel.org>; Fri, 18 Sep 2026 15:32:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.228.43
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789745553; cv=pass; b=lkOi9xt3hJE/y1n8qts+1b8nV901mPtGWp1NOhMrc1ktsZbk1CIwPpG6HtkMcdROG3mrZP/TBM9sl19f11CN0mdC1q8anwPFxH+ERhJqmpbWDhl5kZl1guW6OWRc3GFgQ7tUxPhP+DFOQ3YSXCLxg/D10yQtVeJeYCon+dlsxQs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789745553; c=relaxed/simple;
	bh=ymSNiHBv0rxNjhBEBzAQ3e5pEXSbhOPJPBVgbAV4qGc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Ctd/Yn1elLSf2gmoeC+Q4gaZo6E49g3LTwUszLTP1ZhfIeyOF5o2oP221kO2gFDXLV5nfme04M+kS2uNd96M1jPXp29J/k5l78BxdGlLKJTzKpUuOHsf3bW3li/jQwfwJquM2IHJ/4to+0M2S45kf82IWeCSc4YpmkKjsmAi67o=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Y6O1VpwI; arc=pass smtp.client-ip=74.125.228.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Y6O1VpwI"
Received: by mail-pz2-f43.google.com with SMTP id d2e1a72fcca58-85469d249c5so765453b3a.3
        for <stable@vger.kernel.org>; Fri, 18 Sep 2026 08:32:29 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1789745549; cv=none;
        d=google.com; s=arc-20260327;
        b=BeY9+jMGPWur6LJQpJOABiXb+HfjL/4EePeSM3vr+bmc85/adE82r+F+WLeEug4c1X
         7k9hY7LF/3jOGCTf9pIpktltW7qWQ2VAgeSNM0ej03f1oISmjvQ5PZ7NYpT4qYjBWaUU
         YAlBrNI7Ggar5SboW3dJQ7zyS7plTXjaQOl0HSQS4PrpobB50a20RvB2OAf6th08vzfZ
         zxHobi+5GT4XRaGbYGGmKAE8DrXFAEu6BqKc6oxZRoWpUXzi0GdalB1tC2FcwcSx+NS5
         y8UB0tea8sTVN6QcP3NAjvxEG21OtPO/l870G6krBpCG2wagHdjpPHgnEJ5/RCPmlPrv
         uisQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=W1ylXOncdQ/xqG+G6xMvP7qzdxs98+NQiLMh31Gq++0=;
        fh=aiGkOu6iKL+w+EOtqzTU7lyhrS+XSp3yUtVsY51On1w=;
        b=J+OaFkQxop72/2GDX3XCF2z0kAnYqx0djIpJvsXFIV0iP6FOT3kWA4nwuawnV+J6Ja
         mgZBUDVG5nIJVL5vzm+bscKjwGp7Ea6WzOpHl/0h2l+XcMklm8I5fvFjmUUdkpvH8J1C
         P05lA0yF+ha/gz8rWNiae/yJdmt1MJoBVnLmzQE0ZGOUMWBJEEABeEiLVIo0Aw0oPxug
         5Sj/6r1lCtPqM1rWll38DpR+6ew3T6ZbAS/KirXIHyeHIw7lMqayI6SC+RB8k6q/vfRL
         z5QvHsjl11gMoV5uqemIdYOTjPq0545fz+EiOvG1W7Ra8n6i+v1AfhJtq3VukC+t8yzI
         PNYQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1789745549; x=1790350349; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=W1ylXOncdQ/xqG+G6xMvP7qzdxs98+NQiLMh31Gq++0=;
        b=Y6O1VpwI3Meq1JdZzi31TXfQpcpanZ4wlV9iuXpd5sjIig7phQgfCU47aWyfR6vo5k
         fF5qI7YbZKJqfy+x8XAZFltiJon4GuQN8WBUzqUeSKaguTIN3WWM42KofwVy992IGB3D
         A/KwLB5orHlmqbo35PsAsbVq8pWeMtHNIK0XxYEMlpSTBYYH6K1HR6U62pwvfxU6uZZJ
         QX9pHkygNT6TFTQDXgl7UFGsE89L7ug/iJ1SDQBdIjMEx4okR95NWxfMUcFzo2x7Tnf3
         0vdbG2BYhFcpGWJ8wwNFfDRQ8xHV1NJxG+crmfcpyiZ5BtlOGzbEKTHAhPTV/xTWj6Tu
         LwWA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789745549; x=1790350349;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=W1ylXOncdQ/xqG+G6xMvP7qzdxs98+NQiLMh31Gq++0=;
        b=BUuJ/zVYfKMgDmRBzuMqxE1LwoA+CGJrrQEX9BHHTts1N0Eg54ftmVf6XA0giVw+V2
         6ZFAh/+68X2LpEXJEaX+975mVf310aB52GQST2Z1Wk6T6Xspz2+KqZLeFUW/hp4FJL33
         /rZhLgslD6FKZhRPN6Uncz0WudlAtzMlMpliOlsWzTosD3QtcTfHoO8Z6Vk3XyZMIupa
         UeIsJe02kJTKJgmQob0okxEzeDlgiDdkpSGk0y2cHIG2dw5eHfXduPt5Y+rDwsVA/bpC
         n4kf31H8fLR9G0isgnMce7Gq3Go+Eg3+rZu8j8MVKO7C8tYD+hj0DAKQFreCljEy5dMx
         OneA==
X-Forwarded-Encrypted: i=1; AKwUvBy4p7SmwQIWOypXHgxsY3cnd03nJwHfM+EFK9xSNwQHEZarfMkpKBPtiyFe4y0sHjw0sQvK/KQ=@vger.kernel.org
X-Gm-Message-State: AFuF++lnQo/zNAcZsw5tvyaNxz2sakZ/IwZAz9zbtlNIdrmjb3aJTXs7
	NiK6eh0Esh7ucWjppJRikOrrWV4bvyyYlEpWr6POvADCvw3XsJy6pSYP6IJzQnmT+zRfT45PpXE
	dyU0A7Q62XFxLBN9XP28QQXD/iVr2Ffo=
X-Gm-Gg: AYBFou36i1+fSwEhzJNQ9ss+zjOjvFI9l84ZLR0+Ckhfy68l9dfuvjTrBc5Pxpr3BVP
	AuL/Dqf2j5lRb4BUZhad8nSfxU1ScPJNqxFnRDoLi+IV5lz1nFJa+ey/0TJroJToi9a//7h+qr2
	WGYUhhp7NE1eGBFy3xmgh/sb7VSPyWxq+UYUs2oZyJmy5R37khUqGf6DrZqu2nsaXHeeCvhiSWX
	0daUbx52gEPI+DAfTmTaDyXDYt69eLuauleZTeWvQBrsdRBUa+7w4/UrijjQCB2gW1+UPK2DZpS
	Z+xRHDsuGf28/48/k4LvTP3aP3X87F3QYM9wE1LBgAdOoM0mdjc92FU59BQFt7mKALfzq89maEZ
	bYbQ6BtbtCUlM/f//9+L4rUcVnIh0nLT1GG5BgaNPN8L4y5H+3F0kGwPk
X-Received: by 2002:a05:6a00:300c:b0:86f:394c:5c68 with SMTP id
 d2e1a72fcca58-874dc0f8b8amr5619824b3a.13.1789745549406; Fri, 18 Sep 2026
 08:32:29 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260918033942.85061-1-ndaugoing@gmail.com> <20260918033942.85061-2-ndaugoing@gmail.com>
In-Reply-To: <20260918033942.85061-2-ndaugoing@gmail.com>
From: Xin Long <lucien.xin@gmail.com>
Date: Fri, 18 Sep 2026 11:32:18 -0400
X-Gm-Features: AcwNN1WmYHIGdIjR33SQlazp2k78HvrE9WOuXYfeYWpG_Q_w2uIVAZW-9f1-pjs
Message-ID: <CADvbK_dQdro_x-=ma2=bRgosYf2cZfEaqrbpeg-8odoBHnzqVA@mail.gmail.com>
Subject: Re: [PATCH 1/1] sctp: check return value of sctp_get_af_specific in sctp_process_init
To: Yuchao Zhang <ndaugoing@gmail.com>
Cc: Marcelo Ricardo Leitner <marcelo.leitner@gmail.com>, "David S . Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	Simon Horman <horms@kernel.org>, linux-sctp@vger.kernel.org, netdev@vger.kernel.org, 
	linux-kernel@vger.kernel.org, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Sep 17, 2026 at 11:39=E2=80=AFPM Yuchao Zhang <ndaugoing@gmail.com>=
 wrote:
>
> In sctp_process_init(), when matching the source address of a COOKIE
> ECHO against the embedded address parameters of the INIT chunk carried
> in the cookie, the address family handler is dereferenced without a
> NULL check:
>
>         af =3D sctp_get_af_specific(param_type2af(param.p->type));
>         if (!af->from_addr_param(&addr, param.addr,
>                                  chunk->sctp_hdr->source, 0))
>                 continue;
>
> On kernels built without IPv6 (CONFIG_IPV6=3Dn) sctp_af_v6_specific is
> never registered and sctp_get_af_specific(AF_INET6) returns NULL.  A
> remote peer can reach this path by completing a regular INIT/INIT ACK
> exchange over IPv4 with an SCTP_PARAM_IPV6_ADDRESS parameter embedded
> in its INIT (ignored at INIT time by the address family gate in
> sctp_process_param(), but the cookie embeds the whole INIT chunk), and
> then sending the COOKIE ECHO from a different source address, e.g. a
> second interface of a multihomed peer.  sctp_unpack_cookie() does not
> compare the packet source address against the peer address stored in
> the cookie, so src_match is 0 and the walk dereferences the NULL af.
>
> This crashes the kernel with a NULL pointer dereference in softirq
> context, remotely and without authentication.
>
> The other from_addr_param call sites of the same family already check
> af (__sctp_rcv_init_lookup() and the ASCONF path in
> sctp_process_param(), fixed by commit e40607cbe270 ("net: sctp: fix
> NULL pointer dereference in af->from_addr_param on malformed packet")),
> which missed this one.
>
> Fixes: 0c5dc070ff3d ("sctp: validate from_addr_param return")
> Cc: stable@vger.kernel.org
> Signed-off-by: Yuchao Zhang <ndaugoing@gmail.com>
> ---
>  net/sctp/sm_make_chunk.c | 2 ++
>  1 file changed, 2 insertions(+)
>
> diff --git a/net/sctp/sm_make_chunk.c b/net/sctp/sm_make_chunk.c
> index 84a4c97d0f75..ff1c013e2575 100644
> --- a/net/sctp/sm_make_chunk.c
> +++ b/net/sctp/sm_make_chunk.c
> @@ -2381,6 +2381,8 @@ int sctp_process_init(struct sctp_association *asoc=
, struct sctp_chunk *chunk,
>                     (param.p->type =3D=3D SCTP_PARAM_IPV4_ADDRESS ||
>                      param.p->type =3D=3D SCTP_PARAM_IPV6_ADDRESS)) {
>                         af =3D sctp_get_af_specific(param_type2af(param.p=
->type));
> +                       if (!af)
> +                               continue;
>                         if (!af->from_addr_param(&addr, param.addr,
>                                                  chunk->sctp_hdr->source,=
 0))
>                                 continue;
> --
> 2.53.0
>

I think this is a dup of
https://lore.kernel.org/netdev/20260917030505.4176635-1-hdthky0@gmail.com/

Thanks.
