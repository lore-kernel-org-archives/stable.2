Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794274125;
	b=1LrMsGE55GJ9sfun2biSSZR7XNX7pWRpqU5oSRvrbsxLrxhdu/xxDw+YV3fNpfahOTCx
	 cdeU/1mDAiLlGqhEZNVc5MQ6zPpNK99PdKtjbs+XAMoV5W8nDxDxVLfW4s3faTiP6DYSW
	 FPmXEiok+aUe8D091TXHGtPoSuoZuI89EqG9C6DeR/SiTuDdtSkpJL4Vb6fkcWQ5f+f67
	 t0+orXQeMuoa9RheDYwnbC4my4jktzSmzMzPqvdy3aArfHTtdYmovs5sHG240syLddNbW
	 uy6Doja0mCBXynyrwIoNMP/nnDQZfb9K+KCQl4OSzBEVicuE1Vyhi6zpa9u3/x92Rpg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794274125;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 MIME-Version:Content-Type:Content-Transfer-Encoding;
	bh=/5SN+t2rmlDLG+H/6rx8meMDtvS8HtWR4nQJlFRoJzY=;
	b=e23AOZW2t8B1mPK1lsb9XWWWt/rH2n1ybcykZZgCTKpOu9nzhW8LqtIGnbbabDQ/pdmA
	 u3dLe8OIjvJ/Azx+JzIVmmQm9TA3YRaYbWvUSpWEGnPfPx07K3rQTzHFgqE3FIFz6A6HT
	 Fs/ztmmwSA34kIxXmmmv8/euusekxHNTOkViISCXBKK7oFFf4KO1e4922JAbvIdSYBwVw
	 oUPFdIpJ5kpWtJZnZ9cVSt/lq97HM56SCSpB+mX3ueLM8uQH0Qkd7qksYnAvvaZvKzC9A
	 GYfgnpmJflPWe7rvDReHLMgyq2dgKQb/hRI6MYkdYbWGgDtYv4q4kzSeEcGgF0ncusw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=jb7XwY8i;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9ECDF606A31C
	for <stable@vger.kernel.org>; Tue, 10 Nov 2026 01:28:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=jb7XwY8i
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C39E01F0089F;
	Tue, 10 Nov 2026 01:28:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794274125;
	bh=/5SN+t2rmlDLG+H/6rx8meMDtvS8HtWR4nQJlFRoJzY=;
	h=From:To:Cc:Subject:Date;
	b=jb7XwY8iSb/9oaV5RWaUN9nj523TMLxvFX1OYa+eIrgqqAv5BtQ4co0lqDjR3B3C3
	 h+YcyVLEg3i8xinq6eq3rTKsgiCF/TgfyRTqpNzdc9bx54CS3srHgYVgrH1OJeI/Dy
	 B8hTetEFF5vcUBgwJFhJIpV9u4BrTMCJtayohcNV+iA0EWDFReqmFQdgQ1obTuSLxg
	 FUwOVNQ2rK5KtWJQtpas0tNy5rL0aMRcZ/0r/viRakDQk7kYRkfCOJdPHvxT6q4oZt
	 EZiQli8Eaeh7eJNlNjigmXrDn9RHGIqRM4jEARY1PIOrEFZ7oFsbfSlfUz8N5mLOvs
	 lCE/b9CPMv7Bg==
From: Sasha Levin <sashal@kernel.org>
To: yilinzhang@moonshot.ai,
	bug-report@moonshot.ai,
	jiayuan.chen@linux.dev,
	pabeni@redhat.com,
	matttbe@kernel.org
Cc: stable@vger.kernel.org
Subject: FAILED: patch "[PATCH] mptcp: do not use Fast Open on MP_JOIN subflows" failed to apply to 5.10-stable tree
Date: Mon,  9 Nov 2026 20:28:43 -0500
Message-ID: <20261109202843-failed-5.10-6d2cf411aba2@kernel.org>
X-Mailer: git-send-email 2.53.0
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

The patch below does not apply to the 5.10-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-5.10.y
git checkout FETCH_HEAD
git cherry-pick -x 6d2cf411aba2aa0bd641b49be5b1964ac5097a50
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '20261109202843-failed-5.10-6d2cf411aba2@kernel.org' --subject-prefix 'PATCH 5.10.y' 'HEAD^..'

Thanks,
Sasha

------------------ original commit in Linus's tree ------------------

From 6d2cf411aba2aa0bd641b49be5b1964ac5097a50 Mon Sep 17 00:00:00 2001
From: Yilin Zhang <yilinzhang@moonshot.ai>
Date: Fri, 30 Oct 2026 23:03:51 +0100
Subject: [PATCH] mptcp: do not use Fast Open on MP_JOIN subflows

tcp_fastopen_create_child() hands the SYN packet itself to
subflow_syn_recv_sock(). For an MP_JOIN request this takes the
fatal fallback: the cloned child is destroyed and handed back with
drop_req flagged, but tcp_fastopen_create_child() does not check
the flag and queues it, so accept() can expose the freed child.

MP_JOIN cannot use Fast Open: data on a subflow requires the
completed HMAC exchange (RFC 8684, sec. 3.2). Refuse it (only the
TFO path passes a SYN skb here) and let tcp_conn_request() fall
back to the regular MP_JOIN handshake; also strip the Fast Open
cookie from MP_JOIN SYN/ACKs.

Fixes: 90bf45134d55 ("mptcp: add new sock flag to deal with join subflows")
Cc: stable@vger.kernel.org
Reported-by: Kimi Security Team <bug-report@moonshot.ai>
Suggested-by: Jiayuan Chen <jiayuan.chen@linux.dev>
Suggested-by: Paolo Abeni <pabeni@redhat.com>
Signed-off-by: Yilin Zhang <yilinzhang@moonshot.ai>
[ Moving code to avoid clearing TS and consolidating checks. ]
Signed-off-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
Link: https://patch.msgid.link/20261030-mptcp-tfo-mpj-v4-1-e6eff2027342@kernel.org
Signed-off-by: Paolo Abeni <pabeni@redhat.com>
---
 net/mptcp/subflow.c | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/net/mptcp/subflow.c b/net/mptcp/subflow.c
index 78e886b202585..00677fb3efcdc 100644
--- a/net/mptcp/subflow.c
+++ b/net/mptcp/subflow.c
@@ -379,6 +379,10 @@ static void subflow_prep_synack(const struct sock *sk, struct request_sock *req,
 	struct mptcp_subflow_context *subflow = mptcp_subflow_ctx(sk);
 	struct inet_request_sock *ireq = inet_rsk(req);
 
+	/* MP_JOIN cannot use TFO, do not send a cookie in the SYN/ACK */
+	if (foc && mptcp_subflow_rsk(req)->mp_join)
+		foc->len = -1;
+
 	/* clear tstamp_ok, as needed depending on cookie */
 	if (foc && foc->len > -1)
 		ireq->tstamp_ok = 0;
@@ -887,6 +891,13 @@ static struct sock *subflow_syn_recv_sock(const struct sock *sk,
 			fallback = true;
 
 	} else if (subflow_req->mp_join) {
+		/* a SYN skb here comes from TFO, which MP_JOIN cannot use: just
+		 * fall back to the regular path.
+		 */
+		if ((TCP_SKB_CB(skb)->tcp_flags & (TCPHDR_SYN | TCPHDR_ACK)) ==
+		    TCPHDR_SYN)
+			return NULL;
+
 		mptcp_get_options(skb, &mp_opt);
 		if (!(mp_opt.suboptions & OPTION_MPTCP_MPJ_ACK))
 			fallback = true;
-- 
2.53.0




