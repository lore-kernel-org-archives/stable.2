Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=213.167.242.64
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794482315;
	b=telvf5pmrsLrISXc57hK2aGQKZ1ICE7pqBSQquIf0U9uUjeszODJgauz54PJykDVhZKF
	 fMirAhiEKuxfhduWQw+/0/236sl7Qi2pARF7V1R//j1EopGs6yjVky/NJVVq/1xFu3tSs
	 gDeht9DthOe5m3riMRQm0BwCsK/1MwBuC6SZ6swsrZhfRXfZNyBvidhIYM6TziSKiV8c0
	 yn2NWYudguXT97QIxBSh3nMQxqc/MSVTWYN9QB0EmMbuk2wQ3WR63jzifX1Yg4eO/JHqG
	 PN2wbsP8DE6A+dNDzKK8FhmmkzYBRUDEu2P/wicOSASkopU2GrhuEwLm0aEb8KlPjLQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794482315;
	h=DMARC-Filter:Received:DKIM-Signature:From:Date:Subject:MIME-Version:
	 Content-Type:Content-Transfer-Encoding:Message-Id:References:
	 In-Reply-To:To:Cc:X-Mailer:X-Developer-Signature:X-Developer-Key;
	bh=sZTafjTyeOWXRzBQ8qZ5x9oZ2fxlvwimYZth8/s8Z50=;
	b=hYefIpDGN5IgVrweUQuEtF34ANGLJFo7APhWri8+q21swSHeSKfV32jMBu2GAoSMJJHg
	 JGO0knKSrX+mKB5fI4tMldRA6IehCSgwWJFG6HqYsurVydcrbkY0CF9e62sF8vp27QSBI
	 aanXKHS4ot0CeKLewiMODNzslVOevDzlnhWg9+WCH2aLNextF+Ao/5X9Q9A0VwvM45J5y
	 sku+eerYiDwfG5Ns9SEUu5BNyREffBTecpJQvWD8gBut/v3iohtk7/0ttghCailYNxQso
	 hwpHuqeel48rSux6HgDFsWT8uNHKWFiudbJid+NZsSH5/oK/tFZhL/ZLv/EdpPAZ6vA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=ideasonboard.com;
	spf=pass smtp.mailfrom=ideasonboard.com;
	dkim=pass header.d=ideasonboard.com header.i=@ideasonboard.com header.a=rsa-sha256 header.s=mail header.b=QsnYFTsI;
	arc=none smtp.remote-ip=213.167.242.64
Received: from perceval.ideasonboard.com (perceval.ideasonboard.com [213.167.242.64])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 107B3606A888;
	Thu, 12 Nov 2026 11:18:34 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 107B3606A888
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ideasonboard.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ideasonboard.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ideasonboard.com header.i=@ideasonboard.com header.a=rsa-sha256 header.s=mail header.b=QsnYFTsI
Received: from mail.ideasonboard.com (unknown [IPv6:2401:4900:1c67:cdf:7464:6c04:36e4:ee87])
	by perceval.ideasonboard.com (Postfix) with ESMTPSA id 9B058802;
	Thu, 12 Nov 2026 12:16:09 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ideasonboard.com;
	s=mail; t=1794482170;
	bh=qr9Hb6er4o+ZFd61MYiFbrlFhpxANIoccVfFwpqGICY=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=QsnYFTsIHrX6/KkAbWijLEXEfALSHqPakv7S/+rRWATnfIY9PT7rMEShdoVARWpYV
	 HlrKWMlIX48GLl+gW+QDgxQoEuwp0jAL33rfSpoDSlxu7b07OFqUzF4VYTPnStY0cf
	 y8Rl2HF8QyMx1q3AJKhK0G/9FyGQQ7sPFbd5RvWs=
From: Jai Luthra <jai.luthra@ideasonboard.com>
Date: Thu, 12 Nov 2026 16:47:59 +0530
Subject: [PATCH v5 01/11] platform/raspberrypi: vchiq-mmal: Reset
 buffers_with_vpu on port_enable
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
Message-Id: <20261112-b4-vc-sm-cma-v5-1-d25e3b687e71@ideasonboard.com>
References: <20261112-b4-vc-sm-cma-v5-0-d25e3b687e71@ideasonboard.com>
In-Reply-To: <20261112-b4-vc-sm-cma-v5-0-d25e3b687e71@ideasonboard.com>
To: Stefan Wahren <wahrenst@gmx.net>, 
 Florian Fainelli <florian.fainelli@broadcom.com>, 
 Dave Stevenson <dave.stevenson@raspberrypi.com>, 
 Phil Elwell <phil@raspberrypi.com>, 
 Raspberry Pi Kernel Maintenance <kernel-list@raspberrypi.com>, 
 bcm-kernel-feedback-list@broadcom.com
Cc: Martin Wetterwald <martin@wetterwald.eu>, 
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
 Laurent Pinchart <laurent.pinchart@ideasonboard.com>, 
 Kieran Bingham <kieran.bingham@ideasonboard.com>, 
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, 
 linux-rpi-kernel@lists.infradead.org, linux-media@vger.kernel.org, 
 Jai Luthra <jai.luthra@ideasonboard.com>, stable@vger.kernel.org
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=1246;
 i=jai.luthra@ideasonboard.com; h=from:subject:message-id;
 bh=gStDCJS7/a2iM8pYGnW+XInrWVb9ED96mlf7V+9VfTE=;
 b=owEBbQKS/ZANAwAKAUPekfkkmnFFAcsmYgBq9aB0ZWd+V/36zeF0x5dyIlfZAqMxDy0U5AP8/
 aZFhzXMTfmJAjMEAAEKAB0WIQRN4NgY5dV16NRar8VD3pH5JJpxRQUCavWgdAAKCRBD3pH5JJpx
 RSpaD/9OHniUuocrfClzq6WsIMt5BaIb27T8FG1PLPMyBIM2xUBxWgnM1fyZez7KnHU1FL6/lKO
 liQCFB6kEy8v+Onsx/xYk6NujBjZYtso66Gn6bBrOa9oYvy7Ikx4q0bqhCpxsUYSMFIqZNzrBsn
 bV3HHD+kBtnieGXK73sR0RS0wHSBwhuDweTq1Td6vD0GpdbxjQmmXzcUyNTsWEX1U+wIc+FfXPM
 6POsb26xQuyBoOhCWpa3xZYxDeI5+OfkTYU0Dg/P2+YK05d1tA6pYEKIqQjycanhX+Pm28SeoSm
 PkB3hPKmHfsjvqU5THCtNM3WETR40FAx0w0xWxzxUWeqYeSHC1h5gPift5kwyWlcAHGvr1/BKQb
 xkGal57DMS13kZQIgGH7a7lZLMLcHoNd0Rn2gxX5BLOOfP+zseWsfjbViK+wutz613Rqg0zjXD8
 9Jj4yY83pjicrmh6dPBIz43a+bcaPiwqxRN8rL3H0A8ItxYIUv+a8q/zamvup2d4g/Co1d4wD7b
 j9fiOWSDC/7DHYV1noNdxt6c8lRNySU0CfiVJZWS0xq/hgPr9eHBrctX5LoVnIoVakkqQOmWvqR
 /fq74O5nA56mKKHmeFo9cPFmMW1bBkM2ywnMdfzYH2rOP6oF+tD/YbrXdr1A/KOyaOxLFURXe5h
 gPb8qb7G4muoHiw==
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
2.56.0

