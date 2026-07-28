Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 65B1425B085
	for <stable@vger.kernel.org>; Tue, 28 Jul 2026 00:57:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785200269; cv=none; b=nThH26ZmL1M9V2yp6wmgqzR8JhU4gySieuByjdejYFZ+ym00muehMw6m1qbbPGGSO0Z4jJWpn6LJVXWfP6gfC84eLNIAnwT463FShBVGqpb81B+CBQMf5um+jtjIQRTHoecAvCrNWZLnPZcI6k4BbGWt+krEk2GR86z1C+pMUmA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785200269; c=relaxed/simple;
	bh=Jiqs2QGoJhj76tkPx2dPKMKZmXfoTXVQtPuH+xLtEEY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Q/PCQqJRND2lrQSmGaNaPygYyp60v5sch7+DWTm+PIb6ddSzPYUxgtU26ovGKhrBu4fQaqRZnpFwkVS2Y20PRNgBaPcMJcITloa7mFsO+hHnn2Ga+PC2Y2ieYH35tgeVIfjXdJdblAbusNnS+cDI3+bCCqnRWCfYi9mHb8n2Mtc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=kJQW0h0i; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kJQW0h0i"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3B9371F000E9;
	Tue, 28 Jul 2026 00:57:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785200264;
	bh=WXwD6d8aZjGuxoQJIInVjMbe0lAfOqWVvPE6oSit5uI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=kJQW0h0iMUY3xbW8oCbnc1EjwjrwwkW+L5/TsZscqZlLYzTjW2jncqqg1ey4mj8J7
	 pgwQ24droLqqw5h6c9Q6UJGWJ/K4rcjnA+qtLlOZM3/bsPXIAKbueUpojkTGPpxiT0
	 FwPnhN9eazS0CtzJ6Qa4JhGG5eFxwG2fTC9iVMcp42tQQfEv2WlVIWATyaNHoJgrvb
	 ZEuTDbL2mZITKCnfuy7IT58N06rNkEel5M2FF53E4sjX4nKX06MmVT6mEETOnwUL7U
	 djNyHMSkAQ0ta+6qJCxSofEdP/+xFm1FYByq3RQfk4q0px8r/X3xc3QPtENsJE6yhB
	 IvLbEJnK/FrEg==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Maoyi Xie <maoyixie.tju@gmail.com>,
	Johannes Berg <johannes.berg@intel.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.6.y] wifi: libertas_tf: fix use-after-free in lbtf_free_adapter()
Date: Mon, 27 Jul 2026 20:57:42 -0400
Message-ID: <20260728005742.2689126-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026072009-steerable-peculiar-5fd1@gregkh>
References: <2026072009-steerable-peculiar-5fd1@gregkh>
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
index 199d33ed3bb960..96c46f7679d970 100644
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

