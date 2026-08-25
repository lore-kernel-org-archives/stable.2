Received: from mail-pg1-f170.google.com (mail-pg1-f170.google.com [209.85.215.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B40B22F8E87
	for <stable@vger.kernel.org>; Tue, 25 Aug 2026 02:12:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787623951; cv=none; b=idd5oYigwMWqqSslgti73eKtCFsqrUA7PRhjd+eicOMi+4wjpkcyLkAzc3bW9nAMejWpcOmvmXc99SqLBvWOCmwa5Ry6xmY3WWwdVKoNftFbuw1HwVRaxrNIIawD48nUdqVnFy4imBPi+F1FzJ69A9mSVjaPxynoYyFspBNLRs8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787623951; c=relaxed/simple;
	bh=umCgMUKPQPll6S43CofHLcyYoPkxfOBRKdMbZYySOTM=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=VKTNhD1sUFOVcvgD1u6qv5EPLRElLvrFuNx1NTYij07KZ3dmjIi5WHG3Q21t1rLZEcLhx4i3xcc6OT/pCtPvR/aE0H50/9f0dMQpu/tN1GlQNim/ITGVupRNa6hpipU50OTI+FJI1KN8jXDsDfjrY6OZ9e6VthV2v5fSz62RnpE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ful83ZpO; arc=none smtp.client-ip=209.85.215.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ful83ZpO"
Received: by mail-pg1-f170.google.com with SMTP id 41be03b00d2f7-c9d1fff21edso3454459a12.1
        for <stable@vger.kernel.org>; Mon, 24 Aug 2026 19:12:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1787623949; x=1788228749; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=DuFfc3mYGtCYXOj2mOxxwwBg8bUodS6/wtLWaXsVGqs=;
        b=ful83ZpO12cbUqyRo4o1fJbLdDzuLvz7iiueFvgSOT2WQi1X1qBTBv9hTMsCe5/xKD
         R+2W1p+85PZH/PPVRVl9MDThxP/RWiHB6KLpx6dwsN5cY0RK7scgCKjQd1aXFvCXcBA4
         unavskMoZ6VpbHOiWewV3dpbmgAVL6oz4vau5ZyLPLiEu6Qshj11TwNKBL2A4C9exRja
         ujVjcQA/YWdkwiaESjYABLCJN1/xC/Y+7bn4a6KBvX74Hwgf2MM7UxP7B+IRV5cAA4Kg
         5SYLX7SNTI5pgCaT3WKlXwIs3etdSQznQh6wtdfbbdcLhheYAHyVJdfH78RtZTmoEx2v
         FE5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787623949; x=1788228749;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=DuFfc3mYGtCYXOj2mOxxwwBg8bUodS6/wtLWaXsVGqs=;
        b=kjCnMX8e5Wl8odaeadKEjyeCjkkzrnBDB/inHWiIR5ELUrO9oYT5yloXUYyNJEVb4N
         mkQ/vFexXu/txSlD/h17J++WHQk4Vu/uyX2yLBiQUE4FSxlJUyfPgOu2+sSwUqRHM3YZ
         MoTJCkdDGwfNqIpXmU6Sz31awdobVaa9y19ILXheDMsSieNzjIfeeo1Rif7YQ6kQ0QWY
         kaZ06LY51xlFKPoy/O+xjYmhksa/dnG/z7f/071yoZPm5rL+U5MsLD4/xdkr3+SlCu6V
         BybwbsVmmselGYfxEjMNDwVjBtLFQWYVQlxckIiefsdW6ga0qCaB/x0WWZopG6yuWEuf
         HnHw==
X-Forwarded-Encrypted: i=1; AHgh+Rot5Pz2qDh2svNBuKsMgAnAsk3QQASLMqx8/37kbQYdJv3gnr4GyhUQVGnKIhIiqC6lkWOIWdw=@vger.kernel.org
X-Gm-Message-State: AFuF++n9fRP308Rji53rzD1IueiKY+FxWt3Cjc+yzBxndwTNvQrmOhlu
	wLl+gday9L0HdyHgbFzIQJHwunEAQKgLoDPKu5yZwBSaG3WqzF1FQX35
X-Gm-Gg: AR+sD10MPTUlwfdlvJPkxT4o4yUmg/BTUR8woSzbqzj7nEEAgqdaSTxnCFYYyh9gdOy
	75CRgeBMQ8v9JAu6NLUYEtKB2+B2JzdN4ZRNEYfq227gNmWQghpH1ojCRf8YFXJDjepzoj+XNuq
	a2HDSH3cKzVTkDU4qPjXtu1UMLyMcOVfnsnoz6PkKsqN3Sh+N78LkgGF3fK9NNKiFpXYDGCwFAc
	HFw372B98keJwkUNg/ntZ//w1eXW4J3ZX5sg32QkLDNjAtjW7v4f9KOhGvfd0lUD2IWAnIopDqY
	MpNW4R/+kqoOB8qwhbBrNX55ofDl6nlyoGUsWNCWXaF+Uh8XeBjMvR9ji67pRRk+5DdV9grp+5y
	gX/TWzAUgFvnkoduh8Tp2PetcWeeuHs54CLTY9+ZQQ2dHL7Z2YYgaPWWgzGiLL8Y+/hX1y5EyTm
	lJXCyGFQSntvaSWHvZNFeuFXoOy/iLd2MMtAc3tS/nL4VkBR4nv+GOZAx2yJHOUeqlFuQebdnvp
	LY2531b2UXmVDnRGszOS7nErA==
X-Received: by 2002:a17:90b:55cc:b0:37c:6910:5758 with SMTP id 98e67ed59e1d1-395c334042emr62141979a91.1.1787623949022;
        Mon, 24 Aug 2026 19:12:29 -0700 (PDT)
Received: from localhost.localdomain ([117.88.121.72])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-39645b7ff6dsm1706996a91.10.2026.08.24.19.12.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 24 Aug 2026 19:12:28 -0700 (PDT)
From: Aohan Mei <ljp1205831794@gmail.com>
To: netdev@vger.kernel.org
Cc: Allison Henderson <achender@kernel.org>,
	linux-rdma@vger.kernel.org,
	rds-devel@oss.oracle.com,
	linux-kernel@vger.kernel.org,
	Jason Xing <kerneljasonxing@gmail.com>,
	Aohan Mei <henrymei@tencent.com>,
	TencentOS Corvus AI <corvus@tencent.com>,
	stable@vger.kernel.org
Subject: [PATCH net v2] net: rds: fix uninitialized trans dereference in CM event handler
Date: Tue, 25 Aug 2026 10:12:23 +0800
Message-ID: <20260825021223.3483044-1-ljp1205831794@gmail.com>
X-Mailer: git-send-email 2.43.7
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Aohan Mei <henrymei@tencent.com>

rds_rdma_cm_event_handler_cmn() assigns trans only when the RDMA
device is an InfiniBand CA (RDMA_NODE_IB_CA).  On any other device
type, e.g. an iWARP RNIC such as siw, trans stays uninitialized, but
the event switch dereferences it: unconditionally in the
RDMA_CM_EVENT_CONNECT_REQUEST case via trans->cm_handle_connect(),
and (with a connection context) in the ROUTE_RESOLVED and
ESTABLISHED cases.

An RDS listener on an iWARP device therefore crashes the kernel as
soon as a connect request arrives: with CONFIG_INIT_STACK_ALL_ZERO
the wild load becomes a NULL dereference at offset 0xa0
(&trans->cm_handle_connect) in the iw_cm_wq workqueue.

GCC masks the bug in default builds by folding the uninitialized
load into &rds_ib_transport; Clang-built kernels take the real
uninitialized path and oops.

The iWARP transport was dropped long ago and IB is the only
transport left, so make that explicit: initialize trans to
&rds_ib_transport at declaration, drop the conditional assignment,
and reject events from non-IB devices before the event switch.

Fixes: dcdede0406d3 ("RDS: Drop stale iWARP RDMA transport")
Reported-by: TencentOS Corvus AI <corvus@tencent.com>
Cc: stable@vger.kernel.org
Assisted-by: CodeBuddy:Kimi-K3
Signed-off-by: Aohan Mei <henrymei@tencent.com>
---
v2:
- Enforce the IB transport directly instead of NULL-guarding trans,
  as suggested by Allison Henderson.
v1: https://lore.kernel.org/netdev/20260824111701.2979194-1-ljp1205831794@gmail.com
 net/rds/rdma_transport.c | 11 +++++++----
 1 file changed, 7 insertions(+), 4 deletions(-)

diff --git a/net/rds/rdma_transport.c b/net/rds/rdma_transport.c
index b15cf316b23a..2c5481f1fcb4 100644
--- a/net/rds/rdma_transport.c
+++ b/net/rds/rdma_transport.c
@@ -52,7 +52,7 @@ static int rds_rdma_cm_event_handler_cmn(struct rdma_cm_id *cm_id,
 {
 	/* this can be null in the listening path */
 	struct rds_connection *conn = cm_id->context;
-	struct rds_transport *trans;
+	struct rds_transport *trans = &rds_ib_transport;
 	int ret = 0;
 	int *err;
 	u8 len;
@@ -60,9 +60,6 @@ static int rds_rdma_cm_event_handler_cmn(struct rdma_cm_id *cm_id,
 	rdsdebug("conn %p id %p handling event %u (%s)\n", conn, cm_id,
 		 event->event, rdma_event_msg(event->event));
 
-	if (cm_id->device->node_type == RDMA_NODE_IB_CA)
-		trans = &rds_ib_transport;
-
 	/* Prevent shutdown from tearing down the connection
 	 * while we're executing. */
 	if (conn) {
@@ -80,6 +77,12 @@ static int rds_rdma_cm_event_handler_cmn(struct rdma_cm_id *cm_id,
 		}
 	}
 
+	/* Only the IB transport is supported. */
+	if (cm_id->device->node_type != RDMA_NODE_IB_CA) {
+		ret = 1;
+		goto out;
+	}
+
 	switch (event->event) {
 	case RDMA_CM_EVENT_CONNECT_REQUEST:
 		ret = trans->cm_handle_connect(cm_id, event, isv6);
-- 
2.43.7

