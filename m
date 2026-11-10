Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794325949;
	b=2D401ijvDxEvfKu4NvBu8p0eKp7vC/M7Q0Lvf0IPYfgD+sJk8hFblRyC01xSzNMnKsus
	 0aOCf9x7ud7yBhqT0VPS31iMByYKe48O7Vh9esg7YOh53wnpoc5QdPN8DpImJBcWza9wq
	 cF77Oqd9wexuO4Py2YtzGXrzevX2WzLBI7j7y6pz90OnGMOnzdLah4NhBwhjkcj4Exq/Q
	 hvsgraFfeNXmqhQg0PSrBwF3JHTfLHCKAo9mRgWtOJU4e/CFtxhKCPek1/o6A7vXYiotf
	 08DHiBIqsNW0QF/VGTRzgDxNUqfABZQpjvLY3ARqYYQYJjPrtO4pR9BYu/nWCyNXPRQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794325949;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=d+oSRTszEUE73t9AQ2hTbsZADhSxlop3QyVE9L5elCk=;
	b=e/NIgBfm2x4qep+jJj2vddPMomFoJonHdRJyOShCIlQ7Q+1eAqRa3GZywI93pfqIXyVZ
	 RoRJUHMkT/ytRdfSo2rEWlsIJEtMdEyQl+d6Fku1vCjQ28wqoT0CVScas5Zmqj4KtbOpN
	 w5015CGx1rs55jtmnBl2XIl0a2U+tdJVHxifRn9BWwMCtKIDYtVrqfTkURPpFSI42IInP
	 H4N1yDjHTRsSt25pBEcFULvSTRoNUG5jS5cAf965dmNm7o47P0NygIhWCBJDLOQQpjGWe
	 B1tmnTHRR3pEIdaxbeRwGkj1miCjpn2BkJBifyrFwCz4YBkdk//SQNqAdyaddnpPZSw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=N8uZezZt;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8B2D8606A320
	for <stable@vger.kernel.org>; Tue, 10 Nov 2026 15:52:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=N8uZezZt
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CA3E71F0089F;
	Tue, 10 Nov 2026 15:52:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794325949;
	bh=d+oSRTszEUE73t9AQ2hTbsZADhSxlop3QyVE9L5elCk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=N8uZezZt8GDd3HVyRrUCoCxE1EmQAn5g+4tP/IcLku54+3N8VK3ltcPm+R/Q3Fdc1
	 aOLT3srYeFLqTIg46owHySoQuIQnay0vNmQLUr8OApOUQ3SvzjY7kCq+pFKvxy/l/V
	 08KyCJTvWEVQeilxuRpYKJhW8BXE6GrWx41yk0pCuE9G9xwRRRUQdeptfSElh3tFEp
	 VKbEu07qpkcmBMnq50ub7pvOY3Tc/am1XZvOVt2ynezha+D5G2gJ6ZF+LFa0nRoT6y
	 zMoCWaqAS3rDT+jQU/oa/EEcXvNXmi29Kfg1fRG2VRp70K8GdtsqYxNowUKxFMMzGH
	 fJoKhYBmZ9mZQ==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Peter Ujfalusi <peter.ujfalusi@linux.intel.com>,
	Takashi Iwai <tiwai@suse.de>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.6.y] ALSA: hda/hdmi: clamp sad_count in ELD proc write handler
Date: Tue, 10 Nov 2026 10:52:27 -0500
Message-ID: <20261110155205.2351537-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261107053246-failed-6.6-b3e7ddd694f8@kernel.org>
References: <20261107053246-failed-6.6-b3e7ddd694f8@kernel.org>
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
[ sashal: adapted the patch to the older HDMI ELD source layout ]
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

