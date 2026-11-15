Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.161.46
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794727191;
	b=n77tFq4ag/TBOJY9TvZTWqX0c5zu7BC03o2d8YSAMEa/XsCCeOW3eLlwjkABAHHJzLRQ
	 LeJVTHWTMa+rcQrJBIAsIO2hpZRS556u/39aZQjUKR8TEOXhCk9/Q1ZuyN9qGSWqGzBcp
	 bXPOPjoMRYEx6NMwvjOzTj7UFTOvMmm5SwjLg63XFUqTBoNovvwK1rF14m6dWPrtt9Zof
	 bLBuhapTXIx/pC4K8OtYYPmK/mLlFn3EYrmV8Q8qw9DFoFWZkz6zcc3u+lzVBCDFH+Lu9
	 iXitTQNdhQWfiBrUw/10ugTwsevPGeaVs9ENZFQ89pVpo93j3AZjXW9bXex066qhMJA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794727191;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:Date:Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:
	 Message-Id:References:In-Reply-To:To:Cc:X-Mailer;
	bh=tEAC3AEP0gmVOZIrEp2K5naXDusA8lAF2Ew6yHoW5j0=;
	b=f2u8EpkFKz0u3p/zkSzmpdK0pg6LHKsvWGjr9QTG6HaFSJJPsUc5ZUwR2Pu7YREP+e9L
	 GVYmW3HwLD2nvU5ode1eV19qHRazekbowdmiWsk+Lc3HSyXvprKRRQnrxVFw9ksOWlRw/
	 0sAHb8lIAr3l+x4qZPk7YJAlKWTREoaykluJNixlmvsJ1L3PaLGDFeUZ/r5/8+1UIp7L9
	 6lDjGN+GpC62apQykvyhXycbAfJ/pQNWqmOru873bKQZbcGXvlJf1nP0gb76E5ld6CBqg
	 V88RwSTjGV1QBpwoNyMjLdNvAXJFEdYXTt1V9qsN713vGweqnXgTgT37C7YqrazGbyQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=ErPm0KHX;
	arc=none smtp.remote-ip=209.85.161.46
Received: from mail-oo1-f46.google.com (mail-oo1-f46.google.com [209.85.161.46])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C7B1060A262A
	for <stable@vger.kernel.org>; Sun, 15 Nov 2026 07:19:50 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org C7B1060A262A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=ErPm0KHX
Received: by mail-oo1-f46.google.com with SMTP id 006d021491bc7-70b875f6f13so2871444eaf.0
        for <stable@vger.kernel.org>; Sat, 14 Nov 2026 23:19:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794727190; x=1795331990; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=tEAC3AEP0gmVOZIrEp2K5naXDusA8lAF2Ew6yHoW5j0=;
        b=ErPm0KHXB4Mv060O7w91PxAQZnj4lSzJqaCrlPecymxQxZufCsxz6cv+hYWfhbtihU
         pdJqmR5A/OiXJ/6cVyyp6OOa9ckp4ZrXzfGv9ttSWI2Wer420pQOhk64kRy/kl4I7ncS
         EaF2NZJtozE1gSVbKoePM1btESFdANQr2KB+8S7+0x8y4BrZfEg6Sm24malWI/UyEst0
         +JWgrXFsw4Ondp1Bnr4KDxzb220OjFurLOOTr/hXUGDG18a0K+cMOCX5CGs6ZUQUGC7s
         ++h1hAvHkHb1fHmX1ASQBODhwj3+xSwSTDOC+huEIrHtHpTM8it1Ig3jrDHMh6j2iViZ
         L1Bg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794727190; x=1795331990;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=tEAC3AEP0gmVOZIrEp2K5naXDusA8lAF2Ew6yHoW5j0=;
        b=IeAx19K+fkV3Ee+TXN5s30RHF/K5U3OHVR2T6d3zI2qMcKzbGgUxErM3iFrVjC/n4K
         R8fkZ0a72VAEzWks3L5hnhFawkVLNClAKD1RM3Q3IIN3D04rC1AMejW2+poPFJ5mQHvc
         U/GXujADXdqK8hluieFT9rwDdRiM6bUjZXub2LK21sCNuRBqy0hs84cOZsZHF5ydjDlu
         WFKCpaO4vstzisWooN2yv28zx5Km/UjH5pgiEIwkYVHCoZTw76Biu80CAa+W7YxidMoT
         A/f3JniXO2r6hdzZk1XmjxSqhNVlSRIZ5tsD/8IDiwfOkc3Bpr5SWTmbSQG+ObAcbvFX
         K0qQ==
X-Forwarded-Encrypted: i=1; AL+hErER8IFv/JhEifH+zfHGmDGF0bihz8Z8+Q/iatJWU528T7FrW8osMb1lEkPPl3XNuN/mCjezgAU=@vger.kernel.org
X-Gm-Message-State: APuU4Z/zwCX2GRJCPEhe/ouHco7mcTUxtut754SwvJJWUxGWTXzKyNNK
	uk9MipDxs4r7jQaHrVIf3IDK6SuiMW7MhZH1rnRIToO5xrwgMxPShvVF
X-Gm-Gg: AYBFou30NcyBuA+HyNqJQtRxw3j7+X4QEip2qXxLia3gAMljZq3NjJeT0ITlY33lmjr
	nqWEjjcPFaZlU0SdF3ZlZLXDzGbiposf0YIRYJrinImMWHuMbS07h5ZlrpnbCVr31MAz8EdOvnp
	XufHOrVDSj93o6PUjJSnWGZ2ootA/UJKbyvMYOLkxYpqMR8ug01hW9O9EndID7lcB5NHAcyUViB
	xX1VW/2HEa84D22kjchQ2Q3mUopVGsalUwzV0B53GKDDy0sds0m+MN3JmHYw+qBQhFBffvY/23J
	heUhBwOSiU0j0H5rfrTQBZvl+4L/EO55aNhMyg+6bMQdZ7TT5NBdgUC3sKzRVJHdOX+Ybl9ovlv
	mU1XQ3ooAHMKJolsmqUn1sOCO61YOvuYCrQS/i8otiCAJT6IxS8ZtqGh97zKZfUxkCb6mSvPODg
	ZU1UVxK8rHT0BOayOPKGS1FiYIX+ET5wTXkEiQvEOXwGnTR/qrVryrgoZTHF0DSB9pUc0CYboq4
	nzMY8s6zVknKRVPAKiq79r7vKzZdC0YVCIuPX4CmlKZNnvlA4mCRNJHroRhZcXqVlJ/MgO2Mu8v
	s3sYv3RobNJtOUAOVqRrvHGbSCJbYZqekNKlVyeoa8mQplXRxamUh7jFE4IxC+v5d1wpZKPfkXZ
	jGbJz7xTm0Hzs/APNF6n2pjLbTianVFqYv+kuWyG2MDWtAtu6BTf8cjWiHYZyPGWBvajtkrr76z
	6J0pKIwDwdo2lf3bRMWk+IAT0Wn90Pdg/EA87R2ydB0ycqXd+9QBU=
X-Received: by 2002:a05:6820:1385:b0:719:204c:fae2 with SMTP id 006d021491bc7-71ab4fb81e1mr4716551eaf.28.1794727189811;
        Sat, 14 Nov 2026 23:19:49 -0800 (PST)
Received: from [127.0.1.1] (174-29-1-49.hlrn.qwest.net. [174.29.1.49])
        by smtp.gmail.com with ESMTPSA id 006d021491bc7-71ae860ebd7sm1145321eaf.8.2026.11.14.23.19.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 14 Nov 2026 23:19:49 -0800 (PST)
From: James Hilliard <james.hilliard1@gmail.com>
Date: Sun, 15 Nov 2026 00:19:40 -0700
Subject: [PATCH v7 07/10] dmaengine: dw: report residue for queued
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
Message-Id: <20261115-submit-dw-dma-synchronize-v1-v7-7-8d58f3d49e4d@gmail.com>
References: <20261115-submit-dw-dma-synchronize-v1-v7-0-8d58f3d49e4d@gmail.com>
In-Reply-To: <20261115-submit-dw-dma-synchronize-v1-v7-0-8d58f3d49e4d@gmail.com>
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
 James Hilliard <james.hilliard1@gmail.com>, Frank Li <Frank.Li@nxp.com>, 
 stable@vger.kernel.org
X-Mailer: b4 0.15.2

A submitted transfer may still be queued behind the active transaction.
dwc_find_desc() only searches the active list, so a status query reports
zero residue for the queued cookie even though none of its data has been
transferred.

Search the queue as well. The status getter already reports total_len for
a descriptor that is not the active transaction, giving queued transfers
their full remaining length.

Reviewed-by: Frank Li <Frank.Li@nxp.com>
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

