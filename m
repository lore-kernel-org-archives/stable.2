Received: from smtpout-04.galae.net (smtpout-04.galae.net [185.171.202.116])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 48F4C46E019
	for <stable@vger.kernel.org>; Mon, 28 Sep 2026 08:10:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.171.202.116
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790583022; cv=none; b=VPPNJGWxaAVaRS4kDnV51h8wEHDflqi1IGBit3EhMz/aeDsnVvdr5UgB+06fDn7HX/pWD91nwwRBAsyZRNCZf5mIOkI04pP5EjqISGGFxj4myHG/GFaWTUY+uVoObqg1pq8aHr/5r0gVhyNZGzKW6d//9sVwEoLj42UYUCTQEZw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790583022; c=relaxed/simple;
	bh=d8gttQ0GtmQGGwVP2ciaFpjb9WXqhknmFSKQN+Fp4Mk=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=ODCUt2/fLf4jLfNqCGwc1SveQRzJa7+A/Fht+GQXvzVATLq2ZGP+URu8M6gMWXb0rfEN6UHIFarT2hXimCoAYTv72nJjvoG5qkUz1pcD4aD5KeGNt7jRuO5lhRD5dgSuM9WXBFHnH3s+xNejK5Wh8kqEauYnSkkfqw46KhpLuRM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=OuPJKPTl; arc=none smtp.client-ip=185.171.202.116
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="OuPJKPTl"
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-04.galae.net (Postfix) with ESMTPS id F2D1AC5CD50
	for <stable@vger.kernel.org>; Mon, 28 Sep 2026 08:11:08 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id E9BB9601BD;
	Mon, 28 Sep 2026 08:10:19 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id B091A102F1EA2;
	Mon, 28 Sep 2026 10:10:18 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1790583019; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:in-reply-to:references;
	bh=I6bEulLh7zAM0W47TqvOKsph6UiMIbIjYc+RQMMlt0A=;
	b=OuPJKPTlkev5f88RWWa6xdTAQuyFS4wImDkutoMxn2UQj6jzyiWEHrge8GRWWWIi+h6Cg0
	YqceZQaskZRDXYXYLcfmlUfoOUnPViFjTGoyysfJbJrtUYQ3KlmsZHUejhHFQOLdm0ofn6
	MdEHgV+Kdf9hCFkrpcJW2G6IwRkW4uuE2O3WE1DzARNlXwkIJ5/aoJ2P+8hAosw2wjPqH2
	VNSeweYXJ0OrgwDfaannaS0FGp1pupUSzdZds5+OHWtlBTb3HqxbGGCZ76uusYAK/fslub
	SDhuN7yv1mNbEhmgqbdAsFccu57QTqLQXQVX6rx4ffVW9ulZLYq7xnreTyuvmA==
From: "Benjamin Robin (Schneider Electric)" <benjamin.robin@bootlin.com>
Date: Mon, 28 Sep 2026 10:10:13 +0200
Subject: [PATCH 5.10.y v2 2/2] netfilter: nf_tables: join hook list via
 splice_list_rcu() in commit phase
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260928-cve-2026-52988-5-10-v2-2-d44de149a5ac@bootlin.com>
References: <20260928-cve-2026-52988-5-10-v2-0-d44de149a5ac@bootlin.com>
In-Reply-To: <20260928-cve-2026-52988-5-10-v2-0-d44de149a5ac@bootlin.com>
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
index 5e3f863c487f..63592c73a7a1 100644
--- a/net/netfilter/nf_tables_api.c
+++ b/net/netfilter/nf_tables_api.c
@@ -8797,8 +8797,8 @@ static int nf_tables_commit(struct net *net, struct sk_buff *skb)
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

