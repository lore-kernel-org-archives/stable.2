Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DB02019E97B
	for <stable@vger.kernel.org>; Mon, 24 Aug 2026 23:50:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787615446; cv=none; b=tu8b71iapPkC0yVdxV4scuhapos/4ZTrblrBzQBFxGpEsX6ul6kPV4nHXfFoei1onCpit3moVF319TUl0RBjLYGMfEerZ7w+WoYs6Kze9NcYAKr8F+aRH6BQAYvoq3cHbmnbGXO/j5PfgSEcMbGQmNElCPHSC88iCbswuXhZ26s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787615446; c=relaxed/simple;
	bh=m9lwo4XQmQnHA2ChAR3QzkbyLUJURM94bRWE4rof+SQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Hbb8YV5kvFOYGKFEb84Lyc38abaOgyRfyRiB8JANRLZhB7kE3df41Zahe/6agDkZDUeApshJo1/RJuKb1GhjAQon2CYH5bp/4LF9nQ7O5nDbhgGC+Winst7NKCQw+WdI2Tk75Gvr2NLiXQEWxNGPNdY2rUhOGC2lkdl6VAfNhZ0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=GHID4Nkl; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="GHID4Nkl"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 064A01F00A3F;
	Mon, 24 Aug 2026 23:50:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1787615444;
	bh=12OIME2SEMPO/tR5ruymdRJ884PBLh7GTALJnkosmto=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=GHID4Nkl3ROy7yltTDng4x7SV3ujVn3gbylZE/QZPAYDtoCUDIPvNZrBb39Rc24v2
	 pntGCxeRSj+Go07o8L/ho5ECEKI31b0n16y3PMIr0r0xp7sXWHvWkFLJMfUUju3yeL
	 gg8VIk2TxbgNwA6fIIs71HV9bx1/+kjC5T0raqLzNOCeE4bVwp5C45lCStq6EeFKj7
	 Kd1chB1/Q2tdEqmUlmRExNxC9Ir7/m8RPsjeQAf3tuuIiVzuLY6b+FrieW7aitkfCv
	 Klxb4LPddBTfY/ZyTAE9EjZrJY6Nslr3yTko+eOtEs93gmxCDNy/D7Fbd9/L0o6uey
	 C2LmVi7SLLwGg==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Qing Luo <luoqing@kylinos.cn>,
	"Matthieu Baerts (NGI0)" <matttbe@kernel.org>,
	Jakub Kicinski <kuba@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.1.y 3/3] mptcp: pm: fix data race in add_addr timer callback
Date: Mon, 24 Aug 2026 19:50:40 -0400
Message-ID: <20260824235040.730038-3-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260824235040.730038-1-sashal@kernel.org>
References: <2026082025-sitter-talisman-7358@gregkh>
 <20260824235040.730038-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Qing Luo <luoqing@kylinos.cn>

[ Upstream commit a7aad5b69d3bdaec20a3ed9284e184502450c0cd ]

The timer callback reads entry->retrans_times outside pm.lock to decide
whether to call mptcp_pm_subflow_established(). Since
mptcp_pm_announced_del_timer() can concurrently set retrans_times =
ADD_ADDR_RETRANS_MAX under pm.lock, a race condition exists.

I discovered this issue while studying the code. AI tools helped me to
verify the issue can potentially happen under race conditions.

Use a local 'retransmit' flag set inside pm.lock to capture whether
retransmission is still possible when the lock is taken. This allows to
call mptcp_pm_subflow_established() accordingly, and not depending on
the situation that can be different when checked outside the pm.lock.

Fixes: 348d5c1dec60 ("mptcp: move to next addr when timeout")
Cc: stable@vger.kernel.org
Signed-off-by: Qing Luo <luoqing@kylinos.cn>
Reviewed-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
Signed-off-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
Link: https://patch.msgid.link/20260803-net-mptcp-misc-fixes-7-2-rc6-v2-4-b8f496d71664@kernel.org
Signed-off-by: Jakub Kicinski <kuba@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 net/mptcp/pm_netlink.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/net/mptcp/pm_netlink.c b/net/mptcp/pm_netlink.c
index 495ec8e584035..74e211e8adad4 100644
--- a/net/mptcp/pm_netlink.c
+++ b/net/mptcp/pm_netlink.c
@@ -307,6 +307,7 @@ static void mptcp_pm_add_timer(struct timer_list *timer)
 	struct mptcp_sock *msk = entry->sock;
 	struct sock *sk = (struct sock *)msk;
 	unsigned int timeout = 0;
+	bool retransmit;
 
 	pr_debug("msk=%p\n", msk);
 
@@ -344,12 +345,13 @@ static void mptcp_pm_add_timer(struct timer_list *timer)
 		entry->retrans_times++;
 	}
 
-	if (entry->retrans_times >= ADD_ADDR_RETRANS_MAX)
+	retransmit = entry->retrans_times < ADD_ADDR_RETRANS_MAX;
+	if (!retransmit)
 		timeout = 0;
 
 	spin_unlock_bh(&msk->pm.lock);
 
-	if (entry->retrans_times == ADD_ADDR_RETRANS_MAX)
+	if (!retransmit)
 		mptcp_pm_subflow_established(msk);
 
 out:
-- 
2.53.0

