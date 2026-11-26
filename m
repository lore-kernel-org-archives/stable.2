Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.43
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795699919;
	b=jbx1Gvm8LBE2wEktfHEFKE2pu/qmsgwg5JnyUgH8wsbHccmr+HWuIyU+NR8FLubKj3mJ
	 Oq9Iq8k7C8o88bf7EStXXAd4SbUtk9qWlQs5IOp0XC/CLlzuq4jx8Sn9pIXq7pArXrOLz
	 DeR0waVisNHGxFeA0CJ+z8QeVGcb/l7fqXELd2q44gVFSW5+Lgl2KvKkzQVaNH4278zCE
	 M1DpAILZw1RddVexf/ftVa/bIb15KeqNbLHhjxj+lwaoPFD7loOVWA00XCw3rEELPGK6t
	 yTJVmo2qf9duMdrdEo1BCpwgKNRZlwHM453Ms5B7AwlgiRmoZ3iS7vJ96ajyQ0kd+gQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795699919;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:MIME-Version:
	 Content-Transfer-Encoding;
	bh=O61FDlwjHKBDnCTbb8aWwb1F9/n+IACrfnZVxf0Y28A=;
	b=P3A6Xvy0JVEyIBE8FqXutEpCDQ++I20Cv0r3zf2t6UOMxsqtAWlkfznKX1wR2DeDLToq
	 +FLBJUG39tCJ+/Fcg71gTT2PFGfA2UmQe5QxfKcjG5h9g+bPN+a2n8FNyMBmt9X/XkpQt
	 cYSsKajvCvSIVV+alCQ7b5tjtWAV8YnUpt69bt42cQOByMhYkB8BUTUVa9fAgxgm80HH7
	 eSmI25hi2VodCcWEx3sDb6EUcH0lm5c4nBSVnGrWTdBeiYTmz0f5J/kQsROdnGWeb7Y9M
	 SD+plt5VhykErO+2dwvsoNGonz4Anm5UyWAxtnGHiU8FgxJoVTE5bg5jvTvPJp+pdXw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=pdSwlU8B;
	arc=none smtp.remote-ip=74.125.82.43
Received: from mail-dl1-f43.google.com (mail-dl1-f43.google.com [74.125.82.43])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 19600606A68D
	for <stable@vger.kernel.org>; Thu, 26 Nov 2026 13:31:58 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 19600606A68D
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=pdSwlU8B
Received: by mail-dl1-f43.google.com with SMTP id a92af1059eb24-1a2af4c8d00so6656349c88.0
        for <stable@vger.kernel.org>; Thu, 26 Nov 2026 05:31:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795699918; x=1796304718; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=O61FDlwjHKBDnCTbb8aWwb1F9/n+IACrfnZVxf0Y28A=;
        b=pdSwlU8BdoCVHBBNrELrT0pqFgmmPZpC7zzITXacmHK/w/QFes/gumIDPg93npLdjh
         W0f6aU0w7gB2faGLA/43zn9xB/CibYNQvB5Gggca4LYwEOQEnxhUvgiYAa6aor35j+Un
         jJo4fl5fsax6zJXFwezfZoE/uVUMVjehew3PY26JadHcJy8a8UrO5ZJzRvxSYuZu4Z37
         9e0gUUtck8cc1Ax45OZ9H97uq6SJgsQYNM1PJHwzT1wYoJZTapkquURbS/IamMHVawwA
         Or+fX4lQbTr2qLguralc1DFjjh0f+u1jCVeEWzc5NySvxdjC9LGSgZbtLA54/tByKdNZ
         +j7w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795699918; x=1796304718;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=O61FDlwjHKBDnCTbb8aWwb1F9/n+IACrfnZVxf0Y28A=;
        b=oh39uuuaOULBhbOMBVGZI8+DC5E1QiplaafVjSk/mSVdCkv3Wm+ObwZEFVIt5OLUkZ
         D6M7w4kHph2QSVqwtUjgQpwEHD9RzF9LKyeFm7qSA244wQfKMunAgZbhiJEnOxwUk3lg
         cjsjHy961zLzrTqZH4P0nImsSfJhM0Gjw9jDMzjJ21jpyDQnNObQ/4xMpyoEGz58f+uG
         9/3Layo5mtZCEy2rfUDDoGmK9dTQzjKq/7GP09TcEMSEuYuiSCeNDZ+OqKaezA7IQ8wC
         G0Jc/pWb6+PR3fXe6FbisOLt5P0wFqEyV0Fx65B4D3FhpsPJxwGY9W48HHbXF8OEk80+
         sbmA==
X-Forwarded-Encrypted: i=1; AL+hErHy1ob+GYyBUjwbjMg5NqlHHyTLeYhFVMOwhOrwL8bubLL396xAxWk045C5mV18BYMwNHL7fdQ=@vger.kernel.org
X-Gm-Message-State: APuU4Z+pK52cfd4eGdEOz4VRxGWBbL1L1E91Ntjy3nl985mJ0OExKDAe
	eufaCbLCNitRzfWC/4ntwlZE56qEfTj7hF68pmoB9IwLD1HZbavtdS0=
X-Gm-Gg: AZFdTZevTnF3HC9erdNWjRdtKSbbG9zmgCmzQYisA0VkXcoAcj3lMEn6swBmpsx8nRa
	7FfWaSZDIt+jyHILxOHZjwn71l1TAIQgwOIuiut0gcuWywKWDN7SugRYuYPNUkJqcfDwfceeure
	hPfqzgH31qCh8JyF2xvm2P4BMSUvc8N9LBPpPWX0eDXjx/t500W8vTKIsGRaHdzLAuQlb8ipPob
	2kyOHyJI/XqN6vMJQBJBhD2rah0+kHfhymD74SAyNM0a5z/t17820fnyAxixeeJkvnjxCN+in57
	tQJBIKM4bxGKmzNd3tUmC7rbaryttOWrxJAkfhFeWhudmsYchRXSkqpMImkikMAfsViYhwCRVy6
	+HNaOKMbg4S5NK4+8TRjUsA/s8AE6+18/0CAxFC6tGC1PGgEqc3XgFk/ezPd1vglMKaZjF086F0
	mxUtPa4LJIcNxl3XfSpmbv5cirP/gEhXlIwtwWKXOlhDUFAM4S0Gz7IfyvRqFz2SPm8mUkDWFaa
	KTUi7yWfZ+S81dXTLxTZu/j6PBud4N7jmF8OGYH2qK+0ldVXxb5Kz8JXUJqA3Xb/7P7qEeklFHh
	+cJZ8aqRFDEA4Zw8ZeSS18hGHbJYNI7ACUwtqIzFhDwiqNxMVrlNai7pDZ3GOe4qoRk=
X-Received: by 2002:a05:7022:ed02:b0:149:50cb:2175 with SMTP id a92af1059eb24-1b5568fda53mr20186467c88.33.1795699918133;
        Thu, 26 Nov 2026 05:31:58 -0800 (PST)
Received: from localhost.localdomain ([2406:3003:2002:639c:a06e:23f:85ed:4cfe])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-386c7c62a91sm22321547eec.17.2026.11.26.05.31.55
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Thu, 26 Nov 2026 05:31:57 -0800 (PST)
From: Yige Jiang <yigejiang86@gmail.com>
To: Wolfram Sang <wsa+renesas@sang-engineering.com>,
	Andi Shyti <andi.shyti@kernel.org>,
	Geert Uytterhoeven <geert+renesas@glider.be>,
	Magnus Damm <magnus.damm@gmail.com>
Cc: Yige Jiang <yigejiang86@gmail.com>,
	linux-renesas-soc@vger.kernel.org,
	linux-i2c@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: [PATCH] i2c: rcar: release DMA channels when host notify setup fails
Date: Thu, 26 Nov 2026 21:31:54 +0800
Message-ID: <rc-b1-20261110-vc-182-eee62ef398fd@gmail.com>
X-Mailer: git-send-email 2.50.1
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

rcar_i2c_master_xfer() requests the DMA channels lazily, on the first
transfer that finds priv->dma_tx or priv->dma_rx still set to
ERR_PTR(-EPROBE_DEFER). Clients probed while i2c_add_numbered_adapter()
registers the adapter can already issue such transfers, so the channels
may be held by the time rcar_i2c_probe() creates the host notify client.

If i2c_new_slave_host_notify_device() then fails, the out_del_device
path deletes the adapter but does not call rcar_i2c_release_dma(); only
rcar_i2c_remove() does. The channels then stay allocated, together with
their DMA engine references, after probe has failed and priv is freed.

Release the DMA channels right after deleting the adapter, in the same
order as rcar_i2c_remove(). rcar_i2c_release_dma() skips channels that
were never requested.

Fixes: c4651f11d09a ("i2c: rcar: add HostNotify support")
Cc: stable@vger.kernel.org
Signed-off-by: Yige Jiang <yigejiang86@gmail.com>
---
Based on linux-next next-20261109 (630059a5a632).
Compile-tested: arm64, GCC 14.2.0, W=1, CONFIG_I2C_RCAR=m, CONFIG_COMPILE_TEST=y (object only; no new warnings).
No hardware or runtime test was performed.
Needs a pre-Gen3 R-Car I2C node with the "smbus" property and dmas, a client transfer during adapter registration, and a failing i2c_new_slave_host_notify_device() (e.g. a client already at 0x08); no in-tree DT sets "smbus" on an R-Car I2C node.

 drivers/i2c/busses/i2c-rcar.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/i2c/busses/i2c-rcar.c b/drivers/i2c/busses/i2c-rcar.c
index fcb15be59cb5..b5c964c367e7 100644
--- a/drivers/i2c/busses/i2c-rcar.c
+++ b/drivers/i2c/busses/i2c-rcar.c
@@ -1241,6 +1241,7 @@ static int rcar_i2c_probe(struct platform_device *pdev)
 
  out_del_device:
 	i2c_del_adapter(&priv->adap);
+	rcar_i2c_release_dma(priv);
  out_pm_put:
 	if (priv->flags & ID_P_PM_BLOCKED)
 		pm_runtime_put(dev);

base-commit: 630059a5a632377b9b7b487baccde92b7ae1dd47
