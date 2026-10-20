Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792493840;
	b=1Bj02qnVGrYU2lj0Vhbrwm/6CsdOelT8KCpIKKjvq+Vf0NkTx622ZqnnKuwM69cU0BUL
	 XaA7H8ONrXE+Fsgt9GNF2sEd0BzEr3w1DdiLU6JAcyBIKEpNkkSMJ+A6aoFfJwnGT2Sx4
	 pDN9QJ3m0+fO1quDQ6GC89COCQ8c5IZMsOpeGe2oUyssOm9De09ouOcJL2XNRQXGrjDkq
	 18WC4l11g73x2jxb8fhRqDygfoxhF1DZpdmAv2wx9/+XzegNkao0RR7wlnlXSyh52DMHe
	 7kEOXGhf/o4SvIIA//L0K+kIKZRnO7qyyFOVQsdw7Onc/Of4b2TsHMXFMDFa8Q5iyag==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792493840;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 References:MIME-Version:Content-Type:Content-Disposition:In-Reply-To;
	bh=2smdSTGSfOldcvi+SYYLJcdzdDn1eRh0c0b/azFap+E=;
	b=4ceOrt/OfP/MpHiRDDlxoZy7vZMoun+JmdHhzKpCr6FuztbEdZ6pS8eBwPdwTb3KjLwY
	 jl2QfwXX1WkXJzazziVJtrGMC3airy5vO3hdh8SLWqAxtZYybsM0o56kfvP+CsfY4cGdx
	 lbH57fzxFph9h6lO2Cay4N1gMK/YFpdGmpoxxJ+Gtno6SVSixOWbnIb4cHyD/vTkbv6xK
	 bpogdNHySAO2rqUIcAeDFshlU9jhm4d33x1OAbXyAi4K9B+a0/8xOxmWjB1BmbnYF4Cjb
	 79jmi9GhY0f8KPhYD92QM40ZAKVNJ15oGejsj/ojyJ9T3nf4EPoF3zpgtACfFJlxQiw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=SJKT4izW;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with UTF8SMTPS id BFEEA606A31E;
	Tue, 20 Oct 2026 10:57:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=SJKT4izW
Received: by smtp.kernel.org (Postfix) with UTF8SMTPSA id D97EA1F000C5;
	Tue, 20 Oct 2026 10:57:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792493839;
	bh=2smdSTGSfOldcvi+SYYLJcdzdDn1eRh0c0b/azFap+E=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=SJKT4izWBlp20LrPmaiK4O/ukXaZT/53xGgYlURj5wjY1+0ncpxxxcc3iQX2Y/vBI
	 riukV5LcAhXmSQmO2MvKxOaRa6wX8FFO7BbVqhtfDCX8zijiYPyeGBvZYMuN7is/mT
	 ZQCwwcrMyf/p3zBr5nY2+5Ge+7PA+XP5CpMOOPespN6pTXTS3yARVeGJesrUKrqY6R
	 FF/89uutVX/rMGBtvu6fwMhQs5MJ2B15eeiRk4BtbEttwOJRonyggqXGPCCy8MjYhc
	 6bnYXDmF+kzSML2lKjOR0hIIYE/NwMUMggPwn6zVghNuYwXq4ojsTHP5jd6AJiMn8D
	 M5nFQbh4VDvsA==
Date: Tue, 20 Oct 2026 13:57:15 +0300
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
Message-ID: <atdJC3-PsaNh9PCA@kernel.org>
References: <20261020013903.1244157-1-jarkko@kernel.org>
 <20261020013903.1244157-3-jarkko@kernel.org>
 <atbIP003h_YHofQb@kernel.org>
 <20261020022832.GA3727@sol>
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
In-Reply-To: <20261020022832.GA3727@sol>

On Mon, Oct 19, 2026 at 07:28:32PM -0700, Eric Biggers wrote:
> On Tue, Oct 20, 2026 at 04:47:43AM +0300, Jarkko Sakkinen wrote:
> > On Tue, Oct 20, 2026 at 04:38:56AM +0300, Jarkko Sakkinen wrote:
> > > @desclen in key_alloc() is saved to the 16-bit wide desc_len field in
> > > struct keyring_index_key.
> > > 
> > > Reject @desclen values at or above KEY_MAX_DESC_SIZE with -EINVAL in order
> > > to match the userspace limit. The constraints inherits from the one byte
> > > required for the NULL character.
> > > 
> > > Cc: stable@vger.kernel.org
> > > Assisted-by: LLM
> > > Fixes: f771fde82051 ("keys: Simplify key description management")
> > > Reviewed-by: David Howells <dhowells@redhat.com>
> > > Signed-off-by: Jarkko Sakkinen <jarkko@kernel.org>
> > 
> > This is now the only one, which does not have keyutils script in the
> > commit message so in that sense I think these fixes look pretty good.
> 
> Sure, this fix is still incomplete though, as I mentioned.
> 
> Turns out Sashiko found this too; see the comment on
> https://sashiko.dev/#/patchset/20261020013903.1244157-1-jarkko%40kernel.org

I did not ignore what you said honestly but I overlooked generated
descriptions.

By comparing your v2 response and Sashiko's response and going through the
code this is the list that I have where similar check should be placed:

- key_alloc(): before quota calculation (in place)
- __key_create_or_update():  before assigning index_key.desc_len
- keyring_search(): before match_preparse
- request_key_and_link(): before match_preparse 
- request_key_rcu(): before check_cached_key()

Some sites might require some minor changes I just wrote the around the
ballpark locations.

Did I miss any site that you are aware of?

Because there are so many, despite simple check I also wonder, should
we have a macro for this check?

> 
> - Eric

Br, Jarkko
