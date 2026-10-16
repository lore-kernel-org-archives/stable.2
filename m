Received: from mail-qk1-f182.google.com (mail-qk1-f182.google.com [209.85.222.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EDDC7598BF6
	for <stable@vger.kernel.org>; Fri, 16 Oct 2026 17:31:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792171917; cv=none; b=SuwCcBlAQhauIvo2o+Uoq8F9BFhjmqHhIzmTef85VE2WsZYZ/rD3ZTd2LCIbOFdqr4kFhuce/gYaxXA3/Fu9VoFy0xdzpc8b04908n/Dm3BF5L/XRNopEttkoeUBX63VZzaMMWL+JTYbo20VHsMVkd40mvDMZOyTVt7OELPk2Rs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792171917; c=relaxed/simple;
	bh=RsVlH+APnIxb/YW5DKjHZSFF1ttkYz7gihzSpOO4FPw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=g9eYD3dsIPZ/Gn8BvQyRRBYHeMTZ2WLlVZKZwj5QddzA5rnesw1/V7Afu91tPfsFD11XdJ39+6Pg0QI+3DEEjYtzPAPjXh4ua7jh1/3wo94nad2HCwJCrrudnb04KgYh5Oc3s+SEnbDJn5HoQ0PbFJFgm1jrez92RgeY4kIR0FI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=WhyLQ4wR; arc=none smtp.client-ip=209.85.222.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WhyLQ4wR"
Received: by mail-qk1-f182.google.com with SMTP id af79cd13be357-93f269e335eso20039385a.3
        for <stable@vger.kernel.org>; Fri, 16 Oct 2026 10:31:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792171915; x=1792776715; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=8hf4LaRDBNm1FH/XNRRtnuj8oud85TuTPQVIbPrpZ7E=;
        b=WhyLQ4wRM4w2la5ZBjkKAOlotFxvoiORYwU0tWkiodaKXwnQ8pDLEG/lut12W6L+m2
         ciWjb/LYnGTIQ7BCTJZTD15n6IxsuUEZEDJ0lOaC3Ur71qSOtJnYnkjB+GAOOrsoz3Bs
         fQSRVGtyKr7LhP8f3SmdT4UDqcsLmi9JJjLZ8HTXRXBTv4W8hrUW9ZepQcC241XmCKmT
         BOfPC1hlJFEBu3ngA9PdXehkjkWT/QaE0P7K7AAohg+AAvT/idRiZ7SeZjIkE+Hij5F/
         94SWUsQpDjt+wiXepnLAADSFlexPAx6z/g1TXVRQHGUqH7kw2gz+IDpjZSfIVZzh2Swz
         AD+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792171915; x=1792776715;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=8hf4LaRDBNm1FH/XNRRtnuj8oud85TuTPQVIbPrpZ7E=;
        b=10DHoT8bd8JgBWwvmhZuWFEGt0cS6fPy0wHT4S4SK/i0SVIFsldE5kJxoMHVkUqftR
         m0vmSzN3hqfzvf1tkLR2ZB+D2Whm0xhTMmGmv3eDvJItn+xpj9AGc3wJ52z+EsvMc9xF
         8lyQ+hkZ1tQeukNKmIwtXiENpA8rGnxXj7lrcoXuBPkXSCgJP0afRnZdQAq5A/CM91fG
         LfUPLqwCJ0guYSnPjOr7dAo6l9oOfpMhM6KIpwJjxNEs0/y0CXkiCcVCa7JUTGwPZsrD
         4czG/0ueiF64BULkTIrkFicAPcGp0fyOwc94e88MKudVpun+2Tt/2TVaxhaUMDYbTMS2
         kcSA==
X-Forwarded-Encrypted: i=1; AKwUvBzJ6Uss3ebNm/hZy01nUgislam6Y6cLNnUzffGNcxshjfrkakAMtIWoKfGA67JcD7RP7UglGLU=@vger.kernel.org
X-Gm-Message-State: AFq9FYIiN9/EGgWDY8OrIPQ2ZGWFxhHstsuBmExFonPzuFvFNaxBj8a+
	0X7SEIeSmH8wzEPm+YfLJlVYO0ulXX/3tg1m+OwQLm7Wzra0Ubd/qRPi
X-Gm-Gg: AYBFou05ZSFkFBVYV3zRAPDxVE77aDlS3DqLZOXtvbaOm20yXe2V1qUVQeC80nUgSsY
	Yz0FhC4JpN97Dqb/w77/Nu94qC0TAkPZ33iM4Iy+pB8ChxO3apL8FRjdsOE294eemofTsaRjMAc
	GairLbF7sa+SDgjU3jyub2FvRSo0+PdStD8WbUBKmCco2Lq3qWf5GAFDffj4xWMYJ1Slgfj+dzk
	XpJdqoMILLiXFFLuxkv1e/uIqxhI2hx6bG5x/9n6OJLFNtB5b84kLzzZcwjGQpvVv1qFUQFndM8
	Ot/UYwEaQ8TZXNf4lBSENu4vMprTojA+26XhncQ123xm9GO14NJ/P2uB/pZtB3EKHdacOMjvFqM
	/Lk9uPXKasf/Q3ND9UZkjLMisE28jrbCavfr1VoN8NUCPbIQy0WFyu+i//e5uztMQVP5g2+bkg1
	NN46g6Vy5Djy8VXBwCNg3GMjdx8Iimdlt4ti7Es4LIXcNbywF1xAwFKSPCsCrCxi8=
X-Received: by 2002:a05:620a:3955:b0:937:d6e8:59b0 with SMTP id af79cd13be357-93f29ba0b06mr100125185a.10.1792171914802;
        Fri, 16 Oct 2026 10:31:54 -0700 (PDT)
Received: from beelink ([187.15.139.183])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-93f1a18510fsm262760085a.22.2026.10.16.10.31.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 16 Oct 2026 10:31:54 -0700 (PDT)
From: Aldo Ariel Panzardo <qwe.aldo@gmail.com>
To: jikos@kernel.org,
	bentiss@kernel.org
Cc: dmitry.torokhov@gmail.com,
	linux-input@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org,
	Aldo Ariel Panzardo <qwe.aldo@gmail.com>
Subject: [PATCH v8 1/2] HID: haptic: reorder try_module_get/get_device before input_ff_create
Date: Fri, 16 Oct 2026 14:30:55 -0300
Message-ID: <20261016173056.3397211-2-qwe.aldo@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261016173056.3397211-1-qwe.aldo@gmail.com>
References: <20261016163349.3293666-1-qwe.aldo@gmail.com>
 <20261016173056.3397211-1-qwe.aldo@gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Move try_module_get() and get_device() before input_ff_create() in
hid_haptic_init().  The original order placed them after
input_ff_create(), and failures went to input_free which called
input_ff_destroy() without ever setting ret.  The caller saw ret == 0
on failure and kept a dangling pointer to the haptic struct.

With the references acquired first, all failure paths reach
stop_buffer_free directly.  The flush/event save/restore is no longer
needed.

Clear the EV_FF and FF_HAPTIC capability bits on failure so a masked
error from the caller does not leave the input device advertising FF
support without a dev->ff -- EVIOCGEFFECTS would NULL-deref otherwise.

Fixes: 8d0bf7908b5a ("HID: multitouch: add haptic multitouch support")
Cc: stable@vger.kernel.org
Signed-off-by: Aldo Ariel Panzardo <qwe.aldo@gmail.com>
---
 drivers/hid/hid-haptic.c | 38 ++++++++++++++++++--------------------
 1 file changed, 18 insertions(+), 20 deletions(-)

diff --git a/drivers/hid/hid-haptic.c b/drivers/hid/hid-haptic.c
index 8760eeb..b8aa4bf 100644
--- a/drivers/hid/hid-haptic.c
+++ b/drivers/hid/hid-haptic.c
@@ -419,8 +419,6 @@ int hid_haptic_init(struct hid_device *hdev,
 	};
 	const char *prefix = "hid-haptic";
 	char *name;
-	int (*flush)(struct input_dev *dev, struct file *file);
-	int (*event)(struct input_dev *dev, unsigned int type, unsigned int code, int value);
 
 	haptic->hdev = hdev;
 	haptic->max_waveform_id = max(2u, haptic->max_waveform_id);
@@ -501,12 +499,24 @@ int hid_haptic_init(struct hid_device *hdev,
 
 	input_set_capability(dev, EV_FF, FF_HAPTIC);
 
-	flush = dev->flush;
-	event = dev->event;
+	if (!try_module_get(THIS_MODULE)) {
+		dev_err(&hdev->dev, "Failed to increase module count.\n");
+		ret = -ENODEV;
+		goto ff_cap_clear;
+	}
+	if (!get_device(&hdev->dev)) {
+		dev_err(&hdev->dev, "Failed to get hdev device.\n");
+		ret = -ENODEV;
+		module_put(THIS_MODULE);
+		goto ff_cap_clear;
+	}
+
 	ret = input_ff_create(dev, FF_MAX_EFFECTS);
 	if (ret) {
 		dev_err(&hdev->dev, "Failed to create ff device.\n");
-		goto stop_buffer_free;
+		put_device(&hdev->dev);
+		module_put(THIS_MODULE);
+		goto ff_cap_clear;
 	}
 
 	ff = dev->ff;
@@ -515,23 +525,11 @@ int hid_haptic_init(struct hid_device *hdev,
 	ff->playback = hid_haptic_playback;
 	ff->erase = hid_haptic_erase;
 	ff->destroy = hid_haptic_destroy;
-	if (!try_module_get(THIS_MODULE)) {
-		dev_err(&hdev->dev, "Failed to increase module count.\n");
-		goto input_free;
-	}
-	if (!get_device(&hdev->dev)) {
-		dev_err(&hdev->dev, "Failed to get hdev device.\n");
-		module_put(THIS_MODULE);
-		goto input_free;
-	}
 	return 0;
 
-input_free:
-	input_ff_destroy(dev);
-	/* Restore dev flush and event */
-	dev->flush = flush;
-	dev->event = event;
-	return ret;
+ff_cap_clear:
+	__clear_bit(FF_HAPTIC, dev->ffbit);
+	__clear_bit(EV_FF, dev->evbit);
 stop_buffer_free:
 	kfree(haptic->stop_effect.report_buf);
 	haptic->stop_effect.report_buf = NULL;
-- 
2.53.0

