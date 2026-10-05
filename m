Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6AE654AA1CD
	for <stable@vger.kernel.org>; Mon,  5 Oct 2026 14:39:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791211150; cv=none; b=B52VWp6AklCXKL5VgXJ7DYSmGQ0IY2fEua2lyqpIC+3tIf/FovzS8P3BkVs3/nAfr+09hpD0kwkcHZyVNrEZmFrjsamVF0y45CAiSSPYFI30/POHAODT9bIpGjEu6uIH9hqFtJP0wm5DSyWI81qjL//9GtTX7dBzPSEHkCZJCMY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791211150; c=relaxed/simple;
	bh=/MpP7tUt0tURuVunvaTBBrwOpuQpzYygn4p2BiBWal4=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=o4xHdpw8Q1t719hk+0udtUDbK4DKecg1dafTXMPgpgh+yvtXMA9q9vcdE1KvNpmqcuv8ZSPmAbbhnAsNM3oLoI3KzXhie9NEiqFevWrWrxWmRDnHk0nD1LJb40rAUuTcg8emzQtcg7OM5xg+D4aZjr0LSweA3vvRY5316BOnmNM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=eUsPfRWH; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="eUsPfRWH"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 270431F000FF;
	Mon,  5 Oct 2026 14:38:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1791211137;
	bh=pga8G5rKEWBmBIoN0iaLoYVQFotnZIK6/Wy41e/9Kzc=;
	h=Subject:To:Cc:From:Date;
	b=eUsPfRWH3IwCK1m13l11xJesVUax0zq8cKn0OUR6VbALe3csAbVZrAYzWKFjYzMZv
	 XVh3yxMtedCW8GmsRoyDoaKo4Gn2uMQVTQP/ctqpFHZMcB2h0/l1PxDGi3BYhXy9sX
	 UjRCTJZo5Z4FtsoythKsEtd1ZPxQhr1Z1w5lUVUU=
Subject: FAILED: patch "[PATCH] wifi: mac80211: keep fallback association elements alive" failed to apply to 6.6-stable tree
To: enderaoelyther@gmail.com,johannes.berg@intel.com
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Mon, 05 Oct 2026 16:38:55 +0200
Message-ID: <2026100555-esquire-script-5c3b@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
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
git cherry-pick -x a10a2f80476d166fd81c361ec0319493671b694e
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2026100555-esquire-script-5c3b@gregkh' --subject-prefix 'PATCH 6.6.y' 'HEAD^..'

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From a10a2f80476d166fd81c361ec0319493671b694e Mon Sep 17 00:00:00 2001
From: Zhao Li <enderaoelyther@gmail.com>
Date: Thu, 10 Sep 2026 14:52:51 +0800
Subject: [PATCH] wifi: mac80211: keep fallback association elements alive

Associating to a non-transmitted MBSSID profile reads freed memory while
determining the operating channel and applying HT capabilities.

When an association response omits WMM, HT, or VHT information,
ieee80211_assoc_config_link() parses the cached BSS IEs and copies the
missing element pointers out of that fallback parse. For a
non-transmitted MBSSID profile those pointers refer to merged-profile
storage owned by the parse object, and the fallback block frees that
object at its end. The copied pointers are used afterwards to determine
the operating channel, configure bandwidth, and apply HT capabilities.

Keep the fallback parse result alive until association setup finishes.

Fixes: 5023b14cf4df ("mac80211: support profile split between elements")
Cc: stable@kernel.org
Assisted-by: LLM sparse kasan
[reorder variable declaration]
Signed-off-by: Zhao Li <enderaoelyther@gmail.com>
Signed-off-by: Johannes Berg <johannes.berg@intel.com>

diff --git a/net/mac80211/mlme.c b/net/mac80211/mlme.c
index f51167f0fc46..3c31c16860ab 100644
--- a/net/mac80211/mlme.c
+++ b/net/mac80211/mlme.c
@@ -5877,6 +5877,7 @@ static bool ieee80211_assoc_config_link(struct ieee80211_link_data *link,
 	bool is_6ghz = cbss->channel->band == NL80211_BAND_6GHZ;
 	bool is_s1g = cbss->channel->band == NL80211_BAND_S1GHZ;
 	const struct cfg80211_bss_ies *bss_ies = NULL;
+	struct ieee802_11_elems *bss_elems = NULL;
 	struct ieee80211_supported_band *sband;
 	struct ieee802_11_elems *elems;
 	u16 capab_info;
@@ -6007,7 +6008,6 @@ static bool ieee80211_assoc_config_link(struct ieee80211_link_data *link,
 	     (is_5ghz && link->u.mgd.conn.mode >= IEEE80211_CONN_MODE_VHT &&
 	      (!elems->vht_cap_elem || !elems->vht_operation)))) {
 		const struct cfg80211_bss_ies *ies;
-		struct ieee802_11_elems *bss_elems;
 
 		rcu_read_lock();
 		ies = rcu_dereference(cbss->ies);
@@ -6069,7 +6069,6 @@ static bool ieee80211_assoc_config_link(struct ieee80211_link_data *link,
 					   "AP bug: VHT operation missing from AssocResp\n");
 			}
 		}
-		kfree(bss_elems);
 	}
 
 	/*
@@ -6342,6 +6341,7 @@ static bool ieee80211_assoc_config_link(struct ieee80211_link_data *link,
 	ret = true;
 out:
 	kfree(elems);
+	kfree(bss_elems);
 	kfree(bss_ies);
 	return ret;
 }

