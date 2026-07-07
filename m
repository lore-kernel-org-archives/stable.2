Received: from mail-pl1-f174.google.com (mail-pl1-f174.google.com [209.85.214.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 03BA2390C84
	for <stable@vger.kernel.org>; Tue,  7 Jul 2026 09:13:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783415629; cv=none; b=sIbSR6hEwahnQd7BOPb4wxxdBFd5WSdIF8Svros41UdPodQVWKBfKJTHk3+552gLJC9fJ+TF+R4QYES8pdngkI+Wh7F7u9Cb1SKzlHQIWxHWAyJ9qTlc6Au9DPJQhw/x+KV3LCcQtZhuPlO7wstHRQPIdVVe5XI6rKoj9GRbpKI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783415629; c=relaxed/simple;
	bh=IN3rnUdx/QJ9tTUWniQhk33tdcHEWAN8rDsusiGV/JI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=AdhgIaDQ3mBG/sKjYawQWyZyidEB3SNt3qrxZot+/JezLLeGvTnE2hqUsYUvGtjD9btfzFiFnY6hfVSpTAG+SFqyqEYqRDZte284fcyiqBCMTge8OMImN7WgddikNC38WYs6iqQiGkvpCiuAENbfQwWpt712qDQtscm4oX+G2Rk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=BF0lahuG; arc=none smtp.client-ip=209.85.214.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BF0lahuG"
Received: by mail-pl1-f174.google.com with SMTP id d9443c01a7336-2cc6dd436c6so21083705ad.2
        for <stable@vger.kernel.org>; Tue, 07 Jul 2026 02:13:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1783415627; x=1784020427; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=3ZzKVPkDUFjHWiE6AseaXJ61s34t3U4h5G25MP41TIk=;
        b=BF0lahuGsP+G5993wB0rZpAIxuKqqTc7AXZde1fPasWsa1+OoggqfuH/obZ9YYonsw
         2VwZe2T0eXlTOUqo24BRAEOGF3B1yqJY8L4NfHQirbu1HTr5WzuPw4VZufE97Dg+ZadQ
         r3HAQK5Ky8eaaIZAykxod/yECXkPF5RAM+ZFVPWh6Q8b9+ZEJ3dJu9ljEoVWxd1/n14J
         oFQKeW5URmW4FB0NB0S0rUGkc4XpKcRSgrLqRmQLexWuTf1rzn0ZEer5a3//ZciL6eDs
         xPCEqZ07Eg8XWEEJPYlw/qogO2CxjqPOsB+Z8Nuyar80pESbgKQpx7VDQgt7mioSKldP
         6lLg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783415627; x=1784020427;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=3ZzKVPkDUFjHWiE6AseaXJ61s34t3U4h5G25MP41TIk=;
        b=E737G7CZXOcMsOv42TMJjwzrsvC78pZYBNZ6Fa8Q+2ezbsi0E5EdWCWaDB8ZhqVYe6
         Yg3bo1L8Axz9G8PzR9CYVl75wkfhM/kFBXU7uCoNp6pzeakXtlaOnL9j7Z9TN2ij7Iar
         UFus/vWQZgvSN/cDUqNy1evHDDxphMbO4ayG1ZviXy/nbUzqUl0vTPgC9BbYlvjkusLw
         zfUbGNmIBdl+1L97CE7h814v5CEG+/0wY8FLCrevT3tWQl9V+9zb1XbUrszXAj0Dbgxb
         xk54Dj5JtA2oVFHdk6FkwGW/X3gGDF0CAVovamUS7EfIBBZ06nI8YF46m6XrJdAIRxUg
         BoCw==
X-Forwarded-Encrypted: i=1; AHgh+RpMxIP5jiESXd97qbMa7z89abeTWITS4jCp4Bj1nqnU+f2w25js6kLQh9n09DGsYLDmbn0WUJE=@vger.kernel.org
X-Gm-Message-State: AOJu0YzNFPzzNb6ZI5MsY3M4r3Sw2S6YXvutspX1XTGJLBUgWf2i4x+m
	VDa4Z2rgJU6KFW6BqymsxjvugJMf+wd6iqeCPtHXDii9Wygy5EfUDLe9
X-Gm-Gg: AfdE7ckv0Kz7+pW+Unpa4I4axNWN1nw2Olf0eWnDvOlgSfDwD7q8UClDpJuDN2FEvrZ
	4g7Wq4k1/XXEkXLoLu/ZE4VIkAHGQeR+isT+KfBARbhueKgMvyO49iT1xDhUEXsi+UG8t9LDiUR
	nPbJgOXrz/GH+tn5ayL+YiQkqh0wuBjqStWga2sWpgXoLqc1rWIjIhZEbv8ckX42kqxyROX67UA
	lvo1cNkUWLZnmWehL5VzIezk41dj2XkauihnhhQfSDLPOvYReKjSV6BbcwDcFYWdxxYM6fmPkAj
	/oxqmdwwS++/ZasHnZE60TKumD4cSo9RzCkTTjVB5jJehr7pXmZlWls8LDXuxlXbp9YipuUsg8b
	h+TtURuq33B50jTS3ilutBh+qNrSbV4bPJKDqujgMA5HBvhyeagT7inp0k4FKQoOgHFv5HLArQI
	y7Qr96WT0=
X-Received: by 2002:a17:902:f790:b0:2cc:dacc:fe27 with SMTP id d9443c01a7336-2ccdacd016dmr645665ad.30.1783415627151;
        Tue, 07 Jul 2026 02:13:47 -0700 (PDT)
Received: from xiaowei ([2406:da18:1aa1:6600:7a60:aa58:4b0c:e1c0])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2ccc9c100adsm8167815ad.32.2026.07.07.02.13.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 Jul 2026 02:13:46 -0700 (PDT)
Date: Tue, 7 Jul 2026 17:13:38 +0800
From: Kevin Hao <haokexin@gmail.com>
To: christian.taedcke@weidmueller.com
Cc: christian.taedcke-oss@weidmueller.com,
	=?iso-8859-1?Q?Th=E9o?= Lebrun <theo.lebrun@bootlin.com>,
	Conor Dooley <conor.dooley@microchip.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
	Clark Williams <clrkwllms@kernel.org>,
	Steven Rostedt <rostedt@goodmis.org>,
	Robert Hancock <robert.hancock@calian.com>, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-rt-devel@lists.linux.dev,
	stable@vger.kernel.org
Subject: Re: [PATCH net 1/2] net: macb: reprogram TBQP after shuffling the TX
 ring on link-up
Message-ID: <akzDQrmdYwHAMMmw@xiaowei>
References: <20260706-upstreaming-macb-irq-storm-v1-0-ab3115b5a13a@weidmueller.com>
 <20260706-upstreaming-macb-irq-storm-v1-1-ab3115b5a13a@weidmueller.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="NDb1+SKKlMxGRi/m"
Content-Disposition: inline
In-Reply-To: <20260706-upstreaming-macb-irq-storm-v1-1-ab3115b5a13a@weidmueller.com>


--NDb1+SKKlMxGRi/m
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Jul 06, 2026 at 04:02:14PM +0200, Christian Taedcke via B4 Relay wr=
ote:
> From: Christian Taedcke <christian.taedcke@weidmueller.com>
>=20
> gem_shuffle_tx_one_ring() rotates the software TX ring so that the
> tail sits at index 0 and resets queue->tx_tail to 0, but it never
> reprograms the hardware transmit buffer queue pointer (TBQP). Other
> paths that reset tx_tail to the ring base (macb_init_buffers() and
> macb_tx_error_task()) also reprogram TBQP to queue->tx_ring_dma; this
> path does not, leaving TBQP pointing at a stale descriptor.
>=20
> gem_shuffle_tx_rings() runs on every link-up from
> macb_mac_link_up(). After a few link up/down flaps that leave
> un-completed descriptors in the ring, the stale TBQP keeps pointing at
> a descriptor whose used bit is set. When TX is re-enabled on link-up,
> the GEM reads that used descriptor and raises TXUBR. macb_interrupt()
> schedules the TX NAPI, macb_tx_poll() makes no progress (work_done =3D=3D
> 0) and macb_tx_restart() re-issues TSTART, which makes the controller
> read the same used descriptor again and re-assert TXUBR. As the MAC
> interrupt is level-triggered, it never deasserts and one CPU is pegged
> at 100% in the threaded handler, eventually triggering "sched: RT
> throttling activated" and a dead network interface.
>=20
> Fix it by reprogramming TBQP to the ring base on every path of
> gem_shuffle_tx_one_ring() that resets tx_tail to 0, mirroring
> macb_tx_error_task(). The early return for an already-aligned tail is
> left untouched as TBQP is already consistent there. This is safe
> because the shuffle runs from macb_mac_link_up() while TE is still
> disabled, so the transmitter is halted.
>=20
> Fixes: 881a0263d502 ("net: macb: Shuffle the tx ring before enabling tx")
> Cc: stable@vger.kernel.org
> Assisted-by: Claude:claude-opus-4-8
> Signed-off-by: Christian Taedcke <christian.taedcke@weidmueller.com>
> ---
>  drivers/net/ethernet/cadence/macb_main.c | 9 ++++++++-
>  1 file changed, 8 insertions(+), 1 deletion(-)
>=20
> diff --git a/drivers/net/ethernet/cadence/macb_main.c b/drivers/net/ether=
net/cadence/macb_main.c
> index fd282a1700fb..b11cb8f068b7 100644
> --- a/drivers/net/ethernet/cadence/macb_main.c
> +++ b/drivers/net/ethernet/cadence/macb_main.c
> @@ -820,7 +820,7 @@ static void gem_shuffle_tx_one_ring(struct macb_queue=
 *queue)
>  	if (!count) {
>  		queue->tx_head =3D 0;
>  		queue->tx_tail =3D 0;
> -		goto unlock;
> +		goto reset_hw_ptr;
>  	}
> =20
>  	shift =3D tail % ring_size;
> @@ -869,6 +869,13 @@ static void gem_shuffle_tx_one_ring(struct macb_queu=
e *queue)
>  	/* Make descriptor updates visible to hardware */
>  	wmb();
> =20
> +reset_hw_ptr:
> +	/* tx_tail was reset to the ring base, so TBQP must be reprogrammed
> +	 * to match; otherwise it keeps pointing at a stale descriptor. Safe
> +	 * to write directly here as TX is still disabled (called from
> +	 * macb_mac_link_up() before TE is set).
> +	 */

Could you elaborate on why we need to reprogram the TBQP here? Based on my
understanding, the transmit-buffer queue pointer automatically resets to the
value of TBQP when TX is disabled. The following is quoted from the Zynq
UltraScale TRM [1]:
  While transmit is disabled, bit [3] of the network control is
  set Low, the transmit-buffer queue pointer resets to point to the address=
 indicated by the
  transmit-buffer queue base address register. Disabling receive does not h=
ave the same
  effect on the receive-buffer queue pointer.

[1] https://docs.amd.com/v/u/en-US/ug1085-zynq-ultrascale-trm

Thanks,
Kevin

> +	queue_writel(queue, TBQP, lower_32_bits(queue->tx_ring_dma));
>  unlock:
>  	spin_unlock_irqrestore(&queue->tx_ptr_lock, flags);
>  }
>=20
> --=20
> 2.54.0
>=20
>=20

--NDb1+SKKlMxGRi/m
Content-Type: application/pgp-signature; name=signature.asc

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCgAdFiEEHc6qFoLCZqgJD98Zk1jtMN6usXEFAmpMw0EACgkQk1jtMN6u
sXFKuwf/eTcO0PsGfR3477cVoSGkyYKAr7uk3TUnIpXDtesNZNlFvS3NQCuzYKuF
WCCLByw6cPcu+N86dZUiaaNDAzKQl2v6D3eL8sgOEa3TIFemYcVOW0FOrrYNoWxO
g9woZQguWKXkekrGrcTg9teWqCdFRwspZfZZxW5DAJVaacOW1As4Yre/i4dNeBL/
j+02Z0TMji6q5z9H5QH/BmBQqx7oHDR4hjrQv00yxY9lf05LOhi3s3spWInhvgZD
ONZs1FsZwnQeMYYnUu9SZohTSpk2aLv0T66b2k1Ybel4WMaZq9vDBR4DWdCkwr3l
BdFPsNA9io8VvXRctioGwNmU3dHgxQ==
=kMC1
-----END PGP SIGNATURE-----

--NDb1+SKKlMxGRi/m--
