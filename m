Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4AFF53F9F56
	for <stable@vger.kernel.org>; Wed, 17 Jun 2026 14:33:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781706820; cv=none; b=DP+2pCld1V76pGdNjPwaOCxGPNbk1/jqZAvAQ9IkVgrO1yIWaGORS9rsezZ+frjZEnkp0lzHHKHBQXiehXXF/qurmw02yonCLK9NU6ZiP9Ug5RG/H3Aa5HSaRksi+dQYtSITt4JDEMP4jbsfkqXdliGdUWcXbiVLYw9G1JQvx5Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781706820; c=relaxed/simple;
	bh=ttANePPkO7P1BaCSZQpFItFrqnqjHZWxgMEo0jgIoTw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=XOGVj1VY/FFFvBJ9OLMCZjlXDMbH+yrGGKsMKtLpnR7FwSx/27T0h6AOZyUa/CzW6bf6VWML0XHmbqbtDnoGGi5IewRC+DwIqNfFkdSrBkp6EpbPLsFRbDknyZMmj1ZjqhhmjleOF/VCnrRPYQqtR/cveAE1OxOj+OsfuVlC4kI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hukNwdb4; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hukNwdb4"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4733C1F00A3F;
	Wed, 17 Jun 2026 14:33:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781706819;
	bh=mlUuneOEXraJI0inpBsDP+A4/EPUliEN5nTwxU/J6Ew=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=hukNwdb4NjBwTNhb41B2hHrY/RpquDYawAF7Lb9hmE29IeSp+E5/eaYKfQ0SfUaYb
	 6GZZF+3HoeW+dQ9MZhjmA0RGR8Cpv4L40YW1ipC712W17SIdxi7wn/hTbpP+Luv3uX
	 J17+WMkm+T4EB9uXdifqXn/O2aT4de/mjZ9kUScpZLzF3Qy9xdfsZOyZR8CGnswyA/
	 EJzrt6t2xs+rL+WKn5TLhY/GeeDcMin32jVGK3C9cmyL8muXngO1zIXl5T/bYx/Psu
	 yXoEqFJrPYQ2l6ltTZlqnfPgQY0oo+mo9cTZbMhi2BHHEKUPqPiD1M1B7p2Vh/jTA5
	 Cxluo0DvyTX1g==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Santosh Kalluri <santosh.kalluri129@gmail.com>,
	=?UTF-8?q?R=C3=A9mi=20Denis-Courmont?= <remi@remlab.net>,
	Simon Horman <horms@kernel.org>,
	Jakub Kicinski <kuba@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.6.y 3/3] net: phonet: free phonet_device after RCU grace period
Date: Wed, 17 Jun 2026 10:33:35 -0400
Message-ID: <20260617143335.3942705-3-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260617143335.3942705-1-sashal@kernel.org>
References: <2026061544-output-dreamt-c938@gregkh>
 <20260617143335.3942705-1-sashal@kernel.org>
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

