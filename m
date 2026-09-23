Received: from abb.hmeau.com (abb.hmeau.com [180.181.231.80])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 99A9633993;
	Wed, 23 Sep 2026 03:38:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=180.181.231.80
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790134722; cv=none; b=Oc1Tbdw+QL/flODkDS3dpPgQ1yMoZ4oKPzxCcnAWcwTZVyPbnXdNJkUdoSl5cEMe5NxnssWEl6qFYT5Zd2pCgo19KFUa2elFREHWGcGQpwREHfs95mRNn2E8CIa0KHsXznClaY8hxif6kGA0ZAuchUxYDafF16bbyAycYwUe26A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790134722; c=relaxed/simple;
	bh=WMdApv4RUthsEd5ebCza8E6SAAVj3Gb8kwej9jPoeUc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=jAh2OccJ0786pkpgarhT/MrsqniYo9J6nRBeiq9PvOBtrsjprxAHsfFA+DbTCKBevWBB+zofUj5nU5rvA8O6Ahz3v51z+A1NxbbNA5AVWkjamPCCgIOcAikpoRYsjqtHTmqQtDuf0+5NuVLaDoBEzCAaHQx+gM4gOrRm99hiU78=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gondor.apana.org.au; spf=pass smtp.mailfrom=gondor.apana.org.au; dkim=pass (2048-bit key) header.d=gondor.apana.org.au header.i=@gondor.apana.org.au header.b=lyashE08; arc=none smtp.client-ip=180.181.231.80
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gondor.apana.org.au
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gondor.apana.org.au
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gondor.apana.org.au header.i=@gondor.apana.org.au header.b="lyashE08"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=gondor.apana.org.au; s=h01; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:cc:to:subject:message-id:date:
	from:content-type:reply-to; bh=F5I58iNKYiHkLKhVib51XQxf3ujRbEtldfcOeg/V1aM=; 
	b=lyashE0817QE9SPMhn6XeFn1NtqlsI5DzGomMIIqE1G0REVpIPWSR8Y9ACJ6WW2YY+21JGvUs7f
	QRNn8n/+ner3j+TsiPTJdmn8Ms3pzl1meMwfechq3RToH3wY+5fYctGlfnBPeZbpP0ZPtNJLouWNb
	eQJj2d/zBRv5zdLm9CKdy3s4GJmEK+YieatqZo1OORqNimx1dzbtZxJcdBcep9AugR4o7NTBu+6pO
	4xYuuvKf9hTBmI4qzYsGHOejD97Hd4bqi6GN0espR5KXKXIxu7RjAsbteDcufqOY3iF6RP3Tq12EG
	cVgKSSoSrBeA92U5wrKxjHt/B5DdVQxrZqPw==;
Received: from loth.rohan.me.apana.org.au ([192.168.167.2])
	by formenos.hmeau.com with smtp (Exim 4.98.2 #2 (Debian))
	id 1x9DoJ-0000000GtPH-3prA;
	Wed, 23 Sep 2026 11:38:20 +0800
Received: by loth.rohan.me.apana.org.au (sSMTP sendmail emulation); Wed, 23 Sep 2026 13:38:19 +1000
Date: Wed, 23 Sep 2026 13:38:19 +1000
From: Herbert Xu <herbert@gondor.apana.org.au>
To: Qihang <q.h.hack.winter@gmail.com>
Cc: netdev@vger.kernel.org, steffen.klassert@secunet.com,
	davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
	pabeni@redhat.com, stable@vger.kernel.org
Subject: Re: [PATCH net v3] xfrm: interface: validate the IP header on xmit
Message-ID: <arNJq55gryoQp64j@gondor.apana.org.au>
References: <20260923032456.45814-1-q.h.hack.winter@gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260923032456.45814-1-q.h.hack.winter@gmail.com>

On Wed, Sep 23, 2026 at 11:24:56AM +0800, Qihang wrote:
>
> diff --git a/net/xfrm/xfrm_interface_core.c b/net/xfrm/xfrm_interface_core.c
> index 688306b..5cc906a 100644
> --- a/net/xfrm/xfrm_interface_core.c
> +++ b/net/xfrm/xfrm_interface_core.c
> @@ -531,6 +531,9 @@ static netdev_tx_t xfrmi_xmit(struct sk_buff *skb, struct net_device *dev)
>  
>  	memset(&fl, 0, sizeof(fl));
>  
> +	if (!pskb_inet_may_pull(skb))
> +		goto tx_err;
> +
>  	switch (skb->protocol) {
>  	case htons(ETH_P_IPV6):
>  		memset(IP6CB(skb), 0, sizeof(*IP6CB(skb)));
> @@ -548,6 +551,9 @@ static netdev_tx_t xfrmi_xmit(struct sk_buff *skb, struct net_device *dev)
>  		}
>  		break;
>  	case htons(ETH_P_IP):
> +		if (ip_hdr(skb)->ihl < 5 ||
> +		    !pskb_network_may_pull(skb, ip_hdr(skb)->ihl * 4))
> +			goto tx_err;

Thank you for the quick fix!

I haven't looked at this deeply but should we verify the IPv6 case
as well?

Also we should try to do the same verification that a packet would
normally get upon entry into the IP stack.  So that means checking
iph->version as well.  The standard entry point is ip_rcv_core and
the same checks should apply whether you went through there or one
of these non-standard entry points.

Perhaps we should abstract out the verifications from ip_rcv_core
so that it can be done by all these entry points in a uniform way.

Cheers,
-- 
Email: Herbert Xu <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt
