Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 51C464AC17E
	for <stable@vger.kernel.org>; Mon,  5 Oct 2026 14:38:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791211132; cv=none; b=FdvIUUwugRytU/KNksXuGa/zr6mewcSz6jlCBoUEb80XG8Vaf/83nVYebqml2NkT5kTl/btN2o72dS8fqjkADalI9uNozyi+nLcFMmDVOd5INKqzQYIAfTILKYZiuiT5zhr5nJV5mUHUY3hp7Lr71ipKnrPAj+T43Ecr2iuwHg4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791211132; c=relaxed/simple;
	bh=6gep1d/hNzzeaJWqHnMWMDbBge3qcAgJOe76VY63j5s=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=If+RFU7hTQfxOAX4Kpq+uApQVyhyoVDV5gSwbtR3sZAz0J1EQ3Onj1HeCcFu0yCPmjdUV3oUizwO7j+bd4IIDx3iIYw47KajaWJOs1K2EUmjwQZiMDs6yDmtlEbZXLGx6cHTWEMmEPTCKh3vDxAk59mxj3G8B/NPFfYzeT02Gz8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=ScmmB0nv; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="ScmmB0nv"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 433221F00893;
	Mon,  5 Oct 2026 14:38:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1791211122;
	bh=75xZH4GNH+WF3ZyX3UG6fPIBfXA+OrycQMe/QH46+hs=;
	h=Subject:To:Cc:From:Date;
	b=ScmmB0nvVnLS4MQtfGfgnzGt1urdmwNfETr2OydD5c0mAKz0bCED5EfvmgaFow7RY
	 OIbhyIQGMrvCAabK82s/Uj3uk2r1GsA02qo8yzz7mhOCedjbMxhawZ5kytym8hXlw/
	 ahjeKDxxZsJ/4HNwpOdbFyDypgJ+SrEZtmqoFYyM=
Subject: FAILED: patch "[PATCH] wifi: mac80211: account proxy paths against the mesh path" failed to apply to 5.10-stable tree
To: enderaoelyther@gmail.com,johannes.berg@intel.com
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Mon, 05 Oct 2026 16:38:32 +0200
Message-ID: <2026100532-claim-cannabis-3f5b@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit


The patch below does not apply to the 5.10-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-5.10.y
git checkout FETCH_HEAD
git cherry-pick -x a5f35d4b112af1415ff06bd501c8cc26cc08aa8b
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2026100532-claim-cannabis-3f5b@gregkh' --subject-prefix 'PATCH 5.10.y' 'HEAD^..'

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

