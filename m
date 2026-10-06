Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 308FF22425B
	for <stable@vger.kernel.org>; Tue,  6 Oct 2026 22:01:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791324062; cv=none; b=tkxscCypoSMG338Nf4VT5Nqmb01UXmzA9s15Nf3M0SrQrYAXlS1XhEnUHUm+G9Wp0MUxLejry111HQkBQvy5YtKOQOHoB7CNYCOQSD+eW+CVTOG7xaQomU56V8GLOqINYSxYyDUfjWPlMoIT4dVyspD+xW0o90OPME1ADlLXe6U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791324062; c=relaxed/simple;
	bh=7bZfQMauDa4i08uog57+2w4SQuzOMbjtNJtE3gU+RZQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=NPl3K1ZCrI6qQ5ROr5pL/EuiEnT2+3RW5c9qIlgc9gVvy5yyvrxLmNB8n+8QsiyF6BBnLHowmiMgArjwJG3ppxtD8xvdnxPYwSwlP1fUBipy69rjB14C9D7piUZDY+0285DVrQqthQrfcQUYbj5TYjqe+UD5Tj5pu2PxXWl1xYI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=FAfE1cHg; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="FAfE1cHg"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 84E4B1F0089B;
	Tue,  6 Oct 2026 22:00:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791324060;
	bh=h2xFZmZ9Tt+uaJhtX8XpPJFvn2+eDR/EGc0bcZuqCYE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=FAfE1cHgB3eqzqHqGnTQFeVgvU8HcxZWXO4DWpfhUTqGIIiMN6BMsaX7BQimUyG1D
	 W/d7ufAyPTYNIm2OPU87Tb0zTDBEcCNvpeWIyTasIXUH9Kk8mEn2X93tBEieJXRMCM
	 mJDfTcvwRWWPbn5KHnef1OLNjxwjVG15H0299WZXxA2HpcBAzUHaNulIvMP4eZfYLV
	 7p+GzeN0QBbeVpIl+c1OVvXszcSrCHn4CvuaKx7C71g1cKeHwljP6Mz2C47XHVYKZ3
	 oLZQNx4bKo/gCTZem7H7M9o77CjxsrRFUlWHPZHDMnX8WyCc+cwPAI4nNS0CVzAfRP
	 qgxLMTRb7gqYA==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Zhao Li <enderaoelyther@gmail.com>,
	stable@kernel.org,
	Johannes Berg <johannes.berg@intel.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.15.y] wifi: mac80211: keep fallback association elements alive
Date: Tue,  6 Oct 2026 18:00:56 -0400
Message-ID: <20261006220027.1093295-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026100555-despite-exonerate-bff7@gregkh>
References: <2026100555-despite-exonerate-bff7@gregkh>
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
[ sashal: Applied the changes to ieee80211_assoc_success() instead of ieee80211_assoc_config_link(). ]
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 net/mac80211/mlme.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/net/mac80211/mlme.c b/net/mac80211/mlme.c
index 5617540b40b29..bfd4654d404f0 100644
--- a/net/mac80211/mlme.c
+++ b/net/mac80211/mlme.c
@@ -3310,6 +3310,7 @@ static bool ieee80211_assoc_success(struct ieee80211_sub_if_data *sdata,
 	u16 capab_info, aid;
 	struct ieee80211_bss_conf *bss_conf = &sdata->vif.bss_conf;
 	const struct cfg80211_bss_ies *bss_ies = NULL;
+	struct ieee802_11_elems *bss_elems = NULL;
 	struct ieee80211_mgd_assoc_data *assoc_data = ifmgd->assoc_data;
 	bool is_6ghz = cbss->channel->band == NL80211_BAND_6GHZ;
 	bool is_s1g = cbss->channel->band == NL80211_BAND_S1GHZ;
@@ -3376,7 +3377,6 @@ static bool ieee80211_assoc_success(struct ieee80211_sub_if_data *sdata,
 	     (!(ifmgd->flags & IEEE80211_STA_DISABLE_VHT) &&
 	      (!elems->vht_cap_elem || !elems->vht_operation)))) {
 		const struct cfg80211_bss_ies *ies;
-		struct ieee802_11_elems *bss_elems;
 
 		rcu_read_lock();
 		ies = rcu_dereference(cbss->ies);
@@ -3432,8 +3432,6 @@ static bool ieee80211_assoc_success(struct ieee80211_sub_if_data *sdata,
 			sdata_info(sdata,
 				   "AP bug: VHT operation missing from AssocResp\n");
 		}
-
-		kfree(bss_elems);
 	}
 
 	/*
@@ -3685,6 +3683,7 @@ static bool ieee80211_assoc_success(struct ieee80211_sub_if_data *sdata,
 	ret = true;
  out:
 	kfree(elems);
+	kfree(bss_elems);
 	kfree(bss_ies);
 	return ret;
 }
-- 
2.53.0

