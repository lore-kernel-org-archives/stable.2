Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795440341;
	b=LZZHARUUvA5r6fhT0xdlXmqAETHAVci9F4C5hz+PZKUismYFf/oSQNqmaB+ro1vPUmUr
	 iip8XD364t9nlb1SWf+b91YfI+vm/rPkj/P7vB8E5u5njQm6AdSsdcjhP6IBorheXkc2Q
	 LKeVa91Q+zBbJo/8l9DPjW066F+a5FbHuPaGiG7G4EQA6SoZ/L2ZA8DYTLe0e0CXG9iJK
	 +M/We9QLZpdBNlbEa05vIjQZKmuc2XllY+nFpsC5YMEuv3W1k68sJvkb0H9hOAEpcCsz8
	 QXuqQyaRi6Ml+DNk74ry0Ow6zYr9whDzFAmHkOCCirJWs/H9HbkKO7vaSHh6s5+JPqQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795440341;
	h=Received:DKIM-Signature:From:Date:Subject:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:Message-Id:References:In-Reply-To:To:Cc:
	 X-Mailer:X-Developer-Signature:X-Developer-Key;
	bh=5yQazAnRvUhL1YPWsEfIdEVVovgootntAdurk94OIqg=;
	b=2hNgaxdOFzCiSHN87rNym8Vvx1V+zdsqW5RpGAu69oVU2cpqD2HEMPWW/6M+LSZaVn10
	 UjmirbC3Vdcw4782n81qpw/Azm/QigcpzPq2cy/2iMwUn4TWFthjVUbfJKgd1bM0bHo/H
	 Eg+3yoOe0lL1xETNLl7/MFvg4XlE7OPCmjpbaVuxQUJvKOCtd9zwWj7Rqu67cxXsc/815
	 Hj3fzUUXPk6RZ8/fmnwOSONPc+eMG0c5g/0QV5yegWgN1CQIA21qaTTeS/zyXz6vImG0x
	 anYxngvpI7TNUx/UNyiBMNhe5MERXwtrErfCZr2xFthoMxRj5sEREtitlQyOsYzwXxQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=RO0EorJX;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D025F606A685;
	Mon, 23 Nov 2026 13:25:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=RO0EorJX
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1AA5C1F0089E;
	Mon, 23 Nov 2026 13:25:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795440341;
	bh=5yQazAnRvUhL1YPWsEfIdEVVovgootntAdurk94OIqg=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc;
	b=RO0EorJXxcRkVcVfYhjOHzl/udxH2Snsi6TtPB3SUNCTNb5ucgUm5mvq7T9WKa6XM
	 k1AlPC6mc4M919tcH1/B2LoH+575+1jmZtQt4e3U+ppRl965CIjRbjsk33kI9p3xgq
	 DLvOmmrQcky9+Thwl3tTjkuyYf3Aw226+LbeTdCQnoGZ1C8M6KsT8CL2WSpk8AIsi2
	 2ZT3gqB7gih/FjXsogxsJ5lLQHrjmAJ9CpkDO98U8FmqXkgZvWkKumIo4QW3BfyEnm
	 u1zwickS/8cbuXjldh43vMSNCdEjh1rtc09TQiUE8sOW7eg8ZcEplNC4cWAjMmOQZS
	 k/pwn2qj8Y+fg==
From: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
Date: Mon, 23 Nov 2026 14:24:53 +0100
Subject: [PATCH net 05/10] mptcp: leave an orphan's DATA_FIN to the worker
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261123-net-mptcp-misc-fixes-7-4-rc5-v1-5-278042217e8d@kernel.org>
References: <20261123-net-mptcp-misc-fixes-7-4-rc5-v1-0-278042217e8d@kernel.org>
In-Reply-To: <20261123-net-mptcp-misc-fixes-7-4-rc5-v1-0-278042217e8d@kernel.org>
To: Eric Dumazet <edumazet@kernel.org>, 
 "David S. Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
 Paolo Abeni <pabeni@redhat.com>, Willem de Bruijn <willemb@google.com>, 
 Simon Horman <horms@kernel.org>, Mat Martineau <martineau@kernel.org>, 
 Geliang Tang <geliang@kernel.org>, Christoph Paasch <cpaasch@openai.com>, 
 Florian Westphal <fw@strlen.de>
Cc: netdev@vger.kernel.org, mptcp@lists.linux.dev, 
 Davide Caratti <dcaratti@redhat.com>, 
 "Matthieu Baerts (NGI0)" <matttbe@kernel.org>, 
 Chris Mason <mason@kernel.org>, stable@vger.kernel.org
X-Mailer: b4 0.16.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=3222; i=matttbe@kernel.org;
 h=from:subject:message-id; bh=XWQXbAqQ6Lz7CqdQOqSowGu9aekYFBuMgbNjjPTK0Zw=;
 b=owGbwMvMwCVWo/Th0Gd3rumMp9WSGLJZ7HbzLF97uPnC5/MveHYmPPq69PvfeX+MF7m8tXf3+
 3V0OU9xREcpC4MYF4OsmCKLdFtk/sznVbwlXn4WMHNYmUCGMHBxCsBEWi8y/DM/VPHT5+SSltaj
 AuwNs9KDRTubPVI7rsr+YVg6pe9z20yG/0E37fqsgwMWJR8s2cLSujd6zcT+dUUfOQ8ysM7X22H
 /nAEA
X-Developer-Key: i=matttbe@kernel.org; a=openpgp;
 fpr=E8CB85F76877057A6E27F77AF6B7824F4269A073

From: Chris Mason <mason@kernel.org>

Closed MPTCP sockets can leak until reboot, with the data in their
receive queues, which can exhaust tcp_mem and stall other TCP
connections.

Once close() has returned, only mptcp_worker() destroys an orphaned msk,
and only in the run that moves it to TCP_CLOSE: a later run returns at
once, and mptcp_schedule_work() queues no work for an msk in that state.
The receive path, in softirq, puts data on the backlog while the msk is
owned, and release_sock() calls mptcp_release_cb(), which passes the
backlog to __mptcp_move_skbs(). But __mptcp_move_skbs() calls
mptcp_check_data_fin(), which can move the msk to TCP_CLOSE, and by then
the lock owner, here the worker, no longer looks at the state:

    receive path, softirq             mptcp_worker()
    =====================             ==============
                                      not in TCP_CLOSE: no destroy
    last data, with the DATA_FIN
      the msk is owned: backlog
                                      release_sock()
                                        mptcp_release_cb()
                                          __mptcp_move_skbs()
                                            mptcp_check_data_fin()
                                              TCP_CLOSE, never destroyed

The fix used here is to queue the worker in __mptcp_move_skbs() if an
orphaned msk has a DATA_FIN to handle, instead of calling
mptcp_check_data_fin().

This issue has been found with the help of an LLM, and reproduced in a
VM, with the reproducer shared with the original version of this patch:
200,000 connections in which the server accept()s and close()s, while
the client reads the end of file, sends one byte, and closes. Without
this patch, some MPTCP sockets of the server stayed in the CLOSE state
for good, with their network namespace:

  === connections so far : MPTCP sockets of the server in the state CLOSE: 200000:722,
  [...]
  RESULT [...] | left 300 s behind the end: slab_MPTCP=722 sockets_MPTCP=722 [...]
  [...] | veth_end_left=1 slab_net_namespace_left=2 | [...]

Fixes: bc68b0efa1bf ("mptcp: move the whole rx path under msk socket lock protection")
Cc: stable@vger.kernel.org
Signed-off-by: Chris Mason <mason@kernel.org>
[ Shorter comment. Commit message: how the issue was found, and its
  symptoms. ]
Signed-off-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
---
 net/mptcp/protocol.c | 12 +++++++++---
 1 file changed, 9 insertions(+), 3 deletions(-)

diff --git a/net/mptcp/protocol.c b/net/mptcp/protocol.c
index 23d35f43b566..17451240c105 100644
--- a/net/mptcp/protocol.c
+++ b/net/mptcp/protocol.c
@@ -2312,9 +2312,15 @@ static bool __mptcp_move_skbs(struct sock *sk, struct list_head *skbs, u32 *delt
 	}
 
 	__mptcp_ofo_queue(msk);
-	if (moved)
-		mptcp_check_data_fin((struct sock *)msk);
-	return moved;
+	if (!moved)
+		return false;
+
+	/* Only the worker can close an orphan, as it must then destroy it */
+	if (!sock_flag(sk, SOCK_DEAD))
+		mptcp_check_data_fin(sk);
+	else if (mptcp_pending_data_fin(sk, NULL))
+		mptcp_schedule_work(sk);
+	return true;
 }
 
 static bool mptcp_can_spool_backlog(struct sock *sk, struct list_head *skbs)

-- 
2.55.0

