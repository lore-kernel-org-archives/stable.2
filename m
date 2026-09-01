Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A669B2F3C3E;
	Tue,  1 Sep 2026 13:18:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788268740; cv=none; b=D562Vat9Ke46L4Ep78u9CraDtz/CU1cVS+Ch5B0NZ+2JuWoEcCEW53AvQIo6fKh8aff0a83TAtZKD82kPw/n7HuAFLSQ4BdsKmtfNHg0NNpMHaMPy7cxKqIKDwfoDiE6apBGl2XAmaHhLiT5kOpalQ3PAQGpHueyJF2LZbKRbNA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788268740; c=relaxed/simple;
	bh=35/yin/QF8t3Kqfg+UAOrsmVX85pqU2Iyl2wuXO5t+0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=bPC9fUrj2s2tWTxBx1RfG1GsljjCemYPNpgEOA0X7hBmeMu6CGkH12f7/4azetGNNXVDoi6caIP6vZcBC56PERQ/4XYaTmlIiO6Fn00+HYedH9OPKp/Dfs47xY6SCpHjca3wtpLEWly5wm7eY0CN/fXLlQ791M9MTu8AQ8S+kCU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Wwzgo9sU; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Wwzgo9sU"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EEA971F00A3D;
	Tue,  1 Sep 2026 13:18:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788268739;
	bh=7ZB1yfEGzN5K33ID0e3bcOFkHhvifJ8hhhrNtAvrugg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=Wwzgo9sUB5TGy5zNJC4yHnKl5PtqWaoL8Dz9GwQCTVx+obhlYqR1i0dXlvtkkUxsH
	 d+W+CRtkgAwmR64rN/I4NsWsEeAvHdwvnu4Vyozpe6/CE/q0+kr6mHKbH0iEm4/4Jm
	 FJYIaONRuASM+kaXuNw2QgWGSuP929VGyraDfmNW86cRwkx5yeM7103V36kmVm4szn
	 bx6KyNXzylnXnBWUo3/kFBeCT6ycgOkaxm3HK56Di10oFNNBgRUz7AZm9oAxaCElpM
	 kHbjXf9YQkEdZIG8KxU7SY9fRBE7hp39GHgeYEPLuM+IgfzjovwWd0RP6pk/iArJRp
	 pbVx5n3G7spjQ==
From: SJ Park <sj@kernel.org>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: SJ Park <sj@kernel.org>,
	stable@vger.kernel.org,
	Usama Arif <usamaarif642@gmail.com>,
	damon@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org
Subject: [PATCH 2/8] mm/damon/paddr: respect folio end for DAMOS_STAT
Date: Tue,  1 Sep 2026 06:18:43 -0700
Message-ID: <20260901131850.98037-3-sj@kernel.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260901131850.98037-1-sj@kernel.org>
References: <20260901131850.98037-1-sj@kernel.org>
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
