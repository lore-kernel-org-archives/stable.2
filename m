Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4312944E03B
	for <stable@vger.kernel.org>; Wed, 17 Jun 2026 14:45:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781707510; cv=none; b=C+7cS88NY4yCBwC4+qSkUvoTH2bVUDH7WkN3fj9eUSvWS+V0Q4D6G4e4GVP5a3crSCAwxINQ8ZOY8Ds5Y8CjIMDr2ctWZ+Lx0bDRdOLFBbN1X2zEZdnXRwXTppGJCZxW9o+XUGcH54jr62NCaq5S53j32DsNPum5/i+7ha2y2M8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781707510; c=relaxed/simple;
	bh=ttANePPkO7P1BaCSZQpFItFrqnqjHZWxgMEo0jgIoTw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=DXboQdRgb2VlGhx3eiS+ZAmrVycllw4aZ4YP+9ueo8dyDsz7wVa11gCxw90++sAEVYR66NZlHlysECLpe9y3sI/2V1fxlX3PDUC86muiDlzFhzsGt1GyPXFWLU69VsgLS7HQs8fqLANs5Is0LS4v2hoe3T0OUnkpP2n4UxOECKk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=YEArsaCg; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="YEArsaCg"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 529711F00A3E;
	Wed, 17 Jun 2026 14:45:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781707509;
	bh=mlUuneOEXraJI0inpBsDP+A4/EPUliEN5nTwxU/J6Ew=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=YEArsaCgSrIx2hmg5JLlUO3Esxzl0fDy2zDM0A8sftEU2NFo2HlmZa+uGd+rHvjfJ
	 i4sXsz6mDXbYw++J6Yb+rBJReelrh3eMgOMToX1yX6emyDmaENziaNjwkeZBhZj6vX
	 IYHCY6CDiH8vAGOlNL0vTXysUiKMfvRrzRTMz9hHCNI0dztgnydSF6YnFZRZ0Xg0Ci
	 JGCnq4Lw5mrd+U+puN5hCV7EWAkwnkMkhDeqL+mK8aJwsTcLyOck+S+3AMubR0MqbT
	 Z1iYKqhR8pcx+rF7kSKiUGOB2cTEf3+lDyJl864jRAI+5S9WrQpLRaOoiplYKKhhCq
	 bgk5ArnRRQrBA==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Santosh Kalluri <santosh.kalluri129@gmail.com>,
	=?UTF-8?q?R=C3=A9mi=20Denis-Courmont?= <remi@remlab.net>,
	Simon Horman <horms@kernel.org>,
	Jakub Kicinski <kuba@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.1.y 3/3] net: phonet: free phonet_device after RCU grace period
Date: Wed, 17 Jun 2026 10:45:04 -0400
Message-ID: <20260617144504.4144644-3-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260617144504.4144644-1-sashal@kernel.org>
References: <2026061545-rival-anything-e56f@gregkh>
 <20260617144504.4144644-1-sashal@kernel.org>
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

