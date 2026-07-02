Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DB5574DB570;
	Thu,  2 Jul 2026 14:16:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783001773; cv=none; b=bwbhc8YPcRvD9QJXJ8Ulpf+/MyUAH+1U4Dw9WOdZh7j9D983hhTuzX7ukHbhXDLbnl+pGk9usAtJYGZ+Td/7GPrGRf8H91wpI1vxmM0Km7gqZ/Twx9ZrlSqS2qVctnLqpM0v/pzSu9WJ+0SPz1u9wfT0PZfRAdHgwynGtIodpMw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783001773; c=relaxed/simple;
	bh=klShMiDYJdjKrOGyRecgdjlRNihzW3KMHRt2d1V5ETI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=l2xyXqJMFf93vf0SjgwzP5GvBpegmc15oxrSsCQD6sdYJTqbB19ZkvWPOD8s9J8GBAQI1ylLg4u7n0jiCsqV7eBl/SJvWBQko/Y/4HSqxEb+9zEQTjMASchpNzYVO8ILw/MU3lEG2Msfai8E69+FExB1jP6b4pj3SGV4KM3ojcU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Ze7nh97P; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Ze7nh97P"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0EDAA1F000E9;
	Thu,  2 Jul 2026 14:16:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783001769;
	bh=upo0gek+32/vnIiAbTo2eqGMVX4+1vrtvizChE+eoC8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=Ze7nh97PWyiX5v4zqZlRZlqwqPw8EnbWqpIMpLtGnwkj+IpG7hBwu2OJ9kV+Lii8i
	 tlVfOjILTURlP/+sO+aPe7xs4HRx1HTihVNOgBTcuDmZoycGieeisWKxZC06g/8TxW
	 sSPczmU6WPnSA6JSrgIedQOpVz9mr8V90Wc0JIwZeZP+v4rp513NSl6QoePYzpC/hd
	 3wSK3uWiHdjs1LIBRcIM0/NsN44WgMguDxZUQiai5nOZY+XK0vMc10sC8f8jIlY+Lu
	 YEeVsXbElwtsAhch03hhr+cdkmMJwBjR+UWg6StIBF/rYoggPLmwfKouCRooe8r3lu
	 0WO8fhtl4dJyA==
Received: from johan by xi.lan with local (Exim 4.99.3)
	(envelope-from <johan@kernel.org>)
	id 1wfID0-00000000Nec-2nzW;
	Thu, 02 Jul 2026 16:16:06 +0200
From: Johan Hovold <johan@kernel.org>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: linux-usb@vger.kernel.org,
	linuxppc-dev@lists.ozlabs.org,
	linux-kernel@vger.kernel.org,
	Johan Hovold <johan@kernel.org>,
	stable@vger.kernel.org
Subject: [PATCH 2/4] USB: gadget: snps-udc: fix device name leak on probe failure
Date: Thu,  2 Jul 2026 16:15:34 +0200
Message-ID: <20260702141536.90887-3-johan@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260702141536.90887-1-johan@kernel.org>
References: <20260702141536.90887-1-johan@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The gadget device name is set by UDC core when registering the gadget
and must not be set before to avoid leaking the name in intermediate
error paths (e.g. when detecting an older chip revision).

Fixes: 12ad0fcaf2fb ("usb: gadget: amd5536udc: let udc-core manage gadget->dev")
Cc: stable@vger.kernel.org	# 3.10
Signed-off-by: Johan Hovold <johan@kernel.org>
---
 drivers/usb/gadget/udc/snps_udc_core.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/usb/gadget/udc/snps_udc_core.c b/drivers/usb/gadget/udc/snps_udc_core.c
index 0e0db68e0b27..d506f9d92bca 100644
--- a/drivers/usb/gadget/udc/snps_udc_core.c
+++ b/drivers/usb/gadget/udc/snps_udc_core.c
@@ -3133,7 +3133,6 @@ int udc_probe(struct udc *dev)
 	/* device struct setup */
 	dev->gadget.ops = &udc_ops;
 
-	dev_set_name(&dev->gadget.dev, "gadget");
 	dev->gadget.name = name;
 	dev->gadget.max_speed = USB_SPEED_HIGH;
 
-- 
2.53.0

