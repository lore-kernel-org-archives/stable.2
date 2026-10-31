Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.222.174
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793475372;
	b=pHo+TLxbvxLQfAj0AiMdOzwNqUiHcml1oCKv5iixd+01lXXGS1wE8EN4HIJVMQ6+onGE
	 YfUIX7hknmCqP40C5bp0OURsGjHUuD8oEf7zgeh+wPXhWGQEIDuQcz6O8rEB7VM69tAZU
	 1lP8PJkuEh0yXrF40scgyBX/sftocM1C6FOYraGS+Ou1pUjkAIM1a81J7iGaYAo9KHPX7
	 HQDB/S4C/OR7IdYvSNqrAT98U6h4rJXgbPApma9RBaztE+HKa4Sq2LR80cKPsUDyX6q12
	 lfM9qKIiOIFnYDaXVBTM8cQ9ilBCGtBDyxwORRddjWHip/LXeMDKTeoFvUsE3m57UuQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793475372;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-Id:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding;
	bh=T3hxAM5cEROmPK4n0R9NwV2gBM2O/XyZLRlxcI8cqrk=;
	b=VHP3kBfd0Fb2OQztnJ5ngmFpqn8l40ZEtxMfAvj5kfcTWJtm5+rPxnFKl4mxiuGQWRQr
	 +IFET3xbJFjrWTt5CfUm/M5dV0wGsFcA4Cx9zsVDZQbts5Lv9iudQB6Jf9EBEQ0q9WRNk
	 HT8wGpLCo7drLFKGoHMKPlHLFyMC8MctqEeFEqFvWPmrZ6gAtkLEjXvXDW4SOBekI6Zf0
	 vK6yAaprRoYz3ciBGfhlG+K7OSe2ke5WNyduLkSEKyve12QqqF3OU2iJnAl22IYaL44ni
	 hyvXa3yHQ6IbShx0OCWP7VpmKgCblSX4F5RbkNGzbJlZIyKdQWIYqSROgYOZU1QlsTQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=mojatatu.com;
	spf=none smtp.mailfrom=mojatatu.com;
	dkim=pass header.d=mojatatu.com header.i=@mojatatu.com header.a=rsa-sha256 header.s=google header.b=sQ0if6jp;
	arc=none smtp.remote-ip=209.85.222.174
Received: from mail-qk1-f174.google.com (mail-qk1-f174.google.com [209.85.222.174])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 80F33606A32E
	for <stable@vger.kernel.org>; Sat, 31 Oct 2026 19:36:11 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 80F33606A32E
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mojatatu.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=mojatatu.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=mojatatu.com header.i=@mojatatu.com header.a=rsa-sha256 header.s=google header.b=sQ0if6jp
Received: by mail-qk1-f174.google.com with SMTP id af79cd13be357-93f259cdc86so167532585a.3
        for <stable@vger.kernel.org>; Sat, 31 Oct 2026 12:36:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=mojatatu.com; s=google; t=1793475370; x=1794080170; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=T3hxAM5cEROmPK4n0R9NwV2gBM2O/XyZLRlxcI8cqrk=;
        b=sQ0if6jpmRvMZgps5pZsOPm03BKyUoafhUkOECOPcsYVBLTZsYYdDYchxGW4CoOXTq
         5HeycxLZKIsY1Tv7dMWxvxibkozLYkDmqR7tWHWK0eEBBIC94OdyhTtfEqj5F7Ojn4ID
         F/w9uv9r/DPlI6jyQIxJlfaaGM5QhDDoc2i0s=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793475370; x=1794080170;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=T3hxAM5cEROmPK4n0R9NwV2gBM2O/XyZLRlxcI8cqrk=;
        b=uzFiMJ21dAnR/yepp+u0WtgbC5+sMWY5GGsS8oK1URtuLs7x98X9kHt6Vard+zpYAr
         S8P473HkI1MiZD2HKtWt0tOMn3glOc8sZdwS5596tjV42yII2C+reJR7mByrNyQDytpb
         mEkz1hw7mLRQoN9mZq9SHeKcOZxnoWkdyO3wd1hUik0KNwTyl0X7bgTbb8w5DzggDP3Y
         svTGTjqvPmj5qoF3VasOATG5r4maF3MovyEn5s6jt063tJcL9vZQRum8t+HCBj7daOJ9
         fhOZl4tooD7iyXboNMi+s6PziQLKjume9/GV6mhp8w3JxMEc1ATO69zA/rgmiNoX0Dle
         w2Ag==
X-Forwarded-Encrypted: i=1; AKwUvByomDA2/jltSFmxLPSU2D1AtGXsM7uARi8jaGmuRLsGNdKl4T3yk8ArT5AaDUpQOhDO4rXa30U=@vger.kernel.org
X-Gm-Message-State: AFq9FYJZjGugeYla7RsdG7E8mpBS2hiEE9w8PJ+VR6NDBYns06m9lO0z
	N2tGbH97yAwB2lTyyl0of7c9opoWBqg5tBiw6BlX1UheyItA465YgVyv3OwGtjMijw==
X-Gm-Gg: AYBFou0oCtwSnuo7vz0VzPkGcCLNyDf1FlzJ/gFmI46yoRO28HtTUz9w/9ezuM6V68a
	CgI6nSGywOzwBVQsI9us5oqf32LfSYrTt0SN9FrTKi8+qEYYLdIifuyfC/lNc9iJHoQrH8+wM81
	YzmpE9MIatqJIV1s6loXIipE4PmTLzo0WlEIa+CaJNQA+AfyDFzu1CF/8bvrgcTmL1sxIjkVYJ7
	kHlZwyUGQvfY41fxYVS/kLkVyfe9oalM8bTmGGYT5E0DxIgipOWURgOorIVwMmRl2uUXjQiPfen
	PR6tbLDNm3m03vzzTuw2wULxP1XZMlLWsrs4SMzOHM/ptDv3o9OwdN863q4qvq+K68kgsBmyVnm
	+c74TiNlKOJV1UnVjwXYf2xROkcNmP4k5XRiZTllOuFMe4IlVEezclYNy+6dJW3+bUQHnN4q8Cz
	kLjxOq6RMsEFuSiNGHFfiOTNJJf/kbzCkAYsXxr2oOb05zuiMvr8Pn2qfbWGUHbC8aXR1K1TSM5
	rVB9GoYujbgdpcVX4iHoy0hQk5ymxXCT/3+sBkO6W+/0hjey4TONLglNdJxQBy4fe9wDBwDIEpl
	LhZfy3VAjHBIUpAgjPsFx1IIAPMCeUwWUIkE3W+gkaC7bbqomsaIGssK9V0OHp7sktsockLUSxI
	BYPFYUC/7kIBHUn4=
X-Received: by 2002:a05:620a:2702:b0:93e:e4d1:797b with SMTP id af79cd13be357-944217f57eemr951964985a.56.1793475370499;
        Sat, 31 Oct 2026 12:36:10 -0700 (PDT)
Received: from mbili.tail33bf8.ts.net ([64.203.83.2])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-94425abd317sm446917585a.36.2026.10.31.12.36.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 31 Oct 2026 12:36:08 -0700 (PDT)
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
Subject: [PATCH net 2/3 repost1] net/sched: act_ife: require a full Ethernet header on egress
Date: Sat, 31 Oct 2026 15:35:59 -0400
Message-Id: <SER-NSBD.v1.r1.20261030042947-2@mojatatu.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <SER-NSBD.v1.r1.20261030042947@mojatatu.com>
References: <SER-NSBD.v1.r1.20261030042947@mojatatu.com>
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

