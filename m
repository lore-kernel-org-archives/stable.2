Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.50
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794140816;
	b=lUUW4nqEFRe+QKplXFZLe0WP649ppFGT+/VznVFSkCcoeb0lTtgqdVqhLb1e5zZkDCIA
	 3bDdyQvU48biUHT33+85pIeCKY0yfyxMWvf5rR46dd3iVVY8ZHBr9Kk/wv7KeRjGgbKdm
	 wsz64QLdmblgEoS2NcQJIAZLRXQNjy2LTQ/XPRF37t2vhebhhl/dMpIFmuNGA1vXi2Dy9
	 SjhUCPX/wOleNIGxR6TzQNypJAZvQWfw7/sWIfUkLucKmkKcYa9sj7I5usozuj8NOtFh7
	 HFwFYsFfoLR4zlC0edAkAflYOGgOqJIXZ9fn2q3JesMvoLBQAkLgAfzdOJULVtjQJOQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794140816;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:MIME-Version:
	 Content-Transfer-Encoding;
	bh=j5vfw1aDe1xtu41Qyk1+9C5yZWpL/8ks6O+sOJ8DveI=;
	b=HKvIj++naGO3OaYTCIHVXncPoZmxkQFVNqkzQ6vu0ft1WTesLDs2U53Z5rHsjKG2anF0
	 H27V9AHMCdsz7hKCyfaWyDYlCWxgKUW0MidPpMm4KaGPJ019n3Zzc7/7VVM54wXw+a7W9
	 TbxcevTFO3zBm7BZmAQcz38Ehxlyo3Kyf6JdjnTJu+QyVfpi4gJ+3wTP1AUQd1zl3jU0k
	 XD3FFZLI01jcZK9rncHCnDsV+1SlAFydxTag5VSzlUJ07SgdHje6s16qNZ+PSlDo1ZQVT
	 Q+SBBdqiR9E0V8doTiB+799f+0VYFGZOMWqQuEl+l0zTi7VjCWaqnfHiayY+Jleuwew==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=LdpFVwRc;
	arc=none smtp.remote-ip=74.125.82.50
Received: from mail-dl1-f50.google.com (mail-dl1-f50.google.com [74.125.82.50])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 816E9606A321
	for <stable@vger.kernel.org>; Sun,  8 Nov 2026 12:26:56 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 816E9606A321
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=LdpFVwRc
Received: by mail-dl1-f50.google.com with SMTP id a92af1059eb24-1438d9363fbso12883c88.0
        for <stable@vger.kernel.org>; Sun, 08 Nov 2026 04:26:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794140816; x=1794745616; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=j5vfw1aDe1xtu41Qyk1+9C5yZWpL/8ks6O+sOJ8DveI=;
        b=LdpFVwRcf2cR7Yr+e5IVfyCs3dHwZNUwmMMy1Orgn2Ll6OEWv7JATZ7/JGNqNfszs3
         cQulryuUZeilTSo/QKAuCRaOvdKCqh03j/TmJKuapZevz0TItDdKarZt3bzWUb7tmUCf
         2DVLS0DMMo5osixs9HOr5HV+P6fdQd48ecMm6bxkSSPr7RlfbPKLNMKlSLpcgVnsA8CB
         T7AxxHnNg2C3l043xChd1HGT/FlI3gj0gICjFrPgFJJqdVtDsYWJc96b0yxmFh6gBwz3
         WGjBPzrn1He77nUzkDAJG51ssd0WaLZM5BlZWD+AkETMOY/uvjB3L+46DS759FuaF5Uf
         eOHQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794140816; x=1794745616;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=j5vfw1aDe1xtu41Qyk1+9C5yZWpL/8ks6O+sOJ8DveI=;
        b=GQ2I5eiHXZQt4+UjSkKu3WY7TY+159Cy+cFbtxF7wJXiYigsMTvtEFPZoQ5ikH9bT9
         s7f9q2ilXFlwp5IemHBZbwpCy0w8dSflYIeuhDjLAuzrvK9W/7KV081CQ1EBKhTkOkmH
         NqVNnQi7Ri8BK1YFP9pZS/fUOy2Bcwm9X7JhFazK3vw8Rftvut8GmdfzSyNUPhH3zVqF
         vDlmj0FWuAc/Mqc+Wwc/1Fj19iLZTofbDa7xFvNmr3vYw9/b50qTvyZPrbfuZm/doCxl
         MC/fgh2mZ42gfw21aq7gXaAMl0+W2lOEKALi8a/DwO2JBSjfThTuqpwavaQNNb0OcpoD
         4CMA==
X-Forwarded-Encrypted: i=1; AL+hErHAh05XS5Sc98MJYKkQ1otjbU7yQTlhN1R0Fdvg4Jr3LF55vZ18bNwZy3Cc7FPzInHsny53Kko=@vger.kernel.org
X-Gm-Message-State: APuU4Z9JUlGn/Z+6rz6gunZm2tYUnguRPqq5RmTw53bAl8fGpwJTXP+G
	LOKgNGGqWfy/tc5y6hS3DnCo5/J5BB4OrSgYCwRRIux/6JlgS+XwvF41
X-Gm-Gg: AYBFou2OqxvGaTL6jtNOMbivSQgTU/WNT3RPhr/z7MV3neHpr/RlmApZlPffHgXqfX4
	R9o+HGbXyPPR5scFFcX0iL2dUqiJ3yS4TVhGmIHREg8zVYgm9EIXgTu5AWqhqWfoJbd2Ha6gXHk
	LBYaVFuHWdfFVtc3h19LEnTSuveyoAyU9fYSaB/IN7ubnBezjVi9je7eZQ8EtK9qQk1Gy2eOZhp
	dPaOo1+YKSVuTTOcygje/7oUG0WENjxGn8N1GLZdaGVqnMpCT7fFgaJr/RUX1xd2cALztwSWFZt
	Li0lVGGdgh/tEymB7CnLqkIwqS94GLXsPO+xuryI0oV+iAv3rrqR0Ec4krdo8+/egnoVnY3bHwg
	A68lYyvqEuJmw8sY9lgyfH7qy5xQqXWvVvAKK7COEcl6s5uhULEF0ylWd+IJnOAwWTCMG2rzkBI
	bT0gSWFWXD1fw/uixxm7MT9qiQeL70cgINESbliIUa9eMEGyRGwNcrUtRRyupthSk9hsSB2hdpm
	ltErkjLn2Vaz2vnhyQNfDIbPIl/KofzD9HexCsXhVDsigoUYkdYlkMK7MapduSatAMhoTFu13m+
	Bv028gy4eUZGWis89VSEN3qa0v0E9ie4XDj12U5580Owx1qv
X-Received: by 2002:a05:701b:465b:b0:1b2:6b17:28e6 with SMTP id a92af1059eb24-1b39fe9af5cmr1648537c88.9.1794140815494;
        Sun, 08 Nov 2026 04:26:55 -0800 (PST)
Received: from hj.. ([163.239.22.29])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-1b3731487edsm6026089c88.2.2026.11.08.04.26.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 08 Nov 2026 04:26:55 -0800 (PST)
From: hyunjungg <hj351016@gmail.com>
To: Neill Kapron <nkapron@google.com>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Ruslan Bilovol <ruslan.bilovol@gmail.com>,
	linux-usb@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org,
	Hyunjung Ko <hj351016@gmail.com>
Subject: [PATCH] usb: gadget: f_uac1_legacy: disable OUT ep and drain work on teardown
Date: Sun,  8 Nov 2026 21:26:45 +0900
Message-ID: <20261108122645.421721-1-hj351016@gmail.com>
X-Mailer: git-send-email 2.43.0
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

From: Hyunjung Ko <hj351016@gmail.com>

f_uac1_legacy enables the OUT endpoint in f_audio_set_alt() and queues
usb_requests whose completion handler f_audio_complete() dereferences the
f_audio (req->context) and audio->out_ep, and which schedules
audio->playback_work. However f_audio_disable() is empty and neither
f_audio_unbind() nor f_audio_free() disables the endpoint or drains the
work, so on teardown:

 - f_audio_complete() can run after kfree(audio) (the UDC gives back
   pending requests on the still-enabled endpoint during unbind), using
   freed memory -- a use-after-free; and
 - a playback_work still pending runs f_audio_playback_work() against the
   freed f_audio -- a second use-after-free.

Implement f_audio_disable() to quiesce the function properly: disable the
OUT endpoint (which gives back outstanding requests, so f_audio_complete()
stops touching @audio and no new work is queued), then cancel_work_sync()
the playback work, then free the buffers left on audio->play_queue and
audio->copy_buf (f_audio_playback_work() is the only consumer, so a
cancelled work would otherwise leak them).

The endpoint is disabled before the work is cancelled, and the work is
cancelled before f_audio_free() runs gaudio_cleanup() on audio->card that
u_audio_playback() dereferences, so none of them race the teardown.

Found by static analysis and an automated reviewer; the playback_work
use-after-free was reproduced with KASAN under dummy_hcd (slab-use-after-
free in u_audio_playback() from f_audio_playback_work() after
f_audio_free(); a delay was added to the streaming path to make the
schedule-vs-free race deterministic). The out_ep/f_audio_complete
use-after-free is established by code inspection.

Fixes: f3a3406b3f56 ("usb: gadget: f_uac1: convert to new function interface with backward compatibility")
Cc: stable@vger.kernel.org
Signed-off-by: Hyunjung Ko <hj351016@gmail.com>
---
v2: Completely reworked after review of v1 (which only cancel_work_sync'd
    playback_work in f_audio_free()). v1 did not address the more serious
    out_ep/f_audio_complete() use-after-free, cancelled after gaudio_cleanup()
    rather than before, and leaked audio->play_queue buffers. v2 implements
    f_audio_disable() to disable the endpoint, drain the work, and free the
    buffers, and corrects the Fixes: tag (v1 cited the file-rename commit).
    v1: https://lore.kernel.org/linux-usb/20261108075116.251501-1-hj351016@gmail.com/
 drivers/usb/gadget/function/f_uac1_legacy.c | 30 ++++++++++++++++++++-
 1 file changed, 29 insertions(+), 1 deletion(-)

diff --git a/drivers/usb/gadget/function/f_uac1_legacy.c b/drivers/usb/gadget/function/f_uac1_legacy.c
index 7c8d60c..0f937a7 100644
--- a/drivers/usb/gadget/function/f_uac1_legacy.c
+++ b/drivers/usb/gadget/function/f_uac1_legacy.c
@@ -697,7 +697,35 @@ static int f_audio_get_alt(struct usb_function *f, unsigned intf)
 
 static void f_audio_disable(struct usb_function *f)
 {
-	return;
+	struct f_audio *audio = func_to_audio(f);
+	struct f_audio_buf *buf;
+
+	/*
+	 * Disable the OUT endpoint first: the UDC gives back any outstanding
+	 * usb_requests, so f_audio_complete() stops dereferencing @audio and
+	 * no new playback_work is queued. Then drain the work and free the
+	 * buffers it would otherwise have consumed, before the function is
+	 * unbound and freed.
+	 */
+	if (audio->out_ep)
+		usb_ep_disable(audio->out_ep);
+
+	cancel_work_sync(&audio->playback_work);
+
+	/*
+	 * The endpoint is disabled and the work is drained, so nothing else
+	 * can touch the queue now; free the leftover buffers.
+	 */
+	while (!list_empty(&audio->play_queue)) {
+		buf = list_first_entry(&audio->play_queue,
+				       struct f_audio_buf, list);
+		list_del(&buf->list);
+		f_audio_buffer_free(buf);
+	}
+	if (audio->copy_buf) {
+		f_audio_buffer_free(audio->copy_buf);
+		audio->copy_buf = NULL;
+	}
 }
 
 /*-------------------------------------------------------------------------*/
-- 
2.43.0

