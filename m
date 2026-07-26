Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3B7333AB5C3
	for <stable@vger.kernel.org>; Sun, 26 Jul 2026 12:00:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785067255; cv=none; b=Zg+P+dsscnOfN42t5iJkZAJ5PY5uJvgjx4U2uSLaR816CxkNuxx83tj8iDGGtvLvDJKMSteov6yj3Tqhn++Y2WXCAlaz7XkspnYySTqmAdfP8qpXrPkZHiZPEbXTMyuJOqH0KIhS7lRvXNCzPjg3geTE1951y5gnaUW/0z8N10I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785067255; c=relaxed/simple;
	bh=5+DFFAor53VkLhsAANRI+WhY5IBCX8omkQOmdJ8dN4Q=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=iABMsG32EO0/3VkvpBxABRylElfP0YyOOf11nYdD9L1aDx1XiQ2rLNfJGFhLzFWkeTQykLpHW3il4+V4nCrnJ4wP5ou1ZiLEEP3mDRgradml6BL8kzQQf4+qhM/mttyi80NDF7+NI1tfePkX7mpOdu99Aa0QsyYymDxLozv9bjU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=MZ666Vyh; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="MZ666Vyh"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7F5D21F00A3F;
	Sun, 26 Jul 2026 12:00:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785067253;
	bh=XBYiUJDASjmPD0BtRnQxLzU+c4vU+jLD6Zsu8k1IeOc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=MZ666Vyh/0EIBqYC4DuTFwYlj7qgeW82k7vrd14o82eWQFlbxPC57jFpuyGAC6m6F
	 +udwB56qKJS0AbOkZcTkjP09BJFBbNsuDF6FWBv0pfe98YqikqbXVuTBA02LZRp0Uw
	 8f1ib1glExKvyyGZ4KJpwJRterhv54c3AD3EYefeW68hVWC9eIn1dxsXm+58E5eiDe
	 asqvt/686eKKOvfwo+D0/V3xsIOdnkTsGlTGsz7mK7BdRmKnmbVRWur+jttruR5AUw
	 IU1cSiTMfysGJbtkt7CjeKme8NKoHgJZpP/lzLXrqZZqj90YHWNvtVc5Dx6jgkcPzH
	 Cf3dPQfqiqE6g==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Mika Westerberg <mika.westerberg@linux.intel.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.18.y 3/4] thunderbolt: Remove XDomain from the bus without holding tb->lock
Date: Sun, 26 Jul 2026 08:00:49 -0400
Message-ID: <20260726120050.4138299-3-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260726120050.4138299-1-sashal@kernel.org>
References: <2026072000-karma-payable-51b3@gregkh>
 <20260726120050.4138299-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Mika Westerberg <mika.westerberg@linux.intel.com>

[ Upstream commit a8937f35cf39c39c64325aa84d0463d866850857 ]

Currently we call device_unregister() for services and the XDomain
itself with tb->lock held. This prevents the service drivers from
calling any functions that may take it. For this reason separate
removing the XDomain from the topology data structures (where we need
the lock) from unregistering the device from the bus (where remove
callbacks of the drivers are being called).

Signed-off-by: Mika Westerberg <mika.westerberg@linux.intel.com>
Stable-dep-of: 2c5d2d3c3f70 ("thunderbolt: Prevent XDomain delayed work use-after-free on disconnect")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/thunderbolt/debugfs.c |  2 ++
 drivers/thunderbolt/domain.c  | 30 ++++++++++++++++++
 drivers/thunderbolt/icm.c     |  5 +++
 drivers/thunderbolt/switch.c  | 14 +++++++++
 drivers/thunderbolt/tb.c      | 59 +++++++++++++++++------------------
 drivers/thunderbolt/tb.h      |  2 ++
 drivers/thunderbolt/xdomain.c | 53 +++++++++++++++++++------------
 7 files changed, 115 insertions(+), 50 deletions(-)

diff --git a/drivers/thunderbolt/debugfs.c b/drivers/thunderbolt/debugfs.c
index 71c9833563c709..2968965c76d3f6 100644
--- a/drivers/thunderbolt/debugfs.c
+++ b/drivers/thunderbolt/debugfs.c
@@ -1786,6 +1786,8 @@ static void margining_port_remove(struct tb_port *port)
 
 	if (!port->usb4)
 		return;
+	if (!port->usb4->margining)
+		return;
 
 	snprintf(dir_name, sizeof(dir_name), "port%d", port->port);
 	parent = debugfs_lookup(dir_name, port->sw->debugfs_dir);
diff --git a/drivers/thunderbolt/domain.c b/drivers/thunderbolt/domain.c
index 83defc915d3381..7210415cd269df 100644
--- a/drivers/thunderbolt/domain.c
+++ b/drivers/thunderbolt/domain.c
@@ -850,6 +850,36 @@ int tb_domain_disconnect_all_paths(struct tb *tb)
 	return bus_for_each_dev(&tb_bus_type, NULL, tb, disconnect_xdomain);
 }
 
+struct unregister_context {
+	const struct tb *tb;
+	int n;
+};
+
+static int unregister_unplugged_xdomain(struct device *dev, void *data)
+{
+	struct unregister_context *ctx = data;
+	struct tb_xdomain *xd;
+
+	xd = tb_to_xdomain(dev);
+	if (xd && xd->tb == ctx->tb && xd->is_unplugged) {
+		tb_xdomain_unregister(xd);
+		ctx->n++;
+	}
+	return 0;
+}
+
+int tb_domain_unregister_unplugged_xdomains(struct tb *tb)
+{
+	struct unregister_context ctx;
+
+	ctx.tb = tb_domain_get(tb);
+	ctx.n = 0;
+	bus_for_each_dev(&tb_bus_type, NULL, &ctx, unregister_unplugged_xdomain);
+	tb_domain_put(tb);
+
+	return ctx.n;
+}
+
 int tb_domain_init(void)
 {
 	int ret;
diff --git a/drivers/thunderbolt/icm.c b/drivers/thunderbolt/icm.c
index f213d9174dc574..0a17b2d0b6e8d3 100644
--- a/drivers/thunderbolt/icm.c
+++ b/drivers/thunderbolt/icm.c
@@ -738,6 +738,7 @@ static void remove_xdomain(struct tb_xdomain *xd)
 
 	sw = tb_to_switch(xd->dev.parent);
 	tb_port_at(xd->route, sw)->xdomain = NULL;
+	xd->is_unplugged = true;
 	tb_xdomain_remove(xd);
 }
 
@@ -1762,6 +1763,8 @@ static void icm_handle_notification(struct work_struct *work)
 
 	kfree(n->pkg);
 	kfree(n);
+
+	tb_domain_unregister_unplugged_xdomains(tb);
 }
 
 static void icm_handle_event(struct tb *tb, enum tb_cfg_pkg_type type,
@@ -2112,6 +2115,8 @@ static void icm_rescan_work(struct work_struct *work)
 	if (tb->root_switch)
 		icm_free_unplugged_children(tb->root_switch);
 	mutex_unlock(&tb->lock);
+
+	tb_domain_unregister_unplugged_xdomains(tb);
 }
 
 static void icm_complete(struct tb *tb)
diff --git a/drivers/thunderbolt/switch.c b/drivers/thunderbolt/switch.c
index 0e07904aa73b45..b628ca702717e3 100644
--- a/drivers/thunderbolt/switch.c
+++ b/drivers/thunderbolt/switch.c
@@ -3603,6 +3603,20 @@ int tb_switch_resume(struct tb_switch *sw, bool runtime)
 				tb_port_warn(port,
 					     "lost during suspend, disconnecting\n");
 				tb_sw_set_unplugged(port->remote->sw);
+			} else if (port->xdomain) {
+				/*
+				 * If the user replaced the XDomain with
+				 * another router, this will succeed in
+				 * which case we must remove the XDomain
+				 * before adding the new router.
+				 */
+				err = tb_cfg_get_upstream_port(sw->tb->ctl,
+							       port->xdomain->route);
+				if (err > 0) {
+					tb_port_warn(port,
+						     "XDomain was disconnected\n");
+					port->xdomain->is_unplugged = true;
+				}
 			}
 		}
 	}
diff --git a/drivers/thunderbolt/tb.c b/drivers/thunderbolt/tb.c
index 4a94cb406bdfb1..fbf9998885b08e 100644
--- a/drivers/thunderbolt/tb.c
+++ b/drivers/thunderbolt/tb.c
@@ -2524,6 +2524,8 @@ static void tb_handle_hotplug(struct work_struct *work)
 out:
 	mutex_unlock(&tb->lock);
 
+	tb_domain_unregister_unplugged_xdomains(tb);
+
 	pm_runtime_mark_last_busy(&tb->dev);
 	pm_runtime_put_autosuspend(&tb->dev);
 
@@ -3110,6 +3112,24 @@ static void tb_restore_children(struct tb_switch *sw)
 	}
 }
 
+static void tb_free_unplugged_xdomains(struct tb_switch *sw)
+{
+	struct tb_port *port;
+
+	tb_switch_for_each_port(sw, port) {
+		if (tb_is_upstream_port(port))
+			continue;
+		if (port->xdomain && port->xdomain->is_unplugged) {
+			tb_retimer_remove_all(port);
+			tb_xdomain_remove(port->xdomain);
+			tb_port_unconfigure_xdomain(port);
+			port->xdomain = NULL;
+		} else if (port->remote) {
+			tb_free_unplugged_xdomains(port->remote->sw);
+		}
+	}
+}
+
 static int tb_resume_noirq(struct tb *tb)
 {
 	struct tb_cm *tcm = tb_priv(tb);
@@ -3129,6 +3149,7 @@ static int tb_resume_noirq(struct tb *tb)
 	tb_switch_resume(tb->root_switch, false);
 	tb_free_invalid_tunnels(tb);
 	tb_free_unplugged_children(tb->root_switch);
+	tb_free_unplugged_xdomains(tb->root_switch);
 	tb_restore_children(tb->root_switch);
 
 	/*
@@ -3171,28 +3192,6 @@ static int tb_resume_noirq(struct tb *tb)
 	return 0;
 }
 
-static int tb_free_unplugged_xdomains(struct tb_switch *sw)
-{
-	struct tb_port *port;
-	int ret = 0;
-
-	tb_switch_for_each_port(sw, port) {
-		if (tb_is_upstream_port(port))
-			continue;
-		if (port->xdomain && port->xdomain->is_unplugged) {
-			tb_retimer_remove_all(port);
-			tb_xdomain_remove(port->xdomain);
-			tb_port_unconfigure_xdomain(port);
-			port->xdomain = NULL;
-			ret++;
-		} else if (port->remote) {
-			ret += tb_free_unplugged_xdomains(port->remote->sw);
-		}
-	}
-
-	return ret;
-}
-
 static int tb_freeze_noirq(struct tb *tb)
 {
 	struct tb_cm *tcm = tb_priv(tb);
@@ -3212,14 +3211,14 @@ static int tb_thaw_noirq(struct tb *tb)
 static void tb_complete(struct tb *tb)
 {
 	/*
-	 * Release any unplugged XDomains and if there is a case where
+	 * Unregister unplugged XDomains and if there is a case where
 	 * another domain is swapped in place of unplugged XDomain we
 	 * need to run another rescan.
 	 */
-	mutex_lock(&tb->lock);
-	if (tb_free_unplugged_xdomains(tb->root_switch))
-		tb_scan_switch(tb->root_switch);
-	mutex_unlock(&tb->lock);
+	if (tb_domain_unregister_unplugged_xdomains(tb)) {
+		scoped_guard(mutex, &tb->lock)
+			tb_scan_switch(tb->root_switch);
+	}
 }
 
 static int tb_runtime_suspend(struct tb *tb)
@@ -3246,11 +3245,11 @@ static void tb_remove_work(struct work_struct *work)
 	struct tb *tb = tcm_to_tb(tcm);
 
 	mutex_lock(&tb->lock);
-	if (tb->root_switch) {
+	if (tb->root_switch)
 		tb_free_unplugged_children(tb->root_switch);
-		tb_free_unplugged_xdomains(tb->root_switch);
-	}
 	mutex_unlock(&tb->lock);
+
+	tb_free_unplugged_xdomains(tb->root_switch);
 }
 
 static int tb_runtime_resume(struct tb *tb)
diff --git a/drivers/thunderbolt/tb.h b/drivers/thunderbolt/tb.h
index 8e2762ff8d5178..76958a801be3d2 100644
--- a/drivers/thunderbolt/tb.h
+++ b/drivers/thunderbolt/tb.h
@@ -792,6 +792,7 @@ int tb_domain_disconnect_xdomain_paths(struct tb *tb, struct tb_xdomain *xd,
 				       int transmit_path, int transmit_ring,
 				       int receive_path, int receive_ring);
 int tb_domain_disconnect_all_paths(struct tb *tb);
+int tb_domain_unregister_unplugged_xdomains(struct tb *tb);
 
 static inline struct tb *tb_domain_get(struct tb *tb)
 {
@@ -1262,6 +1263,7 @@ struct tb_xdomain *tb_xdomain_alloc(struct tb *tb, struct device *parent,
 				    const uuid_t *remote_uuid);
 void tb_xdomain_add(struct tb_xdomain *xd);
 void tb_xdomain_remove(struct tb_xdomain *xd);
+void tb_xdomain_unregister(struct tb_xdomain *xd);
 struct tb_xdomain *tb_xdomain_find_by_link_depth(struct tb *tb, u8 link,
 						 u8 depth);
 
diff --git a/drivers/thunderbolt/xdomain.c b/drivers/thunderbolt/xdomain.c
index 56344260b4f2c6..8035dd51d62f10 100644
--- a/drivers/thunderbolt/xdomain.c
+++ b/drivers/thunderbolt/xdomain.c
@@ -2072,40 +2072,53 @@ static int unregister_service(struct device *dev, void *data)
 }
 
 /**
- * tb_xdomain_remove() - Remove XDomain from the bus
+ * tb_xdomain_remove() - Remove XDomain
  * @xd: XDomain to remove
  *
- * This will stop all ongoing configuration work and remove the XDomain
- * along with any services from the bus. When the last reference to @xd
- * is released the object will be released as well.
+ * This will stop all ongoing configuration work. XDomain is not removed
+ * from the bus if it was added. That needs to be done separately by
+ * calling tb_xdomain_unregister().
+ *
+ * Called with @tb->lock held.
  */
 void tb_xdomain_remove(struct tb_xdomain *xd)
 {
 	tb_xdomain_debugfs_remove(xd);
-
 	stop_handshake(xd);
-
-	device_for_each_child_reverse(&xd->dev, xd, unregister_service);
-
 	tb_xdomain_link_exit(xd);
 
-	/*
-	 * Undo runtime PM here explicitly because it is possible that
-	 * the XDomain was never added to the bus and thus device_del()
-	 * is not called for it (device_del() would handle this otherwise).
-	 */
-	pm_runtime_disable(&xd->dev);
-	pm_runtime_put_noidle(&xd->dev);
-	pm_runtime_set_suspended(&xd->dev);
-
 	if (!device_is_registered(&xd->dev)) {
+		/*
+		 * Undo runtime PM here explicitly because it is
+		 * possible that the XDomain was never added to the bus
+		 * and thus device_del() is not called for it
+		 * (device_del() would handle this otherwise).
+		 */
+		pm_runtime_disable(&xd->dev);
+		pm_runtime_put_noidle(&xd->dev);
+		pm_runtime_set_suspended(&xd->dev);
 		put_device(&xd->dev);
-	} else {
-		dev_info(&xd->dev, "host disconnected\n");
-		device_unregister(&xd->dev);
 	}
 }
 
+/**
+ * tb_xdomain_unregister() - Unregister XDomain
+ * @xd: XDomain to unregister
+ *
+ * This will unregister the XDomain along with any services from the
+ * bus. When the last reference to @xd is released the object will be
+ * released as well.
+ */
+void tb_xdomain_unregister(struct tb_xdomain *xd)
+{
+	lockdep_assert_not_held(&xd->tb->lock);
+
+	device_for_each_child_reverse(&xd->dev, xd, unregister_service);
+
+	dev_info(&xd->dev, "host disconnected\n");
+	device_unregister(&xd->dev);
+}
+
 /**
  * tb_xdomain_lane_bonding_enable() - Enable lane bonding on XDomain
  * @xd: XDomain connection
-- 
2.53.0

