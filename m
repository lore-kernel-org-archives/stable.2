Received: from mail-pl1-f182.google.com (mail-pl1-f182.google.com [209.85.214.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C33743B71D9
	for <stable@vger.kernel.org>; Mon,  6 Jul 2026 14:53:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783349601; cv=none; b=uOkhTyqpbsP2IpbkdMa2w0Zo5187GYmUUebvApnmaPD9TDmM925peUrfd6OD+5TNSECgrKQr9wxTvgDXmU7w1gkgmDBBsfXyAfWR7xM+8YbkxhHDxme7N3WNSy6CYm5SHq27rIbKhWyAS/1TaS/+2T2sqqGWqYfLEarOaGZ16FQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783349601; c=relaxed/simple;
	bh=I7jiCCDGbaeKX4aqFPomBZzfK4RxHyb7e1Vpt7EJh6o=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=jPVdPigZIYWtU9EM+utb07phG0dGkuVdMgPEYu4B+vM+PsHfVfwzhiv/7vYSDGBL1qUNo/QXDqFkesiz3VW3fuLYy71a1WUqfNm3GQqyr3zCdK2fsxWR2E4u49bVoWIoxE74YRnozJCVIGqNEBC7tJ1Ee20OWJliFXVNoRlzfKY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=aIFkc6Kd; arc=none smtp.client-ip=209.85.214.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="aIFkc6Kd"
Received: by mail-pl1-f182.google.com with SMTP id d9443c01a7336-2caf4496889so16495605ad.1
        for <stable@vger.kernel.org>; Mon, 06 Jul 2026 07:53:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1783349599; x=1783954399; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=xjunpqkgIb0eNkxRiAQe6rJNL+GYWOS6QsHJM94fNqk=;
        b=aIFkc6Kd081dLm0BQuIMvfxcTcvw19msqe1htsCGOtwbRPC3w/ujAbCIJPeg9ZR6/w
         1x+WEeFZYBe8kDft1BorZ4pPQZuqyzzDJL9WR3p6uKWsHEXlPuShNUCJajMowiACsHBI
         YscyhoViSGnq8Xm11pNdIZHkk+wxSWG9B3EIkxfUDmavsAQYVTQ1OfPipkRUUydh+772
         EbKziyfHoSU28GSHYP39yy4nIYMk2sUd51e+W4cA/TEu7ZQy2P8Y/chy/7W6L7k+cFrH
         bgddTnGNzF+OwKGbaDU5VizJNGv2PeJMkV0XtuAOCDwHx3cBQ8TCFmjxu/QIQ0eCyHPW
         6acw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783349599; x=1783954399;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=xjunpqkgIb0eNkxRiAQe6rJNL+GYWOS6QsHJM94fNqk=;
        b=bowHhzexwhQE1xOrrsarhDEDbinV2NnZTnNHSQKyX40W/haa/DX5LrcPCVMLh8oXEG
         JXgOCtFiEADXhLYsNIhBKDqSZhT/8/xPBBm8RqY6oB65bXllrcXe+ZMgnOZPOvrsbpVP
         X6kOWcZwVtqHfWg1do8/p/GD5iMg/OPkR79t/2CSq0WqVRz5/2G/5eWYvO3ktx09TpL2
         VG+3iv2jPvnU0WmGDqojoUisBf1+ZiwsfFNcmBU2GVeeep2ty6UyxgKgR2JR8M1Rr79N
         CiWKIcjEfKvB42YyZT3yJWqZ5BFPaOD1q6vu39NRSN4cGEsolhJ0m62UL2FlMwlsGBjt
         vItg==
X-Forwarded-Encrypted: i=1; AHgh+RrvuCfCr1ZTGEeuhdNAWj6pCAKsPgDirJKbFbpyTleCHF7ZLXsZwVzcWHaQsUq5xu3OzJr54vQ=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx3oFLIxn5Ia3tzAwR5tSlBXqlUs8wFUfR4ScNVF2e7/IrWNNd/
	GTWP/3GNeqKVxDL2tvbJIMJVM1oKLCHd7YahNhWcFnLGNSSINx3/XFg=
X-Gm-Gg: AfdE7cnzDzk+XPsGqydUcWZERznXNUzW9IcfrclwfdygMxfXqMhj1GhMDd2c0RW3oCt
	Fjfqdu4IXdE/4HRkfpizzpAGlkG1lVJlCkw32dbas3PVElYxefEl22r4qzASzATLbZVITxerbvz
	jpjIvm8rLFA+5QfDSwagal8jBqvpFyG/GT5u7AJXiL2ahNkYxqeX0oMwHWRfbwNVHWJ1YWOLArN
	39Sk2YBYK2svR/1Ken2RcXxok+AbY1/pw8lXAnFzdCaHTaMwsnSI4tT79F7r23LkFLYZeYKs7rq
	LVbkybtx2fH0iqz5ZtLFQpFumHzkbaHtn+CtwtIdYHth2B/FYBRiCm/WOghP/H3tWL3nLampZLA
	43zOo2h9I1ANdPQMlSqSs8/C6udxTiUisIlSQs8ECjs+CCTkWZfPpsrfN83h09srVOmi02myI8C
	ck6O3td4F8vZwoXQEknicYcxH+mIn+brLNNaq3KXyNFgu91t2SIackn6sThI9dHM4+Qc+05W2wZ
	3lxw2vArfgF0GJITSHUBWTqN4fxTe3LKDSfJl5ftJkSonFGeA==
X-Received: by 2002:a17:902:e84d:b0:2ca:11ee:b007 with SMTP id d9443c01a7336-2ccbd7d2b45mr9877485ad.18.1783349598915;
        Mon, 06 Jul 2026 07:53:18 -0700 (PDT)
Received: from localhost.localdomain ([14.5.152.27])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2cad7765810sm52217695ad.53.2026.07.06.07.53.16
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Mon, 06 Jul 2026 07:53:18 -0700 (PDT)
From: Myeonghun Pak <mhun512@gmail.com>
To: Heikki Krogerus <heikki.krogerus@linux.intel.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: linux-usb@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org,
	Myeonghun Pak <mhun512@gmail.com>,
	Ijae Kim <ae878000@gmail.com>
Subject: [PATCH v2] usb: typec: tcpci_rt1711h: unregister TCPCI port with devres
Date: Mon,  6 Jul 2026 23:53:12 +0900
Message-Id: <20260706145312.37260-1-mhun512@gmail.com>
X-Mailer: git-send-email 2.39.5 (Apple Git-154)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

rt1711h_probe() registers the TCPCI port before requesting the interrupt
and enabling alert interrupts. If either of those later steps fails, the
probe function returns without unregistering the TCPCI port. The explicit
unregister currently only happens from the remove callback.

Register a devres action immediately after tcpci_register_port() succeeds,
so tcpci_unregister_port() runs on later probe failures and on driver
detach. Drop the remove callback to avoid unregistering the same port
twice.

This issue was identified during our ongoing static-analysis research while
reviewing kernel code.

Fixes: 302c570bf36e ("usb: typec: tcpci_rt1711h: avoid screaming irq causing boot hangs")
Cc: stable@vger.kernel.org
Co-developed-by: Ijae Kim <ae878000@gmail.com>
Signed-off-by: Ijae Kim <ae878000@gmail.com>
Signed-off-by: Myeonghun Pak <mhun512@gmail.com>
---
v2:
- Add Cc: stable@vger.kernel.org.

 drivers/usb/typec/tcpm/tcpci_rt1711h.c | 13 ++++++++-----
 1 file changed, 8 insertions(+), 5 deletions(-)

diff --git a/drivers/usb/typec/tcpm/tcpci_rt1711h.c b/drivers/usb/typec/tcpm/tcpci_rt1711h.c
index a8726da6fc71..20037ef130ca 100644
--- a/drivers/usb/typec/tcpm/tcpci_rt1711h.c
+++ b/drivers/usb/typec/tcpm/tcpci_rt1711h.c
@@ -298,2 +298,4 @@
+static void rt1711h_unregister_tcpci_port(void *tcpci);
+
 static int rt1711h_probe(struct i2c_client *client)
 {
@@ -339,7 +341,11 @@ static int rt1711h_probe(struct i2c_client *client)
 	chip->tcpci = tcpci_register_port(chip->dev, &chip->data);
 	if (IS_ERR_OR_NULL(chip->tcpci))
 		return PTR_ERR(chip->tcpci);
+
+	ret = devm_add_action_or_reset(chip->dev, rt1711h_unregister_tcpci_port, chip->tcpci);
+	if (ret)
+		return ret;
 
 	ret = devm_request_threaded_irq(chip->dev, client->irq, NULL,
 					rt1711h_irq,
 					IRQF_ONESHOT | IRQF_TRIGGER_LOW,
@@ -357,11 +363,9 @@ static int rt1711h_probe(struct i2c_client *client)
 	return 0;
 }
 
-static void rt1711h_remove(struct i2c_client *client)
+static void rt1711h_unregister_tcpci_port(void *tcpci)
 {
-	struct rt1711h_chip *chip = i2c_get_clientdata(client);
-
-	tcpci_unregister_port(chip->tcpci);
+	tcpci_unregister_port(tcpci);
 }
 
 static const struct rt1711h_chip_info rt1711h = {
@@ -394,7 +396,6 @@ static struct i2c_driver rt1711h_i2c_driver = {
 		.of_match_table = rt1711h_of_match,
 	},
 	.probe = rt1711h_probe,
-	.remove = rt1711h_remove,
 	.id_table = rt1711h_id,
 };
 module_i2c_driver(rt1711h_i2c_driver);
-- 
2.47.1
