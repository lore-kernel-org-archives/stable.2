Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A37DF2DF68;
	Sat,  1 Aug 2026 17:36:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785605765; cv=none; b=hQgPkdQZgVZj2KH2Iwyg1dWzt+DlJibeJULfDRw10SwZrZqB4V13jJT8vmqbCJzgE7yjjNagR3/AAeIT0r+VupScg99qPqm34XqHJQl7pOfF8xsR7vU+riBTj+V6wjsrrrHU5uRu1bMfyJIZoGyVwDqtFO5tlDfRTu94Hvd9aQo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785605765; c=relaxed/simple;
	bh=Cgc540+p4FXI1tY2TNVOMXDdsREZ7GZdUX6iTqwsY5c=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=WyMWXm9de4Ig41DFz04b5s1NVMG84L6RPOvvqD0uiJYwzFoHCu30ZRfzcMIslgAtJkQwDzYn3JZOGBDwHnz39FGjPq/Ej+/FJ6XPq7n+LSwhWfbO5RSh1zUadCkQInd8N4qFJ9e1S9iBFP6Q83MdenTJW2p69izozlHhs8Lo43E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=b7g2jA9x; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="b7g2jA9x"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 014F31F00AC4;
	Sat,  1 Aug 2026 17:36:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785605764;
	bh=DgoWkAGslNq32y7wpqOrv1OO4q/c8+5GUJCCC3yQcNs=;
	h=From:To:Cc:Subject:Date;
	b=b7g2jA9xQ7iYK3VMelhLVoJeebvUY96cXG/MeGKOq/UQPEnD+NxHxwaks8lW8S2L5
	 D1pCq9LBVzmVWbPK6yaG38mkb8sC0nwLwPo/NPcB4Ep1Bm7cT50zESoWO8eAdZlPlG
	 QuyP56W0C9huQxfwO+t2XMLOSTtZyZQGQfHUTz4bDz3+mc+9OHDV9nZDKmxAXSA/ub
	 7w6VIZNttEIL3coUj9bMzlxrVjghVEfQ35ms9aNF2gpznNW0iVKoCU7l2r78v4MaBp
	 RMZwlTWxf5GHK8RqgUuZFFa9qslkg0qDhC+iJzRlN3I9lrXuaAC8llrqP0xmdNYSFL
	 sYKblaRZiNGBA==
From: SJ Park <sj@kernel.org>
To: 
Cc: SJ Park <sj@kernel.org>,
	stable@vger.kernel.org,
	Andrew Morton <akpm@linux-foundation.org>,
	Usama Arif <usamaarif642@gmail.com>,
	Yueyang Pan <pyyjason@gmail.com>,
	damon@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org
Subject: [RFC PATCH 0/9] mm/damon: fix DAMOS bugs in core, paddr and vaddr
Date: Sat,  1 Aug 2026 10:35:43 -0700
Message-ID: <20260801173554.94710-1-sj@kernel.org>
X-Mailer: git-send-email 2.47.3
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Fix misc bugs of DAMOS.  Patch 1 make DAMOS less stress memory allocator
under extreme situation.  Patch 2 fixes wrong DAMOS quota auto-tuning
feedback loop start point for PSI goal.  Patches 3 and 4 fix wrong
folios walking in DAMON_PADDR.  Patches 5 and 6 fix wrong folios walking
in DAMON_VADDR.  Patches 7-9 handle extreme and unlikely memory
situations that can cause divide by zero and underflow.

All bugs are discovered by Sashiko.

The bugs are not very critical, but better to be merged sooner than
later.  Since mm.git is closed for urgent changes, I aim for 7.3-rcX.  I
will drop the RFC tag after 7.3-rc1.

SJ Park (9):
  mm/damon/core: skip applying scheme if region split for quota fails
  mm/damon/core: initialize damos_quota_goal->last_psi_total
  mm/damon/paddr: respect folio end for DAMOS_STAT
  mm/damon/paddr: respect folio end for DAMOS actions except STAT
  mm/damon/vaddr: respect folio end for DAMOS_STAT
  mm/damon/vaddr: respect folio end for DAMOS_MIGRATE_{HOT,COLD}
  mm/damon/core: handle extreme memory state in damon_get_node_mem_bp()
  mm/damon/core: handle extreme memory state in get_node_memcg_used_bp()
  mm/damon/core: handle extreme memory state in get_in_active_mem_bp()

 mm/damon/core.c  | 29 +++++++++++++++++++++++++----
 mm/damon/paddr.c |  8 ++++----
 mm/damon/vaddr.c | 10 ++++++++--
 3 files changed, 37 insertions(+), 10 deletions(-)


base-commit: 70802c13e2c9a0ab52605035e2d63b964afe6add
-- 
2.47.3
