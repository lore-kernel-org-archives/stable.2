Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D24554921A1
	for <stable@vger.kernel.org>; Thu, 23 Jul 2026 14:34:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784817279; cv=none; b=eq26ryyB5FZp0YmRMTjnXipo/9oD99VHHUUf4HJ+Tgj7vhNbfw016r8r2z2EEIy+bafuua7lY5h0BZWaXjiLXaDu7BytIltSyzGrWtzzQJH1jk8slLDj/lmW4DdErgTPx3gxGaVb4jNxppji69Rjj/s4GTAdiFCtDYFUf7QeUfY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784817279; c=relaxed/simple;
	bh=m471EJ9gWM0U6t0rQdEIXHrAJb5Mdq5Uc+rRFI4Ljz4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=blXc+CsymijHlFfEsDACUKnxG7i7YIo9AQrXqoQpg4J3U9WeI5b2Q4X9EqE+gIJL4NbfM+Cyr5O9ZkA9DOMnjRSixE8xTLMhz7hKsDNmkp4JrIpb2/nrw3RLjj44lY+c2GgfDxv1qTYqfBQZ8gC6a+Ca9fuWWUl93suO3x4vK+Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=TFFYnnCV; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="TFFYnnCV"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E19761F00A3A;
	Thu, 23 Jul 2026 14:34:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784817276;
	bh=Sk9JdtJVG4vARnRT8ZWNw7wiXWT6qTrWO9PUvpo5QsI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=TFFYnnCVYs4q1CJRP1in5DnWMFLfSXWAfbxvqkWwCgxnXCpDEwVR0NBkdoRUOVy02
	 D0SJwEjQcc5Mk4FLXf23smMmohbn2fRWVUc9tvZ2n2mahK/KqF7dv9LODQS9V0awfS
	 rFAUKSSJQAyMaPBLTNrfaSyh5xvIWKI9bpMb68CkumxHLy/aDC7zznnIzZgZtinR4l
	 8c9rHk6dtR8EO+i/VAicjXZQt12r0HK8a8l104nBpTZ7aKMkMLPFf+9sCifIVMMr/K
	 xhfsLkWIuzRQfT7M8EEHPeczOHI4Q2QJaRifgtOJOcChVwwB7gIo+lURTnxUQ705JP
	 uQMpH/kMPB4LA==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Florian Westphal <fw@strlen.de>,
	Stefano Brivio <sbrivio@redhat.com>,
	Pablo Neira Ayuso <pablo@netfilter.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.1.y 2/8] netfilter: nft_set_pipapo: move prove_locking helper around
Date: Thu, 23 Jul 2026 10:34:27 -0400
Message-ID: <20260723143433.3226555-2-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260723143433.3226555-1-sashal@kernel.org>
References: <2026072015-dating-wanting-8baf@gregkh>
 <20260723143433.3226555-1-sashal@kernel.org>
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
index 6a14d0441c6ef0..502193505bb26d 100644
--- a/net/netfilter/nft_set_pipapo.c
+++ b/net/netfilter/nft_set_pipapo.c
@@ -1217,6 +1217,17 @@ static int pipapo_realloc_scratch(struct nft_pipapo_match *clone,
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
@@ -1803,17 +1814,6 @@ static void nft_pipapo_commit(struct nft_set *set)
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

