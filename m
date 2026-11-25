Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.197
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795645739;
	b=B/GrGrk/8w85ooPj6HMNu0hKIZd2bLfUpV/WYKir3/xacZ2EqF2zu6wbxBm8huu2G+42
	 pL1i/egBSalczCidp9g7SxrOhY/pbqZ8F+ucqR0UEBuyEibl8TGF0FND2ntkHF6HuQXPb
	 Fy1NP5tnxEz4+ncsjHWpc2BG4PimAjIoNh37mr2RjzmDnzfyTpRrt1rxoY0y2IuzyOxuN
	 X6qaHEUQSlW5o2VDJFPDLujHCRYLE0WQtsyTspAYk3Ttz+xyiKQqC+UuEv/5s80qF4+jD
	 nwagrqiqBn2rgmUjaLhc+L+fDMv9S6pwhNXPkoIYPLgNSNhPdZZcHHnTXdqHLsckD6w==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795645739;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Received:Date:In-Reply-To:
	 Mime-Version:References:X-Mailer:Message-ID:Subject:From:To:Cc:
	 Content-Type;
	bh=sLJgVW+/Vd4As4viT9lUZGKhVy1YU+uNFIGupA5gILQ=;
	b=EipAZBAXmvY3PJ5fkeArt31Nf9CnAPA0fKvejRwTzV/itWvLyBJ2R+48I/REiCmNX4dg
	 fNOpbcwN0NyE6FGuTWCd3bLuxfX5cKPcX+SpZ3sVGKQ1mcpMmryaGY7kGoueRykQlw6pS
	 4luGb807n7VtdUP28/1uJIWQmR0xG31onHPBZ+BglMyTKxZ9y4t+JKEceKkUvZmRN0+sW
	 G1p82UrMsnI3b2KP3tZU+1NWmtw06f25WP3k6KnB4sEgzcuG1kUIHyUc5MKRoVW7V7YLa
	 7bQdSP2lON+Z77Cu45N7pUP2VO0rwyMBoR/Ne1PZMDQUwD2sHNUHUnamxfBDPg4v6VA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=google.com;
	spf=pass smtp.mailfrom=flex--elkin.bounces.google.com;
	dkim=pass header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=NYowGDdS;
	arc=none smtp.remote-ip=74.125.82.197
Received: from mail-dy1-f197.google.com (mail-dy1-f197.google.com [74.125.82.197])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D1FDA606A68E
	for <stable@vger.kernel.org>; Wed, 25 Nov 2026 22:28:58 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org D1FDA606A68E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--elkin.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=NYowGDdS
Received: by mail-dy1-f197.google.com with SMTP id 5a478bee46e88-384c78aa0dbso8372726eec.0
        for <stable@vger.kernel.org>; Wed, 25 Nov 2026 14:28:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20260707; t=1795645738; x=1796250538; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=sLJgVW+/Vd4As4viT9lUZGKhVy1YU+uNFIGupA5gILQ=;
        b=NYowGDdSdLeXb0RUxZvRQ51HbdN+GM5GWA4aLQem06pYn+ezmdLGgdGAvEqlJ6ZPxW
         OL5yE1CdnxCY9+AP1eDKUYQ+1D112KINZOyMWLliNlH0RTjlFosYEflHFbBTYKCWSBgW
         9sqi6daSKH1rBfDgDEVyN/d4sc8Knv8r22U2ayMPHn1CldCcTWn8UL49D6pjpJj3tzeG
         Nc+S4sMCcnJoac4k78L6ge3ySK3fCOAWl4AAcPoUYF8gx01CAiXyvCRZOHPxkRoBgLwC
         59VmQcfK8+Iz3zJW2+HjpZD3ZaXzc7bEyLlEVwjejQyUpJlELsfN94bzSvvPQAPviclL
         oy2w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795645738; x=1796250538;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=sLJgVW+/Vd4As4viT9lUZGKhVy1YU+uNFIGupA5gILQ=;
        b=HSzR435MokIKhahx4sdYL4NWtfyBq6eiywDy6WxdRdJnNIYmJlRUsYUb/w40LbojxQ
         iYpm088O04r+k2xUkQEZr6ZhW/6fOsw8+5iw9Q1uKhfpe9pUq3JLFh9p3sRWVWbv1LXW
         UjNG3UB+U8eZmPFrAJwWi08UyOMdlUKp7GRU3K/hoUE0LfvjggiTHp39StGXO+UaGhsW
         OK9S3nU43VT/D3zgVib1BJyY2yJcNrrLtAme6sfcPrskPwfE5OxRcF6/IHZcFowRmnyi
         1GVO9Eoj5TZyg9wYOBZVBhs90KWPOBmQBCizm0tgrlX8vitZIh2RvXbNPa0xKQ+vUBTp
         RHvw==
X-Forwarded-Encrypted: i=1; AL+hErHtdFqCB7n6xTTXr5FfSLLRK4Ok+2DP5NAtOn0fzY134fNqXhFGo/iuBfasqMwntkWGzMrJOko=@vger.kernel.org
X-Gm-Message-State: APuU4Z+waT4s+/rGfRGF1e1MwW7Ram6XXyfBfKL30AaeDdxiy3JW2wNh
	rSSVOQEjbTgALVj+DcLRbtXjV7TnGJhtQxxyie81JQMAC2uLLYt8g6CrOs2Nb8zznd0W/R+iKqL
	pFg==
X-Received: from dycnm14.prod.google.com ([2002:a05:7300:d18e:b0:386:2134:b328])
 (user=elkin job=prod-delivery.src-stubby-dispatcher) by 2002:a05:7300:1c1b:b0:386:9d31:2d18
 with SMTP id 5a478bee46e88-3869d313208mr14179933eec.0.1795645737640; Wed, 25
 Nov 2026 14:28:57 -0800 (PST)
Date: Wed, 25 Nov 2026 22:28:28 +0000
In-Reply-To: <20261125222828.1452483-1-elkin@google.com>
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
Mime-Version: 1.0
References: <20261125222828.1452483-1-elkin@google.com>
X-Mailer: git-send-email 2.56.1.839.g22a8290db9-goog
Message-ID: <20261125222828.1452483-3-elkin@google.com>
Subject: [PATCH 2/2] usb: misc: usbio: validate endpoint maxpacket sizes in usbio_probe()
From: Elkin Cruz <elkin@google.com>
To: Hans de Goede <hansg@kernel.org>, Sakari Ailus <sakari.ailus@linux.intel.com>, 
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Antti Laakso <antti.laakso@linux.intel.com>, linux-usb@vger.kernel.org, 
	linux-kernel@vger.kernel.org, llvm@lists.linux.dev, irogers@google.com, 
	Elkin Cruz <elkin@google.com>, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

usbio_probe() allocates ctrlbuf, txbuf, and rxbuf directly from the
USB descriptor maxpacket sizes without verifying that each buffer can
hold its packet header. A malformed USB descriptor with a smaller
maxpacket size causes unsigned underflow in length checks and buffer
overflows in usbio_ctrl_msg() and usbio_bulk_msg().

Reject devices whose control or bulk endpoint maxpacket sizes are
smaller than sizeof(struct usbio_ctrl_packet) or
sizeof(struct usbio_bulk_packet), respectively.

Fixes: 121a0f839dbb ("usb: misc: Add Intel USBIO bridge driver")
Cc: stable@vger.kernel.org
Signed-off-by: Elkin Cruz <elkin@google.com>
---
 drivers/usb/misc/usbio.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/drivers/usb/misc/usbio.c b/drivers/usb/misc/usbio.c
index 6142a32c18a9..c9f22b600333 100644
--- a/drivers/usb/misc/usbio.c
+++ b/drivers/usb/misc/usbio.c
@@ -591,6 +591,8 @@ static int usbio_probe(struct usb_interface *intf, const struct usb_device_id *i
 
 	usbio->ctrl_pipe = usb_endpoint_num(&udev->ep0.desc);
 	usbio->ctrlbuf_len = usb_maxpacket(udev, usbio->ctrl_pipe);
+	if (usbio->ctrlbuf_len < sizeof(struct usbio_ctrl_packet))
+		return -ENODEV;
 	usbio->ctrlbuf = devm_kzalloc(dev, usbio->ctrlbuf_len, GFP_KERNEL);
 	if (!usbio->ctrlbuf)
 		return -ENOMEM;
@@ -609,6 +611,8 @@ static int usbio_probe(struct usb_interface *intf, const struct usb_device_id *i
 		usbio->txbuf_len = 63;
 	else
 		usbio->txbuf_len = usb_endpoint_maxp(ep_out);
+	if (usbio->txbuf_len < sizeof(struct usbio_bulk_packet))
+		return -ENODEV;
 
 	usbio->txbuf = devm_kzalloc(dev, usbio->txbuf_len, GFP_KERNEL);
 	if (!usbio->txbuf)
@@ -620,6 +624,8 @@ static int usbio_probe(struct usb_interface *intf, const struct usb_device_id *i
 		usbio->rxbuf_len = 63;
 	else
 		usbio->rxbuf_len = usb_endpoint_maxp(ep_in);
+	if (usbio->rxbuf_len < sizeof(struct usbio_bulk_packet))
+		return -ENODEV;
 
 	usbio->rxbuf = devm_kzalloc(dev, usbio->rxbuf_len, GFP_KERNEL);
 	if (!usbio->rxbuf)
-- 
2.56.1.839.g22a8290db9-goog

