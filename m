Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CEEF5221546
	for <stable@vger.kernel.org>; Sat,  3 Oct 2026 23:23:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791069791; cv=none; b=psVsTx/DEEpqktty5Hx4h/lZrlyFcvN3hcEepBz1OAeM5HhLYP8w9FxtsVkaVSiroUCfB84Uq3Hcy54mkba/tqvZ7xr4qnOTu/UGKOczeZdbdebV2ETe1C9S16YXyW4VPuDt9yusfNj3qJLnnueB5axMCfWwS07+asy/zB2gUGs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791069791; c=relaxed/simple;
	bh=3Le5GHj42wAaNsjbpsN1mIHtmL8mOOKkkgHge+aY6fo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=hTZ3GGBJTG8RcJr6b8UX34onkIyiUYUTo54oEB4NkddS/heYbeR2gxmpDrcCoyQQ2vNBvDhgsObiwQ8eIsZwR3hnGNmVKLGdw/JjAtx1TWQb88/5rGR7eUck4Gf8OEDtRc3tLYkFu/7jW4jcPJ47RkApCpAZc5fybZkAoUskS8Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=kFK3yewk; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kFK3yewk"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 003641F0089B;
	Sat,  3 Oct 2026 23:23:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791069789;
	bh=o0wOHL3Rj+Gobiq39nNmz+38d1nESJP/S5Y4Nid0ej8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=kFK3yewkvMHFGo+v5NeIkypuc9vFPqIek+qlh7Ji9ZUAdPMjt7gjsMfXKehOMLEw0
	 EKLi5HyXgxQ8HfxE6mvXxhWdEUC6ecOK02WNNNCiWvpMWi+Usaayw1uqM2kSgKjkiq
	 oxRdkUP/G0J3hCiwdHGdL6rEVyh/CuQdMQNNnaDcTcSst+2DVAZn3i0aQk1Y1FlIoV
	 83BZ0qDrf+RnIySzNvjtkMKAyDczUbdFsRWPp+ivhHiuVUuaTcQ32Abbtn42Y6iDaH
	 sxZTCMoaCH8mfGIjOXOskgT1ho9uuQiJT92+oahJHoOqvdREi+xfJWGMj8f02nHYy7
	 G0uW6Aiu+fnXg==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Zhiling Zou <zhilinz@nebusec.ai>,
	Vega <vega@nebusec.ai>,
	Julian Anastasov <ja@ssi.bg>,
	Pablo Neira Ayuso <pablo@netfilter.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.12.y] ipvs: bound LBLCR and LBLC cache growth
Date: Sat,  3 Oct 2026 19:22:53 -0400
Message-ID: <20261003232207.714886-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026100347-maverick-derby-bedc@gregkh>
References: <2026100347-maverick-derby-bedc@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Zhiling Zou <zhilinz@nebusec.ai>

[ Upstream commit 2a3c3de660f96865f303fd25f1285f2ffbfd521d ]

ip_vs_lblcr_new() and ip_vs_lblc_new() create cache entries for
every previously unseen destination address. The table max_size only
tells the periodic collector to reclaim entries after the cache has
already exceeded the limit. It does not reclaim entries that the
attacker continues to use.

Reject new cache entries once either table reaches max_size * 3 / 2.
The extra headroom lets the periodic collector catch up while the
existing scheduler fallback continues to use the selected destination
when cache creation fails. New traffic therefore stays serviceable
without growing the tables further.

Fixes: 1da177e4c3f4 ("Linux-2.6.12-rc2")
Cc: stable@vger.kernel.org
Reported-by: Vega <vega@nebusec.ai>
Suggested-by: Julian Anastasov <ja@ssi.bg>
Signed-off-by: Zhiling Zou <zhilinz@nebusec.ai>
Acked-by: Julian Anastasov <ja@ssi.bg>
Signed-off-by: Pablo Neira Ayuso <pablo@netfilter.org>
[ sashal: Retained existing kmalloc() allocation context while adding the missing LBLC counter-decrement prerequisite. ]
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 net/netfilter/ipvs/ip_vs_lblc.c  | 4 ++++
 net/netfilter/ipvs/ip_vs_lblcr.c | 3 +++
 2 files changed, 7 insertions(+)

diff --git a/net/netfilter/ipvs/ip_vs_lblc.c b/net/netfilter/ipvs/ip_vs_lblc.c
index d22f8154ff949..822a5fea20b2e 100644
--- a/net/netfilter/ipvs/ip_vs_lblc.c
+++ b/net/netfilter/ipvs/ip_vs_lblc.c
@@ -204,7 +204,11 @@ ip_vs_lblc_new(struct ip_vs_lblc_table *tbl, const union nf_inet_addr *daddr,
 		if (en->dest == dest)
 			return en;
 		ip_vs_lblc_del(en);
+		atomic_dec(&tbl->entries);
 	}
+	if (atomic_read(&tbl->entries) >= tbl->max_size * 3 / 2)
+		return NULL;
+
 	en = kmalloc(sizeof(*en), GFP_ATOMIC);
 	if (!en)
 		return NULL;
diff --git a/net/netfilter/ipvs/ip_vs_lblcr.c b/net/netfilter/ipvs/ip_vs_lblcr.c
index abe9fd0764958..e9df527471b70 100644
--- a/net/netfilter/ipvs/ip_vs_lblcr.c
+++ b/net/netfilter/ipvs/ip_vs_lblcr.c
@@ -364,6 +364,9 @@ ip_vs_lblcr_new(struct ip_vs_lblcr_table *tbl, const union nf_inet_addr *daddr,
 
 	en = ip_vs_lblcr_get(af, tbl, daddr);
 	if (!en) {
+		if (atomic_read(&tbl->entries) >= tbl->max_size * 3 / 2)
+			return NULL;
+
 		en = kmalloc(sizeof(*en), GFP_ATOMIC);
 		if (!en)
 			return NULL;
-- 
2.53.0

