Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5D65733122A;
	Sat, 19 Sep 2026 19:56:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789847819; cv=none; b=D6hyZUmGwQN8vXhWx5RnR2MOAA4bTqK1/MzuBqyzKky0EVWrXZTvYnv53RaBHKuenEZ/b1noTg+F7Nsr9sjwNOWGoSQMYeMfZTouQwqev9lypKh+WQ+LgmSbJkQ0ZmnKleVrvT1A8ftBEQDJT/WirLpVvwYR7GWjXHeieUgloP0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789847819; c=relaxed/simple;
	bh=pGLpKsWWZHEgJzlaDIV+DTjXeBPIzL1OgOIVS0C9GR4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Rmv4f+/fJBB0C6HeDlTRTSiduaXZR/Z8m+CNKB+MkqED2UUwAXg9WcF8i+nQGHJMofM0CqEi93gcvWxrGXs15wn206IL1KIN8shk/7utyMETslNrGltxJq4UWC3krOAa+/J/HmoW9lMvDo+cMz2vt8BlSOWgCRG16KmfEN+X9x8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=f6MF0qQm; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="f6MF0qQm"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F2D0E1F00893;
	Sat, 19 Sep 2026 19:56:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789847816;
	bh=eE6XX+yaNM954WMOmqfQTOWWRu6GiUdVHiB01E/7LAQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=f6MF0qQmwio6t7yJMpOp5rGbwUwhSP8ech1qAu3xwazEDyS7fdAvKgdDgv3krl20g
	 BcGUiPnr/O3jtBnJbCeq0pbjt3D4O2ekONtT8Oj/iZTbp2XasvBgu5eLt+WnBCMoLl
	 pAnSN3gixdnP4bX7H+rpXqi6J5fix7Y2kHJ4p7SSIbTU551cRy3L0QBt7ywUbYL698
	 eLlLrcaTzsAt7pVRVuV2oFWQPlBS394vSfpmM4y0HKZNa69ARpnHfGuAayq1tuhR/7
	 QxJVeWZwn8e0ebDXEVyUtD/NwxoYGy2GER0pbkMYXB9dBy1lO4IODqv4EatHvZXRNo
	 1fk3tZfJ5qZsg==
From: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
To: mptcp@lists.linux.dev,
	stable@vger.kernel.org,
	gregkh@linuxfoundation.org
Cc: Paolo Abeni <pabeni@redhat.com>,
	sashal@kernel.org,
	"Matthieu Baerts (NGI0)" <matttbe@kernel.org>,
	Jakub Kicinski <kuba@kernel.org>
Subject: [PATCH 6.12.y 2/5] mptcp: remove unneeded READ_ONCE() annotation
Date: Sat, 19 Sep 2026 21:56:45 +0200
Message-ID: <20260919195642.1977885-9-matttbe@kernel.org>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260919195642.1977885-7-matttbe@kernel.org>
References: <20260919195642.1977885-7-matttbe@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=2487; i=matttbe@kernel.org; h=from:subject; bh=zFMRbwkAqOiVyRygY2AAMK/aVZaI+rC9wn7I23Kj0fU=; b=owGbwMvMwCVWo/Th0Gd3rumMp9WSGLLWvfjrZOMkGWFhHLDkzDEH8XaNtKvfF3y+vOR6wGJ5o XCOS/tUOkpZGMS4GGTFFFmk2yLzZz6v4i3x8rOAmcPKBDKEgYtTACYysZWRYUWm0KInvVZxjfZC u+ZuzneJumfyppT7wonbTcuDDEJ9OxgZnnmatn2++6iHNaXDhGWfVFjt7edx+7SWhx52/lu5ccc NFgA=
X-Developer-Key: i=matttbe@kernel.org; a=openpgp; fpr=E8CB85F76877057A6E27F77AF6B7824F4269A073
Content-Transfer-Encoding: 8bit

From: Paolo Abeni <pabeni@redhat.com>

commit caa4a79f74f32084ce28aee8653bc04df745970d upstream.

The subflow->fully_established flag is always written under the subflow
socket lock. Reading such value under the same lock does not require any
ONCE annotation.

Fixes: 581c8cbfa934 ("mptcp: annotate data-races around subflow->fully_established")
Signed-off-by: Paolo Abeni <pabeni@redhat.com>
Reviewed-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
Signed-off-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
Link: https://patch.msgid.link/20260908-net-mptcp-misc-fixes-7-3-rc1-v2-10-df1de70348b6@kernel.org
Signed-off-by: Jakub Kicinski <kuba@kernel.org>
Stable-dep-of: 2b0f561f21b2 ("mptcp: avoid unneeded actions on subflow reset")
Signed-off-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
---
 net/mptcp/options.c  | 4 ++--
 net/mptcp/protocol.c | 2 +-
 2 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/net/mptcp/options.c b/net/mptcp/options.c
index 123c3691833f..d238dd374ce9 100644
--- a/net/mptcp/options.c
+++ b/net/mptcp/options.c
@@ -532,7 +532,7 @@ static bool mptcp_established_options_mp(struct sock *sk, struct sk_buff *skb,
 		return false;
 
 	/* MPC/MPJ needed only on 3rd ack packet, DATA_FIN and TCP shutdown take precedence */
-	if (READ_ONCE(subflow->fully_established) || snd_data_fin_enable ||
+	if (subflow->fully_established || snd_data_fin_enable ||
 	    subflow->snd_isn != TCP_SKB_CB(skb)->seq ||
 	    sk->sk_state != TCP_ESTABLISHED)
 		return false;
@@ -999,7 +999,7 @@ static bool check_fully_established(struct mptcp_sock *msk, struct sock *ssk,
 	/* here we can process OoO, in-window pkts, only in-sequence 4th ack
 	 * will make the subflow fully established
 	 */
-	if (likely(READ_ONCE(subflow->fully_established))) {
+	if (likely(subflow->fully_established)) {
 		/* on passive sockets, check for 3rd ack retransmission
 		 * note that msk is always set by subflow_syn_recv_sock()
 		 * for mp_join subflows
diff --git a/net/mptcp/protocol.c b/net/mptcp/protocol.c
index a4054ed24605..2f34e92d9cce 100644
--- a/net/mptcp/protocol.c
+++ b/net/mptcp/protocol.c
@@ -3685,7 +3685,7 @@ static void schedule_3rdack_retransmission(struct sock *ssk)
 	struct tcp_sock *tp = tcp_sk(ssk);
 	unsigned long timeout;
 
-	if (READ_ONCE(mptcp_subflow_ctx(ssk)->fully_established))
+	if (mptcp_subflow_ctx(ssk)->fully_established)
 		return;
 
 	/* reschedule with a timeout above RTT, as we must look only for drop */
-- 
2.55.0

