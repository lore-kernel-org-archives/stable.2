Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8D28D41D103
	for <stable@vger.kernel.org>; Thu, 23 Jul 2026 16:54:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784825673; cv=none; b=qhQDcu7SUd3IuP4NAsJoxUkEV5u2Exc3eWnWdLfzlseW7yW02TtSP9sxRNv+Ozgk8yZtdIu5pGKUSF+uL1QhUfUZh0meVsHEh6FjDhFZ9tj0D8BckpP6AyIGfL5cxNsRI/ujq4UBMXYo5eXKMK+Y9LtlcwMaRJGdoE0XQqcU9lM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784825673; c=relaxed/simple;
	bh=RTvju58e0IInOKhzfHYIoamEsmP7BUtXXJOIg4mafck=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Z6JSHaRMNm+rnu65Cx6ARAA5O5UHOCDUjyAJAIG+qBN2U9a4UciifXuNfFZ2agWrvFlnTghzkaI6ejK8kJXwOs7S+eSTioRkCZXxGH30unYsx3JT0ODjZmyphhdN4qJipfxhTvLfk3vrBqadXb/KrKorPXrTLHSqQhaPRRcnPcY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=PGi+04GO; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="PGi+04GO"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A7C731F00A3A;
	Thu, 23 Jul 2026 16:54:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784825672;
	bh=QoDMDLM+zJNvUp9DeaGXlAqxTmhdgeuAX37yjx+Swvs=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=PGi+04GOcO+eo4AhUXlBXerBf6tb6NVHfXTDA0IQrQ12GPvEd5IS+hsx45Ix0G+i3
	 ybHRAFsBc8XmFwwy1u5IU1rnpbH2tKreAOcU+9M1tZWTt/1GoY/sv1yvlT0Zp1gF1Z
	 mreWkshGScUJUCya+eJj/KU2yjft3N2jDcsxzlpTat8nquEx3tEg2MndFBND/yWr8B
	 rVj9a3iFYw3BElTI289vipY+ygFtU6XEIpXnaqgmiQltWx91cQv5ha4QqeW3LJk1tC
	 bJMicyMSBG/DnIG4Hgjo7zFwXcOkq+VNseyoTRrZBI90ZlYVoOpTyCrOvoX4XkuBLF
	 1Yrm7SHVvJScA==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Florian Westphal <fw@strlen.de>,
	Stefano Brivio <sbrivio@redhat.com>,
	Pablo Neira Ayuso <pablo@netfilter.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.15.y 5/8] netfilter: nft_set_pipapo: merge deactivate helper into caller
Date: Thu, 23 Jul 2026 12:54:24 -0400
Message-ID: <20260723165427.3390871-5-sashal@kernel.org>
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

[ Upstream commit c5444786d0ea2417a5e2cee7bd67137fc8bad687 ]

Its the only remaining call site so there is no need for this to
be separated anymore.

Signed-off-by: Florian Westphal <fw@strlen.de>
Reviewed-by: Stefano Brivio <sbrivio@redhat.com>
Signed-off-by: Pablo Neira Ayuso <pablo@netfilter.org>
Stable-dep-of: 47e65eff5069 ("netfilter: nft_set_pipapo: don't leak bad clone into future transaction")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 net/netfilter/nft_set_pipapo.c | 39 ++++++++--------------------------
 1 file changed, 9 insertions(+), 30 deletions(-)

diff --git a/net/netfilter/nft_set_pipapo.c b/net/netfilter/nft_set_pipapo.c
index dfedf10973b2f8..f2d4737c09bc40 100644
--- a/net/netfilter/nft_set_pipapo.c
+++ b/net/netfilter/nft_set_pipapo.c
@@ -1826,52 +1826,31 @@ static void nft_pipapo_activate(const struct net *net,
 }
 
 /**
- * pipapo_deactivate() - Check that element is in set, mark as inactive
+ * nft_pipapo_deactivate() - Search for element and make it inactive
  * @net:	Network namespace
  * @set:	nftables API set representation
- * @data:	Input key data
- * @ext:	nftables API extension pointer, used to check for end element
- *
- * This is a convenience function that can be called from both
- * nft_pipapo_deactivate() and nft_pipapo_flush(), as they are in fact the same
- * operation.
+ * @elem:	nftables API element representation containing key data
  *
  * Return: deactivated element if found, NULL otherwise.
  */
-static void *pipapo_deactivate(const struct net *net, const struct nft_set *set,
-			       const u8 *data, const struct nft_set_ext *ext)
+static void *nft_pipapo_deactivate(const struct net *net,
+				   const struct nft_set *set,
+				   const struct nft_set_elem *elem)
 {
 	struct nft_pipapo_elem *e;
 
-	e = pipapo_get(net, set, data, nft_genmask_next(net),
-		       nft_net_tstamp(net), GFP_KERNEL);
+	e = pipapo_get(net, set, (const u8 *)elem->key.val.data,
+		       nft_genmask_next(net), nft_net_tstamp(net), GFP_KERNEL);
 	if (IS_ERR(e))
 		return NULL;
 
 	nft_set_elem_change_active(net, set, &e->ext);
 
-	return e;
-}
-
-/**
- * nft_pipapo_deactivate() - Call pipapo_deactivate() to make element inactive
- * @net:	Network namespace
- * @set:	nftables API set representation
- * @elem:	nftables API element representation containing key data
- *
- * Return: deactivated element if found, NULL otherwise.
- */
-static void *nft_pipapo_deactivate(const struct net *net,
-				   const struct nft_set *set,
-				   const struct nft_set_elem *elem)
-{
-	const struct nft_set_ext *ext = nft_set_elem_ext(set, elem->priv);
-
-	return pipapo_deactivate(net, set, (const u8 *)elem->key.val.data, ext);
+	return &e->priv;
 }
 
 /**
- * nft_pipapo_flush() - Call pipapo_deactivate() to make element inactive
+ * nft_pipapo_flush() - make element inactive
  * @net:	Network namespace
  * @set:	nftables API set representation
  * @elem:	nftables API element representation containing key data
-- 
2.53.0

