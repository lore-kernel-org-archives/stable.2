Received: from mail-qt1-f180.google.com (mail-qt1-f180.google.com [209.85.160.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D41CE40B11B
	for <stable@vger.kernel.org>; Tue, 21 Jul 2026 15:37:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.160.180
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784648245; cv=pass; b=C9PHhQCZbnCfalaIWQq5I76OMKOVOiAnFIss0JZgrbBvmLGYugTsfG4jCXh09skIDVptQIekehGAsrHlaPM5wVVj//pNpNxGKSF1UQcxa2JwfPSsdjlzU9u2ee1/04TuoggobGrVW1t1GgRkyzAW372FZ+3Whqu5mupAnaSe2v0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784648245; c=relaxed/simple;
	bh=qS6BciTxCll3ZIHOBHVpTYa96f8u6jpS8p3mYmAgQns=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=J+fwIkk+2MbufVhLueDwlSC8SX0NdUrzFJ2WZMawUUALeIl5nof9uBi3V6Cwzj8XI7vi0T5rhw1/GIG78M8+jSVViXB9rIuLVL0IjKCKgHNECwEL76vgABvJi3R4a6I8q+AujLQU9NPKrxKN7v5H/PLlrOA7/a7Cr4emAT9/+L4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=I2u0v9FW; arc=pass smtp.client-ip=209.85.160.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="I2u0v9FW"
Received: by mail-qt1-f180.google.com with SMTP id d75a77b69052e-51bfad59921so99480301cf.0
        for <stable@vger.kernel.org>; Tue, 21 Jul 2026 08:37:23 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1784648243; cv=none;
        d=google.com; s=arc-20260327;
        b=d5LNESeB2vqKyHRZohul9Nqdsh20GdKaSo+6Bw4U2Sa+DZ9qUMrLt1Q8K27ThNjUE0
         qP6NkD5UTvS74dfNiSjErupjMdIF9V2N+qCckrvA9JwHKJDpwlFhSv0/Fl2cuZ26ZR8u
         P+Ag75UYZVZjubU2idu6tCLJx1jXSzPU49FUA95A6w+BSRcCWh6x3gAciKPPIa6gxrK+
         L3wBq+GaHW+HSFCVkGi0HjzB8lSiGBO5S7u9uSK548iYVjz7Ga6UGVlqCa2BsKN8VWeA
         YcB2pCFdgeVjR0lO4dbTygMjfjDrjOEgmPNCAKHPSexraADiFhxCFzYYIZNdxzOwv0AD
         mQng==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=lePK3aUOROHNA3Mxb8ZHhUYvtbwzgB3FkuR9oqw9z+0=;
        fh=LyGrvvBr+TJOqT4Awtj5UziPFGrb4R3J4aaQsoTE5cw=;
        b=R1WJ5osoDmrbwbZ8Odpjj0DfwBYAXUOOD4v/LllJEOgF0RkZlPxzV/G2iMWG8x1dCc
         XKoURR9iE1UTUa+o9O0BcCov3tJrhUUxOV/sNGVMb/EVCZLQJchfyeFDGZYHFBoJ3Y3Z
         aYteIwpuHQEfjO5vciX3kWOoKIOveInUL6Av+nPmfZ0BDNwtDeVvhVbvWz41oIqPU4C5
         754kx13QY6dsFonGMbEKv5nhdnQQHOmxfrHrB2S1X1Yv1xUxoxFgsNlUheOjcbnitO+H
         iYYY62d4FBr9giJm0q9O4WLIPGbNFWXDQShZpeQgm9MFhHlEG0+H35YkIiD+WcZtq4sg
         AUSw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1784648243; x=1785253043; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=lePK3aUOROHNA3Mxb8ZHhUYvtbwzgB3FkuR9oqw9z+0=;
        b=I2u0v9FWcaf3xvAHBI4xZ372/AwgbzV9RjgUW1hx4r0nf4ycGPXrpqBLvqaeht0hH6
         HO2gTawLExdz07ZdcZp/C69Loj9RlquTB2q2CyJmTfgONUqLkYZJUNbGt9SlRbr5nO84
         kt2vPssGXCIICk71/OEuY4ds+bgJkM/tL/mWCYVr2ZSY5WTIZEXnHK9Pv0HAVcfVlR3J
         amgVxfzDNUuaNretqjO8b66xWQsr1q/M1SzsYf4a17/hSY7a8zuSIYnl/AcbiBBvWqdM
         oRhqIRGNQv1eifuYDmc/iJEYVVbShpA5HPFjsm0/UULCzp7YKmzqX5+E0c69+maKZ5lY
         nOeA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784648243; x=1785253043;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=lePK3aUOROHNA3Mxb8ZHhUYvtbwzgB3FkuR9oqw9z+0=;
        b=UfO4maDf2a6cOpz69vVkNnAsdSxsAJ7ygeY3Y0uZyfINyiwcADgjNciseI8daj6Fio
         J9w0Q5c/stKuyhnziQ3UBagGAqAmX/XT7PQ6BIQipWkU5UeI2KZbpY9zn4TKqCLQvvzW
         tSJLYQda1AG5bzpfciz6gPmR/bsPqFWx7mV6BmQG6JYZZMhPuAc1teVulDj6CPdpRsor
         pba17Lth8exa/lFurWjAZ/6XzWscQDy/KeX9Y5jErNK7raQaAsdWA/ahQL9b9JSVHswb
         jcTgJQPCJc2RzWyXH2c0guskBkAC6QGaet9G5sDiYjGMYNYsPFn4cMqEufouZygYbghN
         EJpA==
X-Forwarded-Encrypted: i=1; AHgh+RrNtKoDw1/BSvVmdCiJ77SKF7/EQE2iuEDhFzPEFwRNx9MMsy4xEDrgbjBH24Jq3ofuoi/Y/II=@vger.kernel.org
X-Gm-Message-State: AOJu0YwDgjfUxujUScWlL6sSGwlxBuozE+XTAsLF/RxMcvn9v/M9DMKZ
	zDUnpLyOzkOvyT916yvcXMfpq1eG1iWyUtHUzVH+BWBlnr2v+Fn+yJjvWLrP9/ZhstDv5KO9IRR
	xqrlFEQtH1ydVl3JINRWkqD8q6c/04SOYZSUM9f+1
X-Gm-Gg: AfdE7clAZ6/+XAS0Qe9KXfzmZrx+3vei/TEH6hthgAg3PGTC9JPzu5nrv6K3yh722dr
	DTyU1/XEyMWAGhSLH14M/boq15jBxU6pU2PdtJC/u4nsUhXzc6VkRjwX4Z3O+ABgXMMen8C7Jnn
	Az5mlZ7MIMIEJyUWhkNHFFNWqtK721MEel2wboZmYWXnc6Zf8H+GKYnu8q5Rhl+ZaCKExVpexBh
	Lzv+bL2REPfvs7TvULvPu0mFjC9yZ5HvdYrZ4xmsPJe4uxXGzXHRpZ86C2p6kjt4tnbxJkcMul2
	wmyTFo9PUirNh/hbz0tFGjMrK0yfhxDWFPksBQ/GIkwoq7VeXt3tZv/KfE/H8izz5iH8hvI/oQ=
	=
X-Received: by 2002:a05:622a:11cf:b0:517:61d5:2f7b with SMTP id
 d75a77b69052e-5213e28e1c4mr178649641cf.56.1784648241853; Tue, 21 Jul 2026
 08:37:21 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260720135132.3957146-1-edumazet@google.com>
In-Reply-To: <20260720135132.3957146-1-edumazet@google.com>
From: Eric Dumazet <edumazet@google.com>
Date: Tue, 21 Jul 2026 17:37:10 +0200
X-Gm-Features: AUfX_mycCQ3lI7T05ph6-bT8dwM6bGbwo8ZivA5ulrn6TsafLZ58xKvlxuAhGxI
Message-ID: <CANn89iJqUFZYLYuhCk4htc8zxbW3hPSmuvYj3X_7vFyRsa5vBw@mail.gmail.com>
Subject: Re: [PATCH v2 net] gre: fix ERSPAN o_flags race/corruption in xmit
 and fill_info
To: "David S . Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>
Cc: Simon Horman <horms@kernel.org>, Ido Schimmel <idosch@nvidia.com>, netdev@vger.kernel.org, 
	eric.dumazet@gmail.com, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Jul 20, 2026 at 3:51=E2=80=AFPM Eric Dumazet <edumazet@google.com> =
wrote:
>
> For IPv4 ERSPAN:
> In erspan_xmit(), the driver clears IP_TUNNEL_SEQ_BIT (for version 0)
> and IP_TUNNEL_KEY_BIT directly in the shared tunnel->parms.o_flags
> structure. Since transmit paths can run locklessly and concurrently,
> this leads to a data race.
>
> Furthermore, modifying tunnel->parms.o_flags permanently alters the
> tunnel configuration. To work around this, erspan_fill_info() (which
> reports config to userspace) was setting IP_TUNNEL_KEY_BIT back. If
> erspan_fill_info (running under RTNL) and erspan_xmit (running locklessly=
)
> race, erspan_xmit might see IP_TUNNEL_KEY_BIT set when it shouldnt,
> leading to GRE header corruption (injecting a key field into the ERSPAN
> GRE header).
>
> Fix this by:
> 1) Snapshotting tunnel->parms.o_flags onto the stack in ipgre_xmit(),
>    gre_tap_xmit(), and __gre6_xmit(), and computing the GRE header length=
 via
>    gre_calc_hlen(flags) instead of reading tunnel->tun_hlen. This elimina=
tes
>    TOCTOU races between flags, offload checks, and header length.
>    Note: Since tunnel->tun_hlen is no longer used in fast path xmit, it c=
ould be
>    removed altogether in net-next.
> 2) Using local flags in erspan_xmit(), clearing IP_TUNNEL_CSUM_BIT and
>    IP_TUNNEL_KEY_BIT (and IP_TUNNEL_SEQ_BIT for v0) before passing them t=
o
>    __gre_xmit().
> 3) Removing the racy modification of t->parms.o_flags in erspan_fill_info=
().
> 4) Forcing IP_TUNNEL_KEY_BIT in the reported flags for ERSPAN locally
>    in ipgre_fill_info().
>
> For IPv6 ERSPAN:
> ip6erspan_tunnel_xmit() was locklessly clearing IP_TUNNEL_KEY_BIT in
> t->parms.o_flags even though it does not use these flags for building
> the GRE header (it uses local flags). This permanently corrupts the
> configuration and races with ip6gre_fill_info() which reads it.
>
> Remove the redundant and racy modification.
> This should remove false sharing in a fast path.
>
> Add const qualifiers in ipgre_fill_info(), erspan_fill_info()
> and ip6gre_fill_info() to clarify that these methods are not
> supposed to write any live parameters.
>
> Fixes: 84e54fe0a5ea ("gre: introduce native tunnel support for ERSPAN")
> Fixes: ee496694b9ee ("ip_gre: do not report erspan version on GRE interfa=
ce")
> Fixes: 5a963eb61b7c ("ip6_gre: Add ERSPAN native tunnel support")
> Cc: stable@vger.kernel.org
> Signed-off-by: Eric Dumazet <edumazet@google.com>
> ---
> v2: addressed Sashiko and Ido feedback.
> v1: https://lore.kernel.org/netdev/20260615140333.3161072-1-edumazet@goog=
le.com/

Sashiko said:

<quote>
 Does this code generate malformed GRE headers for ERSPAN if the sequence b=
it
 is missing from the output flags?
 erspan_validate() permits configurations where the sequence bit is present=
 in
 the input flags but missing from the output flags. In that case, the snaps=
hot
 of the flags lacks IP_TUNNEL_SEQ_BIT.
 After clearing IP_TUNNEL_CSUM_BIT and IP_TUNNEL_KEY_BIT, if IP_TUNNEL_SEQ_=
BIT
 is also missing:
 net/ipv4/ip_gre.c:__gre_xmit() {
 ...
 gre_build_header(skb, gre_calc_hlen(flags),
 ...
 }
 gre_calc_hlen(flags) will evaluate to 4 bytes instead of the 8 bytes requi=
red
 by the ERSPAN protocol. Before this patch, the hardcoded tunnel->tun_hlen
 ensured an 8-byte header for ERSPAN.
 Could this result in structurally malformed packets being transmitted?
</quote>

What a mess.

pw-bot: cr

I will squash the following:

diff --git a/net/ipv4/ip_gre.c b/net/ipv4/ip_gre.c
index 442a2c9513e84e84013b4a6d447dd5e243428c5c..e102c378eeb5f0e6e9e6f710db1=
e05826e0fb070
100644
--- a/net/ipv4/ip_gre.c
+++ b/net/ipv4/ip_gre.c
@@ -739,11 +739,13 @@ static netdev_tx_t erspan_xmit(struct sk_buff *skb,
                                    tunnel->index,
                                    truncate, true);
                proto =3D htons(ETH_P_ERSPAN);
+               __set_bit(IP_TUNNEL_SEQ_BIT, flags);
        } else if (tunnel->erspan_ver =3D=3D 2) {
                erspan_build_header_v2(skb, ntohl(tunnel->parms.o_key),
                                       tunnel->dir, tunnel->hwid,
                                       truncate, true);
                proto =3D htons(ETH_P_ERSPAN2);
+               __set_bit(IP_TUNNEL_SEQ_BIT, flags);
        } else {
                goto free_skb;
        }
