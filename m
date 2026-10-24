Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.160.176
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792852129;
	b=STIRITzJ0ohwNQ7YqGVPH0wEciEl3kKbMBKru0ZE/GdjI61G2uXgDYvmOfAJLGU9eFAi
	 JZLhWkEv7TbsySaass/7NszsKbkxGXAGptgHtQle4aKIwHQadbnVpRSFTh1ne0Pix7GBl
	 y1SpQRckBaHKT5bOyLJNBMz/uv60S0vApaQhT0dCbQAVADd91ygywHUv4BWldQg7xGZx5
	 7bMggagjYAkwR17gcfgtn8rqHFzOmlUfJ38wQFUBip/xGKQ9YP4FxIwLorRpmnWmtkjZZ
	 cC6z/jc4O5/sYMeRy9AB1z2dQuTyPYNmqZnt+qKXzlQo0wY56f6dMIhx8bTA4rgAoMw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792852129;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-Id:X-Mailer:MIME-Version:
	 Content-Transfer-Encoding;
	bh=T1aUxwSt8x529kwJJ1c+bF4HCux/lGTMN5DP5a7x++k=;
	b=sV5JFldAG5559ZMl4fohZsRyquXTaMN4IJWeMp5Pq1Io9VWwjytdCk48YfKQKES9cL78
	 65vAfYX81V2eZhM4snFfztpDkoZxsYPK+FBjcH7IO/Kav7fhnIlNrKjAW3evXdzklXFqc
	 9GXQFIZnSCIG3i+0qWasJOoCzThorLE/aRhM/O1kzVIuwfbZNUCKN5TDRSUl4HXCbFZLW
	 XKa69X+kYddS8P4keesPa3ty8mlFmood3phGdNXNkfNcwKmvlBxps/l3fuMyRNg4ttNmc
	 Ldw9V4aGWkKE49IjSD2GWp5CT7lRk2sQAM/6WFGpoe4LQcsnyZ6DwWIwcqa3bqLLtxA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=mojatatu.com;
	spf=none smtp.mailfrom=mojatatu.com;
	dkim=pass header.d=mojatatu.com header.i=@mojatatu.com header.a=rsa-sha256 header.s=google header.b=C0923mnC;
	arc=none smtp.remote-ip=209.85.160.176
Received: from mail-qt1-f176.google.com (mail-qt1-f176.google.com [209.85.160.176])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 472EB606A326
	for <stable@vger.kernel.org>; Sat, 24 Oct 2026 14:28:48 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 472EB606A326
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mojatatu.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=mojatatu.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=mojatatu.com header.i=@mojatatu.com header.a=rsa-sha256 header.s=google header.b=C0923mnC
Received: by mail-qt1-f176.google.com with SMTP id d75a77b69052e-53653e30353so6241361cf.2
        for <stable@vger.kernel.org>; Sat, 24 Oct 2026 07:28:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=mojatatu.com; s=google; t=1792852127; x=1793456927; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=T1aUxwSt8x529kwJJ1c+bF4HCux/lGTMN5DP5a7x++k=;
        b=C0923mnCILsVt8ISFT36TIipS1rOY2HeBEwluDKOvujlLf/JqqFl0pk957bgqshcuq
         UbMs0EAzTNlEBX3+pfAi7UoDEamHhJKkIHW30KpE8THBlj75FJQyDgonHfBl1Rb29Jad
         P6zDFehzf4/Pyn53F8B/AbGwlTjEVqlmwKKds=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792852127; x=1793456927;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=T1aUxwSt8x529kwJJ1c+bF4HCux/lGTMN5DP5a7x++k=;
        b=m3vdEhf47zZ+x37ahUEbfJYkbVGUJiel+HgKDXrh6Gd+zx070CBK12tx2A5FbkS7+k
         xnw4EPW05RktvkfzV5BMcaIVhARPHNh021Y4Kktou/N1TbncYVS8XOJ2B8v+iiS/6GPe
         4qDK2Ye8QT7trRGpjfuHbTLAxTdPynS1UtXzZExp2V2wGNF901ZsZgvduKjPidVrE1cK
         LHaHpaDn3Z7UUFeyocJEjUWsVFDBTBRB3vfSJz8haF+ZAhG8D5f9XF300PPtkp7onlDK
         8Om5b02pSZx9wvn1V4TXK1BIx/TkfiMDz8gccfq3oCfbaOivkB4Gh/zcHlg2dwpCx2Hg
         Eqog==
X-Forwarded-Encrypted: i=1; AKwUvBxYhVTCsDqmnb53wKFXUlYB72GXHfqCnLvSz2pofdrmG1HyCcWezO+5nUEdA19IGFZQKlnFTrk=@vger.kernel.org
X-Gm-Message-State: AFq9FYLhdB2sAiRbGQWYU2/0+bM011i8jbtCUzzNWG2rJZXoUiOQtpsy
	SMNw86bZE/HhVcbxdml/pcoBBbuytYesNWnDuDiY/oIvTxTxQcDgpuw7WV/LinB6OQ==
X-Gm-Gg: AYBFou2hmQF/sj9eUvBe5ugJyXw/maqpOokVqUbUmrx9TjPppQuC+6+LMJSr8zUTYC0
	DyzpWM3fF/tyUgZ+i/w6emYvQbx6Q1Rw4JkgJCeoC/bkL86q9BnxfapXVEE7A3QWsgj6SOr94Zi
	atxzLUKV4byB/eqzayVQq6uuow0BqmF71EKXsIGoMcbJ01O1gVQ2ff9IBuEvpszBfA/R18a2Ff4
	zntIY+rMupydp27Mq1Y3O3DX4QiMTB9c11wMKAe6xjNKXRIkY+QfKcJkOzYVPT8j+FWPOxtdUlc
	KK7tl0hJbGT9cFt3f2xsazMMvFk3ntjiDEyICqmIDdC9s+tMPDgYXtKvWJCG5nI8ikqTRNbwZTI
	FUEe8bmT0YxuGxXu/vmJ1uYH3ZrCsIz/seBI0RprFRTMXrT0g8G+2njHCj06Zv07HQqBeqcwLsd
	VjKPPbKBhqQhmxPtJA3ck/A1U6Jkkz5Y4rzbkeBtbk/LXe8iaXOjU2YnG0Im4Msvd1WxSGL4QHC
	/xoSyX+yYVPyKRtTDMlO3l/D7S0P145yH4D3MsSHj+8NwZNHCvJrskIktPsXGy0Ee0vIOwraDB2
	hRmMWCgEiukhfy6AmsB2EJS8vkeeHYoFUi2LjyQ7bg==
X-Received: by 2002:a05:622a:387:b0:535:f9dd:cb9b with SMTP id d75a77b69052e-5383b4cc284mr29729391cf.26.1792852127084;
        Sat, 24 Oct 2026 07:28:47 -0700 (PDT)
Received: from mbili.tail33bf8.ts.net ([64.203.83.2])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-91c47a7cd7esm22349976d6.2.2026.10.24.07.28.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 24 Oct 2026 07:28:45 -0700 (PDT)
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
Subject: [PATCH net v3 0/6] net: pull short linear Ethernet headers before eth_type_trans()
Date: Sat, 24 Oct 2026 10:28:35 -0400
Message-Id: <ACT-N6N4.v3.r0.20261023200137@mojatatu.com>
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
consumer-side guard in act_mirred ensures a pullable link-layer header at
the redirect boundary.

Patch 1 makes act_vlan POP_ETH pull the inner Ethernet header after the
pop and drop only when the packet is genuinely shorter than ETH_HLEN.
Patch 2 does the same for act_mpls when the configured inner protocol is
ETH_P_TEB.  Other inner protocols are not required to carry an Ethernet
header.  Patch 3 ensures a pullable link-layer header at the redirect
boundary.  Patch 4 keeps act_ife egress
decode from consuming the inner Ethernet header and restores the header
metadata.

Patches 5 and 6 establish the same linear-header invariant for the OVS
MPLS/TEB and NSH pops before restoring MAC_PROTO_ETHERNET.

Changes in v3:
  - act_vlan: keep the unconditional post-pop pskb_may_pull(ETH_HLEN).
    After discussion with Willem I considered vetting it on ETH_P_TEB,
    but was hesitant because i felt checking TEB in act_vlan was
    in bad taste: POP_ETH has no inner-protocol parameter. Eyeballing
    also showed the TEB test is not needed for the eth_type_trans()
    failure this series fixes (of course sashikos will have something
    to say;->).
  - act_mpls: drop the pre-pop mac_len gate and pull ETH_HLEN only for
    ETH_P_TEB.  Other act_mpls inner protocols are not required to carry
    an Ethernet header (Willem de Bruijn).
  - act_mirred: drop the skb_network_offset() condition and keep only
    pskb_may_pull(dev->min_header_len).  The offset check rejected valid
    MPLS L2VPN redirects (Eric Dumazet; tc_mpls_l2vpn.sh).
  - act_vlan and act_ife: no code change; add Eric Dumazet's Reviewed-by.
  - OVS TEB and NSH: no code change; add Aaron Conole's Reviewed-by.

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
  net/sched: act_mirred: ensure a pullable link-layer header before redirect
  net/sched: act_ife: do not consume the inner header on egress
  net: openvswitch: ensure a linear inner Ethernet header on TEB pop
  net: openvswitch: ensure a linear inner Ethernet header on NSH pop

 net/openvswitch/actions.c | 12 +++++++++---
 net/sched/act_ife.c       |  4 ++++
 net/sched/act_mirred.c    |  6 ++++++
 net/sched/act_mpls.c      |  3 +++
 net/sched/act_vlan.c      |  2 ++
 5 files changed, 24 insertions(+), 3 deletions(-)

-- 
2.43.0

