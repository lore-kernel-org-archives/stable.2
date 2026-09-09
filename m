Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BB041430CE7;
	Wed,  9 Sep 2026 20:26:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788985624; cv=none; b=srKpvqswQW7Jep9+dzV8pQ6q0avu7pX+ej0hIicQGYDc5jaNG6K2uOgMyoOXXf2T7YTjskDuGn2sQiuUe1GY+Nk9kMCNlQcp1Yy1xG5RDvBM7qEmrEWV+0usu7BM8ibyPPSImWroKm360h1HPraDbc3j8Y425FUcsrgGizo0CKs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788985624; c=relaxed/simple;
	bh=Eskvde/uAfZJqkO/Kev1vIMFsGjT7E+/8uwzzn4kVKQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Ja7bTvrR3b917IliRlKhskDZlcqzUm8S+uXezojeCj3Y1mS3/m5xQXrTtS4ogEEJP/anreJNbochZx3FWX/oZYge2+HbIGlbIv46GvE8qSe4qjibaWt0G+BfNH0RAbJYWIoWVXnPL8vOuUKZkEnoO1i4BvYpaz10Rygm6vhonJo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=TfQzZZ8J; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="TfQzZZ8J"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4F8FC1F00898;
	Wed,  9 Sep 2026 20:26:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788985617;
	bh=0YpUoELrRKqWjn48DPxycybyOyAzrjyvaAtgchkN8/c=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=TfQzZZ8J9oyImPGsA2PQe3QBMoKSjoETpfwyD/FI/lDlrjz9kos9piQAMTWfpPALv
	 +EPHwytyupuRFy6odWaCS0EYVJaEp2BuIEdIa5lSGmSt0a4wit7iqifjXCptBztRcO
	 oD0VMXxcR9qE8vP7gaHSYqYlUgN8x5kizyJVGhOor8mh9Jf2nGBGar3Gv7Fvh4FpqM
	 d7a0D/tmbxecHwWNm1gZZwWiTw0l0Z3Exx8YnsfoqgcVBUG0+gRyjhFcI6xyHKHzht
	 of2HnQzgXKkDSL60tyK1FLbRbtiqYdjMu9nGjI5sOC6Zp8w5f0C5ZumGf77UMlM07J
	 IJB9IkofXxtMw==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Sasha Levin <sashal@kernel.org>,
	damon@lists.linux.dev,
	SJ Park <sj@kernel.org>,
	Brendan Higgins <brendan.higgins@linux.dev>,
	Andrew Morton <akpm@linux-foundation.org>
Subject: Re: [PATCH 6.12.y] mm/damon/core-kunit: handle region split failure in filter_out()
Date: Wed,  9 Sep 2026 16:26:21 -0400
Message-ID: <2026-09-09-daily-reply-0023-damon-core-kunit-filter-out-6-12@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260909040931.177877-1-sj@kernel.org>
References: <20260909040931.177877-1-sj@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

> damos_test_filter_out() test checks if damos_filter_match() of an address
> filter splits the region as expected under a given condition.  But, the
> test continued regardless of the split successes.

Queued for 6.12, thanks.

-- 
Thanks,
Sasha
