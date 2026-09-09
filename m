Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E7F1D2E7396
	for <stable@vger.kernel.org>; Wed,  9 Sep 2026 01:31:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788917490; cv=none; b=FAh5XM0rZOnMY20PZKvrBZrpYGChkPnbVWB9zFA8T6Opv+14uAD8OEfxxPdBr8cIn4T1NRre3xeMzSiAsexVz5qpHwmFJhlxkhOjU4ZMXKMLVNo2xs10xTsjYZOt7D77JLM63DMcfpWrzlGXnSnntGXXs0mbOecL79m8ohIljQA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788917490; c=relaxed/simple;
	bh=JPkF0b3jeyBH+AU3Iu/W3YrFI+4gLNrPViZ8jvT8TWY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Mq5c4jgm9mRDnFt2iucDP+w/So61qIZaXvOkERjrd0EiidNOOqCSoSAcmI4QeMmxrUt8VEIMzhOaTS1ngRcZVexKSMCR0qH6H4/fnvLYG7rmep9YcDaUq6bZrRVvtI4wTC2n/vnhYQhWLKLXyXwhjw8pmTdG/hsPFTRxyTC1olo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=O2k1UN10; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="O2k1UN10"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 438E61F00A3F;
	Wed,  9 Sep 2026 01:31:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788917488;
	bh=9DqZMEROW+WZ6sMNjL+hYx5GfHoM+gAfs3rSBuBPwA8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=O2k1UN10lpLHzXmJp1UrevgNEbPKon4GAzO8F77nJ8yMBw6REwIwtq265J61V9/O0
	 LLmP5hT2FIk2lG8rLsEKB9qjPtpaZQrDmIf8YljfDHMptvOwc+AtPq3ll+6UgUgwp3
	 Html4bANuXyxXPAEeLtPWeGAf74uN7XMrQnuuEmbhZygQPyWqClmoepngXlZ2y+NAc
	 XFRRnripHvRbXoqSA++8N/kREFVQKcSaefJEzT/TcjlMVOLPNYMO1nJWn6Druoa97N
	 xSYjUxas4PrLUIqivHXg/09rENa3yX8HA9ztokch/QtJE1bI+aUUlewSrJn1NaVolC
	 t/sS77+JERo8g==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Yan Zhen <yanzhen@vivo.com>,
	Chuck Lever <chuck.lever@oracle.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.1.y 3/4] sunrpc: xprtrdma: Use ERR_CAST() to return
Date: Tue,  8 Sep 2026 21:31:24 -0400
Message-ID: <20260909013125.889054-3-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260909013125.889054-1-sashal@kernel.org>
References: <2026090355-untaxed-empower-663f@gregkh>
 <20260909013125.889054-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Yan Zhen <yanzhen@vivo.com>

[ Upstream commit aeddf8e6c5662d60d434ce59f7e08ea020162323 ]

Using ERR_CAST() is more reasonable and safer, When it is necessary
to convert the type of an error pointer and return it.

Signed-off-by: Yan Zhen <yanzhen@vivo.com>
Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
Stable-dep-of: e346ef7bcb13 ("svcrdma: Use svc_xprt_put to free listener on create failure")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 net/sunrpc/xprtrdma/svc_rdma_transport.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/net/sunrpc/xprtrdma/svc_rdma_transport.c b/net/sunrpc/xprtrdma/svc_rdma_transport.c
index c84343fbf2d2f..ae15c2ed2f12c 100644
--- a/net/sunrpc/xprtrdma/svc_rdma_transport.c
+++ b/net/sunrpc/xprtrdma/svc_rdma_transport.c
@@ -351,7 +351,7 @@ static struct svc_xprt *svc_rdma_create(struct svc_serv *serv,
 	listen_id = svc_rdma_create_listen_id(net, sa, cma_xprt);
 	if (IS_ERR(listen_id)) {
 		kfree(cma_xprt);
-		return (struct svc_xprt *)listen_id;
+		return ERR_CAST(listen_id);
 	}
 	cma_xprt->sc_cm_id = listen_id;
 
-- 
2.53.0

