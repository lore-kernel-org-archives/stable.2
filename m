Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4B57449B46B
	for <stable@vger.kernel.org>; Wed, 16 Sep 2026 16:34:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789576493; cv=none; b=g1a0l/9mn6AyYVywgsywr7J1oJoblfWf+wLrKOthcVnIpwY9rtD6ny5oA/F+A79K533Es/YnyUlLBgSaK0ZnI1IQaZ9AuV1hnJ0UDNZTHN6fTuswTdWZh/oQC9FsW7fjupnRdEIha74XGFl6mDd+r5lEiMaxKkNJ6NFRvWe+lDM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789576493; c=relaxed/simple;
	bh=wtN57k1zdct0Vj1RxklRLgUD+/AdcoeXLbOBW1ztyko=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=rloYXk/BtiUVjfkhIpSLxPWT20YNbrtaup3Z06B5fFU8wSLg31BxvmLOXbTWeiEIer2jkML+VKCNxsYWQUkCZZwH8eyHZ11GGjRr6WPxv4tIinvat/4eAzscIxC96gE7Aec8P0LGYh57d83powPlRazdfdOJyAidnY/nBKtSyy0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=kZVF2S1b; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="kZVF2S1b"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 943361F000FF;
	Wed, 16 Sep 2026 16:34:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1789576490;
	bh=LACVHaDQbbzIS5ZI8k3roQv7pKCYIzy+efKPdZUPJqA=;
	h=Subject:To:Cc:From:Date;
	b=kZVF2S1bBcvPMwxay3mx9aeE8/P6rhYYZGHfHy1cNYOFHypPXfc7F+HAyMWTXM6tX
	 j5AIZfaCffHxXrwM8BkLnFJaelwn56u1CXSHjXBptmdfup1mPpAclZ8pabBQeGpsic
	 +7plgzMW9DwsQlwbiAEgnNfUpn0JVImwzosb7zWU=
Subject: FAILED: patch "[PATCH] mptcp: pm: userspace: fix address ID overflow" failed to apply to 6.1-stable tree
To: luoqing@kylinos.cn,kuba@kernel.org,matttbe@kernel.org
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Wed, 16 Sep 2026 17:31:28 +0100
Message-ID: <2026091628-sevenfold-cursive-c662@gregkh>
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
git cherry-pick -x f9f0068e8813d8c10d016b030fc3a320d0b6767c
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2026091628-sevenfold-cursive-c662@gregkh' --subject-prefix 'PATCH 6.1.y' 'HEAD^..'

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From f9f0068e8813d8c10d016b030fc3a320d0b6767c Mon Sep 17 00:00:00 2001
From: Qing Luo <luoqing@kylinos.cn>
Date: Tue, 8 Sep 2026 16:07:13 +0200
Subject: [PATCH] mptcp: pm: userspace: fix address ID overflow

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
Signed-off-by: Qing Luo <luoqing@kylinos.cn>
Reviewed-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
Signed-off-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
Link: https://patch.msgid.link/20260908-net-mptcp-misc-fixes-7-3-rc1-v2-8-df1de70348b6@kernel.org
Signed-off-by: Jakub Kicinski <kuba@kernel.org>

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

