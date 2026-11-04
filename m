Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1793785378;
	b=dbfgwzpeSFW9dotxf8j3dyGzSVm4efLniFXcSWmCFsxTHs96+XAwt7ghNJVvVzmHHZ5S
	 d3YWPfVtAKkdVM1AWzddrqM4d2aBsvdI6/erY8sMTiBhtaolp4vyv8MF6bKgDymBrTLOU
	 RUGmHMDNrdprQrxM6NdVCAKJqwkngDkvYUhgBVqj5M9huJR/QUfKWQib+5Hwy/S3hN+nF
	 BO1YZiWURFA2IOJ7z56WDfsQ5cX7mp2d839LNGlhDVrNVTkGR/MUdZHICX3VFYJimN3Si
	 mnsIDooOROeFMkmU+i5xD4GJ+eTo/ZJO5yLnPmoBE2sFSu7WVSE0MiJbq0L9ZZQTi6g==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793785378;
	h=Received:DKIM-Signature:Received:From:Date:Subject:MIME-Version:
	 Content-Type:Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
	 X-Original-From:Reply-To:Content-Transfer-Encoding;
	bh=yQ7xKLTNb/iiYDHuD04QbANNeHHKZXD8bdhyGqyPxF4=;
	b=W0ejAkvwLIB3rorCKs4qURDFP+D+GcB+CSb3oUe7hmhmEtEHnTiXsx7XE3qi/qWN5kBb
	 VdUJEgyw2aB4fsnGmida8RITQBvikxrQe/CsEx2OkZv3zMSzFVrFoo4S9KFduo3D36Arl
	 IhNnVgfBEmqOsIIYGFEtMge1hfN34NPF2RbGm2wSL7qFan11fb6NbWBI3q8RL1bjJVL/x
	 V1MARWSMDlwMIcyEPujz54hnRp67cvVvB0rOM9B26Ew+usti/HuiJ4CGftbNmDa/WBBkr
	 oGfTRk4mZtNb//sCmf0wPr+s+z7WniERio+RcOasa//S6TqpChncyZoDODgit0Uorqg==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=iqB36GAh;
	arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 939B3606A32C;
	Wed,  4 Nov 2026 09:42:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=iqB36GAh
Authentication-Results: smtp.kernel.org; arc=none smtp.remote-ip=100.80.115.77
ARC-Seal: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256; cv=none;
	t=1793785378;
	b=I9wS48WuB5MR33c6W5RAcZ5IlITfT6aHWGPfqpjUGjGX3+PKHrrPNG8WhQN3olsvic9M
	 cf+lGhD+mf+kFKA+u7y4lpi3YDGMPEcQGFflKGk5FshIgS3bAJ2AnK1mU0icc3R+937fF
	 NtZsD9JOS25a5QvU3tbp4ZKn//QGzEZnYfqHJrEL7GLal+JTBp0bBAabKQnG1rrOfSkPb
	 fk3hvjk06mUjXY60U4oZCMhYuTd9AlsIzxIja4UHfoMMyrJwUhbS2Hw3MO2r11YNZLiQw
	 WkvmAn6tgQNkxlSQeAGp5U1xiR4VyZ85UpY5Y1aqlAnpNt80xSbgcmsOELIgXsq00oQ==
ARC-Message-Signature: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256;
	c=relaxed/relaxed; t=1793785378;
	h=DKIM-Signature:Received:From:Date:Subject:MIME-Version:Content-Type:
	 Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
	 X-Original-From:Reply-To:Content-Transfer-Encoding;
	bh=yQ7xKLTNb/iiYDHuD04QbANNeHHKZXD8bdhyGqyPxF4=;
	b=NmgoFWIjt6jnBtcRzoDxPlj5gJA8mURNB9nSb2g1jVhNzjuCVLOUuEpyxEKOOuD7ZaqU
	 nNJaKsvFCz4N5r2/JJ+wnCSQfwC96FLapNgjW9sIF+wMETftQl8OW7/nu0pMFPEQIu8RM
	 +OSjnpJDDjWhnWA5IwC/fz/QdYPS4vMT3FLiPHJnUXyG8eltHppRYLdEykQeYFLhnTj9m
	 fNl2U/SOAFEYAHi3WOHCwVL3OjfPg3Tmtf3RRu49XRcaX+GnSuR41drycV+B7jx/at9Nb
	 aqf7ChrILAqQWjv0C0FE82tNjQf5z+ksNI/A1Qun1Yho0pJSb5+vIzIYgfh2gRzgHSg==
ARC-Authentication-Results: i=1; smtp.kernel.org; 
	arc=none smtp.remote-ip=100.80.115.77
Received: from lkml.kernel.org (nexus.subspace.kernel.org [100.80.115.77])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.kernel.org (Postfix) with ESMTPS id 791941F000C1;
	Wed,  4 Nov 2026 09:42:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793785378;
	bh=yQ7xKLTNb/iiYDHuD04QbANNeHHKZXD8bdhyGqyPxF4=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To;
	b=iqB36GAh6XQLg+q5lfh2D75QUeUZmrx9Cf7l7YEFO02yNUcVhzuYTb4N7vnj6paTt
	 1YuhXPXeQUB7vEU3zZ5qwqwLsFL7Cgaw/w0UOs8XeAhOCVcTk9PvDUmOd4lyWJbuTJ
	 a/+62On0o3VjuC690b7ntJgoCt+y3pUXbofnEb5K5MQFyfEXmnKu90ltXzX8NqXf42
	 yT92l+7Gwitr6a06wvQZ0KPzXGA30el3UX5Dg81Q+wVTrZoX9MuyAZP8hr5mvRwJ52
	 XqDaalRz8ULECXVyT+6Sna1sMBPJNrW6nTQylh7f3K7/yJf8BlP0WC2ihkcCQEwiV4
	 I/dPjCCgdGt/A==
Received: from nexus.subspace.kernel.org (localhost [IPv6:::1])
	by lkml.kernel.org (Postfix) with ESMTP id EA0C046D81;
	Wed,  4 Nov 2026 09:42:56 +0000 (UTC)
From: Babis Danias via B4 Relay <devnull+b.danias.tutamail.com@kernel.org>
Date: Wed, 04 Nov 2026 11:42:48 +0200
Subject: [PATCH 2/3] media: i2c: ov8856: Enable runtime PM before
 registering the sub-device
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
Message-Id: <20261104-ov8856-pm-fixes-v1-2-1958b730ce66@tutamail.com>
References: <20261104-ov8856-pm-fixes-v1-0-1958b730ce66@tutamail.com>
In-Reply-To: <20261104-ov8856-pm-fixes-v1-0-1958b730ce66@tutamail.com>
To: Sakari Ailus <sakari.ailus@linux.intel.com>
Cc: Mauro Carvalho Chehab <mchehab@kernel.org>, 
 Serin Yeh <serin.yeh@intel.com>, 
 Laurent Pinchart <laurent.pinchart@ideasonboard.com>, 
 Robert Foss <rfoss@kernel.org>, Hans de Goede <hansg@kernel.org>, 
 Bryan O'Donoghue <bod@kernel.org>, 
 Kieran Bingham <kieran.bingham@ideasonboard.com>, 
 linux-media@vger.kernel.org, linux-kernel@vger.kernel.org, 
 stable@vger.kernel.org, Babis Danias <b.danias@tutamail.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1793785376; l=3065;
 i=b.danias@tutamail.com; s=20261103; h=from:subject:message-id;
 bh=rio8Ofl7JAOdPxjbb0My+vg5aCRf/Neov9MPh8InP7c=;
 b=Xd/bDsiTeDb3b9wbUGceRefwIPGyKMVOY70n0EcT6npYcEB4o4gzVl2tdVCHgQfhDz7AlqE8k
 qZMAB9PuKe6A3PTqiKH9P7R9D+DIAsUePRfoplEwpDXrQOvqGAefh2j
X-Developer-Key: i=b.danias@tutamail.com; a=ed25519;
 pk=6DWeigdk0D3JwBjwvmxo9RW8cG8S1Eku42cb9PP+ghk=
X-Endpoint-Received: by B4 Relay for b.danias@tutamail.com/20261103 with
 auth_id=1406
X-Original-From: Babis Danias <b.danias@tutamail.com>
Reply-To: b.danias@tutamail.com
Content-Transfer-Encoding: 7bit

From: Babis Danias <b.danias@tutamail.com>

ov8856_probe() registers the async sub-device before it enables runtime
PM. But the sub-device can be used as soon as it is registered. On ACPI
systems where ipu-bridge instantiates a VCM for the sensor, the bridge's
.bound() callback queues a work item that runtime-resumes the sensor.
If the work runs before probe reaches pm_runtime_enable(),
pm_runtime_get_sync() fails with -EACCES and the VCM is never created:

  [  213.265894] ov8856 i2c-OVTI8856:00: Error -13 runtime-resuming sensor, cannot instantiate VCM

On a Dell Latitude 7320 Detachable this happened on every bind of the
rear sensor after the IPU6 ISYS driver had probed, so the dw9714 focus
motor never showed up. Documentation/driver-api/media/v4l2-subdev.rst
asks drivers to enable runtime PM before registering the sub-device.

Enable runtime PM first, and hold a usage reference until registration
is done, so that the sensor can't be suspended halfway through. Drop the
reference with pm_runtime_put(), which also lets the sensor suspend once
probe is done, as the old pm_runtime_idle() call did. If registration
fails, undo the runtime PM setup. The probe_error_media_entity_cleanup
label then has no users left, so remove it.

The problem was found, and this patch written, with the help of an AI
coding assistant (Claude Opus 5.5). See the cover letter for details.

Fixes: 879347f0c258 ("media: ov8856: Add support for OV8856 sensor")
Cc: stable@vger.kernel.org
Signed-off-by: Babis Danias <b.danias@tutamail.com>
---
 drivers/media/i2c/ov8856.c | 23 ++++++++++++++++-------
 1 file changed, 16 insertions(+), 7 deletions(-)

diff --git a/drivers/media/i2c/ov8856.c b/drivers/media/i2c/ov8856.c
index 988ce0310..f9bcdd412 100644
--- a/drivers/media/i2c/ov8856.c
+++ b/drivers/media/i2c/ov8856.c
@@ -2425,22 +2425,31 @@ static int ov8856_probe(struct i2c_client *client)
 		goto probe_error_v4l2_ctrl_handler_free;
 	}
 
+	/* Set the device's state to active if it's in D0 state. */
+	if (full_power)
+		pm_runtime_set_active(ov8856->dev);
+	/*
+	 * The sub-device can be used as soon as it is registered, so enable
+	 * runtime PM first, and hold a reference until registration is done.
+	 */
+	pm_runtime_get_noresume(ov8856->dev);
+	pm_runtime_enable(ov8856->dev);
+
 	ret = v4l2_async_register_subdev_sensor(&ov8856->sd);
 	if (ret < 0) {
 		dev_err(ov8856->dev, "failed to register V4L2 subdev: %d",
 			ret);
-		goto probe_error_media_entity_cleanup;
+		goto probe_error_pm_runtime_disable;
 	}
 
-	/* Set the device's state to active if it's in D0 state. */
-	if (full_power)
-		pm_runtime_set_active(ov8856->dev);
-	pm_runtime_enable(ov8856->dev);
-	pm_runtime_idle(ov8856->dev);
+	pm_runtime_put(ov8856->dev);
 
 	return 0;
 
-probe_error_media_entity_cleanup:
+probe_error_pm_runtime_disable:
+	pm_runtime_disable(ov8856->dev);
+	pm_runtime_set_suspended(ov8856->dev);
+	pm_runtime_put_noidle(ov8856->dev);
 	media_entity_cleanup(&ov8856->sd.entity);
 
 probe_error_v4l2_ctrl_handler_free:

-- 
2.56.0


