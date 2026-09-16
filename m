Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D62E84B8282
	for <stable@vger.kernel.org>; Wed, 16 Sep 2026 16:34:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789576489; cv=none; b=Nt53FDbAdTcPk95aiFudnTg+gICCQPegtcyCiMTNYzlfvEbAPBcBF5awRNb2xM88RFbWBIL70KALuJat95Q12qgN5iwJ3/IMWvSEu9adYTivLagXvPMqkp3JFrgmjIQTtEC3J66M+5e2mvAKrR/YEFMGDMZ7cKI8Rl0zFb3ejx0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789576489; c=relaxed/simple;
	bh=qO3w0xAM6qdXOoQw1JWft4dGybQtgiwRvwjA/KexxgY=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=XOsSYzzvx8qQW5D4MBw+WQUcR9gyqKuxNqX5JZpZ7030k0WGKt9zBKqknB7FWAvGuFtKV0+Xt3si1aekVFI1GeizZr9JU57u4G6fgGm1KWyoI141i9h2pVYiDJGxuOTrpd2LLDEft+i04wAmE8bYf8C/knri2Y30jHYldesuWy0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=GWxkLWB8; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="GWxkLWB8"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 817331F000FF;
	Wed, 16 Sep 2026 16:34:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1789576487;
	bh=WyPA716xmB/izpgee2Vyx7fxJbdvskPd75B1Q6FUUrQ=;
	h=Subject:To:Cc:From:Date;
	b=GWxkLWB88zWQTy3dNi1GV0Xvvkk3xFDwZl+rZ7U9GdK5JWXzZiaQ8gp6+xYZw4iBT
	 w9x85Xqmwb2fyirHTUIrQaSEQ9reSQevkoKjyzgS4jpybOYTU20bxL1cMz0xNsgmC8
	 F5FMRclGFd8U+2KJb8YRjxDCu1laCxhM08+sEgog=
Subject: FAILED: patch "[PATCH] mptcp: pm: userspace: fix address ID overflow" failed to apply to 6.6-stable tree
To: luoqing@kylinos.cn,kuba@kernel.org,matttbe@kernel.org
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Wed, 16 Sep 2026 17:31:27 +0100
Message-ID: <2026091627-sleep-poem-4828@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit


The patch below does not apply to the 6.6-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-6.6.y
git checkout FETCH_HEAD
git cherry-pick -x f9f0068e8813d8c10d016b030fc3a320d0b6767c
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2026091627-sleep-poem-4828@gregkh' --subject-prefix 'PATCH 6.6.y' 'HEAD^..'

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

