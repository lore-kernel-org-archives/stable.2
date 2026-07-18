Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DA96722689C
	for <stable@vger.kernel.org>; Sat, 18 Jul 2026 01:33:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784338418; cv=none; b=sPc/Ji0qL/Z3Mls8hSIeHvQ8vvijNemr6EHzx8uRNX3+RPKmC1c9uqIta3Pt8dhGqL9lVO+FwWvfLMY51lI6ww2arx9Mv5l4iQYN2j0Cx1dS1sN77dfJCEE4+OTKIFmYKUrIk9SFhSFFN4Z2WF6iq0edDjVdW3SVe9VqraSbw1I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784338418; c=relaxed/simple;
	bh=G11uD7ZejIwJX+sRylqH07lXOEKQ1L/5fwq909kKjhM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=J+VicLxSUpqrJFQ2CjRn5wahiV5EFhV2OpkaLNz02BpmJJ+QSPvNWnbC0dx693vkb6ahv7EvSzY8PQ72SBuZmHUKj+O6GQ4ND23scseTv5wGM6o7PKZtyIsUVAfm8hP3gkSxmN6G8dLv+zX+aXypALqy9t88MIFpJ2CqDZeVNm0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=N52upVo0; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="N52upVo0"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D65081F000E9;
	Sat, 18 Jul 2026 01:33:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784338417;
	bh=RPehG0oSh91M/EVUszLQho+fQ2vY7RdK87TV2OchNhw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=N52upVo0BPM67Nh0gTz/8T9EUz164JZXtuNN+vZX0TjDfgGNCi1Qk0Kzr73aIx3IW
	 jMK7DwRypAtqA7LVX7xLcog3JG6q3jzx43rzjP6vgliARJ401HT5mYKSI2bkQQxygU
	 tTL/DY7skJiIARTGTF6aXIKHgj3V3AbLSGpJpfsaas+2qXYmSNYLzXLKq531GrE2tK
	 E9t7xFtWRU+8W79kTACpKL0KwKzopXB7cXZMCsDo32U50SwCmrkZ27Y8GqS2EUPgpJ
	 UOb26xv90/DGXzhEfDH+gcwg6OcCeYo81Y3dTGKEvca0xQ55CQXni0mcJwOKuUW1/I
	 SnV8sbZnfIIwg==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Jiapeng Chong <jiapeng.chong@linux.alibaba.com>,
	Abaci Robot <abaci@linux.alibaba.com>,
	"Darrick J. Wong" <djwong@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.15.y 1/3] xfs: Remove redundant assignment of mp
Date: Fri, 17 Jul 2026 21:33:33 -0400
Message-ID: <20260718013335.2621394-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026071429-showdown-footpad-d6da@gregkh>
References: <2026071429-showdown-footpad-d6da@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Jiapeng Chong <jiapeng.chong@linux.alibaba.com>

[ Upstream commit f4901a182d33d05a3b7020e2af97c635f6c47959 ]

mp is being initialized to log->l_mp but this is never read
as record is overwritten later on. Remove the redundant
assignment.

Cleans up the following clang-analyzer warning:

fs/xfs/xfs_log_recover.c:3543:20: warning: Value stored to 'mp' during
its initialization is never read [clang-analyzer-deadcode.DeadStores].

Reported-by: Abaci Robot <abaci@linux.alibaba.com>
Signed-off-by: Jiapeng Chong <jiapeng.chong@linux.alibaba.com>
Reviewed-by: Darrick J. Wong <djwong@kernel.org>
Signed-off-by: Darrick J. Wong <djwong@kernel.org>
Stable-dep-of: cc9af5e461ea ("xfs: use null daddr for unset first bad log block")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 fs/xfs/xfs_log_recover.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/fs/xfs/xfs_log_recover.c b/fs/xfs/xfs_log_recover.c
index 825e585758bb08..c8e2423a13d82b 100644
--- a/fs/xfs/xfs_log_recover.c
+++ b/fs/xfs/xfs_log_recover.c
@@ -3570,8 +3570,6 @@ xlog_recover_check_summary(
 	uint64_t		ifree;
 	int			error;
 
-	mp = log->l_mp;
-
 	freeblks = 0LL;
 	itotal = 0LL;
 	ifree = 0LL;
-- 
2.53.0

