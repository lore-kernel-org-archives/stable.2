Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9B8872D9797
	for <stable@vger.kernel.org>; Sat,  3 Oct 2026 23:56:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791071816; cv=none; b=g0xb3k18QN5xryJ8h/37qID7rRdaYrsyY4CK2aFRogK2wPFuuFUgQGDQ36tEc0kSl8tftGm6PqSW7BX3LVpghrCc02Y4Dlw6/XqmhUgNTbToQAmtFaZgQnjsv0A1OJftNVd9i8oXG342XWuccUqkeBV5iXS54Cy4onZ3avSj7bY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791071816; c=relaxed/simple;
	bh=SAi9AD18RxpFeEiYEFPCGdlCfBveR1OucrFnnRgJP7o=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=lBlFyWFrtO0PXey2BTh77zcTuz8j45CZ6j7VRAGJywcOvmMbo6dGtTptaKCmutirXeNbylcdKjpncRMsb4YyUie/yjvcen9KbSFePEjU/qi87VI1Bo/5Rqu6ayDerPGfJXag1+PwJyWPH92Doxm3HU7iA9VY4l01ueWgy0dnlIk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=EGMxZYwv; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="EGMxZYwv"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C90AB1F0089B;
	Sat,  3 Oct 2026 23:56:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791071814;
	bh=pzAy20ACJm6ZeUi8mqOWrRMu7clFwkyC4g5KEaIdano=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=EGMxZYwvAR2IubcjYTdChGIEDp/0COvBBxZ9yvn9zhIG86we5NYeIqubgKxBBGL3Z
	 C63lUKiZOo1kcYEcpqoOhNwozxR8FMczG/Ui4f24qlMWOS9eIkW9jx1U+r3NtzjFJm
	 5JNgD2h61LwHQbxXwOO8pDuUWOmAIA5NNLTZwbGtTeQ2C2sJCQZCZHs0dQihp6svz7
	 vjMiIu23WSClmaWaZ6y50llJ/IfnUoCFLY5kWfTG3AunVDvmfCpOEcEWYC/1ynJXkg
	 pg6aFsmLr05FCVd/WfUk6gR4j3hZga2jc8/MbJ4ROpO5SZ2sFEg12t9NrhSm3oAqZI
	 wlL9Q8lWdWskQ==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Zhiling Zou <zhilinz@nebusec.ai>,
	Vega <vega@nebusec.ai>,
	Julian Anastasov <ja@ssi.bg>,
	Pablo Neira Ayuso <pablo@netfilter.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.6.y] ipvs: bound LBLCR and LBLC cache growth
Date: Sat,  3 Oct 2026 19:56:36 -0400
Message-ID: <20261003235545.909116-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026100349-mourner-headboard-23b4@gregkh>
References: <2026100349-mourner-headboard-23b4@gregkh>
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
[ sashal: Retained kmalloc(sizeof(*en), GFP_ATOMIC) instead of kmalloc_obj(). ]
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 net/netfilter/ipvs/ip_vs_lblc.c  | 4 ++++
 net/netfilter/ipvs/ip_vs_lblcr.c | 3 +++
 2 files changed, 7 insertions(+)

diff --git a/net/netfilter/ipvs/ip_vs_lblc.c b/net/netfilter/ipvs/ip_vs_lblc.c
index 70014c89955d6..cfe0c0a3e2cfd 100644
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
index 6b582be087785..9c471a14e3d06 100644
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

