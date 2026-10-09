Received: from mail-wm1-f51.google.com (mail-wm1-f51.google.com [209.85.128.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1FFCE4F4753
	for <stable@vger.kernel.org>; Fri,  9 Oct 2026 20:13:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791576814; cv=none; b=UMHg+YJ963c97kZiVhDeLDe/h45FPY7aCKmpFDiYOH0LCn5Jv6oqBVKVxG/0q5fXXsINTXagWgPw9Z+FP56KD7+GrKDi3G1R06jimavIg41GH3CYAurB0z1rI2z9945CBkfq5puTVz/t0voIaEWhUZjQsrGpf2ZyhAVkjoOEIpg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791576814; c=relaxed/simple;
	bh=mQSQ6sNCH46+PlX7qOn54jxw4AL/mWWfp7QK69l9KR4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=o0PJaDqmk0fggv5EH48SSMd6yFMCjy/gKMAxrC2SIzs8QtsaYZyj7pP3UOywFQsmoWU2XP9NZEHnmrDtdzoBc9R4ljYkSf+UJ9wppjSCvToPd5OufQ/c/UG35pdKXX/EWTOlQ136l1Aqx2jy7MsMnIFI1mSE4In0jK7m/ThHHao=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=cJr7zEyb; arc=none smtp.client-ip=209.85.128.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cJr7zEyb"
Received: by mail-wm1-f51.google.com with SMTP id 5b1f17b1804b1-4a1810f8855so80205e9.3
        for <stable@vger.kernel.org>; Fri, 09 Oct 2026 13:13:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1791576810; x=1792181610; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=nXpkqx2sLfjZ99UEleZi9clOOU5lwItH+DbXV5aYBb8=;
        b=cJr7zEybowftkcrPwTn36i9/BrQ6UuS5Lwd4ZMjwtM2McD8+IfJg1N3ZW4A9YhKQgM
         6475woSVn8sw2oer67c63BUsAMBKVMEjKsBs1ozvN6IP4hXLmO/Wkfnxe5s8rWKJzrWr
         NYZe+UXEkQI72S50rPiztagcwzniG1O4No/gZKqBFTt4/bSFiEGlHb4viv6cuju90xBj
         yTT4QCT00z0d1fpiWLo42GzXeFua55p4J/+pNAe3vd3txWDV8Y4+I3v+I3ue49Az2nfu
         28kLNE3uPUTBH3n1aosEWO+D9mgM7ZFMr6wTrP27WsBOjbO9yHVJTTsVXwr9qYE5rhGs
         OeAQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791576810; x=1792181610;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=nXpkqx2sLfjZ99UEleZi9clOOU5lwItH+DbXV5aYBb8=;
        b=XdN8JL5wBgu1QEmlCLwRFNH2xiBjXVR7EjFsf+1d2nObjxY1226qSWvsFcSaEJ8bUp
         KzPraJ3wJ+SyBUJCEdfrgTjALWJIifT8X8AyJV2CpDibCXSmI9OhWlBo2Ex6S2OU0BEM
         Usmql3XYx9svU4tJ1gN4DCP0ZzPqxmowWOJv1T5yypfN+t3tkbnYjG/0pE9GreyR9X0Y
         sYPy+URKXVb7404RNIXqQtXXVGddhLY8wfWSxjZ7bqJfdjw1TG5rLKUONxTP8qls9Yux
         6RrSTwWlT63aKGr3KGkbWpA3CWM2VAGEBd7uShEXBdphEisK4LLv3hktEtjNgakNfFP+
         xm2g==
X-Forwarded-Encrypted: i=1; AKwUvBxQF/2OZOavlOv+SkifwFY5HIrwvNMm9JxbfE/IAZCcOzfGiMCGA5xuKyBF6FuP2RYsxcXrlgY=@vger.kernel.org
X-Gm-Message-State: AFuF++ljItYiMs5+WYuQQKbgMao+QMA/3aC4dF9djaA28jQf9RgbP8nk
	lvQEsEMTP6C0PdcNue/aEvSzoQkgMBeosQ/d1XDuL9l7DWQ1q92FDTCv
X-Gm-Gg: AYBFou0F9Fqt5vJxMuDXvPr2l7gHX0ZWwPCtT9siTT28mddyM50NlU9NF/QJhJqT/U4
	MGfs/XJv63rGmguUViNMdLEAYHjcOYbxaBW9Uwvkxj0XCnDpAXcCjy5rQZuAvfOHq6+TNwitvcb
	ke3dG6EjkZvAh3Y6iyOY7jdREDFUb4pdT9fLWRvQevyX4FDFyhPFQMWIEjmC3MXeSxaQJM773YD
	7oTvLxIQq2VNDJDQtm/XG3RXr3rkeiQUfVjs+N/vDbGFtd8PZWK48iLErdOc8aAKadInXWUK3KJ
	U4EZzfAFCUExLc8atGd1//N0oJ3G3ZfWwptLPVZzbD35JfTfPIfi6q699PN0gTbI6Y7BqyswOMl
	yHfa354ByxMaI7oVOvM23ctLTQKtFq19JftZ4mUXFytHQXRE0kM4mltptESA/5uCX/S2xf9wfmB
	rHsgdHtV2vzvf5NWniGYJVswh5rE7aFc6UsYrzSQJEYVsqCV8bNg/g3EZI6i/DT3huUGkDvPvhh
	7Cv24Uu5Ktn8UlpErL/6cMFp/OV9M6hvcCSVGYFQMAXfm+FVDHz0nreY4NzNHVHK5tEgQJUjiLM
	les+Q/zV9cLH2nbW3+z4sHDoyPDk1zrZ
X-Received: by 2002:a05:600c:5246:b0:4a1:7e9b:e0b5 with SMTP id 5b1f17b1804b1-4a18e3ee9d3mr50560215e9.0.1791576809991;
        Fri, 09 Oct 2026 13:13:29 -0700 (PDT)
Received: from L-022584.energy.envision.com (dynamic-093-130-185-162.93.130.pool.telefonica.de. [93.130.185.162])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4a18d12fe04sm47053065e9.4.2026.10.09.13.13.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 09 Oct 2026 13:13:28 -0700 (PDT)
From: Xin Xie <xiexinet@gmail.com>
To: netdev@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	horms@kernel.org,
	andrew+netdev@lunn.ch,
	shuah@kernel.org,
	kees@kernel.org,
	petr.wozniak@gmail.com,
	qingfang.deng@linux.dev,
	fmaurer@redhat.com,
	luka.gejak@linux.dev,
	bigeasy@linutronix.de,
	xiaoliang.yang_1@nxp.com,
	skhawaja@google.com,
	liuhangbin@gmail.com,
	stable@vger.kernel.org,
	sdf.kernel@gmail.com,
	xiexinet@gmail.com
Subject: [PATCH net v7 1/4] net: hsr: keep GRO disabled on HSR/PRP ports
Date: Fri,  9 Oct 2026 22:13:21 +0200
Message-ID: <20261009201324.17-2-xiexinet@gmail.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20261009201324.17-1-xiexinet@gmail.com>
References: <20261009201324.17-1-xiexinet@gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

HSR/PRP add tags and sequence numbers per wire frame. GRO can merge
plain interlink traffic before those fields are added, and userspace
can re-enable GRO after the port is attached.

Mark slave A/B and interlink devices with a kernel role bit. Filter
software GRO and configurable GRO_HW requests before ndo_fix_features()
without changing wanted_features. Filtering before the driver keeps
feature dependencies intact; fixed-on or driver-required GRO_HW is
left enabled.

Apply the policy before registering the RX handler and reject attach
if software GRO remains enabled. On failure or detach, unlink the
upper before clearing the role and recomputing features, restoring
the user's last request.

GSO skbs may still arrive. A later patch segments valid GSO before
HSR/PRP processing.

Fixes: 5055cccfc2d1 ("net: hsr: Provide RedBox support (HSR-SAN)")
Signed-off-by: Xin Xie <xiexinet@gmail.com>
---
 .../networking/net_cachelines/net_device.rst  |  1 +
 include/linux/netdevice.h                     |  6 +++
 net/core/dev.c                                | 10 ++++
 net/hsr/hsr_slave.c                           | 47 +++++++++++++++++++
 4 files changed, 64 insertions(+)

diff --git a/Documentation/networking/net_cachelines/net_device.rst b/Documentation/networking/net_cachelines/net_device.rst
index 512f6d6fa3d8..114a29b2ff4c 100644
--- a/Documentation/networking/net_cachelines/net_device.rst
+++ b/Documentation/networking/net_cachelines/net_device.rst
@@ -168,6 +168,7 @@ unsigned_long:1                     see_all_hwtstamp_requests
 unsigned_long:1                     change_proto_down
 unsigned_long:1                     netns_immutable
 unsigned_long:1                     fcoe_mtu
+unsigned_long:1                     hsr_port
 struct list_head                    net_notifier_list
 struct macsec_ops*                  macsec_ops
 struct udp_tunnel_nic_info*         udp_tunnel_nic_info
diff --git a/include/linux/netdevice.h b/include/linux/netdevice.h
index 3cff2174dc03..0a917906fe2a 100644
--- a/include/linux/netdevice.h
+++ b/include/linux/netdevice.h
@@ -2102,6 +2102,7 @@ enum netdev_reg_state {
  *	@change_proto_down: device supports setting carrier via IFLA_PROTO_DOWN
  *	@netns_immutable: interface can't change network namespaces
  *	@fcoe_mtu:	device supports maximum FCoE MTU, 2158 bytes
+ *	@hsr_port:	direct HSR/PRP member (slave A/B or interlink)
  *
  *	@net_notifier_list:	List of per-net netdev notifier block
  *				that follow this device when it is moved
@@ -2522,6 +2523,11 @@ struct net_device {
 	unsigned long		change_proto_down:1;
 	unsigned long		netns_immutable:1;
 	unsigned long		fcoe_mtu:1;
+	/* Direct HSR/PRP member: slave A/B or interlink.
+	 * Software GRO is filtered off while set. Kernel role
+	 * state only; no user ABI or offload capability.
+	 */
+	unsigned long		hsr_port:1;
 
 	struct list_head	net_notifier_list;
 
diff --git a/net/core/dev.c b/net/core/dev.c
index 18dc88990510..0c53b59af439 100644
--- a/net/core/dev.c
+++ b/net/core/dev.c
@@ -11111,6 +11111,16 @@ int __netdev_update_features(struct net_device *dev)
 
 	features = netdev_get_wanted_features(dev);
 
+	/* A direct HSR/PRP port needs per-frame metadata: filter
+	 * software GRO and configurable GRO_HW requests before the
+	 * driver fix runs, keeping the existing driver and core
+	 * feature coupling.
+	 */
+	if (dev->hsr_port) {
+		features &= ~NETIF_F_GRO;
+		features &= ~(dev->hw_features & NETIF_F_GRO_HW);
+	}
+
 	if (dev->netdev_ops->ndo_fix_features)
 		features = dev->netdev_ops->ndo_fix_features(dev, features);
 
diff --git a/net/hsr/hsr_slave.c b/net/hsr/hsr_slave.c
index a546f70f9cc8..1afcacac6b3c 100644
--- a/net/hsr/hsr_slave.c
+++ b/net/hsr/hsr_slave.c
@@ -11,6 +11,7 @@
 #include <linux/etherdevice.h>
 #include <linux/if_arp.h>
 #include <linux/if_vlan.h>
+#include <net/netdev_lock.h>
 #include "hsr_main.h"
 #include "hsr_device.h"
 #include "hsr_forward.h"
@@ -137,6 +138,33 @@ static int hsr_check_dev_ok(struct net_device *dev,
 	return 0;
 }
 
+/* Member role and feature policy.
+ * Setting the role makes __netdev_update_features() filter GRO
+ * and GRO_HW for this device.  Only the role and feature update
+ * run under the device ops lock; unlink, promiscuous updates and
+ * the master recompute stay outside.
+ */
+static void hsr_portdev_role_set(struct net_device *dev)
+{
+	netdev_lock_ops(dev);
+	dev->hsr_port = true;
+	netdev_change_features(dev);
+	netdev_unlock_ops(dev);
+}
+
+static void hsr_portdev_role_clear(struct net_device *dev)
+{
+	netdev_lock_ops(dev);
+	dev->hsr_port = false;
+	/* Restore from the current wanted state only on a still-
+	 * registered device; a netns move stays registered and must
+	 * restore, a dying device just drops the role.
+	 */
+	if (dev->reg_state == NETREG_REGISTERED)
+		netdev_change_features(dev);
+	netdev_unlock_ops(dev);
+}
+
 /* Setup device to be added to the HSR bridge. */
 static int hsr_portdev_setup(struct hsr_priv *hsr, struct net_device *dev,
 			     struct hsr_port *port,
@@ -169,6 +197,19 @@ static int hsr_portdev_setup(struct hsr_priv *hsr, struct net_device *dev,
 	if (res)
 		goto fail_upper_dev_link;
 
+	/* Enable the member role and recompute before the RX handler
+	 * is published: software GRO must be off before frames can
+	 * arrive.  A still-active software GRO rejects the port, a
+	 * remaining GRO_HW alone does not.
+	 */
+	hsr_portdev_role_set(dev);
+	if (dev->features & NETIF_F_GRO) {
+		NL_SET_ERR_MSG_MOD(extack,
+				   "software GRO still on after feature update, cannot join");
+		res = -EBUSY;
+		goto fail_role_policy;
+	}
+
 	res = netdev_rx_handler_register(dev, hsr_handle_frame, port);
 	if (res)
 		goto fail_rx_handler;
@@ -177,7 +218,12 @@ static int hsr_portdev_setup(struct hsr_priv *hsr, struct net_device *dev,
 	return 0;
 
 fail_rx_handler:
+fail_role_policy:
+	/* Rollback order: unlink the upper, clear the role and
+	 * recompute, then undo this setup's promiscuous increment.
+	 */
 	netdev_upper_dev_unlink(dev, hsr_dev);
+	hsr_portdev_role_clear(dev);
 fail_upper_dev_link:
 	if (!port->hsr->fwd_offloaded || port->type == HSR_PT_INTERLINK)
 		dev_set_promiscuity(dev, -1);
@@ -248,6 +294,7 @@ void hsr_del_port(struct hsr_port *port)
 		if (port->type == HSR_PT_SLAVE_A || port->type == HSR_PT_SLAVE_B)
 			vlan_vids_del_by_dev(port->dev, master->dev);
 		netdev_upper_dev_unlink(port->dev, master->dev);
+		hsr_portdev_role_clear(port->dev);
 		if (hsr->prot_version == PRP_V1 &&
 		    port->type == HSR_PT_SLAVE_B) {
 			eth_hw_addr_set(port->dev, port->original_macaddress);
-- 
2.43.0

