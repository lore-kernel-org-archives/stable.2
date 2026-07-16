Received: from stravinsky.debian.org (stravinsky.debian.org [82.195.75.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 84FD1429CDD;
	Thu, 16 Jul 2026 13:24:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=82.195.75.108
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784208255; cv=none; b=UUCymnBA4NnvzfkEXzUcBgGY8XUf+dqoTOe4WXVNU/BBt7DYBNLTAXfCQk87y1hzyInLF/cbTGNarPTvnhZpqY5k5WnOzHHckGHDRWl4CD/knoCYoB3kbCqKK/Es69aUgTs4uSZyT9MemyOK+9Ip1S4IoaQXwM+qMAUYL61Q40o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784208255; c=relaxed/simple;
	bh=Fjgy1z0Z81DUwO8onxh+U/cNhVGjlKnF4EcpganB5kc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=GvehRjVqmE3LcnVabNmsSTWhHcypnvjultnlKwN9TuWSu500XRa/27XyLDNXBOdmprhxnSY103BUpnEaAsy2gZZQUKC3p2/42fjb9x5xpgn0ewkJS4XcOb2zUQc/+i8ifa5RwOYyLNPUOxgane2Ur187YZcYUK3AXs9Sryo+GFc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=debian.org; spf=pass smtp.mailfrom=debian.org; dkim=pass (2048-bit key) header.d=debian.org header.i=@debian.org header.b=TJUEXA7E; arc=none smtp.client-ip=82.195.75.108
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=debian.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=debian.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=debian.org header.i=@debian.org header.b="TJUEXA7E"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=debian.org;
	s=smtpauto.stravinsky; h=X-Debian-User:In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=/PvATEpeA+fg+mhGDaN27YwObJ/Rtexpnw9c2IPB0rk=; b=TJUEXA7Ei4IbzcqT+QbURJJ8vq
	hEL8LQTjRH5G5+bV9qthDR89+/0M+hPsOK4IFsTxv+AgVEfKo3oKG2xD8t33QMq8jIJMp8eT+2Z6W
	7bYzhvvJOqV9HosoRntoe6WWXP2Xz2MKtRmS2ZBEsyoPwgYI7eXEyf0ronfvzrQ3qNejCYtq8c4b3
	CqITZni+2YfmuFxXJzKNLkPccqV1Am4V1Xu84wPBrZ+SWes8CYv/1eMPG/1NdNZcQm9iF104gJUB0
	z8h2heq0ItkLDJP8zlmL9o/nKfLe/rSwY6prdQO482UmLTqNG3yDse9yeBcnpQl3eIlWXMPgQzzlW
	OLNH4u9g==;
Received: from authenticated-user
	by stravinsky.debian.org with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.96)
	(envelope-from <leitao@debian.org>)
	id 1wkM4H-003qs3-2L;
	Thu, 16 Jul 2026 13:24:01 +0000
Date: Thu, 16 Jul 2026 06:23:56 -0700
From: Breno Leitao <leitao@debian.org>
To: Doruk Tan Ozturk <doruk@0sec.ai>
Cc: alex.aring@gmail.com, stefan@datenfreihafen.org, 
	miquel.raynal@bootlin.com, davem@davemloft.net, edumazet@google.com, kuba@kernel.org, 
	pabeni@redhat.com, horms@kernel.org, phoebe.buckheister@itwm.fraunhofer.de, 
	linux-wpan@vger.kernel.org, netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
	stable@vger.kernel.org
Subject: Re: [PATCH net] mac802154: llsec: reject frames shorter than the
 authentication tag
Message-ID: <aljbEr7K3uVRjJNT@gmail.com>
References: <20260709131246.44517-1-doruk@0sec.ai>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260709131246.44517-1-doruk@0sec.ai>
X-Debian-User: leitao

On Thu, Jul 09, 2026 at 03:12:46PM +0200, Doruk Tan Ozturk wrote:

> Reported-by: Doruk Tan Ozturk <doruk@0sec.ai>
> Signed-off-by: Doruk Tan Ozturk <doruk@0sec.ai>

Usually you don't have Reported-by if you are fixing something yourself.

> ---
>  net/mac802154/llsec.c | 5 +++++
>  1 file changed, 5 insertions(+)
> 
> diff --git a/net/mac802154/llsec.c b/net/mac802154/llsec.c
> index 5e7cc11fab3a..364a1ac1d771 100644
> --- a/net/mac802154/llsec.c
> +++ b/net/mac802154/llsec.c
> @@ -893,6 +893,11 @@ llsec_do_decrypt_auth(struct sk_buff *skb, const struct mac802154_llsec *sec,

Why not returning here, before sg_init_one()? here you alrady have
datalen and authlen.

>  	sg_init_one(&sg, skb_mac_header(skb), assoclen + datalen);
>  
> +	if (datalen < authlen) {
> +		kfree_sensitive(req);
> +		return -EBADMSG;
> +	}
> +
>  	if (!(hdr->sec.level & IEEE802154_SCF_SECLEVEL_ENC)) {
>  		assoclen += datalen - authlen;
>  		datalen = authlen;
> -- 
> 2.43.0
> 
> 
