Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8A82B30C14A;
	Wed,  2 Sep 2026 00:27:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788308855; cv=none; b=HpJbKNKarpgvpErepFZKFOP5oje543EQOe0R01QLqTJ80Nv9fk5MARU+9zwstFdy0ZfoRTh5kDGJHGKdSOMsfFMBohZBwJDhc6SrbsRc5alWjl1fj/Lw4HOZEL//fU7nuTQ9pRNRqsu6eY7rCU5fiUfPs0yMaGy3V37SXN+/uD0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788308855; c=relaxed/simple;
	bh=ddJls6Z/ngnt9vZmX1K+spUcI8CLqjuVk9ZoDNPKseY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=lF3EuASeVYQGZ47W95+v308uHU2jS4AsYa8M4E0gyL6DUmMrzs9lmvZ1E2Y39e0FRrHMVE1utbkoqM7kSb11/oUhyj7nvw7js3qStFDCOLDaA2/+4mwxCaZMjLqWhONRUpK7bLZWXEjQl/IgVwNERwVT+Bl7A86YiRlD0fEot9w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=bqyf63ol; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="bqyf63ol"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E916E1F00A3A;
	Wed,  2 Sep 2026 00:27:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788308854;
	bh=dPYnDusm6ZlAINNm2dD6FV62eCx2pxNkpvN0aJrj8uI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=bqyf63oliUzCdLSCa2ShHyBHxtNTT/sxl0PpKRYUg0wgdCm+1RksqmlFUexq4GXUF
	 sX0oaDNLD8cyUfONL3G62kOpS1QRAB4Y8xSj/ZLMh9X6K8b7PoPpgoSKWB9OkjNmfh
	 2p+nSviFi+R1qQBPfHzy9bMl7t+S+BWcahgF8O6yxb6s9mEsUp0ORv7HpriEBrIAzM
	 MTmyd7Dx/zbTHGFecODtxBiKRaW4xovLK0r7jjzLjV5cmaOvtEZ60ZaNgFIF882pu9
	 9W/gOC7hyqT9D58C/CiPhF2EWdYh99cCrBuKoBu+Jv2pTwLqw8uCgmaTu62x2LO9TN
	 NkUfnM38685mA==
From: SJ Park <sj@kernel.org>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: SJ Park <sj@kernel.org>,
	stable@vger.kernel.org,
	Quanmin Yan <yanquanmin1@huawei.com>,
	damon@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org
Subject: [PATCH 4/4] mm/damon/sysfs: set next refresh jiffies per sysfs context
Date: Tue,  1 Sep 2026 17:27:23 -0700
Message-ID: <20260902002725.108635-5-sj@kernel.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260902002725.108635-1-sj@kernel.org>
References: <20260902002725.108635-1-sj@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

When 'refresh_ms' is set, DAMON sysfs interface periodically updates
auto-tuned parameters and DAMOS stats.  The timestamp for the next
refresh is initialized when a DAMON context starts, and updated in its
damon_call() callback function.  That is, each DAMON context updates it.
However, the timestamp is a global variable that is shared with all the
contexts.  When there are multiple DAMON contexts having different
refresh_ms, the update frequency will be changed, depending on the order
of the contexts.  When there are multiple kdamonds, it will be even more
chaotic.  Fix the problem by having the timestamp per each context.

The user impact is not very critical.  It does not leak, corrupt or
crash.  The update will not be faster or slower than the lowest and
largest refresh_ms values of the contexts, respectively.  The user can
also manually ask the updates on demand using kdamond state commands.
That said, clearly this is a bug and can easily be reproduced.

Fixes: 9fd7bb5083d1 ("mm/damon/sysfs: change next_update_jiffies to a global variable")
Cc: <stable@vger.kernel.org> # 6.18.x
Signed-off-by: SJ Park <sj@kernel.org>
---
 mm/damon/sysfs.c | 11 +++++------
 1 file changed, 5 insertions(+), 6 deletions(-)

diff --git a/mm/damon/sysfs.c b/mm/damon/sysfs.c
index 3c81b4c91ac0d..dcb739ce0a729 100644
--- a/mm/damon/sysfs.c
+++ b/mm/damon/sysfs.c
@@ -1788,6 +1788,7 @@ struct damon_sysfs_kdamond {
 	struct damon_sysfs_contexts *contexts;
 	struct damon_ctx *damon_ctx;
 	unsigned int refresh_ms;
+	unsigned long next_refresh_jiffies;
 };
 
 static struct damon_sysfs_kdamond *damon_sysfs_kdamond_alloc(void)
@@ -2213,17 +2214,15 @@ static struct damon_ctx *damon_sysfs_build_ctx(
 	return ctx;
 }
 
-static unsigned long damon_sysfs_next_update_jiffies;
-
 static int damon_sysfs_repeat_call_fn(void *data)
 {
 	struct damon_sysfs_kdamond *sysfs_kdamond = data;
 
 	if (!sysfs_kdamond->refresh_ms)
 		return 0;
-	if (time_before(jiffies, damon_sysfs_next_update_jiffies))
+	if (time_before(jiffies, sysfs_kdamond->next_refresh_jiffies))
 		return 0;
-	damon_sysfs_next_update_jiffies = jiffies +
+	sysfs_kdamond->next_refresh_jiffies = jiffies +
 		msecs_to_jiffies(sysfs_kdamond->refresh_ms);
 
 	if (!mutex_trylock(&damon_sysfs_lock))
@@ -2271,8 +2270,8 @@ static int damon_sysfs_turn_damon_on(struct damon_sysfs_kdamond *kdamond)
 	}
 	kdamond->damon_ctx = ctx;
 
-	damon_sysfs_next_update_jiffies =
-		jiffies + msecs_to_jiffies(kdamond->refresh_ms);
+	kdamond->next_refresh_jiffies = jiffies +
+		msecs_to_jiffies(kdamond->refresh_ms);
 
 	repeat_call_control->fn = damon_sysfs_repeat_call_fn;
 	repeat_call_control->data = kdamond;
-- 
2.47.3
