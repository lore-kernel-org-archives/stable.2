Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794362388;
	b=5A34LkCc0osvwa8gixErKvTMF6P0nroPZ26XlOjia54VAbKPhu1RhpMpQeWAKc3gd633
	 LO5cPAazkj1QkE/xbXzqZ5Q1IOCRCHuyDYRn0Ws2oy0FBAMrtV8Yl84xEQYHvEoQHWOGA
	 q5qBaLuDLFsNDoAzrbz0CDvrR9AYXCKKHmfrb7GRNo1923qJRK6U2c4/N6gFZSs7AzQbS
	 3gsat5oIvLFiXifK74PcgJ4WKYR3QGHzql44tfwHcVNi1Stl/PrUuxjKSJwc6z/jI2FSu
	 GOw8SfoLOZOv5Yy6X/Zc232ZXBb8KwhWP6CepsssnKy2iCbpeKYc3AbR4h+eTuPeang==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794362388;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=187wo1YIBALMVNIOippTR9N27cQBlOIBxAC7EtQUDFI=;
	b=E68CC5c91oKPZVHWEbLQq2HAHM2FIqskaBuV0d0bquz5bVf8iWQ1CH5WOD56ip7c1K7f
	 Pu1BTiKK4x5oqxWWoOAwn+yZd3gTTI8JyQ6p4cfw3PZd6CdpqJiDfb08FF+VllM/1batm
	 cb5Vmg6tMU/Dh40mvmOOTEcSnEYkQXrK3ddfO2ebruZGEmG53myD2odA1KyXpcXiP/23r
	 47cfGOkFAw5eCeUKIAdBQNFhCXC8aBZQ5VLDwZCjm3obUTMzR/rLWFMgBFzGW4sZ7E6i2
	 7Q0mKkJC/mxF9/nqng16MA9EsJ84fHVf4vbV/XaAFIvVN6lLWVSEBszfgQhzcxn9BJg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=opr37sI9;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9D2CF606A31C
	for <stable@vger.kernel.org>; Wed, 11 Nov 2026 01:59:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=opr37sI9
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C75C51F0093C;
	Wed, 11 Nov 2026 01:59:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794362388;
	bh=187wo1YIBALMVNIOippTR9N27cQBlOIBxAC7EtQUDFI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=opr37sI9HHz9G9W2qNW2cm31z/c6kEFTNMiVSTpt1vUElUUV0GYih+Wspsm3bK+qC
	 l9mV5z8NFurmI5nRcnQmhxRpMOqQ+swxgFAGQoxAtpKCyKs7lRWkqsbCHNldx2qlbw
	 yjEhucQn8Aj7j07VquYHidMso/0U2HDIUjAaEb6YuidnF8s5MYu6FeK1FRwTLooOgi
	 ZoDxnKgDOqJ/T/OJdGlyX51/UuhDTjMyYL1pdCJLTDfBM7pCwpq0/LfEAlyqNL9WZ8
	 kzvWZVhm+74dy9Jir45/63sUmhlrF1WO7VznDVotZMJ6QC71+vZU1JugkpGKtJqYHM
	 cwIV9sWBu2Snw==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Takashi Iwai <tiwai@suse.de>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.15.y 4/4] ALSA: emux: Stop voices before freeing zones in all cases
Date: Tue, 10 Nov 2026 20:59:44 -0500
Message-ID: <20261111015933.483997-4-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261111015933.483997-1-sashal@kernel.org>
References: <20261107060913-failed-5.15-8a5d87c2ba30@kernel.org>
 <20261111015933.483997-1-sashal@kernel.org>
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

From: Takashi Iwai <tiwai@suse.de>

[ Upstream commit 8a5d87c2ba30e8de31cfbe888fd4d95f43c63db9 ]

The emux voice caches the soundfont zone pointer in vp->zone, which
is referred to later, e.g. in snd_emux_send_effect().  For avoiding
dangling pointers, the soundfont code calls the sample_reset callback
to stop all voices before freeing zones.  However, in a few cases
(e.g. emu10k1's missing sample_reset or the call path via
remove_info()), the sample reset isn't called properly, leaving the
playing voices.

Fix it by always registering the sample_reset callback, falling back
to snd_emux_terminate_all() when the driver has no own ops, and by
calling sample_reset in remove_info() before freeing the zones.

Cc: stable@vger.kernel.org
Link: https://patch.msgid.link/20261020101624.205638-2-tiwai@suse.de
Signed-off-by: Takashi Iwai <tiwai@suse.de>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 sound/synth/emux/emux.c      | 10 +++++++---
 sound/synth/emux/soundfont.c |  9 +++++++++
 2 files changed, 16 insertions(+), 3 deletions(-)

diff --git a/sound/synth/emux/emux.c b/sound/synth/emux/emux.c
index a02f952d74ba2..1b9f69efc2161 100644
--- a/sound/synth/emux/emux.c
+++ b/sound/synth/emux/emux.c
@@ -71,7 +71,12 @@ static int sf_sample_free(void *private_data, struct snd_sf_sample *sp,
 static void sf_sample_reset(void *private_data)
 {
 	struct snd_emux *emu = private_data;
-	emu->ops.sample_reset(emu);
+
+	/* stop all voices that might refer to zones and samples to be freed */
+	if (emu->ops.sample_reset)
+		emu->ops.sample_reset(emu);
+	else
+		snd_emux_terminate_all(emu);
 }
 
 int snd_emux_register(struct snd_emux *emu, struct snd_card *card, int index, char *name)
@@ -96,8 +101,7 @@ int snd_emux_register(struct snd_emux *emu, struct snd_card *card, int index, ch
 	sf_cb.private_data = emu;
 	sf_cb.sample_new = sf_sample_new;
 	sf_cb.sample_free = sf_sample_free;
-	if (emu->ops.sample_reset)
-		sf_cb.sample_reset = sf_sample_reset;
+	sf_cb.sample_reset = sf_sample_reset;
 	emu->sflist = snd_sf_new(&sf_cb, emu->memhdr);
 	if (emu->sflist == NULL)
 		return -ENOMEM;
diff --git a/sound/synth/emux/soundfont.c b/sound/synth/emux/soundfont.c
index c803c5c756114..b151a53a7066c 100644
--- a/sound/synth/emux/soundfont.c
+++ b/sound/synth/emux/soundfont.c
@@ -483,6 +483,15 @@ remove_info(struct snd_sf_list *sflist, struct snd_soundfont *sf,
 	struct snd_sf_zone *prev, *next, *p;
 	int removed = 0;
 
+	/* stop voices before freeing the zones they might refer to */
+	for (p = sf->zones; p; p = p->next) {
+		if (!p->mapped && p->bank == bank && p->instr == instr) {
+			if (sflist->callback.sample_reset)
+				sflist->callback.sample_reset(sflist->callback.private_data);
+			break;
+		}
+	}
+
 	prev = NULL;
 	for (p = sf->zones; p; p = next) {
 		next = p->next;
-- 
2.53.0

