Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 863DF1F16B
	for <stable@vger.kernel.org>; Wed,  9 Sep 2026 00:25:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788913517; cv=none; b=cPW6E00e7yiV2a+RmVwJvsULLuyXGc9OCnJif5Gls7UntiPQIVH4m8P6HX8tjq+saQt4ZsHTLDGDtD3dqAxEEMGEwaiU06Nbiq18zthuKHVNa6eiscG00LVpprvvw5V2KnlKxsbiPbig/JdjdU877vCqMFYMJO2xzGwq8rKv1XM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788913517; c=relaxed/simple;
	bh=9mAbltwDzlJ/HsbNLG7lQjY8uvsV6iXaOIHmSRNPXp4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=kvdXTWh13mrM+1oRfSAC+Wny8JSppTqP3eAHNwrsGRsxq6t34mYlNIcJUEIZRaUr1beuVrqxoJEZFXbU8t7LVri6Jg+Xd5ygrMvg1a9oay/LYck4w1Eq9Nhhtw6D8PQCw706eUJKl9rnL260sOxhn+wz+axudSrFGzqAWGUljf8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=CBVcL5FT; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="CBVcL5FT"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EC6A01F00AC4;
	Wed,  9 Sep 2026 00:25:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788913516;
	bh=StQHIZuTTRGjwmwlUHfeOq802Kd4s6RheoLI76a7ImE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=CBVcL5FTe+Mm0AEEfc+CpiHmqNCBw7TFAe+SDaQ+n4C6pJSgyb/fexnQNgdIkZHsQ
	 ZmzP9jryV4kW8fJ5MOM2YEtCB0Xl7MfVx/a8BlLLdyvqfSj5+fnqpVNEZ6aYzruG/n
	 2dlVHqNs1BFVFiwxoTIUGpoOetgLIENmxrKrm3g25eJiHhFdvoLcSwj1pJiYAcqv3b
	 2qj0KKmgcmGMI+I8n6ZLVi+qS3lC4aRWSs3xSyxYyBAL1QYcPVJNmV4xJd/wzUBWYz
	 mkpO6RfmcxS25xLh4k2e8sav3YxLymdoyygTAPU09ubdb6hQ5atKQjAW+ZttQLk5TI
	 ComaA57cZzZew==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Jeff Layton <jlayton@kernel.org>,
	Chuck Lever <cel@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.1.y 5/5] sunrpc: defer rq_argp and rq_resp free until after RCU grace period
Date: Tue,  8 Sep 2026 20:25:11 -0400
Message-ID: <20260909002511.725380-5-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260909002511.725380-1-sashal@kernel.org>
References: <2026090350-comment-projector-6988@gregkh>
 <20260909002511.725380-1-sashal@kernel.org>
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
index 3fe7152ee8bf5..c3d18ff3ce296 100644
--- a/net/sunrpc/svc.c
+++ b/net/sunrpc/svc.c
@@ -631,16 +631,23 @@ svc_release_buffer(struct svc_rqst *rqstp)
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

