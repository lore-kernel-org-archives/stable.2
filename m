Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D4F75381AF;
	Thu,  8 Oct 2026 00:35:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791419705; cv=none; b=febPr6qKjdKCiFYKlUeDV9WmcXwBMN8wz4/HCrdH7HLjrUCDAzep7sBlIWmNAy3OMw/33EEjAuXimSIhD+wGeznGw4v+mQaS5swoOdS9h3JZJGcm4h2z+vwq0KnEZzBR74t8v0Ho8VGAeubls+hPo3Fn4yIqVkV59ZTkSWmJ3qs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791419705; c=relaxed/simple;
	bh=bAY7R70u8yCxhxt5vzGfOpTXCpQ0LLpJKoIammqUgIk=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Kl5/H1S3C44LGi9qyf5Nl7jlFmZKvQOMDBjWYAHsDPSmWc9Y5ux9K8Uq7WCuLoJmdGXonvnln2f0rHFnXrBNYP+giSn//aX5QknsDnNrbIVsJYXfFvG92J2FHUjtx+cx4ykLhFajC2wO3c1V1wkUeo/eNlYqmHSVTbJYnFNJ6gE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=SVFYUk+Q; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="SVFYUk+Q"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3F3CD1F000FF;
	Thu,  8 Oct 2026 00:35:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791419704;
	bh=8YQPEMMo0JLlEBVIBy0jUTyHpziLsNDBp9vaxg54cdI=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=SVFYUk+QE5fhlcq0nkVUyz8Kv+0EpPJ2g3VGxyx9rcMgzbM5qONusDjxTNcD11I48
	 iM3QeuHHHmGncebJfIxIR8FbGuDJg6dexnEwdiblVBM3FIysr03XDCH99AL89bUus/
	 BkXV5gVxpiIm5c3+LU2p/jeLE3ERZznaRzKh6yLnTyA7nqbMEYykwMzN5GgC8M0Hn4
	 Jl3IHaw9Z/h84gs/TcirdOUf6aizsTYfxmTqLQfG2M0A0acZB20ERqQd6vAlb/Fu9D
	 hYcEUNg//PM7/woXRYJCTaCyXYi8o+iTumXih3iyNlKN9n6/eLVXY8W4QJlEwutJs2
	 XbJA4wqBy0kXA==
Date: Wed, 7 Oct 2026 17:35:03 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: =?UTF-8?B?SsOpcsOpbXk=?= Jean <Jeremy.Jean@oss.cyber.gouv.fr>
Cc: Jamal Hadi Salim <jhs@mojatatu.com>, Jiri Pirko <jiri@resnulli.us>,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
 stable@vger.kernel.org
Subject: Re: [PATCH net] net/sched: fix use-after-free in __tcf_action_put()
Message-ID: <20261007173503.588b9c7f@kernel.org>
In-Reply-To: <20260930211839.620410-2-Jeremy.Jean@oss.cyber.gouv.fr>
References: <20260930211839.620410-2-Jeremy.Jean@oss.cyber.gouv.fr>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On Wed, 30 Sep 2026 21:18:40 +0000 J=C3=A9r=C3=A9my Jean wrote:
>  {
>  	struct tcf_idrinfo *idrinfo =3D p->idrinfo;
> =20
> -	if (refcount_dec_and_mutex_lock(&p->tcfa_refcnt, &idrinfo->lock)) {
> -		if (bind)
> -			atomic_dec(&p->tcfa_bindcnt);
> -		idr_remove(&idrinfo->action_idr, p->tcfa_index);
> +	mutex_lock(&idrinfo->lock);
> +	if (bind)
> +		atomic_dec(&p->tcfa_bindcnt);
> +	if (!refcount_dec_and_test(&p->tcfa_refcnt)) {
>  		mutex_unlock(&idrinfo->lock);
> -
> -		tcf_action_cleanup(p);
> -		return 1;
> +		return 0;
>  	}
> =20
> -	if (bind)
> -		atomic_dec(&p->tcfa_bindcnt);
> +	idr_remove(&idrinfo->action_idr, p->tcfa_index);
> +	mutex_unlock(&idrinfo->lock);
> =20
> -	return 0;
> +	tcf_action_cleanup(p);
> +	return 1;
>  }

Why did you decide to invert the condition?
If nothing else the diff would be more readable without that
--=20
pw-bot: cr
