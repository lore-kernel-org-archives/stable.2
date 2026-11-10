Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794326556;
	b=ri0r6+atjRrzbNNv2IQlhCKSVWXeSP6SkiPeHdjbGw5+E4PjNK7Jp5dvyI58YEfwGcSA
	 YK5xCZObmGlPCjJQBQ/abyvUz7B8A1F9xwgfLXhaG781CUBdyNhltmg3YYOF4mYzmhPOv
	 LVR/PkIeoQJl6UYpB7dR9jL+IbMSBM26UYLKqeTeUarlcMG4MkVXrcBlVW7JQcUtoMFNn
	 9PJ/hikz4iLw7/uhcx6/8vbVVB3GPBXMvylsNue7g7aQ7zK/7TtfnYpI3dn+7IINiHaq3
	 H1reYi69cx0o1yC6Q6uh3gTDXwY+Ru6gkDdv4ZyTHvDALBLh95JhnCtdOZlpMvHgo4Q==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794326556;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=ASeEdO6aTxj+EokmnU+5Jz0O7KgHvd65pFaWWAjMSfQ=;
	b=yA4kFVDq2T3FJY1JQeGa97wbJYlK9iT0DOee79wMJ97QjNhnupEJKVDohQrhl5hKNmc8
	 FWLl85YSIdxFC15DcSWVHbUAnLvC03m4pW3chH+JOxUzHgNrAacrXcmK0oGn63luq84Kr
	 oOc5jQiP9f0RMHVP8VaYQsav6yqu6K/J54hPESYOs2Tvd3MV28dIu9rtNlPfQ5Uu8P2G+
	 SMmqT3xVI2j8TGAbAxafJl6ck4SePGN7XiVnT3QIZa83ud/aH12pUoTPE7oTgS28xUa0F
	 NxPUY49kHm7I9MuFEX5jq5DM/69nMXbH80UgGa0v4N1CoCCHyKmnYkcazWITQT0doWg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b="VWWJxE/s";
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F173D606A331
	for <stable@vger.kernel.org>; Tue, 10 Nov 2026 16:02:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=VWWJxE/s
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 18CA21F008A1;
	Tue, 10 Nov 2026 16:02:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794326555;
	bh=ASeEdO6aTxj+EokmnU+5Jz0O7KgHvd65pFaWWAjMSfQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=VWWJxE/sZTMjLbyo0AxHDZRLuHEEL2T4ScUFsLuiU46mpTIL0C4ypxZTGnb835gvF
	 UkOo2ctoi4yxmyZepChgJhpSt+sakbI4S5eA4PcyC95maV5RAmLS00tuqUfjh5iYAw
	 JWKTEAA4tp7vWjM3Nw0Cm1O7seESCEGkk+lF1sc2IXj52tbk0z01sOzjCQFE405d/C
	 GpeJ9sZw/jBVPBcDcwFSFco/IAKdcJhYl3wshYLeBPU21Q6S9zV7x/wYkvGoOhw9SG
	 8P+eBfl/5IqEHFJsT8ceMUMBxmfHhj/rgu7ylmLrGUWNiL6bZhbzW64g1Jhv3HfVkw
	 wXcFC6hQWLCxg==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Peter Ujfalusi <peter.ujfalusi@linux.intel.com>,
	Takashi Iwai <tiwai@suse.de>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.10.y] ALSA: hda/hdmi: clamp sad_count in ELD proc write handler
Date: Tue, 10 Nov 2026 11:02:33 -0500
Message-ID: <20261110160211.2388041-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261107061936-failed-5.10-b3e7ddd694f8@kernel.org>
References: <20261107061936-failed-5.10-b3e7ddd694f8@kernel.org>
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
[ sashal: adjusted for the older source file location of the HDMI ELD code ]
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 sound/pci/hda/hda_eld.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/sound/pci/hda/hda_eld.c b/sound/pci/hda/hda_eld.c
index 136477ed46ae2..5d2f48b5d7166 100644
--- a/sound/pci/hda/hda_eld.c
+++ b/sound/pci/hda/hda_eld.c
@@ -521,9 +521,11 @@ void snd_hdmi_write_eld_info(struct hdmi_eld *eld,
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

