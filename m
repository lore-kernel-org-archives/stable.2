Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793967456;
	b=W04fBanTJw3K9E9mwEc812bNBaVYG+XBRxnaHE9MwGUuSCvaNI3BE7ko7uA57Ib1V89O
	 GyqUOz27+J1AVpdB9s02hVFKz8VtXUtyO+JNvEd5WvUtz5k37KsT0r2K4IiGZLjqnbOU5
	 USQK5SooPM1j8NoqyU8SUmuXFGVasPS0UVaRGwYQ595294VXJRNW2wjLiQ5xIpMzE4vTC
	 Dt3y3L+SmFcYl24WZiPD/VLytih1HTqX0i8L9d9UF1EfzSe+f3FQAWlIJAWbU4xwmd740
	 bdoASYB8tsvKOv3LMcvlczoWtpLf9eSwudbmS8gFf7Muc5p4XZGND5YOt6w76Qru78A==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793967456;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 References:MIME-Version:Content-Type:Content-Disposition:In-Reply-To;
	bh=K0F12eVq6pVIQK4QXRpq0UoyWpPy8goPaCprht+deEw=;
	b=uBwqbAvC26098RQd/lJNCsUcYnj6kSlZsef2M5TpHzLlRWXY3fe5tWhnRWAQmTgr6w/0
	 Oq/1+JIU/4yWaEhiXyODZG/U2x3Ot8i7U9qYPCfMpYSL3djuibvt/g21TjxVGDs61VlEG
	 UERWjhA0/ULOYh7ZciA2HnN9HOHanJuhx4jbWdI5RfMRTBTIQfj6cOzyYFOxk9WLz4taO
	 EpYHKsm26UY2oJdJ0PuaL0dXCUlAS4t4PrfivXT6wEXCWs+g7f6qlCLUO15pbYq00E+mW
	 yZ1ZXGQROJ72AXZ4oE/bzL/M40/kQoBsyh2ANYAAr7OjevaE2FE+IlqyqwGVgEPtCzQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=kovEYkcs;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 55DB6606A326;
	Fri,  6 Nov 2026 12:17:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=kovEYkcs
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 057141F008A2;
	Fri,  6 Nov 2026 12:17:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793967455;
	bh=K0F12eVq6pVIQK4QXRpq0UoyWpPy8goPaCprht+deEw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=kovEYkcsZWegaqfGTsc3dbTFvkaBD1XFpSpsuTHgVktR388C3duDiahBvOMCCIAOE
	 n+7v59wLFRjJC6+lTOyUGBFzaNUPmDRgt71MxHNNXVCqNOzEKlEG58cCv4jWYqcuT0
	 oWEGnztMg6qE4m06wpLz3i+cMkKcNB/xfMXctdemAE0BOUOo+lvPjCFzosaf9eqC7C
	 XFk+X3VoHANnNlOj9SyQastt3GBLbd2zoL/2W5hrbvzOMG6B9bmFKKfbVMICGGvL13
	 75OrG/Kbwfp6HD5uRQL1YOmM1UWtUXBxBvSyhvN3NFYHLiLHV6ZdxN6ggHbJ3e60s7
	 q8XCl8Zy/jYTQ==
Date: Fri, 6 Nov 2026 12:17:31 +0000
From: Simon Horman <horms@kernel.org>
To: Wentao Liang <vulab@iscas.ac.cn>
Cc: Elad Nachman <enachman@marvell.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@kernel.org>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: Re: [PATCH] net: prestera: release the ruleset in
 prestera_flower_prio_get
Message-ID: <20261106121731.GI865646@horms.kernel.org>
References: <20261103100532.1309990-1-vulab@iscas.ac.cn>
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
In-Reply-To: <20261103100532.1309990-1-vulab@iscas.ac.cn>

On Tue, Nov 03, 2026 at 10:05:32AM +0000, Wentao Liang wrote:
> prestera_flower_prio_get() looks up the ruleset with
> prestera_acl_ruleset_lookup(), which increments its reference count,
> but returns without calling prestera_acl_ruleset_put().
> 
> The ruleset reference is leaked on every successful priority query.
> Release it after the priority range has been copied out.
> 
> Fixes: 44af95718fed ("net: prestera: manage matchall and flower priorities")
> Cc: stable@vger.kernel.org
> Assisted-by: DeepSeek-V4.1-Flash and OpenAI Codex
> Signed-off-by: Wentao Liang <vulab@iscas.ac.cn>

Hi Wentao,

While I have reservations about the large number of patches you
have sent to netdev in the past days, as others have commented,
I do believe this patch is correct.

Reviewed-by: Simon Horman <horms@kernel.org>
