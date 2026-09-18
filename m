Received: from mail-wr2-f12.google.com (mail-wr2-f12.google.com [74.125.225.76])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 94C97481DD
	for <stable@vger.kernel.org>; Fri, 18 Sep 2026 14:23:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.225.76
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789741396; cv=none; b=ocEfInJ58rDbSl1tNrhEBFEhFJ0BkJy9C/Nc6cq6cHvS/VSq8UAZIzucokd55uhzyP5ctiXNoH7X/01jVk8Pe0q8jMD7oWdX/DuvSeQpKTbz0R9ECcXsWdJcHvQDFW/Wmbl1SMPI+mWgvGOkXH54bl6J37sxFofbu5CiUV3LbPQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789741396; c=relaxed/simple;
	bh=P25xDoU7/1mf3eN1kegDER1cfqBSsDHQXiE+UJt2nQs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=HGRveh5haiEZ5KSnF+8ETaCXM/yzqy2hG08fiTqBdV42wj1AZsdjq6Bzi3+h8m0br6hB7hVr0nZQwF0lNav087kBfdJfLMv4HT3Z/KaGAf6s1baow8sMlWnD58T22GBl1njRaFACuOe7yiflSwLuuAQAMYy0JgiqgqR1N224/Fk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=iit.org.ua; spf=pass smtp.mailfrom=iit.org.ua; dkim=pass (2048-bit key) header.d=iit.org.ua header.i=@iit.org.ua header.b=Ou8mGzpt; arc=none smtp.client-ip=74.125.225.76
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=iit.org.ua
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=iit.org.ua
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=iit.org.ua header.i=@iit.org.ua header.b="Ou8mGzpt"
Received: by mail-wr2-f12.google.com with SMTP id ffacd0b85a97d-48437356d60so421042f8f.3
        for <stable@vger.kernel.org>; Fri, 18 Sep 2026 07:23:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=iit.org.ua; s=google; t=1789741392; x=1790346192; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=7EAmXw7Fnj7MpFoFAOhsQZQdEvNv2Y9tK2i+FbtsLBI=;
        b=Ou8mGzptFbZCU8GXDMPlPk6rQonvOGBwvtlGt1ODSn2YonBs/FtmE5f4f0AinccfEc
         Na2TZjxel6yzjhiV7WYlHd8o4Z0e+ZTBJ9Nu8LAMr6yrHe5AwtscsIorIRTVi+VDkK6j
         J9JEv+LnX3yTLztC9/sQoU1NU04YKcZQ6Z8QCBaw5Q9gXUQG2NFBV/dO0hiqmB3vEZ+3
         INNhhzfJBgpOO1GzZmcyHG3XF4WZOf0CwH7YN39GttQmjLHsbcdxagivF6K6GV+fHowF
         oV/VR+XSwFX4W/tUFqSPqWhyvRHfBEj+7xG7LMmbUv60UVzjBGj3u6O8uxl1+GGzKQ5G
         X5Cw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789741392; x=1790346192;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=7EAmXw7Fnj7MpFoFAOhsQZQdEvNv2Y9tK2i+FbtsLBI=;
        b=ByaeMyKbO9EKqEp2nYMcCmz9+V7VYXoxQ9fefv2Xdpya2SL0tDbRtXN7JDCF1VFonH
         geNdh6kA52fc3+g2EAKLz3dGOVi+W4iKdDym3aeZD96q/chh/kD+r75w/Nw6RDUKyWIL
         hZ9rj+SLO4ROydJfPRjv4RIDhrr4a0ZH/EkRikwCDyPIoEYiofoO13Q+MNTAiy9k/ogB
         O4uOsgt+mlV8peOAAfcUTkfCUAf1076YU7j5/vmjiMFo7yXkwDIJTLA3iy2/VegZhdJK
         JvQmqMCsMOSY4L2p9T06/o1FqlVxvj4iav0IhNiFTdfglFaXOENXqYYLdPJGFoUpozaK
         vMNg==
X-Forwarded-Encrypted: i=1; AKwUvBx6AUDMhBXJPNy1NIJktW0WsiEKQOqgeIM8BMu7CQjwblm5AuttMI0UOEdrpeB/c+lYSHe5D28=@vger.kernel.org
X-Gm-Message-State: AFuF++mfmmCTmMABOloyqwLIULCWHmZxt3rLYx+ZnbX3vuMnLfrkHaw1
	5nP0OndYkLkwr92sQhgNG78waC2wyUZIxEgh/8yUHAny0Hn9zrn1UM2zJitf9rXHV3Y=
X-Gm-Gg: AYBFou0G67cr8Oo/X/eXdGwGULtdOMfB2dSH5e/VyACaw36+aWaEP+cTByrz2FmhNmL
	Nkeoag1gIzQ3IiQKB4h7x9u7spcWR3CLhyK/w7W5dDwqP3uWHHuWjgSbvgA7HK1Kn/DVuk2NE91
	VabfD9N7or3nLiIm49sK5ZorP1gxjrdRU86YoLCeyoewp2CWGzfXZmfEeKql2CEc+eotRsPK0vf
	r45KmK8qM+ybZtO/6FUvUmY4/Rh8rAOj6UdCMFQNXs5qNiCb3F6yiXD4rT/q9OrybDdsRuC40hL
	FIQTFnmdr4lcVM5KE5lKY00+8B5y/lAJNTyGtT2jDIzdl+xkZRE1mTw6UF3VpPBl8j2exLgXBVb
	I3um05ouzs2Ik8IV60lkttjSI7dDAhelwDXr+Bxt45mGrkEqSgRfQdQvinnm5YO32SZtiVeVQMM
	ElaIfgVykyxw8dg2Ms1VVqzUNIcRnhsetrXelVgdCfZPHImQ2L2XWY65mWeAse8Hy4FsZAyK6Ux
	0M=
X-Received: by 2002:a5d:5f41:0:b0:47f:e377:8d61 with SMTP id ffacd0b85a97d-4871e215994mr4806967f8f.11.1789741391505;
        Fri, 18 Sep 2026 07:23:11 -0700 (PDT)
Received: from archbtw ([212.1.106.18])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4871feb5d9asm4597901f8f.2.2026.09.18.07.23.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 18 Sep 2026 07:23:11 -0700 (PDT)
From: Stepan Svatenko <ssvatenko@iit.org.ua>
To: kuba@kernel.org
Cc: PrashanthKumar.K.R@amd.com,
	Raju.Rangoju@amd.com,
	andrew+netdev@lunn.ch,
	davem@davemloft.net,
	edumazet@google.com,
	linux-kernel@vger.kernel.org,
	netdev@vger.kernel.org,
	pabeni@redhat.com,
	stable@vger.kernel.org,
	Stepan Svatenko <ssvatenko@iit.org.ua>,
	Claude Sonnet 5 <noreply@anthropic.com>
Subject: [PATCH v2] amd-xgbe: fix comm_ownership mutex deadlock on SFP module removal
Date: Fri, 18 Sep 2026 17:22:38 +0300
Message-ID: <20260918142238.191589-1-ssvatenko@iit.org.ua>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260903024059.2957610-1-kuba@kernel.org>
References: <20260903024059.2957610-1-kuba@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

xgbe_phy_sfp_detect() acquires xgbe_phy_comm_lock (via
xgbe_phy_get_comm_ownership()) and holds it across calls that can end
up freeing the external PHY device:

  xgbe_phy_sfp_detect()
    xgbe_phy_get_comm_ownership()                  <- mutex_lock
    xgbe_phy_sfp_mod_absent() / xgbe_phy_sfp_read_eeprom() (SFP changed)
      xgbe_phy_free_phy_device()
        phy_detach()
          phy_suspend()
            genphy_suspend()
              xgbe_phy_mii_read_c22()               <- mii_bus->read
                xgbe_phy_get_comm_ownership()       <- mutex_lock again

xgbe_phy_comm_lock is a plain, non-recursive mutex. phy_detach() ends
up calling back into this driver's own MDIO bus callbacks
(xgbe_phy_mii_read_c22()/xgbe_phy_mii_write_c22(), reached via
genphy_suspend() during phy_detach()), which independently acquire the
same lock, so the second acquisition deadlocks the task tearing down
the SFP module.

This is reliably reproducible by removing an SFP module while an
external PHY is attached: the removal handler hangs forever inside
xgbe_phy_free_phy_device(), confirmed via /proc/<pid>/stack and the
kernel hung-task detector (blocked 368s+). Reproduced on a SolidRun
Bedrock V3000 (AMD Ryzen Embedded V3C48).

There were two call paths into xgbe_phy_free_phy_device() while the
mutex was held: the module-absent path, and a second one inside
xgbe_phy_sfp_read_eeprom() when the EEPROM contents change (e.g. a
module swap).

Fix this by never calling xgbe_phy_free_phy_device() (directly, or via
xgbe_phy_sfp_mod_absent()) while holding xgbe_phy_comm_lock.
xgbe_phy_sfp_read_eeprom() no longer frees the PHY device itself; it
only records that the SFP changed. xgbe_phy_sfp_detect() releases the
mutex before calling xgbe_phy_sfp_mod_absent() or
xgbe_phy_free_phy_device(), and re-acquires it only around the
remaining raw I2C access in xgbe_phy_sfp_external_phy(). Neither
xgbe_phy_sfp_mod_absent() nor xgbe_phy_sfp_parse_eeprom()/
xgbe_phy_sfp_phy_settings() touch hardware directly, so they don't
need the mutex held.

phy_detach()/phy_device_remove() additionally require RTNL to be held
by the caller. The callers here run from the service workqueue with no
lock held, and a plain rtnl_lock() cannot be used: xgbe_stopdev()
(system workqueue) takes rtnl_lock() and then calls
flush_workqueue(pdata->dev_workqueue) inside xgbe_stop(), which would
block waiting for this very (dev_workqueue) work item to finish, while
that work item is blocked waiting to reacquire RTNL from
xgbe_stopdev() - an ABBA deadlock. Use a non-blocking rtnl_trylock()
instead: on contention, skip the teardown for this poll and let the
next service poll (100ms-1s later) retry it; if the interface is going
down concurrently, xgbe_phy_stop() (phy_impl.stop) frees the PHY
itself under RTNL already held by its own caller, so nothing is lost
by skipping here.

Taking RTNL around the free also closes a second, independent race:
xgbe does not opt into the newer per-netdevice instance lock
(netdev_need_ops_lock() in include/net/netdev_lock.h checks
dev->request_ops_lock / dev->queue_mgmt_ops / dev->netdev_ops->
net_shaper_ops, none of which this driver sets), so __dev_ethtool()
computes need_rtnl = true and takes rtnl_lock() before calling into
this driver's set_link_ksettings()/set_pauseparam(), which dereference
phy_data->phydev without any lock of their own. Before this change,
xgbe_phy_free_phy_device() could free phy_data->phydev out from under
those ethtool paths with nothing serializing the two. With the free
now gated on rtnl_trylock(), it only proceeds while holding RTNL, so
it is properly excluded from any ethtool_ops call on this device: a
concurrent ethtool call either already holds RTNL (the trylock loses
and the free is retried later) or is blocked waiting to acquire it
(behind the still-held lock from the free side).

Finally, if re-acquiring comm ownership for xgbe_phy_sfp_external_phy()
fails after a new SFP's EEPROM has already been parsed, fall back to
the "no module" state (same as the existing xgbe_phy_sfp_read_eeprom()
failure path) instead of leaving sfp_changed/sfp_eeprom/sfp_base
updated for a module whose sfp_phy_avail was never actually set.

Fixes: abf0a1c2b26a ("amd-xgbe: Add support for SFP+ modules")
Cc: stable@vger.kernel.org
Signed-off-by: Stepan Svatenko <ssvatenko@iit.org.ua>
Assisted-by: Claude Code:claude-sonnet-5 [Bash] [Read] [Edit]
Co-authored-by: Claude Sonnet 5 <noreply@anthropic.com>

---
Changes since v1:
 - Use rtnl_trylock() instead of leaving the PHY teardown unguarded,
   closing both the ABBA deadlock against xgbe_stopdev()'s
   flush_workqueue(pdata->dev_workqueue) under RTNL, and a
   use-after-free race against the ethtool_ops paths
   (set_link_ksettings()/set_pauseparam()) that dereference
   phy_data->phydev without their own locking (both reported in
   review).
 - Handle the case where re-acquiring comm_ownership after parsing a
   new SFP's EEPROM fails, instead of leaving stale/incomplete SFP
   state in place (reported in review).
---
 drivers/net/ethernet/amd/xgbe/xgbe-phy-v2.c | 94 ++++++++++++++++++---
 1 file changed, 83 insertions(+), 11 deletions(-)

diff --git a/drivers/net/ethernet/amd/xgbe/xgbe-phy-v2.c b/drivers/net/ethernet/amd/xgbe/xgbe-phy-v2.c
index 59a074ed312a..8c625a0340c4 100644
--- a/drivers/net/ethernet/amd/xgbe/xgbe-phy-v2.c
+++ b/drivers/net/ethernet/amd/xgbe/xgbe-phy-v2.c
@@ -11,6 +11,7 @@
 #include <linux/mdio.h>
 #include <linux/phy.h>
 #include <linux/ethtool.h>
+#include <linux/rtnetlink.h>
 
 #include "xgbe.h"
 #include "xgbe-common.h"
@@ -1218,7 +1219,13 @@ static int xgbe_phy_sfp_read_eeprom(struct xgbe_prv_data *pdata)
 		goto put;
 	}
 
-	/* Check for an added or changed SFP */
+	/* Check for an added or changed SFP. Freeing any existing external
+	 * PHY device is deferred to the caller: xgbe_phy_free_phy_device()
+	 * can end up calling back into this driver's MDIO read/write
+	 * routines (via phy_detach() -> phy_suspend()), which take the
+	 * comm ownership mutex themselves, and that mutex is held across
+	 * this call.
+	 */
 	if (memcmp(&phy_data->sfp_eeprom, &sfp_eeprom, sizeof(sfp_eeprom))) {
 		phy_data->sfp_changed = 1;
 
@@ -1226,8 +1233,6 @@ static int xgbe_phy_sfp_read_eeprom(struct xgbe_prv_data *pdata)
 			xgbe_phy_sfp_eeprom_info(pdata, &sfp_eeprom);
 
 		memcpy(&phy_data->sfp_eeprom, &sfp_eeprom, sizeof(sfp_eeprom));
-
-		xgbe_phy_free_phy_device(pdata);
 	} else {
 		phy_data->sfp_changed = 0;
 	}
@@ -1268,9 +1273,47 @@ static void xgbe_phy_sfp_mod_absent(struct xgbe_prv_data *pdata)
 
 	phy_data->sfp_mod_absent = 1;
 	phy_data->sfp_phy_avail = 0;
+	phy_data->sfp_changed = 0;
 	memset(&phy_data->sfp_eeprom, 0, sizeof(phy_data->sfp_eeprom));
 }
 
+/* phy_detach()/phy_device_remove(), called from xgbe_phy_free_phy_device()
+ * below, require RTNL to be held by the caller (phy_detach() itself uses
+ * rtnl_dereference() and phy_link_topo_del_phy()). The callers below run
+ * from the service workqueue with no lock held, so a plain rtnl_lock()
+ * cannot be used here: xgbe_stopdev() (system workqueue) takes rtnl_lock()
+ * and then calls flush_workqueue(pdata->dev_workqueue) inside xgbe_stop(),
+ * which would block waiting for this very (dev_workqueue) work item to
+ * finish - while it is blocked waiting to reacquire RTNL from
+ * xgbe_stopdev(). That is an ABBA deadlock, the same class of bug this
+ * driver just fixed elsewhere.
+ *
+ * Use a non-blocking rtnl_trylock() instead: on contention, skip the
+ * teardown for this poll and let the next service poll (100ms-1s later)
+ * retry it. If the interface is going down concurrently, xgbe_phy_stop()
+ * (phy_impl.stop) frees the PHY itself, under RTNL already held by its
+ * own caller - so nothing is lost by skipping here.
+ */
+static void xgbe_phy_sfp_mod_absent_safe(struct xgbe_prv_data *pdata)
+{
+	if (!rtnl_trylock())
+		return;
+
+	xgbe_phy_sfp_mod_absent(pdata);
+
+	rtnl_unlock();
+}
+
+static void xgbe_phy_free_phy_device_safe(struct xgbe_prv_data *pdata)
+{
+	if (!rtnl_trylock())
+		return;
+
+	xgbe_phy_free_phy_device(pdata);
+
+	rtnl_unlock();
+}
+
 static void xgbe_phy_sfp_reset(struct xgbe_phy_data *phy_data)
 {
 	phy_data->sfp_rx_los = 0;
@@ -1296,26 +1339,55 @@ static void xgbe_phy_sfp_detect(struct xgbe_prv_data *pdata)
 	/* Read the SFP signals and check for module presence */
 	xgbe_phy_sfp_signals(pdata);
 	if (phy_data->sfp_mod_absent) {
-		xgbe_phy_sfp_mod_absent(pdata);
-		goto put;
+		/* xgbe_phy_sfp_mod_absent() calls xgbe_phy_free_phy_device(),
+		 * which can call back into this driver's MDIO read/write
+		 * routines via phy_detach() -> phy_suspend(). Those routines
+		 * take the comm ownership mutex themselves, so it must be
+		 * released before making this call.
+		 */
+		xgbe_phy_put_comm_ownership(pdata);
+		xgbe_phy_sfp_mod_absent_safe(pdata);
+		goto settings;
 	}
 
 	ret = xgbe_phy_sfp_read_eeprom(pdata);
+	xgbe_phy_put_comm_ownership(pdata);
 	if (ret) {
 		/* Treat any error as if there isn't an SFP plugged in */
 		xgbe_phy_sfp_reset(phy_data);
-		xgbe_phy_sfp_mod_absent(pdata);
-		goto put;
+		xgbe_phy_sfp_mod_absent_safe(pdata);
+		goto settings;
 	}
 
+	/* Same reasoning as above: this must run without the comm
+	 * ownership mutex held.
+	 */
+	if (phy_data->sfp_changed)
+		xgbe_phy_free_phy_device_safe(pdata);
+
 	xgbe_phy_sfp_parse_eeprom(pdata);
 
-	xgbe_phy_sfp_external_phy(pdata);
+	/* Re-acquire ownership for the external PHY access below; it talks
+	 * to the SFP over I2C directly and needs the mutex held again.
+	 */
+	ret = xgbe_phy_get_comm_ownership(pdata);
+	if (!ret) {
+		xgbe_phy_sfp_external_phy(pdata);
+		xgbe_phy_put_comm_ownership(pdata);
+	} else {
+		/* Could not finish bringing up the new module: sfp_changed,
+		 * sfp_eeprom and sfp_base/sfp_speed were already updated
+		 * above for it, but external_phy() (and thus sfp_phy_avail)
+		 * never ran. Fall back to "no module" state instead of
+		 * committing to a half-initialized one - same pattern as
+		 * the read_eeprom() failure path above.
+		 */
+		xgbe_phy_sfp_reset(phy_data);
+		xgbe_phy_sfp_mod_absent_safe(pdata);
+	}
 
-put:
+settings:
 	xgbe_phy_sfp_phy_settings(pdata);
-
-	xgbe_phy_put_comm_ownership(pdata);
 }
 
 static int xgbe_phy_module_eeprom(struct xgbe_prv_data *pdata,
-- 
2.55.0

