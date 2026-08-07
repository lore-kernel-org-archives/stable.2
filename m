Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1D0AB305057
	for <stable@vger.kernel.org>; Fri,  7 Aug 2026 11:48:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786103309; cv=none; b=pAPotrlDqfr+6KXkOU+7n/SKUAysSoIfFVk3uc8EstWwSqQnzBCZ2NKqtrY62xJLKAVTB5yxsuEhvGUtJ46mAqf6q2C3MigrOlJ4+bbLIjUJcdICvguUlzOYNGD8WXyWK5T+xE3v+2xSTaAHEPsDv9cGV1H8oJVzaH0AhysKTAg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786103309; c=relaxed/simple;
	bh=MwRddDfmX0dUSfuVnP/kW6RNiydf3KVEIHpLh4PyWPI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=TXBriBNe2r7mwt8CBMpQUnnXGa8DnfIFvqK1B5wAl0JOaGahlp6/19a8n5e6cy6zJpkrhIqEq85WgcuNpCtEynsGqOVTXpjAwjmfbm21R6jZ9ME6mfRdPrQwwtjZr89b7ILHkGlbWJ09pR4v0SnsNV2vE2CZD7N4C8H62uG8uAE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=e/GC+Fiv; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="e/GC+Fiv"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3BA541F000E9;
	Fri,  7 Aug 2026 11:48:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786103300;
	bh=DoeEK2v1SSp6PGvWlNmHPdeoF/k1ynw+6V31CSLH5hQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=e/GC+FivZ8x9CsltY0C1hP8K+fnJ0zM3j37m7zh1KU+eZFzHA9aPo5UDU+uwNgi3V
	 gbVPU2eDMC9LKmNd10cIUtyVujj2fWYZFZBIR4p5MAMFVCU3K/9dl9fLQh3om0F9/A
	 i0FdtCixTG9R37H6/02cnWX0nYIWXhQco3C2FVQeQc2Elo+TXIL0ITHxJKoNMMcYuk
	 cHnIQcafR22xWoCv3KHDtqxoKfafGbWZ7txqt8K8y9diSRMrdsYuRYaycVaUOx1+9y
	 QsDjAmNeCtBhYJWlX3N+7qSfGW038ABSajhuQVKy6Ax4fkh0dznRrelwDMIn/GaiC6
	 TZoedMwfmprQg==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Chenguang Zhao <zhaochenguang@kylinos.cn>,
	"Matthieu Baerts (NGI0)" <matttbe@kernel.org>,
	Jakub Kicinski <kuba@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.10.y 2/2] mptcp: decrement subflows counter on failed passive join
Date: Fri,  7 Aug 2026 07:48:17 -0400
Message-ID: <20260807114817.2056504-2-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260807114817.2056504-1-sashal@kernel.org>
References: <2026072945-unsalted-ozone-c2bf@gregkh>
 <20260807114817.2056504-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Chenguang Zhao <zhaochenguang@kylinos.cn>

[ Upstream commit f3ca0ee2cc308e33896536789cbc5f3a12ca7b30 ]

mptcp_pm_allow_new_subflow() increments extra_subflows before
__mptcp_finish_join() on the passive MP_JOIN path.

In case of race conditions, the subflow is dropped without calling
mptcp_close_ssk(), so the counter is not rolled back.

Call mptcp_pm_close_subflow() when the join completion fails to
decrement the subflows counter.

Fixes: 10f6d46c943d ("mptcp: fix race between MP_JOIN and close")
Cc: stable@vger.kernel.org
Signed-off-by: Chenguang Zhao <zhaochenguang@kylinos.cn>
Reviewed-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
Signed-off-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
Link: https://patch.msgid.link/20260722-net-mptcp-misc-fixes-7-2-rc5-v1-1-6fb595bc86ef@kernel.org
Signed-off-by: Jakub Kicinski <kuba@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 net/mptcp/protocol.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/net/mptcp/protocol.c b/net/mptcp/protocol.c
index a9595eb2b5fee..2c6aef813473f 100644
--- a/net/mptcp/protocol.c
+++ b/net/mptcp/protocol.c
@@ -2663,8 +2663,10 @@ bool mptcp_finish_join(struct sock *sk)
 	if (ret && !WARN_ON_ONCE(!list_empty(&subflow->node)))
 		list_add_tail(&subflow->node, &msk->join_list);
 	spin_unlock_bh(&msk->join_list_lock);
-	if (!ret)
+	if (!ret) {
+		mptcp_pm_close_subflow(msk);
 		return false;
+	}
 
 	/* attach to msk socket only after we are sure he will deal with us
 	 * at close time
-- 
2.53.0

