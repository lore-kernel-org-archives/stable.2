Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792757999;
	b=w4kQ5rAtHTadLO30TjIl20fKOHc7iVIYks1z/hGl4pJgVQPSHGhv3kq6FHlAgoKUnIJZ
	 tcD4U5+8G0fy5NG9Xmh2Q8KKuqe66Ft/zBCwdl7nAaZB7pKPRePx5RnjTyZOW6UEj/RON
	 I9PcA81BxW5hQvnsRLyycbQbbfYtJDpk7CX95fj5T1MIGYFODET6HnjkdQKPxO4Y19vJj
	 N+adTpM4jh1MrTJvVzIDHQyemQHjHAmM1MeDyw+y359IkBSPrK1yWY6ES54hcpF9Njfzm
	 4ae+BxG4ockweAVUFkawsPUzSBycyisvudeSyypgwT0ogpamfyfL2X3bDIz/8vttJGQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792757999;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 References:MIME-Version:Content-Type:Content-Disposition:In-Reply-To;
	bh=IMkOyMK69MskDKdftzpRFR3vYJ7WDcWvuOpEh1q94Ug=;
	b=gurswT6QrLOQEaYptSDHS0uuQcP+7PqU+7QfZvqNke5KCZ8oRXEXfSud7bHsuApFFQON
	 99oZUE+/tS2eNu+hGyQTB8aGW7z7pEtn0ZwKIGIQlqwj44FF2O2a0r9SnkeA31RCt38DH
	 0a/74XD4LZBZMIXoSU9x2467vRK3d3SAXlOnM+1z0+W0tHTYzXEPuuNCQ8uswfMqOOM09
	 1OOOwgUXU//dUplHuwGd4r52bX8bYGacnY/LPCD2MBAZdoE0e38+zhq4CBJpjcGL0azHe
	 XB8D2IzMzfi/jkCB+HUeTnB6RA4+v/Ob1joSeyB6Jy+WoasSb6fcyo8Ni28xivpaPOQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=UYfhHKAH;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4BCA5606A31E;
	Fri, 23 Oct 2026 12:19:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=UYfhHKAH
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 957061F031E2;
	Fri, 23 Oct 2026 12:19:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792757999;
	bh=IMkOyMK69MskDKdftzpRFR3vYJ7WDcWvuOpEh1q94Ug=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=UYfhHKAHLS0YSv2GD55pHkvozmKaWqFPvV13tu4gcH6XydsT6e+zuh0IL/kFJoHXI
	 +o3hL3tzPsjlf5U0Ouaq4zsF3tERLzz5uN5r2I8LR6vH2LLP4PRXBRoDASpyHsvtOe
	 DtMfHdpQbgjaSVFyopIZjPBlc7eFB1TbfogGWkrEAzKV3pKq4vaKX9MNw3I2CvUFty
	 vQfOW5quCjX9QyUyEjxp9Ir7yzc1e/z7k57m47AQ5O0HYT6KpH3TbSDGJrRkvfYrit
	 AfxJe8J5YjR2GBtNSCNiLtgc2G/sQTAKHFJz4lJDP5vJX5ytvqNcUoceCbcaqSMyOq
	 d8eUgro7DG4iA==
Date: Fri, 23 Oct 2026 14:19:53 +0200
From: Joel Granados <joel.granados@kernel.org>
To: Jiayuan Chen <jiayuan.chen@linux.dev>
Cc: netdev@vger.kernel.org, stable@vger.kernel.org, 
	"David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@kernel.org>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, 
	David Ahern <dsahern@kernel.org>, Ido Schimmel <idosch@nvidia.com>, 
	Kuniyuki Iwashima <kuniyu@google.com>, Chia-Yu Chang <chia-yu.chang@nokia-bell-labs.com>, 
	Wyatt Feng <bronzed_45_vested@icloud.com>, Yung Chih Su <yuuchihsu@gmail.com>, 
	Fernando Fernandez Mancera <fmancera@suse.de>, Hannes Frederic Sowa <hannes@stressinduktion.org>, 
	Flavio Leitner <fbl@redhat.com>, Petr Mladek <pmladek@suse.com>, 
	"Paul E. McKenney" <paulmck@kernel.org>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH net 5/5] net: restrict message_cost and message_burst to
 non-negative values
Message-ID: <attQGnJGhzTPFsMd@hobbes>
References: <20261023091419.167088-1-jiayuan.chen@linux.dev>
 <20261023091419.167088-6-jiayuan.chen@linux.dev>
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
	protocol="application/pgp-signature"; boundary="6kx4ibxzbc2iwevc"
Content-Disposition: inline
In-Reply-To: <20261023091419.167088-6-jiayuan.chen@linux.dev>


--6kx4ibxzbc2iwevc
Content-Type: text/plain; protected-headers=v1; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: Re: [PATCH net 5/5] net: restrict message_cost and message_burst to
 non-negative values
MIME-Version: 1.0

On Fri, Oct 23, 2026 at 05:13:31PM +0800, Jiayuan Chen wrote:
> net.core.message_cost and net.core.message_burst feed the interval and
> burst of net_ratelimit_state, but neither has a lower bound:
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
> Negative values never meant anything here: ___ratelimit() treats them
> like 0, and 0 already expresses both "no limit" (interval) and
> "suppress everything" (burst).
>=20
> Reject them at write time. message_burst can simply use
> proc_dointvec_minmax with extra1 =3D 0. proc_dointvec_jiffies ignores
> extra1/extra2, so give message_cost a small handler that parses into a
> temporary and only stores the value if it is not negative.
>=20
> Fixes: a940d145cc38 ("ratelimit: Warn if ->interval or ->burst are negati=
ve")
> Cc: stable@vger.kernel.org
> Signed-off-by: Jiayuan Chen <jiayuan.chen@linux.dev>
> ---
>  net/core/sysctl_net_core.c | 21 +++++++++++++++++++--
>  1 file changed, 19 insertions(+), 2 deletions(-)
>=20
> diff --git a/net/core/sysctl_net_core.c b/net/core/sysctl_net_core.c
> index 473c162736d6..8146ed819695 100644
> --- a/net/core/sysctl_net_core.c
> +++ b/net/core/sysctl_net_core.c
> @@ -378,6 +378,22 @@ static int proc_do_skb_defer_max(const struct ctl_ta=
ble *table, int write,
>  	return ret;
>  }
> =20
> +static int proc_do_message_cost(const struct ctl_table *table, int write,
> +				void *buffer, size_t *lenp, loff_t *ppos)
> +{
> +	int ret, interval =3D READ_ONCE(*(int *)table->data);
> +	struct ctl_table tmp =3D *table;
> +
> +	tmp.data =3D &interval;
> +	ret =3D proc_dointvec_jiffies(&tmp, write, buffer, lenp, ppos);
> +	if (write && !ret) {
> +		if (interval < 0)
> +			return -EINVAL;
> +		WRITE_ONCE(*(int *)table->data, interval);
> +	}
> +	return ret;
> +}
> +
>  #ifdef CONFIG_BPF_JIT
>  static int proc_dointvec_minmax_bpf_enable(const struct ctl_table *table=
, int write,
>  					   void *buffer, size_t *lenp,
> @@ -544,14 +560,15 @@ static struct ctl_table net_core_table[] =3D {
>  		.data		=3D &net_ratelimit_state.interval,
>  		.maxlen		=3D sizeof(int),
>  		.mode		=3D 0644,
> -		.proc_handler	=3D proc_dointvec_jiffies,
> +		.proc_handler	=3D proc_do_message_cost,
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

I would prefer something like this [1] (not tested and not compiled).
This is more in line with the patterns inside the jiffies.c file. I put
SYSCTL_ZERO there, but I have a doubt if you actually need SYSCTL_ONE.

If the interval variable can be zero, then leave it as SYSCTL_ZERO, but
if it cant be zero and can be one the use SYSCTL_ONE

best


[1]=20

diff --git i/include/linux/jiffies.h w/include/linux/jiffies.h
index bbd57061802c..288ba81ed53e 100644
--- i/include/linux/jiffies.h
+++ w/include/linux/jiffies.h
@@ -646,6 +646,8 @@ extern unsigned long nsecs_to_jiffies(u64 n);
 struct ctl_table;
 int proc_dointvec_jiffies(const struct ctl_table *table, int dir, void *bu=
ffer,
                          size_t *lenp, loff_t *ppos);
+int proc_dointvec_jiffies_minmax(const struct ctl_table *table, int dir, v=
oid *buffer,
+                                size_t *lenp, loff_t *ppos);
 int proc_dointvec_ms_jiffies_minmax(const struct ctl_table *table, int dir,
                                    void *buffer, size_t *lenp, loff_t *ppo=
s);
 int proc_dointvec_userhz_jiffies(const struct ctl_table *table, int dir,
diff --git i/kernel/time/jiffies.c w/kernel/time/jiffies.c
index 9b3487d40cd6..cf91996fe4e3 100644
--- i/kernel/time/jiffies.c
+++ w/kernel/time/jiffies.c
@@ -165,6 +165,14 @@ static int do_proc_int_conv_jiffies(bool *negp, ulong =
*u_ptr, int *k_ptr,
                             sysctl_u2k_int_conv_hz, sysctl_k2u_int_conv_hz=
);
 }

+static int do_proc_int_conv_jiffies_minmax(bool *negp, ulong *u_ptr, int *=
k_ptr,
+                                   int dir, const struct ctl_table *tbl)
+{
+       return proc_int_conv(negp, u_ptr, k_ptr, dir, tbl, true,
+                            sysctl_u2k_int_conv_hz, sysctl_k2u_int_conv_hz=
);
+}
+
+
 static int do_proc_int_conv_userhz_jiffies(bool *negp, ulong *u_ptr,
                                           int *k_ptr, int dir,
                                           const struct ctl_table *tbl)
@@ -263,6 +271,15 @@ int proc_dointvec_jiffies(const struct ctl_table *tabl=
e, int dir,
 }
 EXPORT_SYMBOL(proc_dointvec_jiffies);

+int proc_dointvec_jiffies_minmax(const struct ctl_table *table, int dir,
+                         void *buffer, size_t *lenp, loff_t *ppos)
+{
+       return proc_dointvec_conv(table, dir, buffer, lenp, ppos,
+                                 do_proc_int_conv_jiffies_minmax);
+}
+EXPORT_SYMBOL(proc_dointvec_jiffies);
+
+
 /**
  * proc_dointvec_userhz_jiffies - read a vector of integers as 1/USER_HZ s=
econds
  * @table: the sysctl table
diff --git i/net/core/sysctl_net_core.c w/net/core/sysctl_net_core.c
index eb35da3556f4..7226697bf7c1 100644
--- i/net/core/sysctl_net_core.c
+++ w/net/core/sysctl_net_core.c
@@ -538,7 +538,8 @@ static struct ctl_table net_core_table[] =3D {
                .data           =3D &net_ratelimit_state.interval,
                .maxlen         =3D sizeof(int),
                .mode           =3D 0644,
-               .proc_handler   =3D proc_dointvec_jiffies,
+               .proc_handler   =3D proc_dointvec_jiffies_minmax,
+               .extra1         =3D SYSCTL_ZERO,
        },
        {
                .procname       =3D "message_burst",

--6kx4ibxzbc2iwevc
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEErkcJVyXmMSXOyyeQupfNUreWQU8FAmrbUOMACgkQupfNUreW
QU8xQQwAkdlzhE19hH3dtoNxiocG2HIDwyKx1G1rYfKz/bQp+TRba19EJHzRYvCA
W+0YoCBjuCyXhE2dh0BmCmGiBW3gnceipWLQG5IIo581qAN6wKjRYGwIsAGCqKid
7PftV/ouB6KyWQT06kkwMMgdxpZXteYZsNBv1jwiktC6fUTaJ5XxO4Fhv2bTzCsi
aw6lahS6SAs1drI0NB9P0wpq/PpZOsAvdjyaSRDzmhh/VwY/V1EZYMJSZSCvXXyg
KP3qZxd6OM4P6PZrQX+yhdwFmschLj0iQvl/D77x3ZGi4m15kQtJSCm/0T9Do18O
tLFecuHJHO7Am1gqDHZSSJuxatBML1YzezNrY+hUjRuSfF+Wih82qChPDH+5DsDv
CMPpWgpDzhWzZB07eY2kaTAuybirDMDbzUx/t0XMALV6dZWE1PlT54l4UWAEceke
wgF/shwrRmCHnBKCiSmXw4uQ5e/UCEPYmTmlJLbPPyn2UyEMtqabM1skU8NAY1Sy
e89oQLwC
=M0Lg
-----END PGP SIGNATURE-----

--6kx4ibxzbc2iwevc--
