Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9541327466A;
	Thu, 18 Jun 2026 00:57:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781744225; cv=none; b=Ft1kJ9U3Oly9esNZGtX0J0xUJnbDNJWD1ndvNnyXqJzduk/k3cNZya1vZcrEqsuGhsPfeC4io6VletvBXY3o3xhBtkvo4BRRa0XYuSkTbVBQ/qx8JHrdWO5KqPUZz+Ymhp4EpCcDdWhutkSGNYs5L+mEvNgFJ1/xQDQAjULIg5w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781744225; c=relaxed/simple;
	bh=6Z4Q4SHb73Mx95B4ZI8V5uOZVQrl/2f/XsP/iI3CXkY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=qG24smX7CySd2aaQJlyq4mSyD1KGBlhe2YVY6PlQuxBZZ2DqBDB8FmeIWesN0sIH16R/52GEW+aurvhSQBahmULVdtFTrHH5kiejoJuQ9TJTiTaDLfb5xJvbih1t4oIsUgfUkdbOVcgX/cwAMpunpx9CCgZJeS9xiGFZKw2FO0E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=BzvG7YBd; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="BzvG7YBd"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 23B301F000E9;
	Thu, 18 Jun 2026 00:57:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781744224;
	bh=vj1ysZXTzQEftM04gbB5WCu/uXQrIziK86sFp/rbmQE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=BzvG7YBdMMtJ2AqIrAKsD7LQV9XdMyH5w+jvu/0hi1pAnks/GEAGun40xtq8a+j0n
	 ZKjopGiUxwhtnsAdY9WjnLujhgVVr+vuNJlN7jZQjqVQQC3hnisf52E+cOOW47zHSO
	 mIkNjYcIPF8MMgnpCNVW/vgU4ARygL0kMQu4huZBWdEWJ54MDXRck2NofGTbLieEcP
	 6QDKfv9dAEQaRJACGJwjWFcNXbLV5EsgsrBhx0mhfLpoMoz0vwdezEAxNz8HduN2Wt
	 Yivavv1q7OtrtjkOp4vgAQtPqmobPg1CUINZF18h5i3qb6lVThJWOtUFYiaH7qI78o
	 3+TEy+4uwE48w==
From: SeongJae Park <sj@kernel.org>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: SeongJae Park <sj@kernel.org>,
	"# 6 . 2 . x" <stable@vger.kernel.org>,
	damon@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org
Subject: [PATCH 2/2] mm/damon/sysfs-schemes: put stats for scheme_add_dirs() internal error
Date: Wed, 17 Jun 2026 17:56:48 -0700
Message-ID: <20260618005650.83868-3-sj@kernel.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260618005650.83868-1-sj@kernel.org>
References: <20260618005650.83868-1-sj@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

damon_sysfs_scheme_add_dirs() setup the tried_regions directory after
the stats directory setup is completed.  When the tried_regions
directory setup is failed, the setup function ensures the reference for
the tried regions directory is released.  Hence the error path should
put references on setup succeeded directory objects, starting from the
stats directory.  However, the error path is putting the tried_regions
directory instead of the stats directory.

As a direct result, the stats directory object is leaked.  Worse yet, if
the tried_regions directory setup failed from the initial allocation,
the scheme->tried_regions field remains uninitialized.  The following
kobject_put(&scheme->tried_regions->kobj) call in the error path will
dereference the uninitialized memory.  The setup failures should not be
common.  But once it happens, the consequence is quite bad.

Fix this issue by correctly putting the stats directory instead of the
tried_regions directory.

The issue was discovered [1] by Sashiko.

[1] https://lore.kernel.org/20260617005223.96813-1-sj@kernel.org

Fixes: 5181b75f438d ("mm/damon/sysfs-schemes: implement schemes/tried_regions directory")
Cc: <stable@vger.kernel.org> # 6.2.x
Signed-off-by: SeongJae Park <sj@kernel.org>
---
 mm/damon/sysfs-schemes.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/mm/damon/sysfs-schemes.c b/mm/damon/sysfs-schemes.c
index 7c00aa78b2f50..0134111c3c1ff 100644
--- a/mm/damon/sysfs-schemes.c
+++ b/mm/damon/sysfs-schemes.c
@@ -2513,12 +2513,12 @@ static int damon_sysfs_scheme_add_dirs(struct damon_sysfs_scheme *scheme)
 		goto put_filters_watermarks_quotas_access_pattern_out;
 	err = damon_sysfs_scheme_set_tried_regions(scheme);
 	if (err)
-		goto put_tried_regions_out;
+		goto put_stats_out;
 	return 0;
 
-put_tried_regions_out:
-	kobject_put(&scheme->tried_regions->kobj);
-	scheme->tried_regions = NULL;
+put_stats_out:
+	kobject_put(&scheme->stats->kobj);
+	scheme->stats = NULL;
 put_filters_watermarks_quotas_access_pattern_out:
 	kobject_put(&scheme->ops_filters->kobj);
 	scheme->ops_filters = NULL;
-- 
2.47.3
