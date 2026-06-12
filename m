Received: from mail-dl1-f46.google.com (mail-dl1-f46.google.com [74.125.82.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E895437DEBC
	for <stable@vger.kernel.org>; Fri, 12 Jun 2026 06:45:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.82.46
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781246744; cv=pass; b=e/g2Q/3JVvWU4kST7ICPYLscXl1yAzT2hJS/IBCrjZm0yXywZncYgSeCDlnHmWPKFsmsNw5pqpkvq7EiBQVQYnqtJe4cFCvlHm90a+kSLMo367BpO04ebUmkNQdrV74aXi0ckMY239bZVthGHHU4Jp447hSeJKuhLeDl5yyvDU0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781246744; c=relaxed/simple;
	bh=nhEFFflgD8hYkfYPqSBKzKXl/2KrcZWE8+1yPCxDWKM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=NR6527lji9RSXnW0kwlLz1Xrlf31RuU7tQlYaqvYMIBYif4kz5o18wvwPFah001moe8Mo+Thp0R1Mh/K44PIj5sJQ9p6THZNZYwiXbOs3DDACK05D/8CBArFZVBymO+UEWR3RkW9vtDEc/nV6YMowubT30nRsi7CjypfAOcAi0k=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=l6LAupRV; arc=pass smtp.client-ip=74.125.82.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="l6LAupRV"
Received: by mail-dl1-f46.google.com with SMTP id a92af1059eb24-13832028e9fso588808c88.1
        for <stable@vger.kernel.org>; Thu, 11 Jun 2026 23:45:41 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1781246741; cv=none;
        d=google.com; s=arc-20240605;
        b=PXXQkFzSKWH7UNXRkW314UCSlRb1dCWhYAuRqx7+EkUA/Tjp8fkLl+8XJLwomCOhYR
         hCrGoxba9bV7VJprZ1wmJlLY1UMlbqn+Hv9GLW8yhvVR/kJh3Dd/Xo3DgNB1O/VyQwSR
         ChhyUSNO05a8zFDPlNKHXV4sTGb0v+yAA6+PzxEzQHWKdKEdENtQjQr3DVLe3S6VCMy2
         nqj1wuLMK/STBhUDJuIVgNbYymgsD9fUMKILVCvbTnJzNoRFR4629rRI+s7W+vhiOxpl
         PLv4YOYbOQ2Q8ePy0l9Bse1TJC6hsWenzmgFMknHLUYu6OaLKoWRXSrmHFoQ4Fo8dcUl
         bnVw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=nhEFFflgD8hYkfYPqSBKzKXl/2KrcZWE8+1yPCxDWKM=;
        fh=Hb1EJltM3r8uC5B/pRTTG3AtOAZ3x3gth8xKIh67vnM=;
        b=Pm/K7IRoqb508M0tQM1E6ISQknFNCKB+WrTjRrnaS5KEYm1+RewmADagh0a7vPrdt/
         OzRepSbzN+ov/P/4M4cwy30Mi0yLk6F8erXKiMEJ6HuG/Ip0J/0oIxcfjf0dvafsscY0
         qgyvCE5BjoZ63vwqL5fZJx+g1tDIWaYW8fjEpcH60Z8ap4qPVdn47oJCUugLG1CLuWR0
         GUHScekIVQY0IY118biTEyrb21Br6KXGwe8ktRQtwLm0WWGJtPos4V4/v1Z6/H04Xhc0
         MwH+9lKYWUNyTWjtu8ftyICtDWji7WgoZHYuVwdlOIP4+dNFJgRk9o/GcEESXZJU56zd
         gzlQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1781246741; x=1781851541; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=nhEFFflgD8hYkfYPqSBKzKXl/2KrcZWE8+1yPCxDWKM=;
        b=l6LAupRVSl2c6T/trhMOUfkI+N+NbvzGGEwMG8IhUjiS779OzDaSM6tPKhYrL2mnEt
         tk+ETpORJf0bij7SrL9Vp4vQfkGh3WojWSuSZMyd6FmbksAVQZAfto6i5y5xCpmVwsRE
         B0ptRUfV4VpPPeoXDAm1/FTDzLwfXX8N4Qle3Xtz+5YYQfh2AKB/DHLemELOCX+e1+tq
         siPED2aPOvJWhHHecFzZPMlLJWsF4qFFGv3SqUrZrZhtQRcaVFG2HqwXhfKQfrFe+LvG
         m/5FZg2YwYl478MxUufGkM9zIG1DCCNSBljxU/vzERHFQn0/pBt2wPKg1h3qW2nJh0Pw
         wMBg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781246741; x=1781851541;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=nhEFFflgD8hYkfYPqSBKzKXl/2KrcZWE8+1yPCxDWKM=;
        b=gE2n9lcSNOS5h6aayINoxFoEWeVM2EtFzOiML9HIYr9iybvkmpnzxO+YM99uQIqUaY
         Zi69WDlzJqsWKAUtobGUBXNRcOojPncDnY9THl6S4crrskGdSWBnfplKY+8vLJo+P2lO
         vdE7Ffh7T0nwkKNC5Wpt6G9xbCXKsAnBkMK66tyApxbvy8w3HVcwWkPFg/8YiwItcmRn
         uZaz/DkN53o/nF40Iv7Pf0L3y4AAvoYFyRPP9s1wiUw5UVDNgmwhgZhgCCRiYZSO9G8O
         AV4QWK4oBk3SCUoqxDXvZnTkT2iLoDR1EuWOUSNd5mhrHxe3qJ9/kK8bzhW+xgErzgdx
         nxUg==
X-Forwarded-Encrypted: i=1; AFNElJ8oFTbe489VGdoeWFxu0M+N8kIlUzokt0VJNCtzFcZuE6UQiBD9+V6f8L/4nxI1Pt4dqLgTBMw=@vger.kernel.org
X-Gm-Message-State: AOJu0YxAY2aO1G7NRL9HchXgthrRiz8FnOjd5nDOnzHoKHVixjmkbN9J
	WAq+Og3+pQ7Ai593Q+WA9QVRksfWVxOJzqWjbee9+/pTQGS3yBC/QfLvSkrQF7R0NTKj82sEQrU
	Nn1etH094jjKxy1pxoS2eoCPYXZiEYZR1cGnRgyEq
X-Gm-Gg: Acq92OELTjxvKzlM2a0Mz+v8s87tlYggIL6NzWLBiRfhfyOV+hVkd/GJRx/5cW2BuIe
	C+BaZ3M3NyQmpKzHtiU+5k2Mb717lmDw6it3RzOHrjAKJFPPpSCln6E5IE2vdUL8K1/NbBB+Q8t
	8mAX7KcWzKUxbna9KttEezSCV9lmuR2GDNaSrBUOkG+0xsvxUbg7rJkDTMNJ6z1e1Q2+zXyr7Or
	nblsjxhTlFMkR9Lr8FqmyttTZpH45MdM318aUEAvCP7ZFDty3mjf5Y9WWeagDnfin8fj27FO89q
	s5fu4IS2ilzX5YpJi+vuMK3YTSegPvz7FxpyTzdWIS+AW0iBNjsmlLqV95mcCDExhQ8NojbUQ6H
	ZqroGm5DVeL1cAh0Ay/HPWe+fhsp6Q/H1ibeJ3u08VU5cuG9hJdqv
X-Received: by 2002:a05:7022:5f04:b0:137:ec94:b487 with SMTP id
 a92af1059eb24-1384bb877f6mr373348c88.30.1781246740207; Thu, 11 Jun 2026
 23:45:40 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260611062814.2528793-1-maoyixie.tju@gmail.com> <20260611062814.2528793-3-maoyixie.tju@gmail.com>
In-Reply-To: <20260611062814.2528793-3-maoyixie.tju@gmail.com>
From: Kuniyuki Iwashima <kuniyu@google.com>
Date: Thu, 11 Jun 2026 23:45:29 -0700
X-Gm-Features: AVVi8Ceb_WszCLrvRcLCFH8FpJsAV2LIBVuQJNjjqU_Xa2Ev1Ja5-d4kf85ySDE
Message-ID: <CAAVpQUCL834OQfOWBmYnAGHNtrKhecdm-_qK5F8A9uyQ9cF=BA@mail.gmail.com>
Subject: Re: [PATCH net v5 2/7] net: ipip: require CAP_NET_ADMIN in the device
 netns for changelink
To: Maoyi Xie <maoyixie.tju@gmail.com>
Cc: "David S . Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, David Ahern <dsahern@kernel.org>, 
	Xiao Liang <shaw.leon@gmail.com>, Steffen Klassert <steffen.klassert@secunet.com>, 
	Herbert Xu <herbert@gondor.apana.org.au>, Simon Horman <horms@kernel.org>, netdev@vger.kernel.org, 
	linux-kernel@vger.kernel.org, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Jun 10, 2026 at 11:28=E2=80=AFPM Maoyi Xie <maoyixie.tju@gmail.com>=
 wrote:
>
> ipip_changelink() operates on at most two netns, dev_net(dev) and the
> tunnel link netns t->net. They differ once the device is created in or
> moved to a netns other than the one the request runs in. The rtnl
> changelink path checks CAP_NET_ADMIN only against dev_net(dev), so a
> caller privileged there but not in t->net can rewrite a tunnel that
> lives in t->net.
>
> Gate ipip_changelink() on rtnl_dev_link_net_capable() at its top,
> before any attribute is parsed.
>
> Reported-by: Xiao Liang <shaw.leon@gmail.com>
> Closes: https://lore.kernel.org/netdev/CABAhCOSzP1vaThGV35_VnsRCb=3D87_CP=
jPVsTHbq905k8A+BuUg@mail.gmail.com/
> Fixes: d0f418516022 ("net, ip_tunnel: fix namespaces move")

This is wrong too.

Fixes: 6c742e714d8c ("ipip: add x-netns support")


> Cc: stable@vger.kernel.org
> Signed-off-by: Maoyi Xie <maoyixie.tju@gmail.com>

Reviewed-by: Kuniyuki Iwashima <kuniyu@google.com>
