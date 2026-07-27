Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0586D345CCE
	for <stable@vger.kernel.org>; Mon, 27 Jul 2026 23:34:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785195276; cv=none; b=Xq8hjwZhI05f6630MD5FfqAsYeB44c8+W33feZvEXyqGGBYvG/HN+KklvZKiywLv8wqNgaJG6Hqc0M16k86FnnfojWe1Ru+AC9jeulBvS4LJeEnwx2ctGxEARXkCPTxgaxeKFU8P88GDnpDYmzWV/ZcrVRhYZkXE4nik7GTZYrg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785195276; c=relaxed/simple;
	bh=SwTP0Ad4jxe6LMIEOxQpjXs4PSg9KbWQai3efkhm7Z0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=sqVcVLpuyr9cN+T3oNZyS/S6J7ER/sJ8CCcnXrWJ4vajz27K9VkNpYZQVOa60zDAi1Nqv9qPGJsloBwPoUonbnIlO91b9OnXQmw98JAuzeFq3zOOte3ljYS0UnBGcLHq9WE9VEquS9ImQv1JK2rmse+qQzGXP0/fuCGeKlgZfM8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=FvNLXv2D; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="FvNLXv2D"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2D6021F000E9;
	Mon, 27 Jul 2026 23:34:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785195274;
	bh=9P3axS43K0RHGRhPUSpi9DGmYduSXOWqordxWN0KpG8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=FvNLXv2DUXBJkjXt5kovBT8OAvlDFtAeX3r9//AkuaCz7Y/aPLkA+MmA3BpDAsfpI
	 TyVKuzqG/K6uXUiqctnwnugQs3oTTCFCT0y/mlH6aZTllBe+0wp0SCtmEiK93/KxL6
	 KO/ebQCoTLshQsf2IjV+ycfRIhtBews1nv/3s9MwZqyQeylztGxwKfuZc9kS4/RbFv
	 /ugianYAaLQkZJtrp+1/vYP05PtM737KlNMkJlFTvkOQYSsbxzcq/0Tpxv2GJo88Eo
	 Z0yD/TPlTzrh9iEKcJa3EsvutSPh7D1jfGQXVeFgymStpowIHiNHTdRzJlj19Cfmb1
	 fCcvfb8YjLB6g==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Maoyi Xie <maoyixie.tju@gmail.com>,
	Johannes Berg <johannes.berg@intel.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.12.y] wifi: libertas_tf: fix use-after-free in lbtf_free_adapter()
Date: Mon, 27 Jul 2026 19:34:31 -0400
Message-ID: <20260727233431.2424901-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026072009-saddlebag-problem-d820@gregkh>
References: <2026072009-saddlebag-problem-d820@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Maoyi Xie <maoyixie.tju@gmail.com>

[ Upstream commit aa6dcd5c8dd9ba1d7d0f60093bcda41c0d6d438d ]

lbtf_free_adapter() calls timer_delete(&priv->command_timer), which does
not wait for a running command_timer_fn() callback. lbtf_free_adapter()
runs on the teardown path right before ieee80211_free_hw() frees priv,
both in lbtf_remove_card() and in the probe error path. command_timer is
armed by mod_timer() in lbtf_cmd() whenever a firmware command is sent.
command_timer_fn() dereferences priv. If a command times out as the
device is removed, command_timer_fn() runs concurrently with teardown and
dereferences priv after it has been freed.

This is the same use-after-free that commit 03cc8f90d053 ("wifi: libertas:
fix use-after-free in lbs_free_adapter()") fixed in the sibling libertas
driver. The libertas_tf variant has the identical pattern and was left
unchanged. Use timer_delete_sync() so any in-flight callback completes
before priv is freed.

Fixes: 06b16ae53192 ("libertas_tf: main.c, data paths and mac80211 handlers")
Cc: stable@vger.kernel.org
Signed-off-by: Maoyi Xie <maoyixie.tju@gmail.com>
Link: https://patch.msgid.link/178211481807.2212567.8773346114561900100@maoyixie.com
Signed-off-by: Johannes Berg <johannes.berg@intel.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/net/wireless/marvell/libertas_tf/main.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/wireless/marvell/libertas_tf/main.c b/drivers/net/wireless/marvell/libertas_tf/main.c
index b47a832b9ae214..25509a873c448b 100644
--- a/drivers/net/wireless/marvell/libertas_tf/main.c
+++ b/drivers/net/wireless/marvell/libertas_tf/main.c
@@ -174,7 +174,7 @@ static void lbtf_free_adapter(struct lbtf_private *priv)
 {
 	lbtf_deb_enter(LBTF_DEB_MAIN);
 	lbtf_free_cmd_buffer(priv);
-	del_timer(&priv->command_timer);
+	timer_delete_sync(&priv->command_timer);
 	lbtf_deb_leave(LBTF_DEB_MAIN);
 }
 
-- 
2.53.0

