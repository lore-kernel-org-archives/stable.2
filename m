Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.160.172
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793579835;
	b=OQfNyWHsj1T/+OC5Vmj9hjqNwLawvXuK4hhFeN1NoGEzCKjuvFNyWk3llmlPnkEGE/vb
	 iAUMLCTG7kWP7L78aD+qD+WX0i3V4JxNFXXTAD1K/vsC8k3ucRXA4bOqNIcKpLUl2hUXp
	 dYrz51VTkawxTErNjD3YU54r2/6Wnp626Wpf/U5hHHOb3Z+Yq94WpDoO3iSUBFJYQVkIz
	 FGHr/eYSZl/c+DbR2gphnbR3lImQVeKg+x7xR8uujL0Kg9Y457flC3QB1vQ1vpvwV+OGD
	 VJKhqG47biDLmd9nuSWpSTeALukX6WpKWKI/isYcdpYaXZXe8ZcPAZHetD6jyoUSnEg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793579835;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-Id:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding;
	bh=Fcyt098zqH0vjocBgVntMP3k8zQT1uQko7bTZ4Zabpc=;
	b=SyArD07aDOdoEtvLUR+GCkgKeQCMO3qeoikyYpsLTuqiRqnFElv9aYT5xSkzyrrJOYQS
	 Ffm7eagH2ha2aflVGPfiWFptS3rrNAcLLFOTwJytnUGydVHiV+5MZgy6ZYyT6e9JiS7Em
	 RbwAOuGVlY6f7BG4OAYOClaOcHtEUmKSLtvWWVzWH59dLvf7/eJCoeRIXxBZvnBy0nmKd
	 Q5n+uv89v01anJt8FLrBIrGGyUsfdu5yHdWLehPAeUIfR2LXbEqTAPct8udkk8uYjy64f
	 m72ctyVRACKHrGS4N8a5o7u0e/lJLw8Gy7PyVDr6rjhkgGaSj61OjKltgwdjHheiEsg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=mojatatu.com;
	spf=none smtp.mailfrom=mojatatu.com;
	dkim=pass header.d=mojatatu.com header.i=@mojatatu.com header.a=rsa-sha256 header.s=google header.b=P51eyIq1;
	arc=none smtp.remote-ip=209.85.160.172
Received: from mail-qt1-f172.google.com (mail-qt1-f172.google.com [209.85.160.172])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 67CB0606A32D
	for <stable@vger.kernel.org>; Mon,  2 Nov 2026 00:37:15 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 67CB0606A32D
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mojatatu.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=mojatatu.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=mojatatu.com header.i=@mojatatu.com header.a=rsa-sha256 header.s=google header.b=P51eyIq1
Received: by mail-qt1-f172.google.com with SMTP id d75a77b69052e-5364c951da4so25030561cf.1
        for <stable@vger.kernel.org>; Sun, 01 Nov 2026 16:37:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=mojatatu.com; s=google; t=1793579834; x=1794184634; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=Fcyt098zqH0vjocBgVntMP3k8zQT1uQko7bTZ4Zabpc=;
        b=P51eyIq14uu5yqDIpxAQoZj5PX+xYhhpr0Q8/+/CqxOItoCAAtOvuZblX5Y3HLYvJP
         BAE0uRgGSTV3H8Ax2bYbgYx8POkk2CndBaZ67v/snj5k5irCZL02ZZZOyG3vrd1Yb19j
         ycEnUGwFtJsgVQnI1XFHF6FtvAD5vDjc7hmEw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793579834; x=1794184634;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=Fcyt098zqH0vjocBgVntMP3k8zQT1uQko7bTZ4Zabpc=;
        b=A7ScaO4+iBWyV6UiNDZHNdmqlilLTety+sNdXe++SLMNo8nntRFzBuniCYWuQ57z8Q
         sGLvbGo+FlU1oprQqsw1frU/lbyHwXxev3X+gAG8ZR0PADvUL8B/iAOKzZPQ5V0x2k9t
         C3iad/WJ9rx/4Rz8QJpIN/cAKwM8EFK2DPoaVsXtL6cL3KRzdpfFJGZfCCW7WCqjTdWE
         1lvgTcwHX5+R6oj6TKgkAJyWgHzrAh6w20xr4jm8z02DHtQUG/sMgnba25FBM3GuOuuk
         s5YRPXijC6coBWsqnNLfcdDdM3rB8sr4CsqOJsVwxhZosIzR+KldOU4ROmXG7Mf0+acy
         cV1g==
X-Forwarded-Encrypted: i=1; AKwUvBydCdJG6TgHw0og2ZB+hpB9m+OY4NHxzlG+fuc78v1IGddObYdHA5MTd0TzVVWpNZud7Y4TNYI=@vger.kernel.org
X-Gm-Message-State: AFq9FYJngOlSV5Teg8GGbOfSDt0E4po5O3WWpKjWnBejJm2b5a0+t4KC
	9zm9HiLvA2Hqqy1lsoDGHoHNpEd6lvnnCtQY4mWV44aJpnQLK/Om3btTW5P17oHn3g==
X-Gm-Gg: AYBFou0S30sot4SUsL2AG6FXMfeVA2dPQ9uxz8eh1+/MsaV1THZSVmuwrtCgoU6vdjI
	107UeFBMKNrW8xw90KpjAEsKG2pNRL2wc6pAAmZzk0d2/L/CWm1PiXBItRNNd6VxAIG351w//Qv
	ml/elkWtZlL9XyTEPeksP+7Nr1z6/uVaraBY1ZbzhO0BrOciM1u56WBZ3gcJdN9sv4g3pNJOzgi
	m5ZViBQUdZS22IZwRtXOwWqRQt7HvWIv0nExUO2GKlXgyRf1hNWpHibEccrhusFBPymqiWNmfJ8
	ISnYGTQ0vpypWcUetY/Atn4OWds0nTp3BDic4uYwFuPWbuUa2jORA556wd5kpIht6tbQ6EUE7IM
	Si13JrDHKjaPuJkGoBcl3vlNf3GczjbOwUvEpiDOfoqifzyK3kXvyE4AVd5qWjOps2StrcV1aT2
	CGDb4xGmYLL9AUQB4gDsBUqH1CXAjYJKjyixBb6ZpQPdwawtdJkiNGYh/YuDoMP+Ib0wQXc4Hsh
	UFsY/jpcBEmP6jPGbDwyeW/C4Yem93NmcInKPb8lUR3iC202MkwQpNShg9Nmamq5BGHhgpbZYhJ
	3ZZ4nK0nuDjHW1kaUfmo+rjogOIsknzE9plSF3DkPQZsdPqUki2p+uhqAgFlzoin/cI/ScI5483
	rYjLnXxPLpYx+fh3R
X-Received: by 2002:ac8:5ac2:0:b0:535:a5fb:6451 with SMTP id d75a77b69052e-542b83f6af2mr144848921cf.75.1793579834332;
        Sun, 01 Nov 2026 16:37:14 -0800 (PST)
Received: from mbili.tail33bf8.ts.net ([64.203.83.2])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-91ca7f23754sm77043066d6.9.2026.11.01.16.37.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 01 Nov 2026 16:37:13 -0800 (PST)
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
Subject: [PATCH net v2 2/4] net/sched: act_ife: require a full Ethernet header on egress
Date: Sun,  1 Nov 2026 19:37:04 -0500
Message-Id: <SER-NSBD.v2.r0.20261101171325-2@mojatatu.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <SER-NSBD.v2.r0.20261101171325@mojatatu.com>
References: <SER-NSBD.v2.r0.20261101171325@mojatatu.com>
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

