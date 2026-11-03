Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.167.179
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793744785;
	b=nrBLZrgjnpv1c8m1Tsxo8ZGjQgZpHW43irLQNuyhmkttKDkM85Dssus8cDFMR/emwx4u
	 vXozOrqfNc8D+r9OdsRS+97isvBp3QycIPzDimxWnX/+9cCqQ0lZ/a96yERaU3tPHn6WX
	 T7628nfi2Jwndmr7ar8mNLmuELol0BBsaPOZ28mykZWKFhnkRDkrCCuIcwrLrfS3YN/6R
	 qEjKit7kEpW08kQdYaEuSQUHyfLr/iMX+Ssz+UEoonf00ObSKIjSTzWmR/we8OKb+eCQG
	 y5ZwPbkyBAaq7Jhg0dXq1zTPSXNZJPti4FdxNjr9+zgtSl/vKvzvWslS1hmYjoQtT+g==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793744785;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:Date:Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:
	 Message-Id:References:In-Reply-To:To:Cc:X-Mailer;
	bh=6B8/kguaSg2buIHgi80qhLVJe9NS42NHDxy6rcmAb7Q=;
	b=KqjIpgR9+F1xV4Q8OUxvO2RboUh8vD5uiT0QziUzh/FuLjnUlFO6xnDzXj9Ja4QhzGu/
	 xn6DVWb2+KWK+ZTRPT3S3UJEC1ezkgcISv0FC/RJVkNyFUaMSwb9Dm7PQ3cW8niYj1U2b
	 dxji3xmwkUZaO9TXVyJNX3TcnImrgaPXywht5LqTu0B5MCHpAJmmRz8CeMfYgSpaQJkSA
	 Ld5ZzafP/TL33AJ2dxoFTHO8yAc5qG6e0CDvK0ZfH//WP3Ia3TrVhyP6V9DT5NS4kJjPf
	 ZROp/T3KOKUe3PxSPA5XRu2WFU1pGwtQUabqeYoxwRfjZbyjpNgFUGnFOPuEvXjx+Zw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=dKKvJtHq;
	arc=none smtp.remote-ip=209.85.167.179
Received: from mail-oi1-f179.google.com (mail-oi1-f179.google.com [209.85.167.179])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E4346606EE8E
	for <stable@vger.kernel.org>; Tue,  3 Nov 2026 22:26:24 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org E4346606EE8E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=dKKvJtHq
Received: by mail-oi1-f179.google.com with SMTP id 5614622812f47-539a57a0b1fso35945b6e.2
        for <stable@vger.kernel.org>; Tue, 03 Nov 2026 14:26:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793744784; x=1794349584; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=6B8/kguaSg2buIHgi80qhLVJe9NS42NHDxy6rcmAb7Q=;
        b=dKKvJtHqdm+dQxArWG5tGxKUXakQohe4whh+UM5E2qaRZ1J7QSOeRNuNLDWDinX5Mx
         lQQZ7H8qQ4R82unXTabFMRowb/yFBo0l2/EmGQqhYmRvPI/+EWwwF1Aj7pkymA8foqX0
         KVODrDZ/s5scJCvp+Q5XBT/oAMbGAz5freabTv85aaA/PCxkoG0VwMuip7KhxDJYT4oo
         Al4baaX65eKEWob2gjxWTk+jiwgPaf5wMaldkqcxAJAASNvnJSBK8dDwxlGSzyKG/kp7
         c6JoJGR+S5phFX07DUxJTrVmvztBj9YllLtye7LHgx2E1CsyI+i0DGjlLrb4gKT7SQxy
         Qq3Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793744784; x=1794349584;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=6B8/kguaSg2buIHgi80qhLVJe9NS42NHDxy6rcmAb7Q=;
        b=xHml8LUKE7jVNmAc/tQLhvRQvVCtN+dHGIXg9sPR8FoHr0N+cvW0+rBRWnJqWoETuj
         8mGuZ3t6Wl3ZF6RTZDmS6Qm6TnEk+kHITiQno/cmnoGULlXI3t9Nt/UwHFCUhIBVkMeg
         C1QBwYcDy9CBqAJ/5ti5nZjx8/WyWHVyrDQne2kpbQlD4FT01bpNKz8xz14Xab/19Af+
         gml8/Z/1AM+WyZx7bIXibWzm5eE6UmqHMoR7Nz3VTQut1mJJxYbtTnxZQVZNDkhS4eKa
         oJ3YdnWoShVtwgr5C5ZwbnPRq3cFPa5n7ZMTutCOlE9QtotTsf6NBuTNQ1aFns2+bb78
         C4mA==
X-Forwarded-Encrypted: i=1; AKwUvBzGmjRcQZg9BPLuX0id/ilUT2qeoTCoa9fPrbh2m5jfE4I5If11i88NmYBrY0IHS3SJautmJbk=@vger.kernel.org
X-Gm-Message-State: APuU4Z8GmRMK/l2FkQhYiKxkEIOlV0MRW0y6GMJ6Ascuf5hDbaKQ4XbS
	kmt0mLat1eMBwQBcWcz263fdeaWUoRKAGDJmOHx6Ar8jJN5vA4q1qIxc
X-Gm-Gg: AYBFou0NP4hlqRsn33MXO6FlAL1Es4UAjUQu+/R0xKEsDDb/jySlH1lEaNio2EoOQ7Y
	e2rhsPSL3QBJZGgmOUjA9iMFPvEVZUBNQoT57KRwR8HtaP53ROAWKNh1xXasBqvDG14pAFNmmXb
	MkIGWp+3bfj5q7vM72lnv5w7hF887k1wgYc3J/rKKtXyeYHSpP3VGQJrQtvs3PjSnmQ+giZA9j0
	nMm/ew6oEA8yClb5t+Qu6bJiPaqv/6PC3xiqpE+LwH4cEwZEE7MCqpHstJnyXg6bg36dEqBp2KW
	uRzTUK1Wbf+F6DbOf7P2sS8QRjFKTVlH8Acw0TXTBPnLOPW6xreUv9LKUG7Lf9km+LwUu8ODrpH
	MMbqBD9eKRH0BMHt91SYDCkeh2gvk3tL2FUgGBTuiMuo3/6eM/hPle3woh4o0AdJxOotBS6zZrf
	qIKt5Pmr4JPcsH3YRKWN3I+OqmKL37ybGv9UpU4Ok1EpbC/iKHTCvD4OHWb/diMxE1OvRaeDTUW
	IHZEpTexxG3FOEaXtDA1dTafN3oecZfGH69zzxU2cZlS9OhlE7epLJmG+/k+HOdoae7KjEq0ZUN
	xfpZ1257QB/181kLjuNU3vCrwGO177qQpc9/uRvCoiPTpcHz+z272XbdAUgwClBDrLMyMMBYgrb
	0tDVBAWoTXG9YSHKDN+ox7C42PNHx+xBGv9RkNMU365LElO9gC60ZpDhny8xWdFGNsJX9LfX85P
	bbrpag+mWr7irz+cop+ljOvqqlx6vv2NReiseX9ui7Xc6RNc1aQnM=
X-Received: by 2002:a05:6808:f12:b0:4f7:d324:bc5e with SMTP id 5614622812f47-5640de72cdfmr9730628b6e.58.1793744783949;
        Tue, 03 Nov 2026 14:26:23 -0800 (PST)
Received: from [127.0.1.1] (174-29-1-49.hlrn.qwest.net. [174.29.1.49])
        by smtp.gmail.com with ESMTPSA id 5614622812f47-567a9ef58b1sm128435b6e.3.2026.11.03.14.26.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 03 Nov 2026 14:26:23 -0800 (PST)
From: James Hilliard <james.hilliard1@gmail.com>
Date: Tue, 03 Nov 2026 15:26:09 -0700
Subject: [PATCH v6 07/10] dmaengine: dw: report residue for queued
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
Message-Id: <20261103-submit-dw-dma-synchronize-v1-v6-7-2ee0c348224d@gmail.com>
References: <20261103-submit-dw-dma-synchronize-v1-v6-0-2ee0c348224d@gmail.com>
In-Reply-To: <20261103-submit-dw-dma-synchronize-v1-v6-0-2ee0c348224d@gmail.com>
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
 drivers/dma/dw/core.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/dma/dw/core.c b/drivers/dma/dw/core.c
index 3cc8579f8829..c602ea01cb83 100644
--- a/drivers/dma/dw/core.c
+++ b/drivers/dma/dw/core.c
@@ -927,6 +927,10 @@ static struct dw_desc *dwc_find_desc(struct dw_dma_chan *dwc, dma_cookie_t c)
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

