Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=165.173.180.112
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1795538771;
	b=iCzSjvnXRoV4UWPeA0KIdz3wo/BciYFljJIHKnirqcv9bgCdA2cgrwOdrTnlHLoIeRRn
	 2ZChNic9pX5aaZFU0BN7r7StqfrCytvOEg0mfMWXItt2P5bPadibgcCv7bPiGjUegr2as
	 GSLW7YDBVK/NOL9gZNpdwmrLGmDGYwytcHVuN+16+c/Ivbes9D7LaL2oVq8ByvNIHwgKk
	 ijLg8BG5+sMPBjMrJO3W+VIp7h6/tDw3kOioQmdF0nN1jDb8OWDAi86zEFdhBRsxFAn6Y
	 eNKCzXa4uqNuD5auJZaroIvoUEQ/K0y8sOWeqy1vrQH3yg1hUTopcTueoWGy3Q0G0YQ==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795538771;
	h=DMARC-Filter:DKIM-Signature:Received:From:Date:Subject:MIME-Version:
	 Content-Type:Content-Transfer-Encoding:Message-Id:References:
	 In-Reply-To:To:Cc:X-Mailer:X-ZohoMailClient;
	bh=LLDJu6OWDDnxUrH9ZzdDynPpPEVIR3ZLD1JnVoiACwQ=;
	b=PvUKCBSash++XBKB+GELwf/tceXewK9lSf5pZVzGqV7jEwBC4s8UumzUm420SwEaFX0I
	 gswi9cMMZF1/VCr3V5tnrt6kFKiSVuXSx4aURk8nk6v7iYDL36YLRe08Ji4r4RfQzs1gC
	 Pxeoa/smWoefJhH57nap+2xTUsPhpIfHJ7l0pwMl9wGruTj4KemSdACQpCVzNolLjzxpA
	 CvW6YxoLFqJYD4GfNqOvAEq7N56I9x8+STgD/V9nbDIp5Cro1uhnLZXgLpKddP+rH1XWZ
	 dwiP3mTgyJAmvjTRcGSIP1Q6LEK26k9oTrozIbwgYYl8Zmog79HTQiFwcaxZeO4zsTQ==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=rong.moe;
	spf=pass smtp.mailfrom=rong.moe;
	dkim=pass header.d=rong.moe header.i=@rong.moe header.a=rsa-sha256 header.s=zmail2048 header.b=O0Rwmv3v;
	arc=pass header.oldest-pass=0 smtp.remote-ip=165.173.180.112
Received: from sender6-pp-f112.zoho.com (sender6-pp-f112.zoho.com [165.173.180.112])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B782E606A32A;
	Tue, 24 Nov 2026 16:46:10 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org B782E606A32A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rong.moe
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rong.moe
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rong.moe header.i=@rong.moe header.a=rsa-sha256 header.s=zmail2048 header.b=O0Rwmv3v
ARC-Seal: i=1; a=rsa-sha256; t=1795538712; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=cKsZNJ7qU1wrZ1U4Qk+6ohy5g1V48TtQ/F0petrsADM6wkQXIGoLiX7aETnggdJWv5MhS2VUru6TIvPyPxFymfXoxoCwK9L/z+7SRLj0+hkBikTPE5e24/FpdWUZm52xoiIRP34M6AUXw0S1ItzQb9KlrSUVgMVE3tlqMwwqIRc=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1795538712; h=Content-Type:Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=LLDJu6OWDDnxUrH9ZzdDynPpPEVIR3ZLD1JnVoiACwQ=; 
	b=V77ODUPDk57ZzSDOjcyBeh7p5V3RUn8GS960fk8YaXYXP0OGlZHkUYQ4xz1Y9qKtfnwBd83HzQsOTePV/aHHrp+4z0V9XeAUjk19rpCwhzT0Ay6729nvXSqbtVkHluAjeBUzKXT374/T4kHbvH35dDx4ZVhEQ6cVmskkuGiEOtk=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=rong.moe;
	spf=pass  smtp.mailfrom=i@rong.moe;
	dmarc=pass header.from=<i@rong.moe>
DKIM-Signature: a=rsa-sha256; b=O0Rwmv3vykpbANs0HEC8581nKFrMcl0vBw44nfN3wGmx5vB6g3AV+EE+Yb+mnZJyu0dCdOsJb6a5cbiChwPE0sbvX8Z1zqPfiv2MU86I5Y65QdmPtBtlkHHl3Qg9dZY3ejFPoyaABkLpERWVEfZdMqfb8jdtVJB4K+zhqRczYymclORjR/0AZdymQd4QLpD5yFi8FN548xFSxBtG9bVD8tdwb9YI3bLt+GH6ELpCiNAHGEZk4fHbIDgfxPNfoc0JexuDOA1B+qoRxm93gZplVJ+kLV2mBKkp5pG4OdAZ4359Sv+RJDPdsL6DAfwNrgLdhwZScq35/xTCfkNAxwP+Dg==; c=relaxed/relaxed; s=zmail2048; d=rong.moe; v=1; bh=LLDJu6OWDDnxUrH9ZzdDynPpPEVIR3ZLD1JnVoiACwQ=; h=Content-Description:Content-ID:Content-Type:Content-Transfer-Encoding:Cc:Date:From:In-Reply-To:List-Subscribe:List-Post:List-Owner:List-Id:List-Archive:List-Help:List-Unsubscribe:MIME-Version:Message-ID:Resent-Sender:Resent-Cc:Resent-Date:Resent-To:Reply-To:Resent-Message-ID:Resent-From:Sender:Subject:To:Date:From:Message-Id:Reply-To:Subject:To:Cc;
Received: by smtp.zohomail.com with SMTPS id 1795538709263532.7347938450698;
	Tue, 24 Nov 2026 08:45:09 -0800 (PST)
From: Rong Zhang <i@rong.moe>
Date: Wed, 25 Nov 2026 00:44:30 +0800
Subject: [PATCH v4 2/9] HID: haptic: Fix use-after-free when draining
 workqueue
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
Message-Id: <20261125-hid-haptic-kmod-v4-2-03713a89f656@rong.moe>
References: <20261125-hid-haptic-kmod-v4-0-03713a89f656@rong.moe>
In-Reply-To: <20261125-hid-haptic-kmod-v4-0-03713a89f656@rong.moe>
To: Jiri Kosina <jikos@kernel.org>, Benjamin Tissoires <bentiss@kernel.org>, 
 Angela Czubak <aczubak@google.com>, Henrik Rydberg <rydberg@bitmath.org>, 
 Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: linux-input@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Rong Zhang <i@rong.moe>, stable@vger.kernel.org
X-Mailer: b4 0.17-dev-ce4c1
X-ZohoMailClient: External

The haptic->wq is destroyed after freeing effects and their report
buffers, which is too late. If any work is still pending or running
before the workqueue destruction, haptic_work_handler() will access the
just-freed contents, causing a use-after-free.

Fix it by destroying the workqueue before putting the HID device and
freeing haptic resources. The allocation sequence is also adjusted to
the reverse.

Since the workqueue allocation is anyway touched, also replace the
legacy creation API with the modern alloc_ordered_workqueue(). In this
manner, the temporary buffer on heap can be replaced by the API's
formatting.

Also call __clear_bit(EV_FF, dev->evbit) in the bail-out path to match
the behavior of input_ff_destroy().

Fixes: 344ff3584957 ("HID: haptic: initialize haptic device")
Cc: stable@vger.kernel.org
Signed-off-by: Rong Zhang <i@rong.moe>
---
 drivers/hid/hid-haptic.c | 36 ++++++++++++++++--------------------
 1 file changed, 16 insertions(+), 20 deletions(-)

diff --git a/drivers/hid/hid-haptic.c b/drivers/hid/hid-haptic.c
index c675e14f06e1..8312b8edc847 100644
--- a/drivers/hid/hid-haptic.c
+++ b/drivers/hid/hid-haptic.c
@@ -382,6 +382,9 @@ static void hid_haptic_destroy(struct ff_device *ff)
 	struct hid_haptic_device *haptic = ff->private;
 	int r;
 
+	destroy_workqueue(haptic->wq);
+	haptic->wq = NULL;
+
 	kfree(haptic->stop_effect.report_buf);
 	haptic->stop_effect.report_buf = NULL;
 
@@ -392,9 +395,6 @@ static void hid_haptic_destroy(struct ff_device *ff)
 	}
 	haptic->effect = NULL;
 
-	destroy_workqueue(haptic->wq);
-	haptic->wq = NULL;
-
 	kfree(haptic->duration_map);
 	haptic->duration_map = NULL;
 
@@ -411,8 +411,6 @@ int hid_haptic_init(struct hid_device *hdev,
 	struct ff_haptic_effect stop_effect = {
 		.hid_usage = HID_HP_WAVEFORMSTOP & HID_USAGE,
 	};
-	const char *prefix = "hid-haptic";
-	char *name;
 
 	haptic->hdev = hdev;
 	haptic->max_waveform_id = max(2u, haptic->max_waveform_id);
@@ -447,20 +445,11 @@ int hid_haptic_init(struct hid_device *hdev,
 	haptic->manual_trigger_report_len =
 		hid_report_len(haptic->manual_trigger_report);
 	mutex_init(&haptic->manual_trigger_mutex);
-	name = kmalloc(strlen(prefix) + strlen(hdev->name) + 2, GFP_KERNEL);
-	if (name) {
-		sprintf(name, "%s %s", prefix, hdev->name);
-		haptic->wq = create_singlethread_workqueue(name);
-		kfree(name);
-	}
-	if (!haptic->wq) {
-		ret = -ENOMEM;
-		goto duration_map;
-	}
+
 	haptic->effect = kzalloc_objs(struct hid_haptic_effect, FF_MAX_EFFECTS);
 	if (!haptic->effect) {
 		ret = -ENOMEM;
-		goto output_queue;
+		goto duration_map;
 	}
 	for (r = 0; r < FF_MAX_EFFECTS; r++) {
 		haptic->effect[r].report_buf =
@@ -489,12 +478,18 @@ int hid_haptic_init(struct hid_device *hdev,
 	fill_effect_buf(haptic, &stop_effect, &haptic->stop_effect,
 			HID_HAPTIC_ORDINAL_WAVEFORMSTOP);
 
+	haptic->wq = alloc_ordered_workqueue("hid-haptic %s", WQ_MEM_RECLAIM, hdev->name);
+	if (!haptic->wq) {
+		ret = -ENOMEM;
+		goto stop_buffer_free;
+	}
+
 	input_set_capability(dev, EV_FF, FF_HAPTIC);
 
 	ret = input_ff_create(dev, FF_MAX_EFFECTS);
 	if (ret) {
 		dev_err(&hdev->dev, "Failed to create ff device.\n");
-		goto stop_buffer_free;
+		goto reset_evbit;
 	}
 
 	ff = dev->ff;
@@ -505,6 +500,10 @@ int hid_haptic_init(struct hid_device *hdev,
 	ff->destroy = hid_haptic_destroy;
 	return 0;
 
+reset_evbit:
+	__clear_bit(EV_FF, dev->evbit);
+	destroy_workqueue(haptic->wq);
+	haptic->wq = NULL;
 stop_buffer_free:
 	kfree(haptic->stop_effect.report_buf);
 	haptic->stop_effect.report_buf = NULL;
@@ -513,9 +512,6 @@ int hid_haptic_init(struct hid_device *hdev,
 		kfree(haptic->effect[r].report_buf);
 	kfree(haptic->effect);
 	haptic->effect = NULL;
-output_queue:
-	destroy_workqueue(haptic->wq);
-	haptic->wq = NULL;
 duration_map:
 	kfree(haptic->duration_map);
 	haptic->duration_map = NULL;

-- 
2.55.0

