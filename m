Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E9E6B35DA6E
	for <stable@vger.kernel.org>; Wed, 23 Sep 2026 01:40:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790127614; cv=none; b=MO1X53Pd/Q02yamLbhq0gJyJ/n1tfmF5loJkPOPNjBwFE8i8lQ4oAQ/kheOzulL1xL+3yPhkdWvvtuu4rMWWplwT6kZSgnyYXETPWj0o0r9iHn76ldIYVHbANhcGZETIvxPscgxDG199q2L/dXvAp/KG0+tLf5yO4HtM9n+m614=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790127614; c=relaxed/simple;
	bh=+NC+mkSkzKd01XQ1bCy1YcKXM8CCrSHCmPPl8nVT87I=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=g/spLY3GFFBl46vwUH63KOmBBzBTz70cE/TVuDRb0uVlv+SGVcVPxIXLW9Pkf3Cssfc5tc1iktXyI8vIKfuqeUhAoVf90g4s4K/5xZQZDqsHdGmrF6h3FWE+ZrGpG1py60jCfcRQCZZpQ4WzeaXlFVzfXUXJGGHrod7Vsn1tCP4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=RF7yuy/f; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="RF7yuy/f"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3383A1F000FF;
	Wed, 23 Sep 2026 01:40:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790127612;
	bh=N5t8+1N8kAMbjQWe783fgbmPCAQ3HVcrq0v22qxT+M0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=RF7yuy/fKe/7BcF2qzryjYhYjwEuRDfwSx4eLLHJT2bpMiHlk9Smi2qbH/zQVEr1S
	 pbD8z9+WCL3Us4qkiDBOI1w0uCz8VnglWRFq5eJaF7bOA7GrYvk3HYbXuoYYQjVhFT
	 NqyVumMyvWrXhA1WLPGyN2yvJQUYTCne63p9TtPqatN+ASHEuiLAfWEvEr0qQN/ud/
	 M4burpkU55wfZmb8y809N7Okystanyr5Zd9aKO/hl7gznBlb72UQ9BPCa/9N/81DFw
	 ImzgKI4tAQxGHUfSygj58G5AgQ20+uMSWHr3UF5D6rTGWvGT+TXJPJSYaBsEaE1D5d
	 LAjDvrN7MRA0Q==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Joseph Qi <joseph.qi@linux.alibaba.com>,
	Shyam Prasad N <sprasad@microsoft.com>,
	Paulo Alcantara <pc@manguebit.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.1.y] smb: client: fix use-after-free of iface in cifs_try_adding_channels()
Date: Tue, 22 Sep 2026 21:40:10 -0400
Message-ID: <20260923014010.879928-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026092255-baked-regroup-d5f6@gregkh>
References: <2026092255-baked-regroup-d5f6@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Joseph Qi <joseph.qi@linux.alibaba.com>

[ Upstream commit d034e836eefd7ce75e588f7031cffbeec594f5ac ]

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
[ adapted calls to retain the cifs_sb argument and use cifs_dbg(VFS, ...) instead of cifs_info(). ]
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 fs/smb/client/sess.c | 106 ++++++++++++++++++++++++++-----------------
 1 file changed, 64 insertions(+), 42 deletions(-)

diff --git a/fs/smb/client/sess.c b/fs/smb/client/sess.c
index ffeb3e7d34d5c..1f1043e47c5cf 100644
--- a/fs/smb/client/sess.c
+++ b/fs/smb/client/sess.c
@@ -163,9 +163,9 @@ int cifs_try_adding_channels(struct cifs_sb_info *cifs_sb, struct cifs_ses *ses)
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
@@ -211,67 +211,89 @@ int cifs_try_adding_channels(struct cifs_sb_info *cifs_sb, struct cifs_ses *ses)
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
-
-			/* skip ifaces that are unusable */
-			if (!iface->is_active ||
-			    (is_ses_using_iface(ses, iface) &&
-			     !iface->rss_capable))
-				continue;
+		attempts = 0;
+		while (left > 0) {
+			spin_lock(&ses->iface_lock);
 
-			/* check if we already allocated enough channels */
-			iface_weight = iface->speed / iface_min_speed;
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
+
+				/* skip ifaces that are unusable */
+				if (!iface->is_active ||
+				    (is_ses_using_iface(ses, iface) &&
+				     !iface->rss_capable))
+					continue;
+
+				/* check if we already allocated enough channels */
+				iface_weight = iface->speed / iface_min_speed;
+
+				if (iface->weight_fulfilled >= iface_weight)
+					continue;
+
+				/* take ref before unlock */
+				kref_get(&iface->refcount);
+				candidate = iface;
+				break;
+			}
 
-			if (iface->weight_fulfilled >= iface_weight)
-				continue;
+			if (!candidate) {
+				/* no usable iface. reset weight_fulfilled and start over */
+				list_for_each_entry(iface, &ses->iface_list, iface_head)
+					iface->weight_fulfilled = 0;
+				spin_unlock(&ses->iface_lock);
+				break;
+			}
 
-			/* take ref before unlock */
-			kref_get(&iface->refcount);
+			attempts++;
+			if (attempts > 3 * ses->chan_max) {
+				kref_put(&candidate->refcount, release_iface);
+				spin_unlock(&ses->iface_lock);
+				break;
+			}
 
 			spin_unlock(&ses->iface_lock);
-			rc = cifs_ses_add_channel(cifs_sb, ses, iface);
+			rc = cifs_ses_add_channel(cifs_sb, ses, candidate);
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
 			cifs_dbg(VFS, "successfully opened new channel on iface:%pIS\n",
-				 &iface->sockaddr);
-			break;
-		}
-
-		/* reached end of list. reset weight_fulfilled and start over */
-		if (list_entry_is_head(iface, &ses->iface_list, iface_head)) {
-			list_for_each_entry(iface, &ses->iface_list, iface_head)
-				iface->weight_fulfilled = 0;
+				 &candidate->sockaddr);
 			spin_unlock(&ses->iface_lock);
-			iface = NULL;
-			continue;
-		}
-		spin_unlock(&ses->iface_lock);
 
-		left--;
-		new_chan_count++;
+			left--;
+			new_chan_count++;
+			break;
+		}
 	}
 
 	return new_chan_count - old_chan_count;
-- 
2.53.0

