Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6E0FB384248;
	Wed, 17 Jun 2026 05:33:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781674413; cv=none; b=JxwRi1R9Rt4/E31W+jmUudWa6A2NbIe8ziYlCA6vjoUGmcQoCCJcZxOWyRrleeHKnNEtjneYE7Hrp9tS9paMIUn/iEitCEb9Ios33ZnRxmDPf4IdGdc9Q35gyoKBDNU6BAGUh4y2qNZmsR0UKs+DouQ5TWGSiom/PlT5peXJ5uM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781674413; c=relaxed/simple;
	bh=mo+de7mVS72L/G8E6eEKcNExaWsidO3a70ofQ1tY/8M=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=MqX2ZzBKp+Jv0/Gtg4P6Dv7MWk/oOZc/BALsXID4+xdzeK862qOWF46FH03u9Cvly0EoqVByhlUUmFtBTzSPL0ZzZdItFMRYxsKElQQzKBExc86jwUJ4xkCRpk/jsYK2l1f/gu0wEIGaXGy7OcWLrAzBfO7NCTHILJ87u/Pvyfs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Sm58GnAf; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Sm58GnAf"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0F5D51F000E9;
	Wed, 17 Jun 2026 05:33:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781674409;
	bh=q7KbxmNe1Mx2RhlgRxTjCgEeTsCY0crj1GVLCPmkWn4=;
	h=From:To:Cc:Subject:Date;
	b=Sm58GnAfoIV6Zm4aRiV1K7AAc/U3olxpPxNC9Rm1WbZz2LKeL0yPrG4TKtJf7fVw8
	 TdZSlsKwdd9KUabaMKmsFUNkeZCPuSKc+w31Xi6Xrxq/eNDQMijglchjhuTskrQOeN
	 50/jyK5fQRRlJJ6XOGwRjrUOmwUm0UOastwjALISZPJXTCxX9yqYMfW158Sw+xBrbE
	 xQO3mA7VRQ06j8KpAHJ4/7iPmu2umaTA0l8+dZMMyrCFxBsbtR/FJF2Ff0PYNDj342
	 trTcn7jWXZQFYZqoqU3dRXHzVVq/TYloCSfBFZ5npoPxxIFE6BuVDIRBzVhdHcGsk2
	 vi4vNXJe13ZSg==
From: SeongJae Park <sj@kernel.org>
To: 
Cc: SeongJae Park <sj@kernel.org>,
	"# 6 . 2 . x" <stable@vger.kernel.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	damon@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org
Subject: [RFC PATCH] mm/damon/sysfs-schemes: put stats for scheme_add_dirs() internal error
Date: Tue, 16 Jun 2026 22:33:07 -0700
Message-ID: <20260617053308.83200-1-sj@kernel.org>
X-Mailer: git-send-email 2.47.3
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
index 329cfd0bbe9f3..0668a0e539713 100644
--- a/mm/damon/sysfs-schemes.c
+++ b/mm/damon/sysfs-schemes.c
@@ -2516,12 +2516,12 @@ static int damon_sysfs_scheme_add_dirs(struct damon_sysfs_scheme *scheme)
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

base-commit: 2d57ad161a03e7a68b2c036bc4895ef56b4c76a6
-- 
2.47.3
