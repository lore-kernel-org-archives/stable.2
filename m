Received: from mail-wm2-f12.google.com (mail-wm2-f12.google.com [74.125.225.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2DF153D953A
	for <stable@vger.kernel.org>; Thu, 10 Sep 2026 08:26:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.225.140
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789028814; cv=none; b=envavwgXqXtcwaLCI7rEg8L5N9Q/S5L4gTzAW/8dM58e9v5NQJEk7nnn0kR3xteLhxNu/kfvuMUQcLjMQReRnxIudYwXQ6w5NgozBck2Bkl0QPHDdDoGJqy/TsCAOcJkHJ567OTBTAIbfCPxvYxHVjc7HPBKQWjlqbIHro8JQzs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789028814; c=relaxed/simple;
	bh=Rt+35QpJwurXh8jaLywJIOfU9KTFVt7yBWWLTBIeMEI=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=TXO4gZfbjBClJ0L41mHyIETOSm3l+d4lbLbQQc7I4lFu0qmx1WQ2St86vvI3p/uQoV690eKelM36yUij2s5tpuAF//vzPMb7/99CBBjTegj7FwVFEkMRwd7352aowxVcV77KVYrL6b3LDZzIhYp0Oe77ZCshn8SUR37ZoYLWyck=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=oFV1p6x2; arc=none smtp.client-ip=74.125.225.140
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="oFV1p6x2"
Received: by mail-wm2-f12.google.com with SMTP id 5b1f17b1804b1-49cd38e0e5dso13419525e9.2
        for <stable@vger.kernel.org>; Thu, 10 Sep 2026 01:26:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1789028810; x=1789633610; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=3FWXbZhvJgbluUBInzWvOijQmCJSvSHt+/OC865YgEk=;
        b=oFV1p6x2VtDcFnSh807d7pnjg3SdB0ZTtp31AcMYoBaNy5o4PZasd8iL7FcCv4cx4m
         j4vdxy9abL1KljpQqR/90REMYa6ZuwKqUJvM+WILILKrZxI0eIxeDk5SpNIYGdik0yg+
         oqfERxn5LKDteua0V6DcnjXc2kz9tAIDahlhZZ2IFNzz8h+cNJRCJMveauIKtHEE9XHS
         kTiaPJAR6MB4v/UYigmaan5noc3V0/MjZk18XPQo3nepxaMHUTSWnZPzwff6ISCmL2dq
         h4MP6LN+X1rFWgRl/aut7Jr1BvqMdnuJ8ntUKh3zh6A/BjPI0FpYpXQcUt7kz98W5iv2
         Lb+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1789028810; x=1789633610;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=3FWXbZhvJgbluUBInzWvOijQmCJSvSHt+/OC865YgEk=;
        b=LrhopZwkQ4LPykj/ljfhHWzYXUFJYbaj0vuPpg3F5oGHaK1qr8BMIfo5iAysvN+sL+
         4kSchY284ktmLIF7IGrmOAfZztQoRZLxwMmCU8AP78jPDeL8WW5xLrQAodfyHdpkGKW8
         wY3O4euXzWY3qyYlByCjko8mawxtPQ3Lwy4YXMMINuNLukVr23UlSiJIO2Ge/oWGg7d0
         nK7jSh5ASbPpKr5HLUm8jwnRZzdlaJd1poKK1QMB2qHwLQ2M5OgXiIy8NYiUi5cpHBHP
         CxqxBNk/YIS1EcL417ptkBo4KOnxdK3Wi+1csuceI0zOMsJ36S5cdRwVjKLcy1so58zT
         xnzw==
X-Forwarded-Encrypted: i=1; AKwUvBxqcyXplKkriqbXxHmARpF2w6vcPUbPrKYFU3E2nAfCMAIv8c2QqpWcsiyAMZbl0cAqxJND4aw=@vger.kernel.org
X-Gm-Message-State: AFuF++n2dEcpNPvPD8A3LReGQqGPkf1VoS2Le03oPpqtXrLCyhUhQXk9
	JrReC3eh0BXu2VSuMHWcP3XZdwwIC/Svm1saOSjuOXRUKQiY55RsSYau
X-Gm-Gg: AYBFou1L3iAn0XEJ2E40OPMqDEIR3bTPKvjRd7sniwrOxYuGBS/OPlnYRUVx0dRtFIG
	mLdRWpWhK/ZYTIopdBDYdit+4WXIaw6ONeMswT9Lx7WjLCrGwlNp8JDeliTO+wVXRaXW3HCNzaW
	D2f1gZbX0lz6Ykwkc5HHXk8r5XOB73fMDm+VI8OvpC/6Q4KkqiKfiTZt3++NJZEIe8oHezGJlWA
	ta4z98vyyzTOp5XAGvyAy7TP+6gJYMc3QF+64UcTXueNUEMO1utz2tAUYPXOnZZU6H1M+70exZL
	9uWmAsWf+Ce1TK6VOslY6UXLCL28qX51SxEX78Wmzpqe9Vwm+imS4aX2A6ECi5zI3iy2sMWjNDZ
	glfvMysU0Wh3CDwRNchQdD6E1FlqchOkY8G8St4XPsDZ01lRU4I7Oj8S2OpfoUCfh9oYJjlcdyT
	ts2ricHtgMPAO9S0ApVGOi70GtjodyFrfP/xVttOfjKzc+A+1+uJSENRKtQv9vqLwbCY+sh/b2e
	r2Ljw==
X-Received: by 2002:a05:600c:5647:b0:499:b65e:49c9 with SMTP id 5b1f17b1804b1-49d259138bamr85010655e9.10.1789028809832;
        Thu, 10 Sep 2026 01:26:49 -0700 (PDT)
Received: from SurHub.localdomain ([196.188.112.26])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-49d26c494basm51434515e9.12.2026.09.10.01.26.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 10 Sep 2026 01:26:48 -0700 (PDT)
From: Abdifatah Suruur <suruurism@gmail.com>
To: netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	andrew+netdev@lunn.ch,
	subash.a.kasiviswanathan@qualcomm.com,
	sean.tranchetti@qualcomm.com,
	dnlplm@gmail.com,
	stable@vger.kernel.org,
	Abdifatah Suruur <suruurism@gmail.com>
Subject: [PATCH net v7] net: qualcomm: rmnet: require CAP_NET_ADMIN in the real device netns for config ops
Date: Thu, 10 Sep 2026 11:26:42 +0300
Message-ID: <20260910082643.14437-1-suruurism@gmail.com>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

An rmnet device may be created with its real device in a different
netns than the rmnet device itself (rmnet_newlink() resolves it in
link_net), and the config paths below only check CAP_NET_ADMIN against
dev_net(dev), while mutating rmnet port state attached to the real
device:

- rmnet_changelink() rewrites the endpoint mux table and
  port->data_format and, via rmnet_vnd_update_dev_mtu(), can shrink the
  MTU of the rmnet endpoint netdevs.
- rmnet_add_bridge() and rmnet_del_bridge(), reachable via
  ndo_add_slave/ndo_del_slave through RTM_SETLINK IFLA_MASTER, flip
  port->rmnet_mode and port->bridge_ep on the real device's port; with
  bridge_ep pointing at a caller-owned device, rmnet_rx_handler() then
  forwards real-device ingress frames to it.
- rmnet_set_coalesce() rewrites the port aggregation parameters via
  ETHTOOL_SCOALESCE (ioctl) or ETHTOOL_MSG_COALESCE_SET (netlink),
  whose capability checks likewise only cover dev's netns.

A caller privileged only in the rmnet device's netns can therefore
rewrite the shared cellular data-path state owned by another netns, and
steer its ingress traffic.

Gate the rtnl paths with rtnl_dev_link_net_capable(), matching the
"require CAP_NET_ADMIN in the device netns for changelink" series
(vxlan/geneve, CVE-2026-68432), and gate the ethtool setter with
ns_capable() in the real device netns, mirroring the check dev_ethtool()
already applies to dev's netns.  Report the new rejections through
extack where one is available.

The gates cover the configuration paths only.  Teardown (RTM_DELLINK
reaching rmnet_dellink(), and rmnet_config_notify_cb() unregistering
the bridge when the slave device is deleted) is intentionally left
ungated: link deletion is normal netdev lifecycle behaviour, and the
changelink series this matches (vxlan/geneve, CVE-2026-68432) gated
only the configuration paths.

Fixes: 2abb5792387e ("net: qualcomm: rmnet: Allow configuration updates to existing devices")
Fixes: 60d58f971c1077 ("net: qualcomm: rmnet: Implement bridge mode")
Fixes: db8a563a9d9024 ("net: qualcomm: rmnet: add ethtool support for configuring tx aggregation")
Cc: stable@vger.kernel.org
Signed-off-by: Abdifatah Suruur <suruurism@gmail.com>
---
v7:
- state explicitly in the commit message that the dellink and notifier
  teardown paths are out of scope, per the Sashiko review
- drop the master-moved-into-the-real-device-netns rationale from the
  rmnet_add_bridge() comment: on the add path do_set_master() resolves
  the master in the slave's netns, so the rationale only applies to
  rmnet_del_bridge(), where the master comes from
  netdev_master_upper_dev_get()
- use the netdev comment style in rmnet_set_coalesce(), per the
  Sashiko review
v6:
- gate rmnet_add_bridge() and rmnet_del_bridge() on slave_dev, the
  RTM_SETLINK target the caller was actually authorized against,
  instead of rmnet_dev: a master moved into the real device's netns
  short-circuits rtnl_dev_link_net_capable() through the net_eq()
  check, so a caller only privileged in the slave's netns could
  otherwise attach or clear the bridge state of the real device's
  port
- add the Fixes tag for the commit that introduced rmnet_set_coalesce()
v5:
- also gate rmnet_set_coalesce(), the ethtool setter that rewrites the
  port aggregation parameters of the real device's port, per the
  Sashiko review
- report the new capability rejections through extack where available
v4:
- use the netdev comment style, per Subash Abhinov Kasiviswanathan
v3:
- cover rmnet_add_bridge() and rmnet_del_bridge() with the same gate;
  they mutate the same real-device port state via ndo_add_slave/
  ndo_del_slave and have no capability check of their own
- correct the impact wording: rmnet_vnd_update_dev_mtu() only reads
  real_dev->mtu; the MTU store lands on the rmnet endpoint netdevs via
  rmnet_vnd_change_mtu(), not on the real device
v2:
- drop Reported-by: (implied for the author), per Jakub Kicinski
---
 .../ethernet/qualcomm/rmnet/rmnet_config.c    | 37 ++++++++++++++++++-
 .../net/ethernet/qualcomm/rmnet/rmnet_vnd.c   | 16 +++++++-
 2 files changed, 51 insertions(+), 2 deletions(-)

diff --git a/drivers/net/ethernet/qualcomm/rmnet/rmnet_config.c b/drivers/net/ethernet/qualcomm/rmnet/rmnet_config.c
index bed6f63facf25..ca6971150180d 100644
--- a/drivers/net/ethernet/qualcomm/rmnet/rmnet_config.c
+++ b/drivers/net/ethernet/qualcomm/rmnet/rmnet_config.c
@@ -312,6 +312,16 @@ static int rmnet_changelink(struct net_device *dev, struct nlattr *tb[],
 	if (!rmnet_is_real_dev_registered(real_dev))
 		return -ENODEV;
 
+	/* The rtnl path only checks CAP_NET_ADMIN against dev_net(dev),
+	 * but the port state mutated below is attached to real_dev, which
+	 * may live in a different netns.
+	 */
+	if (!rtnl_dev_link_net_capable(dev, dev_net(real_dev))) {
+		NL_SET_ERR_MSG_MOD(extack,
+				   "Changing the port settings requires CAP_NET_ADMIN in the real device network namespace");
+		return -EPERM;
+	}
+
 	port = rmnet_get_port_rtnl(real_dev);
 
 	if (data[IFLA_RMNET_MUX_ID]) {
@@ -441,6 +451,16 @@ int rmnet_add_bridge(struct net_device *rmnet_dev,
 	struct rmnet_port *port, *slave_port;
 	int err;
 
+	/* The rtnl path authorizes the caller against the RTM_SETLINK
+	 * target, slave_dev, but the port state mutated below is attached
+	 * to real_dev, which may live in a different netns.
+	 */
+	if (!rtnl_dev_link_net_capable(slave_dev, dev_net(real_dev))) {
+		NL_SET_ERR_MSG_MOD(extack,
+				   "Attaching a bridge device requires CAP_NET_ADMIN in the real device network namespace");
+		return -EPERM;
+	}
+
 	port = rmnet_get_port_rtnl(real_dev);
 
 	/* If there is more than one rmnet dev attached, its probably being
@@ -489,7 +509,22 @@ int rmnet_add_bridge(struct net_device *rmnet_dev,
 int rmnet_del_bridge(struct net_device *rmnet_dev,
 		     struct net_device *slave_dev)
 {
-	struct rmnet_port *port = rmnet_get_port_rtnl(slave_dev);
+	struct rmnet_priv *priv = netdev_priv(rmnet_dev);
+	struct net_device *real_dev = priv->real_dev;
+	struct rmnet_port *port;
+
+	/* The rtnl path authorizes the caller against the RTM_SETLINK
+	 * target, slave_dev, but rmnet_unregister_bridge() below clears
+	 * the bridge state of the real device's port, which may live in a
+	 * different netns.  Check the capability against slave_dev so the
+	 * master's netns, which the caller was never checked against,
+	 * cannot short-circuit the gate after being moved into the real
+	 * device's netns.
+	 */
+	if (!rtnl_dev_link_net_capable(slave_dev, dev_net(real_dev)))
+		return -EPERM;
+
+	port = rmnet_get_port_rtnl(slave_dev);
 
 	rmnet_unregister_bridge(port);
 
diff --git a/drivers/net/ethernet/qualcomm/rmnet/rmnet_vnd.c b/drivers/net/ethernet/qualcomm/rmnet/rmnet_vnd.c
index 4f0ddcedfa979..7549318f83985 100644
--- a/drivers/net/ethernet/qualcomm/rmnet/rmnet_vnd.c
+++ b/drivers/net/ethernet/qualcomm/rmnet/rmnet_vnd.c
@@ -4,9 +4,11 @@
  * RMNET Data virtual network driver
  */
 
+#include <linux/capability.h>
 #include <linux/etherdevice.h>
 #include <linux/ethtool.h>
 #include <linux/if_arp.h>
+#include <linux/netlink.h>
 #include <net/pkt_sched.h>
 #include "rmnet_config.h"
 #include "rmnet_handlers.h"
@@ -240,9 +242,21 @@ static int rmnet_set_coalesce(struct net_device *dev,
 			      struct netlink_ext_ack *extack)
 {
 	struct rmnet_priv *priv = netdev_priv(dev);
+	struct net_device *real_dev = priv->real_dev;
 	struct rmnet_port *port;
 
-	port = rmnet_get_port_rtnl(priv->real_dev);
+	/* The aggregation parameters live in the port attached to real_dev,
+	 * which may reside in a different netns.  The ethtool paths only
+	 * require CAP_NET_ADMIN in dev's netns, so require it in real_dev's
+	 * netns as well before mutating the shared port state.
+	 */
+	if (!ns_capable(dev_net(real_dev)->user_ns, CAP_NET_ADMIN)) {
+		NL_SET_ERR_MSG_MOD(extack,
+				   "Changing aggregation parameters requires CAP_NET_ADMIN in the real device network namespace");
+		return -EPERM;
+	}
+
+	port = rmnet_get_port_rtnl(real_dev);
 
 	if (kernel_coal->tx_aggr_max_frames < 1 || kernel_coal->tx_aggr_max_frames > 64)
 		return -EINVAL;
-- 
2.53.0

