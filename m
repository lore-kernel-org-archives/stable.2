Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.219.48
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792756779;
	b=frJdFSIoGxqGp5hg/I+HPA+3q7xZ2iRpXStRo7UbD9kdvqkVOEQCD9v9DxPL0s3m+xWk
	 NwmELU6VIhxWRJ2ZAUsdPePOMKb8nxDBVCvhjJfNeX6y6FBEG/o1KeXjuiw8jDjDMdfma
	 QmbFZG0S73cTeMHkTUdUnt2l2sCDp+yAYRE2wsrGC/7RqOtc3nTX/ntijRritNeMuaDAu
	 1aRttBuqaDGh4DvpvRClyU64BMgN7S4mHO00ZYTLZCpLDic7aG6EfRRNtoL0PtmWvwK7W
	 AOg2JUwRTMZyCQlSIz6UT0OVwD03b/hwahbgSHyahATf8NT+b+rvYF8qwQRhXK0OQwg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792756779;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-Id:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding;
	bh=CWsdl952wtvjN6N+gHzMg8QSBVTcgUU9JWbb59bA4rg=;
	b=ylhePwwYxjQ/ayDJMvfWduP0DWSnwoF4BPlrtUla6oAhIHhMnXhW/J+fz2CQbrK8TqNn
	 ut3yRGXuLaPBDP1dTjbFy+CmiuDZH3i8Ngn+ZiA02StJVlKWjMjYJrTWpWZFMdH9hOqGl
	 p3MUh9yGg6PhVFX3pFgGjexStvrr3dEJT3l25QHV1KRokNKOhNhWmuTTna9A2enNdYB9E
	 /2Yo/HEtZ6/1qLEMx0cDUJu/gLbGLn5xpa02SdvvZEPzhtPyRvyEHKz0iryvS6RkWtgMt
	 gKIPCUyAp6SwjUnaH2mHbtq5gN933As4XioJO9mrpA3EInxM9D/jJB1QOE/7b/PJZzA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=mojatatu.com;
	spf=none smtp.mailfrom=mojatatu.com;
	dkim=pass header.d=mojatatu.com header.i=@mojatatu.com header.a=rsa-sha256 header.s=google header.b=nBgUe0mT;
	arc=none smtp.remote-ip=209.85.219.48
Received: from mail-qv1-f48.google.com (mail-qv1-f48.google.com [209.85.219.48])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 37DEE606A33B
	for <stable@vger.kernel.org>; Fri, 23 Oct 2026 11:59:34 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 37DEE606A33B
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mojatatu.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=mojatatu.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=mojatatu.com header.i=@mojatatu.com header.a=rsa-sha256 header.s=google header.b=nBgUe0mT
Received: by mail-qv1-f48.google.com with SMTP id 6a1803df08f44-91b83459526so10118656d6.2
        for <stable@vger.kernel.org>; Fri, 23 Oct 2026 04:59:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=mojatatu.com; s=google; t=1792756773; x=1793361573; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=CWsdl952wtvjN6N+gHzMg8QSBVTcgUU9JWbb59bA4rg=;
        b=nBgUe0mTADJl4ddyHy6UPd5rx6Iqavbz+zHKePt2nBRcXCipAzgq7s0KUA9aKlnPDG
         uGT1KX/YwEp/JCK7W1+PqoS2gswSwQjDsqgkC36gQMVdhWQnW9US6ZPyW9gyVwfKn9Yf
         8t7zgDnmRYxzuCmGa/s00BnvT/+jH6NiN7vgo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792756773; x=1793361573;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=CWsdl952wtvjN6N+gHzMg8QSBVTcgUU9JWbb59bA4rg=;
        b=QcYtTtgQcUr5aBThNfyJDUuidj6eBFDW6Zjoid1ohIAg56nJTms5ceznUhclNsDuub
         OxLPbHYCAWXHiu0uKPMEJXX9BA5zWjQClVzwAXu3beHuPO3SALQ8Qin+vkQH9QB4U2Zc
         bPO9Ys/J8+MDRygsDt6lS21o5T/Z+5pOeuBQoLL1f5BbpOekKmxP9jiaXdz66d5yFHSi
         GkofXYc3B96bvEoGE7Li3ChHz4Veabp7bDyLUq6dH/GKV3rjDwtvW1xZDXNiZAO89qxg
         ArgVdWTkgBLQGKBrlB8/0pBSaZdgnzQu9PKZyS4mg8zbAi5g/lcsAusR9Berss7hJijz
         gCgw==
X-Forwarded-Encrypted: i=1; AKwUvBxzQUYoG1kMNKcuMGJkLXbuHtQwmcVYCSB+e4H3+r3uXnV+ued1tJHuNoxglG7Vuw1i3KIoml8=@vger.kernel.org
X-Gm-Message-State: AFq9FYKS7KGteTW7Ikff5arMPz13BMSw7be1/MaUqthZ/AJJx+qCNv8W
	QLWqy9FZBtAJE6njNSZuUVkw37MIlcaLoAqUtRUx/jLJVLYk5TLauJTln0b9t29hTw==
X-Gm-Gg: AYBFou3NMpWobGkLxrn7teKoFldKS0gbfeCjw+bXYOLgwMBmwIVLFjc28oE5VswllP6
	vOB5J3rTKEV6yvpPU5g9x1fXDW6S7IS6N4V7Y4g67C9EWC/hw3GW1qgbl0QdUgGPC8ln/T2+HlJ
	79BoHX2U0S+c+4W88zIr9an+Bn1pM6Ix2NTQW+JrocergH2twXozbHC3cT8wWF4MxCWKupPGEC+
	LRaHHW75M+Q891g46InldXK1ONk/guSfUHPlvZO7FFlA3phHz0MI3LcYu9H5RexhBlz0HHyxLUU
	mcOWwlmXZISYUcpYLUpb8L+uBapAF8xS0uOpDmwvS2b4vvvwZxEc84rdUsMR3YqHU4UmytC+Y+y
	/GHN3Mg8Aff9dh/4N9+rwjziFuOt/9s2auMtj1fLAuUS9/yAmOjtE4cdUrBc65lUXlYHxGqs3Vb
	mSmXMJfD3YCEOF0m4hioKw8LngAmj1r0o0QxfFWQtOt77y5O8q6Frq+TDgjOO19E1hsDsw2v4ha
	dg3uWh94ggyl+YizmKOFdQLYYuhJP+VHaM+JkcxbiU6USyNNtr62VccMiY6L8K0yWL39S6GyhtK
	p+MSkWsB/7jTPpqStGBK7rpyyBm1j0Hz7BAI3xOeM+w=
X-Received: by 2002:ad4:5fcf:0:b0:914:5769:dcee with SMTP id 6a1803df08f44-91c3a82d162mr24656846d6.17.1792756773198;
        Fri, 23 Oct 2026 04:59:33 -0700 (PDT)
Received: from mbili.tail33bf8.ts.net ([64.203.83.2])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-91c396af493sm18358246d6.9.2026.10.23.04.59.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 23 Oct 2026 04:59:32 -0700 (PDT)
From: Jamal Hadi Salim <jhs@mojatatu.com>
To: netdev@vger.kernel.org
Cc: Jamal Hadi Salim <jhs@mojatatu.com>,
	Jiri Pirko <jiri@resnulli.us>,
	Victor Nogueira <victor@mojatatu.com>,
	Yotam Gigi <yotam.gi@gmail.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@kernel.org>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	stable@vger.kernel.org
Subject: [PATCH net v2 4/6] net/sched: act_ife: do not consume the inner header on egress
Date: Fri, 23 Oct 2026 07:59:19 -0400
Message-Id: <ACT-N6N4.v2.r0.20261022191829-4@mojatatu.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <ACT-N6N4.v2.r0.20261022191829-3@mojatatu.com>
References: <ACT-N6N4.v2.r0.20261022191829@mojatatu.com> <ACT-N6N4.v2.r0.20261022191829-1@mojatatu.com> <ACT-N6N4.v2.r0.20261022191829-2@mojatatu.com> <ACT-N6N4.v2.r0.20261022191829-3@mojatatu.com>
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
tcf_ife_decode() unconditionally calls eth_type_trans(), which pulls
ETH_HLEN.  On egress this consumes the inner Ethernet header; a following
eth_type_trans() from loopback_xmit() then parses L3 data as Ethernet and
can BUG in __skb_pull() when the remaining linear area is short.

The Fix:
Parse the inner Ethernet header with eth_type_trans() in both directions,
then restore the egress data position and MAC length.  On ingress the
existing behavior is unchanged.  On egress, push the inner Ethernet header
back after parsing so the xmit path sees the original frame and later
actions see a consistent network header.

Decode is a receive-side operation; the egress branch keeps the frame
intact for transmit paths such as loopback.  tcf_ife_is_eth_skb() accepts
Ethernet and loopback devices generally.

Conditions to recreate the bug:
- egress tc filter on lo: action ife decode pipe;
- AF_PACKET SOCK_RAW frame: outer Ethernet with ETH_P_IFE, IFE metadata,
  inner Ethernet and an 8192-byte payload;
- the egress pipe re-enters eth_type_trans() via loopback_xmit() after the
  action consumed the inner header.

Fixes: ef6980b6becb ("introduce IFE action")
Cc: stable@vger.kernel.org
Signed-off-by: Jamal Hadi Salim <jhs@mojatatu.com>
---
 net/sched/act_ife.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/net/sched/act_ife.c b/net/sched/act_ife.c
index 2afd68983ece..3946a9589bb8 100644
--- a/net/sched/act_ife.c
+++ b/net/sched/act_ife.c
@@ -769,6 +769,10 @@ static int tcf_ife_decode(struct sk_buff *skb, const struct tc_action *a,
 
 	skb->protocol = eth_type_trans(skb, skb->dev);
 	skb_reset_network_header(skb);
+	if (!skb_at_tc_ingress(skb)) {
+		skb_push(skb, ETH_HLEN);
+		skb_reset_mac_len(skb);
+	}
 
 	return action;
 }
-- 
2.43.0


