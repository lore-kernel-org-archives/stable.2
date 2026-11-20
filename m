Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.231.130
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795154597;
	b=h5wwhmE/FxTyLAAPJtmvC7loJ4h4GmWFow9dvd+bEwkYis+du9C0QXgMjDsOOzOqYBlu
	 AYaeYzs1/0k+8ALXUhkRb1gPpuRrJ8sRhR65QoC2HohSv/xNG5lkNK+GmqVdrA9JVxf3E
	 Yy+krUNtvJqIV7w2gRXkRJfgiPWvATaBhnEX5EjMKMaq1QgP5xxCWicvenw4mM8Ttr9Tt
	 EVrwyPX+sGF2Wc9hzNL7LUDN0Gl5HViEK/oxOHvaIepY+TN+spjFb8u7z043gYgUnff/4
	 q1Xf9awk8R6e/X0Vst1smMdjXRRmdu4Zzuwhy0D/uou/1X1o7WznIJom8x4AuYrujsw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795154597;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:MIME-Version:
	 Content-Transfer-Encoding;
	bh=dHo1uLaePnq0/jqGRRY6HsTYF/uviwK8u7AVps7GapM=;
	b=j5C47eruNAKDvLH7L+0WBX8phYHu40I7OaKJ8+/u2VGpqFMO71B1vm1YZSa2NrcJZCZj
	 AgFPJURTJzywmhYxpqCiW/XqmSQVTGKULkFbHSaO6W0/FsPfBuG3EubYnKy1wRUPEXgT3
	 MSJN15VUh2mp8tY+qdTz4xgxYSx4RPcgVcJoe3h+j/29HAN922IfsQPQ18lKNweeTNbVQ
	 L22t5Wf6hBB6HSjtsDcTI5Snb/0RsQ2fFGsoEqCvgXRTuLCjpA2BygTXJDBnpGgkjRc6a
	 9z15uryoDUkoV9H9qTIT7SltKUPjyXGHALe+ZFZe9BwMS7bnK57fJAVJapEttYyRvbA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=OrPPncty;
	arc=none smtp.remote-ip=74.125.231.130
Received: from mail-oo2-f2.google.com (mail-oo2-f2.google.com [74.125.231.130])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 552E8606A52B
	for <stable@vger.kernel.org>; Fri, 20 Nov 2026 06:03:06 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 552E8606A52B
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=OrPPncty
Received: by mail-oo2-f2.google.com with SMTP id 46e09a7af769-862a5ac28e9so254805a34.1
        for <stable@vger.kernel.org>; Thu, 19 Nov 2026 22:03:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795154585; x=1795759385; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=dHo1uLaePnq0/jqGRRY6HsTYF/uviwK8u7AVps7GapM=;
        b=OrPPnctygCKm1/pZi98/dBkUFXfXasfPg3I6gHdkgrd8JBs35P9/Ih2tj3owOSDWlE
         nmo+dCQAmAYTGX6MyD+VfOdVUGoYH6bPh/rrkSbtQ0fWJhMsnIbVR4i+JpVmfKCtuoxO
         1bFupSDpPYVDzkBfcj8tndWPFc3N9xu7ytTSPGM9dv3ESCjD0u5dL8vpkNNtW3fejACY
         RG98k7pAPBOQzJ2lnI/c9o2XB0eqCX2/AS4OMiKDW8PgkrDilsTo1XbGwIUsa5VES9xH
         7i3Y2lYE/TNI8zoA8VxjhFK9pt7FNq5JgHiL52LG5OLwGSknzUCCT4XO7fHKGWkEZZpZ
         fr/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795154585; x=1795759385;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=dHo1uLaePnq0/jqGRRY6HsTYF/uviwK8u7AVps7GapM=;
        b=M6U+8wEuLSy2QPkrq5pKpiRWMxhH5SruHVtCHz8DxAaTm03y+IGzRHME16PWg0+Rfp
         c/bKHzOrmVXcoS1vOLXpGKt37a19ASxNUxNgoPZeUJX3U7af+arazdaJ5gkiMQ2Tc3aV
         Hoh+udEJ1VOg3ch0zyUW6GMFjnYjG/A3DU9O1BIhplBa4p+1OK+YQXt18poBq0wsXLyk
         AwsbESOREIKFOt28m/V9HUGDXbxFujQAAspVVbtlgUnG6+gTMPv9rUP2r3A/AZpMXuBj
         mwNCFjspdi9nGvoHWOPHwDaW3Lar30tg1xERtkeXEqsClNNBe3uKBcG8X/vZaZSCLnsL
         J3Vw==
X-Forwarded-Encrypted: i=1; AL+hErGEmEB1TxTgCW4AOjVO8qgO5cGNK/3Lx3ukLcK/qV/RlG1yz/r5eS8xJ06j8pt4j6V4B/ho/Hc=@vger.kernel.org
X-Gm-Message-State: APuU4Z9EH9E9FFBwP6awDOcnNR36wg653FWWXSTfWX43ud4yS776ztXS
	8ttSiEcy1ODy3NZGGTf5H6dkb+LqZcRgXkN81EkgZikO+92xWbp9aItS
X-Gm-Gg: AYBFou3Coyfmn+d4GOLCyHbJPlwBGGySe+2QbUt0M2iWu28V880kT4co7r+uw4MVyW4
	fUYaCY1haqTt4okKnvlNSw+OaE647drOzPyVI+F04+0TudtdcZIZKDLeglqcAfCnOOIgNCU6Ame
	CXhszudISX7nOsNzSQfnqvn+8I7JMd6D+nhyl2E5Ajq1rNESq9c5BPLeErwnNqYwqvEBCYkykkn
	dbXRgiZ35iZqs/a1If/PQhymdeX8DGhMY3CW99K65pMSSY1lc1zFKxRdPh/zmUH0+rLGyv0fHKK
	tCuokKUzpZnKs+yuM4WC/9dHZSV0y0jokKFB3zMQjmq44YtxaNN/NctgNg+gImeoa0H3asC7m6d
	IWxQCCmhYRwezXvxjZgF4QglPUfvEU2UZCsQrrOn7DiAZKpvOO6Pd5LVpd6R5cUVJdUzt5PJ6bW
	bvrHLeTUrMktinxtFRbFxSucyvNWOApm9akompXZZi5n/PUKHPQSbJ1qOAZ/gxqZkX1cqmAE1+E
	y0PZAW3884f2jAJytNwkZX/rIC2tCjrjBOFN9L4adBLQ2gGWxh78SjYrDkZ6KfPGg5H4nVuBiFq
	0KuNeYoDgAo4Lg8pAYamjkTNmH2T//9Fgx8o8LD7vQNqsCLCkZ8421YoJBqGw4FQ6JQEqw==
X-Received: by 2002:a05:6820:c5d2:10b0:71a:fbb7:da20 with SMTP id 006d021491bc7-71b3957d3f7mr1406475eaf.58.1795154585012;
        Thu, 19 Nov 2026 22:03:05 -0800 (PST)
Received: from localhost.localdomain ([14.116.239.39])
        by smtp.gmail.com with ESMTPSA id 006d021491bc7-71b3806ef20sm1416149eaf.7.2026.11.19.22.02.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 19 Nov 2026 22:03:03 -0800 (PST)
From: Henry Martin <bsdhenrymartin@gmail.com>
To: David Ahern <dsahern@kernel.org>,
	Ido Schimmel <idosch@nvidia.com>,
	"David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@kernel.org>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	Yun Zhou <yun.zhou@windriver.com>,
	Maoyi Xie <maoyixie.tju@gmail.com>,
	Xuanqiang Luo <luoxuanqiang@kylinos.cn>,
	Ilya Maximets <i.maximets@ovn.org>,
	Frode Nordahl <fnordahl@ubuntu.com>
Cc: netdev@vger.kernel.org,
	Henry Martin <bsdhenrymartin@gmail.com>,
	stable@vger.kernel.org
Subject: [PATCH net] ip_gre: fix stale header length after erspan version change
Date: Fri, 20 Nov 2026 14:02:54 +0800
Message-ID: <20261120060254.3766851-1-bsdhenrymartin@gmail.com>
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
erspan_tunnel_init(). After downgrading a tunnel from version 1 or 2
to version 0, tun_hlen stays 8 while the version 0 transmit path
clears the SEQ and KEY flags, so gre_build_header() writes only the
4-byte base header. The upper 4 bytes of the pushed header are
uninitialized skb headroom and are sent to the tunnel peer with every
packet. Switching in the other direction grows the ERSPAN header
without growing needed_headroom.

Recompute the header lengths in erspan_changelink() when the erspan
version attribute is present, mirroring what the IPv6 side does in
ip6erspan_tnl_change(), and propagate the delta to needed_headroom
and the MTU.

This issue was discovered by Tencent CodeBuddy Security.

Cc: stable@vger.kernel.org
Fixes: f989d546a2d5 ("erspan: Add type I version 0 support.")
Signed-off-by: Henry Martin <bsdhenrymartin@gmail.com>
---
 net/ipv4/ip_gre.c | 24 ++++++++++++++++++++++--
 1 file changed, 22 insertions(+), 2 deletions(-)

diff --git a/net/ipv4/ip_gre.c b/net/ipv4/ip_gre.c
index 5485586fa0e6..8acaefca64da 100644
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
@@ -1524,6 +1531,19 @@ static int erspan_changelink(struct net_device *dev, struct nlattr *tb[],
 	ip_tunnel_flags_copy(t->parms.i_flags, p.i_flags);
 	ip_tunnel_flags_copy(t->parms.o_flags, p.o_flags);
 
+	if (data && data[IFLA_GRE_ERSPAN_VER]) {
+		int len = t->hlen;
+
+		erspan_calc_hlen(dev);
+		len = t->hlen - len;
+		if (len) {
+			dev->needed_headroom += len;
+			if (!tb[IFLA_MTU])
+				WRITE_ONCE(dev->mtu, max_t(int, dev->mtu - len,
+							   68));
+		}
+	}
+
 	return 0;
 }
 
-- 
2.43.7

