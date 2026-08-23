Received: from mail-qt1-f173.google.com (mail-qt1-f173.google.com [209.85.160.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D10DA278161
	for <stable@vger.kernel.org>; Sun, 23 Aug 2026 15:11:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.160.173
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787497879; cv=pass; b=Mzcf4BgZo0W6YlSxiQn1aImaIXcS+Ki5de2FQr82badIu4wnQQkbGsovcG4Mb7xCkp/BM83YyiadV2GMIoHLXXaqjnyziI6Bwwp+aIodUKNQw+xE4URHIBHbtkySRsLiq1WcNJV6GULF/qXzcmxpNf2yOrjlZWZjoOFfrtCJZTQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787497879; c=relaxed/simple;
	bh=xIkR7zg5lhtFvWgzMHNup3lKSqq6a/c/k1dJRgDfsLc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=qBpInlq+eAU12kPskdR9DPFLZN4MegM3tGm5QmStpaSvw0aIdPwNv29Aa20Y5HrmlkaViGH2WAScbg137SrDE5E95zFyeTUY9XDMJ8Tf1pmoGNVOpFezdubgf9ccWxzrIc/9jPLbra3xxeb466+2M8Bj70FwGdIHoI+BLRcxy2k=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=OAiHS/nS; arc=pass smtp.client-ip=209.85.160.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="OAiHS/nS"
Received: by mail-qt1-f173.google.com with SMTP id d75a77b69052e-51c2a818fc4so17564191cf.2
        for <stable@vger.kernel.org>; Sun, 23 Aug 2026 08:11:17 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1787497877; cv=none;
        d=google.com; s=arc-20260327;
        b=OtM66v8RPbkn7aRRLF/Rn9qye7WBE0FYMDHL8unvKfCzHESjNR0fvPcRnlp+546rBv
         ztwKoPNmFmf6tX3vZRqF7gYZR48jQQRjONB5RBKG2zT/8bVSu/gRprQmgpDJA3GyBs31
         jaqQpe7jRu1HZd9q38UY9FOx0Lt9Z0fr0NggDg2BnBdeGdFh0l6LKJN0hX3YSCSZs3Hf
         lt1ZFDGHS4zvnhkaxZ1xF7IuSVGuRKMJ2tGInUPxqw5HXgiNb0wl0OXf2irQv/zxObjX
         jqR1po9ur4KlFOxUvhzQb1Z8yKR/x1+ul0ExNt86DWSyz2AsGXzLpM1U2iSXNti8kLU1
         m0gA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=xIkR7zg5lhtFvWgzMHNup3lKSqq6a/c/k1dJRgDfsLc=;
        fh=61Z24qAX009lK/JrbStAnOkW8U74scWEENwvtAZVOr0=;
        b=AfCkCKEVneZM7jDm14sgUwl7Cic93lSBPXwkb1vZcAk7W6O1riHtP0eNMZrhU1BUfq
         kBTRfdADibPax4Qk072wHDlTfdudT3sap2CQo/4CGxWS+c2URdE3OhfgQbFCDyfqeFsP
         YpBU/kw82ULV+ykWpLN2maDThJE+Sbkky8j/8UoOigOlSSwKjuWxHhzczCLdEDH7CdGX
         uTo4X7TjzMqswUwGzuCeGdIz2kJfemUo2izIkmqOogMZ6M2lwuXH97u6Pz0UoqaAzC37
         OLYPGQgd+L+NAwOmYl0wwxZMYMnECI/mJuWUphM3AU3BL5rg0gzI+JmaYS92BpqR9gxG
         3AYw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1787497877; x=1788102677; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=xIkR7zg5lhtFvWgzMHNup3lKSqq6a/c/k1dJRgDfsLc=;
        b=OAiHS/nSmpqHFH949qkvPRDHKimAT91CmO98Ppxv+VVRd9Fcfs+8Cl4AOA+tdMhxPQ
         rZTnlPe3SvbnMR7hpDDXqeQ72koj7ZAb7VidsXjqEXwk1AkYrWiCH4AJLNqUmsCYos8n
         7HVwuWW27Xuxdu6KZ395WxHKrS4lFs2n0u0Z4af/mI5mKXn57k/jqU51tauSmcgXXiAg
         IoSwX1yCywnU/IaUYo4VVs0PHNlgE3EeU0cpCnCKJIn6o4TmUw8R/Td27VKpX4fjpWzO
         WKd5qwqMK70JtFrPsdngN2HR4mbzngQLG0TkYWi/98D7euqY/pSIADFa1B1ujnYLmkmJ
         htWA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787497877; x=1788102677;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=xIkR7zg5lhtFvWgzMHNup3lKSqq6a/c/k1dJRgDfsLc=;
        b=GW345QgXXiUEeCCIEkldBERBSPq3gl5gvA6m8yWnnbkFmS3waGmsM8MxGXuyV4uGWn
         STvFrdQberBHRyjhb4fi/gfQ0c9WP54iDYvO2t100P1OF335BzHgi9gP+UDIc5xneOIn
         MrZNRHCuRnb9ptq7eR/GLsM0/WRec5eR4rA70ELt77TtnDRHI57Rxv/HJYY5NOA3sUO7
         H6CWt9uLxCoY8s60dvUZsdoEMR1V4RgujHbvGzDI3ISP1BZE3yLtmNyTpyRf7ZjYSHh4
         +2XWJx9Gi3lZqJ4tlwsXwFDyyILVDx/urlWO4d+XA8/tCk+CqhzI15xmqIxVhIlZVh9u
         LfbA==
X-Forwarded-Encrypted: i=1; AHgh+RowUWdTUsNKPihDzqK/txyIdjwHY25h3u1iSOF2GlaEyrLI6nG8yrWXQFQV45Rp82vLfhPyquQ=@vger.kernel.org
X-Gm-Message-State: AFuF++krPYY1HQtGFtsN2rQ++UFDgqWtv6b7TGUvdh+PZIvMl0Ft6nTO
	7zn2RXm3kYtwW7OaP6V6dTBzcHHjLuty6EReTVRzMbu+RWeXiZKjZTCGHbLXqGi+sTkzlcEojz8
	50yclzn3zL80YTBOPJsRiN40ofExitBAhAmgz0Kbe
X-Gm-Gg: AR+sD12JINZiGD3M8XjoJFvt/Ubl7Ven5q/1gx6I5ftIOqNPZdc0valGJzxTnQNR5qD
	4/wmCy0LcZVDUHkJ+lp5Xreyopp291GSXQuR0U/p3PlMrE72N+LIPE1/Zs+oIfVtZsYs3Y713kT
	+Kt1RuazH072HdLBGeZNH6LIACFHMKcaKA7emBrks7dD3V0Osn3t5sqLp3H0qPeHZZ6awtRTuna
	H9qKY6e/VLOtst0ilBsupRAYvyKWjHbLMkGY1iWUHH+t5ee9o/09cDArYBms37D5zPhzliNVVr2
	TblSJUm7kDzh0ahunLF/b5LPOdPRwIJ3lhMiziS3+OW/P7qybLK+i5htmN+HAJwuRd2mUbv3GrU
	vx0dOp2UCGyRZvxEvq2Byn9ThxTkCv0sy/NyCeZEK+1zvu4l1LnsSEodC
X-Received: by 2002:a05:622a:1f91:b0:52d:8c01:5238 with SMTP id
 d75a77b69052e-52e09cb983fmr112871311cf.33.1787497876233; Sun, 23 Aug 2026
 08:11:16 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260823101809.26802-1-shlomojune6@gmail.com>
In-Reply-To: <20260823101809.26802-1-shlomojune6@gmail.com>
From: Eric Dumazet <edumazet@google.com>
Date: Sun, 23 Aug 2026 17:11:04 +0200
X-Gm-Features: AcwNN1XEn31QwNoOjATtV2OBczN_PVRdSeHeaGm1GS7qzu4XZoVeex3ZR6dO9QY
Message-ID: <CANn89iJALGUB4jYyRWWMQENyNqBtSChOTiBwFzOVs-s6uX9Eig@mail.gmail.com>
Subject: Re: [PATCH net 1/1] net: Don't deliver IPv6 packets to IPv4 sockets
To: Shihuang Liu <shlomojune6@gmail.com>
Cc: netdev@vger.kernel.org, "David S . Miller" <davem@davemloft.net>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, 
	Joe Stringer <joe@wand.net.nz>, Alexei Starovoitov <ast@kernel.org>, Martin KaFai Lau <kafai@fb.com>, bpf@vger.kernel.org, 
	linux-kernel@vger.kernel.org, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sun, Aug 23, 2026 at 12:18=E2=80=AFPM Shihuang Liu <shlomojune6@gmail.co=
m> wrote:
>
> bpf_sk_assign() allows a TC ingress program to attach an arbitrary
> hashed socket to an skb, without checking that the socket family
> matches the packet's network layer. As a result, an IPv6 UDP packet
> can be assigned to an AF_INET UDP socket: udpv6_rcv() steals the
> socket via inet6_steal_sock(), which also lacks a family check, and
> queues the IPv6 skb on the AF_INET socket.
>
> recvmsg() on that socket then runs the IPv4 udp_recvmsg(), which
> interprets the IPv6 skb control block as IPv4 IP options. When
> IP_RETOPTS is enabled on the target socket, __ip_options_echo()
> copies up to 153 bytes of attacker-controlled data from the IPv6
> Destination Options extension header into the 40-byte option-data
> area of the stack-allocated optbuf in ip_cmsg_recv_retopts():
>
>

Really you need to ask your LLM to not slow down linux fast paths.

Fix bpf_sk_assign() and bpf_sk_assign_tcp_reqsk() instead.

Thank you.

pw-bot: cr
