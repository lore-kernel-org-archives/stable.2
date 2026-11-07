Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=103.168.172.149
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794064844;
	b=uhZkUeODmSTkW7MxRbZA8UG/0c2KbR7qwQtu+/J/a5hsTXPSDR99PBlaI1VzEj5tRaVL
	 Na7cO0hmhX/vvWjdJ0R/7p491d56B5Rqe7vcdOvCvuTGd/wrsmLJFZidHl+0mO5y4HyGf
	 rU67rMkV8mhnRvwhR7HlSjPcOtaxqCKP/+2dPGpqtxW2oySPiGIsfZyPx2B9Kt7tN/Bc/
	 k7AWEH8/L/6ho7W4UrvMbiaSBfVfXHiTLShcF6s4QpSjZ4Qfahk+FTIl1iQ2ctYP6m/An
	 KalNQgLK9nmXCPt3M6WEpQfCSKlIkQCur2bt6hOShX7kQ3GNWfr9NNknnHePmcjGOSw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794064844;
	h=DMARC-Filter:Received:Received:DKIM-Signature:DKIM-Signature:
	 X-DKIM2-Info:DKIM2-Signature:X-DKIM2-Info:Message-Instance:
	 X-ME-Sender:X-ME-Received:X-ME-Proxy-Cause:X-ME-Proxy:Feedback-ID:
	 Received:From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:
	 References:MIME-Version:Content-Transfer-Encoding;
	bh=gkdh65UmnbrK9mmEX7XKd8VvjTbJdjb/iATivkfwk7g=;
	b=sHqwFCo0LYiiREczUd57vZb761WU49XKpZLgJpsz4WxTN+yUmFpC0WrVhAJMtDJ1ZEeQ
	 K3Arfv6Ts1M2RkpEWnl4PPMSeQ8srlbW2c6ko4JQHn88mfEVlJWxCnZPCnQV0zlK2ZPSX
	 Ka2ZgCirAtgFXYNC0Vny1gnEZYKDvbEruXkE1Awo9wyZs2pe0op4p4p/5lryifOH5ComQ
	 0E//UYjpdzFWZvM2RWkPu3uX5sndVN6bxTUUmd911YqAfhli2HhVWher4i6/xPrqtxnRi
	 1+ZUlb5EIZvJC8zkCzqKa/6qri/arbdA1LApmHv/AO8Crco0vYfhKIquE4TfYSihXVw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=jannau.net;
	spf=pass smtp.mailfrom=jannau.net;
	dkim=pass header.d=jannau.net header.i=@jannau.net header.a=rsa-sha256 header.s=fm1 header.b=CvoJ8LS9;
	dkim=pass header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm3 header.b=iQObfGlc;
	arc=none smtp.remote-ip=103.168.172.149
Received: from fout-a6-smtp.messagingengine.com (fout-a6-smtp.messagingengine.com [103.168.172.149])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 757C6606A337
	for <stable@vger.kernel.org>; Sat,  7 Nov 2026 15:20:43 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 757C6606A337
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=jannau.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=jannau.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=jannau.net header.i=@jannau.net header.a=rsa-sha256 header.s=fm1 header.b=CvoJ8LS9;
	dkim=pass (2048-bit key, unprotected) header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm3 header.b=iQObfGlc
Received: from phl-compute-08.internal (phl-compute-08.internal [10.202.2.48])
	by mailfout.phl.internal (Postfix) with ESMTP id 76FBDEC01CC
	for <stable@vger.kernel.org>; Sat,  7 Nov 2026 10:20:42 -0500 (EST)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-08.internal (MEProxy); Sat, 07 Nov 2026 10:20:42 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=jannau.net; h=cc
	:cc:content-transfer-encoding:content-type:date:date:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to; s=fm1; t=1794064842; x=
	1794151242; bh=gkdh65UmnbrK9mmEX7XKd8VvjTbJdjb/iATivkfwk7g=; b=C
	voJ8LS9Q65xAncpd0wwa6VlVKPyd2E62PM4Ie12/i5O134Wz0OGlxZWUmaZ1NCuD
	cfY2b3EIA5vq7+FsJfNf0yfVF4EKRf1TNWEwbp4LcrGjd3icGJ+mNyyKg1DyT5Vt
	xoV+TwMLVrLwPNzNSwjv1JJnMcrjYGtyZ8cpdwveVQH31Gwxi+nE/tUE0yRygJUw
	yrRXFnd9QHoeOitC/6jS19X85fORCvdE6I34v8lXyN7uqxSXL/epH/lsZ/8wqXj7
	owzJs9L62EuxISX9Wjf/jJhSWUZgD1a6vyEIaIw8EtMEQF9BCsg0BFARDWBMM8iu
	3E///YoavhXVsWXM3SLXw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:date:date:feedback-id:feedback-id:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to:x-me-proxy:x-me-sender
	:x-me-sender:x-sasl-enc; s=fm3; t=1794064842; x=1794151242; bh=g
	kdh65UmnbrK9mmEX7XKd8VvjTbJdjb/iATivkfwk7g=; b=iQObfGlc1Mz990GT+
	+ukXM2Y0x5VngTA7+HQaqsfmKRSzoQmP8UVSTmV/1VeeuRknp1SRC0Nt1l1eXf9O
	3vg+Si3ePfLguSJsp8ONfD6DIM7P++R8b/bXSwFXxKh9Y3awR4KXF552kl2gVklD
	PfSlw1q05n3uLSqDs5G57LNSBrRcnlJqWPGlcp7bjfkcP5FxCAZrfghcyqn/f4ox
	R/dKjMdtUfd0PyUcqtPmZLuoWHvJN9LT0MxEmKT+1gKNIOW1OTlRbuVumxLDVqrW
	Iuze7ZJwVLjvWhsPhTZIUUjKQx4/PeJ4z/JQJr5HOhxGfbifLhbytmsatNMSeu5V
	tjGTw==
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-09;
	repo=github.com/dkim2wg/interop; date=2026-11-03; sw=lmtpprox;
	action=sign d=jannau.net a=rsa-sha256;
DKIM2-Signature: i=1; m=1; t=1794064842; d=jannau.net;
	mf=PGpAamFubmF1Lm5ldD4=; rt=PHN0YWJsZUB2Z2VyLmtlcm5lbC5vcmc+;
	s=fm1:rsa-sha256:UQ/BfjddgGlgWjP01TTFP3x58yuu7cJUdx9ssD+I14nJ89c
	2etlb00bkqwVukyJJ0rmhTIb5OPE5iHL+jkSNdWaJZyHFgMrH3y+57nPX1RzRacr
	v3CxyBKf1d4w92H5zsCkpsJ9hCaBqoGz1rBYnd07StUM28qfC3OewIVGk6dlLiHK
	d1QM47KEfbCRJc0lmUd+1j5VWtlaAoKauZHZQZXkGLyB/qIg8Z4PpO3RiWv28ehc
	i4q70v0VbOnQr35Zqj5CPVohEHTKUzvKFN6V9eNfICzo8gX83Dpflprci9nw6aet
	cVXMi0gqs06Oyzh9etrLKd5clW9p95GN4niBUOw==;
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-09;
	repo=github.com/dkim2wg/interop; date=2026-11-03; sw=lmtpprox;
	action=mi-m=1; hc=11;
	hn=cc,content-transfer-encoding,date,feedback-id,from,
	in-reply-to,message-id,mime-version,references,subject,to;
Message-Instance: m=1; h=sha256:sBA4sOyzX4Pb9jQgCWXY9cC0jZVjNSKOVwbDHyRplQ4=:spPvVnfBP184uibGvW+UFvqoEeLg/NhF7si7xi6iOrU=;
X-ME-Sender: <xms:ykHvage_SzYlzY5ROzE94ngrkSJymByBhhFZYc9z1ZGCIy_7RwcVtA>
    <xme:ykHvapNgg7sTvmzGs1jb4afUhRsMctyGZHYENPPeJv3XBkWX8kfoJ1sggzi7t-QDt
    _tqRdn39A6TLRKKat10rry9WZZ3Cpc8EA1Se4CKVWG_n8Dnn-uxkWeY>
X-ME-Received: <xmr:ykHvamg-Is-Fl08U2x8SWHP93XKgMSlGrKpcmYMOLXVuH4JjKU8yoL4aCrdeOMGwQVxat5cgoY3yBZqUQBdPHHFf6KEp6fCq2uf1hA>
X-ME-Proxy-Cause: dmFkZTEOcw7WQ1DDicKiyCw98NGzBOGQESY6kVAI43pAzrrVEHS6znh6y0iWwDuHrj4ht5
    0GLYE5KtbwkcM0aexerspOndhXoDqvSBS64GQxeSBwR+M+CXrVjiCubmsdqJ1osvRskuOm
    zj2NtX2vIIwq4gfurkut3o0KlKsvBhKoClQl0nqEHmtf8FAzsrLAd/2xBAChYND/snoKXF
    +fOdVCv++bTzhMWX1wRwUUUoWlhPg60bEBinL1PXepJIinGwgnQ5BA5yTBLYMJW6XkQ+Bf
    VvvhnXPdBSDoe2w5kzUKO9mg1Lh2oY3x8LFf72/V+Gtyjy+Ig5BRJEfcRUj8RTAJfQYuRb
    RZAv0/gJGejBykHHgXXDdHCmJrp2oPv0IQVPLJbxT9gfuQO2FnysMPGslGuVw4qDM+dCB5
    GcB7Wsx/a1puXy11Ui1NXv9sVrGJhMyhDt3a8URVW+DAFX6IFqu6bBDGagaTFotlRwdUEB
    HKVyXO7w8LFHSNB7vJN8txBsSkU0BSKLDw4g9vClIBBFJxfD9QzZN0KvKPUv9yNjWBqJ3h
    9Mw+g8prqpXtyg+omO4Sy9a4ffIUxDM7jmNaUwxxEA8RnOsj9T83U9uJh4x/tdj/VXqXFV
    yfqParpedMXbWMtz6SGH0QY6tf8Wg0QBGycT9kjkS1wzaNepY1/bA6gxnSIQ
X-ME-Proxy: <xmx:ykHvak0Qpobvlzm1y7vpd_-zGFRpCC2o-knL3A7HP3g7YklHIkQB7A>
    <xmx:ykHvaohUlwHCrBbUqot4wqoTwpPHRYqVmd8eFY6BdZZ4ynfQZBGXOQ>
    <xmx:ykHvasd7V89Ije32_Y7SoKM9ZYbIvQ1er3Td1EWNclPrhRUfI6xQEg>
    <xmx:ykHvajmR0xYGTMbCRiU866nUBgul6w82bDSQgffSFg2H4wzKpIMVMA>
    <xmx:ykHvagp906KtvfNmyCfhoi8zDphxhqS2uzLk5albZdki7DWaRMSZVfqN>
Feedback-ID: i47b949f6:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Sat,
 7 Nov 2026 10:20:41 -0500 (EST)
From: Janne Grunau <j@jannau.net>
To: stable@vger.kernel.org
Cc: Neal Gompa <neal@gompa.dev>,
	Arend van Spriel <arend.vanspriel@broadcom.com>,
	Johannes Berg <johannes.berg@intel.com>
Subject: [PATCH 7.3.y v2] wifi: brcmfmac: cfg80211: Report port_authorized for 4-way HS offload
Date: Sat,  7 Nov 2026 16:20:40 +0100
Message-ID: <20261107152040.2816614-1-j@jannau.net>
X-Mailer: git-send-email 2.56.0
In-Reply-To: <20261107050406-failed-7.3-6fff9de5c5b4@kernel.org>
References: <20261107050406-failed-7.3-6fff9de5c5b4@kernel.org>
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
(cherry picked from commit 6fff9de5c5b425817588eeed42bd56d665751c13)
Signed-off-by: Janne Grunau <j@jannau.net>
---
 .../net/wireless/broadcom/brcm80211/brcmfmac/cfg80211.c    | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/drivers/net/wireless/broadcom/brcm80211/brcmfmac/cfg80211.c b/drivers/net/wireless/broadcom/brcm80211/brcmfmac/cfg80211.c
index 872c48806d09..62d072b6369e 100644
--- a/drivers/net/wireless/broadcom/brcm80211/brcmfmac/cfg80211.c
+++ b/drivers/net/wireless/broadcom/brcm80211/brcmfmac/cfg80211.c
@@ -6504,6 +6504,7 @@ brcmf_bss_connect_done(struct brcmf_cfg80211_info *cfg,
 	struct brcmf_cfg80211_profile *profile = &ifp->vif->profile;
 	struct brcmf_cfg80211_connect_info *conn_info = cfg_to_conn(cfg);
 	struct cfg80211_connect_resp_params conn_params;
+	bool authorized;
 
 	brcmf_dbg(TRACE, "Enter\n");
 
@@ -6528,7 +6529,13 @@ brcmf_bss_connect_done(struct brcmf_cfg80211_info *cfg,
 		conn_params.req_ie_len = conn_info->req_ie_len;
 		conn_params.resp_ie = conn_info->resp_ie;
 		conn_params.resp_ie_len = conn_info->resp_ie_len;
+		authorized = completed &&
+			     ((profile->use_fwsup == BRCMF_PROFILE_FWSUP_SAE) ||
+			      (profile->use_fwsup == BRCMF_PROFILE_FWSUP_PSK));
 		cfg80211_connect_done(ndev, &conn_params, GFP_KERNEL);
+		if (authorized)
+			cfg80211_port_authorized(ndev, profile->bssid, NULL, 0,
+						 GFP_KERNEL);
 		brcmf_dbg(CONN, "Report connect result - connection %s\n",
 			  completed ? "succeeded" : "failed");
 	}
-- 
2.56.0

