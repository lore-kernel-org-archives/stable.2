Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E0CAC43E071;
	Tue, 21 Jul 2026 22:15:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784672109; cv=none; b=WQw8YywaTI4jLxYfWMPR+BX0gbX4eAIUBBM+ohXNmCVNGMkwob6C4ZAydsWB6MtBGTjhYOJ47amRmfXpzM4DoBm++ADNo1Wz3Z0rxmll1hRVXhnIrEXsxNOZRGbbTgRDTXwMKoTk4Pkyhzn/CwU5UWk+/Ws2FMXEYO9NuYbmmHg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784672109; c=relaxed/simple;
	bh=0qURqO9kn/zcU54YmnorJujhtp0lYSnY10DK+OWj0sk=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=qSIgoPGS1ZhNlvNZeQCvuAlX/yYyap76CQ77khFqxbakdoVuBHIgxEYvDA1FEEf/HHzxCZzl80x0XsAZ3cbzfkd7InsChaBLpEFI3VZ0D4SYq7Ct4NYvVRSwWL+a1ncx7XOG2waTX3Lbxc2dfqAdcMsptwTNZCXRAec6LPx5oLU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=A2evbRv2; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="A2evbRv2"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 939C51F000E9;
	Tue, 21 Jul 2026 22:15:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784672108;
	bh=FHRp21V3fuZAYhHcKdmzGkJ92F9rNGdh3mSVIi9BnDw=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc;
	b=A2evbRv2qugeZHRl40FBwW5CbsopYJEt8Gyi5jADqTwvnKAejf0J/kOYlKp2zYTu7
	 Q4NOknpc2cp597N4JFV5lWcdkaj6yH7dCvFRfJTmZ19O2g7mDqCus4eiFqtr5wZRyY
	 myK51G5W0ebG8CG0uESmzcYpO2MzWp5pGdT4eNXmYpa7J7gqSekUPZ96cnvwKNDBZS
	 xUcij9khnoMF7N3TKm+A3sW2bStqDHNf5T2Y5zo8grAbHwT/lSnpWfDdJUtPIv/BlH
	 LEshIhpzIJOyCFEn4Fp3ctmN2a6JW08+g/kVOadncEP5rzkzK1B739GbYGg3JZIfpM
	 Wn9iTCcmOMoKw==
From: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
Date: Wed, 22 Jul 2026 00:14:38 +0200
Subject: [PATCH net 1/5] mptcp: decrement subflows counter on failed
 passive join
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260722-net-mptcp-misc-fixes-7-2-rc5-v1-1-6fb595bc86ef@kernel.org>
References: <20260722-net-mptcp-misc-fixes-7-2-rc5-v1-0-6fb595bc86ef@kernel.org>
In-Reply-To: <20260722-net-mptcp-misc-fixes-7-2-rc5-v1-0-6fb595bc86ef@kernel.org>
To: Mat Martineau <martineau@kernel.org>, Geliang Tang <geliang@kernel.org>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 Simon Horman <horms@kernel.org>
Cc: netdev@vger.kernel.org, mptcp@lists.linux.dev, 
 linux-kernel@vger.kernel.org, "Matthieu Baerts (NGI0)" <matttbe@kernel.org>, 
 Chenguang Zhao <zhaochenguang@kylinos.cn>, stable@vger.kernel.org
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=1082; i=matttbe@kernel.org;
 h=from:subject:message-id; bh=gXFS1yu5DdyRn+H8JzWtKZhQG8QH+B/3J0IBrtKs4tk=;
 b=owGbwMvMwCVWo/Th0Gd3rumMp9WSGLLi3yenrGbg0436yDotyc+uKeE/p6G8janlq7NWFWWf/
 3C68v/vKGVhEONikBVTZJFui8yf+byKt8TLzwJmDisTyBAGLk4BmIiwM8NvVqvHQXdb1Fn9dqV9
 9cqLqGr9KruxKuen3vPj61U2ff1uz/Df9aSiYnjb12Va4V8sTK9vmlZbu4pv58uJ+7JNfJNnMN9
 kBgA=
X-Developer-Key: i=matttbe@kernel.org; a=openpgp;
 fpr=E8CB85F76877057A6E27F77AF6B7824F4269A073

From: Chenguang Zhao <zhaochenguang@kylinos.cn>

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
---
 net/mptcp/protocol.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/net/mptcp/protocol.c b/net/mptcp/protocol.c
index cb9515f505aa..b32f0cd262a7 100644
--- a/net/mptcp/protocol.c
+++ b/net/mptcp/protocol.c
@@ -3907,6 +3907,7 @@ bool mptcp_finish_join(struct sock *ssk)
 	mptcp_data_unlock(parent);
 
 	if (!ret) {
+		mptcp_pm_close_subflow(msk);
 err_prohibited:
 		subflow->reset_reason = MPTCP_RST_EPROHIBIT;
 		return false;

-- 
2.53.0

