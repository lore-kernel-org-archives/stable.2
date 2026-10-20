Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792455599;
	b=oZWq0jpGKCTOUM1P95dcwrMmj3977M8HEd5tYbnW+hAxFtqX5H+8qdm/Bg2WLttwNq/5
	 ytMGPiPZJ064J+RKe5CtZZ1xs98B1MijrZgNY10Ekk8TalvkKA3jHWjt3JC6XsBzMuwqc
	 qpcdgCKw5eI+CHc7LbbSyhiX1GP9/XBCLj6TDWaNurzo4NnQqBKMG895q9vDuje23zTmX
	 Ilc9LdPHNrbJ/rt9roHVLPByRn9TZmj+iGgek6pljoAEgqpzYpdmG0J2IHzCvBRCA74XM
	 2Ux+Y16KVvnBgVbtqLPCWJeQmP/+GIiu5JCl6CPS7XFHd2KXboiKXkSNJGYHLnb5FXg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792455599;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 References:MIME-Version:Content-Type:Content-Disposition:In-Reply-To;
	bh=iiF2O/bop5EiTIhynx8VYby9gA8x0KILaVvvx9Isbbw=;
	b=krRuzUirst4eG/zcN5Ozw+/yfQcY352JT0JJ0mZsqq6habAIUY+osvSXnH5jaHytqofc
	 YGxaDQcmFOgiwhPG8YMuyQRoRj7CwG5ARhteUGkUn42xxBpk/LWhYBmekLdgbwyZ/9Lfh
	 LVcnOzFEf/cPg89ecMppUi0j1wm084xZ86ZrJ2dhHqni6XVd77RCutaoziEPr9q1j50fC
	 jIBUjklDWXk/f8jkpgNd69PD/fIaWk69tzkObl0y2jhCBAy3FplKQEgjpqed5jiCmSWKq
	 HBynHGkfOsgOjJldvvmjuOxdsaErhxIPJe8U6//jVzW7SzfNQ9iLCX5YFTtUxAju8IA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Uw6He+YX;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with UTF8SMTPS id 9BEA0606A319;
	Tue, 20 Oct 2026 00:19:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Uw6He+YX
Received: by smtp.kernel.org (Postfix) with UTF8SMTPSA id D84921F000C4;
	Tue, 20 Oct 2026 00:19:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792455599;
	bh=iiF2O/bop5EiTIhynx8VYby9gA8x0KILaVvvx9Isbbw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=Uw6He+YXpmoBmuUyr/Q2wsQOB6KqlFv013VZSg0/9G7xLtJ2g3nUKeUzj/A1igCGB
	 acHIUwwDPAvuY8LI7/4aODpJJ+Bbkul41MPoeQSbiZD5MpKTd7NwYU3dv/ai0/Lk0U
	 H8YU+w1LkPFmts4oxw468I9uC9PNJTIDE8V3DmlkxydArZ/Pz53rsBZmqSm1DGOcng
	 SlRN6cYu1MYx1b81xmGHTLYpib3XHyzru44u+6o1oRxG/LOBDobl0oO06yKk9xTr0S
	 7lwW+Cu+AUweYbgT5mevhU9FWew/h65YZtKFqr3BlOqIfiQsJ/RAb1UtT1xOPTsgNk
	 3N3dtwoE3ODlA==
Date: Tue, 20 Oct 2026 03:19:55 +0300
From: Jarkko Sakkinen <jarkko@kernel.org>
To: Eric Biggers <ebiggers@kernel.org>
Cc: David Howells <dhowells@redhat.com>, keyrings@vger.kernel.org,
	stable@vger.kernel.org, Paul Moore <paul@paul-moore.com>,
	James Morris <jmorris@namei.org>,
	"Serge E. Hallyn" <serge@hallyn.com>,
	open list <linux-kernel@vger.kernel.org>,
	"open list:SECURITY SUBSYSTEM" <linux-security-module@vger.kernel.org>
Subject: Re: [PATCH v2 2/6] KEYS: Reject @desclen values >= KEY_MAX_DESC_SIZE
 in key_alloc()
Message-ID: <atazq_p9kYi38xWa@kernel.org>
References: <20261019181732.449591-1-jarkko@kernel.org>
 <20261019181732.449591-3-jarkko@kernel.org>
 <20261019191759.GB65095@quark>
 <ataBwhb8d2M1q2ux@kernel.org>
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
In-Reply-To: <ataBwhb8d2M1q2ux@kernel.org>

On Mon, Oct 19, 2026 at 11:46:58PM +0300, Jarkko Sakkinen wrote:
> On Mon, Oct 19, 2026 at 12:17:59PM -0700, Eric Biggers wrote:
> > On Mon, Oct 19, 2026 at 09:17:22PM +0300, Jarkko Sakkinen wrote:
> > > @desclen in key_alloc() is saved to the 16-bit wide desc_len field in
> > > struct keyring_index_key.
> > > 
> > > Reject @desclen values at or above KEY_MAX_DESC_SIZE with -EINVAL in
> > > order to account for the NUL terminator and prevent integer overflow.
> > 
> > This should say something like: "in order to match the userspace limit
> > and avoid u16 truncation".
> > 
> > There are also similar truncations of desc_len to u16 in
> > key_create_or_update() and keyring_search().
> 
> Ack.

Please correct if I'm wrong but I think these don't need anything 
special given that both are capped by strndup().

Br, Jarkko
