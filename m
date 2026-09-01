Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2513939023A;
	Tue,  1 Sep 2026 13:13:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788268416; cv=none; b=IQYpHPjbjJ8OKzF8Be3QEj3OoTzEZVjZx0uLYYsO60dfcXSW2SSHPzP1x8Rlx0RaXGSMiaEwKXnXMTPp7HNkr4ZjaOxJAb+lexMTd6BN4NJS17U6NSFxiBAWqSy6e6+v/1B7tPJMfL7s4O/55MKeAW4BQdEFxJlmJhfi14tyHt8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788268416; c=relaxed/simple;
	bh=DvkDdHq4iHzr8I4BpnauinuiWMfL9IXhZr+IdV54oVQ=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=JVyQ74X5o0TiAgbZ60etRcK//SNALB8K726Gm10TaS79t31FDrLnkRT/gCE6UD5/SRgRqlSs76OD51JMr4IMrAwx9KLz6siz1VqFi0qcKXSmchf93S+1k/0uOOkJupLnSnVoxCIJWWmeH4gI85dQB/Yl3pi6+ZAQmRko+XE6Y1w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=YMO3erO1; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="YMO3erO1"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B6DD61F000E9;
	Tue,  1 Sep 2026 13:13:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788268415;
	bh=bvNMg4+ohXrFj0RX6YNja673VETP6Qf2VRqwotq06F4=;
	h=From:To:Cc:Subject:Date;
	b=YMO3erO1hgqSNyjhZpaWKn6S/jtbTPvOqsAd1zgh2s/4gKJthLl4cJJmmS3oQUTPA
	 kS1WDuVwssqIByTypa31c8WlRKjzRfgMsTCu5r7KQIiJJvFk2xsq0n3No49nr1DRsK
	 rEWtEvCxwPOzm6Z2UI+81nrd7gv7SmAHYOiqS1+eO63I6d9E5Tcl3GPxU8pyLnIRIr
	 04hqNgBf28sx2e/OblVrdm+EWccJvG1c7hVpW6BER1uXUZ97zjiOU6RfN0snC2hcq4
	 UIo0ag50bu9/nE/BWDi5pecqeH5GwA9jaZ8yTvJNuQaszUkZrCqjge+uwNralc0fhS
	 UfQTKswq3bv7g==
From: SJ Park <sj@kernel.org>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: SJ Park <sj@kernel.org>,
	stable@vger.kernel.org,
	Usama Arif <usamaarif642@gmail.com>,
	Yueyang Pan <pyyjason@gmail.com>,
	damon@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org
Subject: [PATCH 0/7] damos_apply_scheme() splits a region and apply the action to the
Date: Tue,  1 Sep 2026 06:13:17 -0700
Message-ID: <20260901131326.97615-1-sj@kernel.org>
X-Mailer: git-send-email 2.47.3
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The user impact is not critical.  The failure of damon_split_region_at()
is unlikely since it is arguably too small to fail.  Also DAMOS being
aggressive is limited to the single region.  Users can set
min_nr_regions to set the maximum size of each region.  If it is
reasonably set, the transient overhead shouldn't be critical.

The issue was discovered [1] by Sashiko.

[1] https://lore.kernel.org/20260718171523.87547-1-sj@kernel.org

SJ Park (7):
  mm/damon/paddr: respect folio end for DAMOS_STAT
  mm/damon/paddr: respect folio end for DAMOS actions except STAT
  mm/damon/vaddr: respect folio end for DAMOS_STAT
  mm/damon/vaddr: respect folio end for DAMOS_MIGRATE_{HOT,COLD}
  mm/damon/core: handle extreme memory state in damon_get_node_mem_bp()
  mm/damon/core: handle extreme memory state in get_node_memcg_used_bp()
  mm/damon/core: handle extreme memory state in get_in_active_mem_bp()

 mm/damon/core.c  | 15 ++++++++++++++-
 mm/damon/paddr.c |  8 ++++----
 mm/damon/vaddr.c | 10 ++++++++--
 3 files changed, 26 insertions(+), 7 deletions(-)


base-commit: d93d8b0181065f8375af61e3a18bbc7c066a8159
-- 
2.47.3
