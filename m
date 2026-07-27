Received: from mail-wr1-f43.google.com (mail-wr1-f43.google.com [209.85.221.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2CEFE3F660E
	for <stable@vger.kernel.org>; Mon, 27 Jul 2026 10:34:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785148500; cv=none; b=IvYnaLiG6eDdJmXfFDQPfpJLFsdUm56JxHrSEiztnZ2tctdRcMj2pxEDXgpSS+cC4uJGQ/P36fnIh9jREXY4lIsSuQOef4f1meXNrXpqD1YopDg5tWYiEGdoesoboPNlpQ28nqK2JZLcjloi5449IpMSa2lEh2A+bHOj8BlXigE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785148500; c=relaxed/simple;
	bh=d+ktqVndZJhCJrT8O2h4M5jsdq4wiPW+WKcCbzjTV00=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=fCkSoky5E5u5yClWjo34CgxoKvwQFxJSweTRQO6tKFjATWJGUe7vO+k3tz+//TbvZ7rrZfUHHmuaTAxujeeVVF0cni5EgvhxxGSCLzG3CXmGNiluOlpde31J/6n85DGHODsb26eetS6591YZytN36Qlt9rbvNtRYZgGo2t8KNa8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ZFy4i75F; arc=none smtp.client-ip=209.85.221.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZFy4i75F"
Received: by mail-wr1-f43.google.com with SMTP id ffacd0b85a97d-4758bd3731bso1843434f8f.0
        for <stable@vger.kernel.org>; Mon, 27 Jul 2026 03:34:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1785148495; x=1785753295; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=+WEq6Gzmt1f2hEZj2wO18jW2AXF+11Es6P4mjwJfz0Q=;
        b=ZFy4i75Fxk8GzZ0pR0P+RE3AqHbcmHIe4syfvgc3RW4Y1zUqRIWcSn4HbgHu3gzmMS
         +vmGyiHfLHcixBEOy/12A85Oro+kp2HU+6LAgKjMovaUzi/LCUktS+6LFgeKuYbP1/L3
         KtbKB7YEJ2xW6or+zd0tGNGLDPKYTB8BjuclVOl218JnP9Kwa+X+FpxngTcNjcPyIhUa
         ZNsWhZcVtneaklAWclkvMM71etFV/RDf4uHVru3XXxqfnKEU84swKdMP7vXCOviO+u8c
         bJHoaWgSHJPxwln4wnIm2Gr6QEZsHozf+imongDvv0K3bZoMQxYckQGPaHSaBmqucJ4g
         fzmw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785148495; x=1785753295;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=+WEq6Gzmt1f2hEZj2wO18jW2AXF+11Es6P4mjwJfz0Q=;
        b=SuQE07YpsZ1M38imUO9quRUdGMrLQlQGVy7waFLhY3EptpAF5YzUbJQDCB7PdiS6gd
         S5K/Cbk7keq+048p1CpWCnBqZR5pIphBCl/Ab7CyntleqdHrulRnH68RWa5y3D/bwevi
         c+9BxCArjWGHKe+4NupqE5utMqri+aPcVyJ+pGrUich04+vCyoiabzcpRq/sV8N9alC5
         qIv+OCfPiwu7+OrKTpIDZPRFAsjCCYNH5018uu7x9TK+RHcDSa9LEuQ93gty/CTjrxyt
         GcSB07QL+QYt/98EEdX2PJyixuRSOm5kWTXsTT/MmkTMxYC0O2B4G+gi9wsrMfDTGeG0
         i8+w==
X-Forwarded-Encrypted: i=1; AHgh+RrKNheXKFOGjW2CjBFSUmJbdmZ6/3dy8xVfj9ClvLCJ4QJKAPam8gGXVPlBezWKoUk+TvMKqJ0=@vger.kernel.org
X-Gm-Message-State: AOJu0YyhO9BiyKZHRaXe22zR8H3ufUdmWNkvM+Wy6TlgQ+L8AW6V8f09
	tacw/BQtMb4d+XHb3hAnWCjZJizxjSrKoX8hhD3hvcP3aBFIQofrSOdmw+ceVKDt
X-Gm-Gg: AR+sD13ZFV6N9YKYJ+Hm9XbtG1iXID3S5p3DtV9WzpLPVnKJr/F9wjh9VKRv99GzTlY
	X7BYhVYA5Nm3JyMYYcrqgm+uc1SLtbC7DIlWOOlZ55y6YZMl8HwhA4b6akCmWTb+RSOr1g0Q5ST
	mC+2BEJLaTJzaM98yjAaECDtkFjdfhqxIZkTjRydvNyWfWJ/5qCbanHa1CMHc3WkUh+cVDuedJX
	XkcTk7sk5y1FpQ24i4ifkFhcDcZlCfIpaC2EHbWdXKkml0AttycMz9cneUmAWAUDUw0xvc+PH8b
	cDzcW/D6HELI7Cw7Ywm7a+LDmZkL0T7WFaBSMqAqtR4IWMMyinoN30OMD7cv7B7AaJyOMff5mUr
	E2OVOH68T7XOx0IWuxgOQiQb+uU074OcRnZj18VliGxPnla94bYnO+fxgfutlbR2hejqcY9BVLP
	WNx2a0LdHdaTOUnJFdqiRuSSB6jHYe4lDJ5cQbKAOkOZQJeF5I+2oM9wGe+h7WmvsThTZt07cWq
	lJ/g8h6tEax84ddRQGqmp4Mrn0=
X-Received: by 2002:a5d:5f88:0:b0:47f:537b:d5d0 with SMTP id ffacd0b85a97d-47f9fec9816mr9416059f8f.28.1785148495056;
        Mon, 27 Jul 2026 03:34:55 -0700 (PDT)
Received: from iku.Home ([2a06:5906:61b:2d00:8281:5343:33a3:cac0])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-47f85bd77a9sm45245173f8f.14.2026.07.27.03.34.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 27 Jul 2026 03:34:54 -0700 (PDT)
From: Prabhakar <prabhakar.csengg@gmail.com>
X-Google-Original-From: Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
To: Krzysztof Kozlowski <krzk@kernel.org>
Cc: linux-kernel@vger.kernel.org,
	linux-renesas-soc@vger.kernel.org,
	Prabhakar <prabhakar.csengg+renesas@gmail.com>,
	Biju Das <biju.das.jz@bp.renesas.com>,
	Fabrizio Castro <fabrizio.castro.jz@renesas.com>,
	Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>,
	stable@vger.kernel.org
Subject: [PATCH v2 1/6] memory: renesas-rpc-if: Mark XSPI_CDD1BUF0 as volatile
Date: Mon, 27 Jul 2026 11:34:44 +0100
Message-ID: <20260727103449.3188105-2-prabhakar.mahadev-lad.rj@bp.renesas.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260727103449.3188105-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
References: <20260727103449.3188105-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>

Add XSPI_CDD1BUF0 to the xSPI regmap volatile register table.

XSPI_CDD1BUF0 is a data buffer register used during manual transfers and,
like XSPI_CDD0BUF0, its contents are transient and should not be cached
by regmap. Mark it as volatile so reads always access the hardware
register.

Fixes: 687cac9559d8 ("memory: renesas-rpc-if: Add RZ/G3E xSPI support")
Cc: stable@vger.kernel.org
Signed-off-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
---
 drivers/memory/renesas-rpc-if.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/memory/renesas-rpc-if.c b/drivers/memory/renesas-rpc-if.c
index 3755956ae906..104c28532c20 100644
--- a/drivers/memory/renesas-rpc-if.c
+++ b/drivers/memory/renesas-rpc-if.c
@@ -34,6 +34,7 @@ static const struct regmap_access_table rpcif_volatile_table = {
 
 static const struct regmap_range xspi_volatile_ranges[] = {
 	regmap_reg_range(XSPI_CDD0BUF0, XSPI_CDD0BUF0),
+	regmap_reg_range(XSPI_CDD1BUF0, XSPI_CDD1BUF0),
 };
 
 static const struct regmap_access_table xspi_volatile_table = {
-- 
2.54.0

