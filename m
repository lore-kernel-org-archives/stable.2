Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0013E3F7A97
	for <stable@vger.kernel.org>; Wed, 17 Jun 2026 14:28:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781706516; cv=none; b=mwSAZv+jEk9CBFngDyW84+DwQePDjTokfRdFyuzElOcfUMj6HnGVAEluK2zWYktMUl+OXLM9ZHc7ETpeUttzRD0qaOmu5z8IV96I2lxLoNoyhdLB0BhU9PQa47xbLoa1s5S6TSJJbiy/zjVozc7DYxxAJ/yki1NxgDcX9xrPG8E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781706516; c=relaxed/simple;
	bh=ttANePPkO7P1BaCSZQpFItFrqnqjHZWxgMEo0jgIoTw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=tpdm/A7WW87//BWzcoe3LriVhblh25dtH9LC+2zYq1UXRj9QhWx8FpouDSkAe2yjHebEwZEsyyhmXn960zEqGwwtkp0oa+wdoKcvmJ1gLmtFArjPJSas+yOrgA/MUfQPfO4NMZpRJaBDUm+V4fwSc8VRX3GkVqedOMnlKUMnwRU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=dDaO4TIx; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="dDaO4TIx"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 36AF81F000E9;
	Wed, 17 Jun 2026 14:28:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781706514;
	bh=mlUuneOEXraJI0inpBsDP+A4/EPUliEN5nTwxU/J6Ew=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=dDaO4TIxQJ3zPc2WTonQ6AinI9jNtD3UUrUjl9oS2SKyxXap8Pa3p9etS0oF8d2ko
	 BfnqtRmFve3KIImnYsKj/T64R982WN6j4js96nGAB/33N/baFyaFE8XmkPLjqSIItR
	 cZ1imIqPXuqCw89Ka1WQgvvIcj/+hb+43Ysgz40hZ0kqkD6fDgLP9ieHk2p2ClAUTp
	 1TYpiZS1xmZe1GYGmykesg/UCZJ8MbY+K0FlTi2795oo7E7MEFGUmK4eZYI1O0fndj
	 9VEl7BHgk2rDBxVqb3mAGPofp+8KYChVCIK4ep8R9DbkC7m/5vJw3e+ej4DwMlsMea
	 6ix4lHlfR7iqQ==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Santosh Kalluri <santosh.kalluri129@gmail.com>,
	=?UTF-8?q?R=C3=A9mi=20Denis-Courmont?= <remi@remlab.net>,
	Simon Horman <horms@kernel.org>,
	Jakub Kicinski <kuba@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.12.y 3/3] net: phonet: free phonet_device after RCU grace period
Date: Wed, 17 Jun 2026 10:28:30 -0400
Message-ID: <20260617142830.3939916-3-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260617142830.3939916-1-sashal@kernel.org>
References: <2026061541-expanse-aloft-6b99@gregkh>
 <20260617142830.3939916-1-sashal@kernel.org>
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

