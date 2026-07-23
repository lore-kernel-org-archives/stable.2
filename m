Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0365D390613
	for <stable@vger.kernel.org>; Thu, 23 Jul 2026 16:54:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784825672; cv=none; b=GLDVdeXeo/H1WQtSsrDEAF22QQQzbyL+5X+JbcIuBvNa6HOD0VyG00uqIDri1DYCM7jJtk8Ne+5/y59YWKv3gviYDmvgkUbfHL0CSfAOy2C88H+4oCWNIwU7rbIhDxnIEeX2z8Jc0zpj6r55pMrHW/0FsoF9zGlmaQYFYXFnz0A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784825672; c=relaxed/simple;
	bh=Cq/dTte3WkR8GMM7RR7rGkWw16nA2DWjLxYRhNW6pGo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=uOdNO7+nBeNkEEy+hUzE9L9B9+ewEh941YKG/tCTp2iXLX/P7Bf15TsoAxWe3ulU3do3OPTl4edDD3Nxc8ByNgQKUDC3X8o1fEEQJaX78eARzw4cxNlIYB9j+GM7RsbP6tKEeIvTxFuLW77DoWdf3tsAGvJlKecqr2mFjoelKyY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=AT9CjmoE; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="AT9CjmoE"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3770A1F00A3D;
	Thu, 23 Jul 2026 16:54:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784825669;
	bh=J9LokTzESPGYxlkn/3U7f2kt48zql+twO2k44fkNeN0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=AT9CjmoEMB0B8zFxaJI3WX9NBkfbSLKDLeklsFPQmG8kMGenCLoPscVtO8DoGcC+F
	 nIQp0fhW5WEYTKVQLmNWkAeWEg+k+RNpoYBq/xGb6VsHZGJAM4Umrq3yULPBOwmIhi
	 DuOefybIFhLPr7fD9ob52GAIYuOtuQq4pZZtnM7jQPF4uCpjY8Djzmki/jJlPYKoLp
	 9SBMqa53Z0v8ZT9U0/B6fxHOM03gtKfNs6Z/7H9SMhOuq0gcRHUaDl6lX91LXVUqQe
	 s+0B1n6qz5+Th1LzO9bs/jMXUuSakn13oxxnyQAWlo+luPguQd3szKCvj5P5cSpxl6
	 Upx0SsdH20BPQ==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Florian Westphal <fw@strlen.de>,
	Stefano Brivio <sbrivio@redhat.com>,
	Pablo Neira Ayuso <pablo@netfilter.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.15.y 2/8] netfilter: nft_set_pipapo: move prove_locking helper around
Date: Thu, 23 Jul 2026 12:54:21 -0400
Message-ID: <20260723165427.3390871-2-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260723165427.3390871-1-sashal@kernel.org>
References: <2026072016-hurling-turmoil-5fb2@gregkh>
 <20260723165427.3390871-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Florian Westphal <fw@strlen.de>

[ Upstream commit a590f4760922acaa2d2b55a88004a38eecdd6412 ]

Preparation patch, the helper will soon get called from insert
function too.

Signed-off-by: Florian Westphal <fw@strlen.de>
Reviewed-by: Stefano Brivio <sbrivio@redhat.com>
Signed-off-by: Pablo Neira Ayuso <pablo@netfilter.org>
Stable-dep-of: 47e65eff5069 ("netfilter: nft_set_pipapo: don't leak bad clone into future transaction")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 net/netfilter/nft_set_pipapo.c | 22 +++++++++++-----------
 1 file changed, 11 insertions(+), 11 deletions(-)

diff --git a/net/netfilter/nft_set_pipapo.c b/net/netfilter/nft_set_pipapo.c
index 00f0b270f08842..a7175f7a21a79d 100644
--- a/net/netfilter/nft_set_pipapo.c
+++ b/net/netfilter/nft_set_pipapo.c
@@ -1190,6 +1190,17 @@ static int pipapo_realloc_scratch(struct nft_pipapo_match *clone,
 	return 0;
 }
 
+static bool nft_pipapo_transaction_mutex_held(const struct nft_set *set)
+{
+#ifdef CONFIG_PROVE_LOCKING
+	const struct net *net = read_pnet(&set->net);
+
+	return lockdep_is_held(&nft_pernet(net)->commit_mutex);
+#else
+	return true;
+#endif
+}
+
 /**
  * nft_pipapo_insert() - Validate and insert ranged elements
  * @net:	Network namespace
@@ -1774,17 +1785,6 @@ static void nft_pipapo_commit(struct nft_set *set)
 	pipapo_gc_queue(set);
 }
 
-static bool nft_pipapo_transaction_mutex_held(const struct nft_set *set)
-{
-#ifdef CONFIG_PROVE_LOCKING
-	const struct net *net = read_pnet(&set->net);
-
-	return lockdep_is_held(&nft_pernet(net)->commit_mutex);
-#else
-	return true;
-#endif
-}
-
 static void nft_pipapo_abort(const struct nft_set *set)
 {
 	struct nft_pipapo *priv = nft_set_priv(set);
-- 
2.53.0

