Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793089605;
	b=dmAAZpn/5bnQH1beoMtQHj3RCelegt9kUEqvLVWWzt3YT3TR2ftA+tH0gaNST0hZMuau
	 fWOidJ7AsdbngCIrrgzFmpdpiS3j2B3744rq6diA0JayHFgwNfKlE0Bludzm3p01Y5Y5X
	 7DUMwW5/LM67rIbiUWCpAISpZALEvvkWqrIhGG8bmwAtAztrtd6rXrfxni4upWJDzb+Go
	 1kCK9Fw7ingFs74sOSD3fGzdB1KHf40MZr8o+MC/a+M2Zm15ukc6n+Ic+2+sI2wDQzfL0
	 yN/ZCTV2MLmsyf7DSCMu0SlkPWvlQjFed8w5dwFPLW3cQcPpsnmisLFsTRMktnx8Lqg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793089605;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=2mAQAxNJCmgorWtFYC1x4ukB0tp8HVcxnxU1mYBs9GQ=;
	b=iQexALRKkTjgcwH2oVLaVW9m+WkCHNY8PBWjMVbcP5Owex8Eac9MQht6ENouMAXAhZ2n
	 dnHf8XZgtNi5id00HSw83jKiQaCddSjMpy/q5uIeh69VDMqNzV4mwswdYLYuRIV8xf1mn
	 mNJ2iZLnLKmS8IXubAf49rUcROqi/S9VVKYqQMa086bRiB/EhvIsI4r3QRwyDQtX2qPJ5
	 gGFzrhP4a3RSaHbXn9o4oVmBpkqEFB5bSzq6ZGdC623LxnJLNZ7Fny06fAHvvzbgfZTAw
	 nDwv/HZ8tgAOcYWv7OUPAqkk54KWsq3uTBTptP1DbYF4FL4d9BMQu39y22UBFFysKvw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=O2aiKLSh;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 54E09606A31B;
	Tue, 27 Oct 2026 08:26:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=O2aiKLSh
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 069071F01825;
	Tue, 27 Oct 2026 08:26:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793089604;
	bh=2mAQAxNJCmgorWtFYC1x4ukB0tp8HVcxnxU1mYBs9GQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=O2aiKLShXReTJCgUIhmKSGZFMBb1Okr2Lt3LXRJAKrbuQTwrd5O8bkiaog1wmxOxy
	 eu2iL4be2Fqp8EsiSnaeMGFrIKgin4x/wW4HpPQAIOkakuVZJG8nFVlHNOkg2jbbww
	 Psi/gcfqt+eD9uzmQ4Jw/Y40Jtq5AWSBzu2BtANE2LlUthfLlNDeqXUuHcUUmLoy4Y
	 oaoAwBIMcdeudiZM/tvXWDrGmUT01qpfWydgqNAFgQfxh3G8BIVTGuZI2nFekz2d+C
	 1+goT8Z07/IP1ZCwGrIoZeodfugM9olCnZC92yDVLoA0afEmroe1z7ltiVacYmPM7C
	 H91hZm19eJj8A==
From: Eric Dumazet <edumazet@kernel.org>
To: "David S . Miller" <davem@davemloft.net>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>
Cc: Willem de Bruijn <willemb@google.com>,
	Simon Horman <horms@kernel.org>,
	netdev@vger.kernel.org,
	Jamal Hadi Salim <jhs@mojatatu.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	Aaron Conole <aconole@redhat.com>,
	Eelco Chaudron <echaudro@redhat.com>,
	Ilya Maximets <i.maximets@ovn.org>,
	Jiri Pirko <jiri@resnulli.us>,
	dev@openvswitch.org,
	Willem de Bruijn <willemdebruijn.kernel@gmail.com>,
	Ren Wei <weir@nebusec.ai>,
	stable@vger.kernel.org,
	Eric Dumazet <edumazet@kernel.org>
Subject: [PATCH net 5/5] net/sched: act_ife: do not consume the inner header on egress
Date: Tue, 27 Oct 2026 09:26:04 +0100
Message-ID: <20261027082604.1485903-6-edumazet@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261027082604.1485903-1-edumazet@kernel.org>
References: <20261027082604.1485903-1-edumazet@kernel.org>
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

From: Jamal Hadi Salim <jhs@mojatatu.com>

The issue:
tcf_ife_decode() unconditionally calls eth_type_trans(), which pulls
ETH_HLEN.  On egress this consumes the inner Ethernet header, and the
device receives an skb whose data points to the L3 header:

- loopback_xmit() parses L3 data as Ethernet: the "ethertype" comes
  from the inner IPv4 source address, and the decapsulated packet is
  dropped or misparsed.
- a real NIC transmits the frame without its Ethernet header.

(The __skb_pull() BUG this used to trigger in loopback_xmit() when the
remaining linear area was short is handled by "loopback: use
eth_type_trans_careful()".)

The Fix:
Parse the inner Ethernet header with eth_type_trans() in both directions,
then restore the egress data position and MAC length.  On ingress the
existing behavior is unchanged.  On egress, push the inner Ethernet header
back after parsing so the xmit path sees the original frame and later
actions see a consistent network header.

Conditions to recreate the bug:
- egress tc filter on lo: action ife decode pipe;
- AF_PACKET SOCK_RAW frame: outer Ethernet with ETH_P_IFE, IFE metadata,
  inner Ethernet + a valid IPv4 ICMP echo request to a local address;
- before this patch, no echo is received; after it, the echo is
  delivered and answered.

Fixes: ef6980b6becb ("introduce IFE action")
Cc: stable@vger.kernel.org
Signed-off-by: Jamal Hadi Salim <jhs@mojatatu.com>
[edumazet: reworded changelog, the crash is now handled in loopback]
Signed-off-by: Eric Dumazet <edumazet@kernel.org>
---
 net/sched/act_ife.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/net/sched/act_ife.c b/net/sched/act_ife.c
index 2afd68983ece40d8cae6c96af86e2ea65be476bc..3946a9589bb8fcd296e6f1f9234c00238df4d954 100644
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
2.53.0

