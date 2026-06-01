Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DA19E2737E0;
	Mon,  1 Jun 2026 03:11:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780283471; cv=none; b=L4EgHQQqkeUeVy2i2sYfJ+hlyoY5NpE4N1tcfiZlS91pE5k3S22bsIID7M0i0SIdPTraHxiB5cww9/Fj8C+/bGpCFcU38wyqCvZ46/hb4rPuPaqS3rMXowIILhxQ+NshkllQyUYrgBJX0hkr5nx4Xp1aZbcfmGVtuD76JgzBD4o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780283471; c=relaxed/simple;
	bh=N1bc/nUu/TVx6vrRiyttrdnrCWdRHHAZglldql0RHt0=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=FJRGA/X6VwTeYg3l/8TxpXDCobOqtnzyGQ2FlOhKfqUgUrhjLrYv/O7MQAaTtDgWD1coVAoU+hMzkk+Lha6PRPP7uWMnAHU+Ne0WdqXaVMFdph9XH3eu8hfwHcQZti4OEhtdugVgv968i9icyM+0XrQBLfjYCTw4SXKA1C/nD5Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=XT8M8KYP; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="XT8M8KYP"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3DF511F00893;
	Mon,  1 Jun 2026 03:11:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780283470;
	bh=B4xB1YlIM90XgSgiiXndV0d7/6vuxA6YWpl23fcgEKU=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc;
	b=XT8M8KYPSA5dZeFZB2GCNBlFtgCX43f+ft0DI9OOMgXKHGqvXb60phmvWofEdCpm9
	 9pdh7hG/ThYqRVCiNaqa7Fqj0Gs1G25xF54eFqLEQw4WF/Us1zrFxyjmcsuUVNUM5F
	 +L1GJrO++gg9oFqpuKgWGX7MZruoMuvtNd7xz1Zav44ADsQk771IOx+ngU6n4yf6Et
	 9iDdRZ1m0gp104AMtQy2OAJyvvpJiAokJA1UpzA5P8GlucDVxb5e/b5OxQdvGeWisx
	 fA4Fs+AnV+VGqWF+hsm3rsl7A8Fht90tLRajQ1YcCJ1BPQWFJBOALDxWRk5t32e/hn
	 xU7QBPiZ4BuyA==
From: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
Date: Mon, 01 Jun 2026 13:10:04 +1000
Subject: [PATCH net 08/10] mptcp: sockopt: set sockopt on all subflows
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260601-net-mptcp-misc-fixes-7-1-rc7-v1-8-a5ae7791754b@kernel.org>
References: <20260601-net-mptcp-misc-fixes-7-1-rc7-v1-0-a5ae7791754b@kernel.org>
In-Reply-To: <20260601-net-mptcp-misc-fixes-7-1-rc7-v1-0-a5ae7791754b@kernel.org>
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
 b=owEBbQKS/ZANAwAIAfa3gk9CaaBzAcsmYgBqHPgeEPpqKTvjGzOf8cNr1mQoA1WSdlrRvGwbp
 79pX5ZafSuJAjMEAAEIAB0WIQToy4X3aHcFem4n93r2t4JPQmmgcwUCahz4HgAKCRD2t4JPQmmg
 c6CyD/oD2ZNPsQJKezZeB/3041Z52oUPR1IDEzXcEt8pZHKbaukirkYGSX2X9LtjamkZNDm3RQ2
 0CSEsE018YCTzC5KPEnvAXp6MzjXWlnetCSJ+7C6uEACK7po3Dpz88Y2IEfzUh/ufgt82+SMEAO
 IpaaKcED9PMz9SWNowMqSg6glB5WMhN4akM994ZNgmWaMHPLs654bKs+X5WXpUebl9ZqbKY2tC0
 1igKeF7DP6wm96LTizS2SJvK1jTQL+TlPApkQ8kQX/OC8QKGBv17i2yiCDbbbPVbt/Bmp6keCSM
 eGKeFz/87fvQURWJA/DNYtL6p+gAjgi12sk8Q/diBBLjGM7BIDt1dzAYFVSFVsIyuvMlsKhV3yb
 N3T2ABV2tA3RyOVk/4frtmq8EzZcpyrZ27tVqlvpD3TXFT7R2vf+NsJ6ZgmoZSWfYsCDbW63M4p
 gX7P/NR9tL7nTql5w7FI5iA/XUzuV6nVHQ8r7AxxPP4vNIyKunGm/7XZVIACTmRHgq3dq7aMlgt
 1EGHy1OUhuZgMm2EZPy6+wOOLQly/YmzQbqLUZ0Lk1kLxkKj/QBWoYd/5+ZD2gFLVgphKG8V4D7
 2vvY9WjMnbUZVpa1esgsmaX0jPMozJTeUnV5EFmJui92cV8Kw4tZrTfBttp3tsJ96+9v3XTEr7m
 w6zT6lKeiYhvKpQ==
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

