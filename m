Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794045862;
	b=lUJut+t+xsy2PYXzK5JxhR/riPGSrBLECDZKD0Z51c0BC5bBL1l6Xpsf7RsKlXAD8fk2
	 M3q9N3u05HcqfQrWODK7I8nBFb8Px0sCSPHs30rOZRbookcmWXNqXqKhLtJC7n2qGYIRR
	 ecyS2BORej8Apc8Gjk290V40NrOnwYakzw9XePGK5c414JLusIfakBuAJaw4WOy2wuRPS
	 DG/llzt1IcR6npV5KE4TeNArs8bTiFwmSEfXQ7CQuogETyJ4CODD0eLJALcDOdSS6LzQJ
	 w6nLCFhyzGB7co1ERYbc99AvWF9od1QgcLr/z1Ur+KpMqbvWxDSXHYHi4WDzMAE6DvA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794045862;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 MIME-Version:Content-Type:Content-Transfer-Encoding;
	bh=qvZCL6qcv+CybS+T8BmnsjTGaSBgAw876QzeZxPgzZc=;
	b=N0fYjNHACYjglsZJli1Brs2ZL8uFrNU+N7qXDEkYF3klpg51b1Z0Ezk54kCYegkQJfUd
	 kLvVh8x0gDaO9QrdlshYTocXuMQXvM7quv5VRWxGWl/USm5TDEDq4klhbvN9kM2KS6IEA
	 8UWu53KxH/JsPH+uIBTLPhqw+cRwGg5KaykSNntPfn8cDk2NnJdFS062r2edmyigXQG1n
	 1P/w5J2ulB7eI/0pk3nD00BL9FAPA5O5euMVWmu1epJZ3dYc1i1wASKmlEzxCiNRyXxgL
	 3TL2ngkQQPfjvzmHB+QXv/U8hyV9a9A8ncoD0OkBs+7ovQwvJMP8jaS7jZaDcDOR5rw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=JPEIj2aT;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1E560606A326
	for <stable@vger.kernel.org>; Sat,  7 Nov 2026 10:04:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=JPEIj2aT
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 70AD31F0089F;
	Sat,  7 Nov 2026 10:04:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794045862;
	bh=qvZCL6qcv+CybS+T8BmnsjTGaSBgAw876QzeZxPgzZc=;
	h=From:To:Cc:Subject:Date;
	b=JPEIj2aT9MnSJVt7zQXxdkudDWabsefduLXcG2W/+E6D/MtVyRAcp3AmwvjNAfZfx
	 nm5eqk4i7P8N/s3aSftLKUqPBKom0r3hp0v7vJbGeoPgmt0lUMvGE1oStGZ8mkTQ9+
	 fdw/5m2UkurEMtgw1EoiPspMx8EaicJkULDafwgixXk6fKHRt+09l1HDRWBJdrRRj4
	 15pSBwidxd/K6ys3bTNYJVZRYzcCvuAJfr12OSrO5fKTwO9JbUw9tFLOnxWB5wN/1F
	 Bva9OYdvEMNF66ZafXN9Qxr3/CY9UZT6Awbobs9xXaYcenjznhccRldCR3xv+wuuZA
	 +ZxI+sjRUd+0w==
From: Sasha Levin <sashal@kernel.org>
To: arnd@arndb.de,
	akpm@linux-foundation.org,
	axelrasmussen@google.com,
	baolin.wang@linux.alibaba.com,
	baoquan.he@linux.dev,
	baohua@kernel.org,
	david@kernel.org,
	hannes@cmpxchg.org,
	kasong@tencent.com,
	ljs@kernel.org,
	mhocko@kernel.org,
	shakeel.butt@linux.dev,
	weixugc@google.com,
	yuanchu@google.com
Cc: stable@vger.kernel.org
Subject: FAILED: patch "[PATCH] mm/vmscan: avoid false-positive -Wuninitialized warning, again" failed to apply to 7.3-stable tree
Date: Sat,  7 Nov 2026 05:04:19 -0500
Message-ID: <20261107050419-failed-7.3-ca6e32f3f424@kernel.org>
X-Mailer: git-send-email 2.53.0
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

The patch below does not apply to the 7.3-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-7.3.y
git checkout FETCH_HEAD
git cherry-pick -x ca6e32f3f4240d0335775a11afc21e0451dd8d8f
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '20261107050419-failed-7.3-ca6e32f3f424@kernel.org' --subject-prefix 'PATCH 7.3.y' 'HEAD^..'

Thanks,
Sasha

------------------ original commit in Linus's tree ------------------

From ca6e32f3f4240d0335775a11afc21e0451dd8d8f Mon Sep 17 00:00:00 2001
From: Arnd Bergmann <arnd@arndb.de>
Date: Wed, 16 Sep 2026 10:34:46 +0200
Subject: [PATCH] mm/vmscan: avoid false-positive -Wuninitialized warning,
 again

I previously worked around a false-postive gcc-16 warning in the
get_tier_idx() function, by adding a fake initializer. This happens with
the -fsanitize=bounds sanitizer when the compiler creates a specialized
variant of isolate_folios():

In function 'get_tier_idx',
    inlined from 'isolate_folios.constprop' at mm/vmscan.c:4982:9:
mm/vmscan.c:4934:9: error: 'sp.refaulted' is used uninitialized [-Werror=uninitialized]
 4934 |         read_ctrl_pos(lruvec, type, LRU_TIER_MIN, LRU_TIER_MIN, 2, &sp);
      |         ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
mm/vmscan.c: In function 'isolate_folios.constprop':
mm/vmscan.c:4946:25: note: 'sp.refaulted' was declared here
 4946 |         struct ctrl_pos sp, pv = {};
      |                         ^~

Adding another "= {}" would solve the problem as well, but to prevent
this from happening again after the next code refactoring, try instead to
prevent this by forbidding interprocedural optimizations on this function.

Link: https://lore.kernel.org/all/20260213123902.3466040-1-arnd@kernel.org/
Link: https://lore.kernel.org/20260916083456.4136132-1-arnd@kernel.org
Fixes: 3de705a43a46 ("mm/vmscan: avoid false-positive -Wuninitialized warning")
Signed-off-by: Arnd Bergmann <arnd@arndb.de>
Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
Cc: Axel Rasmussen <axelrasmussen@google.com>
Cc: Baolin Wang <baolin.wang@linux.alibaba.com>
Cc: Baoquan He <baoquan.he@linux.dev>
Cc: Barry Song <baohua@kernel.org>
Cc: David Hildenbrand <david@kernel.org>
Cc: Johannes Weiner <hannes@cmpxchg.org>
Cc: Kairui Song <kasong@tencent.com>
Cc: Lorenzo Stoakes <ljs@kernel.org>
Cc: Michal Hocko <mhocko@kernel.org>
Cc: Shakeel Butt <shakeel.butt@linux.dev>
Cc: Wei Xu <weixugc@google.com>
Cc: Yuanchu Xie <yuanchu@google.com>
Cc: <stable@vger.kernel.org>
---
 mm/vmscan.c | 11 +++++++----
 1 file changed, 7 insertions(+), 4 deletions(-)

diff --git a/mm/vmscan.c b/mm/vmscan.c
index 40d3f1b48a74c..4059d13007896 100644
--- a/mm/vmscan.c
+++ b/mm/vmscan.c
@@ -3223,8 +3223,11 @@ struct ctrl_pos {
 	int gain;
 };
 
-static void read_ctrl_pos(struct lruvec *lruvec, int type, int tier_min,
-			  int tier_max, int gain, struct ctrl_pos *pos)
+/*
+ * __noipa works around gcc-16 warning for uninitialized use of pos->refaulted
+ */
+static void __noipa read_ctrl_pos(struct lruvec *lruvec, int type, int tier_min,
+				  int tier_max, int gain, struct ctrl_pos *pos)
 {
 	int i;
 	struct lru_gen_folio *lrugen = &lruvec->lrugen;
@@ -4873,7 +4876,7 @@ static int scan_folios(unsigned long nr_to_scan, struct lruvec *lruvec,
 static int get_tier_idx(struct lruvec *lruvec, int type)
 {
 	int tier;
-	struct ctrl_pos sp, pv = {};
+	struct ctrl_pos sp, pv;
 
 	/*
 	 * To leave a margin for fluctuations, use a larger gain factor (2:3).
@@ -4892,7 +4895,7 @@ static int get_tier_idx(struct lruvec *lruvec, int type)
 
 static int get_type_to_scan(struct lruvec *lruvec, int swappiness)
 {
-	struct ctrl_pos sp, pv = {};
+	struct ctrl_pos sp, pv;
 
 	if (swappiness <= MIN_SWAPPINESS + 1)
 		return LRU_GEN_FILE;
-- 
2.53.0




