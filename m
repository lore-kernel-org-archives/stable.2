Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792437482;
	b=pXuWN4aVgZhmFDTJ+trRdqxvvlO3dKTKSjfltiJIgGDOyJG4N5Nw4t8DgndM9vPZNOSZ
	 EP5B9zKep4lC0UzCd+n9vn5NrSj4QCbi9kJnqzFO7XQqj1L0/lnCrRRTAILelbGokAKmL
	 ns/rzYqzGRvO/J30jtHtYqnkDLwNmMGLCQGs4UPQqnUKf0ypNwMTHoIwI4fBoyZzaMHKv
	 MVDQ7mJLR0GVyUZzKVKT8iJe1cQWKZLtH9aN9/erh1a+4h3xT6De+hrRn/lCeVOvMWo84
	 qc4hB4NQRsOyqC+oMdWgrsL6+QfUK1Bqcwhhgw1On/kehs+n/phslOi0d5BkDbn4x1A==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792437482;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 References:MIME-Version:Content-Type:Content-Disposition:In-Reply-To;
	bh=HOOxhWe0N25Vvh+QP+0h17bAVDCPz4LE/9nK0BEyyGI=;
	b=wUCEoPEHUJXBorB0dFWkIsPzjUDsIaZ6E/CK7p81nGY8uQlYODj0qgD1apvMlUeznS2j
	 QLqEa0pDz6dGPBfjJWy+XRS3fd4flLy+U018u0nA5OGlAqNLWxmD064qY0IcZT1f8Vkcq
	 MQ5hxa58VfL+MWtd+UojpqthPaz0iKwu8BIyTN37oZBGhWmgcqIo+1d6CFwqa9ZseLqbq
	 TH3N0MjWAJkbVim/JfZqE26G/hIolgSPyeAdZh4jQTtx/ON+poV+PRiE5HUtDgFKRuZSP
	 +DMZwMERtNEThSr6bdMBcXPW90pzLU8JxjIqv+cOxFpnC/V7g55XBj+RjyNwsNb75BA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=LCqqTU6G;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C56FB606A31C;
	Mon, 19 Oct 2026 19:18:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=LCqqTU6G
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 017551F000C4;
	Mon, 19 Oct 2026 19:18:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792437481;
	bh=HOOxhWe0N25Vvh+QP+0h17bAVDCPz4LE/9nK0BEyyGI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=LCqqTU6G2extdImFhREVnfwGUIRAcaS40Wu2sPK7PcgEG5e/17rHq/cNlzXr4QMQx
	 FrMxowqdRm8+rMs7BKMxRMrwTe2kBS1tcSQ4//GSa9/Ev99lJSPaxa2H82umuXHU+V
	 0LNWGZ3eyWrvIfl8/ouRHQvXwFusr+HR3i9kfqdaQ1UIxbQKMtfjKXf+RCVMIP+Zdy
	 xXmRIKfh/SZOoW80+xblSo3OYO/ltnfjJ3s4fLLcJMrRCj29U3UbxQsh9rZZO+4rr3
	 3SAs8cz8k9PnP3tKfmRZdNp8ehtyRrkYRT+7xvQ6JRA+CxuqvIV0j3a7e1Jd/GdUaS
	 c9q4L6xwBRPYA==
Date: Mon, 19 Oct 2026 12:17:59 -0700
From: Eric Biggers <ebiggers@kernel.org>
To: Jarkko Sakkinen <jarkko@kernel.org>
Cc: David Howells <dhowells@redhat.com>, keyrings@vger.kernel.org,
	stable@vger.kernel.org, Paul Moore <paul@paul-moore.com>,
	James Morris <jmorris@namei.org>,
	"Serge E. Hallyn" <serge@hallyn.com>,
	open list <linux-kernel@vger.kernel.org>,
	"open list:SECURITY SUBSYSTEM" <linux-security-module@vger.kernel.org>
Subject: Re: [PATCH v2 2/6] KEYS: Reject @desclen values >= KEY_MAX_DESC_SIZE
 in key_alloc()
Message-ID: <20261019191759.GB65095@quark>
References: <20261019181732.449591-1-jarkko@kernel.org>
 <20261019181732.449591-3-jarkko@kernel.org>
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
In-Reply-To: <20261019181732.449591-3-jarkko@kernel.org>

On Mon, Oct 19, 2026 at 09:17:22PM +0300, Jarkko Sakkinen wrote:
> @desclen in key_alloc() is saved to the 16-bit wide desc_len field in
> struct keyring_index_key.
> 
> Reject @desclen values at or above KEY_MAX_DESC_SIZE with -EINVAL in
> order to account for the NUL terminator and prevent integer overflow.

This should say something like: "in order to match the userspace limit
and avoid u16 truncation".

There are also similar truncations of desc_len to u16 in
key_create_or_update() and keyring_search().

> +#define KEY_MAX_DESC_SIZE 4096

Could use a comment mentioning that it includes the trailing NUL.

- Eric
