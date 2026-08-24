Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3268837702B;
	Mon, 24 Aug 2026 16:48:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787590132; cv=none; b=m+uBqrKqtSzcK1ng4SdohU+rPvV2klbz4mdE0Jrp0uxi40/By5u6Qni3tcI1M03QKDk6PlJrGhPJHk8mhdxh/Gtl9D3Bzyrn35hnQdmgHVltU3vQ5dQRjqcXtH5fwWsYWFNkYELbleM83fvCRO+aoU32ZUBqpJFwl+sGA9MaHME=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787590132; c=relaxed/simple;
	bh=wKN+6HtMik/nWJg73DgY3roMm91PRy1tMx2HIKB+Wxc=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=UTr/5JO1zkjTtJS+CDGYO/b5HYwVQS+5W6KKVHwVuM5qE5GmHrkUhyCYfI3cNC8+qzm7YyKaWB7eb8owet6dmX4RSCj48nHwETfV9Ahg8JY/KR5lWSGehF1/695L3mhoaOWj6tAZvrQznljj8PxA16MjmlCBvwtIAlvIdGu9cMI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=EJI8w3is; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="EJI8w3is"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A4EEE1F00AC4;
	Mon, 24 Aug 2026 16:48:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1787590130;
	bh=bBBJJ3m4Mj8vD71vixgZgb7Rhng8eDoMplK1Hf1HuJU=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc;
	b=EJI8w3isn9ISDzsqMubCrPh4vNhVVPLccgkH8Dn6rzsMmir4PshjQufSfMKbu5Qpk
	 vV3v+Pu+3VHiFz42JkENk1aUrpNfY6dl8YO8ado/ZPt8gLpQlaD4Bnb1c3clWaFBw2
	 hZvNxg4snaJPqkswjM2x457eJQXNHw3gAXBitcCcinQyNjNZ170IQvsaRukmdQWNhz
	 kg9rPJRtixskUN88kzwUeNbbKcO4l9EjIjACkaBu3wG/KgAybRwsZNDtQBZ8G6tX9b
	 ejM80XyYFEtMfkoz6GWkCOp/TPJQ/9V3BWxgx7RWkV/q5IsNTW3omPafkNJG35waOx
	 LqcDwREus9kxA==
From: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
Date: Mon, 24 Aug 2026 18:48:23 +0200
Subject: [PATCH net 03/14] mptcp: syncookies: remember the request backup
 flag
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260824-net-mptcp-misc-fixes-7-3-rc1-v1-3-a92309d121ca@kernel.org>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=1782; i=matttbe@kernel.org;
 h=from:subject:message-id; bh=wKN+6HtMik/nWJg73DgY3roMm91PRy1tMx2HIKB+Wxc=;
 b=owGbwMvMwCVWo/Th0Gd3rumMp9WSGLJ6Su8HztZd35QjslS3+srX0w9PsYtEdhlt2bPy//5/3
 /iep/Tu6ShlYRDjYpAVU2SRbovMn/m8irfEy88CZg4rE8gQBi5OAZhIzk2Gfxp3ItTfsCqLPmcN
 MJvSudeV9dRXVRuRpZ6Khy9fPcs1Q5uRYeUryZVWXqvT1BoV7bQ7T8csSLZ8+3HSD6Y/Ya+51nY
 rMQEA
X-Developer-Key: i=matttbe@kernel.org; a=openpgp;
 fpr=E8CB85F76877057A6E27F77AF6B7824F4269A073

Instead of using an uninitialised bit when copying the info in
subflow_ulp_clone().

To fix this, no need to extend the join_entry structure: backup is
coming from struct mptcp_subflow_request_sock, only one bit. Do the same
here by using one bit for both.

Fixes: 9466a1ccebbe ("mptcp: enable JOIN requests even if cookies are in use")
Cc: stable@vger.kernel.org
Reviewed-by: Geliang Tang <geliang@kernel.org>
Signed-off-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
---
Cc: Florian Westphal <fw@strlen.de>
Note: Peter Krystad's email address is bouncing.
---
 net/mptcp/syncookies.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/net/mptcp/syncookies.c b/net/mptcp/syncookies.c
index b5cac5701122..9474706641c1 100644
--- a/net/mptcp/syncookies.c
+++ b/net/mptcp/syncookies.c
@@ -26,7 +26,8 @@ struct join_entry {
 	u32 local_nonce;
 	u8 join_id;
 	u8 local_id;
-	u8 backup;
+	u8 backup:1,
+	   request_bkup:1;
 	u8 valid;
 };
 
@@ -63,6 +64,7 @@ static void mptcp_join_store_state(struct join_entry *entry,
 	entry->remote_nonce = subflow_req->remote_nonce;
 	entry->local_nonce = subflow_req->local_nonce;
 	entry->backup = subflow_req->backup;
+	entry->request_bkup = subflow_req->request_bkup;
 	entry->join_id = subflow_req->remote_id;
 	entry->local_id = subflow_req->local_id;
 	entry->valid = 1;
@@ -117,6 +119,7 @@ bool mptcp_token_join_cookie_init_state(struct mptcp_subflow_request_sock *subfl
 	subflow_req->remote_nonce = e->remote_nonce;
 	subflow_req->local_nonce = e->local_nonce;
 	subflow_req->backup = e->backup;
+	subflow_req->request_bkup = e->request_bkup;
 	subflow_req->remote_id = e->join_id;
 	subflow_req->local_id = e->local_id;
 	subflow_req->token = e->token;

-- 
2.53.0

