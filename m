Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793016944;
	b=13N8KyHZT2Yni/wit/F1mdvrVo5bWBlB5qnsD6riwCFhzcmaZMJfVWrpQlF1kzOm6jq4
	 fKtSyGqvOO7qtBKXLqZQ8r3ml90xzh9iioB9h09+QAXcHLEvZMaaHSXN4ht2E/RbbbNnr
	 54WwKunPwLk7AFhZVi8DGDGtOdAs55+uclZtXLzC2ZgYbBJmu/XgzT7v1Gosv5loO9z92
	 pNR2uajrM18s0awcusgLtrHss9H6ryQoSUxt752i5DhVNq7c9ffPhOm5h1SYGyycVwCB+
	 CV6hGSRojgSdId3rDEEMjxng/D4r9rFjgxFu6NCg9EjUH2Nd1lpAlo/oih+WJg6EFyA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793016944;
	h=Received:DKIM-Signature:Subject:From:To:Cc:Date:Message-ID:
	 In-Reply-To:References:X-sashiko-severity:Content-Type:
	 Content-Transfer-Encoding:MIME-Version;
	bh=IvTulwyfQHGq9xJw1yja6dywbpy8LCBW375451x69yI=;
	b=gZtXlsmLi3qjJ9YHZ7zJYEJpLouydA8eo8rzpvoqeI06gTrZ6FKTtlbDtTV5unlS2EDS
	 B+hLXrOtStW91Vd6INVYXT0fLxFNHK3wkwwItSlPzqGTSy5XQUfKc3cz++6jcT8ped+Az
	 gU+AcRWIZwqwM4UL8IWZdm/Ze88umYTXncjvAOLMLku9zSJ560fQktC88F3MnhTgtGD+B
	 vuSoqZvtaFtIy4QdGIPuArxGphzuau++huGV7nMB4Oi0uvtxkT4JIwixZv5uXtC5pg/KM
	 Cj/+HuOzUF85BH/0LLaw/D98xi2S3sQzpICFiWsN8EBgkAfprWhV6EDZjrbpw13pA0w==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=JOwtRTzA;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CD4EA606A31A;
	Mon, 26 Oct 2026 12:15:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=JOwtRTzA
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3AB4E1F01825;
	Mon, 26 Oct 2026 12:15:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793016943;
	bh=IvTulwyfQHGq9xJw1yja6dywbpy8LCBW375451x69yI=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=JOwtRTzAlepsbPE9vjwpasr6jqIBmMZ7ZgaImUQJl5dbLv6NH5CDR8oqvWG3kiO8b
	 Ghl4I3GDbbwtaEHd6lWhe7xgsdYEwz6hygb/QA1m7pnwVjPXsLvc1W18eKs6Epi55R
	 Hrq0Elv2KbPdFjt7F0HA96dvdGNdnmscFXyzv58c1461tViQsEyvYnrVwxgVvuVrTd
	 ++zHkoKVlRIJRXDV9w1S7UtG1cA3kxAKZ2uHqbFLjZzyIiKtRTALY4ur4okCuQ49Hc
	 XRdQN27mxAsOg6m4ADGo+RZmu8EOuceNZ3NFRrBBI6P+FTbTbK+oir3EYw2DY13E+X
	 4Va6iEOQwi08w==
Subject: Re: [PATCH net 3/5] ipv6: restrict mld_qrv to 255
From: netdev-bot+sashiko@kernel.org
To: jiayuan.chen@linux.dev
Cc: netdev@vger.kernel.org, stable@vger.kernel.org, davem@davemloft.net,
 edumazet@kernel.org, kuba@kernel.org, pabeni@redhat.com, horms@kernel.org,
 dsahern@kernel.org, idosch@nvidia.com, kuniyu@google.com,
 joel.granados@kernel.org, chia-yu.chang@nokia-bell-labs.com,
 bronzed_45_vested@icloud.com, yuuchihsu@gmail.com, fmancera@suse.de,
 hannes@stressinduktion.org, fbl@redhat.com, pmladek@suse.com,
 paulmck@kernel.org, linux-kernel@vger.kernel.org
Date: Mon, 26 Oct 2026 12:15:41 +0000
Message-ID: <179301694174.3134.6591289617782917175@kernel.org>
In-Reply-To: <20261023091419.167088-4-jiayuan.chen@linux.dev>
References: <20261023091419.167088-4-jiayuan.chen@linux.dev>
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

- [Low] This patch adds an upper bound to net.ipv6.mld_qrv in
  net/ipv6/sysctl_net_ipv6.c: `static int mld_qrv_max = U8_MAX;` at line…

--

ipv6: restrict mld_qrv to 255

This commit adds an upper bound of U8_MAX to the net.ipv6.mld_qrv
sysctl. ipv6_mc_reset() stores the value in the u8 inet6_dev::mc_qrv, so
larger values wrap. A value of 256 wraps to 0, which then trips the
WARN_ON() in mld_update_qrv() when an MLDv2 query arrives.

> diff --git a/net/ipv6/sysctl_net_ipv6.c b/net/ipv6/sysctl_net_ipv6.c
> index 1a0a36dcdabc1..05a3846803322 100644
> --- a/net/ipv6/sysctl_net_ipv6.c
> +++ b/net/ipv6/sysctl_net_ipv6.c

[ ... ]

> @@ -229,7 +230,8 @@ static struct ctl_table ipv6_rotable[] = {
>  		.maxlen		= sizeof(int),
>  		.mode		= 0644,
>  		.proc_handler	= proc_dointvec_minmax,
> -		.extra1		= SYSCTL_ONE
> +		.extra1		= SYSCTL_ONE,
> +		.extra2		= &mld_qrv_max,
>  	},

[Severity: Low]
This isn't a bug, but should Documentation/networking/ip-sysctl.rst be
updated to match? The mld_qrv entry there already lists its lower limit,
but it doesn't mention the new maximum:

mld_qrv - INTEGER
	Controls the MLD query robustness variable (see RFC3810 9.1).

	Default: 2 (as specified by RFC3810 9.1)

	Minimum: 1 (as specified by RFC6636 4.5)

With extra2 set to &mld_qrv_max, proc_dointvec_minmax() now rejects
writes above 255 with -EINVAL. Writes such as 256 or 1000 used to be
accepted.

Could a "Maximum: 255" line be added, maybe with a short note that the
value is stored in a u8?

No later patch in the series seems to update this file. The igmp_qrv
entry in ip-sysctl.rst also still lists only a minimum, even though
igmp_qrv also appears to be capped at 255 by the end of the series.

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20261023091419.167088-1-jiayuan.chen%40linux.dev
