Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 08CA43B3C1F
	for <stable@vger.kernel.org>; Thu, 17 Sep 2026 03:35:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789616150; cv=none; b=rCaV7XED0zS5CkSDU/nx6pBAu6r7R6ZvUx+iB+TxT4BeMq3jYYnRVbI3RxUlgGXDfd5oqX9nWKBRNJdpkYB4i2Ad9cpg3IR4L8kfkzAo3bFSxkPnQh1Ee3aSP8sbEem5Tf+uG881JiSgCw80E/bswUxZOuhb9lFRNl57BQvGb3A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789616150; c=relaxed/simple;
	bh=F47ux483fxezdFAlLquaQqAUbt0cgRy66rgtrQ9+JIU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=XFuTdbeJ3XrJl+sKApZ61oBcqPNFOpAnU1TMZjkC/0JtczL93AnoduUeXeDn6gSrbyulew1UoupdklWGjdm5g59DqSxosybfmIcZCCDU4rj4i8zEUCMjtXu8Fbc0TJK0qKlV66xNKfa501rOImqgx/g0n0kp+D2WNKhYlD+gNhQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=LeaSpcG0; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="LeaSpcG0"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7685A1F000FF;
	Thu, 17 Sep 2026 03:35:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789616139;
	bh=Zi6wzlXQzDcI+qMsbXSmanvoTI5Md548umyBalKWwpI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=LeaSpcG0c14PIo0DzOJxz+pnv13n2HHzJOexmIJAY7zMD6ia0865MuG8Ohaf05fsM
	 5h11pjUyJe0e6DNpwLp3fm8hQbwnWaxnsn+vG9ZsSWpNH4YSUbLHea9+9ndbDkYFuH
	 ocyo94h/KNDWOzYMwOnOUYabyoKE18jcB3ZVa1+kMmA3x5Z0d0kCk5NAVNBCs6+CAP
	 iSwfjJS1u5HODxb226Kh5Pg8Tjg5mXcQN8tY0+xgXMv9cETsvbJuC5tjC2lnQLPevC
	 6xtjwyZIM7jk3yImGuYuvbgYQUAFzXDlyzCB/QX5oEr0shAF3+AZKIFpXNHH1T1cNt
	 y8jPue8Xs18WQ==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Matthieu Baerts <matthieu.baerts@tessares.net>,
	Mat Martineau <mathew.j.martineau@linux.intel.com>,
	Paolo Abeni <pabeni@redhat.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.1.y 1/5] mptcp: userspace pm: use a single point of exit
Date: Wed, 16 Sep 2026 23:35:32 -0400
Message-ID: <20260917033537.4044281-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026091628-sevenfold-cursive-c662@gregkh>
References: <2026091628-sevenfold-cursive-c662@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Matthieu Baerts <matthieu.baerts@tessares.net>

[ Upstream commit 40c71f763f87b68fe43199c1702220c91afed288 ]

Like in all other functions in this file, a single point of exit is used
when extra operations are needed: unlock, decrement refcount, etc.

There is no functional change for the moment but it is better to do the
same here to make sure all cleanups are done in case of intermediate
errors.

Reviewed-by: Mat Martineau <mathew.j.martineau@linux.intel.com>
Signed-off-by: Matthieu Baerts <matthieu.baerts@tessares.net>
Signed-off-by: Paolo Abeni <pabeni@redhat.com>
Stable-dep-of: f9f0068e8813 ("mptcp: pm: userspace: fix address ID overflow")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 net/mptcp/pm_userspace.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/net/mptcp/pm_userspace.c b/net/mptcp/pm_userspace.c
index 52ab9a3f070a8..129ae1fef054e 100644
--- a/net/mptcp/pm_userspace.c
+++ b/net/mptcp/pm_userspace.c
@@ -77,8 +77,8 @@ static int mptcp_userspace_pm_append_new_local_addr(struct mptcp_sock *msk,
 		 */
 		e = sock_kmalloc(sk, sizeof(*e), GFP_ATOMIC);
 		if (!e) {
-			spin_unlock_bh(&msk->pm.lock);
-			return -ENOMEM;
+			ret = -ENOMEM;
+			goto append_err;
 		}
 
 		*e = *entry;
@@ -93,6 +93,7 @@ static int mptcp_userspace_pm_append_new_local_addr(struct mptcp_sock *msk,
 		ret = entry->addr.id;
 	}
 
+append_err:
 	spin_unlock_bh(&msk->pm.lock);
 	return ret;
 }
-- 
2.53.0

