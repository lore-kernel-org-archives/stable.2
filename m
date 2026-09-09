Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 665C32F90E0
	for <stable@vger.kernel.org>; Wed,  9 Sep 2026 01:47:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788918447; cv=none; b=K5axVT7TnHkxn95ph/EWSsdlGXqY9XNMTjs/h/EUJ/mpzI/u2F/j2++kJnluYa7nSdkOfDw/YSR/xNht9nYGLMVHTb2GRXtZHpYhJEbCE2qzS9pcNraCi/V6BajvatjQS8g9LuhICZA9R5V4FMKGLdJ0ZATb19yC9c9sFBMsbWI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788918447; c=relaxed/simple;
	bh=wcjLOKZT/+MzZXPN2NnMpYTKKcfC5mkSMJOqAojwK9I=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=tm3mG6ma/AjCak910QPAiVhiInOwRTq6TDIMQlZMj4NcR4YDSWRsol8r53LLK52bybDTAfMjbaJ57l28I9PQKqumKEny1OE4+Eygb5jL+rjWhgwQBrQaBDPZPgrQ+1FdztcEqmBQjH6SXMb11jSNo6+BnhUifa27PkvFSKP6RTU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=aCv9HSOB; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="aCv9HSOB"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 99A661F00A3E;
	Wed,  9 Sep 2026 01:47:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788918446;
	bh=aajuy17B3Kx08ku8kwNEiqoPBx+qZhedSC83Ddfgg1c=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=aCv9HSOBQydjV2GvUsA1qVV2ZdQQi+GyqSjf9jp5yTZjfag/P2CbTjo/7/iiIR/xC
	 axbl/43BAVEUae9vsrZ7tpfQjM9lbGBGsHKtNB5rKTSo89l+iOA6wNKswamQJykeOP
	 Fi1qKfD5HiHck7NSxfx7KYKoE1hv4sGA60cBcIyNV0aibn4ePhdbXaTVbHb8dhF11b
	 qUABLBV3TL6DeywNtBd3kNKKD/Npaz7rIr1mCKdvGQkjCGSzJir0ouvdVr0NzgNCfh
	 BHL2WL4uRS6/cH6uTZSaOSiT7xBtbw5ZFSsOA+JtykshD3CALpR+sRPIBCvGbga764
	 OW67rgASiTnoQ==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Jeff Layton <jlayton@kernel.org>,
	Chuck Lever <cel@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.10.y 2/2] sunrpc: defer rq_argp and rq_resp free until after RCU grace period
Date: Tue,  8 Sep 2026 21:47:23 -0400
Message-ID: <20260909014723.928519-2-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260909014723.928519-1-sashal@kernel.org>
References: <2026090351-divinely-underpay-2e28@gregkh>
 <20260909014723.928519-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

From: Jeff Layton <jlayton@kernel.org>

[ Upstream commit c479bde671cbe2f9e152834a8b0eb7c3c295bbaf ]

svc_rqst_free() frees rqstp->rq_argp and rqstp->rq_resp synchronously
via kfree(), but defers the rqstp struct free via kfree_rcu().  After
svc_exit_thread() calls list_del_rcu() and svc_rqst_free(), there is
a window where RCU readers that started before list_del_rcu() can still
traverse the thread list and find the rqstp.  These readers (e.g.
nfsd_nl_rpc_status_get_dumpit()) dereference rqstp->rq_argp, which has
already been freed — a use-after-free.

Fix this by moving the kfree of rq_argp and rq_resp into an explicit
call_rcu() callback alongside the struct free.  Resources not accessed
by RCU readers (bvec, buffer pages, scratch folio, auth_data) remain
synchronously freed.

Fixes: 812443865c5f ("sunrpc: add a rcu_head to svc_rqst and use kfree_rcu to free it")
Cc: stable@vger.kernel.org
Assisted-by: Claude:claude-opus-4-8
Signed-off-by: Jeff Layton <jlayton@kernel.org>
Link: https://patch.msgid.link/20260611-nfsd-testing-v2-4-5b90e276f2d9@kernel.org
Signed-off-by: Chuck Lever <cel@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 net/sunrpc/svc.c | 13 ++++++++++---
 1 file changed, 10 insertions(+), 3 deletions(-)

diff --git a/net/sunrpc/svc.c b/net/sunrpc/svc.c
index d214760da9970..62ea4f955a7e9 100644
--- a/net/sunrpc/svc.c
+++ b/net/sunrpc/svc.c
@@ -630,16 +630,23 @@ svc_release_buffer(struct svc_rqst *rqstp)
 	}
 }
 
+static void svc_rqst_free_rcu(struct rcu_head *head)
+{
+	struct svc_rqst *rqstp = container_of(head, struct svc_rqst, rq_rcu_head);
+
+	kfree(rqstp->rq_resp);
+	kfree(rqstp->rq_argp);
+	kfree(rqstp);
+}
+
 static void
 svc_rqst_free(struct svc_rqst *rqstp)
 {
 	svc_release_buffer(rqstp);
 	if (rqstp->rq_scratch_folio)
 		folio_put(rqstp->rq_scratch_folio);
-	kfree(rqstp->rq_resp);
-	kfree(rqstp->rq_argp);
 	kfree(rqstp->rq_auth_data);
-	kfree_rcu(rqstp, rq_rcu_head);
+	call_rcu(&rqstp->rq_rcu_head, svc_rqst_free_rcu);
 }
 
 static struct svc_rqst *
-- 
2.53.0

