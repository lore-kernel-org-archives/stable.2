Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 262B22609FD
	for <stable@vger.kernel.org>; Wed,  9 Sep 2026 00:25:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788913538; cv=none; b=cPhFlNoQTpCAbYDGZGcSowYVezOwMVVVEXXB84NTJKp2WeTS7n9CEeeCWkNk/VkSkKFIBnbiMg7rQnX94QTVIOdISvq/8pqvwWtpIfgisugVYZkR818VeaYH4bJRvNIl6XCJ0LG0lv/yAVP6JC1EeZjDi2WqS/fEZ1re39S+3TI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788913538; c=relaxed/simple;
	bh=9mAbltwDzlJ/HsbNLG7lQjY8uvsV6iXaOIHmSRNPXp4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=XKX0scnpGpgmjMsJUpYJeGT7za9NKa4v+0NAxmkyqnfM1aBRSHh4X2jl43x5FV1ac6JAzRWqVu58tb70plLey7ve2HASDvay0CPo5NIXoOgXu8vcrwqZ/Tj3qbR/g3osqL2tMdRVHfEQnDgrWxW1+tDe600jVrvYQguwc+BIqYA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=GT/KMPNB; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="GT/KMPNB"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 853301F00A3A;
	Wed,  9 Sep 2026 00:25:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788913537;
	bh=StQHIZuTTRGjwmwlUHfeOq802Kd4s6RheoLI76a7ImE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=GT/KMPNBopjJWZcsE9rUOEkYdGqpubzHR+BK1O5xCMLV+EpeNltOEumdGZ/NeRb5E
	 EUnSzwve3p0m//6U1NDo/5I6H29dLUbtQJo3C8l0FHBo2e+LkIE0NZ+U14+OeIByro
	 ZSs+88EpM+Z7foSLxAP4ELr8DHEplFXrB+JFGI6slHGS4HNVlsmW6qb6ARCSjN/i1H
	 2a+pILdHgqdyYLSod3F0hK1Eu8bKgauilGFfmBJpUnF19Wez88mSa4RNy8Y2h+4056
	 2D6QIZfP2vsnO0JOkYQZ8ELKb/fchPP3c2wJ9bJ63ZTiX/4F8KLXNCnjg8B91nf7it
	 s8TiRDn1stx3w==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Jeff Layton <jlayton@kernel.org>,
	Chuck Lever <cel@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.1.y 5/5] sunrpc: defer rq_argp and rq_resp free until after RCU grace period
Date: Tue,  8 Sep 2026 20:25:32 -0400
Message-ID: <20260909002532.729106-5-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260909002532.729106-1-sashal@kernel.org>
References: <2026090350-comment-projector-6988@gregkh>
 <20260909002532.729106-1-sashal@kernel.org>
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

