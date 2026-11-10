Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794352784;
	b=o9RnPart7F+dFQ9P4aGvm841FTlP4a3PP1wmphGF5oEUtpXfoDNexWbSRr3gpcQAbFQR
	 EF6KM1lKCrxEEMgjMaog9JgsuT4PlvEXGGkefc1B7jmliz4qbR2KhT8IKFsRHFx0G8T80
	 ncb+QFeU7/+m9vCYkJNdppYLvoawDpi1iLd8H2LNTnzFHObahjaX4yvK8XAt0Cf9lu8tM
	 MULQoFMoVakHl8pTeqFZNQH2K+3iTKbVJewIpDXwrQs/dqgGq4cWxucSFY9ihlEh6s0Fs
	 kkudM0coJS82kUzd2gwhu5PoMhQqXMrfetb8VjsZmzIzOsDyXb/b1qZDCpG46E9MzCw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794352784;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=fRBgRbGVAmDKMu/C5YTsdZCfB0nJlMDh28VYzEJWsLI=;
	b=YmPVjgvnM4onOujYKNWN/5g+og8Iu1tgE0/yujfypEPiohPTKkizXKkphyidxAk9vucU
	 TwLEGx+YBlvS7rLowmr7QoqLZKzT5XCa4DsGNvMOdJ1NQ9TtiIa4gTzo4YwcMCg17ZdEI
	 MjRLGoC2EESSeIlUYwYe9vpKn1B9AS9q5bAF/a4yl4zO4hGabgvYxnKMhvytu7dPCTC6o
	 4R5lM7IGcstLn5eEoZ0UM89uoS0+Qp6b3kEf4C4qhIh/zmGleQF/w7TSxM23B2lultu0v
	 u9FXnowtjF4V0dYn1YGGcV5U04TxJaXTPEOKVDaSukuUS6cObkMrU7qouCvimCFbB3Q==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=WZGBvnbm;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E55FF606A321
	for <stable@vger.kernel.org>; Tue, 10 Nov 2026 23:19:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=WZGBvnbm
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0B21F1F0093E;
	Tue, 10 Nov 2026 23:19:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794352783;
	bh=fRBgRbGVAmDKMu/C5YTsdZCfB0nJlMDh28VYzEJWsLI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=WZGBvnbmax5P+Dc2a2xzfhhBCHgq9Jo1qh3T6JbrridgP/ep4JcZluvvJfm3Jfdr8
	 6kG8P/dD1qmte41PIkgpCTs3x7yvQ+HC8YLZ0SM1JX+OIkCKI7FEl0L3ODrYxM02I5
	 Frtw8YTqr+jH846PiwQZmTAZ6XYOptQU3kzbVixDujPMoEJJYgd6X/otvfGRM+4i1q
	 tuiWva0WkyPc5JC+4B95JIUtz+zdTUGUpltk3lGIGiAcJ+ck0RVEjpXqadBlA53b09
	 zRaD6sktyK7UUWLVQzYzBBMrRSXlr7h3aS1jF8xR4QOtfBaWCoTjRysLBRUHXaMGF0
	 h/EycmUQ+h0zA==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Oswald Buddenhagen <oswald.buddenhagen@gmx.de>,
	Takashi Iwai <tiwai@suse.de>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.1.y 1/5] ALSA: emux: prune unused parameter from snd_soundfont_load_guspatch()
Date: Tue, 10 Nov 2026 18:19:38 -0500
Message-ID: <20261110231659.106262-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261107055202-failed-6.1-34e3e04b8a17@kernel.org>
References: <20261107055202-failed-6.1-34e3e04b8a17@kernel.org>
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

