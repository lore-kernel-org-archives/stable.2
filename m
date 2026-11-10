Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794273863;
	b=fKd4jom/u/qk/ICXTdfQm3qPI16LQmhXeEjy2adCjseh770mBQOBQb36Qq5miS93Q/SD
	 7yLNmu0xabrb1/6MzVTcUNXksrQHbaE2yPjRGhSH31BHe0QE9QBd0XWaV9Q8opdzH5kiL
	 v4sx/pvlxym9/oJ5cbYOsYYlXLHSXxxDq5H1nZBRBLXRFijOCVuUifja0kDLKUTOUN+js
	 P0DTjR66osmohErAapucX3GsS/FM5N++iGCZM/k3J0fvkGAYSSy5sezOn8kAge1crBN7N
	 capXSCUQc/KV7UGmOLCKDOstZiVjhZGhcgnPVulPeCs2kgILiddaO02JKyeF+1m7NZA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794273863;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 MIME-Version:Content-Type:Content-Transfer-Encoding;
	bh=7cj9quH0yruZg2CGqm4Y0iwMerJuAbDx+pZro9VMP9k=;
	b=fe3Snz53IJhGgnSKodkW4j2HrfIox17Zior1PHTDfa3Ck8jeHMu0Vc17vJwmBv95rImW
	 RQgcdJrlu1APGIwSLaVCRLyyuzqR+Sk2gTseY/SK2fhWFirM9e2Aey57VLz7HWq3Qv3yn
	 R6Qf5z3NEla/QJ/1STpvN47xmW/LXwySU6+ujIZKSmwbqEhj2FG7OHsymQL8yThvQ19Sk
	 bVZDAgAneA5hbExvJ79lmCIeKnwHRyhAJrU0QfvGq2ltgJzXfgEhRPHH1AQo36AV1DK9Y
	 cwdD/tCnNLeZH7XHJ1PH5SpPJD4UYJ/MG2tae1PaUvVwu++/TJMOzDlQsRz0EYMeF4A==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=OpPPrO0P;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 52DEA60A381D
	for <stable@vger.kernel.org>; Tue, 10 Nov 2026 01:24:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=OpPPrO0P
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 773B41F0089F;
	Tue, 10 Nov 2026 01:24:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794273863;
	bh=7cj9quH0yruZg2CGqm4Y0iwMerJuAbDx+pZro9VMP9k=;
	h=From:To:Cc:Subject:Date;
	b=OpPPrO0Pgk0RjBoP3Pt/kyXcOXNe/K1obmYqEDnG+yFkA2ET9UCLS8xV9klNo2eXY
	 gjV+fGAXticIAwG+t98/9r5nd73hTlNHgiC5ybvn3aeOes1vsaSdQH692R2Ms0F8Tz
	 eLO0StK+gU7UiY3YNMhs9FNWCVvGyataYPhOZaw3lnF6adOKviXIbEXMzrMjBD9T1K
	 9OqatyBjQLhwEQSI3L26YPsXxwsEtY/SymU5+eBD9zcRG7sXRVcCqTCzC3q09e3Dl/
	 cwDCT/sCTFU1+hqveUXWrJBv5BIfrKtSQ1GnL0ouX5eeU75VAlh5bELXEcqN9dhau5
	 ZtfWj8O5zy6dw==
From: Sasha Levin <sashal@kernel.org>
To: yilinzhang@moonshot.ai,
	bug-report@moonshot.ai,
	jiayuan.chen@linux.dev,
	pabeni@redhat.com,
	matttbe@kernel.org
Cc: stable@vger.kernel.org
Subject: FAILED: patch "[PATCH] mptcp: do not use Fast Open on MP_JOIN subflows" failed to apply to 5.15-stable tree
Date: Mon,  9 Nov 2026 20:24:21 -0500
Message-ID: <20261109202421-failed-5.15-6d2cf411aba2@kernel.org>
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

The patch below does not apply to the 5.15-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-5.15.y
git checkout FETCH_HEAD
git cherry-pick -x 6d2cf411aba2aa0bd641b49be5b1964ac5097a50
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '20261109202421-failed-5.15-6d2cf411aba2@kernel.org' --subject-prefix 'PATCH 5.15.y' 'HEAD^..'

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




