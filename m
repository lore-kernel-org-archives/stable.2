Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A331B32A3E5;
	Tue,  1 Sep 2026 13:13:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788268416; cv=none; b=Kf+aq63iFov8pJPm6frFt6bYeqL9ZrX4+056OzFPDKR4xgkhQ51H7GP716hMznAnQXoT9pj7HUiCkehT+yi6MfWocjLS7BA0aKoESEUqn9xiKUL8iwSa5KW5p1Ek1BRXFQwq3DTPG8oFwiM9u+3R/hg2kWvvdCL5pbcmz+s1IL4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788268416; c=relaxed/simple;
	bh=35/yin/QF8t3Kqfg+UAOrsmVX85pqU2Iyl2wuXO5t+0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=nnYVlEccAO1Aj/EnEovq79oBT3jX8yHMA2rvBf26LEWQjJprn7zBwVF6/McbyAGvkaM2BVg92XmTdW6v6lY7nU9wYsiiC7No0tCCI638+5cUNuSulFJSCnJMDsVfFptQ6vSuuiOKEgLQ76xGl3dGJFmhLCVHI5dc6aAYmI5ma5w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=VmCJP86o; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="VmCJP86o"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 266FF1F00A3E;
	Tue,  1 Sep 2026 13:13:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788268415;
	bh=7ZB1yfEGzN5K33ID0e3bcOFkHhvifJ8hhhrNtAvrugg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=VmCJP86oeHn76JzQLhDmTScTgW+IQItKLl9s/BVtCWN6+31Zv3FKqrjnmL/GHP6Y0
	 7NyPgN784/d/zfr6IaXQ1Q7G6hghehkfC5yVy/ucrAlz22jveR89bO60RfJ81n7roT
	 5QYT8W1WRaCLjfJAeCdOt0aEdfS1E1ctnkyf1uNNbeP6ibbaHWJKcARxSDDMqq2zlU
	 wKCmnJuNfkB/JOmC7LlU9MTTu13WvDmPXIyh/6mciXcvapOcaeAv9U/2jVHTwBFVtL
	 0oPMdpW3BGL9Fs1d+ZzPsipWp/kjLfHZrHrHA26yrV3TuY7WenMcHdKe0LS6x17Lnf
	 lA0opfQpWCzfA==
From: SJ Park <sj@kernel.org>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: SJ Park <sj@kernel.org>,
	stable@vger.kernel.org,
	Usama Arif <usamaarif642@gmail.com>,
	damon@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org
Subject: [PATCH 1/7] mm/damon/paddr: respect folio end for DAMOS_STAT
Date: Tue,  1 Sep 2026 06:13:18 -0700
Message-ID: <20260901131326.97615-2-sj@kernel.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260901131326.97615-1-sj@kernel.org>
References: <20260901131326.97615-1-sj@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The function for applying DAMOS_STAT in DAMON physical address space
operation set (paddr), namely damon_pa_stat(), applies DAMOS filters to
folios of the given region.  For that, it gets folios of addresses in
the region.  It starts from the region start address and advances the
address by the size of the folio of the address until it goes out of the
region.  If the start address is in the middle of a large folio, and if
the next folios are small, some of the next folios could be skipped. Fix
the issue by advancing the address to exactly the start address of the
next folio.

The user impact is that the DAMOS_STAT-based page level monitoring
results become inaccurate.  Since the page level monitoring is supposed
to provide relatively high precision, this is definitely a problem.  It
is arguably not critical since it is only monitoring quality
degradation.

Fixes: bdbe1d7bc325 ("mm/damon/paddr: increment pa_stat damon address range by folio size")
Cc: <stable@vger.kernel.org> # 6.14.x
Signed-off-by: SJ Park <sj@kernel.org>
---
 mm/damon/paddr.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/mm/damon/paddr.c b/mm/damon/paddr.c
index 5c6c3a597fd0b..2ab7b3842701e 100644
--- a/mm/damon/paddr.c
+++ b/mm/damon/paddr.c
@@ -379,7 +379,7 @@ static unsigned long damon_pa_stat(struct damon_region *r,
 
 		if (!damos_pa_filter_out(s, folio))
 			*sz_filter_passed += folio_size(folio) / addr_unit;
-		addr += folio_size(folio);
+		addr = PFN_PHYS(folio_pfn(folio)) + folio_size(folio);
 		folio_put(folio);
 	}
 	s->last_applied = folio;
-- 
2.47.3
