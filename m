Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794341168;
	b=PQzhHopXM9uDLxcbkuNV9VoNgqmMswv9k/i2dGJbn55+yUnlwMzpqp/leEevPCCQ0k4G
	 VvDRq+k99HQa06teVDWCZTunuNT3TAcoXnotOQ0jdXJvUPIeAdG/mo+SO8oy0HrEX4CCN
	 eHzQrJZH3ObvdvqlJB2zHTTE2TOV06H2uCWigcCcTJgm9V4KrnJvFuIkEdj8MtczsQFYF
	 NlPORO7q+7ruM05Y3MRsBn/7Wb1f4bnHV5awnWUVL5l8EKftq2VBwhnX9AG38dEUykcSn
	 ori1xlENZFYmVrPl7sRbJVlZ/HYnMnmqLdZc9e3dBlr31JFihURQjH22NUbFulGVGpw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794341168;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=5cCNd5C3NgQ8FqbUpDpP4T8mFx9FG08/ganDkKISSDA=;
	b=AnYrIr3U2Clj/UJxcc0wgHhqDsdrGTxydXDOTkODd4f3s1Sh6SgVOjQrWZLzW3e3cQbc
	 hTf3eMUKqQD8k20/HrrajWN3tHH7vt2U1v4VyO/F6+g0Mquyct842UEybe1fdEMky91k/
	 rulTkpR1BYHYXcnMcB2eHcrGzPJWQ/cATvOxviGVBRg0cNaFWIjTZQsoegQApDcJd9RVv
	 LC0Cs8royfYfP3e0bWNp1dwOBWsNILZDkZSOWn1U7XhGxPtpUQMU1ouynfrlg0KY5JeOF
	 cxHIseHGpSb+zfhiCyumF078UHlRGBmPA1gTpcw+jEMq8MBzBGg71TeZvsvhaqlCMCw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=MtFMd8c2;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 77FA5606A321
	for <stable@vger.kernel.org>; Tue, 10 Nov 2026 20:06:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=MtFMd8c2
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 63D201F0089F;
	Tue, 10 Nov 2026 20:06:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794341168;
	bh=5cCNd5C3NgQ8FqbUpDpP4T8mFx9FG08/ganDkKISSDA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=MtFMd8c2M4VYKer+SfXuElmrYPf8BqbxIoSnvxuq/7Qx7+ESAkb/4OSV+SIOnLrnD
	 ZtkbP23Z9G6r9coczFYJQSRIVinojIzfUsMWKCdaTQ4V+9soEdzYmNF9k8uKetul/L
	 YR1iQ/u1GR1O+QvS2ovC0cXOsDWRcNVmM5iYc/RlL2uNnI7xgAxqZQRqM3C3PLDBhn
	 5Ic3NjiMKPs6IQIg8l7NnELxBqTniV5gQvOwCPn+fJkcrHlqvHFV9tcLSgdgqxBGiK
	 huXIqj3jG7fUwTkl44ahGQyvNvPlWnqogQ6cqoe64GmtDOaA0iKnMbTL7TjU/BbrXc
	 pbm+3w/nOISnw==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Janne Grunau <j@jannau.net>,
	Neal Gompa <neal@gompa.dev>,
	Arend van Spriel <arend.vanspriel@broadcom.com>,
	Johannes Berg <johannes.berg@intel.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.15.y] wifi: brcmfmac: cfg80211: Report port_authorized for 4-way HS offload
Date: Tue, 10 Nov 2026 15:06:06 -0500
Message-ID: <20261110200529.3657251-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261107060223-failed-5.15-6fff9de5c5b4@kernel.org>
References: <20261107060223-failed-5.15-6fff9de5c5b4@kernel.org>
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
[ sashal: replaced the authorization helper with an inline PSK/SAE check using the three-argument cfg80211_port_authorized() API ]
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/net/wireless/broadcom/brcm80211/brcmfmac/cfg80211.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/drivers/net/wireless/broadcom/brcm80211/brcmfmac/cfg80211.c b/drivers/net/wireless/broadcom/brcm80211/brcmfmac/cfg80211.c
index 13ea5f0c8e1e1..aec1c0b9ef08c 100644
--- a/drivers/net/wireless/broadcom/brcm80211/brcmfmac/cfg80211.c
+++ b/drivers/net/wireless/broadcom/brcm80211/brcmfmac/cfg80211.c
@@ -6029,6 +6029,7 @@ brcmf_bss_connect_done(struct brcmf_cfg80211_info *cfg,
 	struct brcmf_cfg80211_profile *profile = &ifp->vif->profile;
 	struct brcmf_cfg80211_connect_info *conn_info = cfg_to_conn(cfg);
 	struct cfg80211_connect_resp_params conn_params;
+	bool authorized;
 
 	brcmf_dbg(TRACE, "Enter\n");
 
@@ -6049,7 +6050,12 @@ brcmf_bss_connect_done(struct brcmf_cfg80211_info *cfg,
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

