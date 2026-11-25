Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795638504;
	b=wpWrWChsMfjcDgEYLpiSMVytNlE5cBwVgBoyZ6xxVrBvqs2oeI/FMGvIaVSezNdtp9N/
	 oO9pKjN95yO07APczjzaZ6xm0gKU5YKv3MMz0ypfzSnEUFnA63BnO5kwv07Ngya3AGHsN
	 4UaK94T41lEfFCfSDq03WWciH7zdNi1quqNmZlJHuMHgIdc+2q1LnzsyKFBvgkGE72QEb
	 8ULqIGsUl5+DzZPzsZmh0Q/x85cSO+1u7rqb78lTvGtuTsxAMCCeqQwGX8c624ZmjSUw+
	 AYYtwYintFhVOD/KIplS0prWKkXHaC7ANPWCkRnApjk4kWiEz59dquB7n8JQk/wSirQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795638504;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=hdv2cUD8CzHQThrd1+eINMsPYaY4koIN9GEHqmDNqn4=;
	b=1Q37vTJ2rMR9na3+NiwfedTaOhAnDLVRasyliwoNFr0dzVB8LBpYj+0SQZ/7G4766ljh
	 Y61w2m3hE2jO9P5YSpfOw3lK7ov8+J8YlSItHI7bknI+HckBxDOsiNP4sxIWYY5vXSr+o
	 ZnCpHVqpq85S+FgE/X3Z6xhNxRF0zAQ1yLaxjW4cZp8QTa2vfHHFJZNXNUpbUdfvCSRds
	 Fjt7k1yRuyk0OtH1Pt5dUhWGIT1wJE/7TcCczF1fFJTsIjkdHgnR0DypbCrV6JbnkBC1z
	 VhYhbafj0D95MJ3e2JXkC7HiWtHMhw0q02Vggt5wxKkvRh2JJT6LG6ZxLUJDwCRzi9Q==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=AmSitKAq;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0F253606A31E
	for <stable@vger.kernel.org>; Wed, 25 Nov 2026 20:28:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=AmSitKAq
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 68AE91F000C0;
	Wed, 25 Nov 2026 20:28:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795638503;
	bh=hdv2cUD8CzHQThrd1+eINMsPYaY4koIN9GEHqmDNqn4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=AmSitKAq38zhuIOHv3lluSbpDW83xBMHed2l7PKUGCiqnSaGxeifONkuO5LVmopCM
	 vAq1pccSY8X+x3jxVXbIGEyGkeGSGs7XvO0zu+FPEI7jy94dsqLb5a1r3yZ5hOgHWx
	 dPwsREnNmjjHKzRWF2n3hZ+bvFRVWqtKqfqXg9YUJaLqP1fWiq/NrPe4+bLcHRXG4z
	 2kRnTP/5pkdFVGcsVxB5C65epmMYNdTY6bq7Q/ZQowTXCQZkgFADkwZ8VZsuO6Yn4B
	 wkXn8j5t+FgMSgqOsmhO6YvvTeYeslXdkImYRZ6nTzPB/Uu31Jh+FrFZ7CE/xnN/Kc
	 epf5V8iUDqmHA==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Zhao Li <enderaoelyther@gmail.com>,
	Johannes Berg <johannes.berg@intel.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.18.y] wifi: mac80211_hwsim: ignore non-generic netlink releases
Date: Wed, 25 Nov 2026 15:28:22 -0500
Message-ID: <20261125202816.1416123-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026112524-postnasal-bullion-f08c@gregkh>
References: <2026112524-postnasal-bullion-f08c@gregkh>
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
index 89794c724858c..eecd6e2ee27e4 100644
--- a/drivers/net/wireless/virtual/mac80211_hwsim.c
+++ b/drivers/net/wireless/virtual/mac80211_hwsim.c
@@ -6747,7 +6747,7 @@ static int mac80211_hwsim_netlink_notify(struct notifier_block *nb,
 {
 	struct netlink_notify *notify = _notify;
 
-	if (state != NETLINK_URELEASE)
+	if (state != NETLINK_URELEASE || notify->protocol != NETLINK_GENERIC)
 		return NOTIFY_DONE;
 
 	remove_user_radios(notify->portid, hwsim_net_get_netgroup(notify->net));
-- 
2.53.0

