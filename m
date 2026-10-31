Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793440166;
	b=LQcPLFS8drX8jZrU7QzcIlyUSkKLQPEmaZ/5NKk0+oMIvyhPBB04H6Way1i+3BwNlcxZ
	 v+U3nbBHNfDdUZ67BxDAMf6MCBX8nAhsd1jvVaYRzHqEgMtM9D1ps0tq/M6Gu9cw7V8rL
	 3Bbf87MOBmwcotCiuS8azIzqFjvwHS0VaIEl3UQXKl2T3q4y1t885EpaEy89tMD0P5pqf
	 s7iVs+iZhxReWR0bGDd3BKPKE/CC17GfMnwFd8f3VEp+uu+Nbz2lyWgC5XQkeBUy5dmMj
	 GvQspWY+6PVb5cuD0lpAfBTFUJzWxM/VYDg/iiWHq47Z/XgUGvbXcBKNsKeMgAbwq2A==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793440166;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 References:MIME-Version:Content-Type:Content-Disposition:In-Reply-To;
	bh=rZ1QUgF5Wn869NtHgEzrQvpkmj17z/XZt5x5Ck7PREo=;
	b=sJmEHARAoqD5t7WOrp75NbnTnzXSEq0Ra8VRFGm9FP1ARg4jrEpQbj+m/dmQazEhjpkU
	 U5EVF1hqa8K0Z02XUCMy3HiV5ZBpo/BswlZRLwJsvw1YybWfcyMcGPfBCjCwY6Q0LYpuo
	 hh4TdAMsHKZnKHW/g2rvxTostbvo2vmwX+xN2Rg7HNsNrd7YvNbHLWpDwguvvPGDt6wB9
	 nF55ouZKa1CdtEn9ZF5pkSyG3XYiVTEL7UMMQBCuSvs5jD/BcWZvIS9XgqPm8F/fJdPYR
	 4SLv9KrYqaCZ95l+2U4/o5WVW22RKFKJ9TLBLhN/Pc2ecQWPkaVv7amNdO4audLJoSw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=VySt+kOr;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with UTF8SMTPS id 805C7606A324;
	Sat, 31 Oct 2026 09:49:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=VySt+kOr
Received: by smtp.kernel.org (Postfix) with UTF8SMTPSA id 9F9AC1F00919;
	Sat, 31 Oct 2026 09:49:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793440166;
	bh=rZ1QUgF5Wn869NtHgEzrQvpkmj17z/XZt5x5Ck7PREo=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=VySt+kOrreYlFHN5gKrUaKjEV9+gQgq3VUEygWX1Og1b8x1sKXlOwxlNf2AJAUlW8
	 wMX4iPvq1tWcgGzogLN1/45E40E29bG4KDyFu6dNlO7gAAOYmlYkXZz6wMltQzeFH8
	 +nqTZlPASNU2WDljK59I2f3FKRAogs6ZdF3tk0XZ2eGI0Lu1Uc17qVtInOPWAS7eZD
	 wabTqtoKrFXm1ZnvycRozqpH6H4/puTBOIdEFZMPO5lm/4UhjGF/YEo8Cca9fKvLOE
	 BBdxCPqZEPn+Gbz8hsDMr9JLJ8YxDsHXrtnztEA9B8Tzws/5ORwobTbzKRKoWhQ7PK
	 ZEboe98oLn5Mg==
Date: Sat, 31 Oct 2026 11:49:22 +0200
From: Jarkko Sakkinen <jarkko@kernel.org>
To: David Howells <dhowells@redhat.com>
Cc: Eric Biggers <ebiggers@kernel.org>, linux-integrity@vger.kernel.org,
	stable@vger.kernel.org,
	Anvik Loitongbam <permissiontogallop@gmail.com>,
	Paul Moore <paul@paul-moore.com>, James Morris <jmorris@namei.org>,
	"Serge E. Hallyn" <serge@hallyn.com>,
	Mimi Zohar <zohar@linux.vnet.ibm.com>,
	"open list:KEYS/KEYRINGS" <keyrings@vger.kernel.org>,
	"open list:SECURITY SUBSYSTEM" <linux-security-module@vger.kernel.org>,
	open list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] KEYS: Reject restricted dest_keyring in
 construct_alloc_key()
Message-ID: <auW5oonD4v63Cog6@kernel.org>
References: <20261031092820.497238-1-jarkko@kernel.org>
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
In-Reply-To: <20261031092820.497238-1-jarkko@kernel.org>

On Sat, Oct 31, 2026 at 11:28:18AM +0200, Jarkko Sakkinen wrote:
> construct_alloc_key() links keys into dest_keyring without checking
> restrict_link, allowing keys whose key->state reaches KEY_IS_POSITIVE to
> remain in a restricted keyring when instantiated without relinking into
> dest_keyring. Reject restricted destination keyrings with -EPERM after
> __key_link_lock() unless KEY_ALLOC_BYPASS_RESTRICTION is set.
> 
> Cc: stable@vger.kernel.org
> Fixes: 5ac7eace2d00 ("KEYS: Add a facility to restrict new links into a keyring")
> Reported-by: Anvik Loitongbam <permissiontogallop@gmail.com>
> Closes: https://lore.kernel.org/keyrings/20261030173930.40948-1-permissiontogallop@gmail.com/
> Signed-off-by: Jarkko Sakkinen <jarkko@kernel.org>

I don't understand why this came out twice. I must have forgot to add
--dry-run when I trialed it. Sorry about that; was unintended.

Br, Jarkko
