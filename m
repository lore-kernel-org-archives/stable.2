Received: from fhigh-a2-smtp.messagingengine.com (fhigh-a2-smtp.messagingengine.com [103.168.172.153])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 89E9540BCC4;
	Thu, 30 Jul 2026 11:40:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.153
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785411651; cv=none; b=FeePLCXyPAhT3+sATRQj5Iivh54Y7iNs28R0Dln4tsTQCsh41ydmhTkVPZdAHjL2fbmHTXwLbB0wwig7gR/CjLYwO0UaLTH2raGCyBehd0eSGSJ8yG0W/0gO1dYHJiS6xsupG5cDExS6z01+nDA88ZL3c54fNOL8IDjjh8R+37E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785411651; c=relaxed/simple;
	bh=++m2A5f/g1GhI7LD4S7U4F2Oc1KNNWqDYFaeuDOvHZM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=qVjqvprVvklTY+9mmKMgo6mM4OZj8ZnIxeCYTR/HrX/dMJ92GiqX8/d0E/PoBu4T9hoHGo/BHpIpMfU+bhtG8Grp/1K9wyhbm7pP3zS+j3etiYz/qfqWOgi4dKvFOt3dA9vlpRq9oGf0BM3PM9PHZd5KVKAeqAdbeq3J/pb7W94=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fourdim.xyz; spf=pass smtp.mailfrom=fourdim.xyz; dkim=pass (2048-bit key) header.d=fourdim.xyz header.i=@fourdim.xyz header.b=GpKyrMKW; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=U+ZpxL2Z; arc=none smtp.client-ip=103.168.172.153
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fourdim.xyz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fourdim.xyz
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fourdim.xyz header.i=@fourdim.xyz header.b="GpKyrMKW";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="U+ZpxL2Z"
Received: from phl-compute-05.internal (phl-compute-05.internal [10.202.2.45])
	by mailfhigh.phl.internal (Postfix) with ESMTP id A8DF61400102;
	Thu, 30 Jul 2026 07:40:48 -0400 (EDT)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-05.internal (MEProxy); Thu, 30 Jul 2026 07:40:48 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fourdim.xyz; h=
	cc:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm1; t=1785411648;
	 x=1785498048; bh=2PRH+TiaRNTVck/c7fpAib4XXYBnbYQMJn2aUAaKQuY=; b=
	GpKyrMKW4lpwiITVCOwUU/8kKq1DfPupVwdznsIHyk8H8yWfdgmV9qHLmY7RysbA
	iGETRvBYIHW0TE4ay2vUw32p1XaEkrzeS2iXOUaF9v3LHkOIOVOGROWgEUkMJu8o
	acBkQOwH3pITPJBvD+rVcK0CGsIUTICTvR14q7ic8IW7Guo4ZeyZSp5Q3Fzfn4SL
	olsNwf7WUrJWD9gT8pI3sLpTpnpaHWAciVB5wLcpEEnPOrD61fWbMtbCRswHlBG2
	TKzu+toC7U3enSFPjJJRTLKjagYJ78lAcW+UOZipEdWsTWdjAsoVXdTNSqpTf4gQ
	/DX2Ot/Vry5kA1ySskoJKQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1785411648; x=
	1785498048; bh=2PRH+TiaRNTVck/c7fpAib4XXYBnbYQMJn2aUAaKQuY=; b=U
	+ZpxL2ZXoYHky/pEshDpBhiRc3UN82IhaxM+bRz/vRmDUZkII9iMd0leP1EQpXgN
	8fiTKEFrGtBJzXmjGQphEHVIWDg7CDxIZzQrPvhC/Y0FBr0qh26sNSwprboDVYih
	Bf3nMTEACQ6e7Hq+D+8wMf74pZQrjfZY6IPX6bZBYhrhfeUrHdHDvvM1LW0SLtpS
	OuH1hkDj6KGZ8nLyITdX2zIjbn5WZPcKCLY4frKL/SMmHCHfHsxZ57AFi5v7ZXzJ
	+9H6NOkhFggJCgYlydmHdYkcofKvvgljqkCPaYkz7btwqnbc7UlyIvf5lBAC+0Fe
	tJr5osRtZEHpQDe7H58QA==
X-ME-Sender: <xms:QDhraknH1QYx-mvslUVCUcehsSjkmL9RPsZGCmTHxaUwCYMemN_UIw>
    <xme:QDhrasCAz8FfszlCx27aBuHKQGFFR3BPRFjI5KeYkjVKNuwcbgAm24ioukFO5MEFf
    5umWs7_v6rz2bsblEesDDSMAOG01KQIN8SLiTatmeZv5nfFjNGB8pM>
X-ME-Received: <xmr:QDhrauMTga3PCBeQHaDmdp1rg81jiiF5Scy6N7q_42WmF6O5ud6Iet3k7xMdPHyY7nkg_AAWTA>
X-ME-Proxy-Cause: dmFkZTGV6Xa745a9rX5TyYW4BcJ0aXa9Un0vyb2mpcHCGd5FrqrV04PxC8YY5y+e8HpGg7
    eirwmOCqGe9QgzKm4/lnJz0De9GY4CL6jgx3mrMYA4timNJLBPhy+3aJ3jrVIvhskwTWSa
    iTl6ICzCDm5voKRGqhAs0fR5+iewTOg70GhxRJG+/HrhrRz1tjOd8KS83o3Ev51xISuyr2
    u8hMynPZDVMP+hZRaadh+Aw3e0pAMRprtWmBos02IKRGptYcMq+DsI95D6d3mIWevV/nxR
    h3EhCIbPLuLK/2NObwa/xo4YCImqT4OhZTJ4Rsm7UdpQsp3H9mVomnywQn+00ZSq6KHmFJ
    7IC6fBTK7QV0IQ98z+Yte6tLIhWjnYv1iN2k7ByQGNiTJ8zmIkq1Z+sVMys1SCSsWG4U7U
    Xk4RsrKnw28XBu8PsWYNTRXvTBs6RqPJeI9VUpedW60emdWCMQjhTNLrXc9/6AzRTC5rE0
    //MhY1HsOy3ltrpob03wVBDRD+SNxbHSajBr8+EvdPcvcKfobVdXXGAiTunHeLTHJwBfxQ
    NdDQEgVeWBk+wt6FLON4k81NiVh5JaIL2xt1GdZQij3aA/JNHe0Z/2umgaId7/Dj5C+J8Q
    bS+eshGEnlDwqx3YIK5C0aXDF9BkkCN71zw9lDx46cYJQ8lzEY6iPmwKfx5g
X-ME-Proxy: <xmx:QDhrarPvj2kqoRr6tD_DwwSXgGXk_MUW5gTc9F-a3bMR_C9s8kFG9A>
    <xmx:QDhraukk9m2ee8avhMyEGvO7068y7jkAwjEzBDvLHo2ksb83hsfZ9w>
    <xmx:QDhrahvgpwL-F1oWT8zZkYwM7lcKjeuYw3qawg9o2NA6KeN1_RSE7w>
    <xmx:QDhraprIgce6isqY929WL3mKwRsrllpiYrErQ8Sqke6dOhOAw4Komg>
    <xmx:QDhrapekmF7YeWY_vQfI87Nf8g3I4O_eWmoRrLy29tm1UAd8lW_9HRU2>
Feedback-ID: if72e4b10:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 30 Jul 2026 07:40:45 -0400 (EDT)
From: Siwei Zhang <oss@fourdim.xyz>
To: netdev@vger.kernel.org
Cc: Steffen Klassert <steffen.klassert@secunet.com>,
	Herbert Xu <herbert@gondor.apana.org.au>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	Siwei Zhang <fourdizhang@tencent.com>,
	stable@vger.kernel.org
Subject: [PATCH net v2 1/1] xfrm: use hlist_del_init_rcu for state_cache and state_cache_input
Date: Thu, 30 Jul 2026 19:40:08 +0800
Message-ID: <20260730114028.1077499-2-oss@fourdim.xyz>
X-Mailer: git-send-email 2.43.7
In-Reply-To: <20260730114028.1077499-1-oss@fourdim.xyz>
References: <20260730114028.1077499-1-oss@fourdim.xyz>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

From: Siwei Zhang <fourdizhang@tencent.com>

Commit 14acf9652e56 ("xfrm: defensively unhash xfrm_state lists in
__xfrm_state_delete") converted bydst/bysrc/byseq/byspi from
hlist_del_rcu() to hlist_del_init_rcu() so that a second
__xfrm_state_delete() on the same object becomes a no-op rather than a
write through LIST_POISON pprev. It missed state_cache and
state_cache_input, which kept hlist_del_rcu():

- hlist_del_rcu() leaves pprev = LIST_POISON2 (non-NULL), so
  hlist_unhashed() returns false.
- hlist_del_init_rcu() leaves pprev = NULL, so hlist_unhashed()
  returns true.

A second __xfrm_state_delete() therefore enters __hlist_del() on the
already-deleted state_cache/state_cache_input nodes and does
WRITE_ONCE(*pprev, next) through LIST_POISON2 — a write use-after-free
once the slab is reused. The corruption can in turn cause a subsequent
hlist_for_each_entry_rcu traversal to follow a dangling next pointer,
producing the read use-after-free reported in xfrm_input_state_lookup().

Switch state_cache and state_cache_input to hlist_del_init_rcu() to
match the other four lists, closing the write use-after-free and, with
it, the read use-after-free it spawns.

Assisted-by: CodeBuddy:GLM-5.2
Fixes: 0045e3d80613 ("xfrm: Cache used outbound xfrm states at the policy.")
Fixes: 81a331a0e72d ("xfrm: Add an inbound percpu state cache.")
Cc: stable@vger.kernel.org
Signed-off-by: Siwei Zhang <fourdizhang@tencent.com>
---
 net/xfrm/xfrm_state.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/net/xfrm/xfrm_state.c b/net/xfrm/xfrm_state.c
index 36a4f6793ede..f494c1ac57a4 100644
--- a/net/xfrm/xfrm_state.c
+++ b/net/xfrm/xfrm_state.c
@@ -823,9 +823,9 @@ int __xfrm_state_delete(struct xfrm_state *x)
 		if (!hlist_unhashed(&x->byseq))
 			hlist_del_init_rcu(&x->byseq);
 		if (!hlist_unhashed(&x->state_cache))
-			hlist_del_rcu(&x->state_cache);
+			hlist_del_init_rcu(&x->state_cache);
 		if (!hlist_unhashed(&x->state_cache_input))
-			hlist_del_rcu(&x->state_cache_input);
+			hlist_del_init_rcu(&x->state_cache_input);
 
 		if (!hlist_unhashed(&x->byspi))
 			hlist_del_init_rcu(&x->byspi);
-- 
2.43.7

