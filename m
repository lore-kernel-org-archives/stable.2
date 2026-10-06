Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C0BD938B133
	for <stable@vger.kernel.org>; Tue,  6 Oct 2026 22:12:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791324746; cv=none; b=Gdybw4mbPtzWWR8ec7PtKcEszyvL3sDdRodyP7PuQZTeTY4iCl9p/8MfyMsXcGRAF7/BzV8SlMvYStcaio1n46N9CctwTz7rJ1L0mytbcVpO40PoI61p3imzYxR3eaoD7I7ZEpIDrFkbAnBqk4+Zvey+x83QTu8OSY7RU9JYBSA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791324746; c=relaxed/simple;
	bh=LgqII1kPvv61b4tQ21Dj0XcmLK5ppYRwdmUAgZOqXZY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=c8ypuLlM866gDW9djtroKnFNJPm7UmtbH2Xl8P5TqgkFBmKhUZgrYwl8j5hvqSFVPwublwhgLqc2uEPBM6pucxePiv9HXcNSivfitOU/Qe2UOPDOX34jSNs0T3rKdpRaTXG8Rq4s4UHd/bmcKC8znbWNE201w+M7SyisYOJ1sMc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=VXyKnY09; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="VXyKnY09"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1DAC81F0089B;
	Tue,  6 Oct 2026 22:12:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791324745;
	bh=MCbGEM9coTpAXXaS93H54nYFL9BrLOAZF1+W0V4aX4g=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=VXyKnY09zSi+93fwM5PifQM9M7ARCpLEHKdNdQOCJC7muJ/gP3HqkckldNoRKdbIk
	 1hR6PHBZ7vH+lboZ0IUa2LytqYgx4MZjoq+1+bm7jEXxgirT1K2ES1VPaHeFosn8vo
	 qEtS4Yx5cEloQcQ+oFxHg/WL1sqr7yssCia7/tT0+CNeaZwzmel0nCOIzqpaM5Q5vC
	 5L/LN1fpSr7fkBML0iL095x9Vwo5mYjdfWmZjfGJyvJ/HscGOy8otP9+KvZ7BhqXPF
	 WuHGIJ1jKaOIgogoZ0MDEfoimXVy1XW1FwQPOpF+x/tftaFfrrRT/ncLYeLMeemjG1
	 L2OhqezsYWfPg==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Zhao Li <enderaoelyther@gmail.com>,
	stable@kernel.org,
	Johannes Berg <johannes.berg@intel.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.10.y] wifi: mac80211: keep fallback association elements alive
Date: Tue,  6 Oct 2026 18:12:21 -0400
Message-ID: <20261006221208.1111207-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026100556-outwit-observant-7f87@gregkh>
References: <2026100556-outwit-observant-7f87@gregkh>
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
[ sashal: changed kfree(bss_elems) to kfree(bss_elems.nontx_profile) for the stack-allocated parse structure. ]
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 net/mac80211/mlme.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/net/mac80211/mlme.c b/net/mac80211/mlme.c
index 79f7f3812da92..0a66b3db29ad8 100644
--- a/net/mac80211/mlme.c
+++ b/net/mac80211/mlme.c
@@ -3284,6 +3284,7 @@ static bool ieee80211_assoc_success(struct ieee80211_sub_if_data *sdata,
 	u16 capab_info, aid;
 	struct ieee80211_bss_conf *bss_conf = &sdata->vif.bss_conf;
 	const struct cfg80211_bss_ies *bss_ies = NULL;
+	struct ieee802_11_elems bss_elems = {};
 	struct ieee80211_mgd_assoc_data *assoc_data = ifmgd->assoc_data;
 	bool is_6ghz = cbss->channel->band == NL80211_BAND_6GHZ;
 	bool is_s1g = cbss->channel->band == NL80211_BAND_S1GHZ;
@@ -3346,7 +3347,6 @@ static bool ieee80211_assoc_success(struct ieee80211_sub_if_data *sdata,
 	     (!(ifmgd->flags & IEEE80211_STA_DISABLE_VHT) &&
 	      (!elems->vht_cap_elem || !elems->vht_operation)))) {
 		const struct cfg80211_bss_ies *ies;
-		struct ieee802_11_elems bss_elems;
 
 		rcu_read_lock();
 		ies = rcu_dereference(cbss->ies);
@@ -3396,7 +3396,6 @@ static bool ieee80211_assoc_success(struct ieee80211_sub_if_data *sdata,
 			sdata_info(sdata,
 				   "AP bug: VHT operation missing from AssocResp\n");
 		}
-		kfree(bss_elems.nontx_profile);
 	}
 
 	/*
@@ -3652,6 +3651,7 @@ static bool ieee80211_assoc_success(struct ieee80211_sub_if_data *sdata,
 
 	ret = true;
  out:
+	kfree(bss_elems.nontx_profile);
 	kfree(bss_ies);
 	return ret;
 }
-- 
2.53.0

