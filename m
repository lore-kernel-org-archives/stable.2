Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793659143;
	b=Ngpmj/h3OW/ThNYNTYtIP0uvvPGPlTlyMVzlqFqFtUkcdYX3s+HGvosQ6OyzQU7Xle3C
	 D4b4Do+J/QHOJcfC2pIN3T9lWZXI3BVQTlTCKi/RK/GUE2uYifZFPDMWL8Exsz8tIVd7c
	 7/qVtlzNZOYLc3blmH7LzQdFZVJ4R1j1FAoIc2d/V2k+6pirb7v1YlRbOcG2SphaZXQrW
	 mYZfabPiJ3pr4Kcnjl4OUL8CJelvOEGntbmyyAxDA6rztR9lv/qnvLt8zFRVdrEK2V9P/
	 oI/LiaHQgznkkAcuIRDfVuJ+/PaYFbs3GRvW27H/th1Oz7KKUurBMgaUS91vRMNK2aA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793659143;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=pEsErr8/B9QW6r/vBViHOeVO+a5kU1j9VPBmnw9SyxI=;
	b=WjBOzed6u8BrURV2cKI+cz1oHBJye3jeDtnMitVT449M7E3Hjg9p3o3I9YeIrNIr8EHh
	 wAvPw6q1ZmCg03VPaQAMobxlAQzhG/9vCh64RkueNjVzEYweREk4Bw+W1XmkpSAetGwQ0
	 mCHTkWoyz2sNY6tn/P7s08izC7QoQMBbeBbx/mke5RzCDvXxQyXzuToJooceAnzMIjIob
	 OdwicV1OQFknAvA26ajeOTRzEyLfxsaeghW3LI7PvUoUtgjGFgd6aZh1kt9IH6jVZ0auX
	 eN6ngP8c6qJ4JBl1CJ5R9ooW8Fmp7nt6vckkik5ORGj9MCgkJOeSI/gnTPco7QYgSLg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=g7lypcZr;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DFDA4606A326
	for <stable@vger.kernel.org>; Mon,  2 Nov 2026 22:39:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=g7lypcZr
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0B76D1F00A16;
	Mon,  2 Nov 2026 22:39:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793659142;
	bh=pEsErr8/B9QW6r/vBViHOeVO+a5kU1j9VPBmnw9SyxI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=g7lypcZrjodG9Gc8HmwP3RwXTk+3g9y444tsawaMYGr1vkNf1Ysd4oJPsAvIFzrex
	 3zeYoOqWiSqMKVLB3wMsKzXKb728krPCtz0WfRWGxAIFSXL2bNCkWhC6ZoZ0r8Kf9c
	 P0AP6Ccd59UCL0VaFDcL/6+y+6YjJzqDR7PQfTV/j5Em7r8P2rvK885xfQ5/DQz0VJ
	 Np1HOp99L/AMmtDj8nQhv/sCMOu2BMp1iAvdnkKzW1OGsS4+XjvEWQpf5xTfiMg6sS
	 v9Yzc4TJlr+gpw2RkViVxkfczA4BK3jXv7fmW2XRAbees9tmmDzgNZqcjOm0/QOUSp
	 0SxE1ajORF82w==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Johan Hovold <johan@kernel.org>,
	Hans Verkuil <hverkuil+cisco@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.12.y 1/2] media: usbtv: drop redundant device reference
Date: Mon,  2 Nov 2026 17:38:59 -0500
Message-ID: <20261102223800.2122371-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026110227-ravine-cider-7c49@gregkh>
References: <2026110227-ravine-cider-7c49@gregkh>
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

