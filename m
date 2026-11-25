Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795603234;
	b=MdePuJ/pxj9pIHNoLRCPyo7xbi/XiJU+OoBXzL2tu+tySrugK9xP34GhogFYj5Uwlkc5
	 ErZw7ZepmTVmECqFr7aPC0MC3ZrFIruq92ahXim3Q1W6T2oU/tvOShFRvCOhxMVguIl3Q
	 mVoQBFU/VFmW/xxJ528eQBVosGCXmJG2bGxhh5LNjBw83pIBUspOR/bGMAII+ScL1QmSK
	 f22dSPJytRWVhNGjMmnv7yJX5ibb4kK/RBMiFpKLdhFwijk+k/x9fH+6kYZX48GdR7LGq
	 eqmSCSA2y43mROjq8Bh2RCGGEAMqqen50Upd6Xw2zUa7TLhBfjE4dI9EK3IDPwatV2w==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795603234;
	h=Received:DKIM-Signature:Subject:To:Cc:From:Date:Message-ID:
	 MIME-Version:Content-Type:Content-Transfer-Encoding;
	bh=e8sJWmH2Q9Kso1ZsgBkjcwFriiNBdW+JOnNxRcH7T5U=;
	b=Aj43E4eggVtVsyEYvUgx4fvBD52z18nXvHEpaPtlmp5y/lE59Ac0ffTy7W3005n+ee9e
	 3LU/BA98oPBqgVDDJ8GqHSrXutG642gO5WbcE5XVsDEzV1SpgkJfTEvtpY3FLm50SBjC0
	 3lZUTwujIp8+lxxCdjholgn4sUCXUyglvDM3L/rwZ1QhRzotxBnqMCCSpv9y8VZ5b87tT
	 ihz/9sWR6ePEXWRZjqOtbzDpsUxyyMtvOFiOjeD6Bx57/jpO1LZS4dv6B2yebMc0F8Gyc
	 k7n4RXogP3zcEv8reNkj+m7FGOPIiGCEWkzqwFIIkAh9PtsINWgyo/oHeTWDypjS5XA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=linuxfoundation.org header.i=@linuxfoundation.org header.a=rsa-sha256 header.s=korg header.b=klK3tGVy;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7CB62606A32C
	for <stable@vger.kernel.org>; Wed, 25 Nov 2026 10:40:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.a=rsa-sha256 header.s=korg header.b=klK3tGVy
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 85C481F000CA;
	Wed, 25 Nov 2026 10:40:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1795603234;
	bh=e8sJWmH2Q9Kso1ZsgBkjcwFriiNBdW+JOnNxRcH7T5U=;
	h=Subject:To:Cc:From:Date;
	b=klK3tGVyfxQH5oPcmjlGbilJy+kptjXlueX9LbkwBNpKt8+L8F1JisTfQRk9an/Lx
	 BL4pt6jh6E00cJH5WQyQduNKpzh98hIG3jD7KuNta1XD5DlGTiA9v+P4Fa0rXEuKia
	 IVbe2iUy1cgb2IQj8K6ef7EWbRdwD+z0jMG0SoIo=
Subject: FAILED: patch "[PATCH] wifi: mac80211: drain link readers before stopping removed" failed to apply to 6.1-stable tree
To: enderaoelyther@gmail.com,johannes.berg@intel.com
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Wed, 25 Nov 2026 11:32:08 +0100
Message-ID: <2026112508-leverage-contents-d7bd@gregkh>
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
git cherry-pick -x 745f5d04395dfc4c311f443c7c04ccb00c436984
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2026112508-leverage-contents-d7bd@gregkh' --subject-prefix 'PATCH 6.1.y' 'HEAD^..'

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From 745f5d04395dfc4c311f443c7c04ccb00c436984 Mon Sep 17 00:00:00 2001
From: Zhao Li <enderaoelyther@gmail.com>
Date: Wed, 28 Oct 2026 22:17:08 +0800
Subject: [PATCH] wifi: mac80211: drain link readers before stopping removed
 links

Removing an MLO link can leave work queued on its link container after
the container is freed.

ieee80211_tear_down_links() stops each link before the RCU grace period.
A reader that fetched the link earlier can therefore queue work after
ieee80211_link_stop() has canceled it. ieee80211_request_smps() and
ieee80211_csa_finish() can both reach this window.

Record each removed link while removing its keys and debugfs state. Wait
for RCU readers, then stop the recorded links so cancellation includes
work queued by those readers. Free the detached keys after the grace
period as before.

LLM assistance was used to find the bug and review.

Fixes: efe9c2bfd1a8 ("wifi: mac80211: isolate driver from inactive links")
Cc: stable@vger.kernel.org
Signed-off-by: Zhao Li <enderaoelyther@gmail.com>
Link: https://patch.msgid.link/20261028141708.5532-1-enderaoelyther@gmail.com
Signed-off-by: Johannes Berg <johannes.berg@intel.com>

diff --git a/net/mac80211/link.c b/net/mac80211/link.c
index 34d313a2fef3..957ab9d232a9 100644
--- a/net/mac80211/link.c
+++ b/net/mac80211/link.c
@@ -192,6 +192,7 @@ struct link_container {
 static void ieee80211_tear_down_links(struct ieee80211_sub_if_data *sdata,
 				      struct link_container **links, u16 mask)
 {
+	struct ieee80211_link_data *stop[IEEE80211_MLD_MAX_NUM_LINKS] = {};
 	struct ieee80211_link_data *link;
 	LIST_HEAD(keys);
 	unsigned int link_id;
@@ -206,11 +207,16 @@ static void ieee80211_tear_down_links(struct ieee80211_sub_if_data *sdata,
 			continue;
 		ieee80211_remove_link_keys(link, &keys);
 		ieee80211_link_debugfs_remove(link);
-		ieee80211_link_stop(link);
+		stop[link_id] = link;
 	}
 
+	/* drain RCU readers before cancelling work they may queue */
 	synchronize_rcu();
 
+	for (link_id = 0; link_id < IEEE80211_MLD_MAX_NUM_LINKS; link_id++)
+		if (stop[link_id])
+			ieee80211_link_stop(stop[link_id]);
+
 	ieee80211_free_key_list(sdata->local, &keys);
 }
 

