Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792455999;
	b=jHMC8Erzm1t9Y2IasKo4wFFCZqJCHp9RuAk93f7WTrialYKcmSCNS0dJh9WfGhbUX9HH
	 2h6bpS/J3KmesLG3TmChPmLKndGt0/CTR6SMvpz4IbzQFoR405NGXILzRqWdR8wrRvoY5
	 7SJs5nn2FcUYpiLC+Zli9JQabAw/Gbq039n93hLo+Vxc47cZi/jCsJvZ37DeBTEEyU7Ba
	 MgLf12uQS/sOfiFclpCYPqBdBa1hZbzsuDWCNomjNVIG2zd1/bws0+f/hKm4jglW9Dio7
	 BWQjJ4Wvqmw7fQDr6ezq3cY32Jobx28YqPLxQSUK6So2Qpn2jES1aVcVm5XRt9fJhJQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792455999;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 References:MIME-Version:Content-Type:Content-Disposition:In-Reply-To;
	bh=Ry43KoGrIHKSfiPd9pS8pTutQpC3TAtFvvOqrBXDe58=;
	b=be0fea4z245J/k+OTRMsMY54GlHxGOJ1CKA0RPZ48W54ZwYwgm57pL4SMXWG/kE8M2C7
	 58FdSBTpAk3Z1OmQZ0b1F5Ar+HSfWz1nnRJyUjU6zqo++0//ua9vpfDTnOVrvUPzU5HQO
	 EXd4htRjTQ+5GSECGsf7zo8M0O9z75zMxFZYF1xXE53kNOsCHcHr+V+TVA3mpnxkd3pJX
	 GJiZil0i1XeQZA20BAF5I15oLiazXDS+bHJ+f+3Vb4kRGgaohUbA7dol72V1EFkLH6WMc
	 dOYKVjjB9QqYOhXdzgDokkRY1sHlN7vbOuSwYsRrRctyl0mNZpHx1LEuY6a2hyPayNg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b="cSab/YdC";
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with UTF8SMTPS id 880B6606A31B;
	Tue, 20 Oct 2026 00:26:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=cSab/YdC
Received: by smtp.kernel.org (Postfix) with UTF8SMTPSA id D92381F000C4;
	Tue, 20 Oct 2026 00:26:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792455999;
	bh=Ry43KoGrIHKSfiPd9pS8pTutQpC3TAtFvvOqrBXDe58=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=cSab/YdCyod72jjbMwbrr2rgbvHAIQp08u7xja1gcLcp25AL5Op/yRE0RNjmmv6UE
	 lXAEhEsv6JpInJNaV13igE1FX+p+AXls3sZXg4Kjpq568bLSge/gLb08insN5S0hOQ
	 QbRJ8IgE6hAWqqp56QWCKSur+mcQKmT6RzoE/czuobNkj/77SG/JMdI1tCBSfzTNP/
	 nY257M6zBXsMmS/IxgRagHXjM5VEWZVzeKfC1EGzFGeJ5rd1/YhGuzqGHdP001xw6l
	 1KiGAna/laMHGOAtoWQmclSe8JDB4m+OrH+GF+Y1zEwDRMcwZwMETG8tktoMB6v5MD
	 0jZvqy4IAFuiw==
Date: Tue, 20 Oct 2026 03:26:35 +0300
From: Jarkko Sakkinen <jarkko@kernel.org>
To: Eric Biggers <ebiggers@kernel.org>
Cc: David Howells <dhowells@redhat.com>, keyrings@vger.kernel.org,
	stable@vger.kernel.org, Paul Moore <paul@paul-moore.com>,
	James Morris <jmorris@namei.org>,
	"Serge E. Hallyn" <serge@hallyn.com>, Andrew Morton <akpm@osdl.org>,
	"open list:SECURITY SUBSYSTEM" <linux-security-module@vger.kernel.org>,
	open list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2 3/6] KEYS: Prevent overflow of user->{qnkeys,qnbytes}
 in key_alloc()
Message-ID: <ata1O7niaPAgPjid@kernel.org>
References: <20261019181732.449591-1-jarkko@kernel.org>
 <20261019181732.449591-4-jarkko@kernel.org>
 <20261019192332.GC65095@quark>
 <ataDOKziXt8j8AhS@kernel.org>
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
In-Reply-To: <ataDOKziXt8j8AhS@kernel.org>

On Mon, Oct 19, 2026 at 11:53:12PM +0300, Jarkko Sakkinen wrote:
> On Mon, Oct 19, 2026 at 12:23:32PM -0700, Eric Biggers wrote:
> > On Mon, Oct 19, 2026 at 09:17:23PM +0300, Jarkko Sakkinen wrote:
> > > Add the missing overflow checks for user->qnkeys and user->qnbytes
> > > in order keep calculations within INT_MAX range, which is the
> > > absolute maximum quota.
> > > 
> > > Cc: stable@vger.kernel.org
> > > Assisted-by: LLM
> > > Fixes: 7e047ef5fe2d ("[PATCH] keys: sort out key quota system")
> > > Reviewed-by: David Howells <dhowells@redhat.com>
> > > Signed-off-by: Jarkko Sakkinen <jarkko@kernel.org>
> > 
> > Don't keyctl_chown_key() and key_payload_reserve() need similar fixes?
> 
> Thanks, I'll investigate.

OK so this is me misleading as my description is missing one important
detail: KEY_ALLOC_QUOTA_OVERRUN bypasses the maxkeys and maxbytes
checks.

This is the exact reason why this fix is needed and commit message
does not properly address that i.e. lacks the actual root cause.

Also:

1. keyctl_chown_key() checks against maxkeys and maxbytes so it 
   is clear.
2. key_payload_reserve() checs against maxbytes.

Br, Jarkko
