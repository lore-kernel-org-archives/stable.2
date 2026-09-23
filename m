Received: from mail-qt1-f197.google.com (mail-qt1-f197.google.com [209.85.160.197])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 80B5E3B840B
	for <stable@vger.kernel.org>; Wed, 23 Sep 2026 03:52:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.197
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790135553; cv=none; b=ixzL2SOX4n85jUWKxXEGXeKgUVzXHVT6NJjae4pCmR8VkcqC1CN83ykBTg5jqGvO0pwZHaL8prb3xWcezJu42qhsHTvQJqAmmKNADxzmG9YIz9Uq/EXZ+7Wpb99wR9CVWH9N/NLCcit6QWRURisClsvsGVRNu2lB6epiGEoy8ok=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790135553; c=relaxed/simple;
	bh=XlwNLn556TBdyg2Pa3BZ9qFzqZHGeWMpikwBXaUl+wo=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=n1XyX8dClMKRI7VQ+/iUCwfivtlDOirx/JNsal8nGtmzBHHK3BV0B69885stFdVGQplimR+vJHKhTnl/FRl9S5eDdJ4/W3xbW4vTLm8BGL0MtNeoOua9spCXcUS6KS3YyGP+GPoN77EbyYmK7MjlV1ZVkOiw19EybUp47tsnMrw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=sX7E2HU/; arc=none smtp.client-ip=209.85.160.197
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="sX7E2HU/"
Received: by mail-qt1-f197.google.com with SMTP id d75a77b69052e-53001b668a6so12993071cf.1
        for <stable@vger.kernel.org>; Tue, 22 Sep 2026 20:52:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1790135550; x=1790740350; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=WTUpwCnWGknGGzA8Yo+oQVFKy+7o8pXGErT2NGfVLvc=;
        b=sX7E2HU/BHAWARLU/wMCQBCSU645jycxdOVWZ/8oKF53dhUxyt3NXWJ4IvaKHP1bsE
         YhEFzL3n4qRguYYausaZFJh8A4xa71uvPiHOO1B4XveLLQ6MilddeUBoWIlQ0swqSSZr
         MZOYvI662hctIGsFHXt73ZMb//dOi4MnIchGYA7YurfoFv9g6oZuGyBmMvQRFdvw1UlM
         NiyRSXUERWYL48kWriq5Fvt15JDqck1dd7EJo4qYHfUZ3x5v020fixwQGZ2BFy5FR3s+
         165Re5WR/W7bEr/MjSiIHPKAhDJuM/FS0NvyHHrVqbfGjrb7BEpoYX/5Q9YVaC3rWhPr
         +f5g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790135550; x=1790740350;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=WTUpwCnWGknGGzA8Yo+oQVFKy+7o8pXGErT2NGfVLvc=;
        b=EsEo/9TBKebQc1T9cvQdJaEQ4nuRzVTLvAbv4PROeK0q4wKsuGrWaUztSANUOZQqHZ
         WvEPLVbBbn/RuxNq8lY49fniwNJCXwaC8Fd9eTkxj13azGWkT2Ci4N1R9yQjnx2DENW/
         DZfnpdGMACPeJeV1UQA9l3+PwejtRaFXETz676Sb42PpjmUH4U+IyCe9Jei8w0BmGWzX
         kwoUUGIWfrj2wFzum/Wcsi9RGrv94JfTnzxr2dHGkJTcN6yyReeBYfPZMvoDYIMgm1j9
         lRW3eqUwy7f1uWFVCvapu7jp6MBAsnXk1fTh04di7Is0nEIYRaUgd4R27/dZorP1SMbP
         SIZg==
X-Forwarded-Encrypted: i=1; AKwUvBzBJzhgNpo7LAs312uwHA4++qoEhVD6HRVNHHhZ+ZoBN16Qh/a0F3eGLhmrR9EeOk5A37HkdD0=@vger.kernel.org
X-Gm-Message-State: AFuF++lGQItrU0xROM//D+cgHxoDwyRoOHVwjsgu0KjGGRT2PdzTFOgT
	dr7rWwPq0VuhQGZOB0fum3poXjDnx/j5oMX3MoE43FvQo6FjZ/ueaKlBSC/Y1CwjDRfddymAHTP
	S7bAvm41cAImTzQ==
X-Received: from qtww9-n1.prod.google.com ([2002:a05:622a:6849:10b0:530:7d2a:50a0])
 (user=edumazet job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:622a:4117:b0:532:8ed7:534 with SMTP id d75a77b69052e-532eadcbef3mr24896481cf.37.1790135550099;
 Tue, 22 Sep 2026 20:52:30 -0700 (PDT)
Date: Wed, 23 Sep 2026 03:52:16 +0000
In-Reply-To: <20260923035217.179102-1-edumazet@google.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260923035217.179102-1-edumazet@google.com>
X-Mailer: git-send-email 2.55.0.1082.g2b9226bbc0-goog
Message-ID: <20260923035217.179102-5-edumazet@google.com>
Subject: [PATCH net v3 4/5] ip_gre: recompute erspan header lengths after a change
From: Eric Dumazet <edumazet@google.com>
To: "David S . Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>
Cc: Simon Horman <horms@kernel.org>, Kuniyuki Iwashima <kuniyu@google.com>, netdev@vger.kernel.org, 
	eric.dumazet@gmail.com, William Tu <u9012063@gmail.com>, 
	Eric Dumazet <edumazet@google.com>, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

erspan_tunnel_init() is the only place computing tunnel->tun_hlen and
tunnel->hlen, but erspan_changelink() can change both: tunnel->erspan_ver
selects a 4 or 8 byte GRE header and feeds erspan_hdr_len(), while
ip_tunnel_encap_setup() recomputes tunnel->hlen without the ERSPAN part.

dev->needed_headroom is not refreshed either, since ip_tunnel_update()
only rebinds when the link or the fwmark changes.

erspan_xmit() then pushes an ERSPAN header sized from the new
tunnel->erspan_ver, while __gre_xmit() lays the GRE header out from the
stale tunnel->tun_hlen. After a version 0 -> 2 change, tun_hlen is still
4 and gre_build_header() writes the sequence number at
greh + tun_hlen - 4, that is over greh->flags and greh->protocol. The
MTU keeps the value derived from the old header length.

Also reject non-zero IFLA_GRE_OFLAGS/IFLA_GRE_IFLAGS when erspan_ver is 0
or IFLA_GRE_COLLECT_METADATA is set, and ensure IP_TUNNEL_SEQ_BIT in
erspan_xmit() matches tunnel->erspan_ver.

There is no memory safety issue: dev->needed_headroom is at least
tunnel->hlen + sizeof(struct iphdr), and erspan_xmit() pushes at most
12 + 8 bytes before ip_tunnel_xmit() takes over and cows again.

Move the computation into erspan_set_hlen() and add
erspan_link_update(), refreshing the lengths as the previous patch does
for plain GRE. Commit gparms alongside i_flags/o_flags after
ip_tunnel_changelink() succeeds, and run erspan_link_update() at the end
of erspan_changelink(), including on the ip_tunnel_changelink() error
path, as ipgre_changelink() does.

Fixes: f551c91de262 ("net: erspan: introduce erspan v2 for ip_gre")
Cc: stable@vger.kernel.org
Signed-off-by: Eric Dumazet <edumazet@google.com>
---
 net/ipv4/ip_gre.c | 81 +++++++++++++++++++++++++++++++++++++----------
 1 file changed, 64 insertions(+), 17 deletions(-)

diff --git a/net/ipv4/ip_gre.c b/net/ipv4/ip_gre.c
index 27b3b4c584b1e1b4f1c9c9f42b5585b28101ece0..7385d66a94bf49c84bc674ded51ed3f9f5352e28 100644
--- a/net/ipv4/ip_gre.c
+++ b/net/ipv4/ip_gre.c
@@ -733,7 +733,6 @@ static netdev_tx_t erspan_xmit(struct sk_buff *skb,
 	/* Push ERSPAN header */
 	if (tunnel->erspan_ver == 0) {
 		proto = htons(ETH_P_ERSPAN);
-		__clear_bit(IP_TUNNEL_SEQ_BIT, flags);
 	} else if (tunnel->erspan_ver == 1) {
 		erspan_build_header(skb, ntohl(tunnel->parms.o_key),
 				    tunnel->index,
@@ -748,6 +747,7 @@ static netdev_tx_t erspan_xmit(struct sk_buff *skb,
 		goto free_skb;
 	}
 
+	__assign_bit(IP_TUNNEL_SEQ_BIT, flags, tunnel->erspan_ver != 0);
 	__clear_bit(IP_TUNNEL_KEY_BIT, flags);
 	__gre_xmit(skb, dev, &tunnel->parms.iph, proto, flags);
 	return NETDEV_TX_OK;
@@ -1169,17 +1169,18 @@ static int erspan_validate(struct nlattr *tb[], struct nlattr *data[],
 	if (ret)
 		return ret;
 
-	if (data[IFLA_GRE_ERSPAN_VER] &&
-	    nla_get_u8(data[IFLA_GRE_ERSPAN_VER]) == 0)
-		return 0;
-
-	/* ERSPAN type II/III should only have GRE sequence and key flag */
 	if (data[IFLA_GRE_OFLAGS])
 		flags |= nla_get_be16(data[IFLA_GRE_OFLAGS]);
 	if (data[IFLA_GRE_IFLAGS])
 		flags |= nla_get_be16(data[IFLA_GRE_IFLAGS]);
-	if (!data[IFLA_GRE_COLLECT_METADATA] &&
-	    flags != (GRE_SEQ | GRE_KEY))
+
+	if ((data[IFLA_GRE_ERSPAN_VER] &&
+	     nla_get_u8(data[IFLA_GRE_ERSPAN_VER]) == 0) ||
+	    data[IFLA_GRE_COLLECT_METADATA])
+		return flags ? -EINVAL : 0;
+
+	/* ERSPAN type II/III should only have GRE sequence and key flag */
+	if (flags != (GRE_SEQ | GRE_KEY))
 		return -EINVAL;
 
 	/* ERSPAN Session ID only has 10-bit. Since we reuse
@@ -1317,7 +1318,11 @@ static int erspan_netlink_parms(struct net_device *dev,
 			return -EINVAL;
 	}
 
-	if (gparms->erspan_ver == 1) {
+	if (gparms->erspan_ver == 0) {
+		if (!ip_tunnel_flags_empty(parms->i_flags) ||
+		    !ip_tunnel_flags_empty(parms->o_flags))
+			return -EINVAL;
+	} else if (gparms->erspan_ver == 1) {
 		if (data[IFLA_GRE_ERSPAN_INDEX]) {
 			gparms->index = nla_get_u32(data[IFLA_GRE_ERSPAN_INDEX]);
 			if (gparms->index & ~INDEX_MASK)
@@ -1394,18 +1399,43 @@ static const struct net_device_ops gre_tap_netdev_ops = {
 	.ndo_fill_metadata_dst	= gre_fill_metadata_dst,
 };
 
+static void erspan_set_hlen(struct ip_tunnel *tunnel)
+{
+	/* Version 0 uses a 4-byte GRE header, other versions use 8 bytes. */
+	tunnel->tun_hlen = tunnel->erspan_ver == 0 ? 4 : 8;
+
+	tunnel->hlen = tunnel->tun_hlen + tunnel->encap_hlen +
+		       erspan_hdr_len(tunnel->erspan_ver);
+}
+
+/* Both tunnel->erspan_ver and tunnel->encap_hlen can be changed from
+ * erspan_changelink(), and both feed tunnel->hlen. Recompute it, then let
+ * ip_tunnel_bind_dev() derive the device lengths from it.
+ *
+ * As in ipgre_link_update(), @old_hlen only tells whether the MTU became
+ * stale and must be sampled before ip_tunnel_encap_setup(), which
+ * recomputes tunnel->hlen without the ERSPAN part.
+ */
+static void erspan_link_update(struct net_device *dev, bool set_mtu,
+			       int old_hlen)
+{
+	struct ip_tunnel *tunnel = netdev_priv(dev);
+
+	erspan_set_hlen(tunnel);
+
+	/* Only reset a MTU that the header length just invalidated, so that
+	 * a MTU configured by the user survives an unrelated change.
+	 */
+	ip_tunnel_refresh_lengths(dev, set_mtu && tunnel->hlen != old_hlen);
+}
+
 static int erspan_tunnel_init(struct net_device *dev)
 {
 	struct ip_tunnel *tunnel = netdev_priv(dev);
 
-	if (tunnel->erspan_ver == 0)
-		tunnel->tun_hlen = 4; /* 4-byte GRE hdr. */
-	else
-		tunnel->tun_hlen = 8; /* 8-byte GRE hdr. */
+	erspan_set_hlen(tunnel);
 
 	tunnel->parms.iph.protocol = IPPROTO_GRE;
-	tunnel->hlen = tunnel->tun_hlen + tunnel->encap_hlen +
-		       erspan_hdr_len(tunnel->erspan_ver);
 
 	dev->features		|= GRE_FEATURES;
 	dev->hw_features	|= GRE_FEATURES;
@@ -1562,6 +1592,8 @@ static int erspan_changelink(struct net_device *dev, struct nlattr *tb[],
 	struct ip_tunnel *t = netdev_priv(dev);
 	struct ip_tunnel_parm_kern p;
 	struct ip_gre_parm gparms;
+	int old_hlen = t->hlen;
+	bool link_changed;
 	int err;
 
 	if (!rtnl_dev_link_net_capable(dev, t->net))
@@ -1575,15 +1607,30 @@ static int erspan_changelink(struct net_device *dev, struct nlattr *tb[],
 	if (err)
 		return err;
 
+	link_changed = t->parms.link != p.link || t->fwmark != gparms.fwmark;
+
 	err = ip_tunnel_changelink(dev, tb, &p, gparms.fwmark);
 	if (err < 0)
-		return err;
+		goto link_update;
+
+	if (link_changed)
+		old_hlen = t->hlen;
 
 	ipgre_commit_parms(t, &gparms);
 	ip_tunnel_flags_copy(t->parms.i_flags, p.i_flags);
 	ip_tunnel_flags_copy(t->parms.o_flags, p.o_flags);
 
-	return 0;
+link_update:
+	/* ipgre_newlink_encap_setup() has published a new encapsulation
+	 * without the ERSPAN header length even if ip_tunnel_changelink()
+	 * failed, so the lengths must be refreshed on that error path too.
+	 *
+	 * As in ipgre_changelink(), IFLA_MTU must not hold the MTU back if we
+	 * return an error, because do_setlink() will not apply it then.
+	 */
+	erspan_link_update(dev, err || !tb[IFLA_MTU], old_hlen);
+
+	return err;
 }
 
 static size_t ipgre_get_size(const struct net_device *dev)
-- 
2.55.0.1082.g2b9226bbc0-goog

