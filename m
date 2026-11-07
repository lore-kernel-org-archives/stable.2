Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794050379;
	b=CSB5SlYLOM2fd1XK3KqqYsp3imxdtT/Xcb+SXiWIOw+Xj8+gldj6+jv8ycrHvsxo9Ttw
	 qMSPaQq/nx6BQN30aNE4IlnaK3r/ta5CCWTdQmWNx1JRVh5AOwbiAR6pGSKZTZUDPAIxG
	 6nm2m3N83qya4U1mX9iyaaniS9D6hAaepIz8GG1xrXRSwRTFOzC78TNQytOt17frkJiwF
	 gU1a4xZmTbDfrkA7kTNExXx2e7RMeEUlUXYlNp6TxALX66zo/VXxWetskn5HsiDqRiLuQ
	 dAOYG+CEZl5BhmXPscwzLmWQ32vfUF6j1J5MfW8kFVUnsG9oUf4ANSLv9cRCyvpUBQg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794050379;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 MIME-Version:Content-Type:Content-Transfer-Encoding;
	bh=bUYpTdwaRjF1fPRpOSJtMQi1KOjjOvKDu85p3wqaV+w=;
	b=KVw2XlkMGVafryfIqAnoLjwwbsdVWWrUcJ9NG+Ab13yfetcL79ViuNy/Hqy3uYoXCiDz
	 GqGvvHH5xUR2YeW3jnu8r0uQfA5TtjtiFl06ZUzKMUZARPUqaTScA58qqBU1/o+yFa+pC
	 xOEo5vqzVN3m/lI8y+L5L1LHkpXQsNmhHTfOVutxEkGIcJm1V0OzeXWr7VZgr4gaZbmVI
	 r1d+AhFWO1t9Zl4UYqRoVGlUkpSjMYTaMQOL5n1MITnI5pVMzn8EAKwrkeeUIEoL/Re55
	 XiaK8tc2BBD7mKmKeUuG7ck+lq4pD26KpScV4JlGhVemsLUM55pJ13RMZ9FpX4csJlA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=HSWQqRXh;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1635F606A326
	for <stable@vger.kernel.org>; Sat,  7 Nov 2026 11:19:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=HSWQqRXh
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 85D761F0089F;
	Sat,  7 Nov 2026 11:19:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794050378;
	bh=bUYpTdwaRjF1fPRpOSJtMQi1KOjjOvKDu85p3wqaV+w=;
	h=From:To:Cc:Subject:Date;
	b=HSWQqRXhGVJPJWgjtOKiMwrXWhel/Vr4BnSXtZgt+JQRIO+ivR9MDS+ULc6mn9JMX
	 uI6oInrLS3gmdwhrblljuQ4r46i9Q1N4lbu9oYvCxrNRuGctKDmnHv7/jOuTEbqgfQ
	 AqrThS/V/gfv67sPunQ72T3Vj59Q3VrWV/BbuXKT+2ASl0aC/2IafdjqE9X8E/VDUJ
	 Tz3n5VlKSso0iptiVTS1j5mu/Ka0y71GVsOaKhgk98wNIIO5wzylKlAzMczzfjsrBj
	 v7smQFD8vN6+kQ6FbT1k4u91iXLKxP86CEBFlxkq2K/EOB1ryig4Iauuf25DPC0ceZ
	 IgGRuSwTXD5bg==
From: Sasha Levin <sashal@kernel.org>
To: peter.ujfalusi@linux.intel.com,
	tiwai@suse.de
Cc: stable@vger.kernel.org
Subject: FAILED: patch "[PATCH] ALSA: hda/hdmi: clamp sad_count in ELD proc write handler" failed to apply to 5.10-stable tree
Date: Sat,  7 Nov 2026 06:19:37 -0500
Message-ID: <20261107061936-failed-5.10-b3e7ddd694f8@kernel.org>
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

The patch below does not apply to the 5.10-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-5.10.y
git checkout FETCH_HEAD
git cherry-pick -x b3e7ddd694f8429217ba509b55b910a0e4361dfb
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '20261107061936-failed-5.10-b3e7ddd694f8@kernel.org' --subject-prefix 'PATCH 5.10.y' 'HEAD^..'

Thanks,
Sasha

------------------ original commit in Linus's tree ------------------

From b3e7ddd694f8429217ba509b55b910a0e4361dfb Mon Sep 17 00:00:00 2001
From: Peter Ujfalusi <peter.ujfalusi@linux.intel.com>
Date: Thu, 8 Oct 2026 11:51:33 +0300
Subject: [PATCH] ALSA: hda/hdmi: clamp sad_count in ELD proc write handler

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
---
 sound/hda/codecs/hdmi/eld.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/sound/hda/codecs/hdmi/eld.c b/sound/hda/codecs/hdmi/eld.c
index 1464fd1c675bc..fc6fe1b0873c3 100644
--- a/sound/hda/codecs/hdmi/eld.c
+++ b/sound/hda/codecs/hdmi/eld.c
@@ -155,9 +155,11 @@ void snd_hdmi_write_eld_info(struct hdmi_eld *eld,
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




