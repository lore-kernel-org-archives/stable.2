Received: from stravinsky.debian.org (stravinsky.debian.org [82.195.75.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AEED42D6E5A;
	Fri,  3 Jul 2026 16:36:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=82.195.75.108
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783096613; cv=none; b=q2X/BCUQ3tyM0k/6HxJbNvmnYM6FxCJjs42rpDsL/CREJraVTfVdKMRbWpulR9YhkmMGIrcV3kDu74jkh9mRODS7xyNoArpBbwT8364JXkdW+sIN5Uw4hr1AjZ6n3bq+3ZCz4oWgK4Rp90GHAV9tqbsrIRlm1crEnqiilU12JX4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783096613; c=relaxed/simple;
	bh=9qdvugQqW/YvFxRkzkxJHKUoAeLRag7HTh/mZandEKs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=kMAvxk46Ayebv/118qCI7yfqOQ8hSED7JluBHFIMt3fle0ThWZYR6+IwXOggxm0t/gBnMZoyxg5r5ZUBeGzVOeDF5dL5rnurlmIec8ZzeE7043wATpt77ZDQEzla/ftaxCpUw5ZeepMdNc4sM2l7PcsE11lQ4nTUByCsUTGJWgc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=debian.org; spf=pass smtp.mailfrom=debian.org; dkim=pass (2048-bit key) header.d=debian.org header.i=@debian.org header.b=IG6/o3sA; arc=none smtp.client-ip=82.195.75.108
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=debian.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=debian.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=debian.org header.i=@debian.org header.b="IG6/o3sA"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=debian.org;
	s=smtpauto.stravinsky; h=X-Debian-User:In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=NaKbXiUjcXXEQM+KivlGkp7ACDkK1uRPQEC/3PlVlnw=; b=IG6/o3sAg3yzjuLyCkfgfMR5Pe
	12axx2uV2uA1a8fj5Vc7VmTAmNxWHr6vf+BDctuuBfdPNPZjmMwbaC1IcMSzoQjWs7dtVdqguXzOV
	ZPXf5211Mj8NjrsOm+9043eSQsILpIIf48FzcJ1KelsdT6EwYQ6lIrEdcdGIVWMf0+pVwH3K0ZPYk
	/kuc2DoGcR2MRn1IDuHqOxk+riKR6LykMyowCwpC1Yfl/BHI6Zv627WPzfM8l9EUDFYmfiiwv4NX0
	+CjdeAAW+bcrYrKvQMp6YPMJmRs/y5z4THETVHGO61Eb0/dOlWeaso2UCrBBnAoXnicxIOpM1LX4I
	2X3YubxQ==;
Received: from authenticated-user
	by stravinsky.debian.org with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.96)
	(envelope-from <leitao@debian.org>)
	id 1wfgsg-009XAY-0K;
	Fri, 03 Jul 2026 16:36:46 +0000
Date: Fri, 3 Jul 2026 09:36:42 -0700
From: Breno Leitao <leitao@debian.org>
To: Sabrina Dubroca <sd@queasysnail.net>
Cc: netdev@vger.kernel.org, 
	Steffen Klassert <steffen.klassert@secunet.com>, Herbert Xu <herbert@gondor.apana.org.au>, stable@vger.kernel.org, 
	zdi-disclosures@trendmicro.com
Subject: Re: [PATCH ipsec] xfrm: espintcp: fix UAF during close
Message-ID: <akfkd_1yI_G4cVoc@gmail.com>
References: <50e2ab4348eb8177581058f0152394cfae6a8d27.1783071494.git.sd@queasysnail.net>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <50e2ab4348eb8177581058f0152394cfae6a8d27.1783071494.git.sd@queasysnail.net>
X-Debian-User: leitao

Hello Sabrina,

On Fri, Jul 03, 2026 at 04:21:12PM +0200, Sabrina Dubroca wrote:
> diff --git a/net/xfrm/espintcp.c b/net/xfrm/espintcp.c
> index 374e1b964438..f09b5dd85db8 100644
> --- a/net/xfrm/espintcp.c
> +++ b/net/xfrm/espintcp.c
> @@ -517,6 +517,8 @@ static void espintcp_close(struct sock *sk, long timeout)
>  	sk->sk_prot = &tcp_prot;
>  	barrier();
>  
> +	synchronize_rcu();

I've got the impression netdev usually prefers synchronize_net() instead
of synchornize_rcu(). Is there any reason for synchronize_net() not
being used here?

Also, given you have a explicit synchronize_rcu() here, should the
barrier() above be dropped?
