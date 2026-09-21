Received: from mail-qk2-f41.google.com (mail-qk2-f41.google.com [74.125.230.233])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2AF3447A890
	for <stable@vger.kernel.org>; Mon, 21 Sep 2026 23:57:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.230.233
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790035051; cv=none; b=WZSKUFyqo3QD5i6IYp6X6jknBrVEXt487oxUkBqKBXnzC6UEPOoeRRzQLSPnA2wZII3hyP8lacpW8/o+1FduZYTdIwLF3Rxxetl4uI2KqirghLeW7IEn8Urg63rXqOyEKndkxfOGArU6E9FEiv+21h33iOV5U/pKFUECxvIOYFI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790035051; c=relaxed/simple;
	bh=YDBw5U2KrTFoLtn1ePgXe55ZEirZT68PAU8v7TTN/74=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=BUH/pJNI1RSAuHqXpmW8sHOSGjRkAtwL4hQAU7oBYwF8ySwOzs4nIH2tp8mIKYJK5QPki23F7CAbNWuYpWOvwRvZ7UXfAPU42cRKtM6JkODQcgLxbfMv0GcIitdVr1c1C4akKgwCQ7JRlTiVmJ1W10B/fVynF9qiEpM9WkK+k2A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=sDk6430J; arc=none smtp.client-ip=74.125.230.233
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="sDk6430J"
Received: by mail-qk2-f41.google.com with SMTP id d75a77b69052e-532c7643bc4so16086551cf.3
        for <stable@vger.kernel.org>; Mon, 21 Sep 2026 16:57:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790035049; x=1790639849; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=hO6e7g4iL/yYUT0YGjmRQ7zN/k9vF/YGJ0T17OVHKgc=;
        b=sDk6430JqzkgDsIKxWBgAMMnwTR9DC7pYrMfbGoPUqNH7NgstmUKlEEuVTLcmnU3x/
         rFa287qMzd3ZzLyK2mpNtHXJmiG7CiTqs5GshWbBRJFnt43RmXo7PUrnYzCf/rJbuqRX
         9isDhzP3mh7fsfxn7k14HmGez2k+jszVH8ZegnckULPCQnUAysRvLRGbHINT1CTV3nvI
         zZ8+8U702c6napv8V4eyt+Ns8TCJQpAHz/vHbidQvRx2uzmq5oS4Z9SzhUz/elhNpl1J
         Umtsz7WcyEJCBGGE7rlNStCCH7tiiG1TUfBsJqrD/V8bvZOVwrKguy7eVs7NsePVbJzo
         xfHA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790035049; x=1790639849;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=hO6e7g4iL/yYUT0YGjmRQ7zN/k9vF/YGJ0T17OVHKgc=;
        b=WsdjAMtoxcKwyLlMlZpwgeuQJtFY/rNBlBtKRc8Qj1uvtEG4rjl+17541TcnQpxynu
         GKhHE7Lf8Wmsdv/2wWs81y8SPyE33c3kze777HEQCiASzWYVJLEjXPk1JSwi4gwTD8Wx
         4svLU3TV8G8IEVJUIMEFflvZqQyKsAJZSioMnl6wLxvsZPdzKgsnZUbxx3qX50swU+v/
         tClY7Yt+Ihv9C7ZGyFUVnJBsOXHcYS1MTHPWnUb560pfhrwub5L2wmjMjFJksdUmAEEX
         qrQJPhrAih5MnADM6Qb/70/IfvvrZUs8CHlpa7YPjtpCJg/bnZaZ+2MBNmcCBTYUuJZG
         S6zg==
X-Forwarded-Encrypted: i=1; AKwUvBxJqthfoEK/VyypPt94sTPVYdHnZ5JYoIKPAlEx/Lke6e3FgF71joljue4G47kBOR4xYmxjXjg=@vger.kernel.org
X-Gm-Message-State: AFuF++kF0kxM65u3VrDiHZx0ku8xpLFEUmzWoq8TkM/IaqpJuEtAn7Ki
	1jg9G3zdCi04I4af741r2y4xLVWJucSJGUnGci7E+BtCYYkyQvIGW+8=
X-Gm-Gg: AYBFou1IDSx2fd3d5HcqG3JBc4OaX4yJKDyZRVmr3NFDeNOhOSiN5Iiy0QUJOgrFPS7
	rfH8jI+mf6v+hB9BXL2Yf/bpxNzCCH4vRUeO5Rb89MYBBPzi5SvcqXrM4AQN1Y3xtx/07/7bgqa
	q1WJF/GkeAVxdYqmmLrnOKqyX5cPAreUhBhEhCwd7Tn5+N8YfWdw5VRYolY3L3RuWoKSKWupuEy
	f2xpcYuwH/BjZ4tuhTsSRGbjgy+fgKETDcdFwHD9x/QsIHM4Uz1Y98PfNRsNVLa6SmZpOJPPPN/
	Drc7+VhWz6rZkQdcpvwJyxGpN6gGvoLwAj4bEDKjlcBgJK+6GzC/w9qXmZtCLKi3RGL3RwrJrUJ
	fM10mF3UNgOwz+G/VU8dCIgoV5DCJKmUpLU71Kf+PVuP688wh/mAxaeKfkC7Hpudrn0y5SSzAcb
	GopXcncU8lPpFM+W1Jkl4gXCtKHo/02pm3pXM84vcH/q06akJPf1J+fEiO7J1cVA8Ox5un33lFi
	dAMIS63FQD6EKpyXnisU2qLg6lHqrLKcd0a3p2Z/Y1w19H12xz1rEbOJlY9VFhdEtdJi8J/a1tY
	KhbmifmwZ7CY/e2g06u5WbWgS6FkXxSUY6L1lwU=
X-Received: by 2002:ac8:7f51:0:b0:530:f214:6240 with SMTP id d75a77b69052e-532d8e9673amr31330151cf.60.1790035049081;
        Mon, 21 Sep 2026 16:57:29 -0700 (PDT)
Received: from i4-gl-tmk5904-1.ad.psu.edu ([130.203.156.90])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-532df30470asm3009161cf.14.2026.09.21.16.57.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 21 Sep 2026 16:57:26 -0700 (PDT)
From: Myeonghun Pak <mhun512@gmail.com>
To: Liam Girdwood <lgirdwood@gmail.com>,
	Mark Brown <broonie@kernel.org>,
	Jaroslav Kysela <perex@perex.cz>,
	Takashi Iwai <tiwai@suse.com>
Cc: Myeonghun Pak <mhun512@gmail.com>,
	patches@opensource.cirrus.com,
	linux-sound@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org,
	Ijae Kim <ae878000@gmail.com>
Subject: [PATCH] ASoC: wm8962: Prevent mic_work rearm during removal
Date: Mon, 21 Sep 2026 19:57:24 -0400
Message-ID: <20260921235724.533472-1-mhun512@gmail.com>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

wm8962_remove() cancels mic_work, but on unbind that cancel runs
before the interrupt that queues it is released.

wm8962_i2c_probe() requests the interrupt with
devm_request_threaded_irq() and registers the component afterwards.
devres releases in LIFO order, so wm8962_remove() runs before
free_irq().  A MICD or MICSCD event in between makes wm8962_irq()
queue mic_work again, and the delayed work then calls
snd_soc_component_read() and snd_soc_jack_report() on the freed
component.

Commit ca50410b731c ("ASoC: wm8962: Move interrupt initalisation to
probe()") dropped the free_irq() that used to precede
cancel_delayed_work_sync() in wm8962_remove().

Disable the interrupt in wm8962_i2c_remove(), which runs before devres
release.  disable_irq() waits for the threaded handler, and the
existing cancel then drains mic_work with no producer left.

This issue was identified during our ongoing static-analysis research
while reviewing kernel code.

Fixes: ca50410b731c ("ASoC: wm8962: Move interrupt initalisation to probe()")
Cc: stable@vger.kernel.org
Assisted-by: LLM
Co-developed-by: Ijae Kim <ae878000@gmail.com>
Signed-off-by: Ijae Kim <ae878000@gmail.com>
Signed-off-by: Myeonghun Pak <mhun512@gmail.com>
---
Found by inspection; I do not have the hardware, so this is not runtime
tested.

 sound/soc/codecs/wm8962.c | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/sound/soc/codecs/wm8962.c b/sound/soc/codecs/wm8962.c
index 8a9598161b35..210ec96fab4c 100644
--- a/sound/soc/codecs/wm8962.c
+++ b/sound/soc/codecs/wm8962.c
@@ -3890,6 +3890,16 @@ static int wm8962_i2c_probe(struct i2c_client *i2c)
 
 static void wm8962_i2c_remove(struct i2c_client *client)
 {
+	struct wm8962_priv *wm8962 = i2c_get_clientdata(client);
+
+	/*
+	 * The IRQ is devm-managed, so it is freed only after the component
+	 * has been unregistered and wm8962_remove() has already cancelled
+	 * mic_work.  Silence the producer here instead.
+	 */
+	if (wm8962->irq)
+		disable_irq(wm8962->irq);
+
 	pm_runtime_disable(&client->dev);
 }
 

base-commit: 238650ef6c7c7cca08e032527329424c9fbd70e5
-- 
2.53.0

