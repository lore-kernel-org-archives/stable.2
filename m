Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0637F4A2E19
	for <stable@vger.kernel.org>; Mon,  5 Oct 2026 14:39:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791211185; cv=none; b=rcipBs0zHM5slsIyy3Qms6GOH4XXPMCmHPNcl47NVtsMyO+UC3I5QBEGZROLIv15JGzAKT0Ujd3BqmrHzmFEkQRT/FPuV0Ug0lR/rW0FNEF+ENQ5zoFSS/wo+VMqTqQqR0q9dCiVYJWkwRKDCG8QPtY4ayONjJIq4zaJ9UVc9wc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791211185; c=relaxed/simple;
	bh=9S4ANd9EQAMjpS1DdkRAl7gDu9tmXhm5mcxp729vURI=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=h5gAsE9kJsAJjKT4LKo3XSWXBwC9NLX63aClFVPb0sbCckrPcIjl8YQg28shVImoLDSjCc6oaOguZtVFSBL8QdVfwIV5tojavFp28DLxg3hJQjxfb/MW25SrpzrsMXwP4N7EUBNWPODssRHXV6qgwj9mGDNUVaNrQuH4OxlawOY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=R9Obuilp; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="R9Obuilp"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B7EA61F000FF;
	Mon,  5 Oct 2026 14:39:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1791211175;
	bh=q/QDYfwR4RXgNtZQcbzEeVFyEMjS8qGHxqnGMptNKeY=;
	h=Subject:To:Cc:From:Date;
	b=R9ObuilpbnvTA/1tq7MCoO9H7awOSGd77guoIDuh1FLVdUNgTuhuHSzebG52ZT+sk
	 o2aEDgNAHLdse4OrBsCJDOqdah2j3Y/nYAyiJoHucNYLTs7cl8G6/VZ0RT2jF0F6EY
	 UrIbGZbNvaQXtCXmNUksrMFqEr2tNVaT/pU84UsU=
Subject: FAILED: patch "[PATCH] wifi: mac80211: set info->band for 802.3 encap offload frames" failed to apply to 6.18-stable tree
To: nbd@nbd.name,andreapesaresi82@gmail.com,johannes.berg@intel.com
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Mon, 05 Oct 2026 16:39:32 +0200
Message-ID: <2026100532-destruct-relative-8c7b@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit


The patch below does not apply to the 6.18-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-6.18.y
git checkout FETCH_HEAD
git cherry-pick -x 4febc02cd02f021f2b6d0768332be643ef14a12d
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2026100532-destruct-relative-8c7b@gregkh' --subject-prefix 'PATCH 6.18.y' 'HEAD^..'

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From 4febc02cd02f021f2b6d0768332be643ef14a12d Mon Sep 17 00:00:00 2001
From: Felix Fietkau <nbd@nbd.name>
Date: Sat, 26 Sep 2026 14:02:16 +0200
Subject: [PATCH] wifi: mac80211: set info->band for 802.3 encap offload frames

Unlike the 802.11 TX paths, ieee80211_8023_xmit() does not set
info->band from the channel context on non-MLD interfaces. It stays at
0, so ieee80211_get_tx_rates() uses the wrong band for these frames.

Set it the same way as ieee80211_build_hdr(): drop the frame if there is
no channel context, and leave the band at 0 on MLD interfaces.

Reported-by: Andrea Pesaresi <andreapesaresi82@gmail.com>
Fixes: 50ff477a8639 ("mac80211: add 802.11 encapsulation offloading support")
Cc: stable@vger.kernel.org
Signed-off-by: Felix Fietkau <nbd@nbd.name>
Link: https://patch.msgid.link/20260926120216.4054712-1-nbd@nbd.name
Signed-off-by: Johannes Berg <johannes.berg@intel.com>

diff --git a/net/mac80211/tx.c b/net/mac80211/tx.c
index c8217f6d146e..b88acb18e04d 100644
--- a/net/mac80211/tx.c
+++ b/net/mac80211/tx.c
@@ -4735,6 +4735,7 @@ static void ieee80211_8023_xmit(struct ieee80211_sub_if_data *sdata,
 {
 	struct ieee80211_tx_info *info;
 	struct ieee80211_local *local = sdata->local;
+	struct ieee80211_chanctx_conf *chanctx_conf;
 	struct tid_ampdu_tx *tid_tx = NULL;
 	struct sk_buff *seg, *next;
 	unsigned int skbs = 0, len = 0;
@@ -4784,6 +4785,16 @@ static void ieee80211_8023_xmit(struct ieee80211_sub_if_data *sdata,
 		sdata = container_of(sdata->bss,
 				     struct ieee80211_sub_if_data, u.ap);
 
+	/* MLD transmissions must not rely on the band */
+	if (!ieee80211_vif_is_mld(&sdata->vif)) {
+		chanctx_conf = rcu_dereference(sdata->vif.bss_conf.chanctx_conf);
+		if (unlikely(!chanctx_conf)) {
+			kfree_skb_list(skb);
+			return;
+		}
+		info->band = chanctx_conf->def.chan->band;
+	}
+
 	info->flags |= IEEE80211_TX_CTL_HW_80211_ENCAP;
 	info->control.vif = &sdata->vif;
 

