Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.227.133
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795762041;
	b=XfNOMq1GNm8AjT3LLh1uCSIgyFDlEGjNVPJT3cK9STvf6NJN/k/ohy2cpGJMY8v1/MLO
	 3aXv8haEqxjSYxLFn8JAhoK7nLmxOF82OnrTzuU0vX//fAoM8q/hH0gEqBlxucinAU27v
	 5LoMmVcEP6+bmSFZSWcE46G0O14n25RFhE4wwSsB91bWTXAzSYpaQEcpUeXul49TxsUU8
	 WmeRFphJC4MClk55F1aeHXGYkfmduiBMzLm/6qQDfccMZxj9Y+LPjjkZIikD4BX/SXGIO
	 9h7PQZPx2eLOLEP4HvLiM3J34wPvZ6g3zIuYR87gAMLNYFN6THjsjgcSQFe5ukTCH9Q==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795762041;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:MIME-Version:
	 Content-Transfer-Encoding;
	bh=/qlVD+W4EYAaz2b3JmMA2e/zNhIM7GUlB+7wqqJ0MxM=;
	b=xmUAUjGEPkdoQVMhJLrGToTiBBB7k14pS/+V3QGLy8d1gVcR9XOiTZ3/ugM43ZYfGm0h
	 BzhCI/xxVk56Jkvo9hwHIOmiyvFApRGsahqxIL4O4jKJHj3955RIAtAyELWOo1h2y2YNB
	 jnS0HV7GIWzcFrQgoMArVmwTaRHBfSu0+e7Gulm6dpIZmSALMVAuTlV/0cDTXZ2hqykFx
	 JALbZco0K7t9t+fLrYPFgtGellAlt0kFCy0+uOeEk2K4MnijCbFO8aPBeruNvKA+0oiZF
	 DcONsB86MEeI622jimPABJYSsL8PLZ2QMHPNJHG2v6wRnZAQ86XAR2TtYb2xOiWYqiw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=n8v7oi4Y;
	arc=none smtp.remote-ip=74.125.227.133
Received: from mail-pj2-f5.google.com (mail-pj2-f5.google.com [74.125.227.133])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B310B606A31C
	for <stable@vger.kernel.org>; Fri, 27 Nov 2026 06:47:20 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org B310B606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=n8v7oi4Y
Received: by mail-pj2-f5.google.com with SMTP id d9443c01a7336-2f04158d3cbso26590035ad.0
        for <stable@vger.kernel.org>; Thu, 26 Nov 2026 22:47:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795762040; x=1796366840; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=/qlVD+W4EYAaz2b3JmMA2e/zNhIM7GUlB+7wqqJ0MxM=;
        b=n8v7oi4YdBWInqnNmqQS501csZVceCsWfpRCPE1dbgQEh7QHAjCL3mQZw/fYbc/Aku
         cv4EqtyifhjVv9I0W9l0MDJPSihD3wgu9lxmvG40i3ySfb6ybPGWMvLhapSf6v0aUjsl
         Le0RlYQTh+1r1KsGuL0bkfcEIaVBQxQb+s2y8krZIOh500fWxtGwwgOa73u0BsF6TxvO
         RZY22SGsb2vsXZBy7nLuE1NV6mi04yZxlXEI6q+tEpuFuYA0ZkyvbpQPWjrDfS4a1cYJ
         J0cVhOXrZSmRQ/gqqhG+hE7MLFfOzssxuEqWkEGPZrVXCxw1Vua1vzwbpwUS6fn83UH3
         0bSg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795762040; x=1796366840;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=/qlVD+W4EYAaz2b3JmMA2e/zNhIM7GUlB+7wqqJ0MxM=;
        b=aHO3VMqmMzpA+urP5UKOwPDNgZheINlaOup0tdu6VlcXgajMXWnhtqg0rS5hYv81MO
         pvpeea8glrQiQ262kN2HO58JLIlXFgcBp15x6MZA+sGgZRg4B4Hw2Ce+Nmf+j57QSqqk
         ZaEtREgVyPg5rNz1F2OaZQ1A3B8v+MxQcrmJz0aZ+Ht00WtzM7wqoi5WHjdiEE04vnV2
         noJn+ROVWgFg/ufO2/FvVDuRU9nk3w0Xpbr3aX78aLqoH4a6+koicTSArg4cfap3UovG
         HhxFkat8dfoaE4116+SHoM7pbfWjruvzwc/9RAMNtuWIkMCB4x2XhESxUTEJdo/9Kv6K
         Z8AA==
X-Forwarded-Encrypted: i=1; AL+hErEsgGeIzNdPaOyM9LZXamu3Is9Qnvp7hXgIUXaXSMsG1QqgAyxnx64DzAQ1YiqclWmKYNhBZtQ=@vger.kernel.org
X-Gm-Message-State: APuU4Z9aWetWUd7ohsdiHwVecqBpp7lQNtJ7akwv0hx17ZT6OLvOQ6kB
	iEu4aDeiw/MYeV96FQ0bCjKIJb7jxh98kRhlDw8FYgnXhBak1goqXH4h
X-Gm-Gg: AZFdTZd9jMjbla8kqIEqGHH8L+7DWzEoAPke15gi6dot6v7kt7cg6dgkON3MuWd7Ujx
	aFRwAJE+fqTiP1sqWg716T09GXTd8WGCRLWblOYp3srAYo+XexLV9AT6mseSbrzVCL8lvUntR3F
	T/64j3K/Vqa9iGvZMWIuN8Tq7Ohzqwc6k93X32jn9YitI56H942/vPc9XLT9KeBh4qddqkqBSTj
	iei+KZNZItuHJP2qaIIBM7IPHa/37psaNhXjqJwn0HWRPQq7qGaxuv44brGM2M+8C6DRulJkTs2
	wwRQlHTet97XGBWGA/l9wPTnZ7vRTTtvnqZTFkFsfkVoLSPWWUB52qXkA1RtIjF+izAbj8FT48f
	2rmqVbh2PkgWJl/SP0UPLmd2rlON94y1usp80j8nJFFeBlh3G6TOoTKAjEadgWP14atdOGFFClo
	+pJk0i+KdF/iIXhknWc4xWCZV23zUQ22zTcaVcSbFkXmpftkMB1W2lKpIC13HNIpVNdmR2RE6je
	evtMdYBX4KUDID48jww7XT0l7eMkQ6HJtITq168fwr7ctEj8dm6a7JltCbIXv6l9DfTJKJvT7Be
	GyDyOAjC127cxIVN+5SDbbOwkl6PT5vye+d2u0ZmNbTfWKPSK/r9Sj4/JzeZF4RkzV9hAWjFiyJ
	sCysABeCPtPnmwtbFl+KA9y8=
X-Received: by 2002:a17:902:fc4b:b0:2ef:d82e:87ba with SMTP id d9443c01a7336-2f03ef870e9mr238228685ad.3.1795762040046;
        Thu, 26 Nov 2026 22:47:20 -0800 (PST)
Received: from BSDHENRYMA-PC1.localdomain ([43.132.141.11])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2f03ee85466sm112294185ad.4.2026.11.26.22.47.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 26 Nov 2026 22:47:19 -0800 (PST)
From: Henry Martin <bsdhenrymartin@gmail.com>
To: Andrew Lunn <andrew+netdev@lunn.ch>,
	Pieter Jansen van Vuuren <pieter.jansenvanvuuren@netronome.com>,
	"David S . Miller" <davem@davemloft.net>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Eric Dumazet <edumazet@kernel.org>
Cc: netdev@vger.kernel.org,
	Henry Martin <bsdhenrymartin@gmail.com>,
	stable@vger.kernel.org
Subject: [PATCH net] geneve: don't announce options that are not geneve options
Date: Fri, 27 Nov 2026 14:47:06 +0800
Message-ID: <20261127064706.2920854-1-bsdhenrymartin@gmail.com>
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

geneve_build_header() announces info->options_len in the wire header
unconditionally, but only copies the option bytes when the tunnel
metadata carries the geneve option flag.  With metadata of another
tunnel type (vxlan, erspan), set for example by a tc tunnel_key action,
the announced option space is never written: the packet goes out with
whatever bytes __skb_push() left in the skb headroom, and the peer can
read 4 or 12 stale kernel bytes per packet, repeatedly.

Only announce and emit options that are actually geneve options.  Other
metadata is dropped from the wire header instead of being replaced by
stale headroom bytes: the option space sizing and the GRO hint offset
now both follow the same condition as the copy.

This issue was discovered by Tencent CodeBuddy Security.

Cc: stable@vger.kernel.org
Fixes: 256c87c17c53 ("net: check tunnel option type in tunnel flags")
Signed-off-by: Henry Martin <bsdhenrymartin@gmail.com>
---
 drivers/net/geneve.c | 19 +++++++++++++++----
 1 file changed, 15 insertions(+), 4 deletions(-)

diff --git a/drivers/net/geneve.c b/drivers/net/geneve.c
index 0ab729f055ea0..dd1734b82af59 100644
--- a/drivers/net/geneve.c
+++ b/drivers/net/geneve.c
@@ -1231,7 +1231,7 @@ static void geneve_build_header(struct genevehdr *geneveh,
 				__be16 inner_proto)
 {
 	geneveh->ver = GENEVE_VER;
-	geneveh->opt_len = info->options_len / 4;
+	geneveh->opt_len = 0;
 	geneveh->oam = test_bit(IP_TUNNEL_OAM_BIT, info->key.tun_flags);
 	geneveh->critical = test_bit(IP_TUNNEL_CRIT_OPT_BIT,
 				     info->key.tun_flags);
@@ -1240,8 +1240,15 @@ static void geneve_build_header(struct genevehdr *geneveh,
 	geneveh->proto_type = inner_proto;
 	geneveh->rsvd2 = 0;
 
-	if (test_bit(IP_TUNNEL_GENEVE_OPT_BIT, info->key.tun_flags))
+	/* Only announce and copy options that are actually geneve
+	 * options.  Metadata of another tunnel type (vxlan, erspan)
+	 * must not go on the wire: there is nothing to copy it from,
+	 * and the option space would carry stale headroom bytes.
+	 */
+	if (test_bit(IP_TUNNEL_GENEVE_OPT_BIT, info->key.tun_flags)) {
+		geneveh->opt_len = info->options_len / 4;
 		ip_tunnel_info_opts_get(geneveh->options, info);
+	}
 }
 
 static int geneve_build_gro_hint_opt(const struct geneve_dev *geneve,
@@ -1336,7 +1343,10 @@ static int geneve_build_skb(struct dst_entry *dst, struct sk_buff *skb,
 	skb_reset_mac_header(skb);
 	skb_scrub_packet(skb, xnet);
 
-	opt_size =  info->options_len + cb->gro_hint_len;
+	if (test_bit(IP_TUNNEL_GENEVE_OPT_BIT, info->key.tun_flags))
+		opt_size = info->options_len + cb->gro_hint_len;
+	else
+		opt_size = cb->gro_hint_len;
 	min_headroom = LL_RESERVED_SPACE(dst->dev) + dst->header_len +
 		       GENEVE_BASE_HLEN + opt_size + ip_hdr_len;
 	err = skb_cow_head(skb, min_headroom);
@@ -1353,7 +1363,8 @@ static int geneve_build_skb(struct dst_entry *dst, struct sk_buff *skb,
 	geneve_build_header(gnvh, info, inner_proto);
 
 	if (cb->gro_hint_len)
-		geneve_put_gro_hint_opt(gnvh, info->options_len, &cb->gro_hint);
+		geneve_put_gro_hint_opt(gnvh, opt_size - cb->gro_hint_len,
+					&cb->gro_hint);
 
 	udp_tunnel_set_inner_protocol(skb, double_encap, inner_proto);
 	return 0;
-- 
2.39.5

