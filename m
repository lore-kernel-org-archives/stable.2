Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792512596;
	b=mGrZWJyz1+CmJYsf98KA8E5LPaJKPHqEfL8m4kTYNue9PIsMxCTtilhm8kUPZJ3AyenQ
	 hhh9rTyRLrU+bgahoP7w1OMs+/IULweWmd6PG/I3B7WVHt3MzNyabF0DWZgLY4GBlcxxf
	 oFMVtIiAag06+vGO9s83B1aaWSIay6Zl+kNQKGH2qGPwhsxM70rmHNHYJtzOvOwI1Knym
	 XAQKynaL6yvfS2Hy09bzWmxPSZvBF9Na91EW2gjmUQC67psPeLUJY6u7H6PippQ53qVwZ
	 k1akKAnwLBXAN7UUfBcToSn+yv0Hj+PuFGO1gn8t2Reh2Es83pcnYk91ZNsjK/t6BtA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792512596;
	h=Received:Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To;
	bh=SkddLdbYxFjr6f3gV2lglxwsCWBWEgg7C72bs+eqvCA=;
	b=y4pvfk1dg/ErYVZl3yI9w/qX4tuvdeDnwtzN0S71XIewxzWUBT9SYzo+XSV9GMtVJiTD
	 xS6IY90T3ijvRMQtnG2KjX9yYtcz67v+Ldb8/Nk16dt8YEXSiGS39vZWqJZIY+UVdnLR7
	 TCcNpuICeteQpt00LZyOl/7eqdRLca6BOZFwWxBG0NCTexdRzfUWBlDqAb02PI+Of2AJD
	 u/QAHLuY5eKe4Trz5M3qEPLWFl/CbfoyHWIGPPDLcghBb11JtQjDzaBpTti2CtUnK0kEP
	 3FvFy2JtoZC7QXGnWMK8xIcwCf1nLYA/mEmGYkxer00DA5As0QBdVx4R6uSnZydBYXg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with UTF8SMTPS id 5A259606A319;
	Tue, 20 Oct 2026 16:09:56 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with UTF8SMTPSA id 6CB671F000C4;
	Tue, 20 Oct 2026 16:09:55 +0000 (UTC)
Date: Tue, 20 Oct 2026 19:09:27 +0300
From: Jarkko Sakkinen <jarkko@kernel.org>
To: Eric Biggers <ebiggers@kernel.org>
Cc: David Howells <dhowells@redhat.com>, keyrings@vger.kernel.org,
	stable@vger.kernel.org, Paul Moore <paul@paul-moore.com>,
	James Morris <jmorris@namei.org>,
	"Serge E. Hallyn" <serge@hallyn.com>,
	open list <linux-kernel@vger.kernel.org>,
	"open list:SECURITY SUBSYSTEM" <linux-security-module@vger.kernel.org>
Subject: Re: [PATCH v3 2/3] KEYS: Reject @desclen values >= KEY_MAX_DESC_SIZE
 in key_alloc()
Message-ID: <ateSNxKG_G6WSK1N@kernel.org>
References: <20261020013903.1244157-1-jarkko@kernel.org>
 <20261020013903.1244157-3-jarkko@kernel.org>
 <atbIP003h_YHofQb@kernel.org>
 <20261020022832.GA3727@sol>
 <atdJC3-PsaNh9PCA@kernel.org>
 <atdl74PtEpLxVPdd@kernel.org>
 <20261020155013.GB699485@google.com>
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
In-Reply-To: <20261020155013.GB699485@google.com>

On Tue, Oct 20, 2026 at 03:50:13PM +0000, Eric Biggers wrote:
> On Tue, Oct 20, 2026 at 04:00:31PM +0300, Jarkko Sakkinen wrote:
> > On Tue, Oct 20, 2026 at 01:57:19PM +0300, Jarkko Sakkinen wrote:
> > > > Sure, this fix is still incomplete though, as I mentioned.
> > > > 
> > > > Turns out Sashiko found this too; see the comment on
> > > > https://sashiko.dev/#/patchset/20261020013903.1244157-1-jarkko%40kernel.org
> > > 
> > > I did not ignore what you said honestly but I overlooked generated
> > > descriptions.
> > > 
> > > By comparing your v2 response and Sashiko's response and going through the
> > > code this is the list that I have where similar check should be placed:
> > > 
> > > - key_alloc(): before quota calculation (in place)
> > > - __key_create_or_update():  before assigning index_key.desc_len
> > > - keyring_search(): before match_preparse
> > > - request_key_and_link(): before match_preparse 
> > > - request_key_rcu(): before check_cached_key()
> > > 
> > > Some sites might require some minor changes I just wrote the around the
> > > ballpark locations.
> > > 
> > > Did I miss any site that you are aware of?
> 
> It looks okay to me.
> 
> > - Would it make sense to wrap strlen + check into key_is_valid_desc()?
> 
> I don't think it would be very helpful.

I tend to agree.

> 
> > - Would it make sense as a safe-guard to use strnlen(), which is capped
> >   to KEY_MAX_DESC_SIZE?
> 
> Not really needed.  They are NUL-terminated strings anyway.

This is what I thought based on that in all of the sites I could
determine where the string is create/sourced.

Just wanted to sanity check so that this does not require too
many additional iterations.

> 
> - Eric

Br, Jarkko
