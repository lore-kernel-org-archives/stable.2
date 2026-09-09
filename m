Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2AE9628505E
	for <stable@vger.kernel.org>; Wed,  9 Sep 2026 01:47:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788918446; cv=none; b=LW2yOZ941/G82609PgtLXflIrvYNi54/cigPpWDRcYWnAnbvCmI2Yx+hekZ5437jtDmdD95uSTRJMa1SM6aJSEuftYbaxxKQAdkI18REPKca8iNWIxLosJEWdB57D3X53VSBmT08YN7g99wXaz0wwJJtTFnu2dl3XN+CBjlh0A4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788918446; c=relaxed/simple;
	bh=JPkF0b3jeyBH+AU3Iu/W3YrFI+4gLNrPViZ8jvT8TWY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=X+Lvu+JJ7T8rPtrDlOwIl+KxPyhDgZOmNi3bdpmaeRM+NEL/o/wWIOx7sOSgF5LLMGrDGECnUDsaffLOl08YVZ7V5OzeCAovnQ7fiTru740n2wvSc+qh7ERsINMmMXfMVBbEbgLm9XqS2JlwP3E6+P9YQxgPlcAhQzSkYMbKIt8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=nuDcJ/sM; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="nuDcJ/sM"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 633F61F00A3D;
	Wed,  9 Sep 2026 01:47:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788918444;
	bh=9DqZMEROW+WZ6sMNjL+hYx5GfHoM+gAfs3rSBuBPwA8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=nuDcJ/sMK6rdFGpX1im9GExBhkhDpk/Qb7fMVtJiiV+7hLw/76gMyOJ37SwVZGp8u
	 BPc01LfNxSi2l61Y6iInPUBgdE0UH8mAmUDv03YLH4ze91+l4i2GZgDEiohU5eXBYG
	 dq2vV1SY0pKEqRolU6CKVZ8RlMzcfhy1pbkFzxSPJZFpDmi1iiAa+6s54BijP2T+Su
	 bNYHlfMI1a4a8+ulpGKHmk9NcVrKeRyIQDDBr4+g9Xqd2F2FMg5Sl8laLWQvq69+LS
	 biHQYuFr+NXUxhkTmY8EX+lcVQnpB37N9L7eLg2KAn8irZhcrxF+ET2fahAN1HIPJX
	 AVoA6Xq9MZJcw==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Yan Zhen <yanzhen@vivo.com>,
	Chuck Lever <chuck.lever@oracle.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.15.y 3/4] sunrpc: xprtrdma: Use ERR_CAST() to return
Date: Tue,  8 Sep 2026 21:47:20 -0400
Message-ID: <20260909014721.928409-3-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260909014721.928409-1-sashal@kernel.org>
References: <2026090356-skimpily-grape-6667@gregkh>
 <20260909014721.928409-1-sashal@kernel.org>
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

