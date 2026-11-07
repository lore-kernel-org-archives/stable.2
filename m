Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=103.168.172.156
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794064010;
	b=2eex0jJROof7Ql46uVqeqOt31KLRPWjjsOQGNt2bwNekvn0Ffb70lMJHkIvCgDJYNB2C
	 hsMfIGoSiVCfhAqrLtZ+vQ7zw5BaafKPekjsgKhvWo9Gww8wCrNxMEhIhycuxROc0BqtB
	 L8kzTn1MmpWatOq3I2lTQGyJ0gIZt477m6sb3m+Js89zQXI+59HqTgrK4f6a0xVszK1Mb
	 ClaVez5OYyENL5KZjflPkpbgpZOllZmAtecuZsUyWdx/jr1vtV7D08l6y6czbA6ywiMV2
	 piuS5oRYsXiqIknMJIX5yggYq92CIV+vMs9737zZN693MNqt07pAxoH8lIXKNSgG9eA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794064010;
	h=DMARC-Filter:Received:Received:DKIM-Signature:DKIM-Signature:
	 X-DKIM2-Info:DKIM2-Signature:X-DKIM2-Info:Message-Instance:
	 X-ME-Sender:X-ME-Received:X-ME-Proxy-Cause:X-ME-Proxy:Feedback-ID:
	 Received:From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:
	 References:MIME-Version:Content-Transfer-Encoding;
	bh=4EswdoGNyx/WpWc4Sr8nikhPvmSnmkPY65pQ5D/CLzk=;
	b=VPyFFMeCTa5s7/jyWhwvmXkowORr7E13HPPA0Me++TBB+u4hhM53BQlh5W4fi5HYfNUR
	 8MKGu1xRdBwuH/c6OicDII/oAQD1jjDbL9gwgQ5rl4xj4aDipWuIUFgZJuqjOl7LhSmwj
	 jguymxFd3AblJ8cNMrK4+JKCBbrm7xxVwrofnEq3+qdpEjiiNJ45WFUZnn6gFV9z2Tq4o
	 tvwo4Jh3tqvBE6XxkZw7FkhzwmMDoEMQBjhNupJng8nRkt2sQiD0UtgrZYBawHHXYwV8v
	 hERo/aObebZk/E4A2pPTEPi//lrFdONOXhDMLPC6GTwIjnGOuJCjUlzA0GpQ/BZ5W6g==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=jannau.net;
	spf=pass smtp.mailfrom=jannau.net;
	dkim=pass header.d=jannau.net header.i=@jannau.net header.a=rsa-sha256 header.s=fm1 header.b=RDan065T;
	dkim=pass header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm3 header.b=sDcjE6Yw;
	arc=none smtp.remote-ip=103.168.172.156
Received: from fhigh-a5-smtp.messagingengine.com (fhigh-a5-smtp.messagingengine.com [103.168.172.156])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 746DD606EE9E
	for <stable@vger.kernel.org>; Sat,  7 Nov 2026 15:06:49 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 746DD606EE9E
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=jannau.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=jannau.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=jannau.net header.i=@jannau.net header.a=rsa-sha256 header.s=fm1 header.b=RDan065T;
	dkim=pass (2048-bit key, unprotected) header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm3 header.b=sDcjE6Yw
Received: from phl-compute-04.internal (phl-compute-04.internal [10.202.2.44])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 780161400086
	for <stable@vger.kernel.org>; Sat,  7 Nov 2026 10:06:48 -0500 (EST)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-04.internal (MEProxy); Sat, 07 Nov 2026 10:06:48 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=jannau.net; h=cc
	:cc:content-transfer-encoding:content-type:date:date:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to; s=fm1; t=1794064008; x=
	1794150408; bh=4EswdoGNyx/WpWc4Sr8nikhPvmSnmkPY65pQ5D/CLzk=; b=R
	Dan065ThA5lDo72TB0ka2N0bId1p1GbcKDq5XWI4NsgdYi52aVW9tDKRy3WBNrNV
	U/3X6RA25zKR40+k07BaimVBloNlodx/36tzK39XCiWbofxlLdegoe8HF7bslUKY
	dADtF/8vvTNge5x+6PdFffl4Gbu/2o/WnSpGzaS6PCtF2OF125GFDt/oNEQOyB1x
	SNTe+FHzYDS4S0qHr6r83ppnD/CciA1HkwShdM1NO9T0JtkuO/8d8o4SE85ARk4p
	Hrz3AQX1q/VmLKmlpQ9WEd7OiipVQz32GdgwMfx83fHHaKMfZ2QaTimAboMs0Mz1
	kifyqaOsdQtpLOVhKwR9w==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:date:date:feedback-id:feedback-id:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to:x-me-proxy:x-me-sender
	:x-me-sender:x-sasl-enc; s=fm3; t=1794064008; x=1794150408; bh=4
	EswdoGNyx/WpWc4Sr8nikhPvmSnmkPY65pQ5D/CLzk=; b=sDcjE6YwP1oCRlcDV
	auK/h2lCK/mRW4xcKqVKaRrWffHXZ68iSWuUivxVI6Rntcg3vGP+jj+sp3juSYrf
	LwbkGlPKPyLOv2tMO6OoC5VNYQtG9nm4zolLgHANNh1tXsXhh8NRdWiUBw0FV2Uw
	zrUpFdGypZOz9phVgGXJbN9qpus45D/T2Y+lmTqQKHyvZUKf6zt0jMJOqmGhTSn+
	wV/Dy/Wa1rW46GwK0ZfHBp1zdaFqmvSnRq47o8N41akrMU8GgJiRZdjuipmTrz0F
	JKvUywbgfTFQEUeVBWU7rbhTzsiC3eMLtRTzub1ORP6hR/QyRCOMhYNIXME5E2/G
	uv+9w==
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-09;
	repo=github.com/dkim2wg/interop; date=2026-11-03; sw=lmtpprox;
	action=sign d=jannau.net a=rsa-sha256;
DKIM2-Signature: i=1; m=1; t=1794064008; d=jannau.net;
	mf=PGpAamFubmF1Lm5ldD4=; rt=PHN0YWJsZUB2Z2VyLmtlcm5lbC5vcmc+;
	s=fm1:rsa-sha256:N94b5gPXl+vjLpA1ejXuPlBaUTJMxTC+c4Zh2GRq1+UTalY
	hs67xgekO7ZxxKtJn1dZBcxUe6Hno/Vmx/J7+NatCE3qTz0bdi3Hq0yyAfft8L+v
	3AbYkn+WOubXY3unEHpHsBwWhU6hB42OjFdIV80mSZtG/kB0CYi/FpjKwIZLjDGL
	b2b+EgrY6zSxZhWltp1w6lSkAD+c1vfV5h22kEcspZh+y6MOqtXc83ig4uJOsdnq
	iw9qViWTyiZDtj4zDBkTzoCloDxfKVy8UUUXe849ynR7uF7wUvAPGRYjyWtnugFz
	qFsDtOeXK9Hen5HI7K2kWAoKMIyc6lfgoY8R/sQ==;
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-09;
	repo=github.com/dkim2wg/interop; date=2026-11-03; sw=lmtpprox;
	action=mi-m=1; hc=11;
	hn=cc,content-transfer-encoding,date,feedback-id,from,
	in-reply-to,message-id,mime-version,references,subject,to;
Message-Instance: m=1; h=sha256:oTsm65to1fkScHC8bRgUnHtQ05gkNGyrHjcO/77XNBg=:3VfyHf4hcLiljluhjtw87xXNGuDkMlcKJ+MUvCOYkJ4=;
X-ME-Sender: <xms:hz7vaqpiGSrJgU8MWnpsjXxGW7Sq6lKd2Wsch0haSmc449QN4C3crQ>
    <xme:hz7vavp-Wn-_2gSq_yAWG3jTT62hXxn7ihJGD4rqnfi5cLH6CasTTSzCTkVN4YzWo
    bWhrk_9PF94_efg7wqKTYhwNtL1RHn3m4lAZ5Y4GEobATsvr_koHghd>
X-ME-Received: <xmr:hz7vakO6_s_X5u6PhEHplMBQu1baLF9PWXtjwhWgagfgX8EYUWx9L0QhGVtJ4j40qBpJ7VuCVdXdgh0VA4TvfMRNKSOsjQc8X_NnnA>
X-ME-Proxy-Cause: dmFkZTECLITeNU+KOmn+ddkgt8hpP+tDlLhTSy5cKuDE+liS0y1xFcW7Q2Dp181mVdF0ws
    sZiU7jT60KckbNnvz30mfujBo4ZLHeTFv/toYz6aPOsgNoBzDRM0qfRx/8V+Q+sqwhhE3A
    AvaRKMFNwpfzyJLIva8XkAcJ4s8To64UrFbQwucgQx1Tu2QWrRoOBXBmf78Kz77vTtS7Hl
    g/qJuw8HZMwgXfzSKUpZPbgBQddMko8TtFPcOOy+6Qatww+7Th98k7THv/NOpdcgMnS6i7
    fGxLaVLDmAOmVBAiyVIsIFLCor8Cp8gVkcQbnS2nDhnv5yO8WZtYdxkqF+KG5e/G5J1MRx
    gXteHmlu7+E6gR9SrJ4thBSpnuKQ9GGUgXNPJvYkqO9rPXwnubIzwoQjrkXjg7XkxhF+IL
    uUXnufObnqR2IdH96k4x6KblOh3m8cohtWZxhLY/U/dL1UFssRMQRSsG/F5k54ysIo5EIH
    fRTAXWz5kSCYAMibUgAgshfzHpzeXLytx5Q/p3q7XD/5OM7n9p2KPytrHX83VN0Cx9beZC
    2HLR/s4G8oNG9qQEL9XpWJBSbNPAOcZ3Q8jn7c141OXgDZGcdyprl3pzOhbSBGVSjsaEXU
    FZyghSmrdihIzEOWR1BXayn2REiI/Sqmj7yY8mP+bPuWULpm3VGzrhqVM+hw
X-ME-Proxy: <xmx:hz7vaoyOsRNNChdvdO14x5NiQekWARKUVgivGzbJKw80moFn53Kz6g>
    <xmx:hz7valuv_GZSyzyJ2ZwkOUD9SXFLkYUR45pS9mKnAFYZoD-VX6ewGg>
    <xmx:hz7vap65nL-PENxek71T1qo7lUrmAoZFrh3yHvGXTJnek9xsecnfxA>
    <xmx:hz7vasQPEg7Gj5sfZ1apdlInKkFykEWTjTL-FaEkzGHO--6TKmnc5g>
    <xmx:iD7vasVIAJz8uMVFQbEV_nokyr8nvj1Gw3BxRYezvZujZLk7ft-5-NVh>
Feedback-ID: i47b949f6:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Sat,
 7 Nov 2026 10:06:47 -0500 (EST)
From: Janne Grunau <j@jannau.net>
To: stable@vger.kernel.org
Cc: Neal Gompa <neal@gompa.dev>,
	Arend van Spriel <arend.vanspriel@broadcom.com>,
	Johannes Berg <johannes.berg@intel.com>
Subject: [PATCH 7.3.y] wifi: brcmfmac: cfg80211: Report port_authorized for 4-way HS offload
Date: Sat,  7 Nov 2026 16:06:44 +0100
Message-ID: <20261107150644.2744000-1-j@jannau.net>
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
 drivers/net/wireless/broadcom/brcm80211/brcmfmac/cfg80211.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/drivers/net/wireless/broadcom/brcm80211/brcmfmac/cfg80211.c b/drivers/net/wireless/broadcom/brcm80211/brcmfmac/cfg80211.c
index 872c48806d09..130eb9eb9c4e 100644
--- a/drivers/net/wireless/broadcom/brcm80211/brcmfmac/cfg80211.c
+++ b/drivers/net/wireless/broadcom/brcm80211/brcmfmac/cfg80211.c
@@ -6528,7 +6528,13 @@ brcmf_bss_connect_done(struct brcmf_cfg80211_info *cfg,
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

