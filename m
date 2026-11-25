Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795639077;
	b=ZYzcmZpnNAPC0galYMhoxL9/LYB9ifhaoRBT3WQ7oLOfAaz971lXkhNEpJXdoHzEeywe
	 YEtXWftN3MyLVoNWqGHhaUrUCN5uk/kiGUryap3eSSIQbRrBeaOK+66LlyKt6n2I1m76t
	 2kw9vsGu1klNsVieA3cOpScfK5FxKBOmollKl/fkQ6v7KOEilZxuEqx7WeGS1uPWEUmhi
	 QD+W49CJx3hVX5rELlrkyHq2i6NShKt68uMzus5I1WqKlBmJXTXMyJzkYL7s19tem+v35
	 RaDAPMNT1NBpF4S0/ZshTSQydDTj4v27kXvdFEgPnav5QjFYP4aFi7SaEQxoTKpFF3g==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795639077;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=fkNY21WnpOzi7qqqJf7R/G0xVCTI+/m+txe0zqVBV2w=;
	b=3/+AtPH6hI3sMEaNInCrUbXs5zctZKihh0g/QHA+z58rXrA+OsQP6xx5Hg5GbB56eSkK
	 WBoZRgjip2tkPOsy14uWDUbbuutKwoFb9S2piaAoidmB75G58+vPmvKmlCiBE2aMatf7B
	 X8vkEnSGyetK8nW5hsVw5k87IMXVeO9v7J5ES1fCHWPr5JfpDdTER69Hs9ilx02dtg/ai
	 27nO9pk9tnBldZNslN2p/3SpA5NqNMXRxTsOa7mmFTGT2G/6tOufqPafaZTM3zkuVUIrY
	 ObIXHwqy8SQEMampnoG/A5arYp5O40wlqyqt1djUCH8Z8Qg31c+aDmEttnCDG2Hz4hA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Hsjsm7No;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0A099606A321
	for <stable@vger.kernel.org>; Wed, 25 Nov 2026 20:37:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Hsjsm7No
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 29BE21F000C0;
	Wed, 25 Nov 2026 20:37:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795639076;
	bh=fkNY21WnpOzi7qqqJf7R/G0xVCTI+/m+txe0zqVBV2w=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=Hsjsm7NoBpbmVgj8SRh8o3vZjitt1ERSbLlI0e4RP319kw25iMwAHXcTVXzc03TQz
	 SY458UBtfKIbj/5SeZaAUAMtNWzJer1Loxx74G8FezYhfU8IJPxTNHG0K5WzzgvV3+
	 XmCqHidHri80pQRCebK5V8VoPNpyTjfh3gZ7L+DR+PDhBPz8XbRSV+HjG9sBRap0uU
	 y9Kb5iiZCJMSCuaV8kLeDVJwdugvP4pvqzGlrhc0Y/ROvD44UhbmcPBxg/nprQZ4JN
	 amGD9E3xQYWglHj/aBu+Kfagp1fEFyAADi2ujhccpws+oLYzPb69uF5F4C0vTHDzaQ
	 shoGJXxXH5DMg==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Zhao Li <enderaoelyther@gmail.com>,
	Johannes Berg <johannes.berg@intel.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.12.y] wifi: mac80211_hwsim: ignore non-generic netlink releases
Date: Wed, 25 Nov 2026 15:37:54 -0500
Message-ID: <20261125203749.1436769-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026112524-scoop-zodiac-c2f4@gregkh>
References: <2026112524-scoop-zodiac-c2f4@gregkh>
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Zhao Li <enderaoelyther@gmail.com>

[ Upstream commit 989f47c56e48d442d79497a25ed946d029c4dc53 ]

Closing an unrelated netlink socket can remove mac80211_hwsim radios or
clear the active wmediumd registration when its port ID matches a generic
netlink socket.

mac80211_hwsim_netlink_notify() handles every NETLINK_URELEASE event,
but netlink port IDs are scoped by protocol. The notifier therefore treats
a release from another protocol as a MAC80211_HWSIM socket release.

Ignore release notifications unless they come from NETLINK_GENERIC.

LLM assistance was used to find the bug and review.

Fixes: 7882513bacb1 ("mac80211_hwsim driver support userspace frame tx/rx")
Fixes: e9ed49bf4c2c ("mac80211-hwsim: Add support for HWSIM_ATTR_DESTROY_RADIO_ON_CLOSE")
Cc: stable@vger.kernel.org
Signed-off-by: Zhao Li <enderaoelyther@gmail.com>
Link: https://patch.msgid.link/20261028141751.6728-2-enderaoelyther@gmail.com
Signed-off-by: Johannes Berg <johannes.berg@intel.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/net/wireless/virtual/mac80211_hwsim.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/wireless/virtual/mac80211_hwsim.c b/drivers/net/wireless/virtual/mac80211_hwsim.c
index 71f07e1a2a972..9f70025fafcc8 100644
--- a/drivers/net/wireless/virtual/mac80211_hwsim.c
+++ b/drivers/net/wireless/virtual/mac80211_hwsim.c
@@ -6454,7 +6454,7 @@ static int mac80211_hwsim_netlink_notify(struct notifier_block *nb,
 {
 	struct netlink_notify *notify = _notify;
 
-	if (state != NETLINK_URELEASE)
+	if (state != NETLINK_URELEASE || notify->protocol != NETLINK_GENERIC)
 		return NOTIFY_DONE;
 
 	remove_user_radios(notify->portid, hwsim_net_get_netgroup(notify->net));
-- 
2.53.0

