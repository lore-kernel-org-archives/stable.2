Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=115.124.28.172
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793071425;
	b=udnY1bGq+zmwDyIDEhzDKQqlT6YF63Aryr1Ax2GLpmDYjV6JEPP8OADDLGsm2lrWbJP8
	 3dds8HMKfUpWi9DNqgEjPFapt12ghAadr31yu+8cwMhp/xQCVCHHkNL9lm0M3UNMwq2y4
	 37GHJvJiGtpN62DpOSPjb/kgXSZpgUlbNllkI01mTLBXomTlQMnrs9h1HValZG6MIkYgz
	 Pi1T+YnWCpVMtNDPeQmv6gSa67aSWO6JdHxfF/jauqeHYuy3Zr6S56exGe3F8nhGZieDa
	 wz6q8UPmRfNv+1Lry39N3XIN30Bf7+nAlBdLZPFuj+lJxvbO4SZbnZm8v+Hzr8JJikg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793071425;
	h=DMARC-Filter:DKIM-Signature:X-Alimail-AntiSpam:Received:From:To:Cc:
	 Subject:Date:Message-ID:X-Mailer:MIME-Version:
	 Content-Transfer-Encoding;
	bh=FoEUjTyegNiS67PR/0ZUdEzFa4c0jrRavIX/Sn4zPwE=;
	b=AyIl2pybFAotIX0uOEQ9+MsCAZf9wA0QKoDZjlUIlQAMdX99r0SdM/IyL6j/c6QcpqoU
	 q9Nm6GR/Q9s2IPzp6+wt8xWONtc27QcrKWIBJmgniUZ5wufu9FgQ3WoZrOZWh15ULdp4n
	 QYO+nSyEAeKD+iot/QbGF6/NNmmbZbapW3CUFMUE2Dzc48HRBCT00CbeKqd7DlGX7PMnQ
	 7DmsjeMHWN7T6aNEP3SGm1JDQuS+6h6trzYhtzIRJYOzwZElxYNDO54D6hGl5ij9hTg1k
	 ZLsz1aaXAnJGC/PW7QgNUIIzBkVvqJuSUpG62NnrMLm/TDzcRBjs6JknSPL5TebNHHw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=xiaopeng.com;
	spf=pass smtp.mailfrom=xiaopeng.com;
	dkim=pass header.d=xiaopeng.com header.i=@xiaopeng.com header.a=rsa-sha256 header.s=default header.b=ZC6yQb+W;
	arc=none smtp.remote-ip=115.124.28.172
Received: from out28-172.mail.aliyun.com (out28-172.mail.aliyun.com [115.124.28.172])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D37B1606A31D;
	Tue, 27 Oct 2026 03:23:42 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org D37B1606A31D
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=xiaopeng.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=xiaopeng.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=xiaopeng.com header.i=@xiaopeng.com header.a=rsa-sha256 header.s=default header.b=ZC6yQb+W
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=xiaopeng.com; s=default;
	t=1793071414; h=From:To:Subject:Date:Message-ID:MIME-Version;
	bh=FoEUjTyegNiS67PR/0ZUdEzFa4c0jrRavIX/Sn4zPwE=;
	b=ZC6yQb+WuZzmZs/5xWMJtnkoR4QYuP2gG5MV47Q8WdHNVY4FNUKWgtpXhs+pc2MWAMvcfnlYK21ZFCpzapbgV2eHR58IVcrjYm8RbuUJMRGPAi/qQmGoBG/joBID/SIuRFyhjiac5Wm43kL5J9xhRLNJlAOgo8mK++Oq+dGxXs0=
X-Alimail-AntiSpam:AC=CONTINUE;BC=0.07720116|-1;CH=green;DM=|CONTINUE|false|;DS=CONTINUE|ham_regular_dialog|0.0236551-0.00195307-0.974392;FP=9815436220790621416|0|0|0|0|-1|-1|-1;HT=maildocker-contentspam033040092104;MF=liuc63@xiaopeng.com;NM=1;PH=DS;RN=9;RT=9;SR=0;TI=SMTPD_---.jqJvIGI_1793071412;
Received: from localhost(mailfrom:liuc63@xiaopeng.com fp:SMTPD_---.jqJvIGI_1793071412 cluster:ay29)
          by smtp.aliyun-inc.com;
          Tue, 27 Oct 2026 11:23:33 +0800
From: Liu Chao <liuc63@xiaopeng.com>
To: andreyknvl@gmail.com
Cc: gregkh@linuxfoundation.org,
	krishnagopi487@gmail.com,
	kees@kernel.org,
	balbi@kernel.org,
	zhugl3@xiaopeng.com,
	linux-usb@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: [PATCH] usb: gadget: raw_gadget: fix dangling ep->desc on enable failure
Date: Tue, 27 Oct 2026 11:23:23 +0800
Message-ID: <20261027032332.1945140-1-liuc63@xiaopeng.com>
X-Mailer: git-send-email 2.50.1
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

raw_ioctl_ep_enable() assigns the user-supplied endpoint descriptor
to ep->ep->desc before calling usb_ep_enable(). If usb_ep_enable()
fails, or if the subsequent usb_ep_alloc_request() fails, the error
path frees desc via out_free but leaves ep->ep->desc pointing at the
freed memory.

The UDC driver may have captured the stale descriptor pointer during
the partial enable sequence and may dereference it in subsequent
operations, resulting in a use-after-free.

Clear ep->ep->desc before jumping to out_free on both failure paths
so the pointer never outlives the descriptor it references.

Fixes: 97df5e5758f7 ("usb: raw-gadget: fix gadget endpoint selection")
Cc: stable@vger.kernel.org
Reviewed-by: Guanglei Zhu <zhugl3@xiaopeng.com>
Signed-off-by: Liu Chao <liuc63@xiaopeng.com>
---
 drivers/usb/gadget/legacy/raw_gadget.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/usb/gadget/legacy/raw_gadget.c b/drivers/usb/gadget/legacy/raw_gadget.c
index 46f343ba4..b52ab3ce7 100644
--- a/drivers/usb/gadget/legacy/raw_gadget.c
+++ b/drivers/usb/gadget/legacy/raw_gadget.c
@@ -886,6 +886,7 @@ static int raw_ioctl_ep_enable(struct raw_dev *dev, unsigned long value)
 		if (ret < 0) {
 			dev_err(&dev->gadget->dev,
 				"fail, usb_ep_enable returned %d\n", ret);
+			ep->ep->desc = NULL;
 			goto out_free;
 		}
 		ep->req = usb_ep_alloc_request(ep->ep, GFP_ATOMIC);
@@ -893,6 +894,7 @@ static int raw_ioctl_ep_enable(struct raw_dev *dev, unsigned long value)
 			dev_err(&dev->gadget->dev,
 				"fail, usb_ep_alloc_request failed\n");
 			usb_ep_disable(ep->ep);
+			ep->ep->desc = NULL;
 			ret = -ENOMEM;
 			goto out_free;
 		}
--
2.50.1

