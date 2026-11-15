Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794746496;
	b=HGj+NYjPAXclP5DH49GaRxNP2lrj78GygVJZuiq9H5uOfbg/WISMHqDlj5kT2efCKi4Z
	 RgvRQ1aDvaR5010A2WY5aE3s2x/jwtHsn560H0D0FF0avl1BFUoT7sHWKs4rdWRG5jrTp
	 q19K0fwiJWp9JQ5Ik/cTN+KvN+NBtZF5a1V7PBfD6raHRfI/60L80jsmxEjkrotOZEYos
	 Mw8vmCIHCD/jPo2OC0CwedWFMM66Y4a91zVykYD/VChxZ62NdNOLFOxA2Jfnuh0gUq7/s
	 d0XLYahWldUBjDTEvVNli+9E/XGGE5ft7PHucahbWzSZ707+qltji8dnZqayGJ0cAGw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794746496;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 References:MIME-Version:Content-Type:Content-Disposition:In-Reply-To;
	bh=LzcXdrOgQ1HaUj250QGR/Dchu7w4hQjXhuOLUavjkoE=;
	b=Ii17EeR4N7HjEnsVvSuw88xdMz+Yiuvuk+EXWkFMrEQNa45I4tq+gxXIe7SSe2GMokWf
	 GzpXOxVnp2oePEO1AB2UihLmfrxqNm2t5biYQ0nq8MKQO6YcA6ol4hXWHQ8n8aul+m8BZ
	 G0lbLpiUTkU1JR32Zl4djO2FhMgkAkWHDRbnRPiRjaiACjHDgdbrQv/uLxybSFCAOSim8
	 JpufT7ZgOFPeZOOIaFtppkfSQDv8QhRr8CPjbcL6xNeol9MC7LDvp0gOjcSMqCuUOcbdH
	 36ywW3bbjZIHF2OhknTjM+bHRAccuTgnHs+naFJ7xTW982o7san7aiNP8DFSc2kSLyw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=NI6P9MDg;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with UTF8SMTPS id EE2E6606A31D;
	Sun, 15 Nov 2026 12:41:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=NI6P9MDg
Received: by smtp.kernel.org (Postfix) with UTF8SMTPSA id 1FA0D1F000C4;
	Sun, 15 Nov 2026 12:41:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794746495;
	bh=LzcXdrOgQ1HaUj250QGR/Dchu7w4hQjXhuOLUavjkoE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=NI6P9MDgHPfKp+q4hLzNUBAYUtlquAxXePLDvoc9WwFHK/jghw4F0pPs3HBBG5fHE
	 RuEpsSet6vFUwEtOX9gOkCj9oYNRplLqEMVkCVLL6hsio1D+/8wB4bAPRbrmdWmcdU
	 2kbaP3gx+I3PvMshgqrDIdAu1pFbta6HK3crCjg7Icc0G+kiRZTDREGPdLqVF3Ej53
	 M0PoDc7+UZkcBd7Wq6EPqAf671pYS4QGB8iCQ7Et0fP5PEMFZfny0aKVLDeJharu/E
	 wvVVHoOxs9a1o/2u0oPAV6qgtPT62WMU/8j55SfTuUwYxJuxLM5CfuxUA2dPDhgHMF
	 LW+rralqOUWzw==
Date: Sun, 15 Nov 2026 14:41:31 +0200
From: Jarkko Sakkinen <jarkko@kernel.org>
To: Sinan Turunc <enscrpt@pm.me>
Cc: David Howells <dhowells@redhat.com>, paul@paul-moore.com,
	jmorris@namei.org, serge@hallyn.com, keyrings@vger.kernel.org,
	linux-security-module@vger.kernel.org, linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: Re: [PATCH] keys: serialise instantiation against keyctl_chown_key
Message-ID: <avmoe41hNwe5GryN@kernel.org>
References: <20261115121722.206-1-enscrpt@pm.me>
 <avml2-lpRCJYlHOp@kernel.org>
 <avmmnHsz2vDUk8HO@kernel.org>
 <avmnRbuvbSg2fCVg@kernel.org>
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
In-Reply-To: <avmnRbuvbSg2fCVg@kernel.org>

On Sun, Nov 15, 2026 at 02:36:25PM +0200, Jarkko Sakkinen wrote:
> On Sun, Nov 15, 2026 at 02:33:36PM +0200, Jarkko Sakkinen wrote:
> > On Sun, Nov 15, 2026 at 02:30:23PM +0200, Jarkko Sakkinen wrote:
> > > Please review the LLM generated patch yourself at first and write
> > > a commit message thta you can understand yourself.
> > > 
> > > Plus, remove spurious inline comment changes. I'm only then going
> > > to review this.
> > 
> > I.e., I have serious concerns that you might not know what you're
> > doing. Well-formed commit is the way to get evidence on that.
> 
> E.g., if I pick and write proper explanation instead of slop,
> should I call it my own?
> 
> To have a review process, there must be two who think. Otherwise,
> it is just me figuring out all of this; and LLM. You have no role.
> 
> This is also why it is important to write proper commits.

Finally, while not knowing if this is the case, it is irresponsible
as hell to send patches to subsystems like keyrings *if* you don't
understand yourself exactly what you are doing.

Leaf driver mixes up only that leave driver; an uncosidered fix to
a subsystem that is always on  side-effects can do much worse.

Have you considered this?

I'll hold for for v2 :-) Just do the work properly. That's all.

Br, Jarkko
