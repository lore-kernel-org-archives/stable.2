Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 873813655CA
	for <stable@vger.kernel.org>; Tue, 16 Jun 2026 13:07:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781615245; cv=none; b=k7sSlyTqeVrwE7rhx9dd9yEcbqPBP7pwsaTzVfemB87U/1IH8vX2byy6tqanJrFYUFpOR+yHKTAmEA/ZBb0U2h2YY2mKeLYQ3nEO8e+8qLx9CSz69zVuaL/mgB5uB3Hkq3khMIML4GcgQJ36DktfA13ONc/ptKzJJkfj2sW9rn8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781615245; c=relaxed/simple;
	bh=ImyHjghmsJtHtIAQGFmukurQ8wEonod3TzRakpslClE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=MvZIMLjCdAOh9ccHDik7834md+VDQNhYHipwm65Pqo1/CJINLTTQ8HPEsS3441MW4SpSmVDV/3aO7Rp8vP5PZpqa98/6ALxlyP6uoLfnORo5+6+dWoDr2Xw1VSfqv83ylon6joCIMp0tqx7zZVOFnUFKtpcL/bozgVWEcxogd4g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=mJ0eYKa+; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="mJ0eYKa+"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A6CB41F000E9;
	Tue, 16 Jun 2026 13:07:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781615244;
	bh=Q4vWunudosnffQ9vgdoBm//nHtoxWRxrAWPiFA9BoFg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=mJ0eYKa+VsG7gKtX1D0dCqfH/54HZ0CZYYxuemWawhxBCP0G1WCVGp/QkKVwbm1bj
	 p42+ol7l/VbWpsiDvv+tRj9OmVjnP4ab16OHvGVofPUoH0ViDyDct5JsuAMIqUND1A
	 LX/H67VLDNFTDDmZouUCX51yFnmVGYU9InE7NtbW11k59+Oz94q6u0mw9s1cg8nAGt
	 JFKTq0dpKK4OFWoOvViqvOVftXe0lhxTrBePdZjRpvzwmj3dGGYsCbqbigcPRoWJ1u
	 DACbPJ9wyAXq4OTMszh6D1/O0msnijtsL4dk/c8mE4tE4MdWKg9OcaC5FQTIiqr/Cb
	 XJMOWHzASSAKw==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Tao Cui <cuitao@kylinos.cn>,
	"Matthieu Baerts (NGI0)" <matttbe@kernel.org>,
	Jakub Kicinski <kuba@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.12.y] mptcp: pm: fix extra_subflows underflow on userspace PM subflow creation
Date: Tue, 16 Jun 2026 09:07:22 -0400
Message-ID: <20260616130722.3208857-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026061552-credibly-luridness-8035@gregkh>
References: <2026061552-credibly-luridness-8035@gregkh>
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
index bb76295d04c56c..bc3eb242f2980c 100644
--- a/net/mptcp/pm_userspace.c
+++ b/net/mptcp/pm_userspace.c
@@ -402,16 +402,19 @@ int mptcp_pm_nl_subflow_create_doit(struct sk_buff *skb, struct genl_info *info)
 	local.flags = entry.flags;
 	local.ifindex = entry.ifindex;
 
+	spin_lock_bh(&msk->pm.lock);
+	msk->pm.subflows++;
+	spin_unlock_bh(&msk->pm.lock);
+
 	lock_sock(sk);
 	err = __mptcp_subflow_connect(sk, &local, &addr_r);
 	release_sock(sk);
 
-	spin_lock_bh(&msk->pm.lock);
-	if (err)
+	if (err) {
+		spin_lock_bh(&msk->pm.lock);
 		mptcp_userspace_pm_delete_local_addr(msk, &entry);
-	else
-		msk->pm.subflows++;
-	spin_unlock_bh(&msk->pm.lock);
+		spin_unlock_bh(&msk->pm.lock);
+	}
 
  create_err:
 	sock_put(sk);
-- 
2.53.0

