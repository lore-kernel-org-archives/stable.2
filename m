Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792500842;
	b=c73wc/uZMMEu62GHCiTJk36DmjVEOSmKXCeB2DWPke5Cuh4sA0iHzNhXKGuE+fIAgExx
	 6ufkstcwAjcPpBzmq3NDZpvU0uo2iGAIyq/NjsUeejLckTKva4626QpRfygwHAh27FAtj
	 sNVtTsNIOKFbuAOBEw2HKbmsGRZQXhK5xaQ4+Jn7EbVzkHi3qYxJ1GwL5jO8QYeq9yHFw
	 Q1F+p5CFGPTviMBClK2mIcblwfMmfGJNuGeN5pp2ejNQyF1wWntVg5n75Y5z/QIADGi0I
	 4jW6Lb2sVO04+N1DCdwDWBBWOefb8Ew4MQ35+dgSDXxyMChh7JxbfJWaUgZHk3LW1kQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792500842;
	h=Received:DKIM-Signature:Received:From:To:Cc:Subject:Date:Message-ID:
	 X-Mailer:MIME-Version:Content-Transfer-Encoding;
	bh=ChL/BYNEwE3sYyCeCJrorSp0a/v/mqSQUACowwaz6zQ=;
	b=mYbPPqlBV2b3/50QNNrk1zr2sTg+m/GI2++wqqtp9rRlkrLkUhWSBhrrKuqVzKOHWJVC
	 TfRgm7bf6te/HgFAjU+CMAOdE1KCkjRy+f87phJWQmvEIdXWIkmxygy973ddQmgUaltSe
	 5M+AGs0LOAQaPKHxAlvaZVa+JwY8A+N5VUQqKui5cSvIrgl5rCI814meTWQ+OoeXDNWVI
	 rVWBlcLMX13HbzrsdKh5p1kcRtFTOVRLz0FNKSElZh4HR/QaXrSer/+CoPoDxum7vsIqx
	 54ZD0zu09YbuXE6OW7pTk0HB/w9cQid1h1FON7bqU2KEZTHYAuOyNZiZk+9vut6ZYPA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=dPfeoqBG;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 41E80606A31A;
	Tue, 20 Oct 2026 12:54:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=dPfeoqBG
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D4F741F000C5;
	Tue, 20 Oct 2026 12:54:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792500841;
	bh=ChL/BYNEwE3sYyCeCJrorSp0a/v/mqSQUACowwaz6zQ=;
	h=From:To:Cc:Subject:Date;
	b=dPfeoqBGQ1yZfvM9tFJY9M53oRagx2zq9VcXSRNkkbpozdT8ZCNwYKRL4yQM1gK0l
	 UiRkzYeIo4rO3L3N+2Kxl0mf4HTMY8WovaNAZwqpYakWjnQIB7CTV67dNz4aAF2Aky
	 7EmyahZgRLL5SO4vES+U1/fy+acSeRjsqEf4BbUOzFe/MPLsFsS7YPYGsWr/1XytyK
	 sNv+lUIcMt4tOLUio8ZSZg1uDVyHVBh7m9CHTk1pfvn4vLgi5wn8D9wwFTCpFmVWUJ
	 +0hgoc2FHDnA2R7RHIsjpcnJDgDtteDBfwjbSeIaEPPtgrUrBw5hmDTkcFgRdxFvor
	 XCZwnJ8SFbhHg==
Received: from johan by xi.lan with local (Exim 4.99.5)
	(envelope-from <johan@kernel.org>)
	id 1xJ9Lr-000000090G2-2Eel;
	Tue, 20 Oct 2026 14:53:59 +0200
From: Johan Hovold <johan@kernel.org>
To: Johan Hovold <johan@kernel.org>
Cc: linux-usb@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Oliver Neukum <oliver@neukum.org>,
	stable@vger.kernel.org
Subject: [PATCH] USB: serial: sierra: fix runtime pm leak on resume failure
Date: Tue, 20 Oct 2026 14:53:47 +0200
Message-ID: <20261020125347.2145928-1-johan@kernel.org>
X-Mailer: git-send-email 2.55.0
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

Make sure to balance the runtime PM usage count also if delayed URB
submission fails during resume (e.g. to allow runtime PM to be used
after the driver has been rebound).

Fixes: e6929a9020ac ("USB: support for autosuspend in sierra while online")
Cc: Oliver Neukum <oliver@neukum.org>
Cc: stable@vger.kernel.org	# 2.6.32
Signed-off-by: Johan Hovold <johan@kernel.org>
---
 drivers/usb/serial/sierra.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/usb/serial/sierra.c b/drivers/usb/serial/sierra.c
index f2cc7f364d20..d2d84542d86c 100644
--- a/drivers/usb/serial/sierra.c
+++ b/drivers/usb/serial/sierra.c
@@ -973,6 +973,8 @@ static int sierra_submit_delayed_urbs(struct usb_serial_port *port)
 			usb_unanchor_urb(urb);
 			kfree(urb->transfer_buffer);
 
+			usb_autopm_put_interface_async(port->serial->interface);
+
 			spin_lock(&portdata->lock);
 			portdata->outstanding_urbs--;
 			spin_unlock(&portdata->lock);
-- 
2.55.0

