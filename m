Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8CFFF4B04B4;
	Sun,  9 Aug 2026 02:32:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786242736; cv=none; b=f1/UgcDbVLwfRwy3v562Q+sd2cz6rLDVPwoP/XUpv9pwS8IkyeKY/RZNz3LNg/byBjOFj1Z05hFi8QdY5q9jLDqG8LZR512Q5Nfli8ngR+xX5CWGuINSqgk9lqo4Pmxn87bd07+kRYqTg/jVLAUhRvuGZvhOGDPGusB1NRkcno8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786242736; c=relaxed/simple;
	bh=naau0ZOdwTgmpgP6cMAH3GyyjG/taDOzyWzYW6EhqFA=;
	h=Message-ID:Date:From:To:Cc:Subject:References:MIME-Version:
	 Content-Type; b=f8eBUmWVXA2iyywyAOAux+UclWzGdDzUTSQx+CVlrGpq521mK8rjjWtoli8ADMFpQMEKWrs7vCje1ISkuv/ZNklHOwLgO3nIYdHtO+tLBkwM6jOaS+XTBPvJRMLuzw1EEjYfmbvncCMho9GHguGK2zO0W/xjeNC0NRk1v7nnH8M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=dwzlAUl4; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="dwzlAUl4"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2DCB01F000E9;
	Sun,  9 Aug 2026 02:32:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786242735;
	bh=uqDm7PtLMIMrxxQDn6i+3zQIKR04zfptQqpulm1NEP0=;
	h=Date:From:To:Cc:Subject:References;
	b=dwzlAUl4R3s2t7Dg/kJFoXTKnfLrrsnXjxiLNKWifFeb8UzkZNsd2o8ZymOZ5XZPn
	 cwuOru7O0vBKjWzZBuzcLFHV66TO96aGkUrYrIWZkAMGTlYzk6nSs62FxJvGPgr/S5
	 fBXBRru5rjLDnXJ7IKSOn+x+RJOrJrulmUFpZygNS5xkuJQ/wRvmdL1I2LhNjwxspt
	 nRIKjsYifUc/Pm8cQ35/YByC4dFUgh/EBJ61nuKX8on2Dp4hiQroFPnkUQQ/XLmetf
	 LjnEu+yNnS7HREFExArkZV4VWxkJvZYn/cwbvFr6P6ZJzJzq+yNzi4wUYZ1qqD1lqT
	 mYSgdtzI0qOvg==
Received: from rostedt by gandalf with local (Exim 4.99.4)
	(envelope-from <rostedt@kernel.org>)
	id 1wstKn-00000001N2l-28sU;
	Sat, 08 Aug 2026 22:32:21 -0400
Message-ID: <20260809023221.366243140@kernel.org>
User-Agent: quilt/0.69
Date: Sat, 08 Aug 2026 22:31:45 -0400
From: Steven Rostedt <rostedt@kernel.org>
To: linux-kernel@vger.kernel.org
Cc: Masami Hiramatsu <mhiramat@kernel.org>,
 Mark Rutland <mark.rutland@arm.com>,
 Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
 Andrew Morton <akpm@linux-foundation.org>,
 stable@vger.kernel.org,
 Shuangpeng Bai <shuangpeng.kernel@gmail.com>
Subject: [for-linus][PATCH 01/12] eventfs: Fix use-after-free in eventfs_remove_rec()
References: <20260809023144.852271250@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8

From: Shuangpeng Bai <shuangpeng.kernel@gmail.com>

eventfs_remove_rec() recursively removes the child at the current loop
position. After the recursive call returns, list_for_each_entry() advances
by reading list.next from the removed child.

If free_ei() drops the final reference, release_ei() reuses the list/rcu
union to queue an SRCU callback. The child may be freed before that read.
The eventfs_mutex serializes list updates, but it does not keep the removed
child alive or prevent the SRCU callback from running.

Use list_for_each_entry_safe() to save the next sibling before recursively
removing the current child.

Cc: stable@vger.kernel.org
Fixes: 43aa6f97c2d0 ("eventfs: Get rid of dentry pointers without refcounts")
Link: https://patch.msgid.link/20260806022719.375354-1-shuangpeng.kernel@gmail.com
Signed-off-by: Shuangpeng Bai <shuangpeng.kernel@gmail.com>
Acked-by: Masami Hiramatsu (Google) <mhiramat@kernel.org>
Signed-off-by: Steven Rostedt <rostedt@goodmis.org>
---
 fs/tracefs/event_inode.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/fs/tracefs/event_inode.c b/fs/tracefs/event_inode.c
index 39c7a34531e8..93bc4f83b73e 100644
--- a/fs/tracefs/event_inode.c
+++ b/fs/tracefs/event_inode.c
@@ -822,7 +822,7 @@ struct eventfs_inode *eventfs_create_events_dir(const char *name, struct dentry
  */
 static void eventfs_remove_rec(struct eventfs_inode *ei, int level)
 {
-	struct eventfs_inode *ei_child;
+	struct eventfs_inode *ei_child, *tmp;
 
 	/*
 	 * Check recursion depth. It should never be greater than 3:
@@ -835,7 +835,7 @@ static void eventfs_remove_rec(struct eventfs_inode *ei, int level)
 		return;
 
 	/* search for nested folders or files */
-	list_for_each_entry(ei_child, &ei->children, list)
+	list_for_each_entry_safe(ei_child, tmp, &ei->children, list)
 		eventfs_remove_rec(ei_child, level + 1);
 
 	list_del_rcu(&ei->list);
-- 
2.53.0


