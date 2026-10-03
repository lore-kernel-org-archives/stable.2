Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 67B2F36197E
	for <stable@vger.kernel.org>; Sat,  3 Oct 2026 22:53:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791067986; cv=none; b=BamOW+ke5OG0X/KvSEWzo2YTWmobWGdPHzJkkUd7ZT0gjeZOOlNWLwCEc/y9NIk52th138/8eNrufIaR1UYjKH6O3ymmDwr/9jhAVGeCGk8jmAE1phMlkU5pLjPRDuL99LG7WTZyuS/dMkUGnhGI7GQyck/u2gwNXZCu46YWQmQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791067986; c=relaxed/simple;
	bh=XMXI2cP5aTXjY2CHyvZJkN40u8/HwP6X/jbQTvD3boI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=PUsYprFYusQ6ktI0B6tmCbNT2BiLUDPQ5SxXT5DbVHjB5VK1/TvDYvA7ETMgjYZ++koj6dG5IEyNq3+qyTL6wcxlCgnpyjcmWC4hCpii69dz4Zgh3VZs59DwCZ6oFS2ARydDOF0QtFRcT6QGkprdmq4bOczQagUChg4rOozoXLM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Z5v9k60z; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Z5v9k60z"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 96EAF1F0089B;
	Sat,  3 Oct 2026 22:52:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791067985;
	bh=jg/pQnUE7amMZWMVsWKy2iPLSd06GeeoMgwp07h7rv0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=Z5v9k60zXzUpkJMaMfNOMf2uAy4jOWoENaXhyt5DSAt3T9SJBDv+9CmBg/Iw4b/WY
	 CXjX85/EUTCHvRsvXiE3p/4V2Q8x7HPwlA9kVo8aeDCV1ZNtKB/MM2wV2qk8F2yRbe
	 BoqO8St0jwW5ssRpFeDytMiC2qqJoXfRBZuuJaxFxn9ix7M604GylsZ5dxaTvHmPW5
	 MeEKNEkPLW6wkHmbWmm6h/g35pMrNlkHfNO/qiUTF0ELH8AefDEQqNUwsXh+3prT1S
	 uzBgRjsv4mqlXGFqs4R6vFItoEZvhe+x20rqBwMqCivLchGTV86J3uBMl5jtdpCkOv
	 +UE701JxbKavQ==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Zhiling Zou <zhilinz@nebusec.ai>,
	Vega <vega@nebusec.ai>,
	Julian Anastasov <ja@ssi.bg>,
	Pablo Neira Ayuso <pablo@netfilter.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.18.y] ipvs: bound LBLCR and LBLC cache growth
Date: Sat,  3 Oct 2026 18:52:47 -0400
Message-ID: <20261003225116.383738-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026100345-backlight-penknife-9708@gregkh>
References: <2026100345-backlight-penknife-9708@gregkh>
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
[ sashal: Retained kmalloc() instead of kmalloc_obj() while including the missing LBLC counter-decrement prerequisite. ]
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 net/netfilter/ipvs/ip_vs_lblc.c  | 4 ++++
 net/netfilter/ipvs/ip_vs_lblcr.c | 3 +++
 2 files changed, 7 insertions(+)

diff --git a/net/netfilter/ipvs/ip_vs_lblc.c b/net/netfilter/ipvs/ip_vs_lblc.c
index 9bb1e05063dc4..832066f11e67e 100644
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
index 1a53c1254fe57..073d3ad177040 100644
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

