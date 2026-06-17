Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2E6E53B38A2
	for <stable@vger.kernel.org>; Wed, 17 Jun 2026 14:49:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781707764; cv=none; b=WAzSQLSp3cxj+d3DGIWaQY3vGmNZ5LPJv1jWPj8nvPRBEgaa1aU2KyGx88WYuHWbH9qAY3bOBAK7X3UHdeYBNFNN7f+S4BQ0fidFOEAY2gwOFdyre77x/YqLX/cdsLwId9Bd6eTJvfcCraKhWDOU7t1hwAg2FNTTnwMg3lYgOkA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781707764; c=relaxed/simple;
	bh=ttANePPkO7P1BaCSZQpFItFrqnqjHZWxgMEo0jgIoTw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=OZA2bGydRvAeEFAfv13B6ewHjO9sdcInKyYW+UlL1cUUw1RNWVrC80cs8VUznkoGdYFBGlrvuJyb1kHIHUnMc8fJS0WvMmrXYBM7pT016/dArlGPrFZAfckNMBCRnD8Lk8gPDJUqHouqNQlH0A1y7YGc7bL9sCa8udH4gyKrOG0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=cgdOQSCl; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="cgdOQSCl"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 680D91F00A3E;
	Wed, 17 Jun 2026 14:49:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781707763;
	bh=mlUuneOEXraJI0inpBsDP+A4/EPUliEN5nTwxU/J6Ew=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=cgdOQSClVa58OfdhzW9IoHiET35PVxCDY4c4scmmnG0tnBuKTSwgk2hvUuzfQJkiL
	 VAAyMRu9Pu0jV00ugDtvKEkQgOsu9cvjGTTUf0MPxag83p75wtRxMk7glDeOF5DKm0
	 nxr0QwUdBf9cmoevpIrNRNTRHmstlmEJGwRIJ7VHXG1YDCxfxw1ARF1v01sVF95zwK
	 oU6VEhIfcZ68Pz+ruu+Cc1RdoQGT48Mo2lcYqOK1wl+vL0P6rZhqtYk3jnr9x25IR5
	 qK/ub+kLVqUmwic4CkjBwxkzpktD0a39CGk+/lEXt/FuNBm6/o2nrTOYUp5WtOVqs9
	 ETjlpGELvGIfw==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Santosh Kalluri <santosh.kalluri129@gmail.com>,
	=?UTF-8?q?R=C3=A9mi=20Denis-Courmont?= <remi@remlab.net>,
	Simon Horman <horms@kernel.org>,
	Jakub Kicinski <kuba@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.15.y 3/3] net: phonet: free phonet_device after RCU grace period
Date: Wed, 17 Jun 2026 10:49:18 -0400
Message-ID: <20260617144918.39042-3-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260617144918.39042-1-sashal@kernel.org>
References: <2026061547-discourse-faceless-4af5@gregkh>
 <20260617144918.39042-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

From: Santosh Kalluri <santosh.kalluri129@gmail.com>

[ Upstream commit 71de0177b28da751f407581a4515cf4d762f6296 ]

phonet_device_destroy() removes a phonet_device from the per-net device
list with list_del_rcu(), but frees it immediately. RCU readers walking
the same list can still hold a pointer to the object after it has been
removed, leading to a slab-use-after-free.

Use kfree_rcu(), matching the lifetime rule already used by
phonet_address_del() for the same object type.

Fixes: eeb74a9d45f7 ("Phonet: convert devices list to RCU")
Cc: stable@vger.kernel.org
Signed-off-by: Santosh Kalluri <santosh.kalluri129@gmail.com>
Acked-by: Rémi Denis-Courmont <remi@remlab.net>
Reviewed-by: Simon Horman <horms@kernel.org>
Signed-off-by: Jakub Kicinski <kuba@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 net/phonet/pn_dev.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/net/phonet/pn_dev.c b/net/phonet/pn_dev.c
index 2e7d850dc72668..3f020c362d6cde 100644
--- a/net/phonet/pn_dev.c
+++ b/net/phonet/pn_dev.c
@@ -105,7 +105,7 @@ static void phonet_device_destroy(struct net_device *dev)
 		for_each_set_bit(addr, pnd->addrs, 64)
 			phonet_address_notify(net, RTM_DELADDR, ifindex, addr);
 
-		kfree(pnd);
+		kfree_rcu(pnd, rcu);
 	}
 }
 
-- 
2.53.0

