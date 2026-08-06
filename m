Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DB8B037E5F2
	for <stable@vger.kernel.org>; Thu,  6 Aug 2026 18:59:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786042798; cv=none; b=VlXWcWzwumDRo7O5NpAZpPFhjypxu5588yFvQcR1HEW3HSDp6mNRjOkvd3HBTd2x42Twk0a+qTjwNkMqTdliZje+vPtVEjRPh4IEGZhoD5iJV+DFlmPGao/F79jDXcHMa660zcWKZHSN04geWtjNYSqQ/Tqcbx0Z2MJizs8wvnY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786042798; c=relaxed/simple;
	bh=QpF8CwHkakTJpMGZDF1zfoieP2JwtcWSXlV6MV9UP88=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=uFvlAc1CL4WKUeoNAerU9aF657YwHfj2s6Zcs1yi5KjM++t2WO/LEy1wsoaywsBpcrPgHwWDUcnyYXftHfHnpPAPbMXMJHjCYRbSH/yc5hLnlrRahdRV6yXe3SlFQZGPrMG0Yfpnknbiich/aTGfaRxq1zccMydac55l1HsH3BM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=SkzPWXqh; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="SkzPWXqh"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 61E251F000E9;
	Thu,  6 Aug 2026 18:59:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786042795;
	bh=TxBUBPsQhx4yNwIyTVo2oofwDjGgtOt1HRGCdqeyJ8U=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=SkzPWXqhHmv1fHfwr6I3ZFdPrX4YUqJNEblT1pca9zG8esZV5SnBU+JYEBcp2XAcB
	 vZdXfVElEP7fPj6NIDDj1Rr5MN1OuYqaLPFWgV30AKhvz2aJCbvS3sYTwuw9JpZ8PF
	 7WGkiBtPS7LzE328MYnEVLKpXy0inBzlVlNVgVtjKHkJYywL9YN3UkU8I1LYUewvb4
	 zdZm1G13Rd9kY3y5/Ohzjsk1IDP8gxFN/1tr2NEVRDHKCeGqJxVfjS8ClnBP3tozKL
	 lmFhAG9pipHpQrsHeP5ol5DPEwx1hcEYW4Mdm6KYQYz4rqOME9mORAguUsgCZiDFYS
	 k1MXU1y1418QQ==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Michael Bommarito <michael.bommarito@gmail.com>,
	Paolo Abeni <pabeni@redhat.com>,
	"Matthieu Baerts (NGI0)" <matttbe@kernel.org>,
	Jakub Kicinski <kuba@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.10.y] mptcp: only set DATA_FIN when a mapping is present
Date: Thu,  6 Aug 2026 14:59:52 -0400
Message-ID: <20260806185952.1529887-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026072905-municipal-wasp-9221@gregkh>
References: <2026072905-municipal-wasp-9221@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Michael Bommarito <michael.bommarito@gmail.com>

[ Upstream commit b2ff91b752b0d85e8815e7f44fd85205c4268094 ]

mptcp_get_options() clears only the status group of struct
mptcp_options_received; data_seq, subflow_seq and data_len are filled in
by mptcp_parse_option() exclusively inside the DSS mapping block, which
runs only when the DSS M (mapping present) bit is set.

A peer can send a DSS option with the DATA_FIN flag set but the mapping
bit clear. The parser then records mp_opt->data_fin while leaving
data_len and data_seq uninitialized. For a zero-length segment
mptcp_incoming_options() evaluates

	if (mp_opt.data_fin && mp_opt.data_len == 1 &&
	    mptcp_update_rcv_data_fin(msk, mp_opt.data_seq, mp_opt.dsn64))

which reads the uninitialized data_len and data_seq; KMSAN reports an
uninit-value in mptcp_incoming_options(). The stale data_seq can also be
fed into the receive-side DATA_FIN sequence tracking.

Record the DATA_FIN flag only when the DSS option carries a mapping, so
data_fin is never set without data_seq and data_len also being present.
data_fin is part of the status group that mptcp_get_options() clears up
front, so on the no-map path it stays zero and the zero-length DATA_FIN
branch is simply skipped. A DATA_FIN is always transmitted together with
a mapping (mptcp_write_data_fin() sets use_map along with data_seq and
data_len), so legitimate DATA_FIN handling is unaffected.

Move the pr_debug() that logs the parsed DSS flags below the mapping
block, so it reports the final data_fin value instead of the stale one
it would otherwise print before the assignment.

Fixes: 43b54c6ee382 ("mptcp: Use full MPTCP-level disconnect state machine")
Suggested-by: Paolo Abeni <pabeni@redhat.com>
Cc: stable@vger.kernel.org
Signed-off-by: Michael Bommarito <michael.bommarito@gmail.com>
Reviewed-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
Link: https://patch.msgid.link/20260709191925.2811195-1-michael.bommarito@gmail.com
Signed-off-by: Jakub Kicinski <kuba@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 net/mptcp/options.c | 13 +++++++------
 1 file changed, 7 insertions(+), 6 deletions(-)

diff --git a/net/mptcp/options.c b/net/mptcp/options.c
index 8bc8812f75266..a63288ec5af6a 100644
--- a/net/mptcp/options.c
+++ b/net/mptcp/options.c
@@ -142,17 +142,11 @@ static void mptcp_parse_option(const struct sk_buff *skb,
 		 */
 		mp_opt->mpc_map = 0;
 		flags = (*ptr++) & MPTCP_DSS_FLAG_MASK;
-		mp_opt->data_fin = (flags & MPTCP_DSS_DATA_FIN) != 0;
 		mp_opt->dsn64 = (flags & MPTCP_DSS_DSN64) != 0;
 		mp_opt->use_map = (flags & MPTCP_DSS_HAS_MAP) != 0;
 		mp_opt->ack64 = (flags & MPTCP_DSS_ACK64) != 0;
 		mp_opt->use_ack = (flags & MPTCP_DSS_HAS_ACK);
 
-		pr_debug("data_fin=%d dsn64=%d use_map=%d ack64=%d use_ack=%d\n",
-			 mp_opt->data_fin, mp_opt->dsn64,
-			 mp_opt->use_map, mp_opt->ack64,
-			 mp_opt->use_ack);
-
 		expected_opsize = TCPOLEN_MPTCP_DSS_BASE;
 
 		if (mp_opt->use_ack) {
@@ -163,12 +157,18 @@ static void mptcp_parse_option(const struct sk_buff *skb,
 		}
 
 		if (mp_opt->use_map) {
+			mp_opt->data_fin = (flags & MPTCP_DSS_DATA_FIN) != 0;
 			if (mp_opt->dsn64)
 				expected_opsize += TCPOLEN_MPTCP_DSS_MAP64;
 			else
 				expected_opsize += TCPOLEN_MPTCP_DSS_MAP32;
 		}
 
+		pr_debug("data_fin=%d dsn64=%d use_map=%d ack64=%d use_ack=%d\n",
+			 mp_opt->data_fin, mp_opt->dsn64,
+			 mp_opt->use_map, mp_opt->ack64,
+			 mp_opt->use_ack);
+
 		/* RFC 6824, Section 3.3:
 		 * If a checksum is present, but its use had
 		 * not been negotiated in the MP_CAPABLE handshake,
@@ -300,6 +300,7 @@ void mptcp_get_options(const struct sk_buff *skb,
 	mp_opt->port = 0;
 	mp_opt->rm_addr = 0;
 	mp_opt->dss = 0;
+	mp_opt->data_fin = 0;
 
 	length = (th->doff * 4) - sizeof(struct tcphdr);
 	ptr = (const unsigned char *)(th + 1);
-- 
2.53.0

