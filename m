Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=185.171.202.116
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795176002;
	b=qfUYz5tod4LmPG0xGh8qp4DKGSY4hzaHyfoR7OmvNXzpTdaE8DSIgy2k+s3goz/eL0DQ
	 I4PXxnK3TcVPzWaFdqBMQJOlkz9qTsdXZbiSdXioUB9axhWXy2BHOJW8PJi0nmSMYkuUV
	 yT82ezpQO0XiVkTHLaow72c36OEQLtRTehruxGDcN4QpYFGYxqsUWBWMyeE/R8Bqe/iCI
	 ZDxH5UiMzMJoCqe7/E8zhkazisUSsdvYdMH3+n7xaBfSxtsxg6A4SR+G1thTFn7MVoHTf
	 sfA6sRnvBg1IgnFpPZAWPhUz7bAHNHS+szjMhOLA9iMwh94HHBhKLgMkvsPoJOX6r7w==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795176002;
	h=DMARC-Filter:Received:Received:Received:DKIM-Signature:From:To:Cc:
	 Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding:X-Last-TLS-Session-Version;
	bh=gHHEiX1JvnvdZ5Xl9lNlgM1lRX6Vc6a7xN9v8eFMhOE=;
	b=HdEbgz4uzaltXZrrhLCkjZi5kTwtbIc0ZJ0tjQPqjLayRLCxvWwqbuQB8O9Ysj2o4ZRI
	 YwkxIMnO6JKmRe/7EcYlGL7Kn5RarOVcizp3PZcxBHMBTCEhhfG8xdXvRAkh/PgsxzjAh
	 ACdCmHYVUZxRbyBJOVdjAih9qBwMHH48t8kUa4vPEWEMeceppxo6+H7vzFbVJoJlPZSMJ
	 NX+1I6V+3XsX7qEnQLVhw2jipIcP0k9jFrU9V2bt3gz2Ib+K+MaMOIApwDgMRhYOQAffD
	 2YT6A2+NuD0BHdnc5Agn0nlmW+F76lBapWhv/zicPJmSoEup45VC3VS2AHyrihoX65Q==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=bootlin.com;
	spf=pass smtp.mailfrom=bootlin.com;
	dkim=pass header.d=bootlin.com header.i=@bootlin.com header.a=rsa-sha256 header.s=dkim header.b="X/nTZxjh";
	arc=none smtp.remote-ip=185.171.202.116
Received: from smtpout-04.galae.net (smtpout-04.galae.net [185.171.202.116])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7493B606A33F
	for <stable@vger.kernel.org>; Fri, 20 Nov 2026 12:00:02 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 7493B606A33F
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.a=rsa-sha256 header.s=dkim header.b=X/nTZxjh
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-04.galae.net (Postfix) with ESMTPS id CA54FC6221A;
	Fri, 20 Nov 2026 12:00:06 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id 267716017D;
	Fri, 20 Nov 2026 12:00:01 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id B5D1C11BC0079;
	Fri, 20 Nov 2026 12:59:58 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1795176000; h=from:subject:date:message-id:to:cc:mime-version:
	 content-transfer-encoding:in-reply-to:references;
	bh=gHHEiX1JvnvdZ5Xl9lNlgM1lRX6Vc6a7xN9v8eFMhOE=;
	b=X/nTZxjh0lvm6tqhdHLtxq9+623cazNT/gcNlJi4LzcHIKCF9FzcxSfSMP/8ahaTEukri3
	KymKsZlsvVl5RK2tpzDPQ12642YYm7yr0uCLBKScczFwoi9lPHlu28XBFoCy5Z5ppBJVwW
	eeFW/6p7hZhvo5hHAYySynoHLFObWptvSZ/hx0h1BmYoadQqJk/D0FvqSZbcuOUkNniJC6
	fQcD4Dhmak4ewrZ7CKzJxyhbhaDqHGPGRlIPJXx2pVnVLrtvr2TLTowjDpEBlrmxXoVB46
	ombyxwYr6mncuR73ZB3NbqTLWDfOnatXtav6/IgukPHErW61wphlJt7L9Hxqiw==
From: Paul Cercueil <paul.cercueil@bootlin.com>
To: Mark Brown <broonie@kernel.org>
Cc: linux-spi@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
	Bharat Bhushan <bbhushan2@marvell.com>,
	Sunil Kovvuri Goutham <sgoutham@marvell.com>,
	Tanmay Jagdale <tanmay@marvell.com>,
	Jisheng Zhang <jszhang@kernel.org>,
	George Cherian <gcherian@marvell.com>,
	Witold Sadowski <wsadowski@marvell.com>,
	stable@vger.kernel.org,
	Paul Cercueil <paul.cercueil@bootlin.com>
Subject: [PATCH v5 3/7] spi: cadence-xspi: Inform SPI core about size transferred
Date: Fri, 20 Nov 2026 12:59:21 +0100
Message-ID: <20261120115925.173568-4-paul.cercueil@bootlin.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20261120115925.173568-1-paul.cercueil@bootlin.com>
References: <20261120115925.173568-1-paul.cercueil@bootlin.com>
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Last-TLS-Session-Version: TLSv1.3

From: Tanmay Jagdale <tanmay@marvell.com>

The SPI core expects the 'actual_length' field of the spi_message to be
updated with the number of bytes transferred.

Fixes: 931e389ded0f ("spi: cadence: Add Marvell xfer operation support")
Cc: stable@vger.kernel.org
Signed-off-by: Tanmay Jagdale <tanmay@marvell.com>
Co-developed-by: Paul Cercueil <paul.cercueil@bootlin.com>
Signed-off-by: Paul Cercueil <paul.cercueil@bootlin.com>

---

v2-v5: No change
---
 drivers/spi/spi-cadence-xspi.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/spi/spi-cadence-xspi.c b/drivers/spi/spi-cadence-xspi.c
index 48a6db290408..29a54ffa1664 100644
--- a/drivers/spi/spi-cadence-xspi.c
+++ b/drivers/spi/spi-cadence-xspi.c
@@ -1338,6 +1338,7 @@ static int cdns_xspi_transfer_one_message_b0(struct spi_controller *controller,
 			}
 			cs_change = t->cs_change;
 			t->len -= current_transfer_len;
+			m->actual_length += current_transfer_len;
 		}
 		spi_transfer_delay_exec(t);
 	}
-- 
2.47.3

