Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794273043;
	b=JfTVQ/2A+BUNb994OqwWkVa4OQfdXOTqrScIKJMnr/afOYCh4A2zQrjwmZwkVrgTeKUH
	 sFM+O/lbArRJGug6pa6oLjVFtQY+b5CV7t8S6Bkvib4gvO3SWF1efztiCCLXgG/1ER/Ed
	 gCYPh9bVBH+GynfcwP8P3KpWIlcsRUPYwfqvEChi7pqTkK12LaPlOogwWbUjXgkUKDpVd
	 o2Wg/tWw89n6zBRoaQ0VzBhLNGlpPCQXfA1bPQvet9zW/wUZtdVu1BWjVywYrUL2pLOxR
	 b/s+8vrIrzZivNQBKQ+CGtLI2t8DBa9H5yZFSOYmYGKbkehaaXJJl+FFhQj4t/gfopA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794273043;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 MIME-Version:Content-Type:Content-Transfer-Encoding;
	bh=KBVGyo5RBI10fyaAqIp6kX8yonqcHl2lYJ/cPWGNAPQ=;
	b=VcHC4JYinMxh8ERlkS9KxbI8wli65wYO0IfHvv62BDYz+lLPywdlVORUr7PbuDrIXkBT
	 7fYShS7qDEU8HGCr/r93wXRsAd+0D4RtqBoD0vLbjglXLEt03o9fMLsATPxMAPh/YJCnJ
	 F1I3Y40flgaX6LlugPlJBhQEk4fuwk1SM6+QZenxo+MwnuS78E00q0INctzCjoNVZv0IB
	 Ah9QeLBrsvrbnqSDrx1XnfKbgpqbPUooxDn/111+gfQUvWJoIg1NwsY8uZ9cyqDGUZOG8
	 kr+3s+7fE5tClaU67uPXjmWF9NW5NNUKz8BJ4/xNjlKo8aXkhSDmQkVBRUN+6o1+IaA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=KYeZ7Rdu;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7A526606A325
	for <stable@vger.kernel.org>; Tue, 10 Nov 2026 01:10:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=KYeZ7Rdu
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E583A1F0089F;
	Tue, 10 Nov 2026 01:10:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794273043;
	bh=KBVGyo5RBI10fyaAqIp6kX8yonqcHl2lYJ/cPWGNAPQ=;
	h=From:To:Cc:Subject:Date;
	b=KYeZ7RduMk4SEh1wMKralG6iOge/yvXGOE1+MBlpXSFZPERr0f1+0yoPRpWYeVxkN
	 DIkArmJJhjy6A4mP9ZBhAMcOSunmgpuSyi3sX7NmcdAJifC53Qx9CkYSXLieEen+Ja
	 /wFiY+7t2mHilhS9BlwFIuTfq85sXvZue/ssQsOkfZvW2Ni9Tu2iKGq4o/6NFiohvD
	 36xI3BNLHa8tkB/l+DczGa6jYFBh9gAh3gP2BnsNrFgVB9u3XPsla6n6s1FOBxsjQk
	 DOdFa35BVjHYAqNZgqz9mQWovUqbugB1BYnPTMjSJaJjYPTQ4Z+6F8hoe2Bw1+MkED
	 BBbaD429TluIA==
From: Sasha Levin <sashal@kernel.org>
To: sven@narfation.org,
	sashiko-bot@kernel.org
Cc: stable@vger.kernel.org
Subject: FAILED: patch "[PATCH] batman-adv: stop originator purge worker before freeing TT" failed to apply to 6.6-stable tree
Date: Mon,  9 Nov 2026 20:10:41 -0500
Message-ID: <20261109201041-failed-6.6-f89eda5a9ccf@kernel.org>
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

The patch below does not apply to the 6.6-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-6.6.y
git checkout FETCH_HEAD
git cherry-pick -x f89eda5a9ccf82cba06b085b42ebc4886b8dfe9e
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '20261109201041-failed-6.6-f89eda5a9ccf@kernel.org' --subject-prefix 'PATCH 6.6.y' 'HEAD^..'

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




