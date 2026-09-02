Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9A27F4A99B8;
	Wed,  2 Sep 2026 15:39:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788363593; cv=none; b=rz4avB1vyCtUQD1BCS91Fcm4L9DaMVFqWFQOHbMLoQHw1mVJUutPa08AFhRoluCL8VzURGNJeaAR/ShP6jrkjb/q+5kZ+pxdqJKQVEUnM8gkUcn7Xptvv6/85ivCSFFZ+5tclZ+pvLjTiwYMonKuDTrXzK4x11hYyH4Gs1cprW4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788363593; c=relaxed/simple;
	bh=ZueZF0HqCIE8XIxhpG8dmdNaf+xe/ks40nkmyLsrEaM=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=jXgBseLCow1LIRW+KmAGkN1t61UUzM4O8GKKnZQFITp3yvmKwv9WX7i99kw7MHC5rCenCNr+j+1ZLq7Z1nzfoYyugkCj5/c3iKK4iawdPVNxSKF1Gj3NU0K0MsCC+eE44dGbYYhYnQlZEpKClSFKY0g9GLCt6Z2r/VIm7IAWHIo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=tEVEXxvS; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="tEVEXxvS"
Received: by smtp.kernel.org (Postfix) with ESMTPS id 23194C2BCC7;
	Wed,  2 Sep 2026 15:39:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1788363593;
	bh=ZueZF0HqCIE8XIxhpG8dmdNaf+xe/ks40nkmyLsrEaM=;
	h=From:Date:Subject:To:Cc:Reply-To:From;
	b=tEVEXxvSzUBdJNjyxoXVRwLEDgJANyL+ZbhbHIw1a2sSvJxHjJuiD0fync61gciIj
	 ST8AnrHD/hyoZDN6KeSKZXE9eyW6aHvba/ml8dAhMTb+Q+f6W1KoZG8q9SiDr7gFxK
	 DcE4qFGYSR8oN153WxpeHFX4x8ZngsG7aqQnx2l1Pk03J1xR8h0Vw4WhOzTZXI8HL4
	 ayu2CEpWAJYs8fJd4Kt731pbvs6CCjeANw+ZwOp+vojRixZnQX28QE8H7hoGmo5XfF
	 NFdPqOMt5Jhqy7lT8hiW8A9eRkN+r4LDrAl+jO26vtTqeCe093dkkdsouKA1zJcPeX
	 a2ovRQZb+2q9Q==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F2F03C624D4;
	Wed,  2 Sep 2026 15:39:52 +0000 (UTC)
From: Quanye Yang via B4 Relay <devnull+quanyeyang.proton.me@kernel.org>
Date: Wed, 02 Sep 2026 23:39:41 +0800
Subject: [PATCH mptcp-net] mptcp: pm: cap userspace extra_subflows at
 U8_MAX
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260902-mptcp-pm-extra-subflows-v1-1-68540a866e5a@proton.me>
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/yWMQQrCMBAAv1L27EKSgzV+RTzEdFdXbBqyUQulf
 ze1x2GYWUCpCCmcuwUKfURlSg3soYP4COlOKENjcMYdjTcOx1xjxjwizbUE1PeNX9NXceDAvWf
 L1p+g1bkQy/w/X2CPElW47qplT4p1O8O6/gCdgIayhgAAAA==
X-Change-ID: 20260902-mptcp-pm-extra-subflows-dfaf79f1f198
To: MPTCP Linux <mptcp@lists.linux.dev>
Cc: stable@vger.kernel.org, Quanye Yang <quanyeyang@proton.me>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1788363590; l=2427;
 i=quanyeyang@proton.me; s=20260801; h=from:subject:message-id;
 bh=+jfn89CDI/g1UvxfJ7Ik7RDNGDH+6qQ2aiBRuMEY2cY=;
 b=bVQdvZ37Klkrs9hOECOB2sv2DGJEHzlvD4P/XBqCiDGRq6uqW+lGKa5JnUopiszMa7GKjDdZW
 vcmg641hIUlBqT1Gtghzypwv/iI/SXpz7jk0U/gydbvcHZtblnBKkwe
X-Developer-Key: i=quanyeyang@proton.me; a=ed25519;
 pk=9L9FrcvzMgxPaBRU6XV0EnqTgjDqVO596rQKSZ9qZoY=
X-Endpoint-Received: by B4 Relay for quanyeyang@proton.me/20260801 with
 auth_id=963
X-Original-From: Quanye Yang <quanyeyang@proton.me>
Reply-To: quanyeyang@proton.me

From: Quanye Yang <quanyeyang@proton.me>

The userspace PM increments extra_subflows with no upper bound. The
field is a u8, so the 256th extra subflow wraps the counter to 0 and
the next close hits WARN_ON_ONCE().

Refuse admission at U8_MAX for incoming MP_JOIN and for the Netlink
create path.

Fixes: 77e4b94a3de6 ("mptcp: update userspace pm infos")
Cc: stable@vger.kernel.org
Link: https://github.com/multipath-tcp/mptcp_net-next/issues/629
Signed-off-by: Quanye Yang <quanyeyang@proton.me>
---
 net/mptcp/pm.c           |  6 ++++--
 net/mptcp/pm_userspace.c | 20 +++++++++++++-------
 2 files changed, 17 insertions(+), 9 deletions(-)

diff --git a/net/mptcp/pm.c b/net/mptcp/pm.c
index b0b71adefb8f..d2ea0bd39a69 100644
--- a/net/mptcp/pm.c
+++ b/net/mptcp/pm.c
@@ -563,9 +563,11 @@ bool mptcp_pm_allow_new_subflow(struct mptcp_sock *msk)
 	if (mptcp_pm_is_userspace(msk)) {
 		if (mptcp_userspace_pm_active(msk)) {
 			spin_lock_bh(&pm->lock);
-			pm->extra_subflows++;
+			ret = pm->extra_subflows < U8_MAX;
+			if (ret)
+				pm->extra_subflows++;
 			spin_unlock_bh(&pm->lock);
-			return true;
+			return ret;
 		}
 		return false;
 	}
diff --git a/net/mptcp/pm_userspace.c b/net/mptcp/pm_userspace.c
index fab16d953dbf..6d798dd96702 100644
--- a/net/mptcp/pm_userspace.c
+++ b/net/mptcp/pm_userspace.c
@@ -427,16 +427,22 @@ int mptcp_pm_nl_subflow_create_doit(struct sk_buff *skb, struct genl_info *info)
 	local.ifindex = entry.ifindex;
 
 	spin_lock_bh(&msk->pm.lock);
-	msk->pm.extra_subflows++;
-	spin_unlock_bh(&msk->pm.lock);
+	if (msk->pm.extra_subflows == U8_MAX) {
+		spin_unlock_bh(&msk->pm.lock);
+		GENL_SET_ERR_MSG(info, "too many extra subflows");
+		err = -ENOSPC;
+	} else {
+		msk->pm.extra_subflows++;
+		spin_unlock_bh(&msk->pm.lock);
 
-	lock_sock(sk);
-	err = __mptcp_subflow_connect(sk, &local, &addr_r);
-	release_sock(sk);
+		lock_sock(sk);
+		err = __mptcp_subflow_connect(sk, &local, &addr_r);
+		release_sock(sk);
+		if (err)
+			GENL_SET_ERR_MSG_FMT(info, "connect error: %d", err);
+	}
 
 	if (err) {
-		GENL_SET_ERR_MSG_FMT(info, "connect error: %d", err);
-
 		spin_lock_bh(&msk->pm.lock);
 		mptcp_userspace_pm_delete_local_addr(msk, &entry);
 		spin_unlock_bh(&msk->pm.lock);

---
base-commit: 9fbdf9ec14b806afdf66ea265477cb9d4790c866
change-id: 20260902-mptcp-pm-extra-subflows-dfaf79f1f198

Best regards,
--  
Quanye Yang <quanyeyang@proton.me>


