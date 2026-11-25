Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.52
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795636667;
	b=h6U4ioTmrtbeplIrtlpI7jJN1SlEX/OmwXf0hkP4ifrAvM+ZPilKxXcnxCtJADxP/chE
	 n2e7wnYauTxlHM4X8nYeo3sponmA4GB9NDl7Yutj5V5sRYoJ/Rw/zXGFIqOBK9YClCCNj
	 0zUUpVDGuDSVh3a/z87Ml6gs8lJ7opwak8tAYbwjIAEZjY2OhXbF2R7uo/GtrofkexoLz
	 Qk0fA044JX/URd/AB/ERYHm4H6+GQOQKRRY868oCM0HFdmKphPxdTamoMSuPO9o+TRxbz
	 0UspXW60YjQmMdCkANPr9r70g5YIfNRCwupoK5R/BGB9jiGtudV8UdODhP3AKh6PNUA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795636667;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:In-Reply-To:References:MIME-Version:Content-Type:
	 Content-Transfer-Encoding;
	bh=RW4FHxXGyZEJsJcwKbYOpf6/c9VUn9gfas8f9jTHwlA=;
	b=j3lrisumfwqnUimvR3iDzo5+zH4dTLVPOl/PsX7tbddrtjmDd1SoJAbsxG507/rbCIK3
	 ogiKFNKQUIkgU7MUV+z/Da8x8oSpJqdKIsfAKYhgReyWBQs4PUMK55LFC6VgXGTYNfu5Q
	 kKow+PjiVoF3bDUxrsJQE6bdZA83KMqu07rb8UhMpasY84u31ULXZIjFj9Rowv6J3Nk01
	 xGR+jYaBvXcGK+iSPLsSaTpBzlsTuBT3Sg1fXBF1YhHCUSZMZki4L2BBrHht/Ttnx+zNo
	 I9Ca7/hUvCzLrz4aJpSsKPo+LpcgT2EuX9EJvqiXpFxaoPbZeXk5YWBzjuJKsww4C5A==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=trailofbits.com;
	spf=pass smtp.mailfrom=trailofbits.com;
	dkim=pass header.d=trailofbits.com header.i=@trailofbits.com header.a=rsa-sha256 header.s=google header.b=Fde+FQe7;
	arc=none smtp.remote-ip=74.125.82.52
Received: from mail-dl1-f52.google.com (mail-dl1-f52.google.com [74.125.82.52])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 264E9606A326
	for <stable@vger.kernel.org>; Wed, 25 Nov 2026 19:57:46 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 264E9606A326
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=trailofbits.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=trailofbits.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=trailofbits.com header.i=@trailofbits.com header.a=rsa-sha256 header.s=google header.b=Fde+FQe7
Received: by mail-dl1-f52.google.com with SMTP id a92af1059eb24-1a3c08d6928so9186694c88.0
        for <stable@vger.kernel.org>; Wed, 25 Nov 2026 11:57:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=trailofbits.com; s=google; t=1795636666; x=1796241466; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=RW4FHxXGyZEJsJcwKbYOpf6/c9VUn9gfas8f9jTHwlA=;
        b=Fde+FQe7ExgpmmeyCCXOU+9tIGpPvsG+QKMhmKMVtqcYZQag2JJOeD8MebKYhx88IG
         NDiJN8lXu/eqVHH/NG+ziU3uvwaiqoh3OyiHsAqZJVppibCB1EEFsUF69Di9phUnPiPo
         n96dmNUQ830dRQsuaeqc/7nHxHGRY6PhNfsOK8g3o20g8LvhU+FJeokKc+jO2RNOcU6I
         xKRx6xdeyxD+krDEyxmNsCGZGiQ8cwJNawRVskv8b4ppFxj1ZXZrjBFrgKUxd1d4pddv
         cVPW15nggdAZtG6mRVZA8cSlytqM2bQu0Ogu5rGiZsh0rZK62kB/7oncNzN3ctEGzWjA
         1SOA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795636666; x=1796241466;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=RW4FHxXGyZEJsJcwKbYOpf6/c9VUn9gfas8f9jTHwlA=;
        b=UylB3eX4Wxa45ov28pZj1RxdJoD7M+y9yIFeV48A1TxG2mJeDDcKtQzl/t8TXRQDYF
         S9/GscW0L2EopcE6Cpq+hujeBcW+58qnRMOr6y8A/bABe3jCmeJY4XMITUa2b5yNhJfY
         CD9gYMwDa4mMI+QfM/ubI8TxCcD26tAPViM7CJ/Skoxihx+SIO+1CHvFx5d55ES9lzFk
         U1rgdsQgijm5c4gAZAs9eAwr8CbN4dI6F/NWGLE9yUQT6eJ1yBDlFStLBlRsM43RFxFK
         gOIKLdr4yDYuig3QXEY8mDHR+HJyGZeRJskuXp6SWo7BkPQGGpVTSMaQ5yT8owuprlb7
         ACuA==
X-Gm-Message-State: APuU4Z8oFdbTj9rkyIatRcrUwP/JZdQbTlMR8J0gVo1eA5ZE0v088cgO
	kxO9IhEvViDM5/tL8dlms1SVO6TRSrdxwcJUQPW6Dqh0apUjbRrJgcY/4m3wMw4uszc9c3XzToE
	KeoVCgn8=
X-Gm-Gg: AZFdTZdbGJRsGW3S7UY3oPTlPcOaKlEnTjkpNurwYKFKeT1dgOEME+Gn3IhvkuPTCie
	kmqtX6Ex9NtFaAJpu7JANOpmeaSrpJZaZmgiiIumIfFulgmvBjQmhrH7U5eTqJI2HB1+ciaL0kA
	6q4aNhx2GOEbg5Cqo9e7ktRY/9wM7RMtNJ1ICX5qLQ2Hd4M3nX7KuzgdvBcV7HeL6a6OHtx4QOX
	ZfV6rFOikr/wWeIMmolQe4aR1n/f1Xsy7GWn38H4Xnl4m0h8EWjSY3gRajJuMRSI8nGt0eYOBf6
	6LlZVrhIvUDzU6X5WKKUh/4tqoQaDERssxhK4SPbF3jM0e8blwp3rkFPsijUASTNa7es4+wr9CE
	6xRLARa3pQs+pEqeC9EuM3zxArCAyOosfhWd2h+fcgW2Aps4x2MnVsp82oRCIpRx6LEoymeknYp
	krnTlPqu6d9L7jDofh0dj1aUehf6hfb7hqFL2QoHu4ACuPGk26UOcTv3oAKuG8cpe4FyHOJYqmb
	rgBcif31U649wjK37ZM0QtlpIz+/3mEZ1S05YZOqATqdkUiSWCUnBxFDz0cnPGJhWh8efn8jNp7
	qzDI0q1oFJ8M3A0QnMt+zBm/z7yrRD4B0mE9C3R8/zAceHIrnhNoBC3Dyg1vyo5y7aeIxXVdqWO
	PUEllsygzM3+w5zrkVs8Vrt5+Rg==
X-Received: by 2002:a05:693c:87da:10b0:386:aaac:7017 with SMTP id 5a478bee46e88-386aaac73a6mr11279980eec.26.1795636666090;
        Wed, 25 Nov 2026 11:57:46 -0800 (PST)
Received: from localhost.localdomain ([2603:8003:6d40:6669:75a7:83bd:63db:baa9])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-38566fdce48sm59596522eec.14.2026.11.25.11.57.45
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Wed, 25 Nov 2026 11:57:45 -0800 (PST)
From: Artem Dinaburg <artem@trailofbits.com>
To: stable@vger.kernel.org
Cc: davem@davemloft.net,
	edumazet@kernel.org,
	horms@kernel.org,
	jhs@mojatatu.com,
	kuba@kernel.org,
	mst@redhat.com,
	netdev@vger.kernel.org,
	pabeni@redhat.com,
	shawnq1@163.com,
	willemb@google.com
Subject: [PATCH 6.18.y 4/5] net: harden qdisc_pkt_len_segs_init() against malicious GSO packets
Date: Wed, 25 Nov 2026 14:57:34 -0500
Message-ID: <20261125195735.57472-5-artem@trailofbits.com>
In-Reply-To: <20261125195735.57472-1-artem@trailofbits.com>
References: <20261125195735.57472-1-artem@trailofbits.com>
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit

From: Eric Dumazet <edumazet@kernel.org>
Date: Thu, 22 Oct 2026 17:54:36 +0200

[ Upstream commit c6648c9f3b51c5a8a3df470c1542b2aa378d88f9 ]

An SKB_GSO_DODGY packet can carry untrusted gso_size and headers.

For instance, gso_size=1 and hdr_len=65532 for a 524275-byte frame
makes qdisc_pkt_len_segs_init() compute an accounted length of
about 4,294,574,091 bytes (after gso_segs silently wrapped in a u16).

With DRR quantum 256, the dequeue path then needs ~16.8 million
deficit refills before it can dequeue the skb, keeping the CPU in
the qdisc path long enough to trigger the soft-lockup watchdog.

Commit 8f735d64382d ("net/sched: bound qdisc_pkt_len to prevent
qdisc soft lockup") added QDISC_PKT_LEN_MAX to bound size table
amplification. Use the same bound for DODGY packets:

- Make gso_segs a u32 and drop packets whose segment count does
  not fit GSO_MAX_SEGS, instead of silently truncating it.

- Drop packets whose estimated qdisc_pkt_len() would exceed
  QDISC_PKT_LEN_MAX.

Fixes: 15e5a0307164 ("net_sched: better precise estimation on packet length for untrusted packets")
Reported-by: shaos <shawnq1@163.com>
Closes: https://lore.kernel.org/netdev/20261022144755.65025-1-shawnq1@163.com/
Signed-off-by: Eric Dumazet <edumazet@kernel.org>
Cc: Jamal Hadi Salim <jhs@mojatatu.com>
Cc: "Michael S. Tsirkin" <mst@redhat.com>
Acked-by: Michael S. Tsirkin <mst@redhat.com>
Reviewed-by: Willem de Bruijn <willemb@google.com>
Link: https://patch.msgid.link/20261022155436.117507-1-edumazet@kernel.org
Signed-off-by: Jakub Kicinski <kuba@kernel.org>

[ Backport to 6.18.y: context adjusted; 6.18.y keeps the name
  qdisc_pkt_len_init() and has no qdisc_skb_cb()->pkt_segs. The code
  change is identical to upstream. ]
Signed-off-by: Artem Dinaburg <artem@trailofbits.com>
---
 net/core/dev.c | 11 ++++++++++-
 1 file changed, 10 insertions(+), 1 deletion(-)

diff --git a/net/core/dev.c b/net/core/dev.c
index 2bbbfc82d779..36375c24b993 100644
--- a/net/core/dev.c
+++ b/net/core/dev.c
@@ -4128,7 +4128,7 @@ static enum skb_drop_reason qdisc_pkt_len_init(struct sk_buff *skb)
 {
 	struct skb_shared_info *shinfo = skb_shinfo(skb);
 	unsigned int hdr_len, tlen;
-	u16 gso_segs;
+	u32 gso_segs;
 
 	qdisc_skb_cb(skb)->pkt_len = skb->len;
 	if (!shinfo->gso_size)
@@ -4177,6 +4177,15 @@ static enum skb_drop_reason qdisc_pkt_len_init(struct sk_buff *skb)
 		if (payload <= 0)
 			return SKB_DROP_REASON_SKB_BAD_GSO;
 		gso_segs = DIV_ROUND_UP(payload, shinfo->gso_size);
+		/* shinfo->gso_segs is a 16bit field.
+		 * Also make sure untrusted gso_size/hdr_len can not inflate
+		 * qdisc_pkt_len() beyond QDISC_PKT_LEN_MAX, or deficit
+		 * schedulers could spin in their refill loops.
+		 */
+		if (unlikely(gso_segs > GSO_MAX_SEGS ||
+			     skb->len + (u64)(gso_segs - 1) * hdr_len >
+			     QDISC_PKT_LEN_MAX))
+			return SKB_DROP_REASON_SKB_BAD_GSO;
 		shinfo->gso_segs = gso_segs;
 	}
 	qdisc_skb_cb(skb)->pkt_len += (gso_segs - 1) * hdr_len;
