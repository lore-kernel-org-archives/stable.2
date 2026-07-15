Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 636D73370E4
	for <stable@vger.kernel.org>; Wed, 15 Jul 2026 20:16:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784146568; cv=none; b=oDKnobg5Pkg1ht3vCY7x14IgrW2nCos+E+I/NK0Wh9HppR4Ygg3QS2Fmu2qS/WDLNipOFJOH24JLP4OlR8ZyLTSC1eRXWQqMk2fKQGkdczQTIP68u0C/AVkHzZuZomD1lEQwILXcvHWJleObhXwDs34oq2wbH5nJ9pz8i4gRt5M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784146568; c=relaxed/simple;
	bh=jdxuCCD4Bk1qymC4XwWErZVgBlJ+43IGalblXkk9Ekc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=gzwPGM/3jeIQ1Qllr13Y9cK50xlJn3AqTu/GRFN/bUwZ2hFOofFY/KQTcLTsEFI9cz21V9a22gimihS09sz/9FdXX1hjHZqPQQjuLDP72AcPtBk9CHzw6CYy4qUCkoQh7tniLWv2S5SCfx2wyERqRNewwL3Aiib7zZXGgVByGS8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hKWCcoj7; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hKWCcoj7"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2AC801F00A3D;
	Wed, 15 Jul 2026 20:16:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784146567;
	bh=Q/zpUPMgM/yIL2RAy8a+UWHqCrVs8X+9CpmOS/v7ans=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=hKWCcoj7CwCqfY1pL3B2aRdvRYErqqqtsJXQ0ZD93pwQiNNgFE2BkN3qGMoVT69SI
	 IgKRWHfVAnYrVhByBWDlP15oKDRB0LX1f4zBLPMg+BxoZCr5vGwL+5W/lYhlGMlhMa
	 rxPd9uP9OmWKfkMvwR5FqsOJ/Z/zkFoDEbQfL6UXIEZh+AIZjew4V0EWshqe/FFIRa
	 mKXGXD/yHtmM9PHzS4xmkzVj8LQCZ3cnHUv4Tb1X2h7VLpxr6aH6vfH/4Dl/tnFF7Y
	 XxF2UFjfCVquDDjeceyedh0g9CS7e00JXXN9+VgiLc0BdyPTk/wEE7LEjqcn4fWGbp
	 XotaKhn8SXctg==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Qi Zheng <zhengqi.arch@bytedance.com>,
	Muchun Song <muchun.song@linux.dev>,
	Dave Chinner <david@fromorbit.com>,
	Roman Gushchin <roman.gushchin@linux.dev>,
	Andrew Morton <akpm@linux-foundation.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.1.y 2/2] mm: shrinker: fix NULL pointer dereference in debugfs
Date: Wed, 15 Jul 2026 16:16:03 -0400
Message-ID: <20260715201603.63084-2-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260715201603.63084-1-sashal@kernel.org>
References: <2026071340-handed-risk-625c@gregkh>
 <20260715201603.63084-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Qi Zheng <zhengqi.arch@bytedance.com>

[ Upstream commit e30453c61e185e914fde83c650e268067b140218 ]

shrinker_debugfs_add() creates both "count" and "scan" debugfs files
unconditionally.

That assumes every shrinker implements both count_objects() and
scan_objects(), which is not guaranteed.  For example, the xen-backend
shrinker sets count_objects() but leaves scan_objects() NULL, so writing
to its scan file calls through a NULL function pointer and panics the
kernel:

BUG: kernel NULL pointer dereference, address: 0000000000000000
RIP: 0010:0x0
Code: Unable to access opcode bytes at 0xffffffffffffffd6.
Call Trace:
 <TASK>
 shrinker_debugfs_scan_write+0x12e/0x270
 full_proxy_write+0x5f/0x90
 vfs_write+0xde/0x420
 ? filp_flush+0x75/0x90
 ? filp_close+0x1d/0x30
 ? do_dup2+0xb8/0x120
 ksys_write+0x68/0xf0
 ? filp_flush+0x75/0x90
 do_syscall_64+0xb3/0x5b0
 entry_SYSCALL_64_after_hwframe+0x76/0x7e

The count path has the same issue in principle if a shrinker omits
count_objects().

To fix it, only create "count" and "scan" debugfs files when the
corresponding callbacks are present.

Link: https://lore.kernel.org/20260617090052.27325-1-qi.zheng@linux.dev
Fixes: bbf535fd6f06 ("mm: shrinkers: add scan interface for shrinker debugfs")
Signed-off-by: Qi Zheng <zhengqi.arch@bytedance.com>
Reviewed-by: Muchun Song <muchun.song@linux.dev>
Cc: Dave Chinner <david@fromorbit.com>
Cc: Qi Zheng <zhengqi.arch@bytedance.com>
Cc: Roman Gushchin <roman.gushchin@linux.dev>
Cc: <stable@vger.kernel.org>
Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 mm/shrinker_debug.c | 10 ++++++----
 1 file changed, 6 insertions(+), 4 deletions(-)

diff --git a/mm/shrinker_debug.c b/mm/shrinker_debug.c
index 6133c8d00f116b..9f3fabe1bf30cd 100644
--- a/mm/shrinker_debug.c
+++ b/mm/shrinker_debug.c
@@ -198,10 +198,12 @@ int shrinker_debugfs_add(struct shrinker *shrinker)
 	}
 	shrinker->debugfs_entry = entry;
 
-	debugfs_create_file("count", 0440, entry, shrinker,
-			    &shrinker_debugfs_count_fops);
-	debugfs_create_file("scan", 0220, entry, shrinker,
-			    &shrinker_debugfs_scan_fops);
+	if (shrinker->count_objects)
+		debugfs_create_file("count", 0440, entry, shrinker,
+				    &shrinker_debugfs_count_fops);
+	if (shrinker->scan_objects)
+		debugfs_create_file("scan", 0220, entry, shrinker,
+				    &shrinker_debugfs_scan_fops);
 	return 0;
 }
 
-- 
2.53.0

