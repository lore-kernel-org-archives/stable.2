Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4C88F2F7F07
	for <stable@vger.kernel.org>; Wed, 15 Jul 2026 21:31:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784151110; cv=none; b=TAEbI/e8YwKJd9cNmjD1o+N4nGqqJSJ9InpQEDTqgajJpVZzG/ChxKoUF8WtlzBZMOyyU0sF8f7GFbtVZHLKDY1mOuQMqsUGRbRV5c8UBLUpxri5ShjV/nFFknLhKIv+KChqHOvcTOd9NITjA6IzdhvzFSSWanZ3T3+LX1mzvfA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784151110; c=relaxed/simple;
	bh=NTmCkuvg5fU24nhyti5hNqff00jqSS3ePln3htE8oCc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=T29oCcOnmAErOnZ3o3nu+KxBuGEK+gDiGOf2Bl/31s114IZVl2YKHABNabDH0Wi2boSqbRxsfbQ40PUEzmxtJdvde1dbsGK4iFl92PTrKYILqMzkvRpxAESLWmpzaFWDo2f+r04EuqcICKx8cxn+DyYcfvtxw2aTBCRM4efCW2Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ZdKsdi5U; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZdKsdi5U"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A89361F000E9;
	Wed, 15 Jul 2026 21:31:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784151109;
	bh=Bb0M8fAkDneRa7c3WVGfuvEqQudHJ+Hb6f1RHFZi9GY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=ZdKsdi5UxjtuCydZp9xkESXNRp3+GxRsRRsPykZGkJOgWBZjht3iWo3iF32gGFtQE
	 LQf9pZWJZXf8zKWKyL8hg5/9oZENhPWAXZGQk+hHpcTrpeWmI/hgnMhwRX3ItM1yZR
	 cCWbxubPoxpPTc1B30wIxW4xzvBIk1CQZzID/S+OuAmBeUXXMnZvn3KDI5/WdzAzFK
	 suQd7g5RUAKw6+zHK4aLVYbk1kZ7kCQZ1C7/pxUp7p/1duCmV8RPvvLhsFGWc3uKAT
	 Pn6CPXT/fw52PXX1qQF5ERxYosLnniLT41QAdAmfbBj28DDoAbuqCjdzTyyWrBnj3j
	 wB4scfmQYCzFA==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Qianfeng Rong <rongqianfeng@vivo.com>,
	Florian Westphal <fw@strlen.de>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.10.y 1/2] netfilter: ebtables: Use vmalloc_array() to improve code
Date: Wed, 15 Jul 2026 17:31:45 -0400
Message-ID: <20260715213146.296837-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026071335-dolly-tinwork-7a6f@gregkh>
References: <2026071335-dolly-tinwork-7a6f@gregkh>
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
index e86695f1ed95b6..075387678f8228 100644
--- a/net/bridge/netfilter/ebtables.c
+++ b/net/bridge/netfilter/ebtables.c
@@ -881,8 +881,8 @@ static int translate_table(struct net *net, const char *name,
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
@@ -897,7 +897,7 @@ static int translate_table(struct net *net, const char *name,
 			}
 		}
 
-		cl_s = vmalloc(array_size(udc_cnt, sizeof(*cl_s)));
+		cl_s = vmalloc_array(udc_cnt, sizeof(*cl_s));
 		if (!cl_s)
 			return -ENOMEM;
 		i = 0; /* the i'th udc */
@@ -977,8 +977,8 @@ static int do_replace_finish(struct net *net, struct ebt_replace *repl,
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
@@ -1273,7 +1273,7 @@ static int do_update_counters(struct net *net, const char *name,
 	if (num_counters == 0)
 		return -EINVAL;
 
-	tmp = vmalloc(array_size(num_counters, sizeof(*tmp)));
+	tmp = vmalloc_array(num_counters, sizeof(*tmp));
 	if (!tmp)
 		return -ENOMEM;
 
@@ -1412,7 +1412,7 @@ static int copy_counters_to_user(struct ebt_table *t,
 	if (num_counters != nentries)
 		return -EINVAL;
 
-	counterstmp = vmalloc(array_size(nentries, sizeof(*counterstmp)));
+	counterstmp = vmalloc_array(nentries, sizeof(*counterstmp));
 	if (!counterstmp)
 		return -ENOMEM;
 
-- 
2.53.0

