Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2CC3F3191A5
	for <stable@vger.kernel.org>; Sat, 25 Jul 2026 14:12:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784988748; cv=none; b=lA6T/pyiCU9Juk2+LmrMmH/VxQebsdzhRxiSj8bIApjBqHokl8n2fZSMGSNnaR11H5cn2v6NLqPR7oAp7JJic1PEUyAQntI4HjTO/SYjeQHWdnSF++VsojkUk7/9D3tKe/5bZsadgCq5yXQFeFzKmCeHjEHme/9UjUWpapfQhUQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784988748; c=relaxed/simple;
	bh=9/j2SXkcOpT7KpJ1lb7dP55AOgzIzRf8vMdQHjxk4GQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=IwGxp1lVWQ7Zvdufa1jdD5/ttrfqmvVI1TqsC3Hr+4r986MkZ3R+yE+fMDSsRRgQjLI9zOvLxueMU8XXw3vpmhRgOnzR9IRHbRQggfpiybXOjN/lG6o82WYMrnPvXTcSo+v7WtLP35790g57uV1LaR14Anh/VjNxHXqYeA8NZa8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=dWdXKY7C; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="dWdXKY7C"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 462C21F00A3D;
	Sat, 25 Jul 2026 14:12:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784988746;
	bh=Qr1rCIJSfF77T/unj+rKh+s6LrPlHY7i4e1ePE3hdlY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=dWdXKY7CJ5erk2c1hmBbbB8jMgGTqjFLm45474nNYwUjkCaYjy/OZMD+FyckXTysj
	 vIDSggZajYr1oe+5i3Du3Ct3lLb0f+RPUnY/CpIqaymzUdqZC9GruxbLFQb24kGwbe
	 icDsKKgQ5odECH2F8V6teF95zqMr19E2F2dX4Fth5GKHL4fbPRqNKJiYa8AxtWFGAF
	 QgGss5ujMsBOu8U5THI43zvzVmXlXpAU3/BRquU4HVqXglWWQiiX2SVCVxu53I+71I
	 egxWQ4h3e+5eK0jzSTRVkleCR+iiDLiO3F11W8VjwdVPjnfFqx4YEDvtJxMNfCNlHO
	 HXL+5bP3uxggw==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Michael Bommarito <michael.bommarito@gmail.com>,
	Mika Westerberg <mika.westerberg@linux.intel.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 7.1.y 4/4] thunderbolt: Prevent XDomain delayed work use-after-free on disconnect
Date: Sat, 25 Jul 2026 10:12:22 -0400
Message-ID: <20260725141222.3814514-4-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260725141222.3814514-1-sashal@kernel.org>
References: <2026072059-tumbling-reflux-fc14@gregkh>
 <20260725141222.3814514-1-sashal@kernel.org>
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
index 1de94b33fc3a59..628f18c264a215 100644
--- a/drivers/thunderbolt/xdomain.c
+++ b/drivers/thunderbolt/xdomain.c
@@ -909,6 +909,19 @@ void tb_unregister_service_driver(struct tb_service_driver *drv)
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
@@ -2500,19 +2513,6 @@ bool tb_xdomain_handle_request(struct tb *tb, enum tb_cfg_pkg_type type,
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

