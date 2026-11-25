Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795603231;
	b=m69K519hUTEEd2Mh3RWU/DCIzDAH363A13tU//f/+j4wWUX7OPQKvb2DTQQjqaVLTagA
	 rhLFwOdbpwjx/fgjUKjQCYk4SdIWBHafVtw8UmGkJq3Zo60RZOT7uxkLofoAawVaRRbJD
	 TjQjjo9AUMKux6TN4rrijgNVSNTfvUMMQaWg6blN0ZT/0a5xCRIvX8f4q6UvkrsBQKM6I
	 RnyZyi31vTRv8ZTKtdOjOnQfATmQqIWrYMscpQcRGt7oN+kknTglPvvMLh2eLOwxj5eCG
	 swUc9AAmLQODBPIU5DwZdO1WNJLRF0WF2xSP3ZyOJTFc833Jd5JR8Evooz3So+sv0Qw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795603231;
	h=Received:DKIM-Signature:Subject:To:Cc:From:Date:Message-ID:
	 MIME-Version:Content-Type:Content-Transfer-Encoding;
	bh=e+mNs48pHs1W7Zg8jGn2XHS/A/2LTbJy/pqZj0z4cbA=;
	b=hAcGD0GCrK8U0k7/GI+7U74yLkqm8rIuXjGiE4NpwZp0kW8xjMwU/04kUpOE/GhfjKPd
	 Vd8yOphkGifLkK3zz9U+UodJalB0jT46GaKuEVxhHg0lqCjj1EhHLdrObioMIaZOE15oq
	 t0Yfk7S/wUZS7SA+Y8pm1MSmMqv0q8BX+uhogQ4H5SU8iMiI4xEHDQW2G5/HchOevt3OJ
	 8wF9Ee04iwTEELkL5sZXiErn+kDq/TxSHsSIEPGdeYdrRbf+0lJCqnpmaK6wNnkaW+eHJ
	 fK0g+3uIjoeTEP8UFZh3Z1UiQcyBq99dJbOMnDiREE2rHbvaLnm359lZYnUg/lGBnlA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=linuxfoundation.org header.i=@linuxfoundation.org header.a=rsa-sha256 header.s=korg header.b=AUaG1NrW;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B2527606A334
	for <stable@vger.kernel.org>; Wed, 25 Nov 2026 10:40:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.a=rsa-sha256 header.s=korg header.b=AUaG1NrW
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9970C1F000EF;
	Wed, 25 Nov 2026 10:40:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1795603231;
	bh=e+mNs48pHs1W7Zg8jGn2XHS/A/2LTbJy/pqZj0z4cbA=;
	h=Subject:To:Cc:From:Date;
	b=AUaG1NrW6MzwC2xq/uOMCKwZ/Ky5hBY/ryMiwYyMPJ6UeWK3BO4lg/AUH6bpWrGps
	 79uURFhv+eD1PJp+hYQhWyKEQ3B8hc2UgPEUtJfqTEWoUTVgPF2D3g/FtJMWly+MNF
	 BGl29MENSCEfiFrOcDBgf8Y5VgyQhUOcin+ZCD0E=
Subject: FAILED: patch "[PATCH] wifi: mac80211: fix use-after-free when MLO link setup is" failed to apply to 6.1-stable tree
To: enderaoelyther@gmail.com,johannes.berg@intel.com
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Wed, 25 Nov 2026 11:31:52 +0100
Message-ID: <2026112552-scoundrel-proactive-5a6c@gregkh>
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
git cherry-pick -x a155ef2ef79531c139244289c5b8f15c05d16a0e
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2026112552-scoundrel-proactive-5a6c@gregkh' --subject-prefix 'PATCH 6.1.y' 'HEAD^..'

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From a155ef2ef79531c139244289c5b8f15c05d16a0e Mon Sep 17 00:00:00 2001
From: Zhao Li <enderaoelyther@gmail.com>
Date: Mon, 26 Oct 2026 23:26:54 +0800
Subject: [PATCH] wifi: mac80211: fix use-after-free when MLO link setup is
 rolled back

Rolling back an MLO link addition can free link containers while RCU
readers still hold pointers to them. ieee80211_vif_update_links()
publishes new links before checking for duplicate addresses and calling
drv_change_vif_links(). If either fails, it restores the old pointers
and frees the new containers without waiting for readers.

During a non-MLO to MLO transition, the published link 0 replaces the
deflink, so existing link 0 users can acquire the new container. Readers
such as ieee80211_csa_finish() and
ieee80211_obss_color_collision_notify() can also queue work embedded in
the link. If they queue after ieee80211_link_stop() cancels that work,
it remains queued when the container is freed.

Wait for RCU readers after restoring the old pointers and before
stopping the new links, so their work is queued before it is cancelled.

Fixes: d3e2439b0f33 ("wifi: mac80211: fix link manipulation")
Cc: stable@vger.kernel.org # 7.2.x
Signed-off-by: Zhao Li <enderaoelyther@gmail.com>
Link: https://patch.msgid.link/20261026152654.80697-1-enderaoelyther@gmail.com
Signed-off-by: Johannes Berg <johannes.berg@intel.com>

diff --git a/net/mac80211/link.c b/net/mac80211/link.c
index ce1c95b40cd9..34d313a2fef3 100644
--- a/net/mac80211/link.c
+++ b/net/mac80211/link.c
@@ -401,6 +401,8 @@ static int ieee80211_vif_update_links(struct ieee80211_sub_if_data *sdata,
 		memcpy(sdata->link, old_data, sizeof(old_data));
 		memcpy(sdata->vif.link_conf, old, sizeof(old));
 		ieee80211_set_vif_links_bitmaps(sdata, old_links, dormant_links);
+		/* drain RCU readers before cancelling work they may queue */
+		synchronize_rcu();
 		for_each_set_bit(link_id, &add, IEEE80211_MLD_MAX_NUM_LINKS) {
 			ieee80211_link_debugfs_remove(&links[link_id]->data);
 			ieee80211_link_stop(&links[link_id]->data);

