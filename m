Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795603221;
	b=O0TnMUWjNgAipMTpuGZF2BOSEoyxxKWdGwKx8MoHcyAHAhLLcRuRCkh5VqZaK8cb6qNM
	 +CXFh8YAar4+4PQ2xweEqrtrmmDhQR/cLJc+5dGpstF7YzrKqxB3WVGleqMOzcYrKA8i0
	 OiRhphP4tvQivn398M+fJrK6TJ/b+BuGPK9CrFjIyhB/NjHTAB8y0Ek3T0YC0kxv3J3+j
	 7rifO4ilAwh0yphQ7MuakFrtXQEZkYYhORr2LC9nmK2ZW0XkgSQqGaci9GtMrKEc+gQtA
	 5jYuVejZMqQOrcJK1PkeDk0nSjBxcTYkFVmTBNshsCamytk44jkDf8Cpz2YFfIJ5Ubg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795603221;
	h=Received:DKIM-Signature:Subject:To:Cc:From:Date:Message-ID:
	 MIME-Version:Content-Type:Content-Transfer-Encoding;
	bh=t7KL1lYIBacquhFq81TFp9NlTdTFB6Zip6UE7m0MxMk=;
	b=nZQXyg5I/eFqzBwAncElXsKfBgoPKsrnUhKiemq/kvgEdO1P4cwxvKdgjXhiNVuYBccu
	 nc7GNJgXV7ZGj5KOkuq/dgW7Z7OOgn2eckxmElOxjofPEModS/a2dYYxDVwTFJSt3pizD
	 bCGxjlQL62Pjq8Meb0qfY4Al23LSI9r1W5AfD8L4m+DXsgTcTDfNuBKLfEVVwLQ1GHtJF
	 yMFqOi5/AZux5cw1y9xH2LLa96G3Ig4ktcYHk9cDXbrYOtGYgow/DGtlTP9+kFRaMQewS
	 EAKFFjPRld81IKYJFAF/gwkc+XXOfm3lTUhoCqjkCscW7RT7CODhNxGqd/qj4HMUC9w==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=linuxfoundation.org header.i=@linuxfoundation.org header.a=rsa-sha256 header.s=korg header.b=W4PKyl+x;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9DD1A606A326
	for <stable@vger.kernel.org>; Wed, 25 Nov 2026 10:40:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.a=rsa-sha256 header.s=korg header.b=W4PKyl+x
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EEEAE1F000C0;
	Wed, 25 Nov 2026 10:40:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1795603221;
	bh=t7KL1lYIBacquhFq81TFp9NlTdTFB6Zip6UE7m0MxMk=;
	h=Subject:To:Cc:From:Date;
	b=W4PKyl+xG2BUqyEaSizRtGeYP21hLHUxICld7fTbPa4Ru6yx8/mkXn0An2bamIyyy
	 y6mjashWnk9kOYOJ1qlzohIg1wIvUbyRjONCbmnRMal5NHT4ZOuRiBy7lGXz6CmIcG
	 zeObA2tq0ZTrY7WRoK+rYd8GMpeK9nFCDVuhov80=
Subject: FAILED: patch "[PATCH] wifi: mac80211_hwsim: ignore non-generic netlink releases" failed to apply to 6.1-stable tree
To: enderaoelyther@gmail.com,johannes.berg@intel.com
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Wed, 25 Nov 2026 11:30:25 +0100
Message-ID: <2026112525-unmatched-vascular-e8f1@gregkh>
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit


The patch below does not apply to the 6.1-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-6.1.y
git checkout FETCH_HEAD
git cherry-pick -x 989f47c56e48d442d79497a25ed946d029c4dc53
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2026112525-unmatched-vascular-e8f1@gregkh' --subject-prefix 'PATCH 6.1.y' 'HEAD^..'

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From 989f47c56e48d442d79497a25ed946d029c4dc53 Mon Sep 17 00:00:00 2001
From: Zhao Li <enderaoelyther@gmail.com>
Date: Wed, 28 Oct 2026 22:17:50 +0800
Subject: [PATCH] wifi: mac80211_hwsim: ignore non-generic netlink releases

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

diff --git a/drivers/net/wireless/virtual/mac80211_hwsim_main.c b/drivers/net/wireless/virtual/mac80211_hwsim_main.c
index 6bbbce75f05a..49ec2948c68a 100644
--- a/drivers/net/wireless/virtual/mac80211_hwsim_main.c
+++ b/drivers/net/wireless/virtual/mac80211_hwsim_main.c
@@ -7293,7 +7293,7 @@ static int mac80211_hwsim_netlink_notify(struct notifier_block *nb,
 {
 	struct netlink_notify *notify = _notify;
 
-	if (state != NETLINK_URELEASE)
+	if (state != NETLINK_URELEASE || notify->protocol != NETLINK_GENERIC)
 		return NOTIFY_DONE;
 
 	remove_user_radios(notify->portid, hwsim_net_get_netgroup(notify->net));

