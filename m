Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.128.49
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794556926;
	b=JKpczOxl43QzJMrmvn2+MXButaVDLC5975NGnSwvu86qXmOHJB3cjwjgZUJbtb+oAuvD
	 aKhwyonQiQkYyNKUxQwIXNsaLF5C/2bsraOENCJIWMUY0o72k7U39OkuzPa85J+82N9H+
	 oAAOEzv8/9wrIlztZIBjXx53bpwu4hHSYgaGbjYL15B97zNB3qpN7LD1fpUTsGdzEICDf
	 6jn1MehFTz2WEgwupWvFnAlphjhor74AbulThmN3DMuVhQrWQ309X65GJVRLyFU8H20mI
	 Qa/p8oaaFFzNN0/sQnL8giPTGfPTc9/CsM9acpAJlCE5VBkMpcJMuZCB2m0HGP+RVLQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794556926;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding;
	bh=QJxalrHssAZhNnjpSDoFedeDiy/biVpvzIuN3reWEpI=;
	b=nezmytnot+T8PTYpQVT2UffHrrJT4xkxma9Nh4XIUYoya911jOAvBAMbdCwbn/8OB0nW
	 8J+adfbbr6q+O+DSyMAKMtZeeN4UjXnNaq/UH4VqlL9Ipg/1kSwjw1O4sZtI/BtdVy6U4
	 GCSuvX1uT/CaZy3ObhLPErclHNWwiolXZwCHd5vETFwbxuhYkECrk/+oE51Cw8nmNaFs0
	 RiybqtAaGXecleBzNnAKrqiacijcarpVh1unX7BWGKBlq/d7ltfvUUH959+WDhB8hUkJx
	 PZoTIFn9DEZPbunTCkD8dEJmGnivQ06DKdPJtv84ZJAfJORpjxTzkzgYEbtd3OKRgCw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=zTIYH4qx;
	arc=none smtp.remote-ip=209.85.128.49
Received: from mail-wm1-f49.google.com (mail-wm1-f49.google.com [209.85.128.49])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 87712606A332
	for <stable@vger.kernel.org>; Fri, 13 Nov 2026 08:02:06 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 87712606A332
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=zTIYH4qx
Received: by mail-wm1-f49.google.com with SMTP id 5b1f17b1804b1-4a35a60499eso3814405e9.0
        for <stable@vger.kernel.org>; Fri, 13 Nov 2026 00:02:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794556925; x=1795161725; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=QJxalrHssAZhNnjpSDoFedeDiy/biVpvzIuN3reWEpI=;
        b=zTIYH4qxkd/UVxtwx/nA4llgh7bESZeGQaTm2prdn7irBT+NII+HvK+AbhWvy4rdyy
         bYKhIfRmJ9GflhYQE4Nmct3m+qHljveeJJbUuliL3S8spo8t1HrXd2rQRIETLr2SDHu5
         rlCHeYrkuksr7oUerEBI2GJebaIgDOaZUv7fYxsplA+DCFzWW7kM7wNsKY59ehJuaO9y
         EwOcgpCz+aeujkXZGcwcKp3jPDVtnAEwCbkinfXL+hAYv6au+gBt75XxGINglZuKzWnY
         RhucEJ7oA+h58Nlk5miFoKMfz8TFoOQ4Mn4cuxAqU8clBxCjhc65T1WK6xbgzu72gsFK
         Wd4A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794556925; x=1795161725;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=QJxalrHssAZhNnjpSDoFedeDiy/biVpvzIuN3reWEpI=;
        b=M5/RLSaX7vmX37lITk6D8V/R3fuK5TEaJVahHTaQ/7IM1v8APLDBGlgl45974ffQWD
         RjEUmWU1yGysJvTajiQCCQEpU1zaZXPKsJxzW73YxbXPJeu2pVUIWxzaKZRImO4eAB9r
         bWnjKon4j3zjJvZH4uBxfqzMurZHNbbvpYVF830iQsQowKZJ+isj9JmSk9X6FviQqEG8
         YPcRtugVHqtMp/UvuFr9nOb1VNyC13VfsFwZvEL9Oz/P68FwBtuq4yYu/eKK+kKN01mz
         4R0gfjXguWWTFek4P15/HzghsPqlvyI5z3/iSCnFvitnOCdU49KybHCNNdMuDEtj0Jpw
         HvFQ==
X-Forwarded-Encrypted: i=1; AL+hErECr4CONo3JwALLg89yaxrC47TXCoA0BgrZyov3oQjrv5d+yeKAmrDIP8eUV5vAYshhROo/jL4=@vger.kernel.org
X-Gm-Message-State: APuU4Z83UVWy0onaBBBf34zgjFF3wBxSBZau5kGjtVWG2Xefs/zfCEHQ
	4SsmZNqyVSiSmUXu8JGOz2a9IQ9FOomsaPoo7pBvbiTX5uhcs5CACDZH
X-Gm-Gg: AYBFou2db7b9ZwBBV/U12PZIrTKTBhgJd+P6Ew15gNxE/onB7owsFnz8uWvM2slSn6n
	4hcRjayERUBADhB/AasRP8E1GnwLwsZP1p41hvIRSjn1wQ5G5LwdlnVKIOi/RTRgxxFJnHxQf0g
	UCftByraL6X7snIC70/ulBXFcL3knBLx9lS4Yuv1UHR8nETbpBtDgnDF1IXlyTtILHGgW3mj98e
	Cs5b2SjsSyHlT7V3dErBS8RFTWk/8Bw9WXKMsSYlDCornDOY91t1aa6BmKfhuDe+t8A4VLzoAmL
	heHzlgn1nCZVjK+Acv2JKUTea+OCsfT0iG8aPYGK+79KVOevk114TyQTnojFrnwO6qkOTa2sbUh
	1Vn1AtiIdlW8Vf3ii22HAwktnvLOwHftHPOna9yTXzNukykyO6MqPeKg+jh5AVOMd9pxE0cuDKF
	WLnl061sTB883Mg4x3M9j3Gs9n8gs3iXJFncgiQaLoEWlLZryd3/1rR3fc0Mh71dz7v4sDn72bf
	wOb8pBr2nUWtie6/G0vBZwLIiFQXTIqwbZuO6Qu1P7cjjMQroL/TlT1UHenpIm+8vlgZ7TWIwZD
	8MTApzd6e05qoY+PZvq9xptYlCfmspiDRKn7
X-Received: by 2002:a05:600c:c4a3:b0:4a1:9663:7639 with SMTP id 5b1f17b1804b1-4bb55ab5526mr35140005e9.34.1794556924633;
        Fri, 13 Nov 2026 00:02:04 -0800 (PST)
Received: from deb05.proceq.com ([213.160.61.66])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4bb4e2acf81sm121590835e9.14.2026.11.13.00.02.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 13 Nov 2026 00:02:04 -0800 (PST)
From: Mehmet Fide <mehmet.fide@gmail.com>
To: Andi Shyti <andi.shyti@kernel.org>,
	Oleksij Rempel <o.rempel@pengutronix.de>
Cc: Pengutronix Kernel Team <kernel@pengutronix.de>,
	Frank Li <Frank.Li@nxp.com>,
	Sascha Hauer <s.hauer@pengutronix.de>,
	Fabio Estevam <festevam@gmail.com>,
	Yao Yuan <yao.yuan@freescale.com>,
	Wolfram Sang <wsa@kernel.org>,
	linux-i2c@vger.kernel.org,
	imx@lists.linux.dev,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: Re: [PATCH 0/2] i2c: imx: two fixes for a DMA write that is not acknowledged
Date: Fri, 13 Nov 2026 09:02:03 +0100
Message-ID: <20261113080203.1046422-1-mehmet.fide@gmail.com>
X-Mailer: git-send-email 2.56.0
In-Reply-To: <20261113073250.1037215-1-mehmet.fide@gmail.com>
References: 
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

A correction to the test note in this cover letter.

The v6.12.117 kernel I tested with is not plain stable. It carries a
backport of commit 5f5c2d4579ca ("i2c: imx: prevent rescheduling in non
dma mode"), so its i2c-imx.c has the interrupt state machine of
mainline. "The touched code is the same" is true for that tree only.

For stable: both patches apply to 6.18.y and 7.3.y. On 6.12.y and older
patch 1 applies with fuzz and patch 2 does not apply, as the interrupt
handler is different there. I can send backports for those trees once
the patches are in mainline.
