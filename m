Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.174
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794124292;
	b=1DEDjqwjDuLvk6tGQdi3CPsPviVFISPLhCWIlEg7gJ6gwQlSv4cUDPVQJHMvWWHomU2p
	 GN6dVkYmOlE5yHfFgKQLVqravjeyjj8EjY2xAW7AOj0BouCfiUurqeGpBriLLXFjh9F7+
	 P/RsfjdRGxKMe0mHVJGxCHENDoYd5ETW/X5EtvgBdngQwFYFoEG0zoSJ1i0KNTUy0AV2u
	 3FzXZLpQrqWuwQoC99WeyvdJz6EPV26YVXi/Ozfbb4W2oCUjFWIXSjlR3ODkvseFO3D5L
	 cfkvVdRW6zDG9itey+gTRPNVfWC4hEzouzkB4sOgMZSuCGvOQl5mzvoUsfm6iE6VEqg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794124292;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:MIME-Version:
	 Content-Transfer-Encoding;
	bh=nAolJ4zrHlGn8Rop6XJv9YeUU1fj1l2rVCM3Mny8M7I=;
	b=TzchRkUA+rlJgZV26XQsl4Q6IWvEpZQ2y+wSjgMuawTd2W5jcmImDK9ETlY0ILM/jjFe
	 HU8gpSoSF72c2tvn0gV4s+JIC9I9qQkN2uBQGBJBY/PkpKADbU0kQaZ6lhKn/aWMmdN39
	 mUDjmKPoaWiH/e77MrbKbkRtRrF+BnEPlEQxvicwjsCgPVw1gQIKMphqGuf723sJCg+hr
	 kyIMwga32nxzNR5Z2zZuQs5s3GW8qJHQWLT0g85mfEwVwQAaC1hMwT7iW9kmUFBatwbtS
	 fMm6TaANzZO8sOKcXLrX0LH30tatmK3R9lMKTolAMRZdskbSe0KbgMyv23goWSXxVmQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b="x/5/dbHb";
	arc=none smtp.remote-ip=74.125.82.174
Received: from mail-dy1-f174.google.com (mail-dy1-f174.google.com [74.125.82.174])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5D031606A322
	for <stable@vger.kernel.org>; Sun,  8 Nov 2026 07:51:31 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 5D031606A322
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=x/5/dbHb
Received: by mail-dy1-f174.google.com with SMTP id 5a478bee46e88-36f8cdd30beso672516eec.1
        for <stable@vger.kernel.org>; Sat, 07 Nov 2026 23:51:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794124290; x=1794729090; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=nAolJ4zrHlGn8Rop6XJv9YeUU1fj1l2rVCM3Mny8M7I=;
        b=x/5/dbHbTtV3HzASC0mSTL6DCkKTqJmhN0woh9gHzab72ecWApO97cGLZbtOzsx5Wq
         Drdpr33yCVYl3pf5qHuHgHHxIsWAzuW5gd39HtpPd35teYSnYvdvp3TvP9NDICzy1YhR
         94U9qWczgdFTmaqEAue9gSPLqTeMUia+qAiWIZUANv2f/A0Bc3P+FbfTwTNW2JKOHv8X
         G2UbdtG+OaFou3O4xCQPRzN3poPeWy7zMVjbUfMsOQNCdxDPaYpuxrJZyS7uZhI9Zmzr
         ITBQU7XLcgNpqNXJj7pV/XDmFZD4wbLFwIlT5OlZjmfSJ/Ii+3m/Vq5l2JsH95yThOnG
         Jqhg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794124290; x=1794729090;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=nAolJ4zrHlGn8Rop6XJv9YeUU1fj1l2rVCM3Mny8M7I=;
        b=EX+3+OIztv3Z3RVPKoBkpN7oIH3ioCxlka7m4RLXc8C9a/gfVfjJNhQf9fr5Y/JyJL
         Bh3p12+T9g6sXh9ptQ9o1HfKxf/manQ7WyE0t4JZVHbulQdfbMPBIGjAStdIn8p92zft
         TeWyvGwgFJhK6ZSsfWL9cEoSEYvRD8n1RZlhqy1G1j0UyD5K1ZPGFRF9+f3t9jA6MPva
         E2M4q5cmayQRtxFln1hX5HdVYoEh2wtCYBOcSmhskd7fWXhjRlGyczjplL/Zf8aD897k
         IoKUPDnbPCg0cLhgbXbabw16NBs2TvFQkZ4YacE3MhfWfBT1DMVA7fhqjPSpxjLWqF0V
         o0Yg==
X-Forwarded-Encrypted: i=1; AL+hErFWiCK6iJZLeqEAHdegHX3FqDrB61Ynn3fP4uhhkSVlxOkoYxxvnNdHOwUWs8E7vIerPGgC4A0=@vger.kernel.org
X-Gm-Message-State: APuU4Z+l5hZ+UhefUzsM4iQhO2h5B9ogwY6zI0HVRFzjgLes2uMMLQo3
	3kDCfJEOnGHB53vEMATEHD0oXglM21Zx6iCjY1ozdqTTRCc/FCCV9yUJ
X-Gm-Gg: AYBFou2QqGGc138CcoxiCsjhM8DS9KewK7lkEhGsqF8IVYtFxoGNlmnUMZfe+wv32vX
	mjKkUAF7WjYy+q4TDa4Ha6xWejhV9y/4uRH6yp8+QyBfrhb8Aa6oyJvLmgxpuPLJySDK1ZXUbEV
	8aITgtL6TM40gdKkKvn4Djeh/DsCyaG7Ukl0TPiaEorcT2OfWeAZ4Pfxa0BoquHVtAEbtwdh+UK
	v/nVl/G4ZDvqLdAoBFlOwTKoO1v5PiApgd2LRyTTlNADqIcYPXsHCgB9jEiDLEx8PW7igPnt8Sd
	24JVM2tZGMokkuJV4+mc4AR8S6klQeXSuU7pb/ngLKfWgzZNeQoMyZW0m3INGak7qY8yt3vd/5o
	YYM7GJZpl02wD9mJZI6VhtoXpe8BybbQOPTdXCq0cr9uFOyIZ2wZBqOcDWMTbCxEGdN8Cfb2Vsb
	L8OUTC7zGpYdzVYwemxy1NZbley5EXelT2DLYFF9Fb9rPBKDQw8eUPF17MuJaO/TXuNJb+Hpa2w
	OLuAqb/XuPWzCcI599eBRE1VC7AdMrxXk0L3X0xKiiq4PPrFDBhXjcr4UaFlIt+h3JlpWib7hkz
	94nzWcmFwSAR4FqJaJYjlBI6b+DhYckm17HPIP1aiemGNs+eQDdB3HOsbLknopeT25EY2g==
X-Received: by 2002:a05:7300:ce93:b0:369:f18f:34ab with SMTP id 5a478bee46e88-3725d77f97emr2096920eec.11.1794124290231;
        Sat, 07 Nov 2026 23:51:30 -0800 (PST)
Received: from hj.. ([163.239.22.29])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-372632d7d62sm5627672eec.3.2026.11.07.23.51.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 07 Nov 2026 23:51:29 -0800 (PST)
From: hyunjungg <hj351016@gmail.com>
To: Neill Kapron <nkapron@google.com>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Ruslan Bilovol <ruslan.bilovol@gmail.com>,
	linux-usb@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org,
	Hyunjung Ko <hj351016@gmail.com>
Subject: [PATCH] usb: gadget: f_uac1_legacy: cancel playback_work before freeing f_audio
Date: Sun,  8 Nov 2026 16:51:15 +0900
Message-ID: <20261108075116.251501-1-hj351016@gmail.com>
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

The OUT endpoint completion (f_audio_out_ep_complete) and the set_alt path
schedule audio->playback_work, whose handler (f_audio_playback_work)
dereferences the f_audio (audio->lock, audio->play_queue, audio->card).
On teardown f_audio_free() frees the f_audio with kfree(audio) but never
cancels playback_work -- f_audio_disable() is empty and nothing else
drains it. A playback_work still pending when the function is freed runs
against freed memory, a use-after-free.

Cancel playback_work in f_audio_free() before kfree(audio). By then the
function is unbound and the OUT endpoint is disabled, so the work cannot
be re-queued and cancel_work_sync() is sufficient.

This was reproduced with KASAN as a slab-use-after-free in
u_audio_playback(), reached from f_audio_playback_work(), under dummy_hcd:
with a UAC1 playback stream active, unlinking the configfs function frees
the f_audio in f_audio_free() while the work is still in flight. A delay
was added to the gadget streaming path to make the schedule-vs-free race
land deterministically; the missing cancel is present regardless. With
this patch applied the splat no longer occurs.

Fixes: d355339eecd9 ("usb: gadget: function: make current f_uac1 implementation legacy")
Cc: stable@vger.kernel.org
Signed-off-by: Hyunjung Ko <hj351016@gmail.com>
---
 drivers/usb/gadget/function/f_uac1_legacy.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/drivers/usb/gadget/function/f_uac1_legacy.c b/drivers/usb/gadget/function/f_uac1_legacy.c
index 7c8d60c..2dca5cd 100644
--- a/drivers/usb/gadget/function/f_uac1_legacy.c
+++ b/drivers/usb/gadget/function/f_uac1_legacy.c
@@ -945,6 +945,12 @@ static void f_audio_free(struct usb_function *f)
 
 	gaudio_cleanup(&audio->card);
 	opts = container_of(f->fi, struct f_uac1_legacy_opts, func_inst);
+	/*
+	 * The function is already unbound, so the OUT endpoint can no longer
+	 * queue playback_work. Drain any work still pending before the
+	 * containing f_audio is freed, otherwise it runs against freed memory.
+	 */
+	cancel_work_sync(&audio->playback_work);
 	kfree(audio);
 	mutex_lock(&opts->lock);
 	--opts->refcnt;
-- 
2.43.0

