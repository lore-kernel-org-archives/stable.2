Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 50FBB42E405;
	Wed,  9 Sep 2026 20:26:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788985618; cv=none; b=hzydm5BAbMdMEL7ncXU2KslxENdAIkhrWhjIcVatTrCRObe+hNcxHiIoh4qP0PO+lg80y6qx8m2/fcnLEC+YamAAgN3XU+owA5DgRzJs3LN/AYduoW6q+uenAbioie80Mvq6ewg28KDen0rMyuGCLimIQpZEfZs7Z4SPLhPPoHM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788985618; c=relaxed/simple;
	bh=hHXG9TCQF6H5fDu7Lbqx2rwDzhKlhyLDjpnr/of83hI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Zc0wLUkoVZcxy1lnpQ3RNU8rbUK/TCoErZYaDfBJI756YuZoP7AZgAJYlivJye8mkNycBXJV4yCJzkhNXMOB1yQvrGiX9DY0Crh+RcOIp+rtVyRpILVJU0fuYRUCIp5Lrm/ioBx+H2LouzCPh+mV5ajRm4UQ3hzQst56J8YaRe0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=CLfwvYI+; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="CLfwvYI+"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6EAE11F0089B;
	Wed,  9 Sep 2026 20:26:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788985614;
	bh=Spdtpss6D8SQ+fZ6999JPsXcHBKIDz3KdOynL9fnT5c=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=CLfwvYI+el4aJ/7ZbEpz5rqrxjlDAp68DBMOsHlgCGcH27gJDCZOOXQMhrawJPrTO
	 iI8a4Kr4LvNQjhwjz9e7IPzkdEol05tiGp6XlWR0O+JCo4apEuKqRWYpdhKaFXbQOA
	 ZZ/98OdIVQrxrvenbG7ZkkVcQdi3nKLtMLdx7qegrV65gsFyGSoGduRN6sDhxQVnpL
	 UzJoOiqUEkWyh5C4gfLh7AtuQEQi1ohjGZ+1yGC8TjZSEefLFiM/EubdGmEuWN2MAC
	 qzvfGur1QWEiQ4eWsHPXdBKYj4pf3V5eJCvA3X3hfoa/15y4jSvpF6G/MKo4/JNvXe
	 ZWbxWXG21DsPg==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Sasha Levin <sashal@kernel.org>,
	damon@lists.linux.dev,
	SJ Park <sj@kernel.org>,
	Brendan Higgins <brendan.higgins@linux.dev>,
	Andrew Morton <akpm@linux-foundation.org>
Subject: Re: [PATCH 6.6.y] mm/damon/vaddr-kunit: check region count in three_regions test
Date: Wed,  9 Sep 2026 16:26:18 -0400
Message-ID: <2026-09-09-daily-reply-0020-damon-vaddr-kunit-three-regions-6-6@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260909034903.150500-1-sj@kernel.org>
References: <20260909034903.150500-1-sj@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

> damon_do_test_apply_three_regions() iterates regions after
> damon_set_regions() call assuming the function would succeed at setting
> the number of regions the same to the expected one.  It might have failed.

Queued for 6.6, thanks.

-- 
Thanks,
Sasha
