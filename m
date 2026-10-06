Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7BD9F4E56FC
	for <stable@vger.kernel.org>; Tue,  6 Oct 2026 22:56:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791327393; cv=none; b=NXRkgZYDEUEndiWToGFXHHVwmfoTL8z8WLa6uuLC0J+RtRgiPoHNfVytYTG5H2CjjBL4iCrQFLrIbb/Wm2eqjyPwL7JK7/UiDkdEe/dVK77STXXQpbMq2ljDmi4q68ZVIV4chnMPWRrIQ4daN3q58/L10RLuzi4haiGBRFaBClQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791327393; c=relaxed/simple;
	bh=lDmDwocO2zv8oV1+wjGP+5gRIvcDWZGPo4teUcpw2yk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=UcRgZ2b66jcHFT30IiuljOTrKmck34evrXfa+IjkJSFp5hVgVIOzZyPU8tSR+7erRHyhSZGVJP5i61G/dAVJ7/LYn8chUkfjQfbMQdUUhsda/U7ZesM+xbyIufjy5b7poHeXjKzYEqFAyw2CtS4L0K9swYBEDgnGSCz8KjhpjGw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=HGqkzw72; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="HGqkzw72"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 006E01F0089B;
	Tue,  6 Oct 2026 22:56:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791327393;
	bh=RsYKujTLNXnWpZPSatA5tbLPwvDQU+hsWjObzd8OHWc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=HGqkzw72arATXTmfVXoJphPGUPFils3/m0MGTvFj5JLbfdks3ZUUSLaxaPcAswMYR
	 YssY2pvO8Ss3oVGw/PDX6BTQ5Iesd9h9T88k+0qUn99yc7l8iQriZklYjrZOuHs3tN
	 3iRHjHbdoC+i8qFkYP1Gcxnq8p3AnRYF9hQgBN4on6QDvJuzWHwbCMKgqR5pmu+jfp
	 SRZGa8waQCoi25MtPt1j7crmgirGcVyek0hC5CWF+DMD1zry1QWek9Bg8LPwyV0+p3
	 n7EJ9teKdQp/X/looUgag+8rR9F2KrEnQoqwWnqG7WASUgVcoORn29mITdLtuDtrdg
	 fe9PZQUNkmclw==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Zhao Li <enderaoelyther@gmail.com>,
	Johannes Berg <johannes.berg@intel.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.10.y] wifi: mac80211: account proxy paths against the mesh path limit
Date: Tue,  6 Oct 2026 18:56:28 -0400
Message-ID: <20261006225447.1127148-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026100532-claim-cannabis-3f5b@gregkh>
References: <2026100532-claim-cannabis-3f5b@gregkh>
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
[ sashal: adapted error handling to the absence of mesh_fast_tx_flush_addr() ]
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 net/mac80211/mesh_pathtbl.c | 11 +++++++++--
 1 file changed, 9 insertions(+), 2 deletions(-)

diff --git a/net/mac80211/mesh_pathtbl.c b/net/mac80211/mesh_pathtbl.c
index 9482b49b7f333..7478ea5786299 100644
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

