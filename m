Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794352357;
	b=kyH9sbxe3dFYKSv6WkPTlTX/Fv5N3rmEsRVhyXZWsFapIKguIldbqnsMU8shOUDmDXsL
	 +I9hmnNPoc1sgPl6vDHwtfTxh7q78l92eQ/SG5roYpuDPCY0Br8PurOJB8u72UgNvYKIk
	 ccFyIp0e8j+ZUEiY0k5R38icoyUmMI9jTTi8OOFzfNZU0BkfrMO8FwHZd/WOy4nKANX39
	 ONeXycsc3CXs7ykscxccAHDdRuLUTAz/6x3uRNU6lX9P0o6lTBJ/jzN2Q03A3mdQ1wc6x
	 oL7Zqk/h4eGSZ2p88IWmrDCozGBIdzGTSmXZjCWfaTQLuuq3wTiTM8OoksmYHOSxy3w==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794352357;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=fRBgRbGVAmDKMu/C5YTsdZCfB0nJlMDh28VYzEJWsLI=;
	b=ulDs3GEn4twUp1VrNL9ZI8GXi2HfqMwGTpE3W4DQBYFRMB+qI0aU7RWYa4+EXoj3Ar8B
	 IZdGM5Z+xF6/qAFScQQGSUxFaFjzof4B2R9VPNKMhx7pQp/3/1lzeGaEB63v04DRo7Cov
	 KJOVzUpZ4uf39jtDdrcTgti2MRCP1/ZbGjO/xDE/gMC1YtD0wrlWhnkWm3lf5wwRqT9hm
	 4meej9NSM5UEtiTl4RjZMbAg++WMrSMNWYg2kEQ4PKhb4t3LPK8MpYJTg8hhdpUIs2tYu
	 x7Nvn6lBdWefEz6NAycLR5JSJyY1+ImPREjuTHqfN3JeHWkkjiPjLAqy3uKFFyAPt3w==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=BK7cDtrv;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9AD9F606A320
	for <stable@vger.kernel.org>; Tue, 10 Nov 2026 23:12:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=BK7cDtrv
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AE1391F0093C;
	Tue, 10 Nov 2026 23:12:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794352357;
	bh=fRBgRbGVAmDKMu/C5YTsdZCfB0nJlMDh28VYzEJWsLI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=BK7cDtrvXITiSN98ae94c+VLtAGdbQM1ghbz3/97wV2U6gedyUXzO9ORk4QtyWseo
	 6oR1UgHDeyJb3MMCvPYcbduWpeeCrsr3pUOubqyMNezxOzxnVEt4sfIT1uzTlpJWlB
	 wY3HsGXawGW2MwAohmaGcIz2TmWbqnN9MpkR7xW3X1ookBOo26sCVpHKyXAvGTMVQO
	 8W0OXAvct1VFcZ1ftljQn9k63OIA10dMNZW/CDccfafJK1UFVnJLSIiQOuzY1HtkNE
	 V9v0fb9PbMRb6xZl3H+2TKExysjLL8A9EomrAuAVQreLN66+9DQDoFVURoNAojukW2
	 Irw6tT5P62HYQ==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Oswald Buddenhagen <oswald.buddenhagen@gmx.de>,
	Takashi Iwai <tiwai@suse.de>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.6.y 1/5] ALSA: emux: prune unused parameter from snd_soundfont_load_guspatch()
Date: Tue, 10 Nov 2026 18:12:31 -0500
Message-ID: <20261110231146.73238-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261107053717-failed-6.6-34e3e04b8a17@kernel.org>
References: <20261107053717-failed-6.6-34e3e04b8a17@kernel.org>
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

From: Oswald Buddenhagen <oswald.buddenhagen@gmx.de>

[ Upstream commit 3f3e0dfc83d586fe9204936fccae771754a9dbc2 ]

The `client` parameter was not used, so eliminate it from the call
chain.

Signed-off-by: Oswald Buddenhagen <oswald.buddenhagen@gmx.de>
Message-ID: <20240406064830.1029573-3-oswald.buddenhagen@gmx.de>
Signed-off-by: Takashi Iwai <tiwai@suse.de>
Stable-dep-of: 34e3e04b8a17 ("ALSA: emux: Fix UAF of soundfont zones at note-on")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 include/sound/soundfont.h     | 2 +-
 sound/synth/emux/emux_hwdep.c | 3 +--
 sound/synth/emux/emux_oss.c   | 3 +--
 sound/synth/emux/soundfont.c  | 7 +++----
 4 files changed, 6 insertions(+), 9 deletions(-)

diff --git a/include/sound/soundfont.h b/include/sound/soundfont.h
index e445688a4f4f9..98ed98d89d6de 100644
--- a/include/sound/soundfont.h
+++ b/include/sound/soundfont.h
@@ -89,7 +89,7 @@ struct snd_sf_list {
 int snd_soundfont_load(struct snd_sf_list *sflist, const void __user *data,
 		       long count, int client);
 int snd_soundfont_load_guspatch(struct snd_sf_list *sflist, const char __user *data,
-				long count, int client);
+				long count);
 int snd_soundfont_close_check(struct snd_sf_list *sflist, int client);
 
 struct snd_sf_list *snd_sf_new(struct snd_sf_callback *callback,
diff --git a/sound/synth/emux/emux_hwdep.c b/sound/synth/emux/emux_hwdep.c
index 81719bfb8ed73..fd8f978cde1c6 100644
--- a/sound/synth/emux/emux_hwdep.c
+++ b/sound/synth/emux/emux_hwdep.c
@@ -27,8 +27,7 @@ snd_emux_hwdep_load_patch(struct snd_emux *emu, void __user *arg)
 
 	if (patch.key == GUS_PATCH)
 		return snd_soundfont_load_guspatch(emu->sflist, arg,
-						   patch.len + sizeof(patch),
-						   TMP_CLIENT_ID);
+						   patch.len + sizeof(patch));
 
 	if (patch.type >= SNDRV_SFNT_LOAD_INFO &&
 	    patch.type <= SNDRV_SFNT_PROBE_DATA) {
diff --git a/sound/synth/emux/emux_oss.c b/sound/synth/emux/emux_oss.c
index d8d32671f7038..04df46b269d37 100644
--- a/sound/synth/emux/emux_oss.c
+++ b/sound/synth/emux/emux_oss.c
@@ -205,8 +205,7 @@ snd_emux_load_patch_seq_oss(struct snd_seq_oss_arg *arg, int format,
 		return -ENXIO;
 
 	if (format == GUS_PATCH)
-		rc = snd_soundfont_load_guspatch(emu->sflist, buf, count,
-						 SF_CLIENT_NO(p->chset.port));
+		rc = snd_soundfont_load_guspatch(emu->sflist, buf, count);
 	else if (format == SNDRV_OSS_SOUNDFONT_PATCH) {
 		struct soundfont_patch_info patch;
 		if (count < (int)sizeof(patch))
diff --git a/sound/synth/emux/soundfont.c b/sound/synth/emux/soundfont.c
index eed47e4830248..77144fe221cf2 100644
--- a/sound/synth/emux/soundfont.c
+++ b/sound/synth/emux/soundfont.c
@@ -944,8 +944,7 @@ int snd_sf_vol_table[128] = {
 
 /* load GUS patch */
 static int
-load_guspatch(struct snd_sf_list *sflist, const char __user *data,
-	      long count, int client)
+load_guspatch(struct snd_sf_list *sflist, const char __user *data, long count)
 {
 	struct patch_info patch;
 	struct snd_soundfont *sf;
@@ -1127,11 +1126,11 @@ load_guspatch(struct snd_sf_list *sflist, const char __user *data,
 /* load GUS patch */
 int
 snd_soundfont_load_guspatch(struct snd_sf_list *sflist, const char __user *data,
-			    long count, int client)
+			    long count)
 {
 	int rc;
 	lock_preset(sflist);
-	rc = load_guspatch(sflist, data, count, client);
+	rc = load_guspatch(sflist, data, count);
 	unlock_preset(sflist);
 	return rc;
 }
-- 
2.53.0

