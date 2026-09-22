Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B5391497B9B
	for <stable@vger.kernel.org>; Tue, 22 Sep 2026 18:45:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790102768; cv=none; b=a+9aD01gCgMDYXi72u71CgRsGs9VPdQuVnxopaoZ4fH6UGxg0OgHL1sQYWziLoLLsRYRXmS10LURQWnCG04doPq9u8n/fbpBKQiG3IfrGuYCTtVyx2RkeIWV6QbQs8An5IvGdjTORrsVnvbxJpWlh3y5Xvbx5LrW8Lc6pWtHaaU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790102768; c=relaxed/simple;
	bh=bv45vaYuAfxT2R3yggfg5ajVwMhVFouvBnm4WJjlmmM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=D3jfaTWFq6MFA2fsDhfUF1bZu3ZhoBE651pEoHORo3zjNTN6zDaHIe4i29ECvAV6hXOXMbwddu68d/XPm5RzXIDSHz1p0mluDe5MepiZVVoro2A+Z8AqjsJS4RjqqUNTPX+Jf4QEAXtR6K3q14ER9fa6qmUoF4946L/sTvESqao=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=OWT1s/Oj; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="OWT1s/Oj"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4FAF91F00899;
	Tue, 22 Sep 2026 18:45:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790102753;
	bh=7UpNvoFkTlNNnekXzF1wUqq7iFlW64wMg1J6ytMrI0Y=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=OWT1s/OjQ73BmWzejD5toxQfdwWqDyfJemIvOdLpVqiusdEjIFFml9bh4drGmTzTu
	 zgaoPXidXnvUfEJfnEYpfIHYm6a/hLiO2a87BGSOSaCRmML/vK8yUghfnKcZgwaJiW
	 JocLaEepgsBXQiuKlrR3CsycSqZKGZExggRK8T8M/kS9cqAY+XGyRB8EE8w6jsfjRp
	 UAGvSD584p/XgD8VwDzrD5FKRg2gulsvdaafSTUSxKv4p/Kumm2aXASfFb+HnVKbhq
	 r1H0jpDMRO5gd65z2VxG7AKo6IjlRzlZTxb9Hr+X736Yqa1OYnuFWgL8nS/OG14O/Q
	 rOrbyZaEpOy1g==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Fan Wu <fanwu01@zju.edu.cn>,
	Song Li <songl@zju.edu.cn>,
	Loic Poulain <loic.poulain@oss.qualcomm.com>,
	Jeff Johnson <jeff.johnson@oss.qualcomm.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.1.y] wifi: wcn36xx: Fix potential use-after-free in TX ack timer teardown
Date: Tue, 22 Sep 2026 14:45:50 -0400
Message-ID: <20260922184550.3791121-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026092258-patriot-carless-32a6@gregkh>
References: <2026092258-patriot-carless-32a6@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Fan Wu <fanwu01@zju.edu.cn>

[ Upstream commit d9be5e75530772fc31637070d51e5717d6aeaa2a ]

wcn36xx_dxe_deinit() tears down the TX ack timer with timer_delete(),
which only dequeues the timer and does not wait for a callback that is
already executing; the preceding free_irq() calls synchronize the
interrupt handlers only. The callback, wcn36xx_dxe_tx_timer(), can
therefore be running past the teardown and use the wcn freed along
with the ieee80211_hw in wcn36xx_remove(): it takes wcn->dxe_lock,
reads wcn->tx_ack_skb and passes wcn->hw to
ieee80211_tx_status_irqsafe().

Fix this by using timer_shutdown_sync(), which waits for a running
callback and also prevents the timer from being rearmed again. The
timer is set up again by wcn36xx_dxe_init() on the next start, so the
start/stop cycle is unaffected.

This issue was found by an in-house static analysis tool.

Fixes: fdf21cc37149 ("wcn36xx: Add TX ack support")
Cc: stable@vger.kernel.org
Assisted-by: LLM
Co-developed-by: Song Li <songl@zju.edu.cn>
Signed-off-by: Song Li <songl@zju.edu.cn>
Signed-off-by: Fan Wu <fanwu01@zju.edu.cn>
Reviewed-by: Loic Poulain <loic.poulain@oss.qualcomm.com>
Link: https://patch.msgid.link/20260910020907.3353-1-fanwu01@zju.edu.cn
Signed-off-by: Jeff Johnson <jeff.johnson@oss.qualcomm.com>
[ Adapted the patch to replace del_timer() instead of timer_delete(). ]
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/net/wireless/ath/wcn36xx/dxe.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/wireless/ath/wcn36xx/dxe.c b/drivers/net/wireless/ath/wcn36xx/dxe.c
index 4e9e13941c8f4..b168db800e07e 100644
--- a/drivers/net/wireless/ath/wcn36xx/dxe.c
+++ b/drivers/net/wireless/ath/wcn36xx/dxe.c
@@ -1054,7 +1054,7 @@ void wcn36xx_dxe_deinit(struct wcn36xx *wcn)
 
 	free_irq(wcn->tx_irq, wcn);
 	free_irq(wcn->rx_irq, wcn);
-	del_timer(&wcn->tx_ack_timer);
+	timer_shutdown_sync(&wcn->tx_ack_timer);
 
 	if (wcn->tx_ack_skb) {
 		ieee80211_tx_status_irqsafe(wcn->hw, wcn->tx_ack_skb);
-- 
2.53.0

