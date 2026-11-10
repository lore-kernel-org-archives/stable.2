Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794345007;
	b=k8JrJKAByru2UXsPcG6orVVLzt2JvVPNonhomPiQWNU9tJLcoQ5oFdBu9NGLoWYdBzcx
	 DvPOFC4ThVlxNPDfuXE/kdIEkaEWdc9uKYva8krH/bq4GesVtUVp9fXptvdXI1lyPMk6C
	 6qP47rijt+PcKdAwn5ZvGCTkDphkjCzM/JhoQ8IAn1INiUtTODL8+5x0WTTpTp8dElEYO
	 oTHmmvkUPmTdL3yfwfuVoYrz8WDy9MVfHdr2I3w/OPoWmfbyCg/gg0YB9IZGA00slhcFB
	 tW1z/6OauCG+3YuP++N2JIn16+cRq/vUhprFi0EpHvFVkDNEZov4c0nfccHtRnTfJ4Q==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794345007;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=21EM9X5pIBmahVdjt5RqRtXxmEjqdolJteb3e5XsGZE=;
	b=4sDiN+q5xaR2Rq5BFR52024TmIdbEiJkuvhfWdovZkVALs5dO06oW718LG2fQdCw/tEQ
	 Vzm+C7mkBuf6qT1AHiSuT8afG082aWYEO0Fh3/kkOxRcddAsnviaXVa6D2YHaQDrGn+uo
	 4pqTe5U5Mcnx6pdgn1hf2dkM5LwSmKZxFp8jjmytJKgScu67MHXHubCCkNE0cV5spbzva
	 furiApuF9gdKIyli0pL946tbZ1YdhIh22ez8vA0ZkoaOSf4PlXwd7xpIm2jqprZ0S0lEi
	 TdoJMsH5K/PRsEtekxFSfImZKwyWk700JaQ+QOf02LoQzlok6xTg+UlLb60YCbZRVig==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=G68vQp0e;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 17C78606A31C
	for <stable@vger.kernel.org>; Tue, 10 Nov 2026 21:10:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=G68vQp0e
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EAA1D1F0089F;
	Tue, 10 Nov 2026 21:10:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794345006;
	bh=21EM9X5pIBmahVdjt5RqRtXxmEjqdolJteb3e5XsGZE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=G68vQp0eqmBRBSRw0Lcmz7BGCvE5OpeYAUvUGNpS8/xj4Pmn6YkfLsREPBe2MJzlY
	 FP4vgLrx+BvDuCsUGDCmB3qt5AaqFxxHBTORDh8C2AgBHyvXBoUPFMVEvQvmxpEhuT
	 zMzEFUZ/XyszASrika0zQfVsRPlx386XZh9+S44RqqS58LTPqgkqr4byq6gQMHgTWi
	 Of150aIiYwIqrd23lpdgdF9lf+DfK19U4J+WurFVSDr8UUk5Ybsj1d+IHa4Lz9RJiu
	 0mBQ9kHKNoJATlIic+oG7r1Kj5JQKz1U0ZwFnn6l69Vd5rneqckTKWnfsqiac5NDf/
	 zQiXU9H41+Eig==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Janne Grunau <j@jannau.net>,
	Neal Gompa <neal@gompa.dev>,
	Arend van Spriel <arend.vanspriel@broadcom.com>,
	Johannes Berg <johannes.berg@intel.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.10.y] wifi: brcmfmac: cfg80211: Report port_authorized for 4-way HS offload
Date: Tue, 10 Nov 2026 16:10:04 -0500
Message-ID: <20261110210827.3733389-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261107061858-failed-5.10-6fff9de5c5b4@kernel.org>
References: <20261107061858-failed-5.10-6fff9de5c5b4@kernel.org>
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

From: Janne Grunau <j@jannau.net>

[ Upstream commit 6fff9de5c5b425817588eeed42bd56d665751c13 ]

Since commit 416386060 ("Mark authorization completed on driver
indication during 4-way HS offload") [0] wpa_supplicant expects
NL80211_CMD_PORT_AUTHORIZED to complete the authentication when the
driver supports 4-way handshake offload.
This was apparently never tested with the upstream brcmfmac driver as it
does not report this. This broke authentication on Apple silicon devices
(BRCM4378, BRMC4387, BRMC4388) and other devices when wpa_supplicant
2.11 was released [1]. This was initially dealt with by reverting the
commit in Fedora [2] and other Linux distributions.
Instead of carrying the revert over to wpa_supplicant 2.12 add the
expected NL80211_CMD_PORT_AUTHORIZED when the connection is established.

The "Fixes:" tag is not fully accurate as this has only became an issue
after userspace changes years after the change. Since the change is
expected to be required in all active stable branches for wpa_supplicant
2.11 / 2.12 compatibility it is helpful even though
BRCMF_PROFILE_FWSUP_SAE did not exists then.

Link: https://github.com/zephyrproject-rtos/hostap/commit/41638606054a09867fe3f9a2b5523aa4678cbfa5 [0]
Link: https://lists.infradead.org/pipermail/hostap/2024-August/042893.html [1]
Link: https://bugzilla.redhat.com/show_bug.cgi?id=2302577 [2]
Link: https://lore.kernel.org/linux-wireless/20260911065656.1269623-5-Jason.Huang2@infineon.com/ [3]
Cc: stable@vger.kernel.org
Fixes: b8a64f0e96c2 ("brcmfmac: support 4-way handshake offloading for WPA/WPA2-PSK")
Signed-off-by: Janne Grunau <j@jannau.net>
Reviewed-by: Neal Gompa <neal@gompa.dev>
Acked-by: Arend van Spriel <arend.vanspriel@broadcom.com>
Link: https://patch.msgid.link/20260915-brcmfmac-4way-handshake-offload-authenticated-event-v2-1-fbb9cc7ac177@jannau.net
Signed-off-by: Johannes Berg <johannes.berg@intel.com>
[ sashal: adapted authorization handling to inline SAE/PSK checks with the older three-argument cfg80211_port_authorized() API ]
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/net/wireless/broadcom/brcm80211/brcmfmac/cfg80211.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/drivers/net/wireless/broadcom/brcm80211/brcmfmac/cfg80211.c b/drivers/net/wireless/broadcom/brcm80211/brcmfmac/cfg80211.c
index 3f6d4299965b2..361675045a67d 100644
--- a/drivers/net/wireless/broadcom/brcm80211/brcmfmac/cfg80211.c
+++ b/drivers/net/wireless/broadcom/brcm80211/brcmfmac/cfg80211.c
@@ -5973,6 +5973,7 @@ brcmf_bss_connect_done(struct brcmf_cfg80211_info *cfg,
 	struct brcmf_cfg80211_profile *profile = &ifp->vif->profile;
 	struct brcmf_cfg80211_connect_info *conn_info = cfg_to_conn(cfg);
 	struct cfg80211_connect_resp_params conn_params;
+	bool authorized;
 
 	brcmf_dbg(TRACE, "Enter\n");
 
@@ -5993,7 +5994,12 @@ brcmf_bss_connect_done(struct brcmf_cfg80211_info *cfg,
 		conn_params.req_ie_len = conn_info->req_ie_len;
 		conn_params.resp_ie = conn_info->resp_ie;
 		conn_params.resp_ie_len = conn_info->resp_ie_len;
+		authorized = completed &&
+			     (profile->use_fwsup == BRCMF_PROFILE_FWSUP_SAE ||
+			      profile->use_fwsup == BRCMF_PROFILE_FWSUP_PSK);
 		cfg80211_connect_done(ndev, &conn_params, GFP_KERNEL);
+		if (authorized)
+			cfg80211_port_authorized(ndev, profile->bssid, GFP_KERNEL);
 		brcmf_dbg(CONN, "Report connect result - connection %s\n",
 			  completed ? "succeeded" : "failed");
 	}
-- 
2.53.0

