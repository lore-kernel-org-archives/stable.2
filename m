Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.160.171
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793477909;
	b=HJ1KfPusjmNh53AqQkX/g/wW3AaR0MTi3VUjNfnyP7HMabTi0yuMHF6uPXUU6arAXVZp
	 tt434BRiagIXIudj4Za9mRnPIPjdQ+ecCmQav9e368aHd1tbJiNVWwzexeKU+Lr0e4l6b
	 5VjHBbkH852Z9EPspw9mImUIgDZkQN2pNZtbDk7C5rc5hFCamI4qYbWCaqirPHfWAO6Ou
	 l6Xk3nr8raRT4sZmCgUcb5CQK+fvSRlao3R3rXRqllsgooAxdOsmjWP80czbWKUPBVaKb
	 7tPUl8uKa0ucWt2k/nk5BV713hy9Br5Cq6yPKUk+3umapt2JQ4R33ulKH4KCULYHNfw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793477909;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-Id:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding;
	bh=gJkNAOVOAvEBRO8m/lbd12U2Ey8CYDNo3KZV6fwQHpI=;
	b=XvqiFbeXytkxSzT0D5OKjgWFEGnRFo/xeVleh7o6XvWYKpbQv8McXY+TV6hNQlqYVOoB
	 mq7dm0G9oM7KGTCU4VAe9mcv4v8nhojZKoLfUGGKwU58sv5ozMmo+HfB/p1x5QMiGoAkD
	 VZf7ljv7kSpD1pSqzDUTycOH25qRGxBrS4UVkFnCvBvQ7GOZgCMlV5tvPWNGAPiXB4eZZ
	 yiy6JcN2bcZMVZQLFe5RHwHugn9Zu3QCMNaO9m9AR4b0yIrzp/ruOEpy5b1Qp/420AblN
	 1kVTJFvpyQFuPvGOWmqGMA0WlOS427FKExD6X8y7uMRDnixw6y4Bhjj/+89I5K4jVkQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=mojatatu.com;
	spf=none smtp.mailfrom=mojatatu.com;
	dkim=pass header.d=mojatatu.com header.i=@mojatatu.com header.a=rsa-sha256 header.s=google header.b=osapbFvW;
	arc=none smtp.remote-ip=209.85.160.171
Received: from mail-qt1-f171.google.com (mail-qt1-f171.google.com [209.85.160.171])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D12BD606A31E
	for <stable@vger.kernel.org>; Sat, 31 Oct 2026 20:18:28 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org D12BD606A31E
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mojatatu.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=mojatatu.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=mojatatu.com header.i=@mojatatu.com header.a=rsa-sha256 header.s=google header.b=osapbFvW
Received: by mail-qt1-f171.google.com with SMTP id d75a77b69052e-5364d86f7f0so25461331cf.1
        for <stable@vger.kernel.org>; Sat, 31 Oct 2026 13:18:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=mojatatu.com; s=google; t=1793477908; x=1794082708; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=gJkNAOVOAvEBRO8m/lbd12U2Ey8CYDNo3KZV6fwQHpI=;
        b=osapbFvW8/pvf2FVPzK08DCcACCLYKsFigFN7so/RZQjdQoK5OfyaOlsF5bx1oN4PU
         IFxqcEWhsB3faY93F9VdZPBAm1Gwi3rmt5qcWqz4zwb40wSqC1/pp3kxMu+eijtJ8oSW
         UQ8L6YRBLKC8TF1l/O7iIwNCzjJ8sA/VcEEag=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793477908; x=1794082708;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=gJkNAOVOAvEBRO8m/lbd12U2Ey8CYDNo3KZV6fwQHpI=;
        b=LsmYLIfE6oEsqKGxEzrwHEMdGezrM7KZ65rfSI/gZwsOylNKM7n8jO5HABPvwrztRT
         WxEUABwF9xRDNW5au7f5LKKBxDOVsOIg/Gs3OpaHMAuR5SpA1Su61WmcePYcnX2i9R+H
         Ve/Ux5shSOaH8wkyMRMcT0/ZzERc4xiuhGtyxZ+Ic50CEwx6TXD27Nu+yj/xfWju2m5F
         HuLKvdfVnXdMqPQh7am4NgbLbpPWvRqC+5BwD0d/VKT4hj3kpCqCLOuzqhCtTYXzJZxt
         maUxTSW3KmcGrzKNI4coIPH2KiG+ftz8WaBGAd/deToaYHS/glrfbFqNRol7X6LY23Hz
         TX7g==
X-Forwarded-Encrypted: i=1; AKwUvBwo9sFYnHxgwLjCjqcpEMwD61oaZosMHJ/tkdwumSs8C6gkm+sGWEL2h5Mytb4BMj1c04OMWTY=@vger.kernel.org
X-Gm-Message-State: AFq9FYK4xszHBPWdfrQZpnuaZReRaKjA+u3nvLJ4m4wjkZ3NmrUWUTGL
	ihUE2g55Wlf+vQ5prEs7nKmOmqdweGVlAejbhDIjxoXvX1IvfBX/J8G9DdLEkz3yJw==
X-Gm-Gg: AYBFou16eYK/vPU0sl0CPpiKLIYTti/qYgpForGThqGITR4WUR1f8UuX/1lhqQAODdd
	6Hb2WIBroohl+m2MUj7lUpQ4zwVkM8g6hOwFFT7HnE8qxE/UWy0vWAimMs4PY8yl77tTcQl38ec
	Q6SKmZHtCwMgkQO7dBqI8tZOdOPCVfqKr4xOMi5RcMN2Wigyei0RJIhW7wMqrCNy7+joNU/OihN
	Bm1LPdV/9CT0C1S7SK7t+Lzws1L2ZjENT7p4q9TQPDju9tKKBM+jjJY5Zo4Hl0v8ss4Dttt1bYM
	FddPFKRnZNmOtXlSRcFLuOTnlPJzqrrFsRIoOSUr9BcJweukVUDdxXYDeUk++UQA1RFnAtNJN1Z
	m++2cDYcPV8Pgxn7fM9CLXgo6wTsnYKaPLtr0XaMVLQyWD4hx/SCGkaSfi5Y8HebuiR1CkQe7xO
	6JxOB/07XljbWwEwUISH3P7Nscd4UqTpg274pw32CC4tk4gBPLOeEY0JGOA5ZBo44JoFuOYMo89
	zHF0C4fnwFlKYMviUFjqqNqMD8kXlJsvL5SmQCOBToI0uoPRGEoIObs70LNuIz4gNCqUswa+291
	zjjfPaRc8LQXk6d6mtJQdZ7A4488KSeqsvNVT974/GicPg6ddhtNc6GE29kwawVpwcIWNtyaf/Q
	AIQ2eTIT0TaYcsFE=
X-Received: by 2002:ac8:5d8d:0:b0:535:a5f7:d589 with SMTP id d75a77b69052e-542b7ef72bbmr102820061cf.67.1793477907796;
        Sat, 31 Oct 2026 13:18:27 -0700 (PDT)
Received: from mbili.tail33bf8.ts.net ([64.203.83.2])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-91ca7e23441sm49148926d6.4.2026.10.31.13.18.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 31 Oct 2026 13:18:26 -0700 (PDT)
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
Subject: [PATCH net 2/3 repost2] net/sched: act_ife: require a full Ethernet header on egress
Date: Sat, 31 Oct 2026 16:18:19 -0400
Message-Id: <SER-NSBD.v1.r2.20261031160050-2@mojatatu.com>
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

repost1 -> repost2: rebased onto the current net tip.  The repost1
posting was recalled because 3/3 no longer applied; this patch is
unchanged.  act_ife.c gained 498c631f9c6d ("act_ife: do not consume the
inner header on egress") since repost1, but it touches tcf_ife_decode(),
not the encoder, so only the hunk offset moved.
---
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

