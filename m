Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C06711FA859
	for <stable@vger.kernel.org>; Tue,  6 Oct 2026 21:46:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791323166; cv=none; b=Mr2VDO36J6bNazoZHz2nktLxPLcLIg7yhGtwskXUxOgx/BYjQNHPXUwexiGtzH5uw5hKaug7eBhN627kORwxW6Wd5AWz2yYOZpirFLjsfiAsvgYQagiEilf1YwUDS3eKGE/iHXArkk6NbCOaC7Hps4Mcgj7jePZFKj/7eD95YCk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791323166; c=relaxed/simple;
	bh=RowfMOnCZv7KezU8dcVDT7CJHMcY+ZpJ2ivkSemS2/A=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=FB+7fiwWsGsmADjAN4OR0HyA5U9qnR5xIfyxZLB5bz0+YvDHt/pT8oU/kkjKDtrndXlVBD1rtQ/o4cAkQn2G7o3JtuXbVz+EgWNJCb9TbU+R+oHPbx2fIweQeKlRZdP4Mcm0u92DFfzkMQu6rZXdLVDl5Zp0U9N8+IX3zUr17TA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=kp5AmFKX; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kp5AmFKX"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E51971F0089B;
	Tue,  6 Oct 2026 21:46:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791323165;
	bh=PLonOSoQCNsSOq+iviD3btf4gASOKdAH/Juu2Qv8Of8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=kp5AmFKXQPkFN8UNHb6+Zxvxh57IYOydOieljv4kWOaIHerWHSYVz4EpBLm9hJvjM
	 jtWQ948hlVEwjFXvzL7GniSBRzFA+Ex83MMJaoENc3sBWL24VuWEbEEQKDC2s8JRcJ
	 tPxt0Ea9wvyW6QOcWKEIIQ7wAwvMTY2W0dSIs3hg+zHM+fDLsSDQMFMi2GZRQA3UEV
	 6WELSByNGbRXuHXZJI6ZEKk924oaONYxUWR6CvkmhzDT7srBFhOitxLCUizUwJGt6y
	 8m406t+Hi/Mxrw+RZGg2+o2pn2HakT+DiXebDIM9rw69LIgnLYmG3uNdHTabCerF9A
	 8t+A7UxHaXXqw==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Zhao Li <enderaoelyther@gmail.com>,
	stable@kernel.org,
	Johannes Berg <johannes.berg@intel.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.1.y] wifi: mac80211: keep fallback association elements alive
Date: Tue,  6 Oct 2026 17:46:01 -0400
Message-ID: <20261006214549.1043561-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026100555-unknown-kilt-2f75@gregkh>
References: <2026100555-unknown-kilt-2f75@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Zhao Li <enderaoelyther@gmail.com>

[ Upstream commit a10a2f80476d166fd81c361ec0319493671b694e ]

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
[ sashal: adjusted context for the existing conn_flags-based VHT check ]
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 net/mac80211/mlme.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/net/mac80211/mlme.c b/net/mac80211/mlme.c
index 32f24dca40ab5..56120762c7fbf 100644
--- a/net/mac80211/mlme.c
+++ b/net/mac80211/mlme.c
@@ -4023,6 +4023,7 @@ static bool ieee80211_assoc_config_link(struct ieee80211_link_data *link,
 	bool is_6ghz = cbss->channel->band == NL80211_BAND_6GHZ;
 	bool is_s1g = cbss->channel->band == NL80211_BAND_S1GHZ;
 	const struct cfg80211_bss_ies *bss_ies = NULL;
+	struct ieee802_11_elems *bss_elems = NULL;
 	struct ieee80211_supported_band *sband;
 	struct ieee802_11_elems *elems;
 	u16 capab_info;
@@ -4059,7 +4060,6 @@ static bool ieee80211_assoc_config_link(struct ieee80211_link_data *link,
 	     (!(link->u.mgd.conn_flags & IEEE80211_CONN_DISABLE_VHT) &&
 	      (!elems->vht_cap_elem || !elems->vht_operation)))) {
 		const struct cfg80211_bss_ies *ies;
-		struct ieee802_11_elems *bss_elems;
 
 		rcu_read_lock();
 		ies = rcu_dereference(cbss->ies);
@@ -4115,8 +4115,6 @@ static bool ieee80211_assoc_config_link(struct ieee80211_link_data *link,
 			sdata_info(sdata,
 				   "AP bug: VHT operation missing from AssocResp\n");
 		}
-
-		kfree(bss_elems);
 	}
 
 	/*
@@ -4343,6 +4341,7 @@ static bool ieee80211_assoc_config_link(struct ieee80211_link_data *link,
 	ret = true;
 out:
 	kfree(elems);
+	kfree(bss_elems);
 	kfree(bss_ies);
 	return ret;
 }
-- 
2.53.0

