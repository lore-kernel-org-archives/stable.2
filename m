Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 612713644C5
	for <stable@vger.kernel.org>; Tue, 29 Sep 2026 14:03:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790690588; cv=none; b=LnJjygU4akn8zCA3mRl7gENfFcALhwS1gat/KR/+7RgRi2cyeHlnCkK4I2eIWsxRLYTogv3kguj5XwKu0WinclHX30HSxVE22AXjFu0E+z7WnIscKrjci8zILpM08/OVCc/1qD0CLoMMvx3411NWWO3ABBaE4ocTE9gw7JLR/S0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790690588; c=relaxed/simple;
	bh=k/BOXgmVr6hiCQzSfKZJuirad6/qGNSkrWO3Xl8QDAA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=YmyO9re4yCPixgRGL5DUQjJytSZvw3ACE8o5fCX4/NW3TWKwtUbadJtb7pyJL+36/P21IGR1hT+DF+D/tckluak6Frj9WUwIDR51q2evOthE7cnJz1h7BW4D6X49WsnzIEYVz3ziETGXcB0x3GfqdSc8jPIGu3v+Oy9UV7DP2t4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=MUHuQt8u; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="MUHuQt8u"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 898011F00893;
	Tue, 29 Sep 2026 14:03:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790690587;
	bh=GIy8FD4SstBtozAl70q5FynflrLf2+mSHpTKBVBvDN8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=MUHuQt8uogohzWQ2ch4EjOwBl+IN695O7dorlq3NCI74H40fLb0mM0A5kJ/5YQRc6
	 07slOSvEwNwGtqgH9C5YrnbnEF3eomeW7Q4BRlb8aMtTYmKU1AIdaws18o8H/bSUVR
	 xVk85kIQohu7BbqKE6T03oF7e9VQKrkHn7W4msahLVuzSwKapVJyzXh1KleCq/cl6v
	 KorRaCaD8BUcycS6ysQrVdfj5a2pKPkyqxaSzdU2QTVpT2XbMUy38wzQT+zP/gumAP
	 +QFWXV/ngQf2rzlP5rFTEVa780oC2o5RSeKNWG9qDKmIUEbOI4ZQ8sbAKp7KevR5qp
	 2XjLdskqhPusg==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Jeremy Kerr <jk@codeconstruct.com.au>,
	Paolo Abeni <pabeni@redhat.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.6.y 2/4] net: mctp: Add some detail on the key allocation implementation
Date: Tue, 29 Sep 2026 10:03:02 -0400
Message-ID: <20260929140304.3526894-2-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260929140304.3526894-1-sashal@kernel.org>
References: <2026092919-dawdler-dodge-debe@gregkh>
 <20260929140304.3526894-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Jeremy Kerr <jk@codeconstruct.com.au>

[ Upstream commit aee6479a458e2c5027e558cfe26c60c37f8efc80 ]

We could do with a little more comment on where MCTP_ADDR_ANY will match
in the key allocations.

Signed-off-by: Jeremy Kerr <jk@codeconstruct.com.au>
Signed-off-by: Paolo Abeni <pabeni@redhat.com>
Stable-dep-of: 26cc0e69cce0 ("mctp: route: iterate socket tag list in mctp_lookup_prealloc_tag()")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 net/mctp/route.c | 37 +++++++++++++++++++++++++++++++++++++
 1 file changed, 37 insertions(+)

diff --git a/net/mctp/route.c b/net/mctp/route.c
index 3e21bc0a88688..fa08e3c098eee 100644
--- a/net/mctp/route.c
+++ b/net/mctp/route.c
@@ -73,6 +73,40 @@ static struct mctp_sock *mctp_lookup_bind(struct net *net, struct sk_buff *skb)
 	return NULL;
 }
 
+/* A note on the key allocations.
+ *
+ * struct net->mctp.keys contains our set of currently-allocated keys for
+ * MCTP tag management. The lookup tuple for these is the peer EID,
+ * local EID and MCTP tag.
+ *
+ * In some cases, the peer EID may be MCTP_EID_ANY: for example, when a
+ * broadcast message is sent, we may receive responses from any peer EID.
+ * Because the broadcast dest address is equivalent to ANY, we create
+ * a key with (local = local-eid, peer = ANY). This allows a match on the
+ * incoming broadcast responses from any peer.
+ *
+ * We perform lookups when packets are received, and when tags are allocated
+ * in two scenarios:
+ *
+ *  - when a packet is sent, with a locally-owned tag: we need to find an
+ *    unused tag value for the (local, peer) EID pair.
+ *
+ *  - when a tag is manually allocated: we need to find an unused tag value
+ *    for the peer EID, but don't have a specific local EID at that stage.
+ *
+ * in the latter case, on successful allocation, we end up with a tag with
+ * (local = ANY, peer = peer-eid).
+ *
+ * So, the key set allows both a local EID of ANY, as well as a peer EID of
+ * ANY in the lookup tuple. Both may be ANY if we prealloc for a broadcast.
+ * The matching (in mctp_key_match()) during lookup allows the match value to
+ * be ANY in either the dest or source addresses.
+ *
+ * When allocating (+ inserting) a tag, we need to check for conflicts amongst
+ * the existing tag set. This requires macthing either exactly on the local
+ * and peer addresses, or either being ANY.
+ */
+
 static bool mctp_key_match(struct mctp_sk_key *key, mctp_eid_t local,
 			   mctp_eid_t peer, u8 tag)
 {
@@ -380,6 +414,9 @@ static int mctp_route_input(struct mctp_route *route, struct sk_buff *skb)
 			 * key lookup to find the socket, but don't use this
 			 * key for reassembly - we'll create a more specific
 			 * one for future packets if required (ie, !EOM).
+			 *
+			 * this lookup requires key->peer to be MCTP_ADDR_ANY,
+			 * it doesn't match just any key->peer.
 			 */
 			any_key = mctp_lookup_key(net, skb, MCTP_ADDR_ANY, &f);
 			if (any_key) {
-- 
2.53.0

