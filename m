Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794412949;
	b=dfMYHN559BWWump72xlKflhJ0Jh6/1Lk4hwbXtb8nT+bCRZ8PfL4NNGvUyg13fn02Gjk
	 8gmpEjizSeIQMappJUbc6XlOknVgHNlTdqm+4bY/PnymScrQbIVZtiY/hBN5riMafO4iL
	 Bb/nSJlcZgjW9XccRO7i8VaX/2BABbqPdXys5MezhuyFJD1ktTO0pGEx5rR0EG+L/aecI
	 Kg7udkeO9tW4h7N/Sz3iXfbQ7vKaHPY458AC84Jr7LQVll78h/1RpwJ3jVkKjoObI6i1c
	 mdSY77fC5j7ETLzSpLd7TPkyBSbHazl19xgKGC/oK+NpDkOlARUThK16m2e6MXBrD+Q==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794412949;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=/q8tBLRdaUGwCfu1FpddJU0kTjMosHJuJXDy8uXLqHc=;
	b=NUsRhs0SmLBLr6zHxvxXAjTxb3ZIg/oCPwFTGCjtfa82oEoR0yqjo9JsXhNjg4CfaKTN
	 PoJRZ7WslRikjC+HUMOyRxtRYnJT3PwwRv9rJcnzjuHUozxtLKzFaNfss1w1tzs0NHtN9
	 GL5qPdpPZJB6Y/4a6QPvR+w1AiuELw/MaJMfhEMa6z4UYpDzIA+RWgVi5boSsLUt70WIw
	 c/48HWywaXNh6eBVRDKLorRBNFGPTI0FORXx7kBvmNq6Xw2wNaSgAx/pSW3kztltn/j32
	 KbUfV+jvuBXJzFbSaLDIqWKcCc0rA3Fz7sRAeRlJ4dvSeiKa09CKN8A5vIhmwsu+HPA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=On5pBBxp;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 71990606A33D
	for <stable@vger.kernel.org>; Wed, 11 Nov 2026 16:02:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=On5pBBxp
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B88141F00A07;
	Wed, 11 Nov 2026 16:02:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794412949;
	bh=/q8tBLRdaUGwCfu1FpddJU0kTjMosHJuJXDy8uXLqHc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=On5pBBxpkFshGwGRAF8r9cYCo440/4cPJIgViS7EII3pOSO0LtPj3rgH33K8q3z50
	 1xHpt1jLuYfwY4YxNMbK8TwZXERCFnOhLPOFWdJ5xeYV3VqTolc60UdS7ZGObBUBzu
	 Yu6GxzjEdQU15WNjNSXU+TmtzZqqbVHr5cYLvL3630iAqkAPQY10glIsf+iWqi0vkZ
	 VebR6iuYn9R8yx0we7LcpWtRMQrB8VDqHWeze6NS4V1rT3mMIIZ0OJtlDxINiRTQIn
	 dkl6LnSijQm9jts/g3GQgeX929AQadjRj9alvA2AAxC+XpydiiJX0zbu+Xk7coQbG9
	 dC/fn3rLrcl9w==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Daehyeon Ko <4ncienth@gmail.com>,
	Ido Schimmel <idosch@nvidia.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.15.y 4/4] ipv6: remove ifaddr from hash during ifdown list cleanup
Date: Wed, 11 Nov 2026 11:02:24 -0500
Message-ID: <20261111160144.2767084-4-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261111160144.2767084-1-sashal@kernel.org>
References: <20261107060950-failed-5.15-6ace56ed7b13@kernel.org>
 <20261111160144.2767084-1-sashal@kernel.org>
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Daehyeon Ko <4ncienth@gmail.com>

[ Upstream commit 6ace56ed7b13a9c6d4cb7ef0d82d3a3d53324a63 ]

addrconf_ifdown() clears the address hash before snapshotting the
per-device address list. A concurrent ipv6_add_addr() can publish an
address after the hash scan and before the list snapshot.

The ifdown path then removes the address from the device list and drops
the list-owned reference while it is still linked in the hash. Once the
remaining references are released, inet6_ifa_finish_destroy() warns, but
a DEAD address continues to kfree_rcu(). The hash therefore points to
freed memory that later RCU walkers can dereference.

This follow-on was found by source review and was not separately
triggered at runtime.

Remove each non-kept address from the hash immediately before removing
it from the per-device list. Keeping it hashed through the delete
notification blocks same-address publication until NETDEV_DOWN has been
delivered. hlist_del_init_rcu() is safe when the earlier hash scan
already removed the address.

This handles a late publisher captured by the list snapshot. The next
change serializes publication with teardown so an add cannot miss both
observations. Both changes are required when backporting the complete fix.

Fixes: 73a8bd74e261 ("ipv6: Revert 'administrative down' address handling changes.")
Cc: stable@vger.kernel.org
Reported-by: Ido Schimmel <idosch@nvidia.com>
Link: https://lore.kernel.org/r/20261004135117.GA206930@shredder
Link: https://lore.kernel.org/r/179161099539.434549.2238120015372268173@kernel.org
Suggested-by: Ido Schimmel <idosch@nvidia.com>
Signed-off-by: Daehyeon Ko <4ncienth@gmail.com>
Reviewed-by: Ido Schimmel <idosch@nvidia.com>
Link: https://patch.msgid.link/20261015050651.1841557-2-4ncienth@gmail.com
Signed-off-by: Jakub Kicinski <kuba@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 net/ipv6/addrconf.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/net/ipv6/addrconf.c b/net/ipv6/addrconf.c
index e4f1c67c6c511..aa033c2cd8a0d 100644
--- a/net/ipv6/addrconf.c
+++ b/net/ipv6/addrconf.c
@@ -3933,6 +3933,10 @@ static int addrconf_ifdown(struct net_device *dev, bool unregister)
 		}
 
 		if (!keep) {
+			spin_lock_bh(&net->ipv6.addrconf_hash_lock);
+			hlist_del_init_rcu(&ifa->addr_lst);
+			spin_unlock_bh(&net->ipv6.addrconf_hash_lock);
+
 			write_lock_bh(&idev->lock);
 			list_del_rcu(&ifa->if_list);
 			write_unlock_bh(&idev->lock);
-- 
2.53.0

