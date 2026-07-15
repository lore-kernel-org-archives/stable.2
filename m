Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C273A35E949
	for <stable@vger.kernel.org>; Wed, 15 Jul 2026 21:13:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784150032; cv=none; b=pOJrV0O8Yr7nvKUndpG7PWReNsQOp3JKwZjzbHN7niH5MPa2tL1SXyFJphcOIzAEGpUgW4ozOT7jPuwaHy/bhpKuYGbo7cjYmCyJAvXLRDxM2QsGtw2CG5IjWCbBkigxhLBMHs5ZSe2y1fBqtYk2+1l6ri8KVHwQOrU8KkhGITc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784150032; c=relaxed/simple;
	bh=9Q+ZCrvokGzrphQdmqxldsnJ3BO5TrDoawVtkwJvKiM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=jL1wybBcxby/ftqIGUmjTpCpb6Mwc1ts3Esw+joOTahzWgFPneMq/JHu6slbZj6NesaeDjv+Y/hQb8bVuHUmjDR7i/inUFTwbGCvu0OCKfLoGv+bZfcfBCDtMpXmZQ6ez3r6iCluEJ4VxAv+78a2jrzJiGxG8fvn0wGst4JY7PU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=kyyoopAX; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kyyoopAX"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DD2CB1F00A3A;
	Wed, 15 Jul 2026 21:13:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784150031;
	bh=EYNzHls3+SbrztiqAi5jP55bXDZ2iigtrFGFtjSIgII=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=kyyoopAXn9rIyzku3gq3oQ54uXUdd4+M/mPUDeeh5GV3dI3NWULz2GsbKp+iVLWdF
	 XRewRq9kXLWf3u6xOI9tCu1a8UpnkmlK7EZykdEhInUPLmwPGlnQ008GbSaB3+rPhE
	 2tlx3MKa5CJSa7dRLYvY9Mar+saFC/0k75F74+hMiSPl37YddRvteWzkHYSE+H3X8e
	 +cjuWCDT/KJuxeD4aeo/Da12bMg/2qh1rZPSwEeGFqwaiCFfLhjdi9Ux/XuJGBwcwl
	 kJoPxDN8V0E/eJ62CljTassE3VQqi8j3YKRzrJiiKJB0DBuhu+tl1N/c77lwetxULP
	 di194eaIRBOKA==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Qianfeng Rong <rongqianfeng@vivo.com>,
	Florian Westphal <fw@strlen.de>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.1.y 1/2] netfilter: ebtables: Use vmalloc_array() to improve code
Date: Wed, 15 Jul 2026 17:13:48 -0400
Message-ID: <20260715211349.253327-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026071335-stench-wolverine-f95c@gregkh>
References: <2026071335-stench-wolverine-f95c@gregkh>
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

