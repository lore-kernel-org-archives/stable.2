Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D10BF22579E
	for <stable@vger.kernel.org>; Fri,  7 Aug 2026 02:36:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786070175; cv=none; b=QE+ekmb596OApNgGJRzuR+zq0F1YAgRzmEOniKbu+95lc9TjvsWGSay87awKuKgz4tmy35Ms7G+e5BODYlVMxqLIfMWc1UO4zCtLb8OQm2j9xLOoWkBa+3JKxi8ZC2L3vNfDjv5L8NpljSCmUp5VV+vfK8y+pNMl3aPMuNjPTx8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786070175; c=relaxed/simple;
	bh=vigE+XiK7pquyOS6UBsaaqYWjHOnnV63+0Tq1eGpK5o=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=nbD/qYGIA+sdORcnMFIw5g4cT3uEugapuVdamEfxgC0Df8qwoJw2iX51rCrw1tRhpGKzYakXGCeTFshWVbr2I+GR2710koNHdfncKdS6i8Oow1LQ7/TU9fSzwBSnUhcJoXJQDFPFNK4TEUZAK4JbEQKTPjPDccJlqBTcaxbbgJI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=COaU7qsd; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="COaU7qsd"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E1D861F00A3D;
	Fri,  7 Aug 2026 02:36:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786070173;
	bh=ukCTtVbXG/4Yawb/WHiNRkcb3N2WJJB5UacqM59phkk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=COaU7qsdm69ppcWqHkTNOYraTSfJF/ksYJPf/4gWMvitAjb2wFENa59B4hdVR8RLP
	 S4tTJQ1EAm7NIJ5kzN2kNw0tlkuk7y1baoxR6ovFdLcbLVOc6+bGI300nI26kk9gCI
	 +tQAMoxHDPoGgD957t9hjzhj103upw2dW1iZBnapcaBCetuUtVGhgl9rlpGnFTkPfg
	 eStlHgzswNn1d8+3ZHm9m5EawqIXcxwhfulvsxbn1oMkpyDDOiQ+fFPygRJQ/fOhzW
	 psZ1VDwop4IxfDqJDpSXFF14sd5X2I1Q1dQvmwA8TPohrB/PMOtfVZQxAPmRB/HjdK
	 ftlXXFSRySrwg==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Paolo Abeni <pabeni@redhat.com>,
	Mat Martineau <mathew.j.martineau@linux.intel.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.15.y 2/3] mptcp: fix subflow accounting on close
Date: Thu,  6 Aug 2026 22:36:09 -0400
Message-ID: <20260807023610.1683763-2-sashal@kernel.org>
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

From: Paolo Abeni <pabeni@redhat.com>

[ Upstream commit 95d686517884a403412b000361cee2b08b2ed1e6 ]

If the PM closes a fully established MPJ subflow or the subflow
creation errors out in it's early stage the subflows counter is
not bumped accordingly.

This change adds the missing accounting, additionally taking care
of updating accordingly the 'accept_subflow' flag.

Fixes: a88c9e496937 ("mptcp: do not block subflows creation on errors")
Signed-off-by: Paolo Abeni <pabeni@redhat.com>
Signed-off-by: Mat Martineau <mathew.j.martineau@linux.intel.com>
Signed-off-by: Jakub Kicinski <kuba@kernel.org>
Stable-dep-of: f3ca0ee2cc30 ("mptcp: decrement subflows counter on failed passive join")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 net/mptcp/protocol.h | 14 ++++++++++++++
 net/mptcp/subflow.c  | 12 +++++++++---
 2 files changed, 23 insertions(+), 3 deletions(-)

diff --git a/net/mptcp/protocol.h b/net/mptcp/protocol.h
index 77350a0a0c704..4767b5ea29df4 100644
--- a/net/mptcp/protocol.h
+++ b/net/mptcp/protocol.h
@@ -839,6 +839,20 @@ unsigned int mptcp_pm_get_add_addr_accept_max(const struct mptcp_sock *msk);
 unsigned int mptcp_pm_get_subflows_max(const struct mptcp_sock *msk);
 unsigned int mptcp_pm_get_local_addr_max(const struct mptcp_sock *msk);
 
+/* called under PM lock */
+static inline void __mptcp_pm_close_subflow(struct mptcp_sock *msk)
+{
+	if (--msk->pm.subflows < mptcp_pm_get_subflows_max(msk))
+		WRITE_ONCE(msk->pm.accept_subflow, true);
+}
+
+static inline void mptcp_pm_close_subflow(struct mptcp_sock *msk)
+{
+	spin_lock_bh(&msk->pm.lock);
+	__mptcp_pm_close_subflow(msk);
+	spin_unlock_bh(&msk->pm.lock);
+}
+
 static inline bool mptcp_pm_add_addr_c_flag_case(struct mptcp_sock *msk)
 {
 	return READ_ONCE(msk->pm.remote_deny_join_id0) &&
diff --git a/net/mptcp/subflow.c b/net/mptcp/subflow.c
index b1679c5949906..2ec22660ba7a2 100644
--- a/net/mptcp/subflow.c
+++ b/net/mptcp/subflow.c
@@ -1434,20 +1434,20 @@ int __mptcp_subflow_connect(struct sock *sk, const struct mptcp_addr_info *loc,
 	struct sockaddr_storage addr;
 	int remote_id = remote->id;
 	int local_id = loc->id;
+	int err = -ENOTCONN;
 	struct socket *sf;
 	struct sock *ssk;
 	u32 remote_token;
 	int addrlen;
 	int ifindex;
 	u8 flags;
-	int err;
 
 	if (!mptcp_is_fully_established(sk))
-		return -ENOTCONN;
+		goto err_out;
 
 	err = mptcp_subflow_create_socket(sk, &sf);
 	if (err)
-		return err;
+		goto err_out;
 
 	ssk = sf->sk;
 	subflow = mptcp_subflow_ctx(ssk);
@@ -1510,6 +1510,12 @@ int __mptcp_subflow_connect(struct sock *sk, const struct mptcp_addr_info *loc,
 failed:
 	subflow->disposable = 1;
 	sock_release(sf);
+
+err_out:
+	/* we account subflows before the creation, and this failures will not
+	 * be caught by sk_state_change()
+	 */
+	mptcp_pm_close_subflow(msk);
 	return err;
 }
 
-- 
2.53.0

