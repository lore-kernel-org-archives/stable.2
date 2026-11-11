Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=45.254.49.198
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794399793;
	b=qLPWUhN1u1SfEIafTXXUPOp7PGmjo0bDXUSvuKwGuhodMIeLLe9glVi6otnAn3HyNU7/
	 iqX+N+88tRvuwjF0GYCfG24EyFYuhgnD3inazNnlqT4LysloJudl/nbtn139iyje78KyS
	 sznfYCTnB0KlNLe+3VZDD/mj3BEs6zEGDWIrNEDUisQGrFBp3tdkgrtr86suXtJ5q3sbl
	 NBFNDPfZWTK2EChwObpcff4yY4Pl0giariEUYJgR/3PlHnTNDVDXPRqPgJPImf7hN8tdm
	 32oBIUYnSOkA3BPJSziylPa/fdgmOneGN04iyBflhkHsBlqlNraw5Xd6aUoLEHgsQew==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794399793;
	h=DMARC-Filter:Received:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 MIME-Version:Content-Type:Content-Transfer-Encoding:X-HM-Tid:
	 X-HM-MType:X-HM-Spam-Status:DKIM-Signature;
	bh=y7c3LFXE7WLvqhMO0fMoXZeL2mSZGG6x7D/2Qalj/xg=;
	b=oo19Supb1XkpeP5SgkypWbAWb54OC3zk1HfFeHSf8vyNtL7bo9YmqM+jQFkuVu6WwDjn
	 nfpDLqgIc2m8V7qwAaBRjExwbzefnF8Bq1e8Fe2YSFVyBppz9N70FWZDmoEJ1j+y61VRl
	 Wlvb3ROGj58Ju65yDA0jhV0gUbvj/usYve2rM7God7hqqd+Y4/vmMSGOuvXagjfJmggKL
	 lAcTLhYFKQ/tFTOYp6mPqNrRcLT+vodIpNoT6EGch5h9pX80c7J0A1jjTSamdEOUB/yfZ
	 P2U9QHytTkhC7NjAyCY3XZp1AwJCpAsKjFQNsWvp74R1tX4rOHMKu3hVS8H0CxlPbug==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=mail.sdu.edu.cn;
	spf=pass smtp.mailfrom=mail.sdu.edu.cn;
	dkim=pass header.d=mail.sdu.edu.cn header.i=@mail.sdu.edu.cn header.a=rsa-sha256 header.s=default header.b=PwzHthlg;
	arc=none smtp.remote-ip=45.254.49.198
Received: from mail-m49198.qiye.163.com (mail-m49198.qiye.163.com [45.254.49.198])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 350D3606A321;
	Wed, 11 Nov 2026 12:23:09 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 350D3606A321
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=mail.sdu.edu.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mail.sdu.edu.cn
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=mail.sdu.edu.cn header.i=@mail.sdu.edu.cn header.a=rsa-sha256 header.s=default header.b=PwzHthlg
Received: from lgs.. (unknown [101.76.249.61])
	by smtp.qiye.163.com (Hmail) with ESMTP id 54502a16b;
	Wed, 11 Nov 2026 20:23:04 +0800 (GMT+08:00)
From: Guangshuo Li <liguangshuo@mail.sdu.edu.cn>
To: Alan Stern <stern@rowland.harvard.edu>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: linux-usb@vger.kernel.org,
	usb-storage@lists.one-eyed-alien.net,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: [PATCH] usb-storage: onetouch: Fix potential use-after-free on input failure
Date: Wed, 11 Nov 2026 20:23:03 +0800
Message-ID: <20261111-e5624093d6-usb-storage@mail.sdu.edu.cn>
X-Mailer: git-send-email 2.43.0
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-HM-Tid: 0aa1ca8fcd2303a1kunm43a9f0741b3654
X-HM-MType: 10
X-HM-Spam-Status: e1kfGhgUHx5ZQUpXWQgPGg8OCBgUHx5ZQUlOS1dZFg8aDwILHllBWSg2Ly
	tZV1koWUFITzdXWRgWCB1ZQUpXWS1ZQUlXWQ8JGhUIEh9ZQVlCSU1IVk4eSRofHkMZQx4dSlYeHw
	5VEwETFhoSFyQUDg9ZV1kYEgtZQVlKS0pVTE1VSU9CVU1KWVdZFhoPEhUdFFlBWU9LSFVKS0lCQ0
	NMVUpLS1VLWQY+
DKIM-Signature: a=rsa-sha256;
	b=PwzHthlgNNrA8wlP+z/8B0K1Swzm+x8QPhgBiMrO80rAxSX/pLpJSg13jKWvr33b1q/Yj1rSRWKDas3r7rOJKQyBjOiaqIScHLcA+kuGTP8KEFOag1zsvKjS1WlwBEao/pQ1kIr7YZz9xxWxPbdqIX6q34nL/zoC0GpnpwzC/MI=; s=default; c=relaxed/relaxed; d=mail.sdu.edu.cn; v=1;
	bh=y7c3LFXE7WLvqhMO0fMoXZeL2mSZGG6x7D/2Qalj/xg=;
	h=date:mime-version:subject:message-id:from;

If input_register_device() fails, onetouch_connect_input() frees the
onetouch state but leaves it installed in ss->extra. USB-storage cleanup
then calls onetouch_release_input() on the freed state.

Install the extra state and callbacks only after input registration
succeeds.

This issue was found by our static analysis tool under development.

Fixes: 17efe155253e ("USB: onetouch - handle errors from input_register_device()")
Cc: stable@vger.kernel.org
Signed-off-by: Guangshuo Li <liguangshuo@mail.sdu.edu.cn>
---
 drivers/usb/storage/onetouch.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/usb/storage/onetouch.c b/drivers/usb/storage/onetouch.c
index 49d281f7bef6..e09b3c6b9a6a 100644
--- a/drivers/usb/storage/onetouch.c
+++ b/drivers/usb/storage/onetouch.c
@@ -237,16 +237,16 @@ static int onetouch_connect_input(struct us_data *ss)
 	onetouch->irq->transfer_dma = onetouch->data_dma;
 	onetouch->irq->transfer_flags |= URB_NO_TRANSFER_DMA_MAP;
 
+	error = input_register_device(onetouch->dev);
+	if (error)
+		goto fail3;
+
 	ss->extra_destructor = onetouch_release_input;
 	ss->extra = onetouch;
 #ifdef CONFIG_PM
 	ss->suspend_resume_hook = usb_onetouch_pm_hook;
 #endif
 
-	error = input_register_device(onetouch->dev);
-	if (error)
-		goto fail3;
-
 	return 0;
 
  fail3:	usb_free_urb(onetouch->irq);

base-commit: 6628e7d4c6b25c8d18f1345e3a20d21829aae7e4
-- 
2.43.0

