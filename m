Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6AAEA29E116
	for <stable@vger.kernel.org>; Wed,  9 Sep 2026 00:52:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788915133; cv=none; b=IUyUsRvvFAo18OHNFXLuugjlRWx0Hq4lSZ9mgjcr6rGkawf3jhY704b4BZBoPpZPGWw7Qud/yFgmrcGTMIzli8ivn84r7pYChc1MCRoi/NeegRA1uw/1Zo+Br9FNzUZ0HFETnW6q76LgAMBZtmPpSRYLOfJnsXKC5BNuU6E+OuQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788915133; c=relaxed/simple;
	bh=rFNcWTxFBYTFY4SQfgkiuwv9BsCutwPSIZ31qyzaIo8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=QFBBwRoS61MxkjOqiQloz/sXhyDg2t5jyfFu/7OG3Nl6w3XAzL40xb+qhOSwqIt3jnWnyBQ13cnobQRYog5gDuoRIOelmSv9BVUVcEBZ86lawcT5AcZwUzL5qAa7T05JFQF3MU1SxdyKs4KPvTrowFisjG15PvIaHzAemXTjfyQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=nMyFaOVl; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="nMyFaOVl"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6DF821F00AC4;
	Wed,  9 Sep 2026 00:52:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788915130;
	bh=/UP79lXps8kMIViT3TG0pRon5WqslaOROL1EaJ4aVfE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=nMyFaOVlVU23fgF0Ozip4iwBWXovMZAZjn1VciA9EXmYueWXl79+2C7lIGSnrE7G3
	 yefUZVP+ncVGWqzv8HTn5bUZkLD9oKuKSAYqPKs6hj31eoeXePdbE5/IG1ZAptDuB0
	 KvhUxX/oDmq62LKyUmu8b0pQgZH72Qjp8eJUdOlisKQ/ycylEjA2PAGBQYtrOAm7bM
	 M89l/xHdlyq/vX6tNghK4HbHOOF/k9Uazts3AZsvHEALS33htdHoRp6WTJEc1bUwaL
	 TacuP+kdYtxHkN7iY/k1xvuG4KiZDmaxkE2lTkAk2aZen7gNXvtNuDP/Bi2ynzsWcp
	 qkTA9POpw9Uzg==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Yan Zhen <yanzhen@vivo.com>,
	Chuck Lever <chuck.lever@oracle.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.6.y 2/3] sunrpc: xprtrdma: Use ERR_CAST() to return
Date: Tue,  8 Sep 2026 20:52:07 -0400
Message-ID: <20260909005208.805626-2-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260909005208.805626-1-sashal@kernel.org>
References: <2026090355-carton-stuffy-958f@gregkh>
 <20260909005208.805626-1-sashal@kernel.org>
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
index c01685223973c..dc7e02ed8894f 100644
--- a/net/sunrpc/xprtrdma/svc_rdma_transport.c
+++ b/net/sunrpc/xprtrdma/svc_rdma_transport.c
@@ -349,7 +349,7 @@ static struct svc_xprt *svc_rdma_create(struct svc_serv *serv,
 	listen_id = svc_rdma_create_listen_id(net, sa, cma_xprt);
 	if (IS_ERR(listen_id)) {
 		kfree(cma_xprt);
-		return (struct svc_xprt *)listen_id;
+		return ERR_CAST(listen_id);
 	}
 	cma_xprt->sc_cm_id = listen_id;
 
-- 
2.53.0

