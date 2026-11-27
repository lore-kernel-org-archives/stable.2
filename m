Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795768250;
	b=nN/IFeGaWvWFkYK/21cJ+qZopaKE4ADPLOI0SBnFerDrN6RIhXc8t1pddWz/90t24S/F
	 pZHDoIc1hDC3ZgciWulZ8VOkNliN5VeDFVYbptFk5hA3DU3fSrd+l6tpILedxS0hd8hJh
	 c3BaIe41nMg+KppAmCsU9y2eRAe8yVGP/Ic88XZw2fKIJuTYNFhQGnELsAALxx4L0O6qM
	 3F9Kykklhna4YXnebN5gXxlu1K5awkMUtF7k0//AvDa6VFc35HGZS151Q0LI45s5X0VZV
	 C8wFtnQmMRBcwBjl6TTtysbtFDek86u7Nl2nosT4SpgpZ31wnNChrdG4rSbTnEp1rTQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795768250;
	h=Received:DKIM-Signature:Subject:From:To:Cc:Date:Message-ID:
	 In-Reply-To:References:X-sashiko-severity:Content-Type:
	 Content-Transfer-Encoding:MIME-Version;
	bh=SKhezHpydXqIPJNJm+VGSWCrhsoJDu4hJDPwIDrJ9Lg=;
	b=T40KLIlT7LRUtM/8aTQ1MDYahBfEZ06vdnD66yf46j/jFIY3ZnmMV6m5ImVRAqtVqPNs
	 ehoPcgMkYb4meOEsX0ywPMD34UmH/SnK6e/IdEeuLn1In3J9Vlyh2krwu6t5DL4th1zGj
	 pn8F1jjRXtndmGxTXqIFij6t65IxuANEI+DkTNlUS56oG3HwILh6ebseGXQAwn6FmfjQb
	 P1uDCtwfFUfJLSRp2jrhIYHJdS7kyJCsapia1qrLDdMXhsgGcWLkcSVGDuS12bWwjxoBX
	 unngsZy0uejyzENO17XHOj4VxxVdEq/jAPOaPLpYupzeta+WHU70ao9E8g7e7NBrphA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=BTPx2S+E;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CA71A606A31E;
	Fri, 27 Nov 2026 08:30:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=BTPx2S+E
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3922E1F000C1;
	Fri, 27 Nov 2026 08:30:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795768249;
	bh=SKhezHpydXqIPJNJm+VGSWCrhsoJDu4hJDPwIDrJ9Lg=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=BTPx2S+EGlZjm3KfcLpfIEgmE6e43JbEtkrOnX+whJH+UDx1OKqadCEs4PIcqpCEQ
	 3pStgyQzrCAFYdIDESQgPNVsXcDG5D0D60+XS2DzRr9vR4imD9m0uBYpf0cTDfnXfn
	 TeiNSU5BEFUUq5eKuBrYeiO/xwRP5nNB8Jl84ZZ6WiADu4BroSQXZPRe6gD6+vDy4I
	 BGwT2cRAKlUKsn08b6lLeyAwC3wwn4yVZQTIHBExi75gvmME0bBMt+MbTURY1YcAaM
	 tBeO//vvYes9C4Ok52o4ZhXHL5ip0YH8v0bwvNU2bTdh5YZAe5elM++jHY9718xNI7
	 DfHo4vwJ6rDXA==
Subject:
 Re: [PATCH v3] net: ethtool: do not call get_regs() for zero-length dumps
From: netdev-bot+sashiko@kernel.org
To: 25031212351@stu.xidian.edu.cn
Cc: andrew@lunn.ch, kuba@kernel.org, davem@davemloft.net, edumazet@kernel.org,
 pabeni@redhat.com, netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
 stable@vger.kernel.org, horms@kernel.org, byu@xidian.edu.cn,
 wencheng@xidian.edu.cn
Date: Fri, 27 Nov 2026 08:30:48 +0000
Message-ID: <179576824874.3135.15886004303093318921@kernel.org>
In-Reply-To: <20261126082748.2798-1-25031212351@stu.xidian.edu.cn>
References: <20261126082748.2798-1-25031212351@stu.xidian.edu.cn>
X-sashiko-severity: Medium
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

Thank you for your contribution! Sashiko AI review found 1 potential
issue(s) to consider.

Critical: 0 · High: 0 · Medium: 1 · Low: 0

If you believe none of the issues are legitimate, please reply to each
issue of Medium severity or higher and explain why the AI is wrong.
If any of them are legitimate and you plan to respin, please let patchwork
know by including "pw-bot: cr" as a separate line at the end of your reply
(one such reply per series is enough).

- [Medium] The patch adds an early `if (!regs.len) return 0;` in
  ethtool_get_regs() (net/ethtool/ioctl.c:1782-1784).

--

net: ethtool: do not call get_regs() for zero-length dumps

This patch adds an early return in ethtool_get_regs() when the
user-supplied regs.len is zero, so the driver's get_regs() callback is
never called for zero-length dumps. The commit message says this does
not remove a way to query the dump size, because the size comes from
ETHTOOL_GDRVINFO.regdump_len.

> diff --git a/net/ethtool/ioctl.c b/net/ethtool/ioctl.c
> index 80b7930b3fe0d..e8af861ee5de3 100644
> --- a/net/ethtool/ioctl.c
> +++ b/net/ethtool/ioctl.c
> @@ -1779,6 +1779,10 @@ static int ethtool_get_regs(struct net_device *dev, char __user *useraddr)
>  	if (copy_from_user(&regs, useraddr, sizeof(regs)))
>  		return -EFAULT;
>  
> +	/* A zero-length dump has nothing to fill in. */
> +	if (!regs.len)
> +		return 0;
> +
>  	reglen = ops->get_regs_len(dev);
>  	if (reglen <= 0)
>  		return reglen;

[Severity: Medium]
The early return sits before ops->get_regs_len() and its error check.
It also comes before the copy_to_user() of the struct ethtool_regs
header. For a request with len == 0, this seems to change
ETHTOOL_GREGS in a few ways userspace can see.

First, is a negative errno from get_regs_len() now reported as success?
ethtool_get_drvinfo() only fills in regdump_len when the driver
returns a positive length:

net/ethtool/ioctl.c:ethtool_get_drvinfo() {
    ...
	if (ops->get_regs_len) {
		int ret = ops->get_regs_len(dev);

		if (ret > 0)
			rsp->info.regdump_len = ret;
	}
    ...
}

So when get_regs_len() fails, ethtool(8) sends GREGS with
len = regdump_len = 0. One example is bnxt_get_regs_len(), which does
this on a VF:

	if (!BNXT_PF(bp))
		return -EOPNOTSUPP;

Before this patch, "ethtool -d" on a bnxt VF failed with "Operation not
supported". With the early return, the ioctl succeeds and ethtool(8)
prints an empty dump. dsa_conduit_get_regs_len() passes on negative
errors from the conduit in the same way.

Second, the header is no longer written back for len == 0. Several
get_regs() implementations set regs->version, and some also overwrite
regs->len with the full dump size. lan743x_get_regs() is one:

	regs->version = LAN743X_ETH_REG_VERSION;
	regs->len = regs_len;

emac_get_regs(), axienet_ethtools_get_regs() and
dsa_conduit_get_regs() do something similar. mcs7830_get_regs(), the
driver named in the changelog, sets regs->version.

On those devices, a GREGS call with len == 0 used to return the
version and the full length in the header, because the data
copy_to_user() moved 0 bytes. Does that conflict with this part of
the commit message?

    This does not remove a way to query the dump size: the
    uAPI tells users to obtain it from ETHTOOL_GDRVINFO.regdump_len,

The struct ethtool_regs kernel-doc in include/uapi/linux/ethtool.h
also describes @version as a driver-supplied output, with no
exception for len == 0. The new comment says there is "nothing to fill
in", but the header still has fields to fill.

Could the zero-length check go after the get_regs_len() call and its
"reglen <= 0" check, so errors still reach userspace? Copying the
header back to userspace, or documenting the new behaviour in the uAPI
header, would cover the version and len cases. Since this is tagged for
stable, the commit message could also mention the change in behaviour.

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20261126082748.2798-1-25031212351%40stu.xidian.edu.cn
