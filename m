Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.222.41
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793027527;
	b=dwVRHZQNWu4eF1TwsdmzVO4p5/36LkqyClgJJXhoqrdpi5mjxPWx7d8K7dZfQb2v/Nla
	 sTXm2AeuekQ96sM8VoXzxV/7gaC4NtKNrtKUR+0c57GyVXB74RssTHQu+99OBTTdVQjku
	 AAlRwv2puH7/w7NxyLOHrFNYQ0fM+Hc2CaWjCWcBF0guszATlTgcT2R74g85CVqLLvC9B
	 uHq/N5kvhL4yNwDujqIuhjK5BLZkxUDcOzwrEmCbo5sDvlFsNsLsGMIyMSPMrY4L3HgdM
	 ecm+6Ra/PCvhSle1dzLLm+84H0iY/AnPyM68OMo1wYffkgalhEgVIJrDnY08DH6QpTQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793027527;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Date:From:To:Cc:Message-ID:In-Reply-To:References:Subject:
	 MIME-Version:Content-Type:Content-Transfer-Encoding;
	bh=18eqJR6kyQWwvlbFvPJ3uLv5+RhM/XmkF7e0poo81Lk=;
	b=h9YcPfKmFfIudhj67dfj16LcUmrk02lMhfk8E5/MAvJumgN/1nOd7up663++UEPPnqce
	 C5qZsPL1zSmKJjgjM044LLcop+VjPzSZ+i62y4UIzW0tGCRQaAUcbkDibQHRcJ9tM2T9w
	 NYj1sHv+LXcMwFuZJmS6/YHwoV98z8xucxzvCCDb28gy+FLTVJjU96CXA1NlfvGKQPFiu
	 vtiNfah11xpSmUAj4JyZfFmr2voDW7q+34TAM5JQ6Bm0P08GiH1qd8hF1TG9F3+bNc2wo
	 8tVtRqXUHVRYzog0wPRC8vDej8+iN/DMUcLeBrxICsLsHq1KTQ7TLhsMzT/BGg9bNOA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=I1o7tJok;
	arc=none smtp.remote-ip=209.85.222.41
Received: from mail-ua1-f41.google.com (mail-ua1-f41.google.com [209.85.222.41])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 832F860A2601
	for <stable@vger.kernel.org>; Mon, 26 Oct 2026 15:12:06 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 832F860A2601
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=I1o7tJok
Received: by mail-ua1-f41.google.com with SMTP id a1e0cc1a2514c-97ccbba8e86so857257241.3
        for <stable@vger.kernel.org>; Mon, 26 Oct 2026 08:12:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1793027525; x=1793632325; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:subject
         :references:in-reply-to:message-id:cc:to:from:date:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=18eqJR6kyQWwvlbFvPJ3uLv5+RhM/XmkF7e0poo81Lk=;
        b=I1o7tJokyf/ftDqohyfkLGfTgURnZwL6WadVmjXnhuhOtae10kjs1eJUkmu/BwK9w+
         LUGDgAhNNTNphLY7v8040t8Ti2aJMaGDG6WDgIHBGQGoyqDDcfgH0TXrZYJmTeiq8ZYI
         hyTXHsHUEamtR+tm8GNbIL+M0gSb0jiZwUxtHIM9vwWV7s3DNTNW/+4qp5pzEIoG1e60
         rknS21a0TP06KzKQHydtcAOPPbr55hMwH9r7tPrKM9vqHf4Ierb01XKKCpkLg9eAE3ti
         np80TPyLaqvBzutk+sSq/0iHvRGtIurdlae+DWZ5fmt/mqK/be+Wi9xaD24kduhk67kG
         in0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793027525; x=1793632325;
        h=content-transfer-encoding:content-type:mime-version:subject
         :references:in-reply-to:message-id:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=18eqJR6kyQWwvlbFvPJ3uLv5+RhM/XmkF7e0poo81Lk=;
        b=kelWV5a7XCh1s5j2PRvmNrTwUusJGlbeTKcWbm3UXGNFDmUElXs4TUXWeL+iRNiePX
         5bgIIbEteJOdI1+V/L0R7vS/tPQvhulBa5cuid5DoDS1f8KbaBhUHFy/xx3KXNOLELuo
         4ZWq1FAIeLjTavETqpsUwS4Ux5cN6H+9CJpnMOV/fpv953vkV9C6U5zo9f3/LyXqUbu5
         oiOEPyyWGYS37T3kD3rkQUgQAAalcq53oaxoism7Qp7TM5JzG6H+G7BzDRBwvI1nV1Ph
         03bcQCOLKPXm/LfNje6/ABn680vdrtjNc1E7FT+lRdFyQXCyc8IaIO/dZoQA6RaMm4yp
         Y1Ig==
X-Forwarded-Encrypted: i=1; AKwUvBwHRHVOk5S1sEYORVvmGbigotjZq+LoPY47X8RH85mhrW/vqYIvQEvyUcZLwB/4g/l5ly6doWE=@vger.kernel.org
X-Gm-Message-State: AFq9FYJRkuD451NE6fblivms7GtS0eumTOGn+b6WG8+2IXTR6sGVOw5j
	gG1yp9BPCHlX8C7N0AGCUVdhQKPwJnnEZR6SmKO6BNzUVZ3IUX1nX9rK
X-Gm-Gg: AYBFou1Gs8Rj0O1SmvKZUYitF0OEWjwnxJti9SCGTdNvQn99o9WfXV+U5YYmtTSdrYi
	RdLUpb+n7i5cbQYPId7ixXbVQICo7Dp4G48i/jMBoFJx91+v7F7jIWo9fOyZ90WAJUQM2D1WNZ/
	DwIbPMVSjJQdSpl8bVKjNNfEmlAwM+EGOc79QgfRfHZzDZlC+P2LKoHiX3aaEBIdrv4KlneMHkj
	bclWtfSYaxdA198HDElASV2XSoPGBOviyFs8kC0k6khWZIJ/649dZzyh/HpfePNhIkJ9Zapj8pv
	FILbE/6Haapsbzou568X1GaUCmXtCum3ckyRCc7hatlSehIsYiL8sMjhHpscdEKR6HzbI/VD/Xa
	atkekv/abPVT78yCrcDk1Id/GQMrJ+zHWh66yJ0NWVFx6Bac3Il4jVLZBmzhIAQ9+7m9r1TpUFj
	yZucataB9codWyWUx8ynemGBTm02hgzo79qpRL0Vtt+egi6pN/DPrZGjYZHw86ehZsxtt0ZzHHI
	B7ZdconXg7Yv5I0JTeZCXPrptBEkqSnIC81tXoFRXJazrP0Kjrdnlah8//XIYVfyxyH5PrD8oQC
	hT6zroISTH3JRptldVhgQCTNOtZ6nifRsbYjQ6QBDlqe0cTRNKOIo9Ri9RMGkcfyifGUilzVIXc
	sMUNk4BECEVoZO2Yvs3s=
X-Received: by 2002:a05:6122:512:b0:5ea:c727:11fa with SMTP id 71dfb90a1353d-5ec22ed48bfmr2374687e0c.0.1793027525326;
        Mon, 26 Oct 2026 08:12:05 -0700 (PDT)
Received: from gmail.com (111.46.245.35.bc.googleusercontent.com. [35.245.46.111])
        by smtp.gmail.com with ESMTPSA id 71dfb90a1353d-5ec233f5148sm8676016e0c.6.2026.10.26.08.12.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 26 Oct 2026 08:12:03 -0700 (PDT)
Date: Mon, 26 Oct 2026 11:12:03 -0400
From: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
To: =?UTF-8?B?5bmz5LmL?= <treebacker@foxmail.com>, 
 Greg KH <greg@kroah.com>, 
 netdev <netdev@vger.kernel.org>
Cc: "David S. Miller" <davem@davemloft.net>, 
 YOSHIFUJI <yoshfuji@linux-ipv6.org>, 
 Ahern <dsahern@kernel.org>, 
 stable <stable@vger.kernel.org>
Message-ID: <willemdebruijn.kernel.1f4132285ab65@gmail.com>
In-Reply-To: <tencent_E14C00D5FE957DD7E12FFDC2E75A4FA9EE08@qq.com>
References: <tencent_B58BAE2F5FF485D1B4F652E9980EAB132A09@qq.com>
 <2026102604-circus-juvenile-c521@gregkh>
 <tencent_7454E65EE7BD1C085B6951A7D2305157370A@qq.com>
 <2026102658-jockey-volley-94ff@gregkh>
 <tencent_E14C00D5FE957DD7E12FFDC2E75A4FA9EE08@qq.com>
Subject: Re: [PATCH net] ipv6: fix dead half of the MTU guard in
 __ip6_append_data()
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable

=E5=B9=B3=E4=B9=8B wrote:
> The second half of the MTU guard in __ip6_append_data() has been dead
> code since the initial git import:
> =

> 	if (mtu <=3D fragheaderlen ||
> 	    ((mtu - fragheaderlen) & ~7) + fragheaderlen <=3D sizeof(struct fr=
ag_hdr))
> 		goto emsgsize;
> =

> (x & ~7) is unsigned and >=3D 0, and fragheaderlen is at least
> sizeof(struct ipv6hdr) =3D 40 > sizeof(struct frag_hdr) =3D 8, so the
> second condition can never be true.  Commit 5e34af4142ff ("net: ipv6:
> fix skb_over_panic in __ip6_append_data") tightened the first half
> (mtu =3D=3D fragheaderlen) but left the dead second half in place.
> =

> For mtu - fragheaderlen in [1,7], (x & ~7) =3D=3D 0, so
> =

> 	maxfraglen =3D ((mtu - fragheaderlen) & ~7) + fragheaderlen - 8
> =

> underflows below fragheaderlen.  Every later bound computed as
> maxfraglen - fragheaderlen then wraps to 0xfffffff8, in particular the
> datalen clamp inside the fragment loop, which never fires and lets
> fraglen =3D datalen + fragheaderlen escape the MTU constraint.
> =

> With MSG_MORE on an egress device without NETIF_F_SG, alloclen =3D mtu
> while skb_put() is called with the unclamped fraglen, so a single
> sendmsg() on a raw IPv6 socket with a 1240-byte HOPOPTS cmsg and
> IPV6_MTU =3D fragheaderlen + 1 triggers:
> =

>   skbuff: skb_over_panic: len:61280 put:61280 ...
> [   37.607856] kernel BUG at net/core/skbuff.c:214!
> [   37.607865] Internal error: Oops - BUG: 00000000f2000800 [#1]  SMP
> ...
> [   37.616606] Call trace:
> [   37.616606]  skb_panic+0x5c/0x60 (P)
> [   37.616778]  skb_put+0x9c/0xa8
> [   37.616952]  __ip6_append_data+0xf80/0x1948
> [   37.617172]  ip6_append_data+0x94/0x2a8
> [   37.617363]  rawv6_sendmsg+0x588/0x988
> [   37.617716]  inet_sendmsg+0x4c/0xa8
> [   37.617891]  ____sys_sendmsg+0x268/0x308
> [   37.618105]  ___sys_sendmsg+0xb4/0x140
> [   37.618299]  __sys_sendmsg+0xa8/0x140
> =

> Replace the dead expression with a direct check of the payload space
> available in a fragment, which rejects mtu - fragheaderlen in [1,8].
> =

> Fixes: 1da177e4c3f4 ("Linux-2.6.12-rc2")
> Cc: stable@vger.kernel.org
> Signed-off-by: bo cao <treebacker@foxmail.com>

Reviewed-by: Willem de Bruijn <willemb@google.com>

> ---
>  net/ipv6/ip6_output.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> =

> diff --git a/net/ipv6/ip6_output.c b/net/ipv6/ip6_output.c
> index 25fe0ba98b1a..7d4d4d45e207 100644
> --- a/net/ipv6/ip6_output.c
> +++ b/net/ipv6/ip6_output.c
> @@ -1500,7 +1500,7 @@ static int __ip6_append_data(struct sock *sk,
>  		     rt->rt6i_nfheader_len;
>  =

>  	if (mtu <=3D fragheaderlen ||
> -	    ((mtu - fragheaderlen) & ~7) + fragheaderlen <=3D sizeof(struct f=
rag_hdr))
> +	    mtu - fragheaderlen <=3D sizeof(struct frag_hdr))
>  		goto emsgsize;

Thanks for the patch. Not critical, but could even consider a single chec=
k:

    if (mtu <=3D fragheaderlen + sizeof(struct frag_hdr))

Checkers may complain that the right hand side could overflow, but in
practice fragheaderlen is bounded.

>  =

>  	maxfraglen =3D ((mtu - fragheaderlen) & ~7) + fragheaderlen -
> -- =


