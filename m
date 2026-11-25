Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795603207;
	b=l2c7MFxdpmqdbIRel0iZBAQnYMKC3tXglQoRmxZjRKdBP9JNapRVja9Tj4a9HbgrygLG
	 fgHXznHATbGDxaLaPir5kzqg+wt5vgtE1Zy67wA2pKF8izNGLYdSzRN5KeqUkNh/YicJi
	 TBbpGQfArYG3DZnale82wGc1bFK6DkY5l+/aw5zGnB7APj6X0oHKgzk2cASd9ByGal0+J
	 uGXR3SN91wxmgyTqcFcXjeyWgOdPQKYPeDDZD4CCa2LqO2koScXKOXzBoKqAWUzEC4I84
	 wZcDlUyxa63M6luqON5V4XBOMj0AQFjptcpgeqmTgmGWHAbZRIzKksafAffleLgEA3A==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795603207;
	h=Received:DKIM-Signature:Subject:To:Cc:From:Date:Message-ID:
	 MIME-Version:Content-Type:Content-Transfer-Encoding;
	bh=8qE2VT9Qmx2AHFwk12YScfyjHv+VV520ZxbC87KbTzI=;
	b=RBA8yVcTiJxxCbCMEI4UnWSK03aTpdED8vaiy8C+xlqzK/YC77OLeGOjnmBgY54AFhuS
	 /Flynr20O9ZpK239om4MUaNUnIiBR2dgyGDhOme9tc9rpGgmdHxhMgs6Cuot7J8q8Uwd3
	 P6dQtBlwi1aRlQU9tpp5ZPuGB0F3QYZaCGKdvXBdjJOJ6lZhZGbYMuWErhVnQAa/T9IGj
	 N+fM0EcGEUc1PeFfuH8bXfXS8csXNpxdSeNif4Ituq86Wqjg2gdvlfW5YvNOF/4JOk6t0
	 RxZqureUibu8DsOXeojgUqapk7xHBRCz8t4xlXMmOQyonoz+JSnsYlCPSTIijSd78tQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=linuxfoundation.org header.i=@linuxfoundation.org header.a=rsa-sha256 header.s=korg header.b=WjPswjj1;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3805F606A321
	for <stable@vger.kernel.org>; Wed, 25 Nov 2026 10:40:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.a=rsa-sha256 header.s=korg header.b=WjPswjj1
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 84E421F000C0;
	Wed, 25 Nov 2026 10:40:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1795603207;
	bh=8qE2VT9Qmx2AHFwk12YScfyjHv+VV520ZxbC87KbTzI=;
	h=Subject:To:Cc:From:Date;
	b=WjPswjj1gIfZ0j+U4HGQ16bPud7jGSxE1yI5VmHgPvzWSNyDv+K2Hlckyc1I4E4/X
	 4Wonv2kJCnTa2hM6uvT1qOg4WlGw/WazgHVAdqitBwF9V0Nej35ZdLWJyuAGIw8UQm
	 IyoRkWEaoLUGur9D8vga4vAzP1pOc99ylB2oH0dg=
Subject: FAILED: patch "[PATCH] wifi: mac80211_hwsim: ignore non-generic netlink releases" failed to apply to 6.12-stable tree
To: enderaoelyther@gmail.com,johannes.berg@intel.com
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Wed, 25 Nov 2026 11:30:24 +0100
Message-ID: <2026112524-scoop-zodiac-c2f4@gregkh>
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


The patch below does not apply to the 6.12-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-6.12.y
git checkout FETCH_HEAD
git cherry-pick -x 989f47c56e48d442d79497a25ed946d029c4dc53
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2026112524-scoop-zodiac-c2f4@gregkh' --subject-prefix 'PATCH 6.12.y' 'HEAD^..'

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

