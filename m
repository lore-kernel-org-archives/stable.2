Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A03B41990A7
	for <stable@vger.kernel.org>; Sun,  4 Oct 2026 00:19:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791073195; cv=none; b=es0+EtWyHPGj0on5ZDnoX1noghuYNI0IFNUd5kHU2tSTQLmTLTxlq3HdFZ8XtykLNG8uPN2T/lzrTzoVTcBXLgAF4ElDwXSgPHoPZ2fj/sMeiYWOAJDJWgB012aV6qYqfVwXbHUIlj+FV+3ywRYR3xdJHxyQXSqkG3l0FHJPAAs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791073195; c=relaxed/simple;
	bh=QiFTykEQceOFaFEu/za9nDiP0T7w5rYmOUweHmojUGU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=uF9lR3xqj5lWvHPvyj8UCP2NiAOHmRuzOOCU4i2oCiIjJR+Ga0seIeHK29wVK519uQ9Pglso3L21nGfiL7i4wN3FOxJfJ8qVVlwMLrMTQCjK1IUC3FneOWJcqaDjapWkzI63mglaLJvgUxppuS9Tz8Uq9f8lIy7QYkSKrJUw3gg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=gjAQZLLH; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gjAQZLLH"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 28F161F0089B;
	Sun,  4 Oct 2026 00:19:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791073193;
	bh=DUe2zcEN2YCmRiqsQNXSXjblZBCywTtXKk9wGxbzFQA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=gjAQZLLHlNwwskgBwsfkIRd4P/u5XcK8Xt1r8NGpXpm+FBsXFlHuIABPqn2gWa3rZ
	 MYA3thFQMieQP/vvV68AjjbSsWJTUxCJ+8VZvDoRU1U855sd87mA2FpZIfa9WO1c7v
	 jE6c8DcIyfo/TuQsPJRJXfjqKdNtxSVcZuAUtIJWDnpgiDLgLL9VCRyvfuPF0uLm9f
	 Op1yIK7pFJcXJgU643zXLKyDj46FZAOt7iV8uRcQ5nP2N/xVGoLF0lRu3Betvf1IoF
	 BIetRJcjI3wakUOuI0ZJWkQWC1T4TrbYNaIOHZg+DaM40SNRGwx3uEgOnPL5vQyky5
	 cKpFq7zHdhMBQ==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Zhiling Zou <zhilinz@nebusec.ai>,
	Vega <vega@nebusec.ai>,
	Julian Anastasov <ja@ssi.bg>,
	Pablo Neira Ayuso <pablo@netfilter.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.15.y] ipvs: bound LBLCR and LBLC cache growth
Date: Sat,  3 Oct 2026 20:19:36 -0400
Message-ID: <20261004001855.1238470-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026100352-expletive-silica-be66@gregkh>
References: <2026100352-expletive-silica-be66@gregkh>
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
[ sashal: adapted the kmalloc()-based code to decrement the entry count explicitly after deletion. ]
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

