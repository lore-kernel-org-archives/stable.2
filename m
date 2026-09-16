Received: from perceval.ideasonboard.com (perceval.ideasonboard.com [213.167.242.64])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6B75D4EE85A;
	Wed, 16 Sep 2026 14:26:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.167.242.64
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789568786; cv=none; b=uwiGyXPwlWM5l9c4LwcDLgnn9njAoaBgnwDuL1r2aEco0VaC3JWMKv26HZ5WBxzF6oGz2rsr9AWnSo7QaS4HiR5dqKVpLTVSDm6q7OMIrJh4BDPW4xaUnMbBZEuXhIccbHIWrgVA0x+sSSaY3groDRv5ZNow81IVOi2E8QlWOYo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789568786; c=relaxed/simple;
	bh=+QuhmE5SESp4++tQAdCkZbcccYK/jFHpbXh6SULYlm4=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=uMalW9qikd24qts0B5KuaMO/YFOBLw4kBoCCNehISE7YLjqJVJvPS/5L3ZECVrHNEYwp3V0SWf4E5YzlarbVOMxZKdn2AuUjTQHMmJ3OMHsPqW7LhrUdo8ATikjM5STI/2hqQTJa5tqOO6A4upeEZ5r5025P/9xzpifMdj1MNnU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ideasonboard.com; spf=pass smtp.mailfrom=ideasonboard.com; dkim=pass (1024-bit key) header.d=ideasonboard.com header.i=@ideasonboard.com header.b=pqCKom6G; arc=none smtp.client-ip=213.167.242.64
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ideasonboard.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ideasonboard.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ideasonboard.com header.i=@ideasonboard.com header.b="pqCKom6G"
Received: from mail.ideasonboard.com (unknown [IPv6:2401:4900:1c69:85de:a3c9:9357:b164:bf0b])
	by perceval.ideasonboard.com (Postfix) with ESMTPSA id 14A3FC42;
	Wed, 16 Sep 2026 16:24:39 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ideasonboard.com;
	s=mail; t=1789568680;
	bh=+QuhmE5SESp4++tQAdCkZbcccYK/jFHpbXh6SULYlm4=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=pqCKom6Ght4XZ9RsYSpcHIlnZdYoNfW5Udt2mHLfi68JJBjgcbUg6S0eUm36rMcEp
	 NT2EL7lwIngTwnlTPSzR2Pu0tIIgULKZnIv3DiiwoJZNR1poyeQA0snBkH7L5zAGSX
	 7r7QWp/t9MMdV8sS/9B1B4cLWaim5FntOsm+8G0w=
From: Jai Luthra <jai.luthra@ideasonboard.com>
Date: Wed, 16 Sep 2026 19:55:31 +0530
Subject: [PATCH v4 1/6] platform/raspberrypi: vchiq-mmal: Reset
 buffers_with_vpu on port_enable
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260916-b4-vc-sm-cma-v4-1-476d1142b5df@ideasonboard.com>
References: <20260916-b4-vc-sm-cma-v4-0-476d1142b5df@ideasonboard.com>
In-Reply-To: <20260916-b4-vc-sm-cma-v4-0-476d1142b5df@ideasonboard.com>
To: Florian Fainelli <florian.fainelli@broadcom.com>, 
 Raspberry Pi Kernel Maintenance <kernel-list@raspberrypi.com>, 
 bcm-kernel-feedback-list@broadcom.com, 
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
 Dave Stevenson <dave.stevenson@raspberrypi.com>, 
 Phil Elwell <phil@raspberrypi.com>, Hans Verkuil <hverkuil@kernel.org>, 
 Mauro Carvalho Chehab <mchehab+samsung@kernel.org>
Cc: Stefan Wahren <wahrenst@gmx.net>, 
 Laurent Pinchart <laurent.pinchart@ideasonboard.com>, 
 Kieran Bingham <kieran.bingham@ideasonboard.com>, 
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, 
 linux-rpi-kernel@lists.infradead.org, linux-media@vger.kernel.org, 
 Jai Luthra <jai.luthra@ideasonboard.com>, stable@vger.kernel.org
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=1246;
 i=jai.luthra@ideasonboard.com; h=from:subject:message-id;
 bh=sMOtM66Tr0BbnLrbjtE+KFfUqM59OoL9ixffhnJPpV8=;
 b=owEBbQKS/ZANAwAKAUPekfkkmnFFAcsmYgBqqqb83r4MQItuT++av1u5omKM21cuJ+sEfs6ia
 Vhu9xW7UuuJAjMEAAEKAB0WIQRN4NgY5dV16NRar8VD3pH5JJpxRQUCaqqm/AAKCRBD3pH5JJpx
 RXQmEACQEZqcQZ0AlRapMqomghGlo0BFKkpvwK4zs/v/LgtZTngMScX6dEazzXOLEEOouLmJG4K
 6alf4HJfXs4KAnErobBJqhlzD/WqK7vtWNIgGFr2eWkstuvWHDG8Y4dRZrgwgMK+USlKUuE8ONa
 A/6WjrMEvi8f9s4vyGJoFK2GgTT76K3b7sq0dFHzv4ZBpZT4nNo3WvPHGMmCMe6+CNwhW2AQet7
 bXXIh+KUEtmXWj+iEXkvNKB0P15P1knXSWWr/q0WJnNmM1oYz5fqfSkrIU1k/no3pjEAcDweoxq
 CGmEBOS1A3MxjP8L4sdlnCvUgISGpK34dGj9WfLuB4AHh1N6mS+/TeS6Y+sbKKr9+gBnWX7UdrW
 i3IsnvAuKFSHjerWgiFKRdabRXMTbu9b25pqMEwOBSwUBGIId6dKgBfdbAqB3pUYvsP8pZeumq9
 4K1JF2MfM0TWCX7BvCHMnOSNF5OgNqz9f2Ix0lQIJPfa79tiQpoAq7DfmGsOpRtKZr+jiSdpm0g
 rLOPwB8wt7AEgjspbANZX6iNeXX6UUUjYM5+iwlnoPvTPB3lxIPzFakN/R7kcfsHJ6RUf1FDj4D
 Ym/HPjOLbEHlzHuO3qXMKBmLC84HdjpNY9lMVeiM8FGKkPUXhYB3DMBiu2gfJsPxSygwFaQh/ID
 vTSQ92w9fxQRNzw==
X-Developer-Key: i=jai.luthra@ideasonboard.com; a=openpgp;
 fpr=4DE0D818E5D575E8D45AAFC543DE91F9249A7145

From: Dave Stevenson <dave.stevenson@raspberrypi.com>

Should we go through the timeout failure case with port_disable
not returning all buffers for whatever reason, the
buffers_with_vpu counter gets left at a non-zero value, which
will cause reference counting issues should the instance be
reused.

Reset the count when the port is enabled again, but before
any buffers have been sent to the VPU.

Fixes: 70ec64ccdaac ("staging: bcm2835-camera: Ensure all buffers are returned on disable")
Cc: stable@vger.kernel.org
Signed-off-by: Dave Stevenson <dave.stevenson@raspberrypi.com>
Signed-off-by: Jai Luthra <jai.luthra@ideasonboard.com>
---
 drivers/platform/raspberrypi/vchiq-mmal/mmal-vchiq.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/platform/raspberrypi/vchiq-mmal/mmal-vchiq.c b/drivers/platform/raspberrypi/vchiq-mmal/mmal-vchiq.c
index c89c16fb8b33..918c30d84ba0 100644
--- a/drivers/platform/raspberrypi/vchiq-mmal/mmal-vchiq.c
+++ b/drivers/platform/raspberrypi/vchiq-mmal/mmal-vchiq.c
@@ -1364,6 +1364,8 @@ static int port_enable(struct vchiq_mmal_instance *instance,
 
 	port->enabled = true;
 
+	atomic_set(&port->buffers_with_vpu, 0);
+
 	if (port->buffer_cb) {
 		/* send buffer headers to videocore */
 		hdr_count = 1;

-- 
2.55.0

