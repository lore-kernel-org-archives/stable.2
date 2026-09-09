Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2200C2E7F39
	for <stable@vger.kernel.org>; Wed,  9 Sep 2026 01:31:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788917480; cv=none; b=rMBcTzSjmMc0pJ0Xqt/F4kDpW6wcN+9bRY90w1lZcMH6mCagJIASaOC4nEEDPQ3JFmVMWBBQV1DGmve0OBfEEI4LeGIGHOOezMAOOFTpvT/vesse3N3goj5/M0LAD3RUAI4KfYiXHHtQVcDHQ6ozO8FhTGHAiMzTzi6YlUpENLE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788917480; c=relaxed/simple;
	bh=yw3Z6WqwcwJrbIGg3gqY//zFfhB7T0j4ay7A785jrzc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Kl995qqbfOjxfE7Ln9c8PL6tAgOzZqvq73agM6PZz4LuM0UeAw+Lr2buTccZgII2piux7te9vGHikmd4e6Xb0qKIxsmaJ7mf2CG1wio9LbaWcWZRY3NxJ7P0KD4PRhJH1ncodmlESqNsHLjFpcH1kZAy5J+BrO965UCn62pR2Yk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fpY9w3yH; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fpY9w3yH"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6EE921F00A3D;
	Wed,  9 Sep 2026 01:31:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788917479;
	bh=1KmDmzYRnuzo4s7KA3GT18q55gh2TIxuXkIQNYH6dmw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=fpY9w3yHpfAeE72ekwV+wH1jAR8/LvdlH2eM2oljovOAkbl3uJLn2k8dl0AjGINMe
	 HB+owGlDlG9ZRLEWvDAypZf/C8tUB8yo7bLjbD9xv0V26wOAACrtYCkZWdCV3yfYh4
	 mBJOa2GybqO8Xk2afCVDt5OsGqViEyTYjRv0NveKsbty9yqmtEdmxHtpOhEuSJPUr8
	 e+TVrabrv2Y824ax5E19LVaRAmzQ0tJpQGYz2mIjGO5yx+qWxpw5wgXJ2dthj+6y/Z
	 QVzYq4raO71w6XQ7fNBae2bmcHt29E+4YCyIUTTFZhTRhaP9P4M2Noi4KVcl6+n9Qh
	 rL6TnCYRjTobQ==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Chuck Lever <chuck.lever@oracle.com>,
	Jeff Layton <jlayton@kernel.org>,
	NeilBrown <neil@brown.name>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.6.y 2/4] sunrpc: Add a helper to derive maxpages from sv_max_mesg
Date: Tue,  8 Sep 2026 21:31:14 -0400
Message-ID: <20260909013116.888180-2-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260909013116.888180-1-sashal@kernel.org>
References: <2026090343-customize-gorgeous-909c@gregkh>
 <20260909013116.888180-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Chuck Lever <chuck.lever@oracle.com>

[ Upstream commit eff042ddf4b9587fa7394d502b93e06ec6015177 ]

This page count is to be used to allocate various arrays of pages
and bio_vecs, replacing the fixed RPCSVC_MAXPAGES value.

The documenting comment is somewhat stale -- of course NFSv4
COMPOUND procedures may have multiple payloads.

Reviewed-by: Jeff Layton <jlayton@kernel.org>
Reviewed-by: NeilBrown <neil@brown.name>
Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
Stable-dep-of: 9808eb765666 ("svcrdma: Reject Write/Reply chunks with segcount 0")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 include/linux/sunrpc/svc.h | 17 +++++++++++++++++
 1 file changed, 17 insertions(+)

diff --git a/include/linux/sunrpc/svc.h b/include/linux/sunrpc/svc.h
index 3d8b215f32d5b..a25371ab11c97 100644
--- a/include/linux/sunrpc/svc.h
+++ b/include/linux/sunrpc/svc.h
@@ -180,6 +180,23 @@ extern u32 svc_max_payload(const struct svc_rqst *rqstp);
 #define RPCSVC_MAXPAGES		((RPCSVC_MAXPAYLOAD+PAGE_SIZE-1)/PAGE_SIZE \
 				+ 2 + 1)
 
+/**
+ * svc_serv_maxpages - maximum count of pages needed for one RPC message
+ * @serv: RPC service context
+ *
+ * Returns a count of pages or vectors that can hold the maximum
+ * size RPC message for @serv.
+ *
+ * Each request/reply pair can have at most one "payload", plus two
+ * pages, one for the request, and one for the reply.
+ * nfsd_splice_actor() might need an extra page when a READ payload
+ * is not page-aligned.
+ */
+static inline unsigned long svc_serv_maxpages(const struct svc_serv *serv)
+{
+	return DIV_ROUND_UP(serv->sv_max_mesg, PAGE_SIZE) + 2 + 1;
+}
+
 /*
  * The context of a single thread, including the request currently being
  * processed.
-- 
2.53.0

