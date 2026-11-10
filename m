Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794281232;
	b=lqp1YDE01ZLrH8I93wEY7dKqXyiMoKxRp50JgsJWatyzn9TGKjvjKAtWOHgqA2CfwmVd
	 vN6KMtOSS7EoCpb/S3faPnkF7YgyqrsD/Wqv0vEycur6b/aqEej5oZO6X6uiHp8ua5xTe
	 x4/979eWSaC8fzFT8DSR7uWtZ71h1OLRuJ+STqsiHMjwX920T4m9J8Hz0H9hgEEtpVoq8
	 6odHkGN3vSuKalYq8mBhdJoOOG8K74+58Z1EojTGtVrk+qi9mTivII9RMuNnMtZT3K9LY
	 QXH01aMg8ssZc7lgaJTlAnMCA62xH3qp0kyaJjhYTWyT9bfP3HvGYoH5MpiOIW8O/Dg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794281232;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=CJU/IDncklmxKcgQZN6OpuRXnMtm9rxZm+fLCaVx+mc=;
	b=WE68RuB/TeVnolJaoPkcEB4OAulvzcWE2Cicpw3o+BEvvHRvTlAIPzxXQ/kU1spJ5ZuP
	 seYvbtB2m+OZhPgK0TwhzX8A8/mCpDaAuBQBZfa4qDSJvbtlpxSw3z6a0OZPt755cYHeu
	 lWHA/ZQsuvY3Mg4qz5FnwOIXOE03WblRTqF+9oQb9RHg4JN33pwsQY5EgM7rX/AicOek2
	 PdtppGCvsTAPIK9PJqEpTTYWFawaU9uAVqhqS2Uzq5dXTKuoTxAneOE4pq1Z1Uo+H91bi
	 JYrews6uqFTHILGZcBduZrYHX65S06kme+PCbs0dEdoWE2pQambEvp7OWvKz5LSH1LA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=IDDNv3+I;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3CDEA606A321
	for <stable@vger.kernel.org>; Tue, 10 Nov 2026 03:27:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=IDDNv3+I
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5FB8F1F0089F;
	Tue, 10 Nov 2026 03:27:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794281231;
	bh=CJU/IDncklmxKcgQZN6OpuRXnMtm9rxZm+fLCaVx+mc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=IDDNv3+I8eOTzjxjn+TJhNkjzt9uJJDEjkp/f5MlAKDCJUuXwP+NLMiijybpIpSfG
	 93EQJ7171yi0fDNaQ2Nqyp4go8USaFXYkSkshBdj+og8qk1GpPMZSg5mwBlLsm/eG4
	 9qGgdVxzYkdcK2lG5lwr0Wdtq/n4SuP7pATcEt64h2iaaSdnh+eoOwHmYT+HJftAkQ
	 84nnTU93hL3uosKK2HyfaHKBa/TL9j/srC2vi0ggTq+Ctd4932IscKNhmhnYJVQVlN
	 lMqrNm5w1byxrE9GXdwdVHExXoKE09+H7FmvRAlHsXxPVhESSH7GkfAaxSnTRT/mwX
	 G38M906Bu2Wxw==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Kexin Sun <kexinsun@smail.nju.edu.cn>,
	Lachlan Hodges <lachlan.hodges@morsemicro.com>,
	Johannes Berg <johannes@sipsolutions.net>,
	Johannes Berg <johannes.berg@intel.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.6.y 1/2] wifi: mac80211: update outdated comment
Date: Mon,  9 Nov 2026 22:27:08 -0500
Message-ID: <20261110032703.180401-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261107052845-failed-6.6-13e51269b665@kernel.org>
References: <20261107052845-failed-6.6-13e51269b665@kernel.org>
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Kexin Sun <kexinsun@smail.nju.edu.cn>

[ Upstream commit b8a57b979a7c2069081ed0bf88a727b17d85ac96 ]

The function ieee80211_start_scan() was refactored and replaced by
__ieee80211_start_scan() in commit f3b85252f081 ("mac80211: fix scan
races and rework scanning"). Update the comment in
ieee80211_tx_h_check_assoc() accordingly.

Additionally, remove the broken gmane.org link in the comment.

Suggested-by: Lachlan Hodges <lachlan.hodges@morsemicro.com>
Suggested-by: Johannes Berg <johannes@sipsolutions.net>
Assisted-by: unnamed:deepseek-v3.2 coccinelle
Signed-off-by: Kexin Sun <kexinsun@smail.nju.edu.cn>
Link: https://patch.msgid.link/20260228061944.887-1-kexinsun@smail.nju.edu.cn
Signed-off-by: Johannes Berg <johannes.berg@intel.com>
Stable-dep-of: 13e51269b665 ("wifi: mac80211: queue frames while off-channel")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 net/mac80211/tx.c | 5 +----
 1 file changed, 1 insertion(+), 4 deletions(-)

diff --git a/net/mac80211/tx.c b/net/mac80211/tx.c
index cf463965b8d40..14513d4fe6329 100644
--- a/net/mac80211/tx.c
+++ b/net/mac80211/tx.c
@@ -301,10 +301,7 @@ ieee80211_tx_h_check_assoc(struct ieee80211_tx_data *tx)
 		 * active scan) are allowed, all other frames should not be
 		 * sent and we should not get here, but if we do
 		 * nonetheless, drop them to avoid sending them
-		 * off-channel. See the link below and
-		 * ieee80211_start_scan() for more.
-		 *
-		 * http://article.gmane.org/gmane.linux.kernel.wireless.general/30089
+		 * off-channel. See __ieee80211_start_scan() for more.
 		 */
 		return TX_DROP;
 
-- 
2.53.0

