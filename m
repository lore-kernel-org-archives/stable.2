Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1EE40443E5E
	for <stable@vger.kernel.org>; Sat,  3 Oct 2026 15:28:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791041315; cv=none; b=EaWvvRUEa4RON3MbseABicDohozEjuKeRW32uEaRnZOej2E9/l23i5bLGQsNz7ANw5mTkO2OYiPoDsAlJduEaCouYdTlNx/6qmoIl1cPUwhqjN2LcDnzckCkImZZLbYN3zpc59PkylgF08rUQg/7ms/Z/UxuI4FF3ZLMQzwJ4sE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791041315; c=relaxed/simple;
	bh=00pN1ZpVUH3xzZIp0Nc7nTKxWfMOQOtYfF/X7RUJBtg=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=upQBjKVnEvQfrQbH5Ryy4HlHI+SVXt6EeKjRVDFJY00lF/vA6VafL+q2wFK4+vkpjwPkCP5z6ES75f9Fx/O1i1CmM1w1RkP+KFYKSx63cmWcUskFoDL46Xt/G+iXJHa1XqwFhQadtyZyVa/NhgimEWdSZDoB0CADiHJWeJCbfKs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=M3W8duU9; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="M3W8duU9"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E30BE1F00A2A;
	Sat,  3 Oct 2026 15:28:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1791041306;
	bh=KiOnndoLqgBW0W9xWdTzbbHA2Vg9/2aDo6SJe5pKq7Q=;
	h=Subject:To:Cc:From:Date;
	b=M3W8duU9xkFSa8WrTCx8vetFnlya68fi9DHHyv0M91S/w3jo5bCede1vJ1MlJZNs2
	 QCABX4dCRFt4n0DEFt+KVZcUavN5obnh2kmqSZI2H8KJqyV8IWO01xSsCnFejvarbk
	 VDGaqE4q+iEFLTO8yXxyhUZ1zFaBD/qcwlJuiUNU=
Subject: FAILED: patch "[PATCH] netfs: zero the tail of a short DIO/unbuffered read" failed to apply to 6.18-stable tree
To: pc@manguebit.org,bharathsm@microsoft.com,brauner@kernel.org,dhowells@redhat.com,linkinjeon@kernel.org,ronniesahlberg@gmail.com,sprasad@microsoft.com,tom@talpey.com,willy@infradead.org
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Sat, 03 Oct 2026 17:18:38 +0200
Message-ID: <2026100338-stonework-justness-8ac0@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit


The patch below does not apply to the 6.18-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-6.18.y
git checkout FETCH_HEAD
git cherry-pick -x dd05add7b2b6004c5fa3a1f276f56d8668f86b65
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2026100338-stonework-justness-8ac0@gregkh' --subject-prefix 'PATCH 6.18.y' 'HEAD^..'

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From dd05add7b2b6004c5fa3a1f276f56d8668f86b65 Mon Sep 17 00:00:00 2001
From: Paulo Alcantara <pc@manguebit.org>
Date: Sat, 26 Sep 2026 19:20:30 -0300
Subject: [PATCH] netfs: zero the tail of a short DIO/unbuffered read

The buffered read collector zero-fills the tail of a short read that
stops below the inode's i_size (netfs_clear_unread()), so a read that
races an extending write still returns the expected number of bytes.
The non-buffered collector path does no such thing: it just records
how much was transferred.

Add the same zero-fill for the non-buffered case, gated on
NETFS_SREQ_CLEAR_TAIL: a subreq's source sets that flag when a short
result from it is known to be safe to treat as a hole, as opposed to
NETFS_SREQ_HIT_EOF, which means the read genuinely ran off the end of
the file and should be reported short as-is. Only CLEAR_TAIL should
zero-fill here; a real EOF must stay a real short read.

No source currently sets CLEAR_TAIL on an unbuffered/DIO subrequest,
so this is inert on its own -- a following change teaches cifs to set
it in the one case that needs it.

Fixes: e2d46f2ec332 ("netfs: Change the read result collector to only use one work item")
Reviewed-by: David Howells <dhowells@redhat.com>
Reviewed-by: Namjae Jeon <linkinjeon@kernel.org>
Signed-off-by: Paulo Alcantara <pc@manguebit.org>
Cc: Christian Brauner <brauner@kernel.org>
Cc: Matthew Wilcox <willy@infradead.org>
Cc: Ronnie Sahlberg <ronniesahlberg@gmail.com>
Cc: Shyam Prasad N <sprasad@microsoft.com>
Cc: Tom Talpey <tom@talpey.com>
Cc: Bharath SM <bharathsm@microsoft.com>
Cc: stable@vger.kernel.org

diff --git a/fs/netfs/read_collect.c b/fs/netfs/read_collect.c
index a94197ef0181..c5bfaf2c6f25 100644
--- a/fs/netfs/read_collect.c
+++ b/fs/netfs/read_collect.c
@@ -33,6 +33,22 @@ static void netfs_clear_unread(struct netfs_io_subrequest *subreq)
 		__set_bit(NETFS_SREQ_HIT_EOF, &subreq->flags);
 }
 
+static void netfs_clear_unread_dio(struct netfs_io_subrequest *subreq)
+{
+	uoff_t pos = subreq->start + subreq->transferred;
+	struct netfs_io_request *rreq = subreq->rreq;
+	size_t fill;
+
+	if (pos >= rreq->i_size)
+		return;
+
+	fill = min_t(uoff_t, rreq->i_size - pos,
+		     subreq->len - subreq->transferred);
+
+	netfs_reset_iter(subreq);
+	subreq->transferred += iov_iter_zero(fill, &subreq->io_iter);
+}
+
 /*
  * Cancel the copy-to-cache mark on a folio.
  */
@@ -311,6 +327,14 @@ static void netfs_collect_read_results(struct netfs_io_request *rreq)
 			    test_bit(NETFS_SREQ_HIT_EOF, &front->flags))
 				netfs_read_unlock_folios(rreq, &notes);
 		} else {
+			if (!(notes & HIT_PENDING) &&
+			    front->error == 0 &&
+			    transferred < front->len &&
+			    test_bit(NETFS_SREQ_CLEAR_TAIL, &front->flags)) {
+				netfs_clear_unread_dio(front);
+				transferred = front->transferred;
+				trace_netfs_sreq(front, netfs_sreq_trace_clear);
+			}
 			stream->collected_to = front->start + transferred;
 			rreq->collected_to = stream->collected_to;
 		}

