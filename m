Received: from smtp-relay-internal-1.canonical.com (smtp-relay-internal-1.canonical.com [185.125.188.123])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8D7961A0BF3
	for <stable@vger.kernel.org>; Wed, 10 Jun 2026 00:47:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.125.188.123
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781052442; cv=none; b=AymlP0SkTYi6YLGkMsX8iJjIl6qLFDc0fdGzQTHw3HQ6JNi59qh87WFqguQ10yKNdjzcBZ4p4K1A4F9NJYfb2rdPIViOQ8EiAluytSjz/6Up+X+B9vCu4CisR5wGSKP7hvrybEGeRueHtLvShEVD9XWa7WAl/dwH/eKmuLnBPrA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781052442; c=relaxed/simple;
	bh=pWLBNG7am5Ns9ULjZtOZJaEKaBc+vooUVAdjN9uiChE=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=mDToyZGsUNHq3SKC27QToyiLVYh7x0iZJHyf1tze/DAJCRyNWlyFTAtcqiWBRotvbKv6+n7D6qsc7MRTuIOta5H2kBb03t9lTHccHT37ytLPzuqjfTCjly2WszxTfc/nnch+i04boEMwR3yQJw+4Ti/WOU3MiXhfzhDreveEsec=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=canonical.com; spf=pass smtp.mailfrom=canonical.com; dkim=pass (4096-bit key) header.d=canonical.com header.i=@canonical.com header.b=fcu321lP; arc=none smtp.client-ip=185.125.188.123
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=canonical.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=canonical.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (4096-bit key) header.d=canonical.com header.i=@canonical.com header.b="fcu321lP"
Received: from mail-pl1-f200.google.com (mail-pl1-f200.google.com [209.85.214.200])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-relay-internal-1.canonical.com (Postfix) with ESMTPS id 1CD123F4CA
	for <stable@vger.kernel.org>; Wed, 10 Jun 2026 00:47:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
	s=20251003; t=1781052431;
	bh=n/KWPxeRKoug9fzHkoO8Q3MP+ErNXigBpMsHQwhtS50=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version;
	b=fcu321lP2TV41U53GqljUtAwa2GYeTtAQ8cg9UbpF0CeGtAp7uY0b+tl4iVd5/pc8
	 e4I85gS2c3jnFWbNrI0VTUvfbXkT7FUX31UUk9QIv0kRPqRzONxTbKIuw9u+2mkoAb
	 fLgI2XeuBLs00qa04VGw3/QQ9SBoBTxfeEJ/9SEDnvch53Sm2gmgExGL8hs/OMx2t4
	 5c7xxQlwDAtlJfBLopZZuBoR+Dq64ifT/zn+t4YBTkykqD0gCRmMq6rtgfooM6Bk2v
	 oCN+YepG5oVSjEMssDc393Sc7qtKH5Uk+ps1v5jEnWLs50OLWwxcy2ExZqMcjaZYm3
	 /1KtySfv11t8fGCXAW7SsB/N/yPED+GscmCxEJ5oUqJIetYEYExrvg0IUa/coon2J/
	 /yIPdhgBBBlHY2Fc7N86ItU+XZSw2wRgPfdnzgW2oV9BBqtzvDJxT+VwRj0qpqh+yY
	 jr00SAH2FHeuTIo4EGpQMEWp4OugnG1t00uoIfAo5fVZ4ZicVfCYOkWsxXJneColjQ
	 YHVlSzpqm1mRE2kwZ+uU/YYYP79GJp2M4GMC84vKtE0jMHGj5ingJrdeJ526+ibm57
	 IxBMIA/VYevSWscJdxcU6NZUyiob/57f1b9AWhAKtUP+RZYO7w5CyH+R3QWsBX8fT4
	 zzpl3jfMjS52L1BKjHHzLiOw=
Received: by mail-pl1-f200.google.com with SMTP id d9443c01a7336-2bfdd99f6b7so86577635ad.0
        for <stable@vger.kernel.org>; Tue, 09 Jun 2026 17:47:10 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781052429; x=1781657229;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=n/KWPxeRKoug9fzHkoO8Q3MP+ErNXigBpMsHQwhtS50=;
        b=G7phEfSpkHGMSQTDEloAfuZt4EMR1+aCfDFaxEkiCNlJtcIqMr914NmS3yfecBgV3N
         6N/QSW7G9eDxhqZeJvWr875v1uFU4x9/Kh5szCuL4To1yOnRyFIPSX9jRgMG3M3A7AsP
         O3uWz9rfQOYmmOfI4ASWVH+OBe10ycdS9JrxYxCrG0nUBuvNnRc4Ga6gUMAba32Lg6Xn
         PRhRLHiUoA+Q+ZVQ+v6tU3AVo/HZMPV8BsUkfDxlt4W5/5gmC054mZNGNIGRED4Q/mzH
         ei7679gGG8gONyS7T27+hHrB8+LMGSc2j0bS5stRE1Ad+pURd9BP5XXG6H+HKdpSFopp
         eT2A==
X-Forwarded-Encrypted: i=1; AFNElJ8aS1zowmYhXTWSrBUHtbYmZJ7vEYQFwkl5sfUvGWCu+21PxHmUVATRg18zCOMV3AGc+H7UxBU=@vger.kernel.org
X-Gm-Message-State: AOJu0YyfFOQSIcAZ/yODxBN8W2nfb+xQ2nsfxAbkcKO2qOrXV3V0cXMR
	+ok5P4vciJaSaPHFEG+5P/bWDpjnLcjaPKUilGIndzRCfZmQS+6RpUAl4Dywh5bTi6WYe7Qf39V
	cvyago8owEs+yq3QR07lZbW+yl+1zzbp50OUWZsf88p3QcEoObWHmZy0vq4SfjtL8KMzl9EbQ+w
	==
X-Gm-Gg: Acq92OEsC93u0zaT5x7Vt7vh5HkSw8GgX7HhgO5IF51LRtYJJqjVfLuauKwuv8lm3AB
	Sxf71OBYaBJPnVCuGbXlpmoTQgz6lgLp7jqsfV4DZj2pewXweP36iTTzB5YjAEo053lq3kvcfwr
	Fe2Y5DVzIvs5XBtG+qhUgwzzgxXBC5EqPp9g2EJLTZGRDMhWxmStww4/ibFrlvrqJuZLHGBd+h1
	jWFpRdUQYaeKhZ4cdjIHwOZ780P8Oag71Z6eRnGtgG5N38PaVGC7uaMdBO5vKPRqnkFzH0ttljy
	lmSee43B3C0ZCk/vy79fDe9qok/F92Q2F7pRm95PSTcOnr/beCMGscEBrPp0aFWt/+1rnelsQKC
	9utyWXdKAy7aUzAht7+EJxVVOsB/5ZViwTD6CopLx/F7l28e3rnYhYxlJ4KQK2dNv+d7HWur+Mv
	gkcj82bfh+SmE63DlMBOeVBUOEZw==
X-Received: by 2002:a17:902:bd0a:b0:2bf:2e93:c624 with SMTP id d9443c01a7336-2c1e85aad5emr181303295ad.27.1781052429308;
        Tue, 09 Jun 2026 17:47:09 -0700 (PDT)
X-Received: by 2002:a17:902:bd0a:b0:2bf:2e93:c624 with SMTP id d9443c01a7336-2c1e85aad5emr181303155ad.27.1781052428977;
        Tue, 09 Jun 2026 17:47:08 -0700 (PDT)
Received: from localhost (2403-5803-7ed2-0-44ce-9172-4c63-78c1.ip6.aussiebb.net. [2403:5803:7ed2:0:44ce:9172:4c63:78c1])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2c164f6d211sm229874265ad.3.2026.06.09.17.47.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 09 Jun 2026 17:47:08 -0700 (PDT)
From: Stewart Hore <stewart.hore@canonical.com>
To: linux-kernel@vger.kernel.org
Cc: krzysztof.kozlowski@linaro.org,
	myungjoo.ham@samsung.com,
	cw00.choi@samsung.com,
	vijaikumar.kanagarajan@gmail.com,
	stable@vger.kernel.org,
	stewart.hore@canonical.com
Subject: [PATCH 0/1] extcon: ptn5150: Request IRQ after device init
Date: Wed, 10 Jun 2026 10:47:04 +1000
Message-ID: <20260610004705.265619-1-stewart.hore@canonical.com>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The ptn5150 probe requests its threaded INTB IRQ before the extcon
device is allocated/registered and before ptn5150_init_dev_type() has
run. If the INTB line is already asserted (e.g. a cable was attached
before probe, or across a warm reboot), the handler can fire and the
work item can run against a half-initialised device.

This patch moves the IRQ request to after device initialisation and
registration are complete, so the handler only runs once the driver is
ready to service it.

Verified with a reboot-cycle stress test on an i.MX (6.8.0-imx) target.

Stewart Hore (1):
  extcon: ptn5150: Request IRQ after device init

 drivers/extcon/extcon-ptn5150.c | 20 ++++++++++----------
 1 file changed, 10 insertions(+), 10 deletions(-)

--
2.54.0

