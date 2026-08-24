Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9B3EF340A6F;
	Mon, 24 Aug 2026 16:48:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787590131; cv=none; b=WOPrA3oYZPkE1QQiWPixvJv7luQlvPCO3HwUGUoBlYHLR51f0l9k3VfNhhlAcqzSkiYfg7wpj7k1zK6feq0tE6t0NnqNYjodlYgp710F1EFlx50TQzBhb3yYmpa9CdGeggQ0IkhyAhQ1I1yd4cI7iAjUEWYHuWPP2lLqsQ5hlps=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787590131; c=relaxed/simple;
	bh=xBPNGBnE67jDLZdPm+a09DaSqatW6I+IsFPkH1rSYog=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=XntI7+O7kag4Y6LkPz9PQr/gdZ4dIMLuR55iSRnwtoHg0uAKJVhO8YIiNXPDEqJGGs2sdcooCWJ7CJYMMIY6By475EvsxueG8InXOQgR9jgkbKbSdkuKAv6f8CrrgYZP3JOHC+DzlnF4uarzRkPUEt68mumyeIiEqB2nDqIhik8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hD6CH+PQ; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hD6CH+PQ"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 161EF1F000E9;
	Mon, 24 Aug 2026 16:48:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1787590128;
	bh=niL7XK/Zy0n//FoXtfYiEkEZnHtpBCUQQY6mZf43iUo=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc;
	b=hD6CH+PQpYZz9OTP3wnCavbiOS74wO2/DX3vKegvOs/PoHHyFYMR+4qMhv/hOHns+
	 m+Z6YZqJKKOklOjxCDFqfU8BJS7iLxAOWgdEy+A4+QKbmEM1bZgtG4HI8BrdkBA19Z
	 kO7wkbf1FlOAzvCrz7h1b5LBZOrWhRDr0QAnFySi80STISP+ouAmk3kG9taPSvWNFS
	 vK/4tzS6U6TnzW+do+9ddwlm8ixiAIRmSEpmJEh08cPVR0U8Acj//IJy+HjyOuvx6p
	 w7c841yTiuCU4DpzwjkMkhJqhx3eTojPom5wYfNibArqlh0bL5zlBVbWfEDQwzybkd
	 AUzuSnALzjl1A==
From: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
Date: Mon, 24 Aug 2026 18:48:22 +0200
Subject: [PATCH net 02/14] mptcp: subflow: no need to copy thmac during
 ulp_clone
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260824-net-mptcp-misc-fixes-7-3-rc1-v1-2-a92309d121ca@kernel.org>
References: <20260824-net-mptcp-misc-fixes-7-3-rc1-v1-0-a92309d121ca@kernel.org>
In-Reply-To: <20260824-net-mptcp-misc-fixes-7-3-rc1-v1-0-a92309d121ca@kernel.org>
To: Mat Martineau <martineau@kernel.org>, Geliang Tang <geliang@kernel.org>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 Simon Horman <horms@kernel.org>
Cc: netdev@vger.kernel.org, mptcp@lists.linux.dev, 
 linux-kernel@vger.kernel.org, "Matthieu Baerts (NGI0)" <matttbe@kernel.org>, 
 stable@vger.kernel.org, Florian Westphal <fw@strlen.de>
X-Mailer: b4 0.16.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1277; i=matttbe@kernel.org;
 h=from:subject:message-id; bh=xBPNGBnE67jDLZdPm+a09DaSqatW6I+IsFPkH1rSYog=;
 b=owGbwMvMwCVWo/Th0Gd3rumMp9WSGLJ6Su/tW8zTZdVeH7tz9kVRuVTxJoZa+8cvlTzbluo9K
 l029aZiRykLgxgXg6yYIot0W2T+zOdVvCVefhYwc1iZQIYwcHEKwEQmLWdkmHOoPepctud1NeVL
 914JMVtuuun8lmGrmNZ1t7KcqY7n1zEyfElefNm1K8TCRM6xQ+fDg9/3hPf7TjS/nVPoez/h8fF
 zTAA=
X-Developer-Key: i=matttbe@kernel.org; a=openpgp;
 fpr=E8CB85F76877057A6E27F77AF6B7824F4269A073

'thmac' is not used after that point.

Indeed, subflow_ulp_clone() is called when the request on the passive
side is over, so when the truncated HMAC is no longer needed.

Note that in case of SYN cookies, thmac will not be initialised. So
better to remove it to avoid a warning from debug tools like KMSAN for
reading uninitialised data.

Fixes: f296234c98a8 ("mptcp: Add handling of incoming MP_JOIN requests")
Cc: stable@vger.kernel.org
Reviewed-by: Geliang Tang <geliang@kernel.org>
Signed-off-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
---
Cc: Florian Westphal <fw@strlen.de>
Note: Peter Krystad's email address is bouncing.
---
 net/mptcp/subflow.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/net/mptcp/subflow.c b/net/mptcp/subflow.c
index af81ad5e699d..01db7edce18a 100644
--- a/net/mptcp/subflow.c
+++ b/net/mptcp/subflow.c
@@ -2084,7 +2084,6 @@ static void subflow_ulp_clone(const struct request_sock *req,
 		new_ctx->request_bkup = subflow_req->request_bkup;
 		WRITE_ONCE(new_ctx->remote_id, subflow_req->remote_id);
 		new_ctx->token = subflow_req->token;
-		new_ctx->thmac = subflow_req->thmac;
 
 		/* the subflow req id is valid, fetched via subflow_check_req()
 		 * and subflow_token_join_request()

-- 
2.53.0

