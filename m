Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794273622;
	b=t61pScaoSumTVDU8A1lZV7rA4KRI0LzL9TCLlZVQueUij452PQjeC/PcWrt/3VXUIGy6
	 EEKFifqzDwaYId4qb2tzACkt0LjwMfRlxWIVxqKNwV57/lcUKXYytrHIbqVG1swEXQJFK
	 zwy1owXuLQuMF9nvp40IuLBijRBGlGDgGhWib9JHHTyY1nvhTpCW3/9tf1BNyz7U6mBHY
	 wGybF4m8rVeFZP9f6yoQDWi5VVHzE6441sn9jfC/MzG/V04eXBbz4QWyAW1rrAP0wRjiK
	 kSsva3Lrf1hsdMxrzpN2Q9UhaBp0qiRk+0tjxgXe8Hev+IhNaEvhh3wQRXUqAvDEDOw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794273622;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 MIME-Version:Content-Type:Content-Transfer-Encoding;
	bh=TyQsmJmZ+Q7/gOM+vFA/4DZDvbwKDMR3qoTJCuIUxSs=;
	b=JVCLaaSxwM9EBLev2Wqt3jp+aIzhZ2dPmmhK7ofUQ57OkwVQn+rId3cJ9RvqbygQw7o+
	 yDFb68sWksCoUbRQp7Sv0h5KzZJ6fdvxAdEC8bT9Wd4Z6IvLZtuaSM5twtjvGgD3tp0Ip
	 bv2r9YqDctmfyIOHa/DafIt8dfj+5X7EaItOx2hg5GESOeMBATTHtrHw3xzEvFFnXwfz4
	 UOiYBxt8XeLUJJ+smSCnPRW0c4+gBWzHCPY3UVzJ59yLL+LYwgs2p1uWMdZOu3ZtTeeqd
	 iyLm4ouCj7bhCSVfp5Oh7IJ5eSsOoeQmyJAnXICpntoQy1bv5L2EAmNI2ldt1JDq+Aw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b="nt/8ThOF";
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8136C606A326
	for <stable@vger.kernel.org>; Tue, 10 Nov 2026 01:20:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=nt/8ThOF
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7D42B1F0089F;
	Tue, 10 Nov 2026 01:20:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794273622;
	bh=TyQsmJmZ+Q7/gOM+vFA/4DZDvbwKDMR3qoTJCuIUxSs=;
	h=From:To:Cc:Subject:Date;
	b=nt/8ThOFS8h35q37xfHljrav3dqiJxbAqTVQHut7mnakJBMwfv9DfxtBuFIUmaSgl
	 qytjxK5jupt5F4M3uRPeBj6HQtbAU5QO2ZEwrAwwoq12u++gwz3SDBP1S/72s+xZC/
	 uhqPbGxcH+5L6IN+ReKrg/YnE10mhSmPKkrKEyXa5MFfB3p3yJqoosHFQ/4YFPCady
	 7WUDICWbUycAdGEq9MJfWO5PF9wKGlYS3K377JwIvBh5HV45nmGSnaHNiOObJBTg1F
	 Nz/LElWPavXVBF2NhBEAWQUVlWbgEjYIWblxjDz9CXjn9Iajks+ufv6ZX23NXLbm/C
	 TqvmJ7j+L6Fag==
From: Sasha Levin <sashal@kernel.org>
To: sven@narfation.org,
	sashiko-bot@kernel.org
Cc: stable@vger.kernel.org
Subject: FAILED: patch "[PATCH] batman-adv: stop originator purge worker before freeing TT" failed to apply to 5.15-stable tree
Date: Mon,  9 Nov 2026 20:20:20 -0500
Message-ID: <20261109202020-failed-5.15-f89eda5a9ccf@kernel.org>
X-Mailer: git-send-email 2.53.0
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

The patch below does not apply to the 5.15-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-5.15.y
git checkout FETCH_HEAD
git cherry-pick -x f89eda5a9ccf82cba06b085b42ebc4886b8dfe9e
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '20261109202020-failed-5.15-f89eda5a9ccf@kernel.org' --subject-prefix 'PATCH 5.15.y' 'HEAD^..'

Thanks,
Sasha

------------------ original commit in Linus's tree ------------------

From f89eda5a9ccf82cba06b085b42ebc4886b8dfe9e Mon Sep 17 00:00:00 2001
From: Sven Eckelmann <sven@narfation.org>
Date: Thu, 8 Oct 2026 18:29:16 +0200
Subject: [PATCH] batman-adv: stop originator purge worker before freeing TT

batadv_mesh_free() releases the translation tables via batadv_tt_free()
before batadv_originator_free() stops orig_work. The purge worker can
therefore still run while the TT is torn down. When an originator times
out, batadv_purge_orig_ref() calls batadv_tt_global_del_orig(), which
loads tt.global_hash and walks all buckets while taking their locks:

  CPU0                          CPU1
  batadv_tt_free()              batadv_purge_orig()
                                  batadv_tt_global_del_orig()
                                    hash = ...tt.global_hash;
    batadv_tt_global_table_free()
      batadv_hash_destroy(hash);
                                    spin_lock_bh(&hash->list_locks[i]);

Disable orig_work at the beginning of batadv_mesh_free(), directly after
the mesh was marked as deactivating. The second
disable_delayed_work_sync() in batadv_originator_free() is harmless because
it is free'd anyway.

Cc: stable@vger.kernel.org
Reported-by: Sashiko <sashiko-bot@kernel.org>
Closes: https://sashiko.dev/#/patchset/20260708091821.314516-1-sw%40simonwunderlich.de?part=3
Fixes: 9d31b3ce8168 ("batman-adv: fix potential TT client + orig-node memory leak")
Signed-off-by: Sven Eckelmann <sven@narfation.org>
---
 net/batman-adv/main.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/net/batman-adv/main.c b/net/batman-adv/main.c
index ced76942f33c5..3b9fa861be7be 100644
--- a/net/batman-adv/main.c
+++ b/net/batman-adv/main.c
@@ -295,6 +295,11 @@ void batadv_mesh_free(struct net_device *mesh_iface)
 
 	WRITE_ONCE(bat_priv->mesh_state, BATADV_MESH_DEACTIVATING);
 
+	/* the originator purge worker accesses (among others) the TT tables
+	 * and must therefore be stopped before any of them are freed
+	 */
+	disable_delayed_work_sync(&bat_priv->orig_work);
+
 	batadv_purge_outstanding_packets(bat_priv, NULL);
 	batadv_tp_stop_all(bat_priv);
 
-- 
2.53.0




