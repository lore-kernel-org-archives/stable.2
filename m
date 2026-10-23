Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.219.53
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792756768;
	b=k+IuIsZcaQkjGfH/N28fU7OuBG/PYes8464d6KB4cKpB3AzAf+ue60usG9gro3QQxfij
	 fEe5NL4puMsrXJSqPua0GBC4/xtIx1aWV53A1//pHp1l8sum1519qGlstaR4YAVE0suMe
	 EjvhlhS323nfjfknEbeqngIg2pevv3MyLNccNuKSYH4NIrE+AqoBS+mvzE93lfNAeSUJy
	 ZZLb70yi4Cj1JWiFeAgQ3mmdJ9gtukoTj40D3uE7PvUmj/D4e4031D+OQ4nzb5AMdvpdz
	 k2hH/ctHNhC7IbWOQNEbgouel3deUY/OXyBTpie80lS/y04W73TAAlkPIdbfysGKVdQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792756768;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-Id:X-Mailer:MIME-Version:
	 Content-Transfer-Encoding;
	bh=tg8frWR4xSaMBN4W5XIQ/DFU/ZoK/yXicRO0bbU7JUQ=;
	b=VHhuUI03CDDKIFU/Uz9N586+wQEGAEhNftSOw5r3ec9HPp3ZbSzsVc1nYzX/+rhLubNe
	 C4JEHU5kwVfTI0rj7Y5eS9X2QAZwgQBP6JMInomW1ec/01APnadNvf23CPYKEmkh/4k04
	 p8+cDmj2XfFgvLmcBCR/GxSVz5k0J3uKOW/47JI7q5CsTkKTO9shVHvxdNjHAoMFOMH0l
	 tZpcps3C9sHA69pQzHO50Z+oQ1ONIwJUPRcV+S9u0CHJkB8wW1N9SnfcsxMpJoNrKj41E
	 UDy+mqfaPAHGcvKLlKwaEJ+XY3K5MhSEYr2GS1kPFOYj4I8VDLFYuMHEqHdF/evqmcA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=mojatatu.com;
	spf=none smtp.mailfrom=mojatatu.com;
	dkim=pass header.d=mojatatu.com header.i=@mojatatu.com header.a=rsa-sha256 header.s=google header.b=y1qVsx6M;
	arc=none smtp.remote-ip=209.85.219.53
Received: from mail-qv1-f53.google.com (mail-qv1-f53.google.com [209.85.219.53])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B9555606A31D
	for <stable@vger.kernel.org>; Fri, 23 Oct 2026 11:59:27 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org B9555606A31D
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mojatatu.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=mojatatu.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=mojatatu.com header.i=@mojatatu.com header.a=rsa-sha256 header.s=google header.b=y1qVsx6M
Received: by mail-qv1-f53.google.com with SMTP id 6a1803df08f44-91c3fd7bbdeso4146276d6.1
        for <stable@vger.kernel.org>; Fri, 23 Oct 2026 04:59:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=mojatatu.com; s=google; t=1792756767; x=1793361567; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=tg8frWR4xSaMBN4W5XIQ/DFU/ZoK/yXicRO0bbU7JUQ=;
        b=y1qVsx6MC2MS5/qXviXo1UIpuMKRvx6euAWQ8YkdoQrtpd5mcFR8X6POj12EZt19y2
         SPUy8aLTvufdmNuuP+v6m9R5xiMPEO4e01OwwXu8wppg1HsttgptUf/OjGndQZ3UcPIT
         9qcoJ7kqspMMemq4KL5bunaE1oBwuZzmchCFA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792756767; x=1793361567;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=tg8frWR4xSaMBN4W5XIQ/DFU/ZoK/yXicRO0bbU7JUQ=;
        b=a/kn8Y+yqT/nmc+idkjBYDgykaUFYLBWEyfj3kZU2YEYQXXWzpoGeiNhrBL062npg8
         lZcVk8MgrpoS7r153pHDrQJbKDQSEtA/gXzSmyJ+s7ZGH1hrsq4gZAXl7KYBv+iKRYJO
         UElte9ZmU2nFiAkeQ5i+vDHc1dvKfP26cLv3lxHdYR3K5W7NM3oVZjDydUR75AdAWRUG
         +sdtFlxpvO/QhCxPAPxyKf79dEgM2GmEhK0jFcXybtNd98CWH+jbXObyyMk4DQXB9n3y
         NcwK9UnRCqHnT14f3syrlMUVPjqSetHRUGTbKBpClxukJrsPa7/YxwhER+6GmNFB2fZH
         UvQQ==
X-Forwarded-Encrypted: i=1; AKwUvBzdXKmqRvlNN/Qi0Fz1z8VV2aCJZsdUSAvpTq3QrXLOgQRh60EYVyDDfyV6OJ4joSrD0iLJI8Q=@vger.kernel.org
X-Gm-Message-State: AFq9FYKepF3+o0KrgF/TG44LmjAbjISdbzZnHSmoa8VbDq3n4Usk9mGI
	AZv8oikPjG7u+y+nV6yc2Dygp3vgjBijnJlLvs4TFpSkvrQBldmbxPGCqw7lcxt48Q==
X-Gm-Gg: AYBFou0NTzfQA9mQ2be/z1SR+F+a/Hu/O2nv19xDrCVGvLsBf2YQHJW0hx9Wiec5pcA
	RkA+pxwEpXFPwVbMoNHBkomPUzRyY8CmDsCnrb9BD8oaxgLL8pvEunzwD/UdHj5wviuF/rch/kD
	uBpQMEaniOHhCmOHUYCw7l4IF0yxWDTwnNuD/QxNlcWxsO5QVOYE4jFICWgUb8sFQ1QOLPwe7KI
	1NVD3vcvB0AuxlZ+APYIc/eizL0zm/xcRZpgtIE3cLLH8DK5tq/nKNC+Vm2dT0ydpfF0VoHcwtZ
	AOZ+qphP6NRssbuCC3KHGP66jQD2Q3FgOVLpNWocRFx67UysTstwG9V1b27n17nbjF5OBLXFCdp
	qHhxRCYBgPY2J49zcVNFxFqIPi/Rq6O6SZRPE831LS1xJtaJJq5N+NauQXlzfAmUD7iYEWt2s9z
	F4uq639j0TV4EVh4dO8FFjU2Zl0d+SW/ychP1EIm3NbahojA64guZqC5c9ZH/Af7V+Rsf9PCqzD
	nANUY8UFO1e3vsZrW/QURldvd3D9xCIUg+VwRbb70sIIySBrgy+JpK5t5HPp+Fiv0tGhtSwuFsR
	uwhUJMO6h2qUL8kAZlnp3DRvtOERiNI8VWOHCLYBKrtAS/GxB8oiBvXyBgp7+rq6
X-Received: by 2002:ad4:5f4a:0:b0:91b:5d3b:4acd with SMTP id 6a1803df08f44-91c3acb8119mr23988026d6.54.1792756766537;
        Fri, 23 Oct 2026 04:59:26 -0700 (PDT)
Received: from mbili.tail33bf8.ts.net ([64.203.83.2])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-91c396af493sm18358246d6.9.2026.10.23.04.59.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 23 Oct 2026 04:59:25 -0700 (PDT)
From: Jamal Hadi Salim <jhs@mojatatu.com>
To: netdev@vger.kernel.org
Cc: Jamal Hadi Salim <jhs@mojatatu.com>,
	Jiri Pirko <jiri@resnulli.us>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@kernel.org>,
	Guillaume Nault <gnault@redhat.com>,
	Simon Horman <horms@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Victor Nogueira <victor@mojatatu.com>,
	Vega <vega@nebusec.ai>,
	Ren Wei <n05ec@lzu.edu.cn>,
	Herbert Xu <herbert@gondor.apana.org.au>,
	Jason Wang <jasowangio@gmail.com>,
	Willem de Bruijn <willemdebruijn.kernel@gmail.com>,
	stable@vger.kernel.org,
	Martin Varghese <martin.varghese@nokia.com>,
	Pravin B Shelar <pshelar@ovn.org>,
	Shmulik Ladkani <sladkani@proofpoint.com>,
	Yotam Gigi <yotam.gi@gmail.com>,
	Aaron Conole <aconole@redhat.com>,
	Eelco Chaudron <echaudro@redhat.com>,
	Ilya Maximets <i.maximets@ovn.org>,
	dev@openvswitch.org,
	Jiri Benc <jbenc@redhat.com>
Subject: [PATCH net v2 0/6] net: pull short linear Ethernet headers before eth_type_trans()
Date: Fri, 23 Oct 2026 07:59:15 -0400
Message-Id: <ACT-N6N4.v2.r0.20261022191829@mojatatu.com>
X-Mailer: git-send-email 2.34.1
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

This series fixes a class of producer/consumer bugs in which an outer
header is popped and the packet is then handed to a consumer with fewer
than ETH_HLEN bytes in the linear area.  eth_type_trans() pulls ETH_HLEN
from that area and can BUG in __skb_pull() when the inner Ethernet header
is not linear.  The affected producers are act_vlan POP_ETH, act_mpls POP,
act_ife egress decode, and the Open vSwitch MPLS/TEB and NSH pops.  A
consumer-side guard in act_mirred rejects redirecting a headerless packet
to a device that expects a link-layer header.

Patch 1 makes act_vlan POP_ETH pull the inner Ethernet header after the
pop and drop only when the packet is genuinely shorter than ETH_HLEN.
Patch 2 does the same for act_mpls, gated on the pre-pop MAC length.
Patch 3 adds the act_mirred guard at the redirect boundary.  Patch 4
keeps act_ife egress decode from consuming the inner Ethernet header and
restores the header metadata.

Patches 5 and 6 establish the same linear-header invariant for the OVS
MPLS/TEB and NSH pops before restoring MAC_PROTO_ETHERNET.

Changes in v2:
  - Pull the inner header with pskb_may_pull(skb, ETH_HLEN) and drop only
    on failure, instead of dropping on the post-pop skb_headlen() check
    which may drop frags (Eric/Willem).
  - act_mpls: gate the pull on the pre-pop mac_len and remove the separate
    was_mpls state.
  - Drop the v1 TUN patch; add the act_mirred consumer-side guard.
  - Add the act_ife egress decode fix; decode is receive-side, and the
    egress path restores the frame for loopback-style transmit paths.
  - Keep the OVS TEB and NSH patches unchanged and restore their v1
    Reviewed-by trailers.
  - Drop two bouncing Cc addresses.

Jamal Hadi Salim (6):
  net/sched: act_vlan: pull the inner Ethernet header after POP_ETH
  net/sched: act_mpls: pull the inner Ethernet header after POP
  net/sched: act_mirred: reject redirects without a link-layer header
  net/sched: act_ife: do not consume the inner header on egress
  net: openvswitch: ensure a linear inner Ethernet header on TEB pop
  net: openvswitch: ensure a linear inner Ethernet header on NSH pop

 net/openvswitch/actions.c | 12 +++++++++---
 net/sched/act_ife.c       |  4 ++++
 net/sched/act_mirred.c    |  7 +++++++
 net/sched/act_mpls.c      |  2 ++
 net/sched/act_vlan.c      |  2 ++
 5 files changed, 24 insertions(+), 3 deletions(-)

-- 
2.43.0

