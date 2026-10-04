Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 65B418834
	for <stable@vger.kernel.org>; Sun,  4 Oct 2026 00:09:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791072544; cv=none; b=b4TAV9Obf9UDJB1rvx5gPttbb0y4Wm1Eq8Sl7YeLAWAAwa50xlnntmqOM8fT5tNSKS8v9O3KdmMAz5NbaWstbkJqv/g3EmkFVEzWkho1Pgqn+ogbPhcqNvAkANSMswTQcwdgb7K8p+hcB+K/VZ8IryJzEMptZYZbN2NNmN8NvTA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791072544; c=relaxed/simple;
	bh=oHwuGZnIP6IOVnFcQX03h3CCRRf9mNojRuRfWiEgSCM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Zb/QcydKMhUoV2DTt9xjV6s8eT/O9dMvT3j1SEMUz0FPD3M0piFfMVVFkkEqC9Soal0dFZ/QzhJfygbhfAXHs+x67JvKCOq3dQmxab5NkWXH+MxrYEzoOvfXZ1nt7TdUExYA6Uh6qlBkDYAJrVBW+LqHW3eMmVVtU6+lHAJjlPQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=KwmEfpoI; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="KwmEfpoI"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BA7F71F0089C;
	Sun,  4 Oct 2026 00:08:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791072543;
	bh=u75ZR2rC2vNy263O5y/kdbtZeN/cUvKZqvberWOmHCk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=KwmEfpoIyg1gD0saoAaeJcxbvH9p7Xpdnn2wxChx4syhc67jIiOvjJz9UXKzEUv+E
	 xKMr2ZzzEYxy+m4Gm+V2rfJwI6MgASfygyrK2Pm2dnxaOpEetBXaTSFI6TwXKdkFlm
	 dybQzH5E4N1vACB4pXvwFm4wBrzh9L3K2uq0p99uwXtJ6MVA46VouuWJULbcKLq4SC
	 F9iYFes+gmGTa1GwDY7P/x+AtY3Op3mfgaKpY2cVDhXtLiDwM6JdCuhmW6sJmC9E9d
	 /8L7bOERzyEz4melwKJAa+U4qRhcCle962Wvbw/gZ1Be/MmKoUmZtkDOV4EYiT9TcT
	 fJeYBFKTP//Tg==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Zhiling Zou <zhilinz@nebusec.ai>,
	Vega <vega@nebusec.ai>,
	Julian Anastasov <ja@ssi.bg>,
	Pablo Neira Ayuso <pablo@netfilter.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.1.y] ipvs: bound LBLCR and LBLC cache growth
Date: Sat,  3 Oct 2026 20:08:45 -0400
Message-ID: <20261004000802.1216030-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026100351-easing-ritzy-2978@gregkh>
References: <2026100351-easing-ritzy-2978@gregkh>
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
[ sashal: Adapted cache-entry handling to use kmalloc() with an explicit entry-count decrement. ]
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 net/netfilter/ipvs/ip_vs_lblc.c  | 4 ++++
 net/netfilter/ipvs/ip_vs_lblcr.c | 3 +++
 2 files changed, 7 insertions(+)

diff --git a/net/netfilter/ipvs/ip_vs_lblc.c b/net/netfilter/ipvs/ip_vs_lblc.c
index e2480f33a1963..49ff1f9fe1474 100644
--- a/net/netfilter/ipvs/ip_vs_lblc.c
+++ b/net/netfilter/ipvs/ip_vs_lblc.c
@@ -205,7 +205,11 @@ ip_vs_lblc_new(struct ip_vs_lblc_table *tbl, const union nf_inet_addr *daddr,
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
index 7469547c8a440..6feab18861e16 100644
--- a/net/netfilter/ipvs/ip_vs_lblcr.c
+++ b/net/netfilter/ipvs/ip_vs_lblcr.c
@@ -365,6 +365,9 @@ ip_vs_lblcr_new(struct ip_vs_lblcr_table *tbl, const union nf_inet_addr *daddr,
 
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

