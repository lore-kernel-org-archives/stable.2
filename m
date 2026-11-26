Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.231.130
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795662753;
	b=Ryh0GxQaRc4+lRBG5lCQR+ucWA0I5TR/NjkVr8rx2p1C/2ekhy8azOfuZFzNPCXKskmU
	 6rAKD/CGQU/29e33vdCaCrsNpB66XagW/ojH+7wflhP66bP9CXdOq2BsCeRPl/KDszYDf
	 1G0GTSvIYgrlQlUfJe6LqzpDODnpVujk4Jq90l6WbXWovGzWtnorWI73m/M/5PvSVRfRl
	 pD/IXOTfNYIzdUzi5SDzfotMhEoy7w2UlM+AwUfcGdUSELHJ81VwCZm14r/bdhgPG5OFp
	 EkCinD0GGdk8YlniiVwAMdq0sopsyGmabtBn+AJp4SzM1o8c9GcbBQvVUXyYJMY26Fw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795662753;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:MIME-Version:
	 Content-Transfer-Encoding;
	bh=pSx+cwaYj6d7FBSuXNFNtOr8390tE4CLrT3hLG+WtOY=;
	b=ZzFSuOKTifQ23edVK5koWIo4iXVpO0a5FnKvYF8KpjT75uHa6WPgP/kN4VcJUQ6Nap8P
	 CaS7rehhasTSb45E563Y2PTG2ulVs+bjhElJOen5uiPWGSCKNQJhF3rVl4uXsYmTwOUFw
	 REV6kQ7igFh8SAPh0CyxtpAPJIhbQgsUsR5gjTf/gOjC7k3GIFZQxvi2VRZlSyQEsvbiO
	 8JZBjKbN0CaAvPH+JKR7gATZBWAzQMf2zp77jcyVB4LvZRLvE4VGmtbWGDsXYCTEwGkNL
	 /tPbhlVg3ITdLHbTOdanSUtXetKfzbEdswGwF9/yI1WGKKX7DK5Wfs7je0anssz8x0g==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=Wc6qSvcK;
	arc=none smtp.remote-ip=74.125.231.130
Received: from mail-oo2-f2.google.com (mail-oo2-f2.google.com [74.125.231.130])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 409B7606A31E
	for <stable@vger.kernel.org>; Thu, 26 Nov 2026 03:12:33 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 409B7606A31E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=Wc6qSvcK
Received: by mail-oo2-f2.google.com with SMTP id 46e09a7af769-862a5ac28e9so2941040a34.1
        for <stable@vger.kernel.org>; Wed, 25 Nov 2026 19:12:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795662752; x=1796267552; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=pSx+cwaYj6d7FBSuXNFNtOr8390tE4CLrT3hLG+WtOY=;
        b=Wc6qSvcKiqg7RxUIgo7kMqz97ReQUsnHo6MOX32ZNb54juz+MLsIDRe9nROf13CoMb
         jdNP79UhphROZ3m/hAyBBAV/VvYewLKfmBXMr8HYjwDlOALmxWupETj0cCsI02t8vjGe
         ypGP6exX+LAC51up+WuBKQKrqE6kZSTrFX/IsuPo9Q8nIPWG6CEhLLA4non0dRVvPPkJ
         /ZPuoaI6usMlkWFXt08GylA3MsJCzaJ+Zkjlx7T0WE5qa5Lu2OJRJ1+JDm7lTkpo/ei9
         bLWqI3NTTGvHdB7d5YSJbNAeUWMbxHv3g0m3SCAAGG7cElrC6FbKrD0U0+JvOpi88P6l
         v4fg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795662752; x=1796267552;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=pSx+cwaYj6d7FBSuXNFNtOr8390tE4CLrT3hLG+WtOY=;
        b=t12rueno0Obs2pn3C7d/YSfyTpR1mND48Z5Dn3xtvDRHJUBo/123sajSCpB8deYfh0
         +r4g6dh8V5dxfv9lw2w0fZtVCvwKly6gNpl8g0LeQxqJ5CsumexnJzNTIdfyOb1Ww2ZU
         oPL+a1z9vmhHWlvtdT2wARPQW+A6q1z9Ed8ZRVmJ8KlAszOqorldRFbzU1Hnowf5ttuX
         Aw+8Fd0L5kdTj56udMfGtOqZMxYIX9YeBRh4ojxKZ5Z8VBWJ502ZPTczpL8L1B2XfExW
         xFtFgET/Y159FvS1pvTVWGftasXKZ8CngVXeRzsHxAgVSxYi8jlgNNcnP+qsaSEASSci
         F19w==
X-Forwarded-Encrypted: i=1; AL+hErGEV9tEVjDkMYUeJ9+Oh8LmpBksP+UJwJUUFgYeOkIBRmXR3O0Xc/CYypUK09Sps3WqArZmSkQ=@vger.kernel.org
X-Gm-Message-State: APuU4Z/aCMUZRYasCTOFV8WZKWk5/J8sRQUGtFzhu8O7BMNoP5yPBCZV
	Di5Q1MhTjB0XMcRVjoLzNEanwmLpu106aas+8X5e5G7vLOT1Z7/rb6H7XuRiNs3vnV7D4A==
X-Gm-Gg: AZFdTZfeK6zwkQPEJRYMIs5ujzI+p1gIAelTM2l3cjvylp0znOLtMrWEEUP+oAEkbD1
	jrraE2FDldi89YY4+oTA4HK2FPy7rhpQcVXGA8ajGiN5ebiT0jIl/WyADT8m9o4Rt1yETpnK6xG
	chHex0Xo+pVcY2LHYfIf5nWeIgBykriQxdR31JKCNfMMUA/4Q9+C333IBhVL2fMOOUDZVgHS4Tu
	sIRmNMuk+qxTNPyVDPuWlvM3o7wjIUnl+AIf/4U9TJfX/q40vWh+UAdA9CRkqsJyhC60p0woW7O
	qMj6iEOyV5TdohvBLmIt6mDvi5kQD0jKKp/P9mc5/3jsROWKgY5fanzHRLmBMF1s0vFRNHQqG9K
	ewt/UxFw9wYmfITi2oAwLphaVMFskjPM0rTUUeyhyR++XzF0mQia5kKl1uRh8P3HcdHHzdpMrPV
	IZp3xV0Spwb/ePBrg9yFlYhJhlrbQ8yNHWGeLkLacPWLI5B5txE2belvaTRdaSk3W7/SjEGstA7
	glZWDSKBVKS6TTm9XJca1n6yjCskc7GhGl6N0oLkzSHzMyOGujjRXMCQ5QBtZypPRT/mTokedNA
	9uo04bVdFsr98JWe1FGhCRdlJpxrcc1oWHwx1ySzV4EcextloUuv5B77wHZrmoGRXIzN
X-Received: by 2002:a05:6830:3150:b0:81b:a5f9:3490 with SMTP id 46e09a7af769-863159adbfamr26546009a34.24.1795662752145;
        Wed, 25 Nov 2026 19:12:32 -0800 (PST)
Received: from localhost.localdomain ([14.116.239.36])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-8631682200esm13980311a34.2.2026.11.25.19.12.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 25 Nov 2026 19:12:31 -0800 (PST)
From: Henry Martin <bsdhenrymartin@gmail.com>
To: dsahern@kernel.org,
	idosch@nvidia.com,
	davem@davemloft.net,
	edumazet@kernel.org,
	kuba@kernel.org,
	pabeni@redhat.com,
	yanhaishuang@cmss.chinamobile.com
Cc: horms@kernel.org,
	netdev@vger.kernel.org,
	Henry Martin <bsdhenrymartin@gmail.com>,
	stable@vger.kernel.org
Subject: [PATCH net v4] net: fix stale header length after erspan version change
Date: Thu, 26 Nov 2026 11:12:24 +0800
Message-ID: <20261126031224.430850-1-bsdhenrymartin@gmail.com>
X-Mailer: git-send-email 2.43.7
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
erspan_tunnel_init().  After a downgrade to version 0, tun_hlen stays 8
while the version 0 transmit path clears the SEQ and KEY flags, so the
upper 4 bytes of every pushed header are uninitialized skb headroom sent
to the tunnel peer.  An upgrade leaves tun_hlen at 4, so the version 1
transmit path writes the GRE sequence field over the GRE base header,
and the ERSPAN header grows without growing needed_headroom.

Triggered with a version 1 tunnel switched to version 0: the four bytes
above the GRE base header carried the heap marker sprayed into skb
headroom instead of the GRE sequence number.

Recompute the header lengths in erspan_changelink() on every change,
mirroring the IPv6 side in ip6erspan_tnl_change().  Sample the old
length before ipgre_newlink_encap_setup() resets t->hlen, and run the
recompute right after erspan_netlink_parms(), before checking its error:
ip_tunnel_changelink() -> ip_tunnel_bind_dev() consumes t->hlen, and a
failed changelink must not leave the reset value for the next call to
sample.

Verified on v7.4-rc4 (KASAN, uid 1000): unpatched, 708 post-switch
frames carry the sprayed heap marker; with the patch the tag hits drop to
0, and repeating a failed (hwid 0xff) followed by a successful
changelink keeps the MTU at 1446, as before the change.

This issue was discovered by Tencent CodeBuddy Security.

Cc: stable@vger.kernel.org
Fixes: f989d546a2d5 ("erspan: Add type I version 0 support.")
Link: https://lore.kernel.org/netdev/20261123062752.27920-1-yanhaishuang@cmss.chinamobile.com/
Link: https://lore.kernel.org/netdev/20261124014646.7954-1-yanhaishuang@cmss.chinamobile.com/
Signed-off-by: Henry Martin <bsdhenrymartin@gmail.com>
---
v3 -> v4: fix the placement of the int hlen; declaration: the hunk
          matched the identical declaration block at the top of
          ipgre_changelink(), leaving an unused variable there and
          breaking the build of erspan_changelink() with -Werror.
          Declare it in erspan_changelink() and order the declarations
          per reverse christmas tree.  No functional change.
v2 -> v3: move the recompute block right after erspan_netlink_parms()
          and run it before checking its error, so a failed changelink
          leaves t->hlen consistent and ip_tunnel_bind_dev() no longer
          sees the reset value (both reported by Haishuang Yan on v2).
          Fix the changelog wording: the sequence number overwrites the
          GRE base header, not the ERSPAN base header.
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
index 5485586fa0e6..16f52b9e77b3 100644
--- a/net/ipv4/ip_gre.c
+++ b/net/ipv4/ip_gre.c
@@ -1346,28 +1346,35 @@ static const struct net_device_ops gre_tap_netdev_ops = {
 	.ndo_set_mac_address 	= eth_mac_addr,
 	.ndo_validate_addr	= eth_validate_addr,
 	.ndo_change_mtu		= ip_tunnel_change_mtu,
 	.ndo_get_stats64	= dev_get_tstats64,
 	.ndo_get_iflink		= ip_tunnel_get_iflink,
 	.ndo_fill_metadata_dst	= gre_fill_metadata_dst,
 };
 
-static int erspan_tunnel_init(struct net_device *dev)
+static void erspan_calc_hlen(struct net_device *dev)
 {
 	struct ip_tunnel *tunnel = netdev_priv(dev);
 
 	if (tunnel->erspan_ver == 0)
 		tunnel->tun_hlen = 4; /* 4-byte GRE hdr. */
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
 	dev->priv_flags		|= IFF_LIVE_ADDR_CHANGE;
 	dev->lltx = true;
 	netif_keep_dst(dev);
 
 	return ip_tunnel_init(dev);
@@ -1493,32 +1500,50 @@ static int ipgre_changelink(struct net_device *dev, struct nlattr *tb[],
 
 static int erspan_changelink(struct net_device *dev, struct nlattr *tb[],
 			     struct nlattr *data[],
 			     struct netlink_ext_ack *extack)
 {
 	struct ip_tunnel *t = netdev_priv(dev);
 	struct ip_tunnel_parm_kern p;
 	__u32 fwmark = t->fwmark;
+	int hlen;
 	int err;
 
 	if (!rtnl_dev_link_net_capable(dev, t->net))
 		return -EPERM;
 
 	if (data && data[IFLA_GRE_COLLECT_METADATA] && !t->collect_md) {
 		NL_SET_ERR_MSG(extack,
 			       "Enabling collect_md on an existing device is not supported");
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
+	 * ipgre_newlink_encap_setup() reset t->hlen without the ERSPAN part.
+	 * Restore it before ip_tunnel_changelink() (and its
+	 * ip_tunnel_bind_dev()) consumes it, and even when the parms above
+	 * failed, so a failed changelink leaves no stale value for the next
+	 * one to sample.
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
 
 	err = ip_tunnel_changelink(dev, tb, &p, fwmark);
 	if (err < 0)
 		return err;
 
 	ip_tunnel_flags_copy(t->parms.i_flags, p.i_flags);
-- 
2.43.7

