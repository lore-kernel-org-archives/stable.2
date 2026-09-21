Received: from mail-pz2-f41.google.com (mail-pz2-f41.google.com [74.125.228.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 30B2448820E
	for <stable@vger.kernel.org>; Mon, 21 Sep 2026 15:42:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.228.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790005353; cv=none; b=Qaes8mmog8Vr/m+8MA5v8JOaZJhkaMZE7B1WkdqbDrhtXeC+96vT/QeD5Iu7FqusWncgZkWC90mtscrVArQeQTSOFESRqiPzg1eA7YtRMGG7gbH8GBG7rsdYLEUl3Ic3fChqN5TaLjN951yXehptfEY3TLCDRwEAxnK4yVrguDE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790005353; c=relaxed/simple;
	bh=9kH4Z0v4eee+DKg2Rpv77UIr+n2moHtnlgKwmj9MEoY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=pwA1zUntGQ+ipdyCfbMkew7XviyGqxhEL602vR67VZ8Z4gMpxPqRvlyYGYXCRkXch4cdgNb/S2XHLnwJETEeiSiV+DfNqE78jOZUmBa3t/jgN2VZwrRnS2BA01VGHt+feaida9a2dq1r/5WEHtyu6vlyzMKCXye90t4DHmYrooc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ad7Rah05; arc=none smtp.client-ip=74.125.228.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ad7Rah05"
Received: by mail-pz2-f41.google.com with SMTP id d2e1a72fcca58-86b90133ae8so2271228b3a.1
        for <stable@vger.kernel.org>; Mon, 21 Sep 2026 08:42:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790005350; x=1790610150; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=B54+vCOLkFDdOpiW0k+Uldsd6dkbrkEHEWRd5WaDkpQ=;
        b=ad7Rah05PSvOwE/76pZJMjzTlqCO2T/G9Tj6rT51mH8Ds8VYe0LseSg15hZ1M7TY+e
         G/IfSz3zdDCcLhv7G83l7Qp7aO1mJ064QX0wG7etlFd9DnsdYY91NNHW3ex6U6Z+vx9y
         koKo3vu/kPjrv8dn/wvrcTWpBV+bjQaSx2AKoFVuLeb0tjQtDuSxnF0AgZcdgZCOhfHm
         gMDzNWyIvd0eGj4AbYiJVzFj71alHFBES61XJr0QkVqNMuVUGblEHRdj9fSHy9g1mTAn
         odOP0gFKnPa8DUBpX3MJTYnnfJ8mTVLWup775ftKoH/HBkKRGuerxNobtjm3cELXl5b8
         YYpA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790005350; x=1790610150;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=B54+vCOLkFDdOpiW0k+Uldsd6dkbrkEHEWRd5WaDkpQ=;
        b=s6yxCN3bfGbq1OFkFwMHePc5d0KhddfuiHh8SVQH7GXrq8JgQDGM8NQdLV1aGOL/oh
         MQLYl6ViwCjOSVeqB5N2ZOCh5fJxyvquoYyxMo/nZn86EQak56p0DD953vxY7hi1Gnop
         pueyPr+A6t3V3nTPJ6nhGzA5pTQkNW76zH1K+Shdh5c3iarPXzERxyKOxh0hkajH6f4j
         5tWME+SgaH1yNGWzHRbZU4zD8ibchdnWA9t/d3bRhbWPqbWo5Cl0DxPP2RZui/g4odep
         PTIqwtPUNbbUn0b+TYX8Vicofpz8o09uCpj2jQUpfknDuEhlh8NdimEaKk+c51OUHnyA
         OeEg==
X-Gm-Message-State: AFuF++ndzi8HcfuHFNOVYQZa6u6FfY0qci159YRq5TOCFPBp/u8GsM7m
	GCAmT7d6S/0FBNfQtBo0KBylnWDWsdByK+hzUhls14AQ2LmbNfJ6C97C
X-Gm-Gg: AYBFou3MXE1MTqNvBHMEa/uecIRTDmqqgaDUFw/POheNewcnSvWtqHj4L2xU4qJHPh4
	ymH7pRCZ+UHdGD+e7FMrRGHGGZUit4Q/vKsZPTpSFSBh+z4ZykLSY+kZyeVzbQW0SXFobSx/vHp
	pNZs9agEH9L7sW1nBwtW8VDHGYC+xFZ/rOsD9kBfjFfNGe7oI3HkyNX8VoWTmRDp8i8rxwMBpzy
	mQhBgvSSknSYI0nPhFv8kM1Bs7qgiW6HeBJPj3UW3NQY9md0HdYM4OvmTxSzfg1i4niNOBQUtby
	bL6HsuUIPQyn9+aC7f1uPRJfpmtHzBVan8b9T7Y94yLHk2XO59o0N7nXS6PorBvoJB26uT6fuwV
	edYQ5omMEvviejYcV8AShD4EIG8F2gUWrdPdVwYH+8yirYmV6bXBPUVUFbKv0B4WQ/ZAwcKPMR7
	fhDAaDzsqR3+8GRNNbTM/g9sYjcqyBvKxcpW2/PHmxNU7CArsxcOrZSA==
X-Received: by 2002:a05:6a00:2eaa:b0:871:f803:1f1a with SMTP id d2e1a72fcca58-874db6f71d0mr13984342b3a.6.1790005350498;
        Mon, 21 Sep 2026 08:42:30 -0700 (PDT)
Received: from lgs.. ([2001:250:5800:1002::de93])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-877aa70200esm3449599b3a.61.2026.09.21.08.42.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 21 Sep 2026 08:42:29 -0700 (PDT)
From: Guangshuo Li <lgs201920130244@gmail.com>
To: Arthur Kiyanovski <akiyano@amazon.com>,
	David Arinzon <darinzon@amazon.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Guangshuo Li <lgs201920130244@gmail.com>,
	Ioana Ciornei <ioana.ciornei@nxp.com>,
	Sang-Heon Jeon <ekffu200098@gmail.com>,
	Dawei Feng <dawei.feng@seu.edu.cn>,
	Amit Bernstein <amitbern@amazon.com>,
	Netanel Belgazal <netanel@annapurnalabs.com>,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: stable@vger.kernel.org
Subject: [PATCH v2 2/2] net: ena: fix MMIO read buffer leak on probe failure
Date: Mon, 21 Sep 2026 23:42:02 +0800
Message-ID: <20260921154202.471662-3-lgs201920130244@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260921154202.471662-1-lgs201920130244@gmail.com>
References: <20260921154202.471662-1-lgs201920130244@gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

ena_device_init() initializes the MMIO read mechanism with
ena_com_mmio_reg_read_request_init(), which allocates a coherent DMA
buffer for MMIO read responses.

The normal removal path releases this buffer through
ena_com_mmio_reg_read_request_destroy(). However, if ena_probe() fails
after ena_device_init() succeeds, the error path destroys the admin
resources and eventually frees ena_dev without destroying the MMIO read
request, leaving the coherent DMA buffer allocated.

Call ena_com_mmio_reg_read_request_destroy() in the probe error path
before releasing the remaining device resources.

This issue was found by manual code inspection.

Fixes: 1738cd3ed342 ("net: ena: Add a driver for Amazon Elastic Network Adapters (ENA)")
Cc: stable@vger.kernel.org
Signed-off-by: Guangshuo Li <lgs201920130244@gmail.com>
---
 drivers/net/ethernet/amazon/ena/ena_netdev.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/net/ethernet/amazon/ena/ena_netdev.c b/drivers/net/ethernet/amazon/ena/ena_netdev.c
index 5f0864d16dd3..7eb6456ed0d5 100644
--- a/drivers/net/ethernet/amazon/ena/ena_netdev.c
+++ b/drivers/net/ethernet/amazon/ena/ena_netdev.c
@@ -4123,6 +4123,7 @@ static int ena_probe(struct pci_dev *pdev, const struct pci_device_id *ent)
 	ena_com_delete_host_info(ena_dev);
 	ena_com_admin_destroy(ena_dev);
 	ena_phc_destroy(adapter);
+	ena_com_mmio_reg_read_request_destroy(ena_dev);
 ena_devlink_destroy:
 	ena_devlink_free(devlink);
 err_metrics_destroy:
-- 
2.43.0

