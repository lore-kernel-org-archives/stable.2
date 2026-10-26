Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793016946;
	b=wG/lH4GK2Vd3qkUT59TdKhQPj8eHoPXLKpRhK4RHdKkS+c6lDbLg/WrEI0NQy/lhuJbX
	 adZSoOZSlfMeVNptCI4K4DV4QOFCmCvi0uT5JOjtJQVt8RcyVEZ1ty+dK+K+UZcmKs0l2
	 zvEsajulvhum3uzhb0p2y/QcTwnNtnxpj1W3oA0X/YvQWcfoY+1Le5GqTkU6rrLAiVgLf
	 TyKL+T77rNigzeIYEs4dCFvE4MYXfwV/hYjMzWCk0a4PaAuBLOZBpm+BAFBlwKe6dtet4
	 znYPSwiBI3hINKsj1LXAU1xInOh93o+KeM83Xkl6x2Xv+9wqBYC9jmJHbeDe6FMHZlw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793016946;
	h=Received:DKIM-Signature:Subject:From:To:Cc:Date:Message-ID:
	 In-Reply-To:References:X-sashiko-severity:Content-Type:
	 Content-Transfer-Encoding:MIME-Version;
	bh=5oEnd5VlB348VE2PuaggCRhBlkFDc/Vhx4236yvYboQ=;
	b=xHlPfjhNYSN0Pb6L3dMrz8ZEI93RoWY8JgEaSV9hwZwfGssZSFPWHCVCWqe4aIFnMS0l
	 HPOUCexZNf/pzjd70f71nOc6xft+dTeaYuEiq/PTY4gPLLKryVYX7xxL7GwAqqJSCsCb6
	 bVsmYupZ50zBd7faTTKUrFoauverU6oqR/BaSmMSmY8hpoitmtW8rGuLCYpKDjYlSrR2/
	 sEfspX2BDOGWR7mNpjPC4GVrLTlCjZa3AFpm31JrGhi8UZkOa31XhWzC6L/MctPnj5yKr
	 xB4fMRJprcPO+UksaA35wRc0YxQ5NmtYFwI8iiskBNUzKaJ7F6Krpn/AdhPd9YFcL5g==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=OFBqKMwO;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AF3B460A2602;
	Mon, 26 Oct 2026 12:15:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=OFBqKMwO
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1E95B1F01829;
	Mon, 26 Oct 2026 12:15:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793016945;
	bh=5oEnd5VlB348VE2PuaggCRhBlkFDc/Vhx4236yvYboQ=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=OFBqKMwO6K5/JCFhdGj4/LYUJYGozZPFdBs+oLmfjhqwHqRiQqOotLV/Iq4n8/sOx
	 SVJnerRkLgpNo2Lr1Rqz7bhPGnNT1GxMKajNMBPUPonZg3Q4F4+iJ6T9yeTtBlni9V
	 wsjawV9fBv7rktXuPbxNqJNvzH81aCh68cWyTc2RXjJi6KL7NPdkmE+uCmigE9wqIH
	 waXgjnedwjUa6jZBMVzL4vGC4eJZga+D22KkfdCX7+bLxNB3RNlW1+RwnJv6AX50xD
	 ZL2o9lJ0MRY75UMwMQejy17oF26Etr/hPCXn4gthfyWC/v77jXsAeeVxGqIU7SgW9K
	 vk5cBK8VpcV0Q==
Subject: Re: [PATCH net 4/5] ipv4: restrict igmp_qrv to 255
From: netdev-bot+sashiko@kernel.org
To: jiayuan.chen@linux.dev
Cc: netdev@vger.kernel.org, stable@vger.kernel.org, davem@davemloft.net,
 edumazet@kernel.org, kuba@kernel.org, pabeni@redhat.com, horms@kernel.org,
 dsahern@kernel.org, idosch@nvidia.com, kuniyu@google.com,
 joel.granados@kernel.org, chia-yu.chang@nokia-bell-labs.com,
 bronzed_45_vested@icloud.com, yuuchihsu@gmail.com, fmancera@suse.de,
 hannes@stressinduktion.org, fbl@redhat.com, pmladek@suse.com,
 paulmck@kernel.org, linux-kernel@vger.kernel.org
Date: Mon, 26 Oct 2026 12:15:43 +0000
Message-ID: <179301694367.3134.13593353266190133687@kernel.org>
In-Reply-To: <20261023091419.167088-5-jiayuan.chen@linux.dev>
References: <20261023091419.167088-5-jiayuan.chen@linux.dev>
X-sashiko-severity: Low
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0

Thank you for your contribution! Sashiko AI review found more severe
issue(s) in other patches of this series. This mail is only an FYI, in case
you want to address the nit picks below when you respin.

Low priority / nit picks for your consideration:

- [Low] This patch adds an upper bound to net.ipv4.igmp_qrv.

Pre-existing issues:
- [Medium] This problem wasn't introduced by this patch, but even with
  the new cap igmp_qrv still accepts 1..255.

--

ipv4: restrict igmp_qrv to 255

This commit caps net.ipv4.igmp_qrv at U8_MAX. Without the cap, the value
is truncated when it is stored into the u8 in_device::mr_qrv and the u8
crcount/sf_crcount counters. With a value of 256, IGMPv3 state change
records are never sent.

> diff --git a/net/ipv4/sysctl_net_ipv4.c b/net/ipv4/sysctl_net_ipv4.c
> index e3760daa34706..ef631a2759b03 100644
> --- a/net/ipv4/sysctl_net_ipv4.c
> +++ b/net/ipv4/sysctl_net_ipv4.c

[ ... ]

> @@ -978,7 +979,8 @@ static const struct ctl_table ipv4_net_table[] = {
>  		.maxlen		= sizeof(int),
>  		.mode		= 0644,
>  		.proc_handler	= proc_dointvec_minmax,
> -		.extra1		= SYSCTL_ONE
> +		.extra1		= SYSCTL_ONE,
> +		.extra2		= &igmp_qrv_max,

[Severity: Low]
Should Documentation/networking/ip-sysctl.rst be updated as well? With
this patch, a write of 256 or more to net.ipv4.igmp_qrv fails with
-EINVAL, but the igmp_qrv entry still lists only a default and a minimum:

igmp_qrv - INTEGER
	Controls the IGMP query robustness variable (see RFC2236 8.1).

	Default: 2 (as specified by RFC2236 8.1)

	Minimum: 1 (as specified by RFC6636 4.5)

Could a "Maximum: 255" line be added here?

The companion patch "ipv6: restrict mld_qrv to 255" leaves the mld_qrv
entry in the same state.

[Severity: Medium]
This isn't a bug introduced by this patch, but the new cap still allows
values from 8 to 255. Is that enough for the AMT relay?

drivers/net/amt.c writes the sysctl straight into the 3-bit QRV field of
struct igmpv3_query (qrv:3 in include/uapi/linux/igmp.h):

drivers/net/amt.c:amt_build_igmp_gq() {
    ...
	ihv3->qrv	= READ_ONCE(amt->net->ipv4.sysctl_igmp_qrv);
    ...
}

In relay mode, amt_newlink() also copies the same sysctl into amt->qrv:

	if (amt->mode == AMT_MODE_RELAY) {
		amt->qrv = READ_ONCE(amt->net->ipv4.sysctl_igmp_qrv);

amt_build_mld_gq() then writes amt->qrv into the 3-bit MLDv2 field:

	mld2q->mld2q_qrv	= amt->qrv;

Neither path clamps the value or applies the RFC 3376 4.1.6 rule, which
says a robustness variable above 7 is sent as QRV=0.

So with igmp_qrv set to 9 or 10, does the relay send QRV=1 or QRV=2 on
the wire? If so, hosts that follow the querier's QRV would use a lower
robustness value than the one configured.

A fix for this would probably belong in amt.c rather than in the sysctl
bound.

>  	},
>  #endif
>  	{

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20261023091419.167088-1-jiayuan.chen%40linux.dev
