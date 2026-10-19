Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792443319;
	b=QyqeZcrX4grhpJb+tg3AiUQx3xvy6iFX3SFgq8FI0rtqKFv/j40O0ckSpl3X9+3BmLfU
	 EqiGjSNDywlaMktcG716aw3ghEeWxmWEAkAj0CK6e3JLQrQEbRKkxqdiCNvQrrLcrYNFh
	 /vLYSfByfMjKIHS1InNU/JTY0q2PHj2N+l97HDvXKvo8I1jg6YJJZZOaf894Mtk/2Ex+r
	 p0WRYW7vk46Wlgd13zKcDQVLJF5ijxF9XLUkLXOvvWbBcl1aUy/f4edck8X6ZztSaSCzF
	 10jDZHY7JyHP/Q18ANDqwkthS97XI2MnUintzyl6UoPUFc5i0BuAbNubDly0ZGQCpyg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792443319;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 References:MIME-Version:Content-Type:Content-Disposition:In-Reply-To;
	bh=g0aYEteT0WSPpmjNie8DOc6kUaUC0ZmccLDoL+rDhXY=;
	b=mvwAHx99/MGa3d5ORBvSm/ivUcY52dX1HHkOGsuP/pbe0VAKOmnKxeitleTxpG9uXq9/
	 /vlloEXWo8HxzXkpsGMGmDzCiT/0A5rNFhdLkWU2z1w8SkKQDJC7fW8YG10MCHpDt1aNa
	 fbXoiUoUyc9nOpfD42NOwO/mhk7cLQdPexz8w0xU7FLey7HshxZhezsHBHcFOJMdrUsvd
	 nMB7Q09XpNMcYVaBm/dQ1ucX9NAUX4ukYbXpzov+8hAV0XNr6wF2c5bl3co5JgMkxEl9v
	 uM13isSx7+Z/TZXhVIC2qnigdsQmjfyV6pnQACN87g3FLrT9d/4c2YeXtWTOnaiyQrQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=H0n15xp4;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with UTF8SMTPS id 8368B606A319;
	Mon, 19 Oct 2026 20:55:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=H0n15xp4
Received: by smtp.kernel.org (Postfix) with UTF8SMTPSA id 8DAF31F000C4;
	Mon, 19 Oct 2026 20:55:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792443319;
	bh=g0aYEteT0WSPpmjNie8DOc6kUaUC0ZmccLDoL+rDhXY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=H0n15xp4paFaFgCvAAh0+3kCDPPMQntyRHtAMJKo2fTiBc4M2ejR5UX5t1tsxriXE
	 e3DB65FPjtnu5pY6iR4lqM2UxqrtUTk2QU9wNV5oPCbLHZKJffo6cE1wg76cixIx/Z
	 thKcbd7z4I8AxdlK2QZK+kgQO7Fep+tKeiPJsU9TPAH9lzs5YR/rCupf7bNvkGCJGH
	 5mLxhSeOTIBTOIbKmiqrkMKguLCAKEjQKxA0mSW6qqZk8NvWnwtJaIGrVjQPCvt2Pi
	 +Hn4s1TeLJNcpdmOssLsATW638CNfadzgdt51otTj2NwCFcVW0AmPYiBh8G4n9ZTQe
	 RwCcJ7HEY4esA==
Date: Mon, 19 Oct 2026 23:55:15 +0300
From: Jarkko Sakkinen <jarkko@kernel.org>
To: Eric Biggers <ebiggers@kernel.org>
Cc: David Howells <dhowells@redhat.com>, keyrings@vger.kernel.org,
	stable@vger.kernel.org, Paul Moore <paul@paul-moore.com>,
	James Morris <jmorris@namei.org>,
	"Serge E. Hallyn" <serge@hallyn.com>, Andrew Morton <akpm@osdl.org>,
	"open list:SECURITY SUBSYSTEM" <linux-security-module@vger.kernel.org>,
	open list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2 4/6] KEYS: Prevent overflow of quota in key_alloc()
Message-ID: <ataDs4TMkbRjxc_G@kernel.org>
References: <20261019181732.449591-1-jarkko@kernel.org>
 <20261019181732.449591-5-jarkko@kernel.org>
 <20261019192545.GD65095@quark>
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
In-Reply-To: <20261019192545.GD65095@quark>

On Mon, Oct 19, 2026 at 12:25:45PM -0700, Eric Biggers wrote:
> On Mon, Oct 19, 2026 at 09:17:24PM +0300, Jarkko Sakkinen wrote:
> > Check that the calculated quota length does not go over INT_MAX.
> > 
> > Cc: stable@vger.kernel.org
> > Assisted-by: LLM
> > Fixes: 7e047ef5fe2d ("[PATCH] keys: sort out key quota system")
> > Reviewed-by: David Howells <dhowells@redhat.com>
> > Signed-off-by: Jarkko Sakkinen <jarkko@kernel.org>
> 
> Seems this should be merged into patch 3?
> 
> Also is this reachable?  I.e. do any of the key types actually specify
> def_datalen > INT_MAX - KEY_MAX_DESC_SIZE + 1?

This is very good question and my *guess* is that no there is not.

That said, when not treated as a bug fix this patch is a great
safe-guard e.g., to block corraterall effects of some other
bugs.

So yeah, that's I would propose here. Let's not call it a bug fix
but still merge.

> 
> - Eric

Br, Jarkko
