Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=212.227.15.15
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792756487;
	b=KOQ2ODlg+rwkRvhGf8BjmX/NpW3dC413OUHUxGCHFBh3Vp8W9o7tgAJgrz0Rfit//Zgn
	 vi65kVFZkY15NhHkL06Y20wwvRD1elVVgPGNiIjDs3Wk2h3XIwwbJA6LXFsyWLGCX2Z7P
	 1DGTv4utBVO2i72oR6LWOqhWxoTmCPBItyHGeyeeSHywHN0AvGbQOJ2U0rejqDOrw+zbC
	 z6jrazWKyGMCDb6wP0IW9le5ew2NPCnXclh3PUgAG/3+kDCs9QFAvXDhLW/n6t2azSuPH
	 f0FFQXFwtlvvNnjBGqeLUYPhGOcIQ7OSkk5baXYjU1cLswnJETGAp7BCBo9DAwY7+HA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792756487;
	h=DMARC-Filter:DKIM-Signature:X-UI-Sender-Class:Received:Message-ID:
	 Date:MIME-Version:User-Agent:Subject:To:Cc:References:
	 Content-Language:From:Autocrypt:Disposition-Notification-To:
	 In-Reply-To:Content-Type:Content-Transfer-Encoding:X-Provags-ID:
	 X-Spam-Flag:UI-OutboundReport;
	bh=gf6TxNx1e0IdRxH4i/lhHbCqYOT0RSpWzt+l0OFkhqc=;
	b=iIavrDYWjbmTpdYqmqnKW1IJkagvn2YmcHY1fkB556/qlO0J6yR0ru5/2+Z/1K0fodWB
	 OV9iSXpyBdVSxm5GsH36LKXjx0nzDeJcXq73WuaV7dYpTd5s7JzXw4C5qgFwHkXsnZS8o
	 Jb0MwX0srQ4kjkuTZNgYT4c4zg2uAvAkdRM9uKOK9Dj6/XQfHN7k4iz6kHe+SkwxCOQ7I
	 J5c55UeVUsOrvqjD0+ThQZpZBqMCmOSzo1TRSACc+3XwANw3yo0JyoTMX8fWcM/G57Jdj
	 1A5F28o+fS9/i8tvHXsJXzliQwrc1C31wJHaTvEzAY1qdhi/TWR/pmQASnKR0LpY/PA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmx.net;
	spf=pass smtp.mailfrom=gmx.net;
	dkim=pass header.d=gmx.net header.i=matthias.tafelmeier@gmx.net header.a=rsa-sha256 header.s=s31663417 header.b=Dih0MGN6;
	arc=none smtp.remote-ip=212.227.15.15
Received: from mout.gmx.net (mout.gmx.net [212.227.15.15])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (prime256v1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E7295606A31A;
	Fri, 23 Oct 2026 11:54:45 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org E7295606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmx.net header.i=matthias.tafelmeier@gmx.net header.a=rsa-sha256 header.s=s31663417 header.b=Dih0MGN6
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.net;
	s=s31663417; t=1792756477; x=1793361277;
	i=matthias.tafelmeier@gmx.net;
	bh=gf6TxNx1e0IdRxH4i/lhHbCqYOT0RSpWzt+l0OFkhqc=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:Cc:
	 References:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:cc:content-transfer-encoding:
	 content-type:date:from:message-id:mime-version:reply-to:subject:
	 to;
	b=Dih0MGN6eLafiobUqu/1vFSXdcEO0MvUnjgkySgM8ENO/Qd+nQqscZY8LF7D+L97
	 pI/J56O7qX8hqgbuRo1lgPnL3Noaa0qd4yCcUxriFsBHmsZFJvebBKWgNBiR4wpvH
	 A35mPjE0hNh4d3AO9C/hmLYYoNxpdLM5tmLmyjPPr225z/kXlzh3AGEJrnkBEPo2L
	 1tgntG6FkpTbN4ouZOIx8IhMG0QanQ4SUqA5zx1F7ZYonUr/E85nZqO/43vceWHHw
	 bYsLuTPVOp0G8rD5Xvhd3wrL7JXXXE/me6JNe5w8CnVwKrLG4bCiUj/rhSpccrdWg
	 JKnuPQRlFc9HkvWaxA==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from client.hidden.invalid by mail.gmx.net (mrgmx004
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1MsYv3-1wQSXO2g4x-012jEw; Fri, 23
 Oct 2026 13:54:37 +0200
Message-ID: <d8acbf8e-c20c-4fad-aae0-ee71b6a1838c@gmx.net>
Date: Fri, 23 Oct 2026 13:54:35 +0200
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net] net: reject dev_weight products that overflow int
To: Jiayuan Chen <jiayuan.chen@linux.dev>, netdev@vger.kernel.org
Cc: stable@vger.kernel.org, "David S. Miller" <davem@davemloft.net>,
 Eric Dumazet <edumazet@kernel.org>, Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>,
 Kuniyuki Iwashima <kuniyu@google.com>, Neal Cardwell <ncardwell@google.com>,
 Joel Granados <joel.granados@kernel.org>, linux-kernel@vger.kernel.org
References: <20261023114228.289161-1-jiayuan.chen@linux.dev>
Content-Language: en-US
From: Matthias Tafelmeier <matthias.tafelmeier@gmx.net>
Autocrypt: addr=matthias.tafelmeier@gmx.net; keydata=
 xsBNBFJ0FzIBCADZ/hkwcprVGydMOqeqM+2k6v5e5kb4YDMKU7nMbCVmH4sn01T7Yh9kDwG5
 LOMLD06BB2txjLBvTY+c0mpK+hE4pWr+i3qhU5CbVvx7jppJqCD6ZT/TA3I7NxsdixRvLIF4
 UXgKQOMKPIx+aw/sp86NqzCLAMse7F0vXUjAP5YANtJid2rfr/B37BGKhqDGhi4Appz4UZOz
 pRov/v8JD4XScuvJnl09/oi5cDj3Mn2uqOc/G6hAt7HXsbHh4dKxd3AftqPPzEkJAmm+9Z4A
 SG9hy8IXms8Czimr+BGL0CnfsJlX6DCUm6mVDqT1GJyzmP4zkWcPi+2fOI4KtpV+C7+bABEB
 AAHNOk1hdHRoaWFzIFRhZmVsbWVpZXIgKHByaXZhdCkgPG1hdHRoaWFzLnRhZmVsbWVpZXJA
 Z214Lm5ldD7CwJgEEwEIAEICGwMGCwkIBwMCBhUIAgkKCwQWAgMBAh4BAheAAhkBFiEE3KAB
 pALWdMCm+KI24BZPW4rfNDsFAmfFwnAFCRkUEj4ACgkQ4BZPW4rfNDuYyQf+MXXaG4Xx/9up
 NKSFy7Sq7dMVkM90KVVtfh9KOJUBm+8SUL782mxE8FgkpvGjDIbiUaSjyvj3oF1SNDKuGg1f
 58oOEQrA/Zv7CEvB4kzPUg/AL0Ao7PobKiZ7hJ/aFYQaB50IIBr+af+WfCjblW+5y6irihTc
 xPuKkHvV+S+saAQ3mcdQQVWgFsLnMTz/AQFL7DMsmJB9XFTIx+G4Q+xXCfNM2uyDUcSf2t4l
 MT6V301O/lhKk9MMyB/CxBD/HvdoiOfWHEGF6c7LilxbHcevge+Il4R52rWcVEZwmeH70vGu
 yRMbBzSg16E3oXMK4Srz5SJUU3Nx7ougjwuv0irWNc7ATQRSdBcyAQgA8gKv7nI3K5Vyay/n
 GmZEqfMqhOMnvG3QQ+Ku7z3ksRQ83bm0nKLw9mYtyI0mcShDbfWOMCWhC/HWlvdyvfnPMZc9
 M8nl8QQJkPExYyNW8IxvhcrRiOoIX2L+4qJznOqPBE0A8QZM79mBL57bWVQlKa4pHqblZBwq
 AEf62pLeuh2CO6ecg3hSI0zFur9VUYgJY+N2ChOSpYTevxC2EouDguPMgsQfcdsbf2X69PAQ
 po/irnFKEVmNFStkLZqcE/6BDH8VsF9/e5+kIv0sXl2TLBk/c0dXJpr8PxProJOPtHKd3g1n
 L+p2oYyMyMS5/RGSBcXtRqvgZea45+shx/9foQARAQABwsB8BBgBCAAmAhsMFiEE3KABpALW
 dMCm+KI24BZPW4rfNDsFAmfFwxYFCRkUEuQACgkQ4BZPW4rfNDu2nwf/Z0JumzgpUE2EHA7F
 j9KzO8TZeMRzXDvigduOi39bT1+kBcRNigMrLOk8dGCgYeT44vTkJCVji23I4YuFH442fvAa
 m3f/9L0ob9As/lGc/VIrEWlplFgDQVKgStLjoKBCD6/VVmy0o1nlZUhH9fXo4V2EoYtuDORV
 uxTTKyFdl9U335HrYboFdYwbOhkE9rM/IPWQP7f3jwdhRfvSL9KCzxiH3VmTCKojmYECQo2X
 O5XeWTvzc2E5ML9qsvXO22cXdmga3krfNrtZTbV6ZYYqYr9fgWo5BWiCp31bGjyIn3q/YzhQ
 gBadsya6LEPJZGkruPVwL5N9H6x28dzgUXNk6w==
In-Reply-To: <20261023114228.289161-1-jiayuan.chen@linux.dev>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:/dKtuV4L1zstFNftoNr/Ika2OVwj8wIlbZkZ8jCrodES0ZI7AUL
 XrUlOzIfFZfBWlRRDljotkhUNefkBNTJIa8QjNT1PNXL6TxkGQIT/mJE0IK6+CcYuM6H8br
 jcgPuJD8bhM11+RkEVWLBYbrkX4QPr0L5QyaRYWmf4SMACXw0scnZZdEheYGY8hsdHDryOR
 GgidDZMLt+4hiIDjmRjsw==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:kry2UjfEthI=;tScG/iHvibkkWNb4oLAbgww7qbo
 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
 E/0JlqWx+u2LV84YC4Q==

ACK from my side.

> proc_do_dev_weight() sets the backlog NAPI weight and the qdisc quota
> to dev_weight * dev_weight_rx_bias and dev_weight * dev_weight_tx_bias.
> The three sysctls only have a lower bound of 1, so the products can
> overflow int and end up <=3D 0, e.g. dev_weight=3D65536 and
> dev_weight_rx_bias=3D65536 give a backlog weight of 0.
>
> With a weight <=3D 0, __napi_poll() never sees work < weight. Once
> process_backlog() drains the queue and completes the NAPI by itself,
> __napi_poll() still asks for a repoll, so net_rx_action() keeps putting
> back a NAPI that is no longer scheduled and NET_RX spins on that CPU
> with nothing to do. Restoring the sysctls does not help, as napi->weight
> is only refreshed by process_backlog(), which is never called again.
>
> After 3 pings over lo on CPU 2, with CONFIG_DEBUG_NET:
>
>    (NULL net_device): NAPI poll function process_backlog+0x0/0x1200 retu=
rned 1, exceeding its budget of 0.
>    repoll requested for device (efault) process_backlog but napi is not =
scheduled.
>    repoll requested for device (efault) process_backlog but napi is not =
scheduled.
>    ...
>
> and with nothing queued anymore, NET_RX keeps running on CPU 2:
>
>    NET_RX on cpu2: +454190 in 5s, ksoftirqd/2 at ~82% CPU
>
> Reject writes that make either product overflow int, and print the
> values involved.
>
> Fixes: 3d48b53fb2ae ("net: dev_weight: TX/RX orthogonality")
> Cc: stable@vger.kernel.org
> Signed-off-by: Jiayuan Chen <jiayuan.chen@linux.dev>
> ---
>   net/core/sysctl_net_core.c | 15 ++++++++++++---
>   1 file changed, 12 insertions(+), 3 deletions(-)
>
> diff --git a/net/core/sysctl_net_core.c b/net/core/sysctl_net_core.c
> index 473c162736d6..4f3796bc8870 100644
> --- a/net/core/sysctl_net_core.c
> +++ b/net/core/sysctl_net_core.c
> @@ -318,14 +318,23 @@ static int proc_do_dev_weight(const struct ctl_tab=
le *table, int write,
>   			   void *buffer, size_t *lenp, loff_t *ppos)
>   {
>   	static DEFINE_MUTEX(dev_weight_mutex);
> -	int ret, weight;
> +	int ret, weight, old, rx, tx;
>  =20
>   	mutex_lock(&dev_weight_mutex);
> +	old =3D *(int *)table->data;
>   	ret =3D proc_dointvec_minmax(table, write, buffer, lenp, ppos);
>   	if (!ret && write) {
>   		weight =3D READ_ONCE(weight_p);
> -		WRITE_ONCE(net_hotdata.dev_rx_weight, weight * dev_weight_rx_bias);
> -		WRITE_ONCE(net_hotdata.dev_tx_weight, weight * dev_weight_tx_bias);
> +		if (check_mul_overflow(weight, dev_weight_rx_bias, &rx) ||
> +		    check_mul_overflow(weight, dev_weight_tx_bias, &tx)) {
> +			pr_warn("dev_weight(%d) * (rx_bias(%d) or tx_bias(%d)) overflows int=
\n",
> +				weight, dev_weight_rx_bias, dev_weight_tx_bias);
> +			WRITE_ONCE(*(int *)table->data, old);
> +			ret =3D -EINVAL;
> +		} else {
> +			WRITE_ONCE(net_hotdata.dev_rx_weight, rx);
> +			WRITE_ONCE(net_hotdata.dev_tx_weight, tx);
> +		}
>   	}
>   	mutex_unlock(&dev_weight_mutex);
>  =20


