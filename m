Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795603210;
	b=k3RYfepJlIHQNUJ17TauRR4rxS4asZwKz7T15mn/abN+y+QuWBncw43YzGvPO8y9cD65
	 ZJRKJUPol8hg1giIUw7/4O2Tdz9jUMV3yGmu6svZu8DJiEEXCUqr4M0EUWjmp2ELWurBP
	 lsPYd6ZU9e7lS4+D+kc0izNHLYLqu1BcNGmOjcptNwVt+STmAtF+ljWwqeqj3V+umy3wA
	 +9ueSI9cmsOcv7/sMiB4A+iQ/CoufXMcZ1agDwNVUsYgDGIiQTNe1ZGcGL+qKQt2Du77G
	 gCdCwa290fs3oD8CL4Hacla/6vypURkKo0+gIjuGWYwqz1aOciFw5W2g4W7YCJmiNYQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795603210;
	h=Received:DKIM-Signature:Subject:To:Cc:From:Date:Message-ID:
	 MIME-Version:Content-Type:Content-Transfer-Encoding;
	bh=ZeyAOSBLQH7UiVBAZBgBjGoLtqMNAuo03X+LkRHjuBM=;
	b=SAPjPt++tGXutYAiALRjZYsdrjSgFQP8H+C1CUDLl1Cl+0YM31uAE5pVuEEteB5OMeva
	 HvnLmUprQIzbelMzoIHxogtx+NwByP8v0riKTrLQDXTIcUgMv17XsKzjORM3XHVkpddvg
	 3pGoUuRiC4nCTPAcDgEkp8XX1pFYCs+/BvmhtMryZpveLeWtnWZShPoPWtcQ1llQ7D3Rh
	 7Ox2V1JKTlZv5S0IE6x2bpsEnAFb+Dvouleb+Lfh8DzLV8xG1GByu86c+F8YyUH4mzjdi
	 Db/ueF4OvKTWbwV+zFZWbhXYu3vb4CVN0dcRXNJgqQclPgNsBN3Nsju/jFx3iQc+VuQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=linuxfoundation.org header.i=@linuxfoundation.org header.a=rsa-sha256 header.s=korg header.b=XF3O6NRE;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 67D96606A321
	for <stable@vger.kernel.org>; Wed, 25 Nov 2026 10:40:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.a=rsa-sha256 header.s=korg header.b=XF3O6NRE
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B8C931F000CA;
	Wed, 25 Nov 2026 10:40:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1795603210;
	bh=ZeyAOSBLQH7UiVBAZBgBjGoLtqMNAuo03X+LkRHjuBM=;
	h=Subject:To:Cc:From:Date;
	b=XF3O6NRETWyAPIGdfVPHV3IJxUxbq53tlqMGFzullLY9oQviBPGqh6dKQS6uNAMUX
	 UHfq8bvqXVe3lWDVCcvlukb61Jt9KLtnHTxAPtea4/edwM++1oXiyt2nD6lkR6FUBp
	 6pVoQwwBHJ6YLpFT6qnszxxbhoqO55E/7v3ekwfA=
Subject: FAILED: patch "[PATCH] wifi: mac80211_hwsim: ignore non-generic netlink releases" failed to apply to 6.6-stable tree
To: enderaoelyther@gmail.com,johannes.berg@intel.com
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Wed, 25 Nov 2026 11:30:24 +0100
Message-ID: <2026112524-chunk-drudge-e37b@gregkh>
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


The patch below does not apply to the 6.6-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-6.6.y
git checkout FETCH_HEAD
git cherry-pick -x 989f47c56e48d442d79497a25ed946d029c4dc53
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2026112524-chunk-drudge-e37b@gregkh' --subject-prefix 'PATCH 6.6.y' 'HEAD^..'

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

