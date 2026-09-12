Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 71F1D37F75B;
	Sat, 12 Sep 2026 19:18:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789240697; cv=none; b=QJHYu1m9ojb2WEOQGP95Okm6Kba+diMIpDXQUdIQW2tqCLL0YrWsSSfFgPemWzJhPRcRQhKDs26AJ7x639aal4fatLbmbBtLJIan5d6jrhF/rWhwgsU+nwEp7YXdWtBkVdp667oNiaOIFJ+Y+K/h8M4/yixGfkfhW5zXQ1DEy1s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789240697; c=relaxed/simple;
	bh=coOKyd0rtvaMCxH/mKUGhnrdea7b8MWsrIPmIS/QuxI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=hag6CP9vinEOQFkYepRPtQk/BJQMCXwVmy3aiw7aoz9tUtd/Cu99v+CoHCyn3vdGe4REAdzr5RP+GdTjpMunbxEztyDkUVF6UoV1btZCeGZslD6wm6zvLF4ajSXLKO8gB3JpF6jUKDdKmpYHS2tgZ4q/AQ5dg5d8z4PSHR38IUo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Pb2rwd3i; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Pb2rwd3i"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F41E81F00898;
	Sat, 12 Sep 2026 19:18:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789240696;
	bh=hAIupWOiZk1Nz5VeipyYWCDtbEHKa9N+XsP7giaox3I=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=Pb2rwd3i7YJEayi20uaPGc3CcA5bXzPFyUFJ6I+PnkBjhyagDQ/JtJWVamOJZF+QZ
	 GOBKiyeMwZ2GNRSpemAIE2yOVYItKsiz4HeJIasjJF1H5qRlhCmaYsdsXBXGAf71Cs
	 f6nfS73vDuIkg1HclAThaPxtO/A0l6G2sVUFkjxrWD2axGUwu1JD4t/zORtLzmv03T
	 sJwuVILiLssQCHhr8TbmtAavsdYwv1yVDyvdGmvvpC4XgP5d2RNC/j77EjuD4XsH1r
	 N5pcZq3qd2B3sCy6+ISy6uggHu+ZC3xFc8mETLPmp0lWmE5pqCmYuZ156H/9E8vh3u
	 FEBDLK2vkmtew==
From: SJ Park <sj@kernel.org>
To: 
Cc: SJ Park <sj@kernel.org>,
	stable@vger.kernel.org,
	Andrew Morton <akpm@linux-foundation.org>,
	Usama Arif <usamaarif642@gmail.com>,
	damon@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org
Subject: [RFC PATCH 2/8] mm/damon/sysfs-schemes: read sysfs_filter->sz_range only once
Date: Sat, 12 Sep 2026 12:18:00 -0700
Message-ID: <20260912191807.138502-3-sj@kernel.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260912191807.138502-1-sj@kernel.org>
References: <20260912191807.138502-1-sj@kernel.org>
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
