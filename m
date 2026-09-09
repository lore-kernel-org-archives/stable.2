Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ED5622E7397
	for <stable@vger.kernel.org>; Wed,  9 Sep 2026 01:55:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788918927; cv=none; b=Q7VBuzBueYAD3ikVQ8xTcIkOInk9W6C1pFSBHUzXiX7sprUw9sP8DNXerp4YqWXkSUoTJr6wWl8FqlBwhx4oQDE468Tqgt2UrD+HXv8dB8ifxrH/iwmcSSrPm9Ye2qv43TvpU118t1GHCc7brktX7ytXjOMLm13FgxRVLuEEh2s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788918927; c=relaxed/simple;
	bh=M+WZR8gT0yoa4qNsCKcksC9yfHYK/Hw+vyeLjXW1h3A=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=KHUZYNoBDtQrtr7+JWBFqJHYOrvuOe5GyfWnKv9N71QGrcJjInYR/2LYSnPK+IKiT78vAsD3d6ISvRt9ljeaUY0SCgX+ivU998tBpZI6HMezxo+cJEjt5t7wJscDQfKdSDPQ6Ek/qM/bhGOOX0LfnIBmtv6GR7zxFqfj51tXIgI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=SfRGWymC; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="SfRGWymC"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5BAE51F00A3F;
	Wed,  9 Sep 2026 01:55:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788918925;
	bh=I3zwLDo/7YD6KgfuZJGYiVjjhx33A6giU/sfxh2lEFQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=SfRGWymCSGsZEIDCGa8IR04Dmm2xgn+0RRuivkNiT7aP2KqCp5vwPF3Z7+7W93+D+
	 rKckQwl4VtWuvBHeOKmYIRVkTriXiKD9cBcon4+H6rBWWZRaP2UkDq7d9RC9xNNMAC
	 cTzrLLsskS5cZq0Vb2rC/G4IvmJWiXk1ubFaG1voAUfjlVdsV4Opxnhe1+zk8KSHlB
	 ClRlAv9KQBR3xOfmNCXYkC6xhB3YANCCGUQmirJB5btII6IF6FHTX0WVA8vGIPS0f4
	 /1rI/fF94izYVX2wfv/haf30CxXJXddD8d3Wk9tK/8WpJvlFI+zmi8xsPXFe4uVtZm
	 hBogbdR5Y39Hw==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Yan Zhen <yanzhen@vivo.com>,
	Chuck Lever <chuck.lever@oracle.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.10.y 3/4] sunrpc: xprtrdma: Use ERR_CAST() to return
Date: Tue,  8 Sep 2026 21:55:21 -0400
Message-ID: <20260909015522.954712-3-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260909015522.954712-1-sashal@kernel.org>
References: <2026090356-dehydrate-probe-c315@gregkh>
 <20260909015522.954712-1-sashal@kernel.org>
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
index e067d171fc4d4..f7f764508a2ea 100644
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

