Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793692842;
	b=04tfi/HirlCmlp4hj6k0CdcyeyPBanz7gGLFhf+TtockgfP/aOr22IczgK3sZR0r1hH4
	 FpsmCtogt6EQ5tInWUQDsOaOCbT4+xo1VY5gPL3YbJwqSAnW+OJtxGs6FWLrvT4O360uy
	 vWP1p7Cz6ok1QUI3A0Blg2feGrBK3eFeNS+K//UfucjJwZb/ZM9DMFq70wsRAN7Dt6Vd2
	 gFFRQ1ZnuAGPO4oFRMqsYPBXZaqyo6Q/Yk7LzgZNTBHglLAeNWge7zCNc2VZywtImEf9k
	 udzHjWw7Ul6JJuh48S1ZxS91ELLXncaS2hgCdbFmLiiYyYDZOleDrOKs+Cxf5yFaRlA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793692842;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 References:MIME-Version:Content-Type:Content-Disposition:In-Reply-To;
	bh=o2eLsx/nGvouTivFiSiDQKL17S34wwlYhifrcocAVCA=;
	b=JBNsBo5H/JOv15vmSxF9hRINqoRcv4YqCGON8JeXIOJBLz9kI/LOgU5MWfabLkcDwPfF
	 1Ro/k2iZNcID0gDHPpEsWY6opKjEjZgUzETrUkvOgn2LnNpC8ccu34VMij2VcdOOAN/Ef
	 xNhwKQoj6ACVuGtIUR61sZhoSElDrivsenm88vfs5DlxD4K2Lojtavhi9ETh29DUPXICL
	 MrIOoqmIgBV3Ep/UnHUh+Cm29o5VKd0OCxhQwXd9U7PNvyVpI/ZBNQlUUXkoE5KEE6wwF
	 0nzu/hJHgIqj4d/IE4n8UJLZInLmAwV3Oxa1dkCBhcYEmYYX7L7EW+m/5uF7HTKirKg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=g9in8RL5;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 05870606A324;
	Tue,  3 Nov 2026 08:00:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=g9in8RL5
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 03EA31F0093A;
	Tue,  3 Nov 2026 08:00:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793692841;
	bh=o2eLsx/nGvouTivFiSiDQKL17S34wwlYhifrcocAVCA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=g9in8RL56728oCnq6IV1kW+ddzlj4UsjLU4X6ShtIkiT2A5P6x7jvMcWBvRmWiQbx
	 lTwHxTIr4GM2WexHy96Tc9t5+6AeFgQL/O1J/EPKo1K6Ppj+nfEPZkrom7LpXckGJk
	 mAPGT7JzlRDLJT8bu3ngfPMcIlAno5MBOxrBkmHYI/ivJCZjHSZN/6+SLsgUSRYu7w
	 4G6wuW2C/mqHMmdF548D9FaaFVDXKjoSfYb1o81hnDcDHjYEPUKwiWAr6pGGsq1BbW
	 d3AkGCxgP5BggMhR43Q6OJ2mOmDilWS5gy+9ta5yLCMMTDrGSMMOLY/63ZNT2dOunk
	 xDHwsIzVuUZ2g==
Date: Tue, 3 Nov 2026 09:00:18 +0100
From: Joel Granados <joel.granados@kernel.org>
To: Jiayuan Chen <jiayuan.chen@linux.dev>
Cc: netdev@vger.kernel.org, stable@vger.kernel.org, 
	"David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@kernel.org>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, 
	Jonathan Corbet <corbet@lwn.net>, Shuah Khan <skhan@linuxfoundation.org>, 
	Randy Dunlap <rdunlap@infradead.org>, David Ahern <dsahern@kernel.org>, 
	Ido Schimmel <idosch@nvidia.com>, Thomas Gleixner <tglx@kernel.org>, 
	Petr Pavlu <petr.pavlu@suse.com>, Kuniyuki Iwashima <kuniyu@google.com>, 
	Fernando Fernandez Mancera <fmancera@suse.de>, Willem de Bruijn <willemb@google.com>, 
	Maoyi Xie <maoyi.xie@ntu.edu.sg>, Gerd Rausch <gerd.rausch@oracle.com>, 
	Zhan Xusheng <zhanxusheng1024@gmail.com>, Oleg Nesterov <oleg@redhat.com>, 
	Chia-Yu Chang <chia-yu.chang@nokia-bell-labs.com>, Yung Chih Su <yuuchihsu@gmail.com>, 
	Wyatt Feng <bronzed_45_vested@icloud.com>, Hannes Frederic Sowa <hannes@stressinduktion.org>, 
	Flavio Leitner <fbl@redhat.com>, Petr Mladek <pmladek@suse.com>, 
	"Paul E. McKenney" <paulmck@kernel.org>, linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH net v2 5/5] net: restrict message_cost and message_burst
 to non-negative values
Message-ID: <aumTvqiaDRTd9rlY@hobbes>
References: <20261027104701.296240-1-jiayuan.chen@linux.dev>
 <20261027104701.296240-6-jiayuan.chen@linux.dev>
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="kbkkqf6zqumhyeya"
Content-Disposition: inline
In-Reply-To: <20261027104701.296240-6-jiayuan.chen@linux.dev>


--kbkkqf6zqumhyeya
Content-Type: text/plain; protected-headers=v1; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: Re: [PATCH net v2 5/5] net: restrict message_cost and message_burst
 to non-negative values
MIME-Version: 1.0

On Tue, Oct 27, 2026 at 06:45:33PM +0800, Jiayuan Chen wrote:
> net.core.message_cost and net.core.message_burst feed the interval and
> burst of net_ratelimit_state, but neither rejects negative values:
> message_burst uses plain proc_dointvec, and message_cost uses
> proc_dointvec_jiffies, which happily stores -1 second as -HZ jiffies.
>=20
> Since commit a940d145cc38 ("ratelimit: Warn if ->interval or ->burst are
> negative"), ___ratelimit() splats on such values, so the next
> net_ratelimit() caller warns, e.g. a martian source log:
>=20
>   Negative interval (-250) or burst (10): Uninitialized ratelimit_state s=
tructure?
>   WARNING: lib/ratelimit.c:43 at ___ratelimit+0x56e/0x960, CPU#1: ping/32=
18
>   RIP: 0010:___ratelimit+0x578/0x960
>   Call Trace:
>    <IRQ>
>    net_ratelimit+0x1c/0x30
>    ip_handle_martian_source+0x1bb/0x340
>    ip_route_input_slow+0x1057/0x3650
>    ip_route_input_noref+0x104/0x260
>    arp_process+0x109b/0x2510
>    arp_rcv+0x381/0x460
>    __netif_receive_skb_one_core+0x173/0x1c0
>    __netif_receive_skb+0x21/0x150
>    process_backlog+0x37e/0x1200
>    __napi_poll.constprop.0+0xa5/0x5e0
>    net_rx_action+0x4c0/0xf70
>    handle_softirqs+0x204/0x9b0
>    __do_softirq+0x10/0x18
>    do_softirq.part.0+0x49/0xd0
>    </IRQ>
>=20
> Negative values never meant anything here: 0 already expresses both
> "no limit" (interval) and "suppress everything" (burst).
>=20
> Reject them at write time. message_burst can simply use
> proc_dointvec_minmax with extra1 =3D 0. proc_dointvec_jiffies has no
> minmax variant, so add proc_dointvec_jiffies_minmax(), mirroring
> proc_dointvec_ms_jiffies_minmax(), and use it for message_cost with
> extra1 =3D 0. Note that like the ms variant, extra1/extra2 are compared
> against the converted jiffies value.
>=20
> Fixes: a940d145cc38 ("ratelimit: Warn if ->interval or ->burst are negati=
ve")
> Cc: stable@vger.kernel.org
> Suggested-by: Joel Granados <joel.granados@kernel.org>
> Signed-off-by: Jiayuan Chen <jiayuan.chen@linux.dev>
> ---
>  include/linux/jiffies.h    |  2 ++
>  kernel/time/jiffies.c      | 40 ++++++++++++++++++++++++++++++++++++++
>  net/core/sysctl_net_core.c |  6 ++++--
>  3 files changed, 46 insertions(+), 2 deletions(-)
>=20
> diff --git a/include/linux/jiffies.h b/include/linux/jiffies.h
> index bbd57061802cd..de12920f8e94b 100644
> --- a/include/linux/jiffies.h
> +++ b/include/linux/jiffies.h
> @@ -646,6 +646,8 @@ extern unsigned long nsecs_to_jiffies(u64 n);
>  struct ctl_table;
>  int proc_dointvec_jiffies(const struct ctl_table *table, int dir, void *=
buffer,
>  			  size_t *lenp, loff_t *ppos);
> +int proc_dointvec_jiffies_minmax(const struct ctl_table *table, int dir,
> +				 void *buffer, size_t *lenp, loff_t *ppos);
>  int proc_dointvec_ms_jiffies_minmax(const struct ctl_table *table, int d=
ir,
>  				    void *buffer, size_t *lenp, loff_t *ppos);
>  int proc_dointvec_userhz_jiffies(const struct ctl_table *table, int dir,
> diff --git a/kernel/time/jiffies.c b/kernel/time/jiffies.c
> index 9b3487d40cd6a..22a70caa58bc1 100644
> --- a/kernel/time/jiffies.c
> +++ b/kernel/time/jiffies.c
> @@ -165,6 +165,14 @@ static int do_proc_int_conv_jiffies(bool *negp, ulon=
g *u_ptr, int *k_ptr,
>  			     sysctl_u2k_int_conv_hz, sysctl_k2u_int_conv_hz);
>  }
> =20
> +static int do_proc_int_conv_jiffies_minmax(bool *negp, ulong *u_ptr,
> +					   int *k_ptr, int dir,
> +					   const struct ctl_table *tbl)
> +{
> +	return proc_int_conv(negp, u_ptr, k_ptr, dir, tbl, true,
> +			     sysctl_u2k_int_conv_hz, sysctl_k2u_int_conv_hz);
> +}
> +
>  static int do_proc_int_conv_userhz_jiffies(bool *negp, ulong *u_ptr,
>  					   int *k_ptr, int dir,
>  					   const struct ctl_table *tbl)
> @@ -213,6 +221,13 @@ static int do_proc_int_conv_jiffies(bool *negp, ulon=
g *u_ptr, int *k_ptr,
>  	return -ENOSYS;
>  }
> =20
> +static int do_proc_int_conv_jiffies_minmax(bool *negp, ulong *u_ptr,
> +					   int *k_ptr, int dir,
> +					   const struct ctl_table *tbl)
> +{
> +	return -ENOSYS;
> +}
> +
>  static int do_proc_int_conv_userhz_jiffies(bool *negp, ulong *u_ptr,
>  					   int *k_ptr, int dir,
>  					   const struct ctl_table *tbl)
> @@ -263,6 +278,31 @@ int proc_dointvec_jiffies(const struct ctl_table *ta=
ble, int dir,
>  }
>  EXPORT_SYMBOL(proc_dointvec_jiffies);
> =20
> +/**
> + * proc_dointvec_jiffies_minmax - read a vector of integers as seconds w=
ith min/max values
> + * @table: the sysctl table
> + * @dir: %TRUE if this is a write to the sysctl file
> + * @buffer: the user buffer
> + * @lenp: the size of the user buffer
> + * @ppos: file position
> + *
> + * Reads/writes up to table->maxlen/sizeof(unsigned int) integer
> + * values from/to the user buffer, treated as an ASCII string.
> + * The values read are assumed to be in seconds, and are converted into
> + * jiffies. The converted values are checked against the optional
> + * table->extra1 (min) and table->extra2 (max) bounds, in jiffies;
> + * a value outside the range is rejected with -EINVAL.
> + *
> + * Returns 0 on success.
> + */
> +int proc_dointvec_jiffies_minmax(const struct ctl_table *table, int dir,
> +				 void *buffer, size_t *lenp, loff_t *ppos)
> +{
> +	return proc_dointvec_conv(table, dir, buffer, lenp, ppos,
> +				  do_proc_int_conv_jiffies_minmax);
> +}
> +EXPORT_SYMBOL(proc_dointvec_jiffies_minmax);
> +
>  /**
>   * proc_dointvec_userhz_jiffies - read a vector of integers as 1/USER_HZ=
 seconds
>   * @table: the sysctl table
> diff --git a/net/core/sysctl_net_core.c b/net/core/sysctl_net_core.c
> index 473c162736d69..9226b96f2e89b 100644
> --- a/net/core/sysctl_net_core.c
> +++ b/net/core/sysctl_net_core.c
> @@ -544,14 +544,16 @@ static struct ctl_table net_core_table[] =3D {
>  		.data		=3D &net_ratelimit_state.interval,
>  		.maxlen		=3D sizeof(int),
>  		.mode		=3D 0644,
> -		.proc_handler	=3D proc_dointvec_jiffies,
> +		.proc_handler	=3D proc_dointvec_jiffies_minmax,
> +		.extra1		=3D SYSCTL_ZERO,
>  	},
>  	{
>  		.procname	=3D "message_burst",
>  		.data		=3D &net_ratelimit_state.burst,
>  		.maxlen		=3D sizeof(int),
>  		.mode		=3D 0644,
> -		.proc_handler	=3D proc_dointvec,
> +		.proc_handler	=3D proc_dointvec_minmax,
> +		.extra1		=3D SYSCTL_ZERO,
>  	},
>  #ifdef CONFIG_RPS
>  	{
> --=20
> 2.43.0
>=20

This LGTM
Reviewed-by: Joel Granados <joel.granados@kernel.org>

--kbkkqf6zqumhyeya
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEErkcJVyXmMSXOyyeQupfNUreWQU8FAmrplE4ACgkQupfNUreW
QU881Qv5AWWfnF1Ruky22k2G+2H2n6RfLkGk4bmIwQ48pNsbbSOJ3eX5+d6C2Zoo
cTcgld7pDj+xI1lXnhsQ7JUgZGdR+8SoyKEmDu1KfidRj7FQV0i8v+O21WpooNfk
TBteqHekPHA4FR4z6C5Yr77irgnj9RbVuE5ouASXpv8YKJlqa8yxoVLxoKx1CnhS
5l0xxZ8eRmvKkQMyjenrGfQ1B4iftk/FKkHjIVyrV2aTpLrYER6oTLFIH3jrJ0By
07ZVpLDBLUB2wPiEOrVXocadkQr+JBZy9UYkepXhbR3lEaOMM9G+GJ8WUPAzOjFz
V2pdeanVf+rZM77gGp3qZ2vAguDkRA5J9lKe5zxujLwrST6h9o5ZQ4oHOiupf0B+
6+NZTCM8qUO/N7NteI17+4ITHFZkUSMKMpzwP2P0Hl2gaA+7NCeTBrPz2dytwE+P
mxZThyFWIAjoLLiobdYbaszhykxESBfXe+PVQxKCku5EwoOOcgqdIpG6DTidSMNA
P6P+KYOJ
=ZL7G
-----END PGP SIGNATURE-----

--kbkkqf6zqumhyeya--
