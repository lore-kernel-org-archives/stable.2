Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 89A4037C912
	for <stable@vger.kernel.org>; Tue, 16 Jun 2026 15:55:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781625336; cv=none; b=GVHyyoh4TV7NA6+5MwU1iOcfWgHKJcUdjn1JHx/746Ht8rvNKKxTjl689OChOigaVyae6A60JU0yXj//CsAABZ/PJbMJwb67+ieaZpjb3UgYVwIL9RYAGMpz8+8wczogmXW9+gyYDfz8+eopgOQAfIt19IW+j5gxSRu/44tQwMc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781625336; c=relaxed/simple;
	bh=tLeVq7+n1v6EjWKWgf/AE15I8C4hwa7E5W/6XcldgVY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=XtOWCDvgH28yIU+bEgzbR6PqUUmvjW3cjQg4DE6pfwDPvBIPdmtKBvD6UhcVeDmsKGgKUWSLHwgEufsda8FxuH2sYG3oiVwoBj14xoxOsu9QFjsajhGkGyaJoTdkp8bQJzAZcHSnfOGd+9M7FrZANatwY+M/akI6aPRCW7P9B8Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=KleP4s5d; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="KleP4s5d"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C9F891F00A3A;
	Tue, 16 Jun 2026 15:55:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781625335;
	bh=e9qoOgMtPh4U/TuzwBJX0HS9QwtFjrRRbjBYcVRcw7Q=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=KleP4s5dMxyAq0eYUxPiECoWT8wvqOBgnYAFwpH144eezpcaRiYlHO8smT3Owb0ru
	 DIGdG3k91UNrP+CCnRLFyUqDZSQBBCfKNdiKc714VP5X9SmIroj4iocFUm6r1ujkRA
	 5lRAT9kyetjOrgzNbE8feo5FulM1zvkqaAKRX1KYwjjTiKCoJ5Xb+o4o2kO1sdEspM
	 a8ZAPtEefcc1BH/UWHmk0o8kP3I122EeLiqc4aT+el95j6evUgE1mTPeVYACt4vwYG
	 U//afD+4HIuWYq2WCvtcTIFdKJNSc7nAgnOQOwS8UH8yNmPZy1ZF7XysH7CHHy66Ct
	 S4d3mJjcQpS1A==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Tao Cui <cuitao@kylinos.cn>,
	"Matthieu Baerts (NGI0)" <matttbe@kernel.org>,
	Jakub Kicinski <kuba@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.6.y] mptcp: pm: fix extra_subflows underflow on userspace PM subflow creation
Date: Tue, 16 Jun 2026 11:55:33 -0400
Message-ID: <20260616155533.3323286-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026061555-garland-jailbird-8f3c@gregkh>
References: <2026061555-garland-jailbird-8f3c@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Tao Cui <cuitao@kylinos.cn>

[ Upstream commit 14e9fea30b68fc75b2b3d97396a7e6adb544bd2a ]

The userspace PM increments extra_subflows after __mptcp_subflow_connect()
succeeds, but __mptcp_subflow_connect() calls mptcp_pm_close_subflow()
on failure to roll back the pre-increment done by the kernel PM's fill_*()
helpers. Because the userspace PM hasn't incremented yet at that point,
this decrement is spurious and causes extra_subflows to underflow.

Fix it by aligning the userspace PM with the kernel PM: increment
extra_subflows before calling __mptcp_subflow_connect(), so the existing
error path in subflow.c correctly rolls it back on failure. Also simplify
the error handling by taking pm.lock only when needed for cleanup.

Fixes: 77e4b94a3de6 ("mptcp: update userspace pm infos")
Cc: stable@vger.kernel.org
Signed-off-by: Tao Cui <cuitao@kylinos.cn>
Reviewed-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
Signed-off-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
Link: https://patch.msgid.link/20260602-net-mptcp-misc-fixes-7-1-rc7-v2-5-856831229976@kernel.org
Signed-off-by: Jakub Kicinski <kuba@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 net/mptcp/pm_userspace.c | 13 ++++++++-----
 1 file changed, 8 insertions(+), 5 deletions(-)

diff --git a/net/mptcp/pm_userspace.c b/net/mptcp/pm_userspace.c
index 8faf776cb977c6..663aeefbd1b230 100644
--- a/net/mptcp/pm_userspace.c
+++ b/net/mptcp/pm_userspace.c
@@ -408,18 +408,21 @@ int mptcp_nl_cmd_sf_create(struct sk_buff *skb, struct genl_info *info)
 		goto create_err;
 	}
 
+	spin_lock_bh(&msk->pm.lock);
+	msk->pm.subflows++;
+	spin_unlock_bh(&msk->pm.lock);
+
 	lock_sock(sk);
 
 	err = __mptcp_subflow_connect(sk, &addr_l, &addr_r);
 
 	release_sock(sk);
 
-	spin_lock_bh(&msk->pm.lock);
-	if (err)
+	if (err) {
+		spin_lock_bh(&msk->pm.lock);
 		mptcp_userspace_pm_delete_local_addr(msk, &local);
-	else
-		msk->pm.subflows++;
-	spin_unlock_bh(&msk->pm.lock);
+		spin_unlock_bh(&msk->pm.lock);
+	}
 
  create_err:
 	sock_put((struct sock *)msk);
-- 
2.53.0

