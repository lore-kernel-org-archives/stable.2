Received: from mail-ej1-f50.google.com (mail-ej1-f50.google.com [209.85.218.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4B6E94B44BE
	for <stable@vger.kernel.org>; Tue, 13 Oct 2026 10:43:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.218.50
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791888217; cv=pass; b=Y9NpJDcHrMPEO8P/zzi6E7FToDrsEmR/eOlm2zW38U58uu3i/iUuqxsiT7TvgRhjJKc272/Nis0FlB1gl/XaY4dRdwsX4EROIxEhybm1Q4XafgngocIzvVlZAVKPG6sZuopZxLOf3P50m27ir2+bWBW87ctYo7q3hzmk5diEIDA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791888217; c=relaxed/simple;
	bh=rUqmGo5gmll+GCaALoJRbfek86ESyi36pidayRfvfM4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=mWlwyGdxNaBWFBha9kh2vXATftFzqatusOO/p9Z7vOgludIax9eBBzlOTjGyfM7mVl6H42YEDINDUMPjA0IbGKrdNjP3rgvt6U9gmOOFDrkrlMJ7fi22EFNj3nuMOu8+Sm3pJc+A8fTGym6dLX1mVVYd3VaVRbxRk4ojfQhQnj8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=a9JKuDu0; arc=pass smtp.client-ip=209.85.218.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="a9JKuDu0"
Received: by mail-ej1-f50.google.com with SMTP id a640c23a62f3a-c2937c43f31so41845166b.3
        for <stable@vger.kernel.org>; Tue, 13 Oct 2026 03:43:35 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1791888213; cv=none;
        d=google.com; s=arc-20260327;
        b=KZU7kVLjPzoHoFVDnXgVItEdXCub3d7iVWJwXofQguIKma7d4AQ/L8/V8QkiTwzC0N
         7gn1Vs5DEqpp6HOJApQIu7oJ437JPcjofU5mI5IrfS2Od2ujquIdMApnRY1NgkoSLQVa
         sscXfgTgIOViNPsZ1QAc+aNrn/22DxNmdxCQIUcsV+0Tl7zxJyTreJkha7SPYnL4848z
         2yXeTOQBq5g6+TEtvQgALshmlfDzf0kbIsoqxsDtw34EPWbexARtLikFbICJXFbbdwQt
         ITbtPAvD422HCqIxJzBnJGa/Gg/+KNkWVVulh8k4JhR4QnIP84bzVUyo/bsaHQWQnRwg
         5OzA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=rUqmGo5gmll+GCaALoJRbfek86ESyi36pidayRfvfM4=;
        fh=oA6VIYAtjLsS5YcKWWnFX2K+siYbilXjrHRMXGomDKY=;
        b=SESyibV9Erw0t2v593RqPWQgGitmEI1pD3ZVat6TepufV8haz/7LQa9kc++vr4wUeP
         bgLkwwPcekx44yZ6hxme2o6+8ZKz2W4lXlZ7Z1+fbzWZF5BG/VYRj0qSUti8A9vYNMkN
         +mmXTq49kbHav74581HdDLCcUD0yiULO0A9DTroHJgWwXRquJ1V/UOML/HRqdhGJVRCK
         PlN0ijHu5GYKf9Bq27BafhJT7TnZzyE4zJG8BM4BHL0+hLMY2WVNwN97yVqu83co8qWE
         Y2muqBTfTz0bff9hv95nbGEfHSyo/fARKjn3ZlQw17d6PG9E9IxEqeyZ4jK+MVqGHGmC
         Ne/g==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1791888213; x=1792493013; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=rUqmGo5gmll+GCaALoJRbfek86ESyi36pidayRfvfM4=;
        b=a9JKuDu0SiivLt+mLksbpd/cL0Ix5TymRLUpuuGfUMEF53taMb/ZGXnzUGm3EPCzLh
         3ZcgW1dw21t+Yur5pA/4H1mOqZNN9Q+rO7gM1DHbah6Upn7tfQeMfFnGVAjbcml4yDDx
         4m2lcvDwoc1VSxlu9/Us/xe/9Dt9ayL6T73pjFOLpnhkDj54DRiODTl0Eu4CPJi01jmj
         GpKp/VM9PNc/7l7cNhPau8fK2oaM7/D6DlEF4wfcSyaymbklitcuzhtw1/poKktPEMgZ
         AswDf97ldxvngcq5kcwMHe500hhGvnP9Q0pVS1NbKQETfE6Ox+dnXinZth16C1WtCJoX
         MelQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791888213; x=1792493013;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=rUqmGo5gmll+GCaALoJRbfek86ESyi36pidayRfvfM4=;
        b=GzGKy2SUx2eHHD4zprvh3fzk2SLmchHg0TEdwZqiDSYhSeU8l+tv9enHYBJTyRHNrj
         N/e2YMQYQDNnOxItp1KLnFYntmqubMgR8kLjfD3hRXqkuqjwcL5q8OHj+ajR+w/J+T5M
         +anvnGyRLXyh6nJXL4Fz5e3vGtPre/NuhH4UHyoqrXT2/lUFr9iRoiv8jt2FEv8i0RA6
         UAU6H5rNhWsm9EylVcpjO2s5LH+VJDVX5nxfdHG/1S0+96kD5uZdL9Bf3i1pNy0MXfpd
         m8iGhBemoz+54vxaE9SCpIO2wrj/Lrj1L4qWmEBxDX7oFpPnqJFbmrwD4bLNp2F+fZpN
         1ibg==
X-Forwarded-Encrypted: i=1; AKwUvBzGM+IIwYaEVOX81KN2spIvMwD1lU2k4xOyuczcL2E4hzoNMNtAJmb7UgefxnXvx3Ya7cYb0Ps=@vger.kernel.org
X-Gm-Message-State: AFq9FYIa87U8NrzKTvoS+zpp/StcRMHarmi1/28DTQsn4vNa+7fsFmIM
	u+/7C76K0Up6y0l6PDRr9/K8tmnj9WctSFN3CzPW7Aif8z7qrAu7ecfs07OpjV1l0FeLX/77l0Z
	CBi7hYE17wVqlanLOJwpgY+TS+jKJQtY=
X-Gm-Gg: AYBFou2VQlf1UuDYYAQ0P7RczC1zSnjimnsiFspOdz0aefRFa4X6bRnJa1QzXVHVJgx
	oqGL8MrzJI9SQaaE68iVyz73IwVdoBoiJ5pWW1BcFMk2WsAp4O9L0DTMDyg6wG4UGgmbXyKwyAM
	PsluhVmaNGzZUyqKDPv+zaHTSF5te+ThUs43EsezKQDDDzi5g5iSI1IeUDUmYH4/xUvckLuQk3k
	j7/osVFeL34SFLyo1Gbqa9ItXR0fGTSYYvlGsySc/mvTT7W7fofDq5c9jrUivqN9X8dZKPS11on
	80LUvKpMdT4O/pccEMp+GGTAXJEHpeRQdIXDLmQkLihxL3YFVIdiIC265dDZW/+NGme5sdkSVIe
	zuy2K9xfY
X-Received: by 2002:a17:907:3cc4:b0:c25:2ded:ad36 with SMTP id
 a640c23a62f3a-c31a96e7a46mr1286808066b.0.1791888213256; Tue, 13 Oct 2026
 03:43:33 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260824152331.216494-1-nicoyip.dev@gmail.com>
 <f3a9dd1f-43a7-4644-bf1a-45dcd422abcb@redhat.com> <CAAo+4rUG_Y_d28bLbQdcmHY5-vtBrhV+D6rzbd3Mb6B3iTSuHQ@mail.gmail.com>
In-Reply-To: <CAAo+4rUG_Y_d28bLbQdcmHY5-vtBrhV+D6rzbd3Mb6B3iTSuHQ@mail.gmail.com>
From: Chengfeng Ye <nicoyip.dev@gmail.com>
Date: Tue, 13 Oct 2026 18:43:21 +0800
X-Gm-Features: AclHuK9kgucNW_X-CmFkUz3aZTCU9FnPnXOeZBb7AYpPKDF7GSiLOX-F6v5amrQ
Message-ID: <CAAo+4rV1zx_U6Er8eDE0JW2f6jBXY6gmhnncXKvycn98ZjXG9Q@mail.gmail.com>
Subject: Re: [PATCH net] net: pktgen: keep device lookup under RCU protection
To: Paolo Abeni <pabeni@redhat.com>
Cc: "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Simon Horman <horms@kernel.org>, 
	Willem de Bruijn <willemb@google.com>, Nikolay Aleksandrov <razor@blackwall.org>, 
	Qi Zhang <marsy12010123@gmail.com>, Randy Dunlap <rdunlap@infradead.org>, 
	Alice Mikityanska <alice.kernel@fastmail.im>, Florian Westphal <fw@strlen.de>, 
	Jesper Dangaard Brouer <hawk@kernel.org>, netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
	stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Aug 26, 2026 at 2:55=E2=80=AFAM Chengfeng Ye <nicoyip.dev@gmail.com=
> wrote:
>
> On Tue, Aug 25, 2026 at 6:45=E2=80=AFPM Paolo Abeni <pabeni@redhat.com> w=
rote:
> > Side note: returning the RCU protected ptr outside the RCU read lock
> > safe, as the caller never deference it, but quite confusing.
> >
> > It would be nice to follow-up on net-next replacing the return type her=
e
> > with a bool.
> >
> > /P
> >
>
> No problem, the follow-up patch is just sent.
>
> Best Regards,
> Chengfeng

Hi Paolo and Eric,

A gentle ping on this fix, which is still marked Deferred.

The requested bool follow-up has been applied to net-next as
2a5043c8b7d0 (https://git.kernel.org/pub/scm/linux/kernel/git/netdev/net-ne=
xt.git/commit/?id=3D2a5043c8b7d09f2fc76c19270fd687b774c5a68b),
but the RCU lifetime fix remains outstanding.

I rechecked this original patch against net/main at 8bf659bd54e1: it
still applies cleanly.

Best regards,
Chengfeng
