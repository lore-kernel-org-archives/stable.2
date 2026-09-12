Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 53CEF4248DB
	for <stable@vger.kernel.org>; Sat, 12 Sep 2026 15:26:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789226791; cv=none; b=QHuAteSeJs6LQEJceHeY3OWIK51kXqFCQH7C0gOXy7AThbQMYaV3SP3hWuB98l+EVJEKZJV/3kyzqg4Pa5RpRe2IJ49JLft0e5RXv26IuoFsWyREYNCOYfb4llYiQMtIwHYcHOUK8PRVeQ48sn6BkpDT6GotomgjYD+MUg8EUKg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789226791; c=relaxed/simple;
	bh=KFMtdZvuBS4VCzlHDXONjM0mXX/j8rjDQTBH1rIegj4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=gXzG0fICUbjWD4mnO15WTEAbhrHhVmP7SJ2OvoQJFx5d4oU6iuA2CPOTtfs+VZUVZo/ibsTfI9vlu7nzFZyrmE9D0DnANn7l9sTRiT2RM+ETwGHQsEd2eQ3LRDVPhyozz6Kn/6Jv9oVlzEG1us1rGE59DmRXfH3UYrW9MhWNfhs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Hd3kv5Lt; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Hd3kv5Lt"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B3A1A1F00899;
	Sat, 12 Sep 2026 15:26:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789226790;
	bh=kBtrkWYgy3pw+A+IEacQYAVtdyhoEgp95bbo7Cu83mE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=Hd3kv5LtudGPgVZKMV0SCaXaAE4nx47+nvThYW70Pjl2oqWRH/nfI/aweHv7W3lem
	 fIgeXfn4cxcCSv9HjxsIy1zb9HZiO215m0IbGrmqFmyKwIsaErAIcN1KiEX8OCXFPY
	 fS2CQlAc9kBtBsTTv7eI0o7qvh59mUONPlea2o/64Nv9kuA3P1xJRBYOX/yig2z2UN
	 sUgp0AOIOo6sesfOLJ5Sdt2/PKg0Mac+tzfCOJQ1RZjS8VLLsvrn1Yix9iRfMb/lkC
	 h+oiUprU3jPbgubD6SFxv6Kx3URjcSOJsWf/20yvkpksGApbaH68loZZgSzcHeJPop
	 b3Gac3q1JQg9g==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Sasha Levin <sashal@kernel.org>,
	SJ Park <sj@kernel.org>,
	Andrew Morton <akpm@linux-foundation.org>
Subject: Re: [PATCH 6.18.y v2] mm/damon/core: avoid infinite kdamond_merge_regions() internal loop
Date: Sat, 12 Sep 2026 11:26:18 -0400
Message-ID: <daily-reply-0010-re-damon-merge-regions-6-18-v2@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260911134904.96369-1-sj@kernel.org>
References: <20260911134904.96369-1-sj@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

> Due to online parameter update like events, the number of DAMON regions
> could be higher than the user-set upper limit. kdamond_merge_regions()
> repeats merge regions until the number meets the limit, while doubling the
> merge threshold up to the theoretical maximum threshold.

Queued for 6.18, thanks.

-- 
Thanks,
Sasha
