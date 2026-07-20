Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B4F1A436BC5
	for <stable@vger.kernel.org>; Mon, 20 Jul 2026 15:49:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784562549; cv=none; b=t7UzUuPcWpgCf91Hcb8atgYXXOY3yVV+BR+RLfZ7njTatR1oommNrHS+bIrdcLM7waeT7iQhng+/Nubh/LCUAyf5yKpKO+FhpT22nLFjDYFMbMqnZQWxp+3SwQzkZ722NZxnMJTneq/V0e7KJmPBAsm62fs2g1Jg6gaX+t/By+k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784562549; c=relaxed/simple;
	bh=wUVxtG7nD2ZvG4lQtXw6njHNzecXmrHe77uV2HXGh/Q=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=ABeA5mfwd4NlSYnIgrVpUoerB5ZJciXJ9w+pdqsZVAbEmmZ14TDp617xRgwTUrg5K3HEdjt1bhxLsJTI/WSlIld/UtJ51Sy2O+0hP/3WE9AwIDnHifOaXm0jGve56ofdCBqySzSbT4B6LKzTKHg1nsJoZxR+m3k7HmKW5Ewm8Vw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=cM7+hANC; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="cM7+hANC"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 26F241F000E9;
	Mon, 20 Jul 2026 15:49:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1784562548;
	bh=oTg1/60/Euatzcaq2j6388CpOyIN/+S2lH+879hFd5o=;
	h=Subject:To:Cc:From:Date;
	b=cM7+hANCjp42XPOURvPFJazpkZbzxoV2t8DgxfbYxNC1DHQeMUqMgrqmKTn3DcBGi
	 5or9kelcgeOUT5/t+NufIIBMtiVhWlYApD7zmUiG5tU5JNp8kl8KmywWEbqyAHECnY
	 vpcC65W3HKhNTPGc4om7KRfbvs5zUzxBrCO8xcKU=
Subject: FAILED: patch "[PATCH] wifi: libertas_tf: fix use-after-free in lbtf_free_adapter()" failed to apply to 6.1-stable tree
To: maoyixie.tju@gmail.com,johannes.berg@intel.com
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Mon, 20 Jul 2026 17:43:10 +0200
Message-ID: <2026072010-postnasal-lisp-2633@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
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
git cherry-pick -x aa6dcd5c8dd9ba1d7d0f60093bcda41c0d6d438d
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2026072010-postnasal-lisp-2633@gregkh' --subject-prefix 'PATCH 6.1.y' 'HEAD^..'

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
 

