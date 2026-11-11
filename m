Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794361580;
	b=CRAdy31A+doJr8FlIJ8/NYT5lAQegNUS6CeMHMAgFQ76NFST6wT3U6oxY4Sekq7bwVsd
	 6wEduKT1R8AYfD0pI7EVMHNSFs/cCzuAM+/aFEx/qLaRDvhkN/Naa/Ed1PoR0mUQynbTe
	 I9b8QVExJIjR+sjD/06dtZ1PBKuar12WlsqPBglP/zKAUtivoIBGauUkQWgY+FFsJ88Zf
	 YQ/dNWm6cde4Wz2XHllwhTA1wrkS59eteby9fraqc1BO2SN8d2ZrPQ7YqNUFv9Mb48sqV
	 0ejEomJLKCOfWgDaAQh62tx1JxnnUowDAWbsbeUMM+hyZp9hZ0k2eC/qvdmwQoh+r/A==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794361580;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=R5wMieI318ntOWFRpsdhCtAG02yIx8pAoBe5+Y5v/So=;
	b=QifXuTZzAFnPGZqXEgcGtZ55wg639mFTYTxbUJws11b8yyQcd0eBtSCgHayqiGLpM8el
	 zx0OQA8t58e/cgwye/Qg/ZkOPj2VdyPU8z+mXAdGEZ5HLgdlXtjwFkPfUi+RD8EwYzpMR
	 cj/LaAauE7NAjCYJ4DkyHbkbdIaG3oR7JoD6nmRWFjrkgBMAAR5QWC8POUDIXR7OZv2Rg
	 7tTqlZJguCx/hRRUVUd+B9EtbqPKsoLNsDVQHmXHanEjUP/lbDe5QCzVlQRJ3dVaIjvB0
	 LTfFQQQffDmqo/xIGwha4iXBsAdBiG5Ed9+yXeaucCCHQLwa88g4DuvadaHGZghxN2Q==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=B1uJu7wd;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 799A2606A335
	for <stable@vger.kernel.org>; Wed, 11 Nov 2026 01:46:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=B1uJu7wd
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E675C1F0093D;
	Wed, 11 Nov 2026 01:46:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794361580;
	bh=R5wMieI318ntOWFRpsdhCtAG02yIx8pAoBe5+Y5v/So=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=B1uJu7wdBDStlMBB2EJFLTfT5t9oioPKc0I1wsB/+TsiWt9fvuCMfjOQ7EXpAdCMA
	 iYj7R4q/8cEZvEdOl4wZWGQ74lQeCWQPIf+YQe0xJEvs3MQlbYvYCB2xZ16t9mNX0F
	 UwBxyvd0dTXto7s70IGBNajtOjKKOg9XxfhxK6omOtnvSVjy3EILmBGU/B+3DyqBa+
	 vKBZl30Dnk8CFeMcEBd5hKtt/Yh3DA+f7WTebfipeltU20e7W+RHwBhu16lG1E0AZZ
	 TyKSU1rtu/eTTQrqyFryfYp/5pv8FFdhUk7ZGIDYcpb5GmnO/SOBFH0casi9lqrO4H
	 P02r7YGQLgxBQ==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Takashi Iwai <tiwai@suse.de>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.6.y 4/4] ALSA: emux: Stop voices before freeing zones in all cases
Date: Tue, 10 Nov 2026 20:46:16 -0500
Message-ID: <20261111014442.403245-4-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261111014442.403245-1-sashal@kernel.org>
References: <20261107053715-failed-6.6-8a5d87c2ba30@kernel.org>
 <20261111014442.403245-1-sashal@kernel.org>
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
index 7966590f2edbc..97b930f0fd041 100644
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

