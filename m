Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=194.13.80.246
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792506830;
	b=IH4GznRBUbNUPCIwg3guKBPl7jN7VLfU/2gTkAcXA8eCDJsh9LYgB1/OJlpAwC4jcebg
	 dHA3R3SU+gR9BjfN/TQCjWXns0AmtDTYrrH290nI3fHNfnX8qIatGCEgG1T3IQDM/Mo3/
	 HklDgQlCXrP1tMnw/tWQIXsrabuM4Iih9hax8zCUWB+Qp6cFaDeKvUL98AmB2Il2WqrS1
	 0RYwbrKZEACrUOh2YKs0M7InO8/uj8QXUDQ6Rqbs2YJp2VB3aNPqDHqGxcQQrSDUySovN
	 GEe9kF+uBjwsT6f5KhUyQt94VA7LAyOmEivTmLH3Jn1fg1LgC3Mg/ohojFP9IzKxOVg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792506830;
	h=DMARC-Filter:Received:DKIM-Signature:From:Date:Subject:MIME-Version:
	 Content-Type:Content-Transfer-Encoding:Message-Id:References:
	 In-Reply-To:To:Cc:X-Mailer:X-Last-TLS-Session-Version;
	bh=PgHaDmY2DOGMgpEhK+04XXO50J0625X+q5VCRHeKwHs=;
	b=4CSIaWzI5CgCUJz/M9UsJ7EtdOi10doSfdnzM5Z0zghPqM6ULGOVKZJZsUmMCwtHV8Ve
	 dCpoonTeUdYvGazlPTDsXZpT8a4VSLASDUS92CLSKzU75VH0+/3pTtN3wjMAQR2AXsf6v
	 NWlWsQSFBJznXURilYeUvbR84mc5YOAjNH7MVmpVGvw/400jHQF/8tXzYu+Yee14hx+KB
	 aOiz1LZSK6hX/xTJbA6Xy93KLJsw7Vn4dXVVRKXw9tHAH2QlJ6YCBDoWC/ropYGqB+RKS
	 zSsWVF5Yw0PnskfFs3oWs6YUt9RN9OmuKs5iTCuUxU5W8nJ+1yK1kaMxGaR5CP8pf4A==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=tipi-net.de;
	spf=pass smtp.mailfrom=tipi-net.de;
	dkim=pass header.d=tipi-net.de header.i=@tipi-net.de header.a=rsa-sha256 header.s=dkim header.b=ctTXmW1Q;
	arc=none smtp.remote-ip=194.13.80.246
Received: from mail.tipi-net.de (mail.tipi-net.de [194.13.80.246])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A1AFE606A33C;
	Tue, 20 Oct 2026 14:33:49 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org A1AFE606A33C
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tipi-net.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=tipi-net.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=tipi-net.de header.i=@tipi-net.de header.a=rsa-sha256 header.s=dkim header.b=ctTXmW1Q
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id E2EB6A1628;
	Tue, 20 Oct 2026 16:33:47 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=tipi-net.de; s=dkim;
	t=1792506828; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:in-reply-to:references;
	bh=PgHaDmY2DOGMgpEhK+04XXO50J0625X+q5VCRHeKwHs=;
	b=ctTXmW1QccVAMXb4Gg7ph98MtbASwU672qeqfkGEmduh0ADW5SbhTFKu4cxZb8ip8H0KSU
	EQyPqnLKkLzgLUfGn7KSLKyoKde2jwdUiH4QiprkzVFmNnO8tTdu9K1j/qwdJdOXxFtCOr
	orJMJYpiHDqpzpCFeCy2eyZpBcTqlAj8fKdv8tBC0AI4wEje/4Rn0Jm0n+fDpiOkG19q9c
	DgxQ6PGANusHjjz/XyN9fQKwOUlc4Fi73/uLJDBWm+eXN+XhMeFZOwkSOoNRPT8Fi/ggmo
	HbB88kEBS/c+ah2BFY3BuAsydaXOuqMiSscpDtDTXEDGKXK0aFOatM5bmhzefA==
From: Nicolai Buchwitz <nb@tipi-net.de>
Date: Tue, 20 Oct 2026 16:33:41 +0200
Subject: [PATCH 4/4] usb: usbtmc: send a ZLP after a full last packet in
 packet I/O mode
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
Message-Id: <20261020-fix-usbtmc-short-packets-v1-4-903f4d029193@tipi-net.de>
References: <20261020-fix-usbtmc-short-packets-v1-0-903f4d029193@tipi-net.de>
In-Reply-To: <20261020-fix-usbtmc-short-packets-v1-0-903f4d029193@tipi-net.de>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
 Steve Bayless <steve_bayless@keysight.com>, 
 Guido Kiener <guido@kiener-muenchen.de>
Cc: linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Nicolai Buchwitz <nb@tipi-net.de>, stable@vger.kernel.org
X-Mailer: b4 0.16.0
X-Last-TLS-Session-Version: TLSv1.3

The Rigol DP800 waits for a short packet before it handles a command.
A message that ends exactly on a 64-byte boundary is never processed.
The read times out, and once the next message gets appended the device
shows "command incorrect".

Send a zero-length packet after a full last packet in usbtmc_write()
on quirked devices.

Tested on a DP832A, a DS1054Z and an SDM4065A-SC.

Cc: stable@vger.kernel.org
Signed-off-by: Nicolai Buchwitz <nb@tipi-net.de>
---
 drivers/usb/class/usbtmc.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/drivers/usb/class/usbtmc.c b/drivers/usb/class/usbtmc.c
index 861913b9de918..101d4f9fff6b5 100644
--- a/drivers/usb/class/usbtmc.c
+++ b/drivers/usb/class/usbtmc.c
@@ -1259,6 +1259,8 @@ static ssize_t usbtmc_generic_write(struct usbtmc_file_data *file_data,
 			usb_sndbulkpipe(data->usb_dev, data->bulk_out),
 			urb->transfer_buffer, aligned,
 			usbtmc_write_bulk_cb, file_data);
+		if (packet_mode && this_part == remaining)
+			urb->transfer_flags |= URB_ZERO_PACKET;
 
 		usb_anchor_urb(urb, &file_data->submitted);
 		retval = usb_submit_urb(urb, GFP_KERNEL);
@@ -1666,6 +1668,9 @@ static ssize_t usbtmc_write(struct file *filp, const char __user *buf,
 		usb_sndbulkpipe(data->usb_dev, data->bulk_out),
 		urb->transfer_buffer, aligned,
 		usbtmc_write_bulk_cb, file_data);
+	/* Some devices only end a transfer on a short packet */
+	if (data->packet_io && transfersize == remaining)
+		urb->transfer_flags |= URB_ZERO_PACKET;
 
 	usb_anchor_urb(urb, &file_data->submitted);
 	retval = usb_submit_urb(urb, GFP_KERNEL);

-- 
2.53.0

