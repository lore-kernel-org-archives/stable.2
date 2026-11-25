Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795603218;
	b=s3sNpipe0A9niW3eBiUjSJUjyGvs19M4CAsfc0XuLgKckNXjRfzzYprbFaOWpOIsoEI/
	 5Kf91gcZJnVGNz0zWm6sF+d0iFo3m2JRGBsM7plgdFbdnmSgqrhA3X9J/DnE3cuEkqndc
	 3PQSZ9n4kROp2bv7roSJmicrAEjHWbqhXErAQZIoMzuA47sFULUAm5Sob8/q0xMGrKfOv
	 HvMHy9GTumoq3Ij2N2DNZlrvNWQ0J3MkaTfCP25Knq2uGgCZhRV8hW013S6KWEyqcjvFH
	 V8QAr8kkJOx0e+qAFHOAp0LKb9xraq//nhm5PpsSvoNOcmHPS9krd0Nrr1ZIwYM9OQg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795603218;
	h=Received:DKIM-Signature:Subject:To:Cc:From:Date:Message-ID:
	 MIME-Version:Content-Type:Content-Transfer-Encoding;
	bh=+ACrXHRztB6ApUWvX13cNA+0t96kFG4IPmmpEf3ayIk=;
	b=WPoJqQxSLAZTJPI1hrFwThwJ5cIbuLIZZJUp58FxdXOu7gAHrXVAnpPCU8EKgjHkNFrl
	 lO6NZaSxkdJnQmht/KsZyvxTNAy/v+cy+6y2RCVAIZRpGIRZojSvO2xan45LhYUW7nzqt
	 C8d0I8rlqWA4tkPYHHt3cQyeYzzpxCge3xm5iIniveFKQlMU3gd9hJE+5cguxItSz2oJb
	 6f5fOizOHZx2XMoj8EXqOkJ6LDCOLKmhxdRv5PJt38XNDdgg2D/BozZWpGFFYxtCbxA9r
	 0oOJo2xCjcfi8jP1jv3vfqwG/R1Kq3Ix7fhLC88ZSPT5zKxwgFEnwTgEXeHxf1kwHCQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=linuxfoundation.org header.i=@linuxfoundation.org header.a=rsa-sha256 header.s=korg header.b=LheAucev;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C7A32606A31E
	for <stable@vger.kernel.org>; Wed, 25 Nov 2026 10:40:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.a=rsa-sha256 header.s=korg header.b=LheAucev
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 23D411F000C4;
	Wed, 25 Nov 2026 10:40:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1795603218;
	bh=+ACrXHRztB6ApUWvX13cNA+0t96kFG4IPmmpEf3ayIk=;
	h=Subject:To:Cc:From:Date;
	b=LheAucevBDbb9eX0RnK2J/8w2VvBUzmNJu4KuVCxwMsucrrGaquKpd9Zy6/om4zpT
	 wshKCqtevzzknHpgMuCJ8Zt3V59oB/QQhDLSAECNgRIEHMHAICMuq80GlU49PbmOI+
	 Bjfmz8wGwxxxSk8LUiak0hKrh1LRP57Tx/j52uLE=
Subject: FAILED: patch "[PATCH] wifi: mac80211_hwsim: ignore non-generic netlink releases" failed to apply to 5.10-stable tree
To: enderaoelyther@gmail.com,johannes.berg@intel.com
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Wed, 25 Nov 2026 11:30:25 +0100
Message-ID: <2026112525-colonist-aide-c6b5@gregkh>
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


The patch below does not apply to the 5.10-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-5.10.y
git checkout FETCH_HEAD
git cherry-pick -x 989f47c56e48d442d79497a25ed946d029c4dc53
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2026112525-colonist-aide-c6b5@gregkh' --subject-prefix 'PATCH 5.10.y' 'HEAD^..'

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

