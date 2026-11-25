Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.227.135
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795592789;
	b=283u00C4yPsF7gw2bZAfUrHb8oLQosdwLwyMLtTuWupMBJsg8NrCEd6BPlmQbV6a1EKv
	 aa24TAQyw8zgn2ICd8ABnySjBwZ9NREbkHcrnrEUVLHA/V9XKdjuHMwTh+2hZ5qwK06bX
	 Zm8K4RVsbWiLWVeUVSULgnQqMDWbqT4B12oOsKg7AfNaNge1+HEJ0M2xNSEz7837pW8Zn
	 jcjdboc1V14vu7LcDL8xo5KEwp25Ca8L2bORzvEkA+BjsSdMyYkyyWie8ox8ThKqQlLMX
	 8OVuFO1KGbon0cp1iMTUeDeew55Q3kstIfM0mIxG78Ikyoj5IImQUgFssvAffcnYDug==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795592789;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:MIME-Version:
	 Content-Transfer-Encoding;
	bh=mPUVHCKsis7yk6TWYroZKPBNx3lL8fJQOoHY6BkH8A8=;
	b=XcBXNOb7YIzQer0l8aKsysJ6l5MArB9rlqtmzil7kTRlv9oO/Z9POncGrQ42ILSFLSW6
	 XOR9FecbJRIqIRngHE9y2X0B/2AyEFvd27iAin0Db1q8IxnYRxG3ZDdpd/nnkjX7g/g4B
	 YXSCU5sXvlxOxUhTffzQ93TnKY4rYxDC3JjdlmDjTjhNhf/B4dJg/B8UYoDgBUummzjss
	 HK11Hwgoc9XEPS2ZWLGseE+rsyrh/0/SWC0skqhlvUJj1G/nRjEa3dUnAc8FiaJPvOcd2
	 MSPFd/7ybY6WYprA4d4+VrSADvGUrbLRokG67MkIe4JNGBCrs1SStIHgKbBrVJQRzGQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=JOTXZSs9;
	arc=none smtp.remote-ip=74.125.227.135
Received: from mail-pj2-f7.google.com (mail-pj2-f7.google.com [74.125.227.135])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9C019606A323
	for <stable@vger.kernel.org>; Wed, 25 Nov 2026 07:46:28 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 9C019606A323
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=JOTXZSs9
Received: by mail-pj2-f7.google.com with SMTP id 98e67ed59e1d1-3b4be95e0afso1125024a91.1
        for <stable@vger.kernel.org>; Tue, 24 Nov 2026 23:46:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795592788; x=1796197588; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=mPUVHCKsis7yk6TWYroZKPBNx3lL8fJQOoHY6BkH8A8=;
        b=JOTXZSs977jZ2hjYo4g+E4jfbHTxF/nwtH4MiHhLO+dwJvIk3V9hZaMvL/qF1xRw0C
         Bm8wd9p091qfBAtwwY+7OeITpA78Ind3goh0+JD/lH2tqvY0TVAD7WgaGHdlBmc7i65Q
         AcbI+WStmp/C7WnKf78SSY4tYDP7fQ13EqaSS8l6qCmgycwaabTdqvorrGnWeRH63CDC
         h6WUAj9cDingPl97IlnGDlCkcEVNx8qk7xSkTX2stG2zdkPmOgp3Lqw7Dao3nKnqq11r
         wiTwBJdb0QKbwf2tq+C0aZnkpLyJCpz+Fz/2v4sBwLmH6KhChf6FY5GSs7xj8LiwKMld
         GATw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795592788; x=1796197588;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=mPUVHCKsis7yk6TWYroZKPBNx3lL8fJQOoHY6BkH8A8=;
        b=N6LPtk2fz6UOwYSuP+nWvNyTwAX+HrnEe3jLr/LjVzKMV+pd/j++qK1ElVi5q+zB3/
         AzhJFzmuQKd6xeQJrCHs4eWGo4P1+S+wXrzjc4yp8gSXEQQxs/PbTc5avdKXq/f+mAoQ
         1tyBZGpb+ZeeiBQx2plG4zgbGFgWmdCXI3GqG70Rai4bUobK3s3N9ssuhDmt0IUFVo+K
         zUPHe325F750fESJgfdiphifFbT8B8eWLIYzxrUv/M7gduEcLb7qpvtrg+WY2rei8V35
         orW2N1Y6Mo1pRBgYmqBQehCjQ3fi8dC0R6eGOtdBI5U1QSLLXAj/7JFA516+jSffAZtX
         YAfA==
X-Forwarded-Encrypted: i=1; AL+hErEz9NDNGnMYckJ9lu+uf1uV7LyOuVnQATm4SRipqN8x+M2Ig/lDaDpePn62BBSNa1rAXeUDFpg=@vger.kernel.org
X-Gm-Message-State: APuU4Z/JyXqopXO+NMdsJXDRmVQ3c+2e4fViLUz6Sxr5cgKCuz5+5CMP
	UTneUWsWSBhOVKmYg9spCrP0I8RjZ+Kxc99GQVrlxKKfvRkJLhHkCOF8
X-Gm-Gg: AZFdTZcueD8ewaGknfdVGJFyP+K2b1/FmChfWGPQ/FOw0CV6yVkmdJZRT34ZzI7jdzb
	93rgddZfHxgz7gGyON3GEaKGx+11tQ19+FNVmOTYYfNckfhXVYZ7MuAXSKwyNxsC4Gu5WDw6Rtt
	9qDwSDSmy9vu+Bbbe+/SuivB6X92AKDqShl6Uv4ZBtFo+XXxqaVe6JcV0Z6UxJrfZccMp1xM5b6
	Xpzcs7OJaO3FcMIHdKiOWjzqUtI24IyebHykXcckjl1Nwxn15ylR8F+J39/YwU7JRU0m5/jux3Y
	X8jln1SNMa/uD5NUVKgKFrThhLyKvvihKBZDnlZtOEMDrpIsrc5W9fCZ0nUhUY85yuvdMsrSm+j
	m0WBH5rqo0Bq0prpHxJ2yLg5ASndRg4igLjVVIXTBuMuKoiKz1RtPN0OULGoL/JXR2oH+LZ3zGK
	/KOoac+/v2p1RG9rq0NQq7jT57lW/73IXjB5ErYHrcOQT3ymZPhA/K8/yw+ZeidRAkF+qaWahBA
	Oo5LExXHnkJyOz5QTYsaR5QPN0aodABcXqa32WZasrDWC0AHm+RTS7nxCW/8oaDltyz7esIcpaJ
	0wvaO9VmUyhzlfn23A7/ahPEnUxrYPuJVOwAJ2AaWowaOIywVzOcQXB3zbMCFMRlyFCW+62u5vl
	l
X-Received: by 2002:a17:90b:560f:b0:3b4:60aa:9b74 with SMTP id 98e67ed59e1d1-3b460aaa7efmr10606579a91.65.1795592787857;
        Tue, 24 Nov 2026 23:46:27 -0800 (PST)
Received: from BSDHENRYMA-PC1.localdomain ([43.132.141.13])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-cde6cfec090sm8662460a12.14.2026.11.24.23.46.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 24 Nov 2026 23:46:26 -0800 (PST)
From: Henry Martin <bsdhenrymartin@gmail.com>
To: dsahern@kernel.org,
	idosch@nvidia.com,
	davem@davemloft.net,
	edumazet@kernel.org,
	kuba@kernel.org,
	pabeni@redhat.com,
	horms@kernel.org,
	yanhaishuang@cmss.chinamobile.com
Cc: netdev@vger.kernel.org,
	Henry Martin <bsdhenrymartin@gmail.com>,
	stable@vger.kernel.org
Subject: [PATCH net v3] ip_gre: fix stale header length after erspan version change
Date: Wed, 25 Nov 2026 15:46:17 +0800
Message-ID: <20261125074617.629026-1-bsdhenrymartin@gmail.com>
X-Mailer: git-send-email 2.53.0
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

erspan_changelink() can switch an existing tunnel between erspan
versions, but the GRE header length is only computed once in
erspan_tunnel_init().  After a downgrade to version 0, tun_hlen stays
8 while the version 0 transmit path clears the SEQ and KEY flags, so
the upper 4 bytes of every pushed header are uninitialized skb
headroom sent to the tunnel peer.  An upgrade leaves tun_hlen at 4,
so the version 1 transmit path writes the GRE sequence field over the
GRE base header, and the ERSPAN header grows without growing
needed_headroom.

Triggered with a version 1 tunnel switched to version 0: the four
bytes above the GRE base header carried the heap marker sprayed into
skb headroom instead of the GRE sequence number.

Recompute the header lengths in erspan_changelink() on every change,
mirroring the IPv6 side in ip6erspan_tnl_change().  Sample the old
length before ipgre_newlink_encap_setup() resets t->hlen, and run the
recompute right after erspan_netlink_parms(), before checking its
error: ip_tunnel_changelink() -> ip_tunnel_bind_dev() consumes
t->hlen, and a failed changelink must not leave the reset value for
the next call to sample.

Verified on v7.4-rc4: alternating erspan_hwid 0xff (-EINVAL) and 7 on
a version 2 tunnel keeps the MTU at 1446 (v2: 1446, 1434, 1422, ...),
and changing the link of a version 1 tunnel yields MTU 1450 (v2:
1458).

This issue was discovered by Tencent CodeBuddy Security.

Cc: stable@vger.kernel.org
Fixes: f989d546a2d5 ("erspan: Add type I version 0 support.")
Link: https://lore.kernel.org/netdev/20261123062752.27920-1-yanhaishuang@cmss.chinamobile.com/
Link: https://lore.kernel.org/netdev/20261124014646.7954-1-yanhaishuang@cmss.chinamobile.com/
Signed-off-by: Henry Martin <bsdhenrymartin@gmail.com>
---
v2 -> v3: move the recompute block right after erspan_netlink_parms()
          and run it before checking its error, so a failed changelink
          leaves t->hlen consistent and ip_tunnel_bind_dev() no longer
          sees the reset value (both reported by Haishuang Yan on v2).
          Fix the changelog wording: the sequence number overwrites the
          GRE base header, not the ERSPAN base header.  Add the v2/v3
          A/B numbers.
v1 -> v2: sample hlen before ipgre_newlink_encap_setup() and recompute it
          on every changelink. v1 sampled it after the encap setup had
          already reset t->hlen, so the delta was always the new ERSPAN
          header length and every "ip link set" on a version 1 device
          shrank the MTU by 8 and grew needed_headroom by 8 (reported by
          Haishuang Yan). Add the runtime trigger observations.
---
 net/ipv4/ip_gre.c | 29 +++++++++++++++++++++++++++--
 1 file changed, 27 insertions(+), 2 deletions(-)

diff --git a/net/ipv4/ip_gre.c b/net/ipv4/ip_gre.c
index 5485586fa0e62..f2103819788a9 100644
--- a/net/ipv4/ip_gre.c
+++ b/net/ipv4/ip_gre.c
@@ -1351,7 +1351,7 @@ static const struct net_device_ops gre_tap_netdev_ops = {
 	.ndo_fill_metadata_dst	= gre_fill_metadata_dst,
 };
 
-static int erspan_tunnel_init(struct net_device *dev)
+static void erspan_calc_hlen(struct net_device *dev)
 {
 	struct ip_tunnel *tunnel = netdev_priv(dev);
 
@@ -1360,9 +1360,16 @@ static int erspan_tunnel_init(struct net_device *dev)
 	else
 		tunnel->tun_hlen = 8; /* 8-byte GRE hdr. */
 
-	tunnel->parms.iph.protocol = IPPROTO_GRE;
 	tunnel->hlen = tunnel->tun_hlen + tunnel->encap_hlen +
 		       erspan_hdr_len(tunnel->erspan_ver);
+}
+
+static int erspan_tunnel_init(struct net_device *dev)
+{
+	struct ip_tunnel *tunnel = netdev_priv(dev);
+
+	erspan_calc_hlen(dev);
+	tunnel->parms.iph.protocol = IPPROTO_GRE;
 
 	dev->features		|= GRE_FEATURES;
 	dev->hw_features	|= GRE_FEATURES;
@@ -1499,6 +1506,7 @@ static int erspan_changelink(struct net_device *dev, struct nlattr *tb[],
 	struct ip_tunnel_parm_kern p;
 	__u32 fwmark = t->fwmark;
 	int err;
+	int hlen;
 
 	if (!rtnl_dev_link_net_capable(dev, t->net))
 		return -EPERM;
@@ -1509,11 +1517,28 @@ static int erspan_changelink(struct net_device *dev, struct nlattr *tb[],
 		return -EOPNOTSUPP;
 	}
 
+	hlen = t->hlen;
+
 	err = ipgre_newlink_encap_setup(dev, data);
 	if (err)
 		return err;
 
 	err = erspan_netlink_parms(dev, data, tb, &p, &fwmark);
+
+	/*
+	 * ipgre_newlink_encap_setup() reset t->hlen without the ERSPAN
+	 * part; restore it before ip_tunnel_changelink() (and its
+	 * ip_tunnel_bind_dev()) consumes it, and even when the parms
+	 * above failed, so a failed changelink leaves no stale value
+	 * for the next one to sample.
+	 */
+	erspan_calc_hlen(dev);
+	hlen = t->hlen - hlen;
+	if (hlen) {
+		dev->needed_headroom += hlen;
+		if (!tb[IFLA_MTU])
+			WRITE_ONCE(dev->mtu, max_t(int, dev->mtu - hlen, 68));
+	}
 	if (err < 0)
 		return err;
 
-- 
2.53.0

