Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8D15F3382F4
	for <stable@vger.kernel.org>; Thu, 23 Jul 2026 14:19:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784816355; cv=none; b=gyobfvxZMZHcvek3RIaAMbc6G0QaIxXrzMeR3RL6qOZo6lINiq3vYuaJMXleCVFGMUo31s7e2Uv5cwcaUJlDQyt4HTP539LRDzfI3dvaCkJ6VBsBV2589WZKql+eL8IJmeGxvfwOOF/6WgkgG3M1hWGHehbV+mdYzZ0VCH4PqUo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784816355; c=relaxed/simple;
	bh=W7cuPNLiULqWJgnqdrofAo04OT5MqyaryhNgKma9/wc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=RtVQNugGidnrY0TCUMqu/3El+kBQecl9JFce1CXddeq5tgBEeldbI71t8ryqaaYuQAsq7gTH1XHeg+XeV6mDHBOoXSD4WTR5owh8qBroElIdmWEfqEhnZaQIec+W+dtYTCvJXxVQ+oJOTEmJ3eBrNU7ayZNOrsmyQlxLxWEG3ww=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A324F1F00A3D;
	Thu, 23 Jul 2026 14:19:11 +0000 (UTC)
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Florian Westphal <fw@strlen.de>,
	Stefano Brivio <sbrivio@redhat.com>,
	Pablo Neira Ayuso <pablo@netfilter.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.6.y 2/8] netfilter: nft_set_pipapo: move prove_locking helper around
Date: Thu, 23 Jul 2026 10:18:49 -0400
Message-ID: <20260723141855.3217594-2-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260723141855.3217594-1-sashal@kernel.org>
References: <2026072015-level-taste-bb42@gregkh>
 <20260723141855.3217594-1-sashal@kernel.org>
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
index 012cd747fdd92f..791f6e1d3f13ac 100644
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
@@ -1802,17 +1813,6 @@ static void nft_pipapo_commit(struct nft_set *set)
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

