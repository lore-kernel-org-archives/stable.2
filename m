Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795816982;
	b=tCPnLfPqopsXShVBK2tctVVCeIO3FpD50Iwzafv4aIeGOf2hJuAPcIse80IMrFGf2ngc
	 /Gb3A4mKIkRKRGA68YH05DWZQba1AvyjvbyZ9GlPamnmPSlQsbIxre0ESrEeez6nGtYxp
	 cF92zezOHxr8lc7mekQhdU7bzmsG8w+pYMImtijHV7/tR3h9QjSg0hiFoVAkmnZgRJclm
	 jj6mAtx/84laow6O9RMfExFTBMfvzhomL46iWN7db/Pe0gTpoMcMlPbeZbM5N3FrhZNBw
	 d70FPBHsAqTNp7S3SsOus4rTMkAyQmYzSbYXeGg27kDenfHE8eSznm5i+FSsDiXobFA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795816982;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 MIME-Version:Content-Transfer-Encoding;
	bh=BCJTZRnGztgdMYTCaqeVM+6f8MnMShmmaX94qOAQDo0=;
	b=VryZrl6XIqCJAubdc34KxsrRGEHakB1KWA3V1fnBlQoz1VA6bRehkVNF+lMwEiHrx6Jh
	 LyEl18b1oFAJJxTvxJU2aHOR/770FFQFpl3us/dUeiDV7tYNLTcQKYvRp/Pai1k9xDfXJ
	 ViK8ONuO2QUPBa6+s3ot9EVH3ddZl9+RBF9znCs1m1nVZZpbalTLn6TmPx5u1EdnU5AU2
	 KjbRcDx3fpplhLz9KueYY9fbUw4YK668uxCsV0tzFg2Ipa6U+SghPOv6qCO7HUZGbIlYl
	 BVbsoNUqTxE5gXA/33EcVh9GY15Jmn5EseQGfzJJkFe59rhtfdMaVWAn7UuHFWfXrEw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=AJ6ML24A;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C263F606A31C;
	Fri, 27 Nov 2026 22:03:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=AJ6ML24A
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 30D991F00893;
	Fri, 27 Nov 2026 22:03:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795816982;
	bh=BCJTZRnGztgdMYTCaqeVM+6f8MnMShmmaX94qOAQDo0=;
	h=From:To:Cc:Subject:Date;
	b=AJ6ML24AXM3tssIwQAlxrjOq/OucBgJ1gzTSGTrlZn5O314KKU8ge+M6xPypCRCfo
	 zqMh7DFjhA6kR6nbu87subKbRihAaYWzbSNZNs4gLe+AEUMA08/rOSgZ91B+kFfzon
	 FAn7SrkJkY+cBwSZDNMDiE6volrqK6C98OVaV0nUzyIumaFMtPC7Nz31/EkDNHjdBK
	 zgL4uipPTNI4YGBYkmt0rx6x4K5M/MQH2XuPGiKn8B57unqYXV/uT4WxFsTopLgAsB
	 uzFu6cCuRxy4cdXdg97NlAG0Ai2VbMLeO76v5uQD/r9b5mPI5JUgrP046Ygg1zfhiI
	 V/YZXqzBQTEig==
From: SJ Park <sj@kernel.org>
To: 
Cc: SJ Park <sj@kernel.org>,
	stable@vger.kernel.org,
	Andrew Morton <akpm@linux-foundation.org>,
	damon@lists.linux.dev,
	linux-mm@kvack.org,
	Lin Ruifeng <linruifeng4@huawei.com>
Subject: [RFC PATCH mm-hotfixes-unstable] mm/damon/core: let kdamond freezable
Date: Fri, 27 Nov 2026 14:02:53 -0800
Message-ID: <20261127220255.99924-1-sj@kernel.org>
X-Mailer: git-send-email 2.47.3
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

DAMON's worker threads, kdamonds, are not freezable.  If DAMOS is set,
it could migrate or reclaim pages while the hibernation image is being
copied.  It could corrupt the resulting image.  As a result the system
could run with the corrupted memory after resuming from hibernation.

Users could work around by stopping or pausing the kdamond before the
hibernation imaging is started.  But it is easy to forget.  Just make it
freezable.

The user impact is quite bad.  Nonetheless, the problem is only found by
the theory.  No real issue from such memory corruption is found and
reported so far.

This change was originally suggested [1] by Lin Ruifeng.

[1] https://lore.kernel.org/20260408080652.1745410-1-linruifeng4@huawei.com

Fixes: af122dd8f3c0 ("mm/damon/dbgfs: support DAMON-based Operation Schemes")
Cc: <stable@vger.kernel.org> # 5.16.x
Suggested-by: Lin Ruifeng <linruifeng4@huawei.com>
Signed-off-by: SJ Park <sj@kernel.org>
---
 mm/damon/core.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/mm/damon/core.c b/mm/damon/core.c
index 0e6b361f97ea..f421965d1f58 100644
--- a/mm/damon/core.c
+++ b/mm/damon/core.c
@@ -7,6 +7,7 @@
 
 #include <linux/damon.h>
 #include <linux/delay.h>
+#include <linux/freezer.h>
 #include <linux/kthread.h>
 #include <linux/memcontrol.h>
 #include <linux/mm.h>
@@ -3845,7 +3846,7 @@ static bool kdamond_need_stop(struct damon_ctx *ctx)
 {
 	struct damon_target *t;
 
-	if (kthread_should_stop())
+	if (kthread_freezable_should_stop(NULL))
 		return true;
 
 	if (!ctx->ops.target_valid)
@@ -4056,6 +4057,7 @@ static int kdamond_fn(void *data)
 
 	sz_limit = damon_apply_min_nr_regions(ctx);
 
+	set_freezable();
 	while (!kdamond_need_stop(ctx)) {
 		/*
 		 * ctx->attrs and ctx->next_{aggregation,ops_update}_sis could

base-commit: daba53bdc1a54c453c2f4ced54a1cd52416c3f87
-- 
2.47.3
