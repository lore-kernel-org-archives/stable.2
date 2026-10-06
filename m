Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 32DAE33123D
	for <stable@vger.kernel.org>; Tue,  6 Oct 2026 22:11:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791324662; cv=none; b=RukqiJKuzi/6x0T64jPFWMVMdttlgdbLYfaWoSKsgfXvaozvK2SbwhU83SMzSo8szhK5jY/NR5CHUiL7QbiUY5jnWUC+Ex7hj5bsjy99YMFJTcJAbaqwl7E+MN7D8Xf4pT5Bg3B6BzIVLH2ANQ7z0j2fAC6t26eTpAuM2SUZbjA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791324662; c=relaxed/simple;
	bh=9Ok0F1GgDVFHvd/MKTwWo/tIIw4djE23BjBQZSOqOIA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=p3cEdoQqNlYyb+RpTucMvTM7Hi8fe4Q0gUzag/pz2bI5Bw6T28DmvVKwaTAji5b2R9vskgN9tIKGuHgRftjEAlvGV8CrAo6FOoqoXJ7kcrclL14iAa1ozLvnOUzRvN/8zxOJAX2W/bUGyBASQv/9mlYUbmIFLVSV4USO/Uv5sTs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Udv0dXY0; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Udv0dXY0"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 73BBE1F0089B;
	Tue,  6 Oct 2026 22:10:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791324660;
	bh=J+hby9LxbIMX9uKWb1rrJWuKI6K32NoPO2zxv7zTjb4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=Udv0dXY05POVDfncDhri8DNsszi1P5kRycPZJCbD1X2XIfWCL5kac47AlbvglO0GB
	 tMnsa8Zckcc7u2vtSZSGIsB7eQ0mjUwcbC3o/N12QmxdKGRvQON7YEUfH0L5YTGWus
	 d9C99uhDpJK05JS0YYhCr+dISWmd2RywgB67W+8rRnr7xP1iZmYk7vAk5qK9HnIh0T
	 QpVgkyy4g98oA5DcREE+2jVR+sZujGtNcJ6fkJBZhd+X6J7BgItk3ocPY+6Yu5C41Y
	 gAvhYkzalrsfKJKJeCOS4N3pPpi3A/o2ETVe+pI6ifp2YKV3deslVI06gpwRyg2bZc
	 67oLGjTc8UE3A==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Zhao Li <enderaoelyther@gmail.com>,
	Johannes Berg <johannes.berg@intel.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.15.y] wifi: mac80211: account proxy paths against the mesh path limit
Date: Tue,  6 Oct 2026 18:10:57 -0400
Message-ID: <20261006221029.1045703-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026100532-spotting-captive-fa8a@gregkh>
References: <2026100532-spotting-captive-fa8a@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Zhao Li <enderaoelyther@gmail.com>

[ Upstream commit a5f35d4b112af1415ff06bd501c8cc26cc08aa8b ]

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
[ sashal: Adjusted error-handling braces to accommodate the missing mesh_fast_tx_flush_addr() call. ]
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 net/mac80211/mesh_pathtbl.c | 11 +++++++++--
 1 file changed, 9 insertions(+), 2 deletions(-)

diff --git a/net/mac80211/mesh_pathtbl.c b/net/mac80211/mesh_pathtbl.c
index a0ef296e3e4f3..f2970f33f96c5 100644
--- a/net/mac80211/mesh_pathtbl.c
+++ b/net/mac80211/mesh_pathtbl.c
@@ -449,10 +449,15 @@ int mpp_path_add(struct ieee80211_sub_if_data *sdata,
 	if (is_multicast_ether_addr(dst))
 		return -ENOTSUPP;
 
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
@@ -465,8 +470,10 @@ int mpp_path_add(struct ieee80211_sub_if_data *sdata,
 		hlist_add_head_rcu(&new_mpath->walk_list, &tbl->walk_head);
 	spin_unlock_bh(&tbl->walk_lock);
 
-	if (ret)
+	if (ret) {
 		kfree(new_mpath);
+		atomic_dec(&sdata->u.mesh.mpaths);
+	}
 
 	sdata->u.mesh.mpp_paths_generation++;
 	return ret;
-- 
2.53.0

