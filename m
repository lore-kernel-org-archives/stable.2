Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8043543A7FC;
	Fri, 24 Jul 2026 14:23:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784903007; cv=none; b=d621AeOSNYE4LWIZI9BNKJHMIFqBJM2yPPYkCRq5JfEV5ao9X9xUEglqcymh2pe/nU3Kwol0UZmkOQL2QLdV0B81C+TUaw0sRmlqBgM3KkAVp4+Yx1M+RRng+bP4EmjzyQ1YR7XTPHIR87ksDNDpwAOMkm03edJv559WnInOO7c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784903007; c=relaxed/simple;
	bh=4loVhPgJrEfROKauF0Kad1YDVif2iUscLmRE3oXuTm4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=V6SvUivXZy/ZBFQrq6lgZdqDChIei6EKieReg3jdHmuM7GIu5O6ZflsVyH+Y+dSgUEjFzCvXt16jGw6Yxqk0/+yzfNy9A66POpRfrZDw0a8HZ+ziPdkpGjp6p2Ph1Dq5Kx6sJHF698YHq3haxhWng4y4IjGFbM8COCGrhXckdpY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ZEfF/SPb; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZEfF/SPb"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id ED96E1F000E9;
	Fri, 24 Jul 2026 14:23:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784903006;
	bh=QdWlO2n3DO4dGMe+bl2rVw7vflgi2g4tXRn6pdejfuo=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=ZEfF/SPbZXtuYy1IIfvltmbLaM09BAbn0ItF+KzDUzdLZN4J7MYTppjZHjxOXkUL2
	 98gzFrJw+RLfvktZtEka+0ue5ovXnL5FZyWfkcrrAd+fBEuiFvNQm1SZPIHiiCXfyb
	 in0qvTmCVkaoBy32KUU3oeQ6dJHQtRnaF+TYWb5jbXN+GYRlZ/EFGHEauojwGS3XXT
	 lxViOhfC6gI+qMgf7So7kShg6NbGODKzyVSEQ270TnmbXCNOopWdh5McyozhevGqvm
	 Y5G0MKIBgk/8xgpJr6eHmtsEONtWAH5+Q7B8aAbbHME9zFEwCxGscfGyqx7p+cBMo9
	 oreYLdJGjHxaA==
Date: Fri, 24 Jul 2026 15:23:21 +0100
From: Simon Horman <horms@kernel.org>
To: Weiming Shi <bestswngs@gmail.com>
Cc: Jakub Kicinski <kuba@kernel.org>, Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>,
	Pablo Neira Ayuso <pablo@netfilter.org>, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org, Xiang Mei <xmei5@asu.edu>,
	stable@vger.kernel.org
Subject: Re: [PATCH net] netdevsim: tc: serialize access to nsim_block_cb_list
Message-ID: <20260724142321.GL418547@horms.kernel.org>
References: <20260719175028.988301-2-bestswngs@gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260719175028.988301-2-bestswngs@gmail.com>


This is an AI-generated review of your patch. The human sending this
email has considered the AI review valid, or at least plausible.
Full review at: https://sashiko.dev/#/patchset/20260719175028.988301-2-bestswngs@gmail.com?part=1
---
--- Patch [1]: [PATCH net] netdevsim: tc: serialize access to nsim_block_cb_list ---
commit 27d18d348023b46d852b44b24e6f4ca81ab39bf3
Author: Weiming Shi <bestswngs@gmail.com>

netdevsim: tc: serialize access to nsim_block_cb_list

This commit attempts to fix a list corruption and slab-use-after-free race
condition between the nftables hardware offload path and the TC control
path. It adds a local mutex to netdevsim to serialize access to the global
nsim_block_cb_list during flow_block_cb_setup_simple().

> diff --git a/drivers/net/netdevsim/tc.c b/drivers/net/netdevsim/tc.c
> index a415e02a6df1e..30dd7f924b716 100644
> --- a/drivers/net/netdevsim/tc.c
> +++ b/drivers/net/netdevsim/tc.c
> @@ -72,11 +72,13 @@ static int nsim_setup_tc_ets(struct net_device *dev,
>  }
>  
>  static LIST_HEAD(nsim_block_cb_list);
> +static DEFINE_MUTEX(nsim_block_cb_lock);
>  
>  int
>  nsim_setup_tc(struct net_device *dev, enum tc_setup_type type, void *type_data)
>  {
>  	struct netdevsim *ns = netdev_priv(dev);
> +	int err;
>  
>  	switch (type) {
>  	case TC_SETUP_QDISC_TAPRIO:
[ ... ]
> @@ -84,10 +86,13 @@ nsim_setup_tc(struct net_device *dev, enum tc_setup_type type, void *type_data)
>  	case TC_SETUP_QDISC_ETS:
>  		return nsim_setup_tc_ets(dev, type_data);
>  	case TC_SETUP_BLOCK:
> -		return flow_block_cb_setup_simple(type_data,
> -						  &nsim_block_cb_list,
> -						  nsim_setup_tc_block_cb,
> -						  ns, ns, true);
> +		mutex_lock(&nsim_block_cb_lock);

Simon says: I'm wondering if you could take a look at the issue flagged
            below as it seems to undermine the fix proposed by this
	    patch.

[Severity: High]
This isn't a bug introduced by this patch, but will the new nsim_block_cb_lock
actually fully serialize access to the list?

If tcf_block_bind() fails in the core TC stack, its error unroll path
directly executes list_del(&block_cb->driver_list) while holding only
rtnl_lock.

If this error unroll happens concurrently with an nftables transaction that
holds the commit_mutex and the newly introduced nsim_block_cb_lock, the core
TC stack will modify nsim_block_cb_list completely bypassing the driver's
local lock.

Could this still lead to list corruption and slab-use-after-free bugs when the
concurrent nftables transaction walks the mutating list?

> +		err = flow_block_cb_setup_simple(type_data,

Simon says: I think the problem flagged below can be considered
            in the context of possible follow-up.

[Severity: High]
This is a pre-existing issue, but does adding a local lock in netdevsim mask
the underlying systemic race?

flow_block_cb_setup_simple() modifies driver-provided lists directly without
internal locking. Since the nftables hardware offload path runs without
rtnl_lock, unprivileged users can configure nftables concurrently and trigger
list corruption.

While this patch addresses the issue for netdevsim locally, won't this same
vulnerability persist across other hardware drivers (e.g., cxgb4, prestera,
i40e) that use TC_SETUP_BLOCK with statically allocated global lists?

> +						 &nsim_block_cb_list,
> +						 nsim_setup_tc_block_cb,
> +						 ns, ns, true);
> +		mutex_unlock(&nsim_block_cb_lock);
> +		return err;
>  	case TC_SETUP_FT:
>  		return 0;
>  	default:
