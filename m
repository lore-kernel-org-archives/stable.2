Received: from mail-qt1-f174.google.com (mail-qt1-f174.google.com [209.85.160.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 66FBB599A2B
	for <stable@vger.kernel.org>; Fri, 16 Oct 2026 17:31:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792171921; cv=none; b=cUgPI+T6EYhOAdV5iNJWwzQP11LL6of4gSB2zoLqjc0ukiUMBmE+Qe7XUuM5VK5f2AVtJy026jd1AjTs5uRak/kNUU9WUnzwiR/SmOKqeTRABmO3qUG9qPZtlSNM8wQfMjBqd/YNbCOaQELhVS5faCfUl9igHEfFB6Y9rQYoioU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792171921; c=relaxed/simple;
	bh=mbOBhU42eMDoQSlVXasgDD6y/r24fvVLTM3qd2EE1ng=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=nTM0Eo+23sRT+11QTOOk/cF3aTc2qwhvCs0JL/xxvaDTy3KusCqNDqzI7ws87DzVfgHpXe5n77kg2Gidk13T7EcTgolCcjpZCX0U9qInNTm51IIEv5dHuQmNA46yEmgPaLXBpyrZcTTymid2Ux0rIPzwFb7vCZH0Pg9tOfQVAMk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=GKru5Qkc; arc=none smtp.client-ip=209.85.160.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GKru5Qkc"
Received: by mail-qt1-f174.google.com with SMTP id d75a77b69052e-53582498790so1524491cf.2
        for <stable@vger.kernel.org>; Fri, 16 Oct 2026 10:31:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792171918; x=1792776718; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=ayg9dclc/7Vl84+qbzC4sAb4naw0KOWzcqqg51qZplw=;
        b=GKru5Qkcrp603I68oUOtaXLUiPtsAndyEcCuRovRA/hRr6QUsktcNBiJj7oKJ98sYH
         d4E1yaIs77fio1z0NSluzPj7lwONCcpgrvxpq14QV1Td+D/3guoDm6GC2dEftNHJPmai
         LxnwnIYaQ2Mp76Z98oJA9sZObDMlV9lyHoA/QA1T8CLQgXOR3+4k/MKBxFd8jNB2fEeW
         vyEOIA8foDQFthiacGoQFx0To07d5P2Wrc/lnGab2buZWHg+QUVzjleQsqA3FTbUcDvb
         LQhiKjfhEtQ9O+FIwQzdZFddAr5KuheinWUYydxi6M5o0scFoihVfEOamG9Q1EgooiiA
         TwXg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792171918; x=1792776718;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=ayg9dclc/7Vl84+qbzC4sAb4naw0KOWzcqqg51qZplw=;
        b=y6ifeQQ8grKwaS00UcnnqyfvoJqeRvehzevzp1ntjhcfxRdBdmLi/6V+hxtbO4oif9
         ItqS9tLq6+fM6npt6whvurZZeAhht+7q3uC6Eb6qHkx8v3cvMWIzxNNXn9UBrkcuBy8a
         Dt2OdgaOv613mNaR3Xnm54OA2fuBvNrGeFbSvDHWynKyBRa7IWbMIk3Jmm/YcelMHvDz
         Elj79dW6Cuslh7M+hoNdnNDOC40xbdyPzflcNcXnAaAMDntG2EC+bz5fUbr/DlvcUG4O
         l/ZJwzkVu1GHlXazr3+UMljt8VI7APy796GYhuVdzJscBYnHpNNjY2Bwbeva1UTt30KX
         ycPw==
X-Forwarded-Encrypted: i=1; AKwUvBwcY5FAE4Wo+7XldiYRfGGnA9DZAEhrh4Fh7VIKn8bzAx8yiCytUN55Dcoz6KmTd70OJZkGqyk=@vger.kernel.org
X-Gm-Message-State: AFq9FYKc/fQ0Wa+YepRRWE23iJ7WdRWQ5HtfWQvDnA/1WsSBWzQWD/0N
	LT1lOtbYqhBjazaqYp2w3ad86WnJSY4cfbpUUZnq2ULNK7b8O0Tecful
X-Gm-Gg: AYBFou0PzqeiNpKswfvzSBipu7M2F9lcrZskLzp3RwyB+MHw/mR7qLjYu16i7YnxJ6L
	DcYEv/8YRUDzAGAN9FXCNzzH+fosqK2IHQTam8F2ffkKgKdDrp5M48N3GZLDs0RlDWJte4fQ9v/
	6GSDCKsH4ww3izQZVN1XmWz1eJhHrCX4FtAFB37x2cgzJJuIDrsEKKmQCrkxkkTCuDLD2efgn4t
	azKZt8rGTKxfBY3L2bzCgWIbtzZKiSkMTwlqU7tUu3Xe99BvC5yxuoasGd42eb27BODtxS5BW7a
	scXKRvMuwy/VRY1j62V/FZrH/1q3E0aVsg5imv0WxVjdzEsbNYKLmygOVnnpO5mdJ2YgdHv4oVA
	+ujKqibaHo+nqly18W+BPSojOao5u9zpSHu6edXHmIV2qx2pI5SGkbtR9nVmckcdQEElNoZxmHV
	JeGt16D7kDQHr3ZN6RIrdYmLtlGlDTB85i4lJTXcztuWibqx4KwKltDtN6dAvbcUvvndWMdwPOY
	A==
X-Received: by 2002:a05:620a:2715:b0:93e:54fb:1568 with SMTP id af79cd13be357-93f29d55d8fmr99695285a.52.1792171918128;
        Fri, 16 Oct 2026 10:31:58 -0700 (PDT)
Received: from beelink ([187.15.139.183])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-93f1a18510fsm262760085a.22.2026.10.16.10.31.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 16 Oct 2026 10:31:57 -0700 (PDT)
From: Aldo Ariel Panzardo <qwe.aldo@gmail.com>
To: jikos@kernel.org,
	bentiss@kernel.org
Cc: dmitry.torokhov@gmail.com,
	linux-input@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org,
	Aldo Ariel Panzardo <qwe.aldo@gmail.com>
Subject: [PATCH v8 2/2] HID: multitouch: fix use-after-free of haptic data on delayed input release
Date: Fri, 16 Oct 2026 14:30:56 -0300
Message-ID: <20261016173056.3397211-3-qwe.aldo@gmail.com>
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

mt_probe() allocates td->haptic with devm_kzalloc() and hid_haptic_init()
stores it in ff->private.  When the HID device is removed while an evdev
fd is still held, devres frees td->haptic at unbind but
hid_haptic_destroy() runs later from input_dev_release() and dereferences
the freed pointer.  input_ff_destroy() then double-frees it via
kfree(ff->private).

Move all resource cleanup into a devm_add_action() callback so it runs
at unbind before devres frees the struct.  hid_haptic_destroy() becomes
ff->private = NULL plus module_put() -- keeping the module loaded until
the FF subsystem is done with the callback.  A second __module_get()
covers hid_haptic_devm_release() itself, dropped after input_put_device().
The input device is pinned with input_get_device() to prevent concurrent
release during the devres action; the workqueue is drained first while
all buffers are still live.

Guard against double-init when multiple touchpad collections trigger
hid_haptic_init() for the same haptic struct.

Fixes: 8d0bf7908b5a ("HID: multitouch: add haptic multitouch support")
Cc: stable@vger.kernel.org
Signed-off-by: Aldo Ariel Panzardo <qwe.aldo@gmail.com>
---
 drivers/hid/hid-haptic.c | 74 +++++++++++++++++++++++++++++++++++-----
 1 file changed, 66 insertions(+), 8 deletions(-)

diff --git a/drivers/hid/hid-haptic.c b/drivers/hid/hid-haptic.c
index b8aa4bf..e4e9bb9 100644
--- a/drivers/hid/hid-haptic.c
+++ b/drivers/hid/hid-haptic.c
@@ -379,32 +379,61 @@ static int hid_haptic_erase(struct input_dev *dev, int effect_id)
 
 static void hid_haptic_destroy(struct ff_device *ff)
 {
-	struct hid_haptic_device *haptic = ff->private;
-	struct hid_device *hdev = haptic->hdev;
+	/*
+	 * Resource cleanup is handled by hid_haptic_devm_release() at
+	 * driver unbind.  Disconnect the FF pointer so input_ff_destroy()'s
+	 * kfree(ff->private) becomes kfree(NULL).  Drop the module
+	 * reference last -- it must outlive this callback.
+	 */
+	ff->private = NULL;
+	module_put(THIS_MODULE);
+}
+
+static void hid_haptic_devm_release(void *data)
+{
+	struct hid_haptic_device *haptic = data;
+	struct input_dev *dev = haptic->input_dev;
 	int r;
 
-	if (hdev)
-		put_device(&hdev->dev);
+	/*
+	 * Drain pending work first -- handlers dereference ff->private
+	 * through the input_dev, so the workqueue must be idle before
+	 * we NULL that pointer or free any buffers.
+	 */
+	if (haptic->wq) {
+		destroy_workqueue(haptic->wq);
+		haptic->wq = NULL;
+	}
+
+	if (dev && dev->ff && dev->ff->private == haptic)
+		dev->ff->private = NULL;
+
+	if (haptic->hdev) {
+		put_device(&haptic->hdev->dev);
+		haptic->hdev = NULL;
+	}
 
 	kfree(haptic->stop_effect.report_buf);
 	haptic->stop_effect.report_buf = NULL;
 
 	if (haptic->effect) {
-		for (r = 0; r < ff->max_effects; r++)
+		for (r = 0; r < FF_MAX_EFFECTS; r++)
 			kfree(haptic->effect[r].report_buf);
 		kfree(haptic->effect);
 	}
 	haptic->effect = NULL;
 
-	destroy_workqueue(haptic->wq);
-	haptic->wq = NULL;
-
 	kfree(haptic->duration_map);
 	haptic->duration_map = NULL;
 
 	kfree(haptic->hid_usage_map);
 	haptic->hid_usage_map = NULL;
 
+	if (dev) {
+		input_put_device(dev);
+		haptic->input_dev = NULL;
+	}
+
 	module_put(THIS_MODULE);
 }
 
@@ -419,6 +448,11 @@ int hid_haptic_init(struct hid_device *hdev,
 	};
 	const char *prefix = "hid-haptic";
 	char *name;
+	int (*saved_flush)(struct input_dev *, struct file *);
+	int (*saved_event)(struct input_dev *, unsigned int, unsigned int, int);
+
+	if (haptic->wq)
+		return 0;
 
 	haptic->hdev = hdev;
 	haptic->max_waveform_id = max(2u, haptic->max_waveform_id);
@@ -511,6 +545,8 @@ int hid_haptic_init(struct hid_device *hdev,
 		goto ff_cap_clear;
 	}
 
+	saved_flush = dev->flush;
+	saved_event = dev->event;
 	ret = input_ff_create(dev, FF_MAX_EFFECTS);
 	if (ret) {
 		dev_err(&hdev->dev, "Failed to create ff device.\n");
@@ -525,6 +561,28 @@ int hid_haptic_init(struct hid_device *hdev,
 	ff->playback = hid_haptic_playback;
 	ff->erase = hid_haptic_erase;
 	ff->destroy = hid_haptic_destroy;
+
+	/*
+	 * Pin the input device so it cannot be released concurrently
+	 * with our devres cleanup, and take a second module reference
+	 * so the module stays loaded while hid_haptic_devm_release()
+	 * executes (the first ref is dropped by hid_haptic_destroy()
+	 * which may run inside input_put_device() below).
+	 */
+	input_get_device(dev);
+	__module_get(THIS_MODULE);
+
+	ret = devm_add_action(&hdev->dev, hid_haptic_devm_release, haptic);
+	if (ret) {
+		module_put(THIS_MODULE);
+		input_ff_destroy(dev);
+		dev->flush = saved_flush;
+		dev->event = saved_event;
+		input_put_device(dev);
+		put_device(&hdev->dev);
+		goto ff_cap_clear;
+	}
+
 	return 0;
 
 ff_cap_clear:
-- 
2.53.0

