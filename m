Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D1C6A48BD3C
	for <stable@vger.kernel.org>; Thu, 23 Jul 2026 14:34:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784817279; cv=none; b=E5ENAq2Joxb+sFzWr8Tl7LQSGHDKDgCc9sjlsLIQGFi+j6rPZW+1Qo8F/TtxnflUg9lHhSRVFlA2h0fgtgDa9lCP3S+nrkMQ8iSgFnHC9d6KZZPIPMmMuOjPRJDnVE8kB9g0LWg6pEUea1TNFO5h/QaQ5LtAyMqivqee4upG264=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784817279; c=relaxed/simple;
	bh=gzQQzwKWKECJUOGIGkIHz7k9q1+d7iaXYj3ak5cz9bc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=TSjssCVyt0lhy2w0/cOLlp2ScoZ3DyzUiR2bQZDtfecag5AlylrtJ4wCxJenJ1W8VOKnBy7Z8ARAQP0lgRiV+ybv2Ww/xHZsZzBEGNg3w9UPIuDU4I8WWy2qbVrP5Fl49lMNBAECOjzXiGDjouELlY9D+B+z+b3xzbxffHp/rIA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=oONY+bXR; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="oONY+bXR"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2C6771F00A3D;
	Thu, 23 Jul 2026 14:34:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784817275;
	bh=kfInsKxvH3tsfUAzgJzvihONmJQcf+wYm6mcAgJkgYg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=oONY+bXRTXGImyR1SJrW7bu1PqksCSsYkKScqeDV2fjsqQeI4dzTW1bjEtiN8T67K
	 QAqegTDr9k6bV/lU9JARu0NVvEzC7bhaMKzV09zHDIr1SCNDri7KccOb3RdbUG76IT
	 t+mXzd3Ch0ghcE+Mq5Tk0lC2+wdF5ICNsD42r4/HKOvRo5r/3/2OGX4AT6xhXa+IXC
	 F1gDcdUF0y/wdVFDbW1ZQJR8UcMSE/24FHTaowxYowX5RCeRIWTq4uo0/8slch0Lr7
	 /5PtO7knLRn7IVrsvA8igv/wTUOuvfbhPqXn23FguCofrIqKhoR4YOMpIHQNxTA8Ut
	 PsAKgBGrSu/qA==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Florian Westphal <fw@strlen.de>,
	Pablo Neira Ayuso <pablo@netfilter.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.1.y 1/8] netfilter: nft_set_pipapo: use GFP_KERNEL for insertions
Date: Thu, 23 Jul 2026 10:34:26 -0400
Message-ID: <20260723143433.3226555-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026072015-dating-wanting-8baf@gregkh>
References: <2026072015-dating-wanting-8baf@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Florian Westphal <fw@strlen.de>

[ Upstream commit 5b651783d80b97167ecd27dc6a4408c694873902 ]

An earlier attempt changed this to GFP_KERNEL, but the get helper is
also called for get requests from userspace, which uses rcu.

Let the caller pass in the kmalloc flags to allow insertions
to schedule if needed.

Suggested-by: Pablo Neira Ayuso <pablo@netfilter.org>
Signed-off-by: Florian Westphal <fw@strlen.de>
Stable-dep-of: 47e65eff5069 ("netfilter: nft_set_pipapo: don't leak bad clone into future transaction")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 net/netfilter/nft_set_pipapo.c | 17 ++++++++++-------
 1 file changed, 10 insertions(+), 7 deletions(-)

diff --git a/net/netfilter/nft_set_pipapo.c b/net/netfilter/nft_set_pipapo.c
index 11473275c6e263..6a14d0441c6ef0 100644
--- a/net/netfilter/nft_set_pipapo.c
+++ b/net/netfilter/nft_set_pipapo.c
@@ -505,6 +505,7 @@ bool nft_pipapo_lookup(const struct net *net, const struct nft_set *set,
  * @data:	Key data to be matched against existing elements
  * @genmask:	If set, check that element is active in given genmask
  * @tstamp:	timestamp to check for expired elements
+ * @gfp:	the type of memory to allocate (see kmalloc).
  *
  * This is essentially the same as the lookup function, except that it matches
  * key data against the uncommitted copy and doesn't use preallocated maps for
@@ -515,7 +516,7 @@ bool nft_pipapo_lookup(const struct net *net, const struct nft_set *set,
 static struct nft_pipapo_elem *pipapo_get(const struct net *net,
 					  const struct nft_set *set,
 					  const u8 *data, u8 genmask,
-					  u64 tstamp)
+					  u64 tstamp, gfp_t gfp)
 {
 	struct nft_pipapo_elem *ret = ERR_PTR(-ENOENT);
 	struct nft_pipapo *priv = nft_set_priv(set);
@@ -528,13 +529,13 @@ static struct nft_pipapo_elem *pipapo_get(const struct net *net,
 	if (m->bsize_max == 0)
 		return ret;
 
-	res_map = kmalloc_array(m->bsize_max, sizeof(*res_map), GFP_ATOMIC);
+	res_map = kmalloc_array(m->bsize_max, sizeof(*res_map), gfp);
 	if (!res_map) {
 		ret = ERR_PTR(-ENOMEM);
 		goto out;
 	}
 
-	fill_map = kcalloc(m->bsize_max, sizeof(*res_map), GFP_ATOMIC);
+	fill_map = kcalloc(m->bsize_max, sizeof(*res_map), gfp);
 	if (!fill_map) {
 		ret = ERR_PTR(-ENOMEM);
 		goto out;
@@ -609,7 +610,7 @@ static void *nft_pipapo_get(const struct net *net, const struct nft_set *set,
 			    const struct nft_set_elem *elem, unsigned int flags)
 {
 	return pipapo_get(net, set, (const u8 *)elem->key.val.data,
-			 nft_genmask_cur(net), get_jiffies_64());
+			 nft_genmask_cur(net), get_jiffies_64(), GFP_ATOMIC);
 }
 
 
@@ -1246,7 +1247,7 @@ static int nft_pipapo_insert(const struct net *net, const struct nft_set *set,
 	else
 		end = start;
 
-	dup = pipapo_get(net, set, start, genmask, tstamp);
+	dup = pipapo_get(net, set, start, genmask, tstamp, GFP_KERNEL);
 	if (!IS_ERR(dup)) {
 		/* Check if we already have the same exact entry */
 		const struct nft_data *dup_key, *dup_end;
@@ -1268,7 +1269,8 @@ static int nft_pipapo_insert(const struct net *net, const struct nft_set *set,
 
 	if (PTR_ERR(dup) == -ENOENT) {
 		/* Look for partially overlapping entries */
-		dup = pipapo_get(net, set, end, nft_genmask_next(net), tstamp);
+		dup = pipapo_get(net, set, end, nft_genmask_next(net), tstamp,
+				 GFP_KERNEL);
 	}
 
 	if (PTR_ERR(dup) != -ENOENT) {
@@ -1870,7 +1872,8 @@ static void *pipapo_deactivate(const struct net *net, const struct nft_set *set,
 {
 	struct nft_pipapo_elem *e;
 
-	e = pipapo_get(net, set, data, nft_genmask_next(net), nft_net_tstamp(net));
+	e = pipapo_get(net, set, data, nft_genmask_next(net),
+		       nft_net_tstamp(net), GFP_KERNEL);
 	if (IS_ERR(e))
 		return NULL;
 
-- 
2.53.0

