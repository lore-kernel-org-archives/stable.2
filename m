Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.172
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794144944;
	b=4aUOB1mF1Vq40KhsFEidNTBaGw8eB7U91YK8Y5i6y1r/yY0X2gkmENrVRixKvbxgQuBF
	 Us5yBDe/XxzcmFbSkCkypVfrDz4ZmShTHKGOmhd9nLvLFFGxLli+scr8Rtsa20EEF2ETy
	 QxodJw3u5DHq7YEBFNeWFqVGsnhTVZqFvaJtnkZknWrwW9lVkoT8FavIjzE0vrDXPARUL
	 QirwrsUY396pynwDz1Te671s1Adm/Td27+59S/95JVIIbZstSVPin5vyCbvZaWc1GHYim
	 U9ygvYVNy52QfCURjKg05K79pVB0SUofnMzy88DSh3AvI2KLhuzc0rCOg66wYH7H0lg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794144944;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:MIME-Version:
	 Content-Transfer-Encoding;
	bh=8Ng0uZYQ+LIwIwtwHGERv4b3yBKSq7JDf+ArUiIqJ40=;
	b=TjF/4naUL202jqdSvWKGrMnTP+cRYl21HutCA3goBe726nQs6ayd3SV9OzFvja+p8c3I
	 cbhiAtJM+ygelqaOwNiX8oxtVzB4+2k/VQubP3SvNZcvy0la9xJL0Cp2j4yQKLYO9g0e3
	 4PpMyNhzsbrgMvToZEQxYK71Wdzp1Qa5KUCZsCXqJKuMpcxxW+IS7eBdOf7YteDL85b/x
	 0pqzfIIo0VJxFVnkg27RKUeoRYraJdDEcq+Kc4+/pDJOinvmyUdKXaaBN48z0Lu73Tnrw
	 JvkMYgdxeD2CdUlkHkwZbmM+R5nZeufDFpOvXa8xdGGJ9uYRsUgM2E3tTY5/XuwwDFw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=QiOpTURZ;
	arc=none smtp.remote-ip=74.125.82.172
Received: from mail-dy1-f172.google.com (mail-dy1-f172.google.com [74.125.82.172])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D37C0606A323
	for <stable@vger.kernel.org>; Sun,  8 Nov 2026 13:35:43 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org D37C0606A323
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=QiOpTURZ
Received: by mail-dy1-f172.google.com with SMTP id 5a478bee46e88-3700ed8dbe3so258276eec.0
        for <stable@vger.kernel.org>; Sun, 08 Nov 2026 05:35:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794144943; x=1794749743; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=8Ng0uZYQ+LIwIwtwHGERv4b3yBKSq7JDf+ArUiIqJ40=;
        b=QiOpTURZzmEjqzsZNZGoZhVtaJpehNpJR2dhcXWm+iWH8i56iAlf8lXP5pYk4OInWA
         VSCvL1x8DzeVfP9rr4NJzSFnyr3RdAxa1QS0LYa4CKs1Aorp+qZHAZC6PgpX6aK8knZl
         /+5KIu+KCMFR4H+acsGttQkDkbA40xEMdDPAtc1VN+0qsbHNoc/05W3Lxp6sSTHCMNTp
         yopzT2st7Y3BCgbhcacd2Hz1dWMVoNKI9COGbMV1WbP27UGlvpsl7xJLMrATltAx26hn
         zycTVLaKC56zOhcssbzpE+ht1YasA4C91eJ0PjEerjFYFMn/p6q4KyY/0x73pkgOduHl
         FPTg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794144943; x=1794749743;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=8Ng0uZYQ+LIwIwtwHGERv4b3yBKSq7JDf+ArUiIqJ40=;
        b=dDtuohtOhTPXa7DnYCLVatQpUrCueV+SkvvTIivv9Ss9WAmiuRrM0SulXiuP3Z+Mor
         WeDVeIx7fXQzbkhVexEWjuTRxLdunmMs2GVPN1Uu9svJxUWZjtmmGnQPa7e/sOPDgCSp
         dSIJ2AhHc/SuFwMK3O+eVVqkYpXnh+oJ8XDnkdchTE6sTOyXT+kcAi7nHIqsXAtbnmX2
         oESPfUJiHw1eJNw24M4uLuUUp13IXL3UmyjgBS+tr+JD2ekSwq0NgImcWKTT70bBkevz
         qMbo7X2oZ8ukL3aZCKhI/rULXBSQkUNAGqINApVCiUz5zIC/LqIVAF9LcpeQVXD9oIbW
         eP7Q==
X-Forwarded-Encrypted: i=1; AL+hErGArxX0sGaM1NvJc7RthJ7fiNdsdnPW6vw3EPAVmV7j7SgRH/6c6L+OBDyN/G2weCeFx+Pl0TU=@vger.kernel.org
X-Gm-Message-State: APuU4Z9pLw5r4GePN/nI9FYeeERnOSJM3ITyfUB80W3bIJkU8N11S/p3
	RMGgAHh/fX3oTcvjCOhPIWol97U1JLkcKKs/hREebbx4Kdj/rYsT7KL8
X-Gm-Gg: AYBFou2bhAmfa6VZfNjCayjxRzpDaMH0xUABkZeVL/Dsnck1eaGfr3Nfnu8h4G0X874
	UFwikFhQ0fxiMCDjFCSVrIllLk0eQrngWFeQYsQfBCxxMUZpmjmSp1Ddbo0MDJoQeDrckaF7NpT
	+yaa1/UYVR9p7+9dBcRVnh9mEJeZ5rdzCwpiAw62FsLOtj6W8xhl0evL95s4auJCI1TwR/oy8VN
	zd8pwrq+m4EP7i8nLPlRbU0ziPCD3XoqphtQWKGwiefD971EhDlNkRLAmIZVyGfaKIhERgiuTVT
	CqOJe1UMMQ/vDHSeZVGMJev1fWqDeG/XyUyj/GAL3lWV9bFViWCcVSizqT5KHcLLWd6gtYUrVLA
	qWyTlJtI8uEUmDPJVWuJ2Q354eVZVG9lQRXuylZkHv6JhELmV42c15c74Kv7RTgmVsJtF5agLDV
	Can6/BDKjRbA6bbWBT4P8xtY+KGECaoOPDkfRQOYF4Av+W+NrdIK8nZJfl5FnicX82pVFaph/3r
	QaM4SLJJburt49ZCHL/hi2BKI8Nlvy2Wz8mQapt8lJqI3GWHt+cWjLmVstTDhBqA9u16pbBD7NI
	pWSviz+KCTHi0GC8Z4r0uztDPJ8LrfOQE9bi//kSupOCxT0G
X-Received: by 2002:a05:7301:6701:b0:36a:79e7:2fd with SMTP id 5a478bee46e88-3725f010ed3mr3895058eec.40.1794144942126;
        Sun, 08 Nov 2026 05:35:42 -0800 (PST)
Received: from hj.. ([163.239.22.29])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-37265a16c49sm5239413eec.10.2026.11.08.05.35.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 08 Nov 2026 05:35:41 -0800 (PST)
From: hyunjungg <hj351016@gmail.com>
To: Neill Kapron <nkapron@google.com>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Ruslan Bilovol <ruslan.bilovol@gmail.com>,
	linux-usb@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org,
	Hyunjung Ko <hj351016@gmail.com>
Subject: [PATCH v3] usb: gadget: f_uac1_legacy: disable OUT ep and drain work on teardown
Date: Sun,  8 Nov 2026 22:35:32 +0900
Message-ID: <20261108133532.532633-1-hj351016@gmail.com>
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
audio->playback_work. However f_audio_disable() is empty and nothing
disables the endpoint or drains the work on teardown, so:

 - f_audio_complete() can run after kfree(audio) (the UDC gives back
   pending requests on the still-enabled endpoint during unbind), using
   freed memory -- a use-after-free; and
 - a playback_work still pending runs f_audio_playback_work() against the
   freed f_audio -- a second use-after-free.

Disable the OUT endpoint in f_audio_disable(): the UDC then gives back the
outstanding requests, so f_audio_complete() stops touching @audio and no
new playback_work is queued. f_audio_disable() runs in atomic context
(reset_config() holds cdev->lock), and usb_ep_disable() is safe there.

Drain the work from f_audio_free() instead, where sleeping is allowed:
cancel_work_sync(&audio->playback_work) before gaudio_cleanup() tears down
audio->card (which f_audio_playback_work() -> u_audio_playback()
dereferences) and before kfree(audio). The endpoint is already disabled by
the time f_audio_disable() has run, so the work cannot be re-queued and
cancel_work_sync() is sufficient.

Found by static analysis and an automated reviewer; the playback_work
use-after-free was reproduced with KASAN under dummy_hcd (slab-use-after-
free in u_audio_playback() from f_audio_playback_work() after
f_audio_free(); a delay was added to the streaming path to make the
schedule-vs-free race deterministic). The out_ep/f_audio_complete
use-after-free is established by code inspection.

Fixes: c6994e6f067c ("USB: gadget: add USB Audio Gadget driver")
Cc: stable@vger.kernel.org
Signed-off-by: Hyunjung Ko <hj351016@gmail.com>
---
v3: Fix the v2 regressions found in review:
    - Do NOT cancel_work_sync() in f_audio_disable(): that callback runs in
      atomic context (reset_config() under cdev->lock), so the sleeping
      cancel would be a sleep-in-atomic. Only usb_ep_disable() (atomic-safe)
      stays in f_audio_disable(); the work is drained from f_audio_free().
    - Drop the play_queue/copy_buf drain added in v2: audio->copy_buf can
      alias a buffer already on play_queue (f_audio_set_alt altset 0 queues
      it without clearing the pointer) and can hold ERR_PTR(-ENOMEM), so
      freeing it there double-freed / dereferenced an error pointer. That
      buffer-leak + copy_buf aliasing is a separate pre-existing issue and
      is left for a dedicated fix.
    - Correct the Fixes: tag to the original driver commit c6994e6f067c.

v2: https://lore.kernel.org/linux-usb/20261108122645.421721-1-hj351016@gmail.com/
 drivers/usb/gadget/function/f_uac1_legacy.c | 21 ++++++++++++++++++++-
 1 file changed, 20 insertions(+), 1 deletion(-)

diff --git a/drivers/usb/gadget/function/f_uac1_legacy.c b/drivers/usb/gadget/function/f_uac1_legacy.c
index 7c8d60c..c07f323 100644
--- a/drivers/usb/gadget/function/f_uac1_legacy.c
+++ b/drivers/usb/gadget/function/f_uac1_legacy.c
@@ -697,7 +697,17 @@ static int f_audio_get_alt(struct usb_function *f, unsigned intf)
 
 static void f_audio_disable(struct usb_function *f)
 {
-	return;
+	struct f_audio *audio = func_to_audio(f);
+
+	/*
+	 * Disable the OUT endpoint: the UDC gives back any outstanding
+	 * usb_requests, so f_audio_complete() stops dereferencing @audio and
+	 * no further playback_work is queued. This callback runs in atomic
+	 * context (reset_config() holds cdev->lock), so it must not sleep;
+	 * the work is drained from f_audio_free() instead.
+	 */
+	if (audio->out_ep)
+		usb_ep_disable(audio->out_ep);
 }
 
 /*-------------------------------------------------------------------------*/
@@ -943,6 +953,15 @@ static void f_audio_free(struct usb_function *f)
 	struct f_audio *audio = func_to_audio(f);
 	struct f_uac1_legacy_opts *opts;
 
+	/*
+	 * The OUT endpoint was disabled in f_audio_disable(), so no new
+	 * playback_work can be queued. Drain any still-pending work here, in
+	 * sleepable context and before gaudio_cleanup() tears down the card
+	 * that f_audio_playback_work() -> u_audio_playback() dereferences,
+	 * otherwise the work runs against freed memory.
+	 */
+	cancel_work_sync(&audio->playback_work);
+
 	gaudio_cleanup(&audio->card);
 	opts = container_of(f->fi, struct f_uac1_legacy_opts, func_inst);
 	kfree(audio);
-- 
2.43.0

