Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=37.230.196.243
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793623675;
	b=t2hTAcIbwdr2dMKYZCvk4w67W6IXjErPmvVrrdmWG+0E0yayPYuLGoWvF1yO1D0Zb9aE
	 Mtq6PM9YSWfuwYvqGvGf6xaSqWIDj8M4NzksDdWgPrsh0snF3jfmRmXB6hqRYvuTKyqFl
	 Ij8H3iS7uT3p7ntadlNw6vECWM7GLQfZ0vXTSj5oi2sR3VgBo0VI5DHPi2942hYxVVLoz
	 sC0f3P3IPVOfPuSN+QxrzYCt8XBMpAbWJW2nH3qZFjJXne5Q1K36BdTwycxPTaosAIkEM
	 Op/RByl3n4YiMjuCyktLx+qjbBeiBYKBWaZXTYlnib4Tj6Cy3+brTEoxrleiFveKOoQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793623675;
	h=DMARC-Filter:DKIM-Signature:Received:Received:Received:From:To:Cc:
	 Subject:Date:Message-ID:X-Mailer:MIME-Version:
	 Content-Transfer-Encoding:X-KSMG-AntiPhishing:X-KSMG-AntiSpam-Auth:
	 X-KSMG-AntiSpam-Envelope-From:X-KSMG-AntiSpam-Info:
	 X-KSMG-AntiSpam-Interceptor-Info:X-KSMG-AntiSpam-Lua-Profiles:
	 X-KSMG-AntiSpam-Method:X-KSMG-AntiSpam-Rate:X-KSMG-AntiSpam-Status:
	 X-KSMG-AntiSpam-Version:X-KSMG-AntiVirus:X-KSMG-AntiVirus-Status:
	 X-KSMG-LinksScanning:X-KSMG-Message-Action:X-KSMG-Rule-ID;
	bh=RJ8/+4zRbRQOCmyB92scD/xfl0eq4A7aEUo/NcgGRfw=;
	b=rmbqYLPxthl1SAcxFDrUkv4XBg1m97AfXkD0S3+Rk8Jm+mHH9QWlxG1cGk+naLpTCNn8
	 oeEVlgHaQqEwGGclW9WGj4hTvgcYRRDZIGRX++7BlAcm71O3lv85513tY2FAaJYe3JfyT
	 5rD4dnpk2XtEi0hMDAhvAOXJo+t5yMKK51Wp9XvLmSzMeQPj7d8FzS8J7ekbce58mS+5s
	 TenCJYy5jIEKSP5HcrKlSt1ALldgt18EVKmKq/d/RP8hhp2D5+Pmk1AuPjy/8+FdCzZBR
	 DPcoRwzWW6Lc1j1xn3fvI8wF3pzQQdqnq6FCUKevtbftd8V/x6fDUV/v1a1RatUbSUA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=astralinux.ru;
	spf=pass smtp.mailfrom=astralinux.ru;
	dkim=pass header.d=astralinux.ru header.i=@astralinux.ru header.a=rsa-sha256 header.s=mail header.b=oVB1x2HZ;
	arc=none smtp.remote-ip=37.230.196.243
Received: from mail-gw01.astralinux.ru (mail-gw01.astralinux.ru [37.230.196.243])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B599B606A326;
	Mon,  2 Nov 2026 12:47:52 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org B599B606A326
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=astralinux.ru
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=astralinux.ru
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=astralinux.ru header.i=@astralinux.ru header.a=rsa-sha256 header.s=mail header.b=oVB1x2HZ
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=astralinux.ru;
	s=mail; t=1793623670;
	bh=lYeFDHWwV3TAhUAPVjToHsZAn0kkozNC4IY2PXrzNZw=;
	h=From:To:Cc:Subject:Date:From;
	b=oVB1x2HZnk2Ro5mWfppnJd5Z/I/7Payc+9HpNKhSN2shq9aXCsXlvolK2sIf4twya
	 skB9mfC7Vp+cgGMog/jadmWH4g/dvaL67Kw3ycKjzoOKvFNUen0e3qyvj3deulhH9H
	 asO8Kmmb6moWFiflisgPbhyQ0BJnpbti210B+sLWS5XRNPOJsgz9io2iQhMS1SFF7N
	 1iFxJtnkWOtZ7ahC9NPHdidUgusZ6RN/yuEBDX0aXaNGgn8IL/cYYCh30arAkX35YH
	 axvHDQXczT6tSNLiGCkDOjd2q8jLKqeVDdSuvgMRF+tz3T+1dHRDntcOrtM+AF5ah8
	 ilizCRC0t8ELw==
Received: from gca-sc-a-srv-ksmg01.astralinux.ru (localhost [127.0.0.1])
	by mail-gw01.astralinux.ru (Postfix) with ESMTP id 4B29C255AA;
	Mon,  2 Nov 2026 15:47:50 +0300 (MSK)
Received: from new-mail.astralinux.ru (unknown [10.205.207.5])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (P-256) server-digest SHA256)
	(No client certificate requested)
	by mail-gw01.astralinux.ru (Postfix) with ESMTPS;
	Mon,  2 Nov 2026 15:47:46 +0300 (MSK)
Received: from DESKTOP-D46TNHI (unknown [10.198.31.164])
	by new-mail.astralinux.ru (Postfix) with ESMTPA id 4jJBLn4gNSz1r4m;
	Mon, 02 Nov 2026 15:47:45 +0300 (MSK)
From: Mikhail Dmitrichenko <mdmitrichenko@astralinux.ru>
To: stable@vger.kernel.org,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Mikhail Dmitrichenko <mdmitrichenko@astralinux.ru>,
	Sasha Levin <sashal@kernel.org>,
	Xiang Mei <xmei5@asu.edu>,
	Takashi Iwai <tiwai@suse.de>,
	Takashi Iwai <tiwai@suse.com>,
	Jaroslav Kysela <perex@perex.cz>,
	Torsten Schenk <torsten.schenk@zoho.com>,
	linux-sound@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	lvc-project@linuxtesting.org,
	co+855929c2df672879@bugs.sh
Subject: [PATCH 5.10/5.15] ALSA: 6fire: fix OOB write from device-reported iso length
Date: Mon,  2 Nov 2026 15:45:44 +0300
Message-ID: <20261102124546.757-1-mdmitrichenko@astralinux.ru>
X-Mailer: git-send-email 2.54.0.windows.1
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
X-KSMG-AntiPhishing: NotDetected, bases: 2026/11/02 11:22:00
X-KSMG-AntiSpam-Auth: dkim=none
X-KSMG-AntiSpam-Envelope-From: mdmitrichenko@astralinux.ru
X-KSMG-AntiSpam-Info: LuaCore: 133 0.3.133 d508d579b02cdb6df47808421a9b9e12fc9fb75b, {date_rfc_vio_soft_silent}, {Tracking_uf_ne_domains}, {Tracking_from_domain_doesnt_match_to}, patch.msgid.link:7.1.1;d41d8cd98f00b204e9800998ecf8427e.com:7.1.1;new-mail.astralinux.ru:7.1.1;127.0.0.199:7.1.2;lore.kernel.org:7.1.1;astralinux.ru:7.1.1, FromAlignment: s
X-KSMG-AntiSpam-Interceptor-Info: scan successful
X-KSMG-AntiSpam-Lua-Profiles: 207177 [Nov 02 2026]
X-KSMG-AntiSpam-Method: none
X-KSMG-AntiSpam-Rate: 0
X-KSMG-AntiSpam-Status: not_detected
X-KSMG-AntiSpam-Version: 6.1.1.27
X-KSMG-AntiVirus: Kaspersky Secure Mail Gateway, version 2.1.0.7854, bases: 2026/11/02 11:53:00 #28780498
X-KSMG-AntiVirus-Status: NotDetected, skipped
X-KSMG-LinksScanning: NotDetected, bases: 2026/11/02 09:49:00
X-KSMG-Message-Action: skipped
X-KSMG-Rule-ID: 1

From: Xiang Mei <xmei5@asu.edu>

commit 1589afe2d099d3e817873bc474676968d7080410 upstream.

usb6fire_pcm_in_urb_handler() sizes each outgoing isochronous packet as
(actual_length - 4) / (in_n_analog << 2) * (out_n_analog << 2) + 4, where
actual_length is the unsigned length the device reported for the matching
IN packet.  A packet completed with status 0 and actual_length < 4 wraps
the subtraction to 0x7fffffec; a zero-length isochronous packet is legal
on the bus, and the preceding loop rejects only non-zero status.  The sum
reaches memset() on out_urb->buffer, a 4832-byte object from
kcalloc(PCM_MAX_PACKET_SIZE, PCM_N_PACKETS_PER_URB).

Even without the wrap the result is out of bounds: at 88.2/96 kHz the
4-in/6-out scaling turns a full 420-byte IN packet into 628, so eight
packets span 5024 bytes of that buffer.  usb_submit_urb() rejects an
over-long descriptor only after the memset() and the
usb6fire_pcm_playback() copy of user PCM data have run.

Guard the subtraction as the sibling usb6fire_pcm_capture() already does,
and limit the frame count to what fits in rt->out_packet_size, the OUT
endpoint's wMaxPacketSize.  This bounds total_length by the buffer size
while keeping each packet length aligned to a whole output frame.

  BUG: KASAN: out-of-bounds in usb6fire_pcm_in_urb_handler (sound/usb/6fire/pcm.c:338)
  Write of size 18446744073709551456 at addr ffff88802a3d0000 by task vhci_rx/5018
  Call Trace:
   dump_stack_lvl (lib/dump_stack.c:94 lib/dump_stack.c:120)
   print_report (mm/kasan/report.c:378 mm/kasan/report.c:482)
   kasan_report (mm/kasan/report.c:595)
   kasan_check_range (mm/kasan/generic.c:186 mm/kasan/generic.c:200)
   __asan_memset (mm/kasan/shadow.c:84)
   usb6fire_pcm_in_urb_handler (sound/usb/6fire/pcm.c:338)
   __usb_hcd_giveback_urb (drivers/usb/core/hcd.c:1657)
   usb_hcd_giveback_urb (drivers/usb/core/hcd.c:1741)
   vhci_rx_loop (drivers/usb/usbip/vhci_rx.c:107 drivers/usb/usbip/vhci_rx.c:242)
   kthread (kernel/kthread.c:436)
   ret_from_fork (arch/x86/kernel/process.c:158)
   ret_from_fork_asm (arch/x86/entry/entry_64.S:245)

  Allocated by task 10:
   __kmalloc_cache_noprof (mm/slub.c:5563)
   usb6fire_pcm_init (sound/usb/6fire/pcm.c:560 sound/usb/6fire/pcm.c:595)
   usb6fire_chip_probe (sound/usb/6fire/chip.c:133)
   usb_probe_interface (drivers/usb/core/driver.c:399)

  The buggy address belongs to the object at ffff88802a3d0000
   which belongs to the cache kmalloc-8k of size 8192
  The buggy address is located 0 bytes inside of
   4832-byte region [ffff88802a3d0000, ffff88802a3d12e0)
  Kernel panic - not syncing: Fatal exception in interrupt

Fixes: c6d43ba816d1 ("ALSA: usb/6fire - Driver for TerraTec DMX 6Fire USB")
Reported-by: co+855929c2df672879@bugs.sh
Closes: https://lore.kernel.org/all/gisnub8aWGLbyZLcDCSc7zWsHonMWGcyRgt5%40bugs.sh/
Assisted-by: LLM
Signed-off-by: Xiang Mei <xmei5@asu.edu>
Link: https://patch.msgid.link/20260914074324.3590843-1-xmei5@asu.edu
Signed-off-by: Takashi Iwai <tiwai@suse.de>
[ mdmitrichenko: Use pcm_urb.packets[] instead of urb.iso_frame_desc[];
  5.10 and 5.15 predate 9fe49dbc023e ("ALSA: usb: 6fire: Avoid embedded
  URBs"). ]
Signed-off-by: Mikhail Dmitrichenko <mdmitrichenko@astralinux.ru>
---
Backport fix for CVE-2026-98312

 sound/usb/6fire/pcm.c | 13 ++++++++++---
 1 file changed, 10 insertions(+), 3 deletions(-)

diff --git a/sound/usb/6fire/pcm.c b/sound/usb/6fire/pcm.c
index 7168f1c6a37a..d209009108ab 100644
--- a/sound/usb/6fire/pcm.c
+++ b/sound/usb/6fire/pcm.c
@@ -327,10 +327,17 @@ static void usb6fire_pcm_in_urb_handler(struct urb *usb_urb)
 
 	/* setup out urb structure */
 	for (i = 0; i < PCM_N_PACKETS_PER_URB; i++) {
+		unsigned int frames = 0;
+
+		if (in_urb->packets[i].actual_length > 4)
+			frames = (in_urb->packets[i].actual_length - 4)
+					/ (rt->in_n_analog << 2);
+		frames = min_t(unsigned int, frames,
+			       (rt->out_packet_size - 4)
+			       / (rt->out_n_analog << 2));
+
 		out_urb->packets[i].offset = total_length;
-		out_urb->packets[i].length = (in_urb->packets[i].actual_length
-				- 4) / (rt->in_n_analog << 2)
-				* (rt->out_n_analog << 2) + 4;
+		out_urb->packets[i].length = frames * (rt->out_n_analog << 2) + 4;
 		out_urb->packets[i].status = 0;
 		total_length += out_urb->packets[i].length;
 	}
-- 
2.43.0

