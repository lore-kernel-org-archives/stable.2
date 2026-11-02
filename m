Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793663075;
	b=sC8oVw2/KlvU3JHABZBhiB1VT7zAQbtTVT0HAgMruMiKpNv6C0BmmnmcG7ILNIsPV51l
	 X0OinOSw9f5+T+XTmRU9kUAh+H7KSr8Ym7o5RQ00GISl0HT9XmMfQsRH8ClvzAQO683If
	 HnF2kNYAp0OodRajHqtvdlfujS+knjTo6To77mKK+hQypSWdgLqRZ6Lda3kO91d83FGN0
	 aJMJcPkYYHgxdCUf54hCYOibSo+l+E+6YRpGEBcprhJ4jVtbFDhzmggggonJqSQEiMA77
	 D8o7ARzWVKuZde8/pgnxrn9/WbFEShBt4fBoGOTPTu+M0HXu6Z3CsO22esTh8J4YDhQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793663075;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=v7igtyyA7YhJUh6CZwrIeNjSU4tN7hbWb9YP/Bw1N7s=;
	b=Ocw2zKzcAYOyXZu4jArooxHRWCyq3vGomeA2/tkIxbf3SjRz//2pr/ukCie7Zr+VpWow
	 MDCMFbTQkU+1XmdzeAqvibIT1bzMJGLwQHbGKnxscvnF8KNCkPWgUP5/YS+Lhm/xuonLA
	 8rZkmcclNZR+vuOBWdHxIQIrSz8H+wuIPSLG6FczL10pGc4tKTHaabmT/HrVxb06PQIBc
	 Uvp/o0pF1B4KjD6MtPd77gO5m403GGVZOI3ZuuI+zGhHNgG9hsUaGTTAG/gkReg3ZYXVG
	 TqiXKwQQIV6zCBA1QypyWajOUEJobLDdz8PzszmlunQxC7tac473IrqfFkLzI9HcggA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=gkaXQUPJ;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4BD99606A327
	for <stable@vger.kernel.org>; Mon,  2 Nov 2026 23:44:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=gkaXQUPJ
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 76C091F00A16;
	Mon,  2 Nov 2026 23:44:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793663075;
	bh=v7igtyyA7YhJUh6CZwrIeNjSU4tN7hbWb9YP/Bw1N7s=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=gkaXQUPJBtWTZhhGFeaH54i6hS9n9Ad2OY1dQfIs9gM4AZNvSrcCfr5/YGc5q05Yn
	 rHrQ2rkQd6P3GnfgPEorLo7f2hGEEnGQ2ikDhkrMTNYZ8oVaHGw+VHaAIXpLo2IBOJ
	 1QNKxNWDSOViBN7Mc5hmr7D3NRkcJ5ee/9u8Oh+2UxRk8/O25atJzYSicxkqax2rCh
	 Ac+/RUYKtQvDH8aCYTkTfStWBw+ewlh4nmbPHzo7rEk2vSyybwuhUxb3OzVzX5xpKa
	 8pCsadlXpRohU/9Crs7lzA7tMC62qq/M5rBQNSWaq5Hx1rJOQL7XlMOn1qH6zfTfl9
	 dViGyD+ukGrWg==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Johan Hovold <johan@kernel.org>,
	Hans Verkuil <hverkuil+cisco@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.1.y 1/2] media: usbtv: drop redundant device reference
Date: Mon,  2 Nov 2026 18:44:31 -0500
Message-ID: <20261102234411.2559732-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026110229-cosmos-scarily-2b64@gregkh>
References: <2026110229-cosmos-scarily-2b64@gregkh>
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

