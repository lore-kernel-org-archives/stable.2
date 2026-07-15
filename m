Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1FE083C1989
	for <stable@vger.kernel.org>; Wed, 15 Jul 2026 21:26:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784150810; cv=none; b=H36Z/rnmgVpPYRzl9Ea7t8L9ET7TItyTs1oMazVTNnkTbm4+F1sG/U/bCBxhZ2rNwldJTBoFvMEwxLj7EK1g8eAyKS1e4I1GuQ3gYBCd9BRKYHEkwNTVbU76+i1nrg/ac9KE8ktkqOcgBzD6bAwmlHMC6GeXHp81hxyhATIuYxY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784150810; c=relaxed/simple;
	bh=AO/t3ucENz8qT38k9mzwwZ3Mt75ifsu9rSC2axUZPms=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=lcsLS9nbjQjVjv96z7uf9NDEq4pFlWhmqG75tmXB9cBuRgO9mSIwaqPHZPfYDcVIY+UlExEjB4jfoAPSlAvZc2nte3lLfqq/oCEeq9F9zRkBfpkLCCgFhAJ8g6vU8JXYEJk9kjrP/VFnYpxfphkoQ44W0Cv7JAS5RyNwnEaLrXo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=j51v9Csi; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="j51v9Csi"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 02C261F000E9;
	Wed, 15 Jul 2026 21:26:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784150808;
	bh=BlaNX3D5O06jgx05FaZrxZsJafkbU32fZta33c3SgEk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=j51v9CsiSRx1Wra9A2CWzBSDjoy0v+Mw9mIj+PDtczFPoGEv9nysr+KESTJI7DNy7
	 zMaqZ/ulRJRFjnTOb1R1/cNoLS8dbRFUjxehYDOTBwWcYSXbeTY4Qlv22blKq94Q91
	 Nl6MO/pQgFw8mqMlNAwOO/bKEbaqw7o2zl1UFwF51hw0NE3NOO59Q5Rq0iU5caums+
	 OcdVUhxwvtQWICFLuLAQSRM41oOwfn2gHISIWOGKrlICjN+ZR3QsQ2ai1LaBxbotCO
	 K4uUTmUhvRE4ZR9JMSoKLIrSkKcjDLp65A6CwLA9MDOyFKxfcSGNkjoiH9LrP0QZzn
	 ZTWn9tBS7XZjA==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Qianfeng Rong <rongqianfeng@vivo.com>,
	Florian Westphal <fw@strlen.de>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.15.y 1/2] netfilter: ebtables: Use vmalloc_array() to improve code
Date: Wed, 15 Jul 2026 17:26:45 -0400
Message-ID: <20260715212646.278719-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026071335-donator-saucy-140c@gregkh>
References: <2026071335-donator-saucy-140c@gregkh>
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
index 2083facfc87d9b..9d23eee5736789 100644
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
 
@@ -1525,7 +1525,7 @@ static int copy_counters_to_user(struct ebt_table *t,
 	if (num_counters != nentries)
 		return -EINVAL;
 
-	counterstmp = vmalloc(array_size(nentries, sizeof(*counterstmp)));
+	counterstmp = vmalloc_array(nentries, sizeof(*counterstmp));
 	if (!counterstmp)
 		return -ENOMEM;
 
-- 
2.53.0

