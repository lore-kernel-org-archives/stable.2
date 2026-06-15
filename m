Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 63D133F5BF8
	for <stable@vger.kernel.org>; Mon, 15 Jun 2026 14:26:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781533606; cv=none; b=DkVWx/IEjpvh1TmZLyREH89odQSuDg9Rz4ZEu/0MTY3lnho/uUid3xK9V6wWwrHRZiH4yqm/X5Rfvx0IW9+AsJqu1UCaIh1f2LoaRpDwS32zF+bugFACI2zkzYhlG3HlkyExsBLmbv4kAHGk6lVXJxYpM5BDFORk+0fbmXYfbcI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781533606; c=relaxed/simple;
	bh=oH3SrJLnNXZwTUp39PJyo373uGEWezUTtYa318H3XFo=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=dSf7jjrWvngG68TmBLDcjEt5NfFrza3SVlApRvbrerFDu+gitYYaLJQKE57frZB8n0y70LQC3dgfIDvRr0G30yDh5vfRQeRtyWq9fMIzLTFvFz1qCgaNU2dtVuFbwMeLx1fnVNHsHfqfNtScdqDE7QCXe0wWNRRsJ4qj8T6ZM8Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=ykdEjJHN; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="ykdEjJHN"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AD6ED1F000E9;
	Mon, 15 Jun 2026 14:26:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1781533605;
	bh=vmOXy3uTcrq4dmO5QgjkwXAv4qI6lIp1dVdj/CCa0bU=;
	h=Subject:To:Cc:From:Date;
	b=ykdEjJHNWTQdO0ug35rq5Vx25Dy7WQAIywev5JfZUFPKEFfqm96wDcOksDfdyERVn
	 bx24A/SEjnHC3gPjqD8BZuBNjPrwfgULgY8+gZ/iQpXjH6wJFH+BOmw3m1k8SiiF2Y
	 wFCE1MmG4WTkvA5QV9XEsA2vYrWy2S3zTv+VRM3M=
Subject: FAILED: patch "[PATCH] mptcp: pm: fix extra_subflows underflow on userspace PM" failed to apply to 6.1-stable tree
To: cuitao@kylinos.cn,kuba@kernel.org,matttbe@kernel.org
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Mon, 15 Jun 2026 16:24:57 +0200
Message-ID: <2026061557-pupil-lumber-1672@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit


The patch below does not apply to the 6.1-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-6.1.y
git checkout FETCH_HEAD
git cherry-pick -x 14e9fea30b68fc75b2b3d97396a7e6adb544bd2a
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2026061557-pupil-lumber-1672@gregkh' --subject-prefix 'PATCH 6.1.y' HEAD^..

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From 14e9fea30b68fc75b2b3d97396a7e6adb544bd2a Mon Sep 17 00:00:00 2001
From: Tao Cui <cuitao@kylinos.cn>
Date: Tue, 2 Jun 2026 22:14:12 +1000
Subject: [PATCH] mptcp: pm: fix extra_subflows underflow on userspace PM
 subflow creation

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

