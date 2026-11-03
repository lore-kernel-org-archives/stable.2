Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793665017;
	b=daGDNIS0rT7QBNz0CxeBb+7ZTEAtZa6bpTqIkizIwPm5C95Tt9hlAYbPJhC0vUiKra0T
	 ElUvlQBhJW5J245llnYXkzwzC1oKq7VOQ26jN8wF0Dcro5NUV8pLcPYD4ZcYIS/A+cplx
	 ru1hlQwNXm8CGMTriPA3q3wtI6nILUPKDTLQWrhcy7dfLf7QlX1/ahyoRS0+RBFR+cUCY
	 3MgYLmkCS082FWj15p9EU9tMMLJdVf3eL5P4Kuyh0vBs3SIcLWGgtiR7biA3K2XCwARCI
	 ZWCWPCw+Tg4CUCzmUmpaDGnBBbqUYDxWhPovFV6y6vx1sL7vRkkusy5wHxmGfsuQpUw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793665017;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=v7igtyyA7YhJUh6CZwrIeNjSU4tN7hbWb9YP/Bw1N7s=;
	b=lXcu+Esa59dC6IRewzR9wBd0zJ+yk2kpbOyK36clectKWM4XCa0KGEXClFtYzDq0lwRz
	 G4GjZamn+jTEFYQO/AMP6zDQ9cHYEodqOL23HpFhvHy1NF4xBGpmTz7/GYxsgzy/cngMR
	 Dupr+qF4754EcDsRUSVfBhG36r6GG4dtjdVOwyNi2XL1h9ivkB3qpkUHpEePjPCZCT9eK
	 +RuNJKDx1MJ8grxRbe9UyNo57lO+ZmOSTC+2WDT1RYWT7boPfFOMqKvIDJRy7MLQWq9jJ
	 g8Zb32uNT1hd1Apj9+mHPZJAA2JAl4+UbH8WjZePlh2g342Oi9H7rcQAmAsR5iiy4fw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=SivoErsq;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 699C9606A326
	for <stable@vger.kernel.org>; Tue,  3 Nov 2026 00:16:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=SivoErsq
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 84E141F000C1;
	Tue,  3 Nov 2026 00:16:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793665017;
	bh=v7igtyyA7YhJUh6CZwrIeNjSU4tN7hbWb9YP/Bw1N7s=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=SivoErsqo2eHqIdYMJc0Kd7p7cRJjLDyPMkStYXT5cnGipdjBgaIm+BGFJP1gmyIt
	 i34lr7JrmDOvLbhCUEhWNBBKfy4fxPHKU09iyVsFcz651ju89h9Zbsh6j25uoZciJ+
	 eNzUHUBQEEwiKghEj19eNtkLXHy4GgI1wYlbcXmHARfCWq+HBT9FZXvvzKRn0t3jcH
	 Cnzsxb29ui3YBs8eFfddThWZJf0OF7yY8LP3xlA7Si1K7fZgVp5LC4jKM8TjhZvaY3
	 VA8y/5FQsOJktylhRLE6SK3RFWnMt5B/Fw3uYE9WE2PiRceYdl722k4oWb3y6B4GDi
	 Z+1xhdh5e/d2Q==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Johan Hovold <johan@kernel.org>,
	Hans Verkuil <hverkuil+cisco@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.10.y 1/2] media: usbtv: drop redundant device reference
Date: Mon,  2 Nov 2026 19:16:53 -0500
Message-ID: <20261103001640.2937037-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026110231-enroll-brewery-d028@gregkh>
References: <2026110231-enroll-brewery-d028@gregkh>
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
index 2308c0b4f5e7e..275b21404dd22 100644
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

