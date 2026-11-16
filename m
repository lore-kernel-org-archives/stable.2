Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794822804;
	b=DspA/SEmOB8dh7CeYNc7Tz9bBOqgMIGoipTa0JC9KHB+PH1uHfSj83Ll1RkjR2Gu7rHc
	 JtEclfjP2khtt38QVltOgY2G/yWlntP2MBGfLoNl2/Dp/wZcMHQkbfdfO6WSzYJ9tPeNZ
	 IyMLQ1QITiUlV27kF+76fhYHkeS/2o2D9mkoTlpUWB/joaoW4P7pCFXPO5c8vr5MAtMV6
	 vXd6o3vlkGgS8earcPzG569nEQPMie+axQLFdhG4UI+pTBh31fp0pW8TS+4iU+V/SdJkA
	 sF+f4x6LeW9rI8syixBTaqqr23ayZIoC4L4z9tjV4jvblFqIv/jl5n1P3jFDxsIb7YA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794822804;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 References:MIME-Version:Content-Type:Content-Disposition:In-Reply-To;
	bh=86ohtxTvSaBHSGY2DmtY/5Zzi74x0UKFvz0vz8fUu/I=;
	b=Pc5kyt+6uqjgWfgDNpPk3KJEOOSO+fsMQrnA5i6L6mKJFEp3R/TYINBV4xkkBXOeXOT4
	 eB2ZXZmhnMs+VJhVgZ2GO0PeKYQx+W+Gd8sruFXHA/UizoPz+VzmtQQKqAmW79ja2miJT
	 cBGUaO9wAWzBffALZjyHYQecgmQJo6o1FRRm99S6OCTDure0RnsCcZYhcziPfLQWB7MPY
	 qn+5VyL6B2G7tZrxWcWD4eSJ7dtgIPGbuOn4VH0hxUFE/7n7/JrUJjRqiV257kU6VVvru
	 gp76whKEo56yBI5MQacnDYL7Rf2cQuCGrrk9SCArV0pgm4xYc4WF1KQYCkTWybaXmRQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=JTxKyHr3;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with UTF8SMTPS id 7634E606A31C;
	Mon, 16 Nov 2026 09:53:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=JTxKyHr3
Received: by smtp.kernel.org (Postfix) with UTF8SMTPSA id 993491F000C4;
	Mon, 16 Nov 2026 09:53:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794822804;
	bh=86ohtxTvSaBHSGY2DmtY/5Zzi74x0UKFvz0vz8fUu/I=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=JTxKyHr31jO+92h0pBpMOuP625dM5BZcQlfCJjvaAiNj4laFmnmrjhNzL/7EghWNG
	 55YGNcqoAFV6T+q/KLEaal4zdSA/cXctkjAogAoEBMwcR82JgMcPVJIUiiFveB1esU
	 zdd8msoLksJJKuzDOeZ0SyGlmcJoq8CQEuztMRDSaOIdopAd/NKRiVWU1ybzUtbw2r
	 OjvBkMaDIck6fWJhuhsfRyZ6ZZ4Q67jq8b0JdaVa/yu10x3BULEWZTlf39YpuCFW00
	 ibJTWoTluwS7muE7dXcHcjz6Y5JVIYZnUEDFuGFC62he7UbDRWIm9iMYgana8/Iy14
	 d2cYAYG9AhPwg==
Date: Mon, 16 Nov 2026 11:53:19 +0200
From: Jarkko Sakkinen <jarkko@kernel.org>
To: Jonathan McDowell <noodles@earth.li>
Cc: linux-integrity@vger.kernel.org, keyrings@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-security-module@vger.kernel.org,
	Alec Brown <alec.r.brown@oracle.com>,
	"Daniel P. Smith" <dpsmith@apertussolutions.com>,
	David Howells <dhowells@redhat.com>,
	Eric Biggers <ebiggers@kernel.org>,
	James Bottomley <James.Bottomley@hansenpartnership.com>,
	James Morris <jmorris@namei.org>, Jason Gunthorpe <jgg@ziepe.ca>,
	Matthew Garrett <mjg59@srcf.ucam.org>,
	Mimi Zohar <zohar@linux.ibm.com>, Paul Moore <paul@paul-moore.com>,
	Peter Huewe <peterhuewe@gmx.de>,
	Roberto Sassu <roberto.sassu@huawei.com>,
	Ross Philipson <ross.philipson@gmail.com>,
	"Serge E. Hallyn" <serge@hallyn.com>, stable@vger.kernel.org
Subject: Re: [PATCH v3 1/5] tpm2-sessions: Drop TPM2_NAME_SIZE
Message-ID: <avrSj7gxIaBLRn1d@kernel.org>
References: <20261116005105.1573016-1-jarkko@kernel.org>
 <20261116005105.1573016-2-jarkko@kernel.org>
 <avrQTPj-iwlrUvcp@earth.li>
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
In-Reply-To: <avrQTPj-iwlrUvcp@earth.li>

On Mon, Nov 16, 2026 at 09:43:40AM +0000, Jonathan McDowell wrote:
> On Mon, Nov 16, 2026 at 02:51:00AM +0200, Jarkko Sakkinen wrote:
> > TPM2_NAME_SIZE was left to include/linux/tpm.h when the base definitions
> > were consolidated. Switch struct tpm2_auth to TPM2_MAX_NAME_SIZE and
> > convert TPM2_NAME_SIZE users to TPM2_NULL_NAME_SIZE, removing the
> > redundant TPM2_NAME_SIZE definition.
> > 
> > Cc: stable@vger.kernel.org # v7.3+
> > Fixes: 88c5a62c3af7 ("tpm: Move TPM common base definitions to the command header")
> > Signed-off-by: Jarkko Sakkinen <jarkko@kernel.org>
> 
> Reviewed-by: Jonathan McDowell <noodles@meta.com>

Thanks. I was not exactly sure (since time has passed) whether this
should have had your R-by so I just in case dropped it :-)

Cleaning up the dirt from tpm2-sessions suddenly became more relevant
as Matthew sent "hibernate for lockdown" patches; so I thought that
these patches would be a low-barrier kickoff towards that direction.

Br, Jarkko
