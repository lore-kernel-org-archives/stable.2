Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792511445;
	b=QsGWyq6umCLNYbsLxoi+6CmoBZrw+mBhLNBdKrjsaa7/vT+tkye4+D2IEZna413hbITO
	 6TyrAAoTcQfwUWKkDRQ8bjsrUqsmUhw+SDVFqIS6QVPQ8eixDZ4rFnNduecPaEEzSHxnu
	 wgbUt3zf4/zjuQuEb10qM9ssX/vvaGR/hOSYQMRAAWsk+82Q3wXANR/PRAMZLlc9XiIWx
	 L9mKuxUhUSgM8OIelxX3128SZtNayDGhREQi/ygpBXxdgxwM+v8TWGiBzifxjBXxS3LYQ
	 keJCmDe4qR0gNu5wc/ehMvGhGIL8FTZ3MKpk0BFPiQ1sNYLtyXpwqy1kZIJ5X2BbO9Q==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792511445;
	h=Received:Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To;
	bh=OWDHjHDdeRWSAK1KnJapwp9Wwh+nx8P6I71kdOQweUY=;
	b=VocFuNxRj1z2cvpJsntEGP6sRa+oVJZn+i2I0u60DMnbA+m9vYoOV/gW9C1oML/ik9am
	 vGa0K69TrIw5XWt5DOveEBPEOfRk3cFKEkWEm6AavpzNDA8/qoubOMSpuznDVUjzmWnCh
	 s28+pM4qXV9uFnvGR/4bZ352NjdJjBEWCVUc9+66nXIf5azf+Zrghj16AU3Tt7KnJ4/oo
	 c0BStEeFJtpbgAnthsF0BpCteGD+wPUdVsDXWkO9NcT9WXOiBxJ5U87dfnKOIo7zUBsHS
	 bTCjp7spLbkMBTvbQ6v8TJvx8TTr6zESMjNKwHcYeuUR2/+pGXptapWfKdEy5OcRCNQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4382A606A31A;
	Tue, 20 Oct 2026 15:50:45 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BD7CA1F000C5;
	Tue, 20 Oct 2026 15:50:44 +0000 (UTC)
Date: Tue, 20 Oct 2026 15:50:13 +0000
From: Eric Biggers <ebiggers@kernel.org>
To: Jarkko Sakkinen <jarkko@kernel.org>
Cc: David Howells <dhowells@redhat.com>, keyrings@vger.kernel.org,
	stable@vger.kernel.org, Paul Moore <paul@paul-moore.com>,
	James Morris <jmorris@namei.org>,
	"Serge E. Hallyn" <serge@hallyn.com>,
	open list <linux-kernel@vger.kernel.org>,
	"open list:SECURITY SUBSYSTEM" <linux-security-module@vger.kernel.org>
Subject: Re: [PATCH v3 2/3] KEYS: Reject @desclen values >= KEY_MAX_DESC_SIZE
 in key_alloc()
Message-ID: <20261020155013.GB699485@google.com>
References: <20261020013903.1244157-1-jarkko@kernel.org>
 <20261020013903.1244157-3-jarkko@kernel.org>
 <atbIP003h_YHofQb@kernel.org>
 <20261020022832.GA3727@sol>
 <atdJC3-PsaNh9PCA@kernel.org>
 <atdl74PtEpLxVPdd@kernel.org>
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <atdl74PtEpLxVPdd@kernel.org>

On Tue, Oct 20, 2026 at 04:00:31PM +0300, Jarkko Sakkinen wrote:
> On Tue, Oct 20, 2026 at 01:57:19PM +0300, Jarkko Sakkinen wrote:
> > > Sure, this fix is still incomplete though, as I mentioned.
> > > 
> > > Turns out Sashiko found this too; see the comment on
> > > https://sashiko.dev/#/patchset/20261020013903.1244157-1-jarkko%40kernel.org
> > 
> > I did not ignore what you said honestly but I overlooked generated
> > descriptions.
> > 
> > By comparing your v2 response and Sashiko's response and going through the
> > code this is the list that I have where similar check should be placed:
> > 
> > - key_alloc(): before quota calculation (in place)
> > - __key_create_or_update():  before assigning index_key.desc_len
> > - keyring_search(): before match_preparse
> > - request_key_and_link(): before match_preparse 
> > - request_key_rcu(): before check_cached_key()
> > 
> > Some sites might require some minor changes I just wrote the around the
> > ballpark locations.
> > 
> > Did I miss any site that you are aware of?

It looks okay to me.

> - Would it make sense to wrap strlen + check into key_is_valid_desc()?

I don't think it would be very helpful.

> - Would it make sense as a safe-guard to use strnlen(), which is capped
>   to KEY_MAX_DESC_SIZE?

Not really needed.  They are NUL-terminated strings anyway.

- Eric
