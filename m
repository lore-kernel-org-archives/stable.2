Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.167.170
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793648067;
	b=up3cH0xaAhqfqP0yGv//9jjUnbjRyiwlTbT/V5OIv8X3X57/1+5slagmHUkBHya/aqi4
	 0xfNl4JZ0UPtvGJN94Bt5IWZUI6UAAX56lrZrR38hV1TpK5q1ACMBe/TSC77rgDea9itQ
	 2m8hsd630GzYuXUO7LZdn+s6g0RdAHB1wKxDwc+6i3Oh294Bw90zasmBiSKULA9AJCCSB
	 RUPJn4w4EYtkmoW+FMoJGFrFQ9+63dJm0kaqzthF2/yCO0GN7W4Iw4g9Y4tuAILgTSUSD
	 anwz6tlLewOJTvWOF3+NHd1DkghGQmRSSTwmWWn1Cf9pyR5nGGdIDbcthmyV8pIodCA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793648067;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:Date:Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:
	 Message-Id:References:In-Reply-To:To:Cc:X-Mailer;
	bh=1CHohurHwGW0s3Zm6Rv+GbWfGWzISEwRaF9a5zGiOwM=;
	b=yHCd2dCwHJsYTU0BkvPe1bWGp+NZzGIZh6jpnECR/j6pDxyT+Oebs0Wyqxo7DnUsz5L8
	 c/dnHdeenoFsXqyZPIZ64xGFjf7lUsEaXL7siV/8BdWAcxYvM8lJrb0UDqVXXFyJ8frVk
	 XpiAPQXdJl+suNU/1YngRxgQnH4wfwQaF50UY7E4ZTe54bMU9hJ0yhag1ctH0S5KHGG4J
	 Pk1DJ4CL70/5YX1Y8L3Vo0tqiG8JyoTGpWWqXk/k+qAP74C/S7tl0/l82mzNtj0mVkNRz
	 h65t11m/zv78aMWelF+Q2GVknB9Rcc/liKSbJzcXQDgKSrMvCkj9fO2ZuOhEoJtwwdA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=sdjD3gzW;
	arc=none smtp.remote-ip=209.85.167.170
Received: from mail-oi1-f170.google.com (mail-oi1-f170.google.com [209.85.167.170])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4F7C4606EEAC
	for <stable@vger.kernel.org>; Mon,  2 Nov 2026 19:34:27 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 4F7C4606EEAC
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=sdjD3gzW
Received: by mail-oi1-f170.google.com with SMTP id 5614622812f47-4b28d7c729fso2035035b6e.0
        for <stable@vger.kernel.org>; Mon, 02 Nov 2026 11:34:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793648066; x=1794252866; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=1CHohurHwGW0s3Zm6Rv+GbWfGWzISEwRaF9a5zGiOwM=;
        b=sdjD3gzW91d/Yiofsx/4ymGX7zchBWu44Xh0qiZRbHLso9tI5+BU16O/HChBvG5dxW
         1MRsdtju6i3dw8lmSCvReHAu6mKtST8cclRlFhLPufQjCKlif68GPo7d49XAw5OXImcn
         CxzTbliT13pYgN0rqr9Ak7znACLFtYlV1aia4ar0Lb2s08bjShTlL+PltykxUXIn7jJ0
         TIn/D90TDYLKWKYn3RDwaMW05UER2+YNFVPmjOIPif398NrCc0lZn4EWGZRpeoKygfqR
         jnn5degMOYZAvL0JqUvJqGuPRaO4EY9CnKxVpszoxisio+WoHIj0Pu/nht+yGxICYP2R
         eXkA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793648066; x=1794252866;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=1CHohurHwGW0s3Zm6Rv+GbWfGWzISEwRaF9a5zGiOwM=;
        b=IlXz9X4MXqPdiiO8OZ/BbkRQ+YfLRQyiiWlYKNvn6x0+ut5999DIsrpX7asjucLz/3
         dzzlWud8DArOB3uHJw21r5qJnt5QERl2JOiq2UqKqjUAkYdDdkuh2gOeaIWaFx4Vjw/p
         3xo66hpAeGZwWEzJGhPr8XqYPzjIHt95KPK7uxc0j9W80374+pzlc6/1Le2caCVAG7nF
         qIgkwFGl1eXoIFv7DTU14YYbyx91clGx/peRB5aYHbsnG4oTnw9+/1vIV0j76PArPQRC
         dpv6oNtgWTideNVi/V9VcLklNkKir7lLjtYzYawensqeJJpCTcYyTKOO9n3ypoW0dS0P
         XQ8w==
X-Forwarded-Encrypted: i=1; AKwUvBzVgCtZePJrJZ5oySSQk3ICvDHKTWyDkBN4tc1y9VIXaO4M9EpAoFU+BfhgAqXgGp4stDwH9zc=@vger.kernel.org
X-Gm-Message-State: AFq9FYKjtEaeXXoDaKTPoKGGiIQ4cKdA03xkKWWg7P9Lcj+U9e0ZgEwn
	dRoi50wXrF97cp0vS160aNi5L8V6lmLEEiFedVVzPI1FrbDyqluRftLE
X-Gm-Gg: AYBFou2gEb1tSy1hnnDsx8fqMz7MU5eaNKtImRm3mSTo38SsQeMSPa+zetPjbyf3OTQ
	r4sJgxkwqeAc0ilIJk0oPFnIyJH7qDtsbXEakbsEzePqU3l6/Mx2whIqg1oGLzChFXSjpG6AfJb
	PWVV1MIbe8dwJdzTSsAA+QkvLxauXwXNey35rYOaEA1RoGVU9q+51Wucf9lIV2NN9MZNotNB2nO
	BSxvgJm4+rYQdfQuSGdrlCbH3ia3SUsrjdLHBzI5pQFMi0R11E8rvAfDn6r4QKPRSND5Xgq/Eu+
	ghv5wwooJtakynY3MNx0EkpYczivx3KXFVUWu2di0iab54D/ERB5gvXEnVkSrtkNBJTWy6vCxE/
	fJnli827IuGapz0wabcNMAXswk0Nsg4auXoPRClBUZ+8lfwGIEGQGruleXTSVf6xa1OTvKolWPl
	pVGlirC27YGtgo2BQ2u9mCLkDfmSyDmtJFXT1auXAoyqHcQI63XieEp33t6UiMTCISHmRbjtyho
	zWO8qodVKb1AV3/MLGpAIHP90ZskoDldr+rtMMXIPbfbREGk6/v+IpdOop2n3ZQScbQv7T6TUTW
	tan4TUc5ACv/Eo3jQf3Q85vYWS5/gfaTC0L10M/cbOhxYDyjZf7P0fW6ejNJqEWs8E1X8fXPaju
	O5SBg6RKQ19UNeAr0WcBVl8/VWWVPm/WRpJNtWS0BqPM044/tpBqFO7wEgiIg3Z8iQoS7q0/FkE
	CQNCemJP+vG2Fo2xMrGvMBYzXIaKn49RZHTL9lykA7oTrQo0r89X34FLuxdogHAOXSAExtwQAc
X-Received: by 2002:a05:6808:2382:b0:4cb:abff:3db9 with SMTP id 5614622812f47-5640d916930mr7379458b6e.9.1793648066236;
        Mon, 02 Nov 2026 11:34:26 -0800 (PST)
Received: from [127.0.1.1] (174-29-1-49.hlrn.qwest.net. [174.29.1.49])
        by smtp.gmail.com with ESMTPSA id 5614622812f47-5640fd93451sm8558249b6e.3.2026.11.02.11.34.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 02 Nov 2026 11:34:25 -0800 (PST)
From: James Hilliard <james.hilliard1@gmail.com>
Date: Mon, 02 Nov 2026 12:34:19 -0700
Subject: [PATCH v5 07/10] dmaengine: dw: report residue for queued
 transfers
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261102-submit-dw-dma-synchronize-v1-v5-7-d3207758fbf9@gmail.com>
References: <20261102-submit-dw-dma-synchronize-v1-v5-0-d3207758fbf9@gmail.com>
In-Reply-To: <20261102-submit-dw-dma-synchronize-v1-v5-0-d3207758fbf9@gmail.com>
To: Viresh Kumar <vireshk@kernel.org>, 
 Andy Shevchenko <andriy.shevchenko@linux.intel.com>, 
 Vinod Koul <vkoul@kernel.org>, Frank Li <Frank.Li@kernel.org>, 
 Dan Williams <djbw@kernel.org>
Cc: Serge Semin <fancer.lancer@gmail.com>, 
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
 Jiri Slaby <jirislaby@kernel.org>, 
 =?utf-8?q?Ilpo_J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>, 
 dmaengine@vger.kernel.org, linux-serial@vger.kernel.org, 
 linux-kernel@vger.kernel.org, Sashiko <sashiko-bot@kernel.org>, 
 Lars-Peter Clausen <lars@metafoo.de>, 
 James Hilliard <james.hilliard1@gmail.com>, stable@vger.kernel.org
X-Mailer: b4 0.15.2

A submitted transfer may still be queued behind the active transaction.
dwc_find_desc() only searches the active list, so a status query reports
zero residue for the queued cookie even though none of its data has been
transferred.

Search the queue as well. The status getter already reports total_len for
a descriptor that is not the active transaction, giving queued transfers
their full remaining length.

Fixes: 3bfb1d20b547 ("dmaengine: Driver for the Synopsys DesignWare DMA controller")
Cc: stable@vger.kernel.org
Signed-off-by: James Hilliard <james.hilliard1@gmail.com>

---

Changelog RFC:
- Instead of just dropping the dwc_scan_descriptors() method invocation
  calculate the residue in the Tx-status getter.
---
 drivers/dma/dw/core.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/dma/dw/core.c b/drivers/dma/dw/core.c
index e198c9f45f0b..0fd49ff9257f 100644
--- a/drivers/dma/dw/core.c
+++ b/drivers/dma/dw/core.c
@@ -901,6 +901,10 @@ static struct dw_desc *dwc_find_desc(struct dw_dma_chan *dwc, dma_cookie_t c)
 		if (desc->txd.cookie == c)
 			return desc;
 
+	list_for_each_entry(desc, &dwc->queue, desc_node)
+		if (desc->txd.cookie == c)
+			return desc;
+
 	return NULL;
 }
 

-- 
2.53.0

