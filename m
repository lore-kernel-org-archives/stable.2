Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794046113;
	b=J9Q4Ck82aKme8+ng2FxC8kReTxKCmpEM8GzuVXHRi25CTl3k6RoXns0BRoCtZ9sKRze9
	 HDIolepF9h31/dV7ZcutxdK6eXHgXZ9uvWSRA7vvAh8PdzGMhbbfnn1MjV97Txh12D7dt
	 h1Sg5Mk+cqEat7bmqOlH3ycybOui/JATaucn2/yJO2AuVOcX/oRzXdHpR0ncBT3RsVSkz
	 cuiVaPqiM5oB9wQcI7HYxggJuV/PO2gI1z9esJ2iFAPvXe4nNbL9ybC56eZU+wmV8EKlq
	 hjZLods3Yeeoqbwn/MmhFHeUYTy0GrLzqzFuTeUCPzgmfZO5GQmAyNX7LwlPZJsA36g==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794046113;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 MIME-Version:Content-Type:Content-Transfer-Encoding;
	bh=xQiSoqY1r0nsHx0KlvBEdQ1vZo+vEq0KPZVxS8td6II=;
	b=i9nlUGypT+6IHXiL51Qx2fh7hojA+EEiivz6W4IHaohCSM17uzI8kyLEdZekk3YF+xcE
	 roZ+TYC0hn5rzbWnZflhqd23id0YjdT8YEUeBPSTKeghtiWx7ZnIqr5076yjjBO2gbOb3
	 967uvJQ/7rQxueoTCn1axQCghElh/7EdIu43RlcsfktgWATLBmnklAO2dWMTYv9A75/gc
	 vW19xzR11xU9oYmEuFX+7n1LweSVBG2X2lzl4NWqbmIzfv5O30Ar1f68MkgA/duSnGEYX
	 jqbmjll7jOhUQLoQ6PPu3k4VHjrsl8OpLqASal/sHZeo7g3GfJZwWHjaWIEG+H+e7Og==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=YHRn630N;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5C5A2606A32C
	for <stable@vger.kernel.org>; Sat,  7 Nov 2026 10:08:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=YHRn630N
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9D7121F008A3;
	Sat,  7 Nov 2026 10:08:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794046113;
	bh=xQiSoqY1r0nsHx0KlvBEdQ1vZo+vEq0KPZVxS8td6II=;
	h=From:To:Cc:Subject:Date;
	b=YHRn630NgWAOWJu43I0nHdMjbFBtNgfPjhqdnsrglNXzxKnImHxC10d9gaOUPuLp6
	 dFSpfws74QeYgTRQNXH25qSeXAUoVxmBMfYgajrhSF2a3SqTH+xUL475ZHelrline2
	 oXHduB6cItJI3jAtCj2g55ea3IoqdlgBQeu41vo6e/nb+g5Jx6TU6GBer6sJc2jq8s
	 StUOECMyJNfrNBQ2BbJ281xf2Y8R77nLnLsQeKAipIdUgzU+3od4UV1Svwl/CZWsvP
	 HYCM/SrVJgb32TRWuibIeYY1JUkB9NMWHUdaYGwwAwUnqV4lRpibNi8NrojQjnNpW2
	 GeAkEzn12+Htg==
From: Sasha Levin <sashal@kernel.org>
To: j@jannau.net,
	neal@gompa.dev,
	arend.vanspriel@broadcom.com,
	johannes.berg@intel.com
Cc: stable@vger.kernel.org
Subject: FAILED: patch "[PATCH] wifi: brcmfmac: cfg80211: Report port_authorized for 4-way HS offload" failed to apply to 6.18-stable tree
Date: Sat,  7 Nov 2026 05:08:31 -0500
Message-ID: <20261107050831-failed-6.18-6fff9de5c5b4@kernel.org>
X-Mailer: git-send-email 2.53.0
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

The patch below does not apply to the 6.18-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-6.18.y
git checkout FETCH_HEAD
git cherry-pick -x 6fff9de5c5b425817588eeed42bd56d665751c13
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '20261107050831-failed-6.18-6fff9de5c5b4@kernel.org' --subject-prefix 'PATCH 6.18.y' 'HEAD^..'

Thanks,
Sasha

------------------ original commit in Linus's tree ------------------

From 6fff9de5c5b425817588eeed42bd56d665751c13 Mon Sep 17 00:00:00 2001
From: Janne Grunau <j@jannau.net>
Date: Tue, 15 Sep 2026 21:17:38 +0200
Subject: [PATCH] wifi: brcmfmac: cfg80211: Report port_authorized for 4-way HS
 offload

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
---
 .../broadcom/brcm80211/brcmfmac/cfg80211.c    | 20 +++++++++++++++----
 1 file changed, 16 insertions(+), 4 deletions(-)

diff --git a/drivers/net/wireless/broadcom/brcm80211/brcmfmac/cfg80211.c b/drivers/net/wireless/broadcom/brcm80211/brcmfmac/cfg80211.c
index fc08c5b2d572f..e32b46b7cbe25 100644
--- a/drivers/net/wireless/broadcom/brcm80211/brcmfmac/cfg80211.c
+++ b/drivers/net/wireless/broadcom/brcm80211/brcmfmac/cfg80211.c
@@ -6588,6 +6588,21 @@ brcmf_bss_roaming_done(struct brcmf_cfg80211_info *cfg,
 	return err;
 }
 
+static bool
+brcmf_fwsup_is_authorized(struct brcmf_cfg80211_profile *profile,
+			  struct cfg80211_connect_resp_params *conn_params)
+{
+	if ((profile->use_fwsup == BRCMF_PROFILE_FWSUP_1X ||
+	     profile->use_fwsup == BRCMF_PROFILE_FWSUP_ROAM) &&
+	    brcmf_has_pmkid(conn_params->req_ie, conn_params->req_ie_len))
+		return true;
+	if (profile->use_fwsup == BRCMF_PROFILE_FWSUP_SAE ||
+	    profile->use_fwsup == BRCMF_PROFILE_FWSUP_PSK)
+		return true;
+
+	return false;
+}
+
 static s32
 brcmf_bss_connect_done(struct brcmf_cfg80211_info *cfg,
 		       struct net_device *ndev, const struct brcmf_event_msg *e,
@@ -6625,10 +6640,7 @@ brcmf_bss_connect_done(struct brcmf_cfg80211_info *cfg,
 		conn_params.resp_ie = conn_info->resp_ie;
 		conn_params.resp_ie_len = conn_info->resp_ie_len;
 		authorized = completed &&
-			     (profile->use_fwsup == BRCMF_PROFILE_FWSUP_1X ||
-			      profile->use_fwsup == BRCMF_PROFILE_FWSUP_ROAM) &&
-			     brcmf_has_pmkid(conn_params.req_ie,
-					     conn_params.req_ie_len);
+			     brcmf_fwsup_is_authorized(profile, &conn_params);
 		cfg80211_connect_done(ndev, &conn_params, GFP_KERNEL);
 		if (authorized)
 			cfg80211_port_authorized(ndev, profile->bssid, NULL, 0,
-- 
2.53.0




