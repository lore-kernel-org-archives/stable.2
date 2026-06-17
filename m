Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E7CDD35DA69;
	Wed, 17 Jun 2026 18:04:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781719455; cv=none; b=KI/H7MziczUWRy4b6sjEBIQIc5dwPrJXREPetwY5sJw5VDDbfeUhjdjsOil2oQZyF0UEKs3ymRfBquv7z1OEjRWJPLs0yiLiOB/6vWKmOH1bh85vsbLTOi8eU5/9hUoKcjYAmpi4R4p8LfzbWVirmD3nqwLdDMlvojyBsbfEtpE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781719455; c=relaxed/simple;
	bh=nvhOenHTV3F9jaHMk4AYIyasVCkfaT8rcJ4NeoBkSPM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=VjljwesQzIBaVCLjs9PtP1ysppqvTqhtY9InEzQk7rRszseMIoqzE/JGy1+x4BkSDXIGG4S0RNvX3J+DQ9eewTJLaCWYnySp5te/LJm7cdM0K8hpNAyoaS5HmZr2c7K/1gpBSAo8YZUDuZaD2IXdlo09EIWjG9sSdTS1hEe0Frk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=RVi/bNfG; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="RVi/bNfG"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 407CC1F000E9;
	Wed, 17 Jun 2026 18:04:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781719453;
	bh=12g9I/uSAv9y5b4YqdhV0CzYTFbkVjSAMucZLEbwMwk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=RVi/bNfGCA/yxsckhVLnAVb5COTH50NfI7rjNLNy/VM4tK8dNS1YNaNHLsKQw3mJ0
	 CDnTp9v1nn/bBFViPMuNfPaK2RUpRSP3Hw+IMNECBlqBv6Iwmqtuh6+cVq8iwYOfpx
	 U2xPqh6XV/eGfeW9S8kCtegbQNL7SUfN0Cq8spKWm2EUsCIGFKZwLJ/y+Fbe18jqEO
	 VRjzzigzmnTadWizPo2zWT6dZnz9/Fap/R3Em0ajpvBvkYCG/Oj9q40XkYDH/zjSC/
	 TpaVcFhji4mnDguHauz/VmSN2W6rW29yBdNXgwKnsa06+ehtXD/PRywzyDRHZVgKZS
	 fRt25vNy1wcKA==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: David Howells <dhowells@redhat.com>,
	Michael Bommarito <michael.bommarito@gmail.com>,
	Marc Dionne <marc.dionne@auristor.com>,
	Jeffrey Altman <jaltman@auristor.com>,
	Eric Dumazet <edumazet@google.com>,
	"David S. Miller" <davem@davemloft.net>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	linux-afs@lists.infradead.org,
	netdev@vger.kernel.org,
	stable@kernel.org,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.6.y] rxrpc: Fix the ACK parser to extract the SACK table for parsing
Date: Wed, 17 Jun 2026 14:04:10 -0400
Message-ID: <20260617180410.271223-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026061543-superior-passerby-d597@gregkh>
References: <2026061543-superior-passerby-d597@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: David Howells <dhowells@redhat.com>

[ Upstream commit 333b6d5bb9f87827ac2639c737bf9613dbae7253 ]

Fix modification of the received skbuff in rxrpc_input_soft_acks() and a
potential incorrect access of the buffer in a fragmented UDP packet (the
packet would probably have to be deliberately pre-generated as fragmented)
when AF_RXRPC tries to extract the contents of the SACK table by copying
out the contents of the SACK table into a buffer before attempting to parse

AF_RXRPC assumes that it can just call skb_condense() and then validly
access the SACK table from skb->data and that it will be a flat buffer -
but skb_condense() can silently fail to do anything under some
circumstances.

Note that whilst rxrpc_input_soft_acks() should be able to parse extended
ACKs, the rest of AF_RXRPC doesn't currently support that.

Further, there's then no need to call skb_condense() in rxrpc_input_ack(),
so don't.

Fixes: d57a3a151660 ("rxrpc: Save last ACK's SACK table rather than marking txbufs")
Reported-by: Michael Bommarito <michael.bommarito@gmail.com>
Link: https://lore.kernel.org/r/20260513180907.2061972-1-michael.bommarito@gmail.com
Signed-off-by: David Howells <dhowells@redhat.com>
cc: Marc Dionne <marc.dionne@auristor.com>
cc: Jeffrey Altman <jaltman@auristor.com>
cc: Eric Dumazet <edumazet@google.com>
cc: "David S. Miller" <davem@davemloft.net>
cc: Jakub Kicinski <kuba@kernel.org>
cc: Paolo Abeni <pabeni@redhat.com>
cc: Simon Horman <horms@kernel.org>
cc: linux-afs@lists.infradead.org
cc: netdev@vger.kernel.org
cc: stable@kernel.org
Link: https://patch.msgid.link/105362.1780573560@warthog.procyon.org.uk
Signed-off-by: Paolo Abeni <pabeni@redhat.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 net/rxrpc/input.c | 13 ++++++++++++-
 1 file changed, 12 insertions(+), 1 deletion(-)

diff --git a/net/rxrpc/input.c b/net/rxrpc/input.c
index 9a162035d4c1d0..1157bf75ef9c8c 100644
--- a/net/rxrpc/input.c
+++ b/net/rxrpc/input.c
@@ -781,7 +781,18 @@ static void rxrpc_input_soft_acks(struct rxrpc_call *call,
 	struct rxrpc_skb_priv *sp = rxrpc_skb(skb);
 	unsigned int i, old_nacks = 0;
 	rxrpc_seq_t lowest_nak = seq + sp->nr_acks;
-	u8 *acks = skb->data + sizeof(struct rxrpc_wire_header) + sizeof(struct rxrpc_ackpacket);
+	u8 sack[256] __aligned(sizeof(unsigned long));
+	u8 *acks = sack;
+
+	/* Extract the SACK table into a flat buffer rather than accessing it
+	 * directly through skb->data, which is not guaranteed to be linear for
+	 * a fragmented packet (skb_condense() can silently fail to linearise
+	 * it).
+	 */
+	if (skb_copy_bits(skb,
+			  sizeof(struct rxrpc_wire_header) + sizeof(struct rxrpc_ackpacket),
+			  sack, umin(sp->nr_acks, sizeof(sack))) < 0)
+		return;
 
 	for (i = 0; i < sp->nr_acks; i++) {
 		if (acks[i] == RXRPC_ACK_TYPE_ACK) {
-- 
2.53.0

