Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AA53227A916
	for <stable@vger.kernel.org>; Fri,  7 Aug 2026 02:36:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786070175; cv=none; b=kCFakeQUTCE+54a7zZIOpnRegN/nCiaudOcYJAnonum0bwS/6VyAZswvcUTIEt8cRGZdtHuTDKD9k7g8e29yGG5u6vrhv/D8PAdxHNjerYu2qW5b0gX4JAFavrjcAC4E/B10hQVxI1M+DuTBDLclZH6/wypB3tStMZueCQbQ94Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786070175; c=relaxed/simple;
	bh=QV2Bqql/vb72j5y9pqEHBLDSPKxC0erevo+QGCD4RqI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=LnyS8OG+KbeqCXRfQbZPiAJF5v29YZuX601NSCNBcOVJ8AZtJQgoVeqYEiAmJYOq8ijGUx1X2z4t1tTxe3SOyB0znv1NzHdHW66ANR7up1JppPwLrGVnEVWQ50lhnPWCUi/Kg1KDOcsFV8t+PUR+dseSuNJWACzPGssyA031d3o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=F7jxAC7N; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="F7jxAC7N"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C25AF1F00A3A;
	Fri,  7 Aug 2026 02:36:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786070174;
	bh=R+vXnDxL7YNm63Go5yD7xSg7KYgqvofkWGzIKCNW8Bo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=F7jxAC7NZ48QDBGLJcD468QQY66eJ4i232glQuhcCVT3TbWTwg3m3wfm0prYSPZhF
	 869GzbFouVGyaeUzQuFmQUCGYSjBQH5DcXdEWe51E+P9E8gEQlVRZft7wVcERU8Snr
	 7YRzZ08GJPmCSaMTluNkRfs5IKH8kw+HCHhAlv5gqliGKP4uAxRnNLyrFUZel4MWy9
	 NDfc32OmYfCVz4OMSYvwUiQ98Pjv9H2xxlpwLdmvCCbNneWSwtNhsepuH2A0N41I+k
	 oGaN5kcrgivWdP1NSs04sPZQaffHR9UB0aAMCSX/PFOpBmTfFdl3Tl+FYYiFvNOf8v
	 ZlYReQsYTYKFw==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Chenguang Zhao <zhaochenguang@kylinos.cn>,
	"Matthieu Baerts (NGI0)" <matttbe@kernel.org>,
	Jakub Kicinski <kuba@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.15.y 3/3] mptcp: decrement subflows counter on failed passive join
Date: Thu,  6 Aug 2026 22:36:10 -0400
Message-ID: <20260807023610.1683763-3-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260807023610.1683763-1-sashal@kernel.org>
References: <2026072945-judge-corset-9953@gregkh>
 <20260807023610.1683763-1-sashal@kernel.org>
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
 net/mptcp/protocol.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/net/mptcp/protocol.c b/net/mptcp/protocol.c
index 4e1a5f10fba0a..522d8740a0f3a 100644
--- a/net/mptcp/protocol.c
+++ b/net/mptcp/protocol.c
@@ -3361,6 +3361,7 @@ bool mptcp_finish_join(struct sock *ssk)
 	mptcp_data_unlock(parent);
 
 	if (!ret) {
+		mptcp_pm_close_subflow(msk);
 err_prohibited:
 		subflow->reset_reason = MPTCP_RST_EPROHIBIT;
 		return false;
-- 
2.53.0

