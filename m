Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=184.106.54.66
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794837177;
	b=4fJq87TtsHbvt3oNhXW8sVMGWaWcbIGgAwRcgjfQzXdP/KXpgBk+Xlns7l7poL6beSr6
	 cdsjqMQayqAYC5C86ex76bA8FgnUtq7jRpRWpY4EtcKj2oSW40aJ99SnubxlX8ivm0fwe
	 8aOBy9fbMI+OJ+dUKB94Nk8FNW4zV1NGBm/VhMqsAsaNIOfRf72y9/OPpM/fw84Hp+MZd
	 3Rm9GHgSZGutzJdNmcAi/CiA7luhSEkUY5lS9+lrBEa9Md9n8BaorxwaWnWQu4XVhckpN
	 lEu1KoJG3alPTJkmmGcUBh91QGmgv8ELaQ/3yEZYcWEXtPULd9I7BMwHogXkqbSGuqw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794837177;
	h=DMARC-Filter:DKIM-Signature:X-Auth-ID:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:X-Classification-ID;
	bh=VQ3YeRHwI3MrkRmNiZMDbwPTTYvVwwgd1WHuRMFva8Q=;
	b=S5HSLHWTlqrwjxGNSkbYKgi1OHpKWkUeYVDKaojeqy9538NzvR4ax1M6JI5gz1aRpkR/
	 uEZoahnEo8DsgdUL5tl+yCIkuZyqLY61948cvFvA1KmTy0E9mVXRy9DhZYoMcanS//OyH
	 DzmhNrQx41Yg7SihNI+TcVNZiJbmU0eW27I25D+F4nCks86FYmRlkbHEYuyxhZMMq1fNg
	 1sevA6FAV9eyJRAF5uEZoB2Rj8Q4Z29PndQ7cfsXz9SGFkL6ISHjLdzCkXE4c1E0V4jcJ
	 9EC+lFS8fv4vWTnjArmFMi+mqwPlXkkYfm0GA4g2kvQJlSpfxzOK3kqU90KRmbIeWwg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=mev.co.uk;
	spf=pass smtp.mailfrom=mev.co.uk;
	dkim=pass header.d=mev.co.uk header.i=@mev.co.uk header.a=rsa-sha256 header.s=20221208-6x11dpa4 header.b=fAGwqTD4;
	arc=none smtp.remote-ip=184.106.54.66
Received: from smtp66.ord1d.emailsrvr.com (smtp66.ord1d.emailsrvr.com [184.106.54.66])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9EF05606A31C
	for <stable@vger.kernel.org>; Mon, 16 Nov 2026 13:52:56 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 9EF05606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=mev.co.uk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mev.co.uk
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mev.co.uk header.i=@mev.co.uk header.a=rsa-sha256 header.s=20221208-6x11dpa4 header.b=fAGwqTD4
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=mev.co.uk;
	s=20221208-6x11dpa4; t=1794837170;
	bh=RWxgcjm3KzeVMSTEJdoZ4zYT0jBi17kDCX2UYtzBi3w=;
	h=From:To:Subject:Date:From;
	b=fAGwqTD4lzPtLN35BuwLV/Av9T/WUlfmlANSC1AMPMtwJnzkXXg2R1Nc2HF0TZ7rb
	 sNbguBK3YGSPkiqNiZtX2XfWJyjG+tFFDc4NpJSOAovfS9Te/OXO+t/I/WQdwnLIhR
	 vhdB3LUJFbsoEAJUJT/t1sYW2jEbwWTpegbAYhWI=
X-Auth-ID: abbotti@mev.co.uk
Received: by smtp17.relay.ord1d.emailsrvr.com (Authenticated sender: abbotti-AT-mev.co.uk) with ESMTPSA id A432720294;
	Mon, 16 Nov 2026 08:52:49 -0500 (EST)
From: Ian Abbott <abbotti@mev.co.uk>
To: stable@vger.kernel.org
Cc: Yang Zi <2959243019@qq.com>,
	Ian Abbott <abbotti@mev.co.uk>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: [PATCH 6.18.y] comedi: addi_apci_3xxx: fix subdevice count underallocation
Date: Mon, 16 Nov 2026 13:52:29 +0000
Message-ID: <20261116135239.110081-1-abbotti@mev.co.uk>
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
X-Classification-ID: 1104277f-1901-4354-97ad-aef8f731813b-1-1

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

