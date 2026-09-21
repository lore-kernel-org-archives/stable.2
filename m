Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E9C86485506;
	Mon, 21 Sep 2026 10:46:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789987590; cv=none; b=hzltwRQA/caCMe3iJ4UYSKe4wSnZBrFmzGUmclhk4D6haNenBqdPxpt1pu8/L7OiiaCQcfekzjsH81pbC0YfAUiK2mvCAGyvzpwXAG9HxHqozUwoyuE38WyelbxHlOoyYpb920hQ9tatnYdt1pT5tKJiEvh9FLZc6BXMMyPt6rE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789987590; c=relaxed/simple;
	bh=V/mTvVL5WpnDPKSgaJv02dNBla2Lmr3Vphd3nWknQhU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=kvHCnxMdUfrdGEzL9wjroxGw81bUY1Umt5CJoTEIDcK5If2/x3TwMbxtMcwDSvG6/IzDh6jpRGkG5PIr/qS6bpuN2XadwJ92CPSx6jeNerMgy9GqV2NP7uiZY+25GnAY/zE3yPhIyiY/XalGcMqZmghK2xTaCPQZRJKTocHuXcI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=LkviZ7he; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="LkviZ7he"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 860401F00898;
	Mon, 21 Sep 2026 10:46:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789987588;
	bh=iihlso6WiedFT9qMOlZdg0soKAXWmysksw94t25MY4M=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=LkviZ7heVc1DO05y4Xdc+4yXk2tWYp6AE45sX1MwrgPkMHmq68/s3tcsYjHUQAimU
	 muS5kHjpE4NMl5G32u/qThgI3KmukUE93NHnBZI9Y3CHdY3sTkP8YfJ5T1JcpHSBj7
	 VqM/qy2pG/aj5GMFzp2thYiWrDvqG46gLlQYE42u15yqGcZb6pk2tnzdkALAEGpSqA
	 gpIB92OJZy1iC9xL1vIKaMNm9mqMXH8lh0VqXx2j7pXY3NK8Eyg4RxKz5wu8RuwZDc
	 DS8w3ffAUiTJMA5nc9rLdCnC/nP1wvZKguKQuBdH1fPAzQus+tRE4ixHX3O+r0mmfo
	 fGb+ohKnEdCLw==
Date: Mon, 21 Sep 2026 11:46:24 +0100
From: Simon Horman <horms@kernel.org>
To: Wentao Liang <vulab@iscas.ac.cn>
Cc: UNGLinuxDriver@microchip.com, andrew+netdev@lunn.ch,
	davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
	linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
	pabeni@redhat.com, vladimir.oltean@nxp.com, stable@vger.kernel.org
Subject: Re: [PATCH] net: mscc: ocelot: Fix mirror reference leak on VCAP aux
 resource error
Message-ID: <20260921104624.GI13925@horms.kernel.org>
References: <20260917113444.2149183-1-vulab@iscas.ac.cn>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260917113444.2149183-1-vulab@iscas.ac.cn>

On Thu, Sep 17, 2026 at 11:34:44AM +0000, Wentao Liang wrote:
> When ocelot_vcap_policer_add() fails, the aux resource setup returns
> without releasing the mirror reference taken earlier by
> ocelot_mirror_get(). The caller drops the filter without calling
> ocelot_vcap_filter_del_aux_resources(), so the reference is leaked.
> 
> Release the mirror reference before returning the error.
> 
> Fixes: c3d427eac90f ("net: mscc: ocelot: establish functions for handling VCAP aux resources")
> Cc: stable@vger.kernel.org
> Signed-off-by: Wentao Liang <vulab@iscas.ac.cn>
> ---
>  drivers/net/ethernet/mscc/ocelot_vcap.c | 5 ++++-
>  1 file changed, 4 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/net/ethernet/mscc/ocelot_vcap.c b/drivers/net/ethernet/mscc/ocelot_vcap.c
> index 25e533e91d71..c479af2a423f 100644
> --- a/drivers/net/ethernet/mscc/ocelot_vcap.c
> +++ b/drivers/net/ethernet/mscc/ocelot_vcap.c
> @@ -970,8 +970,11 @@ ocelot_vcap_filter_add_aux_resources(struct ocelot *ocelot,
>  	if (filter->block_id == VCAP_IS2 && filter->action.police_ena) {
>  		ret = ocelot_vcap_policer_add(ocelot, filter->action.pol_ix,
>  					      &filter->action.pol);
> -		if (ret)
> +		if (ret) {
> +			if (filter->action.mirror_ena)
> +				ocelot_mirror_put(ocelot);
>  			return ret;
> +		}
>  	}
>  
>  	return 0;

I think this change would be somewhat more robust against future changes to
this function if it was implemented using a goto-driven unwind ladder,
which is the generally preferred in Networking code.

Something like this (compile tested only!):

diff --git a/drivers/net/ethernet/mscc/ocelot_vcap.c b/drivers/net/ethernet/mscc/ocelot_vcap.c
index 25e533e91d71..ce4a3da38c58 100644
--- a/drivers/net/ethernet/mscc/ocelot_vcap.c
+++ b/drivers/net/ethernet/mscc/ocelot_vcap.c
@@ -957,7 +957,7 @@ ocelot_vcap_filter_add_aux_resources(struct ocelot *ocelot,
 				     struct ocelot_vcap_filter *filter,
 				     struct netlink_ext_ack *extack)
 {
-	struct ocelot_mirror *m;
+	struct ocelot_mirror *m = NULL;
 	int ret;
 
 	if (filter->block_id == VCAP_IS2 && filter->action.mirror_ena) {
@@ -971,10 +971,15 @@ ocelot_vcap_filter_add_aux_resources(struct ocelot *ocelot,
 		ret = ocelot_vcap_policer_add(ocelot, filter->action.pol_ix,
 					      &filter->action.pol);
 		if (ret)
-			return ret;
+			goto err_mirror_put;
 	}
 
 	return 0;
+
+err_mirror_put:
+	if (m)
+		ocelot_mirror_put(ocelot);
+	return ret;
 }
 
 static void

-- 
pw-bot: changes-requested
