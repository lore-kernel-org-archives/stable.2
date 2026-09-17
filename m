Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F3756286D60
	for <stable@vger.kernel.org>; Thu, 17 Sep 2026 01:33:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789608792; cv=none; b=DUfsWTGwMIOQx4rXBOnWsRbfVkWP/wXP5bBowdlEmrTh9FsDhLOnCX8kEw9LZ55gwQN/wpBbC+DS6m0EbK3WOAFpZFplxt43sd2pdnaz3Qtk/2WFRHZWonjPNigd+K3NHKXOif4coGFK8IuEFCX6FthMx/4dQjn75o2j7KEbkic=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789608792; c=relaxed/simple;
	bh=8HEnvYibECYvyebUZdlANB2x7Ia39M56OqjkYzIXWsE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=XXShju6hSktfoBpiGOZcHKLQg+cK50026I+R9bfzMvOSyZfi95sxyrY3gY/QGor+c2DJITgJZO07/vjEUYvz2d/a2wtrq06h2LXBiMzMX8Ohc4Q0jQZktfau2l/9LLrmL4UP6KQsv/+dDiEVIHCHJXwFodrm/BJl/JqQuE1Nvg0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=GW9kz5G3; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="GW9kz5G3"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5118D1F00898;
	Thu, 17 Sep 2026 01:33:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789608790;
	bh=A/cRpXSAd7+x20J6qm4iUPu04difzhe3bAB+gQ1RIrk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=GW9kz5G3imLV/mYGjbcYSInU4ACcCsuQZli6cab//i5Hfxcshu5oEHUpjAP484es0
	 ai02hbZM6KwfISwxs0ex2/Kzn3g9ERYRpMti/RNKnkkLKiJnAO4y5EKfHNiojIKpGt
	 tlMATWuyhtTekesS021FQ63zrvST12uqZKJuMdYzA18LlYFmHmgC4FNDUk9S+SYsyp
	 wiufCQKQ/++NiuaxUMh7TUVeoJWfSEn24LH21qcbdyhB/8143z6vgYJRi6FKlM+dHB
	 wfsLuSPzztnKN/hfx11wVI6NdUIkp6ULYC8URrQnQ6KG6AfiStUxe4930MwiQGqNI/
	 bD2xC8X/gSSQQ==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: David Carlier <devnexen@gmail.com>,
	syzbot+60332fd095f8bb2946ad@syzkaller.appspotmail.com,
	Stefan Schmidt <stefan@datenfreihafen.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.10.y] ieee802154: hwsim: serialize pib updates to fix double-free
Date: Wed, 16 Sep 2026 21:33:08 -0400
Message-ID: <20260917013308.3594458-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026091659-marry-gender-6432@gregkh>
References: <2026091659-marry-gender-6432@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: David Carlier <devnexen@gmail.com>

[ Upstream commit 979d5b8de8ed4e1f997aef12da5694b99be7b871 ]

hwsim_update_pib() does an unserialized read-swap-free of phy->pib:

	pib_old = rtnl_dereference(phy->pib);
	...
	rcu_assign_pointer(phy->pib, pib);
	kfree_rcu(pib_old, rcu);

It assumes the RTNL is held, but ->set_channel is not always called
under it: the mac802154 scan worker changes channels via
drv_set_channel() without the RTNL. Such an update can race an
RTNL-held one on the same phy; both read the same pib_old and both
kfree_rcu() it, double-freeing the object. With SLUB percpu sheaves
batching kfree_rcu(), this surfaces as a KASAN invalid-free in
rcu_free_sheaf().

struct hwsim_phy has no lock for pib. Add one and make the swap atomic
with rcu_replace_pointer() under it, dropping the misleading
rtnl_dereference().

Reported-by: syzbot+60332fd095f8bb2946ad@syzkaller.appspotmail.com
Closes: https://syzkaller.appspot.com/bug?extid=60332fd095f8bb2946ad
Fixes: f25da51fdc38 ("ieee802154: hwsim: add replacement for fakelb")
Signed-off-by: David Carlier <devnexen@gmail.com>
Cc: stable@vger.kernel.org
Link: https://lore.kernel.org/20260709221858.158063-1-devnexen@gmail.com
Signed-off-by: Stefan Schmidt <stefan@datenfreihafen.org>
[ Adapted hwsim_update_pib() changes to hwsim_hw_channel() because the older branch lacks the helper. ]
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/net/ieee802154/mac802154_hwsim.c | 9 +++++++--
 1 file changed, 7 insertions(+), 2 deletions(-)

diff --git a/drivers/net/ieee802154/mac802154_hwsim.c b/drivers/net/ieee802154/mac802154_hwsim.c
index 344f63bc94a21..e6a68d522baec 100644
--- a/drivers/net/ieee802154/mac802154_hwsim.c
+++ b/drivers/net/ieee802154/mac802154_hwsim.c
@@ -69,6 +69,8 @@ struct hwsim_phy {
 	struct ieee802154_hw *hw;
 	u32 idx;
 
+	/* Serializes phy->pib_updates. */
+	spinlock_t pib_lock;
 	struct hwsim_pib __rcu *pib;
 
 	bool suspended;
@@ -100,8 +102,10 @@ static int hwsim_hw_channel(struct ieee802154_hw *hw, u8 page, u8 channel)
 	pib->page = page;
 	pib->channel = channel;
 
-	pib_old = rtnl_dereference(phy->pib);
-	rcu_assign_pointer(phy->pib, pib);
+	spin_lock_bh(&phy->pib_lock);
+	pib_old = rcu_replace_pointer(phy->pib, pib,
+				      lockdep_is_held(&phy->pib_lock));
+	spin_unlock_bh(&phy->pib_lock);
 	kfree_rcu(pib_old, rcu);
 	return 0;
 }
@@ -788,6 +792,7 @@ static int hwsim_add_one(struct genl_info *info, struct device *dev,
 		goto err_pib;
 	}
 
+	spin_lock_init(&phy->pib_lock);
 	pib->channel = 13;
 	rcu_assign_pointer(phy->pib, pib);
 	phy->idx = idx;
-- 
2.53.0

