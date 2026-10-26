Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.128.51
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793013739;
	b=pVoHtfjcenfKajlo4m2OSEi+y7qAm1GAPUk0wABKgAs9+3Y8gyQ5JpRcwYsuZ3IUI74q
	 cIx3u58OLaDy1v4RMA4Au8/iz8ubqKL860cQmnWEus7P/83ivDYsQDN6+ae86RpI1i9k5
	 N2DgoTQki+MwtlL+hNLVpUIsEHnmp97FwZQP6+LskqHfJewoclnatES2aoDt1F8/UN1AF
	 4Tw712PgQT3WLSVNHwOi1Hx2yaTf1/ah2m/CJaVPZOar/pMXPNhcKKuvG2/MAvmuIolV0
	 5UFvNkXyBWp9RlG5MtHvadPzVqzZQ7sCtxxOsDcmwL/2kGOdxNQVesa+znyFrTURVcw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793013739;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding;
	bh=s4qQ/bFBK5eaOJIStGYxhCTOPxN89dq+twzU6uM3Z7c=;
	b=4Xd+NG6V8L7bIQzuJAbtLm0jv7aFuLXjdW/rvTZPSdlI6WnHqoI3ccZQeMr/n2xaSpXf
	 bKPPgFwLCdzoWGYeOzVOCqDrKl7ZJPQMPhFPDDOplnwtQIS5FZSoAtLHZZk4Z+Bdz0rH9
	 OzRXNz5BEup88aos0U81Loh+74Rd8zZzwkJ5Ag4HBL2aCLodjzsdYQRO3Ay892hz9gIBB
	 qwJTPDUpUPd3BEipvw801LSgqpaKX9KCQACiusy9rgQjoO34abxyi0cR+0iHx39mC432j
	 dsntOrNcNF/ql6Joc5VziY06KsUorisGonzdIOXSq0Lwv9G0cgysnifBB8KPkfAyM3Q==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=MoyEVzA4;
	arc=none smtp.remote-ip=209.85.128.51
Received: from mail-wm1-f51.google.com (mail-wm1-f51.google.com [209.85.128.51])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 67625606A32F
	for <stable@vger.kernel.org>; Mon, 26 Oct 2026 11:22:19 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 67625606A32F
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=MoyEVzA4
Received: by mail-wm1-f51.google.com with SMTP id 5b1f17b1804b1-4a5720b0a57so5332625e9.0
        for <stable@vger.kernel.org>; Mon, 26 Oct 2026 04:22:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1793013738; x=1793618538; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=s4qQ/bFBK5eaOJIStGYxhCTOPxN89dq+twzU6uM3Z7c=;
        b=MoyEVzA4BlfgrZmr/+xem5km/GDXPU4lmttZ/MbD1CCdRKwUQ6cUTdkFM0JJwIuQ/e
         fi0dECa5qaYr58c1v9ebxC9HUXtLgrX9gQOGOBgJm6IO71s1GRREbVuNEZloj8HoDj4F
         5fseC0ckMgoARaJfjYociSVZpwAz2kxIhT0p7S+trrjPbS8kEpjGDWZ/VBBSRfoZLb01
         AgXRmYO7JGaZG5xy0jfV2rH39aRBLq6j/vcV9ETaGxTafXEp2uOjE5hCURUPJC1iQci3
         0aPlWA3zqm3+o4Rz3MlCyMzmPnJ9SB31zbDKIy+UPqW4rlpuNWlXTqCssRoa+uHeIb3r
         jJwA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793013738; x=1793618538;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=s4qQ/bFBK5eaOJIStGYxhCTOPxN89dq+twzU6uM3Z7c=;
        b=UhGKc8vAAYVfDEjo7oTJy6UomTYIYZHHxyvzFpSIU/1zd2MrtnAX094qLAhbk5F5t4
         IHMwu7Cs6K4IM++amcRzOkHJhJFk0nAs5CadtMebSVNELRR7TPyOg3uknVkvbUvFAuQl
         40B94ZLTT6D8OhrwIGLc/Zv9nX3/kKYE9fyCCLZbOKpEsa4iLy/E44wQSDa+pIN9QU5o
         6OYExT7q+IaSMVY3hmi7AHPrLvvwvRxh1bv2h1V/sZG4gK1dihL2zOOg9dCdga+JmOba
         cVH3iEHVNCHfYHyfQT3AF4CjbVB9wys/OV0NHili9e25orpy90oAmYA0oPf6w09CXfBO
         YyYg==
X-Forwarded-Encrypted: i=1; AKwUvBzjKlEhSFpVDC0dhUDzqaSkXaMGSTKaMhD1o2sYqlCX1/mo8XuOMs4RRSJQOZW58dhH/IMRWgQ=@vger.kernel.org
X-Gm-Message-State: AFq9FYLevzWlQTPoSlNV4u57bZigPcreQlYXJJXgnyrvj6d0h6wslEiL
	JhGG234pzmKOQG76a/2wM6YoXamE1VVVRPfu0/8HMV5J8ei6jG4tRUQ=
X-Gm-Gg: AYBFou3wvBXJ0qspoWQvyAqItQ6eSlpHHMtQC4hCTjfeuLhb3ZHx4FLg6uU1IAd9Vul
	Jpvi+o5ElMufvlFvwObaZpj0cFFPa08Q9Nt2CA6kx4OeJWrRindOXEdv/NzPrqIRdaPtfxF0h25
	kYdn0ot/zmfJSWn+D6Tf4v4Md822YuopeH9eOjmKSZ1bGdzj2DVt+p4V4yxEdq8RtDBkdT6GYqd
	wLfoANIwjlyF11Zf4tbtPFXSox6E8ar99+6MJSxyhbTJWUWD3SffdYZteZkUyk8DlF3s+tnoZjh
	+CYs1h1HBR0IT4wANvxT8W8flu1yJ1Fu5PuMzhdRNuK9vDjS92ySryZs3vtdlO7zxdKnALQLaRS
	GdefsXv37Ejq1bA1TBJsBEW1F4tFqA07xw1gO+b+jxU08rAkkwY66nBhaFpkZw3Fp+PbNHmYZ1W
	T47B36EqrruwAfdVyyGaeaug7+54JJwOkWOou31M5ib6GZlHMJyApuj7DdzXLq88K3Kt+qbGP9+
	g7uIPIY2b4EVb4fipACIZnrcZbsuuIohlzIGCcnVN6xQw==
X-Received: by 2002:a05:600c:4f05:b0:49e:65f2:db64 with SMTP id 5b1f17b1804b1-4a35ae71b30mr134739435e9.5.1793013737744;
        Mon, 26 Oct 2026 04:22:17 -0700 (PDT)
Received: from debian.. ([2001:41d0:303:db6b::])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4a359f59750sm129141265e9.0.2026.10.26.04.22.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 26 Oct 2026 04:22:17 -0700 (PDT)
From: Tristan Madani <tristmd@gmail.com>
To: Mark Brown <broonie@kernel.org>,
	Takashi Iwai <tiwai@suse.com>
Cc: Oder Chiou <oder_chiou@realtek.com>,
	Bard Liao <bardliao@realtek.com>,
	Liam Girdwood <lgirdwood@gmail.com>,
	Jaroslav Kysela <perex@perex.cz>,
	Jorge Eduardo Candelaria <jorge.candelaria@ti.com>,
	linux-sound@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org,
	Tristan Madani <tristan@talencesecurity.com>
Subject: [PATCH 3/4] ASoC: twl6040: cancel headset jack work on component remove
Date: Mon, 26 Oct 2026 11:22:11 +0000
Message-ID: <20261026112212.2519775-4-tristmd@gmail.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20261026112212.2519775-1-tristmd@gmail.com>
References: <20261026112212.2519775-1-tristmd@gmail.com>
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

twl6040_remove() frees the plug detect IRQ but does not cancel the
delayed work that the IRQ handler schedules.  If the work is still
pending after free_irq() returns, it fires on freed memory.

Add cancel_delayed_work_sync() after free_irq() to drain any residual
work.  The IRQ is freed first to stop the producer, then the work is
drained.

Fixes: a2d2362edf9f ("ASoC: twl6040: Add jack support for headset and handset")
Cc: stable@vger.kernel.org
Signed-off-by: Tristan Madani <tristan@talencesecurity.com>
---
 sound/soc/codecs/twl6040.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/sound/soc/codecs/twl6040.c b/sound/soc/codecs/twl6040.c
index 650836f9615fb..826bde1a9ba46 100644
--- a/sound/soc/codecs/twl6040.c
+++ b/sound/soc/codecs/twl6040.c
@@ -1136,6 +1136,7 @@ static void twl6040_remove(struct snd_soc_component *component)
 	struct twl6040_data *priv = snd_soc_component_get_drvdata(component);
 
 	free_irq(priv->plug_irq, component);
+	cancel_delayed_work_sync(&priv->hs_jack.work);
 }
 
 static const struct snd_soc_component_driver soc_component_dev_twl6040 = {
-- 
2.47.3

