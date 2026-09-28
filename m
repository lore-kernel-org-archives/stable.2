Received: from smtpout-02.galae.net (smtpout-02.galae.net [185.246.84.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7E41B3B813D
	for <stable@vger.kernel.org>; Mon, 28 Sep 2026 08:05:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.246.84.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790582737; cv=none; b=fG1sxGtQRFwa48ZChCbg6hhbBvxn+tirRxanIaJG2xFOa6Tfs/VU2WOJa2oVeSdAW9t4XTKnZYMo+8Ff0PyzdAM20w8Frluj7yoxxxkf611jvJEOVf4/87Pn4q3FwffsoORHeZsjkJTNTHK4KvoxLFZGrPZpTC+utR+DKCqtRX8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790582737; c=relaxed/simple;
	bh=Db2t4/6bv/wUf68nck8rEPG1Qa5EqBs2EpF/WGC73Pc=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=lOXck0w885eb6RhPc0JPaLMALEk7jz24cyEC/Sg+SBFzUHmu9SEY7IyZR/MbzjzBM3bihNqibLFzOhxGq5H0wM9pFpKa7seiFHEMamXwYf1eU3mnwVjMfNsZWRWlJr7B/oNUXTB+l2balFSbblODvP+ZR2m228idwBHKvyGMmjs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=YzhSlGDp; arc=none smtp.client-ip=185.246.84.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="YzhSlGDp"
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-02.galae.net (Postfix) with ESMTPS id AFD191A0FE0;
	Mon, 28 Sep 2026 08:05:34 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id 848F4601BD;
	Mon, 28 Sep 2026 08:05:34 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 16575102F1EA2;
	Mon, 28 Sep 2026 10:05:32 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1790582733; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:in-reply-to:references;
	bh=YSsHqt8o+oNPZWRgI6DyJXdECqC82zyiwqS5WKv+Rpk=;
	b=YzhSlGDpYvKk3izFR1jTjO36i5eBbFufkICyc9Pura0JySsirDMgVTBs9+hghqmrG3HuML
	6Ulvw+XNuly9uMaLm9earRhmDKm0vWR+E9jIzEr33rBQx1L3vCJbsULTEuj1UZMbdQxIX1
	o4gZVO0O/x9gpL4V8iF2+nYtk3ZFhqMLhBmXqYpnUtqs3U1z08FkNGJYn4DosXhdGTnmRS
	GPjvk2t3zSVBL7ki3NttnFAIx1F81Wub3RTw+hz9V5bECpJJAkzt7xuCbJsmbDPOeco0uM
	W/N+KQo2tZ1tfePHurXn1HBZDOS+VBurMuKNsQS34R+NSB8qUJYNaz4stW1GRQ==
From: "Benjamin Robin (Schneider Electric)" <benjamin.robin@bootlin.com>
Date: Mon, 28 Sep 2026 10:05:20 +0200
Subject: [PATCH 6.1.y v2 2/2] netfilter: nf_tables: join hook list via
 splice_list_rcu() in commit phase
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260928-cve-2026-52988-6-1-v2-2-727cab14b35c@bootlin.com>
References: <20260928-cve-2026-52988-6-1-v2-0-727cab14b35c@bootlin.com>
In-Reply-To: <20260928-cve-2026-52988-6-1-v2-0-727cab14b35c@bootlin.com>
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
index 96b0638c220a..a373a0969e99 100644
--- a/net/netfilter/nf_tables_api.c
+++ b/net/netfilter/nf_tables_api.c
@@ -9995,8 +9995,8 @@ static int nf_tables_commit(struct net *net, struct sk_buff *skb)
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

