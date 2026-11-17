Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794932591;
	b=W4bsnLiyQXf3BlfsXrsPS2loE05DLoYZDi4VxyLNzDMLTmW1Ik+F223op+qSQSDSiJL/
	 ndIJiE9b/n/2MPX3sf1K0oy+RXo+ZHKlGg3xbYeCTXxEI7FUDXeT35C7QnSbly8HrMZsy
	 W3Nd8QVDyGwFgXLO1PO71oMWALllF+x+C3EmhUurAM7Xd8s8ovQAK0BvlpUDND1t4NWXQ
	 3CfUIWhmMSVz0kBQqHM9o2xJk8znj4SsS5FPPtt3oCt6RuImWYZ8rdT/9MiqtHeeO59T6
	 ywn/20Bbon1LIQsS3xvHD+etUeoN2SL7VbNN2u+cqCcBeWMkgAphpNv2jOwAX82HLJg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794932591;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 References:MIME-Version:Content-Type:Content-Disposition:In-Reply-To;
	bh=RmDX99UUbaUuuroC6I2ybrzbZM1pwPC97hDvxVqjK4s=;
	b=LZ3sqKeFl58D0ZvrMCcHWqmwEeaUqDwCpufBTYUcZio9TuBr//Xo3tB0zymRGD/v5yWE
	 MkpNPlNw9QRa1h25COFcHNGjlgcx+Jf33lij6Z8teJtXGQ0zduD4o+kL6HX+8TGeXDTwH
	 qxsGInCg/N9ItKUoZCDcFHtryRWd09P4/Qbpn4khASVYmiEyegsbSV60yuzIPL3Tyr3N6
	 RBjP2J770sNWHf+0SUXQzwCzCfG4AirpJgkwUBTIsFR08wjKgXR4LwksVo4n9b9Fb7ptt
	 Qtq9IE3r3JqKoPOEJ3ZElXUUG3+8s5dLms/U+stJ7NeOKUCwTSkRs2v1dRy6fd/3kVQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=W6I+OJLt;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with UTF8SMTPS id 41A10606A31C;
	Tue, 17 Nov 2026 16:23:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=W6I+OJLt
Received: by smtp.kernel.org (Postfix) with UTF8SMTPSA id 906B41F000C5;
	Tue, 17 Nov 2026 16:23:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794932591;
	bh=RmDX99UUbaUuuroC6I2ybrzbZM1pwPC97hDvxVqjK4s=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=W6I+OJLtuZzBBqh43lEEMPiTbNGWHOEXIQjp3gpVtlcUXd6miMrKYVwzD9p3EBQvG
	 5Q1AoFqA4vsFvQTLNJGz7/JfCNDFLdV8Zoc3xlX5iv6niPPZkkIxnj/uYrhL+pzEdi
	 JrQlpWu2gTixYsqlu74pWgOla6MEtnHj8zWPK5GGxyLCy6MbqF0srQoBanVJiYjH4/
	 p/QaQpmjxE4lOm2Yts4GuXsp3/frKVW9Xa1JG3s1gBxM0/gZHQL/7FcU2TUe+rGn4C
	 e6kqo9OLUKAdlhGFCGMIC4IPXdxY8KWeZUYz72UKeNwuMqjc3HC7c+vH52kwWnKZim
	 2p6vp8/XLxUMw==
Date: Tue, 17 Nov 2026 18:23:07 +0200
From: Jarkko Sakkinen <jarkko@kernel.org>
To: Sinan Turunc <enscrpt@pm.me>
Cc: David Howells <dhowells@redhat.com>, paul@paul-moore.com,
	jmorris@namei.org, serge@hallyn.com, keyrings@vger.kernel.org,
	linux-security-module@vger.kernel.org, linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: Re: [PATCH v2] keys: serialise key instantiation against
 keyctl_chown_key()
Message-ID: <avx_axeHCenqxY_G@kernel.org>
References: <20261117123353.1822-1-enscrpt@pm.me>
 <avx_Eu0rbWtwPDGK@kernel.org>
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
In-Reply-To: <avx_Eu0rbWtwPDGK@kernel.org>

On Tue, Nov 17, 2026 at 06:21:43PM +0200, Jarkko Sakkinen wrote:
> On Tue, Nov 17, 2026 at 12:34:12PM +0000, Sinan Turunc wrote:
> > Subclass 2 is an unused lockdep subclass that is
> > only ever taken inside key_construction_mutex. Subclasses 0 and 1 are
> > already taken outside keyring_serialise_link_lock by __key_link_lock() and
> > __key_move_lock().
> 
> Delete also this as there was no bug associated with nesting levels.
> 
> And this does not need additional fixes despite I forewarned about that.
> 
> I'll wait for v3.

"Take key->sem for write with down_write_nested(&key->sem, 2) inside
key_construction_mutex in __key_instantiate_and_link() and
key_reject_and_link()."

This sentence tells everything about nesting that this patch requires.

Br, Jarkko
