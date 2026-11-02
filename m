Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793657692;
	b=m0CJl6q6v8Uw34bpe0SYHfFG+zU1nizhKOD3zVCqD8jQfrtfo1ZQ7f2+W3i4b3xz+/dh
	 hvLYUN63RlFMarY4IyqUYnHE5VYmXyY3cZp1eQONWRuU12EW6f9BLhY25OZdptuZtq70B
	 LxqQJH7+EOXHwI+3is+dBPOBpLYRj/781JuKNsj4EM6oZTWnO/0CEnNN+nLTK5SpCdho7
	 2VSwXiQ0azu5piAJM3+ifkCtcjeFHiWnvjX1nC9qAoF4xuJCfy5NTcw2w4ntBSfn3JSSG
	 AxgmiyXu29k1CXQoZzddLekBHkG2lPSiQeQ/9M6TVYKAe1rLAe50NUgxxu2lZ+WuAaw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793657692;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=pEsErr8/B9QW6r/vBViHOeVO+a5kU1j9VPBmnw9SyxI=;
	b=hwpIkgam2e+4Nmxl3buBADTRlAf/laT+I93Cx0G2JOYV8hdF3UFhvz7XWSSEOWf/50s3
	 aBLj6nAsjneQr52C/FF4vOVKSPygoaux8SM2Tz2HuVLWgGwjOPeqfwUfKc5aqHvB6l8bq
	 EyJMuIRQG5+EdaaWs/bvx4taU7lo8NYSPmj8pX+2pXEVR4o6j4zAW0ig9dug5tViF//KY
	 DcnJvp+HReH2unZ6tN9rSUfDornJ+7WddEFzfs1x7ZcDjrJ/0tyP+BtcOlhnKZq04jv4B
	 EAklt3E2GEaMhTitBi03MiMWX1WZUG6S24aVqP3s0JtQu+skSkAsDj2ywFyvGIlncxg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Ne2grGRT;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A63B2606A324
	for <stable@vger.kernel.org>; Mon,  2 Nov 2026 22:14:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Ne2grGRT
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 024201F00A17;
	Mon,  2 Nov 2026 22:14:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793657691;
	bh=pEsErr8/B9QW6r/vBViHOeVO+a5kU1j9VPBmnw9SyxI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=Ne2grGRTxF8ITMmylmS1px8RkhSHnqWf+Rw8lbZjGeSw+NS0uvMlpOtMOVYek9jcm
	 Li7ozTqt/IdCGggrxa/2xF7bmDpqdGipebepoxtlsjOubCAlIic6VZCDhhZyNvY93j
	 LQ+ED/IUmcquLSVNnZu0ly68Cgon9X/CfCCBApz92NEPgIiUw4V8Xpj+ukqZdNtqw2
	 HisWDeS/TGiXad+r9aKDlGFh1vXl1QE59c7D9KXkykfvMRlthOftbai3xGt+GeAKTl
	 7tvI6ixcwxDWQv6FEVlTtP9eusTN+Xjkis50pZ39hI77FckWNYpXCgpM9TgLrSppys
	 8/UUowQKq15Dg==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Johan Hovold <johan@kernel.org>,
	Hans Verkuil <hverkuil+cisco@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.18.y 1/2] media: usbtv: drop redundant device reference
Date: Mon,  2 Nov 2026 17:14:48 -0500
Message-ID: <20261102221431.1933091-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026110226-immunize-simile-9c23@gregkh>
References: <2026110226-immunize-simile-9c23@gregkh>
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

From: Johan Hovold <johan@kernel.org>

[ Upstream commit dbc6798b80481a20f9aff671bc4d529eae63c9e8 ]

Driver core holds a reference to the USB interface and its parent USB
device while the interface is bound to a driver and there is no need to
take additional references unless the structures are needed after
disconnect.

Drop the redundant device reference to reduce cargo culting, make it
easier to spot drivers where an extra reference is needed, and reduce
the risk of memory leaks when drivers fail to release it.

Signed-off-by: Johan Hovold <johan@kernel.org>
Signed-off-by: Hans Verkuil <hverkuil+cisco@kernel.org>
Stable-dep-of: cb705f75d03e ("media: usbtv: fix null-pointer dereference on disconnect")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/media/usb/usbtv/usbtv-core.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/drivers/media/usb/usbtv/usbtv-core.c b/drivers/media/usb/usbtv/usbtv-core.c
index 1f7620cd2996d..4925113af9603 100644
--- a/drivers/media/usb/usbtv/usbtv-core.c
+++ b/drivers/media/usb/usbtv/usbtv-core.c
@@ -91,7 +91,7 @@ static int usbtv_probe(struct usb_interface *intf,
 	if (usbtv == NULL)
 		return -ENOMEM;
 	usbtv->dev = dev;
-	usbtv->udev = usb_get_dev(interface_to_usbdev(intf));
+	usbtv->udev = interface_to_usbdev(intf);
 
 	usbtv->iso_size = size;
 
@@ -119,7 +119,6 @@ static int usbtv_probe(struct usb_interface *intf,
 
 usbtv_video_fail:
 	usb_set_intfdata(intf, NULL);
-	usb_put_dev(usbtv->udev);
 	kfree(usbtv);
 
 	return ret;
@@ -137,7 +136,6 @@ static void usbtv_disconnect(struct usb_interface *intf)
 	usbtv_audio_free(usbtv);
 	usbtv_video_free(usbtv);
 
-	usb_put_dev(usbtv->udev);
 	usbtv->udev = NULL;
 
 	/* the usbtv structure will be deallocated when v4l2 will be
-- 
2.53.0

