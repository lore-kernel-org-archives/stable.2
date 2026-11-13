Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.128.53
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794562111;
	b=cuK6b8401gT7xQ/JdryH6sGha00Ln2SoFXr/GqCdXxUkGJkfw6qcMeS3+eBuHktPh0iH
	 tGjmYZFS+ylvJ9TBxbg9KiSrsnU3AY1ZaewM/bL9p/F3HfljNve9xONmso+oE6ZtAmBXp
	 1vXWDvXOGNfVOyaV0E7CGAPXZqLThW8jLh+gxbWwa/FvOyCPLw7LFvOOzqlKAVNxFGkGZ
	 R/n5mImINP0not/dpd1y/XEKIMOouicXJsCpwazUimV+AdrpDeqChNxswMtAT7j22fI77
	 VACRaKzbEXPXfY4KvujYLh2r6nbfWbp7o5cZFMP6v0oDCWs1mYoqLUuAqw/v1J9W9Gg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794562111;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:Date:Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:
	 Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key;
	bh=CIlAjjzP5ZXkuJIu4Whn5N+9lP8TULOuvWMoUXH2eBk=;
	b=fFaFpo6u886yGJfz9NQwzHronij2k69loFC6gpgwP6uJufHtT3uKj4fm4mwKA3zvYCnt
	 TKlbfOzL6e1TeMGcZSvtkBY8W//zmU2WCyIk73Sbd7U55PmQX1wPUGvC/LXbwjMe1A79z
	 kX4fRSOTeSyfXH1TYnLfkVm5jBW0hA4f8R+y8WOJEhXYHoYh+Xpf18W2a4JChuv1ANYDe
	 Z9VVOydztW9o6H7NFlGZPJ0JZPOgf+yFrhFSScm17BXs7y+Yi9BptlnlAB8vJXanVHNgJ
	 YipTLNiBuLLISAtUdFxpcz//WKz5redpT+QTBYW944P7IHK2zAQRlqVNDL826ASfJ8A==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=flipper.net;
	spf=pass smtp.mailfrom=flipper.net;
	dkim=pass header.d=flipper.net header.i=@flipper.net header.a=rsa-sha256 header.s=google header.b=tMyJJZ7d;
	arc=none smtp.remote-ip=209.85.128.53
Received: from mail-wm1-f53.google.com (mail-wm1-f53.google.com [209.85.128.53])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 82BF5606A885
	for <stable@vger.kernel.org>; Fri, 13 Nov 2026 09:28:31 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 82BF5606A885
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=flipper.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flipper.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=flipper.net header.i=@flipper.net header.a=rsa-sha256 header.s=google header.b=tMyJJZ7d
Received: by mail-wm1-f53.google.com with SMTP id 5b1f17b1804b1-4b79502c27aso4867705e9.1
        for <stable@vger.kernel.org>; Fri, 13 Nov 2026 01:28:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=flipper.net; s=google; t=1794562110; x=1795166910; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=CIlAjjzP5ZXkuJIu4Whn5N+9lP8TULOuvWMoUXH2eBk=;
        b=tMyJJZ7dm0Zrfs81fs07a8kOa0DEdvi9J3wePjDtL0TbRD1onKbr487LUAiBe8MrT/
         lqXfCfc7Sn+gszaAsV4SKMFIuuXPY3Xxvl5/z1TvQZG1AbNjczFNICpoG3RebBqAWf4X
         ksWWlPhuFS3F/OMFz9F3fDBoVMB+jd1dp8JfmanVIGzsrK8C2OpHEbBORZsp9G+kDbD7
         UQHtzMRKEsvG3SB76rE69Aoc+6x+3dSMZN21/bKA4eozJkSZ65R7xm05vTHQtHl2WnbP
         PlMBUT2SB9LENhOHmkO8Z2tWdEO/A1ffYLg6GUutRg7VQeCIVDp/3Jkki7r1dVyWhlG5
         Wgww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794562110; x=1795166910;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=CIlAjjzP5ZXkuJIu4Whn5N+9lP8TULOuvWMoUXH2eBk=;
        b=KdEnCuUAv3iD8jsXkLcgaPSNQzfDr1ePn2gHyVfuDlWIGqs8upSrwqZA4J0iN0ivhX
         nfRuizqVFh95RRpd4z3pTisr76l7NpmQZXjFVozJvsHGkUj3U16c757dHM/cciixgFXO
         zN7MxEJKzQTJEkAkXiTxXm/YgzIm2buQ7fVZQFdlUk5TkPUmmnJN/4BDVonYoMNhLlZn
         G3zCKSLlwkX4OunOMGVmNd86ot8gRxh9ApZk71OaGuQ2EyVIGhYfwjp2TiVjjpfUbTSB
         g+/v7dJIno4WxmXx56GclyBxaa0knUVOISNDVVS7f+weZq4Vr76CEmlMMLogn6AdNWVG
         ZdYQ==
X-Forwarded-Encrypted: i=1; AL+hErFYrY+iaSqwA/bjbtMrFukgJt0KfoWzXVip6+2hE7ZNc+qzpOrMXMMo5qhwO3AE5annU8ZZp7c=@vger.kernel.org
X-Gm-Message-State: APuU4Z9h1tCFvTx0g+XV86ogcA74FWjN/M3FvlVdeSDzHqOoCDnJo9u2
	5MStMLDdBFP/Ka7ggetj4v17M36qN/mJb7KMGWjdHKK3eu6xIiirkhB4Az3FG/JhwWrq3am/bQb
	5VYseDryu+Q==
X-Gm-Gg: AYBFou0z0ELquzXSNsDHdU86twrGRqCLEwrmfvbgGkyN+z6rbB2aCxGLYNlrKGFLbnC
	+UaDtMLeoAuFMItHJ4coDRsjX7N3eX38eeSOwQqsak1XYsrtrQK9AKOkQLWQyLBYbLB78iIQQ7I
	kxMZWJxwqP0UWiQHjzRERMMHvYrWMNWY0CTbjEVMU2RrBeM09DU83C8JCe3TtwoRl0H+c4gWi3P
	N7JViWH04XLWGEV1pqnpWkM8pGk1UO8bsnVHB5yDJ4jiJNn1/JqhFrhd3+/MY8WrTEYxFNBPPCv
	K4uHS/OMD7zA6ieu2utxGv7LaL4a71E8Q/AvOzvezovoTAWMdvfvXyT3PI2L0ZVa07lNAPzkvDN
	cDkqSCWpKr0kkC/bpaUal48kngKSIcAyWvlZ1MsVF6knyaL+Qm4bVBMITUKJBj7FdHfZOxXIJVM
	IYTmybJLTpvJ/czQSVsSO/NhOiTt+bTLJEeATUk1KzqOmat6tjrCWabnQpgWDDii2kJl7C4yKR8
	khKCRmuPohzRuVknNC/TytqfRwjSZQatfYGvyVl9u6D92YqOecigaNUbWIaOQwgrAnn3xCLqEFi
	A0Fs3BwUUdHxGd7Kkm+tSLYtO6oI30gBxKsZWMzwRti+qvgv5d8Ol8DS+wEjMGUvctUj1i574T8
	vNIEhPlNQ
X-Received: by 2002:a05:600c:a45:b0:4ac:86c9:b09c with SMTP id 5b1f17b1804b1-4bb55a69123mr38136345e9.13.1794562109875;
        Fri, 13 Nov 2026 01:28:29 -0800 (PST)
Received: from alchark-surface.localdomain (bba-86-98-194-229.alshamil.net.ae. [86.98.194.229])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4bb4e2538b9sm238668335e9.1.2026.11.13.01.28.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 13 Nov 2026 01:28:29 -0800 (PST)
From: Alexey Charkov <alchark@flipper.net>
Date: Fri, 13 Nov 2026 13:28:16 +0400
Subject: [PATCH v2 1/4] usb: gadget: udc: Clear a pending connection when
 starting the UDC
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261113-udc-connect-v2-1-f51b11f07eb8@flipper.net>
References: <20261113-udc-connect-v2-0-f51b11f07eb8@flipper.net>
In-Reply-To: <20261113-udc-connect-v2-0-f51b11f07eb8@flipper.net>
To: Neill Kapron <nkapron@google.com>, 
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
 Xu Yang <xu.yang_2@nxp.com>, Alan Stern <stern@rowland.harvard.edu>
Cc: linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Sebastian Reichel <sebastian.reichel@collabora.com>, 
 Alexey Charkov <alchark@flipper.net>, stable@vger.kernel.org
X-Mailer: b4 0.16.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1994; i=alchark@flipper.net;
 h=from:subject:message-id; bh=H1NZkbwOLqgox3njeMpCXWj9ST4HT9e/9uVkqeyhY3k=;
 b=owGbwMvMwCW2adGNfoHIK0sZT6slMWR9u2ExvzC8IC6y1H675PsVR3gZWD/3LjZ8Yfng54IsE
 ZaV8+q4OyayMIhxMViKKbLM/bbEdqoR36xdHh5fYeawMoEMkRZpYAACFga+3MS8UiMdIz1TbUM9
 QyMdYx0jBi5OAZjqKa8YGToDL/KUn7jzeK3VnBOrD/n9ajnlGfAoTyqx42np7Lc29+oYGW65LTX
 9fFN/F0OolOvx12cq8h3VBbLPH9nBmfs5XurOL0YA
X-Developer-Key: i=alchark@flipper.net; a=openpgp;
 fpr=9DF6A43D95320E9ABA4848F5B2A2D88F1059D4A5

Since commit 62911bc82b03 ("usb: gadget: udc: skip pullup() if already
connected"), usb_gadget_connect_locked() returns early when
gadget->connected is set. A connection requested while the UDC is
stopped sets that flag too, without enabling the pullup. A later
gadget_bind_driver() or soft_connect "connect" then finds it set and
never enables the pullup, so the host doesn't see the gadget until it is
unbound and bound again.

This happens whenever a UDC driver reports VBUS through
usb_udc_vbus_handler() while no gadget driver is bound, e.g. when a
Type-C port controller switches the controller to the device role at
boot, seconds before userspace binds a configfs gadget.

The pullup is never enabled while the UDC is stopped, so clear
gadget->connected once it starts. The bind connects according to the
VBUS state that the core tracks anyway, and a function that deactivates
the gadget during bind still has the connection recorded for
usb_gadget_activate().

Fixes: 62911bc82b03 ("usb: gadget: udc: skip pullup() if already connected")
Cc: stable@vger.kernel.org
Signed-off-by: Alexey Charkov <alchark@flipper.net>
---
 drivers/usb/gadget/udc/core.c | 10 +++++++++-
 1 file changed, 9 insertions(+), 1 deletion(-)

diff --git a/drivers/usb/gadget/udc/core.c b/drivers/usb/gadget/udc/core.c
index d5844384c368..577bc15f61a1 100644
--- a/drivers/usb/gadget/udc/core.c
+++ b/drivers/usb/gadget/udc/core.c
@@ -1236,8 +1236,16 @@ static inline int usb_gadget_udc_start_locked(struct usb_udc *udc)
 	}
 
 	ret = udc->gadget->ops->udc_start(udc->gadget, udc->driver);
-	if (!ret)
+	if (!ret) {
 		udc->started = true;
+		/*
+		 * The pullup is never enabled while the UDC is stopped, so any
+		 * connection recorded meanwhile was only a request. Forget it,
+		 * so that the next usb_gadget_connect_locked() enables the
+		 * pullup rather than returning early.
+		 */
+		udc->gadget->connected = false;
+	}
 
 	return ret;
 }

-- 
2.56.0

