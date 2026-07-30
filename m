Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7895F3B7777;
	Thu, 30 Jul 2026 22:50:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785451847; cv=none; b=rGv3/jHsMGVn0VsGXwSAJz8dJ/0kmEhZBUraC2qz2BL3NuWRoR00uUiEw4GGc6Jp8g2VXN+IOAI7JYIdxPbFuGkdn5a5JZwR2oFUTUdv/Ovv6sG7lhGw7E6S/9Q626o6bXxnkgM0YxBajCRN44tLCO4aTy1JVP99RPUOriC81/M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785451847; c=relaxed/simple;
	bh=JpalKRZX9njfQ3MQWD2YrqzINhvOq+OkFBODMOuwKNc=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Fesfeu2ZUpOKar0Qaz7zC6J1MF13Paf+ZrUuu7McI7khLZpK0RL5vnuE4G0BoteiZcl2dGIxR91YnsmsQ5hJloJJS6z0xU3r7mZczucrBo/cXor+A9doNOGXaXrMIntGaBaYEajzCJKzPiWF5W/M+yoabe0bxJMifvm09p9WC34=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=HAOTyD4B; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="HAOTyD4B"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B6C711F000E9;
	Thu, 30 Jul 2026 22:50:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785451846;
	bh=XEd6hXttOvySEFhA8BB4g88telRNG8B5whgcgWs6ekE=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=HAOTyD4B8puIKieu5T5fmZPrOiCunXcFCu/RbkdR3cIIyYfh4FHH+tqt7J0ViTd+y
	 0qWN67PzI+lA973vWHy7s3tHObtMYDcPXhjdxVGQuOEVqs27+Nwrg7pgzBlCMX4IJu
	 n6Y5seAb3ieitQm7kd6BFSGeo2AR3TGN8hVVFbOogCcKKyPe3vwt8UBKIAJ9jBvqsV
	 h2ROiem8ZHHHq1nGrzXdea2fNxe9O1PlVNdOmgLxDogE+mMG0+TqcIK1JYTfJZJU8b
	 At07fPNAd13f7qq6Lw5j27VNmy8Y0zdLOoCJLlG753+wHr/1Hy0/Gzx1WtvZjT8ffa
	 CmK8fyOyLi0gQ==
Date: Thu, 30 Jul 2026 15:50:45 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Abdun Nihaal <nihaal@cse.iitm.ac.in>
Cc: Steen.Hegelund@microchip.com, daniel.machon@microchip.com,
 UNGLinuxDriver@microchip.com, andrew+netdev@lunn.ch, davem@davemloft.net,
 edumazet@google.com, pabeni@redhat.com, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, joe@dama.to,
 linux-arm-kernel@lists.infradead.org, horatiu.vultur@microchip.com,
 stable@vger.kernel.org
Subject: Re: [PATCH net v2] net: microchip: vcap api: Fix possible memory
 leak in vcap_decode_rule()
Message-ID: <20260730155045.49d7252b@kernel.org>
In-Reply-To: <20260728114253.196398-1-nihaal@cse.iitm.ac.in>
References: <20260728114253.196398-1-nihaal@cse.iitm.ac.in>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue, 28 Jul 2026 17:12:51 +0530 Abdun Nihaal wrote:
> The memory allocated for struct vcap_rule_internal, keyfields and
> actionfields inside vcap_dup_rule() are not freed in some of the error
> paths in vcap_decode_rule(). Fix that by calling vcap_free_rule().
> 
> Fixes: 610c32b2ce66 ("net: microchip: vcap: Add vcap_get_rule")
> Cc: stable@vger.kernel.org
> Reviewed-by: Joe Damato <joe@dama.to>
> Signed-off-by: Abdun Nihaal <nihaal@cse.iitm.ac.in>
> ---
> Compile tested only. Issue found using static analysis.

This is important information please add it to the main commit message
body.

> v1->v2:
> - Convert the error labels from "err" to "out_err" to avoid confusion
>   with the err variable, as suggested by Joe Damato.
> 
> Link to v1: https://patchwork.kernel.org/project/netdevbpf/patch/20260727125757.134611-1-nihaal@cse.iitm.ac.in/
> 
>  drivers/net/ethernet/microchip/vcap/vcap_api.c | 9 ++++++---
>  1 file changed, 6 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/net/ethernet/microchip/vcap/vcap_api.c b/drivers/net/ethernet/microchip/vcap/vcap_api.c
> index ff86cde11a32..376be059d662 100644
> --- a/drivers/net/ethernet/microchip/vcap/vcap_api.c
> +++ b/drivers/net/ethernet/microchip/vcap/vcap_api.c
> @@ -2427,18 +2427,21 @@ struct vcap_rule *vcap_decode_rule(struct vcap_rule_internal *elem)
>  
>  	err = vcap_read_rule(ri);
>  	if (err)
> -		return ERR_PTR(err);
> +		goto out_err;
>  
>  	err = vcap_decode_keyset(ri);
>  	if (err)
> -		return ERR_PTR(err);
> +		goto out_err;
>  
>  	err = vcap_decode_actionset(ri);
>  	if (err)
> -		return ERR_PTR(err);
> +		goto out_err;
>  
>  out:
>  	return &ri->data;
> +out_err:

Please name the label after the first action being undone

err_free_rule:

> +	vcap_free_rule(&ri->data);
> +	return ERR_PTR(err);
-- 
pw-bot: cr
