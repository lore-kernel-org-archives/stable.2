Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794746186;
	b=LVBfSX/iokIMX0WZl3G0ateFv6p3nuWDEOY2liJ+xs3js3l7YNE535RQhynyThEWq97S
	 e2SRlSrNqIqorCT1CiNQQXZEM0v4XumVnkaS61DPXfnEcDuWXeXrPPBsQ9M5dSeq6RkiO
	 2vMvvad3I6Xig8T81hnVT0kMlWd+baJkqDnvoIrJ7llzK+8x9RwiSe7OKPhwHLH3CQWea
	 EPe6xl9rwzZn4L2gjX0KHrqmmo3r6m+theZNx4qYklwgbvxXjMSAjIj2g303VKdnXRGQD
	 ppNy08ugmaf8mx8lWILm/H04B4f+w7ayTVQtXxCu/KbTMkvmnCnWgMAB7/iN5wJm2GA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794746186;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 References:MIME-Version:Content-Type:Content-Disposition:In-Reply-To;
	bh=L6HQE2xScx8hSo24Z2qW4bWVXNgmQLX5o0MfiCqV4Xg=;
	b=psnxx4fJx9xesEdq4ZKXdPiaz135KGMowTb4rajTLhz8EkE1XRFGNpL54lw4xPG9ohp+
	 01weNG0IqepUsNGa/EER9015FjAOkQNRxu1xXsLbI2RuhkF2EIrK4pVehKt1ppYUZlTfl
	 ephncOYISZ8nB+ba983hyyb/VlkeAfzDOaXoLLjIkEOhmty9+Mfgyd5UFirNxL5OIITGj
	 +1Fe316Jhk9xq09CR0ULzvcarNE6IO+rpFwGIkE0mIY8fjyaQMevhxezVt0sfSI06pWsf
	 VrA6Cw5aUsibXAHyEwHW7n7JSxXZtuJedXTSpRRk+9vIe+S0i89vqSDjc7MqWAGwrVA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=gVyf7hE+;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with UTF8SMTPS id E6814606A31A;
	Sun, 15 Nov 2026 12:36:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=gVyf7hE+
Received: by smtp.kernel.org (Postfix) with UTF8SMTPSA id DBABF1F000C4;
	Sun, 15 Nov 2026 12:36:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794746185;
	bh=L6HQE2xScx8hSo24Z2qW4bWVXNgmQLX5o0MfiCqV4Xg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=gVyf7hE+V5b3HdHZ+pKeP9ajiiMxgp4BBKA7snzww0Bg53T0e2BEDCVn8okva02ir
	 /nvRwy0iReTHxwhSmsYeT87Wz8LokCt+CVg+fI11JKNf4BaaYtW5AssFL/X386Q5s1
	 IaJdiK6367k87CTbS+aoIVVP8uSnQC3sLOQgnmsO6knfLzX2Fn6aEIJGLDbIctY0VP
	 9aILyJwM+j5Aaq/qzt+djhS9Y0NPknFGCL+3adIji7cf6yHwcN7f4yuGHJSDPMq8hg
	 bof8lLmBzEsH1j/9Loneh299UekxESJWGEh0jVlGtBAX45hV7pAf4VLoNNcWwTG/Rm
	 4Mrgr1m057OZA==
Date: Sun, 15 Nov 2026 14:36:21 +0200
From: Jarkko Sakkinen <jarkko@kernel.org>
To: Sinan Turunc <enscrpt@pm.me>
Cc: David Howells <dhowells@redhat.com>, paul@paul-moore.com,
	jmorris@namei.org, serge@hallyn.com, keyrings@vger.kernel.org,
	linux-security-module@vger.kernel.org, linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: Re: [PATCH] keys: serialise instantiation against keyctl_chown_key
Message-ID: <avmnRbuvbSg2fCVg@kernel.org>
References: <20261115121722.206-1-enscrpt@pm.me>
 <avml2-lpRCJYlHOp@kernel.org>
 <avmmnHsz2vDUk8HO@kernel.org>
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
In-Reply-To: <avmmnHsz2vDUk8HO@kernel.org>

On Sun, Nov 15, 2026 at 02:33:36PM +0200, Jarkko Sakkinen wrote:
> On Sun, Nov 15, 2026 at 02:30:23PM +0200, Jarkko Sakkinen wrote:
> > Please review the LLM generated patch yourself at first and write
> > a commit message thta you can understand yourself.
> > 
> > Plus, remove spurious inline comment changes. I'm only then going
> > to review this.
> 
> I.e., I have serious concerns that you might not know what you're
> doing. Well-formed commit is the way to get evidence on that.

E.g., if I pick and write proper explanation instead of slop,
should I call it my own?

To have a review process, there must be two who think. Otherwise,
it is just me figuring out all of this; and LLM. You have no role.

This is also why it is important to write proper commits.

Br, Jarkko
