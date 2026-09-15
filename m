Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8D0354D0A17;
	Tue, 15 Sep 2026 20:37:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789504672; cv=none; b=Cba+T033q6hiArBQ80VkZ+oTLfMCjvbVQ9W2qYbAUYNdEOXExSK1VKEkc93TAPDun/nrgNnC0N54WGSe1VYFizLPT3dYjxWCWak7XmxVggE3eI9LTqFJj8aHhQjDpDJ58UIA/jICZWEk/EpCidzGCzsEWSBRDUMoZUgrlVEC4K4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789504672; c=relaxed/simple;
	bh=Ch9axBupHZE1+mazYa0QKUB5rUQp0AQp4VygAP5hlis=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=qA1Oq1mQ63GFzi1W0HdzG1287mKwbWJQFs3WBi+x/AAHJm3a/iiUn+PaEt35YvIUR42V3Pa1bQAy80oS7yzysZ2RnzC0NgkZWn/vg5gw7A/2omyugK8ZbtHmie40rmmG8IE9irrib4vHEKYOQLE5zV7qfuIKgvoThxHEd9jfxBk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=cKXhdI59; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="cKXhdI59"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4C74C1F00898;
	Tue, 15 Sep 2026 20:37:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789504667;
	bh=+o+TE1sP/I26jYccCYsrcdOwqm+lL5lJjZTCPLtUlzg=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc;
	b=cKXhdI59oWn6BKDbUuDWVtk4DGANZ3gEp5pVwdhA92H2eN8ObJ3cq8nbKHjNfHjX9
	 LTSHFnh3I38HZ0bXudUPjTgaGJb9U+U/mj85zILgNuCxO+g9/c5grZyHPQuh5K/MMl
	 vJNAIFa70EX31AtwECQFsyMD4Nu+vks6sO61u/wCwfZ1bOWbYXzXDLYnQlqrCI7pHX
	 mXekMdMGW65Nwhy5HvDAhKtKOy6NzQsrPEtFw4ZOkiTQm9o3J6TVQFV/ojJGb1A2rO
	 UWHWtNY0i4psy0nwKv95Mlu66M8P9vG7Rot42EHgCx1jXOboK8LYByqhoclDiBW2E1
	 xLn3LPrkx88hg==
From: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
Date: Tue, 15 Sep 2026 22:37:32 +0200
Subject: [PATCH net 1/2] mptcp: avoid unneeded actions on subflow reset
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260915-net-mptcp-misc-fixes-7-3-rc4-v1-1-a257797dd5d0@kernel.org>
References: <20260915-net-mptcp-misc-fixes-7-3-rc4-v1-0-a257797dd5d0@kernel.org>
In-Reply-To: <20260915-net-mptcp-misc-fixes-7-3-rc4-v1-0-a257797dd5d0@kernel.org>
To: Mat Martineau <martineau@kernel.org>, Geliang Tang <geliang@kernel.org>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 Simon Horman <horms@kernel.org>
Cc: netdev@vger.kernel.org, mptcp@lists.linux.dev, 
 "Matthieu Baerts (NGI0)" <matttbe@kernel.org>, stable@vger.kernel.org, 
 Xinyang Ge <xinyang@anthropic.com>
X-Mailer: b4 0.16.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=2600; i=matttbe@kernel.org;
 h=from:subject:message-id; bh=cn0VYiy2CFtxBfVRI25WAt6f7vL649MXEnqMpjnZGKA=;
 b=owGbwMvMwCVWo/Th0Gd3rumMp9WSGLJWrpkqffHY9+qLyux3FELzp99qjn/cZLDFZZ70zc0RK
 S4KSxrWdZSyMIhxMciKKbJIt0Xmz3xexVvi5WcBM4eVCWQIAxenAEzE+zvDP73XcZF3JE3sZgZz
 HlHwcX3qO7tKs/2JSdwL2WcHmKXDVBj++zNIP5yg2WVQcjX1guqOKNe9H6eG/mo2WPhDyGw6/+y
 t7AA=
X-Developer-Key: i=matttbe@kernel.org; a=openpgp;
 fpr=E8CB85F76877057A6E27F77AF6B7824F4269A073

From: Paolo Abeni <pabeni@redhat.com>

Once in a blue moon, the mptcp receive path can recursively call
mptcp_data_ready() via state change under unlucky error conditions, and
then try to hold the data lock again.

Break the recursion loop explicitly checking for the exceptional
condition.

Add a new flag instead of using an existing one like 'closing', to exit
early in subflow_state_change(). This avoids unneeded processing to
check for available data -- calling get_mapping_status() and more on a
dying subflow -- but also in error reporting and worker scheduling.

Fixes: e32d262c89e2 ("mptcp: handle consistently DSS corruption")
Cc: stable@vger.kernel.org
Reported-by: Xinyang Ge <xinyang@anthropic.com>
Signed-off-by: Paolo Abeni <pabeni@redhat.com>
Reviewed-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
Signed-off-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
---
 net/mptcp/protocol.h | 3 ++-
 net/mptcp/subflow.c  | 8 ++++++++
 2 files changed, 10 insertions(+), 1 deletion(-)

diff --git a/net/mptcp/protocol.h b/net/mptcp/protocol.h
index 2b4c27426477..0384d6a023f9 100644
--- a/net/mptcp/protocol.h
+++ b/net/mptcp/protocol.h
@@ -585,7 +585,8 @@ struct mptcp_subflow_context {
 		is_mptfo : 1,	    /* subflow is doing TFO */
 		close_event_done : 1,       /* has done the post-closed part */
 		mpc_drop : 1,	    /* the MPC option has been dropped in a rtx */
-		__unused : 9;
+		resetting : 1,	    /* subflow is resetting */
+		__unused : 8;
 	bool	data_avail;
 	bool	scheduled;
 	bool	pm_listener;	    /* a listener managed by the kernel PM? */
diff --git a/net/mptcp/subflow.c b/net/mptcp/subflow.c
index 01db7edce18a..cbe227d21844 100644
--- a/net/mptcp/subflow.c
+++ b/net/mptcp/subflow.c
@@ -438,6 +438,7 @@ void mptcp_subflow_reset(struct sock *ssk)
 	/* must hold: tcp_done() could drop last reference on parent */
 	sock_hold(sk);
 
+	subflow->resetting = 1;
 	mptcp_send_active_reset_reason(ssk);
 	tcp_done(ssk);
 	if (!test_and_set_bit(MPTCP_WORK_CLOSE_SUBFLOW, &mptcp_sk(sk)->flags))
@@ -1883,6 +1884,13 @@ static void subflow_state_change(struct sock *sk)
 
 	__subflow_state_change(sk);
 
+	/* Rx queue processing is unneeded, error reporting will take place at
+	 * __mptcp_close_ssk() time and subflow reset can't happen in case of
+	 * fallback: subflow_sched_work_if_closed() would be a no-op.
+	 */
+	if (subflow->resetting)
+		return;
+
 	/* as recvmsg() does not acquire the subflow socket for ssk selection
 	 * a fin packet carrying a DSS can be unnoticed if we don't trigger
 	 * the data available machinery here.

-- 
2.55.0

