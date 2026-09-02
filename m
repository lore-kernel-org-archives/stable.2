Received: from mail-pf1-f179.google.com (mail-pf1-f179.google.com [209.85.210.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4B91438552C
	for <stable@vger.kernel.org>; Wed,  2 Sep 2026 08:30:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788337811; cv=none; b=Hy8Sbw3N0WPjplW8Ea5mNwcTBeB1t4YRAwztt8lZMThO62pWPIfXdSJRJa1K80nFac0hIVTrRlZLKJBloBJ5nP4OlMLc9d5A5WqWPESUbpfDL4OKg82qjneaWqsoYXIt7MtcYyVDQ82vY7Y3GbC+zLiFxV1BLqmBhLEVJJuuqHU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788337811; c=relaxed/simple;
	bh=4iqQOhkYAe4JDnnoq/RB1ItQgfUSqdEhqwOJ5R58t6c=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=S1RW4v4Ula3nPNcCf4ugHr+161s9suqLVs/kOyMwng52gduIZVGESQD8UlWe7idjsPvrdJknfgMsq+MGpqD7WCmey1jTaDrXMNrOZBk+NQUMOA4O15rnJYJKl/B0S/k2LWX9osCTcLXizRQuQwzv066yUiqo9R+hSWeILyFgE28=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=G5MzQUyk; arc=none smtp.client-ip=209.85.210.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="G5MzQUyk"
Received: by mail-pf1-f179.google.com with SMTP id d2e1a72fcca58-84f38f3b36eso661711b3a.1
        for <stable@vger.kernel.org>; Wed, 02 Sep 2026 01:30:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1788337810; x=1788942610; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=90ZQiGeRfZ2jvqj4fAVGYYp8oYEh3dff8JUXtoUNxF0=;
        b=G5MzQUyktmXp9N+3SJJN8OBTMlGB/ee5Nx+CZwKLqueHaWWiPBB2yQnTzv/R8YNwp6
         JyZwr46QB3iUUNdcDdn4pGOhzbs3qc8KG6nzXxcNkPaTp4ZljHst6hT8waZuWVcRJE7k
         UraqsxHLxdNRyWvQ1t0eylQ4JGh3NX5JjgeBt1vvE2iwvR/g5c62bOgFn+h2EFQ26RRJ
         7A5SUMZ8cytugmLXX0M1Z7+98nxhTtkGedymeqT3pY7em8irB5NJVjVzE74HSewyUPYF
         cBP+tpHxDZyOamO9l1EpdxSpq/csaAsF7ibkwRa3hb/eAJ8dP4Z6ArV6X96osXZw14Pd
         u7Og==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788337810; x=1788942610;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=90ZQiGeRfZ2jvqj4fAVGYYp8oYEh3dff8JUXtoUNxF0=;
        b=glSdtULLwG24VXbL3FJZzez4niGKCNuJgkKbbFa/lBgMRDRIj5H96R/74LGqofT+Ep
         dcebZryiDlCDvWpTn1QflF42icWnWImeQUEOvDQ2HPuST4AsKLcyA8/jezDwN29/zK3x
         CZApdECxZxrmi9oLdy90oTzFF7e3OOmMTxYHgGVObyRNFjroFTnFhcF3Jkc44V+zIPyG
         K7JyujyMI0xZnbotTo4JQvu27fNwZEaX48aLcUjkmE52BWauyIbD+rgyWf1gWNAEERq7
         u75bSlsOheBfAWfLAyJyo4t116e3OnARfffTpvMYbkkf/7yqlYEz4I+35x5RQqg086FA
         cPzQ==
X-Forwarded-Encrypted: i=1; AKwUvBzB77oagEAYYgimpA0J9pSvkUAzMDi2QflMOP9DilP0PB4xYe8DMKoavuTZWkhQTxZ1MKmuWKo=@vger.kernel.org
X-Gm-Message-State: AFuF++kqMtgGDRp3SD5ZK0JhUjXoIDCVRjWwil6gAgTyly0KOp8NuahP
	eznEtWHzkQJ7qgfG3iFyvjVBJ0p3dWXFRWIFrSMuTeJG6L/DBhIFeAim
X-Gm-Gg: AYBFou2VhajQyzJYln6vSlK1ZLnLyzOpCAQ8PQiTxq8GR4yChqhYzDLoMa9miTg5qV2
	14JG6ui9KuW0+8ZkPY9hWUE/HxOBuYm2uONhyQjWTtdy6mBKOXyXO8Ru2IgAcetfhgHoxsf/xvz
	p3v5msbrjB+y8hMT4qje7qxm7IGeBEawifBZoGm1XflM5ROHWMRlPiv+uVmONGtJTfc6ZmuZd43
	eeKEbwscfXFS/7zl/r6yxGDoa4Q43nd1ZQSJ4r0OQ+L5hpUIZZbXrTHMzs03F2HcnwLLkAFAy4n
	MpIZmdBaMPQ5xELbTPVONbZaCzKaFNe1XWIS84W1cRHpuDNWDZt8G2OTEeLOyXBWDQssoyD9X1g
	WFdiIDJVg771ws+fPKzN/Aid3W9IlAWZoYJn79ugW9FwTB+DTxWXVUt0n7Cs5sWSvv3cm02ie5n
	YOaYkcLx9h2m+VooFGQnrYstJkjvB42JSkbWB6c5LCsC4g9liKwx2rtvX9b7d73TRrKVf606iOl
	UdK
X-Received: by 2002:a05:6a00:2e9c:b0:848:2c2e:c79e with SMTP id d2e1a72fcca58-85ed3c7d861mr4329381b3a.12.1788337809432;
        Wed, 02 Sep 2026 01:30:09 -0700 (PDT)
Received: from TENCENT64.site ([103.7.29.106])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-85db24f29adsm1026904b3a.5.2026.09.02.01.30.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 02 Sep 2026 01:30:09 -0700 (PDT)
From: Fourie Zhang <littleddfu@gmail.com>
X-Google-Original-From: Fourie Zhang <fouriezhang@tencent.com>
To: netdev@vger.kernel.org,
	"David S . Miller" <davem@davemloft.net>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Eric Dumazet <edumazet@google.com>
Cc: Simon Horman <horms@kernel.org>,
	Jiri Benc <jbenc@redhat.com>,
	Jamal Hadi Salim <jhs@mojatatu.com>,
	Cong Wang <xiyou.wangcong@gmail.com>,
	Jiri Pirko <jiri@resnulli.us>,
	Aaron Conole <aconole@redhat.com>,
	Ilya Maximets <i.maximets@ovn.org>,
	dev@openvswitch.org,
	stable@vger.kernel.org,
	Fourie Zhang <fouriezhang@tencent.com>
Subject: [PATCH net] net: mpls: clear inner_protocol when the last label is popped
Date: Wed,  2 Sep 2026 16:28:08 +0800
Message-ID: <20260902082924.2812968-1-fouriezhang@tencent.com>
X-Mailer: git-send-email 2.43.7
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

skb_mpls_push() records the pre-encapsulation network header once, gated
on !skb->inner_protocol. skb_mpls_pop() never clears that record, so it
outlives the encapsulation it describes.

Open vSwitch can then re-push MPLS onto a packet whose
inner_network_header still points at the older, deeper offset: push a
label, pop every label, recirculate (ovs_flow_key_update() re-derives
key->eth.type and resets network_header, but leaves inner_*), then push
again. ovs_fragment() trusts the record:

	skb->network_header = skb->inner_network_header;

so skb_network_offset() goes negative. The bound check is signed:

	if (skb_network_offset(skb) > MAX_L2_LEN)

a negative offset passes it, and prepare_frag() widens the value:

	unsigned int hlen = skb_network_offset(skb);
	memcpy(&data->l2_data, skb->data, hlen);

which is a ~4GiB memcpy out of a 30-byte per-CPU buffer.

Reproduced on v7.3-rc1. RDX is the truncated length, (unsigned int)(-8):

  BUG: unable to handle page fault for address: ffffe8ffffc16000
  #PF: supervisor write access in kernel mode
  Oops: 0002 [#1] SMP KASAN NOPTI
  RIP: 0010:memcpy+0x8/0x20
  RDX: 00000000fffffff8 RSI: ffff888105d732db RDI: ffffe8ffffc16000
   prepare_frag+0x3df/0x4e0
   ovs_fragment+0x589/0x7e0
   do_output+0x4ce/0x5e0
   do_execute_actions+0x55d2/0x7b30
   ovs_execute_actions+0xea/0x450

Same root-cause shape as commit 975b5b067f52 ("ipv6: sr: restore network
header before routing and forwarding"): a stale network header offset
reaching a consumer that widens it. Here it originates in the MPLS
push/pop path.

Clear inner_protocol once the packet is no longer MPLS, so a later push
re-records the current header. net/sched/act_mpls.c is the only other
skb_mpls_pop() caller and gets the same fix; sch_frag.c saves and
restores inner_protocol around fragmentation in the same way OVS does.

Fixes: c66549ffd666 ("openvswitch: correctly fragment packet with mpls headers")
Cc: stable@vger.kernel.org
Assisted-by: tencentos-corvus-ai:hy4-preview
Signed-off-by: Fourie Zhang <fouriezhang@tencent.com>
---
A KASAN reproducer for this issue is available if requested.

 net/core/skbuff.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/net/core/skbuff.c b/net/core/skbuff.c
index 966af3beed94..cc3b4b70288b 100644
--- a/net/core/skbuff.c
+++ b/net/core/skbuff.c
@@ -6690,6 +6690,13 @@ int skb_mpls_pop(struct sk_buff *skb, __be16 next_proto, int mac_len,
 	}
 	skb->protocol = next_proto;
 
+	/* The last label is gone, so the inner header recorded by
+	 * skb_mpls_push() no longer describes this packet. Drop it, or a
+	 * later push keeps the stale offset.
+	 */
+	if (!eth_p_mpls(next_proto))
+		skb->inner_protocol = 0;
+
 	return 0;
 }
 EXPORT_SYMBOL_GPL(skb_mpls_pop);
-- 
2.43.7

