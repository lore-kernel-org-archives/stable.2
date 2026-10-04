Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2A4E23FFD
	for <stable@vger.kernel.org>; Sun,  4 Oct 2026 00:33:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791074014; cv=none; b=fXtcoctVJ+AwAurtuQQxHCL/Ta8CNtZYdlDvJb/2qaMrGAti/QXHsQzHZ2fs+jbGo6x3mVXCSyMREevQuedsSsp9TBX8/PJVU/37TnhKwQHPm6GcL6JtwxShtxAflSxcjeCypfMqjVmvd5u5oHTwzLIODfTRm4N+U0Cy24ZmV6g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791074014; c=relaxed/simple;
	bh=sR/OMUVSu9fPuKlsQCVIftTrm+GWCeIiCasXRalnfKY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=VTAt1i4V6LpL63X8z++G4K6Ugf8LmUaH+fgCclTCIy3t11nM/V50DrgrqBTrMD4YRXhoh7z9JJOXM4a1gZ9qKwiSzjKczIAiKv082ebyXLmZ330Z/AEKskW2R6PnApO0b9UpXeOkunrlYPgeWM07RuP40cbam5jda59n2M2120M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Hxm4ogaP; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Hxm4ogaP"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 02FEC1F0089B;
	Sun,  4 Oct 2026 00:33:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791074012;
	bh=c84oqjFn+KZPv7USjFXEa8zC1cOcmkr4oY/Ku6ViHkM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=Hxm4ogaPcp8M/KJjCT9CzdcELDx2Vrs5DCnrPxiciC85ddmLQj5/6fBeQGK2EWtyq
	 20sOJqQCgYo8YG/kx+X58sj7vKBrocAZgD68wd5HG/n1rIMgtOsuA87UaLDv7PIqE9
	 vArfAccfk3ZoHFlck59kDkwkqLWsWOTOY1/lw7vNpiJU42bHDuvri5Zhm+9R39g9hK
	 yqbZDdE/tI15VE0rNhdGGJp26IWvHuRYpapo9pwY58Y49IY1w5Wbvzew9Hhkl0IhAi
	 M4RCOpMVmhALzokjYLOHEMzyP6AthBdv4Np2CnAozKNGbQy2jG73EVwJcJGL5uWwNN
	 6OXCOmnT/+i2g==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Zhiling Zou <zhilinz@nebusec.ai>,
	Vega <vega@nebusec.ai>,
	Julian Anastasov <ja@ssi.bg>,
	Pablo Neira Ayuso <pablo@netfilter.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.10.y] ipvs: bound LBLCR and LBLC cache growth
Date: Sat,  3 Oct 2026 20:33:19 -0400
Message-ID: <20261004003233.1262384-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026100354-snub-granola-86d3@gregkh>
References: <2026100354-snub-granola-86d3@gregkh>
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
[ sashal: replaced kmalloc_obj() with kmalloc(sizeof(*en), GFP_ATOMIC) and added the missing entry-count decrement. ]
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

