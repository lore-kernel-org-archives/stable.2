Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C45D1387364
	for <stable@vger.kernel.org>; Tue, 22 Sep 2026 15:13:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790090000; cv=none; b=PN9AQ6lzqTK3LtlzyQcYFri2Vk/O8OVkPijFNmdGscBYTJGVRXNzozaD9AS9wq3+R9sFmXQTwetQB7MoDnvU7Z1rzDaXas/lb0gaS9dmy7CGFvtLUj8DZ5de/BzA12gXP9ZKDcX6/F4Ox3F1OfGkN9cq6cpddt1/lfXEuHJupL0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790090000; c=relaxed/simple;
	bh=EQ1iHlIvn2U9UbBoo0iM7RmuD9umrMQQmUDbRfsl9tA=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=UWab83WQobswJpaHxqmcUQoCbKvCTFFQINhj9xGl9txxRq7ZDE64r2ltYiSPbTXJ/y+tpd7DAwt/5ezUHcEvs7hpUDBF3xvzbRjX2tsErjOf8iN9U48GWYc6FcB/3jy6FW5lR0TaCpGnOtzcVoS2UDz/hRNDrxLkfPQOf+QA89U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=ozd5abPA; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="ozd5abPA"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7FE081F000FF;
	Tue, 22 Sep 2026 15:13:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1790089998;
	bh=b5UaBmps7lfXOSa3G3SWmaymVVzcBbk/qxp3LFESPEk=;
	h=Subject:To:Cc:From:Date;
	b=ozd5abPAJqsgDVhkG1kYk23pIB/ZMqs8vyj6ikxy/xIlANTHd6CP7wuPoVuiQledl
	 +QnxOHW13BUJpcd5L3h4FuilBScDTMRtYtb8EwlNppztW6TBvQxaPncvgn6CyrD8Ol
	 USAxR5jQedGYTBItVGW68uszLuukg+6MoWTV0avs=
Subject: FAILED: patch "[PATCH] smb: client: fix use-after-free of iface in" failed to apply to 6.1-stable tree
To: joseph.qi@linux.alibaba.com,pc@manguebit.org,sprasad@microsoft.com
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Tue, 22 Sep 2026 17:05:55 +0200
Message-ID: <2026092255-baked-regroup-d5f6@gregkh>
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
git cherry-pick -x d034e836eefd7ce75e588f7031cffbeec594f5ac
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2026092255-baked-regroup-d5f6@gregkh' --subject-prefix 'PATCH 6.1.y' 'HEAD^..'

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From d034e836eefd7ce75e588f7031cffbeec594f5ac Mon Sep 17 00:00:00 2001
From: Joseph Qi <joseph.qi@linux.alibaba.com>
Date: Tue, 1 Sep 2026 09:04:13 +0800
Subject: [PATCH] smb: client: fix use-after-free of iface in
 cifs_try_adding_channels()

cifs_try_adding_channels() iterates ses->iface_list with
list_for_each_entry_safe_from(), which captures the next entry
(niface) under iface_lock.  The loop body then drops iface_lock for
the whole duration of cifs_ses_add_channel().

A concurrent interface refresh (SMB3_request_interfaces() ->
parse_server_interfaces()) marks all ifaces inactive and removes and
frees any that are not re-advertised via list_del() + kref_put(),
where release_iface() is a bare kfree().  Since niface typically has
no channel holding a reference, the list reference is its last and it
can be freed inside the unlocked window.  On continue, the iterator
advance step then dereferences niface->iface_head.next, and the loop
body reads iface->rdma_capable/is_active, both on freed memory.

Fix this by never keeping an unreferenced list pointer across the
unlocked window.  Each channel attempt now re-scans the list from the
head under iface_lock, takes a kref on the selected candidate, and
passes only that referenced candidate to cifs_ses_add_channel().
weight_fulfilled still tracks selection progress, so restarting the
scan preserves the original weighted distribution and the
weight_fulfilled-before-kref_put ordering on the failure path.

Add a per-pass attempts cap so a flapping interface refresh cannot
keep the inner loop spinning within a single tries increment.

Fixes: aa45dadd34e4 ("cifs: change iface_list from array to sorted linked list")
Cc: stable@vger.kernel.org
Assisted-by: Qoder:Qwen3.8-Max
Signed-off-by: Joseph Qi <joseph.qi@linux.alibaba.com>
Acked-by: Shyam Prasad N <sprasad@microsoft.com>
Signed-off-by: Paulo Alcantara <pc@manguebit.org>

diff --git a/fs/smb/client/sess.c b/fs/smb/client/sess.c
index 7cf7dd104f7c..e095f41b5882 100644
--- a/fs/smb/client/sess.c
+++ b/fs/smb/client/sess.c
@@ -149,9 +149,9 @@ int cifs_try_adding_channels(struct cifs_ses *ses)
 	int old_chan_count, new_chan_count;
 	int left;
 	int rc = 0;
-	int tries = 0;
+	int tries = 0, attempts;
 	size_t iface_weight = 0, iface_min_speed = 0;
-	struct cifs_server_iface *iface = NULL, *niface = NULL;
+	struct cifs_server_iface *iface = NULL, *candidate = NULL;
 	struct cifs_server_iface *last_iface = NULL;
 
 	spin_lock(&ses->chan_lock);
@@ -197,67 +197,89 @@ int cifs_try_adding_channels(struct cifs_ses *ses)
 			break;
 		}
 
-		if (!iface)
-			iface = list_first_entry(&ses->iface_list, struct cifs_server_iface,
-						 iface_head);
 		last_iface = list_last_entry(&ses->iface_list, struct cifs_server_iface,
 					     iface_head);
 		iface_min_speed = last_iface->speed;
+		spin_unlock(&ses->iface_lock);
 
-		list_for_each_entry_safe_from(iface, niface, &ses->iface_list,
-				    iface_head) {
-			/* do not mix rdma and non-rdma interfaces */
-			if (iface->rdma_capable != ses->server->rdma)
-				continue;
+		attempts = 0;
+		while (left > 0) {
+			spin_lock(&ses->iface_lock);
 
-			/* skip ifaces that are unusable */
-			if (!iface->is_active ||
-			    (is_ses_using_iface(ses, iface) &&
-			     !iface->rss_capable))
-				continue;
+			/*
+			 * iface_lock must be dropped while opening a channel,
+			 * and a concurrent interface refresh may remove and
+			 * free entries during that window, so no list entry
+			 * may be kept across it without a reference.  Scan
+			 * the list from the beginning each time and only pass
+			 * a referenced candidate to cifs_ses_add_channel();
+			 * weight_fulfilled tracks the progress so that no
+			 * iface is selected beyond its weight.
+			 */
+			candidate = NULL;
+			list_for_each_entry(iface, &ses->iface_list, iface_head) {
+				/* do not mix rdma and non-rdma interfaces */
+				if (iface->rdma_capable != ses->server->rdma)
+					continue;
 
-			/* check if we already allocated enough channels */
-			iface_weight = iface->speed / iface_min_speed;
+				/* skip ifaces that are unusable */
+				if (!iface->is_active ||
+				    (is_ses_using_iface(ses, iface) &&
+				     !iface->rss_capable))
+					continue;
 
-			if (iface->weight_fulfilled >= iface_weight)
-				continue;
+				/* check if we already allocated enough channels */
+				iface_weight = iface->speed / iface_min_speed;
 
-			/* take ref before unlock */
-			kref_get(&iface->refcount);
+				if (iface->weight_fulfilled >= iface_weight)
+					continue;
+
+				/* take ref before unlock */
+				kref_get(&iface->refcount);
+				candidate = iface;
+				break;
+			}
+
+			if (!candidate) {
+				/* no usable iface. reset weight_fulfilled and start over */
+				list_for_each_entry(iface, &ses->iface_list, iface_head)
+					iface->weight_fulfilled = 0;
+				spin_unlock(&ses->iface_lock);
+				break;
+			}
+
+			attempts++;
+			if (attempts > 3 * ses->chan_max) {
+				kref_put(&candidate->refcount, release_iface);
+				spin_unlock(&ses->iface_lock);
+				break;
+			}
 
 			spin_unlock(&ses->iface_lock);
-			rc = cifs_ses_add_channel(ses, iface);
+			rc = cifs_ses_add_channel(ses, candidate);
 			spin_lock(&ses->iface_lock);
 
 			if (rc) {
 				cifs_dbg(VFS, "failed to open extra channel on iface:%pIS rc=%d\n",
-					 &iface->sockaddr,
+					 &candidate->sockaddr,
 					 rc);
 				/* failure to add chan should increase weight */
-				iface->weight_fulfilled++;
-				kref_put(&iface->refcount, release_iface);
+				candidate->weight_fulfilled++;
+				kref_put(&candidate->refcount, release_iface);
+				spin_unlock(&ses->iface_lock);
 				continue;
 			}
 
-			iface->num_channels++;
-			iface->weight_fulfilled++;
+			candidate->num_channels++;
+			candidate->weight_fulfilled++;
 			cifs_info("successfully opened new channel on iface:%pIS\n",
-				 &iface->sockaddr);
+				 &candidate->sockaddr);
+			spin_unlock(&ses->iface_lock);
+
+			left--;
+			new_chan_count++;
 			break;
 		}
-
-		/* reached end of list. reset weight_fulfilled and start over */
-		if (list_entry_is_head(iface, &ses->iface_list, iface_head)) {
-			list_for_each_entry(iface, &ses->iface_list, iface_head)
-				iface->weight_fulfilled = 0;
-			spin_unlock(&ses->iface_lock);
-			iface = NULL;
-			continue;
-		}
-		spin_unlock(&ses->iface_lock);
-
-		left--;
-		new_chan_count++;
 	}
 
 	return new_chan_count - old_chan_count;

