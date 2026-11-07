Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794046818;
	b=mpTJYBAla12XnojmSpZoO/8Z9bsfCQKYVL72SjhogNWQI1x1on58gQxHa5S0kniEL4pL
	 fHDazy+Eogl4uNufFaV5LlEnYVGBIVgAbc8/nBCxoYqE5XqWhRhDDuxwRFM072DB3vH6t
	 cBroz1IfW7ua2vFFPKQwTSbke5wz7zojNKwFe3CjvGpyav0DwGbEV6IJcKKhLIwhTOmRR
	 vf6W8SUwl5Ihn0ErszeY4l1REi1pNmH527BrHR81ad5a4KR/VnvVKrJcTsLDZMXN7cFcq
	 HCeupy22I8f36uZXvLD39m6btpZE53aGS0lWwTqSeajE+oQEPnMp4OWkVj/YdsNM8BQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794046818;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 MIME-Version:Content-Type:Content-Transfer-Encoding;
	bh=1LmFu0Dt3fpDvpEJnOnXo3NTMkqjMaoFbDwjX2MCQME=;
	b=XocGXxXt0B6r3Xx7lpOIzkGFJQYtBlRMo1W1mmfAoyL0smO0wfzoX6n96f/8A+LY6RUn
	 JnRxUURQYVko8f6Hun00lVEXCpCNwgGGcFK3C42i1rsAQchhmznCMudCqCGSw5hLmQNIT
	 ZELRXXpWRRyaJVzRSn2eq6JDhmfucYKQxjkvXOp8cnymN8NRFpMJQUCuARdvhjI63zHNk
	 6T388EZVxC6iEWe77PL9++2xPowxkRkYnwEZEgo2mLklh/UuEApabxTWXBT1qWaKTqaUj
	 mQ0AgkLeU+WoTVnbBCxg7BbBq07QIRvtynDeuPcjCJxEB2rxbeoN6l/OFGxlFPXPodg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b="g9jV/O5o";
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B1987606A8C7
	for <stable@vger.kernel.org>; Sat,  7 Nov 2026 10:20:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=g9jV/O5o
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2E7361F0089F;
	Sat,  7 Nov 2026 10:20:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794046817;
	bh=1LmFu0Dt3fpDvpEJnOnXo3NTMkqjMaoFbDwjX2MCQME=;
	h=From:To:Cc:Subject:Date;
	b=g9jV/O5ofu0waLInCw9G4sSD0DtGrnc2s6+3P3sjpXC10xsD5Q0++ARyzwFDo0lzN
	 feaumB68mOjrjMXTbtxbcsdXf1qkVSbYzAo+9BLdDcTvUxEyoFB/ZwxAT2k0eJvHYN
	 7+lVix0paihmctzeCyr7j5OUwQADxp51yJ433Q2CC68V2oaVFUZcmjDdpKhRPUzkrT
	 dhjLo+kpwaHD87pqEmLjrTi6yWXiikd0nVx3WgbmAmGym+xUfV68LZBGwR7JGB0xKD
	 mQmST+AIl9bQPr19JRzplojLzcOKWY9mhhGt71ZWupzrZNUk8YN5wbm9D5K92h3fJB
	 vt+x623tnphMA==
From: Sasha Levin <sashal@kernel.org>
To: peter.ujfalusi@linux.intel.com,
	tiwai@suse.de
Cc: stable@vger.kernel.org
Subject: FAILED: patch "[PATCH] ALSA: hda/hdmi: clamp sad_count in ELD proc write handler" failed to apply to 6.12-stable tree
Date: Sat,  7 Nov 2026 05:20:16 -0500
Message-ID: <20261107052016-failed-6.12-b3e7ddd694f8@kernel.org>
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

The patch below does not apply to the 6.12-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-6.12.y
git checkout FETCH_HEAD
git cherry-pick -x b3e7ddd694f8429217ba509b55b910a0e4361dfb
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '20261107052016-failed-6.12-b3e7ddd694f8@kernel.org' --subject-prefix 'PATCH 6.12.y' 'HEAD^..'

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




