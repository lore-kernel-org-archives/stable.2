Received: from smtpout-02.galae.net (smtpout-02.galae.net [185.246.84.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AF03337C11F
	for <stable@vger.kernel.org>; Mon, 28 Sep 2026 08:07:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.246.84.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790582864; cv=none; b=dPsUFdbqenC0nX8Nn4xxvaOcXNwNrQQEsapSKkPHLbRyQgcrrRXMYkgJhPI1XIWZteCA0omJl2Q1sCTiwaRrBT5XnY7Tcx75q9z/zQ30q7VRLuHaIQ4EL3Xl5GzPxBor763OgMQkokwLOafqXp7bigOXFzhLSZUYH/AaTvVThoA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790582864; c=relaxed/simple;
	bh=tsgUxipLyTrdL9cSd3NyCLrooN616oJ6tavqwFcTkag=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=rfk9g+KEKbI8eMwVt/o9yjycNKIjmHn7+yxgdVLugRKPXjSAlUY9kdckdD/2VID9D1so1TGQKlKPkS5QLFwgC1belc4d95vgBZZQyeLZwft2HHv4MJSGO1sjg8A8J7zMQdr5lODlTdb5IlOfMfiwh+8RzWUayhTA5pnSb7ho0js=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=iB+2S+rl; arc=none smtp.client-ip=185.246.84.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="iB+2S+rl"
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-02.galae.net (Postfix) with ESMTPS id 15A6A1A0FE0;
	Mon, 28 Sep 2026 08:07:41 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id DE15E601BD;
	Mon, 28 Sep 2026 08:07:40 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 0FC12102F1EA8;
	Mon, 28 Sep 2026 10:07:38 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1790582859; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:in-reply-to:references;
	bh=sfmYFRpGfvRZcHLUebRjxL5igT3UF5/tv9+/66kl8e4=;
	b=iB+2S+rllg8RsKp9wnf+f1GDttE/++wNEYnnOhOGlKsbfm0T0m/edVf73m4w8asD0QcNJO
	zlREJ1c/hRp7gsXiiQepC5801+hqVqcqTxZS6dhwNynZmlxjJ5qulKjtMhMUYunZFkniKr
	dTrNLg3pYsz0aoBX/eYGedGigGCFKjuKB7wzzh21YoIp0x8qlNkW7C8QJgjC20nI6ZBXKm
	sMXwTT8+e6VOJaiHTXsCW9sgCDik39YP/znO4gj7Ce7U8AVrWGXL+hAya893mPfDWwF2uT
	uFpjv6D9G41p4JpCk7zfej8u1L9mV6M0K4N5a1G6U/2DEyGwm2Z2O5YLA4v6qA==
From: "Benjamin Robin (Schneider Electric)" <benjamin.robin@bootlin.com>
Date: Mon, 28 Sep 2026 10:07:26 +0200
Subject: [PATCH 6.6.y v2 2/2] netfilter: nf_tables: join hook list via
 splice_list_rcu() in commit phase
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260928-cve-2026-52988-6-6-v2-2-0d40c1553ff1@bootlin.com>
References: <20260928-cve-2026-52988-6-6-v2-0-0d40c1553ff1@bootlin.com>
In-Reply-To: <20260928-cve-2026-52988-6-6-v2-0-0d40c1553ff1@bootlin.com>
To: stable@vger.kernel.org, "Paul E. McKenney" <paulmck@kernel.org>, 
 Pablo Neira Ayuso <pablo@netfilter.org>
Cc: Sasha Levin <sashal@kernel.org>, miguel.gazquez@bootlin.com, 
 thomas.petazzoni@bootlin.com, 
 "Benjamin Robin (Schneider Electric)" <benjamin.robin@bootlin.com>
X-Mailer: b4 0.15.2
X-Last-TLS-Session-Version: TLSv1.3

From: Pablo Neira Ayuso <pablo@netfilter.org>

[ Upstream commit a6134e62dba2ea4f760b29d5226907f447c92400 ]

Publish new hooks in the list into the basechain/flowtable using
splice_list_rcu() to ensure netlink dump list traversal via rcu is safe
while concurrent ruleset update is going on.

Fixes: 78d9f48f7f44 ("netfilter: nf_tables: add devices to existing flowtable")
Fixes: b9703ed44ffb ("netfilter: nf_tables: support for adding new devices to an existing netdev chain")
Signed-off-by: Pablo Neira Ayuso <pablo@netfilter.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
Signed-off-by: Benjamin Robin (Schneider Electric) <benjamin.robin@bootlin.com>
---
 net/netfilter/nf_tables_api.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/net/netfilter/nf_tables_api.c b/net/netfilter/nf_tables_api.c
index a9053667e370..a1c701886fc1 100644
--- a/net/netfilter/nf_tables_api.c
+++ b/net/netfilter/nf_tables_api.c
@@ -10298,8 +10298,8 @@ static int nf_tables_commit(struct net *net, struct sk_buff *skb)
 				nft_chain_commit_update(trans);
 				nf_tables_chain_notify(&trans->ctx, NFT_MSG_NEWCHAIN,
 						       &nft_trans_chain_hooks(trans));
-				list_splice(&nft_trans_chain_hooks(trans),
-					    &nft_trans_basechain(trans)->hook_list);
+				list_splice_rcu(&nft_trans_chain_hooks(trans),
+						&nft_trans_basechain(trans)->hook_list);
 				/* trans destroyed after rcu grace period */
 			} else {
 				nft_chain_commit_drop_policy(trans);
@@ -10439,8 +10439,8 @@ static int nf_tables_commit(struct net *net, struct sk_buff *skb)
 							   nft_trans_flowtable(trans),
 							   &nft_trans_flowtable_hooks(trans),
 							   NFT_MSG_NEWFLOWTABLE);
-				list_splice(&nft_trans_flowtable_hooks(trans),
-					    &nft_trans_flowtable(trans)->hook_list);
+				list_splice_rcu(&nft_trans_flowtable_hooks(trans),
+						&nft_trans_flowtable(trans)->hook_list);
 			} else {
 				nft_clear(net, nft_trans_flowtable(trans));
 				nf_tables_flowtable_notify(&trans->ctx,

-- 
2.55.0

