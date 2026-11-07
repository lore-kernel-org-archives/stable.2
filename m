Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=103.168.172.149
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794064993;
	b=mscbJPhvTEFjtiqvMXuG6d9aQU3Ciki1IuRN4zxsGbieu4EyJ2A5VVkTlH8FKXBlehr9
	 SZlpvNRk/HM2UBqRzFDxCOPmTFAzAxAd6g4r6h0P5cbvGoGEmc8Y9R0W2rnhUYKrHRmit
	 7noTO8G+f5fn9+ECkMiFA2jDHMlkobksAH4dgx6WkSS1F5LfNQLHJ89ykN3j4bmy7kMbL
	 nbSQ/t+TduWBq54oY9IYVO/EWvCS76siIy70rsH+UCJEXvFt5fvKWLDE9xRGgWX7rQJof
	 ITGu3o0XWOTOa+yLt3aN/4g3r1fhItzUeBh16hAxoRa9VM6wCBwDDAky1pmQxKgiEYw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794064993;
	h=DMARC-Filter:Received:Received:DKIM-Signature:DKIM-Signature:
	 X-DKIM2-Info:DKIM2-Signature:X-DKIM2-Info:Message-Instance:
	 X-ME-Sender:X-ME-Received:X-ME-Proxy-Cause:X-ME-Proxy:Feedback-ID:
	 Received:From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:
	 References:MIME-Version:Content-Transfer-Encoding;
	bh=rYYTgwCvHSoXI6n7eF/Sa8dZs0DF/G3JDTn86JWyp7c=;
	b=ICZAjwhjK2ypdDUvUWke5mDoNT2NJ3yrZIYM8FyJCpvZTHe9Agj94TGV00bHLKjeWAja
	 /ONi7ySwz2xpexSe9A9cODPIr0J4vSk8I348yXpDwCt31ukHLllz3tEJ1scS7HS/6kAgT
	 h57jEK2IdBKLjJKXcPhE8khg4O6VNseehiAA74RosxiFtB/Bqz6pxVO3ytisFEtKJtLMD
	 +cYsKUC+lUc/JVF2NsDiytfStZGOAu5oK4p1E8WDjSMvjcIGwqnAXIQkgLhI9GHyc86Ly
	 2BwwtQS9bQ8ZcDSk5hjQh5th/EfvkJA4eEhdmfsVVZeg8OWEMa/juBYkqq8EjWmTukw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=jannau.net;
	spf=pass smtp.mailfrom=jannau.net;
	dkim=pass header.d=jannau.net header.i=@jannau.net header.a=rsa-sha256 header.s=fm1 header.b=QTA614bA;
	dkim=pass header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm3 header.b=cenZ5FjN;
	arc=none smtp.remote-ip=103.168.172.149
Received: from fout-a6-smtp.messagingengine.com (fout-a6-smtp.messagingengine.com [103.168.172.149])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 93C08606B896
	for <stable@vger.kernel.org>; Sat,  7 Nov 2026 15:23:11 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 93C08606B896
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=jannau.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=jannau.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=jannau.net header.i=@jannau.net header.a=rsa-sha256 header.s=fm1 header.b=QTA614bA;
	dkim=pass (2048-bit key, unprotected) header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm3 header.b=cenZ5FjN
Received: from phl-compute-02.internal (phl-compute-02.internal [10.202.2.42])
	by mailfout.phl.internal (Postfix) with ESMTP id 944C1EC01CC
	for <stable@vger.kernel.org>; Sat,  7 Nov 2026 10:23:10 -0500 (EST)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-02.internal (MEProxy); Sat, 07 Nov 2026 10:23:10 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=jannau.net; h=cc
	:cc:content-transfer-encoding:content-type:date:date:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to; s=fm1; t=1794064990; x=
	1794151390; bh=rYYTgwCvHSoXI6n7eF/Sa8dZs0DF/G3JDTn86JWyp7c=; b=Q
	TA614bAczsLkkcZEUOInmiuPYaXJqQ44DfccIxTfL5vEC6coZa6G8VUieJW+IuqB
	UFxuB6GXSrNBtNQJKUlSzWqLqId1tDP8utdD6DiTjaxCByf/F4pzvBRgk7VhQFN0
	QW1ub5T5eKpfpEBd3BrXzWak/RH0xMXQg2LT9fGBOnfaheipKQHtSbYiqRoZEgPo
	r+tbSo352n94kRR5UGUKV27Zz/fyP5v73zdyrvCcKmCNCKV2coARi6jP7JL5ls7D
	VVLUXjGVB+aJVannkdNjyoGLl6TU9QPXN1NH9dDh/dJM5kCtcBU1duVxAE6JNUle
	eM34I9k9eiyBgaVWOWBVw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:date:date:feedback-id:feedback-id:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to:x-me-proxy:x-me-sender
	:x-me-sender:x-sasl-enc; s=fm3; t=1794064990; x=1794151390; bh=r
	YYTgwCvHSoXI6n7eF/Sa8dZs0DF/G3JDTn86JWyp7c=; b=cenZ5FjNmsXNJ7+io
	kY3fKx79A6qOGx6xxS+EOKAJYIFJNv3opPP+Btxo07u+vAXORUKsn+Nep09UtIK2
	uTmKEbExWj8ZQPFPwB6DizhePngV9UlRSvNnMynw65YKKWH2WoxrKaY9iIW06JsL
	N5ov7yB8agX1c4QUI/Y7pwpeaiLp1NyT8RJkHVvAyzxYA8JuWQfoi31Ft9fAN/8b
	Uvk1OsUufVsPQyWV5Ny7pc/NQikeCoXfE5idTdIE2k+ZEqmorPt+WBZo2aTGYViO
	ySCud10FkybUgWPaQ6UQcuYSXPXKQkYAh+KkGwJssNffqMl3ZhcCW8QBjXzHtGV0
	Y7Q7Q==
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-09;
	repo=github.com/dkim2wg/interop; date=2026-11-03; sw=lmtpprox;
	action=sign d=jannau.net a=rsa-sha256;
DKIM2-Signature: i=1; m=1; t=1794064990; d=jannau.net;
	mf=PGpAamFubmF1Lm5ldD4=; rt=PHN0YWJsZUB2Z2VyLmtlcm5lbC5vcmc+;
	s=fm1:rsa-sha256:qMlfwl30qW4BQj++hwxVkOxoTCdPJIWflrbML+tgzv6vAFk
	FG3Jtm82cFirKDs0t7cst8iT+CXuYUjpjyRbO/Jtlehfr6/SwgMvtC8fFiDiPxdA
	NdTvpq7/6oQO9sLyxEAWJhKro7B8MuhanNuip+L20uPM5GhpA7HGZyNjgAwr4+SZ
	Ot20nQkKm3m9oahWwbXJ0M4hgjPP2EyIOUxMH/45epUmRa4x7QgoMS3LU/qB175+
	vYtf4Y0WYsFV8AGRbkzmCiNWBxJHnnvK811VrDNUKdDHfkNGsV+NlPejCmF9MmHC
	DYCe+ZB/2eaFdYwSUqy+S9+wdBMDNAck8OPFbrQ==;
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-09;
	repo=github.com/dkim2wg/interop; date=2026-11-03; sw=lmtpprox;
	action=mi-m=1; hc=11;
	hn=cc,content-transfer-encoding,date,feedback-id,from,
	in-reply-to,message-id,mime-version,references,subject,to;
Message-Instance: m=1; h=sha256:F3M9LVce1Oo3jZ6V1alDcqkOv5BUTDjEWObY0CrjLoM=:PmT1/8RP5wLJPJmoTepUZWlOwr23vd+4SwSojFXORBs=;
X-ME-Sender: <xms:XkLvaq2U3OzGOpC4IV1itnnZNOqsmLjS4aadEwiEoCpXm9u3FyUMGA>
    <xme:XkLvakF8KYC20_6cmdjYamrr9MgEj84ag2yBsEbiPnnMUOeihrMj3g_6SL9xJjsfU
    C0iZibiVf-igbfq7WIAk_7Ru9NkC0HyU9dc4FSmSLgZ0fzlwIHAluyl>
X-ME-Received: <xmr:XkLvan5bIi9nmtBtZmQrm1x46vjDxlPtXZJ7_cv3A7QS2ZAQdHBeHYfrBNGZsJ7BZigZvvFroZPFK9iTM4KxnwD2x0kReu0XMEkPHQ>
X-ME-Proxy-Cause: dmFkZTE3DlA7rGDJ5g9kNWuU0FSG+EtAWXWVQcRnEE+5AkE1gngG+n463JSX/VsJoN2LB8
    j9CJor228TAugYsmJJ6QjeT2s6kCv3M/SJXZyGewSZtXHNXRtw/62j1B4prMFezipfl1+4
    lcaj222Y5Kq3n52oTxAslAC2vB38TxiTKld8zQSoYlJcDlTVG+lKbaAL0ympjyh6vbt9MB
    +wrChl+mcgGHlYb9SbqwiYUvPeCfFEYzo0QRy1Adja0JS6UbjMJqfoRbexlLDgBqsi9BAu
    ZXM5DBWkOETb6/NyrwQq7IsuEAGObW5P8ERtNxjY7ODQ/0IDjl2ahJumwBQQiy8+fytJp4
    XYeRiiypaEj0+r5YSRPZFj9u+WoinqYjDpecyQbt5bTpC5EpvMUQQe0BJjon/A7xWSeWsN
    Eu1CDUA22UL5xHAQNLfGnIkyebCoADHOXEfhjKUWhElZxD8i0swMb2SORq7sKzjN/E/V+e
    Hysqhsw4c9jCqAUNgQcBJFkL08smPz/X7q0OiWu6+MG+WICqzv9kDlchJkMgg239kRRbTD
    kfyBRtBq4dtQcAPvx7Vo8f1h6T0jUEWYwmKcnkx2CR+RiTtC9SPU28Dj+gMrfEk41yaRv4
    MU8ZpgW/uDWgNRUyRSxaJbYG9B7qhjkYLH85duN3+ZVcz/eyEUx9o+5oXoug
X-ME-Proxy: <xmx:XkLvaqs2HGW82VfS-jztUlS-H3VSzaoLjbRsstPqIIp0YzZVNtpjoQ>
    <xmx:XkLvao4eBsM4Djl2hjqFN1hh5pvREa4l02WPzI026Fsn-pFltZF9qw>
    <xmx:XkLvalXkjCYCivOHikiK4gNQ-Wm4GWtFIer7YdLe6YqT3l3Gj0npmQ>
    <xmx:XkLvaq-paLvcRfQFoWnmrJGsY7XeqQcvArCkcpmjBFBHgrOBEOiTnQ>
    <xmx:XkLvaggaflqKBx5_0svF9akWqImWXbDt5nvzr3dgaO55Cp8fzoqb2i8e>
Feedback-ID: i47b949f6:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Sat,
 7 Nov 2026 10:23:09 -0500 (EST)
From: Janne Grunau <j@jannau.net>
To: stable@vger.kernel.org
Cc: Neal Gompa <neal@gompa.dev>,
	Arend van Spriel <arend.vanspriel@broadcom.com>,
	Johannes Berg <johannes.berg@intel.com>
Subject: [PATCH 6.18.y] wifi: brcmfmac: cfg80211: Report port_authorized for 4-way HS offload
Date: Sat,  7 Nov 2026 16:23:08 +0100
Message-ID: <20261107152308.2817643-1-j@jannau.net>
X-Mailer: git-send-email 2.56.0
In-Reply-To: <20261107050831-failed-6.18-6fff9de5c5b4@kernel.org>
References: <20261107050831-failed-6.18-6fff9de5c5b4@kernel.org>
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
index 1fc9ecd86d5d..1ca879ffb602 100644
--- a/drivers/net/wireless/broadcom/brcm80211/brcmfmac/cfg80211.c
+++ b/drivers/net/wireless/broadcom/brcm80211/brcmfmac/cfg80211.c
@@ -6481,6 +6481,7 @@ brcmf_bss_connect_done(struct brcmf_cfg80211_info *cfg,
 	struct brcmf_cfg80211_profile *profile = &ifp->vif->profile;
 	struct brcmf_cfg80211_connect_info *conn_info = cfg_to_conn(cfg);
 	struct cfg80211_connect_resp_params conn_params;
+	bool authorized;
 
 	brcmf_dbg(TRACE, "Enter\n");
 
@@ -6505,7 +6506,13 @@ brcmf_bss_connect_done(struct brcmf_cfg80211_info *cfg,
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

