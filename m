Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6F35F434E20
	for <stable@vger.kernel.org>; Mon, 20 Jul 2026 15:49:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784562544; cv=none; b=b2cSy/CvGUecYqBnYTvnliBX6HFamBMhTWfdnhzEHiQwvx9tgMYpgxltz9uHYOsqOVRF2BUA4WKuoQkemhPjA/7fQjAV+PIm1ZMcYO295TjiZI+blSHFj3lhLeojHGgiQn7hVE58WxBx1qwupg2c9JYJ20x/Ztzxhs9HTPJPf/k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784562544; c=relaxed/simple;
	bh=OeIrAZJ4xq9MXsgG2pK612Y1VGJZMxAhYhLRiPhoQ/4=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=bj3ar4+UFs5IdlEyGSkifqYglR4Nox6/AZkEz1adC/Lntq+KB1UshFEZ5hWyacfFhwiu4yfxMVvuS+BLACrrRUruG9b6CTZpJKHbTgtR9XVmv0gvfU/V4nmizg5X/5hmyCM2r1kszZSisG20Tkgg1ekcQJq6RoGuSwhprNNETBQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=IsJnfyKu; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="IsJnfyKu"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D5F6F1F000E9;
	Mon, 20 Jul 2026 15:49:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1784562543;
	bh=vhQryXH/nFCcJtbrBBaUKX2ElvSj3RPToHDyVrphzQY=;
	h=Subject:To:Cc:From:Date;
	b=IsJnfyKuMftEzYnVZho1a9Iz2D7rV63sy8BjQT9duTIS4zuY/K9jul44jQaJpfJTn
	 7cIH/PVRODcdEE+D6U1BeCKQWB7w8gM/XtXe3zqD7d9mmfkunItEuSZwE4XfuXhFBh
	 UA3KvcfB8R48bj/E3ZlNFPrrAYPId0yoWW2rFbHA=
Subject: FAILED: patch "[PATCH] wifi: libertas_tf: fix use-after-free in lbtf_free_adapter()" failed to apply to 5.15-stable tree
To: maoyixie.tju@gmail.com,johannes.berg@intel.com
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Mon, 20 Jul 2026 17:43:10 +0200
Message-ID: <2026072010-corncob-unease-948d@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit


The patch below does not apply to the 5.15-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-5.15.y
git checkout FETCH_HEAD
git cherry-pick -x aa6dcd5c8dd9ba1d7d0f60093bcda41c0d6d438d
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2026072010-corncob-unease-948d@gregkh' --subject-prefix 'PATCH 5.15.y' 'HEAD^..'

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From aa6dcd5c8dd9ba1d7d0f60093bcda41c0d6d438d Mon Sep 17 00:00:00 2001
From: Maoyi Xie <maoyixie.tju@gmail.com>
Date: Mon, 22 Jun 2026 15:53:38 +0800
Subject: [PATCH] wifi: libertas_tf: fix use-after-free in lbtf_free_adapter()

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

diff --git a/drivers/net/wireless/marvell/libertas_tf/main.c b/drivers/net/wireless/marvell/libertas_tf/main.c
index fb20fe31cd36..42be6fa22f9c 100644
--- a/drivers/net/wireless/marvell/libertas_tf/main.c
+++ b/drivers/net/wireless/marvell/libertas_tf/main.c
@@ -174,7 +174,7 @@ static void lbtf_free_adapter(struct lbtf_private *priv)
 {
 	lbtf_deb_enter(LBTF_DEB_MAIN);
 	lbtf_free_cmd_buffer(priv);
-	timer_delete(&priv->command_timer);
+	timer_delete_sync(&priv->command_timer);
 	lbtf_deb_leave(LBTF_DEB_MAIN);
 }
 

