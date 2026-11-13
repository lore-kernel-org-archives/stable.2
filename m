Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.171
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794537686;
	b=SKHeYcCnysDmsbMLRsWD8d7X4Pt1lGH4/SZXHIOYZj1g6fdFwoy+LB+kx4mZbtsI5gir
	 /Mjo7HAebckhcfSw/iUJbZa6fYUHVOFEWXI7icxKTVzTFkVYlrPETS5ipWa5W92oDHHaT
	 zlQFiwhmLdBExQypxmEN4CKPWq98sMTSd17TAmnAiYLiUXtcxVpfxT3dAFrYXjM24p1Ml
	 u1xb+6woonmmDeunsfu5jUSfwI3vZllNbjk5eUPllpVPZs+c5aTEQcWN9S9I7o9QTGOuZ
	 09MkHPkb8/Sh3HlTQl4v3vhsX942Rs0h0b27ytbuOZsYxMW6NcPrFhSD6jkzBN0yQbg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794537686;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding;
	bh=1umUU6E6aYyeT1k/Gpsp+FhAOaMvQ+4/dxDpS4M7kSE=;
	b=pGyvVcEK/pKX4PDA7WmTuSvqu0aQVIYqaihjzxvevUmAfvAKKAljY8Lo92HiFxpvfHtR
	 eFtNaKKxn0SA/Hsm3InfhpmsmLt84UTqZsPw6qqleysz7opIlYGaUjDaRA1YqEveCw2tT
	 ftlncypjcMV0rnmYVAY1Jt/mQ0brTPpG5sqV5XuqTGlgWpamcCoe2iGxiy3+X/f1xGT79
	 7B3HLeiYeVLOsmdCK7DJ9AJxv04ibsR5KLUjHEU1iRtiI+n4YxZjWOlN731DtKxLhhO3b
	 YqYcS5mu1RyJ9x9vdTecp4dGwtWF3XgVX/SJMRGa2vdRFaV6y1s+Y822l5+ZY8yibqQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=dVbRKYny;
	arc=none smtp.remote-ip=74.125.82.171
Received: from mail-dy1-f171.google.com (mail-dy1-f171.google.com [74.125.82.171])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5DCFE606A31C
	for <stable@vger.kernel.org>; Fri, 13 Nov 2026 02:41:26 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 5DCFE606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=dVbRKYny
Received: by mail-dy1-f171.google.com with SMTP id 5a478bee46e88-37605faade6so68558eec.3
        for <stable@vger.kernel.org>; Thu, 12 Nov 2026 18:41:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794537685; x=1795142485; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=1umUU6E6aYyeT1k/Gpsp+FhAOaMvQ+4/dxDpS4M7kSE=;
        b=dVbRKYnyths2fZT4KghoNuIZOk83gcvy+dZ4HKzIuJHMXqGsWPzgfd5VY6D57x8XSQ
         8Ya0/TtG2vOCmHl7xfWCnhisaRtw89LNcAiqwEPKf822/54psw7oKXoNlEo9ve1Wxf2/
         +1i9XFp00WZYzvsfmAFgurlxG0oLGfKrgyWtULtMcpYUYLTLB14LEQLRatF8p+9dk27R
         d+jjbx46twJuwdv3P1z9MMJtc8ULK4fRwXuA1hmJq+EAZjTt46M1i8mv5umyveZvfJTD
         157xu8biLDMiDh91jfYqjaFrSZ/W+fucYNmp60SSbzkXdWKhQy9M1tRELHhUvNcUKR1l
         Jn5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794537685; x=1795142485;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=1umUU6E6aYyeT1k/Gpsp+FhAOaMvQ+4/dxDpS4M7kSE=;
        b=fUAn1recgHLp+WIoV9BThFFoxeZXxQ8J0rqtqRvEXMXEJWv06my9gCm9LolMpJt0B0
         yJQ5TD7gnceeqqL6y+ARBprSd8RvgMpRT/n1HBe5m+SPSgVYK28ID26cHt0KRiBMekUn
         Yc21gaPs1alZW3wCnwI75JMNjlTYH290/nt26Q5iiwXGX9akgccGgnLNq+/a8kLI9/Rg
         AzzFXo0a+RYf3BwgP3FoIExvjgp+CDjci6+t+PQw09pRuy/VFKm+OLqkPZhsAn/y1h8g
         iwR7mP0bcbyS7dZ2LQfFtZEpt25cwz+la0FBqR1VzMYFmPF2HRO/6fN5kgtVGYUkslJW
         4cAA==
X-Forwarded-Encrypted: i=1; AL+hErF66bNSLrUlwZUiPHX48yJatYWycdl7WZBoUS5ffKT9dcACdQpfnuYWz7popudd41z50Ns9Ojo=@vger.kernel.org
X-Gm-Message-State: APuU4Z/+Y4fjfmSk3/4Hs1dliC0RLUx1UivwUb8R9qsqQhBJQGJ9QI52
	9sTgJDOUyvjRHTRAuQx9/xmB4FFDKR3hahO5l5xXlgKEt0yvOOZ8WD6z
X-Gm-Gg: AYBFou2PBVa80u96ZtC0s0WJKkCCr4YHHhxrOs9W6IzeWApAaEFARLIOEaPDCHMPBZ3
	3FQX+nN0QVgcQlqCdHeCvsMpI/3klFw2ohh0/HnAP6kHqvz41PdyGowqBvIv/ZsUG6sCGggkt6q
	Y/HIwnxrGH9o59z+dGcp/s75XQ8iy19aUHl9I5mPRTKdH3UJVcHxZ1PfvlWtIJ9xPySuHgI3V5L
	nrKQiiUMWS/Ds5SaicZwUF+1K5j48NlTvk6z/En5G4HlIrURZRX4AWbkMASlpsem3v8wFGLkp43
	OZv59qV4JcBhF78ymOXwQ6Kbyu+Y7Y5HHCQSQ+jG7lerROIzLtt66gAplvDy4KPDcF4OU2Jq++U
	qTj/aOB3zX5JeNBIqBJ3ArqJBLJ42wOj8AGKSiyrvyNl3cBZl2QWpCvNykfkbIC4hySAgZNmOxE
	a/qCp3Ispaael7/tnoFJC0OyVuE/YGlSEQYAaimzgYQt0k15fDtnzDZd9WUVvF+lO2eJ2e0JMbi
	IuoeU5inidh5iWKd1832wCiY+ANSzC1JKAOp3fAvbJWlBZ+RRH1WknD2gyxWYHh/wTqf/gDrLSb
	g6Ql9JjBtDqO+DSgiHL8Av2KpVJXWkU7aLhAytYCfquJjnhi/trcRB1WO+ZQuRYOBaS+Dre3Rx7
	gtZQKrHAv3MyMFqaK9A/bT6tbMnn6YatFXrmox60yc5+/c121vwv97GtiZns67GEtiAc+ZeQZIS
	Zhk47SOWHglPM98xuF0dAq7AlJajFDpcY=
X-Received: by 2002:a05:693c:8204:b0:372:c0ee:875b with SMTP id 5a478bee46e88-3796057b529mr1566710eec.0.1794537685511;
        Thu, 12 Nov 2026 18:41:25 -0800 (PST)
Received: from esteban.tail1178e6.ts.net ([240b:c020:623:52c6::44d])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-379565d07b3sm2334704eec.22.2026.11.12.18.41.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 12 Nov 2026 18:41:25 -0800 (PST)
From: Antoine Pichot <antoine.pichot@gmail.com>
To: linux-media@vger.kernel.org
Cc: sakari.ailus@linux.intel.com,
	mchehab@kernel.org,
	hansg@kernel.org,
	andriy.shevchenko@linux.intel.com,
	dan.scally@ideasonboard.com,
	djrscally@gmail.com,
	dmanresa@gmail.com,
	dave.stevenson@raspberrypi.com,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: [PATCH v3 2/9] media: i2c: ov7251: Fix link frequency index
Date: Fri, 13 Nov 2026 11:40:52 +0900
Message-ID: <20261113024059.1087031-3-antoine.pichot@gmail.com>
X-Mailer: git-send-email 2.56.0
In-Reply-To: <20261113024059.1087031-1-antoine.pichot@gmail.com>
References: <20261113024059.1087031-1-antoine.pichot@gmail.com>
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

ov7251_check_hwcfg() stores i, the index into the firmware's
link_frequencies array, in link_freq_idx, which the driver then uses to
index its own link_freq[], pixel_rates[] and pll1[] tables. The matching
driver entry is j. Store j.

Observed on a Surface Book 2, where ipu-bridge lists one link frequency,
319.2 MHz, which is link_freq[1]: V4L2_CID_LINK_FREQ reads 240000000,
and the pixel rate and PLL registers are off the same way.

The 319.2 MHz table this selects ran its PLL outside the datasheet
range until the previous patch, so do not apply this fix without it.

Fixes: cc125aaa5a78 ("media: i2c: Provide ov7251_check_hwcfg()")
Cc: stable@vger.kernel.org
Signed-off-by: Antoine Pichot <antoine.pichot@gmail.com>
Reviewed-by: Daniel Scally <dan.scally@ideasonboard.com>
---
 drivers/media/i2c/ov7251.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/media/i2c/ov7251.c b/drivers/media/i2c/ov7251.c
index f429de5f1f7c..1f30a01c85b3 100644
--- a/drivers/media/i2c/ov7251.c
+++ b/drivers/media/i2c/ov7251.c
@@ -1523,7 +1523,7 @@ static int ov7251_check_hwcfg(struct ov7251 *ov7251)
 		goto out_free_bus_cfg;
 	}
 
-	ov7251->link_freq_idx = i;
+	ov7251->link_freq_idx = j;
 
 out_free_bus_cfg:
 	v4l2_fwnode_endpoint_free(&bus_cfg);
-- 
2.56.0

