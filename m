Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=173.203.187.77
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794837379;
	b=Au9bi2/C/C6wRmgPAzdt2RGd2L2i3Xk5qtU0aPJIy3aRKzg2Bk2AjWXu6OKtidx//3aN
	 YVAyrNa64U4Q4TLaz9wSy/KjuvaGIvNA6PekQ8I6TVe/nP3hddSPI5O/QwMZYKhX9FSiU
	 sflpsifIs8lJLygXtlrsR+rnm6IE2xkkNmpk+b1nIvPzn2qq6OauTLf8sqrRUR/p3B5D7
	 wfZc71vdmU2rZ8PWXWcYZED7JVEYNveXLUWFs/UV7pYNhdBXBF/KdOTAzdHG39ePxhtYq
	 UHYJdb2SFMF2ECmt3U6LxXhzgVip/jnMXCKoyAjxe1invq/4yQ72r4uzeznaOgIaeAQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794837379;
	h=DMARC-Filter:DKIM-Signature:X-Auth-ID:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:X-Classification-ID;
	bh=VQ3YeRHwI3MrkRmNiZMDbwPTTYvVwwgd1WHuRMFva8Q=;
	b=cyXDDyP+dLYkxm3Zx6v6yp7GayaGhZ2pLIz6arzntwcKmUQHXM1GK9AiVfZZKEAXAYWG
	 i3AYNvt1jSjTZqzxBWaHeHkRSdAC3ilI+9/hEcbHroC2Jpuw1J0JE+JvXAeZ+NI4/2rSC
	 EMWGdhcCg3jWyyGx8dTR2fa9GvZ2aE6YOI1dwEMV6Ze2Znrn1VngEGOgPCpYruZq51gKM
	 V7Jwem3nXYuoBg7M7404VYH3sRyVo9qh7qM+46g0olIsXy+bNm4eJnLIP6uD7i65gUMu/
	 11u3G3g9S96qa7OUvkhFtGKfC000hLUI4b/hUjZnzd3StSPta1tgcrQND5CnsMLdLYg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=mev.co.uk;
	spf=pass smtp.mailfrom=mev.co.uk;
	dkim=pass header.d=mev.co.uk header.i=@mev.co.uk header.a=rsa-sha256 header.s=20221208-6x11dpa4 header.b="cXAM+8/y";
	arc=none smtp.remote-ip=173.203.187.77
Received: from smtp77.iad3a.emailsrvr.com (smtp77.iad3a.emailsrvr.com [173.203.187.77])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BC909606A32C
	for <stable@vger.kernel.org>; Mon, 16 Nov 2026 13:56:18 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org BC909606A32C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=mev.co.uk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mev.co.uk
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mev.co.uk header.i=@mev.co.uk header.a=rsa-sha256 header.s=20221208-6x11dpa4 header.b=cXAM+8/y
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=mev.co.uk;
	s=20221208-6x11dpa4; t=1794837372;
	bh=RWxgcjm3KzeVMSTEJdoZ4zYT0jBi17kDCX2UYtzBi3w=;
	h=From:To:Subject:Date:From;
	b=cXAM+8/ySmCrbZhJP/eUfLEPC8XKjcxNeeSImxoRHDJezBacZoN2xwM/GU2aDHzzP
	 J1VizJEdAZjmWMp8u3jvzk7ZuIEb/I5bkapIQUVEHIiaNupj8dF+byXDnrDI48NsrF
	 85rkK3SUGZHPjVFKRdMofa6Xwp/fg592W/JQ+n3g=
X-Auth-ID: abbotti@mev.co.uk
Received: by smtp18.relay.iad3a.emailsrvr.com (Authenticated sender: abbotti-AT-mev.co.uk) with ESMTPSA id 850722515A;
	Mon, 16 Nov 2026 08:56:11 -0500 (EST)
From: Ian Abbott <abbotti@mev.co.uk>
To: stable@vger.kernel.org
Cc: Yang Zi <2959243019@qq.com>,
	Ian Abbott <abbotti@mev.co.uk>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: [PATCH 6.6.y] comedi: addi_apci_3xxx: fix subdevice count underallocation
Date: Mon, 16 Nov 2026 13:55:56 +0000
Message-ID: <20261116135602.110589-1-abbotti@mev.co.uk>
X-Mailer: git-send-email 2.53.0
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Classification-ID: a6f988fa-7a62-4241-adbe-c6ab86ed9899-1-1

From: Yang Zi <2959243019@qq.com>

[ Upstream commit 3de5aa458dede472a253266d02902bd95af8e849 ]

In apci3xxx_auto_attach(), the number of subdevices is computed with

    n_subdevices = (board->ai_n_chan ? 0 : 1) + board->has_ao + ...

The ternary is inverted: when the board has analog input channels
(ai_n_chan != 0), it counts 0 instead of 1, so the AI subdevice that is
actually created is not accounted for. As a result
comedi_alloc_subdevices() allocates one entry too few, and the later
subdevice initialization (notably the TTL Digital I/O subdevice, which
is populated last) writes past the end of the allocated array, causing a
slab out-of-bounds write.

Flip the ternary to count 1 when ai_n_chan is non-zero and 0 otherwise,
matching the subdevice creation order in the function.

Signed-off-by: Yang Zi <2959243019@qq.com>
Reviewed-by: Ian Abbott <abbotti@mev.co.uk>
Link: https://patch.msgid.link/20261014101803.11036-1-abbotti@mev.co.uk
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Fixes: 656e39fedcf0 ("staging: comedi: addi_apci_3xxx: only allocate needed subdevices")
Signed-off-by: Ian Abbott <abbotti@mev.co.uk>
---
 drivers/comedi/drivers/addi_apci_3xxx.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/comedi/drivers/addi_apci_3xxx.c b/drivers/comedi/drivers/addi_apci_3xxx.c
index bc72273e6a29..7355ec454cb4 100644
--- a/drivers/comedi/drivers/addi_apci_3xxx.c
+++ b/drivers/comedi/drivers/addi_apci_3xxx.c
@@ -787,7 +787,7 @@ static int apci3xxx_auto_attach(struct comedi_device *dev,
 			dev->irq = pcidev->irq;
 	}
 
-	n_subdevices = (board->ai_n_chan ? 0 : 1) + board->has_ao +
+	n_subdevices = (board->ai_n_chan ? 1 : 0) + board->has_ao +
 		       board->has_dig_in + board->has_dig_out +
 		       board->has_ttl_io;
 	ret = comedi_alloc_subdevices(dev, n_subdevices);
-- 
2.53.0

