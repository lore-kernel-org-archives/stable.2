Received: from mail-vs2-f12.google.com (mail-vs2-f12.google.com [74.125.227.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C5CC9421229
	for <stable@vger.kernel.org>; Tue, 15 Sep 2026 04:11:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.227.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789445485; cv=none; b=cZy0+77vAkU9pVLQfCBKZioJIf7M6/lyPGfjqjJBNnAS9A0St7Gnh1/LMcZ3DX9Y0d9MvaHKFIWK9PO7pqBmGTVEs5AxKgXvt1Ggucf1NX0wVo1Y3OxFVOPDaYppbIPFVWmGdoCGeiXLHlw4M55XNHfdhaSwpq2cg65xcnQXJxw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789445485; c=relaxed/simple;
	bh=rpqsVg/ubcBlSt4tnnMt3u2mC1fHYBLgP79xcXW2LK8=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=tGjA/geSb1Qd5zlgX69no1ERbkkKxdKp4uaaVwNZGXop0yTHHLLsbibAJy0FEeJNvm5OpoOg1TplkKgw5ATNvZdsv5fR3qQjPLVqGIFmHhdbgIgY7XEtmg4adLkWAuXYiGt8nloQBHq+DHPva9VS2MWxJGsyKInNkwC91LWpABc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=AagDPInT; arc=none smtp.client-ip=74.125.227.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="AagDPInT"
Received: by mail-vs2-f12.google.com with SMTP id 71dfb90a1353d-5c67e2ff27eso2235581e0c.0
        for <stable@vger.kernel.org>; Mon, 14 Sep 2026 21:11:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1789445481; x=1790050281; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=0RtRX0RhngTPzlcHJEE2Zn3GZesHhDf37sxI3w5bu7M=;
        b=AagDPInT1WTHeXz5Gh+5jBdlpX5Iu1Vu8bX9dgIMc/5hJS39oJXJ8e6ntkcNGnSDDN
         8WCjThMzbWmuiT5OI8QKjF9P+0EZh7OxXyS5z6+B6GHuMi/AhpDAE56ZIPocfBkbTdvk
         SX6Hum/Ws2+mwlNC/1a8StrbQB9pXlGO73Pk7o5UPbRSrp9xUh2IRSG4uE6c3PuDi1C5
         TxRE23U1PpTqExlwR++wyZZOj/5kcqDzsSy2cF/7OfJUeZQoszLrKT/7sn2b9BFj8Nx7
         To5m7CGxFSjFp4sqpZdDBF+0PCksGr2qylVh7bL40uP0vDSJeW5FN1RNhTqtGp/+vbqZ
         S3fA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789445481; x=1790050281;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=0RtRX0RhngTPzlcHJEE2Zn3GZesHhDf37sxI3w5bu7M=;
        b=iAIjtvUJqChi3Wd0h09Qyy9GoC7rCaIOeDhbQOSvG3KwXDiMzX50c3uqulsmNyl7YY
         MesBYHVwiyIs/cnx5EdrfJIkfHleLqtiAcLpv1zYDliZzaAKfphbqCGYBli/J66K0qMQ
         6EtGzCgSe+80VrD5rvEzJUr8wGY2U09cvVoydsYXlEI/Y1Mvq6yDzKF0boau3P9Nwq/V
         FWfcbw0lfEvVY5brKHIisH2KsbZYsp6SicewhkSPWN4np3nikmY1KqdbOg5G8btK2LZv
         Lq45UkU/VtuW4F66sCfl+W+F6kDZ9FOcbe7Fp4CqT6dIzEsm/huVmiTLjpjOQTB+2+RP
         NBjQ==
X-Forwarded-Encrypted: i=1; AKwUvBy5zKBsvUCnh+OkjppiHXKi9zcijb+cDxEYkGaQf8BeEUVRvLncoFKxVTf8/uDcOl/IMzsEEi4=@vger.kernel.org
X-Gm-Message-State: AFuF++mXDuwXc7fmxt4fqzAzvCj6OyBLFmdk0RzeNtXoMEWPdyVEb8ik
	hd1xmaYnb9QjC4SR0WRLjuZKzpXKXSw2GXac+YdFraYyXPbDpSQUMP9h
X-Gm-Gg: AYBFou17PXnFfl8NeayGQb4GHXpzL84Pove50GvTQXZk2ghBx+OV4y+pXKy6tqh5ekQ
	NFv8A8vvQ2O6nvr4ExmZ4PthoEvBnJ8ina/qZQQod2TxHs8HIXyTon4OjQ225vZl4YxYMxvk8aA
	xR/EifVy5FIvG7Y+i24D7VU7LfqW1NkwIMTAh5TNifxIGaFD2qXbL8gCqkSTrmjefId6pmTgHHy
	dlBSclFY/TsdFRx037NIPOuOTDtAQVMgrUMflaPbLLibOrOmtlUz6TDRzNdYHexWxYSWjDIeRNn
	+Gmmzb64GlXL8Du/Rn3KZ+Pvt+d5GbfNJysOuNGKmCLvSQLTD2PdlcZbSufrNrGouiztJGKhYXk
	VlIkExcutrlsQAco3BnHxatByhJ6rTq1fpAVAABxGm4CeJl9Fcz8RZV3b6rn01/W3VK6YUtxIqE
	mLhTF6nAVb2kbhyzbarrJj9/NfdVP3sq6n5BIZ3QGih00p0n3BZABO2/shxmN5yLru
X-Received: by 2002:a05:6122:6992:b0:5c8:2c83:9cb with SMTP id 71dfb90a1353d-5c981abc29cmr7943230e0c.2.1789445481622;
        Mon, 14 Sep 2026 21:11:21 -0700 (PDT)
Received: from beelink.. ([187.13.206.89])
        by smtp.gmail.com with ESMTPSA id 71dfb90a1353d-5c84711aee4sm14282826e0c.13.2026.09.14.21.11.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 14 Sep 2026 21:11:21 -0700 (PDT)
From: Aldo Ariel Panzardo <qwe.aldo@gmail.com>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: linux-usb@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org,
	Aldo Ariel Panzardo <qwe.aldo@gmail.com>
Subject: [PATCH] usb: gadget: ncm: validate the NDP chain before parsing
Date: Tue, 15 Sep 2026 01:11:11 -0300
Message-ID: <20260915041111.2429236-1-qwe.aldo@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The next-NDP pointers form a chain supplied by the USB host.  A cyclic
chain therefore makes the receive path loop indefinitely and repeatedly
allocate datagram skbs.

Prewalk the chain using only bounded header reads before parsing any
NDP.  NDP offsets must be four-byte aligned, so following more than
block_len / 4 valid offsets proves that the chain contains a cycle.
This terminates cyclic chains without imposing an arbitrary limit on
valid NTBs or allocating skbs before the chain is known to terminate.

Fixes: 370af734dfaf ("usb: gadget: NCM: RX function support multiple NDPs")
Cc: stable@vger.kernel.org
Signed-off-by: Aldo Ariel Panzardo <qwe.aldo@gmail.com>
---
 drivers/usb/gadget/function/f_ncm.c | 25 +++++++++++++++++++++++++
 1 file changed, 25 insertions(+)

diff --git a/drivers/usb/gadget/function/f_ncm.c b/drivers/usb/gadget/function/f_ncm.c
index 64eabda2f5..085aea142f 100644
--- a/drivers/usb/gadget/function/f_ncm.c
+++ b/drivers/usb/gadget/function/f_ncm.c
@@ -1175,6 +1175,7 @@ static int ncm_unwrap_ntb(struct gether *port,
 	unsigned	dg_len, dg_len2;
 	unsigned	ndp_len;
 	unsigned	block_len;
+	unsigned int	ndp_count, next_ndp_index;
 	struct sk_buff	*skb2;
 	int		ret = -EINVAL;
 	unsigned	ntb_max = le32_to_cpu(ntb_parameters.dwNtbOutMaxSize);
@@ -1224,6 +1225,30 @@ static int ncm_unwrap_ntb(struct gether *port,
 	}
 
 	ndp_index = get_ncm(&tmp, opts->ndp_index);
+	next_ndp_index = ndp_index;
+	ndp_count = 0;
+
+	/* Validate the NDP chain before allocating datagram skbs. */
+	while (next_ndp_index) {
+		if (next_ndp_index % 4 ||
+		    next_ndp_index < opts->nth_size ||
+		    next_ndp_index > block_len - opts->ndp_size) {
+			INFO(port->func.config->cdev, "Bad index: %#X\n",
+			     next_ndp_index);
+			goto err;
+		}
+
+		/* More aligned offsets than fit in the NTB imply a cycle. */
+		if (++ndp_count > block_len / 4) {
+			INFO(port->func.config->cdev, "NDP chain cycle\n");
+			goto err;
+		}
+
+		tmp = (__le16 *)(ntb_ptr + next_ndp_index);
+		tmp += 3; /* skip the signature and length */
+		tmp += opts->reserved1;
+		next_ndp_index = get_ncm(&tmp, opts->next_ndp_index);
+	}
 
 	/* Run through all the NDP's in the NTB */
 	do {
-- 
2.43.0

