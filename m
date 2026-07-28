Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D250139FCD8;
	Tue, 28 Jul 2026 17:12:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785258747; cv=none; b=qIqcPin2EeioimAG4SiriGupLxvDDMscoqAdEBWPZr9GarWWnO0cg3MJK99Y0XFfvz4+4793ItYQ/DSi79hRfRPCr/9tjjS/xBBf1WvhH3cZGzqHviXiAl3Ku5bVQlixEUx680AIS/+5g9EwlTAeN8W+J1XhkFqnV7uXRBOz4Ag=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785258747; c=relaxed/simple;
	bh=5uECOOns2Y41XUYlvAgm8ybQtbEZGOYp0nbjgwLpCZU=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=jQSLtmzK8NSQEolx+cYBZOaUNeKLUWcYCiqmb+B6N03vFRXsq+A91y8U5Qd3lgVR5y5aNs990BhdVZ2L3KEhv/CiycgjRoATxPw2xJwFg3EjYxiUGlyb8x9fWxwhGO6UTuVSzlr7moX1Rv1jjeX690GgRVLUddINjXbTNeIOSIM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=odqfIDuJ; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="odqfIDuJ"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5C30D1F00A3A;
	Tue, 28 Jul 2026 17:12:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785258745;
	bh=ddGrUJuo0FcgqMZcBeOx4dAowEcWdhsa4UnRR007kHg=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc;
	b=odqfIDuJOgTR1Z4kOUKNTKFwmGfEyoP3IROfFC14dO7qTBWKRF3DFA6ASjohZWqyJ
	 ZjuiZrxOjQs45oV+naQuurCskZX+hWUg26hhnp18A9X/+pCQQ0KRv4wTy2TWL8s+BJ
	 RV3G/3xkYdUBNbteOJVV69j5curGee4OKZBmHt121uZXTEesQOLEibelmmg3IlUKa4
	 gTIWZCCragESTahwgSzgOi4UTNxoP17T00ILyRT6L2pS4zp+SQyY5/LaVXMzVVfTgi
	 hsYHuaiCUkmT9f0wuD+9CV5/HwL3ZJmMdrJhe+pouMbdBWCuLQ2C+pd3iRPIlYp3uH
	 s3+Cs+BJJA2XA==
From: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
Date: Tue, 28 Jul 2026 19:11:58 +0200
Subject: [PATCH net 2/5] mptcp: pm: fix data race in add_addr timer
 callback
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260728-net-mptcp-misc-fixes-7-2-rc6-v1-2-f7e2d229159d@kernel.org>
References: <20260728-net-mptcp-misc-fixes-7-2-rc6-v1-0-f7e2d229159d@kernel.org>
In-Reply-To: <20260728-net-mptcp-misc-fixes-7-2-rc6-v1-0-f7e2d229159d@kernel.org>
To: Mat Martineau <martineau@kernel.org>, Geliang Tang <geliang@kernel.org>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 Simon Horman <horms@kernel.org>
Cc: netdev@vger.kernel.org, mptcp@lists.linux.dev, 
 linux-kernel@vger.kernel.org, "Matthieu Baerts (NGI0)" <matttbe@kernel.org>, 
 Qing Luo <luoqing@kylinos.cn>, stable@vger.kernel.org
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=1829; i=matttbe@kernel.org;
 h=from:subject:message-id; bh=wZ1yI/4v6nUYzHek0OESNzLU3HkX5ZJAftiZ5gXxbrA=;
 b=owGbwMvMwCVWo/Th0Gd3rumMp9WSGLIyHr29+rrlkdvkFz8vLmA8qdJw19T9dqeW36aoPX9XN
 7kVsq7621HKwiDGxSArpsgi3RaZP/N5FW+Jl58FzBxWJpAhDFycAjCRG5IM/2t/HoxdyXtmXoQ8
 t93+Lw9i2j2ESqREuRW7epcUXX1gW8rIcEN1pz77jNiL/Xyx7zY0tJgWsdQo3C3aaCIdHzvFgDO
 JEwA=
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
retransmission is still possible. This ensures that
mptcp_pm_subflow_established() is only called when the retransmission
naturally exhausts.

Fixes: 348d5c1dec60 ("mptcp: move to next addr when timeout")
Cc: stable@vger.kernel.org
Signed-off-by: Qing Luo <luoqing@kylinos.cn>
Reviewed-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
Signed-off-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
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

