Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794326162;
	b=UPRsyo3HiE+eSLr1ZNIX7dLP3w7rcIGYKK4hR+3OHXoTHGg1C2i1xBqQJ7sEYuMz7WyA
	 9zTYg7epJh870MNUH8DvMShpoSAa75ap09sqKVJaIWHmlM/ugZmW/INTXZ5wyBWS28tMW
	 kyTqu4jLBFW1rA4LUW5vsCKfo4Wwbfza8vHEynWXRVF5jf+mtNFnBu2FhGcB2D2olD0LV
	 0Z4rg+xF2SdkE3klAKGvyWypxfpHEdNw93gHAFLDXx8MsL/9qvBpGfiutT10ESMgDNS5w
	 9ET55BGgkXIbZtAvxmxw5TZh4nOaJuPBJOVNcFFthxdCuHJ0I6+2UEZOILWcOqnpMrA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794326162;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=YPLdc2eljXIx9llDxGfxIoz7l1FAkguNVoXUYGSo/XI=;
	b=eUPB/p4AupyIwg8KsOud21jP4fWnxnE168jK3yQAX+K59vRG+CYxgHEXvVvWromrFLYj
	 LM3w53HLFt8nkqmqhESjJUkAgapIVA+LCiHz7/L9ro8R84NjXazB4fIof8LkNuVYk/joY
	 5gxenVzB8t4iC74uh6SqN9NGlKvUwNBH7N3DsSy942r6GSSm8KpXqt4UyqTKwJapjLPQm
	 Fmq0bQey4lxgNuFaj+0XVS/ecMiA/j6JvSj8ZO/o/nCJgqOXA2Uzs5VYIIwUEy+pFtAcz
	 t4zXaWUCCHkebV6l0ly+nCqbRyCyhnbVv4HWtDyuv9DQ6rCFBYj9zPli9Yo7DfcurLQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=G6lnvOgi;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B5AF7606A31C
	for <stable@vger.kernel.org>; Tue, 10 Nov 2026 15:56:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=G6lnvOgi
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A2D8C1F008A1;
	Tue, 10 Nov 2026 15:56:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794326161;
	bh=YPLdc2eljXIx9llDxGfxIoz7l1FAkguNVoXUYGSo/XI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=G6lnvOgiDdFc1yUW9DCWrbm7vU/UvgVO+fUyNli+/BGKA4Yk3Vqr/cZP2BZm1AmxI
	 F1WK4mnI4WMkUBNeCd6mwK+tNWjo6+BvcpL4bXutJQisTZGI6oSiMEG6RuC9HYlO0I
	 pONm9quSjTwamT3GOfxefmJ8PN0BcWm8GlLQSYQ7emVbK4WZD/wm/PiEw6FJSwoOWh
	 F/HbRhG6k0bxHmOq1k4O3aILLzhGmomroDU1p8pPlJLdd+nTyCAGcyuPjt6onSVCS6
	 o3j1MwCSFomzHGdD06DS3wDNp7H48I2XY3dMI/GIr7YVJ/a8WfCU0x+rP3NPnNtgYb
	 Ws854PNNpEaeg==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Peter Ujfalusi <peter.ujfalusi@linux.intel.com>,
	Takashi Iwai <tiwai@suse.de>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.1.y] ALSA: hda/hdmi: clamp sad_count in ELD proc write handler
Date: Tue, 10 Nov 2026 10:55:59 -0500
Message-ID: <20261110155539.2371634-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261107054533-failed-6.1-b3e7ddd694f8@kernel.org>
References: <20261107054533-failed-6.1-b3e7ddd694f8@kernel.org>
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

From: Peter Ujfalusi <peter.ujfalusi@linux.intel.com>

[ Upstream commit b3e7ddd694f8429217ba509b55b910a0e4361dfb ]

snd_hdmi_write_eld_info() parses a "sad_count N" line from the
root-writable ELD proc interface and assigns N directly to
e->sad_count with no upper bound, unlike the per-index "sadN_*" lines
a few lines below which are already bounded to ELD_MAX_SAD.

snd_hdmi_eld_update_pcm_info() later iterates
"for (i = 0; i < e->sad_count; i++)" over the fixed
e->sad[ELD_MAX_SAD] array, so an oversized sad_count read from the
proc file causes it to walk past the array.

Reject sad_count values above ELD_MAX_SAD, matching the existing
per-index guard.

Fixes: acb059938810 ("ALSA: hda - ELD proc interface write updates")
Cc: stable@vger.kernel.org
Signed-off-by: Peter Ujfalusi <peter.ujfalusi@linux.intel.com>
Link: https://patch.msgid.link/20261008085133.9528-1-peter.ujfalusi@linux.intel.com
Signed-off-by: Takashi Iwai <tiwai@suse.de>
[ sashal: adjusted the target file to the older HDA ELD source layout ]
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 sound/pci/hda/hda_eld.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/sound/pci/hda/hda_eld.c b/sound/pci/hda/hda_eld.c
index 1d108ed5c6f25..2f3cf2a88cebe 100644
--- a/sound/pci/hda/hda_eld.c
+++ b/sound/pci/hda/hda_eld.c
@@ -525,9 +525,11 @@ void snd_hdmi_write_eld_info(struct hdmi_eld *eld,
 			e->aud_synch_delay = val;
 		else if (!strcmp(name, "speakers"))
 			e->spk_alloc = val;
-		else if (!strcmp(name, "sad_count"))
+		else if (!strcmp(name, "sad_count")) {
+			if (val > ELD_MAX_SAD)
+				continue;
 			e->sad_count = val;
-		else if (!strncmp(name, "sad", 3)) {
+		} else if (!strncmp(name, "sad", 3)) {
 			sname = name + 4;
 			n = name[3] - '0';
 			if (name[4] >= '0' && name[4] <= '9') {
-- 
2.53.0

