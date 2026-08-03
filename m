Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4B7033812ED;
	Mon,  3 Aug 2026 16:17:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785773829; cv=none; b=XPeihXi8dju68gr0XcM9lV6s01/ZKY3Qbf2OQ65onof7Myx3/4iixoKxX4ABSDi2nc2hoxcHc4VoChcwDjYVZPov+7PPlgpnSKCfc7yllwChNlQHxsFZHJMiXS4fQMnRzG+70zNoYJQiF3TnIW0w/lRkfpSNMHb5YvdxQCWco5E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785773829; c=relaxed/simple;
	bh=tR+bpbZaXHR7yYtUPL3piKutNWTjz7W9MI5kuSN5Yp0=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=oK2Lzd6OT3m+cBEnlavzv7DhyQFj5jgzn1AV8ZYKRVc363Bo3b1sC18t/twv6YLxMhy3LUyvwQOqiu+k6AGJoADY+lhVr20ho8qi/28ehItEMdOU8587l2hq2Cc5MdXRydvobl03Irnzx1qFE+pgwVznndQwlgjb40p4AeLLYsQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=NaVSLzt+; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="NaVSLzt+"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0D20F1F000E9;
	Mon,  3 Aug 2026 16:17:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785773828;
	bh=sk6xlk6RotAQHIR+N71Qjs1WiPc1f3XKjXhaiZnzVAI=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc;
	b=NaVSLzt+5KqdJx5CaYoudXrv+UwKS73A4A0AFsc1s5xfOGxFAtLeFy1rci+f8+GfI
	 TC/aSQtu2GdoKKpSxteVHM5Z5D7hHmgELLkLswwHv54dypFR966HJ/U8JzVSVg5Ceu
	 SRUl40+762Kp3myenhKskDlQZrzlFBH7bWxTWwtGyMRks3bHrTG6Gz11yeEWFHX+YO
	 hhHK4X4mLpJs1gWIQbJz/poTXI9Z4B2LQxGDE91WBfMsZXbEDlcwO8088rfmKyBqzt
	 X+Cm7rJXkbvh0UBoU4/OwWQXNgafgV1osVHwXiuUwFbwZgKEFkSrn9IoP4ysFxwXSw
	 tHLD69QpkJE6g==
From: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
Date: Mon, 03 Aug 2026 18:16:36 +0200
Subject: [PATCH net v2 4/8] mptcp: pm: fix data race in add_addr timer
 callback
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260803-net-mptcp-misc-fixes-7-2-rc6-v2-4-b8f496d71664@kernel.org>
References: <20260803-net-mptcp-misc-fixes-7-2-rc6-v2-0-b8f496d71664@kernel.org>
In-Reply-To: <20260803-net-mptcp-misc-fixes-7-2-rc6-v2-0-b8f496d71664@kernel.org>
To: Mat Martineau <martineau@kernel.org>, Geliang Tang <geliang@kernel.org>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 Simon Horman <horms@kernel.org>
Cc: netdev@vger.kernel.org, mptcp@lists.linux.dev, 
 linux-kernel@vger.kernel.org, "Matthieu Baerts (NGI0)" <matttbe@kernel.org>, 
 Qing Luo <luoqing@kylinos.cn>, stable@vger.kernel.org
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=1972; i=matttbe@kernel.org;
 h=from:subject:message-id; bh=yRPzTy5hKZEYeq+xcCHW0MQlumNe3rfsdEDdQlVhA5E=;
 b=owGbwMvMwCVWo/Th0Gd3rumMp9WSGLIK9n2w7K7RfnrlTnqin+xM4TazpcJ9BYpVH15FPGxMl
 XnywW9aRykLgxgXg6yYIot0W2T+zOdVvCVefhYwc1iZQIYwcHEKwEQOsjD8957o7jxxT2FPTo3G
 g9NBW1M19reF9Ez/VWSvxMyRlPdIg5GhTTHVT3bDwUcHW1fFHSxdeshxmyWvgKeHR3DXohv8Oq8
 YAA==
X-Developer-Key: i=matttbe@kernel.org; a=openpgp;
 fpr=E8CB85F76877057A6E27F77AF6B7824F4269A073

From: Qing Luo <luoqing@kylinos.cn>

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
---
v2: clarify commit message to avoid possible confusion. (Clashiko)
---
 net/mptcp/pm.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/net/mptcp/pm.c b/net/mptcp/pm.c
index 6afd39aea110..c71dcf887683 100644
--- a/net/mptcp/pm.c
+++ b/net/mptcp/pm.c
@@ -380,6 +380,7 @@ static void mptcp_pm_add_addr_timer(struct timer_list *timer)
 	struct mptcp_sock *msk = entry->sock;
 	struct sock *sk = (struct sock *)msk;
 	unsigned int timeout = 0;
+	bool retransmit;
 
 	pr_debug("msk=%p\n", msk);
 
@@ -412,14 +413,15 @@ static void mptcp_pm_add_addr_timer(struct timer_list *timer)
 		entry->retrans_times++;
 	}
 
-	if (entry->retrans_times < ADD_ADDR_RETRANS_MAX)
+	retransmit = entry->retrans_times < ADD_ADDR_RETRANS_MAX;
+	if (retransmit)
 		timeout <<= entry->retrans_times;
 	else
 		timeout = 0;
 
 	spin_unlock_bh(&msk->pm.lock);
 
-	if (entry->retrans_times == ADD_ADDR_RETRANS_MAX)
+	if (!retransmit)
 		mptcp_pm_subflow_established(msk);
 
 out:

-- 
2.53.0

