Received: from smtpout-03.galae.net (smtpout-03.galae.net [185.246.85.4])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 21901470450
	for <stable@vger.kernel.org>; Mon, 28 Sep 2026 08:08:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.246.85.4
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790582939; cv=none; b=EMMe5UFWC0zLzpLBIhHP72PTcj150AnEkk6C/V56KeTKovrrcBUc/R0ykLXLIJ2FfRmTG7gEDfSy0G72d+iUhvKddRMTAv7nR/5IJzFjFz6exv2zHs9aC8rwVXVUi7QVef7cjbPi2lTFLd/9NmRDJYrpAqXMp2RfiagY4qz3zcM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790582939; c=relaxed/simple;
	bh=2ckTwF4IVy/Y4ATnzyENRg7sebynBORa64nTlCQ3eQY=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=gJRfFmNbmkRIUX3XHvfV3kCTdE0DBsBazddXEaI7loq1uKaM6J6ex59Nu4pih1EJapmuFk64gC57wXbepoWag+PcRAVPPixw8dFi1zNVF2GSdkEUxNwAssVFno43JXUBNnSyZLPQcOkyncpPHXuicYDd+j84zhitdCE5Fuy91Uk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=JEiYl0in; arc=none smtp.client-ip=185.246.85.4
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="JEiYl0in"
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-03.galae.net (Postfix) with ESMTPS id 795924E41094;
	Mon, 28 Sep 2026 08:08:56 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id 4EEA2601BD;
	Mon, 28 Sep 2026 08:08:56 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id C0857102F1EA9;
	Mon, 28 Sep 2026 10:08:54 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1790582935; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:in-reply-to:references;
	bh=yZr8kHxnJ4C5buPDl1h/BxtYs8zl+KiT7OUxlH5Z1Ow=;
	b=JEiYl0injq2+D0OirMKw/QLxRoTiw6yvM54yCtj0b725pNsLgPOR4LdqXeQb8kupj2QUc2
	tt889XTogzWeXFZGG2whvonHO6Ej6leCzh04swHS+y9XeA9ftziqQN6dxVDGY2lbnB7y+d
	EXiVknUbld1Q0Z681xczWOuXvEYYlxt1n6K5KkK29a7ksfOkXZtOmPm1HMwSCEyW52JwGa
	W8egzjMdq4qs+Cd+29ri+2Z47+cuJ0fgFHZEI53rZj10IDa8n7aE0k7JDDfSkg0Y1f03G6
	RMKSwBeb1OJRkuaSKDb9O7laqp5RKWF9McmZYkidNIrh/CiJmKTF4HjpXONFEg==
From: "Benjamin Robin (Schneider Electric)" <benjamin.robin@bootlin.com>
Date: Mon, 28 Sep 2026 10:08:50 +0200
Subject: [PATCH 5.15.y v2 2/2] netfilter: nf_tables: join hook list via
 splice_list_rcu() in commit phase
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260928-cve-2026-52988-5-15-v2-2-519003db6b26@bootlin.com>
References: <20260928-cve-2026-52988-5-15-v2-0-519003db6b26@bootlin.com>
In-Reply-To: <20260928-cve-2026-52988-5-15-v2-0-519003db6b26@bootlin.com>
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
 net/netfilter/nf_tables_api.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/net/netfilter/nf_tables_api.c b/net/netfilter/nf_tables_api.c
index c1b5b579ccd7..b5273255b738 100644
--- a/net/netfilter/nf_tables_api.c
+++ b/net/netfilter/nf_tables_api.c
@@ -9707,8 +9707,8 @@ static int nf_tables_commit(struct net *net, struct sk_buff *skb)
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

