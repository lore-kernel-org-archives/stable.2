Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794746016;
	b=H8eaa1RuxBsxmRn6QFAl9f7BA1KYts2Ww5vih9tGNeo7b05l1jRUAqtQn2SF2F7DXVF2
	 NydZ0pb4WAaQMgdOVakIZXIvUmyY6+sdVbpzJyuKgl8nbt74BbzFjuQiG1dHCgh7Fzksa
	 +oscYZifxcet2BWzfsI5EArs9PSRrWjWXpMpLyyud0GfksMAnRbqpQoEG2ylH4n040uxp
	 hcwSJPsqbHuoZdAE05sv3dHD0FV/hVXgBLqwtldnF2ojH4jxR761jBZIDzPwACZDm/v1c
	 MUd2JvKJkUDFxYCdaP4OEdUdG6ylc4m+ZBunJqREEyjTTRkeOQasH/WfNMgZdguq/hg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794746016;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 References:MIME-Version:Content-Type:Content-Disposition:In-Reply-To;
	bh=BO246RphuzY/DrEjzoUVe0XefTBKEGV6YAQpWNCx62M=;
	b=NXQFC6b7EWWjTiogyslw/hqUiXnyFB7ndSt8tFrhw5xrjBlBMhxLV2du6X9Yq/o8zXfP
	 jiAhW6LqXP7mjNOnNYla1O3sygTtoCzcPCwupTdplB3uUqXZ6V1ecX0PoohB7eAYCf10z
	 We1l4pJUMRM9LZLWtepXoA4pMo/+b9xiIypwnGt1CkvECiorZn2BtU1FshyfuLD+t8QrV
	 sEe3ML4Ypmv6YWVWiY3MZgAHT75RCj+p0/eyE4a8RtioX/7hF8QkfCideYdBG+pTq/59Z
	 cV9vP6MoWaAZf9IHnYUiadunQvTihhtgqTvFvCK9ksU/OP1yixF2P83CFwqnAEgJhBA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=LtJ6RtOK;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with UTF8SMTPS id F25B7606A31E;
	Sun, 15 Nov 2026 12:33:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=LtJ6RtOK
Received: by smtp.kernel.org (Postfix) with UTF8SMTPSA id 4A7A11F000C9;
	Sun, 15 Nov 2026 12:33:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794746015;
	bh=BO246RphuzY/DrEjzoUVe0XefTBKEGV6YAQpWNCx62M=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=LtJ6RtOKs02Otv7TADMcCxrEypSYbPf1GlT0OwXOP6go1fD6hhlIGU2b95psS2kvK
	 OvZeeFpUy6zC40XrC8lneqtdEEynPJUkruWd1oIGhzhFapepYik9op9hEBL/2cCIaX
	 CNYEl8VL/2RL/o5m7PtVEyKWmNTQs2e8JWcmdakpDjXO26F3r2jY0tBLi5BJmwIzEl
	 R6sNfFWNbVBUcckyqWd8B0Xu/+fvuKplo//9J5AdzYaaIXo1q3Ee3NXmXOrN24BOwE
	 jqTgNuUlqR5Tx8USYyDbnWMK/ls9g+1qsVLEUXkC9vGkqymQfSDFLOKAJLJjnsL9IM
	 V+yLIf/mzbFLw==
Date: Sun, 15 Nov 2026 14:33:32 +0200
From: Jarkko Sakkinen <jarkko@kernel.org>
To: Sinan Turunc <enscrpt@pm.me>
Cc: David Howells <dhowells@redhat.com>, paul@paul-moore.com,
	jmorris@namei.org, serge@hallyn.com, keyrings@vger.kernel.org,
	linux-security-module@vger.kernel.org, linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: Re: [PATCH] keys: serialise instantiation against keyctl_chown_key
Message-ID: <avmmnHsz2vDUk8HO@kernel.org>
References: <20261115121722.206-1-enscrpt@pm.me>
 <avml2-lpRCJYlHOp@kernel.org>
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
In-Reply-To: <avml2-lpRCJYlHOp@kernel.org>

On Sun, Nov 15, 2026 at 02:30:23PM +0200, Jarkko Sakkinen wrote:
> Please review the LLM generated patch yourself at first and write
> a commit message thta you can understand yourself.
> 
> Plus, remove spurious inline comment changes. I'm only then going
> to review this.

I.e., I have serious concerns that you might not know what you're
doing. Well-formed commit is the way to get evidence on that.

br, Jarkko
