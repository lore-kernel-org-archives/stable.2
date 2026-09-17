Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 64BD638A736
	for <stable@vger.kernel.org>; Thu, 17 Sep 2026 02:50:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789613462; cv=none; b=NYn1xt8EnGb1U0AxEm8+O7ded0UA7t20QPeOvR4TvPMtn+8I6zVdURqS9r+lZy19Ktv361mgvKi5hSLpmqRwL4YtMGMyl03iSd3JVscxEcsbqo1WbdfzS23dJG/PE/xQcmgTgi1luzn7r6qoq52fcw41sKas29p/AwCxixweETs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789613462; c=relaxed/simple;
	bh=NUiyaDjxtPQ6zKjzxim0SMRNKZ0VHD2cinVQEQhs1vc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=IL0J1Ey4sQcImGsf1vFEG6YNaDaKv7/ny4j52WdvCJSOXOCtjMkQxvdy+tpWB3voB2F/c7ZQF8QOeCYFrJNiUTe7rv0uDP9eOwk71EZ8xXGY7bNfVcTl0XMcy1O7naevA4gARF9FHEIkF0r+z8k4OdL4yHKP3xIcTaCj1kMxRls=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=oDWS9Sm3; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="oDWS9Sm3"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 98B6B1F0089C;
	Thu, 17 Sep 2026 02:50:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789613422;
	bh=EXdfyA2RTwIQsNnjQJwUMJIAvz+BoUDB1tDcxvGTmPQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=oDWS9Sm3sf1tO92trC56WQycATBSxhzeSrgBrc/iR/5eI6P+rtywWjJCHatYfkDRY
	 ly3IZiNqsDJBUOj/GMrlgv4ytX81LTwN+Htl46/+ZQZ6AC/c11+j1TfiAKnEIioG6f
	 nidB8uLg4UdKjA4Um2E3/jjvgsmiFK5eKcB01AookpN9TN3JhViE0+3iWmopjOnhI8
	 xo6Ujj++ZOoIyuchmrPxXHMrK1mANaJk6tEM1zMgncBnjrgxn95PqWC3It67lnZQj2
	 QcBthJR3V3/UAUfCQMohdppoUB5hCN/PshZM3JpMJdZggqPladsITSsECdUtu9uVsi
	 8e//3pXq3I/wg==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Geliang Tang <tanggeliang@kylinos.cn>,
	"Matthieu Baerts (NGI0)" <matttbe@kernel.org>,
	Jakub Kicinski <kuba@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.12.y 3/4] mptcp: use sock_kmemdup for address entry
Date: Wed, 16 Sep 2026 22:50:17 -0400
Message-ID: <20260917025018.3917338-3-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260917025018.3917338-1-sashal@kernel.org>
References: <2026091626-embassy-overhead-d482@gregkh>
 <20260917025018.3917338-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Geliang Tang <tanggeliang@kylinos.cn>

[ Upstream commit 52f83c0b5f857dbe24f66fc9a7f035523e9ffbc9 ]

Instead of using sock_kmalloc() to allocate an address
entry "e" and then immediately duplicate the input "entry"
to it, the newly added sock_kmemdup() helper can be used in
mptcp_userspace_pm_append_new_local_addr() to simplify the code.

More importantly, the code "*e = *entry;" that assigns "entry"
to "e" is not easy to implemented in BPF if we use the same code
to implement an append_new_local_addr() helper of a BFP path
manager. This patch avoids this type of memory assignment
operation.

Signed-off-by: Geliang Tang <tanggeliang@kylinos.cn>
Acked-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
Link: https://patch.msgid.link/3e5a307aed213038a87e44ff93b5793229b16279.1740735165.git.tanggeliang@kylinos.cn
Signed-off-by: Jakub Kicinski <kuba@kernel.org>
Stable-dep-of: f9f0068e8813 ("mptcp: pm: userspace: fix address ID overflow")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 net/mptcp/pm_userspace.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/net/mptcp/pm_userspace.c b/net/mptcp/pm_userspace.c
index 708cc81e707e7..da39a2e396661 100644
--- a/net/mptcp/pm_userspace.c
+++ b/net/mptcp/pm_userspace.c
@@ -68,13 +68,12 @@ static int mptcp_userspace_pm_append_new_local_addr(struct mptcp_sock *msk,
 		/* Memory for the entry is allocated from the
 		 * sock option buffer.
 		 */
-		e = sock_kmalloc(sk, sizeof(*e), GFP_ATOMIC);
+		e = sock_kmemdup(sk, entry, sizeof(*entry), GFP_ATOMIC);
 		if (!e) {
 			ret = -ENOMEM;
 			goto append_err;
 		}
 
-		*e = *entry;
 		if (!e->addr.id && needs_id)
 			e->addr.id = find_next_zero_bit(id_bitmap,
 							MPTCP_PM_MAX_ADDR_ID + 1,
-- 
2.53.0

