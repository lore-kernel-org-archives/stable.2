Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795639400;
	b=Mphsgc1PPjcmVqox+lc8LvFMPlDIxe7QHmja4jDXF7aGlO3b2PpIEz9ndUQL3wXNFzd2
	 zmb8cVm0aVvDiubQW+hHFR8rYrLy8J4/ys3K6NQb3z7ymoN2e5gyzUDe+OJcud+iMp2aM
	 Zp7RQjHktvaoTEVPIphdRVMam7UJowLKaeRUbCiRHeLg3WMc7rP4tPa67X5VtyIuJbr0b
	 ryVTAOyByxrA/9uWvQLn+dQls0rv5PKEVtgFZFz+nbCN+Rc19r2kdydKYMbLUBS/ABXOT
	 aThVwVdmtvknmk8ep4INCJiMsfRWNgp67yofJ57KldMp9vbXElt6771pz9v27Q66KGw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795639400;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=8tcve+Ft0iJ4rDYFhambebnlg6LjtbHnwuU5CV41ECs=;
	b=TzcXhzS6PVmTYEDc30e7beZ5UOayiMLzQt6QsOldeP99KzaDh30kedGhlA+ntm6ABwll
	 dcBvJJtgBU71Crkzu6X6PC10FPtBPGwuwoXi2pDDcVVwYW5Lne4G54eQlxWqwpq0cHibe
	 U1oWMuA/gKF6MmZxm9VyQ5FTXB9Aa8HNqX5ELAtScQhzAKcLreph6EG/Or2uK1P1zyFWZ
	 5v12gbuXkOW9YXqGrKcnqFlGa7afx/X81YMpstmsGn19++eN9I1j7wXtcdLnexKB7KHt5
	 zo3wvsnJv/iK22Sa+H9CJdBAhNtfEZ3mXd0c3gAUzkLgbG0szZtoWjaavlSh+Lk6kPg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=iRVDsjbk;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2222D606A323
	for <stable@vger.kernel.org>; Wed, 25 Nov 2026 20:43:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=iRVDsjbk
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DB29D1F000CF;
	Wed, 25 Nov 2026 20:43:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795639399;
	bh=8tcve+Ft0iJ4rDYFhambebnlg6LjtbHnwuU5CV41ECs=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=iRVDsjbkyOL2WF76kHmepT7fJCLzgtr6eT4416KHL9vm3o1kRYmqTRo9qjJzmA9J1
	 D0xCe8f2ysQ6syIW/+729BZXK4xkZ5WEXHYQeXo8jUNNGuqMsY36grBVuQErT/2JxU
	 7Re+O5UWWVU51jfoE5tJQNOWkKMcFqBYR/rxHhjQO7Yqz7gf3pBx0TcaZOg9eXD1VI
	 vjOvf5ANTqponVXy/HQzFSDXrxeEVx0TLL9BAxdx+KSmhN7mQ1ZUkISJB6OQKdrN+1
	 MjSO0WoGjKY39UQRvuPnum3YjuPipZhgoZV5BBJxtwbzPlG7YQVwZsol+CLIOIo5q2
	 H4AFwaO/HoobQ==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Zhao Li <enderaoelyther@gmail.com>,
	Johannes Berg <johannes.berg@intel.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.6.y] wifi: mac80211_hwsim: ignore non-generic netlink releases
Date: Wed, 25 Nov 2026 15:43:17 -0500
Message-ID: <20261125204312.1467689-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026112524-chunk-drudge-e37b@gregkh>
References: <2026112524-chunk-drudge-e37b@gregkh>
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
index 6731f0a3de1b3..1531c04ddfd51 100644
--- a/drivers/net/wireless/virtual/mac80211_hwsim.c
+++ b/drivers/net/wireless/virtual/mac80211_hwsim.c
@@ -6232,7 +6232,7 @@ static int mac80211_hwsim_netlink_notify(struct notifier_block *nb,
 {
 	struct netlink_notify *notify = _notify;
 
-	if (state != NETLINK_URELEASE)
+	if (state != NETLINK_URELEASE || notify->protocol != NETLINK_GENERIC)
 		return NOTIFY_DONE;
 
 	remove_user_radios(notify->portid, hwsim_net_get_netgroup(notify->net));
-- 
2.53.0

