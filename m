Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D6C7A47B43A
	for <stable@vger.kernel.org>; Fri,  4 Sep 2026 20:32:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788553972; cv=none; b=AufJRVNCPB2AuPR8VGvJPuG3MUMfuUB+abFbYyLyBWbL3+/r3bmqUoqWoUPcb4XUBMT6XBFaZgUK3ppeTuC5VIFcoxZQmP7jE+PzD5f3YnDL4+8m4CFoJ6XbKejbhuRkKp5Kd0DB7rlKSg/Ilksdt1v4LpCckjIn3J99Oopc/rE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788553972; c=relaxed/simple;
	bh=tV/9yjT+sXVEHiZeaHDxyegXLLkLDHCxwIdyUWmxQx4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=iyEkxVpGeEhmYhiGSwDhffPSouuGZnZ9uqETUS/9fbBF7GyCCnJ8uxuj8jlv9HLsPSuNbarwnVmSLxcVhKt2M+4C9ERA9OxcnUrQ6ty8lgYe0+gKfEodIBwtxj9gRmhhS6an1kk3RcJcsjhgaQqkaprnWrThuvTgjVxUZBK9CiI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Dm2qD0tb; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Dm2qD0tb"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9E7E61F00A3D;
	Fri,  4 Sep 2026 20:32:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788553947;
	bh=EUndfF+8Rpn2E0ckMhMbfqjjMXwlTj3GAJu58GzWgqY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=Dm2qD0tbIBM2Z7xhat7tgyYAamIlys8wL+uL1X1ebqGEN145CbekOId1kxsy8hBC2
	 Qc7969VPpg8vhj125HADf0bczr+DY70q3uSyxfMMG3wKDWhSyBaE3/vQ6T33EKtiKI
	 FnL4uChJfCRot2BH8xKRlFowdnAdvIdtPVPPi6S99Oc0+Dg3mqgDJnUTp2ejCuI7co
	 zsishgXE2eySKNXgKhuQWjPqAVUbVN8+5w//byAnSiErCM8bPWdU225SdqeOwTK+uE
	 lt7fO3Nt9sp/OMF6psxOGsIitncUNVZ5Q6NZpk0/wjq1FCowxFcHh+HW0Dvy2QkAFm
	 QE91WgeoGR7bA==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Chengming Zhou <chengming.zhou@linux.dev>,
	Minchan Kim <minchan@kernel.org>,
	Sergey Senozhatsky <senozhatsky@chromium.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.6.y 7/9] mm/zsmalloc: clarify class per-fullness zspage counts
Date: Fri,  4 Sep 2026 16:32:15 -0400
Message-ID: <20260904203217.1548415-7-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260904203217.1548415-1-sashal@kernel.org>
References: <2026090349-deniable-copilot-d36a@gregkh>
 <20260904203217.1548415-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Chengming Zhou <chengming.zhou@linux.dev>

[ Upstream commit 538148f9ba9e3136a877881e72ccbe56733daae2 ]

We always use insert_zspage() and remove_zspage() to update zspage's
fullness location, which will account correctly.

But this special async free path use "splice" instead of remove_zspage(),
so the per-fullness zspage count for ZS_INUSE_RATIO_0 won't decrease.

Clean things up by decreasing when iterate over the zspage free list.

This doesn't actually fix anything.  ZS_INUSE_RATIO_0 is just a
"placeholder" which is never used anywhere.

Link: https://lkml.kernel.org/r/20240627075959.611783-1-chengming.zhou@linux.dev
Signed-off-by: Chengming Zhou <chengming.zhou@linux.dev>
Cc: Minchan Kim <minchan@kernel.org>
Cc: Sergey Senozhatsky <senozhatsky@chromium.org>
Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
Stable-dep-of: f7bf5cd5b5f2 ("zsmalloc: account for handle size in class lookup")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 mm/zsmalloc.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/mm/zsmalloc.c b/mm/zsmalloc.c
index 6b78584c4183a..1249cfa2b67f2 100644
--- a/mm/zsmalloc.c
+++ b/mm/zsmalloc.c
@@ -1873,6 +1873,7 @@ static void async_free_zspage(struct work_struct *work)
 
 		class = zspage_class(pool, zspage);
 		spin_lock(&class->lock);
+		class_stat_dec(class, ZS_INUSE_RATIO_0, 1);
 		__free_zspage(pool, class, zspage);
 		spin_unlock(&class->lock);
 	}
-- 
2.53.0

