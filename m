Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DE82232E128
	for <stable@vger.kernel.org>; Wed, 15 Jul 2026 20:49:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784148591; cv=none; b=Vy0we9OVgFlpwmEMeEOQOH/NVayZTDTw2Jb+qc5uPfX4ohwEy7seZK6csng5pQulB4z6qD846Lj12l2TyQlS4ttI+R6fJHjyknyQgouZRM5HeSv4j2I6hiw2QrwmD4dYNKym7yyqA87FieuxmNWCI6QF7WHG6s55ThJ3AFe0seo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784148591; c=relaxed/simple;
	bh=9Q+ZCrvokGzrphQdmqxldsnJ3BO5TrDoawVtkwJvKiM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=b7hE7ph7gC0SFd/NhR9cjsg+lS1fAMa6bY3pajyPQZs7/h+8GZTMKsBcQCkHyl26lQtgusqBlZLu84Fd/r+ODXMFKHNwRj6PC7EFN9xMGo0NcES9f6Fv+R+FicKbrBbGtqhcZswR3b+lYYvqffWZhVAPhVyD6lobt1HzK2crPaE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=DWnIG5xl; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="DWnIG5xl"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 172901F000E9;
	Wed, 15 Jul 2026 20:49:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784148589;
	bh=EYNzHls3+SbrztiqAi5jP55bXDZ2iigtrFGFtjSIgII=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=DWnIG5xliY8SyqF1fnJjxmGhWcWANQaZClDGsPyDOdYYqx66WdFQs4SDT67y5syO5
	 25yv4jrunlsNBc0VqzW+1gMnp2TyznwYqhSsO44iZ7P1a4Ep+HHs+/cNYqeWDfwPPZ
	 XSqWxB1rZdCOrUFguyUlkfNjtsYPH97y5uS+hq1XcZWekW55UVm1MgaMVTZsRB4BUk
	 2Jmv4GXPVVEm6vG9IcVvTcSLolWuu+guFhuAtQH7zybuIYWVQHnyYiXEsBqA8NPppJ
	 XZYQOjsloTSxztOv9sfFNQQPC3WjAKJm0Zprl39m7SoemN50uKvNSCxDClnhwbIew9
	 bCywjLY+wrK6w==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Qianfeng Rong <rongqianfeng@vivo.com>,
	Florian Westphal <fw@strlen.de>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.6.y 1/2] netfilter: ebtables: Use vmalloc_array() to improve code
Date: Wed, 15 Jul 2026 16:49:46 -0400
Message-ID: <20260715204947.205286-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026071335-exemplify-sheet-ddd5@gregkh>
References: <2026071335-exemplify-sheet-ddd5@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Qianfeng Rong <rongqianfeng@vivo.com>

[ Upstream commit 46015e6b3ea75297b28d4806564f3f692cf11861 ]

Remove array_size() calls and replace vmalloc() with vmalloc_array() to
simplify the code.  vmalloc_array() is also optimized better, uses fewer
instructions, and handles overflow more concisely[1].

[1]: https://lore.kernel.org/lkml/abc66ec5-85a4-47e1-9759-2f60ab111971@vivo.com/
Signed-off-by: Qianfeng Rong <rongqianfeng@vivo.com>
Signed-off-by: Florian Westphal <fw@strlen.de>
Stable-dep-of: cbfe53599eeb ("netfilter: ebtables: zero chainstack array")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 net/bridge/netfilter/ebtables.c | 14 +++++++-------
 1 file changed, 7 insertions(+), 7 deletions(-)

diff --git a/net/bridge/netfilter/ebtables.c b/net/bridge/netfilter/ebtables.c
index bc69406d103df6..4d0fcee59fdd57 100644
--- a/net/bridge/netfilter/ebtables.c
+++ b/net/bridge/netfilter/ebtables.c
@@ -920,8 +920,8 @@ static int translate_table(struct net *net, const char *name,
 		 * if an error occurs
 		 */
 		newinfo->chainstack =
-			vmalloc(array_size(nr_cpu_ids,
-					   sizeof(*(newinfo->chainstack))));
+			vmalloc_array(nr_cpu_ids,
+				      sizeof(*(newinfo->chainstack)));
 		if (!newinfo->chainstack)
 			return -ENOMEM;
 		for_each_possible_cpu(i) {
@@ -938,7 +938,7 @@ static int translate_table(struct net *net, const char *name,
 			}
 		}
 
-		cl_s = vmalloc(array_size(udc_cnt, sizeof(*cl_s)));
+		cl_s = vmalloc_array(udc_cnt, sizeof(*cl_s));
 		if (!cl_s)
 			return -ENOMEM;
 		i = 0; /* the i'th udc */
@@ -1018,8 +1018,8 @@ static int do_replace_finish(struct net *net, struct ebt_replace *repl,
 	 * the check on the size is done later, when we have the lock
 	 */
 	if (repl->num_counters) {
-		unsigned long size = repl->num_counters * sizeof(*counterstmp);
-		counterstmp = vmalloc(size);
+		counterstmp = vmalloc_array(repl->num_counters,
+					    sizeof(*counterstmp));
 		if (!counterstmp)
 			return -ENOMEM;
 	}
@@ -1386,7 +1386,7 @@ static int do_update_counters(struct net *net, const char *name,
 	if (num_counters == 0)
 		return -EINVAL;
 
-	tmp = vmalloc(array_size(num_counters, sizeof(*tmp)));
+	tmp = vmalloc_array(num_counters, sizeof(*tmp));
 	if (!tmp)
 		return -ENOMEM;
 
@@ -1526,7 +1526,7 @@ static int copy_counters_to_user(struct ebt_table *t,
 	if (num_counters != nentries)
 		return -EINVAL;
 
-	counterstmp = vmalloc(array_size(nentries, sizeof(*counterstmp)));
+	counterstmp = vmalloc_array(nentries, sizeof(*counterstmp));
 	if (!counterstmp)
 		return -ENOMEM;
 
-- 
2.53.0

