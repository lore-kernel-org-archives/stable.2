Received: from extorris.mess.org (extorris.mess.org [92.243.27.206])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4FEC7372B57;
	Tue, 15 Sep 2026 08:33:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=92.243.27.206
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789461185; cv=none; b=c9S0wDWQtlQ1htb7e8Eu3kzceZlB6g/BEGvKSKEdW6gO4ZtBHmPLpwwW/g8OyZ/uk66+23k+sBQ3Wvc2wjPHkCKN5DvTaDfEHsA/1LkBWvJlJZqbVDZlQP9RzX4aDuL66xqbEs0WbieVyTrlMcNf8ofqhSWCLrwQv3/eHmdZj58=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789461185; c=relaxed/simple;
	bh=WNs8D4arokG53Zki8ASyISHql/nDLj2Xji+hml43eFA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=YeR5FhB/YH9zHWmGdspYDlixfBfGAxm9FRGa93Ov6wDM+a8rbXgq0/rUO0tgIr9cO56aua7S1gRbc3L1rusIfLk9CHLtBsBdM6ct+SCi8KmeEY7KhjQZO/wtZeI5z0PBN7LtwRzhQf+IIQu0RW3A4akb6KkqYOz00Bf9E4g7W1w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=mess.org; spf=pass smtp.mailfrom=mess.org; dkim=pass (2048-bit key) header.d=mess.org header.i=@mess.org header.b=toGbY8E0; dkim=pass (2048-bit key) header.d=mess.org header.i=@mess.org header.b=QV4VS6G3; arc=none smtp.client-ip=92.243.27.206
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=mess.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mess.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mess.org header.i=@mess.org header.b="toGbY8E0";
	dkim=pass (2048-bit key) header.d=mess.org header.i=@mess.org header.b="QV4VS6G3"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=mess.org; s=2020;
	t=1789461176; bh=WNs8D4arokG53Zki8ASyISHql/nDLj2Xji+hml43eFA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=toGbY8E07siYO3WB1Q/MDl/oUAtA+Rr0w7COCNeZjw/9Mm9LsKsLNKgtytSLwn4f1
	 R7Wz2+eR6Ge7SKbFfKRhJh1/jgUvePhcUZTbrz7i0PVZAPx5KZjhh3Vz2SFPP4tipc
	 ZBa9QXCPW9ECT6CqdFTeuMrgB3eH7nKUPv8wcqIHsasH0iDZzVb5IGl6+GJriOIj2k
	 5qVsCpUPSvuSI4RxLx0dWLzSLYDMdKbSG1p5xPFjlQk5p0wjudYwgkP9aCBSm9vq9X
	 Wx+Nubbru4/uZDVoFSMUqxRCJz0CJKFKw2snwOnpvW5p85y7A+xDpwT8HifDCwqGCw
	 G1/8gzJSYgs1g==
Received: by extorris.mess.org (Postfix, from userid 1004)
	id A312040BA6; Tue, 15 Sep 2026 09:32:56 +0100 (BST)
X-Spam-Level: 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=mess.org; s=2020;
	t=1789461175; bh=WNs8D4arokG53Zki8ASyISHql/nDLj2Xji+hml43eFA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=QV4VS6G3cK+ArccT4crWhY6b2/9MbQI63yqzA8RVLjCBmxKoLn016ssfxTlrmU8nQ
	 yl5onhVB2AaskLQSvgSOTbMbBr3qmWGYw4zq5vNKsXcR00W4mojeHpBh3V6xsNxdC9
	 k5Pa5e50mlTdCjGe3asT/Uqz+W7SPV25hcQfcW2Iqwj6swWQFCA4tpLpKbyohVBI4D
	 dmF4/wfyN8M6ePytQ1Hwqi4QoYezRF/pEVX0dohkHJOvcmjYr+SsPI99Du0Ltj44Tk
	 gsOv6VrIZEtfgA6/rXnqmbR4UuCVrYr7rPVvRNgE3Jfm6NDqKIToiNSL72AgWViSgh
	 auXRK3k1zeniA==
Received: from maru.home (host81-158-254-226.range81-158.btcentralplus.com [81.158.254.226])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by extorris.mess.org (Postfix) with ESMTPSA id 5BDE840155;
	Tue, 15 Sep 2026 09:32:55 +0100 (BST)
From: Sean Young <sean@mess.org>
To: linux-media@vger.kernel.org,
	Sean Young <sean@mess.org>,
	Mauro Carvalho Chehab <mchehab@kernel.org>,
	Hans Verkuil <hverkuil+cisco@kernel.org>,
	Patrice Chotard <patrice.chotard@foss.st.com>
Cc: Rik van Riel <riel@surriel.com>,
	stable@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v5 01/20] media: rc: Ensure registered is cleared in error path
Date: Tue, 15 Sep 2026 09:32:11 +0100
Message-ID: <d357f944fe9a4c771f210f09ef65ccd20dd25aa0.1789460680.git.sean@mess.org>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <cover.1789460680.git.sean@mess.org>
References: <cover.1789460680.git.sean@mess.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

If rc_register_device() fails, ensure that registered is not set to true.
If lirc_register() succeeded, then userspace could have an open file
descriptor open. This leads to a use-after-free.

lirc_unregister() must be called with registered = false, else there is a
possibility that an fd is open and polling, which would never return
POLLERR unless registered is false.

Note that registered must be changed under dev->lock, many functions
read registered under lock (e.g. lirc_ioctl).

Fixes: dccc0c3ddf8f ("media: rc: fix race between unregister and urb/irq callbacks")
Signed-off-by: Sean Young <sean@mess.org>
Cc: stable@vger.kernel.org
---
 drivers/media/rc/rc-main.c | 16 ++++++++++++----
 1 file changed, 12 insertions(+), 4 deletions(-)

diff --git a/drivers/media/rc/rc-main.c b/drivers/media/rc/rc-main.c
index d93e98189c1a..930d45517229 100644
--- a/drivers/media/rc/rc-main.c
+++ b/drivers/media/rc/rc-main.c
@@ -1934,7 +1934,8 @@ int rc_register_device(struct rc_dev *dev)
 			goto out_raw;
 	}
 
-	dev->registered = true;
+	scoped_guard(mutex, &dev->lock)
+		dev->registered = true;
 
 	rc = device_add(&dev->dev);
 	if (rc)
@@ -1954,7 +1955,7 @@ int rc_register_device(struct rc_dev *dev)
 	if (dev->allowed_protocols != RC_PROTO_BIT_CEC) {
 		rc = lirc_register(dev);
 		if (rc < 0)
-			goto out_dev;
+			goto out_lirc;
 	}
 
 	if (dev->driver_type != RC_DRIVER_IR_RAW_TX) {
@@ -1977,11 +1978,18 @@ int rc_register_device(struct rc_dev *dev)
 out_rx:
 	rc_free_rx_device(dev);
 out_lirc:
-	if (dev->allowed_protocols != RC_PROTO_BIT_CEC)
+	scoped_guard(mutex, &dev->lock)
+		dev->registered = false;
+
+	if (device_is_registered(&dev->lirc_dev))
 		lirc_unregister(dev);
-out_dev:
 	device_del(&dev->dev);
+	/* registered already cleared above */
+	goto out_free_table;
 out_rx_free:
+	scoped_guard(mutex, &dev->lock)
+		dev->registered = false;
+out_free_table:
 	ir_free_table(&dev->rc_map);
 out_raw:
 	ida_free(&rc_ida, minor);
-- 
2.55.0

