Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794325719;
	b=PWcl/7WxCZ0+DFHRaT00QCENh+vivQ3gCZWkqRWmvKS2cvRfkz0dsps6605MEvurIWsc
	 y38w1vskSUPc2Do6uzwxXM6Y6+mXzHQK6THeW8ykHP3cImcDvk9+c+104gZYmbbc/ngYm
	 9kFJ5Bgz2PraneXuhk2qshLfrTi1eXacJ+MLZswa00M1ntTzsUwPXy76JlJ5EuUTJ+zHj
	 s/3saT02Fl+hOpHBrfX81ySy1Y3TRxUnBAdeEY6VFzDgvaKKwY2O6Ua6I4UAcFs5KNcga
	 qTXKBg0hDsbp+DIOzUAQ1IlaW2uIcY5NAJsxPKRhjIUqAYTc2NWZY+WFsNU8FFkrpVw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794325719;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=JoSvLghUZnP0QEos3ypgnuspmgJTDw6sDGmwjr7Wonw=;
	b=3wy73F01mPJUTsQM5B7iN9ndq85mIAKJz9floUnguGrgnekiCz6r3AABzen/kGE3SPUD
	 L7+DXiMg9PhZ+1OUrbuE8D5Zz/4rJKB59fZErPgZwg1DsdGEegzMFmdzDy7SzqR0xjSBX
	 Ey3kBH+hxtNK/cBYAWXuTW/WHr0voZhHpj16hchlfPZefVKMsy6KSBHRhlqi/fymUJf7y
	 bGl3Cil4qOdPFrarXSNwiTgByGew1gzvLbyvuTLKOTGt5TCkb5B7yDl81GZnbcfQK32z/
	 lcGYKiKv6egbxRo7Gp0W81onmloDul3iOzJWee1banZiGDDlTOxl7SjT+HHpKJif7wg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b="Yl2no/qm";
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7428060A2619
	for <stable@vger.kernel.org>; Tue, 10 Nov 2026 15:48:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Yl2no/qm
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9B0E11F008A4;
	Tue, 10 Nov 2026 15:48:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794325719;
	bh=JoSvLghUZnP0QEos3ypgnuspmgJTDw6sDGmwjr7Wonw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=Yl2no/qm2Tn3YHJW4ZBcCJ49VpChhk27IAXBRTAOu9IXvci3+ToFILoogM0FaFi0S
	 RwJ1umXpYxcSH9FEvzGFxL+R1Xs6K56xy2K0uOq8Aj9TWjn4tIdBnfZcRLtI8/JsFP
	 sgQHtsfjRyAsYRf9L6CAi6o3UjbHjr+7upqdEH+x7Gb1HvLN3iphlWA6Hk9pfKIzem
	 u0wpWSXyYsopA0Ja3Nu67ibuEV2cXP785ZuLf5lViEbj28wOiM2tivE8zKZ9ereRXN
	 zfoBzBT4IUmYs6wrBQDKv7VTEhGTgqoBI7madzNFPN/+kx6MWLD4oVj5LrVmR6e7w/
	 57FkdMDymL6zQ==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Peter Ujfalusi <peter.ujfalusi@linux.intel.com>,
	Takashi Iwai <tiwai@suse.de>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.12.y 2/2] ALSA: hda/hdmi: clamp sad_count in ELD proc write handler
Date: Tue, 10 Nov 2026 10:48:36 -0500
Message-ID: <20261110154828.2333180-2-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261110154828.2333180-1-sashal@kernel.org>
References: <20261107052016-failed-6.12-b3e7ddd694f8@kernel.org>
 <20261110154828.2333180-1-sashal@kernel.org>
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
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 sound/pci/hda/hda_eld.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/sound/pci/hda/hda_eld.c b/sound/pci/hda/hda_eld.c
index d3e87b9c1a4f1..9c3ddc290e14a 100644
--- a/sound/pci/hda/hda_eld.c
+++ b/sound/pci/hda/hda_eld.c
@@ -156,9 +156,11 @@ void snd_hdmi_write_eld_info(struct hdmi_eld *eld,
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

