Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.128.51
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793796830;
	b=d+nE7HuXS3GIt4OmE2CA9VjAEkuoIukTcf3KnafdO1Skwe77IUVvVzN40mPO8OTJD/HP
	 ed35b4BxiM/EGcRvaaX/lgKfoMB0tmGQSW8M2CS372L/RBAwhZnKtTUDSLCUSTbtA1+4N
	 7s1GOwJw+6AS/ncm/KXmpJJ2LqToDiyYEExtcUhEproMZPNHo/bTCF8lCWwb2YiNhrbGK
	 R3Njrkk7wAJ+dYh99S6LIcMCJcNmO/9HGfPwvC9aJu2t4xbxOTGr9X7ShMSCnWVIdYudU
	 Am1buNyNmDnPN5auZxaUaVCVixIgLetvb10y+Ot6EJqsCBF0CxFt30Wl+oubCawIGaA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793796830;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:MIME-Version:
	 Content-Transfer-Encoding;
	bh=dQeDBQaYC+1E6SoUX0OhszHMVcEGeNK258dKX42ECfg=;
	b=g9TmMjdrihkkrY3OirVEKED9It6qeo4lZXun5hNRDk6AuUgngGMAfLBARNEm/N3Nw/rE
	 pDejqDB2fZbjcw1OTcAlFUHbteMBpX09MPppUFqbNr/KP+tDoSJ3s0J0AXeOt5iZ/jOs9
	 yChef/38qZm1aPvMQROxkA8mLc2J5PqHZXNY/fW1GyKqEDdW+mqnEyTWSNYpYEnekTUml
	 8qNZCpdN0Lg/23RpOfx4Sa3nxLnV5H0d2pQR6xLSKqUhYuedr+olwN4Z/9FYzqE4pOfjv
	 O3ygZcojJ9ahQbUhnFJAcBwgH0Z+ecfCCafSr5Mc8jishVZWQhQGdez0JUAKZEJeT0Q==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=ktj6KEmh;
	arc=none smtp.remote-ip=209.85.128.51
Received: from mail-wm1-f51.google.com (mail-wm1-f51.google.com [209.85.128.51])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2A395606A328
	for <stable@vger.kernel.org>; Wed,  4 Nov 2026 12:53:49 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 2A395606A328
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=ktj6KEmh
Received: by mail-wm1-f51.google.com with SMTP id 5b1f17b1804b1-4a5720b0a57so10970525e9.0
        for <stable@vger.kernel.org>; Wed, 04 Nov 2026 04:53:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793796828; x=1794401628; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=dQeDBQaYC+1E6SoUX0OhszHMVcEGeNK258dKX42ECfg=;
        b=ktj6KEmhxJq+o87tNkdrmYXGC9amk6JOz3ljdSX1WzIhRfgngzc37yG2WgN/Ja+mma
         sjb1Pj1VVgDIGAeU3jVjDpSy2c+UCJAwaOw5lRAeTZfciJVMWumqKs5hMBzailPuw/IN
         1/vwZDsVHMqaWyKkyH3MpLwxjuaTCIAVqaBNX8ao7C3EOX6+Vl7IbEUzUwIW19XNRXHx
         aFIE6zaYgiS0GijcvL7f5PDV4DRRT09SeIjMz+o/gt787si5s1hRlFOX0Q+3ypcDN6DG
         SYDZKInFvulyn+Je5vEd87dGziD/MagyvXSAJCjeuISUu4sA3A7Ws7dUukXg1wmz78/6
         7psQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793796828; x=1794401628;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=dQeDBQaYC+1E6SoUX0OhszHMVcEGeNK258dKX42ECfg=;
        b=ct6+vJaySOcStz44mTzwIJpUtWfkBPDDGJoQDBuNjXXD7w782o98+n19eDPly/7MUy
         807YFz2MfoDAD93EztPMzDPJ9Ug+auSBcojqqCS6bTmfhXwbMRBbaubehKaYOVfkyuPc
         p/3dGTRGsrQDhEtWQtxjNqlY1JSLYJttPzLJpq0ALUnw5dfpw1LhmJr6bGgsgsY8DFkw
         gwCQq4uKqbdTkRZFaqVEVXj9LzkPdyfUnWZTI08lIAuAf4o4DRAu02NVFJBAzKTFohvb
         ug+F2q2dClkBmPzLzMaTLVE50i+b8RFZ7kEBsMl0B1C+dwZBvisGL0a1B5E/h6QmIrVP
         NJqQ==
X-Forwarded-Encrypted: i=1; AKwUvBxSNmZ8AEIO//x7srbLhTcyJvoOS4oBU7VmQBrgq/suvy2+GeJ5IRpAR0k6ydoPLXmqz+GlDH4=@vger.kernel.org
X-Gm-Message-State: APuU4Z+gUFgaxRiyUiVLiRZBml5x2SNV6ytZP3u74mrDjLPXWSlmDtwz
	2vA6JOYETBHSCgV+MLbU9bpBLY2Hg3E7Uwmkxe0DzNSQPWzcAiVvDGM=
X-Gm-Gg: AYBFou2grbZOpyu2beEORyfTIopYi8nZeHW/FWW3D6QnjHbw4ebaGP3IkjT40ekxdCk
	bepz3B+bjpAoi/zMdL/x5bAwN1vTpydS4mrQiWVrpjM+8q92B/s6CKHi0H3fZDkeyvHz6wm+f9/
	he4RSQKCVDJY8H0bgmJNKCOOHKnkW77MYGe4TMmRKdtGPfxVZ1Li7w4eYfxKu/O1iiunr3+wSt4
	SsWhQ5SaD8wBqO5qJspduQjUmOhF5fRlYLQcuQFbj3QKYVzigw3Jq1tWrXuHjJxn7oohKnToBO8
	L5I3fCwylPdwkk9XiAZVvlFhy8FoKXTZlgFDtHzmgNTU65pkRdnydgJQc0Ch6waBQLokWGnyf8O
	YSrpuRPlOc0HrGOxCHigpNJ86U/YjA8bx31wck3Krf17fE8AxykuitP2y9CNYg0OlMzDnmPLRrA
	gu31GH7wypKqTUPyWc373Q1t51XI92p6kxvOf1qxiPDh3PXEnvt6S9q81CPTrQpbeeUC4WxfqVq
	MJljG1/sw3/t4h+dXfD42zz2fgkN+vxdV//0WKESJ0IMcTzIl2wQ5+dXHdCYfXSZ1UuRqtMOg==
X-Received: by 2002:a7b:c051:0:b0:4a1:d766:758 with SMTP id 5b1f17b1804b1-4aa8b0609cfmr358227225e9.16.1793796828290;
        Wed, 04 Nov 2026 04:53:48 -0800 (PST)
Received: from debian.. ([2001:41d0:303:db6b::])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-48fec8d8748sm3810754f8f.16.2026.11.04.04.53.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 Nov 2026 04:53:47 -0800 (PST)
From: Tristan Madani <tristmd@gmail.com>
To: Neill Kapron <nkapron@google.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: linux-usb@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Tristan Madani <tristan@talencesecurity.com>,
	stable@vger.kernel.org
Subject: [PATCH v4] usb: gadget: f_uac1_legacy: fix copy_buf lifetime on queue handoff and free
Date: Wed,  4 Nov 2026 12:53:46 +0000
Message-ID: <20261104125346.2552742-1-tristmd@gmail.com>
X-Mailer: git-send-email 2.47.3
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

From: Tristan Madani <tristan@talencesecurity.com>

f_audio_free() tears down the f_audio structure without cancelling
playback_work or releasing audio buffers.  The pending work can access
the freed structure, and queued audio buffers leak.

Additionally, f_audio_set_alt() and f_audio_out_ep_complete() transfer
copy_buf to play_queue without clearing audio->copy_buf.  When
playback_work later consumes the buffer from the queue, audio->copy_buf
becomes a stale reference.

Clear audio->copy_buf when its buffer is queued to play_queue, so the
pointer reliably reflects ownership.  In f_audio_free(), cancel
playback_work, drain the play_queue, and free copy_buf when it was not
queued.  Use IS_ERR_OR_NULL for the copy_buf check because
f_audio_buffer_alloc() returns ERR_PTR on failure and f_audio_set_alt()
stores the result directly in audio->copy_buf.

Fixes: c6994e6f067c ("USB: gadget: add USB Audio Gadget driver")
Cc: stable@vger.kernel.org
Signed-off-by: Tristan Madani <tristan@talencesecurity.com>
---

Changes in v4:
- Fix the root cause of the stale copy_buf reference: clear
  audio->copy_buf at the two sites that transfer ownership to
  play_queue (f_audio_out_ep_complete inside the spinlock, and
  f_audio_set_alt alt 0) so playback_work consuming the buffer
  can no longer leave a stale pointer (sashiko-bot)
- Simplify f_audio_free drain: no buf == copy_buf comparison
  needed since copy_buf is now reliably NULL when its buffer
  is on the queue

Changes in v3:
- Guard copy_buf free with IS_ERR_OR_NULL because
  f_audio_buffer_alloc() returns ERR_PTR on failure (sashiko-bot)
- Attempted to detect copy_buf during queue drain, but that
  missed the case where playback_work already consumed it

Changes in v2:
- Added play_queue drain and copy_buf free (sashiko-bot)

 drivers/usb/gadget/function/f_uac1_legacy.c | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/drivers/usb/gadget/function/f_uac1_legacy.c b/drivers/usb/gadget/function/f_uac1_legacy.c
index 7c8d60c7e87d1..cba7b447b09e3 100644
--- a/drivers/usb/gadget/function/f_uac1_legacy.c
+++ b/drivers/usb/gadget/function/f_uac1_legacy.c
@@ -9,6 +9,7 @@
 #include <linux/slab.h>
 #include <linux/kernel.h>
 #include <linux/module.h>
+#include <linux/err.h>
 #include <linux/device.h>
 #include <linux/atomic.h>
 
@@ -338,6 +339,7 @@ static int f_audio_out_ep_complete(struct usb_ep *ep, struct usb_request *req)
 	if (audio_buf_size - copy_buf->actual < req->actual) {
 		spin_lock_irq(&audio->lock);
 		list_add_tail(&copy_buf->list, &audio->play_queue);
+		audio->copy_buf = NULL;
 		spin_unlock_irq(&audio->lock);
 		schedule_work(&audio->playback_work);
 		copy_buf = f_audio_buffer_alloc(audio_buf_size);
@@ -670,6 +672,7 @@ static int f_audio_set_alt(struct usb_function *f, unsigned intf, unsigned alt)
 			if (copy_buf) {
 				list_add_tail(&copy_buf->list,
 						&audio->play_queue);
+				audio->copy_buf = NULL;
 				schedule_work(&audio->playback_work);
 			}
 		}
@@ -942,7 +945,15 @@ static void f_audio_free(struct usb_function *f)
 {
 	struct f_audio *audio = func_to_audio(f);
 	struct f_uac1_legacy_opts *opts;
+	struct f_audio_buf *buf, *tmp;
 
+	cancel_work_sync(&audio->playback_work);
+	list_for_each_entry_safe(buf, tmp, &audio->play_queue, list) {
+		list_del(&buf->list);
+		f_audio_buffer_free(buf);
+	}
+	if (!IS_ERR_OR_NULL(audio->copy_buf))
+		f_audio_buffer_free(audio->copy_buf);
 	gaudio_cleanup(&audio->card);
 	opts = container_of(f->fi, struct f_uac1_legacy_opts, func_inst);
 	kfree(audio);
-- 
2.47.3

