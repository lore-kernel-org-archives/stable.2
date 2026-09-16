Received: from mail-pj2-f13.google.com (mail-pj2-f13.google.com [74.125.227.141])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6AE554EE859
	for <stable@vger.kernel.org>; Wed, 16 Sep 2026 11:37:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.227.141
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789558661; cv=none; b=I2//cVynzhdLS1exttj9Grs1RwfK2eElvWDY0X3VvhnpT1NFj5guTffZ/91xgDCdz+3zpgGotdT+aDcOLBnPLks0XceLFD3mtINa+ogxOlI4Fr5GKoVV1b04PiPWvUZz8+bwQWa1H5ndH95W510WIDJUc3+EhwbSnlN7Fm34j4U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789558661; c=relaxed/simple;
	bh=/Hc8uJtTDrUeU5cVZdc1ZyUkvgdb77Y94Nbtto9GWOk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=TL4aBLizaaDXELkDXlHRN7EC3jSnca3WNpsEb3SgjnYi+1I2CxRewExl75WTzoqbXiBrJUSiaymz0mTnzJ35o3wuDEWXQ3/O4pe2byn3NkkodKAxKWsuAKhlfP6uKjq1t8cNFHRrDOTBSPHjL1qVEJBwBxkauTv4UbA/q8FBZeM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=TqbZiUiE; arc=none smtp.client-ip=74.125.227.141
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TqbZiUiE"
Received: by mail-pj2-f13.google.com with SMTP id d9443c01a7336-2d747f01363so6464585ad.2
        for <stable@vger.kernel.org>; Wed, 16 Sep 2026 04:37:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1789558643; x=1790163443; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=u71SukOk/uWqGG5KqXUmklLOaVffKeGeaoghUb9DD4k=;
        b=TqbZiUiEA+CMSix0qtFQKpx40D5mN8jlve96C1PqxDGY+d6GYO8iLxFXjeurGRkyW6
         b+sxAOZb21sPCeM35/2kNOpL3bbCbBMgyVOR4xpbRiZaMU292mcnMLEsbe1eqqtQ9qgw
         33kEn9KnAfzL3zwGhUVRM+atXUu7tkhIKfV6Fu/hy8dK7//TMVak8mOLH22gA35rFB0x
         KeiZ8kOoxsPPYFZXKlNhEhK7PoRTZ0szUCEaHp5X6b0vblxkLYeaDp3gYhu+lWx283R4
         9GIHlyueTiBghsTGtaZ1NLzRnNcvBFc7Z9Z+FtTEnif/ma7zlS1+LOakFJBLMJthUIBI
         pcxg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789558643; x=1790163443;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=u71SukOk/uWqGG5KqXUmklLOaVffKeGeaoghUb9DD4k=;
        b=rI040qABCziEHU5ZWwtnvCkP9eb2oOFxPSFwl7YXdWvdCLFaAHW69z9KGXmYxLnjLa
         nroFy0Xqeqq3Iv7YqU9C6hqCINlcWJFFUtdZu/diiVn4j7KBjuLBb2CRMi51PkRDxRJ2
         7AQqzm1oCyX/fKIqkJjzhKathw9M7yJhBUeRlxHMAkV4W2nbv3Pr4df5VrcaDUS75s7g
         lwGbnVxwP8E8KpUunpPc+5vnKHPMIBsmwv19oKxC8qsSSD6e1WIKw272SUUMsdan8ANc
         da+r2JIf9A3QIubrKEU/tJfb1KQzWxsvSCLKdDB2YVpEg6IILLS0WKFhcGkNo4l8npYs
         hJxg==
X-Forwarded-Encrypted: i=1; AKwUvBycNj5rQz/yShYzY/DSXg4GyhuytjWpSe38yZGva5KrHrlwjCQ+V+WqWNE4qhz3V4G6KFujMdU=@vger.kernel.org
X-Gm-Message-State: AFuF++lVwqJWBq7iiVuNkuZ8Eyr4QXzUXRbPSdcw5XkgkDMtz0ZqUZrk
	YwQRFsrNU861vmkWQvvtfkheYPI2S4I5DJSURLJoA37vPxTmLLwgbGIz
X-Gm-Gg: AYBFou26zg+xj2Vka7TXl+NCdJIgRRYNqfBxI1HUljpmITNx5/6riEFKprWwpog8rF1
	4aaBPg/6qgYoZ3YoHWr7eXJww0A0RMuiD7TH9GnelSRaoa1+auHF9NnwL9xuNguHveuR+Usc5Tw
	GgpmaoO5EEX0FHFRcv1Zg0zvyLyMBET408ab9Zh5oSscbmeQVbVdrGklRodcoa7Scdy6Lphudcb
	kIi8Rjl2f0yn7hAsjwAq9GF3mmZIxQoaFDERhGzZHHEwKjly1JXFjZEBrsbMF0OB0o5LdTBcK6e
	5IVYvb71EbTtzvppdMUl2hE+lGQJtuRKV8DidCXF0Bv3Ytdd6bUqi8v47MaoHA7pytAU9oc19Rj
	WcIudih/+v2yiVYsDxP47mEJbhzEa7NJ16BgIZHzA2P8p/ppgFdWyAt+abgNmJfoKpzIdfGd5SP
	Viw9+5AwJQebOd/nxw5phGp2xFQTHsCpzVuMoD5hJvT3caYdCQ+OR0fZ7H7ymgBdFucUXODyjxT
	A/XArjPpK+anCNYYfvEo2cVUFCcwlSFiQ==
X-Received: by 2002:a17:903:1b67:b0:2cc:6018:f030 with SMTP id d9443c01a7336-2dd8e51df8amr47363745ad.14.1789558642410;
        Wed, 16 Sep 2026 04:37:22 -0700 (PDT)
Received: from KRHW1CJW23.bytedance.net ([139.177.225.247])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2dd89f02fc2sm9927045ad.59.2026.09.16.04.37.18
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Wed, 16 Sep 2026 04:37:21 -0700 (PDT)
From: Zhao Li <enderaoelyther@gmail.com>
To: Johannes Berg <johannes@sipsolutions.net>
Cc: Bob Copeland <me@bobcopeland.com>,
	linux-wireless@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: [PATCH 2/2] wifi: mac80211: account proxy paths against the mesh path limit
Date: Wed, 16 Sep 2026 19:36:49 +0800
Message-ID: <20260916113649.28315-3-enderaoelyther@gmail.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260916113649.28315-1-enderaoelyther@gmail.com>
References: <20260916113649.28315-1-enderaoelyther@gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

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
---
Validation:
- GCC W=1 and Sparse C=2 produced no diagnostics.
- A controlled production-helper matrix drove the counter to -10 through
  proxy-path churn before the fix and kept it at zero after it. With 1023
  mesh paths and one proxy path installed, one further mesh addition
  exceeded the combined cap before the fix and returned -ENOSPC afterward.
- A two-point hwsim 802.11s run reached production mpp_path_add() from
  received address-extension mesh data. After one proxy install, the
  pre-patch counter was 2 and the fixed counter was 3 for the same three
  walk-list entries. No physical-radio or layer-3 success is claimed.

 net/mac80211/mesh_pathtbl.c | 13 ++++++++++---
 1 file changed, 10 insertions(+), 3 deletions(-)

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
-- 
2.55.0
