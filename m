Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AC8C74ACC7A
	for <stable@vger.kernel.org>; Mon,  5 Oct 2026 14:39:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791211160; cv=none; b=dvyo2pU7CLBZvQ7DhKgAuB6c9TL5SHQuvaAmaql9V2UYUsVsEpctE6bcLA9+aJhXccpL0xDMwxeaZHzPQO4/8xw3/TH888gqpNiR7rvkGBhhombinJ5thPYEkme8t8dtPmoLbl4AB7WPiWcV39cQlvJrDCnmnhPoWwA8i5hWTtU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791211160; c=relaxed/simple;
	bh=bbA/ovjaGh1LkfErjSqs5hYitQ+C7kc+fDAaNp2hjaA=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=c9Q1ksZ260hZbMoIt/HGdZ+Cu26fJ9GF7LJicc5jWpdygq0wlHllKC0lEUPYApay7iEgnKMNwd/TJvXxg8x6PSM2bJmDbNU+0utYQR5EYzTsVQgttrwbgljSAnGerJ6eoKaitLpYZhOU6YmrojLF+XNB5X9ScpR5gLSKu4g2x8k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=S/fUkfes; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="S/fUkfes"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 57F521F00898;
	Mon,  5 Oct 2026 14:39:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1791211148;
	bh=SxUEQ9m2dxlQ69Yl8wDcLVXF8m/rBbtvDyuPOUVc+XM=;
	h=Subject:To:Cc:From:Date;
	b=S/fUkfesz4CH8cpjcTz4f+fZ8ulWGB/r4N4euHe9Bn6v77d4hCu0yH7wg/fKD5H83
	 fbFBmr4EDFIubWX6IGAAHwmSkICZQr+AFBO+PD5VW4jlZDJjHBQ6tZA9Htgk3Er9Ky
	 9x91EoNxxb3MWXONSWmHwgXbCR4ndaJ+bM/zKWNE=
Subject: FAILED: patch "[PATCH] wifi: mac80211: keep fallback association elements alive" failed to apply to 5.15-stable tree
To: enderaoelyther@gmail.com,johannes.berg@intel.com
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Mon, 05 Oct 2026 16:38:55 +0200
Message-ID: <2026100555-despite-exonerate-bff7@gregkh>
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
git cherry-pick -x a10a2f80476d166fd81c361ec0319493671b694e
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2026100555-despite-exonerate-bff7@gregkh' --subject-prefix 'PATCH 5.15.y' 'HEAD^..'

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

