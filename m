Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 85CCE21257E;
	Mon,  1 Jun 2026 03:10:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780283456; cv=none; b=DHXevpIgSZpX8hVmMmCDGkmMwArt6fSYMTAmdB5JvYjkLJZil0jTX1u+SIQfjyna6WkBONnYdGY6MxJuq8182odYlOHsjr82b6WH9HUM0RNiDMIs6z7iuFsatnbUzzUfqY+YG8C0D/OAtKL6AJFqvvrxKAE046sXqUMxwseUgHU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780283456; c=relaxed/simple;
	bh=RbIMlTBhX+nwth2ktVhSGSSP8Wft3sWwsEfCV850KPU=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=l754/SHm/XibPM9HanpqOvFMNqKEC1QlilHUTPmcn4h3rxCdox7oHGZF0KurkeKWFdVnEdA6I4zfRapYeOaL3LxIWJTePzm4XUnupWGcByNX3a5HXVBWgDV26y7/TVqqBwJ9mo+6p9bJn2sH1kYzQmENuGlC6dYfJSuHH3xiOtw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=joDMrWWY; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="joDMrWWY"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 513341F00898;
	Mon,  1 Jun 2026 03:10:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780283455;
	bh=GszvUxBaQDM6cXw6ZUDOFBlW4uvlwqG8sNmpgHjMLvE=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc;
	b=joDMrWWYGKQX8mpyBOrXDgS8L5WkLxwaMK2ABpvygehNsvQy+mv+GdCGx/Sdnh7Df
	 RmIiPbaLGN2bkQb3LwXYgd+5lhToHf0M4hXgo59mwcuIyfEDXtKN0RuDWetfqA0wxb
	 WFjHgdeVnhxtTksx7pXYB7R6gDmW32mME888lfy46e80DMz+G+1CsfCj6zJyWNruO9
	 e4qyyBZ7K5vPUhR1lZ5jDywiw4zUN7zLeuL5KdmrVSy8QVQn0Ud3LleY/kleGCFOoO
	 5GWn8BKf2fAQI8NMCy/ei6uebw3KaF7qVx7qIt19v7P/tnZnzTHBQI6SdRuRUS+0op
	 5kPjSDMGi6b6g==
From: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
Date: Mon, 01 Jun 2026 13:10:01 +1000
Subject: [PATCH net 05/10] mptcp: pm: fix extra_subflows underflow on
 userspace PM subflow creation
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260601-net-mptcp-misc-fixes-7-1-rc7-v1-5-a5ae7791754b@kernel.org>
References: <20260601-net-mptcp-misc-fixes-7-1-rc7-v1-0-a5ae7791754b@kernel.org>
In-Reply-To: <20260601-net-mptcp-misc-fixes-7-1-rc7-v1-0-a5ae7791754b@kernel.org>
To: Mat Martineau <martineau@kernel.org>, Geliang Tang <geliang@kernel.org>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 Simon Horman <horms@kernel.org>, Florian Westphal <fw@strlen.de>
Cc: netdev@vger.kernel.org, mptcp@lists.linux.dev, 
 linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org, 
 "Matthieu Baerts (NGI0)" <matttbe@kernel.org>, Tao Cui <cuitao@kylinos.cn>, 
 stable@vger.kernel.org
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=1923; i=matttbe@kernel.org;
 h=from:subject:message-id; bh=7ukesoEXWL1n6AAghVFKroS6WjmMIg9iq0MAWyf9XNo=;
 b=owEBbQKS/ZANAwAIAfa3gk9CaaBzAcsmYgBqHPgeUdPWrOC90oSk/b3RuEYzhSI9SXUiGMytg
 fMmoe6ND7qJAjMEAAEIAB0WIQToy4X3aHcFem4n93r2t4JPQmmgcwUCahz4HgAKCRD2t4JPQmmg
 c91bEACmOi21fbl7qM0ww2YK74tekfYZbboBoN7Jhkw1rOfLXCprcV90Mm6jAtxYUaCjhfAnM5W
 MXA6ZC1/mCteXi451PaU6yHDnWAsDX65GOFpFNL4sa6d1XvckY3Gj/XJiAiOT66uGL5MMoeYg/k
 +CEFeEPqeXZHgOFpyLNkaFJkvnK+1Wrj+sEVJHysK369Bsg4w4uv8uYln09O/LPpoLuA7or7Ot+
 w26BYY4xFrw+JVGJ9T2isYup635jEB3zeIb9MK2EE7731KeYgSF+pd+5zGZzFNnYHj5J9uUfGMv
 W3VWhPn4kg1nta/hacWS8dnItahDte1eKCydm/G/Nr4A42cpJajj4KGCN5tiuNXfMUFNn7dwxPY
 8cFlQxvcNz8MVkWMYaYnRGRs67BhxLXUS7NdjCuHb+WlPRzC7bII1pqgI/1HZFR+/H9ut4T9CSO
 dfi3Hqhn0+4EJ5TqMS+XWguh0FiYAE22Cu629o48Y+6+WwGlsPB/BI3XpvLH5nLveZfqoCQdOGl
 qEw7RvdPP/5Uxlg/OWBpAH52DyeQd+6le+uG+o08QUcCPHqVKJF78mJJ5/sK0850ymhO600irMJ
 gnRZ2JZqSacbr8DiGsrJ/surq5CjRGzPsa9bGJ+7X4lcR0TjTp/6xiVsuyBKO7dBFkTR5NRtL2R
 ELh2ojgS+tmdrbQ==
X-Developer-Key: i=matttbe@kernel.org; a=openpgp;
 fpr=E8CB85F76877057A6E27F77AF6B7824F4269A073

From: Tao Cui <cuitao@kylinos.cn>

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
---
 net/mptcp/pm_userspace.c | 14 ++++++++------
 1 file changed, 8 insertions(+), 6 deletions(-)

diff --git a/net/mptcp/pm_userspace.c b/net/mptcp/pm_userspace.c
index 8cbc1920afb4..0d3a95e676f1 100644
--- a/net/mptcp/pm_userspace.c
+++ b/net/mptcp/pm_userspace.c
@@ -408,19 +408,21 @@ int mptcp_pm_nl_subflow_create_doit(struct sk_buff *skb, struct genl_info *info)
 	local.flags = entry.flags;
 	local.ifindex = entry.ifindex;
 
+	spin_lock_bh(&msk->pm.lock);
+	msk->pm.extra_subflows++;
+	spin_unlock_bh(&msk->pm.lock);
+
 	lock_sock(sk);
 	err = __mptcp_subflow_connect(sk, &local, &addr_r);
 	release_sock(sk);
 
-	if (err)
+	if (err) {
 		GENL_SET_ERR_MSG_FMT(info, "connect error: %d", err);
 
-	spin_lock_bh(&msk->pm.lock);
-	if (err)
+		spin_lock_bh(&msk->pm.lock);
 		mptcp_userspace_pm_delete_local_addr(msk, &entry);
-	else
-		msk->pm.extra_subflows++;
-	spin_unlock_bh(&msk->pm.lock);
+		spin_unlock_bh(&msk->pm.lock);
+	}
 
  create_err:
 	sock_put(sk);

-- 
2.53.0

