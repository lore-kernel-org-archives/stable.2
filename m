Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B876D52CCFE
	for <stable@vger.kernel.org>; Tue, 29 Sep 2026 14:12:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790691172; cv=none; b=MPxEsfTiEDIKhTQw7qQwCo9nTRW3VQLlEm7Np3aN6b4eNEgOcXe+rGTo1r0cpmfkC2q82y82qm6Pi/bZ9oOseDGfHlcvqJDb7l3gAmH7m0vWmsi7wMkXSBdiowo2jAEwMI4YVpA6CtqZUXKyXaFvuQK94Xg1NASOXHc4scJBDAk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790691172; c=relaxed/simple;
	bh=j+5axpmlHdgQI2vzIRa3yZ+S/YlYGImENpKk0sYmr2Q=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=eoekjI5xCtbps7/JE+vEc48whmEUBsyItqmVZCGSV6368sPucEN7Ea+bpTmufo0BAeIKBymoYNqqVahErqduwL6npzinH7h9kkXMAQz1xWLsA0hUvKEEF5CBGwMch6b+6uV+e7nGYVVKjAG/Y8qbf3Bj7y/MbkyvyBuUuIHL9pw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=dYadUUqF; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="dYadUUqF"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2D2A11F0089A;
	Tue, 29 Sep 2026 14:12:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790691170;
	bh=LwuJgvx6shmgCkPv56xx7JzbTbxivv3SmN5O++teg8Q=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=dYadUUqFonuNzr64OQ/xaaW8ta1QSA0Hfv0aZ3IPVt7kMN6ciSwHFIQBACP5iawVu
	 b6JlETnGF7baEvbxMg/eBeOlUU/Fv1J/yCrEDKSbf9tRK+rEn/h7UgNYWgCtbHjtfu
	 HY98GE19Sfm6cCXwih1aWhe5IC3ZuIAJRVP+MzV1hJ7Hhc/bmeSI4GxUIkeciSWE8H
	 zhf6m1qFZ/OmXQhotvD7ercBkLnafu5PyjsLyvdPbH3X6CaTwjQcEhOzZXm8b/UH1H
	 MLzzyY4YnaO/v5N4MmNJzdNZZ1ZrdVDFwT+7PwOyBGsu5bjiN5z96N2iURskFdif8G
	 pxUaED8Is1Czw==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Jeremy Kerr <jk@codeconstruct.com.au>,
	Paolo Abeni <pabeni@redhat.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.1.y 2/4] net: mctp: Add some detail on the key allocation implementation
Date: Tue, 29 Sep 2026 10:12:46 -0400
Message-ID: <20260929141248.3537868-2-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260929141248.3537868-1-sashal@kernel.org>
References: <2026092919-helpful-hydrogen-8802@gregkh>
 <20260929141248.3537868-1-sashal@kernel.org>
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
index e3c69a1a8761a..f633745827ff3 100644
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

