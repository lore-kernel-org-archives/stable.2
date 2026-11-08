Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.48
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794145113;
	b=Wm6tULgz9j929H4GoIW6n52XPG0vUaS5yDB4PrdJfmoLt8vaNC8n2KClzbMpINJJQmQY
	 Ar5YoR2UFoONxuMDpfEOzVaJ9x1+DgduS+jrudr1ZKFrZ6ZIb4FYLuSM4wOQxy9APFE3l
	 iIhxf7WlInzS74EdpKkvImFzLZ7FcjiD3/N2RJU4Vv1lwleqoFWV/Q4qGL8vLP4WOuvtL
	 BFpjt7nYpANtdBCXkOVc7oaK+JzgAj6d14Y16IF0Nw6tz6MsTVwjxgLqlwKEITxQqqyF+
	 mWg7SHG9USVcnlsARcMw7O8k+bzi/bpyJ44hD6e1xCDDcNCZdNl1RQqNfe6BZ+6Li/g==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794145113;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:MIME-Version:
	 Content-Transfer-Encoding;
	bh=OxFXA2A8vf97MLqDI2dXStFoDohf1oeX4s7Z28iiyTE=;
	b=Df/fQyOaFyXMdwsPSTpDaMK/HY5lY1ojhuzrfdt5x/dUsJIl55pyaeAM6VZxg8/3b0pW
	 qv66xcCgvswl6TBF2vCyl5F+jlBtvuZthxcI0Iu0KHt/Y8hypuJFfksaVHP8OFon2N7l8
	 WAvYtBXm7gTQPEsQjtyKgjaBP9GeN8YMtLmBGcNcatJkE2VKAbP4lZR5SD8CZw+wHzmYw
	 kmY0HZ9Vq9Oue9KYkf6dR5n4FU0FD3M0/hFrLGpwi/TJ2wu/aCEF62N8w0B6b5EX5TdmD
	 DRcaNEC/UwWZQTyMy1IKrl4Kw8w2EV5XVZPvza13BJn7O1s8GUqN8kKvOiDyhLo3azw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=OndAluFL;
	arc=none smtp.remote-ip=74.125.82.48
Received: from mail-dl1-f48.google.com (mail-dl1-f48.google.com [74.125.82.48])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 09ABA606A321
	for <stable@vger.kernel.org>; Sun,  8 Nov 2026 13:38:32 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 09ABA606A321
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=OndAluFL
Received: by mail-dl1-f48.google.com with SMTP id a92af1059eb24-15ea896ddc8so180398c88.0
        for <stable@vger.kernel.org>; Sun, 08 Nov 2026 05:38:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794145112; x=1794749912; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=OxFXA2A8vf97MLqDI2dXStFoDohf1oeX4s7Z28iiyTE=;
        b=OndAluFLYQ0ImKAKq1jHnVrqGsXubi2j/NdImWBrrb5hYsZFLTPTaGF3DKFkO/tcoS
         t2DV+AWof8yg+skrFd5sosrJQe/T3NtDsYBQdeg9ivuLcShfR6LGmS93ycc7SvKPKFqk
         vkVtgwCZJKSPUFnUvCIKh7O8Skj5BgOCOcp+BgEtbhXACxwMgwt0KfdjBuWKqcOy2TkJ
         9vVupA1eEDOOuOCOm9dtdIhGZef+5X9gFVBrCdXv7Rvb8y0hH/BhAlQGfxop7xAEPHR/
         wVQvoDCqUZGPEiEzvRXXJ+oVxWrDA1ODwzL8XCbUjZHdHwwMcfbuyHYSq8Hb//WEkqsM
         aAJg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794145112; x=1794749912;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=OxFXA2A8vf97MLqDI2dXStFoDohf1oeX4s7Z28iiyTE=;
        b=YSIIHGieReRwk2lNE4zqsrbNvRWvI5OWaJJU27JLZQ6fwiRr0KdQe7YMG+JBGNfFrb
         fvOcD4EtIG5rWQJ+AK/z4ua3yLYWqqOvx15f6ATUxVvNSk1qOILgj+TidKRBQtPSxels
         KwGDVIKZC1rJhTSmMbfaaZUOXgvvuBgC/7IE9omPtc4jN0X8oafewKtLTo3GRf5m+jIu
         Hsk+LhJFgLxvvqKb1tbDwEyhjO+NoCiFMLvk2z3RymKCfDp/Dqa6VJ8QIB8TPx4lmGug
         V87DVbdjfUExRMQSgM8gnExMAmPMr1qcGIKxr6Jod/Pagupx+v+x/MsKi7XIGJhw1tRX
         t+mQ==
X-Forwarded-Encrypted: i=1; AL+hErGTE0yYMEH9R1z+XZzzNbGG3a06JOleKSHFGGd6CvSdPMGwJz1Gk0rP3fEY24JTE7dNYzd09gU=@vger.kernel.org
X-Gm-Message-State: APuU4Z9vFqkBcg1ovXJvAPhmCLL1VqgRXgcEuT+Qo+a0ZK0rib3zLrR6
	WKvW58pIZLHfrddJuUIIauSPK42mqHiRScdqFT+Ar7zJSQixE3C9WiKH
X-Gm-Gg: AYBFou0LzqRiP+bM7TkWMQKYuEIOFB83JQb2H2ZBAWEBElkhau6Xtaj0F7wEeJPnC9F
	1G436D4aeEE/BMqoD6ZKNqJhBN7Hosnb1BJEr9ALWs/HxbI7iIIhRjHbsydUgKlBC37w9lICdbA
	YNcA5pnJb+Uw/PHRt3Llyx3oU7MOTbtSzFC/M3yQcD3YzKxMl3DpfVJDEOrt8ImKYgb+qBF4859
	cVq41hehN57mXDb+7CtEDKr7kT8J9Q3ZnGwAA6K2h2DSyhqI0LoWXct1AsFBQPzit9v9Bt1tZpE
	ai35qN2ySRS/udCOSCoMWeLK3doOnu/hNJ/lXvB0Ir3pOuxwhhG073Vk9AP2gSop+ou2yW4Otef
	+s+BNwyhpLTdv9JY9j3w1RyE9cmq5PNKs54xvKLUAfZVofHZG/yfdPLCcNpSGaauYc9K6K6pF8e
	8HGLWC4V8sni6OeUgEMh/5PdSmE1FJd5hQftxTh3pfylJSw9Pqt5IbaRZ4OW4ExpQuy4rgYK7Bi
	kuIVWet+0WSM3XvfWI1KHaRkNzcf9Y8JFMuIiVeNGUAg/7cqwsfA7JA8BzAnHCOzDGbXPkZiO1y
	kOiIY+yw9JgXdzaES8Df86lttZt+03YO5zgR7m6EC8EqER1eg4W2bjR5Okb5SlcQH0bEZg==
X-Received: by 2002:a05:7022:5f1b:b0:1b1:251f:d732 with SMTP id a92af1059eb24-1b39fea9b18mr2244971c88.31.1794145111975;
        Sun, 08 Nov 2026 05:38:31 -0800 (PST)
Received: from hj.. ([163.239.22.29])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-1b37561ccabsm5515696c88.12.2026.11.08.05.38.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 08 Nov 2026 05:38:30 -0800 (PST)
From: hyunjungg <hj351016@gmail.com>
To: Jiri Kosina <jikos@kernel.org>
Cc: Benjamin Tissoires <bentiss@kernel.org>,
	Dmitry Torokhov <dmitry.torokhov@gmail.com>,
	linux-input@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org,
	Hyunjung Ko <hj351016@gmail.com>
Subject: [PATCH] HID: microsoft: cancel ff_worker on remove to avoid use-after-free
Date: Sun,  8 Nov 2026 22:38:21 +0900
Message-ID: <20261108133821.535139-1-hj351016@gmail.com>
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

ms_play_effect() schedules ms->ff_worker to send the force-feedback
report. ms is devm-allocated, so it is freed only after ms_remove()
returns. Commit 1cfc77a64b71 ("HID: microsoft: move FF initialization
to .input_configured()") dropped the cancel_work_sync(&ms->ff_worker)
call that the remove path previously had, so an ff_worker scheduled just
before the device goes away can still run after ms (and ms->hdev,
ms->output_report_dmabuf) has been freed -- a use-after-free.

Cancel ff_worker before hid_hw_stop() in ms_remove(), restoring the
teardown the driver had before the FF-init rework (and matching
hid-bigbenff). cancel_work_sync() is safe even if ff_worker was never
initialized: ms is zero-allocated, so the work reads as idle.

Fixes: 1cfc77a64b71 ("HID: microsoft: move FF initialization to .input_configured()")
Cc: stable@vger.kernel.org
Signed-off-by: Hyunjung Ko <hj351016@gmail.com>
---
 drivers/hid/hid-microsoft.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/hid/hid-microsoft.c b/drivers/hid/hid-microsoft.c
index a7d3493..462fdaf 100644
--- a/drivers/hid/hid-microsoft.c
+++ b/drivers/hid/hid-microsoft.c
@@ -384,6 +384,9 @@ static int ms_probe(struct hid_device *hdev, const struct hid_device_id *id)
 }
 static void ms_remove(struct hid_device *hdev)
 {
+	struct ms_data *ms = hid_get_drvdata(hdev);
+
+	cancel_work_sync(&ms->ff_worker);
 	hid_hw_stop(hdev);
 }
 
-- 
2.43.0

