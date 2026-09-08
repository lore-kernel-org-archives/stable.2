Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0EB6F4349B8
	for <stable@vger.kernel.org>; Tue,  8 Sep 2026 19:28:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788895718; cv=none; b=Cw4xS7vdQkorIrH0Q76gCK4SU3Ir2l++WvxdV8MSzcXv5JJ2/N6glNVAXKmQUVrww1m41YKvmJWoQpwnYTyAv2mzt+44s+5COMdmFccS4QDfOVHdhcWDxNH3fAin1JlYodQZd0ZFmJINTH2oEdOskyEaIMixK2XTVMPybyBFBhA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788895718; c=relaxed/simple;
	bh=VNRBVYOnpx9cljK9DHxeVw8vzhHrrmL6xivkq1qmNE0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=OyOCNoKyfhG53hhNG1wPI8QScaNo6AlqI5Db5EqEiBLH6i7A/FkxKaAQ/BPjDzqtz/1ZjVqfpCoKC5opcJYiakmrxWxOuIZ8q+N+YA/WvampbbToWgD/NfpgIFkUXl8ys4E8DD5lHKtjyx98zskl4UFA40KpE5DLODbqTNt5iaI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=VHMg8cgf; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="VHMg8cgf"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2ED5A1F00A3F;
	Tue,  8 Sep 2026 19:28:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788895712;
	bh=Ln1bAmIGEgnMBReLJra55xmRqu4DivHc2gLTDcDn4q4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=VHMg8cgfsdSPR6H0eAyRt5Bcibx9XR3o6RgwUDA0Do2INp6uQvQnjrC7tqAbAUr1W
	 ZVq6MqS6D9X18tj8erPnloKlun5s0CgV2fg5MSOej6dhXRdIFfWHkwx9LeX0FB//Z5
	 WXFCud/TgNBHNM7d6SlfEaAzSTN5decW+2FwniDMwXoYtdbwOrBUspTydZohchqKJ8
	 2k1VC0639r9wv/HlfIF9i1MfXmHpEFo7l5by9BvnfSoesu0Ie4n7bNTWHr3Cqs4Bgx
	 sM/FHa3yKa1ASuBQKdB1M0/tuJVwFmT2dWHaN55eLifIn4eAphI4hi3rK/zyFk04z7
	 Q8M83XSV4nx5g==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Jeff Layton <jlayton@kernel.org>,
	Chuck Lever <cel@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.12.y 3/3] sunrpc: defer rq_argp and rq_resp free until after RCU grace period
Date: Tue,  8 Sep 2026 15:28:28 -0400
Message-ID: <20260908192828.296500-3-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260908192828.296500-1-sashal@kernel.org>
References: <2026090349-throwing-hardware-8a25@gregkh>
 <20260908192828.296500-1-sashal@kernel.org>
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
index 553ec553d3baf..194e2bc9faa59 100644
--- a/net/sunrpc/svc.c
+++ b/net/sunrpc/svc.c
@@ -729,6 +729,15 @@ svc_release_buffer(struct svc_rqst *rqstp)
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
@@ -736,10 +745,8 @@ svc_rqst_free(struct svc_rqst *rqstp)
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

