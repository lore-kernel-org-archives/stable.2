Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795640278;
	b=gaRLdw51hHILGTrSNd+pgYSqDwO1bFOHAd7plmn0EcZ4fMfHHP7Zh/vDP5RbZm7SZSZE
	 aNw0Zig56+W4lRhHFdN0n/fZRGvly1Mnh+kCdhiLlFymCxFBlD1kgWtG84XG1ik+ZS1KE
	 +hO7xyJSdlJQGkr1CxusFhdqXz/lduogdPQWv+as91wAvPPong2Y2LTMNDOnHV1ftE6Lk
	 OXc7URM6qZg5FdBPf5w+dwtR+qPywxbbnBi7wN038GTSBr4afX2UO6RfAoHjEzuXVTmgG
	 7A/J6JhQ/sw7zuIf7uYYZ4esIr5F0ogaaedamHlmbjWVfdxNeh9bPkW0yNaITMAIugQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795640278;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=voGbDxAfebOEp6BtxVSTzWNdjW+Ob/GwAtxmR0eYPi8=;
	b=EtNZQJ8dCSWT0RH95ekaGfHYZwinDr1OsejfOWCBzEPpYjUfmwU967i9N7eqGJDJEdwC
	 nrhre3QODRTjcIFGVmsTDn9IoStasEOedxFWkeoSQ5ZJKUlLj4+fVp0P6nnOAM0XJFclw
	 n5zbeLxDO8HsbLP6+I5CUeUQsn+mNWU+jlcWgZKFzVyoT5ErFk3ufYnqC+csx+beeZimD
	 T4SHxefHB4iRzqdjl6QfnyEZKfwpU06WuH1/IvmYUY1WimexINNRvro1m1FfL0LW61yUm
	 lXTq3pEflLeWjt2jyfV/1QVlKGOi/Y5+go0TOMx8GnUk7MIik3uANZ2mAu3nXhMznTg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=NTviIFy0;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F18DD606A32A
	for <stable@vger.kernel.org>; Wed, 25 Nov 2026 20:57:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=NTviIFy0
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 49F391F000C4;
	Wed, 25 Nov 2026 20:57:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795640277;
	bh=voGbDxAfebOEp6BtxVSTzWNdjW+Ob/GwAtxmR0eYPi8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=NTviIFy0mXmMBb8GeO7d5lcwgTIMsQ2qXmVROZqcSGOpPQYIfknQhjoypTlznN88x
	 1Wc7MOAJ6HoOoAs8RRt0xl64o8WsFD+qwRbnkmYx2+IkqHs+9cl3jcRg+OW4JK9vti
	 wpf54CNDaCYZdbKbbj5Z0A4Qa9I2r1dbxNfnT7yfrFzAA5aMV8gLUpRP+L4rPo3Awq
	 nAg6lZpUij5aYk+XSrtmKPiC+VaH5He0Gv02zCOAMuglHZCLis+5OrsdQAVZSokSXe
	 MaYetw4sZJs1U1ak+mlX2XZ8wvo2MliCY4q4iRrVyKWcJCI2wkT048whekd6GbKapF
	 Hb5ke4LBx/AOg==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Zhao Li <enderaoelyther@gmail.com>,
	Johannes Berg <johannes.berg@intel.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.15.y] wifi: mac80211_hwsim: ignore non-generic netlink releases
Date: Wed, 25 Nov 2026 15:57:56 -0500
Message-ID: <20261125205724.1499965-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026112525-context-bulk-d4fc@gregkh>
References: <2026112525-context-bulk-d4fc@gregkh>
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
[ sashal: adapted to the older driver file path and the older one-argument remove_user_radios(notify->portid) call, without the netgroup lookup ]
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/net/wireless/mac80211_hwsim.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/wireless/mac80211_hwsim.c b/drivers/net/wireless/mac80211_hwsim.c
index 6bf9a0309dfd3..32c3a0c4c7cb1 100644
--- a/drivers/net/wireless/mac80211_hwsim.c
+++ b/drivers/net/wireless/mac80211_hwsim.c
@@ -4170,7 +4170,7 @@ static int mac80211_hwsim_netlink_notify(struct notifier_block *nb,
 {
 	struct netlink_notify *notify = _notify;
 
-	if (state != NETLINK_URELEASE)
+	if (state != NETLINK_URELEASE || notify->protocol != NETLINK_GENERIC)
 		return NOTIFY_DONE;
 
 	remove_user_radios(notify->portid);
-- 
2.53.0

