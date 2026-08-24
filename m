Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2EABE470E9C;
	Mon, 24 Aug 2026 16:49:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787590159; cv=none; b=ihGA93gF/WuQlO/JfIUspDXMSSbh3mZKFl0LE5+P567noLyA1zHYbdMqilQkAKWBCAQtIUggT+ipo3aBHbk7X096srVUTRYCi5Y/WKu7l22T1/ObbcUBGUfKmZHybqbl9CgL1dr04MCJ+q55DxNzneRM2PJTt1ENw1p3uzS24MI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787590159; c=relaxed/simple;
	bh=Ey6sLV9Oon8XTxBtjs39uN0/nRoJMd00sb+ykNkZUis=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=fgzU0lOe1k+YYV9MdyJHTrXiWKtbrBAsf/9hKYYvW3gy4cLjrhF9tFWyjg95/wo2iXHbR4PNmCDCIvUz1PGbYgnmj2+8gbRngQV0wTJ1rd1pmYtdFMYpZFuR57dI32+3sfm0J4rwnDOEcscT/Is+P7iRhIvDFOchuuxwJZE9gcI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=TVsPWuIZ; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="TVsPWuIZ"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C99CB1F00A3D;
	Mon, 24 Aug 2026 16:49:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1787590157;
	bh=GXP9GWldKytA5St615ekAHxdGTk4m0L4kGPQQnuyG4s=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc;
	b=TVsPWuIZcT64oStpXiP6GsSOixrTbUlpAqeJCbUe90sE7RvIKUQV+Ma9SdF/5m51k
	 Tk9NW/eSVAOIM0aOtJkgTm2EBPPuBNxJ9AfLsysos9BpLVO9OU0x+RBYOq5uoeYCi5
	 vGrfdnEE8sP9L7Rej6jHloM1a7s+TL6UlyeU9xnaaLSwEPllfxqjsyUccJ25wEouWI
	 1MBQKzKIjAjfOXUPpBIzLgFQr8+z8hdjgQ+NOFM0N7FsSIF2BS8siTU6xZsMHx3Mbb
	 LjCUEclS0xb639rIxrtTEKibmhAHm4NQQJNDRQrl4xezT3yfMLZPuxdwG+n1CKOPDa
	 9I5RaKEOw/ErQ==
From: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
Date: Mon, 24 Aug 2026 18:48:33 +0200
Subject: [PATCH net 13/14] mptcp: being below memory limit is a likely()
 condition
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260824-net-mptcp-misc-fixes-7-3-rc1-v1-13-a92309d121ca@kernel.org>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=1095; i=matttbe@kernel.org;
 h=from:subject:message-id; bh=wv0O0DPEH/JcczeA1KIApUH8RIwBeS7ndEXCzeQDfGc=;
 b=owGbwMvMwCVWo/Th0Gd3rumMp9WSGLJ6Sp+Jb9+zbZGCkGLNE9+ZFV7/2OqiTTcJFcws+9p7+
 Y/zA97ZHaUsDGJcDLJiiizSbZH5M59X8ZZ4+VnAzGFlAhnCwMUpABPJ9mdk+HnVhpHl/Xend3MO
 aKoxa9dqVlyW2cXF/mrZJLEVX3o7njAyLD45d08379vQmuvvPK9ur06dG2bmPoWdf+Zeg0tb2y7
 /5QUA
X-Developer-Key: i=matttbe@kernel.org; a=openpgp;
 fpr=E8CB85F76877057A6E27F77AF6B7824F4269A073

From: Paolo Abeni <pabeni@redhat.com>

The current compiler hint annotation is wrong, due to inverted
logic in the previous revision of the relevant code.

Fixes: e468d371180d ("mptcp: implemented OoO queue pruning")
Cc: stable@vger.kernel.org
Signed-off-by: Paolo Abeni <pabeni@redhat.com>
Reviewed-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
Signed-off-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
---
 net/mptcp/protocol.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/net/mptcp/protocol.c b/net/mptcp/protocol.c
index c7c8bb3b3e00..be59ffa4bd31 100644
--- a/net/mptcp/protocol.c
+++ b/net/mptcp/protocol.c
@@ -289,8 +289,8 @@ static void mptcp_prune_ofo_queue(struct sock *sk,
  */
 static bool mptcp_can_ingest(const struct sock *sk)
 {
-	return unlikely(sk_rmem_alloc_get(sk) <= READ_ONCE(sk->sk_rcvbuf)) ||
-			__mptcp_check_fallback(mptcp_sk(sk));
+	return likely(sk_rmem_alloc_get(sk) <= READ_ONCE(sk->sk_rcvbuf)) ||
+	       __mptcp_check_fallback(mptcp_sk(sk));
 }
 
 static bool mptcp_try_rmem_schedule(struct sock *sk, const struct sk_buff *skb)

-- 
2.53.0

