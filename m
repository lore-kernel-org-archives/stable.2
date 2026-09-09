Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DB201296BD2
	for <stable@vger.kernel.org>; Wed,  9 Sep 2026 01:31:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788917491; cv=none; b=N46iRMdUlIECBQ86W5/M4YTA5Fpe6xZMAG+x2iO4KSIiEOfvt6yCwhorTrGmt/2ec1m5h9u2OsFCngHo9EXXHsL//9sD6jXQTxpIf+6Ix5E9s9QulXXfStRZ4Zs50oj80nKkIy8wEeYg565gJRRyAZDVfjFb0lhTJBeCfB7qQH4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788917491; c=relaxed/simple;
	bh=mag5fy3Y3xt1vGLMWjmUi8Iz6F/wmQHC+cJl40rPtJM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ntax2CleKW+nkVJVGZjLhLgaHbhqm4iayR/FFHiqfW97fdCsJzlSh7Z2V8J9owahcIWZCEHqEwKcKsIBj2ENth03lEWlfmMQe5opRMyQ9X8iAnmZp3ospCaKPcr8kZHXOEmpqqDHp/7+wf+75Q8yvLPTn7mARFoBy9qHYkbOOC4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=go7WYNld; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="go7WYNld"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0291A1F00A3A;
	Wed,  9 Sep 2026 01:31:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788917489;
	bh=6DQMMJWdFRE8GZ4yCiVYWK3JEw4jTr+Ehk2haOPq2Gw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=go7WYNldLhsgkn9mL3z1bZRZEMPDVgDXzjuhTc9MLgCrL3AiAXYbfrPM/waJ+Qcen
	 ffJ1TpUODG6xbhAu6TXSmM/nviNh7eIH7t3BMHrfFo67VwJjsmhz5ewVOUn0UV84pv
	 8DW5FFrA9IUz59TWcUXB8XMY/Rnp77yVXsyHo7psA5pb00mbMQrEHDXFsl0ffU0GJN
	 sJoyu1yXEjlJrYFYHYg3OyBvznYl9yH6dD/RCHPV2NzQs2ZdIm/V7P8KuHyHLqIWeR
	 XSSVHpMTbvPKfevtAHLxuQpY6cTOj6vwfYR9xjjz9NqzAbCUS8Vk/brGHQhPjNrvTW
	 pBLMWH6LiptWw==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Chuck Lever <chuck.lever@oracle.com>,
	Jeff Layton <jlayton@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.1.y 4/4] svcrdma: Use svc_xprt_put to free listener on create failure
Date: Tue,  8 Sep 2026 21:31:25 -0400
Message-ID: <20260909013125.889054-4-sashal@kernel.org>
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

From: Chuck Lever <chuck.lever@oracle.com>

[ Upstream commit e346ef7bcb137f50c49f969330ab7dcf64ea1654 ]

svc_rdma_create() calls kfree(cma_xprt) when
svc_rdma_create_listen_id() fails. svc_xprt_init() has already
acquired a net namespace reference via get_net_track(); kfree
bypasses svc_xprt_free() which releases it.

Replace the kfree() with svc_xprt_put() so the kref_init birth
reference drops to zero and svc_xprt_free() dispatches
svc_rdma_free() to clean up properly. sc_cm_id is still NULL
at that point; the preceding patch added the necessary NULL
guard in svc_rdma_free().

svc_xprt_free() also drops the module reference via
module_put(), but the caller _svc_xprt_create() does the same
on xpo_create failure, double-putting the single
try_module_get() it acquired. Take a compensating
__module_get() before the svc_xprt_put() to keep the count
balanced, matching the convention in svc_rdma_accept()'s error
path.

Fixes: 4fb8518bdac8 ("sunrpc: Tag svc_xprt with net")
Cc: stable@vger.kernel.org
Acked-by: Jeff Layton <jlayton@kernel.org>
Link: https://patch.msgid.link/20260527-rdma-follow-on-v1-3-1b09bd87b6cd@oracle.com
Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 net/sunrpc/xprtrdma/svc_rdma_transport.c | 8 +++++++-
 1 file changed, 7 insertions(+), 1 deletion(-)

diff --git a/net/sunrpc/xprtrdma/svc_rdma_transport.c b/net/sunrpc/xprtrdma/svc_rdma_transport.c
index ae15c2ed2f12c..f573b555853c7 100644
--- a/net/sunrpc/xprtrdma/svc_rdma_transport.c
+++ b/net/sunrpc/xprtrdma/svc_rdma_transport.c
@@ -350,7 +350,13 @@ static struct svc_xprt *svc_rdma_create(struct svc_serv *serv,
 
 	listen_id = svc_rdma_create_listen_id(net, sa, cma_xprt);
 	if (IS_ERR(listen_id)) {
-		kfree(cma_xprt);
+		/* _svc_xprt_create() acquired one module reference and
+		 * puts it on xpo_create failure.  svc_xprt_free() puts
+		 * a second one when the kref drops to zero.  Take a
+		 * compensating reference so both puts are balanced.
+		 */
+		__module_get(cma_xprt->sc_xprt.xpt_class->xcl_owner);
+		svc_xprt_put(&cma_xprt->sc_xprt);
 		return ERR_CAST(listen_id);
 	}
 	cma_xprt->sc_cm_id = listen_id;
-- 
2.53.0

