Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794047506;
	b=MddVrxaDtp9E9jVR/WB2sUHqVUW0IIrvHTCF9FPuFhrMjkJxjeQYN/CJVMp9lvl7Mtbn
	 MGjoZzY0n9iHhem4YCRLp5FfzXZEYLOE8IpRIYQjUV8VGyhODIrbmHQa4y8mSugLT0w3Y
	 PvxLln6wBk3r+lvWCYC5IMJGGNvt5in2UPdpksFrXiM+Zcnhd+jZaZwL3cD3a36g9XNbj
	 iomMZgQGmcPDRAaHbqrwmS2T32IK+An18pvT2+cHLcgsrwL1+9yvXRemx9JIOY1+LbWlD
	 a8sU5OqLdxpbUn/7Hm+oWvZ6xFYR5NrKnArHxByBO+qLRCyeh1gyxv8ffAnbBvjGgdQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794047506;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 MIME-Version:Content-Type:Content-Transfer-Encoding;
	bh=5T708wAGw2xGDmEbX4pSWQQVZfc407MHnrAgFDhfIAA=;
	b=gvnnsC9/Y9IMir7UzJwJr/Oj8dvQoN+vb9DpFt8XZu2HZQ6FbujLjPVZmyk9XPwC76gp
	 eBuNqIVW3hZRzvxcD89p6UTfZUuzVrp5kj6uoBK5UkdyIWI7J6gH1QFTReEMW81dm42XX
	 Nn+IjfChR/Zy2A2q+jyRZ2t6PtXEmDYSB9lX97qTxAMxwAY5wqr4f/R85M4xQVodb6CE4
	 uvayDcaza5jwCAmDWtJpgSrhO+ZJ7w5gnhZ3NeNExu5DU3EjNIKqzdSeeIXPhY/a3+kc9
	 Sa8VL+aNgo1MISt3JXeeRibnQlOa5L4wjx+22u/ri9mYVJDs07CP88kdnVq44Het8lg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=LAi+WDJW;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C3DE2606A32C
	for <stable@vger.kernel.org>; Sat,  7 Nov 2026 10:31:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=LAi+WDJW
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BACEC1F0089F;
	Sat,  7 Nov 2026 10:31:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794047505;
	bh=5T708wAGw2xGDmEbX4pSWQQVZfc407MHnrAgFDhfIAA=;
	h=From:To:Cc:Subject:Date;
	b=LAi+WDJWBqhiXhSLxjYvzoAsl15yY1kVzW8//2ZXlhtZGXmtaceBwIzTG9IFv2JqC
	 uEmpyQymJImi637oarrW05zL8OIfC/g+JjLXHsxu42EZ9fsjKT6rmkJFrLatt7E2Jp
	 4ba3SWCfXxvO3ljlCjC7sN0Ja4Kr8vtgIYzS1e2sGVaHKh95xgGsIQxTCvcKFMTLrm
	 uCAlJiz1a1/y5eoazUtx9nW+o0o9+XzQBOaeqkdeOo08x3Ht2ogEcTVSFakdD8fVY8
	 a8d591GTDAkLUi3vENJjrh2iKsGZIo2ZGLbJAYhpfrtQOs7h6tFUz3VRFUbWMpbFkH
	 XuMs6RYJdoSjw==
From: Sasha Levin <sashal@kernel.org>
To: j@jannau.net,
	neal@gompa.dev,
	arend.vanspriel@broadcom.com,
	johannes.berg@intel.com
Cc: stable@vger.kernel.org
Subject: FAILED: patch "[PATCH] wifi: brcmfmac: cfg80211: Report port_authorized for 4-way HS offload" failed to apply to 6.6-stable tree
Date: Sat,  7 Nov 2026 05:31:43 -0500
Message-ID: <20261107053143-failed-6.6-6fff9de5c5b4@kernel.org>
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

The patch below does not apply to the 6.6-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-6.6.y
git checkout FETCH_HEAD
git cherry-pick -x 6fff9de5c5b425817588eeed42bd56d665751c13
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '20261107053143-failed-6.6-6fff9de5c5b4@kernel.org' --subject-prefix 'PATCH 6.6.y' 'HEAD^..'

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




