Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.219.43
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792756780;
	b=u5jdnXhtOQS1JHW6pgoM8i0EGQL8E9XcR64vyCfOZJZU2U2+EY6uQnuioEN2DJs7KOCv
	 AhMU/kIsH2Cy3Q3J4a7mGMpxhSZV78XN3Zs2uuiTlWYQK3PKMZ1hqybOS/6yGx8+eKPaa
	 Gt6TLIPLG0oGMIwFqoRnHj8lmTCvQeAJgq4Qr8NWHhIruXACdoWOLLPEVwSAZWCDq3RXo
	 bF4RfwdnkzAl9wdGBFbyDSu0Ap9rumB22XYrvT0zT6grkWsMBkK/MA9aGTHv1rbqL0brN
	 +P1vmTzc4QsDh/FWm+9oplfd072Om7uh2osCx+pSjWDKlcBnePsrnZb/rFlnwYVx4+g==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792756780;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-Id:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding;
	bh=gV9JJW+KLxJUN6kglpTyIoS0mZGlvplEh+/pn0zPRYE=;
	b=tNxb/cCo5KG0zPlgnIuiZVCCDevROcX1QT9In/WV+DD9JEZfob+OcDcHtveV9kJ/dRcy
	 hiU1FzCk5U4npfUEeSgMsXXLWpOZCr+jK+63VVTFfjeAx0F/Xn/IYmB67o+PzQqD4k3fO
	 e+3IBIhcKxwlUdmCrrGmckkOmF4yXzautuQlOYoXZos+UKQSO8515eNeuLCb6dNKEL3tr
	 Py0hVNX+sMLu+yfe6GrlgO6QDO8s6EDdOiXycMj34AXiFpHw43FTJtNhOHWpufkNqXvpy
	 Zamm12oXSoEF0y8PqhJE8TDXwpg48z46zJf9I7Cww+LV2e18eiaFItm32eKKTMsRVQA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=mojatatu.com;
	spf=none smtp.mailfrom=mojatatu.com;
	dkim=pass header.d=mojatatu.com header.i=@mojatatu.com header.a=rsa-sha256 header.s=google header.b=u1430m0q;
	arc=none smtp.remote-ip=209.85.219.43
Received: from mail-qv1-f43.google.com (mail-qv1-f43.google.com [209.85.219.43])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 04EDD606A31D
	for <stable@vger.kernel.org>; Fri, 23 Oct 2026 11:59:39 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 04EDD606A31D
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mojatatu.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=mojatatu.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=mojatatu.com header.i=@mojatatu.com header.a=rsa-sha256 header.s=google header.b=u1430m0q
Received: by mail-qv1-f43.google.com with SMTP id 6a1803df08f44-91791ec1b83so6848556d6.1
        for <stable@vger.kernel.org>; Fri, 23 Oct 2026 04:59:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=mojatatu.com; s=google; t=1792756779; x=1793361579; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=gV9JJW+KLxJUN6kglpTyIoS0mZGlvplEh+/pn0zPRYE=;
        b=u1430m0qP/A9kJIJFSLgIapQETPAFJziJC7HIEFc3GT5frECg0W+c98paaGch9M/x5
         /CkHWTgVCan9thcUYoK8w/xd3aTPb9JhLSM25tVKpUd/jwLzYccDDp3VjEDWk9X/odCX
         uoZ+lPVTdca0C8NH9fz4l2rTb1QdKoiCe+VHY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792756779; x=1793361579;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=gV9JJW+KLxJUN6kglpTyIoS0mZGlvplEh+/pn0zPRYE=;
        b=iIigAemmHCATJA+IjN+XDsiuBvlsu8bNl14S780EWosdrzQNgLEV1e7OG/Nx5m5rLI
         mVc9xzrelRV0cYMp1tcax6dF2RRair8s0jm4vXdMHMh9G+qAk2bF5alAlQxzheHP7vP3
         cRyE4q1APJhiMk8XyqSg9lt85xkDSazYfpbbgSW/S/dY9mtXzeeZU7YEgSIwyl3KzIcO
         RcMNzTbAFhl+0nfnldQ/UJRZs+l4aaumCgiFr11bapx4G7vhDj9Pk0sS4Jr/5yB0QN8t
         vip2hyYKlH1DyBUIN5a29B44vWYuvK3heY778xg7rILKqonyOWg/2rsshQrNKHdu9nSe
         1WVw==
X-Forwarded-Encrypted: i=1; AKwUvBzaP1KPBPjrJVYDK1ymypBkKdtHtFMQQQ9dYdEtT9zYYE6LsN/0/l3BoABWrumHoevRmfnfVO8=@vger.kernel.org
X-Gm-Message-State: AFq9FYKEf1haxYitTSsCoP8MpgCjQV8Dr7NhLbA9FHQB8pXYogQIBO0Y
	b6Q1P82Rtu+/TD5UHD00qnSC8hx3l0kdo4c1bTZ3HikrjGqD/QehhwusAiXXK72FFQ==
X-Gm-Gg: AYBFou09akOHihHNnlPdvBIe6yYJdsQ6YUvgoC5Q6S+xW2ttmkSLonRZuNYLbbLPv3W
	w88+fgV+shBChoBrk58bQVUG5ZD47tP4o5gxCNYiC3/6THzZFaGH/6rCZKh+XkhxeffQu+tVdUA
	bJXT+sbtdYIzGXrjhg6dOijYiaS4o9HRizzXXcz+XYuNcw1ObeesMJOeURXQNp7uVdWjRDjFCvA
	xcxvYdXmvuSJTXWO2iSYwOSwDez8nCg0GYLzQDlUZAIkJOvSqk/uFzl/xcTR95cZ8691+OnicY+
	HzjR5gBrxIP1zYl3ao+J6zWkRv8B5pZMNF4L2MfRkO4NvWqh5xMhBCz1jy6Z3CgfmnoEMqTJ1qI
	xXChxVQc4uhJzvExXZYrwZjqRYbCmYboHcNDK4ZTuZLw+vpP3qWPp+j5pPtCBpNK4YLMlLRGWsa
	Ud6jrfwk/+0uIEj7a46FfVw9ipHWHZPEtHHUjwhDBLlQdbBT++KHTczTHXuNuXGl9tDSwMxqgsZ
	8QEO5fXlhw9baC8fZRkxaMj6laaWgANJ2CD1JZrnZnPHBhlsOFpf/YduGnI51sy8sqb7myfqDvh
	aYGHR65hOsbm0lkKwLVRNJvBFrg11cS2ye/QFlA4CQ==
X-Received: by 2002:a05:6214:509c:b0:91b:8d12:bac9 with SMTP id 6a1803df08f44-91c3a4bd85fmr27351516d6.0.1792756778735;
        Fri, 23 Oct 2026 04:59:38 -0700 (PDT)
Received: from mbili.tail33bf8.ts.net ([64.203.83.2])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-91c396af493sm18358246d6.9.2026.10.23.04.59.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 23 Oct 2026 04:59:38 -0700 (PDT)
From: Jamal Hadi Salim <jhs@mojatatu.com>
To: netdev@vger.kernel.org
Cc: Jamal Hadi Salim <jhs@mojatatu.com>,
	Aaron Conole <aconole@redhat.com>,
	Eelco Chaudron <echaudro@redhat.com>,
	Ilya Maximets <i.maximets@ovn.org>,
	"David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@kernel.org>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	Jiri Benc <jbenc@redhat.com>,
	Pravin Shelar <pshelar@ovn.org>,
	Jiri Pirko <jiri@resnulli.us>,
	Victor Nogueira <victor@mojatatu.com>,
	dev@openvswitch.org,
	stable@vger.kernel.org
Subject: [PATCH net v2 6/6] net: openvswitch: ensure a linear inner Ethernet header on NSH pop
Date: Fri, 23 Oct 2026 07:59:21 -0400
Message-Id: <ACT-N6N4.v2.r0.20261022191829-6@mojatatu.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <ACT-N6N4.v2.r0.20261022191829-5@mojatatu.com>
References: <ACT-N6N4.v2.r0.20261022191829@mojatatu.com> <ACT-N6N4.v2.r0.20261022191829-1@mojatatu.com> <ACT-N6N4.v2.r0.20261022191829-2@mojatatu.com> <ACT-N6N4.v2.r0.20261022191829-3@mojatatu.com> <ACT-N6N4.v2.r0.20261022191829-4@mojatatu.com> <ACT-N6N4.v2.r0.20261022191829-5@mojatatu.com>
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

The issue:
pop_nsh() restores MAC_PROTO_ETHERNET when the popped NSH next-protocol
is TUN_P_ETHERNET, but nsh_pop() only guarantees that the NSH header is
in the linear area.  When the inner Ethernet header sits in a page
fragment, the datapath then claims an Ethernet header it cannot access
linearly.

Output to an OVS internal vport then calls eth_type_trans(), which
pulls ETH_HLEN from an empty linear area and triggers the BUG in
__skb_pull():

  kernel BUG at ./include/linux/skbuff.h:2830!
  RIP: 0010:eth_type_trans+0x335/0x500
  internal_dev_recv
  ovs_vport_send
  do_output
  do_execute_actions
  ovs_execute_actions
  ovs_dp_process_packet
  ovs_vport_receive
  internal_dev_xmit

Conditions to recreate the bug:
On a system with 4 KiB pages and CONFIG_OPENVSWITCH and CONFIG_PACKET
enabled, use CAP_NET_ADMIN to create an OVS datapath and bring its local
internal port up with MTU 9000.  Install a flow matching an Ethernet/NSH
packet with a 24-byte MD1 header whose next-protocol is TUN_P_ETHERNET,
and actions pop_eth, pop_nsh, output to the local port.  With
CAP_NET_RAW, send a 4148-byte AF_PACKET/SOCK_RAW frame containing outer
Ethernet, the NSH header, inner Ethernet and 4096 payload bytes.  The
two pops consume the linear headers and expose the inner Ethernet header
in page fragments.

The fix:
Pull the inner Ethernet header into the linear area before restoring
MAC_PROTO_ETHERNET.  This is the NSH counterpart of the MPLS/TEB
producer fix in the previous patch.

Fixes: b2d0f5d5dc53 ("openvswitch: enable NSH support")
Link: https://lore.kernel.org/netdev/e85fa16e-df3c-43dd-bb3a-9edca07200ea@kernel.org/
Cc: stable@vger.kernel.org
Reviewed-by: Jiri Benc <jbenc@redhat.com>
Reviewed-by: Ilya Maximets <i.maximets@ovn.org>
Reviewed-by: Eric Dumazet <edumazet@kernel.org>
Signed-off-by: Jamal Hadi Salim <jhs@mojatatu.com>
---
 net/openvswitch/actions.c | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/net/openvswitch/actions.c b/net/openvswitch/actions.c
index 03b31e33e880..cb7e16c6a8ef 100644
--- a/net/openvswitch/actions.c
+++ b/net/openvswitch/actions.c
@@ -314,10 +314,13 @@ static int pop_nsh(struct sk_buff *skb, struct sw_flow_key *key)
 		return err;
 
 	/* safe right before invalidate_flow_key */
-	if (skb->protocol == htons(ETH_P_TEB))
+	if (skb->protocol == htons(ETH_P_TEB)) {
+		if (!pskb_may_pull(skb, ETH_HLEN))
+			return -ENOMEM;
 		key->mac_proto = MAC_PROTO_ETHERNET;
-	else
+	} else {
 		key->mac_proto = MAC_PROTO_NONE;
+	}
 	invalidate_flow_key(key);
 	return 0;
 }
-- 
2.43.0

