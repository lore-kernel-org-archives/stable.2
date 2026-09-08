Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 76D694B488E
	for <stable@vger.kernel.org>; Tue,  8 Sep 2026 22:36:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788907022; cv=none; b=YyXnARF2Nf6VnJ32eRXBP76iSG9J/j09/Ts1+cKL5RNv7oc9ZW825toCkWN7XWO+6Q0U1B9/cd4RSXYxm9lO0k9dcBHE0lIJ3PtcrUc5gfoEgNLY/VF+ujSLbvFEI1p1Nvuvnhky0PBvLTx1VUMZDXquH1kaBMbY24N4lSxJrt0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788907022; c=relaxed/simple;
	bh=jaoaGgnFupWl/bOqsIj1HjGwvW0euWWc3X3zFYsylbQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=MFkoiXV+G8GPUIRT1bULQ84eK3Em7iWnIk/vyoL4+8iolc+Kyk2kf+1h5UK7wYT5PmePG+fiGdFP94yZ/WFYMSiXuaiXdswhkTC83M3ekrp53HCDQux8upEQuyf1DN8bsvuSoKBUSKuN6H/A5rYtv4hSmphmMnJZgcKtVT85ErM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ouiCb9Bd; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ouiCb9Bd"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A54FE1F00A3E;
	Tue,  8 Sep 2026 22:36:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788907017;
	bh=9edE442dsGadAl7oWAflMMCvz8YLqP2Eqj0wlH263mU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=ouiCb9BdIE/xl/nPTfRbrBFF/vfm/G/Etm80qfHhLImlC587gERpJYYC4NsRA3zcl
	 VABlX6UUhjTx8+3DQlepV6oJhU6jpORAIxL8QS3327g4/7lg87GfguZctJb/Qe4H/t
	 DR5hXVNwTDTrh2GBR4aqLV1w1Zr7r+j+feT8XwuF0yz32SnPu0l7yG15vmGpaxbN0X
	 L3rAx2Vat6DmsJtsJb/11irwjMIYxIhYktECZJIZPTJRocKAhLg+imf30RI2L9X+tx
	 9ODtxhSGjoo57VreETQx2ysn/np6h+ykgGJjOlr2RXH30SjaImlKqHnIqux7Wjcbix
	 mdAc9a4kg3Rgw==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Jeff Layton <jlayton@kernel.org>,
	Chuck Lever <cel@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.6.y 7/7] sunrpc: defer rq_argp and rq_resp free until after RCU grace period
Date: Tue,  8 Sep 2026 18:36:50 -0400
Message-ID: <20260908223651.501880-7-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260908223651.501880-1-sashal@kernel.org>
References: <2026090350-breeze-repugnant-70de@gregkh>
 <20260908223651.501880-1-sashal@kernel.org>
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
index bfd685dfc70e9..b6c4287077fbd 100644
--- a/net/sunrpc/svc.c
+++ b/net/sunrpc/svc.c
@@ -677,6 +677,15 @@ svc_release_buffer(struct svc_rqst *rqstp)
 			put_page(rqstp->rq_pages[i]);
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
@@ -684,10 +693,8 @@ svc_rqst_free(struct svc_rqst *rqstp)
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

