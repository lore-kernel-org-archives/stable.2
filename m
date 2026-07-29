Received: from mail-pj1-f50.google.com (mail-pj1-f50.google.com [209.85.216.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 284273AA1BD
	for <stable@vger.kernel.org>; Wed, 29 Jul 2026 23:01:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785366098; cv=none; b=T6flVMpt09JHF890wLoQvYNY5P6xzyVXm4mGpx9+XW4op/zA3t051L8l9rEvGiqETVBD/MDbPv86AvOuj9Zf70pwox75NJk6afPDlJB3jkS6PyXB4kTl775tm+PaWxapDd30I0P6IZkN+n+GxI2iIK3UnWUfVIkSKE0Qeph4N6s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785366098; c=relaxed/simple;
	bh=Oyb45EYofyM4dN00IPyHH0yZs9a1iN55YP3vYtNIdEA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=PzSvDh2+gSkgYhD4V//+FM624TElZa0vD2X1WNcik01kHgLQkbdmdGddTqeirV3r+bDng6lQwgRkzRtpIVppBUPSlYjc6mnhjKkjznfmsCuniK4M3QbtqZ208EWSzddiZRMczMD0jQvkH4pui8psKDxt4fpgUn653NEHpoC2gJM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=asu.edu; spf=pass smtp.mailfrom=asu.edu; dkim=pass (2048-bit key) header.d=asu.edu header.i=@asu.edu header.b=rijZq63q; arc=none smtp.client-ip=209.85.216.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=asu.edu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=asu.edu
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=asu.edu header.i=@asu.edu header.b="rijZq63q"
Received: by mail-pj1-f50.google.com with SMTP id 98e67ed59e1d1-38101f85591so153125a91.1
        for <stable@vger.kernel.org>; Wed, 29 Jul 2026 16:01:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=asu.edu; s=google; t=1785366095; x=1785970895; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=kQUnJujPcFsZ6VetQyxf08ib9Ig2H7AajXt4skg+zWQ=;
        b=rijZq63q+oPsIrOMxQr7AeQ+zNvmWcMRfyA1vG+NO2lC/OrBAAwYMj4YS5hJg7mD/B
         jVFVALBM355p5Cco/oTphy+9YAHHhrPtWT+jzz10+F8dnCISBY0uNHYzxOkA/dAkLG3H
         hxSpnPEa6cOgckpHscJUcnaxgTgq5jMNPNqajQ8eqjKO+zqrFNSwMyl/e8eH5iDqa4Fp
         uThNN7Ng1V9n1p7Io37MpuBlOcMRRwT9fGFfTIAEBEqq8LE/U9ny2j8slj09bzVzLPw2
         w7uN4sBkrJtxZZFqVenL/AdXF2l4tt6p/nWbTsVIgostWjAvby8g/cRFkzzYaWn9DTh+
         0apg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785366095; x=1785970895;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=kQUnJujPcFsZ6VetQyxf08ib9Ig2H7AajXt4skg+zWQ=;
        b=izj8MxM6DnlN5sB/sO3jLjv/VR+lw4E5fA8gQkw4yGJcc5jZ7JzLP+Zk9fndMJaZMC
         Vyv2sp+LPkWpQhVmHdLdQDNgLOsMBzU6etqFfVyi+K4DsC8ik58Zh4QI5OZR6H+/J1t8
         WNrjNQHYlTTSMcCl5i5X9FXyx90LHrxxLo4jy482cnOjRmCbDuCV08uFU8FWqaPGuPlf
         DsIm0G0Xvt5R7ctfROLSjBlmXAxAF1qIReNiQG13JjIUv0m99orbtt33fHw6omgGZB4T
         hw02rv7omvN3anaF5FqYItTk5M2iG2QkZvj91vh9hGgsmJjYUmFjAsemyQchmk/ZuP1z
         kKvQ==
X-Forwarded-Encrypted: i=1; AHgh+RqAR7BrAeILm9Ac8Mlu/cuuskn4t/Z7KKPntJ5/WFBg4a/aFCSU7H6y4kc3dZbX78lVzOk0/7w=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyiu25zc3HUwHphPIMmITShtgGZfxSy3JxdPwH9wrV/fj9+/dqj
	sOKwVGsuePRWAyIRgnjwB+xxJ2RKHdaOjIFqd5/k2CUU3AzNhlRMF7XsR1N/SJsB6g==
X-Gm-Gg: AR+sD13w46K2oG3xVWLTm+dxStSRKma1Tt6H9EGuQM1VkpmKCnm3JV8GZCgLeJsqunZ
	TdTh+5MQ20IcNIdZl8Th0I80qWQjJwhRipWnoN/RUvHS8A9gjBbMAIcG3YFFDTMqlGYpyEYkX6+
	Zi2fq86zVlee04/LMjJz0YFamqkD1Cxs4CqJLXrPQIsfdDdBWv+q/j8G2d8wBJY632+ymk5kPb2
	NcmkP0OgcGSgLARVHir0yYEEHNjenKVONjFDs0nwsLrmKRX2tY4V39LFF9ks4towKd6nEDeBi0F
	0ZqHx6IOrFjg3swtpLVWgXKxw2Xk+5uwrqO/9th+UdbCmMOSgZR2M/UZJMSV0S/aPdWaGFkCFKg
	t1RhRibdLIH9Tb3Qa3TonhPC1QFtBDVFMgm/bDzcMu/Ic6wjv4OmgGOBFa3R+6BDUSqhYgK57vE
	ny8I6o7aqrG0NsTrpAaK30OgTVthbGz5IXe07oz9CIc/Kwv+24UxOHg1lr0YwpTKFZNg==
X-Received: by 2002:a17:90a:dfcf:b0:38e:c1ba:4f94 with SMTP id 98e67ed59e1d1-38f9b83aa0bmr225471a91.2.1785366095305;
        Wed, 29 Jul 2026 16:01:35 -0700 (PDT)
Received: from xiang.tailc0aff1.ts.net ([20.171.14.70])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-31504d373c3sm13777272eec.23.2026.07.29.16.01.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 29 Jul 2026 16:01:33 -0700 (PDT)
From: "Xiang Mei (Microsoft)" <xmei5@asu.edu>
To: Jay Vosburgh <jv@jvosburgh.net>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>
Cc: Hangbin Liu <liuhangbin@gmail.com>,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	AutonomousCodeSecurity@microsoft.com,
	tgopinath@linux.microsoft.com,
	kys@microsoft.com,
	"Xiang Mei (Microsoft)" <xmei5@asu.edu>,
	stable@vger.kernel.org
Subject: [RFC net-next v2 2/3] bonding: build NS probe headers before inserting VLAN tags
Date: Wed, 29 Jul 2026 23:01:18 +0000
Message-ID: <20260729230119.2717507-3-xmei5@asu.edu>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260729230119.2717507-1-xmei5@asu.edu>
References: <20260729230119.2717507-1-xmei5@asu.edu>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

bond_ns_send() passes the skb from ndisc_ns_create() to
bond_handle_vlan() before any header exists: ndisc_ns_create() returns
only the ICMPv6 message, and the IPv6 and link-layer headers are pushed
later by ndisc_send_skb().  Tagging that bare message causes two
failures:

- Corruption: bond_handle_vlan() inserts tags at mac_len = ETH_HLEN,
  expecting an Ethernet header.  arp_create() provides one,
  ndisc_ns_create() does not, so each tag lands 12 bytes into the ICMPv6
  message, inside the target address.  Every config with two or more
  stacked VLANs emits a probe no peer can answer.

- Panic: each tag also eats the headroom reserved for the IPv6 header
  (LL_RESERVED_SPACE(dev) + sizeof(struct ipv6hdr) = 56 for a plain
  Ethernet slave, leaving 56 - 4 * (N - 1) for N VLANs).  Six leave
  36 < 40 and the ip6_nd_hdr() push underflows skb->head:

    skbuff: skb_under_panic: text:ffffffff85eef44b len:84 put:40
      head:ffff88801400b740 data:ffff88801400b73c
      tail:0x50 end:0x180 dev:veth0
    kernel BUG at net/core/skbuff.c:214!
    Oops: invalid opcode: 0000 [#1] SMP KASAN NOPTI
    Workqueue: bond0 bond_arp_monitor
    RIP: 0010:skb_panic+0x142/0x230
    Call Trace:
     skb_push (net/core/skbuff.c:224)
     ndisc_send_skb (net/ipv6/ndisc.c:454 net/ipv6/ndisc.c:506)
     bond_ns_send (drivers/net/bonding/bond_main.c:3255)
     bond_ns_send_all (drivers/net/bonding/bond_main.c:3313)
     bond_arp_monitor (drivers/net/bonding/bond_main.c:3458)
     process_one_work (kernel/workqueue.c:3322)
     worker_thread (kernel/workqueue.c:3405)
     kthread (kernel/kthread.c:436)
    Kernel panic - not syncing: Fatal exception

Build the probe in the order the stack uses: bond_ns_build_ip6hdr()
pushes the IPv6 header, the probe traverses NF_INET_LOCAL_OUT as a bare
IPv6 packet, then bond_ns_add_llhdr() pushes the link-layer header,
bond_handle_vlan() adds the tags, and it is transmitted on the slave
being tested.  NF_INET_LOCAL_OUT must run before tagging so netfilter
sees the IPv6 packet ndisc_send_skb() feeds it rather than a half-built
Ethernet frame; ndisc_attach_dst() supplies the dst
ip6_route_me_harder() dereferences unconditionally.

The tags now land at a real Ethernet header, so the target address is
intact, and pushing the headers first lets skb_vlan_push() grow the
headroom itself, so no push underflows skb->head.  nf_hook() returns 1
on NF_ACCEPT with the skb still owned by the caller; any other verdict
means netfilter consumed it.

Fixes: 4e24be018eb9 ("bonding: add new parameter ns_targets")
Cc: stable@vger.kernel.org
Reported-by: AutonomousCodeSecurity@microsoft.com
Signed-off-by: Xiang Mei (Microsoft) <xmei5@asu.edu>
---
 drivers/net/bonding/bond_main.c | 106 +++++++++++++++++++++++++++++++-
 1 file changed, 103 insertions(+), 3 deletions(-)

diff --git a/drivers/net/bonding/bond_main.c b/drivers/net/bonding/bond_main.c
index 522eab060f9e..d5a7a7dd1eb2 100644
--- a/drivers/net/bonding/bond_main.c
+++ b/drivers/net/bonding/bond_main.c
@@ -90,6 +90,8 @@
 #include <net/tls.h>
 #endif
 #include <net/ip6_route.h>
+#include <net/ip6_checksum.h>
+#include <linux/netfilter.h>
 #include <net/netdev_lock.h>
 #include <net/xdp.h>
 
@@ -3232,13 +3234,75 @@ static int bond_arp_rcv(const struct sk_buff *skb, struct bonding *bond,
 }
 
 #if IS_ENABLED(CONFIG_IPV6)
+static int bond_ns_xmit_finish(struct net *net, struct sock *sk,
+			       struct sk_buff *skb)
+{
+	return dev_queue_xmit(skb);
+}
+
+static void bond_ns_build_ip6hdr(struct sk_buff *skb, struct net_device *dev,
+				 const struct in6_addr *saddr,
+				 const struct in6_addr *daddr)
+{
+	struct icmp6hdr *icmp6h = icmp6_hdr(skb);
+	unsigned int len = skb->len;
+	struct inet6_dev *idev;
+	struct ipv6hdr *hdr;
+	unsigned int tclass;
+
+	icmp6h->icmp6_cksum = csum_ipv6_magic(saddr, daddr, len,
+					      IPPROTO_ICMPV6,
+					      csum_partial(icmp6h, len, 0));
+
+	rcu_read_lock();
+	idev = __in6_dev_get(dev);
+	tclass = idev ? READ_ONCE(idev->cnf.ndisc_tclass) : 0;
+	rcu_read_unlock();
+
+	skb_push(skb, sizeof(*hdr));
+	skb_reset_network_header(skb);
+	hdr = ipv6_hdr(skb);
+
+	ip6_flow_hdr(hdr, tclass, 0);
+	hdr->payload_len = htons(len);
+	hdr->nexthdr = IPPROTO_ICMPV6;
+	hdr->hop_limit = 255;		/* RFC 4861, 7.1.1 */
+	hdr->saddr = *saddr;
+	hdr->daddr = *daddr;
+}
+
+/* Push the Ethernet header after the LOCAL_OUT hooks, as arp_create() and the
+ * IPv6 output path do.
+ */
+static int bond_ns_add_llhdr(struct sk_buff *skb, struct net_device *dev,
+			     const struct in6_addr *daddr)
+{
+	unsigned char ha[MAX_ADDR_LEN];
+	int err;
+
+	err = ndisc_mc_map(daddr, ha, dev, 1);
+	if (err < 0)
+		return err;
+
+	err = dev_hard_header(skb, dev, ETH_P_IPV6, ha, dev->dev_addr,
+			      skb->len);
+	if (err < 0)
+		return err;
+
+	skb_reset_mac_header(skb);
+	return 0;
+}
+
 static void bond_ns_send(struct slave *slave, const struct in6_addr *daddr,
 			 const struct in6_addr *saddr, struct bond_vlan_tag *tags)
 {
 	struct net_device *bond_dev = slave->bond->dev;
 	struct net_device *slave_dev = slave->dev;
+	struct inet6_dev *idev;
 	struct in6_addr mcaddr;
 	struct sk_buff *skb;
+	struct net *net;
+	int ret;
 
 	slave_dbg(bond_dev, slave_dev, "NS on slave: dst %pI6c src %pI6c\n",
 		  daddr, saddr);
@@ -3250,10 +3314,46 @@ static void bond_ns_send(struct slave *slave, const struct in6_addr *daddr,
 	}
 
 	addrconf_addr_solict_mult(daddr, &mcaddr);
-	if (bond_handle_vlan(slave, tags, skb)) {
-		slave_update_last_tx(slave);
-		ndisc_send_skb(skb, &mcaddr, saddr);
+
+	/* ip6_route_me_harder() in the LOCAL_OUT path dereferences skb_dst() */
+	if (ndisc_attach_dst(skb, &mcaddr, saddr)) {
+		net_err_ratelimited("NS route allocation failed\n");
+		kfree_skb(skb);
+		return;
 	}
+
+	bond_ns_build_ip6hdr(skb, slave_dev, saddr, &mcaddr);
+
+	rcu_read_lock();
+	net = dev_net_rcu(slave_dev);
+	idev = __in6_dev_get(slave_dev);
+	IP6_INC_STATS(net, idev, IPSTATS_MIB_OUTREQUESTS);
+
+	/* nf_hook() returns 1 on NF_ACCEPT with @skb still ours; any other
+	 * verdict means netfilter consumed it.
+	 */
+	ret = nf_hook(NFPROTO_IPV6, NF_INET_LOCAL_OUT, net, NULL, skb, NULL,
+		      slave_dev, bond_ns_xmit_finish);
+	if (ret == 1) {
+		ICMP6MSGOUT_INC_STATS(net, idev, NDISC_NEIGHBOUR_SOLICITATION);
+		ICMP6_INC_STATS(net, idev, ICMP6_MIB_OUTMSGS);
+	}
+	rcu_read_unlock();
+
+	if (ret != 1)
+		return;
+
+	if (bond_ns_add_llhdr(skb, slave_dev, &mcaddr) < 0) {
+		net_err_ratelimited("failed to build NS link-layer header\n");
+		kfree_skb(skb);
+		return;
+	}
+
+	if (!bond_handle_vlan(slave, tags, skb))
+		return;
+
+	slave_update_last_tx(slave);
+	dev_queue_xmit(skb);
 }
 
 static void bond_ns_send_all(struct bonding *bond, struct slave *slave)
-- 
2.43.0

