Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1195531716D
	for <stable@vger.kernel.org>; Tue, 28 Jul 2026 03:26:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785209166; cv=none; b=FE2p8HiCywxNfB4QDj8MK7jzrGY1z4k3DBMNcw2bBj2HSOr1ZW5xlsvnrDWHKkOk+F55IPqe7y/swG7ZIKhafGwNXKOzOd6A6LwhRMShqsqIoaVVNmcKaWfPNMdfTNP9+G13pDA2P2grL8dJjfEK563eJQmtyDEXFwKNQf2m1vg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785209166; c=relaxed/simple;
	bh=1Xjy7mvnUJLaf7K1NKEtHqfCqKb2Sj9c3d/cKgxqBpc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=fB52Ko+oOkJ/UUG+cAi0od/Q6bzL24NZpSpDlO470UxTtH3C7DwXIiGuRHnDqCArViqJ5R6KgC89E5l4qMGT1qctJuhhmU6Fq/soJpM765ppWnInVPkXTS54Lbn2onvfReDzs/n4zeOaOhfqHtwKIKWWArjgIJSzmtdlT6i1XJA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=NO6EDI1U; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="NO6EDI1U"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 300261F000E9;
	Tue, 28 Jul 2026 03:26:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785209164;
	bh=1aTccwo5lgl6pLo4ImDTcGlXkdcaD2IpPcdrtCg/9Uk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=NO6EDI1Ud84pfgj9u3gwDuRHEHJ9PLIxtwnxYT0ZTdnRzx1GclRBZTh3K9xnmn16l
	 q6E/+O2zqyUFByYvhjufClpFaCs19WFrvdk1iH+b7LnfevtJIRZLly7fBJ40/VvYbq
	 G6YfPQEdQA2/FTQNcBnZWbA72G6shapk3YRLIP6NqOFO42SuCXXfOOMEcms2Z99brQ
	 P755++pe56LDGfWhSxtDuFDZzs1eDwPULgaiHi91rb72MPcJD6gUZpn+32mfFiYgTf
	 S+t37/ssFZ7k3AE9+AXo7F/rKoNsVNgDc5DQGC/s1TpbfQrS0bYoynyaO39vjR10d8
	 syCDP2sl1bOLw==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Maoyi Xie <maoyixie.tju@gmail.com>,
	Johannes Berg <johannes.berg@intel.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.10.y] wifi: libertas_tf: fix use-after-free in lbtf_free_adapter()
Date: Mon, 27 Jul 2026 23:26:02 -0400
Message-ID: <20260728032602.3151440-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026072010-gentile-dramatic-7b6e@gregkh>
References: <2026072010-gentile-dramatic-7b6e@gregkh>
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
index 71492211904b34..b726e7e0b26084 100644
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

