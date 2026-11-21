Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.210.43
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795295114;
	b=UnoGdiboMJqFOxSjRGEwLMWXcEq8x46HE6eymro8Sc59/m7j4XUN+6ClusBfqAiaVpa/
	 ls4CGpBUr9WZ/GleY42Etm8kWBOvu1J13/F2eOidmd9FjWcTrxUlUK9NcKkzC2nFup7aD
	 8YA/QONlhIaF1idYP3xAWk+gY5o8EsaN65PDapQuLRGsaK31xDfNI8AjTS28ylfe9h6Ri
	 h+yaYSELkWlBtLJ+kWYTcxmgg4zLyr0sCHy1nwMbYWcHrwTlUhAEw9MrZ69V0PDhG9eey
	 oAqK8Kuv6YkknLgEpnJfzUZHRQ08xDhaLgdIaJkt7Trebd7ni5Rj/hCFgzeGbCfLN1w==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795295114;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:Date:Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:
	 Message-Id:References:In-Reply-To:To:Cc:X-Mailer;
	bh=NQnbPfOzKZsGZYbWuagccx5bm/OCUTvNG/34f4erQB8=;
	b=BwhYc5ubXeDeMsnuUMK7s6WfqQFd0xsYJzmZqqosOBnQyuxPJtPMkgn/bnCaUZSqzAj1
	 W0SeIQUNvPEYgmLueZgL8e5jSaHbq3YiaNYu+3Ck2e7XbtuDsfwelecnsK7bT75L3MVxe
	 1kXcYGjBw1O7Sc+HKnB07yq6wmLjRw5RmoICmLALVst68I0WBLi79g/l6NAdDUd48Nwd1
	 FK6JN9VT7O7/UJGvg71J0cM0eTFihdmiHBgq4X88Y2C7Gbmog2WVJ1EkuQOxJ+bXltFG6
	 BLgwJudwUVTmKEP9L+O9LYPIHnJIlWcQRRAtRD6I/gST3ZH5uhpADKx/HWSSulWOp4g==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=IX7vznIL;
	arc=none smtp.remote-ip=209.85.210.43
Received: from mail-ot1-f43.google.com (mail-ot1-f43.google.com [209.85.210.43])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7CE35606A6A5
	for <stable@vger.kernel.org>; Sat, 21 Nov 2026 21:05:14 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 7CE35606A6A5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=IX7vznIL
Received: by mail-ot1-f43.google.com with SMTP id 46e09a7af769-843cf077f10so2893492a34.1
        for <stable@vger.kernel.org>; Sat, 21 Nov 2026 13:05:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795295113; x=1795899913; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=NQnbPfOzKZsGZYbWuagccx5bm/OCUTvNG/34f4erQB8=;
        b=IX7vznILkd/CCVxwf4ciGJ2ED21G+VQpoY0/+tApV8+6vFo9BV1d6XlU9m2qYT9GZB
         jQ/J/iUxKWfpcq/LOwOJM+Id5MOyF0c+1zH0hgYpgnOkLPgwQ82Ky6YrCPcU89Rb6z6E
         LmX99YzDz1KCdkIIjjqBK+nq82jrRsCaxvlqKWILWmssSEElKScn6+/5xNRM7BEX4YNi
         wT/hZ7TAEqYIyprnRFra37qMWRfHx90t94makB9jOvKD/0E7tTbZcjcURQJ4hStg5E6q
         mbQqgqY32MST/9pW3kKW4FZHXllcQDZB/ztUBNSsC1vcbrBMkvfvXy12J6Y6GlHYl0c0
         K00Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795295113; x=1795899913;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=NQnbPfOzKZsGZYbWuagccx5bm/OCUTvNG/34f4erQB8=;
        b=sKZPl9Ab1bzQZvIvF4/RcOhrr+V+qXGAGYC72eqpTPKgLFfLUBwn2C+Z1vymbz0/uI
         uwV1uh7yu/y04sgAtPQFSaB1b6XFs0P0SEzcOGVtjHHEbZ4Mdk7VFWDsQiMcYu6QK+6H
         /2P9HeHyKXvhAws6GDCaGIKGGOJwBO3cGCP0JWVQmXdlZyoXcCdJDjIDFa7ojVTtJecq
         JuR35JH9xxhhLYHfFbsgVSF4UHf7i/cjNcnGOS6XPEKdWfgqWw6cv7MDy03/2Pd92Q5T
         cHTZJDDP+m2d2bXZewKVUQsOiA8mk1hNl7SYmbqkX5k0uTZQgG4imbEbgppU+NesyUvC
         dYEg==
X-Forwarded-Encrypted: i=1; AL+hErEkNk2sr/tPPfFpfLuVtqI6Lygmk/NktJ9Ot/Rsb/l2fEt3vmYH5K8cZQg0GJ/5u8gFcYgBMpU=@vger.kernel.org
X-Gm-Message-State: APuU4Z+CZMbyPYgQJiBtwRKqjZyhP2gMklHHCVW1LyWIXexzTEVCg4eH
	C5ROczTKFRi+KVtpkkJwtXEME9VSbjQFHVjTxBfZSxH0ZdSrN4gYHzzW
X-Gm-Gg: AZFdTZekS7mlrIAgSZ4SmxXggQigI5s46id7fEcXBZAuw2EDVNnfOcIZJIxFkV7Sk69
	CbjjQukHUqWncL/SDPd5IoNyu3PFJGLqaJC64neUjBID/ZlZnWUc0O5a4Hr93xUw02LKg/ep0ie
	jV6TH6xsrRZQnVNwVWAQlSN7um+NqMuFLoub5NIsjaLUsZgO1Vp7ChW0B/OElWfm5CvLj/fobPa
	L2OhSFvcA4P09FuMdSfaSI5ZK6Oowq4JbNI9rfxONOhYIUZWpMxRuTdjk7/SwMG+qdGhY+KH0cN
	ARIX9dCtoE3KA3w+eF9Vsu587n1ggKEkgo24/AMNcsdl4XaDTwp1stgJUWl6k/QT/skVvDRZ29r
	v2kSaPe30H+rfIldZtdvORhhzVz4SaXpNaq1Zvvp5e35AhxZCtnk8glzPgx1HAFVygX+C6F5+vp
	DpFCRoP4SaxrH4okh1Te91TqtKOA2siXw8Nwx7dv8EsNviTy1jEOKglnAsU8QjYzFxzlL5DTGj7
	Mu00m6+1Wl+s0DlkVMjT7/djHn7ni2UeIkQ33gr9gHUPRABIFjM+XCbtHj1cwCv4FMviiM0vK+N
	WA4MQ1VHPceSEi99iABa976+kFk0SUqM/9qJYhKIqs3QLr0BARVK9qyBiqKoR5gC8gnPAL/iD/R
	l9tad9Bq917yVGnMrwvinMA86qdyWgM+yRykKZ1q5qd4gPAIFE3qwol7HujjAHO1TdHO7eAjz6Y
	+m+Az+mR2VwB85hyIRoLCC5mDF6e9IdNS23Jz/SrMkgUK9wA2C4ku7
X-Received: by 2002:a05:6820:570b:20b0:71a:d8a5:4d1b with SMTP id 006d021491bc7-71b3947aef8mr4275597eaf.36.1795295113480;
        Sat, 21 Nov 2026 13:05:13 -0800 (PST)
Received: from [127.0.1.1] (174-29-1-49.hlrn.qwest.net. [174.29.1.49])
        by smtp.gmail.com with ESMTPSA id 006d021491bc7-71b380e4a6dsm4635728eaf.13.2026.11.21.13.05.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 21 Nov 2026 13:05:12 -0800 (PST)
From: James Hilliard <james.hilliard1@gmail.com>
Date: Sat, 21 Nov 2026 14:03:22 -0700
Subject: [PATCH v12 7/7] dmaengine: dw: report residue for queued transfers
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
Message-Id: <20261121-submit-dw-dma-synchronize-v1-v12-7-f51eb635209d@gmail.com>
References: <20261121-submit-dw-dma-synchronize-v1-v12-0-f51eb635209d@gmail.com>
In-Reply-To: <20261121-submit-dw-dma-synchronize-v1-v12-0-f51eb635209d@gmail.com>
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
X-Mailer: b4 0.17-dev

A submitted transfer may still be queued behind the active transaction.
dwc_find_desc() only checks the active descriptor, so a status query
reports zero residue for a queued cookie even though none of its data has
been transferred.

Search the issued and submitted queues as well. vchan_find_desc() covers
issued descriptors; submitted descriptors need a separate lookup. The
status getter already reports total_len for a descriptor that is not the
active transaction, giving queued transfers their full remaining length.

Fixes: b68fd0976286 ("dmaengine: dw: move residue to a descriptor")
Cc: stable@vger.kernel.org
Signed-off-by: James Hilliard <james.hilliard1@gmail.com>
---
 drivers/dma/dw/core.c | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/drivers/dma/dw/core.c b/drivers/dma/dw/core.c
index 302ff591cde0..88c14575a604 100644
--- a/drivers/dma/dw/core.c
+++ b/drivers/dma/dw/core.c
@@ -944,9 +944,19 @@ static void dwc_synchronize(struct dma_chan *chan)
 
 static struct dw_desc *dwc_find_desc(struct dw_dma_chan *dwc, dma_cookie_t c)
 {
+	struct virt_dma_desc *vd;
+
 	if (dwc->desc && dwc->desc->vd.tx.cookie == c)
 		return dwc->desc;
 
+	vd = vchan_find_desc(&dwc->vc, c);
+	if (vd)
+		return vd_to_dw_desc(vd);
+
+	list_for_each_entry(vd, &dwc->vc.desc_submitted, node)
+		if (vd->tx.cookie == c)
+			return vd_to_dw_desc(vd);
+
 	return NULL;
 }
 

-- 
2.53.0

