Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6F95547F2D6;
	Mon, 14 Sep 2026 14:23:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789395818; cv=none; b=UJoOAhKx5UCfpotWGEEDE2XEjW9VF5MF/bohfxbDz62l75aVIsiF2hqIXAn9joZOWeNtMs/ZnNDUGumPFxpxSs09xitK7eHJ86pJQm7DERXSxSl4tp0dWiwjXRwwu+4vhw7PB1ZtcpAxJZoBZZwiMk7TFLmhFP8+27of0yWIBOY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789395818; c=relaxed/simple;
	bh=coOKyd0rtvaMCxH/mKUGhnrdea7b8MWsrIPmIS/QuxI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=i2aqAq4QbLlJCC2EIcFgTPsUdns3ILZnSVF4eVCqziMGnqvPE2/WBbKupWAdKnkLWU4vkrOD9MsvWjmYU3oDr5eDC/cJjCzqkcCGHB8e/UKLr1vNcOdXgcjejkhjyC+i1VIS91SqO3yF4qm3/l8KhpiWERfMpzpGl3FZLOGqnl8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=EWiER/3E; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="EWiER/3E"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C53A51F0089A;
	Mon, 14 Sep 2026 14:23:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789395816;
	bh=hAIupWOiZk1Nz5VeipyYWCDtbEHKa9N+XsP7giaox3I=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=EWiER/3EXkZMh6IAzLZjB+BC/ivAJZlgAEj08Ubqs/oGEkB+6gGa10ONspOW69cgr
	 1+whmqS2j6DxXT7A6LGbsSEBERXZKTNqFgIizHC/CyIEu9s7WDorYvcPVvP5Sd6F2P
	 ZvSMv0i2EB1eVijnxMuFm35cRWfagKjChMTuveUgjODV/3e+b/1rHCvbiDbbtCRVln
	 8isMkJPRoCOFB8gGBaIwWOC8XU9r9Swz+o8bgp9yLHdy3XkyiFXsTF7fv+VFdB2tKI
	 UkBvzVtKKq++R82set9MAvGhXimbPcfsJO9/xnMmV0PVX9Z+a7XqeUfSIwf3gNCoP5
	 VC13OV35TpWag==
From: SJ Park <sj@kernel.org>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: SJ Park <sj@kernel.org>,
	stable@vger.kernel.org,
	Usama Arif <usamaarif642@gmail.com>,
	damon@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org
Subject: [PATCH 2/8] mm/damon/sysfs-schemes: read sysfs_filter->sz_range only once
Date: Mon, 14 Sep 2026 07:23:19 -0700
Message-ID: <20260914142327.92510-3-sj@kernel.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260914142327.92510-1-sj@kernel.org>
References: <20260914142327.92510-1-sj@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

DAMON sysfs interface reads the user-provided size range arguments for
hugepage_size type DAMOS filter twice.  Once for validation, and once
again for assignments to the variable that will be passed to the core
layer.  If the user updates the arguments in parallel, an invalid size
range could be passed to the core layer.  Avoid it by doing the
assignments first, and then validating the assigned variables before
passing those to the core layer.

User impact of the bug should be trivial.  From the core layer's
perspective, the invalid size range is not really invalid.  It just
works as having a weird size range.  No critical issues such as a crash
or a leak could happen.  And sane users ain't do such parallel arguments
update anyway.  If they do, such racy behavior is arguably somewhat
expected and deserved.  That said, there is no reason to keep such
races.

Fixes: ea1f204ba29a ("mm/damon/sysfs-schemes: add files for setting damos_filter->sz_range")
Cc: <stable@vger.kernel.org> # 6.15.x
Signed-off-by: SJ Park <sj@kernel.org>
---
 mm/damon/sysfs-schemes.c | 7 +++----
 1 file changed, 3 insertions(+), 4 deletions(-)

diff --git a/mm/damon/sysfs-schemes.c b/mm/damon/sysfs-schemes.c
index 3c1c1cb387fec..8c8ab82c8facc 100644
--- a/mm/damon/sysfs-schemes.c
+++ b/mm/damon/sysfs-schemes.c
@@ -2840,13 +2840,12 @@ static int damon_sysfs_add_scheme_filters(struct damos *scheme,
 		} else if (filter->type == DAMOS_FILTER_TYPE_TARGET) {
 			filter->target_idx = sysfs_filter->target_idx;
 		} else if (filter->type == DAMOS_FILTER_TYPE_HUGEPAGE_SIZE) {
-			if (sysfs_filter->range_min >
-					sysfs_filter->range_max) {
+			filter->sz_range.min = sysfs_filter->range_min;
+			filter->sz_range.max = sysfs_filter->range_max;
+			if (filter->range_min > filter->range_max) {
 				damos_destroy_filter(filter);
 				return -EINVAL;
 			}
-			filter->sz_range.min = sysfs_filter->range_min;
-			filter->sz_range.max = sysfs_filter->range_max;
 		} else if (filter->type == DAMOS_FILTER_TYPE_PROBE_HITS_WSUM) {
 			filter->range_min = sysfs_filter->range_min;
 			filter->range_max = sysfs_filter->range_max;
-- 
2.47.3
