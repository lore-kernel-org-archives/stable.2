Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794167513;
	b=m1r8npLmENIhsDnIlHrDBCs2P2+v4zRBqiqVujRXHxp4vrwCVK4237JmJwu+EE+mQqAa
	 4vFK0r97iO1PeWfLjOvBiGMsY/kVuAuFNaWNeLKYUH3l+eJMc8+kx1ctyb4UpZswGGDKo
	 ZcIZi+A0uOJsicDRlh8MwKWHLV0km9/RczPFchyePCnJutG1IU4OfXCPtbqW0RZNdMP5X
	 o99imzVtgXMdOESeyPqqPOc8T9ehVzP3VudFXMg4J+QpEuaFWris/3oXXPOob0GX1tczp
	 ZKhKqCQ4VuiXX/jEKM0E8rXCvK2qsumzd0vTXKoUF64jAUM4Yp8p8MlKOdQLBJ4wd2Q==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794167513;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 MIME-Version:Content-Transfer-Encoding;
	bh=OJAr4xLTV8QiOwhk6gGpqr46jyVyTKNFU7LHvyqTRTs=;
	b=vhiuMwn0d7+2KrmgGCM6Hjq+7H4CvaWeKJaREZnUTv6weMX7hfwtHoZZGuvKGoyQs3N+
	 X8m3gXUC8IgEeWNd5aiLP0iW8KwpC+lTHWMwMXTrNOxHM0BFspiZopl3BYNokLtHNPx4i
	 pj+9wfQdxvCKYCUmPDBHqMB8vRUd6hSitRGO/qde6OcL0abKrc/SLMty4WY4Dz4EruL0N
	 rzL75PHlTCQ593xSFuZmx6xVl3cbFwW03woa6BW7cS5FYU1V4T8W3R5vJj+y49pUf7zGQ
	 eNvFwcWV3v1I/yrj6mAZJdDXAd4J4ykZGjmhqylFPzrCyWSIBz2OwYr9nn/lck7WvTA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=E4XJY5Et;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 81141606A31C;
	Sun,  8 Nov 2026 19:51:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=E4XJY5Et
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EDFD11F0089F;
	Sun,  8 Nov 2026 19:51:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794167513;
	bh=OJAr4xLTV8QiOwhk6gGpqr46jyVyTKNFU7LHvyqTRTs=;
	h=From:To:Cc:Subject:Date;
	b=E4XJY5Etd4ycRs2IGY1YQ9/0VbDTr7XLpuGSttyjyxlozycuUxa+fQ4LjIRepbV3q
	 AdBNR74SA8BowS5r+jit8dUOUzLsoTFMvZ1U7L0dKsq519Sp5Z72DJJFeD3hs3b2EX
	 BkIpVLyldzMZWaGmQrnOqV79F6Ek4RG/cFOXQo7deN1XP8xk57TEyHUs0ZoQOEh7Gb
	 NGR8x8L4TUrzt5tJKccxcptbseIzXbziAHx32uht1yrqf6LpzH8QwMRyGXWOziv2BO
	 ukUpeJHzbYOFZWhgZIMnSWiTOOJFjjKyJQjNPiH4Zb57ZGnnaiYFoJQWOolZhRIDFO
	 xwscjWhn774VQ==
From: SJ Park <sj@kernel.org>
To: stable@vger.kernel.org
Cc: SJ Park <sj@kernel.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	Brendan Higgins <brendan.higgins@linux.dev>,
	David Gow <davidgow@davidgow.net>,
	Quanmin Yan <yanquanmin1@huawei.com>,
	Usama Arif <usamaarif642@gmail.com>,
	damon@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org
Subject: [PATCH 6.12.y 0/5] mm/damon: porting fixes that cherry-pick failed on 2026-11-07
Date: Sun,  8 Nov 2026 11:51:39 -0800
Message-ID: <20261108195145.115792-1-sj@kernel.org>
X-Mailer: git-send-email 2.47.3
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

Manually port five DAMON fixes that cherry-pick failed [1-5] and turned
out to really need to be picked.  Note that seven patches [6-12] that
also failed in the same day were having wrong Cc:stable@ tags, so
ignored.

Patches that this series is porting.

[1] https://lore.kernel.org/20261107051942-failed-6.12-90c2fa6adfed@kernel.org
[2] https://lore.kernel.org/20261107051944-failed-6.12-1613ac9edf38@kernel.org
[3] https://lore.kernel.org/20261107051946-failed-6.12-29c6084658af@kernel.org
[4] https://lore.kernel.org/20261107052624-failed-6.12-bbeec2d8324d@kernel.org
[5] https://lore.kernel.org/20261107052626-failed-6.12-5695abc4e742@kernel.org

Patches that also cherry-pick failed but deliverately ignored.

[6] https://lore.kernel.org/20261107051949-failed-6.12-df7d9a0f8d91@kernel.org
[7] https://lore.kernel.org/20261107052123-failed-6.12-6f276422aded@kernel.org
[8] https://lore.kernel.org/20261107052125-failed-6.12-a1c7fdaf1657@kernel.org
[9] https://lore.kernel.org/20261107052128-failed-6.12-1bfb9384ae0e@kernel.org
[10] https://lore.kernel.org/20261107052130-failed-6.12-cec08aad3def@kernel.org
[11] https://lore.kernel.org/20261107052132-failed-6.12-409d2ab6d982@kernel.org
[12] https://lore.kernel.org/20261107052135-failed-6.12-1d2397b2c414@kernel.org

Changes from RFC
- RFC: https://lore.kernel.org/20261107214525.304638-1-sj@kernel.org
- None.

SJ Park (5):
  mm/damon/core: skip applying scheme if region split for quota fails
  mm/damon/paddr: respect folio end for DAMOS actions except STAT
  mm/damon/core: handle uninitialized damos_quota_goal->last_psi_total
  mm/damon/core: filter out damos address filter-split failed region
  mm/damon/core: remove unreachable damos charge_{target,addr}_from

 mm/damon/core.c             | 59 ++++++++++++++++++++++++++++++-------
 mm/damon/paddr.c            |  6 ++--
 mm/damon/tests/core-kunit.h | 11 +++----
 3 files changed, 58 insertions(+), 18 deletions(-)


base-commit: 749e25da48308e7fd273cf1a64a27020e4fd1118
-- 
2.47.3
