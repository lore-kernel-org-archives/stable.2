Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1C7BE2E764D
	for <stable@vger.kernel.org>; Wed,  9 Sep 2026 01:31:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788917485; cv=none; b=L6DFixfNeKpUdA6KL8sspPZxaLqv5c3Ojt8mfv7EFWjTyk/Oc+zDUFMRFi+h2WbVSw3haKPL96WLEZtCCtOkotM3UJYbTWToW7+udwlQZBf6yh79uWvRK/UdVT758PJZDOgaEYCeYsDrPkrVfVK08bHq1/ubFbjGAn7Zu4B1bn8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788917485; c=relaxed/simple;
	bh=ZNRdlUH8osA7tbBhC1I8llgh7grFOqaulEb0n3wcPDk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=TZbS6FwTC70CiJnb+TaAv9XBNTb77QJBEENwIAWUaBXgM88W0bfFhR5JlEtZzlYwdDbjI64k5r5OyPeqbTenZecuGUHz2o/kSZuVSPtE9Nwy3ZWpD+dl5OJ1KQTKyypd90Dt63y5XQqvVUTlQW2LaKj9Hwf4jpG+x9whdIG7x4Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=KdVhB90N; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="KdVhB90N"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 88EAB1F00A3D;
	Wed,  9 Sep 2026 01:31:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788917484;
	bh=HaSs3hEePIh2PgmtTHXi/AyHv3fFkBz1hCyrQ19FGR8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=KdVhB90NyqybJDQi/HQ+gsZOzqlDlLJRGtWCzGG1T3FRQF2vdsSdNfTyr3+hnysKL
	 4h9vcie4yzxWfbUdVUkd4osdFX0Q/ssHzTSAzR/MRQLDxCUgKTxcL1Cy+ayYZzFc8/
	 kLDxD9e6rS0CxC5x1kyWFj5dJsToiz26vrK+3vagjbg+JmrQLTynQURrxaY6oZr++V
	 k6un+PSUEa/v4Sls3eRUFk+a4bAkVyxUwKgzhE9Z1cK0E9hdzg+GZ3x77lXLbf2Tms
	 x1Wo7+WaBS5PmlPNljc2D4tQ0j/DolhGbe3iVY1GyyfBXE+MC2jQPD89afUBFAxGRh
	 OWWjZjH5rF5xA==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Jeff Layton <jlayton@kernel.org>,
	Chuck Lever <cel@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.15.y 2/2] sunrpc: defer rq_argp and rq_resp free until after RCU grace period
Date: Tue,  8 Sep 2026 21:31:21 -0400
Message-ID: <20260909013121.888599-2-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260909013121.888599-1-sashal@kernel.org>
References: <2026090350-lip-cognitive-6180@gregkh>
 <20260909013121.888599-1-sashal@kernel.org>
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
index 4fc4a7f426a17..8dad2d6b6d7cb 100644
--- a/net/sunrpc/svc.c
+++ b/net/sunrpc/svc.c
@@ -632,16 +632,23 @@ svc_release_buffer(struct svc_rqst *rqstp)
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

