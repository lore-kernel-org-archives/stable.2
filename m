Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4BA8046C4AA;
	Mon, 24 Aug 2026 16:49:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787590143; cv=none; b=UAFPuEh5Jhw0I12mr/vnIZUS24QJ0//6XfFogI+M2HWKOjE+ibbB4f7VjUYTObYoLKI7AnGc0DjResPoOfwPR0WE864qq8txs98APlqtKXst27lnraIslT2e9hwQr+enEenxZRNPHlETE/CaJfChQdMGVP6HMVs25g1MhbLflBA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787590143; c=relaxed/simple;
	bh=+FBPAQNeCbh4Mvnw/tNWB3LSVLgglpExjCKKNXa4l3M=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=h0WM3JHKxcJVCX6SJQ4sczGdWVvPmMHhxToY4/skV19NKCCTnWBr6N9dSyT77mhvbzQ8S3tfVaYM5baHNHrVmwC9AIVvXdOgjTs7SBJtaatyVU2oFu3sYM/vMRrlleQFMvZr8ZuRwZtsakSoOp2KX2sj7k1wLDAXbZizTA2o6zo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ctNuyL8p; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ctNuyL8p"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 75F071F00ACA;
	Mon, 24 Aug 2026 16:48:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1787590141;
	bh=Ry9Eu4FQ67wro1NXnJ+dB+8O1f5fq9fWbkVH9KdHvoM=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc;
	b=ctNuyL8pexlNoEW9NrePYa99u2hPJB+b2LRCalcemogKQKOTP2uOjHaZSjICZoSBu
	 TK7evuoppmk10oWnavdukyqoA8nnrkSWocDqrpq5qoR6mHC3nPzIEhkTCNLpO36Zfi
	 oV48w7anzyJDFN9IRw1MLznFsxFoLtKnyAKNu9d086Zn4LYsx8sMPQ5Wm0M6sr0TNH
	 0NYqfMfx59FzBJ31+4lREPUEPLy7QR8q2Mcvjk3XnNCbE2j5YEzdJE6AdNYZU4734h
	 ODcKfFUNyo7/jye38t7j9bQVpcvby+B9a43LaHWFpWDXkzV19vlTMppg79D0pWqpip
	 1mSB1fvNQNTjg==
From: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
Date: Mon, 24 Aug 2026 18:48:27 +0200
Subject: [PATCH net 07/14] mptcp: pm: userspace: fix address ID overflow
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260824-net-mptcp-misc-fixes-7-3-rc1-v1-7-a92309d121ca@kernel.org>
References: <20260824-net-mptcp-misc-fixes-7-3-rc1-v1-0-a92309d121ca@kernel.org>
In-Reply-To: <20260824-net-mptcp-misc-fixes-7-3-rc1-v1-0-a92309d121ca@kernel.org>
To: Mat Martineau <martineau@kernel.org>, Geliang Tang <geliang@kernel.org>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 Simon Horman <horms@kernel.org>
Cc: netdev@vger.kernel.org, mptcp@lists.linux.dev, 
 linux-kernel@vger.kernel.org, "Matthieu Baerts (NGI0)" <matttbe@kernel.org>, 
 Qing Luo <luoqing@kylinos.cn>, stable@vger.kernel.org, 
 Kishen Maloor <kishen.maloor@intel.com>
X-Mailer: b4 0.16.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=2431; i=matttbe@kernel.org;
 h=from:subject:message-id; bh=veYo+tqcZdu23R8BrIYMlRY2bcPvxR2NXQ7J8ZSw5Xs=;
 b=owGbwMvMwCVWo/Th0Gd3rumMp9WSGLJ6Sh+uYHa2XnXxo2Coo7pOpF2j817mDWFC6RHFmYWlY
 p0PEwI6SlkYxLgYZMUUWaTbIvNnPq/iLfHys4CZw8oEMoSBi1MAJiI5m5Hhr2StpqTWAdcFTXPr
 D9j8PfFtcdYsTYMJ73bFymwSSLD+wfBPJ2ap2taweTobNCarFQpofFuXc+XL4gtdB05adF9acUe
 SHwA=
X-Developer-Key: i=matttbe@kernel.org; a=openpgp;
 fpr=E8CB85F76877057A6E27F77AF6B7824F4269A073

From: Qing Luo <luoqing@kylinos.cn>

When all MPTCP address IDs (1-255) are exhausted in the userspace PM,
find_next_zero_bit() returns MPTCP_PM_MAX_ADDR_ID + 1 (256). This value
overflows when stored in the u8 field e->addr.id, resulting in ID 0
being stored and the entry being incorrectly added to the list.

ID 0 is reserved for the initial connection in MPTCP, so this overflow
can cause address conflicts.

Note: the in-kernel PM already has an 'endpoints == MPTCP_PM_MAX_ADDR_ID'
check in mptcp_pm_nl_append_new_local_addr() that returns -ERANGE before
reaching find_next_zero_bit(), preventing this overflow. So this fix only
addresses the userspace PM path.

Check the find_next_zero_bit() result against MPTCP_PM_MAX_ADDR_ID and
return -ENOSPC if all IDs are truly exhausted. Move the ID allocation
check before the memory allocation so that the error path does not need
to free the allocated entry.

Fixes: 4638de5aefe5 ("mptcp: handle local addrs announced by userspace PMs")
Cc: stable@vger.kernel.org
Assisted-by: LLM:0
Signed-off-by: Qing Luo <luoqing@kylinos.cn>
Reviewed-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
Signed-off-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
---
Cc: Kishen Maloor <kishen.maloor@intel.com>
---
 net/mptcp/pm_userspace.c | 18 ++++++++++++++----
 1 file changed, 14 insertions(+), 4 deletions(-)

diff --git a/net/mptcp/pm_userspace.c b/net/mptcp/pm_userspace.c
index b94fbb483bf9..fab16d953dbf 100644
--- a/net/mptcp/pm_userspace.c
+++ b/net/mptcp/pm_userspace.c
@@ -69,6 +69,19 @@ static int mptcp_userspace_pm_append_new_local_addr(struct mptcp_sock *msk,
 	}
 
 	if (!addr_match && !id_match) {
+		unsigned int id;
+
+		if (!entry->addr.id && needs_id) {
+			id = find_next_zero_bit(id_bitmap,
+						MPTCP_PM_MAX_ADDR_ID + 1, 1);
+			if (id > MPTCP_PM_MAX_ADDR_ID) {
+				ret = -ENOSPC;
+				goto append_err;
+			}
+		} else {
+			id = entry->addr.id;
+		}
+
 		/* Memory for the entry is allocated from the
 		 * sock option buffer.
 		 */
@@ -78,10 +91,7 @@ static int mptcp_userspace_pm_append_new_local_addr(struct mptcp_sock *msk,
 			goto append_err;
 		}
 
-		if (!e->addr.id && needs_id)
-			e->addr.id = find_next_zero_bit(id_bitmap,
-							MPTCP_PM_MAX_ADDR_ID + 1,
-							1);
+		e->addr.id = id;
 		list_add_tail_rcu(&e->list, &msk->pm.userspace_pm_local_addr_list);
 		msk->pm.local_addr_used++;
 		ret = e->addr.id;

-- 
2.53.0

