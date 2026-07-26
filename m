Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C677F3BB671
	for <stable@vger.kernel.org>; Sun, 26 Jul 2026 14:00:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785074405; cv=none; b=Qm3FjEf32T0whEiic0ngsZenm2qMFmgT/cculEXakvf7rb+KhZ1d067C3FnCPYbE5jJ+yjpzyt5FYo+JJxHQDyAh8FYNTBpZTlpaxZb/Mby3YIIw7Zdl4sxqPaov1XrupZrb0sXWEqb4QlLySdLMWbdajZEyQtK5RQKaAMOAHiA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785074405; c=relaxed/simple;
	bh=W2C5kAuAxeyLeqy3DKA2QQLDwX1IN2oBPbPkI3GBxlk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=UVLMClFc6RyX4AWuxzBqW1brNYkZBHqUDhQReqC0JgyvbRkdK9yr9VQW2ricUUuFzgChW7aUxj+XgM6Jot1UoZpjPBhnKHfcxzsf4jKWJeEPkrmN/I4wS0kmlUSuWYvMjarRjSRcY1ys98gf1f8pSeSE0sAhirgEWfw1blVCCXI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ol2ArfjE; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ol2ArfjE"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 959801F00A3A;
	Sun, 26 Jul 2026 14:00:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785074404;
	bh=9TA8f2t78oTS3I2notv1s2D/5x23qDxNQtPIqb9DaWM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=ol2ArfjE90OFRhgkrj/POhjsxZrd1EU0P3/ngs6/VsCc3sjKT6XMwvG7eeaS0CgCp
	 1sViXq1k1ljdWENSlgpTCbc6z+B56pT9ARQCW+SQfMI6H7OvSMTXiaWPn5aImZB8FX
	 yBooC+BQUXW87Pvi+9VrciiAjtfRAF7GDhU3NYchwxbDOdLxXCNGRtiVZQDry1U54F
	 Qpaqu5hxNN8GfQSwaVVEeyq4wTA0lte+tPANvc0he+/gyequlnKhwNMSN8sbP9RRSa
	 E1wyX6ew4MSTfnGZZMGd1yx4S2G5rp7vk8fag2eb4Vm87+ya9f7ZnhHhLOt2YoIE3h
	 gk9XeMYOpltiw==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Michael Bommarito <michael.bommarito@gmail.com>,
	Mika Westerberg <mika.westerberg@linux.intel.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.6.y 7/7] thunderbolt: Prevent XDomain delayed work use-after-free on disconnect
Date: Sun, 26 Jul 2026 09:59:55 -0400
Message-ID: <20260726135955.668115-7-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260726135955.668115-1-sashal@kernel.org>
References: <2026072000-womb-upturned-7ecf@gregkh>
 <20260726135955.668115-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Michael Bommarito <michael.bommarito@gmail.com>

[ Upstream commit 2c5d2d3c3f70cde2565d7b279b544893a2035842 ]

tb_xdp_handle_request() runs on system_wq and queues
xd->state_work via queue_delayed_work() in three request handlers:
PROPERTIES_CHANGED_REQUEST, UUID_REQUEST (via start_handshake),
and LINK_STATE_CHANGE_REQUEST.  Similarly, update_xdomain() queues
xd->properties_changed_work when local properties change.

Concurrently, tb_xdomain_remove() calls stop_handshake() which does
cancel_delayed_work_sync() on both delayed works.  Later,
tb_xdomain_unregister() calls device_unregister() which eventually
frees the xdomain.  Since commit 559c1e1e0134 ("thunderbolt: Run
tb_xdp_handle_request() in system workqueue") moved the request
handler off tb->wq, the handler and the remove path are no longer
serialized.  If queue_delayed_work() executes after
cancel_delayed_work_sync() but before the xdomain is freed, the
delayed work fires on a freed object.

Add xd->removing that tb_xdomain_remove() sets under xd->lock
before calling stop_handshake().  Each external queue site holds
the same lock and checks removing before calling
queue_delayed_work().  This provides the mutual exclusion needed:
either the queue site acquires the lock first and queues work that
the subsequent cancel will see, or the remove path acquires the
lock first and the queue site observes removing == true and skips
the queue.

Fixes: 559c1e1e0134 ("thunderbolt: Run tb_xdp_handle_request() in system workqueue")
Cc: stable@vger.kernel.org
Assisted-by: Claude:claude-opus-4-7
Signed-off-by: Michael Bommarito <michael.bommarito@gmail.com>
Signed-off-by: Mika Westerberg <mika.westerberg@linux.intel.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/thunderbolt/xdomain.c | 26 +++++++++++++-------------
 1 file changed, 13 insertions(+), 13 deletions(-)

diff --git a/drivers/thunderbolt/xdomain.c b/drivers/thunderbolt/xdomain.c
index f07e2536b51dc0..8055b6a952fdc7 100644
--- a/drivers/thunderbolt/xdomain.c
+++ b/drivers/thunderbolt/xdomain.c
@@ -905,6 +905,19 @@ void tb_unregister_service_driver(struct tb_service_driver *drv)
 }
 EXPORT_SYMBOL_GPL(tb_unregister_service_driver);
 
+static int update_xdomain(struct device *dev, void *data)
+{
+	struct tb_xdomain *xd;
+
+	xd = tb_to_xdomain(dev);
+	if (xd) {
+		queue_delayed_work(xd->tb->wq, &xd->properties_changed_work,
+				   msecs_to_jiffies(50));
+	}
+
+	return 0;
+}
+
 static ssize_t key_show(struct device *dev, struct device_attribute *attr,
 			char *buf)
 {
@@ -2475,19 +2488,6 @@ bool tb_xdomain_handle_request(struct tb *tb, enum tb_cfg_pkg_type type,
 	return ret > 0;
 }
 
-static int update_xdomain(struct device *dev, void *data)
-{
-	struct tb_xdomain *xd;
-
-	xd = tb_to_xdomain(dev);
-	if (xd) {
-		queue_delayed_work(xd->tb->wq, &xd->properties_changed_work,
-				   msecs_to_jiffies(50));
-	}
-
-	return 0;
-}
-
 static void update_all_xdomains(void)
 {
 	bus_for_each_dev(&tb_bus_type, NULL, NULL, update_xdomain);
-- 
2.53.0

