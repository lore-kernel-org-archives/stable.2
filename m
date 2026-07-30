Received: from fhigh-a2-smtp.messagingengine.com (fhigh-a2-smtp.messagingengine.com [103.168.172.153])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EE7A441168B;
	Thu, 30 Jul 2026 11:21:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.153
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785410486; cv=none; b=Q6tMzTQcE5sZPzm7KtbeEPtfEmjtK0WNYLdgwXTQ5rVOJOVlQCvSsgJG58WLX92aVTiROhs4oNkPj034Llzo8AE0eKziYQ+JeRYccthngOVGnHl8p2Nq4eC9ZV5JG4HZoqL/9GMy0vrNQDidxCElM2Ou+cBIDy5ndsJO1OsLTfo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785410486; c=relaxed/simple;
	bh=++m2A5f/g1GhI7LD4S7U4F2Oc1KNNWqDYFaeuDOvHZM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=aAnT/QRrhjmvK8dS4gbpldmt93niMUsrp/dnBoXqF5kPsvckUxkbinGBAZkjqndYlD+s75XSxSab95LvSB1nruSUgRwRrE0YHeoo37Xd5l5OpEc9zco6C/X/6wfri4KcGoc+KWyi5WdUl2DtwCd7qfBDJKQ2/KJYemILPAI3wTA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fourdim.xyz; spf=pass smtp.mailfrom=fourdim.xyz; dkim=pass (2048-bit key) header.d=fourdim.xyz header.i=@fourdim.xyz header.b=tVhOBvkW; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=puFKOQQB; arc=none smtp.client-ip=103.168.172.153
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fourdim.xyz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fourdim.xyz
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fourdim.xyz header.i=@fourdim.xyz header.b="tVhOBvkW";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="puFKOQQB"
Received: from phl-compute-06.internal (phl-compute-06.internal [10.202.2.46])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 568A914000FD;
	Thu, 30 Jul 2026 07:21:20 -0400 (EDT)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-06.internal (MEProxy); Thu, 30 Jul 2026 07:21:20 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fourdim.xyz; h=
	cc:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm1; t=1785410480;
	 x=1785496880; bh=2PRH+TiaRNTVck/c7fpAib4XXYBnbYQMJn2aUAaKQuY=; b=
	tVhOBvkWKD83z286up3uJVB9EMTZ8Y8C2hOf5drRsuH6ZBHg8iAUJeWVATtR4T4W
	L38GIHa/PJhQ1Ynp0k8Y2y8DequkoeR3l3zcbIRJN+EM9+d8JXwTUupXqeWWc00f
	iEGKqtkPm2eZfJL0BE73hm6WLt103Q6Dy/p2om8PBkokTMbWirNYL/zcs9QlTimN
	u1gGWH5ZMFrp7R41UNtcOw4hYkmVlAWzjxDByKZFidKqM/QaoBIbLeaB2JWdakSd
	DZGaaYUKkH6RICWbvuVOl+uXasb0gN3vKgBcSizWEyndByu/XqIoRO+76qnLq42z
	wfVsHnqNhx4jsEwt5J5gxQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1785410480; x=
	1785496880; bh=2PRH+TiaRNTVck/c7fpAib4XXYBnbYQMJn2aUAaKQuY=; b=p
	uFKOQQBDwYWLJRIutumSe79vSWqLR1c71DeLGO30If9RpLyN4mpauXg9aKPvsHV1
	ftK/JpbzeBJTnmOEwlUrWL3ZEZeiIPJ9JBbGn8iDN0lFOS1dg7nOcGaH5+ujRN/6
	KOIfLjK5Hn++U220MfMWrhBcRAVhaFiH/fvRXCzNEUo43v/fos1l26V5YebpjEDz
	Uw97piHVm17bWIYFHP5itEnpVOF1RUDg/QbzQLOYeiXZA36BdaN0BIrt2+TdsEYX
	Nyj+PJVpNIuQZoejBfpsKIVeAiaC5i9nGyFgNnmeM7+GYNsUJV1QBfRkMycxlAZ8
	fdt92/6CK80xZb67Ki+6w==
X-ME-Sender: <xms:sDNraoddFbC3K2NUASD2zn_vatOWhawhHSvKgmB_fGny2kFII-S5YQ>
    <xme:sDNraiYtBjgpUs8F8MsuD-7e0bXnSfr8AXyacTlJUUdqDM0AlN_PvgZK4vsHchcz-
    MX_nmqf7uM8UV5dMI2FJt1sgnM8s0ET-OT_rqPZvfXmQJnis0Szitw>
X-ME-Received: <xmr:sDNralEftIM8tC2tPSSscz7i4kdpGPlWD09T0zNJdrhhDYIwR8PXC_onZLOSEiBB6HXdlCDKe-0>
X-ME-Proxy-Cause: dmFkZTEfhuXvrEHIffqsR4HT0I/U4kI+eRbRn2WCl7cAo9+NPKEqFhGU6PViVqBTecXU7K
    x34crM035ypKCkLfCRweHs8VyGs4J8jAh+3SbFQIYB5FDCDVDlJsCwpOCRGXq0gdGbOV3d
    bia9C1yA+WFULJTyvi0cKrWVpHdAfAhhruBGtjxedH7RaRGyZfCP/tKhREjzggTPrE08Y7
    5B6GDdn0L29fW5um6b7+FHAsrDvWWScqO5zhpVxi/gVVpn4YoNiL2VfmY7h13aNpXDCc/j
    OcXNjGtWy5nAUe0AuEtiueUEH3YPtmzKpDSCHL7SJ5x5CI/YmnfLO+EIhwwf1udWiSzLdR
    2O0lBReY7r/LpHPEPJUpbT3pgAZI8bL3wibDKTg1lt55WNRZw5+lV2T2oeBAgwWpcjwE9t
    DakrADDpNuE301M90VHAEAmLNk9kW287eTWg/JX8qPNE00OS3hnWiMigL/vhKVm2kweI08
    dkr80Hl4QPDdx0kqolkpgdpWDGY3km46iyihTaTtx18K1Jp8dt0JyjWQMeudgk71Jbm0i3
    HQqtD7XFOxmFOnRKAeZg+k+RRTlGgKurkcaJnpbKW3WM4WCwRXkko/IqrV/jufcq+8nhJD
    Z4bSYvteNwcj00DIubGm3SNp1bXh0oGJ0FPA18qxub/cpyC/M3FK7txURbdA
X-ME-Proxy: <xmx:sDNraomh-GaX4c7EyGxnt2ZM9-lTpLVKzwIHjmwB6FziGSynT1QobA>
    <xmx:sDNragchmOiTrx17XQqPEKRNmGIJtK2kjZlqy6C-lIhBSIX0zacz_Q>
    <xmx:sDNrauEsyzGr2V0hZn9bx7rzlORM7A5504J3kaQ7EjSgFCBZ5HWe0A>
    <xmx:sDNrauhcCwsWgEEr7nok7MVSLr_4Eb3DWvV72_LCvE4sCO1G37BQlg>
    <xmx:sDNrai0EmWGbR0iI4pqmMNn9tXPhRMPcCRM296_kNFd9OLJUmmjV1hPZ>
Feedback-ID: if72e4b10:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 30 Jul 2026 07:21:16 -0400 (EDT)
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
Subject: [PATCH] xfrm: use hlist_del_init_rcu for state_cache and state_cache_input
Date: Thu, 30 Jul 2026 19:20:50 +0800
Message-ID: <20260730112058.1062795-2-oss@fourdim.xyz>
X-Mailer: git-send-email 2.43.7
In-Reply-To: <20260730112058.1062795-1-oss@fourdim.xyz>
References: <20260730112058.1062795-1-oss@fourdim.xyz>
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

