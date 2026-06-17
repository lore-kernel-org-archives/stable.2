Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 93800429802;
	Wed, 17 Jun 2026 13:56:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781704583; cv=none; b=RBsRUbcCZrAKiM7+6Hq2rkZKqRWI0OouccH5pdL6w4cpFw7kLBj4UwGRq2b2PFqt4cd8hZkigDfQ68h5MkIQrmw1DbvX6uxGTG+JxJoha1rP+qW2GkTIlHJVPBF6sE8p/GabOyTwponlDFJaL/RJYFKuFoSfhE6Kv8Who9lrCsk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781704583; c=relaxed/simple;
	bh=ms3mnDz+Ek5gjkdy+IsNqPfdvrEmdheVzOTBFeABAnU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=CZFfdRGInkGd3KoKq9U625Q/trg873BtWwVKdNWtHNFO+CyVaNCb5F5FNmcIn5xjaqNRrvWq3nNNwJsA6oRmtViRV8h3tp647iEDJ94wldUp9HreExOHop6RZwRMAjZ4uM+fFipj8kA+fzMyKkNz2pLka4cKF17M3PmWDC5quUU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=cyaCzHfc; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="cyaCzHfc"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 07B221F00A3A;
	Wed, 17 Jun 2026 13:56:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781704582;
	bh=304b+5TS5ljtcCjsmfNo5OTxh/l/vWic2mRv4DwMcZo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=cyaCzHfccCxiNdLe9RwuNDoWcG9TM+7UWaC6wYL0c1SFkbRS4UyuJQy2Cs3jMTC1s
	 TAOZdr6l0aQ9pIklCP/5b0Dk4l14FOUV88uanExxYm3tCcuset00oZTlFHz9cVXjhA
	 PZQ+kIdT6QFyng+u2uMXcrMbK35KJrAJd8U+7/3t+bJal1MmgCAs+s3A2ls5t38QXj
	 UHnfuD+x+RmSpKJ2Lf6soL/VRP67qh0usSCddqbYs/C7KQS9I0xiR80w+feDAjeL6Y
	 goad0Y8ab9+bTfRRBBYqlvwj7GJ7eHNUPz6Kf9fyPtLCU3c0YWaO7ZR1R/++wMtw7q
	 9Jz7zyVfPAuaA==
From: SeongJae Park <sj@kernel.org>
To: 
Cc: SeongJae Park <sj@kernel.org>,
	"# 5 . 18 . x" <stable@vger.kernel.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	damon@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org
Subject: [RFC PATCH v1.1 1/2] mm/damon/sysfs-schemes: fix dir put orders in access_pattern_add_dirs()
Date: Wed, 17 Jun 2026 06:55:48 -0700
Message-ID: <20260617135551.86013-2-sj@kernel.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260617135551.86013-1-sj@kernel.org>
References: <20260617135551.86013-1-sj@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

In access_pattern_add_dirs(), error handling path puts references
starting from setup failed directories.  If the failure happpened from
the initial allication in the setup functions, uninitialized memory
dereference happen.  The allocation failures will not commonly happen,
but the consequence is quite bad.  Fix the wrong reference put orders.

The issue was discovered [1] by Sashiko.

[1] https://lore.kernel.org/20260617060005.86852-1-sj@kernel.org

Fixes: 7e84b1f8212a ("mm/damon/sysfs: support DAMON-based Operation Schemes")
Cc: <stable@vger.kernel.org> # 5.18.x
Signed-off-by: SeongJae Park <sj@kernel.org>
---
 mm/damon/sysfs-schemes.c | 9 +++------
 1 file changed, 3 insertions(+), 6 deletions(-)

diff --git a/mm/damon/sysfs-schemes.c b/mm/damon/sysfs-schemes.c
index 329cfd0bbe9f3..7c00aa78b2f50 100644
--- a/mm/damon/sysfs-schemes.c
+++ b/mm/damon/sysfs-schemes.c
@@ -1993,22 +1993,19 @@ static int damon_sysfs_access_pattern_add_dirs(
 	err = damon_sysfs_access_pattern_add_range_dir(access_pattern,
 			&access_pattern->sz, "sz");
 	if (err)
-		goto put_sz_out;
+		return err;
 
 	err = damon_sysfs_access_pattern_add_range_dir(access_pattern,
 			&access_pattern->nr_accesses, "nr_accesses");
 	if (err)
-		goto put_nr_accesses_sz_out;
+		goto put_sz_out;
 
 	err = damon_sysfs_access_pattern_add_range_dir(access_pattern,
 			&access_pattern->age, "age");
 	if (err)
-		goto put_age_nr_accesses_sz_out;
+		goto put_nr_accesses_sz_out;
 	return 0;
 
-put_age_nr_accesses_sz_out:
-	kobject_put(&access_pattern->age->kobj);
-	access_pattern->age = NULL;
 put_nr_accesses_sz_out:
 	kobject_put(&access_pattern->nr_accesses->kobj);
 	access_pattern->nr_accesses = NULL;
-- 
2.47.3
