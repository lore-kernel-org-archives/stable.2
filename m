Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.221.54
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793792711;
	b=SDAxJQzSPA25bQic+pdmk3HCkqzX2MsfflyKqYaO7seIzH1ozWC5E849FpJufpVhQ5HE
	 OsZXH6zu+Odnwh2KHPVa8+9VevlJnI5hG21QwXQ0cvVgHS7BpvQE1sBg9QG6EFbu6/ZW8
	 cV1YvrGP/ARRQe9C7rqE7aleEU0MomsSoqZXIAkiiY1WjcbDkNUiCxounXIK3p3eZ5/YD
	 PG0NdscmZLWmpKbaFvzT5ZV9e4yGe2lUc2IzITmboEMeSa5AUoUT3vX19QvgiBJTiro6B
	 kwSpUOZUyttAmUQQ0W04z4mHFJgOZJk9d3koPaHngWy7ivse1RzttQHHyYCDe/GKl+Q==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793792711;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:MIME-Version:
	 Content-Transfer-Encoding;
	bh=Fwmi2BanXdLKK6Q5fiHKOWwPdRJTU6INzhuG9S9OW0U=;
	b=Olln2VwsEZnfylnziJ+mt+16ERR7iTaqCwwbnQz6ChLE08+YhJI9OxBBeu17Ve3nv93E
	 XASmMGNVl/iYKQgVF46cgGj5s2l6g4+NDbFQrsj4kRdO4ijkU3kfLmkIozeUDrB3w5+I7
	 4PSGxvUWgnt2O70+RBpCkqrdl51kJtgSufrJ3Gw7t42opNevXd8AwpOD83DqLB21LoEIq
	 xl7J2/hzdK3O/KpoWITjqvlhvRuEnKnBwM/H+hiR8KMGeQp/kAioJITakGYyIgV8Ge3cJ
	 23aILsYCsXjAJSwPGPJFjXoUJ7KXcF2RpfI4CDM3Ewk0qlfIS9exO9WfOzy2pSPdYCw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=mxJzikPN;
	arc=none smtp.remote-ip=209.85.221.54
Received: from mail-wr1-f54.google.com (mail-wr1-f54.google.com [209.85.221.54])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A91AB606A32D
	for <stable@vger.kernel.org>; Wed,  4 Nov 2026 11:45:10 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org A91AB606A32D
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=mxJzikPN
Received: by mail-wr1-f54.google.com with SMTP id ffacd0b85a97d-48e0d1c095dso319778f8f.1
        for <stable@vger.kernel.org>; Wed, 04 Nov 2026 03:45:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793792709; x=1794397509; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=Fwmi2BanXdLKK6Q5fiHKOWwPdRJTU6INzhuG9S9OW0U=;
        b=mxJzikPNMzjmoiEyvS16txFYybRJZhTlonxyZaPZM6I6X8xGByAxGrWpT/B6UGGNAF
         /RSQ+jU1/C8iqEkea+iGqkHBXthsI1ASf+0RcfVFeCb81OelVQh55ah0ForS/wFZQ2SN
         ECQVB6u0GMGDTK3fbdujGGBLfWxnePTp9gQ/8oKw6M6ifXEldpj84HSWBLP43029q/uj
         9DiKo8CM3si6aOXO+zfJkZXA2SNHFC4tCK8rCbL8mD8R2Pk8D3kXDKcPe11IlNymP+zJ
         z4PGDmfrMEZDpCJgjiqEG6DUZYh28Aaa5+W3K7e+ijgM+yafLesL4to9d3RQrVr4CH9l
         m4jQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793792709; x=1794397509;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=Fwmi2BanXdLKK6Q5fiHKOWwPdRJTU6INzhuG9S9OW0U=;
        b=FzNMqkFt8mdDTsfNSx4nOOzSQ86MovnnvVFKw/s2+/nCk94SdjC51aK8bDp1OASJVO
         ZeDzOEZOFSG1ce8qprTno9CvK3P9+Y4Mujvq9/wluoECM3xFOHh7Ssm6zE4OtQOyZHYd
         tKDD9qSD7KAWQjv/NmhmMeXFRxuNaonUVqA5NsFkRdY55hvWONtUuJ6uk9sK6rHWO0l8
         90u3AFlUMdISltIYXlcrVFH0dh/IBPdZdogLm/hVmKJL4atAJLYQtklYKDyO8jtd59da
         fybP+d9jRsG4P223b6EAKV0esteO5m1nDOdvFRFM7HQhUFvjol81SXGrqhvO7nlzVif4
         xTTw==
X-Forwarded-Encrypted: i=1; AKwUvBxRMBlPwLw8AWMNIutfKQVV3HzNPOPKbo5SQkTmnMgJhFwEL58SQBdxGIVFuEr5DaMbDKZ1K30=@vger.kernel.org
X-Gm-Message-State: APuU4Z+UodnGx1FALsdrwZuKVMYndl9aryOHV5xbipGg5W80LZIldVv0
	3MkqGAzd7HR73NQ2vn+SuhUe+II73XZoS7nhK11/5bWHVV0RnLIGoiY=
X-Gm-Gg: AYBFou25M+yp6LVh5e1dOqoyrw3u9xV7/AVWqbuHMvczilcADM0Nu99CI7ZzHcle71j
	A0Bv9qPsonaulfY4dKn0OQCvHdsQeB+30ggh13pQoHKsh0nOQtcavfkqJf88w2IgMRelN7EnTv0
	wqiFIEB9+fxWDTDJPBjfixeJNn1Z21Z9k/W7MDynlfwbWIg4t6ZgW9JEyzcx0Hf1+qFYUT9cCfG
	VVMh758PglVIoVwQT52IMDuGvHZy44rbWsBO6zr260bXWHKQxEPUQzaB5PWo+7DcaZm47s0o3nP
	7InILr3pWTP73F5FEOnGIypF4eB72SjPh+TZGexSC6rcgZz0QHkSc1AiabObiDgAKqT7GJ+6mpH
	QDKuDeCz5hJnV+fHrjPZPK/BhkSSnNwyZXYkLL22pqR5l4o8wJ1Xos0+Z/2zJ+tLlwm4ABU+F4k
	sJFeWksPGY+1SmtUGhL/2XO0EWEP6Exx5nqQhQzevavTJ0bpvNQJdMqImTobF1pzY0eQVo7x5JF
	33ssTWiDibUo8N5YogbzDYIT5ol8gDL/DHHnHLXuTJ83/c8F/sStXfo7xCjX4Yapyq/TLGYTA==
X-Received: by 2002:a05:6000:25c3:b0:48b:db7:86a7 with SMTP id ffacd0b85a97d-48e6e517f2bmr32360828f8f.50.1793792709001;
        Wed, 04 Nov 2026 03:45:09 -0800 (PST)
Received: from debian.. ([2001:41d0:303:db6b::])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-48feda207d8sm3265405f8f.52.2026.11.04.03.45.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 Nov 2026 03:45:07 -0800 (PST)
From: Tristan Madani <tristmd@gmail.com>
To: Neill Kapron <nkapron@google.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: linux-usb@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Tristan Madani <tristan@talencesecurity.com>,
	stable@vger.kernel.org
Subject: [PATCH v3] usb: gadget: f_uac1_legacy: cancel playback work and drain buffers on free
Date: Wed,  4 Nov 2026 11:45:05 +0000
Message-ID: <20261104114506.1596023-1-tristmd@gmail.com>
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
playback_work or draining the play_queue.  The pending work can fire
after the structure is freed, and queued audio buffers leak.

Cancel the work, walk the play_queue to free every queued buffer, and
free copy_buf when it was not already queued.  When f_audio_set_alt()
is called with alt 0 it queues copy_buf to play_queue without clearing
audio->copy_buf, so the drain detects this and clears the pointer to
prevent a double free.  Use IS_ERR_OR_NULL for the final copy_buf check
because f_audio_buffer_alloc() returns ERR_PTR on failure and
f_audio_set_alt() stores the result directly in audio->copy_buf.

Fixes: c6994e6f067c ("USB: gadget: add USB Audio Gadget driver")
Cc: stable@vger.kernel.org
Signed-off-by: Tristan Madani <tristan@talencesecurity.com>
---

Changes in v3:
- Fix double-free of copy_buf: when f_audio_set_alt(alt=0) queues
  copy_buf to play_queue without clearing audio->copy_buf, the drain
  now detects this and clears the pointer before freeing
- Change copy_buf NULL check to IS_ERR_OR_NULL because
  f_audio_buffer_alloc() returns ERR_PTR(-ENOMEM) on failure

Changes in v2:
- Drain play_queue and free copy_buf in addition to cancelling work

 drivers/usb/gadget/function/f_uac1_legacy.c | 13 ++++++++++++-
 1 file changed, 12 insertions(+), 1 deletion(-)

diff --git a/drivers/usb/gadget/function/f_uac1_legacy.c b/drivers/usb/gadget/function/f_uac1_legacy.c
index 7c8d60c7e87d1..88c816b4ba119 100644
--- a/drivers/usb/gadget/function/f_uac1_legacy.c
+++ b/drivers/usb/gadget/function/f_uac1_legacy.c
@@ -9,6 +9,7 @@
 #include <linux/slab.h>
 #include <linux/kernel.h>
 #include <linux/module.h>
+#include <linux/err.h>
 #include <linux/device.h>
 #include <linux/atomic.h>
 
@@ -942,7 +943,17 @@ static void f_audio_free(struct usb_function *f)
 {
 	struct f_audio *audio = func_to_audio(f);
 	struct f_uac1_legacy_opts *opts;
-
+	struct f_audio_buf *buf, *tmp;
+
+	cancel_work_sync(&audio->playback_work);
+	list_for_each_entry_safe(buf, tmp, &audio->play_queue, list) {
+		list_del(&buf->list);
+		if (buf == audio->copy_buf)
+			audio->copy_buf = NULL;
+		f_audio_buffer_free(buf);
+	}
+	if (!IS_ERR_OR_NULL(audio->copy_buf))
+		f_audio_buffer_free(audio->copy_buf);
 	gaudio_cleanup(&audio->card);
 	opts = container_of(f->fi, struct f_uac1_legacy_opts, func_inst);
 	kfree(audio);
-- 
2.47.3

