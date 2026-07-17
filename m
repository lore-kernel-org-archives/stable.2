Received: from mail-qt1-f173.google.com (mail-qt1-f173.google.com [209.85.160.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DFBA0E54B
	for <stable@vger.kernel.org>; Fri, 17 Jul 2026 19:34:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.160.173
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784316849; cv=pass; b=cvhThsbeYdg4t4ypJJOqdzU22O6b42qpl66C62TTVylbqsuKYEkbPIQ+CoeyjzTmJuB8q/yGoO6OVAMHcDnPgwD10WGZOhNSG490mQUYnrpTC3kayqhz9nlB3Ms6mas7j7j0w/Ucp4tJ59qwi/FckzU+0Z7karaBLLtpyQeI8lY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784316849; c=relaxed/simple;
	bh=Z2+x0bVuX2JZuXF66F8NzOj726FZhm0l0KRuCmFB0LE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=qF//9Pycf3PnFO2wgGTm9nzx9aLemKrVRwFFRVVA9C08fkN7Xeu7q/IbS7lA5SATbgCYQwkCIvpYVZlBd1d/r3nat3pbLJDdYQpMJhqA0Jar1Zkj88nAm0yjXGmnmWEcnwD29MlkDkpEtziVTORe/48SBNGJFI2V2YVcR7uuh1o=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=GhpA09/D; arc=pass smtp.client-ip=209.85.160.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="GhpA09/D"
Received: by mail-qt1-f173.google.com with SMTP id d75a77b69052e-51c08df8513so34028741cf.3
        for <stable@vger.kernel.org>; Fri, 17 Jul 2026 12:34:06 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1784316846; cv=none;
        d=google.com; s=arc-20260327;
        b=KZ92I0FZ9DOW2+S6BOVkNDjuGnPuigRGs9OJ78y1bz3lryiWd8YD5pWpW0HNINQ9Ms
         +5XCNw0VvQmA9WoZQqSefUnVfIIWPWnh8xcOtgpa77gxrU8ZRsb6UBWhbwc3jFP2eZXJ
         uazA1o5NFWBj47DKjlcntm0Mm3MDrEFjvnQ3glsiNFr6Dg5mTnwN1KSwd9LtQLU2afZD
         puIhhx0cdSnbI+G7MQB2WnzcX7++8coKExpJf1CpQzx+x3Mg0N/wYo4B+urN2fa8qV04
         L7jRTIGxubvFK7AgbiYpVK552rpyCzZK+FxNdicJOrO4bWouDDzr94a34LSyMiLmLkUw
         Gq7A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=0VXJKOtnkf44j+tQQsqQzA0l3vLSi+Q72kwccQQQrtI=;
        fh=Npo6q59QiPZXSrHOeoWAvJL8NhFw2AlcJzTP2aIVBgE=;
        b=Y6QvWELZMrlPILhP4ZUfMKhwbSX6jw2AhcaURAPqXBpIA9Dpu5Od04LpCwKclCUwV/
         L1T+ba7Unjm3X+12qwIdulKPToTCVi0qoZSyToR03+LWAZ7oVq/ywivd9DIQJiAfTnFf
         KIxVb/9/r21l51cZ0DxuhT3IiGFYQkBI0jUnFZ53zQF05J5wARXIwLqpvtTTqBzFUZ//
         Fi6kJ5Ho9YSPXuicHf/EhxPg1BpuT3L1ENaX10dWiy908pXetzbOeCcSWK2Fkni9Y2F2
         m8v8WlehkJOQU1ZN93lqRjReLYEaheboEKzgU/KdgyYmJsZVk+FHXJfVkiVmuGRDeZ6J
         e+3Q==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1784316846; x=1784921646; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=0VXJKOtnkf44j+tQQsqQzA0l3vLSi+Q72kwccQQQrtI=;
        b=GhpA09/DoCfXdyGGw7zJ9bP9uoHcFXAbDYNrOfZd4UlF6r56MqXBISyGIx0DH/aA+8
         flc7lUkG2oUgoH+SEAnwAWbY600DXVGjWpnBy9jxSUoMCWJQb+eCSukiujd8/C3fOhn5
         VFWqs9q9rCDcJgKCFmwZFGrX5QAtWniCUAuW5ajgJl5qX0QYd4I7gUd3anDnsoxYlR2N
         GsytER35otGTNYcygF2S+3nvQLb7JN7ql6TcKD22THvKQcHMcqqyqCEZIqPRO1wV9HfD
         Y2opmcQUoxDtfe244ASkRTcS7TugCUGj10aQhJA+w01AQAFu7xg1esbIO02vwCeDhA4h
         Cz3g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784316846; x=1784921646;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=0VXJKOtnkf44j+tQQsqQzA0l3vLSi+Q72kwccQQQrtI=;
        b=gW28wzzpRcG/U34yYba29sn+tYmNIdDl3jhkcEQmkDw4didjoRAwXhJ/v9AhGqUv0E
         g0VCEhWXjGYJ+ES+ru7lmBiRZOo0nlVm+FwpNqHSpDsNexyyt3B/5iUYEOkmhh6A9Lq4
         D4heuiHmzoH2Fx6su3Taovq0HarVyv5aRdxmlZV7wDcWSREWP3iBScQ5+ICR6rPCeWkD
         bT5g/YRsvPUtZjc1DNCJy0NlNsfeuxegAo7oRMO5NSpu7mlCVFebGX1HGKQDCz/KuokS
         s6BK3wD1dzdicARuX64lumx1zhAMuiyOx6Qjo+2iw+rVKG1ML9a11K/NLiuGt3AtGnlC
         7Thg==
X-Forwarded-Encrypted: i=1; AHgh+RpYCtlN9ZrkwiblxowCcUbsM0taxh2M4MD7DeGXd1gLHj27EB/RNQ6124sq73KuzKwwFsB4Mrg=@vger.kernel.org
X-Gm-Message-State: AOJu0YxuU2dBjJQY8/kCU11uGX7xSRCaO7WHTigy5GvTwVuXS9CUFbXa
	U4CgC/8U51DSHFKFf12P4P5bEA8sEKZNsexlnhE9YjytIZOeHpFVG1Tpew3KE2OTAp5fUc3K38g
	eueT1dptqf7wC1S6IPRbq6tOow2mqHYesRR1NdVL/
X-Gm-Gg: AfdE7cmV2NREcbM0bTdNHphj0XJZwj0Ob2tKDQ/3hfUrp7iOWyfpQBVHnakgPUiUEda
	HnSNtFMdQBfI9Cuh5bm9K7RAOiIAa68Nz+tKKCyNEN0xiU0YSo43SjF4sUy6XO1gcXHpMeGX8YZ
	h9vOHCFfZ654U2yJ8dHziuvH0cHoWBQfB+j+4Cvv+GKDyjahtjLZY4boR8/8H1IwCiH2QJ0/KVZ
	BuQjyKz/JFfurRozMjwMW9kWHX7hfXdLtk4a77jXuU7Q9A18F0ERxuTrcN3SIEfFIHAIcL0zl+E
	Ig5k82WiyeUWuSu4c+fMDRw8vSyYNdioTAZu96S/XqX01TO+r3mkIRi9XHIgFXfK8nNcJ0TEBFu
	GdhTDIh2B
X-Received: by 2002:a05:622a:a05:b0:51c:1c00:e46 with SMTP id
 d75a77b69052e-5213c7e8436mr37586171cf.25.1784316845085; Fri, 17 Jul 2026
 12:34:05 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260717074109.686170-1-yangyx22@mails.tsinghua.edu.cn>
In-Reply-To: <20260717074109.686170-1-yangyx22@mails.tsinghua.edu.cn>
From: Eric Dumazet <edumazet@google.com>
Date: Fri, 17 Jul 2026 21:33:52 +0200
X-Gm-Features: AUfX_mzjSXpXhmgPyFW5IUal0VGKT4ixqqI6k9wW0PNFr2YNbw4acNqb_17YTjk
Message-ID: <CANn89iLK7dN3JObPGCsgep5aCobrfT-gKpdPpmG3uZwgyOwa7Q@mail.gmail.com>
Subject: Re: [PATCH net] ipv4: reject impossible oversized fragments at queue time
To: Yuxiang Yang <yangyx22@mails.tsinghua.edu.cn>
Cc: netdev@vger.kernel.org, dsahern@kernel.org, idosch@nvidia.com, 
	davem@davemloft.net, kuba@kernel.org, pabeni@redhat.com, horms@kernel.org, 
	linux-kernel@vger.kernel.org, stable@vger.kernel.org, 
	Yizhou Zhao <zhaoyz24@mails.tsinghua.edu.cn>, Ao Wang <wangao@seu.edu.cn>, 
	Xuewei Feng <fengxw06@126.com>, Qi Li <qli01@tsinghua.edu.cn>, Ke Xu <xuke@tsinghua.edu.cn>, 
	yyxroy22@gmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Jul 17, 2026 at 9:41=E2=80=AFAM Yuxiang Yang
<yangyx22@mails.tsinghua.edu.cn> wrote:
>
> ip_frag_queue() computes each incoming fragment's end offset and may
> store it in qp->q.len without checking that the fragment can fit within
> the 65535 byte IPv4 datagram limit, even with the minimum IPv4 header.
> The only 65535 byte check lives later in ip_frag_reasm(), after the
> fragment has already been accepted into the reassembly queue and has
> updated its state.
>
> A fragment whose end offset exceeds 65535 minus the minimum 20-byte IPv4
> header cannot be part of any valid IPv4 datagram. Letting it update
> qp->q.len leaves the shared reassembly queue with an impossible expected
> length. A later legitimate two-fragment datagram sharing that key can no
> longer complete reassembly and is not delivered.
>
> This was verified at runtime on Linux 6.12.93-0-virt. A same-key
> oversized-fragment injection (offset 65528, payload 8, end 65536) drove
> legitimate two-fragment UDP delivery from 8/8 to 0/8, while a cross-ID
> control stayed at 8/8.
>
> With this change applied to net main, the same-key test delivered 8/8.
> A valid 65535-byte datagram with a 20-byte header was also delivered with
> both in-order and reverse-order fragments; its 65507-byte UDP payload
> was intact in both cases.
>
> Add a per-fragment bound check in ip_frag_queue() right after computing
> end and before any qp->q.len update or skb insertion. IPv4 always needs
> at least a struct iphdr, so an end offset greater than IP_MAX_MTU minus
> sizeof(struct iphdr) cannot fit in any valid IPv4 datagram. Use that
> minimum-header bound rather than the current fragment's IHL because
> fragments may arrive out of order and the first fragment may carry
> non-copied options that later fragments lack. The existing check in
> ip_frag_reasm() continues to validate the final length against the
> actual header length of the first fragment.
>
> Drop only the invalid skb so an existing queue for the same key remains
> intact.

I have a hard time understanding the issue.

This is an invalid packet, why should we add more bloat to
the kernel just to 'optimize' this case?

You understand that IP frags are unreliable no matter how hard we try
to 'fix' them, right ?



>
> The issue was found by Yuxiang Yang, Yizhou Zhao, Ao Wang, Xuewei Feng,
> Qi Li, and Ke Xu, with assistance from GLM-5.2 by Z.ai.
>
> Fixes: 1da177e4c3f4 ("Linux-2.6.12-rc2")
> Cc: stable@vger.kernel.org
> Signed-off-by: Yuxiang Yang <yangyx22@mails.tsinghua.edu.cn>
> ---
>  net/ipv4/ip_fragment.c | 2 ++
>  1 file changed, 2 insertions(+)
>
> diff --git a/net/ipv4/ip_fragment.c b/net/ipv4/ip_fragment.c
> index c790d2f49..32e5240a5 100644
> --- a/net/ipv4/ip_fragment.c
> +++ b/net/ipv4/ip_fragment.c
> @@ -291,6 +291,8 @@ static int ip_frag_queue(struct ipq *qp, struct sk_bu=
ff *skb, int *refs)
>         /* Determine the position of this fragment. */
>         end =3D offset + skb->len - skb_network_offset(skb) - ihl;
>         err =3D -EINVAL;
> +       if (end > IP_MAX_MTU - sizeof(struct iphdr))
> +               goto err;
>
>         /* Is this the final fragment? */
>         if ((flags & IP_MF) =3D=3D 0) {
> --
> 2.34.1
>
