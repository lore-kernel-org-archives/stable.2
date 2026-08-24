Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4411446AEDD;
	Mon, 24 Aug 2026 16:48:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787590137; cv=none; b=ryhZKc55e8DiKkkSXhmbnSbhXFDYf1L66Jv134/K3ZgJeps8snDBYe3Je/smZVQW/sHWhYUn4zzZUWVuPv5QDg/xT9Pa69V3kODpNAlIEMjIdjM+paE/+GlYeKMpewumHicY9VQ9RdvCZ3YLlnvdYUsFneNL03Rvj/VttBKANZk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787590137; c=relaxed/simple;
	bh=z7wtoyOwpjfF7//Agdkguz3+gKqzGcxFhF/6OCf4C8w=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=uRVpXAojYOmZHolkR9/dOLajA8WhOuXKvp85q2hDYIaQK+eGGaGfpn0jxg2N7mGMQzWSyCds+PFSU1qIZKzC9W4qLDu+mOKHRgrWW4pW7c1a7+fjmFatmCGfcDrkcqBO4PSFdHWEmua4wDbI/qdsXLY8lNInyCivkH9C7XKB5t0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=NUY0f3iZ; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="NUY0f3iZ"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 262B11F00A3D;
	Mon, 24 Aug 2026 16:48:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1787590136;
	bh=malZ4u2amF3l75ye9yerrprmL8w3KICVfFH7XuWia5A=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc;
	b=NUY0f3iZirAoE9kGSoyyIFG1IxmbkW7aaL9JiCRXUfP73GtCrICamtFwFjyaEce16
	 cTN3yDYD1sidlrIaLAsrCCWQp/5OW7BqV8gZdxMig0d7nkdv7UiPIAQf3Tgv/ILiSk
	 ZgaaN89Ai/+06ZK5SH6fCfodCvWVn3HlL6uOSW8p0N5pTyIK2t7sToRlNnSzGvRxVO
	 eRnZtKLTN9GtCvzU3lTmW4jMQxoQVKe9TgQRf773xc9rrFVQYuH2Vj4oSZoK7egZNa
	 TmhiqZj4JQWTg5aiq7S1QhY2vHs6sV4DWVS/KqRHKNXzKAUAcODykoiZ39bDaOwsCM
	 NTU/pG146Thmw==
From: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
Date: Mon, 24 Aug 2026 18:48:25 +0200
Subject: [PATCH net 05/14] mptcp: options: handle MPC data + csum reqd + no
 csum
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260824-net-mptcp-misc-fixes-7-3-rc1-v1-5-a92309d121ca@kernel.org>
References: <20260824-net-mptcp-misc-fixes-7-3-rc1-v1-0-a92309d121ca@kernel.org>
In-Reply-To: <20260824-net-mptcp-misc-fixes-7-3-rc1-v1-0-a92309d121ca@kernel.org>
To: Mat Martineau <martineau@kernel.org>, Geliang Tang <geliang@kernel.org>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 Simon Horman <horms@kernel.org>
Cc: netdev@vger.kernel.org, mptcp@lists.linux.dev, 
 linux-kernel@vger.kernel.org, "Matthieu Baerts (NGI0)" <matttbe@kernel.org>, 
 stable@vger.kernel.org
X-Mailer: b4 0.16.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=2240; i=matttbe@kernel.org;
 h=from:subject:message-id; bh=z7wtoyOwpjfF7//Agdkguz3+gKqzGcxFhF/6OCf4C8w=;
 b=kA0DAAoWfCLwwvNHCpcByyZiAGqMdeCjWz3yWXw7D/oy189dbZ3kwc2pLwHVBymxFxhuloEBf
 oh1BAAWCgAdFiEEG4ZZb5nneg10Sk44fCLwwvNHCpcFAmqMdeAACgkQfCLwwvNHCpcUsgEAgnBw
 FWo6aNwd0XhThIhCXjmhsD91XpJtYogIuos+2KoBAKXVk/7Orca7/Z1va12lpoKdIDj+BMRv4sq
 H9VCNQ/gA
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

Fixes: 208e8f66926c ("mptcp: receive checksum for MP_CAPABLE with data")
Cc: stable@vger.kernel.org
Link: https://datatracker.ietf.org/doc/html/rfc8684#section-3.1-23 [1]
Closes: https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20260803-net-mptcp-misc-fixes-7-2-rc6-v2-0-b8f496d71664%40kernel.org?part=1
Reviewed-by: Mat Martineau <martineau@kernel.org>
Signed-off-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
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
2.53.0

