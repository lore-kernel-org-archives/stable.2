Received: from perceval.ideasonboard.com (perceval.ideasonboard.com [213.167.242.64])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A4C1D3F7A99;
	Fri, 17 Jul 2026 11:01:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.167.242.64
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784286086; cv=none; b=nmJoQmoxTqac68+AoTeNQVm+V+fSJW9nz/BZAG/8RIK0kWLoxesg3knH6teMi3DSNLxjS6FXJGJYzq1UPJ6YKiPW5a3otB2sM2UrWHbCNayZz2Lmmp7jLIRVnH1MiEXUtx/fcNq3OptjmXfW4dMRFyLBPOJHl5KhuLxVdg7ei9Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784286086; c=relaxed/simple;
	bh=Qmaf7P8vl+NQHpQ3paAYKLmkVqoBgjPQUSXUyV8H9og=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=ZXz2Ek9mxciQ7YovywLZv8zG8T68Hw98G95e7pUPm7bjJcSx9UJEkm8LnjeOlSAjpdly6rl6GjpKrjabmrVH9uwBOqeo4WNhRUsiGN5fD2cM0N5wxeKhMe5s3GbatX4ZK7DPWTrZqhQgQLL8PDfi2fYHMavqQ7I8cDDwKxVvq2Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ideasonboard.com; spf=pass smtp.mailfrom=ideasonboard.com; dkim=pass (1024-bit key) header.d=ideasonboard.com header.i=@ideasonboard.com header.b=X9HtYL6s; arc=none smtp.client-ip=213.167.242.64
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ideasonboard.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ideasonboard.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ideasonboard.com header.i=@ideasonboard.com header.b="X9HtYL6s"
Received: from mail.ideasonboard.com (unknown [IPv6:2401:4900:1c68:66a6:48e1:9e1:50d5:c75c])
	by perceval.ideasonboard.com (Postfix) with ESMTPSA id 504D6192C;
	Fri, 17 Jul 2026 13:00:07 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ideasonboard.com;
	s=mail; t=1784286007;
	bh=Qmaf7P8vl+NQHpQ3paAYKLmkVqoBgjPQUSXUyV8H9og=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=X9HtYL6s2eNBPTSQMk4PjBKbnxjUP/Ji6WWvwa87PuZQb0K5tbLZ215r51l5vCZF8
	 A+F9TTD6nIEl+LlfQt+T0sSAKs6wPZK/qxRfbfMOGSOUcpMXViQX7g/n7+CooAxwEa
	 GtETMSFVqUjNsIQJ79mS+CNTBXqjywA8lXGiAnBY=
From: Jai Luthra <jai.luthra@ideasonboard.com>
Date: Fri, 17 Jul 2026 16:30:12 +0530
Subject: [PATCH v3 1/6] platform/raspberrypi: vchiq-mmal: Reset
 buffers_with_vpu on port_enable
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260717-b4-vc-sm-cma-v3-1-6c4e77804e5d@ideasonboard.com>
References: <20260717-b4-vc-sm-cma-v3-0-6c4e77804e5d@ideasonboard.com>
In-Reply-To: <20260717-b4-vc-sm-cma-v3-0-6c4e77804e5d@ideasonboard.com>
To: Florian Fainelli <florian.fainelli@broadcom.com>, 
 Raspberry Pi Kernel Maintenance <kernel-list@raspberrypi.com>, 
 bcm-kernel-feedback-list@broadcom.com, 
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
 Dave Stevenson <dave.stevenson@raspberrypi.com>, 
 Phil Elwell <phil@raspberrypi.com>
Cc: Stefan Wahren <wahrenst@gmx.net>, 
 Laurent Pinchart <laurent.pinchart@ideasonboard.com>, 
 Kieran Bingham <kieran.bingham@ideasonboard.com>, 
 Sumit Semwal <sumit.semwal@linaro.org>, 
 =?utf-8?q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>, 
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, 
 linux-rpi-kernel@lists.infradead.org, linux-media@vger.kernel.org, 
 Jai Luthra <jai.luthra@ideasonboard.com>, stable@vger.kernel.org
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=1246;
 i=jai.luthra@ideasonboard.com; h=from:subject:message-id;
 bh=Do8bRGCfHOEftezshmsJTo9xCK4W1kAn6ofPdB/RoWY=;
 b=owEBbQKS/ZANAwAKAUPekfkkmnFFAcsmYgBqWgteUdwr/t+ronwJgjEv63igmNQ2a5tQkOipO
 WxPIviazn+JAjMEAAEKAB0WIQRN4NgY5dV16NRar8VD3pH5JJpxRQUCaloLXgAKCRBD3pH5JJpx
 RS3VD/95fhaDr6R9bQWYDSqFOCnm9AmpIxA9IQV+Axs3NRRjofgry9Ft1e/geiRe6R/L1qhhh0Q
 4IkYk4dA3s0XMcKhbYwH1VOqFeJXH2SZWaGvnDMdNb5+lSlTvW/zUU3yAJlZAsU9qalJ09lxotJ
 xXfbOZ5a+neqNl5MccRd4rZJMqjWC/jKlfsV72ObYbY+1dzVxw6IIjFvXRVqf5Qq77ADBzIRDpC
 mJAL7B2kLFkn6apcUsyQLMawkkm+EuC5YiBEZLIcrp6e/1qkwCUVm7GohF/NAxf+p0kTow7RLK3
 0JxbwJ5z/t8sUXORZh2Y6BRl+k0FCC0NqwsBPsb9y+9Jzdn7bSQEebyx9UhkxczClBC6m046ern
 xYDze5h9b08UmExSKAvhrrI0l2NIzdfHBYAKBsanQMCTW3Hi2lemXZY1kfEiDz3pIN+nMQjnKwH
 vbFVbAea+ziRH9V9uncT4+MhCi5dUhPDhNtkiDvM32/aRnP24FBQafrr7w47AiToWKjzWaOgXB2
 YrIJUIX2PLWJf+xvsUX/+G7ijrTu1V3tuB3qZaYPTYCyuuVv4wDQw3y9pj7yREgwLUuoMmq47f/
 mC8wN8sz5QFGaripAsnAG3LnDNs32lmXJPX2G8JQatsVN9mtOXfx/widmyx8V2AzCKIJlsxxrpE
 ujdpU7UYuMYW3Ag==
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
2.54.0

