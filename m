Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6C05D3B1008
	for <stable@vger.kernel.org>; Tue,  6 Oct 2026 21:32:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791322341; cv=none; b=MzpYBtNMHD7S6/oDmdU4uf9q93/Ff7MRk6Lugns2eE9lq1pxYFdpOEZg1hMCRurW23q66B0HrM0eCXVyddSw52JeYJEQd2th/HEn2YlAyeUKwh35fVnPyZ3RPklHPLz1hFPvz97QFm46iAPc3ovrFXOWB6vn3IfUwe/roplp8Jk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791322341; c=relaxed/simple;
	bh=+QwZhTUbLn+/MENCPNrbV/iBvRYczFitPWG+JCFY2oY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=M/hMd3tuPMBRKrYGgmPjNeUX46gkg20J+jfUZJZlD+mVJ5K8owdEEaPr8W/MJvnM2a2qOQDCo8yftpLoUd6zTkj2nXBpDe6V+APH4qDRZIi5ddr/4xP5x9+Ub9TU6sSqeuIOyhyUWQ5H/9JaJoRrVixOotbpr+VZhahuWOuOeBM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=E6d1h+5C; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="E6d1h+5C"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B47061F0089B;
	Tue,  6 Oct 2026 21:32:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791322340;
	bh=ZDIqOYIuux5ZePdQPk6YwYEXrLbxspwJ8AhXfg+tR/g=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=E6d1h+5Cv1gom5dLLjJSjHpzBFvxeoGYXMr8K08wUvHu3JS8oJ3qoeLEyrfr3yn0G
	 ftnDUGSL5YM8VKSfzxyrdlH1z02/LF763n1ishIZnvCayzRITnaHwFZsiqQH+zZ0Z0
	 65W9Cfbudrl+TIxi17iy+Az/hJC58G29dkKlfGHPKaombnTFtAMYpJwCYAxEfGIQf0
	 LUf5JszcqZPfUHzKyxmtRGZE8skFq11qKWA8zdTWvNN9y4zzF7l23pX0yEUlxLBGpP
	 YUtG+B+49skhIVsFolWRuAnVV2+cdSSETCYUvXMutsBX88c7hvUYUDS5JUSET0YeXN
	 bxruQwfVk1gqw==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Zhao Li <enderaoelyther@gmail.com>,
	stable@kernel.org,
	Johannes Berg <johannes.berg@intel.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.6.y] wifi: mac80211: keep fallback association elements alive
Date: Tue,  6 Oct 2026 17:32:14 -0400
Message-ID: <20261006213145.985540-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026100555-esquire-script-5c3b@gregkh>
References: <2026100555-esquire-script-5c3b@gregkh>
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
[ sashal: Adjusted context for existing conn_flags-based HT/VHT conditionals. ]
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 net/mac80211/mlme.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/net/mac80211/mlme.c b/net/mac80211/mlme.c
index ac3c2c3334fdf..9f67290e7fe58 100644
--- a/net/mac80211/mlme.c
+++ b/net/mac80211/mlme.c
@@ -4026,6 +4026,7 @@ static bool ieee80211_assoc_config_link(struct ieee80211_link_data *link,
 	bool is_6ghz = cbss->channel->band == NL80211_BAND_6GHZ;
 	bool is_s1g = cbss->channel->band == NL80211_BAND_S1GHZ;
 	const struct cfg80211_bss_ies *bss_ies = NULL;
+	struct ieee802_11_elems *bss_elems = NULL;
 	struct ieee80211_supported_band *sband;
 	struct ieee802_11_elems *elems;
 	const __le16 prof_bss_param_ch_present =
@@ -4103,7 +4104,6 @@ static bool ieee80211_assoc_config_link(struct ieee80211_link_data *link,
 	     (!(link->u.mgd.conn_flags & IEEE80211_CONN_DISABLE_VHT) &&
 	      (!elems->vht_cap_elem || !elems->vht_operation)))) {
 		const struct cfg80211_bss_ies *ies;
-		struct ieee802_11_elems *bss_elems;
 
 		rcu_read_lock();
 		ies = rcu_dereference(cbss->ies);
@@ -4160,8 +4160,6 @@ static bool ieee80211_assoc_config_link(struct ieee80211_link_data *link,
 			sdata_info(sdata,
 				   "AP bug: VHT operation missing from AssocResp\n");
 		}
-
-		kfree(bss_elems);
 	}
 
 	/*
@@ -4389,6 +4387,7 @@ static bool ieee80211_assoc_config_link(struct ieee80211_link_data *link,
 	ret = true;
 out:
 	kfree(elems);
+	kfree(bss_elems);
 	kfree(bss_ies);
 	return ret;
 }
-- 
2.53.0

