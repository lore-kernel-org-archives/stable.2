Received: from mail.toke.dk (mail.toke.dk [45.145.95.4])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 77F4D4D1799;
	Mon, 28 Sep 2026 13:49:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.145.95.4
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790603345; cv=none; b=TiPsRAgakRoNncoSEUeYRaglvwTsxL+Sg+YdoW2OrfIFZwhuc4VtexuOugNOd0k3Nq2PQDNnxK6Lvng+ru6FZ9GpYsKr/V+FXFdR1lUFzLVlXqMXPoOVH8g2Fv9Xs4SJg6aohUa07uJb/C+l926OP/mA0uZdWfabOv26zcCL0nk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790603345; c=relaxed/simple;
	bh=XJoluPe8klrmOrQuwGDVDDIEwvnsLYAmbcH38lTrp8M=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=HW18YqTEhsrThUDzOhoCo1cDNlG0z9RmObcx08tuIzuZDwmZ22tHnR0mP39Kf5v1umUox/lvE2Q9Iv9i20G6whw7GlctOhaSu+0GhLw5oRHyrbwFRuPa47H/CBWH+xAE5K9qWoL+nigqfLqi6uf5u1tXaoD0Oho/2LEJJL6hpg4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=toke.dk; spf=pass smtp.mailfrom=toke.dk; arc=none smtp.client-ip=45.145.95.4
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=toke.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=toke.dk
Authentication-Results: mail.toke.dk; dkim=none
From: Toke =?utf-8?Q?H=C3=B8iland-J=C3=B8rgensen?= <toke@toke.dk>
To: Yuchao Zhang <ndaugoing@gmail.com>, "David S . Miller"
 <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Jakub Kicinski
 <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>
Cc: Simon Horman <horms@kernel.org>, Jamal Hadi Salim <jhs@mojatatu.com>,
 Jiri Pirko <jiri@resnulli.us>, cake@lists.bufferbloat.net,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
 stable@vger.kernel.org, Yuchao Zhang <ndaugoing@gmail.com>
Subject: Re: [PATCH net v3 1/2] net/sched: sch_cake: fix shaper stall on
 segs == 0 in cake_overhead()
In-Reply-To: <20260927131009.24250-2-ndaugoing@gmail.com>
References: <20260927131009.24250-1-ndaugoing@gmail.com>
 <20260927131009.24250-2-ndaugoing@gmail.com>
Date: Mon, 28 Sep 2026 14:30:39 +0200
X-Clacks-Overhead: GNU Terry Pratchett
Message-ID: <877bk5lfrk.fsf@toke.dk>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Yuchao Zhang <ndaugoing@gmail.com> writes:

> In cake_overhead(), packets with a single segment bypass multi-segment
> overhead calculations:
>
> 	if (segs =3D=3D 1)
> 		return cake_calc_overhead(q, len, off);
>
> Commit c5d34f4583ea ("net_sched: cake: use qdisc_pkt_segs()") switched
> cake to retrieve the cached segmentation count via qdisc_pkt_segs(skb)
> instead of calculating it locally for dodgy GSO packets. If an skb with
> segs =3D=3D 0 reaches cake_overhead(), it skips the segs =3D=3D 1 early r=
eturn
> and enters the multi-segment arithmetic:
>
> 	len =3D shinfo->gso_size + hdr_len;
> 	last_len =3D skb->len - shinfo->gso_size * (segs - 1);
>
> 	return (cake_calc_overhead(q, len, off) * (segs - 1) +
> 		cake_calc_overhead(q, last_len, off));
>
> Because segs is an unsigned 16-bit integer, (segs - 1) underflows to
> 65535 (and is promoted to 4294967295 in the 32-bit unsigned arithmetic
> above). This multiplies the per-segment overhead by UINT32_MAX, so
> cake_overhead() returns a length close to 4.29 GB. cake_advance_shaper()
> then charges that length to the shaper, stalling the CAKE dequeue path
> for tens of seconds at 1 Gbit/s, and for minutes to hours at lower rates.
>
> Fix this by returning early with cake_calc_overhead(q, len, off) whenever
> segs <=3D 1.
>
> Fixes: c5d34f4583ea ("net_sched: cake: use qdisc_pkt_segs()")
> Cc: stable@vger.kernel.org
> Signed-off-by: Yuchao Zhang <ndaugoing@gmail.com>

Acked-by: Toke H=C3=B8iland-J=C3=B8rgensen <toke@toke.dk>
