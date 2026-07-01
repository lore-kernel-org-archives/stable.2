Received: from mail-pl1-f173.google.com (mail-pl1-f173.google.com [209.85.214.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 650E0480DEC
	for <stable@vger.kernel.org>; Wed,  1 Jul 2026 12:23:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782908595; cv=none; b=loz4rpYctgp/ULTXzknStLQYo//ugBDmUYtQstY3PEDSrrO3t6Mk4YrrEbMdg7MYMl5qEzzXNhUDpFFZKfn0EBozX40NH0Cp8iibEikbRUnFmdORJIrGWkreucRlk2FbVCReW0Zpjtr7Gzwl129vRneDHkkXafhhbmH/g1bWdO4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782908595; c=relaxed/simple;
	bh=yhC1e0ZzliyRdtlVUueoO1bJdMQisEQkE6746sabsHw=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=pSyBBIych8zSpAIrBM7VMMB5of59FA0gbp7wmfDkHudANvGYcPylonuL0LESNwPDv4bedDSVmqnrNHyof3o9XpDtWHODQOUUIO62xz//u8nU736g2YCuKyASRKaa6xfr8ho5PwyiSeVLEs4gZfGcS0PCF4lDM/pfHBC6kenhXzw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=eaB84vdI; arc=none smtp.client-ip=209.85.214.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="eaB84vdI"
Received: by mail-pl1-f173.google.com with SMTP id d9443c01a7336-2c9b19bbaefso3588035ad.0
        for <stable@vger.kernel.org>; Wed, 01 Jul 2026 05:23:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1782908594; x=1783513394; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=7kp62ieRMyjOkk6mXBcyHmXcTSjtToMp+qoAu3klnJQ=;
        b=eaB84vdIsGgOO3pXysISsZd0EtpY/EOtRg35/iG0grwgplPwSBAkB38H/m7fqHmgXN
         8fcOPB4Q65PWnL+9X3ekoxNF0HfFXMoEktVAbRdkSz0LE0bkZWhb16MBjYKIz0S7g+y7
         5/w1F/6l5aTYz95c8u545ufpjcPrpIGYgGou9/2lRqSZ/FjitktrU5RMO+cedpslX44f
         hCq7gJO7uw7ZdpzKu6inUrFXTDzM8jmstZh99PaLbnhU7w81BjGn7kN5VHf67cf47DRG
         e4ufYglWN9BE7ejfG23v6J6oRiotLJQxl0E2cXHFv7BFw3yaSuWK9kHexMvPj7sd2PDn
         /vdg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782908594; x=1783513394;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=7kp62ieRMyjOkk6mXBcyHmXcTSjtToMp+qoAu3klnJQ=;
        b=L0J2cmiC8V1dqowYISavXFSpS1W5yVj/7HAr7CiICAXdrpKPNZDxGg+/wcVnPJ/O83
         vlK+WFkyL/qxHxFYM065MJxDQ3/O5WmmabHrwA8eCOP1tWqkCdISjiJFad0TdEUZx4fA
         5jRAtGPm1xj2cCpmW8rPMxPt+N01sZ2D8Jmaq1PkFxWQqw6Hke5knSedMaaO7AgD0WtW
         4PzpJ0Mztm3pnCJMyAKdCRSUM1vVKG7baV7wJ/MJr4S2jEJmqgWYaThvrDgnKlCTLFbd
         nKUdxqMC6SOnLpkvS5HV5zr6U7c7O9qxYU5Vf3d5xnj43f5yb+sOoGyKaLv1Y02dvFZV
         5KJg==
X-Forwarded-Encrypted: i=1; AHgh+Rp1nmz8NHvUTOTfRk67sivC6EMi1Jnv7FyHjxFDb+WupyL0YDT6a7F6enlK2hhYfy4/eYqPK9E=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy92t6E3ey0z7wGPoM0s6A0rgb+IfUhDriEI1Eo9ohQyUASUrzj
	vPcSAnuYUiBIEI0VJ01YV/FRgBbj5BFFOtp3/YwBJTbMIECVAovdRmU=
X-Gm-Gg: AfdE7clPFCQaZD9YfiOa2djig/YOx4C0AnmpLtZPyLroFG2pzTeMikmFkgFq8/sFuyN
	ptK7Yi170FLxfYn2EyL0t4Xsh13YlMmIxh6a1zNqDRghe0WKTSgx1P33vN2p8mrb8HxLa/uKi2+
	uDH4pl/dl3dyZyZ3RgurRPtJxvavSxjXISKEllT7PoHtAEInyyx2t/kYKAG5emHviJ/1Vh9f51s
	UwHh6SqxKc8MPQMgPDuLAb54kzOQCmNK/xpAwlHAxXBW5lqoANbU1Sz6oeZYmKuriV97WcdRJW9
	6yLeu11Epp6Rix2INUxVKKCUQfR28LculAtGL60qJDhisARBH1IdWtd8XG9VkBcUeBa11jqVk6M
	9eguKcoZ0CVWcv3QtCtnzF1ohzpWehjb4J2946YIqU2PvwuAy6rpPrdGlAgJupPvNO8mAF0TSMu
	yKYqJDs7jUQBZT3RJXkC7C39RM/02wR8DqVuwDeZy2kQgIAWmRFmK6qTlMwDTOGLPnA1UGWlIXr
	8m5YjDnI7UFnqF7Zfvdj5WoUj1KDxpvoE1xFkCBKtKqdIgZkQ==
X-Received: by 2002:a17:902:ebc4:b0:2ca:35d:1148 with SMTP id d9443c01a7336-2ca7e8dbff8mr15486835ad.29.1782908593440;
        Wed, 01 Jul 2026 05:23:13 -0700 (PDT)
Received: from localhost.localdomain ([14.5.152.27])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2ca3828c8e8sm31219095ad.42.2026.07.01.05.23.10
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Wed, 01 Jul 2026 05:23:12 -0700 (PDT)
From: Myeonghun Pak <mhun512@gmail.com>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Oliver Neukum <oneukum@suse.com>,
	Alex Henrie <alexhenrie24@gmail.com>,
	linux-usb@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org,
	Myeonghun Pak <mhun512@gmail.com>,
	Ijae Kim <ae878000@gmail.com>
Subject: [PATCH] USB: misc: uss720: unregister parport on probe failure
Date: Wed,  1 Jul 2026 21:22:46 +0900
Message-Id: <20260701122246.2451-1-mhun512@gmail.com>
X-Mailer: git-send-email 2.39.5 (Apple Git-154)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

uss720_probe() registers a parport before reading the 1284 register used
to detect unsupported Belkin F5U002 adapters. If get_1284_register()
fails, the error path drops the driver private data and the USB device
reference, but leaves the parport device registered.

Undo the pre-announce registration with parport_del_port(). Clear
priv->pp before unregistering the port, matching the disconnect path and
avoiding leaving a stale pointer in the private data.

This issue was identified during our ongoing static-analysis research while
reviewing kernel code.

Fixes: 3295f1b866bf ("usb: misc: uss720: check for incompatible versions of the Belkin F5U002")
Cc: stable@vger.kernel.org
Co-developed-by: Ijae Kim <ae878000@gmail.com>
Signed-off-by: Ijae Kim <ae878000@gmail.com>
Signed-off-by: Myeonghun Pak <mhun512@gmail.com>
---
 drivers/usb/misc/uss720.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/usb/misc/uss720.c b/drivers/usb/misc/uss720.c
index a8af7615b1..8a5ffb19a5 100644
--- a/drivers/usb/misc/uss720.c
+++ b/drivers/usb/misc/uss720.c
@@ -749,6 +749,10 @@ static int uss720_probe(struct usb_interface *intf,
 	return 0;
 
 probe_abort:
+	if (pp) {
+		priv->pp = NULL;
+		parport_del_port(pp);
+	}
 	kill_all_async_requests_priv(priv);
 	kref_put(&priv->ref_count, destroy_priv);
 	return -ENODEV;
-- 
2.47.1
