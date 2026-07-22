Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ADCE11DDC35;
	Wed, 22 Jul 2026 08:25:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784708710; cv=none; b=g0NVOGeWZkoVe9Vxf9eUHfsw83b0W9nfxvTTn6VZCvyhQdMGzmJVPiXIkMJFqJNV+3e223eGmzZdq4WaD3wXU3UltwRsA+za9FXiN3aliQLds1eR8RBtKYHqLHoVxveyHWsX/J1xlnbuipk6joegE9JK3ApTMsxn/3z2lIZbE4k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784708710; c=relaxed/simple;
	bh=8Fm1NhxEv4ThFGfFigKRHL10dAlyTCC6pNNg8Ntn/4E=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=U6J6q3MHsFDNOQyK6avB4FxH2YPJNN3RVCePK6bvntbbx8PIxCLyH9/yaFP2/XDF1YIH/TqbAG+fh19eCaUw3CSfFGncUNHxvSwtpgPF3yFbW6xcYdfd0dJzLRZfGnVScEZbefauIu4eK4FRrHZLYZDWjJhenbiX+pfFaDOcksQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=XSpVWTMe; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="XSpVWTMe"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BAF491F00A3D;
	Wed, 22 Jul 2026 08:25:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784708709;
	bh=Vlk1XgoQCSbQxn/T8Z8FjUzrB0XKs9ddJy6TAd1zdxA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=XSpVWTMetwsRR7nK315yCCO3rHjzzLMmdMVRUR9UHlIlsxBLb8C/vqnpzrBMdglFY
	 WxkGvD0LLNeNtzsB+lTY6kQSjiXaJuNHLhAtSZShOS1TUSBe0upZZF8Mf4SkspMY1p
	 eh/A0BcCHo86NgarXl9pUYxNbeYsNLj4+utbe5vB7emqQwsTmCFyKAuesPxCIvA35c
	 XpQXzjOgFaOFCY24fzh3daE06/Sdue1rHT6vG0w+el7oYi7Fb1QOK0+P1Hf1ALcV51
	 QIdbhp+pZ/fY5tB71coxSfQsVMepewtcCIwUfAtmNgps6k7QkXwci1HwMS3JXUYR+v
	 /MxFKtrpQ0Sow==
Date: Wed, 22 Jul 2026 10:25:03 +0200
From: Antoine Tenart <atenart@kernel.org>
To: James Raphael Tiovalen <jamestiotio@gmail.com>
Cc: Andrew Lunn <andrew+netdev@lunn.ch>, 
	"David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, netdev@vger.kernel.org, 
	stable@vger.kernel.org, Kees Cook <kees@kernel.org>, 
	Nikolay Aleksandrov <razor@blackwall.org>, Ido Schimmel <idosch@nvidia.com>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH net] vxlan: mdb: Fix source list corruption on a failed
 replace
Message-ID: <amB-O8v0P2AfY9Oh@kwain>
References: <20260720160428.249356-1-jamestiotio@gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260720160428.249356-1-jamestiotio@gmail.com>

On Tue, Jul 21, 2026 at 12:04:24AM +0800, James Raphael Tiovalen wrote:
> When replacing the source list of an MDB remote entry, all existing
> sources are first marked for deletion and vxlan_mdb_remote_srcs_add()
> is then called to add the new source list. Sources present in the new
> list have their deletion mark cleared, and any sources left marked
> afterwards are removed.
> 
> If vxlan_mdb_remote_srcs_add() fails partway through, its error path
> deletes all entries on the remote's source list. That rollback is only
> correct for its other caller, vxlan_mdb_remote_add(), where the remote
> was just allocated and the list contains solely entries added during
> the call. On the replace path the list also holds pre-existing sources,
> so a failed replace tears them down together with their (S, G)
> forwarding entries instead of leaving the entry unchanged.
> 
> This is reachable from an existing (*, G) remote. An EXCLUDE filter
> that loses sources starts forwarding traffic that should be blocked,
> while an INCLUDE filter that loses sources drops traffic that should be
> forwarded.
> 
> Mark entries created during the current pass with a new
> VXLAN_SGRP_F_NEW flag. On failure, delete only those entries and clear
> the deletion mark on the pre-existing ones, so a failed replace leaves
> the source list untouched. Retain the flag until the whole operation
> succeeds and then clear it. Also stop vxlan_mdb_remote_src_add() from
> deleting a pre-existing entry it only looked up when adding that
> entry's forwarding entry fails.
> 
> Fixes: a3a48de5eade ("vxlan: mdb: Add MDB control path support")
> Cc: stable@vger.kernel.org
> Signed-off-by: James Raphael Tiovalen <jamestiotio@gmail.com>

Reviewed-by: Antoine Tenart <atenart@kernel.org>

> ---
>  drivers/net/vxlan/vxlan_mdb.c | 30 ++++++++++++++++++------------
>  1 file changed, 18 insertions(+), 12 deletions(-)
> 
> diff --git a/drivers/net/vxlan/vxlan_mdb.c b/drivers/net/vxlan/vxlan_mdb.c
> index 055a4969f593..af7a0d7f95a5 100644
> --- a/drivers/net/vxlan/vxlan_mdb.c
> +++ b/drivers/net/vxlan/vxlan_mdb.c
> @@ -42,6 +42,7 @@ struct vxlan_mdb_remote {
>  };
>  
>  #define VXLAN_SGRP_F_DELETE	BIT(0)
> +#define VXLAN_SGRP_F_NEW	BIT(1)
>  
>  struct vxlan_mdb_src_entry {
>  	struct hlist_node node;
> @@ -844,6 +845,7 @@ vxlan_mdb_remote_src_add(const struct vxlan_mdb_config *cfg,
>  		ent = vxlan_mdb_remote_src_entry_add(remote, &src->addr);
>  		if (!ent)
>  			return -ENOMEM;
> +		ent->flags |= VXLAN_SGRP_F_NEW;
>  	} else if (!(cfg->nlflags & NLM_F_REPLACE)) {
>  		NL_SET_ERR_MSG_MOD(extack, "Source entry already exists");
>  		return -EEXIST;
> @@ -853,15 +855,16 @@ vxlan_mdb_remote_src_add(const struct vxlan_mdb_config *cfg,
>  	if (err)
>  		goto err_src_del;
>  
> -	/* Clear flags in case source entry was marked for deletion as part of
> -	 * replace flow.
> +	/* Clear the deletion mark so the entry survives the replace sweep.
> +	 * The new mark is retained until the whole operation succeeds.
>  	 */
> -	ent->flags = 0;
> +	ent->flags &= ~VXLAN_SGRP_F_DELETE;
>  
>  	return 0;
>  
>  err_src_del:
> -	vxlan_mdb_remote_src_entry_del(ent);
> +	if (ent->flags & VXLAN_SGRP_F_NEW)
> +		vxlan_mdb_remote_src_entry_del(ent);
>  	return err;
>  }
>  
> @@ -889,11 +892,19 @@ static int vxlan_mdb_remote_srcs_add(const struct vxlan_mdb_config *cfg,
>  			goto err_src_del;
>  	}
>  
> +	hlist_for_each_entry(ent, &remote->src_list, node)
> +		ent->flags &= ~VXLAN_SGRP_F_NEW;
> +
>  	return 0;
>  
>  err_src_del:
> -	hlist_for_each_entry_safe(ent, tmp, &remote->src_list, node)
> -		vxlan_mdb_remote_src_del(cfg->vxlan, &cfg->group, remote, ent);
> +	hlist_for_each_entry_safe(ent, tmp, &remote->src_list, node) {
> +		if (ent->flags & VXLAN_SGRP_F_NEW)
> +			vxlan_mdb_remote_src_del(cfg->vxlan, &cfg->group, remote,
> +						 ent);
> +		else
> +			ent->flags &= ~VXLAN_SGRP_F_DELETE;
> +	}
>  	return err;
>  }
>  
> @@ -1069,7 +1080,7 @@ vxlan_mdb_remote_srcs_replace(const struct vxlan_mdb_config *cfg,
>  
>  	err = vxlan_mdb_remote_srcs_add(cfg, remote, extack);
>  	if (err)
> -		goto err_clear_delete;
> +		return err;
>  
>  	hlist_for_each_entry_safe(ent, tmp, &remote->src_list, node) {
>  		if (ent->flags & VXLAN_SGRP_F_DELETE)
> @@ -1078,11 +1089,6 @@ vxlan_mdb_remote_srcs_replace(const struct vxlan_mdb_config *cfg,
>  	}
>  
>  	return 0;
> -
> -err_clear_delete:
> -	hlist_for_each_entry(ent, &remote->src_list, node)
> -		ent->flags &= ~VXLAN_SGRP_F_DELETE;
> -	return err;
>  }
>  
>  static int vxlan_mdb_remote_replace(const struct vxlan_mdb_config *cfg,
> -- 
> 2.43.0
> 
