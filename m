Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.221.43
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793755706;
	b=Brof8YX0J3o/8miOPKPMUb8WVnTslHn4mJ6JrbmRGFI9tmqIWlh1wlTupoV1xXyuKyex
	 JGkfqfNRZsPHgg4Dpi9/7d3P8pGb+Fr0WqiY9hDPqlNTsWm7TVNG8mjvIsMURI3RVkNIu
	 0A4hln6MYN2sc8qEd+7y7rlQFuVt9LHYd2rNHUDgXV8+IT70OvXyDv8DmF94qkmrcK7W5
	 5oWJw1PCz0pVZW7bSwXPDBKBlRyWu6RAz7aWv365Moal5QWvEFLG2y4yliNZhFZ37441F
	 ucOulg0hvsGBJRt44HkqWpK215MYUake/47h71sMdDYRd7iHStswmOhCdoW1mZEO+hw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793755706;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:MIME-Version:
	 Content-Transfer-Encoding;
	bh=CEWS5O6NICxLw6C5QXAFqTMWmsO+xhOgA5e6wxAsh5I=;
	b=i8sFL29Kx/RNQExVfjH9/4iY04hCvXmMW3gWQn7LpJbl+oMt1UNuJBIJhiTzNcUtS+n0
	 ZN0HLduowgaPK/jvzGrcipaY+gtTRCP7+BLXVMeeER3YaCGjHp5N3iClGRpXb0bbeMSSz
	 KxuCrcK2ajFkAH53z2E8hOpauxLfe4efCMjx48WeOvmnIkUmEpLnT9IqgblX8jk90z8DE
	 /KX9x00FG/T3HQaBzEJBxPl+xzP1YqocgN+XQT9cEZcfS2ilXpQsg6mWMz9DBI7eMCPdf
	 uMKiLKitSuH9Yiijd+PLcva+jc/jFThzlGFK4dXi/SQg7ETzYL27knvtYY1SIJLGQFQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=HJhMxTyc;
	arc=none smtp.remote-ip=209.85.221.43
Received: from mail-wr1-f43.google.com (mail-wr1-f43.google.com [209.85.221.43])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 70B69606A32F
	for <stable@vger.kernel.org>; Wed,  4 Nov 2026 01:28:26 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 70B69606A32F
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=HJhMxTyc
Received: by mail-wr1-f43.google.com with SMTP id ffacd0b85a97d-48e10a70540so87750f8f.1
        for <stable@vger.kernel.org>; Tue, 03 Nov 2026 17:28:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793755705; x=1794360505; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=CEWS5O6NICxLw6C5QXAFqTMWmsO+xhOgA5e6wxAsh5I=;
        b=HJhMxTycCUfqPBAbNdRZq0fbvxLcBFVmpm5hNmv4XI85OBDknpn28HOhjyn6y+wipA
         7ZaleVLYsbr/Q3fg8neLy8Wg/iPAKLxTRUr6Akl9CY8JgJ8YdrZX2tpVyILH66KhQUDJ
         v7fw3y9y4flULZb3UJ+zvN7Pr9mH5UNIylfOsVNm5gUfoekVspPGrVbyquiLfqp1gkbm
         xxE6PjWSQWBpZfQm3eZ9RhEehwjYoZhYIC7mgyQnLRk8ZmziAWC2FcC3rV5e26YXNtT2
         fEddyhh6+d0MYJLF5GWE9ngWw7oEAW7+uMOaYUEZSK82fsJO8rsWgUa0hEK36NRW1Pdb
         t45w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793755705; x=1794360505;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=CEWS5O6NICxLw6C5QXAFqTMWmsO+xhOgA5e6wxAsh5I=;
        b=TKH68dc8b0maueFjlEjFh2LIsV/6cozGYMQ9mI+3/7a2d6ww1ws8EvhXOmLbJxQH6a
         qQw8clOSpTVU6YerPRHvvI8RAzbLumkj0ShVW3b9reOrrbDXAAvTwdNZSoEtJpcubgXf
         QJz/5bYkPA0hFVvjVuiHoZmWgQKwrHfSCarPPf/Y6rdYqvSLOYRyBM5UVaicY1ItDaym
         I+O2QZb8HBvCEcP9W2swQehXEYKFmE14KvyKMQU5uBDmgrbW+Ub7pFs7PRcF63i6Obr0
         KgKrWyhAyIB4Z1Jsjzfh1SSCQZLUaCIeaqjD6nUtpN6yc2bpD82eCvZp9b94DhstWiPV
         pVcQ==
X-Forwarded-Encrypted: i=1; AKwUvBw9JM8tNFpZjpjtj22DX8iGsUrF/I4EytdW0ru61XTkkKeOWEHJX3zSLQzv7mXUKQPfG5MUWXg=@vger.kernel.org
X-Gm-Message-State: APuU4Z8yZDZRtz9wJH+5PdJepf5ePC6u/jeoe95MnvhM02vWtT4II8Fl
	CComeVapA/JOvW2V0JNqQYNL+UZdfiNPRNzyQqvdzfC46/ECpoq/ddA=
X-Gm-Gg: AYBFou0JGi0+UJIC5Jfoh9CUPbLDCWdH8XmicHgAKxIUP2/q5fGFiOeN1DQ0KakaeCn
	vFl6xLSyD0g8S5TKhTVcjvXNZ0Rp1UZQgGj7Wg2zFEn4aJX11iVSKiRBBPrE2hsm1ZD3tuwjwCm
	k5mN8RdPW3xMOrZaEztbAm9FxdlNOUSEu6KR7vPX3nU+GJXaCIo8MJDwOeB+pUG0XmhqrFs08t9
	UhXaVf6GSXRK//nEgdsgMbI8444Mmy9xJoTF6Zk7/v9s8MXVkLdcUzmELWus9eb5VaHnV7ZJsId
	yi340WeK/pBuZd0NLVf/Aa5T79BjiTiB6efjSX5bgSTMKmCEcaCzrFJhHTQ6hIn58TM7zmzWN8R
	td7Wz89tUL1k+3lk9cHCcO7D6w0Ka+AiAVy0I2gtN3fRcA4lHBghOqCr4byx0dMUeRgh++Cs/CG
	g6bbvn8gf+lUnMacAIo5O5KmbyxDSfXw88E/Z7pGgqbBux6KC1uBXx4QdH8fBPmC4bX7xONEalg
	LNo5Igh5wiJwJ6siw9QcgDmqsYFelGXgPvChe3hopJA4QoJIKfY+bQLqEDhGCtkUE8HTvqMQw==
X-Received: by 2002:a05:6000:41c8:b0:48d:faa6:cedf with SMTP id ffacd0b85a97d-48e6e50645dmr33085390f8f.56.1793755704707;
        Tue, 03 Nov 2026 17:28:24 -0800 (PST)
Received: from debian.. ([2001:41d0:303:db6b::])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-48feda2007esm898557f8f.47.2026.11.03.17.28.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 03 Nov 2026 17:28:23 -0800 (PST)
From: Tristan Madani <tristmd@gmail.com>
To: Neill Kapron <nkapron@google.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Bryan Wu <cooloney@kernel.org>,
	linux-usb@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org,
	Tristan Madani <tristan@talencesecurity.com>
Subject: [PATCH v2] usb: gadget: f_uac1_legacy: cancel playback_work and drain buffers on free
Date: Wed,  4 Nov 2026 01:28:21 +0000
Message-ID: <20261104012821.3253258-1-tristmd@gmail.com>
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

f_audio_free() calls kfree(audio) without cancelling playback_work or
freeing the queued audio buffers.  If a playback work item is pending
or running when the function is freed, the work handler references
the already-freed audio structure via container_of.  Additionally, any
f_audio_buf entries remaining on play_queue and the partially filled
copy_buf are not freed.

Cancel the pending work, drain all queued buffers from play_queue, and
free copy_buf before cleaning up the ALSA card and freeing the audio
structure.

Fixes: c6994e6f067c ("USB: gadget: add USB Audio Gadget driver")
Cc: stable@vger.kernel.org
Signed-off-by: Tristan Madani <tristan@talencesecurity.com>
---
Changes in v2:
- Drain queued f_audio_buf entries from play_queue and free copy_buf
  before kfree, addressing sashiko-bot [Medium] buffer leak concern

 drivers/usb/gadget/function/f_uac1_legacy.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/drivers/usb/gadget/function/f_uac1_legacy.c b/drivers/usb/gadget/function/f_uac1_legacy.c
index 7c8d60c7e87d1..9fab3f9c8b9d6 100644
--- a/drivers/usb/gadget/function/f_uac1_legacy.c
+++ b/drivers/usb/gadget/function/f_uac1_legacy.c
@@ -942,7 +942,15 @@ static void f_audio_free(struct usb_function *f)
 {
 	struct f_audio *audio = func_to_audio(f);
 	struct f_uac1_legacy_opts *opts;
+	struct f_audio_buf *buf, *tmp;
 
+	cancel_work_sync(&audio->playback_work);
+	list_for_each_entry_safe(buf, tmp, &audio->play_queue, list) {
+		list_del(&buf->list);
+		f_audio_buffer_free(buf);
+	}
+	if (audio->copy_buf)
+		f_audio_buffer_free(audio->copy_buf);
 	gaudio_cleanup(&audio->card);
 	opts = container_of(f->fi, struct f_uac1_legacy_opts, func_inst);
 	kfree(audio);
-- 
2.47.3

