Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7B0A132A3DA
	for <stable@vger.kernel.org>; Tue, 22 Sep 2026 15:13:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790090003; cv=none; b=jfoGhO9YAbJte2YlAdWR7LKH+kY5YN1ucLlbwlGja1uuwVW3cF4rBST/I7yTbNOzxcN1AjWH4h/jgUTZkqdIfxOkNpob6qA1rIQeFr142u0zc0aSY7/qeNjtQpGsuRHgkuNosTuMmebFuLcQd4l8fR8Gfz5xZhm+QpVcLzkFgL4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790090003; c=relaxed/simple;
	bh=BUdDGlO6lCV7j79lPXnmj+LPB60vT9kYO9zkY7H2O2w=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=avAdNX1sLT9mDv2b1nqlDGci+XVweX0oKz4gnnuiFcK5EZ/AiQijwtoVjlJRlQsHwkIeoI1TgQHuLh7mInBLJniKvneyz3G44Q0DmNn4JeiJYY0F7tqYIPhjPmRX3d/ZAMj87mBnX6ySyLV1VxR1cAtIIZZz3C37bI/cXjE3F9Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=DUVtX41Y; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="DUVtX41Y"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 395451F000FF;
	Tue, 22 Sep 2026 15:13:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1790090002;
	bh=WmroLwCsZkucd5a2W2XhORzoBOumkaKX+GBoWLs9nG8=;
	h=Subject:To:Cc:From:Date;
	b=DUVtX41YQBHQBU4l/4EIZz4849+jwYRLU15IxlEnGoCAu8ZQP13W3W5+sWtCUTbR7
	 5z3rEQTCII4cxLwWW0Ny+NcYKndiQVSw4BC8dpGXS+V9bhreH5Q7Qg/I/1hpsgga3L
	 QhdikjMLgqiv6YDtvjOv7NrNMwU6x1XGxiVDjvAA=
Subject: FAILED: patch "[PATCH] smb: client: fix smbd_connection leak on" failed to apply to 5.15-stable tree
To: pc@manguebit.org,bharathsm@microsoft.com,linkinjeon@kernel.org,metze@samba.org,ronniesahlberg@gmail.com,sprasad@microsoft.com,tom@talpey.com
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Tue, 22 Sep 2026 17:06:21 +0200
Message-ID: <2026092221-chive-engaged-cc27@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit


The patch below does not apply to the 5.15-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-5.15.y
git checkout FETCH_HEAD
git cherry-pick -x e75c96157d45e498970158c8f7373d90102e33b9
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2026092221-chive-engaged-cc27@gregkh' --subject-prefix 'PATCH 5.15.y' 'HEAD^..'

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From e75c96157d45e498970158c8f7373d90102e33b9 Mon Sep 17 00:00:00 2001
From: Paulo Alcantara <pc@manguebit.org>
Date: Sat, 12 Sep 2026 14:20:08 -0300
Subject: [PATCH] smb: client: fix smbd_connection leak on
 cifs_get_tcp_session() error

When an RDMA connection is successfully established via
smbd_get_connection() but cifs_get_tcp_session() later fails (e.g.
kthread_create() returns an error), the error path frees tcp_ses
without first destroying the smbd_connection.

Fix this by calling smbd_destroy() in the out_err cleanup path before
kfree(tcp_ses).  smbd_destroy() safely handles the case where
smbd_conn is NULL, so it can be called unconditionally.

Closes: https://sashiko.dev/#/patchset/20260912165503.521597-1-pc%40manguebit.org
Fixes: 2f8946464b11 ("CIFS: SMBD: Upper layer connects to SMBDirect session")
Reviewed-by: Namjae Jeon <linkinjeon@kernel.org>
Signed-off-by: Paulo Alcantara <pc@manguebit.org>
Cc: Tom Talpey <tom@talpey.com>
Cc: Stefan Metzmacher <metze@samba.org>
Cc: Shyam Prasad N <sprasad@microsoft.com>
Cc: Ronnie Sahlberg <ronniesahlberg@gmail.com>
Cc: Bharath SM <bharathsm@microsoft.com>
Cc: Namjae Jeon <linkinjeon@kernel.org>
Cc: stable@vger.kernel.org

diff --git a/fs/smb/client/connect.c b/fs/smb/client/connect.c
index 4bd9f9fb93bb..28e1ddeb6182 100644
--- a/fs/smb/client/connect.c
+++ b/fs/smb/client/connect.c
@@ -1934,6 +1934,7 @@ cifs_get_tcp_session(struct smb3_fs_context *ctx,
 		kfree(tcp_ses->leaf_fullpath);
 		if (tcp_ses->ssocket)
 			sock_release(tcp_ses->ssocket);
+		smbd_destroy(tcp_ses);
 		kfree(tcp_ses);
 	}
 	return ERR_PTR(rc);

