Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3B3B03E2769;
	Tue,  2 Jun 2026 12:15:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780402521; cv=none; b=uqBSZ/GGX8gBmib27O4ESOyny6yBuQgcDMwsGI7lU9GnPjrk8HyY9BTOff3T+FZi0xjcYc3HeGyMGiqcATja51klaO7DkK2oo8iS5Nj9rzrnxu7cln2E9WEUoxI9Mm1COXgNgJ8TKWO62uV6vHD0s6V3MunYrrz508wMuelEPsw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780402521; c=relaxed/simple;
	bh=N1bc/nUu/TVx6vrRiyttrdnrCWdRHHAZglldql0RHt0=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=Fa0lVdi6Dd4++qiCXDAZeoQxwwL8G7c8dLI4hP7IixscHHj5L93nJCaEh5kfBN2lb3/F6eLeR+5LYuEzpDkRjg7mroYkrRumZrRCuqk3PET0N/bY4MoWap1LOjwEwOyktpNCaPJ8DTLMGURRcYnovGDNVRU4JlUd1mrLuk/cMrQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=SSwIzN90; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="SSwIzN90"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 147ED1F00893;
	Tue,  2 Jun 2026 12:15:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780402520;
	bh=B4xB1YlIM90XgSgiiXndV0d7/6vuxA6YWpl23fcgEKU=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc;
	b=SSwIzN90WHVAVkOr2JHlhH8fVDX/cdEAtDa8l4hbTkk5uOvLIUA6fqkjwpn4o1eOI
	 jy99AVK2fGCr+Daw3Glk29VrWnazBPImWWvhl47jdiSiVnDIbDZYpch8VEC76nRV/j
	 cbVaTONBVCLcSpeCEn4J19qrL26y2l7yUL5pxmNcnGFnYOW+Kyll3cJ0VClI6Ln4GX
	 cC5k9k+61ZwLyKtSARh8Na4X4mEEQWZOcycLFYNCGHoscX9C3nvecCHtPBr6USUB/+
	 sJdmfpqKZzjGvIL7Toc+nQdvyyrNaZ8lJx5KFPixQFEJ7fnmpyEMBQxMDNJoTJ0LTo
	 DUV014MYHyp2g==
From: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
Date: Tue, 02 Jun 2026 22:14:15 +1000
Subject: [PATCH net v2 08/11] mptcp: sockopt: set sockopt on all subflows
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260602-net-mptcp-misc-fixes-7-1-rc7-v2-8-856831229976@kernel.org>
References: <20260602-net-mptcp-misc-fixes-7-1-rc7-v2-0-856831229976@kernel.org>
In-Reply-To: <20260602-net-mptcp-misc-fixes-7-1-rc7-v2-0-856831229976@kernel.org>
To: Mat Martineau <martineau@kernel.org>, Geliang Tang <geliang@kernel.org>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 Simon Horman <horms@kernel.org>, Florian Westphal <fw@strlen.de>
Cc: netdev@vger.kernel.org, mptcp@lists.linux.dev, 
 linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org, 
 "Matthieu Baerts (NGI0)" <matttbe@kernel.org>, stable@vger.kernel.org
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=1237; i=matttbe@kernel.org;
 h=from:subject:message-id; bh=N1bc/nUu/TVx6vrRiyttrdnrCWdRHHAZglldql0RHt0=;
 b=owEBbQKS/ZANAwAIAfa3gk9CaaBzAcsmYgBqHsks2QEuzSYHMPCU8zFEmJNQCwGBHJ9OBY3JY
 Fm/L1NGDUWJAjMEAAEIAB0WIQToy4X3aHcFem4n93r2t4JPQmmgcwUCah7JLAAKCRD2t4JPQmmg
 c9LUEADoDTAfJ4IQwvOm87BA5wseGddFN/qDZcquGnMZNsmxNtLt4wMcxEnNy+fOB8EceC4wSdh
 /GB9KY27DTtftU31+Vs+z0eo9CUj1tbeXK3HZs1jugt7jvddZxPEN9rMTiLkBtAHpF/NQBChD3s
 2F2DAsBGdW2uv1xCNw65a8bhM+0f5jVQtkmWdrFaMF0JUeNx6h6dZNVsqkUQHH3HFD/teCTsdFP
 CLdFt8MHOUvBL6+IiyA29KmJL229TAsCubzl9WATYRLJUkWFpMLuymvOpuF4BCKF2Rz2p6oFG4Q
 iGNiB4xudGgCluPxEWI+19Dq60ZWctHu+JRESjGBgaf7i3nTFFoxcLR/BnSWD8RzkXkCS+y9cDE
 f1aI3Pq6fW86o21xhHWJwzwXOU0mlQgiFtdWNOEm3as78aSBO1J7GhhykcLKqqzqPap/b/37n/W
 iSYti2txhFtv26HYV1kJ/HPLPWCMHfTeKkpGq3519k+Klyq7xNzY8As8JxeP2vJj1pGRVsF+Slc
 YnE0BhBSKFiXsiutOB7jpmjD23kgoeqNGUJ94ZxTPBCiCiflc9CQDWy05OCNVJWh37CasI/tcgm
 W7XQeSUcqGNPi+XpeVh9gw0g1j3jed/RQIAu2g6M1+ezMJZtWUk1btNWtGjvUJ+4Sx7qfIAjGS/
 Gnwknita+8qteRg==
X-Developer-Key: i=matttbe@kernel.org; a=openpgp;
 fpr=E8CB85F76877057A6E27F77AF6B7824F4269A073

The mptcp_setsockopt_all_sf(), currently used only with TCP_MAXSEG,
stopped when one subflow returned an error.

Even if it is not wrong, this is different from the other helpers trying
to set the option on all subflows, and then returning an error if at
least one of them had an issue.

Follow this behaviour, for a question of uniformity.

Fixes: 51c5fd09e1b4 ("mptcp: add TCP_MAXSEG sockopt support")
Cc: stable@vger.kernel.org
Reviewed-by: Mat Martineau <martineau@kernel.org>
Signed-off-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
---
 net/mptcp/sockopt.c | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/net/mptcp/sockopt.c b/net/mptcp/sockopt.c
index 91aa57f1d0fd..fcf6feb2a9eb 100644
--- a/net/mptcp/sockopt.c
+++ b/net/mptcp/sockopt.c
@@ -817,10 +817,11 @@ static int mptcp_setsockopt_all_sf(struct mptcp_sock *msk, int level,
 
 	mptcp_for_each_subflow(msk, subflow) {
 		struct sock *ssk = mptcp_subflow_tcp_sock(subflow);
+		int err;
 
-		ret = tcp_setsockopt(ssk, level, optname, optval, optlen);
-		if (ret)
-			break;
+		err = tcp_setsockopt(ssk, level, optname, optval, optlen);
+		if (err < 0 && ret == 0)
+			ret = err;
 	}
 
 	if (!ret)

-- 
2.53.0

