Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0E9BD31F9A7;
	Sun,  2 Aug 2026 18:54:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785696881; cv=none; b=cD/uvhIOMx9p+ogxdtBa5rhxlVAInSiX/7UK6fZvyLYzQo2W3JEmitYL0kkdUwShwd1Q7LQQVST367VMJiEgZpiDCiq3I13hZ3gh1QBif1wxgAC1jusg0y2koNF6cEh0qi5X5F2bnkVW73kX3traQYOWvdN4RgCr5gyv3A9nDqQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785696881; c=relaxed/simple;
	bh=ghfFXlr9KhD1jZsE5cv7wrvbhfgr/WBF5uJoiQTwOE8=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Vm5H3Y8jSsQPb+XoevBrcMZl8gtRKw5dTCyP4FgIyFhEUrW/jNh9U5p49I/FQNaiFv2XSDx9kM2GKyzFx8Cs2XXG6MdmRkacL5DuG4sHZUNWu77B/jymvKXmP894za5uUx4BP4yVxzZg5hDV4s2go+kyyMbF9GFwMai6AkSIbXw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=R3FE+Te6; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="R3FE+Te6"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 729DB1F000E9;
	Sun,  2 Aug 2026 18:54:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785696879;
	bh=jhwpPt8VETeDzUlgcaGfy/+m0kpeMGsxwzMN5hnljhc=;
	h=From:To:Cc:Subject:Date;
	b=R3FE+Te6xd/7Z5It05vdlY7Ysz864FmCc4VL0KGlQE6lPKkrLYH2KMDVrsNk6kpxn
	 pVM4I3oNZ6lN5TTtdNNS/fY1iqcHDgOXsIGxRSFIHhu0fboDtbee3N0/CKXMmKM8B7
	 K5ubgsI9OBJgD1uuHcJEyT11Nf3qLUhJCkq8jkBjjrZ6S4I/nMgholX8BPEI9e7ze1
	 +VdkhALsP4l5iZVfIPfcapLGpJm75+Ba6MmLD2YtYIN0BXGDZMSC2kHlMnzNCJVO/8
	 jp24ZM1+O3km1Q9ZzC7+dZO4r5BVykm+w3x2fi2ETQRumUzgB2Qd0Wqxa8/srpnUFj
	 g2v8sQ0wgeN5w==
From: SJ Park <sj@kernel.org>
To: 
Cc: SJ Park <sj@kernel.org>,
	stable@vger.kernel.org,
	Andrew Morton <akpm@linux-foundation.org>,
	Liew Rui Yan <aethernet65535@gmail.com>,
	damon@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org
Subject: [RFC PATCH 0/2] mm/damon/{reclaim,lru_sort}: fix commit_inputs infinite hang
Date: Sun,  2 Aug 2026 11:54:26 -0700
Message-ID: <20260802185430.9940-1-sj@kernel.org>
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

SJ Park (2):
  mm/damon/reclaim: skip damon_call() if ctx has not started
  mm/damon/lru_sort: skip damon_call() if ctx has not started

 mm/damon/lru_sort.c | 11 ++++++-----
 mm/damon/reclaim.c  | 11 ++++++-----
 2 files changed, 12 insertions(+), 10 deletions(-)


base-commit: d6580a342bc8c459628d2b68b313e9c0668bca59
-- 
2.47.3
