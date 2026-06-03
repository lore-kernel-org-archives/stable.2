Received: from sipsolutions.net (s3.sipsolutions.net [168.119.38.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 708D946AF37;
	Wed,  3 Jun 2026 12:10:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=168.119.38.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780488613; cv=none; b=rAPvN3ZYeEm7YmSlcGLrZMOQ68ZXXUZ3PY+R4NOC6M8ukXg4Fq3WJXjRq44SaXlTGgnlvylKdRACxhlHHJ5lcCoGWRbLxtbxd+Ab+T2WeEwmqM8AsHfnQ26ZxNJlMQ5Ken1dX/JCf7uAgUQ/CrOitfCoyLSgCICtG4Ghrwc0jtk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780488613; c=relaxed/simple;
	bh=E53t0GX/q0rfd2pSXpToIBYHwBQUqiT01aMUKreh3Jk=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=edRF+xowYZNhQabj0dXRDKDyMh0j3FjUY0bmGh1BCUnSkx7vM+QENxYQykSmBmnkHAb7mid8XkdR4pcFJlODk67f8Mw52JryRgrB7KwU0YHZ4O6aAjsuj3Cwai7Q1YVjSYBpsUVlLhtRuREweJNgHu/9BZtusFax5ObvVPHOACg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=permerror header.from=sipsolutions.net; spf=none smtp.mailfrom=sipsolutions.net; dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b=keEAZASF; arc=none smtp.client-ip=168.119.38.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=permerror header.from=sipsolutions.net
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=sipsolutions.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b="keEAZASF"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=sipsolutions.net; s=mail; h=MIME-Version:Content-Transfer-Encoding:
	Content-Type:References:In-Reply-To:Date:Cc:To:From:Subject:Message-ID:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
	Resent-Cc:Resent-Message-ID; bh=+PlzdCER/RcjA0HQ3AgtKopayR3MXsHpT+3IgIX4iOI=;
	t=1780488612; x=1781698212; b=keEAZASFmyNChkK4Q6g2K76nZgLQAiaZZNnZx+hczgaUs8/
	xp8GEoH+fP08CGxro8wWlojDFOfCz9nK2vvepIiewV2tf6NOCTVOG9+xl10g0qjm+4OoUQ8Mc3iQf
	dh62zPgKn8vOMQAjTsGzEE6IxJjcumXJQ6Q7m1ljAdSL6kennVsyqeai2i14Ysku4UxC9FmIADd2d
	pgsJyW6ka1+5V8GGj9cHwyP7JptJyyplLDZjCmVTkTGGkdZZuHeRAvaKNUn8/PkTZ2yd2HiCCCWvH
	Cdr3QLF1DSgZwvRCEBaY+i41uce/W320JMS7g1M8snvJ9h0If2t5Db41Ikb6lAfg==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.98.2)
	(envelope-from <johannes@sipsolutions.net>)
	id 1wUkQD-0000000H6do-3qUU;
	Wed, 03 Jun 2026 14:10:10 +0200
Message-ID: <978c9a11cf836680b1fd9365f3b90f028ddf5372.camel@sipsolutions.net>
Subject: Re: [PATCH v4] wifi: mac80211: fix monitor mode frame capture for
 real chanctx drivers
From: Johannes Berg <johannes@sipsolutions.net>
To: Devin Wittmayer <lucid_duck@justthetip.ca>, 
	linux-wireless@vger.kernel.org
Cc: Felix Fietkau <nbd@nbd.name>, Lorenzo Bianconi <lorenzo@kernel.org>, 
	linux-kernel@vger.kernel.org, stable@vger.kernel.org, Oscar Alfonso Diaz
	 <oscar.alfonso.diaz@gmail.com>, fjhhz1997@gmail.com
Date: Wed, 03 Jun 2026 14:10:09 +0200
In-Reply-To: <20260519235713.49109-2-lucid_duck@justthetip.ca>
References: <20260518170147.13885-1-lucid_duck@justthetip.ca>
	 <20260519235713.49109-1-lucid_duck@justthetip.ca>
	 <20260519235713.49109-2-lucid_duck@justthetip.ca>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.58.3 (3.58.3-1.fc43) 
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-malware-bazaar: not-scanned

On Tue, 2026-05-19 at 16:57 -0700, Devin Wittmayer wrote:
>=20
> Cc: stable@vger.kernel.org # 6.9+

No. It's known to crash drivers on some versions, so it should
explicitly opt out of stable by

Cc: <stable+noautosel@kernel.org> # causes some older drivers to crash


> -	if (chanctx_conf)
> +	if (chanctx_conf) {
>  		chandef =3D &chanctx_conf->def;
> -	else if (local->emulate_chanctx)
> -		chandef =3D &local->hw.conf.chandef;
> -	else
> -		goto fail_rcu;
> +	} else {
> +		struct ieee80211_chanctx *ctx;
> +
> +		ctx =3D list_first_or_null_rcu(&local->chanctx_list,
> +					     struct ieee80211_chanctx, list);
> +		if (!ctx ||
> +		    rcu_access_pointer(ctx->list.next) !=3D &local->chanctx_list)
> +			goto fail_rcu;

This results in a sparse warning, maybe my loop approach was better
after all.

johannes
