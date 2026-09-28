Received: from smtpout-02.galae.net (smtpout-02.galae.net [185.246.84.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 18571469828
	for <stable@vger.kernel.org>; Mon, 28 Sep 2026 07:59:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.246.84.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790582347; cv=none; b=J2qwSiuSvSioCtavU0N6IDWE1bw4BqJBAJnEiQdrgObWAE7XKh9OK1IdhXS4WMcr3BRkyr/wjS/UHGWaqybRMKWOciggxHobyKPXP27X1nWtAlnstPBMeONpwSCJzBss35EDi+96+jzOvjpiMy1gzVgL5spvwQXSXSjhlOHWFCQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790582347; c=relaxed/simple;
	bh=3W4NBgrl+/+uvd0zacahZXxOp+vkntyxfo7leGlIQhM=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=lS+3UhmYttW57FPMTVcw0DpZd1/Z4mOi5LC7xaQ7/v/1E0hCI6+FUY0zSbuOfacv3dtQSZtN9Z1CQxsl8vuR8eXo/nVS1p5PKNPYYeZ+F/AtiUyTwiEdli0kjWx9f5evmzvSGxg3ydfkAIk2M5t5wY6D6uo9XxdrUhhVfOLjFoU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=HeUHL2fd; arc=none smtp.client-ip=185.246.84.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="HeUHL2fd"
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-02.galae.net (Postfix) with ESMTPS id 4E0F51A0FF7;
	Mon, 28 Sep 2026 07:59:03 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id 1D97C601BD;
	Mon, 28 Sep 2026 07:59:03 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 74571102F1EAC;
	Mon, 28 Sep 2026 09:59:01 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1790582342; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:in-reply-to:references;
	bh=lo+fp3uIp/MZMNdfvqhab5GBoaeFlln1V3lSeLMKGGQ=;
	b=HeUHL2fdKHsw9VtYOarWLfaXTnGPX0WpJryG8tYhr257fYfXrUKIiApq0IHpUQI3VY9dgr
	CGroSCRxYOl4ycN0URqlRtHOuIHhUkotc/9ItYXlzGiL0EybsAM6nrSoXVFa3czRoYDnMQ
	CCPQdaqCSGs/5nZMXJGG69YCpmq7205yPdxOr6dGh6RYQGldeksqrh3fcV4iDjywBnnc+I
	gDJ23BBxYaUswsCBAdFHjNi1X5QJNz4bK2OSypkOO3mLh4WWGqwfbQ/7xYY0ee7Gqi9EEg
	iCllGUUgE0np3dYrKGxMCY2XKNvrU/LYnvAi8bkeEiefPzKZbhB8YcTEJJ6JyA==
From: "Benjamin Robin (Schneider Electric)" <benjamin.robin@bootlin.com>
Date: Mon, 28 Sep 2026 09:58:47 +0200
Subject: [PATCH 6.18.y v2 2/2] netfilter: nf_tables: join hook list via
 splice_list_rcu() in commit phase
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260928-cve-2026-52988-6-18-v2-2-6492e680c52a@bootlin.com>
References: <20260928-cve-2026-52988-6-18-v2-0-6492e680c52a@bootlin.com>
In-Reply-To: <20260928-cve-2026-52988-6-18-v2-0-6492e680c52a@bootlin.com>
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
index a3a66b6268cd..fa1ee5024d58 100644
--- a/net/netfilter/nf_tables_api.c
+++ b/net/netfilter/nf_tables_api.c
@@ -10863,8 +10863,8 @@ static int nf_tables_commit(struct net *net, struct sk_buff *skb)
 				nft_chain_commit_update(nft_trans_container_chain(trans));
 				nf_tables_chain_notify(&ctx, NFT_MSG_NEWCHAIN,
 						       &nft_trans_chain_hooks(trans));
-				list_splice(&nft_trans_chain_hooks(trans),
-					    &nft_trans_basechain(trans)->hook_list);
+				list_splice_rcu(&nft_trans_chain_hooks(trans),
+						&nft_trans_basechain(trans)->hook_list);
 				/* trans destroyed after rcu grace period */
 			} else {
 				nft_chain_commit_drop_policy(nft_trans_container_chain(trans));
@@ -10993,8 +10993,8 @@ static int nf_tables_commit(struct net *net, struct sk_buff *skb)
 							   nft_trans_flowtable(trans),
 							   &nft_trans_flowtable_hooks(trans),
 							   NFT_MSG_NEWFLOWTABLE);
-				list_splice(&nft_trans_flowtable_hooks(trans),
-					    &nft_trans_flowtable(trans)->hook_list);
+				list_splice_rcu(&nft_trans_flowtable_hooks(trans),
+						&nft_trans_flowtable(trans)->hook_list);
 			} else {
 				nft_clear(net, nft_trans_flowtable(trans));
 				nf_tables_flowtable_notify(&ctx,

-- 
2.55.0

