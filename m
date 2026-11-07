Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794049380;
	b=UHM+1d0A7rle9eWCjZV+mRoxm/SrnSfhNOPMqA8d38yVcz0m2uv+1+tgvdFvTpMUW8aG
	 qzTcSyJcGWbwzfURpL4azCmdof4yUDU9N+k0FLM+puCoZZONsep0O7UJA7mEnIpj+1RHw
	 o9AsUz7+WVw5hogtw0PZc0C4Cex8stQHeTG/YHsRbIOP+EDms3WSJHdtHmP3/pgQLJegI
	 J3PsOhcaIU2cpbNR11LKY34fVI/IKZJWBhlz/cTci6dv1nxBBBD0+8mnvjRZXYCmtQBpB
	 QsAqx3YaKE2I9/vVR0vUE5zI2SGQok2J90mEn32bvdsNqr2Eqvh1Yw+EhDFZK1Ye2aw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794049380;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 MIME-Version:Content-Type:Content-Transfer-Encoding;
	bh=zJLMvucbz+TuKQo8upqf4HknqyWuTmFVJZoDNEI0318=;
	b=mUYiOxhO8mz3g5SmoyQeFog8rjbuploaB5jgQ+4wHa+mXNiwPjqOzx1luaRI3y2IIe2x
	 bqZ9W+Tk0HYXdTx/CB1o6nesVBFiTm6bWFwWWW6S+MN3Ho8xdcgLbJ61Iv/f1xlVogcGY
	 gIP2Ad6Vwg6i2rpGJnKqI4zoodjODGPUsl1gfKA3uk6sYSv8ex6cU/Vsbab2XVhZANzaX
	 Gv9E0+qXwjK51tIhurMhLFnT0j9LoqoTaKqYd3WYoQJ1+2LlVfg9u2NdMxxLNQsbJAskv
	 x/tA5AKETk8EJS4AwhJfV9YDc4XWk0aZ8zTUWaUUcEHeGp1IpUPG7+5yzSkTe9ZS90Q==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=jKK5fEMa;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E6EB3606A326
	for <stable@vger.kernel.org>; Sat,  7 Nov 2026 11:02:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=jKK5fEMa
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6656A1F0089F;
	Sat,  7 Nov 2026 11:02:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794049379;
	bh=zJLMvucbz+TuKQo8upqf4HknqyWuTmFVJZoDNEI0318=;
	h=From:To:Cc:Subject:Date;
	b=jKK5fEMafbrEF2SyN8IIxXeE/PQko9sERPgDvM9wm5L8u7L4DTiZ7um7JLXyd9Cqb
	 P/Hdd8vF7WcI9HnR2yf0BGynDNgqr34asLxz6bsyThaQioiQbtij2eTwdgZDq38GAl
	 8uJQB7JOlCFlLd3ZpMkgrotR3oSzT40DF0DtGCj35ntKBBw9RoEZiJV/OiOE8gOUT/
	 dxVyAIyabP8g1HByMKtjHl/Aj4U9MagSYk3a3xdwSTh/ZowteIMwiHbXDXE8Ivmzht
	 T5f6qMSVKIPWjO9sr77GUneQOdwuYEcQ4myJGUpJMtClifdL2A3516yij6tuSOFFC+
	 T0qtCQvvZaKtQ==
From: Sasha Levin <sashal@kernel.org>
To: peter.ujfalusi@linux.intel.com,
	tiwai@suse.de
Cc: stable@vger.kernel.org
Subject: FAILED: patch "[PATCH] ALSA: hda/hdmi: clamp sad_count in ELD proc write handler" failed to apply to 5.15-stable tree
Date: Sat,  7 Nov 2026 06:02:58 -0500
Message-ID: <20261107060258-failed-5.15-b3e7ddd694f8@kernel.org>
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
git cherry-pick -x b3e7ddd694f8429217ba509b55b910a0e4361dfb
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '20261107060258-failed-5.15-b3e7ddd694f8@kernel.org' --subject-prefix 'PATCH 5.15.y' 'HEAD^..'

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




