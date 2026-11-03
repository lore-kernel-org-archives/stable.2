Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.128.180
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793706642;
	b=Qx5vTIWeguY02vLRrfGFJyxUwms9rRADjgZ3Rz8Tp2uPfRx+I5/y6D5Kweq6bLpsEu9I
	 xf48Up9BdrgMNRRMThiRT7wZCQptrkM1gtHAQDPPYBPob3vUzFJwnLQwTYXRZXmfONI7s
	 m1y1D6jEyrR7rK/qatAyQV60TPhzyJPIZABnwx9heDsT7/5ROPWRzPAPuErFPsSzS0cGH
	 HwCl4Q295NsqFCSiWLPmye6lscWis4RZ+wfIvtD+7euPWnAsuS1xqm01arRQKzdeJYi6W
	 4sPNcjJTlNJGHixqziiqdvZStsUFoRByHFtRA1cOGPpjZeSGHaunpTGkXotPi4UA4Hg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793706642;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-Id:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding;
	bh=tVvHMbr2t3O+rGP4lNLl+w7jf0chwBmejgN5Dwc7oic=;
	b=e053RYojv1FgHX762vXUF4+c3niMnYGMchuWH9ZyV7ZIOwB9xYnmoTL/XjQ8UW08BaF3
	 mJy0IbOKK6SurhMGTnwaTQCapkpkVxoB2bWvaXr/WFoSUPHPNz2O0b0wZedKbKPzt1h7A
	 gCVEyv2ufSrZiPk19AkUvBJpfY4fTmShWZlNH8CWSd2mw37JnARLdqpjsBWqHT0ztg5yW
	 kJ097dXtX5vE9eX9HWDOX+Yl9pKp7rFno7iPFCuulL82yaauLiADsGKdfUeZ/o/x9xH6g
	 o/KhNdAuL2QjeX0HdQ3RxiDHmrBGrS68htiNT/NUTlNPF/fibWk612096RNm9e9gwoQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=mojatatu.com;
	spf=none smtp.mailfrom=mojatatu.com;
	dkim=pass header.d=mojatatu.com header.i=@mojatatu.com header.a=rsa-sha256 header.s=google header.b=aHZEAIZE;
	arc=none smtp.remote-ip=209.85.128.180
Received: from mail-yw1-f180.google.com (mail-yw1-f180.google.com [209.85.128.180])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CC4C86082BCA
	for <stable@vger.kernel.org>; Tue,  3 Nov 2026 11:50:41 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org CC4C86082BCA
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mojatatu.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=mojatatu.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=mojatatu.com header.i=@mojatatu.com header.a=rsa-sha256 header.s=google header.b=aHZEAIZE
Received: by mail-yw1-f180.google.com with SMTP id 00721157ae682-8ab395abf79so35208337b3.0
        for <stable@vger.kernel.org>; Tue, 03 Nov 2026 03:50:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=mojatatu.com; s=google; t=1793706641; x=1794311441; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=tVvHMbr2t3O+rGP4lNLl+w7jf0chwBmejgN5Dwc7oic=;
        b=aHZEAIZEzxcyL6zkvE260oyLvIsNbR544mMmCV5hmO/2yEBrr5xWFlh/jWDFsjH5Ej
         8K2MWZqYDE5Q8H9or80ufoPYIudZU+bYo8fzaBQKj93rhszZv7fXOH1S9isi0FgcEHlb
         G25UFnIT3yuJGb6xgqnE6X4LmWz5+litFGzjU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793706641; x=1794311441;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=tVvHMbr2t3O+rGP4lNLl+w7jf0chwBmejgN5Dwc7oic=;
        b=D0kpavCgyCpM98WjjcpxZufoVAd5sEWqxv/Fecnvv3ACvvtLDW/RkwdVFdO5k/+jBy
         mfUXasONC0D2OVAkpT+O7P2yaint6nM5UfpOULAIgJ2X91NSVvz4F4kk6Rcuxy341vo/
         QPXLWbHpClN/08HFntKnN9H/reToTfZbffDMEKSmYb3j6gQwz7jOcCQ54KUhvtos/flD
         P/2xE6lX39sHGMh2QrEFmTmfI75ogf59bG/B6uWE3eb0HgybndiykdsMNEGdtwu22uy5
         waclDh11qvkPvACmYx1ZP19en+ZV9JmVMFvqJglU+tHR1ye0ticYH91RwqA/d6D21Yxn
         fmEw==
X-Forwarded-Encrypted: i=1; AKwUvBzm+TZn8FMa8y4uQyi4CavlOz1rHnruoBjWO1pc8YUYwMQ39IVbRlrP4Td8H/tyLEkgeavJXYo=@vger.kernel.org
X-Gm-Message-State: APuU4Z+M8JP9BWXj8OeZfXc4GlcUo97U+YLOH3/3FxNZmvPswGx57bnJ
	uzAkXvMrb076ACYvVJ2BTiFTJtmg3IBM0IXjCKyUiLTlEAGFVXkDzbzuzFQIMWOMlQ==
X-Gm-Gg: AYBFou3pCS91Art3rs/rqp0vDA1e/b2OwRw0vEa/KGFU3RUuh+rzekSrJYGTQQpPoRU
	HnM8sjzwkoyfyF1oh81JBW0rBBxn7K53nq3oePKK3R8WcVWI/KbacId2RYaIKlEvDFZOLftLLZT
	nPAHC1V6bvWtkltUbxJrQg4G978kmOLMdYgUZbuX14Kj4qrb3hCSfAV21d10/gUThY0s4VrX5ga
	s4SRmfm+Nx7t2upH0y8n9Z2POUE8Qj4WM+RujWgQ9nlRw5zpuST4Vx78BmJ14iK0rOiKBrDpSl8
	7aMGZLQwRi5NmC6he7veazipboTcz/3jxUYnrOamKx2x1gGtWZRkz9KB7IZcgmulSATRZw6asgS
	ZLjDoGoaWBfaGC9w77cxprNokcSeOzSCLE2QpzJSrJrMWSDXFiE56gY73pNdSeoiCjYTwVHXGoP
	aPq9BvzAp6adbXJHYEkHIqMDUrBr/XYruS0QLB1hjuR8w6DuoiW3nSlmfC1FWav6Tc6WOml3ldB
	ab4Qnc6axjupXfKCr8eG9XqhGAHgBMutli7awtAXERpV2tPoqjgZ3YMRaTJQnag/QJN+xp5eRrE
	bB6wP+5BSA05yVsUiPCHlzdvUwm06LOZCjay5Aix3EEWx0MFgPgCr/XOzkdtFWcDI6KoPfLCYAp
	Xqbp5e7l4jp9oHYo=
X-Received: by 2002:a05:690c:ed6:b0:8b0:ad62:198f with SMTP id 00721157ae682-8b2b672232fmr92632267b3.20.1793706640718;
        Tue, 03 Nov 2026 03:50:40 -0800 (PST)
Received: from mbili.tail33bf8.ts.net ([64.203.83.2])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-8b2b704d699sm70016857b3.5.2026.11.03.03.50.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 03 Nov 2026 03:50:40 -0800 (PST)
From: Jamal Hadi Salim <jhs@mojatatu.com>
To: netdev@vger.kernel.org
Cc: Jamal Hadi Salim <jhs@mojatatu.com>,
	stable@vger.kernel.org,
	shaos <shawnq1@163.com>,
	"David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@kernel.org>,
	Simon Horman <horms@kernel.org>,
	Jiri Pirko <jiri@resnulli.us>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Victor Nogueira <victor@mojatatu.com>,
	Sashiko <sashiko-bot@kernel.org>,
	Yotam Gigi <yotam.gi@gmail.com>
Subject: [PATCH net v3 2/4] net/sched: act_ife: require a full Ethernet header on egress
Date: Tue,  3 Nov 2026 06:50:30 -0500
Message-Id: <SER-NSBD.v3.r0.20261103064310-2@mojatatu.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <SER-NSBD.v3.r0.20261103064310@mojatatu.com>
References: <SER-NSBD.v3.r0.20261103064310@mojatatu.com>
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

This is a followup of commit 5b483f7791b0 ("net/sched: act_ife: Only
operate on Ethernet frames") as reported by Sashiko.

The finding was raised by both Sashiko providers (nipa and gemini)
while reviewing the parent patchset. shaos <shawnq1@163.com>
independently reported the same undersized-egress path with a
reproducer, which was reproduced and verified in our test environment.

The issue:
On egress tcf_ife_is_eth_skb() only checks the device type; it does not
check that the skb carries a full Ethernet header. For an Ethernet or
loopback device it returns true even when the skb has no Ethernet
header. tcf_ife_encode() then calls ife_encode(), which copies ETH_HLEN
bytes from skb->data. A short skb therefore reads past its linear data
and the copied bytes, including stale kernel memory, are emitted in the
outer Ethernet header.

The parent commit fixed the reported ingress mac_len case but left the
egress path without a length check.

A total-length test is not sufficient: a non-GSO TUN skb can have a
large total length while only a single byte sits in the linear area, so
ife_encode() still reads past the linear header. Require instead that
the Ethernet header the encoder copies is present in the linear part of
the skb.

The Fix:
On egress require pskb_may_pull(skb, ETH_HLEN) before encoding, which
ensures the Ethernet header is present in the linear data ife_encode()
copies from; the ingress mac_len check is unchanged. A short egress skb
is now dropped instead of being encoded.

Conditions to recreate the bug:
CONFIG_NET_ACT_IFE=y, CONFIG_NET_CLS_MATCHALL=y, CONFIG_NET_SCH_INGRESS=y,
CONFIG_TUN=y, CONFIG_NET_ACT_MIRRED=y. In two user and network
namespaces (a victim and an attacker), open a TUN device in IFF_TUN mode
and attach clsact to it and to lo. Redirect ingress traffic from the TUN
device to lo egress with mirred, and install an ife encode action on lo
egress:

  tc qdisc add dev <tun> clsact
  tc qdisc add dev lo clsact
  tc filter add dev <tun> ingress matchall action mirred egress \
      redirect dev lo
  tc filter add dev lo egress matchall action ife encode use mark 1 \
      action ok

Send a TUN packet shorter than ETH_HLEN (a one-byte payload is enough)
and receive the emitted frame on the other side. Without the fix the
outer Ethernet header contains bytes copied past the short packet; with
the fix the short skb is dropped. The attacker needs CAP_NET_ADMIN in
its user namespace; no init-net privilege is required.

The same path is reachable when the total length is large but the
Ethernet header is not linear: write a non-GSO virtio header with
hdr_len=1 followed by an 8192-byte packet so that only one byte stays
linear. Without the fix the copied header reads past the linear data;
with the fix the header is pulled into the linear area before the copy.

Fixes: 295a6e06d21e ("net/sched: act_ife: Change to use ife module")
Reported-by: Sashiko (nipa) <sashiko-bot@kernel.org>
Reported-by: Sashiko (gemini) <sashiko-bot@kernel.org>
Reported-by: shaos <shawnq1@163.com>
Link: https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20260821164031.32824-1-victor%40mojatatu.com
Link: https://sashiko.dev/#/patchset/20260821164031.32824-1-victor@mojatatu.com
Link: https://lore.kernel.org/netdev/20261022144736.61227-1-shawnq1@163.com/
Cc: stable@vger.kernel.org
Reviewed-by: Victor Nogueira <victor@mojatatu.com>
Signed-off-by: Jamal Hadi Salim <jhs@mojatatu.com>
---
v2 -> v3: no change to the diff; the Fixes: tag now names the commit that
introduced the unguarded copy.  This series revision considers comments
from Sashiko (nipa) on the v2 posting:
https://lore.kernel.org/netdev/179366641863.488856.17368571591466000274@kernel.org/

The tc-testing coverage of the teql rejections is reworked in 4/4 so that
each case exercises exactly one check.

 net/sched/act_ife.c | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/net/sched/act_ife.c b/net/sched/act_ife.c
index 6b23a3965121..5a527da00566 100644
--- a/net/sched/act_ife.c
+++ b/net/sched/act_ife.c
@@ -878,13 +878,16 @@ static int tcf_ife_encode(struct sk_buff *skb, const struct tc_action *a,
  * is an Ethernet header because the skb could've been redirected with mirred
  * from a non-Ethernet device.
  */
-static bool tcf_ife_is_eth_skb(const struct sk_buff *skb)
+static bool tcf_ife_is_eth_skb(struct sk_buff *skb)
 {
 	if (skb->dev->type != ARPHRD_ETHER &&
 	    skb->dev->type != ARPHRD_LOOPBACK)
 		return false;
 
-	return !skb_at_tc_ingress(skb) || skb->mac_len == ETH_HLEN;
+	if (skb_at_tc_ingress(skb))
+		return skb->mac_len == ETH_HLEN;
+
+	return pskb_may_pull(skb, ETH_HLEN);
 }
 
 TC_INDIRECT_SCOPE int tcf_ife_act(struct sk_buff *skb,
-- 
2.43.0

