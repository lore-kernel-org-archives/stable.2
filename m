Received: from mail-dy1-f172.google.com (mail-dy1-f172.google.com [74.125.82.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7D4BD3CF024
	for <stable@vger.kernel.org>; Tue, 16 Jun 2026 05:12:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781586769; cv=none; b=jXww8i8BNlrHpJghdYrNdO7/2l/Px/wbyvm+ftNyoE4F7HdCRReC1FakWlLtCnsDBpI2MgeHsQCIx6/8Db+2AHgbzQnm9ArmHM2IziPamTiTk7Nkhnlo0Zw1s7LIsIcPvanXXffNZBe1k7eI/7eput6nyMeoiUuD/GbbTHAOiEM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781586769; c=relaxed/simple;
	bh=KCxdB9tKuM8Ldh97gSu/cGjuHoW55vbxKxPCupj1cXg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=FYYU5U103vuTSOCYIZzGPL3e/5c42a5r+NKUBsj+jF3FCCtqF84+h3NrSm+uldrq8D9YK+7cA0qY1DgPJP9rPpG6UrwCeC7RPj83rd40e/8zFt7XfNjmuNk/AVY4+WmH0guuXd9TAw2oxE92wzyK3jl52JOUAT3zTd6YRJzQcNM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=tM1nCD71; arc=none smtp.client-ip=74.125.82.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="tM1nCD71"
Received: by mail-dy1-f172.google.com with SMTP id 5a478bee46e88-304ec41197bso4620902eec.1
        for <stable@vger.kernel.org>; Mon, 15 Jun 2026 22:12:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1781586768; x=1782191568; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=sCZvnCGRlKO/jFEMUOCjlpNZ45nZwP99ZmU//Z3m5ok=;
        b=tM1nCD71TetJyAoZcU6wbpGzeebzgst1hHV/EYTA7aglEu5meOkOo3F1MEKHKeDHFb
         4jQs26TaJMxa06JD+GYXFafBStMIjEFGR4RuL96CA17RikkqPwIqd9CgXkA3FIYX8xG6
         RYcXV41epr3IELliLSvOs9BPY+W3Ib8MiLEtaeuN63DEVZvVAij1t6FWELf9rQhSVcgT
         MxY1YSrvtAPxlSJ+zdOfbLxmt2cZiNAotyKxH+gcCb3KfREv4CvHONJ5MnFdi3ZsH0K2
         L0OnDflLcsy+RAy6b5pLOVGKUBNfuodjShDEUIcL3HVChd+PZ/awL64YFyAvXO6tH+h/
         uxZg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781586768; x=1782191568;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=sCZvnCGRlKO/jFEMUOCjlpNZ45nZwP99ZmU//Z3m5ok=;
        b=W0P++q07v4ybtvpnsLNfYfTyRe17x24YLCICUvZPUusKqEBhtv1WIDgs60fI0VLxUV
         HxlzGDyUiVG3/wRc9EQITqNQ/umYrT5kzS7W1nFfPXGLp2HVlszHoHu1LdwtXsuZK55N
         Dp23rPVrlbPRKsYHhnVR80DZuoK5wpp5xlWmoD0HB+Hw375Q+LNsJwPCur9l5+QOisTt
         yP6hTLwlKTqV+g+XDxCy8KPOu746CvdTmXqZ19NKjOrhg7w3GB7tzjnC0cpGpc4TfE5J
         DRqdde/aVSNnnLqRZuNKLhpgEI2ZvR8nB7onHBK0LGMBqfw9IDIm9OHju7CKmdVb1iCJ
         9CJw==
X-Forwarded-Encrypted: i=1; AFNElJ/EF9J3hiZI8DBlzORVkS9Y12PrgIOgpkl0q4QFjif4umcooMRS0SAyA62kuyadktyOBPeAIxo=@vger.kernel.org
X-Gm-Message-State: AOJu0YxKFiwNZPIJErkqcVajl0jogTMpBQ0zDT7vwFdg3YRhfHARdss+
	40vUI/noeSGB2u8BLcuzkjxdY4/ITfDJD31dLlai2QX2u4Mg0pdD2Nmb
X-Gm-Gg: Acq92OFTVEDtVufZJXRiaEOfXOxVKDKoxhMaB4fIiwX7peN7XqkDH+87ZeEwRCXCkK1
	hcxWkUfG9ebWGA0HpiIQ7+1bOYd5Ium1WmIryajdlpPO0yr09CAP3UazKTfJU1KRSbnCVuf8fHG
	sJhzGTJSgMsVfHXsRIhNmSVcwHu3CvINjbgJfIVqzXH653Lmp31x7db6hX5/dpjkZVR1NMn5GVE
	fXq0jqYG+05LIEj/5EsqSDHNtnJFZUWRC1Wy7upXfuDSz6G5e3bd+4jcnxQK07b0bHNScH7qRcd
	aOC+p+J+WSi3yB298VnN5HfdgR+xTh32VWhAQc2wDmvzeLhgGKtqrSoflTxi/8cxKWNh6P8PzyP
	eQC/+WpXd68ed+LMtnxae1MUfneZcFnhVc7Qr1Uv5NEh1Bc4ShFMGHFTYP9rAmzEWtu+t7bitYk
	duNL06IZiz7ukBZFtwyksT1pEw7k09E0DbTR9LhxrsE808HEE5asy7eAlR5lB24YyimyNPCrzrg
	TzaHTxkQQv7ss0=
X-Received: by 2002:a05:7300:4346:b0:2ed:e14:e956 with SMTP id 5a478bee46e88-30ba5fce46dmr1210450eec.32.1781586767417;
        Mon, 15 Jun 2026 22:12:47 -0700 (PDT)
Received: from dtor-ws.sjc.corp.google.com ([2a00:79e0:2ebe:8:3714:f5c2:9b83:3df1])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-3081ea43b80sm16726052eec.21.2026.06.15.22.12.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 15 Jun 2026 22:12:46 -0700 (PDT)
From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
To: Hans Verkuil <hverkuil@kernel.org>,
	linux-input@vger.kernel.org
Cc: linux-kernel@vger.kernel.org,
	sashiko-bot@kernel.org,
	stable@vger.kernel.org
Subject: [PATCH 3/4] Input: sur40 - factor out and move input device initialization
Date: Mon, 15 Jun 2026 22:12:31 -0700
Message-ID: <20260616051235.1549517-3-dmitry.torokhov@gmail.com>
X-Mailer: git-send-email 2.54.0.1136.gdb2ca164c4-goog
In-Reply-To: <20260616051235.1549517-1-dmitry.torokhov@gmail.com>
References: <20260616051235.1549517-1-dmitry.torokhov@gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The input device allocation, setup, and registration in sur40_probe() is
quite verbose. Factor it out into a helper function sur40_init_input() to
improve readability.

Additionally, call this helper at the very end of sur40_probe() instead of
allocating the input device early. This ensures all video components are fully
initialized before the input device is registered (which starts polling),
and simplifies the early probe error paths since we don't have to carry and
free the input device if probe fails during early V4L2 setup.

Reported-by: sashiko-bot@kernel.org
Cc: stable@vger.kernel.org
Assisted-by: Antigravity:gemini-3.5-flash
Signed-off-by: Dmitry Torokhov <dmitry.torokhov@gmail.com>
---
 drivers/input/touchscreen/sur40.c | 91 +++++++++++++++++--------------
 1 file changed, 50 insertions(+), 41 deletions(-)

diff --git a/drivers/input/touchscreen/sur40.c b/drivers/input/touchscreen/sur40.c
index e9089b0c3e2f..1ad68131e3a6 100644
--- a/drivers/input/touchscreen/sur40.c
+++ b/drivers/input/touchscreen/sur40.c
@@ -647,6 +647,53 @@ static int sur40_input_setup_events(struct input_dev *input_dev)
 	return 0;
 }
 
+static int sur40_init_input(struct sur40_state *sur40)
+{
+	struct input_dev *input;
+	int error;
+
+	input = input_allocate_device();
+	if (!input)
+		return -ENOMEM;
+
+	/* Set up regular input device structure */
+	input->name = DRIVER_LONG;
+	usb_to_input_id(sur40->usbdev, &input->id);
+	usb_make_path(sur40->usbdev, sur40->phys, sizeof(sur40->phys));
+	strlcat(sur40->phys, "/input0", sizeof(sur40->phys));
+	input->phys = sur40->phys;
+	input->dev.parent = sur40->dev;
+
+	input->open = sur40_open;
+	input->close = sur40_close;
+
+	error = sur40_input_setup_events(input);
+	if (error)
+		goto err_free_input;
+
+	input_set_drvdata(input, sur40);
+	error = input_setup_polling(input, sur40_poll);
+	if (error) {
+		dev_err(sur40->dev, "failed to set up polling\n");
+		goto err_free_input;
+	}
+
+	input_set_poll_interval(input, POLL_INTERVAL);
+
+	error = input_register_device(input);
+	if (error) {
+		dev_err(sur40->dev, "Unable to register polled input device.\n");
+		goto err_free_input;
+	}
+
+	sur40->input = input;
+	return 0;
+
+err_free_input:
+	input_free_device(input);
+	return error;
+}
+
 /* Check candidate USB interface. */
 static int sur40_probe(struct usb_interface *interface,
 		       const struct usb_device_id *id)
@@ -655,7 +702,6 @@ static int sur40_probe(struct usb_interface *interface,
 	struct sur40_state *sur40;
 	struct usb_host_interface *iface_desc;
 	struct usb_endpoint_descriptor *endpoint;
-	struct input_dev *input;
 	int error;
 
 	/* Check if we really have the right interface. */
@@ -676,44 +722,13 @@ static int sur40_probe(struct usb_interface *interface,
 	if (!sur40)
 		return -ENOMEM;
 
-	input = input_allocate_device();
-	if (!input) {
-		error = -ENOMEM;
-		goto err_free_dev;
-	}
-
 	/* initialize locks/lists */
 	INIT_LIST_HEAD(&sur40->buf_list);
 	spin_lock_init(&sur40->qlock);
 	mutex_init(&sur40->lock);
 
-	/* Set up regular input device structure */
-	input->name = DRIVER_LONG;
-	usb_to_input_id(usbdev, &input->id);
-	usb_make_path(usbdev, sur40->phys, sizeof(sur40->phys));
-	strlcat(sur40->phys, "/input0", sizeof(sur40->phys));
-	input->phys = sur40->phys;
-	input->dev.parent = &interface->dev;
-
-	input->open = sur40_open;
-	input->close = sur40_close;
-
-	error = sur40_input_setup_events(input);
-	if (error)
-		goto err_free_input;
-
-	input_set_drvdata(input, sur40);
-	error = input_setup_polling(input, sur40_poll);
-	if (error) {
-		dev_err(&interface->dev, "failed to set up polling");
-		goto err_free_input;
-	}
-
-	input_set_poll_interval(input, POLL_INTERVAL);
-
 	sur40->usbdev = usbdev;
 	sur40->dev = &interface->dev;
-	sur40->input = input;
 
 	/* use the bulk-in endpoint tested above */
 	sur40->bulk_in_size = usb_endpoint_maxp(endpoint);
@@ -722,7 +737,7 @@ static int sur40_probe(struct usb_interface *interface,
 	if (!sur40->bulk_in_buffer) {
 		dev_err(&interface->dev, "Unable to allocate input buffer.");
 		error = -ENOMEM;
-		goto err_free_input;
+		goto err_free_dev;
 	}
 
 	/* register the video master device */
@@ -790,13 +805,9 @@ static int sur40_probe(struct usb_interface *interface,
 		goto err_free_ctrl;
 	}
 
-	/* register the polled input device */
-	error = input_register_device(input);
-	if (error) {
-		dev_err(&interface->dev,
-			"Unable to register polled input device.");
+	error = sur40_init_input(sur40);
+	if (error)
 		goto err_unreg_video;
-	}
 
 	/* we can register the device now, as it is ready */
 	usb_set_intfdata(interface, sur40);
@@ -812,8 +823,6 @@ static int sur40_probe(struct usb_interface *interface,
 	v4l2_device_unregister(&sur40->v4l2);
 err_free_buffer:
 	kfree(sur40->bulk_in_buffer);
-err_free_input:
-	input_free_device(input);
 err_free_dev:
 	kfree(sur40);
 
-- 
2.54.0.1136.gdb2ca164c4-goog

