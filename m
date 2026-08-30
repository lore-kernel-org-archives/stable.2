Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7DBF83CA491;
	Sun, 30 Aug 2026 18:03:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788113001; cv=none; b=dirOIJkOBL4ABearpQtXSOYiEEMuxqrkSNFDIoD8Y11TYxghq1JKJpcw0P9TZq1DKhBdIYBRa5KFz8E+UMzkqOde+ypunqJty1qKFfRvF1zNFOgVaHLGrFGfxxspzpcQkWfVZ9uDRyiPpHQzk6mQf/WlDeFyPgPcHsqEfh5RN0c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788113001; c=relaxed/simple;
	bh=xa4QOHs1Z3S0yLpyNsGokX4rQPB+bdSKoVSJ/RXR0Dg=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=fVxwwcwoxpbd9IiiALG8ty6dgrh0zgr2igLtN9G47jXSHWd0/e9VqKcjDkYFZqaQ0MjiJYYWdath6xDFrOsXNxeJRQ2lsHGuMp5ap5F90b3gP7Z90ftU8scKo/lQfxqzTpcKp/IEsKPTRuZSR+FY2yeK+bg9aFO2qDmIzy7FdRE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fUwwDUI2; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fUwwDUI2"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4CA771F000E9;
	Sun, 30 Aug 2026 18:03:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788112998;
	bh=is8bnBNTo3ZvCgX4EDHRkiAFox35JV24PhKPu5yGWZE=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=fUwwDUI2R+thnnPdmQ1wNnV02hFVk2Lv0vG8XPRDlgv3nEmhw+XJMwchPmqxSWlzb
	 JEtTYKu/SpSQqgsRR0eenVaRzqpJoH5rOhHyO9qWXIKkPmwSMm7JVQoptnaWabewNq
	 ASms1HHtoRX5Q7G1ebKHIbH8kZ5YxjT2Sp68WckNnnCh/VjZyBQnPG0JC2xSR7HTfH
	 ewUBIGkF+xSFwm9Uq2Z0NQy+BGBbOsIuE6JA+fJJNA7Gl+tzowFdZ0CoewffODhVAh
	 e8CS2tbXH+X6DHtpe4UkQnbrI2du+zRCAUT6/R2S3sukkYmiSg2NdDMZaidU8DUdrF
	 PO9F6y3yRUw7w==
Date: Sun, 30 Aug 2026 11:03:17 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Jamal Hadi Salim <jhs@mojatatu.com>
Cc: netdev@vger.kernel.org, Jiri Pirko <jiri@resnulli.us>, "David S. Miller"
 <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Paolo Abeni
 <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, Victor Nogueira
 <victor@mojatatu.com>, vega@nebusec.ai, stable@vger.kernel.org,
 toke@redhat.com, chia-yu.chang@nokia-bell-labs.com,
 subramanian.vijay@gmail.com, petrm@nvidia.com
Subject: Re: [PATCH net v2 8/8] net/sched: ets: clamp quantum in parse and
 fallback paths
Message-ID: <20260830110317.3357a4ea@kernel.org>
In-Reply-To: <20260829081229.81708-9-jhs@mojatatu.com>
References: <all>
	<20260829081229.81708-1-jhs@mojatatu.com>
	<20260829081229.81708-9-jhs@mojatatu.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On Sat, 29 Aug 2026 04:12:29 -0400 Jamal Hadi Salim wrote:
> ets_qdisc_change() falls back to psched_mtu() with no floor for bands
> without an explicit quantum. With a crafted size table qdisc_pkt_len
> reaches ~2 GiB, so a zero psched_mtu on a headerless device makes the
> deficit-refill loop spin under the qdisc lock.
>=20
> Move the floor into ets_quantum_parse() so explicitly configured quanta
> are also clamped to [256, 1<<20], not just the fallback path.
>=20
> Conditions to recreate the bug:
>   CONFIG_NET_SCH_ETS=3Dy. Requires CAP_NET_ADMIN (namespace-local via
>   unshare -Urn suffices).
>=20
>   tc qdisc add dev dummy0 root ets bands 3 strict 2 quanta 1 1
>=20
> Fixes: dcc68b4d8084 ("net: sch_ets: Add a new Qdisc")
> Reported-by: vega@nebusec.ai
> Reviewed-by: Toke H=C3=B8iland-J=C3=B8rgensen <toke@redhat.com>
> Tested-by: Victor Nogueira <victor@mojatatu.com>
> Signed-off-by: Jamal Hadi Salim <jhs@mojatatu.com>
> Cc: stable@vger.kernel.org
> ---
>  net/sched/sch_ets.c | 12 +++++-------
>  1 file changed, 5 insertions(+), 7 deletions(-)
>=20
> diff --git a/net/sched/sch_ets.c b/net/sched/sch_ets.c
> index 25fcf4079fec..6cc902a03838 100644
> --- a/net/sched/sch_ets.c
> +++ b/net/sched/sch_ets.c
> @@ -83,11 +83,7 @@ static int ets_quantum_parse(struct Qdisc *sch, const =
struct nlattr *attr,
>  			     unsigned int *quantum,
>  			     struct netlink_ext_ack *extack)
>  {
> -	*quantum =3D nla_get_u32(attr);
> -	if (!*quantum) {
> -		NL_SET_ERR_MSG(extack, "ETS quantum cannot be zero");
> -		return -EINVAL;
> -	}
> +	*quantum =3D clamp_t(u32, nla_get_u32(attr), 256, 1 << 20);
>  	return 0;
>  }
> =20
> @@ -632,11 +628,13 @@ static int ets_qdisc_change(struct Qdisc *sch, stru=
ct nlattr *opt,
>  			return err;
>  	}
>  	/* If there are more bands than strict + quanta provided, the remaining
> -	 * ones are ETS with quantum of MTU. Initialize the missing values here.
> +	 * ones are ETS with quantum of max(MTU, 256). Initialize the missing
> +	 * values here.
>  	 */
>  	for (i =3D nstrict; i < nbands; i++) {
>  		if (!quanta[i])
> -			quanta[i] =3D psched_mtu(qdisc_dev(sch));
> +			quanta[i] =3D clamp_t(u32, (u32)psched_mtu(qdisc_dev(sch)),
> +					    256, 1 << 20);
>  	}
> =20
>  	/* Before commit, make sure we can allocate all new qdiscs */

Does this run afoul of one of the tdc cases?

# not ok 39 41f5 - ETS offload where the sum of quanta wraps u32
# Could not match regex pattern. Verify command output:
# qdisc ets 8004: root refcnt 5 offloaded bands 3 quanta 1048576 256 256 pr=
iomap 2 2 2 2 2 2 2 2 2 2 2 2 2 2 2 2=20

https://github.com/p4tc-dev/tc-executor/blob/storage-dbg/artifacts/799938/1=
-tdc-sh/stdout
