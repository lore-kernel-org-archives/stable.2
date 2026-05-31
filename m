Received: from air.basealt.ru (air.basealt.ru [193.43.8.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8536C3002AB
	for <stable@vger.kernel.org>; Sun, 31 May 2026 15:30:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.43.8.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780241403; cv=none; b=bGmRQoi89+Mu9tTnCwZ3/y9PS0QodxYcvztsTlEWYSDQRO8wyLmv6qY8zoP383fKcbtWOcVz7/ytdR19A41tl1wAz1OAwLY85nq8+Ik1daM7kVcRuDL+/JIHrpNVNYrqkZ7PNjTkTMw/x+8Ad7a/Ojp72uV9kAiIFUVa0v1fKls=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780241403; c=relaxed/simple;
	bh=yg5rsPofvjlbY/T1oBhBGcDsq5RRca5BvMM41jKdXKI=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=mH/wtUz12q2k2z7KpRauRi6XpEGJI/0pDo+0ugY/etDXsKyVDlW4XMbQSvKZHMFsWH3jqxDXwLUMxD8WgxIXbGn8OEwfJscMmh69oBNi3vga9F5rK8JAAARwhsIr3DHJ8zTF2kYZuqOF4WUXPhIdnyNL8jV1wDBzc+0IL97so88=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=altlinux.org; spf=pass smtp.mailfrom=altlinux.org; arc=none smtp.client-ip=193.43.8.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=altlinux.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=altlinux.org
Received: from altlinux.ipa.basealt.ru (unknown [193.43.11.2])
	(Authenticated sender: kovalevvv)
	by air.basealt.ru (Postfix) with ESMTPSA id CA04B2336D;
	Sun, 31 May 2026 18:29:51 +0300 (MSK)
From: Vasiliy Kovalev <kovalev@altlinux.org>
To: stable@vger.kernel.org
Cc: Ben Hutchings <ben@decadent.org.uk>,
	Takashi Iwai <tiwai@suse.com>,
	alsa-devel@alsa-project.org,
	lvc-project@linuxtesting.org,
	kovalev@altlinux.org
Subject: [PATCH v2 5.10.y] ALSA: usb-audio: fix null pointer dereference on pointer cs_desc
Date: Sun, 31 May 2026 18:29:50 +0300
Message-Id: <20260531152950.191924-1-kovalev@altlinux.org>
X-Mailer: git-send-email 2.33.8
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Chengfeng Ye <cyeaa@connect.ust.hk>

commit b97053df0f04747c3c1e021ecbe99db675342954 upstream.

The pointer cs_desc return from snd_usb_find_clock_source could
be null, so there is a potential null pointer dereference issue.
Fix this by adding a null check before dereference.

Signed-off-by: Chengfeng Ye <cyeaa@connect.ust.hk>
Link: https://lore.kernel.org/r/20211024111736.11342-1-cyeaa@connect.ust.hk
Signed-off-by: Takashi Iwai <tiwai@suse.de>
Fixes: 1dc669fed61a ("ALSA: usb-audio: UAC2: support read-only freq control")
[ kovalev: bp to fix CVE-2021-47211; added Fixes tag; the null
  check was added into both UAC2 and UAC3 branches since the
  older kernel still has the clock source lookup split between
  snd_usb_find_clock_source() and snd_usb_find_clock_source_v3()
  (see upstream commit 9ec730052fa2); return -ENXIO instead of 0
  to match upstream behavior, where the caller reaches the clock
  validation path and returns -ENXIO ]
Signed-off-by: Vasiliy Kovalev <kovalev@altlinux.org>
---
v2:
 - Return -ENXIO instead of 0 on missing cs_desc to match upstream
   behavior. Suggested by Ben Hutchings.
   Link: https://lore.kernel.org/all/ca469f4a22fe4688bbf88c355d074ae5be16a621.camel@decadent.org.uk/
v1:
   Link: https://lore.kernel.org/all/20260421132047.38233-1-kovalev@altlinux.org/
---
 sound/usb/clock.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/sound/usb/clock.c b/sound/usb/clock.c
index 197a6b7d8..8759e20c4 100644
--- a/sound/usb/clock.c
+++ b/sound/usb/clock.c
@@ -646,11 +646,17 @@ static int set_sample_rate_v2v3(struct snd_usb_audio *chip, int iface,
 		struct uac3_clock_source_descriptor *cs_desc;
 
 		cs_desc = snd_usb_find_clock_source_v3(chip->ctrl_intf, clock);
+
+		if (!cs_desc)
+			return -ENXIO;
 		bmControls = le32_to_cpu(cs_desc->bmControls);
 	} else {
 		struct uac_clock_source_descriptor *cs_desc;
 
 		cs_desc = snd_usb_find_clock_source(chip->ctrl_intf, clock);
+
+		if (!cs_desc)
+			return -ENXIO;
 		bmControls = cs_desc->bmControls;
 	}
 
-- 
2.50.1

