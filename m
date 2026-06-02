Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 538473E1231;
	Tue,  2 Jun 2026 12:15:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780402506; cv=none; b=jQe8dkSaKDz7m95FsWriSMt1whL7R4JhJhcCjTZPDmiPyLSosZnKqDmsRoQ1tN7Qj+wIsx44R12xgKuAwChv3cErTAJtaUtt5hAvHG7RfmYylyLWOMZixXVa9ONTIrS8dgMxGcPxUoYlkwbm8SjD0w7M4SezwDUHjwDtMfuY/Ys=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780402506; c=relaxed/simple;
	bh=RbIMlTBhX+nwth2ktVhSGSSP8Wft3sWwsEfCV850KPU=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=GR45rrZtMNwnWjkW0uGqFxpz4uJ623/wT9xbSPjEjEZPr/6bwJB+KnnmmkWWkJrp03IIHQAZOj5IOsHaCgXJau4ZZ4pqHIKPriFm2QLPeirCroihYYPROPJCcFPXUMwoof+xTbvpqZJQuJbgsujX81+WNC+oy02k1dkZS9wLeY8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=anYL2ekO; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="anYL2ekO"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 518741F00899;
	Tue,  2 Jun 2026 12:15:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780402505;
	bh=GszvUxBaQDM6cXw6ZUDOFBlW4uvlwqG8sNmpgHjMLvE=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc;
	b=anYL2ekO3xG7ATE9PPzneakr4Cets8drBTTViQwVThOpz1S2ET6jhGPkIqMDPCC/T
	 ygkbLkRayd6MC6MTrij71BnCdtJNb9EKK4IaVH4blQbRjl7K2+JQDw3ksrxay0iKEu
	 mo5PG6+ZaqkVLEeGWZqUHpw+d8xoAw5AVjNyWGPID59gNHLPpKlU0zWWBIuGCaeKWd
	 Fej0aytYS/UyDIRdfv/4/faDEEdF7lj/0Dxo9jsFCwFid3xEM+16XLPwyBoK3zwLLW
	 kJYTQ+xdL/oXcBCXMR1Ib3aHJ9AlAmJsrdVsDmPXJWym96821P4q7jrZOXyE7aShXD
	 TmOaI4pjFihmA==
From: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
Date: Tue, 02 Jun 2026 22:14:12 +1000
Subject: [PATCH net v2 05/11] mptcp: pm: fix extra_subflows underflow on
 userspace PM subflow creation
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260602-net-mptcp-misc-fixes-7-1-rc7-v2-5-856831229976@kernel.org>
References: <20260602-net-mptcp-misc-fixes-7-1-rc7-v2-0-856831229976@kernel.org>
In-Reply-To: <20260602-net-mptcp-misc-fixes-7-1-rc7-v2-0-856831229976@kernel.org>
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
 b=owEBbQKS/ZANAwAIAfa3gk9CaaBzAcsmYgBqHsksbi2YDv1oHFqBSHFmhgsONSsDTaWJHJTNx
 kBAG9P6hZOJAjMEAAEIAB0WIQToy4X3aHcFem4n93r2t4JPQmmgcwUCah7JLAAKCRD2t4JPQmmg
 cy4kD/9zUAp6YRfI4W/e5jjRIpW3xIKDrQASL32osbKBTHCNnREUP8oHiJT5hdUMcmtET1YJIvn
 8zH16xNL1EIl5V/IYC5tRrwoJd+LAAR7i8/+Sd8y+YWFtAkI0Pjq62T84Ng2ypoKkc6UxW8YP0R
 xqsx/Ba7lY+zedvHHTr0Jjok/cUbN0AF2qRYlEmJi9XM2NO3mU7xISSfX8P5mo8wVmnUczfCRnU
 btoVGufWyHPZ/+Le6giw1N4FKOkUcTUxFvRC2DHbJLfWBlYC89HsEESGPLN5cJbcjdCcqMW7NLw
 8nz8fbU/pFRA/fVaXDW6KYmY3+T1D5ggImzQT+PoKl8PdfsH15UW9N5Fwrr7VefWaBZnE5Xlf/q
 kc0lhOFXhhfVJNhi7aO4i+OZWsjPMXyy/4+MK56QaASc8maxrWpw0raBMpZ01rLQL772jwg4Ein
 jvvJWDC8CdLZkW7Y9RWRX4Q1UlEO2aHUOKev9R+s4M6yON4nIVHXzC7IF5l4vURqtxsORettMxE
 pSNs1twMruzI88wQbToOS2rEJNemw9mKBYX1DWXN4Rd8/NOvCrCUO5974cWOxLAc5rqbN9lB7pT
 R1Fexfw03eDYr7Tpsf3dWOHKVheDXUlCUt3BqBgQcSwTngF/yvfYqhKozwRMbs78mwkfwLLG2FL
 KByQQ2C35uutTRA==
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

