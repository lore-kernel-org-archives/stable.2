Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794362041;
	b=XdiH+Rcs64WzG0gZz2D4xvGP9RCPb5cI6/vL/SdOpaf6qjxDvz5u2BdWYL4NUIvWKr6q
	 kYWB/jU9PPUlVojMfvYumwk1jw8YmtNdquJrq+YMDG1qB0BN26AWn+QXrmKvodaAOyBBp
	 pChR1LJ5UMinp9IaRBkZimW9eBbHS94JHn+phiRlOp1unCWdY+O0RhzIezzrE1w72U7kf
	 Ojcbv/2XUW2VAU6bIru+7/A9q8VJ076vw0RmafyZAl2Sn8UM4NygnqWYuJSqgZHuVzniT
	 lygRsEFMbfrA4O54UVw6fJeNR3pXRP7RZZzHrp6XMCcDA1ayeZGgxiIxXh9v5I3ShDw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794362041;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=187wo1YIBALMVNIOippTR9N27cQBlOIBxAC7EtQUDFI=;
	b=ZpvttPqfeWKgBqDDAsNhq18yExF2r4RqRV6WdoDeha4xyLH3r+QZ2hNVkXK4AET2VWBY
	 7KJ+VZyJONcuK2NSPq3QiDTM51seHq2MembfCQjY45u+oVw/azVIezBq5gsxq56ybJ9y2
	 C7gMeBoBC66H09p/DU2EODrkr87lJJhjWBpjC85nxHpc7vuzsAKmHCxKvlFCuNXq2vDhd
	 hpINs/nY79jSa3OLFToVQ++kqz3z4SPLaNFLohd6VqgpfC6VfhSruj6Yb+f3ljGrE3o9r
	 p3vEE6BPBzQ6Qb7Un2P6ozHksJlMWu5a6BmsyD2SSHMD/0V0ThGJkAqaOEsksbMkcFg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=UD5yn5MW;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 75C95606A31C
	for <stable@vger.kernel.org>; Wed, 11 Nov 2026 01:54:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=UD5yn5MW
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DFDA61F0093D;
	Wed, 11 Nov 2026 01:54:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794362041;
	bh=187wo1YIBALMVNIOippTR9N27cQBlOIBxAC7EtQUDFI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=UD5yn5MW2Fle1jSGeDhD4UmEs/tAEDHoTd0jHMvso9B0YuvdEAEUypzVb5nmJkklV
	 rs9OULHU3S/hSsLN/EOV2tW/yivNudypczBxqgW3YXrdKsfcJzUWB+UqVvd8nYsR7M
	 LXCJp5AiBA2h+CSJmwmQuQ7eVP6h8ICcDdx8e1tygeFCEQDTIqBB32Xwh47FGGSdpe
	 S45DTWpY0oDLrAmXbulXtyUlQwcqk0VbgNui+1uXGt5O/Avs2MW3LpnsOvcv5QRZJH
	 h664qJycrpjkPj7wbgxmvu2oUwdzFfyGZiGaDGJ8WkRrnV0fVzuDgh0VEHI4BtTN/5
	 twrbA7VYqoOEw==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Takashi Iwai <tiwai@suse.de>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.1.y 4/4] ALSA: emux: Stop voices before freeing zones in all cases
Date: Tue, 10 Nov 2026 20:53:57 -0500
Message-ID: <20261111015344.441072-4-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261111015344.441072-1-sashal@kernel.org>
References: <20261107055205-failed-6.1-8a5d87c2ba30@kernel.org>
 <20261111015344.441072-1-sashal@kernel.org>
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

