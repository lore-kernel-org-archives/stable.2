Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8A2CB28B7DA
	for <stable@vger.kernel.org>; Tue, 25 Aug 2026 11:24:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787657075; cv=none; b=e6bzoBFniwfjPkrbLEGTuzSNitgjC2CK08suBMwuIZQEwtvxcvXlFQ3G8CQ6sN5Cxu81GkNuoKlo26OqOsKLNkQ21nCymFejFSK28yWz2ZtVaQdHd4NMGtTeLIKFh4RbtVxSyXkm7VienbzmAshdvUb4Kqpo5UuECn2ORbGfrW8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787657075; c=relaxed/simple;
	bh=jBZw5CmNJM+rDwkqsKfulR1l8p1oBJMISbeWqZfgMBo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=SjqvpRZ65Aa8GD32SQ35PfKwv4gbSY1hTNj2LYj2CY0+mK2zE9xLTpBb2n/ilmSTO7S0fA8+Vk/ogpS2XaDGd/W8tRruqkpCseEo31EWsmInbTAuu017VNjrL2OFfDOv0zagHxM+Oqdfg9jOJzGrbBK289cBfpg0N78hBiGyLoY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=bUXQvPia; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="bUXQvPia"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2D1FC1F000E9;
	Tue, 25 Aug 2026 11:24:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1787657073;
	bh=V1z0WDyXk0bENziWWVHab0A8lslH4RHIcL7VtBIWyUw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=bUXQvPiaLRjT45tKWWyIqeEq8KuomC3enx5nAGLkCuPjxvRo4zQNT9aZUDgSxX79M
	 JVMtKsFECRqP6jamcXF2CCdBqi/06IcPwh+q0JZxckeIBMfY6JpHx8gUmUNk4vTwfy
	 /g4SKZuJzwBo6lfjIqGhTeRmDCeF1/XKVgBlpkDYLq7I+Ota3yv7Zm+Aa2nS98Utwj
	 DMSJijchfppZXY2XolRrLI4u7IdA4l1i77WX/P5/A/WLfv6OloytiDlrv0U+0HY3Zf
	 /dFXoRGzF33dLdCEp+ZJjGJEtcIM2ecCFFKskd7LGGyGMlKUKudr+E9IGuBqIrHMXy
	 tKHIesx4k/bUQ==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>,
	Mat Martineau <martineau@kernel.org>,
	Jakub Kicinski <kuba@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.15.y 1/4] mptcp: pm: ADD_ADDR rtx: allow ID 0
Date: Tue, 25 Aug 2026 07:24:28 -0400
Message-ID: <20260825112431.3541047-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026082026-treble-stylized-d851@gregkh>
References: <2026082026-treble-stylized-d851@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>

[ Upstream commit 03f324f3f1f7619a47b9c91282cb12775ab0a2f1 ]

ADD_ADDR can be sent for the ID 0, which corresponds to the local
address and port linked to the initial subflow.

Indeed, this address could be removed, and re-added later on, e.g. what
is done in the "delete re-add signal" MPTCP Join selftests. So no reason
to ignore it.

Fixes: 00cfd77b9063 ("mptcp: retransmit ADD_ADDR when timeout")
Cc: stable@vger.kernel.org
Reviewed-by: Mat Martineau <martineau@kernel.org>
Signed-off-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
Link: https://patch.msgid.link/20260505-net-mptcp-pm-fixes-7-1-rc3-v1-2-fca8091060a4@kernel.org
Signed-off-by: Jakub Kicinski <kuba@kernel.org>
Stable-dep-of: a7aad5b69d3b ("mptcp: pm: fix data race in add_addr timer callback")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 net/mptcp/pm_netlink.c | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/net/mptcp/pm_netlink.c b/net/mptcp/pm_netlink.c
index 87321d545564e..efdea351895d2 100644
--- a/net/mptcp/pm_netlink.c
+++ b/net/mptcp/pm_netlink.c
@@ -326,9 +326,6 @@ static void mptcp_pm_add_timer(struct timer_list *timer)
 	if (inet_sk_state_load(sk) == TCP_CLOSE)
 		return;
 
-	if (!entry->addr.id)
-		return;
-
 	bh_lock_sock(sk);
 	if (sock_owned_by_user(sk)) {
 		/* Try again later. */
-- 
2.53.0

