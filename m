Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.219.50
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793477906;
	b=cLJB88Po/qI8jKywQV1IZEJcepQxKzxwHz1KJ5YrO2ofeuAi5KC0O9CQshpqHlouEDCD
	 Ti67Q6IWOUBBHZU74Au7o6eRev1Cq0K4PIa4rMqlyI0WU6B7eT8IzoaT9e5BvChdXhGOz
	 y7Ap6gyzbjxF93xiW2aFyvmiDTcaVo1GRUlqWDtDNyhm5f/8G1h6r/GqGA0Kr81Ic1FBa
	 HRq5tm7ySgmkTDTOenUYbPxCEedvFcWUQ5SDRDNx6cA+HFbasC++W0rkcQ6OZRgkqzovR
	 ipre4TdYcFXa0VFEegsepoM22KPPF168sRlJkHN/kZSjuqpZUjWFjw5ydODrH3j0tlQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793477906;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-Id:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding;
	bh=3iWVot0KlE9fmub2PT5UvYmJQE3iIWxESCHZEC+AAUE=;
	b=ChPRp2bLvfrY7OCMdzkflZ2JyK7Fj74CjRao4iQnYnVVWE9H3ouzSaWlcewpS4HP7UUO
	 QJLMlJzZSLjfHY9JTLibekZQ0N9Ly84g0UkkxP4kYWHQdEXi7gYZZXpKUokeq6vwFei0r
	 Sf8pFbmDy0p56ZYK+oX0IzJUbLWz4hOURpL4U++O08zSUVT3B7fpBTC2BwuD52yPFNTHe
	 mTCu7rkzmS2xC7KVlA5yk7aY/+5qtQ0GoX2UvK64Jk/5WWTkJJVNnniSmLvvtseZd6LAx
	 MwojTNYYrrRXGvW1KFzYCCixTGoTO+RkvemjQX2YsKib35y77zKZXYYGCyEF/rDhXkg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=mojatatu.com;
	spf=none smtp.mailfrom=mojatatu.com;
	dkim=pass header.d=mojatatu.com header.i=@mojatatu.com header.a=rsa-sha256 header.s=google header.b=UPv7QuWe;
	arc=none smtp.remote-ip=209.85.219.50
Received: from mail-qv1-f50.google.com (mail-qv1-f50.google.com [209.85.219.50])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5751C606A322
	for <stable@vger.kernel.org>; Sat, 31 Oct 2026 20:18:26 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 5751C606A322
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mojatatu.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=mojatatu.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=mojatatu.com header.i=@mojatatu.com header.a=rsa-sha256 header.s=google header.b=UPv7QuWe
Received: by mail-qv1-f50.google.com with SMTP id 6a1803df08f44-91c5e31bea9so30521516d6.1
        for <stable@vger.kernel.org>; Sat, 31 Oct 2026 13:18:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=mojatatu.com; s=google; t=1793477905; x=1794082705; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=3iWVot0KlE9fmub2PT5UvYmJQE3iIWxESCHZEC+AAUE=;
        b=UPv7QuWeNJyIW1y8EnKUnceNTlowYWC4Llk0Grj/7BDIs1Xjn7rpsbhbpG5uf/TD5+
         WDMh49hWv+8WFCIIan423zuZ/Eez/F7M6hh2EiigrzVNiVIcVRNDJG7eMyXagC+Qnbu4
         PjpT/Z+5oln1YDgWGQ528HKWJ2hBUgG9ThgjY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793477905; x=1794082705;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=3iWVot0KlE9fmub2PT5UvYmJQE3iIWxESCHZEC+AAUE=;
        b=ReTp4w1FN2lSDLnLhkvsXiNj7vAkpvZo8/i5TP6aqeB70ZskTZICNsiEPnCBD74saY
         qQDAs8c8elmtxkXbtzcy0UzsumqML7Rqf9YmyrJR2Xgyah7gq1lLp9NCAR5R+pcXC4ah
         WFN2sm/NsnlN+j8vMvtFBNae3/lISQl4JALfxTImCrqETCt3DK5Pv4x2B6segP6tcara
         EOcpGRCP3M9NN4hixeK8Nlp+PfkERaA6JEd0N6Xvt41lnzEwg48fRDYnoXZ18JqX8Fsi
         1yDKGxvHckZMnBDb5T45noX3+WHd3a6ljw1zJ+kjSG7AyDB9ce8YZTwOTbG5UX17VtNM
         gmLQ==
X-Forwarded-Encrypted: i=1; AKwUvBxVJbj1BgcaGoxdjg+lHbzQ7OIJW2pAY07gkGKh4t+Sw7ApTH7Lhc+lFIN6xiSIrCdlDmf06Lo=@vger.kernel.org
X-Gm-Message-State: AFq9FYI2A+5N1twmZp3x63hoRrn3fSQ3eZQbMxfb3zJnU99D9H2+EVbq
	g5bR2JBzju5z/4+GHnwTpxDlPtUQFI111XooEsMjOLqPa9RK4OYhOnABUr9Yprn4FA==
X-Gm-Gg: AYBFou0hB3/Jvw3TXJG865wZxpXQLBOiwbGjLSD3QnxirvRNoEpUzeYmVeMvUeMRMIh
	R7lFyKTQ8ZznYD2f/zS9g+2pr7WtmOFcB3ll0NI1jvEKp15h0gwvIC+C1zlTdL6dKMDEBgwoq+U
	bcj11P1kxxuO5TGpyNFe2YLFzB4WbIeYV97JKLhzAnet4jUk+Rl89MIDyiM/xj0MDWZH6+hpte1
	EBZR/A52BuFDqwFo685IujxKcTipLOQOHb+V+2xl80xGUu0bFLFQDk9A2z5aY2MIYydkePsB68a
	jiprGUoEY4d1ztpZ+LFeQ8mkhAlWJhBFM0WsEaDX+UtFHn+bcjzAIyL+c/ZQsBT3XbXDP5jn2do
	4NIwS1FeSDJ/jXsIJar3esNy8iSCIk+PjlzjNtb4TQLYDqtlnS0s9kVn9owNEGF04G45dG0INN0
	497A3rimIrJyglUiL+Kqe7d1KwJ4iEapIVkyPDJ3hoMeWMrMruKAfZcm9G2bLcPnsVH3NuxzeDN
	n6KSoinC/VF7GIm3Kg3BPkTa6l/QeOvi/SvsPKmEPTGfP32AzfU8vi7ebSyHE5xI2u55BAFaemS
	fvEe2PFM11txMxfAwvtH7ot92Pty922z0+ss6zYN42j6tVbMuT1JiIiWFwCkXdp77YJ7d+AUFcj
	Yy6qij9U0kckIs3g=
X-Received: by 2002:a05:6214:240a:b0:91c:450d:8f34 with SMTP id 6a1803df08f44-91ca4bce34emr101975466d6.46.1793477905258;
        Sat, 31 Oct 2026 13:18:25 -0700 (PDT)
Received: from mbili.tail33bf8.ts.net ([64.203.83.2])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-91ca7e23441sm49148926d6.4.2026.10.31.13.18.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 31 Oct 2026 13:18:24 -0700 (PDT)
From: Jamal Hadi Salim <jhs@mojatatu.com>
To: netdev@vger.kernel.org
Cc: Jamal Hadi Salim <jhs@mojatatu.com>,
	stable@vger.kernel.org,
	shaos <shawnq1@163.com>,
	Jiri Pirko <jiri@resnulli.us>,
	"David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@kernel.org>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	Victor Nogueira <victor@mojatatu.com>
Subject: [PATCH net 1/3 repost2] net/sched: act_ife: encode configured zero metadata values
Date: Sat, 31 Oct 2026 16:18:18 -0400
Message-Id: <SER-NSBD.v1.r2.20261031160050-1@mojatatu.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <SER-NSBD.v1.r2.20261031160050@mojatatu.com>
References: <SER-NSBD.v1.r2.20261031160050@mojatatu.com>
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

Reported by shaos <shawnq1@163.com> with a reproducer for the 32-bit
case, which was reproduced and verified in our test environment.

The issue:
ife_check_meta_u32() and ife_check_meta_u16() both reserve eight bytes
of metadata for a configured value even when that value is zero, but the
matching encoder returns without calling ife_tlv_meta_encode(). The
encoder therefore writes neither the TLV header nor its value, while the
enclosing IFE length still includes the reserved bytes, exposing stale
skb headroom contents to the peer.

The 32-bit helper has been present since the IFE action was introduced
(v4.6); the 16-bit helper was added with the 16-bit metadata helpers used
by the skbtcindex callback (v4.9). Both defects predate the oldest
supported stable kernel (5.10), so they are fixed together in this patch.
Each hunk keeps its own Fixes: tag for provenance.

The fix:
Encode any configured value, including zero; skip the TLV only when
there is neither a configured nor a runtime value. The runtime fallback
is unchanged.

A raw TCA_IFE_METALST netlink request is needed to express the
configured zero: the IFE_META_SKBMARK attribute carries four zero
payload bytes for the u32 helper, and IFE_META_TCINDEX two zero payload
bytes for the 16-bit helper (not an absent or zero-length attribute).
Stock tc cannot build these requests; "use mark 0x0" emits no mark
attribute and "allow mark" emits a zero-length one.

Conditions to recreate the bug:
CONFIG_NET_ACT_IFE=y, CONFIG_NET_IFE_SKBMARK=y,
CONFIG_NET_IFE_SKBTCINDEX=y, CONFIG_NET_CLS_MATCHALL=y,
CONFIG_NET_SCH_INGRESS=y, CONFIG_USER_NS=y, CONFIG_NET_NS=y,
CONFIG_VETH=y. In a fresh user and network namespace create a veth pair
and attach clsact to the egress side. Install a matchall filter whose
ife encode action carries a zero skb mark (or a zero tcindex) in
TCA_IFE_METALST. Send a frame through the veth and inspect the IFE
metadata in the received frame. The metadata region is eight bytes but
holds neither a valid TLV header nor a value; it exposes prior headroom
contents. Setting the value to a nonzero one does not trigger the leak.
The namespace needs CAP_NET_ADMIN; no additional privilege is required.
With the fix the zero TLVs are 0001000800000000 (u32) and
0005000600000000 (u16).

Fixes: ef6980b6becb ("introduce IFE action")
Fixes: 6a5d58b67e20 ("net sched ife action: add 16 bit helpers")
Reported-by: shaos <shawnq1@163.com>
Link: https://lore.kernel.org/netdev/20261022144739.61342-1-shawnq1@163.com/
Cc: stable@vger.kernel.org
Signed-off-by: Jamal Hadi Salim <jhs@mojatatu.com>

---

repost1 -> repost2: rebased onto the current net tip.  The repost1
posting was recalled because 3/3 no longer applied; this patch is
unchanged.
---
 net/sched/act_ife.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/net/sched/act_ife.c b/net/sched/act_ife.c
index 3946a9589bb8..6b23a3965121 100644
--- a/net/sched/act_ife.c
+++ b/net/sched/act_ife.c
@@ -50,8 +50,7 @@ int ife_encode_meta_u16(u16 metaval, void *skbdata, struct tcf_meta_info *mi)
 		edata = *(u16 *)mi->metaval;
 	else if (metaval)
 		edata = metaval;
-
-	if (!edata) /* will not encode */
+	else
 		return 0;
 
 	edata = htons(edata);
@@ -94,8 +93,7 @@ int ife_encode_meta_u32(u32 metaval, void *skbdata, struct tcf_meta_info *mi)
 		edata = *(u32 *)mi->metaval;
 	else if (metaval)
 		edata = metaval;
-
-	if (!edata) /* will not encode */
+	else
 		return 0;
 
 	edata = htonl(edata);
-- 
2.43.0

