Received: from mail-qv1-f54.google.com (mail-qv1-f54.google.com [209.85.219.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 20A342E6CA6
	for <stable@vger.kernel.org>; Tue, 15 Sep 2026 02:13:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789438432; cv=none; b=hv7cYm4G6pY//1FnSyLKXrBf4CMVq4lh7/KqOVX99av57z1+2fnYVRMSLerN8cSM/7MiuybIAHqHYp1StD57+8wj/K4GdgskwumZjo7SpXJPld6f+B/4Ui7esVyb4BSiREUqfzZkZIwWy+IB5ozbqcEvIcN7GnOf9/l4bghInB8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789438432; c=relaxed/simple;
	bh=XQuSQ137DUmjJs4vhjNv/rFoQoHzrImIZp2orhXaMrM=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=DLxgXEIc/80aiy7qLnsjWN7yJWkQpVNbjuE+Kv1FkWSNQZB7x8ypnzkbx5Tcz+4Pzj0qtgldpm6BStppGyjFoLphr8l9QsdxeCFn9m3cNLzmGl00h4/TMtS7dCdIC8wdcloWVWebm/fTA8PZ6Ln29/8oWnx7HLuLg6e4h0haXlI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ArpeM/M8; arc=none smtp.client-ip=209.85.219.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ArpeM/M8"
Received: by mail-qv1-f54.google.com with SMTP id 6a1803df08f44-90cd4631090so4997466d6.1
        for <stable@vger.kernel.org>; Mon, 14 Sep 2026 19:13:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1789438428; x=1790043228; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=sW7+JeYuhnmm8ntFAHs80fMLHHnC3GGrA2lFtY4r8iw=;
        b=ArpeM/M85b8EZF6euTPV6Rxx4QF4QCU6Dtggcr3tLBTgOhody2jmtYEoF7hi+fOWXJ
         u1eusydnC/22oU21g9N/EcnkxR5ySZHVyMfuDMpBx66cYJECE4aRO1YNjVVl1osDBNSd
         QEBo1EnO0mY6db/OOnn8wRGgX5je24CKPARNn2jDLp6zcg1GrKcMqdQh/sEQJXTtyzum
         taoFIqWDsy7UI4HdeacGNxZgzJS3P2guvSE/iV4jKUvcEfARurTHd/ShaN3paXvK3eqQ
         8Q3yoXBNWS3I1naaEGVmY5480qCjgG/V660zPB/qQ6RqJbIyd1RdnNweQAny/sjTEV0k
         JRUg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789438428; x=1790043228;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=sW7+JeYuhnmm8ntFAHs80fMLHHnC3GGrA2lFtY4r8iw=;
        b=ATUbDNk9TSD82UPU1mfFNiQsninMUiJvnrM/MUj/VI9l/2hhVjewgvgkO0Fzn2owfP
         enEGl50D0xTdSbXN+eszE3Ep0QQF6QzchwGHIghHTQ2Cl8bsKYXzptuLKNlybjArUb6+
         dZpEjl4FbJjDqds8C2ZWsWNdgDjj5A8BhUejsNyrOL3Hem6Ss8n+odLm0vi6oDGieLI3
         ftE6slA4uA5Xh2JFzpKALYYd1wS+SETptrNWMFlKhqYI7j1lHlNjRib7Tmm6yMCPZcxM
         telg3fM0ICx3FXmskGAXvXwPwI7nc4YNau4kcw7zK6Bal5gH7b0mg38U5JkyTbm4Ti3w
         D9QA==
X-Forwarded-Encrypted: i=1; AKwUvByvYHtynxoA5lAUMCsH0CSQsb/kewqgoWiW/5bC+wBTWtXWMkC6pqvOvzfUsCx7F4tdaVAsrh4=@vger.kernel.org
X-Gm-Message-State: AFuF++nc1LoVUQiFz2uQToFZSGhljCtdQDElKQTKd9Qz+77s57qAUlhA
	/YvPXUYTVZOFiiQC9drEKAhPfNJauOiuZrvG/Dr1FMqIJDq0nQO8p0c=
X-Gm-Gg: AYBFou2rBu6cd5nsrniUZvLt/S+qcTkInmsdOIkFrkdvimeONgxmBuppKDGsa/bAsne
	LMnizr7q1q8+iUet1jUYyfDIKjrs5XCUKNvaiMSXw4BW26ybKgjm6z9yVz9zNcmVT31uLJLrIK/
	KQIj8gGjEU6YjwgjUnTm53lZH2w1RxVA4z4Ju6V/plmkPGv+vpoVu8jUWlqvjpaB6kg07hltV+S
	rT1uoJUVwVLXtaVw/oPlvqZPYsd8VuQCP/uoL+Dw2fvDBG1+GROzzA0jcIW+cKCyZoFEILViwfP
	wUyAYJ2iSSG/T39Scec9BDWjDXwAlUekBZ4SLp7EDkDTidWewcDLtt6yFHQhBfS/8+tBHcolm0G
	tsOzzDUX3j6tQQUhwCEr/BvWECZmYsP+y3PZpPc2MOHxga8RDn+vPlWQTf/MbutMiW75EmVYgZ5
	yBj6a5mzWNFkvTKy/9yBBP/+jtBU0ep/CswZwtNMGHGfi+tVce2bEM+CrqgDHPuAcOOtaAt7SD0
	rYYjDB3EiBgQPAvMuSaygMYXhhnyoLUm0McGEWDrw7UU/bJSJg/ltTNBrXYztJMjyw/fXQBuBDH
	qDaSIhn9gOEg+aMpC1l8DIsW4XKedV0wgevcDdY4Q74jwYHOMRRd6+iEM3WhrE8g
X-Received: by 2002:a05:6214:311c:b0:910:3923:cc6c with SMTP id 6a1803df08f44-912343f288dmr28143126d6.21.1789438428254;
        Mon, 14 Sep 2026 19:13:48 -0700 (PDT)
Received: from 6e-wmo5420-02.ad.psu.edu.net (6e-wmo5420-02.ad.psu.edu. [104.39.213.233])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-9122cf9ba03sm34230136d6.32.2026.09.14.19.13.46
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Mon, 14 Sep 2026 19:13:47 -0700 (PDT)
From: Myeonghun Pak <mhun512@gmail.com>
To: Hans Verkuil <hverkuil@kernel.org>,
	Mauro Carvalho Chehab <mchehab@kernel.org>
Cc: linux-media@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: [PATCH] media: radio-maxiradio: balance PCI device enable on cleanup
Date: Mon, 14 Sep 2026 22:13:39 -0400
Message-ID: <20260915021339.94468-1-mhun512@gmail.com>
X-Mailer: git-send-email 2.47.1
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The tuner initialization failure and remove paths omit the matching
pci_disable_device() after a successful pci_enable_device(). Disable
the device on both paths, after the final hardware access on removal.

This issue was identified during our ongoing static-analysis research
while reviewing kernel code.

Cc: stable@vger.kernel.org
Assisted-by: LLM
Co-developed-by: Ijae Kim <ae878000@gmail.com>
Signed-off-by: Ijae Kim <ae878000@gmail.com>
Signed-off-by: Myeonghun Pak <mhun512@gmail.com>
---
diff --git a/drivers/media/radio/radio-maxiradio.c b/drivers/media/radio/radio-maxiradio.c
--- a/drivers/media/radio/radio-maxiradio.c
+++ b/drivers/media/radio/radio-maxiradio.c
@@ -159,10 +159,12 @@
 	dev->io = pci_resource_start(pdev, 0);
 	if (snd_tea575x_init(&dev->tea, THIS_MODULE)) {
 		printk(KERN_ERR "radio-maxiradio: Unable to detect TEA575x tuner\n");
-		goto err_out_free_region;
+		goto err_disable_device;
 	}
 	return 0;
 
+err_disable_device:
+	pci_disable_device(pdev);
 err_out_free_region:
 	release_region(pci_resource_start(pdev, 0), pci_resource_len(pdev, 0));
 err_hdl:
@@ -180,6 +182,7 @@
 	snd_tea575x_exit(&dev->tea);
 	/* Turn off power */
 	outb(0, dev->io);
+	pci_disable_device(pdev);
 	v4l2_device_unregister(v4l2_dev);
 	release_region(pci_resource_start(pdev, 0), pci_resource_len(pdev, 0));
 	kfree(dev);
