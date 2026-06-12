Received: from abb.hmeau.com (abb.hmeau.com [180.181.231.80])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B4D5D26E71E;
	Fri, 12 Jun 2026 12:22:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=180.181.231.80
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781266949; cv=none; b=gH7N7k/xjCvCA0FAASOf/6A4WEu7Do4nTAia8ul5EjkhbJJ9xss0oOonLn2RxKjW6bHzPRsWGZyncsAZpttV/0qSpzuiw55/X9TrXkhrLKRP1qWXx3oa1HLpQ/plC4PhR8vZXW/GGvMOez9OQHxiaYHRukMqelUY7f2RqaQbn68=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781266949; c=relaxed/simple;
	bh=IUeAJ5+dySEN5WgxzQxh+CK9mQ+YBfKhP8x6h0oQkbI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=h6/Z4XdFUi3gmDXHBpQiJYCqtC1o/YT3D4NdJFx0x6Y8NjisheJferxdazi0iloWga3FzrFWS/SVzx2Zu+th0dfNGCLStWLZM7LQRqDtoXNYbf0VlI4bs2n+mqZr9et9QJqAHEt4gLcOuFW4a5uIxWysh+hOvU/fOcpNM3FM7sI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gondor.apana.org.au; spf=pass smtp.mailfrom=gondor.apana.org.au; dkim=pass (2048-bit key) header.d=gondor.apana.org.au header.i=@gondor.apana.org.au header.b=Dcv8zf0x; arc=none smtp.client-ip=180.181.231.80
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gondor.apana.org.au
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gondor.apana.org.au
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gondor.apana.org.au header.i=@gondor.apana.org.au header.b="Dcv8zf0x"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=gondor.apana.org.au; s=h01; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:cc:to:subject:message-id:date:
	from:content-type:reply-to; bh=uacM3fp+zTvq2ZzUoLDnYJ26A/sGMeP6MVc0khN1l08=; 
	b=Dcv8zf0xzhZqxmqodkE8AxA0FpgsTz+NWUDK+vOYkntRCbfGlfwATtEuWchTDEX/zLfhFrE6SVB
	zcchTNcHStA+2/ywP0j42HLVZrPiq/T0QQSbCDZBeG+I5zXU4mP5KDrDv4KjgJ7vGJS9VdE2Mmrn6
	0CAWA7+U4Ih/wHZEjhZoElOcgDBoxQuWskzuHLEibzyeU1vzM+3leC6KqFVz/wNtal0ccQkVJtopC
	mzxGaMN5I1ZGlZiydb0GjSx4Vhl/ifD+7TdXC6DFJTLvegTEHSRjsZ3UfvwowVJn7ghZcgMbq9hBt
	Dz6rkskFp7C/+2Q496nij5v2irecy/BbrQgA==;
Received: from loth.rohan.me.apana.org.au ([192.168.167.2])
	by formenos.hmeau.com with smtp (Exim 4.98.2 #2 (Debian))
	id 1wY0tq-00000004taX-2oJr;
	Fri, 12 Jun 2026 20:22:15 +0800
Received: by loth.rohan.me.apana.org.au (sSMTP sendmail emulation); Fri, 12 Jun 2026 20:22:14 +0800
Date: Fri, 12 Jun 2026 20:22:14 +0800
From: Herbert Xu <herbert@gondor.apana.org.au>
To: Eric Dumazet <edumazet@google.com>
Cc: WenTao Liang <vulab@iscas.ac.cn>, steffen.klassert@secunet.com,
	davem@davemloft.net, kuba@kernel.org, pabeni@redhat.com,
	horms@kernel.org, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH] net/xfrm: fix refcount leak in clone_policy()
Message-ID: <aiv59s6XS-_4iwlv@gondor.apana.org.au>
References: <20260612020941.12694-1-vulab@iscas.ac.cn>
 <CANn89iJVksVj+tnSgGFeWo9C1m7V6gM7pA_badBs6G5Z=GMO9Q@mail.gmail.com>
 <CANn89i+bQHftM4-36j6+8Hn6iQgTi6Z8r5+YOFDju2KXCU-Jmw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CANn89i+bQHftM4-36j6+8Hn6iQgTi6Z8r5+YOFDju2KXCU-Jmw@mail.gmail.com>

On Thu, Jun 11, 2026 at 11:01:12PM -0700, Eric Dumazet wrote:
>
> Having to clear a refcount before kfree() is a new thing for me.
> 
> Just curious of why this is needed on a private object (not visible yet)

It's not the first time this guy has sent nonsense like this:

https://lore.kernel.org/all/aiDcg4CL92mdFqfA@gondor.apana.org.au/

Cheers,
-- 
Email: Herbert Xu <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt
