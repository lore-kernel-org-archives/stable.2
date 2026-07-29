Received: from extorris.mess.org (extorris.mess.org [92.243.27.206])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1CAD63B0584;
	Wed, 29 Jul 2026 15:23:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=92.243.27.206
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785338593; cv=none; b=C4D8X0jbJYE4Du42xVrzpmjlCVLn9jxOniSdfoEyYv6WFJHDO1g2cImCNJKnwnIL/uAXutxEz10VRH2kIJXanb6naXgjt5/3jJUJVTCrst9fp7C+ukoKm/c3PGUUOcfnZn4adyUaWNbFegw5X89gH5DtEMAIEhIhhA7168uUwC4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785338593; c=relaxed/simple;
	bh=yZxyCRkmp4AKMHYqkRoIsn2dSvwisuNURdwjTe4731Q=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=HiA2WjFyEqyVofiESp6yVVrBhkk2kpCoGXm4LxFSPw3qPp2kV6C5be2paLDGwXAmQFbLJPRNIibsGw8W0KpPOznIKmHO8av1L6Q9Qrb4Q63Nfue2ZocXkf0exXc1O8TwNNvsP0DkbplegSWf50l9abymxI/wab6Kc+Ff7xfXMVA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=mess.org; spf=pass smtp.mailfrom=mess.org; dkim=pass (2048-bit key) header.d=mess.org header.i=@mess.org header.b=rZytN7q/; dkim=pass (2048-bit key) header.d=mess.org header.i=@mess.org header.b=fulHtu1t; arc=none smtp.client-ip=92.243.27.206
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=mess.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mess.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mess.org header.i=@mess.org header.b="rZytN7q/";
	dkim=pass (2048-bit key) header.d=mess.org header.i=@mess.org header.b="fulHtu1t"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=mess.org; s=2020;
	t=1785338590; bh=yZxyCRkmp4AKMHYqkRoIsn2dSvwisuNURdwjTe4731Q=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=rZytN7q/gnbE0hIFv5YtshbfSnNCG0h3g2XZqsCws1DicUxrhKDtez1z8h04103LO
	 Pn8hBP7yXrLYy97r1xENwNHaGIQlYHkLFd4ScTYKiVdrgag8BOVlYr1RO96TSLUc11
	 jbYVTJ9OYpm1jrjcJQVaXuR+4DxF/tsnehAbzvybCAmeSBbFO5H+ksyn2cdAJCsBpY
	 X0+4NCau70/3r6w0Ve2fNKQK+UKFrbjYyT823ijMSrT+DnKQ8eylvXhxX6TphYdeW1
	 tSZS3huN5/GMdrlQZSYDC+LUEZd+r6wrjfyujhJkVM6Znk//yBlFTEbHiz+TnMN1Wn
	 9pzWKFszqUMJA==
Received: by extorris.mess.org (Postfix, from userid 1004)
	id 5D2C242528; Wed, 29 Jul 2026 16:23:10 +0100 (BST)
X-Spam-Level: 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=mess.org; s=2020;
	t=1785338589; bh=yZxyCRkmp4AKMHYqkRoIsn2dSvwisuNURdwjTe4731Q=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=fulHtu1tx7VDkosqIJ6Zsw9wafE40FgUe7XWuRx5YM/rZ7fkcDMW2xMuXUd9ISwLs
	 AWggpBUpWFtMsUH8Y3GyOatmTCGwFd/fAD9hNp8hC4+IrQfbRPfw1eGd5ZAN6YoMK9
	 DcB2FqS+DHyO10GnP19jwMFTGLzgDzeRUEJf+4Pe8OyVZGJHLWeNdiXqk9b8kDrwFU
	 Rb35rREHWcVLlcNipVHyc283piuXCKmhxMb14ZxeKzJk/5l9EfPqgantKqs/eabs6w
	 r6s31oXVQImhgy8mWZgTufHh1rHFNZT9mn1AMYGOmbyQ9mCd9ASpliiIVIAeImZCmy
	 FTnKfIrogv2RA==
Received: from maru.local (unknown [62.232.99.130])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by extorris.mess.org (Postfix) with ESMTPSA id 9AA6241567;
	Wed, 29 Jul 2026 16:23:09 +0100 (BST)
From: Sean Young <sean@mess.org>
To: linux-media@vger.kernel.org,
	Sean Young <sean@mess.org>,
	Mauro Carvalho Chehab <mchehab@kernel.org>,
	Oliver Neukum <oneukum@suse.com>,
	Hans Verkuil <hverkuil+cisco@kernel.org>
Cc: stable@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v5 01/15] media: streamzap: Add missing rc_unregister_device()
Date: Wed, 29 Jul 2026 16:22:39 +0100
Message-ID: <96fd93385f18492cdafaa964e91e82671fc62fc9.1785338381.git.sean@mess.org>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <cover.1785338381.git.sean@mess.org>
References: <cover.1785338381.git.sean@mess.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

If usb_submit_urb() fails during probe, then the error path is missing a
call to rc_unregister_device(), which will leak various things like the
input device.

Fixes: 42844992664f ("media: rc: streamzap: Error handling in probe")
Signed-off-by: Sean Young <sean@mess.org>
Cc: stable@vger.kernel.org
---
 drivers/media/rc/streamzap.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/media/rc/streamzap.c b/drivers/media/rc/streamzap.c
index 307985d74fe8..41195ad82734 100644
--- a/drivers/media/rc/streamzap.c
+++ b/drivers/media/rc/streamzap.c
@@ -365,6 +365,7 @@ static int streamzap_probe(struct usb_interface *intf,
 
 	return 0;
 rc_submit_fail:
+	rc_unregister_device(sz->rdev);
 	rc_free_device(sz->rdev);
 	usb_set_intfdata(intf, NULL);
 rc_dev_fail:
-- 
2.55.0

