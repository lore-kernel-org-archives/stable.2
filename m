Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ABEBB2D2488;
	Tue,  8 Sep 2026 14:14:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788876881; cv=none; b=CqQNzpfZrulEoDXemx8tS2VIgRLmr96He0X7iMr3YLKDUjiETVLzYMLp44jz89Q4x3HMlNdHSuLVnWmKXu9MsEb6p0U2baSZJ6feSQowJ/29a8jvWfNONr3S7b38VQafogp/ju/xP0sqnYdpvIvhI1GTZWJGmGmxmWXR/sf/bo0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788876881; c=relaxed/simple;
	bh=eCDaC8JU1hiplahjCkqNi+vidf1Fmw1XOI7fKun8pfo=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=Ef9kINlE9DR7v2KYy989VTj7F/by1A8ZoU/sILRe2jmRmna4sKSVPPIe5wBP25GxWQKgl8jkfnAbOzDqjR34p48lUrsqfAv2uc8Exn73aba2ALIr/2auN5kyPmQd/+1oXqPu7fTcPQJg2to03yN9Z1t2GNLkkYnc/SX4Z2R/nNw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ZUmTumhb; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZUmTumhb"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5E8381F00ACA;
	Tue,  8 Sep 2026 14:14:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788876867;
	bh=sb+mmGXsUplGkfw4gNxTxpAxsM0oDflslbitEXnYeqw=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc;
	b=ZUmTumhbZtrJ+FlmeTIjijLFj9LJF1V+LYL0MqTzmSfgOLoMrBjFDxOlppeHcC1U8
	 HfXywVw/9d/RgoAct6yXlHa7rvN0iUFx3ceZ7Cd27GrXuowjOEmbNk8fvzPP2cT3Je
	 IH/abw45B87JcAPgnwqp1uSRGvmz8X6c8pkH6r4bwBplz9yfGmOyNHru8p7b9ctEGB
	 mIVvgJKdWO/nBz0zsJpfzz3FL1+1dP3E6gbZznIVoxn2g4vX8VIPRRMisAXbAP+j54
	 2yjWkk4ukTq9rkecIxOagx6eqEGW7stmbht/JLuhKmZ+piqUsnhkiNIqNiQEIHjoBQ
	 9XnVZr/1dsTQg==
From: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
Date: Tue, 08 Sep 2026 16:07:10 +0200
Subject: [PATCH net v2 05/15] mptcp: options: handle MPC data + csum reqd +
 no csum
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260908-net-mptcp-misc-fixes-7-3-rc1-v2-5-df1de70348b6@kernel.org>
References: <20260908-net-mptcp-misc-fixes-7-3-rc1-v2-0-df1de70348b6@kernel.org>
In-Reply-To: <20260908-net-mptcp-misc-fixes-7-3-rc1-v2-0-df1de70348b6@kernel.org>
To: Mat Martineau <martineau@kernel.org>, Geliang Tang <geliang@kernel.org>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 Simon Horman <horms@kernel.org>
Cc: netdev@vger.kernel.org, mptcp@lists.linux.dev, 
 linux-kernel@vger.kernel.org, "Matthieu Baerts (NGI0)" <matttbe@kernel.org>, 
 stable@vger.kernel.org
X-Mailer: b4 0.16.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=2883; i=matttbe@kernel.org;
 h=from:subject:message-id; bh=eCDaC8JU1hiplahjCkqNi+vidf1Fmw1XOI7fKun8pfo=;
 b=owGbwMvMwCVWo/Th0Gd3rumMp9WSGLIWSGjtPLW1RGdK/M3F0jduTDONZbxffvJo4IZ3O2dfv
 nI8ZlVMa0cpC4MYF4OsmCKLdFtk/sznVbwlXn4WMHNYmUCGMHBxCsBEltgw/OF6Znq7ufZu5CqT
 ZxMuFc3N8dNb/XfqAQ3Ns7XvZ88KWP2MkWHn9utH7h/6sXJBwp09Et+mLOzdL7H8x9r8+8Ga99x
 z3TW4AQ==
X-Developer-Key: i=matttbe@kernel.org; a=openpgp;
 fpr=E8CB85F76877057A6E27F77AF6B7824F4269A073

Before this modification, a remote peer could send an MP_CAPABLE with
data, with the checksum flag set, but without adding the actual 2 bytes
of checksum. As a result, uninitialised bytes could be used for the
'csum' field.

That was not a critical issue, because this 'csum' field is only used to
compare with the expected one, if previously negotiated in the 3WHS.
Worst case, the checksum is likely wrong, a fallback is done without a
reject if the negotiation was done earlier. That's OK.

Yet, better to take the expected path with this case: only look at the
checksum flag for MP_CAPABLEs not carrying a data-len.

Such packet can be seen as a 3rd or 4th ACK. The RFC8684 mentions [1]
that the 3rd packet should have the checksum flag set. When an MPC + ACK
contains data, the checksum flag is redundant with the checksum field.
It is not clear what should be done for the 4th ACK, nor if the flag has
to be set if the checksum field is set.

Therefore, it seems fine to only look at the presence of the checksum
field, not to break the interaction with stacks that were not setting
both.

Note that linked to this checksum flag on the 3rd ACK, with the current
implementation, we can have a situation where the SYN packets have no
checksum flag, but the 3rd ACK has one, and this is the one that will be
taken into account. First, that's clearly not directly linked to this
patch, but Clashiko forced us to look at that. At the end, that seems
fine to act like that: yes that's not how the negotiation should work,
but being flexible without introducing side effects is also fine: fixing
this would mean increasing the complexity, and that's not worth it.

Fixes: 208e8f66926c ("mptcp: receive checksum for MP_CAPABLE with data")
Cc: stable@vger.kernel.org
Link: https://datatracker.ietf.org/doc/html/rfc8684#section-3.1-23 [1]
Closes: https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20260803-net-mptcp-misc-fixes-7-2-rc6-v2-0-b8f496d71664%40kernel.org?part=1
Reviewed-by: Mat Martineau <martineau@kernel.org>
Signed-off-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
---
Note about a non directly related case spotted by Clashiko.
---
 net/mptcp/options.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/net/mptcp/options.c b/net/mptcp/options.c
index b8318e030138..92f27b9e087a 100644
--- a/net/mptcp/options.c
+++ b/net/mptcp/options.c
@@ -93,7 +93,8 @@ static void mptcp_parse_option(const struct sk_buff *skb,
 		 * In other words, the only way for checksums not to be used
 		 * is if both hosts in their SYNs set A=0."
 		 */
-		if (flags & MPTCP_CAP_CHECKSUM_REQD)
+		if ((flags & MPTCP_CAP_CHECKSUM_REQD) &&
+		    opsize < TCPOLEN_MPTCP_MPC_ACK_DATA)
 			mp_opt->suboptions |= OPTION_MPTCP_CSUMREQD;
 
 		mp_opt->deny_join_id0 = !!(flags & MPTCP_CAP_DENY_JOIN_ID0);

-- 
2.55.0

