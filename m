Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.208.52
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794925173;
	b=f8waWoC+8p1qFIjIJ7BjZkNmQLE5Zh9t/mHScANaDoPbdS57M0UhD6DnLhgFG7mLprdA
	 asska+TiT0S2ZWiAdHF8Ni9SMN81JakTi9zY2eExIasHGF8jf/dMXvRguRmT4RQzbTpTo
	 0WsOOq5/03Hg04qJB4CTH5wql25DHdvoRKaWSDIJYCrt/hyfhfsFn4sBZYn/KSumTbLDp
	 P6tOdhe1L352L/9xbZm5/c1Y/C4f0LURnnEeOhmbaQkQgYqxvaABLujBVdFVjt43Y450c
	 /0Vw/XEd5m9vqAYpTpBRJ2p/ierL0PuLpyvVRw6Ppjr8zP1K54jlUUzdM2siB/v+Ong==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794925173;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding;
	bh=t1jrGQlhBIdZ6ivHW5rbtbqkReZD/ruHN7hCzqfWGBA=;
	b=VAJyk74hQn3LKYst9PPxjoDQzko7MmxaweibECnS/sQxho4U2zIXHg3FZPNCny446BlH
	 R/nplLlUtF7oOKs/8zTwU+qwy6Kb1DCMQxoEpgI37cNGn2gkrqgSf8Mg48eBAQYFCFvXS
	 vnvutT/4dM5oL/6SZaBWt3xNJi9VHfJ8tmY9u2KDGWwhz3AL15o45ntNBtYLK6NffNzMe
	 saZ/7mpUnM+LWuf8kleBlGYnpMLNysXd7Xpm6PDQw/L46hwJvbFFfKzyYhzWWkGaxV/mv
	 5EiK+cCcoBe6OebFdkeQQDAiO1PpnIUgveYx7EtnfPWnF42vwupv6oSkq7NP57hIWHQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=rWNI03ss;
	arc=none smtp.remote-ip=209.85.208.52
Received: from mail-ed1-f52.google.com (mail-ed1-f52.google.com [209.85.208.52])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 96CF8606A8A1
	for <stable@vger.kernel.org>; Tue, 17 Nov 2026 14:19:32 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 96CF8606A8A1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=rWNI03ss
Received: by mail-ed1-f52.google.com with SMTP id 4fb4d7f45d1cf-6b7c7fd4c33so592398a12.3
        for <stable@vger.kernel.org>; Tue, 17 Nov 2026 06:19:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794925171; x=1795529971; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=t1jrGQlhBIdZ6ivHW5rbtbqkReZD/ruHN7hCzqfWGBA=;
        b=rWNI03ssepG2GAdxIAm6mClwSGDj7Qa99s03IHuWgo9Xuz2G26ZWpjL+iuAjv7+oyU
         EHIztuOSWXO3We0LJx9hCqFHNHYOYlCPdhH2jRP5k5kGzC5Foo2d2dnin92uN9Z2Q4Ip
         aQmlXE3C1241PNOo6cflwfO41r35QGq0J1vVj8gRAO6O2JN1qiqYfAdbksmoAeoZn0Ir
         oyLPGlo971296XL9iRF6NlkYGCGCzdnibEM1/P3Ttrd/JSzPpixsTHBr41Hl/5HGU7W7
         9Bw9CTRrXqvJYDg+PF9VIaTuFStfZ7s0Nwa4BKxc6W0mnZAHTsJXLQmQqE+TysryNHWw
         NtBA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794925171; x=1795529971;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=t1jrGQlhBIdZ6ivHW5rbtbqkReZD/ruHN7hCzqfWGBA=;
        b=TmRd46v4+aGyp0p/UjWlPHGja1LE+SyjwFL/x5W1NEz0Iz53x71+UaU+kXMwMkX5/L
         YY0T2sCfbADEV84NWQduBKbpdE63CndX/ZQakFe/RI2g1kiPPZ9WsdTcgkwAtV9qxkqw
         TwB9xxK2HUShRNfIH44rmIYQOVrzntlN88s7oPspd/Ev+7gUkIaL9MRS00x+srBUtimV
         IyDgglDUlRL99Ij79jm8QqJJxWnqiXo3LetNQjUzoV7kMy1R8WVQgIYn+fuDIoLJG+sM
         yOManYFzeBfmKfzLouMNqLVxmousK9nn1lpJda5s2x8erGnYsDuKaqDNtkTn8gPqXLnd
         G8JA==
X-Forwarded-Encrypted: i=1; AL+hErHDGBa5R2I8jiJh7nxvmJnoDb7wjxH+gj42fQ/WIb1EWSxr1QhHVAbSzREyP2sKeP1nWd306Qo=@vger.kernel.org
X-Gm-Message-State: APuU4Z892NRViKPWHFK03EMQL0oZSnvZSbrn+4EXz2JxFW3X2E2mlZ0e
	SVDhCtVQ//s4yCCSh8yZ8CciFqk/rdVOU2MQVwr5NgtbW8f6KqOMeNJ+
X-Gm-Gg: AYBFou2DmmW99Gld/l8Jching7kq7Px8k3CYstbT+brpEv4uCxIZb7HXNxnt/inkOvX
	mwl0nA0thawYIeQCups5T7u8y2NMEMpmUEVOTmsAek3CQY33EgRWN7blvNcnk06GGo10PosGZp5
	8YIBeKll7Zvx2Wy/p1NP3ErUahIdTQA5SHnpwzKFECxC1TnPFylHp60fqYEaW09pJqWU2DSaDWG
	UKtfng509SR3JjTIzQn5yp3C+/IB15GKVJA9AIIBfjtOmO8R/7KIAw3scYRFu/q0hW0lRQILyDH
	5QeX07zYrd0tWbg2FxRMYTADpcVNPnJjkjbootpQIT+L/B9DNNJmaUsI4hzM+aKgbXMIyswlOk0
	ARWR02fsET8opo+NbCZbGIpV7LFGoQ6KKBpZIbp+xctS1/FNqNWvZzFlw5u7+7jedIf0ASwKtui
	6KRrOYM3tJSRe5W3MBtWalM/AJJlzIYCCeWi0tTcpmr5RvTiCLFmI8p8kDN/XrTGD4iwiRUXoHc
	nnYGbVb7HxlBsBusUj+ElgTPRHB41EhCEd30tRhNDC9KllVb3hMd5iRPZchRey4ikBoQ1XVhkz5
	qNrWyBE0VHz80OuYL/MkzPyme7AchmrSgvx10P2i6d6oT5NVFu585bTtPmEMnwkFIwpkSAB94eK
	7Erqg3qD4HoMO7scoXLQQX7/pC+g9DTqrwUl9K14Yx8LVCvz+pBvW+vhNXd5wxLlicL+dNQWqcg
	x/NYRj4w==
X-Received: by 2002:a17:906:16c8:b0:c34:db91:aa1e with SMTP id a640c23a62f3a-c509634b915mr1082809466b.4.1794925170821;
        Tue, 17 Nov 2026 06:19:30 -0800 (PST)
Received: from L-022584.energy.envision.com (dynamic-077-184-154-007.77.184.pool.telefonica.de. [77.184.154.7])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-c5095a5abf3sm545215166b.12.2026.11.17.06.19.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 17 Nov 2026 06:19:30 -0800 (PST)
From: Xin Xie <xiexinet@gmail.com>
To: netdev@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: davem@davemloft.net,
	edumazet@kernel.org,
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
	xiexinet@gmail.com,
	lukma@denx.de,
	fmancera@suse.de,
	danishanwar@ti.com,
	syzbot+fbf74291c3b7e753b481@syzkaller.appspotmail.com,
	sd@queasysnail.net
Subject: [PATCH net v10 2/4] net: hsr: refuse forwarding devices as HSR/PRP ports
Date: Tue, 17 Nov 2026 15:19:20 +0100
Message-ID: <20261117141922.20-3-xiexinet@gmail.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20261117141922.20-1-xiexinet@gmail.com>
References: <20261117141922.20-1-xiexinet@gmail.com>
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

syzbot reported recursive locking with an HSR device whose slave is a
bridge, and that bridge has the master of a second HSR device as a port.
The first device transmits its supervision frames with its seqnr_lock
held; the bridge floods them to the second HSR master, whose
hsr_dev_xmit() takes the seqnr_lock of that device:

  WARNING: possible recursive locking detected
  ...
   hsr_dev_xmit+0x18a/0x210 net/hsr/hsr_device.c:234
   ...
   br_dev_xmit+0x1202/0x1b40
   ...
   hsr_forward_skb+0x171c/0x2ac0 net/hsr/hsr_forward.c:728
   send_hsr_supervision_frame+0x63b/0xcc0 net/hsr/hsr_device.c:351
   hsr_announce+0x1f8/0x3a0 net/hsr/hsr_device.c:408

Interlink RX forwards to the slaves with the same lock held. A chain of
two devices does not deadlock, but such a port makes no sense: an HSR
ring and the two PRP LANs are attached to the node directly.

Refuse bridge and OVS masters and bond and team masters (also without
ports, since ports can be added later) as slave or interlink, and a
macvlan or MACsec device when an HSR/PRP, bridge, bond or team master
is below it; on an ordinary NIC or veth such a device stays valid. This
also refuses one on a DSA user port whose conduit is a bond or team,
since it can gain ports later too. A macvlan takes its GRO setting
from its lower device, so it is accepted only if GRO is off there when
it is attached. The lower devices of other ports are not checked,
because a DSA user port is an upper of its conduit and can offload HSR.
VLAN devices are already refused. The check runs at attach; later
changes below a stacked device are not rechecked. Not covered are a
tunnel whose route leads back through the HSR master, a tc or BPF
redirect to it, other stacked devices, and a software device without
an identifying flag such as batman-adv. Narrowing seqnr_lock, planned
for net-next, addresses that class as a whole.

Also refuse a device whose RX handler is in use or not supported
(IFF_NO_RX_HANDLER: ipvlan, VRF), or that already has a master, such as
a VRF port, with an extack message and the same error codes. All ports
are checked before any of them is changed. Some of these devices, such
as a macvlan lower, ipvlan or VRF, used to fail only in
netdev_rx_handler_register(), after the previous patch had dropped
their GRO request; a refused device now keeps its state, and so do the
ports given with it.

A bridge can no longer be used directly as the interlink; connect it
through a veth pair.

Reported-by: syzbot+fbf74291c3b7e753b481@syzkaller.appspotmail.com
Closes: https://syzkaller.appspot.com/bug?extid=fbf74291c3b7e753b481
Fixes: 06afd2c31d33 ("hsr: Synchronize sending frames to have always incremented outgoing seq nr.")
Fixes: 430d67bdcb04 ("net: hsr: Use the seqnr lock for frames received via interlink port.")
Signed-off-by: Xin Xie <xiexinet@gmail.com>
Reviewed-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
---
 net/hsr/hsr_device.c |  7 ++++
 net/hsr/hsr_slave.c  | 79 ++++++++++++++++++++++++++++++++++++++++++--
 net/hsr/hsr_slave.h  |  2 ++
 3 files changed, 86 insertions(+), 2 deletions(-)

diff --git a/net/hsr/hsr_device.c b/net/hsr/hsr_device.c
index fc512204600c..90ee55eb3c19 100644
--- a/net/hsr/hsr_device.c
+++ b/net/hsr/hsr_device.c
@@ -758,6 +758,13 @@ int hsr_dev_finalize(struct net_device *hsr_dev, struct net_device *slave[2],
 	INIT_LIST_HEAD(&hsr->proxy_node_db);
 	spin_lock_init(&hsr->list_lock);
 
+	/* Refuse a bad port before any port is changed. The same checks
+	 * in hsr_add_port() remain as a safety net.
+	 */
+	res = hsr_check_ports(slave, interlink, extack);
+	if (res)
+		return res;
+
 	eth_hw_addr_set(hsr_dev, slave[0]->dev_addr);
 
 	/* initialize protocol specific functions */
diff --git a/net/hsr/hsr_slave.c b/net/hsr/hsr_slave.c
index 4c4f8fe3d128..a4dd64227db5 100644
--- a/net/hsr/hsr_slave.c
+++ b/net/hsr/hsr_slave.c
@@ -10,6 +10,7 @@
 #include "hsr_slave.h"
 #include <linux/etherdevice.h>
 #include <linux/if_arp.h>
+#include <linux/if_macvlan.h>
 #include <linux/if_vlan.h>
 #include <net/netdev_lock.h>
 #include "hsr_main.h"
@@ -97,6 +98,16 @@ bool hsr_port_exists(const struct net_device *dev)
 	return rcu_access_pointer(dev->rx_handler) == hsr_handle_frame;
 }
 
+/* A lower device that forwards into other ports or into a second
+ * HSR/PRP device; called under RTNL by the lower-device walk.
+ */
+static int hsr_lower_forwards(struct net_device *lower,
+			      struct netdev_nested_priv *priv)
+{
+	return is_hsr_master(lower) || netif_is_any_bridge_master(lower) ||
+	       netif_is_lag_master(lower);
+}
+
 static int hsr_check_dev_ok(struct net_device *dev,
 			    struct netlink_ext_ack *extack)
 {
@@ -120,6 +131,27 @@ static int hsr_check_dev_ok(struct net_device *dev,
 		return -EINVAL;
 	}
 
+	/* The RX handler is taken by devices such as bridge/bond/team
+	 * ports, macvlan and ipvlan lowers and HSR ports, or unsupported
+	 * (IFF_NO_RX_HANDLER). Refuse before any state change, so a
+	 * failed attach leaves the device as it was.
+	 */
+	if (dev->priv_flags & IFF_NO_RX_HANDLER) {
+		NL_SET_ERR_MSG_MOD(extack,
+				   "This device does not support an RX handler.");
+		return -EINVAL;
+	}
+	if (netdev_is_rx_handler_busy(dev)) {
+		NL_SET_ERR_MSG_MOD(extack,
+				   "RX handler busy: device is already a lower of another device.");
+		return -EBUSY;
+	}
+	/* A master without an RX handler on its ports, such as VRF. */
+	if (netdev_master_upper_dev_get(dev)) {
+		NL_SET_ERR_MSG_MOD(extack, "Device already has a master.");
+		return -EBUSY;
+	}
+
 	if (is_vlan_dev(dev)) {
 		NL_SET_ERR_MSG_MOD(extack, "HSR on top of VLAN is not yet supported in this driver.");
 		return -EINVAL;
@@ -131,13 +163,56 @@ static int hsr_check_dev_ok(struct net_device *dev,
 		return -EOPNOTSUPP;
 	}
 
-	/* HSR over bonded devices has not been tested, but I'm not sure it
-	 * won't work...
+	/* Forwarding devices feed HSR frames into another device's
+	 * transmit path and can nest seqnr_lock through a second HSR
+	 * device. A bridge, bond, team or OVS master makes no sense as a
+	 * ring or LAN port and is refused by type. A macvlan or MACsec
+	 * device is refused if such a master or an HSR/PRP master is
+	 * below it. Other devices keep their lower devices unchecked:
+	 * DSA user ports are uppers of their conduit.
+	 */
+	if (netif_is_any_bridge_master(dev) || netif_is_lag_master(dev)) {
+		NL_SET_ERR_MSG_MOD(extack,
+				   "Cannot use a bridge, bond, team or OVS master as HSR port.");
+		return -EINVAL;
+	}
+	if ((netif_is_macvlan(dev) || netif_is_macsec(dev)) &&
+	    netdev_walk_all_lower_dev(dev, hsr_lower_forwards, NULL)) {
+		NL_SET_ERR_MSG_MOD(extack,
+				   "Cannot use a macvlan or MACsec device stacked on an HSR, bridge, bond, team or OVS master as HSR port.");
+		return -EINVAL;
+	}
+	/* A macvlan takes its GRO setting from the lower device, so the
+	 * member role cannot turn it off. Refuse at attach, before any
+	 * state change, if the lower device runs GRO; it can still turn
+	 * GRO on later.
 	 */
+	if (netif_is_macvlan(dev) &&
+	    (macvlan_dev_real_dev(dev)->features & NETIF_F_GRO)) {
+		NL_SET_ERR_MSG_MOD(extack,
+				   "macvlan inherits GRO from its lower device; turn GRO off on the lower device.");
+		return -EBUSY;
+	}
 
 	return 0;
 }
 
+/* Check every port before any of them is changed, so that a refused
+ * port does not leave an earlier one modified.
+ */
+int hsr_check_ports(struct net_device *slave[2], struct net_device *interlink,
+		    struct netlink_ext_ack *extack)
+{
+	int res;
+
+	res = hsr_check_dev_ok(slave[0], extack);
+	if (!res)
+		res = hsr_check_dev_ok(slave[1], extack);
+	if (!res && interlink)
+		res = hsr_check_dev_ok(interlink, extack);
+	return res;
+}
+
 /* Member role and feature policy.
  * Setting the role makes __netdev_update_features() clear GRO
  * and configurable GRO_HW from the request and before
diff --git a/net/hsr/hsr_slave.h b/net/hsr/hsr_slave.h
index edc4612bb009..e19c779b500d 100644
--- a/net/hsr/hsr_slave.h
+++ b/net/hsr/hsr_slave.h
@@ -14,6 +14,8 @@
 #include <linux/rtnetlink.h>
 #include "hsr_main.h"
 
+int hsr_check_ports(struct net_device *slave[2], struct net_device *interlink,
+		    struct netlink_ext_ack *extack);
 int hsr_add_port(struct hsr_priv *hsr, struct net_device *dev,
 		 enum hsr_port_type pt, struct netlink_ext_ack *extack);
 void hsr_del_port(struct hsr_port *port);
-- 
2.53.0

