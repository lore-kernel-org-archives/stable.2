Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.222.174
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793316468;
	b=rihj1OZ8WiKMSsjuk76DrcVCnhKlbtzDbMjhuepXUOfMPGr+YmP8SmiqFYlUHL6OTrBq
	 ZiAJgXlm8MWlWWnYO+ah8c9n1a7CaNHU0Q8nmlOUPXzE/kVbC5AHhPlf73b3k2tq46hbw
	 ZlcWjilSIIwRLDxZuNyAJ0ktIlzHl3fAjIe/8QoHcuNmDEdBiNmuAgN5J7Ilc0k47LmXC
	 sfZ7Knz94/XDOkDxV3GoAV26mGIPiykltGWkRQ1r4jTHVzMZ9ohad1C6zPuMbjUU70xMP
	 J4iM+7iaBkWOdEvN8xKK75yDvE8s26p4RogykszU9QajfSTaDBzSyeIteX9QJPh+UAw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793316468;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-Id:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding;
	bh=T3hxAM5cEROmPK4n0R9NwV2gBM2O/XyZLRlxcI8cqrk=;
	b=TFkWJdxQiDJ3OQB7EAFOKHoTaCSEmiQ3fnbPT5xny2uiNdTkmgm7Fwv13kbIszIjmxdq
	 4Yad9W4oJq8KMnmj+Stm09jDIkC0RtHeoqAYvNXwtsQbXhlgvbwPu5XS+Xmgdsqwm53PB
	 hhuiPxHwiA3DIUqlVquA7smDxjczBnrRQ0GTFNVdUOZjPCwx89F4tifrtXNKHrdgQT3tX
	 FATL0JIkN435LdCXl8wuvyHa6/zfKIHKOqGFA9A7qaCEz8NntmC3NMMsFLLOJCz4ije8t
	 hUTngSObuymgGsq/z2MkR+OT5hrcKxYhhaVzuj8ElFTD8t6l98dVBASOTY9BbooOIAg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=mojatatu.com;
	spf=none smtp.mailfrom=mojatatu.com;
	dkim=pass header.d=mojatatu.com header.i=@mojatatu.com header.a=rsa-sha256 header.s=google header.b=wXzhaUs+;
	arc=none smtp.remote-ip=209.85.222.174
Received: from mail-qk1-f174.google.com (mail-qk1-f174.google.com [209.85.222.174])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DBE16606A325
	for <stable@vger.kernel.org>; Thu, 29 Oct 2026 23:27:47 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org DBE16606A325
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mojatatu.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=mojatatu.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=mojatatu.com header.i=@mojatatu.com header.a=rsa-sha256 header.s=google header.b=wXzhaUs+
Received: by mail-qk1-f174.google.com with SMTP id af79cd13be357-93e64d52949so5688185a.1
        for <stable@vger.kernel.org>; Thu, 29 Oct 2026 16:27:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=mojatatu.com; s=google; t=1793316467; x=1793921267; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=T3hxAM5cEROmPK4n0R9NwV2gBM2O/XyZLRlxcI8cqrk=;
        b=wXzhaUs+nXAE9QzdFqH/pW6xNcQ2k3dW/Fyy5x+FYbA09Cvmggn1hOpcgdKuJBTzLw
         mtz3Q617eN688Pg3U0xVpuBvuKceCKq4FQhyN1yU9qMyNowZ2oOBRNWXr3bwBQthxIHH
         x8wK6ZIjuD4rDTn4JwoBlJ1VkrGJ4FixQB5A0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793316467; x=1793921267;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=T3hxAM5cEROmPK4n0R9NwV2gBM2O/XyZLRlxcI8cqrk=;
        b=EqhRVIN0HzhZLM+vy8Zt7LYPqYZM3/0/77GfKXG7vyLbLGQijN+tafFAFPWJEyXVOw
         yQMWwPLIkVvTW3ZWDk4aqcY3QkDihLUpAsgTKmC1mdRV8sJdw+1yGxxDTEaooXyRx40R
         w6Ys7QuI7nTvoo8JX0Qa1Xjp6O90AMsf5PPwPPKhWL69rByzrJ8pore4jSAd5FFo4spq
         F4SHcOZ6dN7RsLQYG89543W0es+bwj2V17XUsKgY5b6SMAaovWSqtPMIbE0wkIn0LwiQ
         3b6xSyIJSRv8rChnAY6PKgFPswFnTET+6fl43XnqZ6xFXlgK/BDbZFXhcRZ71nxhMRtl
         jO2w==
X-Forwarded-Encrypted: i=1; AKwUvBxeDAx/i2wU537SOsEbJ0UEwkP9GQTqnHKIRo3J1dIxkrGLq+CMu3q/RLOCGcIO5G9KrjrwauY=@vger.kernel.org
X-Gm-Message-State: AFq9FYJ5Oytf/cd2cagXGfVFGoIY9wF23jzvVlNL9q5XrJs9zrJ8N4UW
	DVbA5142F33HQbIOnHYUEyB1/cYQ/t5b1EeHfk99ob0OXYicvzSRJ96yHYpfgdmbHQ==
X-Gm-Gg: AYBFou0mK36RRTJH9Qn6IBx3y3e1U05TifPisQmHbbwYBnIhfzScmNkrt7QH5XPfScs
	UTUIjjGwozDAG86j4YEzYjG+MR61xHqgp6ArBe6JfXiDaOka7gvo74Y4009N1ngNL25Zxjkq6jh
	mX3UgJxNxikSqm5uqT5sbUvtyq6Ig2nwuWjlgK2RyUwRwsqF6GChHbVrYj3JlewNHUa1Zu1gCl9
	tpsfl1okAY8+Kl4LLnAy9qoEr+mTxXR+ooUyA4LDuXdlC9F80TgMacma2xFPntwcuSITDBHEO/t
	EGDL8QG/QhdHHawQ2PR1Kd3OHPuT6xV0otsS0Ahdyrql+xCOxhNfRV9Y3GI933hndfrCGheB0Za
	CTSJZeyFZcfSISS2lcTucX9eRcbh4AM9S4xoCAe6BE1KFAXjUVD0F0J1Ada6Ti9pwIa8ph+xwt3
	jxm1C6s0GfcGqMPLcM+y4Hc5f0pnww5aQ87Vg55pefA/vDmAjsP6bDeLLXcmTUtLlQopE+wJ5lF
	jcVbfvCskJ3jP1hYTX65HRrA3lHYlPKUj5lXRJShM9XiPOOwx8w7DulqMhlCNjAKWUyGbA00Lfm
	Rfa8HMkqJ6p9fHo30YNwnG4B49bdWcC4VafmfYhbx1pSXs+sNPY3foHunky6lIBYTWde4b+o8Ok
	=
X-Received: by 2002:a05:620a:2609:b0:944:dbd:8253 with SMTP id af79cd13be357-944217f72c8mr121536785a.59.1793316466853;
        Thu, 29 Oct 2026 16:27:46 -0700 (PDT)
Received: from mbili.waya ([64.203.83.2])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-94424243823sm5384385a.21.2026.10.29.16.27.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 29 Oct 2026 16:27:46 -0700 (PDT)
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
	Vega <vega@nebusec.ai>
Subject: [PATCH net 2/3] net/sched: act_ife: require a full Ethernet header on egress
Date: Thu, 29 Oct 2026 19:27:38 -0400
Message-Id: <SER-NSBD.v1.r0.20261029191634-2@mojatatu.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <SER-NSBD.v1.r0.20261029191634-1@mojatatu.com>
References: <SER-NSBD.v1.r0.20261029191634@mojatatu.com> <SER-NSBD.v1.r0.20261029191634-1@mojatatu.com>
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

Fixes: ef6980b6becb ("introduce IFE action")
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
 net/sched/act_ife.c | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/net/sched/act_ife.c b/net/sched/act_ife.c
index 2afd68983ece..986264af8146 100644
--- a/net/sched/act_ife.c
+++ b/net/sched/act_ife.c
@@ -876,13 +876,16 @@ static int tcf_ife_encode(struct sk_buff *skb, const struct tc_action *a,
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

