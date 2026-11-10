Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794339566;
	b=A9gJo1rb18Bnn37wapInu8S+bqoC/f6uenKOg34ya0tQ8Sb5rxCgKhu1E+AnVAoqNVnA
	 rI1TwFwtLxXH7fxe2+6Z07SIt5+TR68cJkyCQuUwijRsg/DUcAStNYt6CX+Ic5Fkttiah
	 BpuQZCe6W4s6zrv23mI4XaGm2baP9G7GQNFhtDpMMdc/KJIs6SGSZ8b2VDT8Zabr4T6bi
	 IlwIACMhIiYS3/vjNmhmdOBDhsNjPfyI4I9mwyEBgIfZ48+LcfJUdM5OTU0n9mXaWCL+v
	 NKaPyiwtOuNewvxT8ZrmiKfvCRi2eS0GY+aYVS0yaNa+6XU6WhK08zzK1zjHAF5Wrfw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794339566;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=n5v8u0KteC+acFRhIx2lKbzAOAXa1zitLP+bkV8+KQo=;
	b=BNAV7CFW4woCIneT2GR9JF+Q7hKE7rU92fyjGfqlNAiK9+Z5dx5Da6RqlPLfvUstDcKi
	 M/uGELySn3C+PDTn6zWMqctzMsoznQlhWLwIG28CbxVc9oAHGpYtfdFPkfsFoZRPE/z0m
	 Ny0spbD1sVQijC5sCQCUKxuzmDsXs2FP8Zkdhyp74VVW2yeox2B3IZZssJsCi6hcTRSLn
	 2xRj1BSntBZlVBbqh+TSII3vtlFLTanceF6+bYhKIGxMOC8duPlku//CvDdsMRgdxn2FJ
	 ZyGqF1fT+54tsUv8tXNWTXXetwJ/QxOz0utdYAbZaFPKhXO3NfIbqe7okUX8Vp+6vtg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=lZjXk7nH;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D5654606A31C
	for <stable@vger.kernel.org>; Tue, 10 Nov 2026 19:39:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=lZjXk7nH
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BFEDD1F008A1;
	Tue, 10 Nov 2026 19:39:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794339565;
	bh=n5v8u0KteC+acFRhIx2lKbzAOAXa1zitLP+bkV8+KQo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=lZjXk7nH/RygB8ruMZ95/7kWJX9U368oUN0EQQKETTGPrYcBXGcbDX/sKirKexDJ9
	 OsdvMPmyWGgrH1Ijukct/XYqMn+s9tuCV5oosKNB5sJwcOk20LB0udXGCA748lIFk+
	 z/7lDx3KkW8xBpE42LzY2qYpl5LVPiK7u15KS4+E05qU1O61jrPzCFHvB9GMTsIt1L
	 Pghsx298Rr+WDL/DqbRHOL6La+NYuSDW5Na+cNjEOXgWlarveWsIJ8FZdcSEiGcEot
	 zhWZnO8ofV99h2owekagtOVNwXvCLz3N7mn/2j+nvndzasp7bfVLPcF0Hm3BJgsKft
	 KakW79oDa+Ozg==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Janne Grunau <j@jannau.net>,
	Neal Gompa <neal@gompa.dev>,
	Arend van Spriel <arend.vanspriel@broadcom.com>,
	Johannes Berg <johannes.berg@intel.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.6.y] wifi: brcmfmac: cfg80211: Report port_authorized for 4-way HS offload
Date: Tue, 10 Nov 2026 14:39:23 -0500
Message-ID: <20261110193657.3619508-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261107053143-failed-6.6-6fff9de5c5b4@kernel.org>
References: <20261107053143-failed-6.6-6fff9de5c5b4@kernel.org>
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
[ sashal: inlined SAE/PSK authorization checks because the existing 1X/ROAM PMKID authorization logic is absent ]
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 .../net/wireless/broadcom/brcm80211/brcmfmac/cfg80211.c    | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/drivers/net/wireless/broadcom/brcm80211/brcmfmac/cfg80211.c b/drivers/net/wireless/broadcom/brcm80211/brcmfmac/cfg80211.c
index 7146e32717cfc..9398a9a7668ee 100644
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

