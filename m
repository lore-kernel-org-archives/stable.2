Received: from mx1.white.stw.pengutronix.de (mx1.white.stw.pengutronix.de [185.203.200.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 723EA54281E;
	Thu, 15 Oct 2026 19:09:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=185.203.200.13
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792091403; cv=pass; b=GafoINbtclYAdoNybp0GvspdizavW0QDSLirc7PSHFdz1kW4eCJ5fFzSPHwd6cOirALSUyBFjy1ySpDBFlx4Jr9+UcMIwGkfmir1pb4klNDMUDB0DM3nHYdCxK9EGZfJG6pJJKIcMMbi6k8YSc3viVgDJf8f/vsS46XXxKueYzk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792091403; c=relaxed/simple;
	bh=AJOok54pYTMNQTN2gZ/M0PvND6SQyAFOTWYhc1wPdA8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=hn90WhUVwEG1SuzcFVZ+YwyCr4KXrjuGIi2jyevrOYBCoiK0zY/sTL8fZzFgR5BjEWVdPVYJVGiWF9/uEYFNH0B01/lfu8nteBuenWURAZ+oRexH9BhB+bBtdqVNcUYgvaFYOBHd7UU1y51jdBFvNbC5qvmpBWcatlMNYYzhQm4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; dkim=pass (2048-bit key) header.d=pengutronix.de header.i=@pengutronix.de header.b=TZ41r0/R; arc=pass smtp.client-ip=185.203.200.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pengutronix.de header.i=@pengutronix.de header.b="TZ41r0/R"
Received: from drehscheibe.grey.stw.pengutronix.de (drehscheibe.grey.stw.pengutronix.de [IPv6:2a0a:edc0:0:c01:1d::a2])
	(Authenticated sender: relay-from-drehscheibe.grey.stw.pengutronix.de)
	by mx1.white.stw.pengutronix.de (Postfix) with ESMTPSA id F3D9F202601;
	Thu, 15 Oct 2026 21:09:52 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pengutronix.de;
	s=20260414; t=1792091393;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=tvhrR4AzEPkFGEWFPJAW4hmuI8DkmcdRFX0ErXIxci0=;
	b=TZ41r0/RfH5UlAZx0rmjnuvPaZs8umJfa2UmyGcE6RbeWvuxpZG++yJx5VTKwKrKTcFeTX
	M8/eIvQ0mBPkQw8wt8/Fbh7SbX4dg26uB1Bgy2W/XVpj5bLnlz9W8O0mx8MDK3R/F6Lx0/
	PPa+MUZhSAYwZgyJ+fWXP9TtkxYT7BX8f+nJtqh6VL1ApM/vHTA0wJYDgHUCqwNq7IabIZ
	FjMcZoq0tjSYeCBwPYmiTrWyZpt5bAxyoRmaXhGk09Cngz3NlDeofCfAdiHRGHf3usV167
	Tc5Oz3GNvrrfcuJkgxWtc/mFUE4l5A7cdM3myGGjb7h6CLJHY8mV4O1Zt4+hPw==
ARC-Seal: i=1; s=20260414; d=pengutronix.de; t=1792091393; a=rsa-sha256;
	cv=none;
	b=bw5TsKZqdfHKjZ7hfoL67E3JZuvYdb6w158Urw397bGW7yY4V+3/BqPIr72UfXtviRWspw
	Y9L3levRBBrqThTkS1zVE2gcJse/pPld4O6AUXU3ziaD/a7Hgbmj6x16+A3GmacPFD7TrA
	EPI3q0wybXZNPcsWCvjH/UUbA1BxcYuaBJ8kcMOaXT1iWrzwg07s04PyfmnjxHTctk6++N
	7n6N4GIsn/dJKhDP26mHYjW5ItzaCwciVjOZKw7OGG5n20okAA2784hEKSaCFNHFkgtysD
	Y0zL4Y799A5MP2yWhFycVXIilvyi4qYSm5aHPqyIfvY2PcHDXuSI1xo95o/ebA==
ARC-Authentication-Results: i=1;
	ORIGINATING;
	auth=pass smtp.auth=relay-from-drehscheibe.grey.stw.pengutronix.de smtp.mailfrom=mkl@pengutronix.de
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=pengutronix.de;
	s=20260414; t=1792091393;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=tvhrR4AzEPkFGEWFPJAW4hmuI8DkmcdRFX0ErXIxci0=;
	b=AQ4y88o1vaOkAxEbzWchvxyy2rPhAYBRIvv3lTd3sSGHaw5XsXuNeXNpAFl2qrwJ/dg5/n
	CPISMLg/xH06vuQ5it30NIIuzg3wFmTI5akJXEBxVGs7v9p11EDjMmyc43Sy7ZS4dMlEv7
	gYumHTR4Anc+uaAR1o8kF4kmC1xMehGJZwUyJ2qQsy2/valDfwtU9ZsmnZBLsJH7gtm5uL
	s3n6WeS9RQyBtNmD+eUOBdFT6iKfkuNGXEtV+Xm8Ny4Ms+2WokD7tdF2wZtx/RrcoIyvD7
	0S3Lr2gO5XnNikZ9LnrhqDAutYK+j/u63LbzszZBmY8crMT7klSkN/7P8Lhb+A==
Received: from moin.white.stw.pengutronix.de ([2a0a:edc0:0:b01:1d::7b] helo=bjornoya.blackshift.org)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <mkl@pengutronix.de>)
	id 1xHQps-0064FG-2o;
	Thu, 15 Oct 2026 21:09:52 +0200
Received: from pengutronix.de (p4ffb23c7.dip0.t-ipconnect.de [79.251.35.199])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(Client did not present a certificate)
	(Authenticated sender: mkl-all@blackshift.org)
	by smtp.blackshift.org (Postfix) with ESMTPSA id 806AD5C563B;
	Thu, 15 Oct 2026 19:09:52 +0000 (UTC)
Date: Thu, 15 Oct 2026 21:09:52 +0200
From: Marc Kleine-Budde <mkl@pengutronix.de>
To: netdev-bot+sashiko@kernel.org
Cc: 1579567540@qq.com, mailhol@kernel.org, heiko@sntech.de, 
	davem@davemloft.net, wg@grandegger.com, socketcan@hartkopp.net, kernel@pengutronix.de, 
	linux-can@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-arm-kernel@lists.infradead.org, linux-rockchip@lists.infradead.org, stable@vger.kernel.org, 
	kuba@kernel.org
Subject: Re: [PATCH net v2 1/3] can: dev: prevent bus-off recovery when the
 interface is not running
Message-ID: <20261015-ludicrous-super-serval-d6772d-mkl@pengutronix.de>
References: <tencent_196A2433801631CD2FA42998465E26316105@qq.com>
 <179208227237.1406898.11528789185033827404@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="gcamumrzud2sotcr"
Content-Disposition: inline
In-Reply-To: <179208227237.1406898.11528789185033827404@kernel.org>


--gcamumrzud2sotcr
Content-Type: text/plain; protected-headers=v1; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: Re: [PATCH net v2 1/3] can: dev: prevent bus-off recovery when the
 interface is not running
MIME-Version: 1.0

Hello,

there was a hickup with the sashiko bot.

It seems the review for patch:

| https://lore.kernel.org/all/20261014-stmmac-rx-mb-v7-2-5d2d70f052cd@oss.q=
ualcomm.com/

was send to as a rely to this patch:

| https://lore.kernel.org/all/tencent_196A2433801631CD2FA42998465E26316105@=
qq.com/

regards,
Marc

On 15.10.2026 16:37:52, netdev-bot+sashiko@kernel.org wrote:
> Thank you for your contribution! Sashiko AI review found 1 potential
> issue(s) to consider.
>
> Critical: 0 =C2=B7 High: 0 (1) =C2=B7 Medium: 1 (1) =C2=B7 Low: 0
>
> If you believe none of the issues are legitimate, please reply to each
> issue of Medium severity or higher and explain why the AI is wrong.
> If any of them are legitimate and you plan to respin, please let patchwork
> know by including "pw-bot: cr" as a separate line at the end of your reply
> (one such reply per series is enough).
>
> - [Medium] Split-frame drop accounting in stmmac_rx_zc() is inconsistent
>   per frame and per core.
>
> Pre-existing issues:
> - [High] stmmac_dispatch_skb_zc() (stmmac_main.c:5533) sets
>   `skb->ip_summed =3D CHECKSUM_UNNECESSARY` for every IP frame when RX CO=
E=E2=80=A6
> - [Medium] priv->xstats.rx_dropped and priv->xstats.rx_errors are device-
>   wide unsigned longs.
>
> --
>
> net: stmmac: drop split frames on AF_XDP zero-copy RX
>
> This patch fixes stmmac_rx_zc() so that split frames are drained as
> errored, and the last fragment is no longer handed to XDP as a fresh
> frame. It also changes the legacy normal and enhanced descriptor
> callbacks to report rx_not_ls together with discard_frame for non-last
> descriptors.
>
> > diff --git a/drivers/net/ethernet/stmicro/stmmac/enh_desc.c b/drivers/n=
et/ethernet/stmicro/stmmac/enh_desc.c
> > index 0512536012251..297e2428a8f9b 100644
> > --- a/drivers/net/ethernet/stmicro/stmmac/enh_desc.c
> > +++ b/drivers/net/ethernet/stmicro/stmmac/enh_desc.c
> > @@ -184,7 +184,7 @@ static int enh_desc_get_rx_status(struct stmmac_ext=
ra_stats *x,
> >
> >  	if (unlikely(!(rdes0 & RDES0_LAST_DESCRIPTOR))) {
> >  		x->rx_length++;
> > -		return discard_frame;
> > +		return discard_frame | rx_not_ls;
> >  	}
> >
> >  	if (unlikely(rdes0 & RDES0_ERROR_SUMMARY)) {
> > diff --git a/drivers/net/ethernet/stmicro/stmmac/norm_desc.c b/drivers/=
net/ethernet/stmicro/stmmac/norm_desc.c
> > index c4b613564f87c..d19bf7ca4db38 100644
> > --- a/drivers/net/ethernet/stmicro/stmmac/norm_desc.c
> > +++ b/drivers/net/ethernet/stmicro/stmmac/norm_desc.c
> > @@ -70,7 +70,7 @@ static int ndesc_get_rx_status(struct stmmac_extra_st=
ats *x,
> >
> >  	if (unlikely(!(rdes0 & RDES0_LAST_DESCRIPTOR))) {
> >  		x->rx_length++;
> > -		return discard_frame;
> > +		return discard_frame | rx_not_ls;
> >  	}
> >
> >  	if (unlikely(rdes0 & RDES0_ERROR_SUMMARY)) {
> > diff --git a/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c b/driver=
s/net/ethernet/stmicro/stmmac/stmmac_main.c
> > index f0835be2f65a7..10ea72cbf889a 100644
> > --- a/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
> > +++ b/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
> > @@ -5695,18 +5695,21 @@ static int stmmac_rx_zc(struct stmmac_priv *pri=
v, int limit, u32 queue)
> >  		if (priv->extend_desc)
> >  			stmmac_rx_extended_status(priv, &priv->xstats,
> >  						  rx_q->dma_erx + entry);
> > -		if (unlikely(status =3D=3D discard_frame)) {
> > -			xsk_buff_free(buf->xdp);
> > -			buf->xdp =3D NULL;
> > -			dirty++;
> > +
> > +		if (unlikely(status & discard_frame)) {
> >  			error =3D 1;
> >  			if (!priv->hwts_rx_en)
> >  				rx_errors++;
> >  		}
> >
> > -		if (unlikely(error && (status & rx_not_ls)))
> > -			goto read_again;
> >  		if (unlikely(error)) {
> > +			xsk_buff_free(buf->xdp);
> > +			buf->xdp =3D NULL;
> > +			dirty++;
> > +
> > +			if (status & rx_not_ls)
> > +				goto read_again;
> > +
> >  			count++;
> >  			continue;
> >  		}
> > @@ -5715,8 +5718,9 @@ static int stmmac_rx_zc(struct stmmac_priv *priv,=
 int limit, u32 queue)
> >  		if (likely(status & rx_not_ls)) {
> >  			xsk_buff_free(buf->xdp);
> >  			buf->xdp =3D NULL;
> > +			rx_dropped++;
> > +			error =3D 1;
>
> [Severity: Medium]
>
> Is the split-frame drop accounting here consistent across descriptor
> formats?
>
> The legacy callbacks now return discard_frame | rx_not_ls for every
> non-last descriptor. So the discard branch above runs first for each of
> those descriptors, and there is no !error guard:
>
>     if (unlikely(status & discard_frame)) {
>         error =3D 1;
>         if (!priv->hwts_rx_en)
>             rx_errors++;
>     }
>
> On dwmac100/dwmac1000, a frame spanning N descriptors would then add N-1
> to rx_errors. It adds 0 to rx_dropped, while count / rx_pkt_n goes up
> only once for the frame. The new rx_dropped++ in this 1:1 block can never
> be reached on those cores.
>
> On dwmac4 (and similarly xgmac), dwmac4_wrback_get_rx_status() returns a
> bare rx_not_ls for non-last descriptors:
>
> 	if (likely(!(rdes3 & RDES3_LAST_DESCRIPTOR)))
> 		return rx_not_ls;
>
> That means this block does rx_dropped++ and sets error =3D 1. If the last
> descriptor has RDES3_ERROR_SUMMARY set, the discard branch also does
> rx_errors++. The same dropped frame then shows up in both rx_dropped and
> rx_errors.
>
> Later in the series, stmmac_rx() is changed to count only once, using
> (!error && (status & discard_frame)). Should stmmac_rx_zc() get the same
> treatment, so each dropped frame is counted once in either rx_errors or
> rx_dropped?
>
> >  			dirty++;
> > -			count++;
> >  			goto read_again;
> >  		}
> >
>
> [Severity: Medium]
>
> This is a pre-existing issue and was not introduced by this patch. The
> new rx_dropped++ feeds into an unsynchronized accumulation at the end of
> stmmac_rx_zc():
>
> 	priv->xstats.rx_dropped +=3D rx_dropped;
> 	priv->xstats.rx_errors +=3D rx_errors;
>
> These are device-wide unsigned longs. They are updated with a plain +=3D
> from per-queue NAPI contexts that can run at the same time on different
> CPUs. stmmac_rx() does the same thing, and stmmac_get_stats64() reads
> them without any locking.
>
> Can concurrent NAPI polls on different queues lose increments to these
> counters?
>
> [Severity: High]
>
> This isn't a bug introduced by this patch, but it is in the same receive
> path. On XDP_PASS, stmmac_rx_zc() calls stmmac_dispatch_skb_zc() without
> passing status. That function marks every IP frame as verified when RX
> COE is enabled:
>
> stmmac_dispatch_skb_zc() {
>     ...
> 	if (unlikely(!coe) || !stmmac_has_ip_ethertype(skb))
> 		skb_checksum_none_assert(skb);
> 	else
> 		skb->ip_summed =3D CHECKSUM_UNNECESSARY;
>     ...
> }
>
> On dwmac4, dwmac4_wrback_get_rx_status() reports L4 payload checksum
> failures only as csum_none, without discard_frame:
>
> 	if (rdes1 & RDES1_IP_PAYLOAD_ERROR) {
> 		x->ip_payload_err++;
> 		ret |=3D csum_none;
> 	}
>
> Also, dwmac4_dma_rx_chan_op_mode() sets MTL_OP_MODE_DIS_TCP_EF, so the
> hardware forwards these frames instead of dropping them.
>
> Suppose a frame with a bad TCP/UDP checksum arrives on a ZC queue and
> the XDP program passes it. Could it reach the stack as
> CHECKSUM_UNNECESSARY and hand corrupted payload to applications?
>
> The non-ZC stmmac_rx() handles this case:
>
> 	if (unlikely(!coe) || !stmmac_has_ip_ethertype(skb) ||
> 	    (status & csum_none))
> 		skb_checksum_none_assert(skb);
>
> This still seems to be the case at the end of the series.
>
> [ ... ]
>
> --
> Sashiko AI review =C2=B7 https://netdev-ai.bots.linux.dev/sashiko/#/patch=
set/tencent_196A2433801631CD2FA42998465E26316105%40qq.com
>
>

--
Pengutronix e.K.                 | Marc Kleine-Budde          |
Embedded Linux                   | https://www.pengutronix.de |
Vertretung N=C3=BCrnberg              | Phone: +49-5121-206917-129 |
Amtsgericht Hildesheim, HRA 2686 | Fax:   +49-5121-206917-9   |

--gcamumrzud2sotcr
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQSl+MghEFFAdY3pYJLMOmT6rpmt0gUCatEk/QAKCRDMOmT6rpmt
0nybAQCej263C6T9rh/9UccPY7pYee0u3sO3irOlbWtPJsBGIgEAjfoTn5FNQD/G
hHwfj9aK27M4N1i6C6vWzMMB74QylQM=
=WKVh
-----END PGP SIGNATURE-----

--gcamumrzud2sotcr--
