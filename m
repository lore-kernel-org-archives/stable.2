Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1794845043;
	b=cnc+FRqfLyqXxW/CiykHEYwRvaaB8LLMmbinkzq1kiOWpRwBy2yCKLKodVVc5+xKzmkO
	 btWa9sGKop4S93eo/mXbXgQCgdNsBjPK32kJVC4AnquYq3wXVkLaxhwbUlQ6TtoTSdzWX
	 946hifJBQVlgsVK3lHDdCHAZ8TzqzLuvpDh6iceBvJq2Lr7NKEZ99MUjvBquuYhi+ztlX
	 6sjejilY3ItDVaSX9aH0jmYX+qyzZ5ZtVEE/m4LhMGT7+XUEitBzQZ7hMc6GsVQ9Fcgjh
	 4FelH0qL5TUtujCmhCdhAo7QqHteItkcUTa5ZtwysKwlk8BTRDhtscjh2czrk94jHJA==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794845043;
	h=Received:DKIM-Signature:Received:From:Date:Subject:MIME-Version:
	 Content-Type:Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
	 X-Original-From:Reply-To:Content-Transfer-Encoding;
	bh=m/imQsST/BVfRqc+e9HDWJfbux7rdyFkRuZEgaSJ6dU=;
	b=gRKRl61V9qepnwUuWBOlXCUymwoAuwFeJQhUWSUnfiK5UH23ImIdQCmvNa6JPH9JwFxi
	 mJ2GdSsC0Ot4PqgyZx69U5UYIMiJAzvkwdP5jElo6EyX7Hw806zTQja7L9eEAt3J2N9Ly
	 KhyuO74u3QmpInC/8aUPdjD6ZvWUnrega4NWB7oHhkRRKGLwISfxl2I3Bv6r069X22rZX
	 W2MPfAaUqSyx/LaMskJ8FZWjZ8iMyQ9U7Ehi5QpgW+36aHS+4N9lh533Ap6aFcg0EAHje
	 e6RsgvTNtqSb/23Ts+xgtFYuXbJfX5moWkYQcfR9/39DuqEXpbGBRj+aLNWOe/wHa6A==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=VtTDzjxF;
	arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 92D4F606A31C;
	Mon, 16 Nov 2026 16:04:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=VtTDzjxF
Authentication-Results: smtp.kernel.org; arc=none smtp.remote-ip=100.80.115.77
ARC-Seal: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256; cv=none;
	t=1794845043;
	b=WiIbfoFXswQ7EohUc/JrwN0Qr4SGrxTpFu8wTsa8nMk0At7ru4niX1j1QA+Dog85lNEE
	 Qz/0cLK6W9Mv2yKZ6yU6x87Psoiy22CFcuizFevbQsj+RdkrDAabBTjg/geUdzOiNrWny
	 POeFnHk9wl5zEBS+3tCMORmebRpx2hOa3cZoflX8oixIyO9o5gfn5L1JrY18rPDRwDT5E
	 B7si9mULktIHPRhGI86SH8B7HftZxriWZfpq7y/TJ2/jyAZYOiMav5CHYegTHqoV160w6
	 DmfGL/vc/efXQYfe33coe8aLgDdQRO1phx/5HQhCxo9zSn5N4fqSyeiFhVR4wdaUcDQ==
ARC-Message-Signature: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256;
	c=relaxed/relaxed; t=1794845043;
	h=DKIM-Signature:Received:From:Date:Subject:MIME-Version:Content-Type:
	 Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
	 X-Original-From:Reply-To:Content-Transfer-Encoding;
	bh=m/imQsST/BVfRqc+e9HDWJfbux7rdyFkRuZEgaSJ6dU=;
	b=ytGgUrEvBMFAkK5CtYxsJGn/LJGKEBAKnGIINqVWeKg6pUiqetdblbDgK9pHHTjIFYrP
	 vYZNn8AZi+JzIbXs8y2JsgYQXsNpOE6wIkGH6S5nBvz5NbVURxCRrgkDtzOX36siIAvT2
	 t+rD8KTJ7UIjwaF7r8fLdC+8foAnOSxX4yNTSgK4otqmw2NJ+qyH9PWP6HnyyHYU2v7pq
	 72UiIau5hJrhgj4E5Gk7JjWwsuos8YWttaWIpVB9t6dIzRpJ9qrL/3AM1KvwhKm9CkxfB
	 PjOurG25SeE8Iw2DBsPU3PuvwGW95mndU91AnCGQyJmPKlVsMXU9FA66tUXEtqMM9ew==
ARC-Authentication-Results: i=1; smtp.kernel.org; 
	arc=none smtp.remote-ip=100.80.115.77
Received: from lkml.kernel.org (nexus.subspace.kernel.org [100.80.115.77])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.kernel.org (Postfix) with ESMTPS id 95B041F000CA;
	Mon, 16 Nov 2026 16:04:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794845043;
	bh=m/imQsST/BVfRqc+e9HDWJfbux7rdyFkRuZEgaSJ6dU=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To;
	b=VtTDzjxFEKQjfkftv/wLlWs3Zpz8xrYkiY7nLiQ+dC4rfLxjMPEVt7tW1k38aFHG9
	 Ck4zCgShtbjCOZ+dQzzi54lbPtVG0KZ3/7eorsVXjp4grHwg2nTLONFh8DWX6pv7B+
	 qwKeTLqIZVl1BxuwZxIKXjhDPmAtlvN+7SSi9gRmcoOtwjY3F1L2uog1SEG/Qu9Kvy
	 uR4PTqLfV320nTgP89SmI4pBl9PmZP2IbCz4vkus4goMdsZ4eh0DFkq+naHqsK7cQj
	 PYlfFyQg6drXGdzL1SHNEJbVLIzeysv7QxZpK2Pz9FTzb3/ap6RbB+9M6gw0WPdbQb
	 tju8aiq7bdnkA==
Received: from nexus.subspace.kernel.org (localhost [IPv6:::1])
	by lkml.kernel.org (Postfix) with ESMTP id 2411E4A50C;
	Mon, 16 Nov 2026 16:04:02 +0000 (UTC)
From: Babis Danias via B4 Relay <devnull+b.danias.tutamail.com@kernel.org>
Date: Mon, 16 Nov 2026 18:04:00 +0200
Subject: [PATCH v2 2/2] media: i2c: ov8856: Enable runtime PM before
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
Message-Id: <20261116-ov8856-pm-fixes-v2-2-7e41763164f2@tutamail.com>
References: <20261116-ov8856-pm-fixes-v2-0-7e41763164f2@tutamail.com>
In-Reply-To: <20261116-ov8856-pm-fixes-v2-0-7e41763164f2@tutamail.com>
To: Sakari Ailus <sakari.ailus@linux.intel.com>, 
 Tomasz Figa <tfiga@chromium.org>, 
 Hidenori Kobayashi <hidenorik@chromium.org>, Ben Kao <ben.kao@intel.com>
Cc: Mauro Carvalho Chehab <mchehab@kernel.org>, 
 Serin Yeh <serin.yeh@intel.com>, 
 Laurent Pinchart <laurent.pinchart@ideasonboard.com>, 
 Robert Foss <rfoss@kernel.org>, Hans de Goede <hansg@kernel.org>, 
 Bryan O'Donoghue <bod@kernel.org>, 
 Kieran Bingham <kieran.bingham@ideasonboard.com>, 
 Charles Drolet <linux@cdrolet.dev>, linux-media@vger.kernel.org, 
 linux-kernel@vger.kernel.org, stable@vger.kernel.org, 
 Babis Danias <b.danias@tutamail.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1794845041; l=2716;
 i=b.danias@tutamail.com; s=20261103; h=from:subject:message-id;
 bh=9Sob8EIPfCS4oIJbr5Hlz/DsJU9QMNnA5zdbHTCDRzQ=;
 b=dX1Osg17NALZ6SQbn7NyEfJHKqCb/plyYAXUo4Udcn5BNkv8QU63n67Jvb7DNUq0c8vA8SEzP
 gJnTyyzHyQ2CReTTivFaxKzwebDSaFxp6z1adKsqv0GY2E+k15LlCE4
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
motor never showed up. On another unit of the same model, Charles Drolet
saw it on about one boot in four.
Documentation/driver-api/media/v4l2-subdev.rst asks drivers to enable
runtime PM before registering the sub-device.

Enable runtime PM before registering the sub-device. Keep the
pm_runtime_idle() call after registration, so that the sensor can still
suspend once probe is done. If registration fails, disable runtime PM
again and mark the device suspended. The probe_error_media_entity_cleanup
label then has no users left, so remove it.

Fixes: 879347f0c258 ("media: ov8856: Add support for OV8856 sensor")
Cc: stable@vger.kernel.org
Signed-off-by: Babis Danias <b.danias@tutamail.com>
---
 drivers/media/i2c/ov8856.c | 16 ++++++++++------
 1 file changed, 10 insertions(+), 6 deletions(-)

diff --git a/drivers/media/i2c/ov8856.c b/drivers/media/i2c/ov8856.c
index 18bae9db64..c8cb9ee882 100644
--- a/drivers/media/i2c/ov8856.c
+++ b/drivers/media/i2c/ov8856.c
@@ -2426,22 +2426,26 @@ static int ov8856_probe(struct i2c_client *client)
 		goto probe_error_v4l2_ctrl_handler_free;
 	}
 
+	/* Set the device's state to active if it's in D0 state. */
+	if (full_power)
+		pm_runtime_set_active(ov8856->dev);
+	/* The sub-device can be used as soon as it is registered. */
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
 	pm_runtime_idle(ov8856->dev);
 
 	return 0;
 
-probe_error_media_entity_cleanup:
+probe_error_pm_runtime_disable:
+	pm_runtime_disable(ov8856->dev);
+	pm_runtime_set_suspended(ov8856->dev);
 	media_entity_cleanup(&ov8856->sd.entity);
 
 probe_error_v4l2_ctrl_handler_free:

-- 
2.56.0


