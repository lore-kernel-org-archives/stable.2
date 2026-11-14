Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794672451;
	b=oLsvgmM0089tdD2cxPCSDPpBRb49BiorD8GRUjdO2Dsx4QGKKkTyFrsOplH6/QlVku9z
	 tMzlzifWSjNFKoHtv4aCLgolrwyjHrv3aApdFlhm/CDhqXzZDsF3tq7qr+3PSJwTO0gQD
	 WEUWazSl+VRf4JfxJOCXZq/3WVFwuGef4zXKQnG3lkNUY3zwtoQxrXaoWE92uhMwEFYWn
	 3O00V8yWJLS2aCbk+0LNtyf79plAXSG2sm7tFGzAY5IS+j/MyncHMmwxEo2udcJTccZ5W
	 p3DrFKpHxZG76+pwwvk49BeKZie8sIJ3GW3Ky5Sr6AdXeX2OALvSuc7gUSEIutgXvzA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794672451;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=9mUl2zxE6mFs8HLJKZ7tBZmSIV1Pw+lKUFmyiKwdUJo=;
	b=Z5Apjq9DrHycikDqk4GQmgTr3Ni0EHvnlhCb0mywAnf+hgKz7hj+6Ok4W3FdlzWlxMsM
	 RmCXlUVgQcAhsxDuFAwycG8ireUwBPZU013bJXUKUrLadf2Dh7Sy1ay3DgP4MBCbgDRwf
	 /gBYGBg615GcAEdlTZLImF5jWXfRMZaT+XsRFfYrA8gntfbsDJuD6DHHpScSCr/WKfkWl
	 v0wKkM9Nc6M7XzFDSle3ykaI+fLKcNxe6lyfrQk2NOovgckHht4tyNgyB2q/AEH3dpsxk
	 PEcb1p+C8f13tSgmDXXPkvj4foLrkPQ6vWe6skuEoIJXGweCwMqKFgTfnSjQ1sZOL0g==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Zy4eGhvN;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D4E97606A32E
	for <stable@vger.kernel.org>; Sat, 14 Nov 2026 16:07:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Zy4eGhvN
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 013F51F000C4;
	Sat, 14 Nov 2026 16:07:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794672451;
	bh=9mUl2zxE6mFs8HLJKZ7tBZmSIV1Pw+lKUFmyiKwdUJo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=Zy4eGhvN1MhuSL9N4qCuM50bYavsZU2imCseaHxHQ1Ece59PvIedFDiAAvs8cDTQ5
	 3+UaM1oklbMdaMsqmerYONhsTaugROE+zH6WBdAxBim3CHVErj1MRCYQIKgIYblJmz
	 9huzpCP7NbcH9ytLZHAL0DHdAOpN6QjLkszJIaNt5ct2Q3IRQMOepdPPdLLgSArZQn
	 PcPv3Nl/X1U8E4G053RD7GUXLfmXpAF/VueG7FZ0MpA95xkhr4d25f/0QQ1mEdUlnS
	 bUJeQkyq+sOcM/6eCvLKPnbDOgWS0ZpG/oLB1SpwU4qD5fH0yLIJf+J5zYAIo7RhLK
	 RDueo2JI1trWA==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Hongbin Wang <wh_bin@126.com>,
	Steffen Klassert <steffen.klassert@secunet.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.15.y 1/2] xfrm: Drop unused argument
Date: Sat, 14 Nov 2026 11:07:28 -0500
Message-ID: <20261114160719.3922066-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261109202003-failed-5.15-868f63c8bfaf@kernel.org>
References: <20261109202003-failed-5.15-868f63c8bfaf@kernel.org>
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

From: Hongbin Wang <wh_bin@126.com>

[ Upstream commit 0de1978852dff8643a80f20a8f44cef3f16c2db0 ]

Drop unused argument from xfrm_policy_match,
__xfrm_policy_eval_candidates and xfrm_policy_eval_candidates.
No functional changes intended.

Signed-off-by: Hongbin Wang <wh_bin@126.com>
Signed-off-by: Steffen Klassert <steffen.klassert@secunet.com>
Stable-dep-of: 868f63c8bfaf ("xfrm: retry inexact policy lookup after node reinsertion")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 net/xfrm/xfrm_policy.c | 15 +++++++--------
 1 file changed, 7 insertions(+), 8 deletions(-)

diff --git a/net/xfrm/xfrm_policy.c b/net/xfrm/xfrm_policy.c
index 15d50b5a22ef1..9e18e8d2c1c5c 100644
--- a/net/xfrm/xfrm_policy.c
+++ b/net/xfrm/xfrm_policy.c
@@ -1908,7 +1908,7 @@ EXPORT_SYMBOL(xfrm_policy_walk_done);
  */
 static int xfrm_policy_match(const struct xfrm_policy *pol,
 			     const struct flowi *fl,
-			     u8 type, u16 family, int dir, u32 if_id)
+			     u8 type, u16 family, u32 if_id)
 {
 	const struct xfrm_selector *sel = &pol->selector;
 	int ret = -ESRCH;
@@ -2033,7 +2033,7 @@ static struct xfrm_policy *
 __xfrm_policy_eval_candidates(struct hlist_head *chain,
 			      struct xfrm_policy *prefer,
 			      const struct flowi *fl,
-			      u8 type, u16 family, int dir, u32 if_id)
+			      u8 type, u16 family, u32 if_id)
 {
 	u32 priority = prefer ? prefer->priority : ~0u;
 	struct xfrm_policy *pol;
@@ -2047,7 +2047,7 @@ __xfrm_policy_eval_candidates(struct hlist_head *chain,
 		if (pol->priority > priority)
 			break;
 
-		err = xfrm_policy_match(pol, fl, type, family, dir, if_id);
+		err = xfrm_policy_match(pol, fl, type, family, if_id);
 		if (err) {
 			if (err != -ESRCH)
 				return ERR_PTR(err);
@@ -2072,7 +2072,7 @@ static struct xfrm_policy *
 xfrm_policy_eval_candidates(struct xfrm_pol_inexact_candidates *cand,
 			    struct xfrm_policy *prefer,
 			    const struct flowi *fl,
-			    u8 type, u16 family, int dir, u32 if_id)
+			    u8 type, u16 family, u32 if_id)
 {
 	struct xfrm_policy *tmp;
 	int i;
@@ -2080,8 +2080,7 @@ xfrm_policy_eval_candidates(struct xfrm_pol_inexact_candidates *cand,
 	for (i = 0; i < ARRAY_SIZE(cand->res); i++) {
 		tmp = __xfrm_policy_eval_candidates(cand->res[i],
 						    prefer,
-						    fl, type, family, dir,
-						    if_id);
+						    fl, type, family, if_id);
 		if (!tmp)
 			continue;
 
@@ -2120,7 +2119,7 @@ static struct xfrm_policy *xfrm_policy_lookup_bytype(struct net *net, u8 type,
 
 	ret = NULL;
 	hlist_for_each_entry_rcu(pol, chain, bydst) {
-		err = xfrm_policy_match(pol, fl, type, family, dir, if_id);
+		err = xfrm_policy_match(pol, fl, type, family, if_id);
 		if (err) {
 			if (err == -ESRCH)
 				continue;
@@ -2139,7 +2138,7 @@ static struct xfrm_policy *xfrm_policy_lookup_bytype(struct net *net, u8 type,
 		goto skip_inexact;
 
 	pol = xfrm_policy_eval_candidates(&cand, ret, fl, type,
-					  family, dir, if_id);
+					  family, if_id);
 	if (pol) {
 		ret = pol;
 		if (IS_ERR(pol))
-- 
2.53.0

