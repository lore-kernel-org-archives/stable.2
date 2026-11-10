Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794339229;
	b=4Q+nttceL0qQxwu1zShzd++e47ZSGOLsxfofKG+WXNpZnYJ7P5g8xyqZeiOq0CJJKo04
	 lE7t2DCoQsDew0PMmq2naxxflFDzrvAqxo2mFwrMUUfRkB6ixCkho+UjmB2vhk1FLoAz1
	 QH+ns50TEYXwLLJmPGi1YLqDMVlragElhf8kaynudhwPfuEy4Fl+pmIibgVQflvEJ7V2y
	 4AV4qaoKrafgcHL8g0Cy40p0dRSIDyHqb8PjArm0jmYcxERZgzX4J5oCMBPy8e5k6gmfY
	 LOA40JJgAmwtGsC2C7vPOIzEEZypEp3LB5//AcNIGXfsWFWAdPvzbmoFIfADbUyquHw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794339229;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=L65HjD0LrAddqiMDc8Cmg4CYkIzl4RXQWZ+FqVGwm3s=;
	b=v9Vey40waE3djKhZmZ3BpBHi2tcE6T5wdJgJaerjGMgQ+bC4eyXTWtPPtkIV3N5X/g1a
	 XZMePDeZxmdsNCMbnYwQWoJQ5RnpOFMeGd80IVGSSbPtqU95Zg4AH5rSP7F0Alt/XSwfm
	 hgHVrkiQil1Sa+hYBWhzJB99enOO/l8NQ0DMvVHlf7O6Y/N2kFIgZNzaJ20EMh6x2pSqL
	 ua5zzQC2pDgNLpsVMgnqZOC7fhHZg9xpGR4u+UV/wuN0l4EZXAsghSCWsI81iM9ssLeCN
	 IdirgGJDozwiN/WiYb9CgZ0Fr0hNRrb04gWYa+dfwBup5nMTWih2U3l78KVB6EUN1pg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Q9FVCYiB;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 500AB606A326
	for <stable@vger.kernel.org>; Tue, 10 Nov 2026 19:33:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Q9FVCYiB
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3ADD11F008A2;
	Tue, 10 Nov 2026 19:33:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794339229;
	bh=L65HjD0LrAddqiMDc8Cmg4CYkIzl4RXQWZ+FqVGwm3s=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=Q9FVCYiBZlq7xQdUNHCGgqy1aiwjuSKlo0KwJ2POo1ZdWVHsQx8t3TeEmKLeWlXz8
	 tw7IFDS4mg23xI0QKER92I3nDhJ/WPtaVRqHP1vvJ40UyBC3f4MNRNX+Ql+x78klKW
	 lBmTw0fJUXMZC1SegeiXMdiY21S8TcYgZWNdWeEKgsPyOiVLKQ+N7l7rBue6g9alfy
	 W2ZtA5LGAKMfiZDuZgUeCMioHZzg6WighYxQ1eBOjStx53FFjZDSbL+rnyxLt5wd4m
	 FOsKgT+8vmnoG5ez3p1d7KJHXYbv/QD2u30Md+CAoFM4tL8nhPQ+77fpA6QGjqIXcs
	 rsmZwjqDK4iog==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Janne Grunau <j@jannau.net>,
	Neal Gompa <neal@gompa.dev>,
	Arend van Spriel <arend.vanspriel@broadcom.com>,
	Johannes Berg <johannes.berg@intel.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.12.y 2/2] wifi: brcmfmac: cfg80211: Report port_authorized for 4-way HS offload
Date: Tue, 10 Nov 2026 14:33:45 -0500
Message-ID: <20261110193151.3473712-2-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261110193151.3473712-1-sashal@kernel.org>
References: <20261107051913-failed-6.12-6fff9de5c5b4@kernel.org>
 <20261110193151.3473712-1-sashal@kernel.org>
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
[ sashal: Inlined the PSK/SAE authorization check because the baseline lacks upstream roaming and PMKID authorization support. ]
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 .../net/wireless/broadcom/brcm80211/brcmfmac/cfg80211.c    | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/drivers/net/wireless/broadcom/brcm80211/brcmfmac/cfg80211.c b/drivers/net/wireless/broadcom/brcm80211/brcmfmac/cfg80211.c
index c3a3a08179109..a2a0cc43bc721 100644
--- a/drivers/net/wireless/broadcom/brcm80211/brcmfmac/cfg80211.c
+++ b/drivers/net/wireless/broadcom/brcm80211/brcmfmac/cfg80211.c
@@ -6424,6 +6424,7 @@ brcmf_bss_connect_done(struct brcmf_cfg80211_info *cfg,
 	struct brcmf_cfg80211_profile *profile = &ifp->vif->profile;
 	struct brcmf_cfg80211_connect_info *conn_info = cfg_to_conn(cfg);
 	struct cfg80211_connect_resp_params conn_params;
+	bool authorized;
 
 	brcmf_dbg(TRACE, "Enter\n");
 
@@ -6448,7 +6449,13 @@ brcmf_bss_connect_done(struct brcmf_cfg80211_info *cfg,
 		conn_params.req_ie_len = conn_info->req_ie_len;
 		conn_params.resp_ie = conn_info->resp_ie;
 		conn_params.resp_ie_len = conn_info->resp_ie_len;
+		authorized = completed &&
+			     (profile->use_fwsup == BRCMF_PROFILE_FWSUP_SAE ||
+			      profile->use_fwsup == BRCMF_PROFILE_FWSUP_PSK);
 		cfg80211_connect_done(ndev, &conn_params, GFP_KERNEL);
+		if (authorized)
+			cfg80211_port_authorized(ndev, profile->bssid, NULL, 0,
+						 GFP_KERNEL);
 		brcmf_dbg(CONN, "Report connect result - connection %s\n",
 			  completed ? "succeeded" : "failed");
 	}
-- 
2.53.0

