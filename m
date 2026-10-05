Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A2BFC4AAC51
	for <stable@vger.kernel.org>; Mon,  5 Oct 2026 14:38:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791211123; cv=none; b=WVMT+O2KKybUSw6hwp4HMnsxTFZsN5IUoXUGbCO//v4Oieb7C4Ix91ip2QnfKlw37ugR7k0l4+yMhfvt8sCqcPzWX+umlP8pXh/9bTf6Nel4MwKkQ5VWk11E/jay/WRa+DAhfm9qn3kgc2EzBhAcNxYFlwpuN6oH472IqnTMXpI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791211123; c=relaxed/simple;
	bh=LJbdBWfVzxwETYz0X6IMlMUfHpR8YtrdU8QIZg5wSI8=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=mLfJxcXr0qW6DObN9fv98dEYpccBhHzLhnPfSzxTQaGxGRglSVmaf9bjEFttSeCgJLNHl4ghUO+VVsKDmCbyC1iVYAloKuGanBE278ZZhwACnib7z8IUtCKQGu28e+bVPMYU6ZRzrd2F7alIkvxetaF+6sDwnUKcbNm/EP5q41k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=t7ubfP/o; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="t7ubfP/o"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 287631F00899;
	Mon,  5 Oct 2026 14:38:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1791211114;
	bh=ix3W2RF2HVzc9VYWNmsUtvPqayZbDVBxd/5UqQu0ZqU=;
	h=Subject:To:Cc:From:Date;
	b=t7ubfP/oJ1VAqGq7ApBHLDTpoV8Q3K9tGWCajC+6wnqA327ObLX2rViyEogiUoeII
	 8Hq8Ik9J/SgxDGQFryCAt0mWQsmq1SZ5/M8gTa5GQ4KTd5z5wGFLvkVzR8vRhxNyH5
	 d2XgY2JHpko34hfU3mtejOgRQbAWwjgEkFsBYkFU=
Subject: FAILED: patch "[PATCH] wifi: mac80211: account proxy paths against the mesh path" failed to apply to 6.1-stable tree
To: enderaoelyther@gmail.com,johannes.berg@intel.com
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Mon, 05 Oct 2026 16:38:31 +0200
Message-ID: <2026100531-preformed-tinfoil-ff4b@gregkh>
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
git cherry-pick -x a5f35d4b112af1415ff06bd501c8cc26cc08aa8b
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2026100531-preformed-tinfoil-ff4b@gregkh' --subject-prefix 'PATCH 6.1.y' 'HEAD^..'

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From a5f35d4b112af1415ff06bd501c8cc26cc08aa8b Mon Sep 17 00:00:00 2001
From: Zhao Li <enderaoelyther@gmail.com>
Date: Wed, 16 Sep 2026 19:36:49 +0800
Subject: [PATCH] wifi: mac80211: account proxy paths against the mesh path
 limit

Proxy-path churn can drive the interface path counter negative and let
later mesh path additions exceed MESH_MAX_MPATHS.

mesh_path_free_rcu() decrements the interface mpaths counter for entries
from both the mesh and proxy path tables, but mpp_path_add() never
reserves a slot in that counter. Removing or expiring a proxy path
therefore returns a slot that was never charged.

mesh_path_add() uses the same counter to enforce MESH_MAX_MPATHS, so once
it falls below the number of installed paths the limit no longer holds.

Reserve the shared quota before allocating a proxy path and release it on
every unsuccessful addition. Mesh and proxy paths now share one
1024-entry budget, so mpp_path_add() can return -ENOSPC at that limit.

Fixes: ece1a2e7e860 ("mac80211: Remove mesh paths when an interface is removed")
Cc: stable@vger.kernel.org
Assisted-by: LLM sparse kasan
Signed-off-by: Zhao Li <enderaoelyther@gmail.com>
Link: https://patch.msgid.link/20260916113649.28315-3-enderaoelyther@gmail.com
Signed-off-by: Johannes Berg <johannes.berg@intel.com>

diff --git a/net/mac80211/mesh_pathtbl.c b/net/mac80211/mesh_pathtbl.c
index 770fc16b439b..1c55b14c2ac0 100644
--- a/net/mac80211/mesh_pathtbl.c
+++ b/net/mac80211/mesh_pathtbl.c
@@ -736,10 +736,15 @@ int mpp_path_add(struct ieee80211_sub_if_data *sdata,
 	if (is_multicast_ether_addr(dst))
 		return -EOPNOTSUPP;
 
+	if (!atomic_add_unless(&sdata->u.mesh.mpaths, 1, MESH_MAX_MPATHS))
+		return -ENOSPC;
+
 	new_mpath = mesh_path_new(sdata, dst, GFP_ATOMIC);
 
-	if (!new_mpath)
+	if (!new_mpath) {
+		atomic_dec(&sdata->u.mesh.mpaths);
 		return -ENOMEM;
+	}
 
 	memcpy(new_mpath->mpp, mpp, ETH_ALEN);
 	tbl = &sdata->u.mesh.mpp_paths;
@@ -752,10 +757,12 @@ int mpp_path_add(struct ieee80211_sub_if_data *sdata,
 		hlist_add_head_rcu(&new_mpath->walk_list, &tbl->walk_head);
 	spin_unlock_bh(&tbl->walk_lock);
 
-	if (ret)
+	if (ret) {
 		kfree(new_mpath);
-	else
+		atomic_dec(&sdata->u.mesh.mpaths);
+	} else {
 		mesh_fast_tx_flush_addr(sdata, dst);
+	}
 
 	sdata->u.mesh.mpp_paths_generation++;
 	return ret;

