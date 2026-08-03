Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AECBC435ABA;
	Mon,  3 Aug 2026 13:46:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785764815; cv=none; b=XQ+jFrx1XjHS3DVhxa5zwWnTwthu1YDZcTzaIXV6EeWEGBJ8mGbFtpfE9q22Sk1pNqO3SiKjadUgsXT5O0E346OxYw7yyNGYCia7mHs/fxr0EMcpCvfFdFDal1hNFKy+bVFs/T2UI5V9nuWghUKipIv0V09EqkvZdh5DzqNziZ0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785764815; c=relaxed/simple;
	bh=s3Ll2/kwUTxV4Droi+8b8swm3V8iQaTImQDpi22W8OM=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=ZAleeFTxMBef2Dih+xn0Dqu1ulroOEDrLjzv9cGzNlQRTMrhtLKsx427vnUSdMCdGKiJhj8GtW4DlD+sNIfbH96vvXbvlbobZvdWEkATORI3sj5eKKkAkjOtv+HH17dJ+Dcm7kilWXpjteOF/q99mQkzh2VDVS11tOKpdOQ0AzM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=l3gHHJ5k; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="l3gHHJ5k"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 263691F00A3A;
	Mon,  3 Aug 2026 13:46:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785764814;
	bh=co/3NtBMT+/PSQBj9iUTUY4KxUG/Ig2umyiYC8Q4zFc=;
	h=From:To:Cc:Subject:Date;
	b=l3gHHJ5klugoL+0hNmdK4DzQSOkan+yAC9Nal74GzYW31jeLXXi4X1kxjUsloEG8l
	 SQV/uUVas9PpeKXumZD+LIH8wsmrQ+w5m7bVeWjx6s1ZIUrC166lTy6+UNENIpIqFs
	 CdhRw0s+yt1QdDIGmy9R9BvUHFiKKwEPuGUljJIjA/GCmS87UnIHCnwiaP5TLNNyEC
	 XYO3FKA5eanu4mwiXUm9/DynpZX/mmu1Djg2ytvh+FQSwAp2J+/Wp8C9z6s3ndKf8x
	 Te4TJH+fF4NIPaqVg3iNBncEIs3c+CxbDWEqRWPAn3ovLMA2lNnnJGXkLSOt1CnnyY
	 2+ENQnbqP/o2A==
From: SJ Park <sj@kernel.org>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: SJ Park <sj@kernel.org>,
	stable@vger.kernel.org,
	Liew Rui Yan <aethernet65535@gmail.com>,
	damon@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org
Subject: [PATCH 0/2] mm/damon/{reclaim,lru_sort}: fix commit_inputs infinite hang
Date: Mon,  3 Aug 2026 06:46:43 -0700
Message-ID: <20260803134646.16640-1-sj@kernel.org>
X-Mailer: git-send-email 2.47.3
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Writing 'Y' to commit_inputs parameters of DAMON_RECLAIM and
DAMON_LRU_SORT before the modules were ever turned on causes infinite
hang.  Fix those.

The issue was discovered [1] by Sashiko.

[1] https://lore.kernel.org/20260802173021.762-1-sj@kernel.org

Changes from RFC
- RFC: https://lore.kernel.org/20260802185430.9940-1-sj@kernel.org
- Drop RFC tag.

SJ Park (2):
  mm/damon/reclaim: skip damon_call() if ctx has not started
  mm/damon/lru_sort: skip damon_call() if ctx has not started

 mm/damon/lru_sort.c | 11 ++++++-----
 mm/damon/reclaim.c  | 11 ++++++-----
 2 files changed, 12 insertions(+), 10 deletions(-)


base-commit: a96a4f995fbc65238bcbe94e05bcdbec29a54571
-- 
2.47.3
