Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 247ED4137AA;
	Thu, 23 Jul 2026 16:04:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784822656; cv=none; b=Pio6MdvxcRmZm8McWjcplDCKT1NJ377cxxiG0XYjfR7BwcjKaLucP5msL7H6/S0drKupmGWzo6UIrP6zcbX/14HRryzRuR72PHxAwTx98jwkPbZvJN6P1jSGzv3lhAqlz7jBLYUr9ABRJ+e1JU+dN0Go0SJiLNfqjq8D8KeGbms=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784822656; c=relaxed/simple;
	bh=qfK1tX9eEqUpJ2avN8XrkevNrjW6Xx9cUkhq69/1VEQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=EyJDzGlrTZGZkVnAVeP0/vWqjhEm1S1NkC5fFwA9/3YbWOtmeJsVWGitS3oGowRsMmKE8bIdmPIZ3exbcfBKcJBp5CgXI7Oc6nogTh7bWUp0pVLi2xeak3zLCGGIUhWE12NAQviaLDSzzE/PRo6ZRrP1V/PYobtngf2WyhgbDAo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Tu3hawyt; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Tu3hawyt"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2F0561F00A3A;
	Thu, 23 Jul 2026 16:04:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784822653;
	bh=cL1jbpIKPYsal4j07KMS5EI8X0/2GBgrtVs6E+OlpTw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=Tu3hawyt73p7grxhftqSFhn2xtH7m5YMu8XoXttqbRBpsyI9twbxkpRuP2rzTq5NL
	 eR6ycEG7waNJvwjctd8BbnRadh+TDhtP8iRYsjMCGfcusxcEq826bEiVkaAtri9MVd
	 acVhmqs6WMsWcJa9gPQjgaxad0MtNpxDVQOjzmAlGeg7d+F0Yw9iAsnhWBA25rCSRK
	 f/0mAr/c0Ji2qK4G75WfaSnEiPxgjJybOkxORzKZOxl/6B8RjChc/Db4CAPWl7L6Yh
	 aZ4c1byruP1GUYPsdpkItChNmzTNSjUjyaniB80lkZTQXkFn+SaQDG9fquuL3D+JaM
	 579EyYdfApzYQ==
From: Jakub Kicinski <kuba@kernel.org>
To: shuangpeng.kernel@gmail.com
Cc: Jakub Kicinski <kuba@kernel.org>,
	davem@davemloft.net,
	edumazet@google.com,
	pabeni@redhat.com,
	horms@kernel.org,
	elic@nvidia.com,
	jiri@resnulli.us,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: Re: [PATCH] net: flow_offload: clean up indirect flow block on bind failure
Date: Thu, 23 Jul 2026 09:03:50 -0700
Message-ID: <20260723160350.721846-1-kuba@kernel.org>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260717194455.1734974-1-shuangpeng.kernel@gmail.com>
References: <20260717194455.1734974-1-shuangpeng.kernel@gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This is an AI-generated review of your patch. The human sending this
email has considered the AI review valid, or at least plausible.
---
net: flow_offload: clean up indirect flow block on bind failure

This patch tries to fix a use-after-free in the nftables netdev offload
path by removing the replay entry that flow_indr_dev_setup_offload()
inserts into flow_indir_dev_list when no registered indirect provider
binds the block and the call returns -EOPNOTSUPP.

> diff --git a/net/core/flow_offload.c b/net/core/flow_offload.c
> index 5071d7fe6ce2..5fbb1ae4679d 100644
> --- a/net/core/flow_offload.c
> +++ b/net/core/flow_offload.c
> @@ -606,15 +606,20 @@ int flow_indr_dev_setup_offload(struct net_device *dev,	struct Qdisc *sch,
>  				void (*cleanup)(struct flow_block_cb *block_cb))
>  {
>  	struct flow_indr_dev *this;
> +	bool replay_added = false;
>  	u32 count = 0;
>  	int err;
>  
>  	mutex_lock(&flow_indr_block_lock);
>  	if (bo) {
> -		if (bo->command == FLOW_BLOCK_BIND)
> -			indir_dev_add(data, dev, sch, type, cleanup, bo);
> -		else if (bo->command == FLOW_BLOCK_UNBIND)
> +		if (bo->command == FLOW_BLOCK_BIND) {
> +			int add_err;
> +
> +			add_err = indir_dev_add(data, dev, sch, type, cleanup, bo);
> +			replay_added = add_err == 0;
> +		} else if (bo->command == FLOW_BLOCK_UNBIND) {
>  			indir_dev_remove(data);
> +		}
>  	}
>  
>  	list_for_each_entry(this, &flow_block_indr_dev_list, list) {
> @@ -623,9 +628,17 @@ int flow_indr_dev_setup_offload(struct net_device *dev,	struct Qdisc *sch,
>  			count++;
>  	}
>  
> +	if (bo && list_empty(&bo->cb_list)) {
> +		if (replay_added)
> +			indir_dev_remove(data);
> +		err = -EOPNOTSUPP;
> +	} else {
> +		err = count;
> +	}

[High]
Does this change reintroduce the exact scenario that commit
74fc4f828769 ("net: Fix offloading indirect devices dependency on qdisc
order creation") was written to address?

The purpose of flow_indir_dev_list is to remember BIND requests made
when no indirect provider has registered yet, so that a driver
registering later via flow_indr_dev_register() can replay them through
existing_qdiscs_register().

Consider a TC ingress qdisc on a device without ndo_setup_tc that is
created before any indirect provider registers.  With this patch:

  - indir_dev_add() succeeds, so replay_added = true
  - flow_block_indr_dev_list is empty, so no cb runs
  - bo->cb_list is therefore empty
  - the newly-inserted replay entry is immediately removed via
    indir_dev_remove(data)

When a driver (for example mlx5/nfp/bnxt/ice/sfc) later calls
flow_indr_dev_register(), existing_qdiscs_register() will not find the
qdisc and the hardware offload will silently never happen.

For the TC path, tcf_block_offload_cmd() calls
flow_indr_dev_setup_offload() and its return value is effectively
absorbed by tcf_block_offload_bind(), which treats -EOPNOTSUPP as
"no offload yet" via the no_offload_dev_inc path; the tcf_block itself
stays alive.  The replay entry it inserted is still valid state that
future provider registrations depend on.

Could the fix be scoped only to the caller that actually frees the
block on -EOPNOTSUPP (nftables netdev), for example by having nft's
abort path call indir_dev_remove() explicitly, or by adding an opt-in
flag on flow_block_offload so that only callers that will free their
state on failure request the cleanup?

As written, the cleanup fires unconditionally for every BIND that
produces -EOPNOTSUPP, including TC, tc actions and nf_flow_table paths
that legitimately keep their state alive on -EOPNOTSUPP and rely on
the replay entry being preserved.

>  
>  	mutex_unlock(&flow_indr_block_lock);
>  
> -	return (bo && list_empty(&bo->cb_list)) ? -EOPNOTSUPP : count;
> +	return err;
>  }
>  EXPORT_SYMBOL(flow_indr_dev_setup_offload);
>
-- 
pw-bot: cr
