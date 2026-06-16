Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 60B63466B65
	for <stable@vger.kernel.org>; Tue, 16 Jun 2026 16:18:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781626730; cv=none; b=DBHk6M1ZV04QL3yI98jQIDzQ1OclpqY6gaVUt+GNsMbUt7yT0GKZR4oQHuXOrRwwuhNbBtDhpN+BPpBmKdy5tcLA0M/3IOdaM7Fmre/bzNPXOOoh4IBikl9+px7Ly8VdlWkm3JfzDQcbEwX4yTXLARTNXZYVfAtx6jGqvyQL/M4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781626730; c=relaxed/simple;
	bh=bfYHa33ebgUatk7KX4hJI/IEYwJBMZsyQg7800Jj0KY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=biO7TJYjjTtuY7I0um8pcrbkgyKd97UmU2YxmzBeSuKNPE5c39yCzC6Odx6Uu/kIRkNb5L9C+F3/5FwemctHUVdg26+/FowSsSfEeBTMm1bDGLJVN+azHV4ZI8h1fFEeR4MqxZ0XqNWjjKKROrjxm/xmpWLIs8ZphESmKDR6ZkE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Xf0Mc9h3; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Xf0Mc9h3"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 90AB41F00A3A;
	Tue, 16 Jun 2026 16:18:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781626729;
	bh=IsN/jdWIKBB1Qd/FIyO572YPQpuyYosA6vhI3XSTiyM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=Xf0Mc9h3kKOF+I/5pHjR4wVfGrpPRJHJxRUhxbksHoQrrqrQrjpqj4q8FmScL9FOy
	 uoW7LAO9i7YjPCiU3/j+7AQ8C927g02IoMb8192STWlYEhurc/5ET4H3kLNUbeY8Gv
	 zwjDlpXsCyo58cv3qWHyMVagKBCZkvFHDgHyMX2gPfvHYyqO3Um524KSVqrpi4Utde
	 RU76HJTGAmsA0FgH/S42sCtJD2ILgOL58AEJBDWre8S+AWRkblVbnqBBnApARvs1Pt
	 rMSGaJYoYE4H+hm4LMD8Axzj6cLz+GoxAWENVlST+s5jNamP6yWJAWMj/y71hxl0fC
	 wkM5BFWxxgYLw==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Tao Cui <cuitao@kylinos.cn>,
	"Matthieu Baerts (NGI0)" <matttbe@kernel.org>,
	Jakub Kicinski <kuba@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.1.y] mptcp: pm: fix extra_subflows underflow on userspace PM subflow creation
Date: Tue, 16 Jun 2026 12:18:46 -0400
Message-ID: <20260616161846.3332083-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026061557-pupil-lumber-1672@gregkh>
References: <2026061557-pupil-lumber-1672@gregkh>
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
index 9016f8900c1928..5260a34a617ebd 100644
--- a/net/mptcp/pm_userspace.c
+++ b/net/mptcp/pm_userspace.c
@@ -410,18 +410,21 @@ int mptcp_nl_cmd_sf_create(struct sk_buff *skb, struct genl_info *info)
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

