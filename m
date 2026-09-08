Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 338D2560AC0;
	Tue,  8 Sep 2026 14:14:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788876912; cv=none; b=m8xG5ZGHg58if51r6drIW6uLYOxHmL3GA4jXJJVMB4t4P4mviWnUr8nSKd3qcj6G5GnFUGCEmeN26VHT2b+a8w7G19tOIJcbhTnfbvNrz2LneH9mBuNlGw14izw/LUWiwwZCST2tBHSNdNp9XUUayOZxcOTe+D5gfWN3A8NyMAs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788876912; c=relaxed/simple;
	bh=Va1cm8+jI3RJ75BNEHddwmAG2Q40V2L9shM8rRbvVzY=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=LN90M310/YS00fQwzReUnZqknVTU8/Ss81JItNY2Xu3KKf+Wuvrm4fIdp033IEFZLpbpurIUgXd3YCGeBgyrzTuUJR/pmYR0WtrOM6JQzDkO403uTviv3dH48V7hxAtkiVjptEqSi+GVBlSBY27buCF2C7vxsfsNfyDyhJ4V97A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Nyt3BGNT; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Nyt3BGNT"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 666ED1F00A3F;
	Tue,  8 Sep 2026 14:14:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788876890;
	bh=6h9xAWtPZ4ldGAVn39Gn3qvFe+0Q0ZME7hRKhcrqhVQ=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc;
	b=Nyt3BGNTlB1YnIJRX2Io6NHcTGMAu9oukKM7mZKLWBy56NofJqEAWI6KZ+hPGgnFx
	 C9/5Er/cEMXclfujIrCRLztDa2+PMByj2a06axiQ701wsE9x6HH1ZAEQ0cmmU75nHD
	 rTldDaJF79KAJ8vCYEFjIu44+0gfRMErcrY2cy9oYqPrVMKcD1+F5VtgvDsO7+xfLB
	 NC0j6HPSaEjMK/HspU8AobIrqKqvtIWIf7nMLW8/98XSN7UdlDjFh1i/6dUD5YYtLY
	 cDzGBCM7SmzzRJsMLhGUFrN6JkpuQjejFlwZjgT1wiX/Dfb5sEX+MUVrW/nZOJPd9K
	 VxlikDkcTK5mQ==
From: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
Date: Tue, 08 Sep 2026 16:07:19 +0200
Subject: [PATCH net v2 14/15] mptcp: being below memory limit is a likely()
 condition
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260908-net-mptcp-misc-fixes-7-3-rc1-v2-14-df1de70348b6@kernel.org>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=1095; i=matttbe@kernel.org;
 h=from:subject:message-id; bh=5TH+UjKSDKZpdqyAuzRYKv7QKP0HLCkVk4wX0y2bs2U=;
 b=owGbwMvMwCVWo/Th0Gd3rumMp9WSGLIWSBg6+C/+XuwVUebe0G15T6e80L5OYnkSx3+dneKeJ
 Zay4n87SlkYxLgYZMUUWaTbIvNnPq/iLfHys4CZw8oEMoSBi1MAJnIvh+EP98RCsbP6dz+sbWv/
 VnI7svZ3/YWO1D3xX7NTci5cyFwazMgwye/P2nTxzI25McmNG2U3HC5Xln3c9GJiQ/YbVxmLoDR
 2AA==
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
index 302936ff456a..4309fca6b119 100644
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
2.55.0

