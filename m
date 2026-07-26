Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B502D35950
	for <stable@vger.kernel.org>; Sun, 26 Jul 2026 13:59:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785074399; cv=none; b=r5rejjh+ngQCtVtK9DEYfKNK2ZkAfSRyoLbRTv+QwSTrtOLojDpObjgBuQaR9OUGI+UMp+xIQ9R4W9gPH3LEiTWSgkf6IEah4xuAPsm6VRW1a/V26KaEfQJDxWC36PoXAbuWlnyTWfEwsbjcp4Qz+Ujax8dfr5lEpMp+CaORZgw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785074399; c=relaxed/simple;
	bh=WlFTZlDBe04Ea/h1+SJUJiBeLpE2hKihUDe0RdL1aLU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=jsoxVy2ecybuMt4unMJVxPEGLwtLg690Hj3EaXHlikzSYTe2dMjJV2VROoUchVKDpLEzApKEx/VGiUK782Red5U68aMVfkxrxmdLszz8trP3FHORGoml12Fcj/xWM5OMRuZF9c+sw/b9w+YzXHNz+P+jTxymL+m5CoLg4NlIvc4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Np7TXRsL; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Np7TXRsL"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D60A71F000E9;
	Sun, 26 Jul 2026 13:59:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785074398;
	bh=xI6KgnrGxJQ+461pI3yS7+fi3Xx9qf1lNx48RAq1OTk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=Np7TXRsLBNlojMWF/loAYovgj+eSdgysUDdeOfpWbCRjSzLKmGpqgQzdk6ZkWd2qJ
	 8DuujzrqUb99IfuYB3Ush1vYaY1h+pU3cHVpgwdt2FMjTeLEF/42KFdK9IJVpBVL2h
	 mjhkKJQhSpHyAeDZldtNSbV+7ZaVQIF5ly35cWFoopA7J00mAoL1JenfckdsL0RoMW
	 DBBo6hjR7aN/PPDk4mndo5MGMbwS/xyqRabJYkUh8/a+QtjGe8eYS+Kos8a2D/i4WK
	 9UsI1Vx+lvrXN1gYZk6/LB9PJnNQPfSE7fk2SrZOYo38hX+VYJR6J1N6jAj2TLwnJb
	 D30CgIem+JNaw==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Gil Fine <gil.fine@linux.intel.com>,
	Mika Westerberg <mika.westerberg@linux.intel.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.6.y 1/7] thunderbolt: Handle lane bonding of Gen 4 XDomain links properly
Date: Sun, 26 Jul 2026 09:59:49 -0400
Message-ID: <20260726135955.668115-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026072000-womb-upturned-7ecf@gregkh>
References: <2026072000-womb-upturned-7ecf@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Gil Fine <gil.fine@linux.intel.com>

[ Upstream commit 36b6ad6ad0350554e611a8cb754ccd40857416a8 ]

Gen 4 links come up as bonded already so we are not supposed to initiate
lane bonding on them. However, we should still update the port
structures accordingly. Split these into their own functions to make it
easier to follow.

Signed-off-by: Gil Fine <gil.fine@linux.intel.com>
Signed-off-by: Mika Westerberg <mika.westerberg@linux.intel.com>
Stable-dep-of: 2c5d2d3c3f70 ("thunderbolt: Prevent XDomain delayed work use-after-free on disconnect")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/thunderbolt/tb.c      |  2 --
 drivers/thunderbolt/xdomain.c | 49 ++++++++++++++++++++++++++++++++++-
 2 files changed, 48 insertions(+), 3 deletions(-)

diff --git a/drivers/thunderbolt/tb.c b/drivers/thunderbolt/tb.c
index bf35fd23b5e160..0f489527343f3d 100644
--- a/drivers/thunderbolt/tb.c
+++ b/drivers/thunderbolt/tb.c
@@ -539,8 +539,6 @@ static void tb_port_unconfigure_xdomain(struct tb_port *port)
 		usb4_port_unconfigure_xdomain(port);
 	else
 		tb_lc_unconfigure_xdomain(port);
-
-	tb_port_enable(port->dual_link_port);
 }
 
 static void tb_scan_xdomain(struct tb_port *port)
diff --git a/drivers/thunderbolt/xdomain.c b/drivers/thunderbolt/xdomain.c
index a5ec70327d81ab..8a40584024c4fe 100644
--- a/drivers/thunderbolt/xdomain.c
+++ b/drivers/thunderbolt/xdomain.c
@@ -1903,6 +1903,50 @@ struct device_type tb_xdomain_type = {
 };
 EXPORT_SYMBOL_GPL(tb_xdomain_type);
 
+static void tb_xdomain_link_init(struct tb_xdomain *xd, struct tb_port *down)
+{
+	if (!down->dual_link_port)
+		return;
+
+	/*
+	 * Gen 4 links come up already as bonded so only update the port
+	 * structures here.
+	 */
+	if (tb_port_get_link_generation(down) >= 4) {
+		down->bonded = true;
+		down->dual_link_port->bonded = true;
+	} else {
+		xd->bonding_possible = true;
+	}
+}
+
+static void tb_xdomain_link_exit(struct tb_xdomain *xd)
+{
+	struct tb_port *down = tb_xdomain_downstream_port(xd);
+
+	if (!down->dual_link_port)
+		return;
+
+	if (tb_port_get_link_generation(down) >= 4) {
+		down->bonded = false;
+		down->dual_link_port->bonded = false;
+	} else if (xd->link_width > TB_LINK_WIDTH_SINGLE) {
+		/*
+		 * Just return port structures back to way they were and
+		 * update credits. No need to update userspace because
+		 * the XDomain is removed soon anyway.
+		 */
+		tb_port_lane_bonding_disable(down);
+		tb_port_update_credits(down);
+	} else if (down->dual_link_port) {
+		/*
+		 * Re-enable the lane 1 adapter we disabled at the end
+		 * of tb_xdomain_get_properties().
+		 */
+		tb_port_enable(down->dual_link_port);
+	}
+}
+
 /**
  * tb_xdomain_alloc() - Allocate new XDomain object
  * @tb: Domain where the XDomain belongs
@@ -1953,7 +1997,8 @@ struct tb_xdomain *tb_xdomain_alloc(struct tb *tb, struct device *parent,
 			goto err_free_local_uuid;
 	} else {
 		xd->needs_uuid = true;
-		xd->bonding_possible = !!down->dual_link_port;
+
+		tb_xdomain_link_init(xd, down);
 	}
 
 	device_initialize(&xd->dev);
@@ -2022,6 +2067,8 @@ void tb_xdomain_remove(struct tb_xdomain *xd)
 
 	device_for_each_child_reverse(&xd->dev, xd, unregister_service);
 
+	tb_xdomain_link_exit(xd);
+
 	/*
 	 * Undo runtime PM here explicitly because it is possible that
 	 * the XDomain was never added to the bus and thus device_del()
-- 
2.53.0

