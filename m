Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=101.71.155.101
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795011064;
	b=LHrol4WDfL2sRwi0WeQsFqcfQFF3WMXki07oYbEP+uahf2P6BdK83x6QrqNV0hRu66Zy
	 hRjqEwsfMXE7DZcUBCg0U+xoAmLHy3ntGMun/Z+uMnD1hOb/ZkSV+TUR/rUZ3uZpQn1Cb
	 P1cGabXmiwoEQHMr1FvL++K7AH7xsGMIabYPZNFHv2mz/4fMM0KVZa/xz8hKiEfvfx0ZH
	 cDrC/2BvDpjZJzAFBE1uSREyMOgJNY+yShZ9j2k7M3eaQ2GAtAMq5J7VsG75zAtI9pzWt
	 l6l0UFqBIebtLzX60EnsE4gDwKXvXVCJkbZz6yXi0cyOzpOXz6if47Jrn6HqlGIpPlg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795011064;
	h=DMARC-Filter:Received:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:X-HM-Tid:X-HM-MType:X-HM-Spam-Status:
	 DKIM-Signature;
	bh=0sSkgJi+Iy6AbBDGZ/m3UoHILo4pwmgba+6jz8hywfI=;
	b=Vf9OpB70XMAHC6TK0smBH22gkMe7tHJbuR/AwHVUj476iLxsEnOu3GEHyagoQ7smM6LI
	 syeLTgDObr3CmLlb6etFLUtNtl4TRAF0fCTR1Lp5EQ82VRYmiIwGsuFJwvDJzwmoqRx7g
	 Ujg1dGuTnWYBxHjGqaL31XbLYBQhZHxQbqbbECOnGkRWpHzzNbMuk3m9ASbE+aC6laV9w
	 ogF2j5pjjMpvWpNUH2ZSStxOndiNL2N3n7pBd/9UO2qK+J2mBcESetcJ5pAzeUKrVobgm
	 Ny7vr/73mJSvS8EkcIpNtXprbaUzdQY9aHCmnHMxYjVrTRUFgbmjlbULUvVxnPfzmUw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=mail.sdu.edu.cn;
	spf=pass smtp.mailfrom=mail.sdu.edu.cn;
	dkim=pass header.d=mail.sdu.edu.cn header.i=@mail.sdu.edu.cn header.a=rsa-sha256 header.s=default header.b=HrES4Tp4;
	arc=none smtp.remote-ip=101.71.155.101
Received: from mail-m155101.qiye.163.com (mail-m155101.qiye.163.com [101.71.155.101])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5A5EC60A2625;
	Wed, 18 Nov 2026 14:10:58 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 5A5EC60A2625
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=mail.sdu.edu.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mail.sdu.edu.cn
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mail.sdu.edu.cn header.i=@mail.sdu.edu.cn header.a=rsa-sha256 header.s=default header.b=HrES4Tp4
Received: from lgs.. (unknown [101.76.249.61])
	by smtp.qiye.163.com (Hmail) with ESMTP id 5526d7801;
	Wed, 18 Nov 2026 22:10:53 +0800 (GMT+08:00)
From: Guangshuo Li <liguangshuo@mail.sdu.edu.cn>
To: Neill Kapron <nkapron@google.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: linux-usb@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linuxppc-dev@lists.ozlabs.org,
	stable@vger.kernel.org
Subject: [PATCH 1/2] usb: gadget: fsl_udc: Fix potential use-after-free during removal
Date: Wed, 18 Nov 2026 22:10:53 +0800
Message-ID: <20261118-324f82bd41-usb-gadget-1@mail.sdu.edu.cn>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261118-324f82bd41-usb-gadget-0@mail.sdu.edu.cn>
References: <20261118-324f82bd41-usb-gadget-0@mail.sdu.edu.cn>
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
X-HM-Tid: 0aa1eeff090603a1kunm8266b8a11a0aa5
X-HM-MType: 10
X-HM-Spam-Status: e1kfGhgUHx5ZQUpXWQgPGg8OCBgUHx5ZQUlOS1dZFg8aDwILHllBWSg2Ly
	tZV1koWUFITzdXWRgWCB1ZQUpXWS1ZQUlXWQ8JGhUIEh9ZQVkZSkJDVhpPSkJLGB1PTk1MGFYeHw
	5VEwETFhoSFyQUDg9ZV1kYEgtZQVlKS0pVTE1VSU9CVU1KWVdZFhoPEhUdFFlBWU9LSFVKS0lCQ0
	NMVUpLS1VLWQY+
DKIM-Signature: a=rsa-sha256;
	b=HrES4Tp44DGQexBDvC2aVamA/bscbe+hZ2E8EVhnkiSq/sXlJiPNQjkWO/rFbdwDE1jlPnuJPpRNbDegiCb0KRxAdkZRc0kTZG+NSWhvKKBxuu//ifvpIVcdYlGaed8zmNjn81+Mb0Evp+bznl8hhHBXmw/oViXnWNl8E72gKE8=; c=relaxed/relaxed; s=default; d=mail.sdu.edu.cn; v=1;
	bh=0sSkgJi+Iy6AbBDGZ/m3UoHILo4pwmgba+6jz8hywfI=;
	h=date:mime-version:subject:message-id:from;

usb_del_gadget_udc() can drop the last gadget device reference and call
fsl_udc_release(), which frees udc_controller. The remaining remove path
then dereferences it to release its requests, endpoints and DMA pool.

Hold a gadget device reference until this cleanup has finished.

This issue was found by our static analysis tool under development.

Fixes: eab35c4e6d95 ("usb: gadget: fsl_udc_core: let udc-core manage gadget->dev")
Cc: stable@vger.kernel.org
Signed-off-by: Guangshuo Li <liguangshuo@mail.sdu.edu.cn>
---
 drivers/usb/gadget/udc/fsl_udc_core.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/usb/gadget/udc/fsl_udc_core.c b/drivers/usb/gadget/udc/fsl_udc_core.c
index 878d70b55530..9d9d2164c5bf 100644
--- a/drivers/usb/gadget/udc/fsl_udc_core.c
+++ b/drivers/usb/gadget/udc/fsl_udc_core.c
@@ -2537,6 +2537,7 @@ static void fsl_udc_remove(struct platform_device *pdev)
 	DECLARE_COMPLETION_ONSTACK(done);
 
 	udc_controller->done = &done;
+	get_device(&udc_controller->gadget.dev);
 	usb_del_gadget_udc(&udc_controller->gadget);
 
 	/* DR has been stopped in usb_gadget_unregister_driver() */
@@ -2554,6 +2555,7 @@ static void fsl_udc_remove(struct platform_device *pdev)
 		release_mem_region(res->start, resource_size(res));
 
 	/* free udc --wait for the release() finished */
+	put_device(&udc_controller->gadget.dev);
 	wait_for_completion(&done);
 
 	/*
-- 
2.43.0

