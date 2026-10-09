Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1C8D04D1783;
	Fri,  9 Oct 2026 13:50:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791553804; cv=none; b=GL9fzU1Rka1xl7eJiMc1px2ga807J554cc/Sk53Oma70foU92pXxY9FJSvbyJ16mVvKCQV76waI9uJAOmnR9zLshSVKrZsJpGqWgUwmHlPbYoG7ZH8h6Y3AaYvcSmuzq75FkDcSyed655P58N1WmUy2r2Od8t7dlZCoKWsm1rl8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791553804; c=relaxed/simple;
	bh=qgH/nhtiCFqz2ON6RzU2zqMmTDEZ++lrR+Yb4CBEpPQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=uUO963R88QyKmjRwNvbvL815cICs5qUmudGkAUJ6y93tiyn7MoUxhgpz3Zi2/QT73BH7l+v51S7lhakSY1x7stKgMp5yocAgxG9Ljf0hXsp0iJO2OJHTzJ1XRsGSRsaBlnhEdGswJ47fWzLWSH9GCedGK98zNEkR0ziP3YxqESM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jaOtYbWS; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jaOtYbWS"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8F33C1F000FF;
	Fri,  9 Oct 2026 13:50:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791553803;
	bh=H071Su+4anOlMSS+gUVM0N4jNV+NkmKss72WEdIivlQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=jaOtYbWSMeWlKVzUtj/mC5JhGw/eRRP8P9KPZ7ycsQyvrSjSKPXPjSB28iY/uOAUf
	 RYAAC5Ao9A2ivu5JD+w8dayx1zgxO3ZY8oaz7hD3DHp7MiR18Cu4k6WQNcpvsrnci1
	 kEpw7YRjqoD52RKePcVL5DnorfevK0IhATdk0sQhMWn1ixlgnvdBpguXKGP5OTtCTG
	 QWh0BrB2T5L/v3HtdgH9PGy4Rd78axftTQNIlk3QCSj3i88YE/NIgE3+U2zE3TOcso
	 TLOmT454SYB0b+9WxhiOOQW+NwyJoTGnv9zdum6CZFx8qdT5lh21Ti2gxPvTBg9CBX
	 HS0FZSbklCKtQ==
From: SJ Park <sj@kernel.org>
To: stable@vger.kernel.org
Cc: damon@lists.linux.dev,
	SJ Park <sj@kernel.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org
Subject: [PATCH 6.6.y v3 0/2] mm/damon/core: fix last region handling of damos_skip_charged_regions()
Date: Fri,  9 Oct 2026 06:49:47 -0700
Message-ID: <20261009134949.11507-1-sj@kernel.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <2026092948-moonrise-persecute-3597@gregkh>
References: <2026092948-moonrise-persecute-3597@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Patch 1 is a dependency of patch 2.  Without it, patch 2 introduces
out-of-bounds memory access bug that was found by Sashiko.  Patch 2
fixes a bug that categorized to be backported to stable@.

Changes from v2
- v2: https://lore.kernel.org/20260930101853.58786-1-sj@kernel.org
- Fix out-of-bounds memory access bug by adding patch 1.
Changes from v1
- v1: https://lore.kernel.org/20260930093707.48739-1-sj@kernel.org
- Add missed damon_sz_region(r) <= min_region_sz case change.

Liew Rui Yan (1):
  mm/damon/core: fix unconditionally skip last region

SeongJae Park (1):
  mm/damon/core: do non-safe region walk on kdamond_apply_schemes()

 mm/damon/core.c | 45 ++++++++++++++++++++++++---------------------
 1 file changed, 24 insertions(+), 21 deletions(-)


base-commit: ae7bc7c9b4336d7a8fb4bcfe0a6d8c925bde3ce9
-- 
2.47.3
