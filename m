Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C40A33B19A6
	for <stable@vger.kernel.org>; Wed, 15 Jul 2026 20:16:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784146574; cv=none; b=QBejjbH7QHSjFRjRZm4KF3muJJ+/qU9uBEOa4Y62exUAfm+FjR7/dhV188FGou4rtHMdgiJi7f9VlCSqOVkA4O7hw8RCs795XVvSHdCxE1iud9NTnRMg7dq4PHw9EpY/CnomTEOD5JbIehOJMNi4X1uMdmapIX1pO/grOInCx3k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784146574; c=relaxed/simple;
	bh=mefjOLlEJ+ENJv9+suLHOxY/AM1fbUVV7qe4xvEyV2k=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Nanj2dyz4OM/5nP7/UnoQXOEKBEoEg9l7NQsBkCcf9QrrN7mkJW8EYy8v6P93fLY7yIm1YTlfwRqrlGZN2W+ECmINWx9HBtNHL5ErQyfaCUwI8Tux3bgNjubBSpq3lnZwCUq/642FOkGOpjb3f9akhiD4EQMe5o8gG/b2WebpLA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=KZ6xtpzV; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="KZ6xtpzV"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C54491F000E9;
	Wed, 15 Jul 2026 20:16:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784146572;
	bh=VwtJCiQcltw5/pjznHvcIHUFyFWtiHNK8saIcfRrkFo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=KZ6xtpzVv+aWBrAwUHZFR+WbMEMVi6VkLL7Py9NmTaeYiojJQfSHTWoolihrwWtoa
	 kpi98GF8vzY0awJPSWkyCctdqJNoz8QQ2TVnooUED0LjOW1lk+GJZ7HpS7k5wIlS/4
	 YpviqDLud8+kiiGAs2FJnHu6txCymrnq2/j2iErJ/uP0E+PLOpMAVqhXB8ev4QujPN
	 Eb1n7ofGR0HCdhrlcxVTs8K/B0gYb6WMs8k6DzngURattFshyQQYyID3tVVptS4XPj
	 7YkJvAoGdqOcooSKSdADCaOaUFQIt9YcLyTsypHpvK2zO3hRK2eCrzQL9JxDRHyeTM
	 4tN+gbmNaohpA==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Qianfeng Rong <rongqianfeng@vivo.com>,
	Florian Westphal <fw@strlen.de>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.12.y 1/2] netfilter: ebtables: Use vmalloc_array() to improve code
Date: Wed, 15 Jul 2026 16:16:09 -0400
Message-ID: <20260715201610.64283-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026071334-dribble-bunny-03b1@gregkh>
References: <2026071334-dribble-bunny-03b1@gregkh>
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
index 1bc7b5d8f76d7a..d8dda76ac14524 100644
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

