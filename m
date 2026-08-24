Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A57CF46D0B9;
	Mon, 24 Aug 2026 16:49:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787590156; cv=none; b=gZ0ohcy+tmJ61pGunqTyDu0/KtoZRhE0Q5R3GS4XvarZP4wbGIDMlZOIR/yzk3o72cHh3k2iTUqs8XwfD23iFY/T1iHGToqWeB3rV/HqC9cm1LKqMWhMoZX7VBgZz4lDjcBqora9uOoTEZFnSnlxCS+SdOj2I0TiXFzPIr9WeJc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787590156; c=relaxed/simple;
	bh=7jSWUUVFWTP7oYJmRxO7xcqs4guR/7YUJnwFZN8z43c=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=pidAKWW3x3P/gZe7WBoRIkd8xI9yux9l2DsKrRgOUCEhKZ9Pp8KR/rsD/g5qcNQRWFcIGsZ2og8adhbecHMyGK3JzHDf9JmlHPTXsTbkyaT//9pyNey0kbUc3RjTWLw906p0LQsIH3zkujEuOUtCaDLMcWcjfE0OSvTsDqHcmEU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ETsfbYWi; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ETsfbYWi"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E328A1F00A3A;
	Mon, 24 Aug 2026 16:49:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1787590155;
	bh=MzzsoE+CXryRRKd5J5xh+BgTBt7W3d3SdYarcORfHtY=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc;
	b=ETsfbYWiLe32/Vol+ba+uGc2udDeTxzeBBm/QJ8EHrPoiN1uyz50CQmVJnLbe2bLn
	 ppe7kgxU8pFvnniScO6sWCvRI8IVE+WFMwEJKiNg59bkcKz2yk7CFO2ppLQWWqJ9uh
	 MT8y6uL1zoV3yWL15jOlaxrpduWkBf6egbskBcGt/E5dGLDLmWke7Lsv7JMukKLfvg
	 IA0/0bf3qPjwUA3opHla+fi6dCLNcR5rNBaiAyu5dkqYQKJQ21ZG9BqgU2OfxBIxBL
	 dfhRHU8ca3NuDRi/kPTs5IpQojqlnuIASTKyWsOpLU0qJEHM5vsayuASLX59v5n0/o
	 LI10iurzuhMew==
From: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
Date: Mon, 24 Aug 2026 18:48:32 +0200
Subject: [PATCH net 12/14] mptcp: options: fix uninit-value in
 mptcp_write_data_fin
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260824-net-mptcp-misc-fixes-7-3-rc1-v1-12-a92309d121ca@kernel.org>
References: <20260824-net-mptcp-misc-fixes-7-3-rc1-v1-0-a92309d121ca@kernel.org>
In-Reply-To: <20260824-net-mptcp-misc-fixes-7-3-rc1-v1-0-a92309d121ca@kernel.org>
To: Mat Martineau <martineau@kernel.org>, Geliang Tang <geliang@kernel.org>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 Simon Horman <horms@kernel.org>
Cc: netdev@vger.kernel.org, mptcp@lists.linux.dev, 
 linux-kernel@vger.kernel.org, "Matthieu Baerts (NGI0)" <matttbe@kernel.org>, 
 stable@vger.kernel.org, Kuniyuki Iwashima <kuniyu@google.com>, 
 Keita Morisaki <kmta1236@gmail.com>, Jakub Sitnicki <jakub@cloudflare.com>
X-Mailer: b4 0.16.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1873; i=matttbe@kernel.org;
 h=from:subject:message-id; bh=7jSWUUVFWTP7oYJmRxO7xcqs4guR/7YUJnwFZN8z43c=;
 b=owGbwMvMwCVWo/Th0Gd3rumMp9WSGLJ6Sp9a3zXfvvH3itu6ydWcR9Zv4p0/zXnD5dVNz5ZGi
 Gl570hQ6ShlYRDjYpAVU2SRbovMn/m8irfEy88CZg4rE8gQBi5OAZiIiyXDfw+WzqNB8gskZWV+
 ix1b5v9nmXsrw6Of4rfbHu+OCjk5+Q3DP0UrxVXV804q93PP6GufmOv/QS25u/bOjNZJQbvebdq
 vzwsA
X-Developer-Key: i=matttbe@kernel.org; a=openpgp;
 fpr=E8CB85F76877057A6E27F77AF6B7824F4269A073

When sending a DATA_FIN without data, and because the DATA_FIN occupies
1 octet of the connection-level sequence space [1], it is then required
to add a DSS mapping with specific values.

If the checksum has been negotiated, it also needs to be computed, and
included in the outgoing packet, and thus the initial csum data needs to
be reset to 0 as well. This is no longer the case since commit
cfcceb7a39fc ("tcp: shrink per-packet memset in __tcp_transmit_skb()"),
because the whole ext_copy structure is no longer zeroed by default.

This seems to be the only case where use_map is changed and set
afterwards, so initialising the csum field only in this case, along with
other fields for this specific case.

Fixes: cfcceb7a39fc ("tcp: shrink per-packet memset in __tcp_transmit_skb()")
Cc: stable@vger.kernel.org
Link: https://datatracker.ietf.org/doc/html/rfc8684#section-3.3.3 [1]
Link: https://sashiko.dev/#/patchset/20260812-net-next-mptcp-misc-feat-7-3-v1-0-1905a818f6cb%40kernel.org?part=2
Reviewed-by: Geliang Tang <geliang@kernel.org>
Signed-off-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
---
Cc: Kuniyuki Iwashima <kuniyu@google.com>
Cc: Keita Morisaki <kmta1236@gmail.com>
Cc: Jakub Sitnicki <jakub@cloudflare.com>
---
 net/mptcp/options.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/net/mptcp/options.c b/net/mptcp/options.c
index 196a46e7467d..ce0de02f5a3a 100644
--- a/net/mptcp/options.c
+++ b/net/mptcp/options.c
@@ -612,6 +612,7 @@ static void mptcp_write_data_fin(struct mptcp_subflow_context *subflow,
 		ext->data_seq = data_fin_tx_seq;
 		ext->subflow_seq = 0;
 		ext->data_len = 1;
+		ext->csum = 0;
 	} else if (ext->data_seq + ext->data_len == data_fin_tx_seq) {
 		/* If there's an existing DSS mapping and it is the
 		 * final mapping, DATA_FIN consumes 1 additional byte of

-- 
2.53.0

