Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=165.173.182.112
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1795538749;
	b=hnHdRDsoVXlIje8dAw0Jg1gwFYYPiIpHihfDMP6XUkrm0rG5G6jhlQJpig/4S69Pu/OD
	 bj4Jz1JtDHzarZ8CUVO5ocaKvXXDUCQZ2HEDBvBUbStOLGyl9uH3tvYYmGnKuyML+XL3O
	 gUrJ/K4fDLAIZraHb6iU3j568ZM7AAdz65AZ+h85Xvla4XvzfkVBgqMhT86wZK4qrnsLk
	 VzMZ4NkzPBeOQcVju5rjKRzWQhu2/B7X9yMoRcG2nBqMLE8Eqvoar7H2raekces0C/ygt
	 HO3plnO3/FS20PrQDWKonGkivDgBtSODqHjCWZfQy6RVDp6WPvc9bc83sZWAJ0PrE9w==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795538749;
	h=DMARC-Filter:DKIM-Signature:Received:From:Date:Subject:MIME-Version:
	 Content-Type:Content-Transfer-Encoding:Message-Id:References:
	 In-Reply-To:To:Cc:X-Mailer:X-ZohoMailClient;
	bh=NxEUqxMS4+QPrlaTVEWgJwJSWYwUiBTj4xqIdeG8VuI=;
	b=c6hs31roB6kRA28bVebgk3uvyn8FYF5Zxf5WR+zoiaeZGMKTAuB1TlWKvx0py73UCOzE
	 v7LG4DRrhrQwTggHTHaZHW26+s+OrtJbR0GzsAOa4cYkeY2kb8ob2cqLP+vbTGDRuv70Z
	 ZPzj6eP1tiVZOK78nP5iZtRLhETAjVlZdF10IxE4mmW530ZPRhVbPWAuGgRGJOxd+Gjse
	 CVoqcunpmPf05qNgg1Ue0ImEF5/TnD0Lnbz7zW7cKGTcJ6TMJalq1mUYOOL6aWnUpmm2p
	 gvws3o6cs2dDUlA3jDTp4W6s45uFGKgwcbuw2Uxnw9khcPfb8/uJiPAfFYjWOR0YOtQ==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=rong.moe;
	spf=pass smtp.mailfrom=rong.moe;
	dkim=pass header.d=rong.moe header.i=@rong.moe header.a=rsa-sha256 header.s=zmail2048 header.b=j+SuMpjC;
	arc=pass header.oldest-pass=0 smtp.remote-ip=165.173.182.112
Received: from sender5-pp-f112.zoho.com (sender5-pp-f112.zoho.com [165.173.182.112])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DFC28606A323;
	Tue, 24 Nov 2026 16:45:48 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org DFC28606A323
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rong.moe
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rong.moe
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rong.moe header.i=@rong.moe header.a=rsa-sha256 header.s=zmail2048 header.b=j+SuMpjC
ARC-Seal: i=1; a=rsa-sha256; t=1795538706; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=hBw7/fL+7KNbfb2O6t/yUndg7jvZphFbt0KjZyW6VH/GfxRVH5PDanZiZdZswWhUnN8y3yRZzEOCYZvTYZXQuPoDyhTaZCnNHtgafWk5cJsQmNzsoDs5hg5D4Mu2/JfOPIuHNoREaqkgboy7aEcc3UEFUfpsf5WsrGLNdZT+eQY=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1795538706; h=Content-Type:Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=NxEUqxMS4+QPrlaTVEWgJwJSWYwUiBTj4xqIdeG8VuI=; 
	b=HhtG0/YORTLcH1iFSvA0p7zRqb5kS0KtedG2bngTNjE6IwSCQbXvvGzWWzggTAZsjIKEC0qXcXarjnmod99KoRmzJ1f+0ndfg1LonTIcehIXpIQJhUR+D/p1y1hNHRvwBO8XrWD8ar70tfbNiJ+8dxss76IWTv81SlwfIkgpfKE=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=rong.moe;
	spf=pass  smtp.mailfrom=i@rong.moe;
	dmarc=pass header.from=<i@rong.moe>
DKIM-Signature: a=rsa-sha256; b=j+SuMpjCQK1dtnTgay5IQIcy7CDGV3eL2KQN+OY0LydmB5njXLP9fPEGaGpzRf70YJ2PMeUJ3lsFZC3plIObpkzukmbZC2SPflVe+Q2pYqNTaqSpBaQBcz89PgrWwIymYZkJxPiMIb8+rEq3UmILHKTIxDS5/Y0ckIJfMjCvKC4dNRpf5IfTcK1TZ9rg5891JbNT9Hd8c98+JydByDOA16fsYaXMMOj3SRLgTBBIP1VSf2RtXTQIvQVgSgGYITc2ZhBGitfUaFFQLMmbGB+2rnQrQjX/VuZLrONQdnb1kiyrXC/ZqKGUaahCvS7wqqM2i6ZloO+fMqMNwApb964mIQ==; c=relaxed/relaxed; s=zmail2048; d=rong.moe; v=1; bh=NxEUqxMS4+QPrlaTVEWgJwJSWYwUiBTj4xqIdeG8VuI=; h=Content-Description:Content-ID:Content-Type:Content-Transfer-Encoding:Cc:Date:From:In-Reply-To:List-Subscribe:List-Post:List-Owner:List-Id:List-Archive:List-Help:List-Unsubscribe:MIME-Version:Message-ID:Resent-Sender:Resent-Cc:Resent-Date:Resent-To:Reply-To:Resent-Message-ID:Resent-From:Sender:Subject:To:Date:From:Message-Id:Reply-To:Subject:To:Cc;
Received: by smtp.zohomail.com with SMTPS id 1795538704996748.7946167071358;
	Tue, 24 Nov 2026 08:45:04 -0800 (PST)
From: Rong Zhang <i@rong.moe>
Date: Wed, 25 Nov 2026 00:44:29 +0800
Subject: [PATCH v4 1/9] HID: haptic: Get rid of input_ff_destroy() in error
 paths
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261125-hid-haptic-kmod-v4-1-03713a89f656@rong.moe>
References: <20261125-hid-haptic-kmod-v4-0-03713a89f656@rong.moe>
In-Reply-To: <20261125-hid-haptic-kmod-v4-0-03713a89f656@rong.moe>
To: Jiri Kosina <jikos@kernel.org>, Benjamin Tissoires <bentiss@kernel.org>, 
 Angela Czubak <aczubak@google.com>, Henrik Rydberg <rydberg@bitmath.org>, 
 Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: linux-input@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Rong Zhang <i@rong.moe>, stable@vger.kernel.org
X-Mailer: b4 0.17-dev-ce4c1
X-ZohoMailClient: External

It's painful to have error paths after calling input_ff_create(),
because input_ff_destroy() frees too much things but does not restore
some other things. For example, every error path calling
input_ff_destroy() frees ff->private, while the others don't. This
divergence has caused quite a lot of trouble.

Additionally, the driver's get_device() bail-out path calls module_put()
right before hid_haptic_destroy() calling it again, causing refcount
underflow.

Since commit 2ae35f090d02 ("Input: destroy force-feedback device on
input unregistration"), the HID device is now guaranteed to have a
longer lifetime than the FF device, making get_device()/put_device()
unnecessary.

Due to the driver being unable to build as a module since commit
083a4f3f3cc7 ("HID: Kconfig: Fix build error from CONFIG_HID_HAPTIC"),
try_module_get()/module_put() is needless, too.

Remove the said calls, so that there is no error path after
input_ff_create(), eliminating the call to input_ff_destroy(). In this
manner, we don't need to restore dev->flush and dev->event either.

Fixes: 083a4f3f3cc7 ("HID: Kconfig: Fix build error from CONFIG_HID_HAPTIC")
Cc: stable@vger.kernel.org
Suggested-by: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Link: https://msgid.link/f44447354f28c295e79a025bbcab7a4e@gmail.com
Signed-off-by: Rong Zhang <i@rong.moe>
---
Changes in v4:
- Drop get_device()/put_device() and try_module_get()/module_put()
  completely, as they are needless now (thanks Dmitry Torokhov)
---
 drivers/hid/hid-haptic.c | 25 -------------------------
 1 file changed, 25 deletions(-)

diff --git a/drivers/hid/hid-haptic.c b/drivers/hid/hid-haptic.c
index b7fadfbddc4c..c675e14f06e1 100644
--- a/drivers/hid/hid-haptic.c
+++ b/drivers/hid/hid-haptic.c
@@ -380,12 +380,8 @@ static int hid_haptic_erase(struct input_dev *dev, int effect_id)
 static void hid_haptic_destroy(struct ff_device *ff)
 {
 	struct hid_haptic_device *haptic = ff->private;
-	struct hid_device *hdev = haptic->hdev;
 	int r;
 
-	if (hdev)
-		put_device(&hdev->dev);
-
 	kfree(haptic->stop_effect.report_buf);
 	haptic->stop_effect.report_buf = NULL;
 
@@ -404,8 +400,6 @@ static void hid_haptic_destroy(struct ff_device *ff)
 
 	kfree(haptic->hid_usage_map);
 	haptic->hid_usage_map = NULL;
-
-	module_put(THIS_MODULE);
 }
 
 int hid_haptic_init(struct hid_device *hdev,
@@ -419,8 +413,6 @@ int hid_haptic_init(struct hid_device *hdev,
 	};
 	const char *prefix = "hid-haptic";
 	char *name;
-	int (*flush)(struct input_dev *dev, struct file *file);
-	int (*event)(struct input_dev *dev, unsigned int type, unsigned int code, int value);
 
 	haptic->hdev = hdev;
 	haptic->max_waveform_id = max(2u, haptic->max_waveform_id);
@@ -499,8 +491,6 @@ int hid_haptic_init(struct hid_device *hdev,
 
 	input_set_capability(dev, EV_FF, FF_HAPTIC);
 
-	flush = dev->flush;
-	event = dev->event;
 	ret = input_ff_create(dev, FF_MAX_EFFECTS);
 	if (ret) {
 		dev_err(&hdev->dev, "Failed to create ff device.\n");
@@ -513,23 +503,8 @@ int hid_haptic_init(struct hid_device *hdev,
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
 stop_buffer_free:
 	kfree(haptic->stop_effect.report_buf);
 	haptic->stop_effect.report_buf = NULL;

-- 
2.55.0

