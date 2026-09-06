Received: from mail-wm1-f48.google.com (mail-wm1-f48.google.com [209.85.128.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 04742199920
	for <stable@vger.kernel.org>; Sun,  6 Sep 2026 12:32:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788697956; cv=none; b=iN+jJxVNxT8pzD2TXGOAyDecz4Y40ty3p2NE0O2rq7s0lE8zj6LW+dQdWRqmkggAgALlB3jv60wC/pyR82B5FF+BEUaKksmKe7TbNVktanhrsEoQBEOCBl8LnZl+myBsSqXlWPczJA78zg9j5NJpUXfhGMFo/ay2kWtP32dUcBw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788697956; c=relaxed/simple;
	bh=Sgcn14L0g02bItZ04E+YkjO9u5qGmAuMZdZAS26Crys=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=asQq1ltUtHCQ+SpYaPvdIDgaXIW0cXBHuPeNkyLpjYPEb78SRM5qMEZktR55GrX3i/z+vYYlryzcSMN3NpKlvLHfwNmobwMnGJG30yZLpufr3vlzXWwj0ZjHi9FDPR0HPdNK/dxDE2L+vTLBn8QiYxtUI0HV4NxsJTLOB0VejIE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=YGLJaZ1K; arc=none smtp.client-ip=209.85.128.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YGLJaZ1K"
Received: by mail-wm1-f48.google.com with SMTP id 5b1f17b1804b1-49b0d8bc2aaso32799685e9.0
        for <stable@vger.kernel.org>; Sun, 06 Sep 2026 05:32:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1788697953; x=1789302753; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=7bRw+3griMmmm9uOADm1tBgo3gIoZKRYcTHKvyuLxuU=;
        b=YGLJaZ1KysSaNP7GwB5C2qbCFuItqtBZxoquO1FvJwmB81AsgomrPHuORDh8DnqkSH
         CWP/XY8bf6svNrFM4zW9y+/RvmSmpZYtCIMLVD0ImcJrzYURtCVNVkf5fzXkSMco1pKR
         p4EMhJ8VL9F1ibBkob9lH4P0hNTWavO2gitA6C2lhL+rVHlUW12JErHJdiJQiPGc54jh
         7MH62BIs2iKCorX6koKWvTNj4Pw+LRD3TcotNqm2i/YJPtRL1s7omC20ApEXCWGyadQ9
         D2t6pdSHvbpujXuUZRLwkKha5hChF2wvDGX4hvQ46nnE/k5O7xhDhQJf5Mcw+k+f1E9e
         jzJg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788697953; x=1789302753;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=7bRw+3griMmmm9uOADm1tBgo3gIoZKRYcTHKvyuLxuU=;
        b=IRFWs5OAYqV/Kmdkja3MUYOAgA8q2x+P0btJd5on6xdtzEKRD49zBrJUIiUsfoGJBG
         kwU6B+HBD5GMbFoUf7o4Q1PNsv3SUmlQcbtcbHz8r+1RS7Pg/F/9LAmm0nFsiwzbrUiR
         QGhSSkdQzTU9Stk/9l8bYxi1DEdwBnImakUWfUW6aIrvSaiRerce2CfhtZSL2Ho2yFRD
         SQKDpx8jQ5OzB7JlYnwCI6zGvIJrqldAfmEL6zZozqENew60gfaPiK0h1FGKlM8FaFd5
         fL/ks7RuUAqkTI29yFD58OjW6aatbYtHotPC8tFurG3mT45/V0l5Y5uyDZeBxj6eH10c
         sUVQ==
X-Forwarded-Encrypted: i=1; AKwUvBx1S3dPu/Gz4+LCxW4Y38B5Ztn8+UFYIVLM9x04wlUgrd8ZbZTb0SYJiGq5gWvPq/Grww0chwU=@vger.kernel.org
X-Gm-Message-State: AFuF++l0Yb8F8N7XzqW2n/Q2LWo5YynfLaPd3HmONvUoPXGvBdNPdxFZ
	AuM1oj1BSwNlit74sGdCjv5Okj6lA9LLt/bwg9G+w9PKaoyTKtPYxQvl
X-Gm-Gg: AYBFou2ezP+ILhNGP8ZrzXrG0wm5I41w27y8s5kY7pwktI1qy1+cfxzbsFYZMyKkgFj
	+cJF+p1004AUQ83OrDohx/BDzgXhYWKbUonSfV9e0pnaax4ajhknVc2zR4EgQY64IwjGO0gxTe3
	mX1KcJE5e/UuK89YFN3viZrKI+AVFf8suhNSeidywZYweSOLbu9pheSWjaqj5WPwq+T1m/+9Wx2
	iDTqp5hjE4ea6ETs+p3/L/CTCtx+9GvZbCi9EHFTLMiaeIrZZspGGKeWfI8lVBaWH/0QEbHQVUh
	KwCyTb7z/WCQjE18lEQ3h6ys6ux49NOAIPRp5jgzXGUJsE+0Ph+u7wrCZNcwxVnZMleOLVKkp+i
	YZpXK6/JDkz7FEjvt7bJmFCXsUWAqaXJXEgwomc1AGVfRfPeQ49ZaaKPDg1ay96QBZbGJQ74KHz
	/Uw/Np7tRoHImq/GM6znkO4+ITQgn9nogIf4X74yjcUtf5qtpq/ht0eMMWedzcIPdbxTwW
X-Received: by 2002:a05:600d:8481:20b0:49c:fde6:8b39 with SMTP id 5b1f17b1804b1-49cfde68bacmr97434185e9.29.1788697952905;
        Sun, 06 Sep 2026 05:32:32 -0700 (PDT)
Received: from SurHub.localdomain ([102.218.51.179])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-49d0af538d0sm65779485e9.8.2026.09.06.05.32.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 06 Sep 2026 05:32:32 -0700 (PDT)
From: Abdifatah Suruur <suruurism@gmail.com>
To: netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: subash.a.kasiviswanathan@oss.qualcomm.com,
	sean.tranchetti@oss.qualcomm.com,
	horms@kernel.org,
	stable@vger.kernel.org,
	Abdifatah Suruur <suruurism@gmail.com>
Subject: [PATCH net v5] net: qualcomm: rmnet: require CAP_NET_ADMIN in the real device netns for config ops
Date: Sun,  6 Sep 2026 15:32:11 +0300
Message-ID: <20260906123212.10829-1-suruurism@gmail.com>
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

Fixes: 2abb5792387e ("net: qualcomm: rmnet: Allow configuration updates to existing devices")
Fixes: 60d58f971c1077 ("net: qualcomm: rmnet: Implement bridge mode")
Cc: stable@vger.kernel.org
Signed-off-by: Abdifatah Suruur <suruurism@gmail.com>
---
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
 .../ethernet/qualcomm/rmnet/rmnet_config.c    | 33 ++++++++++++++++++-
 .../net/ethernet/qualcomm/rmnet/rmnet_vnd.c   | 18 +++++++++-
 2 files changed, 49 insertions(+), 2 deletions(-)

diff --git a/drivers/net/ethernet/qualcomm/rmnet/rmnet_config.c b/drivers/net/ethernet/qualcomm/rmnet/rmnet_config.c
index bed6f63facf25..7757fcb2fcc9f 100644
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
 
+	/* The rtnl path only checks CAP_NET_ADMIN against dev_net(dev),
+	 * but the port state mutated below is attached to real_dev, which
+	 * may live in a different netns.
+	 */
+	if (!rtnl_dev_link_net_capable(rmnet_dev, dev_net(real_dev))) {
+		NL_SET_ERR_MSG_MOD(extack,
+				   "Attaching a bridge device requires CAP_NET_ADMIN in the real device network namespace");
+		return -EPERM;
+	}
+
 	port = rmnet_get_port_rtnl(real_dev);
 
 	/* If there is more than one rmnet dev attached, its probably being
@@ -489,7 +509,18 @@ int rmnet_add_bridge(struct net_device *rmnet_dev,
 int rmnet_del_bridge(struct net_device *rmnet_dev,
 		     struct net_device *slave_dev)
 {
-	struct rmnet_port *port = rmnet_get_port_rtnl(slave_dev);
+	struct rmnet_priv *priv = netdev_priv(rmnet_dev);
+	struct net_device *real_dev = priv->real_dev;
+	struct rmnet_port *port;
+
+	/* The rtnl path only checks CAP_NET_ADMIN against dev_net(dev),
+	 * but rmnet_unregister_bridge() below clears the bridge state of
+	 * the real device's port, which may live in a different netns.
+	 */
+	if (!rtnl_dev_link_net_capable(rmnet_dev, dev_net(real_dev)))
+		return -EPERM;
+
+	port = rmnet_get_port_rtnl(slave_dev);
 
 	rmnet_unregister_bridge(port);
 
diff --git a/drivers/net/ethernet/qualcomm/rmnet/rmnet_vnd.c b/drivers/net/ethernet/qualcomm/rmnet/rmnet_vnd.c
index 4f0ddcedfa979..1f4a3246f254a 100644
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
@@ -240,9 +242,23 @@ static int rmnet_set_coalesce(struct net_device *dev,
 			      struct netlink_ext_ack *extack)
 {
 	struct rmnet_priv *priv = netdev_priv(dev);
+	struct net_device *real_dev = priv->real_dev;
 	struct rmnet_port *port;
 
-	port = rmnet_get_port_rtnl(priv->real_dev);
+	/*
+	 * The aggregation parameters live in the port attached to
+	 * real_dev, which may reside in a different netns.  The ethtool
+	 * paths only require CAP_NET_ADMIN in dev's netns, so require it
+	 * in real_dev's netns as well before mutating the shared port
+	 * state.
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

