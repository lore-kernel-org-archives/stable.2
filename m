Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A5AA733FE33;
	Mon,  3 Aug 2026 16:17:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785773822; cv=none; b=L321iChxsxKTpzYJ4+Pl73QpU3IGjcRDB5e4mRxChp0AzSbH8L884sQSub9t3UuGk1zptY1IxCgwFLQCY1vEqgolouapVDbO5DUhZrGLP0rR5+t6wgBO3vTNA7+w5V34LrbPR9f5xV12PICP2fOSBkK9+H7QlRL76OpKPhvmmss=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785773822; c=relaxed/simple;
	bh=lvmkn61vQQEGAHxKyJX6XZhY6CoTu18WnEURCPq786A=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=AgkvWU+mCNaWTwXO+3KBIjRqIhrK9VVue3Vh28GaOrO8vZDEUmH2k5wzOZMlCezye/BrBicDF5i21vfNwezCM1CKiKEZXuCV6jMGZ0t1sq7ZPdseIVSrB/KPqmh7aAD/pUD8+GvLXrf9YZBuRpq4zOtPLfUqWKI2/y8SKKz+/VU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Bw9pcqpU; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Bw9pcqpU"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0FE081F00A3A;
	Mon,  3 Aug 2026 16:16:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785773820;
	bh=BEcd7zqaFXXWz5985otFpOCYR4kc99cvg9uym3Vjsvc=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc;
	b=Bw9pcqpUSekjhf0CErwZIK6L6/WVaubHnd95Nu3H+t4rUzx8O1mAUd0YAoUHRRZIo
	 SUl78qJ3n/Tv3HzJNtXKuiH7OMG286LoYmU0dYgz2QIQujAfKfMhpha/UtafyChLNy
	 ghtDBv3MP7QbiA4A5GMo8FBt/nuUC+Xxs+/Kk133M0VhDr2vb21xfiRWxGIWKlfJZI
	 aF2nFLMwFszM2CMO1Af6zCAM8ZtLXuLZpKoqMWa/nTVjlMY4WMLwSjLaBb7OQ9d//P
	 ZvjAEJH4dONxCEbiI46Umi+ddvkIaAhZ3eCSX/cHNlckE1aWGqh+JvELG2m27rBSa0
	 SQ3MUqy4iH//A==
From: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
Date: Mon, 03 Aug 2026 18:16:33 +0200
Subject: [PATCH net v2 1/8] mptcp: options: reset DSS fields in case of
 unexpected size
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260803-net-mptcp-misc-fixes-7-2-rc6-v2-1-b8f496d71664@kernel.org>
References: <20260803-net-mptcp-misc-fixes-7-2-rc6-v2-0-b8f496d71664@kernel.org>
In-Reply-To: <20260803-net-mptcp-misc-fixes-7-2-rc6-v2-0-b8f496d71664@kernel.org>
To: Mat Martineau <martineau@kernel.org>, Geliang Tang <geliang@kernel.org>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 Simon Horman <horms@kernel.org>
Cc: netdev@vger.kernel.org, mptcp@lists.linux.dev, 
 linux-kernel@vger.kernel.org, "Matthieu Baerts (NGI0)" <matttbe@kernel.org>, 
 stable@vger.kernel.org, Davide Caratti <dcaratti@redhat.com>, 
 Florian Westphal <fw@strlen.de>, Christoph Paasch <cpaasch@openai.com>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=1627; i=matttbe@kernel.org;
 h=from:subject:message-id; bh=lvmkn61vQQEGAHxKyJX6XZhY6CoTu18WnEURCPq786A=;
 b=owGbwMvMwCVWo/Th0Gd3rumMp9WSGLIK9r39toNV6MPpvHXfBfaes2FyUrpto/P3VJSH3pX1D
 Ln+JrMWdZSyMIhxMciKKbJIt0Xmz3xexVvi5WcBM4eVCWQIAxenAEzkTijDH85DN8pecKypXMlm
 cnS9U0gl1/OFKbIG7YmlvG+kmJVnWTIybPZvitW7Ya58UeJJ/abje6N//3885coWr0CFhmNPrqx
 bxwkA
X-Developer-Key: i=matttbe@kernel.org; a=openpgp;
 fpr=E8CB85F76877057A6E27F77AF6B7824F4269A073

A remote peer could send a malformed DSS with a wrong size, followed by
another DSS or MPC + Data. In this case, the first suboption will be
ignored, but leaving some fields written, which could lead to
inconsistency or access uninitialized data.

Explicitly reset the fields that could have been modified in case of
unexpected size.

Link: https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20260728-net-mptcp-misc-fixes-7-2-rc6-v1-0-f7e2d229159d%40kernel.org?part=1
Fixes: 648ef4b88673 ("mptcp: Implement MPTCP receive path")
Cc: stable@vger.kernel.org
Signed-off-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
---
Cc: Davide Caratti <dcaratti@redhat.com>
Cc: Florian Westphal <fw@strlen.de>
Cc: Christoph Paasch <cpaasch@openai.com>
Note: Peter Krystad's email address is no longer valid
v2: New. (Clashiko)
---
 net/mptcp/options.c | 8 +++++++-
 1 file changed, 7 insertions(+), 1 deletion(-)

diff --git a/net/mptcp/options.c b/net/mptcp/options.c
index c664023d37ba..038eca33c6b1 100644
--- a/net/mptcp/options.c
+++ b/net/mptcp/options.c
@@ -188,8 +188,14 @@ static void mptcp_parse_option(const struct sk_buff *skb,
 		 * RFC 8684 Section 3.3.0 checks later in subflow_data_ready
 		 */
 		if (opsize != expected_opsize &&
-		    opsize != expected_opsize + TCPOLEN_MPTCP_DSS_CHECKSUM)
+		    opsize != expected_opsize + TCPOLEN_MPTCP_DSS_CHECKSUM) {
+			mp_opt->dsn64 = 0;
+			mp_opt->use_map = 0;
+			mp_opt->ack64 = 0;
+			mp_opt->use_ack = 0;
+			mp_opt->data_fin = 0;
 			break;
+		}
 
 		mp_opt->suboptions |= OPTION_MPTCP_DSS;
 		if (mp_opt->use_ack) {

-- 
2.53.0

