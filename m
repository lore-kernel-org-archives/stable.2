Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4D72F36B92F
	for <stable@vger.kernel.org>; Thu, 17 Sep 2026 01:13:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789607615; cv=none; b=gGG5DczQfepJBe8+5szTKaWf9WFr6CkmwXLorBoYxM9xdsrYlpvjTqR/Rd+n/yXrFlNCcpzbUSWb+qh4cE1JBHpm4Zy1JWSelfQyRUBz8W7aSzbW18aE1Ad14HZFK9ITpSafJ8lOJsEx54xNLjFazlD9chuqWfBFYb1OUe7MLHw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789607615; c=relaxed/simple;
	bh=1EqHGAaT/mT5wFvdWtBespSsKL5gFSnkLDDYXgyaTEc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=npaCUpVpUOSQbFciXs0a9woqjkVZb5yPyxeEP7kZjdc0euybhZBFxHrEeBJ94DEdCswt9PdkCvqfmMr39Epq/KGdOQ7je7H3yZPB2MqNkidk8w729KQHfnpYMAHoluTNx1l72oFSgjYD3I8oE/8qibgGLoeICzmoJE0Wx0LRciI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=A0xJ6Drz; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="A0xJ6Drz"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0A39F1F00893;
	Thu, 17 Sep 2026 01:13:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789607608;
	bh=uojKJYSbQN2ZLylTZr0w2JqFSQLHcwA9xjp/SukdnWw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=A0xJ6DrzyLwyEyojNKi3PNSAdIuHEbe+KKKH7ARvswyearn4ldAvLn4o29rqPSL3w
	 YfAGzF9rdgEWNd5XO+rMGsDMCRy4hFjlPZi6YxljALqHrP3qoisC+7bY0Q3trU4NdX
	 b1iZsYvrVnCFLOlcqgozptaPPrwC2zlKxyFlKKCElSFl5buIYUTwnG+A1sIHXLJnlo
	 FOv7q7jiXJivikUe0LhxlRvdaDnB2ocELO078l8B6Uk8uhmylazfBV95hvqj+fcd8C
	 kE368ZYAjDE25wPMPrS73h9sxbGolQv/STpxVnEqDpSGpw7iEuqYfocECWkca5DccQ
	 GUgbdRAUKp10g==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: David Carlier <devnexen@gmail.com>,
	syzbot+60332fd095f8bb2946ad@syzkaller.appspotmail.com,
	Stefan Schmidt <stefan@datenfreihafen.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.1.y] ieee802154: hwsim: serialize pib updates to fix double-free
Date: Wed, 16 Sep 2026 21:13:26 -0400
Message-ID: <20260917011326.3531363-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026091655-percolate-occupy-3e3c@gregkh>
References: <2026091655-percolate-occupy-3e3c@gregkh>
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
index 9b3da61840a8f..1b00efc44dcb0 100644
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
@@ -789,6 +793,7 @@ static int hwsim_add_one(struct genl_info *info, struct device *dev,
 		goto err_pib;
 	}
 
+	spin_lock_init(&phy->pib_lock);
 	pib->channel = 13;
 	rcu_assign_pointer(phy->pib, pib);
 	phy->idx = idx;
-- 
2.53.0

