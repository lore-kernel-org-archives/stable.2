Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793664054;
	b=K9OBO1dTcB10mfrCMPNVO3GGF7VqqN4UX6S5XtS3COKlMUkmxWqH5Vkci7FgPi7TOVsI
	 RHzlVIpoHdLhaMG3RaQHJhgtxph58d3DaAz6CRYJm0eoLu5byA+BYeuSfaldvmNw0PcNO
	 IvME5ih2plCqc67j5i9JGExoteJW1xnE9lua0UFgaTuaP4m7Q04E4yjUEJS9evc6krjG5
	 cCeyN9/6yhR2q6PpvvL7oZIBa/9ng4Wt0w9fUNpOAFQ9p0LKOZtsmz+39xCGKOS1uFmlT
	 NTQq6nqYEDFp1o/xEYlH5bWitIYzy9JFidj8igeJP1Th5X72ZXXdaSXbJo6t0d12SOg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793664054;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=v7igtyyA7YhJUh6CZwrIeNjSU4tN7hbWb9YP/Bw1N7s=;
	b=XzbF4C1Ha2fgPqrkEqXKK9pKchmD1bPOnCpECYhFfwOSXxkcpDRAsqCJsv6NMOsIFiG+
	 +OW2D5ymV3jF8zEVtIstL5P6Zce+rwUnR0Tky+nLS9y85SlpKbcMNU+vzZtMESniOCkgB
	 0cWOjaUu+H41WtQFu1F4lJ/7pcphyPUkKKMoYxcCBlgaADklk8m8Rzt1LPMgk/I+L0YSm
	 yr2ll7wFAGxWWU3FnnE5M99ftbaSDZ3YI8bUI7xARw1+B3NVjQsuNtLedG5U7ezv/9WO9
	 AAiO+s23NwEFNj7A9WPl1YnheYXGAWghOazbvlyHQzLB/Iy7qIP7BQN0kDNnYJF+iYA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=W0v1jv4t;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AB7E8606A324
	for <stable@vger.kernel.org>; Tue,  3 Nov 2026 00:00:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=W0v1jv4t
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DE9021F00A17;
	Tue,  3 Nov 2026 00:00:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793664053;
	bh=v7igtyyA7YhJUh6CZwrIeNjSU4tN7hbWb9YP/Bw1N7s=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=W0v1jv4tzlHXuOoXbBnn/MVyWKS0GMqH+9Ek6/ud5vBViYRk9mhMuPZpKpI/2x1Gu
	 Jcti7uE+WovAbNTgg0+XggBrh1z98BLnQYThsE7cJFQex+60XDOl2dhD/kQ2FYgl14
	 tDcHaH8v4RF6IewZT6OXTGvxIb7cQxLBgZfNM0Nykn/YwkqZ/XqXn8lmkUOperZC9Q
	 xFNdqYEZhjjQInM0am19HaCNDeQKm/HpmGISd7U50WfDwhhGKsTxSnKzC9/mAeejAx
	 SUj39VM+IcQ1Go0YguShioGjq0kD2Db2x1FBK4eOIuTVHxC76sFBQZVcrFH6eJ3xTL
	 mnX+Wk1flnhbA==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Johan Hovold <johan@kernel.org>,
	Hans Verkuil <hverkuil+cisco@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.15.y 1/2] media: usbtv: drop redundant device reference
Date: Mon,  2 Nov 2026 19:00:50 -0500
Message-ID: <20261103000039.2784878-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026110230-monthly-delighted-0afc@gregkh>
References: <2026110230-monthly-delighted-0afc@gregkh>
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

