Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5617519E97B
	for <stable@vger.kernel.org>; Mon, 24 Aug 2026 23:50:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787615444; cv=none; b=moMjm8/vNlqmueZFFIMHYL+XWrHJr2vIgdgOydEA0cb6DxOOp1LSJlootQ/5odN0sPOz1icj9Xb4Vktdw/LVLcbBJY606RmftKxjFsrK/sHbJQP60U0PAs/r/PaKLeNEqHhTNIyGoxor67Ki5oqIZoXAKWhpP/GQB2xIeTwwRf4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787615444; c=relaxed/simple;
	bh=zL6xSR0U98Vyajxv3mZIN7xvMLiJK8KNz9GxD2oYefQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=EikLV/jOyFTE+poyu5j9OEzC3OwHs/LpUcIyz1kFicOFlCjIQpOlZHEdvQgYJEVdwvE4CMGOM42DzXJhSKccgOtPey0bziWCu/5LOQdLd4xillSuJOd2h151+/nF693jbryRXJYyREwm8A9WVgxEQtgc+JtGpgDk7fSoicHxCpI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=PwfcOn6s; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="PwfcOn6s"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5DA9F1F000E9;
	Mon, 24 Aug 2026 23:50:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1787615442;
	bh=2U2nf2T1vqdboEBJrEPNIc3JkVEpwevPz0cftAiTxO8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=PwfcOn6sZaU9aBzG0MZBmE2sbYNoRAKCnhWds90QPy40BGDyXB3Pjc0RU+vSaGiu3
	 ZSCv+TMRgIu709W7uDHsy4vCJeO0NH32W0d4wsDkZk1ET0oTTayHLEB6zOWTPhTfuX
	 UV9s9/M3kwfmOBHdcFJ8LSwhCHywAhYNDPJuVqqHTGfUPZ/cQrTSMmW4edMsWWafDW
	 eBTqyIMT3LzwmwSW0OweKH3+ZuqJN9MMSMvubWf6CW8kDG/1wqfRBfc6H/sT2dxZPF
	 n30krpQTY//53rKjZIyGIC9NrWbpF3s3Y7chs+ul2rGNfMy7ZREQquiM//fbd5CD4q
	 GtGKN4w/n+eSA==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>,
	Mat Martineau <martineau@kernel.org>,
	Jakub Kicinski <kuba@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.1.y 1/3] mptcp: pm: ADD_ADDR rtx: always decrease sk refcount
Date: Mon, 24 Aug 2026 19:50:38 -0400
Message-ID: <20260824235040.730038-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026082025-sitter-talisman-7358@gregkh>
References: <2026082025-sitter-talisman-7358@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>

[ Upstream commit 9634cb35af17019baec21ca648516ce376fa10e6 ]

When an ADD_ADDR is retransmitted, the sk is held in sk_reset_timer().
It should then be released in all cases at the end.

Some (unlikely) checks were returning directly instead of calling
sock_put() to decrease the refcount. Jump to a new 'exit' label to call
__sock_put() (which will become sock_put() in the next commit) to fix
this potential leak.

While at it, drop the '!msk' check which cannot happen because it is
never reset, and explicitly mark the remaining one as "unlikely".

Fixes: 00cfd77b9063 ("mptcp: retransmit ADD_ADDR when timeout")
Cc: stable@vger.kernel.org
Reviewed-by: Mat Martineau <martineau@kernel.org>
Signed-off-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
Link: https://patch.msgid.link/20260505-net-mptcp-pm-fixes-7-1-rc3-v1-4-fca8091060a4@kernel.org
Signed-off-by: Jakub Kicinski <kuba@kernel.org>
Stable-dep-of: a7aad5b69d3b ("mptcp: pm: fix data race in add_addr timer callback")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 net/mptcp/pm_netlink.c | 8 +++-----
 1 file changed, 3 insertions(+), 5 deletions(-)

diff --git a/net/mptcp/pm_netlink.c b/net/mptcp/pm_netlink.c
index 9a931c4a9cdc2..9f20c789cde53 100644
--- a/net/mptcp/pm_netlink.c
+++ b/net/mptcp/pm_netlink.c
@@ -309,11 +309,8 @@ static void mptcp_pm_add_timer(struct timer_list *timer)
 
 	pr_debug("msk=%p\n", msk);
 
-	if (!msk)
-		return;
-
-	if (inet_sk_state_load(sk) == TCP_CLOSE)
-		return;
+	if (unlikely(inet_sk_state_load(sk) == TCP_CLOSE))
+		goto exit;
 
 	bh_lock_sock(sk);
 	if (sock_owned_by_user(sk)) {
@@ -357,6 +354,7 @@ static void mptcp_pm_add_timer(struct timer_list *timer)
 
 out:
 	bh_unlock_sock(sk);
+exit:
 	__sock_put(sk);
 }
 
-- 
2.53.0

