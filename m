Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3DBC525A359;
	Mon,  1 Jun 2026 03:10:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780283451; cv=none; b=ZCcoT0EMflBtqYQtxKotY73NAO6t4/Rqt7yH/6wDuHKZGZfHlzFehopqqQEA8srqUYcHhobrqJs2NUrzjtXzceYDuqVBL+CFxPo+2PiD+ZaWCiuXZyrse1k8D7Z60InYhdgOkTwrPwb1pSRjNMFNoQ/V2hg+nO97rB0jQw+9cdU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780283451; c=relaxed/simple;
	bh=WU4mnJJidC8kx5P5EykZbiDwDBze9pofk03KcfcUqAw=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=qfiLu9zGYazBfe+RkFwbLFKHlkr5hGaJHV89rzbH1bd3Zsn8v/6KO5AtSyUtw3UO6iVR07Z18IjeCrMQX+GwA3I8a9kgYkS8bqDQuwSxHd2gCkYUTfrF5dHI5N7RMWEOOozclqJhpKlaadzK4iqYEUz0uTy1LuTmY7pX0gJDhrY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=OLt1Jwj5; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="OLt1Jwj5"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4C53A1F00893;
	Mon,  1 Jun 2026 03:10:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780283449;
	bh=YWzk4iwyj8yswO5of1zVWiveGCHoYg3J0Uz2q9B4axM=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc;
	b=OLt1Jwj5sraVsfZ0P/BeVfSRE43cnFgybJBeYHJYVqt4G8mVqbf4DYzRohNY7RqUj
	 0MHfBwKV+9kcWk00+ygmeAUdlkouVmu6i+ixy5D/HLVzTuI5ht5k3utWBaJZuwR4J1
	 GDkoXi8AfoSBRNTP7bkGHX/Q/R03HXCc3FMVaP6MvTUqcTGdocbgu45wkjypxPzcN0
	 nvfeffRLDZd4pzJ5GuxwPusoT+UNTezzkPAoLHmmOd878MAuQhzbhUvuH3nVmT+j4d
	 SVqUfK+GqUSGROd/0notNiVooG4ovu2kW4UDXbbcLOJZq6F5l2d4vILa6oVpDbd2zh
	 GewACIpw6PoQA==
From: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
Date: Mon, 01 Jun 2026 13:10:00 +1000
Subject: [PATCH net 04/10] mptcp: allow subflow rcv wnd to shrink
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260601-net-mptcp-misc-fixes-7-1-rc7-v1-4-a5ae7791754b@kernel.org>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=2014; i=matttbe@kernel.org;
 h=from:subject:message-id; bh=xSUkA5awwabkeoOO2Z+2O7VW9WQAdaet1Zc/wMjFy4k=;
 b=owEBbQKS/ZANAwAIAfa3gk9CaaBzAcsmYgBqHPge66MHbxdL/cpv//lR6JnE94nIvP4gCuVCL
 ceKw8x0iCCJAjMEAAEIAB0WIQToy4X3aHcFem4n93r2t4JPQmmgcwUCahz4HgAKCRD2t4JPQmmg
 c/hsEADauF2av4TeDvZXGrYhyOXt3zCLLk4W0JIP/z/obS+TZqUvR2YDZSeC2ESoE6uITeNR2Cr
 BCkyZ2Tmp6TTVpSD1J+8smGIw4m7dLxouL4/nWPLpAZ0WaYHBclvIrET+4RkKoqDXXq9RbnVBXx
 xy7KS48+zCD0Xh20m1LT3k27jJG4DNg3ZR7nOj2Fa1mXOxRUXZ5eBDNR7nf3C/9MK26o01kTHgk
 a2WUZRXVyL77iy2uEXapR4//ykUCxrYIynQH8GCG0qrNkTd0Ntehfsqi1fePcOuYGpW98+dlpw0
 d9ffGGuDUXdVqWqdFsn/4ly17k46CQsvksWbdXEFcBS7wWf6Y6WxpPcuwq+uStaaRkZVgtUkjOm
 SGcSVHURqt1O8BHc91h2vSzep+GZGijvc+TAuhy+7a3UNJLAWmIr1c/geSpAzCMRmXWCxAKQOW2
 nooeyFjtRb6kMjpdDb1BgFz+WIcWFW3WzjGgxxVGXor4DbYKS7JAhS+/EHm3hAUZZfoxJEQsDre
 7+JTPLBBVjl8HsL2njnZYFjHCQ3oBi+gT6582A1gCZUyPx+Nbs8NrKBKXBnuJdq3MqEEb1w2IBL
 f6k+Ak5N6D6oOpihApEMX6AUYQX6/aB3ndKBnYcKeASXim9sd9Z4qp1UVP9KH3w1TtMUUpEx7uh
 kmNmMc6WD89Lplw==
X-Developer-Key: i=matttbe@kernel.org; a=openpgp;
 fpr=E8CB85F76877057A6E27F77AF6B7824F4269A073

From: Paolo Abeni <pabeni@redhat.com>

In MPTCP connection, the `window` field in the TCP header refers to the
MPTCP-level rcv_nxt and it's right edge should not move backward. Such
constraint is enforced at DSS option generation time.

At the same time, the TCP stack ensures independently that the TCP-level
rcv wnd right's edge does not move backward. That in turn causes artificial
inflating of the MPTCP rcv window when the incoming data is acked at the
TCP level and is OoO in the MPTCP sequence space (or lands in the backlog).

As a consequence, the incoming traffic can exceed the receiver rcvbuf size
even when the sender is not misbehaving.

Prevent such scenario forcibly allowing the TCP subflow to shrink the
TCP-level rcv wnd regardless of the current netns setting.

Fixes: f3589be0c420 ("mptcp: never shrink offered window")
Cc: stable@vger.kernel.org
Signed-off-by: Paolo Abeni <pabeni@redhat.com>
Reviewed-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
Signed-off-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
---
 net/mptcp/options.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/net/mptcp/options.c b/net/mptcp/options.c
index 5c228344e83f..12cbd98c7111 100644
--- a/net/mptcp/options.c
+++ b/net/mptcp/options.c
@@ -566,6 +566,7 @@ static bool mptcp_established_options_dss(struct sock *sk, struct sk_buff *skb,
 {
 	struct mptcp_subflow_context *subflow = mptcp_subflow_ctx(sk);
 	struct mptcp_sock *msk = mptcp_sk(subflow->conn);
+	struct tcp_sock *tp = tcp_sk(sk);
 	unsigned int dss_size = 0;
 	struct mptcp_ext *mpext;
 	unsigned int ack_size;
@@ -614,6 +615,12 @@ static bool mptcp_established_options_dss(struct sock *sk, struct sk_buff *skb,
 	if (dss_size == 0)
 		ack_size += TCPOLEN_MPTCP_DSS_BASE;
 
+	/* The caller is __tcp_transmit_skb(), and will compute the new rcv
+	 * wnd soon: ensure that the window can shrink.
+	 */
+	if (skb)
+		tp->rcv_wnd = tp->rcv_nxt - tp->rcv_wup;
+
 	dss_size += ack_size;
 
 	*size = ALIGN(dss_size, 4);

-- 
2.53.0

