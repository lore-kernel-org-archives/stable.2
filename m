Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793059294;
	b=XUT6yvRR2wl1T6BOXB/yq4szCFYUFuP6dAK5Eebk/wrqM+t+V7WhkiDrzdaggooksnqP
	 eRebVHXIvpxquh4ipzb5K3K27hiQwdUB1M5RXpoD4t/iPhPSW9ct6lC89hU+qZRFbBfgz
	 40qynNVbZI6K5EDMIpLXszMJKx4kiau3feOcMMHqy04Rakh/GotOA2m2CuLi2kzRvMA3k
	 fr+iEzO4UQY4jlgDHTJFOKKSW7M83SXD2IrQHLbj9/B8bDfnxGbaNyMf9Jax7u/+H39un
	 P9yD684iXrSPKMEadt2kLor835UgEoEq5fBWAnmmShrypfh+6KiLzOgsD7pNP5woR9w==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793059294;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=1Ah8BrrnLsu2f3h+SZaSrIJTZykx5ndF54DrtT2Sjfk=;
	b=uEq2iVFyDl/L8XU5ceCnl/rL522PRWJsCL0/9k/vI7pdnk03tnopiXiwRATLN+FT3r03
	 XW+fmu22DXpqHS9dFI5J854BLAEoOCx8t5g6E2fvI/uyRtSBzm0styu3Fa2f7c6I1YLwA
	 gwxAvkG0qKbNsqwvZEscyU8zgeodkEo0jMy2EfePPbvGimjeEIyoul/qacksM08C4SiKx
	 AEgYprxyVpq3+DvBPbDjTpLW3DmUmpC/+oaguc1OOIXf0JvK39VvxfOPj7yErNxnUxEDw
	 GEgoXyFGitXZETQVKPrfqujK0IwbRzWbd3A5iLKP+O5PIYhwDFflOLXnQhwyCHcfwcw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=h7rOTNav;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CB746606A31D;
	Tue, 27 Oct 2026 00:01:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=h7rOTNav
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 264521F01825;
	Tue, 27 Oct 2026 00:01:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793059293;
	bh=1Ah8BrrnLsu2f3h+SZaSrIJTZykx5ndF54DrtT2Sjfk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=h7rOTNavWHvnY0UaYjX9CW/w7w1qHLGHcxMxhQWYFvyVaApX37ziE1Y2163AzbFeG
	 9YTONgGt3YpegrQqQ7/z+/x2SXLN5K6S9RFe5Cl3+4upqHoLqmoMcSyjOUV2Dt6wKg
	 Eg7eISzf1aIfybVMg+hsdujCTSaRULl6jfbD1Nw3lZJtzw+/9S4fVNxmsc59XScJN9
	 hxHvGp6FcWNwlZgNHB5Wnbyrxof/KlFPNGBREaWeNZNlME2p+7GrBoIsZWUgmbXpJg
	 FsB/b5aZkWQol1GdDcQblZkHQSCB+aExQ8u/Bcsm3vjhp0FxlfDxeT7GiwK/8s1h7W
	 l3iw/RQRlnHYg==
From: SJ Park <sj@kernel.org>
To: Sasha Levin <sashal@kernel.org>
Cc: SJ Park <sj@kernel.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	damon@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org,
	stable@vger.kernel.org
Subject: Re: [RFC PATCH 6.12.y v2] mm/damon/core: error damos_commit_quota_goal() for zero target_value
Date: Mon, 26 Oct 2026 17:01:20 -0700
Message-ID: <20261027000120.156623-1-sj@kernel.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <2026-10-26-1-daily-reply-0007-damon-zero-target-value-6-12@kernel.org>
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

Hello Sasha,

On Mon, 26 Oct 2026 18:55:58 -0400 Sasha Levin <sashal@kernel.org> wrote:

> > Also, the upstream commit on this stable kernel can fix the issue for
> > parameters commit paths but DAMON start path.  That's because DAMON
> > start path does not invoke damon_commit_quota_goals().  To fix the path
> > with minimum change, add a new small validation of quota goal target
> > value before damon_start() call.
> 
> Queued for 6.12, thanks.

I'm sorry but could you please unqueue?  Sashiko found [1] a bug that can leak
pids.

Also, could we avoid queueing DAMON patches that marked as RFC in general?

[1] https://lore.kernel.org/20261026150825.152576-1-sj@kernel.org


Thanks,
SJ

[...]
