Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.161.52
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794954480;
	b=UROjfA/dojARnbeb4jK3Ok8gFAVTcFlKRqvsF0mw17tPRWkY/Wk6kI6kiGpKtXVrE6j4
	 zUASeY3ETa9kdGDZxy3eiBxIwh93Iu938XlOltPQgFQzFz7O8AhQnEUPAsAxa2ueAQiR1
	 qrrfTIoMJs/sGLvrBGPMafL/0VZwuo8uc0j4WLOo0BKlBwu9H1SclFNwWrSimG/8zzWrF
	 Dm2RBKKAOHOo5WHhIBQljj5zdBxwTF1SfFaELOPGHhZ8ReMnb7N14P2OhQftenwuvmq3C
	 KErBSOzSYbIab/8EhwVoQh+YwYkFuo22Y7U4pXq5t2mtVloKp4LDVp7P2CfXLLaQ6qw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794954480;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:Date:Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:
	 Message-Id:X-B4-Tracking:X-Change-ID:To:Cc:X-Mailer;
	bh=hPezEz8U3+5Ayu7HR/Y/vZwTcxbwYJPMNSvefHQ3nh4=;
	b=eS7guYI66rk2IRemeSEfFNye+9nPOXEJdI7qel75uwdUdnDtKeUWP1OGnmkMBzzndiNs
	 7ioPb79Lxk3d80JRQ//dPoXmT80eF+M/54+lZg4zvzuhgF1UN4b5dIXiQx/WOZTb7NlmP
	 EZrBrQJlbHHCW+xfxh+UNHh1O6yT+1H9Uflx9fKehT7fc26xJ8e+jNovZlRG1uQEcW3Sy
	 XU4JTIbzOTtt1I9V4oz0AkkIvHWilimb9pc57qQlmbCxQ5RbwHEyw9CNskZXxXv3N31pF
	 Qq+S7jDkI+UG5vh0nv8AVDeNBzEFlY+HMuCYhXJiJp97eY6AAm0h6OF62JsN1EuUj1A==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=h+wKUcVy;
	arc=none smtp.remote-ip=209.85.161.52
Received: from mail-oo1-f52.google.com (mail-oo1-f52.google.com [209.85.161.52])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 93267606A335
	for <stable@vger.kernel.org>; Tue, 17 Nov 2026 22:28:00 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 93267606A335
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=h+wKUcVy
Received: by mail-oo1-f52.google.com with SMTP id 006d021491bc7-6d68de53053so260585eaf.0
        for <stable@vger.kernel.org>; Tue, 17 Nov 2026 14:28:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794954479; x=1795559279; darn=vger.kernel.org;
        h=cc:to:message-id:content-transfer-encoding:content-type
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=hPezEz8U3+5Ayu7HR/Y/vZwTcxbwYJPMNSvefHQ3nh4=;
        b=h+wKUcVynJxkQpaq42YCQ9VBO27XP0ynW5u2cpCAqvTPx6NKJWigoKU6JTD1FmBBxq
         LOCLbuIjhUfu5cT7G290fhVXkwcvguJWelAPkd1u8XaUF8K8PpuEFCSEODYS7KS0rfFf
         aBpEivYF2zy/mQVIAtQrediyVJd8JXqZfD1czpj0p1ISszVljX7MgpZ+2OIkynRjy9O9
         1goMVuKRAIoDqvmRJlIQXhh2dI16Lrb100Ph2XHhZ/6uClgEWXaUkee6QjIUO7IPlGod
         oeGJLBvSZOHmuabMLzufffKVK/WgxjWO1RaC6jqPGh+z9prPr/wCj68s7LpCAEaA4yqP
         FKsg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794954479; x=1795559279;
        h=cc:to:message-id:content-transfer-encoding:content-type
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=hPezEz8U3+5Ayu7HR/Y/vZwTcxbwYJPMNSvefHQ3nh4=;
        b=aAYIcSKnqFjmtLNjHba6SYtrMLh462oxl2tt1EMXqdPLA3bsvhRauKagMAD3XJB/uN
         rleUDPJXH2BGZBwA1QbHVlZuUl10A27IP/u1XqtoQIFvrjPJyXPPVwXdKEktT1qcTI22
         MtJd6tCalAwLjdF6tIOfFSMrUMP8if2hGf7tVmcnjYjh1Z/yJJhC1WsGUBOgPqij5PvJ
         uSfIbiUYqKnCGlGj6XfiitlBVjpNipedTyVJW9psmFn1yL2MvT5AN9BDdwBEcyEwbsp8
         LGVWZMi1iQukQzvLD67d3lkVflBOweCs4AbyFMJIKwk1HfplTSSgC5vLOBlWpVgvwBRR
         +ITg==
X-Forwarded-Encrypted: i=1; AL+hErFuSkiclTUEL2ry4JccPoU3YeSQeru/LI6taP5NkEiSzdWsnK7bhtClEwawrxWzxYrC5IQapfI=@vger.kernel.org
X-Gm-Message-State: APuU4Z+Rufy/FJQ7X60AtrB5f9yQ/Jncm/02Pk8dMXTQ3uQpI0+KbZ4n
	rM0hbx+YJ5Fk5ywTI0IjvCWvYoJyZrRroAM/r/8OxEB8ZDu0feRaXd8Mk1YIUbNl
X-Gm-Gg: AYBFou13ek+gOlP8yL4rsresAaMavW/6dOO5TMSyeOp0NfYuKxYeGjfxCMgfplQLOA8
	rQsoFVeE+fQGY3mI66XrDeyRLUNp1vhnMQQT82rDclxi0FlfP8qy08e0OBDQJoUC6Zqreun20yQ
	UbuqsPSG8YqNZK2BF7LtqFY4QnMHa1lKQ/qtxBItgeqwWc2zw6uTrl29s/h3GLcpT7V9BSS1/yH
	o95VyaF4El6lzBNIZm+TWDLmxNeK54d/K/Bxa+dS0KT3gisE0uIRn2+m4UJB2crz7DLhrjmz2R3
	aInEXZRpGpMSwVUVPhKbQHM3M2vTwTZSbH2FJEfNMUyj0ay5lG4X+okYoPXro2tu26xroc0lRFh
	DQvfF7nMQUrdbUB0hMZGoq88rai6DTmYasOWjCLG2UKKDMwvNawrlXSh1IG20e5tvSCXYisCYXB
	A8PU1+zgXzEx16a4YTS0IAXn/NWUFi9craRLqiw9SylgHq4A1cYjL/Jjk9N5oBsZuccYM5lct3s
	ZyyP6goKZgMo2yYd1t27Qf/L4eZfUVH/pfJN+o8ySI82pdBjHJGvOtyG9DcL4CmQut+Xic0NHOB
	s9Mweb79cQ9JcRqn2JTu5be3p57NFQ2KK0bKURxecz5QXxcX2yo/B0csN0XoWQJgPE3bA2f9SuG
	E9ZBZanxsN2KNzcoMi7HVdwroaHystXWBc/yLztZHZSitb3TxCmVukTZd239po9VHDsVRdd23t6
	1P0uIzMjxlouqx0jZqWIX63lgwpendleiFkYJrvUz0XKweF7cUerE=
X-Received: by 2002:a05:6820:1691:b0:71a:f390:ae5c with SMTP id 006d021491bc7-71b186099ecmr646533eaf.70.1794954479501;
        Tue, 17 Nov 2026 14:27:59 -0800 (PST)
Received: from [127.0.1.1] (174-29-1-49.hlrn.qwest.net. [174.29.1.49])
        by smtp.gmail.com with ESMTPSA id 006d021491bc7-71b194a0da8sm481741eaf.6.2026.11.17.14.27.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 17 Nov 2026 14:27:57 -0800 (PST)
From: James Hilliard <james.hilliard1@gmail.com>
Date: Tue, 17 Nov 2026 15:27:53 -0700
Subject: [PATCH] nvmem: layouts: onie-tlv: validate the base MAC address
 length
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
Message-Id: <20261117-submit-nvmem-onie-mac-length-v1-v1-1-e6d359b82862@gmail.com>
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/y2OQQqDMBBFryJZd4wR2opXKS40jnFaE+0kiiDev
 VG7fMznvdmERyb0okw2wbiQp9FFULdE6L52BoHayCLP8odS6gl+biwFcItFC6MjBFtrGNCZ0MO
 ioFZdmxWYN6q4i2iZGDtaz8Krujgq3qjDof0vGL9zTIdrJpraIwRGLJM+hMmXUhoK6QfZ4ZCOb
 OQ0N9JrKwdy8yqvw7GRnsmRPL9LIyfdyHD1q33/AWHNDBnuAAAA
X-Change-ID: 20261117-submit-nvmem-onie-mac-length-v1-a1fd08e2b185
To: Miquel Raynal <miquel.raynal@bootlin.com>, 
 Srinivas Kandagatla <srini@kernel.org>, 
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: linux-kernel@vger.kernel.org, stable@vger.kernel.org, 
 James Hilliard <james.hilliard1@gmail.com>
X-Mailer: b4 0.17-dev

The ONIE base MAC address field is six bytes, but the layout accepts
any length from the TLV. Its read callback calls eth_addr_add(), which
always accesses six bytes, even if the cell is shorter.

Check the declared field length before registering the cell. The read
callback gets the transfer length rounded up to the provider's word
size, which can be larger than a valid six-byte address. Skip a
malformed MAC field and continue registering the other cells.

Fixes: d3c0d12f6474 ("nvmem: layouts: onie-tlv: Add new layout driver")
Cc: stable@vger.kernel.org
Signed-off-by: James Hilliard <james.hilliard1@gmail.com>
---
 drivers/nvmem/layouts/onie-tlv.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/nvmem/layouts/onie-tlv.c b/drivers/nvmem/layouts/onie-tlv.c
index 4da3a704388e..85562fc6b06f 100644
--- a/drivers/nvmem/layouts/onie-tlv.c
+++ b/drivers/nvmem/layouts/onie-tlv.c
@@ -30,9 +30,9 @@ struct onie_tlv {
 	u8 len;
 } __packed;
 
-static const char *onie_tlv_cell_name(u8 type)
+static const char *onie_tlv_cell_name(const struct onie_tlv *tlv)
 {
-	switch (type) {
+	switch (tlv->type) {
 	case 0x21:
 		return "product-name";
 	case 0x22:
@@ -40,7 +40,7 @@ static const char *onie_tlv_cell_name(u8 type)
 	case 0x23:
 		return "serial-number";
 	case 0x24:
-		return "mac-address";
+		return tlv->len == ETH_ALEN ? "mac-address" : NULL;
 	case 0x25:
 		return "manufacture-date";
 	case 0x26:
@@ -117,7 +117,7 @@ static int onie_tlv_add_cells(struct device *dev, struct nvmem_device *nvmem,
 			break;
 		}
 
-		cell.name = onie_tlv_cell_name(tlv.type);
+		cell.name = onie_tlv_cell_name(&tlv);
 		if (!cell.name)
 			goto next;
 

---
base-commit: 6628e7d4c6b25c8d18f1345e3a20d21829aae7e4
base-tree: https://git.kernel.org/pub/scm/linux/kernel/git/srini/nvmem.git for-fixes
change-id: 20261117-submit-nvmem-onie-mac-length-v1-a1fd08e2b185

Best regards,
--  
James Hilliard <james.hilliard1@gmail.com>

