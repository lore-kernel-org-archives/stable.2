Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.221.48
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795095753;
	b=tYstDuy6jEmjaWKyBvJzX/YxBHfACpZ7GyfiHUsMAJXjbCxNHkVEPHBSgcXbteoiybdn
	 +wbnuwHq8DwPJIrj2rXeXL5FMnesZ6nE1GYzdv8gDfo6/35zj1yYryyK2H+58wNRIjlvH
	 MWFxaYx0kR60RtpY6zoLto2Vw2/A6qUkssL85le44eEdLdvnPK5He/tR3i/BZdfSeBQ0B
	 Mo6LEuB0epEXsRO3sPnXsfTced98DQw169T+Uo3HWPMEosj1rQVuboVkjyNlK64s6isHj
	 CGwnmNw2ptEZYJXT0/XfeVpVoF9mKoozgX8e0GHyHIEeic+fdtOoAn7i43CfIBuD25w==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795095753;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding;
	bh=9qeJQ2WcAvPP7/Q2COJ9+M/C2lXq9FsH5eUhG/hiMvQ=;
	b=kpooxmN5P+F5kKWBqjE5lifNzz9uk/l7tHa+j4E3M74FxYMvw5q1hqZSLZRKJqMXyX78
	 VLGc1N+iQoRzElTcxKf1WkiJGSsSblMO2oALpylGwlemNVOA9jHHNVFIkVFSaTVYI4hTB
	 CgV1fGiX30S12ZVSQEgJfOBdCsJ5g5pa6qdEUxGL31auc+kVoiGoIHpN3IvCOk+nzDaQU
	 l/cqSdizLd8TIPO6dJ/yOKdati/5kMtpGaK1y8Nn17U23MgeVpV320wPvNqZ5yprd6FZ/
	 Sbgkr6evtSeiFfh4uzr2O4ZU+4t76Js289QjN9D4nG50PHI616POGjpJki2FaLamb5A==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=O7MKf09n;
	arc=none smtp.remote-ip=209.85.221.48
Received: from mail-wr1-f48.google.com (mail-wr1-f48.google.com [209.85.221.48])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7F8F260A382F
	for <stable@vger.kernel.org>; Thu, 19 Nov 2026 13:42:33 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 7F8F260A382F
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=O7MKf09n
Received: by mail-wr1-f48.google.com with SMTP id ffacd0b85a97d-490c3ae81d3so1506626f8f.2
        for <stable@vger.kernel.org>; Thu, 19 Nov 2026 05:42:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795095752; x=1795700552; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=9qeJQ2WcAvPP7/Q2COJ9+M/C2lXq9FsH5eUhG/hiMvQ=;
        b=O7MKf09nfKVBP1T4oceqltTqNtUEQMesLfGURBojEzm+GY2PG4pGTRLM358fYPh3Bb
         J7gEm70bgkgR+aAKOziihcRGiyQZ/5m1A4bDhkpWXWGOvot/7vlfc6twpDoA/knjlyBR
         v9LdUIG1NjuUuyejLuiKGarM1yLCqKXx1emsnc/n8iS/V5ZQ0x4Gc/x2wEkYkAaq4Tx4
         oLYuQRNkzG+C472Qn4CWCBXndOU7ucavfo8oISYimlIjbR8g4gaPvgZSjkz1NnP1BnZ1
         ireq8zSTYDWK8sCK18d2c+u3Go2TXNKzJ+ZUPeqB8xM1O2AxxOkIEXf9tbKIB/a7/Lrr
         vI6Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795095752; x=1795700552;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=9qeJQ2WcAvPP7/Q2COJ9+M/C2lXq9FsH5eUhG/hiMvQ=;
        b=oc0kXtTDuqpyVqqAECrT9BpZ8TVLHUdH8QkgDByxuAXZuuTUdiVmvwkp5mUOwuww1b
         3pq2iFPAZteE4beAtr45F+wiJSUYnkIfeZlPBY7MDHqyDGnYS7ULmk6C2RUtOoZ8Ga0o
         OAliRYe2MEXC+MgLGAfe7wwwdghDs7qC1loe9xDBF9Qx3/ow7Q5bD87tBCZkKClNLIsP
         ixw/WHRNTCaf6aLWF1AZhGIzCCNCkBlZJ3mzPDBjwKM9k70GK7JneOVVy0Lcs4XgIA5u
         pt+KKwdNkpUVUaZ4ZnQhAumQrfcvfybXPMxO4FVztR7fPsQCe+1p5EMI/gpl3+0I8aas
         2P6g==
X-Forwarded-Encrypted: i=1; AL+hErFXr2DPUBG8H+dU+QvN+7Lk87p4VlFKsmd3d1Tf6Hny2XdeZgmbFo14ryPmLq72tUFbqgx0hYA=@vger.kernel.org
X-Gm-Message-State: APuU4Z/UFGQs5YyXd/hDwuyx2+EVi1odCsaJ3PI/F/Y6bATBGlPh3NGE
	MzH/R1EutqkUmZ0w0px6G9GSAhz5qqGjtWb/LqdrC4oQExFXpLSMqAEZ
X-Gm-Gg: AZFdTZf3p/l7edm2ABFRpprdR/PsPjwaEBJHMGEmAl3tdwtc1I+jJ2tGPOLFe3bah85
	40eqBeICzteR5yVMkdWZIHkJryZDGixrcBylkHYJFU+pMDLEoHoVtgxb4aQMHFaMt8dXSi2Iz9W
	Zqpf7/hIpAg1yn9qjjBoBGTBLRHxtv2mXuV2PaM9WoFh2YL4DYTovxAhj6ba7g21DtalYT7Y78y
	zQCL73nLUab8xz2oYEUv3BVupIqy7A6B954alaQyBkvQt1rPoy/hLZU51rYNsV2/+RRtuIzeF7T
	RqzK0jXl2sKIYZ3nm3CdAHuE6k8SrWJ73bdhuYVQ96hh9kMPrlDUMPZSZeErK9zTSwf775F5ENw
	Z+1OeJvZinCGxQeGS8u6IOCL4CdkrWJmLw9Z33LLRy2W8MJKr9u+08KEpa3Okt9wke3JEnT7Xht
	6uvo3+p0ZdQ8qejFA7gUbWb8eBhFPXbf/3Yr1TAn+wCisgKdTxF7QZST2Ux+xTofXJgwgEW4dlV
	rhJyea6Lu7uCMcvaURnqdDdK8s+U+0beCUpm7R6vbVFtI4oPcLDZSJstUgH564nRsV1YNRMZciu
	5jE2IJC7A8e0xc/2//CCYF5mcfgKZZ1ZerFJ03BCxLjzqzRVJqpFLz30
X-Received: by 2002:a05:6000:2c0a:b0:4a7:1fca:e52b with SMTP id ffacd0b85a97d-4a71fcae766mr11850285f8f.19.1795095751841;
        Thu, 19 Nov 2026 05:42:31 -0800 (PST)
Received: from deb05.proceq.com ([213.160.61.66])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4a656095e98sm9437971f8f.42.2026.11.19.05.42.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 19 Nov 2026 05:42:31 -0800 (PST)
From: Mehmet Fide <mehmet.fide@gmail.com>
To: Andi Shyti <andi.shyti@kernel.org>,
	Oleksij Rempel <o.rempel@pengutronix.de>
Cc: Pengutronix Kernel Team <kernel@pengutronix.de>,
	Frank Li <Frank.Li@nxp.com>,
	Sascha Hauer <s.hauer@pengutronix.de>,
	Fabio Estevam <festevam@gmail.com>,
	Stefan Eichenberger <eichest@gmail.com>,
	Yao Yuan <yao.yuan@freescale.com>,
	Wolfram Sang <wsa@kernel.org>,
	linux-i2c@vger.kernel.org,
	imx@lists.linux.dev,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org,
	mehmet.fide@screeningeagle.com
Subject: [PATCH v2 3/3] i2c: imx: return -ENXIO at once when a DMA write is not acknowledged
Date: Thu, 19 Nov 2026 14:42:25 +0100
Message-ID: <20261119134225.265242-4-mehmet.fide@gmail.com>
X-Mailer: git-send-email 2.56.0
In-Reply-To: <20261119134225.265242-1-mehmet.fide@gmail.com>
References: <20261119134225.265242-1-mehmet.fide@gmail.com>
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

From: Mehmet Fide <mehmet.fide@screeningeagle.com>

When a byte of a DMA write is not acknowledged the controller raises its
interrupt and no DMA request, so i2c_imx_dma_write() blocks for
DMA_TIMEOUT (1 s) and returns -ETIMEDOUT, where the interrupt driven
write returns -ENXIO.

Let the interrupt handler end the wait when it sees a missing
acknowledge during a DMA write, and return -ENXIO. The last byte the DMA
writes is still on the bus when its completion arrives: look at its
acknowledge once the byte is out, before the final byte is sent.

Fixes: ce1a78840ff7 ("i2c: imx: add DMA support for freescale i2c driver")
Cc: stable@vger.kernel.org
Signed-off-by: Mehmet Fide <mehmet.fide@screeningeagle.com>
---
 drivers/i2c/busses/i2c-imx.c | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/drivers/i2c/busses/i2c-imx.c b/drivers/i2c/busses/i2c-imx.c
index fbfabceb29ac..06b082c677a3 100644
--- a/drivers/i2c/busses/i2c-imx.c
+++ b/drivers/i2c/busses/i2c-imx.c
@@ -480,6 +480,9 @@ static int i2c_imx_dma_wait(struct imx_i2c_struct *i2c_imx)
 	if (!wait_for_completion_timeout(&dma->cmd_complete,
 					 msecs_to_jiffies(DMA_TIMEOUT)))
 		result = -ETIMEDOUT;
+	else if (dma->dma_transfer_dir == DMA_MEM_TO_DEV &&
+		 (i2c_imx->i2csr & I2SR_RXAK))
+		result = -ENXIO;
 
 	if (result)
 		dmaengine_terminate_sync(dma->chan_using);
@@ -1123,6 +1126,9 @@ static irqreturn_t i2c_imx_master_isr(struct imx_i2c_struct *i2c_imx, unsigned i
 	switch (i2c_imx->state) {
 	case IMX_I2C_STATE_DMA:
 		i2c_imx->i2csr = status;
+		if ((status & I2SR_RXAK) &&
+		    i2c_imx->dma->dma_transfer_dir == DMA_MEM_TO_DEV)
+			complete(&i2c_imx->dma->cmd_complete);
 		wake_up(&i2c_imx->queue);
 		break;
 
@@ -1248,6 +1254,9 @@ static int i2c_imx_dma_write(struct imx_i2c_struct *i2c_imx,
 		schedule();
 	}
 
+	if (temp & I2SR_RXAK)
+		return -ENXIO;
+
 	temp = imx_i2c_read_reg(i2c_imx, IMX_I2C_I2CR);
 	temp &= ~I2CR_DMAEN;
 	imx_i2c_write_reg(temp, i2c_imx, IMX_I2C_I2CR);
-- 
2.56.0

