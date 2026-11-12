Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.128.41
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794493907;
	b=i7HXNLmpioHIjWZ4MZq0M2Pac5eH7qI/Tcu3gyf0RiOTt5OENG2qXTAdKiIItVHeXDDW
	 f7pbu9TLUR29aPBLse3B61gmX4ZVeSknKIyyoCBiA0w2St/ml4va2phHlHymiVlZc6Y8+
	 WOeGfd5NvyC1pbZICx3fK7t0lI01e4S2yOHn40q1AwT4ZNSWhg7OI9XDGk3Op9L5Bs5Vo
	 zftJ/73Da35VUcnIQZumoXiqI7A3TOoHPtMgdBBeoBKWdBRkCy3H+GjOiKXcEcSQSJkIt
	 a2eoYHJttITKV2UJgkIeAsEf14f0KIhBkNdaBhaFMDb6nxvjfHm47rm4+V0KlsFQeyw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794493907;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:Date:Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:
	 Message-Id:X-B4-Tracking:X-Change-ID:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key;
	bh=NwZKnHeueZm5SUbYhirFm5Y+XTxCLeRvAgzZxImWLKk=;
	b=NzN8+KFAojma7bq7dSMbu+fq850uQo+XFnH0H7m9ax62QqNFiNW5T2HQWcVAR/cdY9AD
	 ooBO/NsElaQqIRumHMshFXx6petNQvfIfDe0Sofwg/pTTaUEhfl20U431YRwhl+j8FqIh
	 WfwcTI8brasPTOsD/hiOh1jHK123EpLEerBTmovytrXfTfAtJypieZuqcvoP2aIgrapDy
	 PexLKtYy0VN6VmidJ0BQPfA3zPW8BL386l54Fz4eO2NhtT/4pUMOQUxxxeJSJkcFN6qMh
	 9XcWrAP17kol+hOBGMw+hzov/OKKZXBNHhovDFgpmtglAeT80Q2pe3UsNeHgZ083gJQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=flipper.net;
	spf=pass smtp.mailfrom=flipper.net;
	dkim=pass header.d=flipper.net header.i=@flipper.net header.a=rsa-sha256 header.s=google header.b=uD4ajhan;
	arc=none smtp.remote-ip=209.85.128.41
Received: from mail-wm1-f41.google.com (mail-wm1-f41.google.com [209.85.128.41])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CA3D2606A8A3
	for <stable@vger.kernel.org>; Thu, 12 Nov 2026 14:31:46 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org CA3D2606A8A3
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=flipper.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flipper.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=flipper.net header.i=@flipper.net header.a=rsa-sha256 header.s=google header.b=uD4ajhan
Received: by mail-wm1-f41.google.com with SMTP id 5b1f17b1804b1-4a20bde60a0so43076795e9.3
        for <stable@vger.kernel.org>; Thu, 12 Nov 2026 06:31:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=flipper.net; s=google; t=1794493905; x=1795098705; darn=vger.kernel.org;
        h=cc:to:message-id:content-transfer-encoding:content-type
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=NwZKnHeueZm5SUbYhirFm5Y+XTxCLeRvAgzZxImWLKk=;
        b=uD4ajhanlvjpm43NY53eT+GPkSD7TSc6oQHCqCNmFkQgAocpSKCFZtrdyaCilWnzqq
         fxyp1P8+IdBw7pJ8HdVpkZBI14lrD4GuvgdQlc96XPERyWkJ6/0KNynelqB3+gLVuKd1
         FdX7/PtNC1fbLGnrGXFlKr+/F1nYQcRldw3E5t1WYFkxJbuAcc+LPZH+tywQQWnXSbaD
         5vocNjKiq/9zQdQ7bQemqH0t5f+jltrBfgczcUQeU8Z0ZR/IVpKSYRnBjInAGk82lODp
         dhzBtHW7WEFp6WsN6TK7SaKeR4Hdk76uay2KqJ05WtIgv5yrhuXN0bv2t6ZNYy/aPRZg
         2ykA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794493905; x=1795098705;
        h=cc:to:message-id:content-transfer-encoding:content-type
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=NwZKnHeueZm5SUbYhirFm5Y+XTxCLeRvAgzZxImWLKk=;
        b=U0rVB6rCrTkQsUjdpLO5pAUuv+CMkib1XhL0HFarJV3zWnrbLbHZwjmjDoZlos0ANZ
         57IKQ9wveUSu6QQysegQNnzE3NAjjoJ/7UfcAuJxRDx3lJQKrQZngWfYUzwRJJ3ZyFef
         PdZOMEK1D+uunDnQPjagBK21WMPELJrZ6vgv++NrKs2q4lamGFfLrhrhMjRsf6Pss6e7
         /hg8c1N1mI+rGGE7udMxkNi5mJGEYfDFj7ZbnXwuoSSLX6nVDptE1c1gAb6Elipgjfrp
         eSAb1POU46IlWyr15e0HOVYsbLJJcrJZp2qu87XNLt0UOTXBLwyI37FxnfyEwATwqKTv
         8IiA==
X-Forwarded-Encrypted: i=1; AL+hErGXg+7AEIrvm4J7RlbWbtzJm+Oyn5V5TJTPtw+GPwmro+uP849cPvP7SiS9N/iZUyKgBFGjOuo=@vger.kernel.org
X-Gm-Message-State: APuU4Z/jSXjfVps5VniHbcf3K2vSZPjPi+I9iFw1PDdfCpbdn5HToKKc
	+K/xDAX0oS6e1i5ZWbKl7ql9qasaqqS5jaqYLZBX+9fz5VvnjjzSPC0bUoFgJjjfPzw=
X-Gm-Gg: AYBFou2QeFdg2LCFlDUAo2bs4eTnr+DbxxBOHbWaL9swqQv4DU5Z1LARdCel0eGkiii
	Oxa3hUpyzaT6QUdVkCEIk1wnld4LXwFI79ogcGPT9QXehWmw2n15JVCqBri8G/LoHeI9wKtiliS
	/D1jxC1uIDohvwGauWrr78Rb1hD2ZJUHdFOqhN2IPp6sHv8u2xnNRNGO9wBa6oI+dZoFo857jXQ
	v8ipxiXf11LTMQ07JIjULXww+Dx2TNDkqhk5b0orhIs5q3Hr18CSMs2jgu8AkqtzJRz6oCl3Pyo
	nAOM5KPMbYGwiPEkVsrBTZsSXmejKGXfavOjAkQSgATKsTG8iiLRyPfhHqe4XovorYd2MnU4oeq
	rbdkZ/fntVZA7aaLCuQKRNqF1E4t+ZWoQG4DNAkq2j8Rz2z2EmV3iq8amUv8GK7vkXEny2acdc1
	1WxZLBXP7RhkBDsQguJVUZibNNqb6Z0G9zX2P3vNh6sncs+bb36VAAaIQGPd8Vg62au7BkCsC2L
	oHc4J6nzfBbRiEdtfkJVNbqxGNhznkqzbyqIiyzQo5Aq/XzrbT92RlGh7698F0gkYMmN/zHrzOt
	h+AG7IbOHQzp3KMYZoPqImKY1E9v1tKC+SNaKRmuWXYVvczGvpdnCJgkpuXk5j2OFV5oKW6FwAc
	cABetlZEPuQ==
X-Received: by 2002:a05:600c:4444:b0:4b3:6900:280c with SMTP id 5b1f17b1804b1-4ba09377988mr107048235e9.19.1794493905182;
        Thu, 12 Nov 2026 06:31:45 -0800 (PST)
Received: from alchark-surface.localdomain (bba-86-98-194-229.alshamil.net.ae. [86.98.194.229])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4bb51f3cbf9sm40456285e9.0.2026.11.12.06.31.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 12 Nov 2026 06:31:44 -0800 (PST)
From: Alexey Charkov <alchark@flipper.net>
Date: Thu, 12 Nov 2026 18:31:35 +0400
Subject: [PATCH] usb: gadget: udc: Clear a pending connection when starting
 the UDC
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
Message-Id: <20261112-udc-connect-v1-1-03c73259642b@flipper.net>
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/yXMQQqAIBCF4avErBMcg6CuEi1qHGtaWGhFIN09q
 +UH7/0JIgfhCG2RIPApUVafgWUBNA9+YiU2G4w2NSIadVhStHrPtKsaWTtEck01Qn5sgZ1cX63
 rf8djXPL0TcB9P18ShtBvAAAA
X-Change-ID: 20261112-udc-connect-61e0f11cf93b
To: Neill Kapron <nkapron@google.com>, 
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
 Xu Yang <xu.yang_2@nxp.com>, Alan Stern <stern@rowland.harvard.edu>
Cc: linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Sebastian Reichel <sebastian.reichel@collabora.com>, stable@vger.kernel.org, 
 Alexey Charkov <alchark@flipper.net>
X-Mailer: b4 0.16.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=2148; i=alchark@flipper.net;
 h=from:subject:message-id; bh=MHd6orKLm11EEOPLXLXTgh0g8Oy55XzQF+QD+f5lqwg=;
 b=owGbwMvMwCW2adGNfoHIK0sZT6slMWR9PXu2+nn9MUOBV39f/nL6cocr7MPfj7M/cTutqn+qk
 t5nvsjlecdEFgYxLgZLMUWWud+W2E414pu1y8PjK8wcViaQIdIiDQxAwMLAl5uYV2qkY6Rnqm2o
 Z2ikY6xjxMDFKQBTzS/NyLBEc09T1AtLf8cSPSvW/F3SD+VuVPCXnz84e/vGCGZe7U5Ghqf1zfH
 5/P+kV4l96J9f+6g932F1ZmsB64YbyxlFlzxVYAEA
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

---
base-commit: aaa2f954c21b205a0bcd0961e5b2be4e82e58455
change-id: 20261112-udc-connect-61e0f11cf93b

Best regards,
--  
Alexey Charkov <alchark@flipper.net>

