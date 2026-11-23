Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795440345;
	b=SQZzidJZUzwE6OwZNjVMowGbz1hhSOYBBhMXX7f3n5Jl+p3VW7+mTg6uJqtkQB0Zp0A1
	 UUyzAgGx75n6MtkxOKbgWXW8lB13GQ54TICYz1Lm44xaFHwUc8ScuODGL6Bp6HK+3a6GU
	 vPiufbUh19h/OIxT/NRJb3zDPAquN1JelIZJ2y4iZamFZ7da+DchtA4WDW1bavEoiMzX5
	 bsrD4v6PgaI+BwSmO7ub1gjPBcbdEViIMMBLH37bxy0R1Am5Q3sUBrJW+/P0eE5hNGX57
	 V8GMCxO8eYVhHvMAMH9ptLkQw753Gk9M2WYP9ZGG9RNxsJJKtzrt+UTvcwWublg2f8w==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795440345;
	h=Received:DKIM-Signature:From:Date:Subject:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:Message-Id:References:In-Reply-To:To:Cc:
	 X-Mailer:X-Developer-Signature:X-Developer-Key;
	bh=dhOl6SMJcFEgG7JjGFeImeI+0PoTpGZsESAagy7OtWc=;
	b=0Mg8Ujm75xf8uQGqnpThXKbEBhAYlGD8vHIQQdyK8MC4IEBTfccFhhxN68AhczVIyG1E
	 XWwxGhylawuXkBzx9TlxN/dYdn/8dGGIJwwmbPaOJ5r7P96ptzh0iXFjxNY3PCFkH6znv
	 pKJLWOBnY5Zvjp28eoWl9nEdnaRltNNZ678q3hjjsb9QBWgxjQIpsJ2L5hHLKnZd861t9
	 Ob7Q+oVA052ZMMSt9rt43RNCfUTIL6dyUguqJNrKHKzZN3PKlk3Yrqol3NAYzmdX4cT69
	 aED/DHQ8hUB8uqtHpOGTky8VmPmfhzyVrC73DZhtWiXRGGlA3Q0Ii9t3ZilU6Qr2Tsw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=YOYCJAT+;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 56BB4606A69A;
	Mon, 23 Nov 2026 13:25:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=YOYCJAT+
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B25061F000EB;
	Mon, 23 Nov 2026 13:25:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795440345;
	bh=dhOl6SMJcFEgG7JjGFeImeI+0PoTpGZsESAagy7OtWc=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc;
	b=YOYCJAT+1au2FoXWFlgrCw8LuyylzV6LeFXo3/9Ver4d4Qys5WFL0AYiWDwigGzGf
	 60wyZinnE1F7aSIg1MjpOfLqNIZOHuCNoEFYtkWzdbGLqXFy/VHa9OPVQ0p3iN78yH
	 IcYtI3Ms67bBiDVGsdEQeQvgfS4iHAZ/YZxidtYc1MP2pHYLW6wDirVsYbp9qGB2h7
	 6vq0vydldoe2kivfymszceP78Zj23JjsS22V3ufm4Nri9+cFn3hOb+oe2M2FK3k9yV
	 ILNip26Zr83bii0A1Jd8jAR7q8FNtRJJioyyQ+qL9qcAlXKiuyxssqW0LPwX8fenC3
	 vM06DyFd/rziQ==
From: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
Date: Mon, 23 Nov 2026 14:24:54 +0100
Subject: [PATCH net 06/10] mptcp: don't leak an orphan when the PM closes
 its last subflow
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
Message-Id: <20261123-net-mptcp-misc-fixes-7-4-rc5-v1-6-278042217e8d@kernel.org>
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
 "Matthieu Baerts (NGI0)" <matttbe@kernel.org>, stable@vger.kernel.org
X-Mailer: b4 0.16.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=3178; i=matttbe@kernel.org;
 h=from:subject:message-id; bh=idSA9++hWiOgEzQLbsTV71c4EwKKNFxFmkF/eqUJWig=;
 b=owGbwMvMwCVWo/Th0Gd3rumMp9WSGLJZ7PZYdN+e6PHmqsaK7teiz+pNHCMjm/tC3y6sLHVZF
 iK1LONoRykLgxgXg6yYIot0W2T+zOdVvCVefhYwc1iZQIYwcHEKwESC4xn+6bSU3/6/tGHnP+65
 E8SufnwwQ/bRssNF89d/SFTK2NxbbcLIcJQj4c52j/KT29bk1bD9PXZBu3G24/O7PMKe29/ciXu
 2kgUA
X-Developer-Key: i=matttbe@kernel.org; a=openpgp;
 fpr=E8CB85F76877057A6E27F77AF6B7824F4269A073

Once close() has returned, an orphaned MPTCP socket is only destroyed by
mptcp_worker(), in the run that sees it in TCP_CLOSE: later on, the
worker returns at once for an msk in this state, and
mptcp_schedule_work() no longer queues it.

__mptcp_close_ssk() moves an orphan to TCP_CLOSE when, after the closure
of a subflow, only the initial one remains, and it is closed. This
function is not only called by the worker: path manager commands also
close subflows of any msk of the netns, orphans included, under the msk
lock: e.g. 'ip mptcp endpoint delete' or 'flush' with the in-kernel PM,
or MPTCP_PM_CMD_SUBFLOW_DESTROY with the userspace one. In this case,
nothing destroys the orphan: it stays in TCP_CLOSE until the reboot,
with its token, its initial subflow, and its reference to the netns,
which is then never freed.

This can happen when the initial subflow has been reset or has timed
out, and the connection is closed -- the orphan then waits for the end
of the DATA_FIN exchange, up to TCP_TIMEWAIT_LEN -- before the endpoint
used by another subflow is removed, e.g. when an interface goes down.

Only the worker can close an orphan, as it must then destroy it. So
here, mark its close timeout as expired, and queue the worker, like it
is done for an msk in the accept queue. The worker then closes the
orphan with mptcp_do_fastclose() -- nothing is sent: the only subflow
left is closed -- and destroys it. If __mptcp_close_ssk() was called by
the worker, this happens later in the same run.

This issue has been found by an AI code review agent, while reviewing
the code of the commit "mptcp: leave an orphan's DATA_FIN to the
worker", and confirmed with a new Packetdrill test: the initial subflow
of an orphan waiting for the end of the DATA_FIN exchange is reset, then
the endpoint of the other subflow is removed. Without this patch, the
orphan stayed:

  UNCONN 0      0      192.168.0.1:8080 192.0.2.1:39933
  kernel_orphan_last_subflow.pkt:39: error executing `! ss -HMan | grep -v LISTEN` command: non-zero status 1

Fixes: 27e5ccc2d5a5 ("mptcp: fix dangling connection hang-up")
Cc: stable@vger.kernel.org
Signed-off-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
---
 net/mptcp/protocol.c | 9 +++++++--
 1 file changed, 7 insertions(+), 2 deletions(-)

diff --git a/net/mptcp/protocol.c b/net/mptcp/protocol.c
index 17451240c105..5339fd6a8d81 100644
--- a/net/mptcp/protocol.c
+++ b/net/mptcp/protocol.c
@@ -2744,8 +2744,13 @@ static void __mptcp_close_ssk(struct sock *sk, struct sock *ssk,
 	 */
 	if (list_is_singular(&msk->conn_list) && msk->first &&
 	    inet_sk_state_load(msk->first) == TCP_CLOSE) {
-		if (sk->sk_state != TCP_ESTABLISHED ||
-		    msk->in_accept_queue || sock_flag(sk, SOCK_DEAD)) {
+		if (sock_flag(sk, SOCK_DEAD)) {
+			/* let the worker close and destroy the orphan */
+			mptcp_set_close_tout(sk, tcp_jiffies32 -
+					     (mptcp_close_timeout(sk) + 1));
+			mptcp_schedule_work(sk);
+		} else if (sk->sk_state != TCP_ESTABLISHED ||
+			   msk->in_accept_queue) {
 			mptcp_set_state(sk, TCP_CLOSE);
 			mptcp_close_wake_up(sk);
 		} else {

-- 
2.55.0

