Received: from 3.mo576.mail-out.ovh.net (3.mo576.mail-out.ovh.net [188.165.52.203])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 54063374183
	for <stable@vger.kernel.org>; Sun, 18 Oct 2026 11:15:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=188.165.52.203
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792322136; cv=none; b=OpiVKvr+7WVrP4naC1xwww2Eq8k6cmRfdIIrf7sS6e48QR/3Yfxk8ktglnY1qiT+og1ON2Y1/rRABvGRFl0ixjriEQxkZfjOLHp0ffk9P8oHKJJ7hVAoF1syEQNXQQ1jXQPf4H18r/BfpFq9YEj4i7jUifqhseEDyN/XdVCaFJ4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792322136; c=relaxed/simple;
	bh=HoHaPtjHoYfkbv9dtFclewtiTpwiXcz72MUS8v1F7Ok=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=HI53fbtQHjmkLqvQkZGwMTMGFYcNJvwvZ/I7Tl+XWFGbBWcsYzdePYBq9Q4Agh+El6sMwUSRBmQ0F9eug9TkE39K1JJu+47N3ULfnC+tphTwNsb6CBjGrazzOWRbVh/QX24uaHFnMjOK3HqCRZPrN9E/4StfUFxLjkWRX4Z7uPs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fortytwo.fr; spf=pass smtp.mailfrom=fortytwo.fr; dkim=pass (2048-bit key) header.d=fortytwo.fr header.i=@fortytwo.fr header.b=BglLw0HX; arc=none smtp.client-ip=188.165.52.203
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fortytwo.fr
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fortytwo.fr
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fortytwo.fr header.i=@fortytwo.fr header.b="BglLw0HX"
Received: from director8.ghost.mail-out.ovh.net (unknown [10.109.231.178])
	by mo576.mail-out.ovh.net (Postfix) with ESMTP id 4j6x184G6hz5wch
	for <stable@vger.kernel.org>; Sun, 18 Oct 2026 11:15:24 +0000 (UTC)
Received: from ghost-submission-7ccd8bbbb6-g6jb4 (unknown [10.111.174.188])
	by director8.ghost.mail-out.ovh.net (Postfix) with ESMTPS id 0068FC010E;
	Sun, 18 Oct 2026 11:15:23 +0000 (UTC)
Received: from fortytwo.fr ([37.59.142.97])
	by ghost-submission-7ccd8bbbb6-g6jb4 with ESMTPSA
	id SwRZKUuq1GqLkAUAZOlizA
	(envelope-from <thomas.nemer@fortytwo.fr>); Sun, 18 Oct 2026 11:15:23 +0000
Authentication-Results:garm.ovh; auth=pass (GARM-97G002cba71a3c-52dd-4ff1-974c-945b586c1852,
                    B56F0971D6B095CE003BCFC685B2F3186F5EFD30) smtp.auth=thomas.nemer@fortytwo.fr
X-OVh-ClientIp:95.173.222.53
From: Thomas Nemer <thomas.nemer@fortytwo.fr>
To: tiwai@suse.com,
	perex@perex.cz
Cc: linux-sound@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Abhinav Mahadevan <abhi220204@gmail.com>,
	Thomas Nemer <thomas.nemer@fortytwo.fr>,
	stable@vger.kernel.org
Subject: [PATCH] ALSA: usb-audio: Fix missing sample-rate control for PreSonus AudioBox USB
Date: Sun, 18 Oct 2026 13:15:19 +0200
Message-ID: <20261018111519.191844-1-thomas.nemer@fortytwo.fr>
X-Mailer: git-send-email 2.56.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
x-ovh-tracer-id: 12271183087021757979
X-VR-SPAMSTATE: OK
X-VR-SPAMSCORE: -100
X-VR-SPAMCAUSE: dmFkZTFMUckpR4h9Qq6ufQkfNitkWwc/06VG3sqOP9O1waKFC2AhgfRF4wZgtEhlKDVEra9FMMg4y7CoDldZWdqsdqUuBfhDriA0EzSgSvslOMwS+ad2uY9MLMmBTkqxVCMGFg9r6LhKa/BG0dIFwrm0EN+KHIQR0QxgJ3mCu/0PCvRZ8PveNfnMW70cr/JC/X4s8Zj3KOr3LTK9fJtAj/zJP5QJOue/RcAZqDnjESXTTGeAmGAoKwT4zIWv0YnOW9miYDUG085WCmDKoO3z/dbLaLFR2KUF1l9WKxp9gBIwMHGGVrJzQVZJCl0rNtds2+MPVTMDwuRWXUk4bqW9agRfENUWaR0SvH3tVoeodi3mWDWn1sHrYdrIvSBzDvXzb+OupMVk3eDg0QanH2liZMWCBNGM7ykgP7A24OSmj73SokJbRk8Is5NfYQuBRqmTvspi2vE/04/izk5uYnntxRbaLZ832sdB1oZOI6e+xAv7iptXYCe6bmsyur4xfHletXSUQJ1xKI+NjMzcNNYtWJl6ZMyS5G6tfn3NIfqm/zo5FhFweFe0RgrAqHEeEzpAS39IFy1yxf0tTzYnkkgDtQ0rsmEdnE58wh39990+MnSGMbnkgFZbjdcY4e3tNXx3LW4GQtnaDzMxzSJuz59YfV/bTeKBk8s39iJ3k40aFMp7baM6eA
DKIM-Signature: a=rsa-sha256; bh=GvC2EkNZpLSK0S+Zb8J1W73t6EIxhICjDJ3m4zRPN/g=;
 c=relaxed/relaxed; d=fortytwo.fr; h=From; s=ovhmo5104297-selector1;
 t=1792322124; v=1;
 b=BglLw0HXajdquoFMYaeMJzWjqA67/eZjgtvG8knpnWwk602L42Jlni0UY60DsR6fMOZUSc0A
 EanytxtO+4w3sYond7siJNTxCxY8mKhcsKluQ8gYE0EgjVDTzb/Zy+/5cz2uGlJ45OWiZvRfInT
 p7wY3IJ3gCm/ZU+kFQc5JsfgmlBAgoguHNeUYjMNHRZXWu6VAwBMiuONuskoIU+Mk5DJhtDOvSo
 pjcAsBvNex3u8Yp2T2CEt0ESaAS3u+V+SOWkExUuaHckq4XgBBKhNI0nm1W4RwWqdWmxmEgv0v9
 uy0kiUhIr59sgd9pCw3GIadR1A2Y3gpCdPk5WHPnjwTGQ==

The fixed audio formats for the PreSonus AudioBox USB declare
.attributes = 0, dropping UAC_EP_CS_ATTR_SAMPLE_RATE that the device
advertises in its class-specific endpoint descriptors (EP_GENERAL
bmAttributes 0x01 on both EP 0x01 and EP 0x82).

As a result set_sample_rate_v1() bails out and the kernel never sends
the UAC1 SET_CUR SAMPLING_FREQ request, leaving the device on its
power-on default clock. Playback and capture then run distorted
whenever the stream rate differs from that default. The device keeps
the last rate set by a host as long as it stays powered, which made the
regression look intermittent (e.g. it disappears after the device was
initialized by a host running a kernel without this quirk entry).

Restore the sample-rate attribute on both streams.

Fixes: 34fe4a9df247 ("ALSA: usb-audio: Add quirk for PreSonus AudioBox USB")
Cc: stable@vger.kernel.org
Signed-off-by: Thomas Nemer <thomas.nemer@fortytwo.fr>
---
 sound/usb/quirks-table.h | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/sound/usb/quirks-table.h b/sound/usb/quirks-table.h
index 2da8cbe3e6..6343a50fb2 100644
--- a/sound/usb/quirks-table.h
+++ b/sound/usb/quirks-table.h
@@ -2911,7 +2911,7 @@ YAMAHA_DEVICE(0x7010, "UB99"),
 					.iface = 2,
 					.altsetting = 1,
 					.altset_idx = 1,
-					.attributes = 0,
+					.attributes = UAC_EP_CS_ATTR_SAMPLE_RATE,
 					.endpoint = 0x01,
 					.ep_attr = USB_ENDPOINT_XFER_ISOC,
 					.rates = SNDRV_PCM_RATE_44100 |
@@ -2932,7 +2932,7 @@ YAMAHA_DEVICE(0x7010, "UB99"),
 					.iface = 3,
 					.altsetting = 1,
 					.altset_idx = 1,
-					.attributes = 0,
+					.attributes = UAC_EP_CS_ATTR_SAMPLE_RATE,
 					.endpoint = 0x82,
 					.ep_attr = USB_ENDPOINT_XFER_ISOC,
 					.rates = SNDRV_PCM_RATE_44100 |
-- 
2.56.0

