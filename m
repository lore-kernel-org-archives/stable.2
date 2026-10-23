Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.219.42
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792756773;
	b=zwGaWSYwH8E1SV2uYOf9v508EFMRnrMSTJ/Jyu7e7e84J21vqQUw+C8+rNpPnz9cMs0C
	 h523w6OjP98e8yrYfWhdzAIZB7TkQLbFEEOEuMgufbH7hE3eyIab+2YsVARTvmAp6l6yn
	 dS9/jtNAvhD7ph9dW7heu+0UqLjDJDCxir17xHDKZDosmZnzzevGcYc+KuiAy4CZUpn2v
	 TdxrmRNefQ1EdlfOws7BaxFJ7T/6jwQ94Yi1QW41rf2OJXOPfY1Ov3FRcV6h9c1XkiID/
	 ee6LipEo/ibYv09Ssrj0dtu/1YTV1qsiZTyQnI+9bXF42F/DUEVN7KM0QBUG7L9ivJQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792756773;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-Id:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding;
	bh=SEgSB+fCrdDdR4pMioinv3V6z4wpylFB8adOgpawsaw=;
	b=3L+9UCow/qlvYp/fkJ0nlzuH/MHxG8FkCBT1shY3HPuyQCHXTRCnKF3vE6HT/F9k2TkZ
	 H2LPVIfHWUEqMz27cDqhKItR48IVT8HbzXwZbLJSHOI7eUTNJPfY9uvz8XUsiIzpRn/4u
	 f2v2sek7rjnKddHbdesKwZZC9t2EkO/tRsZdOO3vGCsd6a7zj0hz5X2aScaXLnYBp78cY
	 IMfryAIXzNPlX/NIGWktvwJF1Ys/7wMIbofPqEwn8Jk09+wtx0xFvY7F2/dlcmUKbvFEy
	 bZRNuErKVrQnAptOR+dAyiQ47CsBDLCZNS5zVitVBwu3NXz3cGwBGK+rK9amauQALwg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=mojatatu.com;
	spf=none smtp.mailfrom=mojatatu.com;
	dkim=pass header.d=mojatatu.com header.i=@mojatatu.com header.a=rsa-sha256 header.s=google header.b=M9sCOydb;
	arc=none smtp.remote-ip=209.85.219.42
Received: from mail-qv1-f42.google.com (mail-qv1-f42.google.com [209.85.219.42])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B212B606A332
	for <stable@vger.kernel.org>; Fri, 23 Oct 2026 11:59:32 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org B212B606A332
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mojatatu.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=mojatatu.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=mojatatu.com header.i=@mojatatu.com header.a=rsa-sha256 header.s=google header.b=M9sCOydb
Received: by mail-qv1-f42.google.com with SMTP id 6a1803df08f44-917997ab0d9so10410246d6.3
        for <stable@vger.kernel.org>; Fri, 23 Oct 2026 04:59:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=mojatatu.com; s=google; t=1792756772; x=1793361572; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=SEgSB+fCrdDdR4pMioinv3V6z4wpylFB8adOgpawsaw=;
        b=M9sCOydbeZo/L1rAE1m1GWSuH49lDlJLjVsT+gC68h2o+bRv4aVFZAEwrwR8HL+sVV
         phcHu9Yp24IOxeANmE+KVo6kQ4Gd7htuoEAEI3feMOC8pEDyLHfs+1TrBrAItci5JZbZ
         HuqjAMdiMTfSWqGanJDPvoDDPu6kK+PyOW81U=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792756772; x=1793361572;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=SEgSB+fCrdDdR4pMioinv3V6z4wpylFB8adOgpawsaw=;
        b=kwSFXRwWLxrX6amti3WafQgEfp2BeT/nnasLUIL8o2N8fcxcqylF37+PbSyFSAOJSR
         cWLMaLyGz+VBR7nawWpbk/Gy3q7ZcLn/omvqcEO0tFKGIA33XBHZbEZ6Q+DR9hxOWytK
         RkqrTqPBFwCo0+rtRg3ND42SMdhNqDDeAGUHuDAvAiFivDzEc5C4QeSREKLTwdk+iKW4
         DhYxKodeZyIh7vpxFPbHHqWpuH3UfuayMhRyOUQu9Cka83K8P/p6oQXn+gqk5ZYRqEFf
         ZxKpgt7gMYNaAA13jwpwhsK2F349dIwfKDLEfzoNFHQEm92lO/1CaanwnZozV2unjrCx
         gLbQ==
X-Forwarded-Encrypted: i=1; AKwUvBy86gMAkWvCtc11haREnftbpoxtPiF2q93T4t9tsWptFrMGTgxpFb6GfCnpF+d8wrS1AFwjHSs=@vger.kernel.org
X-Gm-Message-State: AFq9FYIEv2ul/RV6O5BCAsDd+jJqrtmNBH6A0x86N3035UbG3DO0/rjk
	FlHURx+xb2A404io1j8f0lLiputlE+pfuXSiknYSMoBjoLjKBnlnypFdC3yN271VJgfNygjC71l
	m5j8=
X-Gm-Gg: AYBFou0bTMtcKEHm77t2muYm7u11+fADmMgTGhoucvQSAG4Yj0HfuDx7sCRIr+187Ad
	phpUVw/m88bEm6wX5QLS0rKKB+YuJjjcSSdXuXL56fkNTou0dpIJuH/qlpwNxYZ+n9uH/SgPxvC
	zE9YickQwV9Gx5KJZ2LS3hQlXx+6g1lScwHIABtNJlhmVr/SJ2AlIkVUcFzX/zAEg1Naxyoe9ZA
	8HomrHrWUpVm+p/0WDcBJz9Gtpf0q+FkS7r6jiFyCxmqEB948s7shtmCnTV+QUolxy1PVIZrYGh
	78+hdvD98D8rON/2thKFr5o2ZiaZ8rll+G1aORvaU4F+OsA+IuD3r8nLKaz0mG5ANYRR8ldZtVU
	WFGYau+zEwTVi9joa5a3wgP0tD+qbDcPFBYltePonKOeEr1j6BNSkgKuC88aSSj6zlnHv14cjzy
	gSMFEs75va94tlLHdWCRp+csCLtaB7UMPhaBy+tyXbpN9aZ9IfyXNS6DRpwcqEbnDQAW9udqedc
	RP1son+JueqKUt3QSq69iHSs3SiANZkFMckbyXpIFQnnJWheQ6z6cQL7UTukn/AYHMHm9L5hagx
	UtGT7UVAm7O6kfiPp2iCWbhvX3NwAzeL3Uded517UO0L5Kh5QYdmY48oTZBB22w=
X-Received: by 2002:a05:6214:da4:b0:915:e5c8:5663 with SMTP id 6a1803df08f44-91c3a643bb4mr26289136d6.4.1792756771660;
        Fri, 23 Oct 2026 04:59:31 -0700 (PDT)
Received: from mbili.tail33bf8.ts.net ([64.203.83.2])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-91c396af493sm18358246d6.9.2026.10.23.04.59.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 23 Oct 2026 04:59:31 -0700 (PDT)
From: Jamal Hadi Salim <jhs@mojatatu.com>
To: netdev@vger.kernel.org
Cc: Jamal Hadi Salim <jhs@mojatatu.com>,
	Jiri Pirko <jiri@resnulli.us>,
	Victor Nogueira <victor@mojatatu.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@kernel.org>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	Willem de Bruijn <willemdebruijn.kernel@gmail.com>,
	Shmulik Ladkani <shmulik.ladkani@gmail.com>,
	stable@vger.kernel.org
Subject: [PATCH net v2 3/6] net/sched: act_mirred: reject redirects without a link-layer header
Date: Fri, 23 Oct 2026 07:59:18 -0400
Message-Id: <ACT-N6N4.v2.r0.20261022191829-3@mojatatu.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <ACT-N6N4.v2.r0.20261022191829-2@mojatatu.com>
References: <ACT-N6N4.v2.r0.20261022191829@mojatatu.com> <ACT-N6N4.v2.r0.20261022191829-1@mojatatu.com> <ACT-N6N4.v2.r0.20261022191829-2@mojatatu.com>
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
tcf_mirred_to_dev() may redirect a packet that has no link-layer header to
a device that expects one.  TUN builds a valid L3 skb with mac_len == 0;
mirred then pushes zero bytes and the IP header is parsed as Ethernet by
eth_type_trans().  The same happens after a VLAN POP_ETH or MPLS POP chain
whose producer did not leave a full inner Ethernet header.

The Fix:
After the existing push/pull adjustment, when the target expects data at
the MAC header, require a link-layer header of at least
dev->min_header_len bytes and pull it into the linear area.  Drop the
packet otherwise.  This mirrors the check bpf_redirect() already performs
and keeps the legitimate push_eth-then-mirred case working.

Conditions to recreate the bug:
- create a TUN device with IFF_TUN | IFF_VNET_HDR | IFF_NO_PI;
- attach egress mirred redirect to an Ethernet device (for example lo);
- write a virtio_net_hdr with hdr_len=1 and an 8192-byte payload.
The unfixed kernel parses the IP header as Ethernet and can BUG in
eth_type_trans() via loopback_xmit.

Fixes: 53592b364001 ("net/sched: act_mirred: Implement ingress actions")
Suggested-by: Eric Dumazet <edumazet@kernel.org>
Suggested-by: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
Cc: stable@vger.kernel.org
Signed-off-by: Jamal Hadi Salim <jhs@mojatatu.com>
---
 net/sched/act_mirred.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/net/sched/act_mirred.c b/net/sched/act_mirred.c
index 553342c55cf7..e3e0e4aa70a1 100644
--- a/net/sched/act_mirred.c
+++ b/net/sched/act_mirred.c
@@ -316,6 +316,11 @@ static int tcf_mirred_to_dev(struct sk_buff *skb, struct tcf_mirred *m,
 		}
 	}
 
+	if (!expects_nh &&
+	    (unlikely(skb_network_offset(skb_to_send) < dev->min_header_len) ||
+	     !pskb_may_pull(skb_to_send, dev->min_header_len)))
+		goto err_cant_do;
+
 	skb_to_send->skb_iif = skb->dev->ifindex;
 	skb_to_send->dev = dev;
 
@@ -335,6 +340,8 @@ static int tcf_mirred_to_dev(struct sk_buff *skb, struct tcf_mirred *m,
 	return retval;
 
 err_cant_do:
+	if (skb_to_send != skb)
+		kfree_skb(skb_to_send);
 	if (is_redirect)
 		retval = TC_ACT_SHOT;
 	tcf_action_inc_overlimit_qstats(&m->common);
-- 
2.43.0


