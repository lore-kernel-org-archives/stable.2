Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2F51D43E9D5;
	Tue, 16 Jun 2026 15:09:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781622544; cv=none; b=Abiz0856n3n3V3fSmey81K3F9CXt4mnfP7lfMF007Qybfs1fmYi+/wr1LznCYyvAzboOiJAEGNXroMczNniwtlOyBM5HYqsNvgNjPcdeA7BvpynI2HtPN4OshLBeF6liNASO86UPWVNyEdVq+snoyxSj8+0btuiVDCzbzfpizKc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781622544; c=relaxed/simple;
	bh=YCOYIsP2UPA3JL2Qr+ccMSs46GgRKcUWZGG6JVBp61Y=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=kCsszXb6+/KL0X0nr48vOhImf3V1S81gX/tVt/hPkSb7kg0ztI6OkdBUuLVsuZ0ftHgxGadLv1Twdcsg17YHy9cTwtr4MCuoXPLvvmuP7j40ZGiZ6U61+tKivXHwTfugYzLLPw1Gym8QfolZn5T3B7ZCmDNl2gQSttI7roYzISw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=V65DTVK2; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="V65DTVK2"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 205721F00A3E;
	Tue, 16 Jun 2026 15:09:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781622542;
	bh=KBDvSQ1iWnZfp5aAlbLhoAvHHvZ9HPS98yHZ0WmqRY4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=V65DTVK2MhA9N5rWMFKW2QvWqid8b11n1IsCAKjH4uuzl/8DHFRAKFkH5n6HaLie+
	 qs8pE/IVON6wQBL9wXK59zDqZbAn5tTy7IBNrNCx+npgTg69QsfZcG+AVjyibp/M+y
	 pzuRiMvj3EBi0q4JfdLNT4FoN0NpKBSc5ApvjV+6gNkp7oD0Vte+n/NAQ9WLEdm6X8
	 aMHQZ4SPHX1rFOPJtnsq8kxviok7JAIypwzG3w+9QHavEopV4sxJowN81FD87uNjvV
	 iJmrD0S156TRc/8aW5lW9frqy8rF6qkx6a47pwwUGvXG8mAiemY0papX5z4rdX8fzC
	 ci9X0FoO49Sfg==
From: SeongJae Park <sj@kernel.org>
To: 
Cc: SeongJae Park <sj@kernel.org>,
	"# 6 . 3 . x" <stable@vger.kernel.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	damon@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org
Subject: [RFC PATCH 5/9] mm/damon/sysfs-schemes: kobject_del() scheme filter dirs
Date: Tue, 16 Jun 2026 08:08:39 -0700
Message-ID: <20260616150844.88305-6-sj@kernel.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260616150844.88305-1-sj@kernel.org>
References: <20260616150844.88305-1-sj@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On CONFIG_DEBUG_KOBJECT_RELEASE enabled kernel, lack of kobject_del()
could cause directories creation failures due to the name conflicts. Fix
those issues for scheme filter directories by adding kobject_del()
calls.

Fixes: 472e2b70eda6 ("mm/damon/sysfs-schemes: connect filter directory and filters directory")
Cc: <stable@vger.kernel.org> # 6.3.x
Signed-off-by: SeongJae Park <sj@kernel.org>
---
 mm/damon/sysfs-schemes.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/mm/damon/sysfs-schemes.c b/mm/damon/sysfs-schemes.c
index bf08e6e1f1635..300930c2c5b3f 100644
--- a/mm/damon/sysfs-schemes.c
+++ b/mm/damon/sysfs-schemes.c
@@ -914,8 +914,10 @@ static void damon_sysfs_scheme_filters_rm_dirs(
 	struct damon_sysfs_scheme_filter **filters_arr = filters->filters_arr;
 	int i;
 
-	for (i = 0; i < filters->nr; i++)
+	for (i = 0; i < filters->nr; i++) {
+		kobject_del(&filters_arr[i]->kobj);
 		kobject_put(&filters_arr[i]->kobj);
+	}
 	filters->nr = 0;
 	kfree(filters_arr);
 	filters->filters_arr = NULL;
-- 
2.47.3
