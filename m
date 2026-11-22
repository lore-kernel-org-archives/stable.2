Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795310555;
	b=wiCvUUqapfGpV+6/wApt0BEzJuM0bQFYlyWlsyvJ9hGa1kF1AVcRH+tgteyVdasCrUUH
	 y7C5UcsAdCyDtsk5XylvLR2bvI7ZwLdMCgSbovv1F0ivBosUca39RIOPacXv/6xlqo9nJ
	 IRzS6p1u4AYvJwCFBjSaWCDPoUAOXPAA9J4dV4+54b4uDR27W854+bt/wZP02fz5bNqSm
	 8NRCkRMGBjc+lQk18OLfclyMGERzoZiD/zlQzO73/HvfVZBONVlCkJ6Rz+ml9kpPTkth/
	 3XahctyzOR54ALtq6xbdCNQl4iyVHloT58KtFR8oer7xD5ljdBnMzTaJ1So03bsYuzw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795310555;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=zE8gT4dthHqcTUv77ew8bDqnQXZvGmO379GEAq+aYmM=;
	b=sdo5KUFhLbm2LwK8zyITvEFA7+MY0OCJSb+7zLZs02d/+1myGjbpSy/7HJ1+XyNKgFky
	 gCnZ7hqgK1MBxEgxCWPrhHXJjKANdVDyCwLAqN+bF4RRTN8iYRCSkEqJ6z69SjzUr87NU
	 Gx5DG1GGBcHUjfZyYzeJyFLm/C3zOCvtWQjeUmpK18u0N4Uaf/aQjpttvYAQ2mwbsHkJS
	 TVoGVxu2eqA/o9f/iGnsN1me3I5V9nXnDCaM6/n4oZtBqzndLcD06yq4MY3elP+O3An0i
	 AfglNrnhoRaSMLjA2gIIDgg2DQpiPPQx0PXfV/nIUivqxU0roganlQdyz8PDOek5JaA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=BOjEfvAw;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 26B96606A320;
	Sun, 22 Nov 2026 01:22:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=BOjEfvAw
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7BFF31F000C4;
	Sun, 22 Nov 2026 01:22:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795310554;
	bh=zE8gT4dthHqcTUv77ew8bDqnQXZvGmO379GEAq+aYmM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=BOjEfvAwidbckoqjR4wNrgB9CbuljWYbNZOEhAFhqfQ4NZayeIpUIJzYmE29QtyEE
	 6tUxCfwpDQJ/uMb6T24gDoLrh3q3I6oNui1kvs4kx4SOQzEhVy0iDeRGqQo4Q1m5Fx
	 bsSu/X+eX+G2/aE57Ofwxjt1+ouyLaYjhdahM9ds6Mf+JaUVYz+Rb7tQj8f3O3pLTq
	 G8TWLbT3sBC35XU2vlD4nCJ9ERR2OwIYJV18BZoZGuYRwB//xd0N4pvlcjTxbeF7m9
	 DPxA2bZWE+dFcJ5DYsJbVG8TiodDTrShUt7xleVmTU5lh20SvmBGrRzAJ4IkQ77tGX
	 +pAVZa5vTkvgg==
From: SJ Park <sj@kernel.org>
To: Yifan Feng <evanfengff@gmail.com>
Cc: SJ Park <sj@kernel.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	damon@lists.linux.dev,
	linux-mm@kvack.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: Re: [PATCH] mm/damon/core: do not overwrite wmarks.activated in damos_commit()
Date: Sat, 21 Nov 2026 17:22:21 -0800
Message-ID: <20261122012222.148520-1-sj@kernel.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20261122002930.98401-1-evanfengff@gmail.com>
References: 
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On Sat, 21 Nov 2026 16:29:30 -0800 Yifan Feng <evanfengff@gmail.com> wrote:

> damos_commit() copies the whole wmarks struct from the source scheme,
> including the private 'activated' field.  The source scheme is a new
> one, so the field is always true there.
> 
> As a result, a commit turns on a scheme that the watermarks turned off.
> If the metric is between mid and high at that time, the scheme keeps
> running, though it should stay off until the metric goes below mid.
> DAMON_RECLAIM and DAMON_LRU_SORT use the same path for commit_inputs.
> 
> Save 'activated' before the copy and restore it after.

Thank you for finding the issue and sharing this patch.

> Do not restore
> it for DAMOS_WMARK_NONE, because nothing sets it again in that case and
> the scheme would stay off.

Is this really necessary?  If not, I'd prefer restoring it always for
simplicity.


Thanks,
SJ

[...]
