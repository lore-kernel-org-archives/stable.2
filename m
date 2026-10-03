Received: from mail-qv1-f42.google.com (mail-qv1-f42.google.com [209.85.219.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E194525F99F
	for <stable@vger.kernel.org>; Sat,  3 Oct 2026 00:24:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790987103; cv=none; b=uVXyVeRrF0nKcVcBTNISJJ+u9FJk5MrqbU+SADAPbAeXER8dvXDKlfroGT/batJM9zJfcm/2yCQOuQ/A5OP1z8yi1xndkCwFVlac/DeOEDM3Vu71pVRu0OAp0OsVmQbC04EqBT2hOUSwvNqkIHZN6oAJLNwKPyVcg063D9Uf6oc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790987103; c=relaxed/simple;
	bh=A/3AUXde72fuZ6eY3PoFCI49hKa2ZKP7PMEccBpbJk4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=s+HsSKzQIEnzXyNQBPC7gRQdkXa2rmBpPYGZb53x/GY8Jm0VqNXWJin8AEqfgIRY33zyBoE9HiD6lHiiQtn30oC4U6TNFy5hD9cmzAVyZYWfrPZlpq/pyW1syoihemsE5AfgvAW4iK7r47OTuX6FPjDo6RTCAF1aLQqx2ZQ7cmY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=IKpowAtE; arc=none smtp.client-ip=209.85.219.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="IKpowAtE"
Received: by mail-qv1-f42.google.com with SMTP id 6a1803df08f44-917a2800e83so3027896d6.2
        for <stable@vger.kernel.org>; Fri, 02 Oct 2026 17:24:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790987097; x=1791591897; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=8hxKqOypKGR+ve63h/kwiqa4y6aqyuQrRDm4kuc2wAI=;
        b=IKpowAtEhkMc7UlX32fZg3kvjFh+HzDUPniQ2AqOUSysBqt/ewvXLPTpnUI4HVtHUD
         sVikVJIKWBkfCqqnDWZRQMKJg/YWKUUnWGDYXobqfixYAEY5c2Fp3Sm4t9QAk+SvYMZg
         8RYEtTGW+em2ozbyFpOuVkUp+dyWUqQ9dqcn7riBQVG44C97HBkWH0ZA2CTuDEvXOoUP
         Fus2MrbzauY8DkNmYcRDHMOPr/RpjMEgK0d3Isrc0rMo02FSj27GrjNNLrza7EnHtjX6
         Ds/oWzXIIyTu7bzq0nsecZKOjb1LWYL2VtJ+Yp8CuLGAS7UyzT2XtfBjWen6XlvdIQFU
         L5UA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790987097; x=1791591897;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=8hxKqOypKGR+ve63h/kwiqa4y6aqyuQrRDm4kuc2wAI=;
        b=jeuS4wzVdhVoZyXNsS8vH7AknGEWFgr4BsN8xO6F1s5nYwWYXmn1ofpHInWM9LXCW7
         Y0gBem5CIfa92sI0m3hD2zPoHLoPK0ueMWSzZmoJawPJBGkw/Qva5HzDEFLK/ZvcOZUt
         2oNOVHr/9pevxWJ/AhafcD4/2H5Y8GMNAgyC5HML4vpwqWoelj0cGRNnlgDWpTABAiJX
         4cC3LnEsY+dNzBWNKreQ5NXpiyJx/VMZMdC5qVudMjl3iQaqJhnN7YUHrVAM1NR3hUq9
         XVbgSZmbr+cwn3crc1TLlCjlSx503ltx7ztLBfMZZy0V3aMbnzxuMkmwzojXPIpDKdg4
         fZ9Q==
X-Forwarded-Encrypted: i=1; AKwUvBxTRQB/NAAUqaN3M8/plXejlQE6p6G9CcrZ/Wi5kPVlGKJkzqWnQKNpnZOOzOUSycPA3hN1ebY=@vger.kernel.org
X-Gm-Message-State: AFuF++mS6ZBlxVKxzXbi7qouYWuYnEOxvbuDx0E51097g9wC+psd1dlw
	WKS6yzlql4Q2vHnnFRxPEDnagSe7NDDZpWdiWwbQqXJG/q8PyKTVs4I=
X-Gm-Gg: AYBFou28LUQj/L/KoKbW4zHSJjPsIhlu/NIgkQ2t9Wu/obEjkZ6SjK7lt2StejGXPbB
	Kr/NG9EoEaN1bJ9uEgqwdHNJ2QEHZWatp5U6rmFbO7E4KU0at9FQSHYyqVo7W4fFBa0HStmBKab
	qHe1A+2oaoKvj9eIgKDYo0OkrmNQzN8b1KosbLx7aUKFaSsims5PJSzDJKeVSg6JypfceqgEEJv
	yhboE1OUk7DWWrBl/cj2yuXNXi2sHoerbi5KVMn07eS1MVPbqHXTrpaGEly8ZHNyN10ML8V2jEK
	FEuqD81A6Blj8nBIZQwN20M/xVt4NIUZj++lPaV2Oq0grXoi3wXQVMKhzgBg5jA5qWMEgzDx1H1
	D3iyGMZAa0xc9xILGTdLrag3+mwWpcDEHVYp8IZavNzIV7pPSwLn4XGy97OJRRjoDyYIdueHyuv
	R9+31RzZ0ln0equcielUooD9DJ8AqrgGFrrKoqt0BpgRzArFuBT1EIoS0pzyt538vlQ5W45v0Hs
	Ly1x9DZWJwgwxPnWU5yJPUMeyDS2QiQ4cIr+tBxB2LKzBrzh3QBcKiUIV0sYxPxxax81oyPH2FF
	UfOsftS55K50Zg0dMqp3Gbr2wkzy
X-Received: by 2002:a05:620a:2814:b0:937:2d64:57ae with SMTP id af79cd13be357-93e50c00470mr224017585a.0.1790987097519;
        Fri, 02 Oct 2026 17:24:57 -0700 (PDT)
Received: from i4-gl-tmk5904-1.ad.psu.edu ([130.203.156.90])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-93cca1a48a5sm341771585a.14.2026.10.02.17.24.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 02 Oct 2026 17:24:56 -0700 (PDT)
From: Myeonghun Pak <mhun512@gmail.com>
To: Maxime Ripard <mripard@kernel.org>,
	Mauro Carvalho Chehab <mchehab@kernel.org>
Cc: linux-media@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org,
	Ijae Kim <ae878000@gmail.com>
Subject: [PATCH 2/2] media: cadence: csi2rx: disable error IRQ while runtime suspended
Date: Fri,  2 Oct 2026 20:24:51 -0400
Message-ID: <6778a4ae61c46294f5014125fbe82618067e2c30.1790986123.git.mhun512@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <0d41c39bc84b97efdb8c06ef451fdaefcb331058.1790986123.git.mhun512@gmail.com>
References: <0d41c39bc84b97efdb8c06ef451fdaefcb331058.1790986123.git.mhun512@gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The error IRQ handler accesses MMIO while runtime suspend can disable
its clocks without draining the handler.

Request the IRQ with IRQF_NO_AUTOEN, enable it after successful runtime
resume, and disable and drain it before runtime suspend gates clocks.

This issue was identified during our ongoing static-analysis research
while reviewing kernel code.

Fixes: c85d3d5362a8 ("media: cadence: csi2rx: Support runtime PM")
Assisted-by: LLM
Cc: stable@vger.kernel.org
Co-developed-by: Ijae Kim <ae878000@gmail.com>
Signed-off-by: Ijae Kim <ae878000@gmail.com>
Signed-off-by: Myeonghun Pak <mhun512@gmail.com>
---
 drivers/media/platform/cadence/cdns-csi2rx.c | 9 ++++++++-
 1 file changed, 8 insertions(+), 1 deletion(-)

diff --git a/drivers/media/platform/cadence/cdns-csi2rx.c b/drivers/media/platform/cadence/cdns-csi2rx.c
index f8c626e19aa84569737aa785a31a0f8c94087613..9bb776b5a4c8248a65df733e3a8963a6393f0996 100644
--- a/drivers/media/platform/cadence/cdns-csi2rx.c
+++ b/drivers/media/platform/cadence/cdns-csi2rx.c
@@ -982,7 +982,7 @@ static int csi2rx_probe(struct platform_device *pdev)
 		dev_dbg(csi2rx->dev, "Optional interrupt not defined, proceeding without it\n");
 	} else {
 		ret = devm_request_irq(csi2rx->dev, csi2rx->error_irq,
-				       csi2rx_irq_handler, 0,
+				       csi2rx_irq_handler, IRQF_NO_AUTOEN,
 				       dev_name(&pdev->dev), csi2rx);
 		if (ret) {
 			dev_err(csi2rx->dev,
@@ -1042,6 +1042,10 @@ static int csi2rx_runtime_suspend(struct device *dev)
 {
 	struct csi2rx_priv *csi2rx = dev_get_drvdata(dev);
 
+	/* Drain the handler before disabling the clocks it needs. */
+	if (csi2rx->error_irq >= 0)
+		disable_irq(csi2rx->error_irq);
+
 	reset_control_assert(csi2rx->sys_rst);
 	clk_disable_unprepare(csi2rx->sys_clk);
 
@@ -1082,6 +1086,9 @@ static int csi2rx_runtime_resume(struct device *dev)
 
 	reset_control_deassert(csi2rx->sys_rst);
 
+	if (csi2rx->error_irq >= 0)
+		enable_irq(csi2rx->error_irq);
+
 	return 0;
 
 err_disable_pixclk:
