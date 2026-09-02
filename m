Received: from mail-qv1-f45.google.com (mail-qv1-f45.google.com [209.85.219.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 89910377A90
	for <stable@vger.kernel.org>; Wed,  2 Sep 2026 21:29:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788384571; cv=none; b=ZQdtBL+E4FkmE3r0NRQ9HYoVaaSx57MxKh4xqNcP09wDWt6wFKMF2jHbpE86VLFwYWe0FEIY/dZN8gwTyykxIQafZFNYgTXiiATlx2Z7TNsSxVHu8nV55DHBe76dxDcpxyh06ySnGsg21XfDyboCNEpCdsMVBbNfbxWkXl4/GKw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788384571; c=relaxed/simple;
	bh=4fTOBu7ZmtSh/C3l6jTVpDrODpwVf3HW1zi4un9olTg=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=uabtxw8vmWTnaS2GlIXZ5y5tsv0Z8lS1hZc/f3jZFrr3NWkWbkerHYPEDgAZ2g+iALdaL6vsYIbByfPge2qi9WuNiThwFmjNIWX3X82Wdj9eH4VWqPq8ILJqHYipH4zLdbejGqepxysb4Bdl+fTZSzN20WpoKstWlSYy0HY7/wo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mojatatu.com; spf=none smtp.mailfrom=mojatatu.com; dkim=pass (1024-bit key) header.d=mojatatu.com header.i=@mojatatu.com header.b=x/RI14y7; arc=none smtp.client-ip=209.85.219.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mojatatu.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=mojatatu.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mojatatu.com header.i=@mojatatu.com header.b="x/RI14y7"
Received: by mail-qv1-f45.google.com with SMTP id 6a1803df08f44-90cd7ad71a9so21696196d6.3
        for <stable@vger.kernel.org>; Wed, 02 Sep 2026 14:29:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=mojatatu.com; s=google; t=1788384559; x=1788989359; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=W05eG7tDptWvPiRXlFUVnZdx6HhWTPdwO0Ji7A8VYos=;
        b=x/RI14y7b1OWkUFzzwLuGzE0Q29oQzJq4Yf4hNiAVrUHS+put83cDjoV9VutwOsDmb
         N53GJWcYDvDI5WjeA6UkbmilzUvzp/ESmV268eqPNyhYBQogwJsMOzPOjpmuc4BtviBu
         g8Dgk0teeDb2Dwx0ObmxidN9a9hsO+Qkw840Y=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788384559; x=1788989359;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=W05eG7tDptWvPiRXlFUVnZdx6HhWTPdwO0Ji7A8VYos=;
        b=TJ/IHZwcKfk9dbTu6Ea2D662UpYhC8HqNFmzD4KGki7VX81jwAGaRuaoZ7+oyTgMlK
         6yst+Or7vA51WA5puATokJacdBmeQPSn4dDrBXJLNbe7wHkxEq8zPeHpo0MlAJ5wqS+6
         29jmrn4Sp5Q9po9yZ/b1mgASxkA4TGug4jDc03IQ7sbiwNWnJ5JMtwaofOXeIBRHbZKQ
         c8jM3M3QztXZlDFeH697CPp6CHNGE4oTL0AKCBGzKFMeyTIxfAYRguflCJUifi91bEuu
         Yp7fCUSSdLqYdLB+DMkJLXLDiz0BCEbiF6eBK9z/J8GAPhFtPluoLLJI/Au0fcxdbrIM
         p8qA==
X-Forwarded-Encrypted: i=1; AKwUvBwZSng9WkrfXGqV1mhhTshzvQdowlM2yEuc6BR5m9Myhzip2VoX79sQA+xFvOO57IYHt8AtHx8=@vger.kernel.org
X-Gm-Message-State: AFuF++lrXOnmion9hNw/uL20RILj/58n0/V5+/HDXpy0wkD2vFY8iAp2
	WJYP2wFQRqOni+Uwn2HowKNDxKHP35XiaH5SKkndIdeo71p6vvu87I1m2ZurdObc8w==
X-Gm-Gg: AYBFou3Y2uFfy5t3tkaF6fMoHeOTrBAL1/jC0pFBD5NaonNgYbBaoSNOjjJbUH+AiE0
	B+RE5aTb2c5Oj4FKWV5tJI+gHjgAub6RbLhBLmcJCCJOiH0e95BBV8lm0NwJn7Di43heb5Z2RmG
	13mU+mM7yMHQNSEPeCgOUq34Qs60WbGwDa0jGZel+coQP/aQNFxbWnyEtIm+tQb2uuqYTeAMlIx
	zLwg3h/whlpLV1QPk44RXyBvwQsMMRYC+i28GmUuzAj1x9xJ/ZVKeGo7V+NyBie4Iikr9ovgWxN
	RIYMX4pZH0+SUG4IOe5aVc/RqFJth5cyPkv9mDjZpOvTWfzSoRLfFOQTkmyTdKAe0mbNNb39FLO
	J6gMsTcRbBiRBekHD24Ax9rcvcIsdXeDt1Txt2VF39dTAWXsAVjQEwnmG3wSm4nzNBz2qmeEM7s
	HbZ+UaCrRQ7ZEinwN6JxkpkoFNAv41aUYqY6uqbTawKZyoG6A8VaNpJMUkoqMIv2/uc3VcFyOLp
	JrUuTL75vgSixnFjPRHPNf2Rgi4JFNbAuNNKw==
X-Received: by 2002:ad4:5cc9:0:b0:90e:8424:4068 with SMTP id 6a1803df08f44-90eca39df2amr102399596d6.24.1788384559119;
        Wed, 02 Sep 2026 14:29:19 -0700 (PDT)
Received: from majuu.waya ([142.159.91.240])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-90e9ee08710sm27169086d6.2.2026.09.02.14.29.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 02 Sep 2026 14:29:18 -0700 (PDT)
From: Jamal Hadi Salim <jhs@mojatatu.com>
To: netdev@vger.kernel.org
Cc: Jamal Hadi Salim <jhs@mojatatu.com>,
	stable@vger.kernel.org,
	Jiri Pirko <jiri@resnulli.us>,
	"David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	Donald Hunter <donald.hunter@gmail.com>,
	Cong Wang <xiyou.wangcong@gmail.com>,
	Shuah Khan <shuah@kernel.org>,
	Vega <vega@nebusec.ai>,
	Victor Nogueira <victor@mojatatu.com>
Subject: [PATCH net v2 2/3] net: reject oversized tx_queue_len at netlink parse time
Date: Wed,  2 Sep 2026 17:29:09 -0400
Message-Id: <QDISC-2899.v2.20260901233641@mojatatu.com.2>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <QDISC-2899.v2.20260901233641@mojatatu.com>
References: <QDISC-2899.v2.20260901233641@mojatatu.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

rtnl_create_link() assigns IFLA_TXQLEN directly to dev->tx_queue_len
without going through netif_change_tx_queue_len(), so a device created
with "ip link add ... txqueuelen 500000" bypasses the S16_MAX cap and
still triggers the oversized ring allocations in pfifo_fast, tun and
tap. The veth peer nest (rtnl_nla_parse_ifinfomsg()) and the
RTM_NEWLINK-on-existing-device path reach the same sinks.

Enforce the cap in ifla_policy instead: IFLA_TXQLEN becomes
NLA_POLICY_FULL_RANGE(NLA_U32, &txqlen_range) with
txqlen_range = { .min = 0, .max = S16_MAX }. All netlink consumers
parse against this policy - rtnl_setlink(), rtnl_newlink() (create
and change), and the veth peer nest - so every netlink path is capped
at parse time and rejects the attribute with -ERANGE plus a proper
"integer out of range" extack message before any device state is
modified (the RTM_SETLINK half-application wart is gone with it).

Document the bound in the rt-link.yaml netlink spec.

Conditions to recreate the bug:
- CONFIG_NET_SCHED=y, CONFIG_VETH=y, CONFIG_USER_NS=y, CONFIG_NET_NS=y.
- Unprivileged user in a fresh user+net namespace (unshare -Urn):
  ip link add v0 txqueuelen 500000 type veth peer name v1
  -> on the fixed kernel this is rejected with -ERANGE ("integer out
  of range" extack) instead of installing an oversized tx_queue_len
  that later inflates pfifo_fast/tun/tap ring allocations.
- ip link set v0 txqueuelen 500000 is likewise rejected at parse time.

Fixes: 38f7b870d4a6 ("[RTNETLINK]: Link creation API")
Reported-by: Vega <vega@nebusec.ai>
Tested-by: Victor Nogueira <victor@mojatatu.com>
Signed-off-by: Jamal Hadi Salim <jhs@mojatatu.com>
---
 Documentation/netlink/specs/rt-link.yaml | 2 ++
 net/core/rtnetlink.c                     | 3 ++-
 2 files changed, 7 insertions(+), 1 deletion(-)

diff --git a/Documentation/netlink/specs/rt-link.yaml b/Documentation/netlink/specs/rt-link.yaml
index b80c2ac3ac31..99f6fba456cc 100644
--- a/Documentation/netlink/specs/rt-link.yaml
+++ b/Documentation/netlink/specs/rt-link.yaml
@@ -898,6 +898,8 @@ attribute-sets:
       -
         name: txqlen
         type: u32
+        checks:
+          max: 32767
       -
         name: map
         type: binary
diff --git a/net/core/rtnetlink.c b/net/core/rtnetlink.c
index 81c5a6104dea..9ea4ff9c1e29 100644
--- a/net/core/rtnetlink.c
+++ b/net/core/rtnetlink.c
@@ -2285,7 +2285,12 @@ int rtnl_unicast(struct sk_buff *skb, struct net *net, u32 pid)
 	rcu_read_unlock();
 nla_put_failure:
 	nlmsg_cancel(skb, nlh);
 	return -EMSGSIZE;
 }
 
+static const struct netlink_range_validation txqlen_range = {
+	.min = 0,
+	.max = S16_MAX,
+};
+
 static const struct nla_policy ifla_policy[IFLA_MAX+1] = {
@@ -2297,7 +2302,7 @@ static const struct nla_policy ifla_policy[IFLA_MAX+1] = {
 	[IFLA_LINK]		= { .type = NLA_U32 },
 	[IFLA_MASTER]		= { .type = NLA_U32 },
 	[IFLA_CARRIER]		= { .type = NLA_U8 },
-	[IFLA_TXQLEN]		= { .type = NLA_U32 },
+	[IFLA_TXQLEN]		= NLA_POLICY_FULL_RANGE(NLA_U32, &txqlen_range),
 	[IFLA_WEIGHT]		= { .type = NLA_U32 },
 	[IFLA_OPERSTATE]	= { .type = NLA_U8 },
 	[IFLA_LINKMODE]		= { .type = NLA_U8 },
-- 
2.43.0
