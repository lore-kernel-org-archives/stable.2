Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794049346;
	b=LQJVHdsCZGnNEpuEM3eKpCpHqW2ZvY+k8OZbgMGMOTqkzQs/g+j6gqDy9+6WTRaU0uUF
	 0htJfb84BaZA3r1Epl2z66xX1RtV5TrzQKI5XK/EjORrX8+xDNHke0kwYfPmUFkYz6lMK
	 KQ0PqNiZ8VUP7VImlEInw50DoXSSGDhWcC40E817V6oXz4PJ5Nm0HEgfRX4WjO1EcFWWS
	 KwCIYF0l+fwei4Jj4M+OQO402LWfQ8ZWfZuqQEeNPQyGkE4wN5go3ZBKMp9wnQFWcNroA
	 5xb2UETkLWc95vj8cmSPCtSXbNAGBVq5Bxr2CyhSyyMHHCG8IxBAxj2e6QOcDEcA2Zg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794049346;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 MIME-Version:Content-Type:Content-Transfer-Encoding;
	bh=tzZJpIjkDleqLUnD6okYIvkpMbrSpzmh1g+wWV0bKvM=;
	b=eGsi6ZA1EVwwmj4Cg1q38bp55uyMRtK5YtoHiSRJ14A0gVWjn3fbo0A4UPtmJjwlrLr2
	 4qKfVVmcZ7uXCuZcH6SiCC7xsqdHZmLoPNLeQPi1yJtYF6IzImoDhaNG2F8hR+HpELzy7
	 SCjTkjk1kzlxjJhC2YW6ll5674YeHmN8gpx3dOFbgVKKfSYW2tsRFqDBm9+qChbtFNsla
	 scGSVlY7RY9KrEdh2Wb4NWSf1vAAvWdepJSpqm60QE4Gi0JHlv50IELTX8FXfP4HdsFZJ
	 E0A+i4MCC1fMvJF3ziGv7pwCs2uh2sFDd1kpl1r6C/YWH/Rm7LOUoDBH0aB4hEG7h2Q==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b="jg/33h+L";
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1997B606A326
	for <stable@vger.kernel.org>; Sat,  7 Nov 2026 11:02:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=jg/33h+L
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5E4741F0089F;
	Sat,  7 Nov 2026 11:02:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794049346;
	bh=tzZJpIjkDleqLUnD6okYIvkpMbrSpzmh1g+wWV0bKvM=;
	h=From:To:Cc:Subject:Date;
	b=jg/33h+LUZAyN9b/dbjJF7AMDFL24m7O7lpq75d5hqCQ8Zr791tAfB0xkX3U11OaH
	 +csGW7MS4jAL+uzDXdZ02AnVvuZFIrsnlHs11QXiLWnopHSGUSIlaX8dPUbKcUqLVQ
	 eusuv4VFXXZvbtaxZyi0L5wtSh6JDVN84q/15Qc0imEKE2XPc3Hslo0MzSNNWPDBVF
	 1QhlC4WJXSIgX17UM6+kxF/OO8TKBB7WwtBdL6FhCZkwbiBpGnbEh2S86K9wQEovDK
	 4S6xDH652GLrpL98JcdpV0/1PzZOZgN6zCyJn245kEFsSuXqF1mL1REFQ3h9gRv+qg
	 AHXI1noTEWF7w==
From: Sasha Levin <sashal@kernel.org>
To: j@jannau.net,
	neal@gompa.dev,
	arend.vanspriel@broadcom.com,
	johannes.berg@intel.com
Cc: stable@vger.kernel.org
Subject: FAILED: patch "[PATCH] wifi: brcmfmac: cfg80211: Report port_authorized for 4-way HS offload" failed to apply to 5.15-stable tree
Date: Sat,  7 Nov 2026 06:02:24 -0500
Message-ID: <20261107060223-failed-5.15-6fff9de5c5b4@kernel.org>
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

The patch below does not apply to the 5.15-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-5.15.y
git checkout FETCH_HEAD
git cherry-pick -x 6fff9de5c5b425817588eeed42bd56d665751c13
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '20261107060223-failed-5.15-6fff9de5c5b4@kernel.org' --subject-prefix 'PATCH 5.15.y' 'HEAD^..'

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




