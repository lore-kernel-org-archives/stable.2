Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.160.45
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794160339;
	b=1LO6kDws2j/Va+Iu1LWgbBE9pac5k7NawVxfRaVZpx1ki7xCmzVRH+rXRH5i6oCOY7Z8
	 +SDcPygsRyaqxgH3pQhGLdw6Qag5h3LI16BWv7f75vrpHUojmdAvFSo7fTh7oAjKoHp96
	 vtaZKCM84z5+uKGUIk2gNB1xMt3Xi41r3ogWuovCyT2e6DrUK0FvhyOisuFxP5siKfMTk
	 6XdSIjE47DqYlWk6xiEITMuiKkKUjcmosijTUwViR6TmhhlJFDB8+PtflPfS9MKEU8y/T
	 tWMy7FQGfTvVykjqXARtY3J4eo/kRjwTiUncrB12qMqm11J8xSyL28WZ3MVLHlk5kpg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794160339;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:MIME-Version:
	 Content-Transfer-Encoding;
	bh=ZbsGt/Yaewv8ArPLycAYYXmDqJHO01ChanNYScKiO+c=;
	b=V0vd+6D87On3eHifz+NvRVFStJASir4/f4iQWBrQg6aJtx0RdP4+YT7nz+jLvVoogWJt
	 C8qsuUqlPMaBm486rFnJfzDW2LSSQKbgbLkk9aS0Y/Vh3qm6R1qxorfF6o+egQAy8eHpb
	 cZownfawPh1nTaP8BxYdGif4o30uOh1Ee0grCRTgwjXCtNYYNMGhWPrbyIzIMJAf0yOap
	 A7tgPZAd759BxeGvhaOp1fJNUnmES6gnK8CMEtwgHR5JlCL+ji//h1hSeSJP6xrv0yVtS
	 YBSfT6HakJv8Zm2l2Bz9cKZmVRJiP1nNhNw9Q1TZ0PJjmuXc7SjkjRp3PaiCjsUXLLg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=nolknHvS;
	arc=none smtp.remote-ip=209.85.160.45
Received: from mail-oa1-f45.google.com (mail-oa1-f45.google.com [209.85.160.45])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0A0E9606A320
	for <stable@vger.kernel.org>; Sun,  8 Nov 2026 17:52:17 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 0A0E9606A320
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=nolknHvS
Received: by mail-oa1-f45.google.com with SMTP id 586e51a60fabf-48e2d5a69c4so92449fac.3
        for <stable@vger.kernel.org>; Sun, 08 Nov 2026 09:52:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794160337; x=1794765137; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=ZbsGt/Yaewv8ArPLycAYYXmDqJHO01ChanNYScKiO+c=;
        b=nolknHvSLtnEw0mNYq1xDNKKwNZ80yOhtr4P6+0Cly55+qNwwJ0aLUpghOW397MonE
         arPaf4+fjBCN7cj6gVPvczwqp/iQwZk7JFvP/O32pG1miypIAXCxNbZuClZulIsjmKtx
         MC7mIWP4eVReH5yy1ggGYsEl5lRDNXM6zqiE4chPSAqFV/t55pzBECUIdRmvDnX29IMQ
         S4EfhVU5QKlReigkhwALskWeIREbV+1XnrTllMuG/9OkOBzkCmyyv8VKrkUUtsFteeAM
         AKRPgCFSrGvn9b0wXV1AQekQdPWe4/Qu0K0eSFxHdzTnDQSiMq7ZFuZKCeZ+hqzJDrqK
         U6FA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794160337; x=1794765137;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=ZbsGt/Yaewv8ArPLycAYYXmDqJHO01ChanNYScKiO+c=;
        b=BWwVuxqAwBcSCvWf1SESUSkkpdJWilSQU+c1A4reycGzjXNFsYYM14O5gvWQo5y/vL
         dhymUoohjUvr6ilupsFJY7iTBP2yUhfdYlMsaGXXsrBsB148OrGPoKynYCPRTT2zkHjS
         ABFwX9Vmm36efYCSSUcsBfKVt5U1zaProfK19UWPZlj/wMbGA7cbSgXNP1uWWO3iWS7s
         VPKOGlhu5XJyivVdblktEUScOyn5ciDygqTbpyzryQvH2RcoTmm/viMIEXw7FtrRLykE
         8+4iEuJFQ3AFxAAk/BGuCl1NPqGcHrCtQgNRQWtUVYm09jjRvtpfDJ2Mm93JST8ejKdy
         1ESg==
X-Forwarded-Encrypted: i=1; AL+hErHdCGZ4Gc3+8zHwyqW42P6s5QMCJsKsgkvVRguuLSFVQtbLqKzoU6w+iZ32dAWUfb9ofRgYd/0=@vger.kernel.org
X-Gm-Message-State: APuU4Z/PlLmj23NHqAUItaCOo9gNVcD8rj53s4QO1hzxj/77eyq35Sw5
	S0hpt0b4CmNFtwM7rpCBHlPAfOMF8YtMvmnQIHKUmjUjnp8SCv1RMmvb
X-Gm-Gg: AYBFou2ZXKyXxyzWXCxBL5BJp1mEPr6t+C7MeA3Lb3UpnmbkyDOCunNxA6QR14ALb+o
	n3zCdqXUtpLQ2FhHrVV/WTRU06reYIL0BnM1s4zquk3WcTO9M7ZylT8hvIPkxzjRpmizIGeOl+j
	9LLGCIYPCpwGF3g/JuAvswlb+wqXKUdZ5g66D7rS6jyOjEe7dddt6GaYSqJE9/udOjD5/QSf0Cz
	7u+0X05RGNrNfNyVtrdOS50yomoJcvgz8ZOrb6fGfO7VA6hwpyQtPs8FbL+OJ1w8l+RhjTERT2Z
	6R3CE4QHK/xDwEHXjGc4PLV+cLrp8qhkboa2jbvRXXgIuNNgvxeF2eCDEqNlWdZkq1sbn/ou2Lm
	ZQ0aGoi42YMpfkLK0BHkFVcr1yt4oUcKGguMnQHK7r0bhnn23C5gtloDref6mCr8CF25W/p4o/2
	9hMGYBsxw2Z/CnJUnolJEAC5ZOo6Ww1A+QEBvv/rLLy7GIo904N6fQeiVljYgyUWcC+Ue3B2dbl
	6/PaToOGaDj6IvDJ36lV8RSABzADp19HiLdjwf8weEOZ1jF0+saYVHS5A54QjoHOnxDI+7bfqw0
	e+HExFsW0paR1T/gyEMqcmqFJKosdwkLxtjCXZVUKmEgNfAI
X-Received: by 2002:a05:6871:3321:b0:4a6:fa51:3c89 with SMTP id 586e51a60fabf-4adecbadfb9mr1009105fac.51.1794160336736;
        Sun, 08 Nov 2026 09:52:16 -0800 (PST)
Received: from hj.. ([163.239.22.29])
        by smtp.gmail.com with ESMTPSA id 586e51a60fabf-4ade6a26d74sm2682674fac.15.2026.11.08.09.52.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 08 Nov 2026 09:52:15 -0800 (PST)
From: hyunjungg <hj351016@gmail.com>
To: Jiri Kosina <jikos@kernel.org>
Cc: Benjamin Tissoires <bentiss@kernel.org>,
	Dmitry Torokhov <dmitry.torokhov@gmail.com>,
	linux-input@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org,
	Hyunjung Ko <hj351016@gmail.com>
Subject: [PATCH v2] HID: microsoft: fix use-after-free of ff_worker on teardown
Date: Mon,  9 Nov 2026 02:52:05 +0900
Message-ID: <20261108175205.722820-1-hj351016@gmail.com>
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
report; ms (and ms->output_report_dmabuf) is devm-allocated, so it is
freed by devres after ms_remove() returns. The work was never cancelled
on teardown, so ms_ff_worker() could run against freed memory.

Draining the work is not quite enough on its own:

 - hid_hw_stop() in ms_remove() unregisters the input device, whose
   teardown (input_ff_flush() -> ms_play_effect()) can re-queue ff_worker,
   so the work must be cancelled *after* hid_hw_stop(), not before;
 - ff_worker was only INIT_WORK()'d in ms_input_configured() for devices
   with force-feedback, so cancelling it unconditionally would hit the
   WARN_ON(!work->func) in __flush_work() for the other MS devices; and
 - if hid_hw_start() fails in ms_probe() after force-feedback was
   registered, its unwind can likewise schedule ff_worker, which was then
   left pending when ms_probe() returned.

Initialise ff_worker unconditionally in ms_probe() (so it is always valid
to cancel), cancel it on the hid_hw_start() error path, and cancel it in
ms_remove() after hid_hw_stop().

Not runtime-tested (requires MS force-feedback hardware).

Fixes: 73c5b254c365 ("HID: microsoft: Add rumble support for Xbox One S controller")
Cc: stable@vger.kernel.org
Signed-off-by: Hyunjung Ko <hj351016@gmail.com>
---
v2: Address the review of v1 (which just added cancel_work_sync before
    hid_hw_stop):
    - Cancel ff_worker AFTER hid_hw_stop(), since the input-device teardown
      in hid_hw_stop() can re-queue it via input_ff_flush() ->
      ms_play_effect().
    - Initialise ff_worker unconditionally in ms_probe() so cancelling it
      does not hit WARN_ON(!work->func) for non-FF MS devices (it was only
      INIT_WORK()'d for FF devices in ms_input_configured()).
    - Also cancel it on the ms_probe() hid_hw_start() error path, where a
      failed start can likewise leave the work queued.

    v1: https://lore.kernel.org/linux-input/20261108133821.535139-1-hj351016@gmail.com/
 drivers/hid/hid-microsoft.c | 21 ++++++++++++++++++---
 1 file changed, 18 insertions(+), 3 deletions(-)

diff --git a/drivers/hid/hid-microsoft.c b/drivers/hid/hid-microsoft.c
index a7d3493..1042a52 100644
--- a/drivers/hid/hid-microsoft.c
+++ b/drivers/hid/hid-microsoft.c
@@ -334,9 +334,6 @@ static int ms_input_configured(struct hid_device *hdev, struct hid_input *hidinp
 	if (!list_is_first(&hidinput->list, &hdev->inputs))
 		return 0;
 
-	ms->hdev = hdev;
-	INIT_WORK(&ms->ff_worker, ms_ff_worker);
-
 	ms->output_report_dmabuf = devm_kzalloc(&hdev->dev,
 						sizeof(struct xb1s_ff_report),
 						GFP_KERNEL);
@@ -361,6 +358,14 @@ static int ms_probe(struct hid_device *hdev, const struct hid_device_id *id)
 
 	hid_set_drvdata(hdev, ms);
 
+	/*
+	 * Initialise ff_worker unconditionally so it is always valid to
+	 * cancel on the probe-error and remove paths, even for devices
+	 * without force-feedback (where it is never scheduled).
+	 */
+	ms->hdev = hdev;
+	INIT_WORK(&ms->ff_worker, ms_ff_worker);
+
 	if (quirks & MS_NOGET)
 		hdev->quirks |= HID_QUIRK_NOGET;
 
@@ -377,6 +382,7 @@ static int ms_probe(struct hid_device *hdev, const struct hid_device_id *id)
 				HID_CONNECT_HIDINPUT_FORCE : 0));
 	if (ret) {
 		hid_err(hdev, "hw start failed\n");
+		cancel_work_sync(&ms->ff_worker);
 		return ret;
 	}
 
@@ -384,7 +390,16 @@ static int ms_probe(struct hid_device *hdev, const struct hid_device_id *id)
 }
 static void ms_remove(struct hid_device *hdev)
 {
+	struct ms_data *ms = hid_get_drvdata(hdev);
+
+	/*
+	 * hid_hw_stop() unregisters the input device, whose teardown can
+	 * re-queue ff_worker via input_ff_flush() -> ms_play_effect(). Drain
+	 * the work after hid_hw_stop() so it cannot run against the
+	 * devm-freed ms once ms_remove() returns.
+	 */
 	hid_hw_stop(hdev);
+	cancel_work_sync(&ms->ff_worker);
 }
 
 static const struct hid_device_id ms_devices[] = {
-- 
2.43.0

